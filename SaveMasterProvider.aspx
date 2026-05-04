<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e) {
        string name = Request.Form["name"];
        string details = Request.Form["details"];
        string connStr = @"Data Source=.\SQLEXPRESS;Initial Catalog=APBBroadband;Integrated Security=True";
        
        using (SqlConnection conn = new SqlConnection(connStr)) {
            string sql = "INSERT INTO MasterProviders (ProviderName, OtherDetails) VALUES (@n, @d)";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("@n", name);
            cmd.Parameters.AddWithValue("@d", details);
            conn.Open();
            cmd.ExecuteNonQuery();
        }
        Response.Write("Success");
        Response.End();
    }
</script>