using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Threading;
using System.Diagnostics;
using System.Web.Services;

namespace Payroll_Mangmt_sys
{
    public partial class login1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["IsAuthenticated"] != null && (bool)Session["IsAuthenticated"])
            {
                // User is authenticated, redirect to admin.aspx
                Response.Redirect("Admindashboard.aspx");
            }
        }

        private string GetUserRoleFromDatabase(string username, string password, string location)
        {
            // Replace this with your actual database query logic to retrieve the user's role
            // You should query the "Login_Cred" table with the provided username, password, and location
            // and return the user's role.

            // Example query (make sure to adapt this to your database structure):
            // SELECT Role FROM Login_Cred WHERE Username = @Username AND Password = @Password AND Location = @Location

            string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT Role FROM Login_Cred WHERE Username = @Username AND Password = @Password AND Location = @Location";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@Password", password);
                    cmd.Parameters.AddWithValue("@Location", location);

                    con.Open();
                    object role = cmd.ExecuteScalar();

                    if (role != null)
                    {
                        return role.ToString();
                    }
                }
            }

            // Return a default role or handle the scenario where the role is not found
            return "DefaultRole";
        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // Replace the connection string with your SQL Server credentials
            string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string username = txtUsername.Text;
                string password = txtPassword.Text;
                string selectedLocation = ddlLocation.SelectedValue; // Get the selected location from the dropdown list
                
                // Modify the SQL query to include the location check
                string query = "SELECT COUNT(*) FROM Login_Cred WHERE Username = @Username AND Password = @Password AND Location = @Location";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@Password", password);
                    cmd.Parameters.AddWithValue("@Location", selectedLocation); // Pass the selected location as a parameter

                    con.Open();
                    int count = (int)cmd.ExecuteScalar();      

                    if (count > 0)
                    {
                        Session["SelectedLocation"] = selectedLocation;
                        Session["LoginLocation"] = selectedLocation;
                        // Redirect to the appropriate dashboard upon successful login
                        Session["IsAuthenticated"] = true;

                        // You can determine the appropriate dashboard URL based on user role or other criteria.
                        // For example, check if the user is a super admin or regular admin.
                        string userRole = GetUserRoleFromDatabase(username, password, selectedLocation);

                        if (userRole == "SuperAdmin")
                        {
                            Response.Redirect("Intermediate_Superadmin.aspx", false);
                        }
                        else if (userRole == "Admin")
                        {
                            Response.Redirect("Admindashboard.aspx", false);
                        }
                        

                        Context.ApplicationInstance.CompleteRequest(); // Prevents further processing of the page
                    }
                    else
                    {
                        // Show an error message for invalid credentials

                        Session["LoginErrorMessage"] = "Invalid username, password, or location.";
                        Response.Redirect("login1.aspx");
                    }
                }
            }
        }
        [WebMethod]
        public static string Logout()
        {
            // Clear the session (example: remove the user's authentication details)
            HttpContext.Current.Session.Clear();

            // Remove the selected location from the session
            HttpContext.Current.Session.Remove("SelectedLocation");

            // Redirect to the login page
            return "login1.aspx"; // Adjust the URL if needed
        }
    }
}