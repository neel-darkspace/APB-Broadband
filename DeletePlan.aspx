<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e) {
        string id = Request.QueryString["id"];
        string connStr = @"Data Source=.\SQLEXPRESS;Initial Catalog=APBBroadband;Integrated Security=True";
        using (SqlConnection conn = new SqlConnection(connStr)) {
            string sql = "DELETE FROM BroadbandPlans WHERE PlanID = @id";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("@id", id);
            conn.Open();
            cmd.ExecuteNonQuery();
        }
        Response.Write("Success");
        Response.End();
    }
</script>