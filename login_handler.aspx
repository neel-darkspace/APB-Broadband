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
                        Response.Write("<h2 style='color:white; font-family:sans-serif;'>Login Successful! Welcome, " + role.ToString() + "</h2>");
                    } else {
                        Response.Write("<h2 style='color:red; font-family:sans-serif;'>Invalid Username or Password. <a href='index.html' style='color:white;'>Try again</a></h2>");
                    }
                }
                catch (Exception ex) {
                    Response.Write("<p style='color:yellow;'>Error: " + ex.Message + "</p>");
                }
            }
        }
        else {
            Response.Redirect("index.html");
        }
    }
</script>