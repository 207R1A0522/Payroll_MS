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
    public class LocationSummary
    {
        public string Location { get; set; }
        public decimal TotalGrossPay { get; set; }
        public decimal TotalNetPay { get; set; }
    }
    public partial class SuperAdminDashboard : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
           
                // Load and display previous data from the database
                DisplayPreviousData();
                CalculateLocationSums();
            
           
        }

        private void CalculateLocationSums()
        {
            // Set your connection string
            string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

            // Initialize variables to store location-wise sums
            decimal totalGrossPayPathur = 0;
            decimal totalGrossPayTunikibollaram = 0;
            decimal totalGrossPayToopran = 0;
            decimal totalGrossPayWestbengal = 0;
            decimal totalGrossPayEluru = 0;
            decimal totalGrossPayKodakandla = 0;
            decimal totalGrossPayMedchal = 0;

            decimal totalNetPayPathur = 0;
            decimal totalNetPayTunikibollaram = 0;
            decimal totalNetPayToopran = 0;
            decimal totalNetPayWestbengal = 0;
            decimal totalNetPayEluru = 0;
            decimal totalNetPayKodakandla = 0;
            decimal totalNetPayMedchal = 0;

            

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Set your SQL query to retrieve data grouped by location
                string query = "SELECT Emp_Location, SUM(CAST(CTC_Gross AS decimal(18, 2))) AS TotalGrossPay, SUM(CAST(NetPay AS decimal(18, 2))) AS TotalNetPay FROM Emp_Salary GROUP BY Emp_Location";


                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            string location = reader["Emp_Location"].ToString();
                            decimal totalGrossPay = Convert.ToDecimal(reader["TotalGrossPay"]);
                            decimal totalNetPay = Convert.ToDecimal(reader["TotalNetPay"]);

                            // Update location-wise sums based on the location
                            switch (location)
                            {
                                case "Pathur":
                                    totalGrossPayPathur = totalGrossPay;
                                    totalNetPayPathur = totalNetPay;
                                    break;
                                case "Tunikibollaram":
                                    totalGrossPayTunikibollaram = totalGrossPay;
                                    totalNetPayTunikibollaram = totalNetPay;
                                    break;
                                case "Toopran":
                                    totalGrossPayToopran = totalGrossPay;
                                    totalNetPayToopran = totalNetPay;
                                    break;
                                case "Westbengal":
                                    totalGrossPayWestbengal = totalGrossPay;
                                    totalNetPayWestbengal = totalNetPay;
                                    break;
                                case "Eluru":
                                    totalGrossPayEluru = totalGrossPay;
                                    totalNetPayEluru = totalNetPay;
                                    break;
                                case "Kodakandla":
                                    totalGrossPayKodakandla = totalGrossPay;
                                    totalNetPayKodakandla = totalNetPay;
                                    break;
                                case "Medchal":
                                    totalGrossPayMedchal = totalGrossPay;
                                    totalNetPayMedchal = totalNetPay;
                                    break;
                            }
                        }
                    }
                }

                
            }
            string script = @"<script>
                        var branchData = {
                            labels: ['Pathur', 'Kodakandla', 'Tunikibollaram', 'Eluru', 'Toopran', 'Westbengal', 'Medchal'],
                            datasets: [
                                {
                                    label: 'Gross Pay',
                                    backgroundColor: 'rgba(52, 152, 219, 0.7)', // Blue color
                                    data: [" + totalGrossPayPathur + @", " + totalGrossPayKodakandla + @", " + totalGrossPayTunikibollaram + @", " + totalGrossPayEluru + @", " + totalGrossPayToopran + @", " + totalGrossPayWestbengal + @", " + totalGrossPayMedchal + @"],
                                },
                                {
                                    label: 'Net Pay',
                                    backgroundColor: 'rgba(231, 76, 60, 0.7)', // Red color
                                    data: [" + totalNetPayPathur + @", " + totalNetPayKodakandla + @", " + totalNetPayTunikibollaram + @", " + totalNetPayEluru + @", " + totalNetPayToopran + @", " + totalNetPayWestbengal + @", " + totalNetPayMedchal + @"],
                                },
                            ],
                        };

                        var ctx = document.getElementById('barChart').getContext('2d');
                        var barChart = new Chart(ctx, {
                            type: 'bar',
                            data: branchData,
                            options: {
                                responsive: true, // Make the chart responsive
                                scales: {
                                    x: {
                                        beginAtZero: true,
                                    },
                                    y: {
                                        beginAtZero: true,
                                    },
                                },
                            },
                        });
                </script>";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "MyScript", script);
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


        protected void submitReport_Click(object sender, EventArgs e)
        {
            // Get the entered data
            string newData = reportInput.Text.Trim();

            if (!string.IsNullOrEmpty(newData))
            {
                // Store the data in the database
                StoreDataInDatabase(newData);

                // Display the data above the input box
                dataLabel.Text += newData + "<br />";

                // Clear the input box
                reportInput.Text = "";
            }
        }

        protected void StoreDataInDatabase(string data)
        {
            // Set your connection string
            string connectionString = WebConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Set your SQL query with the new column D_Date
                string query = "INSERT INTO ReportData (Description, D_Date) VALUES (@Description, @D_Date)";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Add parameters for the data and the current date
                    command.Parameters.AddWithValue("@Description", data);
                    command.Parameters.AddWithValue("@D_Date", DateTime.Now);

                    command.ExecuteNonQuery();
                }
            }
        }



    }
}
