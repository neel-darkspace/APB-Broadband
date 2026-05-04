<%@ Page Language="C#" ContentType="application/json" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Script.Serialization" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e) {
        if (Request.HttpMethod == "POST") {
            string user = Request.Form["username"];
            string pass = Request.Form["password"];
            
            // Critical Fix: Points exactly to your local SQL instance[cite: 3]
            string connString = @"Data Source=DESKTOP-HLJKG0L\SQLEXPRESS;Initial Catalog=apb;Integrated Security=True";

            using (SqlConnection conn = new SqlConnection(connString)) {
                string query = "SELECT FullName FROM Users WHERE Username=@u AND Password=@p";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@u", user);
                cmd.Parameters.AddWithValue("@p", pass);

                try {
                    conn.Open();
                    object name = cmd.ExecuteScalar();
                    bool auth = (name != null);
                    var result = new { authenticated = auth, fullName = name };
                    Response.Write(new JavaScriptSerializer().Serialize(result));
                }
                catch (Exception ex) {
                    // Send error details to JS console for debugging
                    Response.Write(new JavaScriptSerializer().Serialize(new { error = ex.Message }));
                }
            }
        }
    }
</script>