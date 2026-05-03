<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.HttpMethod == "POST")
        {
            string user = Request.Form["username"];
            string pass = Request.Form["password"];
            
            // Database Connection for APBManagementStudio
            string connString = "Data Source=.;Initial Catalog=APBManagementStudio;Integrated Security=True";

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
                        // Create a simple session cookie for the HTML page to check
                        HttpCookie authCookie = new HttpCookie("AuthStatus", "Logged");
                        Response.Cookies.Add(authCookie);
                        
                        // Redirect to the HTML version of the dashboard
                        Response.Redirect("dashboard.html");
                    } else {
                        Response.Write("<script>alert('Invalid Credentials'); window.location='index.html';</script>");
                    }
                }
                catch (Exception ex) {
                    Response.Write("Error: " + ex.Message);
                }
            }
        }
    }
</script>