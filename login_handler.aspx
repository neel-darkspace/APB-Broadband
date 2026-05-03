<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.HttpMethod == "POST")
        {
            string user = Request.Form["username"];
            string pass = Request.Form["password"];
            
            // Connection string for APBManagementStudio
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
                        // Success: Redirect to the dashboard page
                        Response.Redirect("dashboard.aspx");
                    } else {
                        // Failure: Show alert and go back to login
                        Response.Write("<script>alert('Invalid Username or Password'); window.location='index.html';</script>");
                    }
                }
                catch (Exception ex) {
                    Response.Write("<p style='color:red;'>Database Error: " + ex.Message + "</p>");
                }
            }
        }
        else {
            Response.Redirect("index.html");
        }
    }
</script>