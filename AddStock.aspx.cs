using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class AddStock : System.Web.UI.Page {
    protected void Page_Load(object sender, EventArgs e) {
        if (Request.HttpMethod == "POST") {
            try {
                // Safely retrieve form values
                string item = Request.Form["item"] ?? "";
                string brand = Request.Form["brand"] ?? "";
                string spec = Request.Form["spec"] ?? "";
                string costStr = Request.Form["cost"] ?? "0";
                string qtyStr = Request.Form["qty"] ?? "0";

                // Validate critical fields to avoid null reference exceptions
                if (string.IsNullOrEmpty(item) || string.IsNullOrEmpty(brand)) {
                    Response.Write("Error: Missing Item or Brand data.");
                    Response.End();
                    return;
                }

                // Check if connection string exists
                if (ConfigurationManager.ConnectionStrings["MyDbConn"] == null) {
                    Response.Write("Error: Connection string 'MyDbConn' not found in web.config.");
                    Response.End();
                    return;
                }

                string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connStr)) {
                    using (SqlCommand cmd = new SqlCommand("sp_AddStock", conn)) {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@ItemCategory", item);
                        cmd.Parameters.AddWithValue("@BrandName", brand);
                        cmd.Parameters.AddWithValue("@Specification", spec);
                        cmd.Parameters.AddWithValue("@CostingRS", decimal.Parse(costStr));
                        cmd.Parameters.AddWithValue("@Quantity", int.Parse(qtyStr));

                        conn.Open();
                        cmd.ExecuteNonQuery();
                        Response.Write("Success");
                    }
                }
            } catch (Exception ex) {
                Response.Write("Error: " + ex.Message);
            }
            Response.End();
        }
    }
}