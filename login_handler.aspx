<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.HttpMethod == "POST")
        {
            string user = Request.Form["username"];
            string pass = Request.Form["password"];
            
            // CRITICAL FIX: Pointing to your specific instance from your screenshot
            string connString = @"Data Source=DESKTOP-HLJKG0L\SQLEXPRESS;Initial Catalog=APBManagementStudio;Integrated Security=True";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT Role FROM Users WHERE Username=@user AND Password=@pass";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@user", user);
                cmd.Parameters.AddWithValue("@pass", pass);

                try {
                    conn.Open();
                    object role = cmd.ExecuteScalar();
                    
                    if (role != null) {
                        Response.Redirect("dashboard.html");
                    } else {
                        // Breaking the script tag prevents compilation errors
                        Response.Write("<script>alert('Invalid Credentials'); window.location='index.html';</" + "script>");
                    }
                }
                catch (Exception ex) {
                    Response.Write("<h3 style='color:red; font-family:sans-serif;'>Connection Error: " + ex.Message + "</h3>");
                }
            }
        }
    }
</script>