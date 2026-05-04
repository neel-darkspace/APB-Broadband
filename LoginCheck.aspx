<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Script.Serialization" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e) {
        // Allow port 8081 to talk to the backend
        Response.AppendHeader("Access-Control-Allow-Origin", "*");
        
        string user = Request.Form["user"];
        string pass = Request.Form["pass"];
        
        var result = new { authenticated = false, fullName = "", plan = "", message = "" };
        
        // Use the new database name we created
        string connStr = @"Data Source=.\SQLEXPRESS;Initial Catalog=APBBroadband;Integrated Security=True;TrustServerCertificate=True";
        
        using (SqlConnection conn = new SqlConnection(connStr)) {
            try {
                conn.Open();
                // We use TRIM to ensure no hidden spaces from the HTML input cause a mismatch
                string sql = "SELECT FullName, PlanName FROM Users WHERE LTRIM(RTRIM(Username))=@u AND LTRIM(RTRIM(Password))=@p";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@u", user != null ? user.Trim() : "");
                cmd.Parameters.AddWithValue("@p", pass != null ? pass.Trim() : "");
                
                SqlDataReader rdr = cmd.ExecuteReader();
                if (rdr.Read()) {
                    result = new { 
                        authenticated = true, 
                        fullName = rdr["FullName"].ToString(), 
                        plan = rdr["PlanName"].ToString(),
                        message = "Success"
                    };
                } else {
                    result = new { authenticated = false, fullName = "", plan = "", message = "Invalid Credentials" };
                }
            } catch (Exception ex) {
                result = new { authenticated = false, fullName = "", plan = "", message = "DB Error: " + ex.Message };
            }
        }
        
        Response.ContentType = "application/json";
        Response.Write(new JavaScriptSerializer().Serialize(result));
        Response.End();
    }
</script>