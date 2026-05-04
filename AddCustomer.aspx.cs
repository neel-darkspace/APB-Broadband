using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

public partial class AddCustomer : Page {
    protected void Page_Load(object sender, EventArgs e) {
        if (Request.HttpMethod == "POST") {
            try {
                // We use Request.Form to match the keys from the frontend
                string name = Request.Form["n"];
                string phone = Request.Form["p"];
                string altPhone = Request.Form["ap"];
                string email = Request.Form["e"];
                string address = Request.Form["addr"];
                string installAddr = Request.Form["iaddr"];
                string reference = Request.Form["ref"];
                string lat = Request.Form["lat"];
                string lng = Request.Form["lng"];
                string provider = Request.Form["sp"];
                string plan = Request.Form["plan"];
                string equipment = Request.Form["eq"];

                string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connStr)) {
                    string sql = @"INSERT INTO APB_Customers 
                                 (FullName, ContactNumber, AlternateNumber, EmailAddress, PrimaryAddress, 
                                  InstallationAddress, ReferenceSource, Latitude, Longitude, 
                                  ServiceProvider, AllocatedPlanName, EquipmentDetails, InstallationStatus) 
                                 VALUES (@n, @p, @ap, @e, @addr, @iaddr, @ref, @lat, @lng, @sp, @plan, @eq, 'Active')";

                    using (SqlCommand cmd = new SqlCommand(sql, conn)) {
                        cmd.Parameters.AddWithValue("@n", name);
                        cmd.Parameters.AddWithValue("@p", phone);
                        cmd.Parameters.AddWithValue("@ap", (object)altPhone ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@e", (object)email ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@addr", address);
                        cmd.Parameters.AddWithValue("@iaddr", installAddr);
                        cmd.Parameters.AddWithValue("@ref", (object)reference ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@lat", (object)lat ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@lng", (object)lng ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@sp", provider);
                        cmd.Parameters.AddWithValue("@plan", plan);
                        cmd.Parameters.AddWithValue("@eq", equipment);

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