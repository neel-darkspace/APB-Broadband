<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Web.Script.Serialization" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e) {
        try {
            string json;
            using (var reader = new StreamReader(Request.InputStream)) {
                json = reader.ReadToEnd();
            }
            
            var serializer = new JavaScriptSerializer();
            var plans = serializer.Deserialize<System.Collections.Generic.List<System.Collections.Generic.Dictionary<string, object>>>(json);
            string connStr = @"Data Source=.\SQLEXPRESS;Initial Catalog=APBBroadband;Integrated Security=True;TrustServerCertificate=True";
            
            using (SqlConnection conn = new SqlConnection(connStr)) {
                conn.Open();
                foreach (var plan in plans) {
                    // 1. Resolve or AUTO-CREATE Provider Name to ID
                    object rawProvider = FindValue(plan, new[] { "Provider", "MasterProvider", "ProviderName" });
                    int resolvedId = GetOrCreateProviderID(conn, rawProvider);

                    if (resolvedId == 0) continue; 

                    // 2. Upsert Plan Logic (Replace if exists, else insert)
                    string sql = @"
                        IF EXISTS (SELECT 1 FROM BroadbandPlans WHERE PlanName = @n AND ProviderID = @pid)
                        BEGIN
                            UPDATE BroadbandPlans SET Amount = @a, SpeedMbps = @s, PlanDetails = @d 
                            WHERE PlanName = @n AND ProviderID = @pid
                        END
                        ELSE
                        BEGIN
                            INSERT INTO BroadbandPlans (ProviderID, PlanName, Amount, SpeedMbps, PlanDetails) 
                            VALUES (@pid, @n, @a, @s, @d)
                        END";
                    
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@pid", resolvedId);
                    cmd.Parameters.AddWithValue("@n", FindValue(plan, new[] { "PlanName", "Plan" }) ?? "New Plan");
                    cmd.Parameters.AddWithValue("@a", FindValue(plan, new[] { "Amount", "Price" }) ?? 0);
                    cmd.Parameters.AddWithValue("@s", FindValue(plan, new[] { "SpeedMbps", "Speed" }) ?? 0);
                    cmd.Parameters.AddWithValue("@d", FindValue(plan, new[] { "PlanDetails", "Details" }) ?? "");
                    
                    cmd.ExecuteNonQuery();
                }
            }
            Response.Write("Success");
        }
        catch (Exception ex) {
            Response.Write("Error: " + ex.Message);
        }
        Response.End();
    }

    // This function ensures the Provider exists in the DB before the plan is saved
    private int GetOrCreateProviderID(SqlConnection conn, object input) {
        if (input == null) return 0;
        string name = input.ToString().Trim();
        
        // Check if name already exists
        string checkSql = "SELECT ProviderID FROM MasterProviders WHERE ProviderName = @name";
        using (SqlCommand cmd = new SqlCommand(checkSql, conn)) {
            cmd.Parameters.AddWithValue("@name", name);
            object result = cmd.ExecuteScalar();
            if (result != null) return Convert.ToInt32(result);
        }

        // If not found, CREATE the new provider automatically
        string insSql = "INSERT INTO MasterProviders (ProviderName) OUTPUT INSERTED.ProviderID VALUES (@name)";
        using (SqlCommand cmd = new SqlCommand(insSql, conn)) {
            cmd.Parameters.AddWithValue("@name", name);
            return (int)cmd.ExecuteScalar();
        }
    }

    private object FindValue(System.Collections.Generic.Dictionary<string, object> dict, string[] aliases) {
        foreach (var key in dict.Keys) {
            string cleanKey = key.Trim().Replace(" ", "").ToLower();
            foreach (var alias in aliases) {
                if (cleanKey == alias.ToLower()) return dict[key];
            }
        }
        return null;
    }
</script>