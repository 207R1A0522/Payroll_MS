using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Payroll_Mangmt_sys
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
                // Check if the query string contains a location parameter
                if (!string.IsNullOrEmpty(Request.QueryString["location"]))
                {
                    string selectedLocation = Request.QueryString["location"];

                    // Set the session variable based on the selected location
                    Session["SelectedLocation"] = selectedLocation;

                    // Redirect to the appropriate page based on the selected location
                    if (selectedLocation.Equals("Medchal", StringComparison.OrdinalIgnoreCase))
                    {
                        // Redirect to SuperAdminDashboard.aspx for Medchal
                        Response.Redirect("SuperAdminDashboard.aspx");
                    }
                    else
                    {
                        // Redirect to Admindashboard.aspx for other locations
                        Response.Redirect("Admindashboard.aspx");
                    }
                }
                locationDropdown_SelectedIndexChanged(sender, e);

            }
        }





        protected void locationDropdown_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Get the selected location from the dropdown
            string selectedLocation = locationDropdown.SelectedValue;
            string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

            // Use the selected location to fetch corresponding username, password, and email from the database
            string query = "SELECT Username, Password, Email FROM Login_Cred WHERE Location = @Location";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Location", selectedLocation);
                    connection.Open();

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // Display the values in the textboxes
                            usernameTextBox.Text = reader["Username"].ToString();
                            passwordTextBox.Text = reader["Password"].ToString();
                            emailTextBox.Text = reader["Email"].ToString();
                        }
                        else
                        {
                            // Default values or clear the textboxes if no match is found
                            usernameTextBox.Text = "";
                            passwordTextBox.Text = "";
                            emailTextBox.Text = "";
                        }
                    }
                }
            }

        }





        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                // Retrieve the updated values from the textboxes
                string updatedUsername = usernameTextBox.Text;
                string updatedPassword = passwordTextBox.Text;
                string updatedEmail = emailTextBox.Text;

                // Retrieve the selected location from the dropdown
                string selectedLocation = locationDropdown.SelectedItem.Text;
                string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

                // Use the selected location to update the corresponding username, password, and email
                string query = "UPDATE Login_Cred SET Username = @Username, Password = @Password, Email = @Email WHERE Location = @Location";

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@Username", updatedUsername);
                        command.Parameters.AddWithValue("@Password", updatedPassword);
                        command.Parameters.AddWithValue("@Email", updatedEmail);
                        command.Parameters.AddWithValue("@Location", selectedLocation);

                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "success", $"showSuccessNotification('{selectedLocation}');", true);
            }
            catch (Exception ex)
            {
                // Log the exception or display an error message
                string errorMessage = WebUtility.HtmlEncode(ex.Message);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "error", $"showErrorNotification('Personal', '{errorMessage}');", true);
            }


        }



    }


}