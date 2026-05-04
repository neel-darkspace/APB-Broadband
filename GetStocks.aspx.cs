using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Script.Serialization;

public partial class GetStocks : System.Web.UI.Page {
    protected void Page_Load(object sender, EventArgs e) {
        Response.ContentType = "application/json";
        try {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr)) {
                string sql = "SELECT StockID, ItemCategory, BrandName, Specification, CostingRS, Quantity FROM APB_Stocks ORDER BY LastUpdated DESC";
                using (SqlCommand cmd = new SqlCommand(sql, conn)) {
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                    foreach (DataRow dr in dt.Rows) {
                        var row = new Dictionary<string, object>();
                        foreach (DataColumn col in dt.Columns) {
                            row.Add(col.ColumnName, dr[col]);
                        }
                        rows.Add(row);
                    }

                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    Response.Write(serializer.Serialize(rows));
                }
            }
        } catch (Exception ex) {
            Response.Write("[]"); // Return empty array on error
        }
        Response.End();
    }
}