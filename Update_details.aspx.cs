using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Payroll_Mangmt_sys
{
    public partial class Update_details : System.Web.UI.Page
    {
        // Create a dictionary to store family member controls
        //private Dictionary<int, Tuple<TextBox, TextBox>> familyMembers = new Dictionary<int, Tuple<TextBox, TextBox>>();

        protected void Page_Load(object sender, EventArgs e)
        {
            txtEmployeeID.Attributes.Add("readonly", "readonly");
            TextBox8.Attributes.Add("readonly", "readonly");
            txtEmployeeName.Attributes.Add("readonly", "readonly");
            txtEmpID_account.Attributes.Add("readonly", "readonly");
            txtEmpName_account.Attributes.Add("readonly", "readonly");
            txtEmpID_family.Attributes.Add("readonly", "readonly");
            txtEmpName_family.Attributes.Add("readonly", "readonly");
            if (!IsPostBack)
            {
                if (Request.QueryString["EmployeeID"] != null)
                {
                    string employeeID = Request.QueryString["EmployeeID"].ToString();

                    // Fetch employee details from the "addemployee_personal" table
                    string personalDetailsQuery = "SELECT * FROM addemployee_personal WHERE Emp_ID = @EmployeeID";
                    // Fetch account details from the "addemployee_account" table
                    string accountDetailsQuery = "SELECT * FROM addemployee_account WHERE Emp_ID = @EmployeeID";
                    // Fetch family details from the "addemployee_family" table
                    string familyDetailsQuery = "SELECT * FROM addemployee_family WHERE Emp_ID = @EmployeeID";

                    // Create a SqlConnection and SqlCommand for personal details
                    using (SqlConnection personalConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString))
                    using (SqlCommand personalCmd = new SqlCommand(personalDetailsQuery, personalConnection))
                    {
                        personalCmd.Parameters.AddWithValue("@EmployeeID", employeeID);

                        try
                        {
                            personalConnection.Open();
                            SqlDataReader personalReader = personalCmd.ExecuteReader();

                            if (personalReader.Read())
                            {
                                // Populate personal details fields with the fetched data
                                txtEmployeeID.Text = personalReader["Emp_ID"].ToString();
                                TextBox8.Text= personalReader["Emp_Bio"].ToString();
                                txtEmployeeName.Text = personalReader["Emp_Name"].ToString();
                                TextBox4.Text = personalReader["Designation"].ToString();
                                TextBox5.Text = personalReader["CTC_Gross"].ToString();
                                object ctcBasicValue = personalReader["CTC_Basic"];
                                string ctcbasic = (ctcBasicValue != DBNull.Value && ctcBasicValue != null) ? ctcBasicValue.ToString() : string.Empty;
                                ListItem selectedItem5 = ddlCTCBasic.Items.FindByText(ctcbasic);

                                // Check if the item is found before trying to access its properties
                                if (selectedItem5 != null)
                                {
                                    selectedItem5.Selected = true;
                                }
                                TextBox6.Text= personalReader["Mobile"].ToString();
                                TextBox1.Text= personalReader["Email_ID"].ToString();
                                DateTime dob1 = (DateTime)personalReader["DOB"];
                                txtDOB.Text = dob1.ToString("dd-MM-yyyy");
                                txtAge.Text= personalReader["Age"].ToString();
                                txtFatherName.Text= personalReader["Father_Name"].ToString();
                                string gender = personalReader["Gender"].ToString();
                                ListItem selectedItem = ddlGender.Items.FindByText(gender);
                                selectedItem.Selected = true;
                                txtCity.Text = personalReader["City"].ToString();
                                txtPincode.Text = personalReader["Pincode"].ToString();
                                txtAddress.Text = personalReader["Address"].ToString();
                                string  bloodgroup= personalReader["Bloodgroup"].ToString();
                                ListItem selectedItem1 = ddlBloodgroup.Items.FindByText(bloodgroup);
                                selectedItem1.Selected = true;
                                TextBox2.Text = personalReader["PF_Number"].ToString();
                                txtESI_Number.Text= personalReader["ESI_Number"].ToString();
                                TextBox3.Text = personalReader["PAN"].ToString();
                                TextBox7.Text = personalReader["Aadhar_Number"].ToString();
                                DateTime dateOfJoining = (DateTime)personalReader["Date_Of_Joining"];
                                txtDate_Of_Joining.Text = dateOfJoining.ToString("dd-MM-yyyy");
                                
                                

                            }

                            personalReader.Close();
                        }
                        catch (Exception ex)
                        {
                            // Handle exceptions for personal details, e.g., log the error or display an error message
                        }
                    }

                    // Create a SqlConnection and SqlCommand for account details
                    using (SqlConnection accountConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString))
                    using (SqlCommand accountCmd = new SqlCommand(accountDetailsQuery, accountConnection))
                    {
                        accountCmd.Parameters.AddWithValue("@EmployeeID", employeeID);

                        try
                        {
                            accountConnection.Open();
                            SqlDataReader accountReader = accountCmd.ExecuteReader();

                            if (accountReader.Read())
                            {
                                // Populate account details fields with the fetched data
                                txtEmpID_account.Text = accountReader["Emp_ID"].ToString();
                                txtEmpName_account.Text = accountReader["Emp_Name"].ToString();
                                txtBankName.Text = accountReader["Bank_Name"].ToString();
                                txtAccountNumber.Text = accountReader["Account_Number"].ToString();
                                txtBranch.Text = accountReader["Branch"].ToString();
                                txtIFSCCode.Text = accountReader["IFSC_Code"].ToString();



                            }

                            accountReader.Close();
                        }
                        catch (Exception ex)
                        {
                            // Handle exceptions for account details, e.g., log the error or display an error message
                        }
                    }
                    using (SqlConnection familyConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString))
                    using (SqlCommand familyCmd = new SqlCommand(familyDetailsQuery, familyConnection))
                    {
                        familyCmd.Parameters.AddWithValue("@EmployeeID", employeeID);

                        try
                        {
                            familyConnection.Open();
                            SqlDataReader familyReader = familyCmd.ExecuteReader();

                            if (familyReader.Read())
                            {
                                // Populate account details fields with the fetched data
                                txtEmpID_family.Text = familyReader["Emp_ID"].ToString();
                                txtEmpName_family.Text = familyReader["Emp_Name"].ToString();
                                string marital = familyReader["Emp_Marital"].ToString();
                                ListItem selectedItem5 = ddlMaritalStatus.Items.FindByText(marital);
                                selectedItem5.Selected = true;
                                txtnn.Text= familyReader["Nom_Name"].ToString();
                                string nrelation = familyReader["Nom_Relation"].ToString();
                                ListItem selectedItem6 = ddlnr.Items.FindByText(nrelation);
                                selectedItem6.Selected = true;
                                txtnm.Text= familyReader["Nom_Mobile"].ToString();
                                txtnban.Text= familyReader["Nom_Account"].ToString();



                            }

                            familyReader.Close();
                        }
                        catch (Exception ex)
                        {
                            // Handle exceptions for account details, e.g., log the error or display an error message
                            Response.Write("An error occurred: " + ex.Message);
                        }
                    }
                }

            }
        }
        protected void btnSaveDetails_Click(object sender, EventArgs e)
        {
            try
            {
                string EmpID = txtEmployeeID.Text;
                string Empbio = TextBox8.Text;
                string mobile = TextBox6.Text;
                string email = TextBox1.Text;
                DateTime dob;
                if (DateTime.TryParseExact(txtDOB.Text, "dd-MM-yyyy", null, System.Globalization.DateTimeStyles.None, out dob))
                {
                    // 'dob' now contains the parsed date from txtDOB
                }
                string age = txtAge.Text;
                string fathername = txtFatherName.Text;
                string gender = ddlGender.SelectedValue;
                string designation = TextBox4.Text;
                string ctc = TextBox5.Text;
                string ctcbasic = ddlCTCBasic.SelectedValue;
                string bloodgroup = ddlBloodgroup.SelectedValue;
                string pf = TextBox2.Text;
                string esi = txtESI_Number.Text;
                DateTime doj;
                if (DateTime.TryParseExact(txtDate_Of_Joining.Text, "dd-MM-yyyy", null, System.Globalization.DateTimeStyles.None, out doj))
                {
                    // 'doj' now contains the parsed date from txtDate_Of_Joining
                }
                string city = txtCity.Text;
                string pin = txtPincode.Text;
                string address = txtAddress.Text;

                string pan = TextBox3.Text;

                string aadhar = TextBox7.Text;
                string bankName = txtBankName.Text;
                string accountNumber = txtAccountNumber.Text;
                string branch = txtBranch.Text;
                string ifsc = txtIFSCCode.Text;
                string maritalStatus = ddlMaritalStatus.SelectedValue;
                string nname = txtnn.Text;
                string nrelation=ddlnr.SelectedValue;
                string nmobile = txtnm.Text;
                string nbank = txtnban.Text;

                // Update the database with the edited details
                bool updateResult = UpdateEmployeeDetails(EmpID, Empbio, mobile, email, dob, age, fathername, gender, designation, ctc,ctcbasic, bloodgroup, pf, esi, doj, city, pin, address, pan, aadhar, bankName, accountNumber, branch, ifsc, maritalStatus, nname, nrelation, nmobile, nbank);
                if (updateResult)
                {
                    // Show a success notification using JavaScript
                    ScriptManager.RegisterStartupScript(this, GetType(), "showSuccessNotification", "showSuccessNotification('Employee details updated successfully.');", true);
                }
                else
                {
                    // Show an error notification using JavaScript
                    ScriptManager.RegisterStartupScript(this, GetType(), "showErrorNotification", "showErrorNotification('Error updating employee details.');", true);
                }
            }
            catch(Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showErrorNotification", $"showErrorNotification('An error occurred: {ex.Message}');", true);
            }

        }

        



        private bool UpdateEmployeeDetails(string EmpID,string Empbio, string mobile, string email, DateTime dob, string age, string fathername, string gender, string designation, string ctc, string ctcbasic, string bloodgroup, string pf, string esi, DateTime doj, string city, string pin, string address, string pan, string aadhar, string bankName, string accountNumber, string branch, string ifsc, string maritalStatus, string nname, string nrelation, string nmobile, string nbank)
        {
            bool updateSuccess = false;
            string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string updatePersonalQuery = "UPDATE addemployee_personal SET  Designation=@Designation,CTC_Gross=@CTC_Gross,CTC_Basic=@CTC_Basic, Mobile = @Mobile, Email_ID = @Email_ID, DOB = @DOB, Age=@Age,Father_Name=@Father_Name,Gender=@Gender,City=@City, Pincode=@Pincode,Address=@Address, Bloodgroup=@Bloodgroup,PF_Number=@PF_Number,ESI_Number=@ESI_Number, PAN=@PAN, Aadhar_Number=@Aadhar_Number, Date_Of_Joining=@Date_Of_Joining WHERE Emp_ID = @Emp_ID";

                string updateAccountQuery = "UPDATE addemployee_account SET Bank_Name = @Bank_Name, Account_Number = @Account_Number, Branch = @Branch, IFSC_Code = @IFSC_Code WHERE Emp_ID = @Emp_ID";

                string updateFamilyQuery = "UPDATE addemployee_family SET Emp_Marital = @Emp_Marital, Nom_Name=@Nom_Name, Nom_Relation=@Nom_Relation, Nom_Mobile=@Nom_Mobile, Nom_Account=@Nom_Account   WHERE Emp_ID = @Emp_ID";

                using (SqlCommand cmd = new SqlCommand(updatePersonalQuery, connection))
                {
                    cmd.Parameters.AddWithValue("@Emp_ID", EmpID);
                    cmd.Parameters.AddWithValue("@Emp_Bio", Empbio);
                    cmd.Parameters.AddWithValue("@Designation", designation);
                    cmd.Parameters.AddWithValue("@CTC_Gross", ctc);
                    cmd.Parameters.AddWithValue("@CTC_Basic", ctcbasic);
                    cmd.Parameters.AddWithValue("@Mobile", mobile);
                    cmd.Parameters.AddWithValue("@Email_ID", email);
                    cmd.Parameters.AddWithValue("@DOB", dob);
                    cmd.Parameters.AddWithValue("@Age", age);
                    cmd.Parameters.AddWithValue("@Father_Name", fathername);
                    cmd.Parameters.AddWithValue("@Gender", gender);
                    cmd.Parameters.AddWithValue("@City", city);
                    cmd.Parameters.AddWithValue("@Pincode", pin);
                    cmd.Parameters.AddWithValue("@Address", address);
                    cmd.Parameters.AddWithValue("@Bloodgroup", bloodgroup);
                    cmd.Parameters.AddWithValue("@PF_Number", pf);
                    cmd.Parameters.AddWithValue("@ESI_Number", esi);
                    cmd.Parameters.AddWithValue("@PAN", pan);
                    cmd.Parameters.AddWithValue("@Aadhar_Number", aadhar);
                    cmd.Parameters.AddWithValue("@Date_Of_Joining", doj);
                  

                    // Execute the SQL command to update personal details
                    connection.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    updateSuccess = rowsAffected > 0;
                }

                using (SqlCommand cmd = new SqlCommand(updateAccountQuery, connection))
                {
                    cmd.Parameters.AddWithValue("@Emp_ID", EmpID);
                    cmd.Parameters.AddWithValue("@Bank_Name", bankName);
                    cmd.Parameters.AddWithValue("@Account_Number", accountNumber);
                    cmd.Parameters.AddWithValue("@Branch", branch);
                    cmd.Parameters.AddWithValue("@IFSC_Code", ifsc);

                    // Execute the SQL command to update account details
                    int rowsAffected = cmd.ExecuteNonQuery();
                    updateSuccess &= rowsAffected > 0;
                }

                using (SqlCommand cmd = new SqlCommand(updateFamilyQuery, connection))
                {
                    cmd.Parameters.AddWithValue("@Emp_ID", EmpID);
                    cmd.Parameters.AddWithValue("@Emp_Marital", maritalStatus);
                    cmd.Parameters.AddWithValue("@Nom_Name", nname);
                    cmd.Parameters.AddWithValue("@Nom_Relation", nrelation);
                    cmd.Parameters.AddWithValue("@Nom_Mobile", nmobile);
                    cmd.Parameters.AddWithValue("@Nom_Account", nbank);

                    // Execute the SQL command to update family details
                    int rowsAffected = cmd.ExecuteNonQuery();
                    updateSuccess &= rowsAffected > 0;
                }
            }
            return updateSuccess;
        }






    }
}