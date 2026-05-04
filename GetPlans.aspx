<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Script.Serialization" %>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e) {
        string connStr = @"Data Source=.\SQLEXPRESS;Initial Catalog=APBBroadband;Integrated Security=True;TrustServerCertificate=True";
        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection(connStr)) {
            string sql = @"SELECT p.PlanID, p.PlanName, p.Amount, p.SpeedMbps, p.ProviderID, mp.ProviderName 
                           FROM BroadbandPlans p JOIN MasterProviders mp ON p.ProviderID = mp.ProviderID";
            SqlDataAdapter da = new SqlDataAdapter(sql, conn);
            da.Fill(dt);
        }
        var list = new System.Collections.Generic.List<object>();
        foreach (DataRow row in dt.Rows) {
            list.Add(new { 
                id = row["PlanID"], 
                name = row["PlanName"], 
                amount = row["Amount"], 
                speed = row["SpeedMbps"], 
                providerId = row["ProviderID"],
                providerName = row["ProviderName"]
            });
        }
        Response.ContentType = "application/json";
        Response.Write(new JavaScriptSerializer().Serialize(list));
        Response.End();
    }
</script>