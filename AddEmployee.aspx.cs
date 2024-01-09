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
using System.Xml.Linq;
using System.Web.Script.Services;
using System.Web.Services;
using System.Windows.Media.TextFormatting;


namespace Payroll_Mangmt_sys
{
    public partial class AddEmployee : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            txtEmpName_account.Attributes.Add("readonly", "readonly");
            txtEmpName_family.Attributes.Add("readonly", "readonly");
            if (!IsPostBack)
            {
                string selectedLocation = Session["SelectedLocation"] as string;

                // Set the selected location in the dropdown list
                if (!string.IsNullOrEmpty(selectedLocation))
                {
                    ddlOfficeLocation.SelectedValue = selectedLocation;
                    ddlOfficeLocation_Account.SelectedValue = selectedLocation;
                    ddlOfficeLocation_Family.SelectedValue = selectedLocation;

                    // If the selected location is "Medchal," enable the dropdown for selection
                    if (selectedLocation == "Medchal")
                    {
                        ddlOfficeLocation.Enabled = true;
                        ddlOfficeLocation_Account.Enabled = true;
                        ddlOfficeLocation_Family.Enabled = true;
                    }
                    else
                    {
                        ddlOfficeLocation.Enabled = false;
                        ddlOfficeLocation_Account.Enabled = false;
                        ddlOfficeLocation_Family.Enabled = false;
                    }
                }
            }
        }

        protected void ddlLocation_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Handle the selection change event if needed
            // This event will be triggered when the user selects a different location.

        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<string> GetEmployeeIDSuggestions(string prefixText, int count)
        {
            List<string> suggestions = new List<string>();

            // Implement code to fetch employee ID suggestions from your database
            // Replace this with your actual data retrieval logic
            string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

            // Check if the location is available in the session
            string selectedLocation = HttpContext.Current.Session["SelectedLocation"] as string;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT Emp_ID FROM addemployee_personal WHERE Emp_ID LIKE @prefixText";

                // Add a location filter to the query if the location is not empty
                if (!string.IsNullOrEmpty(selectedLocation))
                {
                    query += " AND Emp_Location = @selectedLocation";
                }

                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    cmd.Parameters.AddWithValue("@prefixText", prefixText + "%");

                    // Set the location parameter if it's not empty
                    if (!string.IsNullOrEmpty(selectedLocation))
                    {
                        cmd.Parameters.AddWithValue("@selectedLocation", selectedLocation);
                    }

                    connection.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read() && suggestions.Count < count)
                        {
                            suggestions.Add(reader["Emp_ID"].ToString());
                        }
                    }
                }
            }

            return suggestions;
        }



        protected void txtEmployeeID_TextChanged(object sender, EventArgs e)
        {
            // Your code to handle the text changed event, if needed.
            // For example, you can leave it empty if you don't have specific logic to execute here
            // .

        }


        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string GetEmployeeName(string selectedEmpID)
        {
            string empName = string.Empty;
            string errorMessage = string.Empty;

            // Implement code to fetch the Employee Name from your database based on the selected Employee ID
            // Replace this with your actual data retrieval logic
            string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // Check if the Employee ID exists in the selected location
                string locationQuery = "SELECT Emp_Location FROM addemployee_personal WHERE Emp_ID = @selectedEmpID";
                using (SqlCommand locationCmd = new SqlCommand(locationQuery, connection))
                {
                    locationCmd.Parameters.AddWithValue("@selectedEmpID", selectedEmpID);
                    connection.Open();
                    object locationResult = locationCmd.ExecuteScalar();

                    if (locationResult != null)
                    {
                        string employeeLocation = locationResult.ToString();

                        // Check if the employee's location matches the selected location
                        if (string.Equals(employeeLocation, HttpContext.Current.Session["SelectedLocation"]?.ToString(), StringComparison.OrdinalIgnoreCase))
                        {
                            // Employee ID is valid for the selected location, fetch the Employee Name
                            string nameQuery = "SELECT Emp_Name FROM addemployee_personal WHERE Emp_ID = @selectedEmpID";
                            using (SqlCommand cmd = new SqlCommand(nameQuery, connection))
                            {
                                cmd.Parameters.AddWithValue("@selectedEmpID", selectedEmpID);
                                object result = cmd.ExecuteScalar();
                                if (result != null)
                                {
                                    empName = result.ToString();
                                }
                            }
                        }
                        
                    }
                    else
                    {
                        // Employee ID doesn't match the selected location
                        errorMessage = "Employee ID not found in selected location or Invalid Employee ID";
                    }
                }
            }
            // Generate JavaScript code to show the error message in a Toastr notification
            string script = $@"
        <script type='text/javascript'>
            showErrorNotification('Family', '{errorMessage}');
        </script>";

            // Register the script to be injected into the page output
            Page page = HttpContext.Current.CurrentHandler as Page;
            if (page != null)
            {
                ScriptManager.RegisterStartupScript(page, page.GetType(), "errorScript", script, false);
            }

            return empName;
        }

        protected void SavePersonalDetails_Click(object sender, EventArgs e)
        {

            string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    // Check if the employee ID already exists in the database
                    string checkQuery = "SELECT COUNT(*) FROM addemployee_personal WHERE Emp_ID = @Emp_ID";
                    using (SqlCommand checkCmd = new SqlCommand(checkQuery, connection))
                    {
                        
                        checkCmd.Parameters.AddWithValue("@Emp_ID", txtEmployeeID.Text);
                        int existingCount = Convert.ToInt32(checkCmd.ExecuteScalar());

                        if (existingCount == 1)
                        {
                            // Employee ID already exists, display a message to the user
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "showErrorNotification('Personal', 'Employee already exists.');", true);
                        }
                        else
                        {
                            string query = "INSERT INTO addemployee_personal (Emp_ID, Emp_Bio, Emp_Location, Emp_Name, Designation, CTC_Gross,CTC_Basic, Mobile, Email_ID, DOB, Age, Father_Name, Gender, City, Pincode, Address, Bloodgroup , PF_Number , ESI_Number , PAN, Aadhar_Number, Date_Of_Joining, Emp_Type) " +
                                       "VALUES (@Emp_ID,@Emp_Bio, @Emp_Location, @Emp_Name, @Designation, @CTC_Gross,@CTC_Basic, @Mobile, @Email_ID, @DOB, @Age, @Father_Name, @Gender, @City, @Pincode, @Address, @Bloodgroup , @PF_Number , @ESI_Number , @PAN, @Aadhar_Number, @Date_Of_Joining, @Emp_Type)";

                            using (SqlCommand cmd = new SqlCommand(query, connection))
                            {
                                // Set parameter values from the TextBoxes
                                cmd.Parameters.AddWithValue("@Emp_ID", txtEmployeeID.Text);
                                cmd.Parameters.AddWithValue("@Emp_Bio", TextBox3.Text);
                                cmd.Parameters.AddWithValue("@Emp_Location", ddlOfficeLocation.SelectedValue);
                                cmd.Parameters.AddWithValue("@Emp_Name", txtEmployeeName.Text);
                                cmd.Parameters.AddWithValue("@Designation", TextBox4.Text);
                                cmd.Parameters.AddWithValue("@CTC_Gross", TextBox5.Text);
                                cmd.Parameters.AddWithValue("@CTC_Basic", ddlCTCBasic.SelectedValue);
                                cmd.Parameters.AddWithValue("@Mobile", TextBox6.Text);
                                cmd.Parameters.AddWithValue("@Email_ID", TextBox1.Text);
                                cmd.Parameters.AddWithValue("@DOB", DateTime.ParseExact(txtDOB.Text, "dd-MM-yyyy", null));
                                cmd.Parameters.AddWithValue("@Age", txtAge.Text);
                                cmd.Parameters.AddWithValue("@Father_Name", txtFatherName.Text);
                                cmd.Parameters.AddWithValue("@Gender", ddlGender.SelectedValue);
                                cmd.Parameters.AddWithValue("@City", txtCity.Text);
                                cmd.Parameters.AddWithValue("@Pincode", txtPincode.Text);
                                cmd.Parameters.AddWithValue("@Address", txtAddress.Text);
                                cmd.Parameters.AddWithValue("@Bloodgroup", ddlBloodgroup.SelectedValue);
                                cmd.Parameters.AddWithValue("@PF_Number", TextBox2.Text);
                                cmd.Parameters.AddWithValue("@ESI_Number", txtESI_Number.Text);
                                cmd.Parameters.AddWithValue("@PAN", txtPAN.Text);
                                cmd.Parameters.AddWithValue("@Aadhar_Number", txtAadharNumber.Text);
                                cmd.Parameters.AddWithValue("@Date_Of_Joining", DateTime.ParseExact(txtDate_Of_Joining.Text, "dd-MM-yyyy", null));
                                cmd.Parameters.AddWithValue("@Emp_Type", Emp_type.SelectedValue);


                                int rowsAffected = cmd.ExecuteNonQuery();

                                if (rowsAffected > 0)
                                {
                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "success", "showSuccessNotification('Personal details updated successfully');", true);
                                    ClearPersonalDetailsFields();
                                }
                                else
                                {
                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "showErrorNotification('Personal');", true);
                                }

                            }
                        }
                    }
                }
                
            }
            catch (Exception ex)
            {
                hidSuccessMessage.Value = "Error adding Personal details: " + ex.Message;
            }

            ClearPersonalDetailsFields();

        }
        private void ClearPersonalDetailsFields()
        {
            txtEmployeeID.Text = "";
            TextBox3.Text = "";
            txtEmployeeName.Text = "";
            TextBox6.Text = "";
            TextBox1.Text = "";
            ddlCTCBasic.SelectedIndex = 0;
            txtDOB.Text = "";
            txtAge.Text = "";
            txtFatherName.Text = "";
            ddlGender.SelectedIndex = 0;
            TextBox4.Text = "";
            TextBox5.Text = "";
            ddlBloodgroup.SelectedIndex = 0;
            TextBox2.Text = "";
            txtESI_Number.Text = "";
            txtPAN.Text = "";
            txtAadharNumber.Text = "";
            txtDate_Of_Joining.Text = "";
            txtCity.Text = "";
            txtPincode.Text = "";
            txtAddress.Text = "";
            Emp_type.SelectedIndex = 0;

        }

        protected void CancelPersonalDetails_Click(object sender, EventArgs e)
        {

            ClearPersonalDetailsFields();


        }


        //Account Details
        protected void SaveAccountDetails_Click(object sender, EventArgs e)
        {
            string prefilled = prefilledIFSC.InnerText; // Access directly via runat="server"
            string editableIFSC = txtEditableIFSC.Value; // Access directly via runat="server"

            string combinedIFSC = prefilled + editableIFSC;
            string selectedBank = DropDownList1.SelectedValue;

            if (selectedBank == "Others")
            {
                // If "Others" is selected, get the entered bank name and IFSC code
                string enteredBankName = bankNameInput.Value; // Get the bank name from the input field
                string enteredIFSC = ifscCodeInput.Value; // Get the IFSC code from the input field

                // Now, you can store the entered bank name and IFSC code into the database using your database logic (e.g., SQL INSERT query)
                // Example SQL INSERT query:
                // INSERT INTO YourTableName (BankName, IFSCCode) VALUES ('enteredBankName', 'enteredIFSC')

                string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
                try
                {
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        connection.Open();
                        // Check if the employee ID already exists in the database
                        string checkQuery = "SELECT COUNT(*) FROM addemployee_account WHERE Emp_ID = @Emp_ID";
                        using (SqlCommand checkCmd = new SqlCommand(checkQuery, connection))
                        {

                            checkCmd.Parameters.AddWithValue("@Emp_ID", txtEmpID_account.Text);
                            int existingCount = Convert.ToInt32(checkCmd.ExecuteScalar());

                            if (existingCount == 1)
                            {
                                // Employee ID already exists, display a message to the user
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "showErrorNotification('Account', 'Employee already exists.');", true);

                            }
                            else
                            {

                                string query = "INSERT INTO addemployee_account (Emp_ID, Emp_Location, Emp_Name, Bank_Name, Account_Number, Branch, IFSC_Code) " +
                                           "VALUES (@Emp_ID, @Emp_Location, @Emp_Name, @Bank_Name, @Account_Number, @Branch, @IFSC_Code)";

                                using (SqlCommand cmd = new SqlCommand(query, connection))
                                {
                                    // Set parameter values from the TextBoxes
                                    cmd.Parameters.AddWithValue("@Emp_ID", txtEmpID_account.Text);
                                    cmd.Parameters.AddWithValue("@Emp_Location", ddlOfficeLocation_Account.SelectedValue);
                                    cmd.Parameters.AddWithValue("@Emp_Name", txtEmpName_account.Text);
                                    cmd.Parameters.AddWithValue("@Bank_Name", enteredBankName);
                                    cmd.Parameters.AddWithValue("@Account_Number", txtAccountNumber.Text);
                                    cmd.Parameters.AddWithValue("@Branch", txtBranch.Text);
                                    cmd.Parameters.AddWithValue("@IFSC_Code", enteredIFSC);


                                    int rowsAffected = cmd.ExecuteNonQuery();

                                    if (rowsAffected > 0)
                                    {
                                        ScriptManager.RegisterStartupScript(this, this.GetType(), "success", "showSuccessNotification('Account details updated successfully');", true);
                                        ClearAccountDetailsFields();
                                    }
                                    else
                                    {
                                        ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "showErrorNotification('Account');", true);
                                    }
                                }
                            }
                        }
                    }

                }
                catch (Exception ex)
                {
                    hidSuccessMessage.Value = "Error adding Account details: " + ex.Message;
                }
            }
            else
            {
                string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
                try
                {
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        connection.Open();
                        // Check if the employee ID already exists in the database
                        string checkQuery = "SELECT COUNT(*) FROM addemployee_account WHERE Emp_ID = @Emp_ID";
                        using (SqlCommand checkCmd = new SqlCommand(checkQuery, connection))
                        {

                            checkCmd.Parameters.AddWithValue("@Emp_ID", txtEmpID_account.Text);
                            int existingCount = Convert.ToInt32(checkCmd.ExecuteScalar());

                            if (existingCount == 1)
                            {
                                // Employee ID already exists, display a message to the user
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "showErrorNotification('Account', 'Employee already exists.');", true);

                            }
                            else
                            {

                                string query = "INSERT INTO addemployee_account (Emp_ID, Emp_Location, Emp_Name, Emp_PAN, Emp_Aadhar, Bank_Name, Account_Number, Branch, IFSC_Code) " +
                                           "VALUES (@Emp_ID, @Emp_Location, @Emp_Name, @Emp_PAN, @Emp_Aadhar, @Bank_Name, @Account_Number, @Branch, @IFSC_Code)";

                                using (SqlCommand cmd = new SqlCommand(query, connection))
                                {
                                    // Set parameter values from the TextBoxes
                                    cmd.Parameters.AddWithValue("@Emp_ID", txtEmpID_account.Text);
                                    cmd.Parameters.AddWithValue("@Emp_Location", ddlOfficeLocation_Account.SelectedValue);
                                    cmd.Parameters.AddWithValue("@Emp_Name", txtEmpName_account.Text);
                                    cmd.Parameters.AddWithValue("@Emp_PAN", txtPAN.Text);
                                    cmd.Parameters.AddWithValue("@Emp_Aadhar", txtAadharNumber.Text);
                                    cmd.Parameters.AddWithValue("@Bank_Name", DropDownList1.SelectedValue);
                                    cmd.Parameters.AddWithValue("@Account_Number", txtAccountNumber.Text);
                                    cmd.Parameters.AddWithValue("@Branch", txtBranch.Text);
                                    cmd.Parameters.AddWithValue("@IFSC_Code", combinedIFSC);


                                    int rowsAffected = cmd.ExecuteNonQuery();

                                    if (rowsAffected > 0)
                                    {
                                        ScriptManager.RegisterStartupScript(this, this.GetType(), "success", "showSuccessNotification('Account details updated successfully');", true);
                                        ClearAccountDetailsFields();
                                    }
                                    else
                                    {
                                        ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "showErrorNotification('Account');", true);
                                    }
                                }
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    hidSuccessMessage.Value = "Error adding Account details: " + ex.Message;
                }
            }
        }

        private void ClearAccountDetailsFields()
        {
            // Clear account details fields here
            txtEmpID_account.Text = "";
            txtEmpName_account.Text = "";
            DropDownList1.SelectedIndex = 0;
            txtAccountNumber.Text = "";
            txtBranch.Text = "";
            
        }

        protected void CancelAccountDetails_Click(object sender, EventArgs e)
        {
            ClearAccountDetailsFields();
        }



        //Family Details

        protected void SaveFamilyDetails_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    // Check if the employee ID already exists in the database
                    string checkQuery = "SELECT COUNT(*) FROM addemployee_family WHERE Emp_ID = @Emp_ID";
                    using (SqlCommand checkCmd = new SqlCommand(checkQuery, connection))
                    {

                        checkCmd.Parameters.AddWithValue("@Emp_ID", txtEmpID_family.Text);
                        int existingCount = Convert.ToInt32(checkCmd.ExecuteScalar());

                        if (existingCount == 1)
                        {
                            // Employee ID already exists, display a message to the user
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "showErrorNotification('Family', 'Employee already exists.');", true);
                            
                        }
                        else
                        {
                            string query = "INSERT INTO addemployee_family (Emp_ID, Emp_Location, Emp_Name, Emp_Marital, Nom_Name, Nom_Relation, Nom_Mobile, Nom_Account) " +
                                   "VALUES (@Emp_ID, @Emp_Location, @Emp_Name, @Emp_Marital, @Nom_Name, @Nom_Relation, @Nom_Mobile, @Nom_Account)";

                            using (SqlCommand cmd = new SqlCommand(query, connection))
                            {
                                // Set parameter values from the TextBoxes
                                cmd.Parameters.AddWithValue("@Emp_ID", txtEmpID_family.Text);
                                cmd.Parameters.AddWithValue("@Emp_Location", ddlOfficeLocation_Family.SelectedValue);
                                cmd.Parameters.AddWithValue("@Emp_Name", txtEmpName_family.Text);
                                cmd.Parameters.AddWithValue("@Emp_Marital", ddlMaritalStatus.SelectedValue);
                                cmd.Parameters.AddWithValue("@Nom_Name", txtnn.Text);
                                cmd.Parameters.AddWithValue("@Nom_Relation", ddlnr.SelectedValue);
                                cmd.Parameters.AddWithValue("@Nom_Mobile", txtnm.Text);
                                cmd.Parameters.AddWithValue("@Nom_Account", txtnban.Text);



                                int rowsAffected = cmd.ExecuteNonQuery();

                                if (rowsAffected > 0)
                                {
                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "success", "showSuccessNotification('Family details updated successfully');", true);
                                    ClearFamilyDetailsFields();
                                }
                                else
                                {
                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "showErrorNotification('Family');", true);
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                hidSuccessMessage.Value = "Error adding Family details: " + ex.Message;
            }
        }

       
        

        private void ClearFamilyDetailsFields()
        {
            // Clear account details fields here
            txtEmpID_family.Text = "";
            txtEmpName_family.Text = "";
            ddlMaritalStatus.SelectedIndex = 0;
            txtnn.Text = "";
            ddlnr.SelectedIndex = 0;
            txtnm.Text = "";
            txtnban.Text = "";
        }

        protected void CancelFamilyDetails_Click(object sender, EventArgs e)
        {
            ClearFamilyDetailsFields();
        }





    }
}