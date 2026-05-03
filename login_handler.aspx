<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.HttpMethod == "POST")
        {
            string user = Request.Form["username"];
            string pass = Request.Form["password"];
            
            // This string uses the server name and database you just created[cite: 1, 4]
            string connString = @"Data Source=DESKTOP-HLJKG0L\SQLEXPRESS;Initial Catalog=apbstudio;Integrated Security=True";

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
                        // Success: Move to the dashboard[cite: 3]
                        Response.Redirect("dashboard.html");
                    } else {
                        // Fail: Use broken tag to avoid compilation errors[cite: 3]
                        Response.Write("<script>alert('Invalid Credentials'); window.location='index.html';</" + "script>");
                    }
                }
                catch (Exception ex) {
                    // Displays the error if the connection fails again
                    Response.Write("<div style='color:red; font-family:sans-serif;'>Connection Error: " + ex.Message + "</div>");
                }
            }
        }
    }
</script>