<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e) {
        string connStr = @"Data Source=.\SQLEXPRESS;Initial Catalog=APBBroadband;Integrated Security=True";
        using (SqlConnection conn = new SqlConnection(connStr)) {
            string sql = "INSERT INTO BroadbandPlans (ProviderID, PlanName, Amount, SpeedMbps, PlanDetails) VALUES (@pid, @n, @a, @s, @d)";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("@pid", Request.Form["pid"]);
            cmd.Parameters.AddWithValue("@n", Request.Form["name"]);
            cmd.Parameters.AddWithValue("@a", Request.Form["amt"]);
            cmd.Parameters.AddWithValue("@s", Request.Form["speed"]);
            cmd.Parameters.AddWithValue("@d", Request.Form["details"]);
            conn.Open();
            cmd.ExecuteNonQuery();
        }
        Response.Write("Success");
        Response.End();
    }
</script>