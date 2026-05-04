<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e) {
        try {
            // Retrieve data sent from the modal
            string id = Request.Form["id"];
            string name = Request.Form["name"];
            string amount = Request.Form["amount"];
            string speed = Request.Form["speed"];
            string details = Request.Form["details"];

            // Your database connection string
            string connStr = @"Data Source=.\SQLEXPRESS;Initial Catalog=APBBroadband;Integrated Security=True;TrustServerCertificate=True";
            
            using (SqlConnection conn = new SqlConnection(connStr)) {
                // SQL Command to update the specific plan
                string sql = "UPDATE BroadbandPlans SET PlanName=@n, Amount=@a, SpeedMbps=@s, PlanDetails=@d WHERE PlanID=@id";
                
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@n", name);
                cmd.Parameters.AddWithValue("@a", amount);
                cmd.Parameters.AddWithValue("@s", speed);
                cmd.Parameters.AddWithValue("@d", details);
                cmd.Parameters.AddWithValue("@id", id);
                
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            // Send back a plain text "Success" message to the JavaScript
            Response.Write("Success");
        } catch (Exception ex) { 
            // If something goes wrong, send the error back
            Response.Write("Error: " + ex.Message); 
        }
        Response.End();
    }
</script>