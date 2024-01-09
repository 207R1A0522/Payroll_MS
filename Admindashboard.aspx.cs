using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Payroll_Mangmt_sys
{
    public partial class Admindashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
               
                // Check if the session contains the selected location
                if (Session["SelectedLocation"] != null)
                {
                    string selectedLocation = Session["SelectedLocation"].ToString();
                    CalculateTotalNetPay(selectedLocation);
                }
                else
                {
                    // Handle the case where the location is not set in the session
                    // You can redirect the user to select a location or handle it as needed.
                }

                string script = "toggleValues();";
                ScriptManager.RegisterStartupScript(this, GetType(), "ToggleValuesScript", script, true);

                DisplayPreviousData();
            }
        }


        [WebMethod]
        public static string GetUserProfileDetails(string location)
        {
            try
            {
                // You may need to configure your connection string in the Web.config file
                string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();

                    // Modify the SQL query to match your table structure
                    string query = "SELECT Username, Email, Location, Role FROM Login_Cred WHERE Location = @Location";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Location", location);

                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            if (dr.Read())
                            {
                                // Create a user profile object
                                var userProfile = new
                                {
                                    UserName = dr["Username"].ToString(),
                                    Email = dr["Email"].ToString(),
                                    Location = dr["Location"].ToString(),
                                    Role = dr["Role"].ToString()
                                };

                                // Serialize the user profile to JSON
                                string userProfileJson = JsonConvert.SerializeObject(userProfile);

                                return userProfileJson;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions
            }

            return null;
        }

        protected void CalculateTotalNetPay(string location)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
            string netpayQuery = "SELECT SUM(CONVERT(decimal, NetPay)) AS TotalNetPay FROM Emp_Salary WHERE Emp_Location = @Location";
            string ctcGrossQuery = "SELECT SUM(CONVERT(decimal, CTC_Gross)) AS TotalCTCGross FROM Emp_Salary WHERE Emp_Location = @Location";
            decimal totalNetPay = 0;
            decimal totalCTCGross = 0;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                using (SqlCommand netpaycmd = new SqlCommand(netpayQuery, connection))
                {
                    netpaycmd.Parameters.AddWithValue("@Location", location);

                    object result = netpaycmd.ExecuteScalar();

                    if (result != null && result != DBNull.Value)
                    {
                        totalNetPay = Convert.ToDecimal(result);
                    }
                }

                using (SqlCommand ctcGrossCmd = new SqlCommand(ctcGrossQuery, connection))
                {
                    ctcGrossCmd.Parameters.AddWithValue("@Location", location);

                    object result = ctcGrossCmd.ExecuteScalar();

                    if (result != null && result != DBNull.Value)
                    {
                        totalCTCGross = Convert.ToDecimal(result);
                    }
                }

                netPayHiddenField.Value = totalNetPay.ToString();
                ctcGrossHiddenField.Value = totalCTCGross.ToString();
            }
        }
        private void DisplayPreviousData()
        {
            // Retrieve data from the database
            List<Tuple<string, DateTime>> previousData = GetPreviousDataFromDatabase();

            // Display the data in the label
            foreach (Tuple<string, DateTime> dataTuple in previousData)
            {
                string data = $"<div style=\"float: left;\">{dataTuple.Item1}</div><div style=\"float: right; color: gray;\"><small>{dataTuple.Item2.ToShortDateString()}</small></div>";
                dataLabel.Text += data + "<br style=\"clear: both;\" />";
            }
        }



        private List<Tuple<string, DateTime>> GetPreviousDataFromDatabase()
        {
            List<Tuple<string, DateTime>> previousData = new List<Tuple<string, DateTime>>();

            // Set your connection string
            string connectionString = WebConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Set your SQL query to retrieve data with the date
                string query = "SELECT TOP 5 Description, D_Date FROM ReportData ORDER BY D_ID DESC;";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            // Read data from the database
                            string data = reader["Description"].ToString();
                            DateTime date = Convert.ToDateTime(reader["D_Date"]);

                            // Add the data and date as a tuple to the list
                            previousData.Add(new Tuple<string, DateTime>(data, date));
                        }
                    }
                }
            }

            return previousData;
        }

    }
}