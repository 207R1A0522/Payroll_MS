using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Payroll_Mangmt_sys
{
    public partial class Employee_Search : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Populate the "Designation" dropdown list on the initial page load
                PopulateDesignationDropdown();
                string selectedLocation = Session["SelectedLocation"] as string;
                if (selectedLocation == "Medchal")
                {
                    // Enable the DropDownList and perform any additional logic if needed.
                    ddlLocation.Enabled = true;
                }
                else
                {
                    // Set the selected value and disable the DropDownList.
                    ddlLocation.SelectedValue = selectedLocation;
                    ddlLocation.Enabled = false;
                }


            }
        }

        private void PopulateDesignationDropdown()
        {
            // Define your database connection string
            string connStr = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT DISTINCT Designation FROM addemployee_personal", conn))
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    // Clear any existing items in the dropdown list
                    ddlDesignation.Items.Clear();

                    while (reader.Read())
                    {
                        string designation = reader["Designation"].ToString();

                        // Add each unique designation to the dropdown list
                        ddlDesignation.Items.Add(new ListItem(designation, designation));
                    }

                    // Add an "All" option at the top of the dropdown list
                    ddlDesignation.Items.Insert(0, new ListItem("All", ""));
                }
            }
        }


        protected void btnSearch_Click(object sender, EventArgs e)
        {
            // Retrieve filter values from the controls
            string selectedLocation = Session["SelectedLocation"] as string;
            string filter_location;
            if(selectedLocation=="Medchal")
            {
                filter_location = ddlLocation.SelectedValue;
            }
            else
            {
                filter_location = selectedLocation;
            }
            string designation = ddlDesignation.SelectedValue;
            string salary = txtSalary.Text;
            
            string gender = ddlGender.SelectedValue;
            string bloodGroup = ddlBloodgroup.SelectedValue;

            // Build the SQL query
            string query = "SELECT Emp_ID, Emp_Name FROM addemployee_personal WHERE " +
                           "(@Location IS NULL OR Emp_Location = @Location) " +
                           "AND (@Gender IS NULL OR Gender = @Gender) " +
                           "AND (@BloodGroup IS NULL OR Bloodgroup = @BloodGroup)"+
                           "AND (@Designation IS NULL OR Designation = @Designation)"+
                           "AND (@CTC_Gross IS NULL OR CTC_Gross = @CTC_Gross)";

            string connec = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connec))
            {
                connection.Open();
                SqlCommand cmd = new SqlCommand(query, connection);

                // Add parameters to the command
                cmd.Parameters.AddWithValue("@Location", string.IsNullOrEmpty(filter_location) ? (object)DBNull.Value : filter_location);
                cmd.Parameters.AddWithValue("@Gender", string.IsNullOrEmpty(gender) ? (object)DBNull.Value : gender);
                cmd.Parameters.AddWithValue("@BloodGroup", string.IsNullOrEmpty(bloodGroup) ? (object)DBNull.Value : bloodGroup);
                cmd.Parameters.AddWithValue("@Designation", string.IsNullOrEmpty(designation) ? (object)DBNull.Value : designation);
                cmd.Parameters.AddWithValue("@CTC_Gross", string.IsNullOrEmpty(salary) ? DBNull.Value : (object)salary);

                // Execute the query and retrieve the results
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        // Bind the search results to the GridView
                        GridView1.DataSource = reader;
                        GridView1.DataBind();
                        int rowCount = GridView1.Rows.Count;
                        lblRowCount.Text = $"We Found {rowCount} {(rowCount == 1 ? "row" : "rows")}.";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "showSuccessNotification", "showSuccessNotification('Details Fetched Successfully.');", true);
                    }
                    else
                    {
                        // Handle the case where no matching records were found
                        // You can display a message or perform other actions here
                        lblRowCount.Text = "No matching records found.";

                        // You can also clear the GridView if you want to remove any previous results
                        GridView1.DataSource = null;
                        GridView1.DataBind();
                    }
                }
            }
        }






    }
}