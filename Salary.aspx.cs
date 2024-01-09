using OfficeOpenXml.FormulaParsing.Excel.Functions.Engineering;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Reflection.Emit;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using OfficeOpenXml;
using System.Globalization;
using System.Data;

namespace Payroll_Mangmt_sys
{
    public partial class Salary : System.Web.UI.Page
    {
        private decimal view_newCtcGross;
        private decimal view_ctcBasicValue;
        private decimal view_ctcHRAValue;
        private decimal view_caValue;
        private decimal view_medicalValue;
        private decimal view_othersValue;
        private decimal view_totalGrossValue;
        private decimal view_totalPaidGross;
        private decimal view_actualBasic;
        private decimal view_actualHRA;
        private decimal view_actualca;
        private decimal view_actualMedical;
        private decimal view_others1;
        private decimal view_lop;
        private decimal view_EPF;
        private decimal view_ESI;
        private decimal view_PT;
        private decimal view_medical1;
        private decimal view_totalDeduction;
        private decimal view_arrears;
        private decimal view_NetPay;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            empName.Attributes.Add("readonly", "readonly");
            ctcGross.Attributes.Add("readonly", "readonly");
            if (!IsPostBack)
            {
                string selectedLocation = Session["SelectedLocation"] as string;
                if (selectedLocation!="Medchal")
                {
                    Session["SelectedLocation2"] = selectedLocation;
                }
                // Populate the "Select Year" dropdown list with years from 2020 to the current year
                
                if (!string.IsNullOrEmpty(selectedLocation))
                {
                    ddlOfficeLocation.SelectedValue = selectedLocation;


                    // If the selected location is "Medchal," enable the dropdown for selection
                    if (selectedLocation == "Medchal")
                    {
                        ddlOfficeLocation.Enabled = true;

                    }
                    else
                    {
                        ddlOfficeLocation.Enabled = false;

                    }
                }

                int currentYear = DateTime.Now.Year;
                for (int year = 2020; year <= currentYear; year++)
                {
                    ddlYear.Items.Add(new ListItem(year.ToString(), year.ToString()));
                }

                // Populate the "Select Month" dropdown list based on the initial selection
                PopulateMonthDropDown();
                ClearSalaryDetailsFields();
            }
        }
        protected void ddlLocation_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Handle the selection change event if needed
            // This event will be triggered when the user selects a different location.
            
            string selectedLocation1 = ddlOfficeLocation.SelectedValue;
            Session["SelectedLocation2"] = selectedLocation1;

        }
        protected void ddlYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Populate the "Select Month" dropdown list based on the selected year
            PopulateMonthDropDown();

        }

        private void PopulateMonthDropDown()
        {
            ddlMonth.Items.Clear();

            if (int.TryParse(ddlYear.SelectedValue, out int selectedYear))
            {
                int maxMonth = (selectedYear == DateTime.Now.Year) ? DateTime.Now.Month : 12;

                for (int monthValue = maxMonth; monthValue >= 1; monthValue--)
                {
                   
                    ddlMonth.Items.Add(new ListItem(monthValue.ToString(), monthValue.ToString()));
                }
            }
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
                string query = "SELECT Emp_ID FROM addemployee_personal WHERE Emp_ID LIKE @prefixText AND Emp_Type = 'Fulltime'";

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


        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static Dictionary<string, string> GetEmployeeDetails(string selectedEmpID, string selectedLocation1)
        {
            Dictionary<string, string> employeeDetails = new Dictionary<string, string>();

            string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT Emp_Name, CTC_Gross, Emp_Location, Emp_Type FROM addemployee_personal WHERE Emp_ID = @Emp_ID";

                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    cmd.Parameters.AddWithValue("@Emp_ID", selectedEmpID);
                    connection.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            string employeeLocation = reader["Emp_Location"].ToString();
                            string empType = reader["Emp_Type"].ToString();

                            // Check if the employee's location matches the selected location
                            if (string.Equals(employeeLocation, selectedLocation1, StringComparison.OrdinalIgnoreCase))
                            {
                                if (string.Equals(empType, "Fulltime", StringComparison.OrdinalIgnoreCase))
                                {
                                    // Employee location matches, retrieve the Employee Name and CTC Gross values
                                    employeeDetails["Emp_Name"] = reader["Emp_Name"].ToString();
                                    employeeDetails["CTC_Gross"] = reader["CTC_Gross"].ToString();
                                }
                                else
                                {
                                    // Employee type is not 'Fulltime', return an error message
                                    employeeDetails["Error"] = "Select Fulltime employees only.";
                                }
                            }
                            else
                            {
                                // Employee location does not match, return an error message
                                employeeDetails["Error"] = "Employee ID not found in selected location.";
                            }
                        }
                        else
                        {
                            // Employee ID not found
                            employeeDetails["Error"] = "Employee ID not found.";
                        }
                    }
                }
            }

            return employeeDetails;
        }





        protected void Download_Click(object sender, EventArgs e)
        {
            // Create a unique filename based on the current timestamp
            string fileName = $"salary_details_{DateTime.Now:yyyyMMddHHmmss}.xlsx";

            // Define the file path where you want to save the Excel file
            string downloadsPath = Environment.GetFolderPath(Environment.SpecialFolder.UserProfile) + "\\Downloads";
            string filePath = Path.Combine(downloadsPath, fileName);
            decimal view_ctcBasicValue = (decimal)Session["view_ctcBasicValue"];
            decimal view_ctcHRAValue = (decimal)Session["view_ctcHRAValue"];
            decimal view_caValue = (decimal)Session["view_caValue"];
            decimal view_medicalValue = (decimal)Session["view_medicalValue"];
            decimal view_othersValue = (decimal)Session["view_othersValue"];
            decimal view_totalPaidGross = (decimal)Session["view_totalPaidGross"];
            decimal view_actualBasic = (decimal)Session["view_actualBasic"];
            decimal view_actualHRA = (decimal)Session["view_actualHRA"];
            decimal view_actualca = (decimal)Session["view_actualca"];
            decimal view_actualMedical = (decimal)Session["view_actualMedical"];
            decimal view_others1 = (decimal)Session["view_others1"];
            decimal view_lop = (decimal)Session["view_lop"];
            decimal view_EPF = (decimal)Session["view_EPF"];
            decimal view_ESI = (decimal)Session["view_ESI"];
            decimal view_PT = (decimal)Session["view_PT"];
            decimal view_medical1 = (decimal)Session["view_medical1"];
            decimal view_totalDeduction = (decimal)Session["view_totalDeduction"];
            decimal view_arrears = (decimal)Session["view_arrears"];
            decimal view_NetPay = (decimal)Session["view_NetPay"];

            try
            {
                // Create a new Excel package
                using (var package = new ExcelPackage())
                {
                    // Add a new worksheet to the Excel package
                    var worksheet = package.Workbook.Worksheets.Add("Salary Details");

                    worksheet.Cells["A1"].Value = "CTC_Basic";
                    worksheet.Cells["A2"].Value = view_ctcBasicValue;

                    worksheet.Cells["B1"].Value = "CTC_HRA";
                    worksheet.Cells["B2"].Value = view_ctcHRAValue;

                    worksheet.Cells["C1"].Value = "C.A";
                    worksheet.Cells["C2"].Value = view_caValue;

                    worksheet.Cells["D1"].Value = "Medical";
                    worksheet.Cells["D2"].Value = view_medicalValue;

                    worksheet.Cells["E1"].Value = "Others";
                    worksheet.Cells["E2"].Value = view_othersValue;

                    worksheet.Cells["F1"].Value = "TotalPaidGross";
                    worksheet.Cells["F2"].Value = view_totalPaidGross;

                    worksheet.Cells["G1"].Value = "Actual_Basic";
                    worksheet.Cells["G2"].Value = view_actualBasic;

                    worksheet.Cells["H1"].Value = "Actual_HRA";
                    worksheet.Cells["H2"].Value = view_actualHRA;

                    worksheet.Cells["I1"].Value = "Actual-CA";
                    worksheet.Cells["I2"].Value = view_actualca;

                    worksheet.Cells["J1"].Value = "Actual_Medical";
                    worksheet.Cells["J2"].Value = view_actualMedical;

                    worksheet.Cells["K1"].Value = "Others1";
                    worksheet.Cells["K2"].Value = view_others1;

                    worksheet.Cells["L1"].Value = "LOP";
                    worksheet.Cells["L2"].Value = view_lop;

                    worksheet.Cells["M1"].Value = "EPF";
                    worksheet.Cells["M2"].Value = view_EPF;

                    worksheet.Cells["N1"].Value = "ESI";
                    worksheet.Cells["N2"].Value = view_ESI;

                    worksheet.Cells["O1"].Value = "PT";
                    worksheet.Cells["O2"].Value = view_PT;

                    worksheet.Cells["P1"].Value = "Medical1";
                    worksheet.Cells["P2"].Value = view_medical1;

                    worksheet.Cells["Q1"].Value = "Total_Deduction";
                    worksheet.Cells["Q2"].Value = view_totalDeduction;

                    worksheet.Cells["R1"].Value = "Arrears";
                    worksheet.Cells["R2"].Value = view_arrears;

                    worksheet.Cells["S1"].Value = "Net_Pay";
                    worksheet.Cells["S2"].Value = view_NetPay;

                    // Save the Excel package to the file
                    File.WriteAllBytes(filePath, package.GetAsByteArray());
                }

                // Clear Response reference
                Response.Clear();

                // Add header by specifying file name
                Response.AddHeader("Content-Disposition", "attachment; filename=" + fileName);

                // Add header for content type
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";

                // Add header for content length
                Response.AddHeader("Content-Length", new FileInfo(filePath).Length.ToString());

                // Transmit the file
                Response.TransmitFile(filePath);

                // End the response
                Response.End();
                ScriptManager.RegisterStartupScript(this, GetType(), "SuccessNotification", "toastr.success('Download completed successfully.', 'Success');", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "ErrorNotification", $"toastr.error('Error downloading file: {ex.Message}', 'Error');", true);
            }
        }
        private string GetEmpBioFromPersonalTable(string empId)
        {
            string personal = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
            using (SqlConnection personalConnection = new SqlConnection(personal))
            {
                string personalQuery = "SELECT Emp_Bio FROM addemployee_personal WHERE Emp_ID = @Emp_ID";

                using (SqlCommand personalCmd = new SqlCommand(personalQuery, personalConnection))
                {
                    personalCmd.Parameters.AddWithValue("@Emp_ID", empId);
                    personalConnection.Open();
                    object result = personalCmd.ExecuteScalar();

                    if (result != null)
                    {
                        return result.ToString();
                    }
                    else
                    {
                        return string.Empty;
                    }
                }
            }
        }
        protected void CalculateSalary_Click(object sender, EventArgs e)
        {
            int paiddays = 0;
            string ctcbasicpercentage = "";
            int ctcbasic = 0;

            // Modify the connection string and SQL query to retrieve the values from your Leaves table
            string leavesConnectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

            try
            {
                string empBio = GetEmpBioFromPersonalTable(empId.Text);
                using (SqlConnection leavesConnection = new SqlConnection(leavesConnectionString))
                {
                    string leavesQuery = "SELECT Paid_Days FROM Attendance_table_f WHERE Emp_ID = @Emp_ID";


                    using (SqlCommand leavesCmd = new SqlCommand(leavesQuery, leavesConnection))
                    {
                        leavesCmd.Parameters.AddWithValue("@Emp_ID", empBio);
                        leavesConnection.Open();
                        SqlDataReader reader = leavesCmd.ExecuteReader();
                        if (reader.Read())
                        {
                            // Retrieve the working days and leaves values from the database
                            paiddays = Convert.ToInt32(reader["Paid_Days"]);
             
                        }
                    }

                }
                string successMessage = "Salary calculations completed successfully.";
                ScriptManager.RegisterStartupScript(this, GetType(), "SuccessToast", $"toastr.success('{successMessage}', 'Success');", true);
            }
            catch (Exception ex)
            {
                string errorMessage = "Error calculating salary: " + ex.Message;
                ScriptManager.RegisterStartupScript(this, GetType(), "ErrorToast", $"toastr.error('{errorMessage}', 'Error');", true);
            }


            // Retrieve inputs from the form
            string ctcbasicstring = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

            try
            {
                string empid = empId.Text;
                using (SqlConnection salConnection = new SqlConnection(ctcbasicstring))
                {
                    string leavesQuery = "SELECT CTC_Basic FROM addemployee_personal WHERE Emp_ID = @Emp_ID";


                    using (SqlCommand leavesCmd = new SqlCommand(leavesQuery, salConnection))
                    {
                        leavesCmd.Parameters.AddWithValue("@Emp_ID", empid);
                        salConnection.Open();
                        SqlDataReader reader = leavesCmd.ExecuteReader();
                        if (reader.Read())
                        {
                            // Retrieve the working days and leaves values from the database
                            ctcbasicpercentage = reader["CTC_Basic"].ToString();
                            ctcbasic = Convert.ToInt32(ctcbasicpercentage.Trim('%').Trim());

                        }
                    }

                }
                string successMessage = "Salary calculations completed successfully.";
                ScriptManager.RegisterStartupScript(this, GetType(), "SuccessToast", $"toastr.success('{successMessage}', 'Success');", true);
            }
            catch (Exception ex)
            {
                string errorMessage = "Error calculating salary: " + ex.Message;
                ScriptManager.RegisterStartupScript(this, GetType(), "ErrorToast", $"toastr.error('{errorMessage}', 'Error');", true);
            }

            decimal ctcGrossValue = decimal.Parse(ctcGross.Text);




            decimal ThikeValue = string.IsNullOrWhiteSpace(hike.Text) ? 0 : decimal.Parse(hike.Text);
            decimal TepcValue = string.IsNullOrWhiteSpace(epc.Text) ? 0 : decimal.Parse(epc.Text);
            decimal TTDS = string.IsNullOrWhiteSpace(tds.Text) ? 0 : decimal.Parse(tds.Text);
            decimal TAdvance = string.IsNullOrWhiteSpace(advance.Text) ? 0 : decimal.Parse(advance.Text);
            decimal Travel = string.IsNullOrWhiteSpace(ta.Text) ? 0 : decimal.Parse(ta.Text);
            decimal ctcfinal=0.0m;
            // Calculate the new CTC Gross with the hike
            view_newCtcGross = ctcGrossValue + ThikeValue;
            if(ctcbasic==40)
            {
                ctcfinal = 0.4m;
            }
            else if(ctcbasic==50)
            {
                ctcfinal = 0.5m;
            }
            else if(ctcbasic==60)
            {
                ctcfinal = 0.6m;
            }
            // Calculate other components
            view_ctcBasicValue = ctcfinal * view_newCtcGross;
            view_ctcHRAValue = 0.4m * view_ctcBasicValue;
            view_caValue = 0.1m * view_ctcBasicValue;
            view_medicalValue = view_ctcBasicValue / 12m;
            view_othersValue = view_newCtcGross - (view_ctcBasicValue + view_ctcHRAValue + view_caValue + view_medicalValue);
            view_totalGrossValue = view_ctcBasicValue + view_ctcHRAValue + view_caValue + view_medicalValue + view_othersValue;
            view_totalPaidGross = ((view_totalGrossValue - TepcValue) / 31) * (paiddays);
            view_actualBasic = 0.4m * view_totalPaidGross;
            view_actualHRA = 0.4m * view_actualBasic;
            view_actualca = 0.1m * view_actualBasic;
            view_actualMedical = view_actualBasic / 12m;
            view_others1 = view_totalPaidGross - (view_actualBasic + view_actualHRA + view_actualca + view_actualMedical);
            view_lop = view_totalGrossValue - TepcValue - view_totalPaidGross;
            view_EPF = 0;
            if (view_actualBasic + view_actualMedical + view_others1 <= 15000)
            {
                view_EPF = 1.2m * (view_actualBasic + view_actualMedical + view_others1);
            }
            else
            {
                view_EPF = ((1800) / 31) * (paiddays);
            }
            view_ESI = 0;
            if (view_totalPaidGross <= 21000)
            {
                view_ESI = view_totalPaidGross * 0.075m;
            }

            view_PT = 0;
            if (view_totalPaidGross <= 15000)
            {
                view_PT = 0;
            }
            else if (view_totalPaidGross >= 15001 && view_totalPaidGross <= 20000)
            {
                view_PT = 150;
            }
            else
            {
                view_PT = 200;
            }

            view_medical1 = 0;
            if (view_ESI == 0)
            {
                view_medical1 = 564;
            }


            view_totalDeduction = view_EPF + view_ESI + view_PT + TTDS + TAdvance + view_medical1;
            view_arrears = 0;

            view_NetPay = view_totalPaidGross - view_totalDeduction + view_arrears+Travel;



            view_ctcBasicValue = Math.Round(view_ctcBasicValue);
            view_ctcHRAValue = Math.Round(view_ctcHRAValue);
            view_caValue = Math.Round(view_caValue);
            view_medicalValue = Math.Round(view_medicalValue);
            view_othersValue = Math.Round(view_othersValue);
            view_totalPaidGross = Math.Round(view_totalPaidGross);
            view_actualBasic = Math.Round(view_actualBasic, 0);
            view_actualHRA = Math.Round(view_actualHRA, 0);
            view_actualca = Math.Round(view_actualca, 0);
            view_actualMedical = Math.Round(view_actualMedical, 0);
            view_others1 = Math.Round(view_others1, 0);
            view_EPF = Math.Round(view_EPF);
            view_ESI = Math.Round(view_ESI);
            view_lop = Math.Round(view_lop, 0);
            view_totalDeduction = Math.Round(view_totalDeduction);
            view_NetPay = Math.Round(view_NetPay);

            // Display the calculated values
            ctcBasic.Text = view_ctcBasicValue.ToString("C");
            ctcHRA.Text = view_ctcHRAValue.ToString("C");
            ca.Text = view_caValue.ToString("C");
            medical.Text = view_medicalValue.ToString("C");
            others.Text = view_othersValue.ToString("C");
            totalGross.Text = view_totalPaidGross.ToString("C");
            ActualBasic.Text = view_actualBasic.ToString("C");
            ActualHRA.Text = view_actualHRA.ToString("C");
            actualCA.Text = view_actualca.ToString("C");
            ActualMedical.Text = view_actualMedical.ToString("C");
            Others1.Text = view_others1.ToString("C");
            LOP.Text = view_lop.ToString("C");
            epf.Text = view_EPF.ToString("C");
            esi.Text = view_ESI.ToString("C");
            pt.Text = view_PT.ToString("C");
            Medical1.Text = view_medical1.ToString("C");
            TotalDeduction.Text = view_totalDeduction.ToString("C");
            Arrears.Text = view_arrears.ToString("C");
            netPay.Text = view_NetPay.ToString("C");

            //Store in a Session
            Session["view_ctcBasicValue"] = view_ctcBasicValue;
            Session["view_ctcHRAValue"] = view_ctcHRAValue;
            Session["view_caValue"] = view_caValue;
            Session["view_medicalValue"] = view_medicalValue;
            Session["view_othersValue"] = view_othersValue;
            Session["view_totalPaidGross"] = view_totalPaidGross;
            Session["view_actualBasic"] = view_actualBasic;
            Session["view_actualHRA"] = view_actualHRA;
            Session["view_actualca"] = view_actualca;
            Session["view_actualMedical"] = view_actualMedical;
            Session["view_others1"] = view_others1;
            Session["view_lop"] = view_lop;
            Session["view_EPF"] = view_EPF;
            Session["view_ESI"] = view_ESI;
            Session["view_PT"] = view_PT;
            Session["view_medical1"] = view_medical1;
            Session["view_totalDeduction"] = view_totalDeduction;
            Session["view_arrears"] = view_arrears;
            Session["view_NetPay"] = view_NetPay;




            // Register a script to show the results in the UpdatePanel
            string script = "<script type='text/javascript'>showResults();</script>";
            ClientScript.RegisterStartupScript(this.GetType(), "ShowResultsScript", script);
        }

        protected void BtnSave_Click(object sender, EventArgs e)
        {
            decimal view_ctcBasicValue = (decimal)Session["view_ctcBasicValue"];
            decimal view_ctcHRAValue = (decimal)Session["view_ctcHRAValue"];
            decimal view_caValue = (decimal)Session["view_caValue"];
            decimal view_medicalValue = (decimal)Session["view_medicalValue"];
            decimal view_othersValue = (decimal)Session["view_othersValue"];
            decimal view_totalPaidGross = (decimal)Session["view_totalPaidGross"];
            decimal view_actualBasic = (decimal)Session["view_actualBasic"];
            decimal view_actualHRA = (decimal)Session["view_actualHRA"];
            decimal view_actualca = (decimal)Session["view_actualca"];
            decimal view_actualMedical = (decimal)Session["view_actualMedical"];
            decimal view_others1 = (decimal)Session["view_others1"];
            decimal view_lop = (decimal)Session["view_lop"];
            decimal view_EPF = (decimal)Session["view_EPF"];
            decimal view_ESI = (decimal)Session["view_ESI"];
            decimal view_PT = (decimal)Session["view_PT"];
            decimal view_medical1 = (decimal)Session["view_medical1"];
            decimal view_totalDeduction = (decimal)Session["view_totalDeduction"];
            decimal view_arrears = (decimal)Session["view_arrears"];
            decimal view_NetPay = (decimal)Session["view_NetPay"];


            string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    // Check if the employee ID already exists in the database
                    string checkQuery = "SELECT COUNT(*) FROM Emp_Salary WHERE Emp_ID = @Emp_ID AND Emp_Month = @Emp_Month AND Emp_Year = @Emp_Year";
                    using (SqlCommand checkCmd = new SqlCommand(checkQuery, connection))
                    {

                        checkCmd.Parameters.AddWithValue("@Emp_ID", empId.Text);
                        checkCmd.Parameters.AddWithValue("@Emp_Month", DateTimeFormatInfo.CurrentInfo.GetMonthName(int.Parse(ddlMonth.SelectedValue)));
                        checkCmd.Parameters.AddWithValue("@Emp_Year", ddlYear.SelectedValue);
                        int existingCount = Convert.ToInt32(checkCmd.ExecuteScalar());

                        if (existingCount == 1)
                        {
                            // Employee ID already exists, display a message to the user
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "showErrorNotification('Salary', 'Employee already exists for selected Month and Year.');", true);
                        }
                        else
                        {
                            string query = "INSERT INTO Emp_Salary (Emp_ID,Emp_Location,Emp_Month, Emp_Year, Emp_Name, CTC_Gross, Hike, CTC_Basic, CTC_HRA, CA, Medical, Others, EPC, TotalPaidGross,ActualBasic,ActualHRA,ActualCA, ActualMedical,Others1,LOP,EPF,ESI,PT,TDS,Advance,Travel,Medical1,TotalDeduction,Arrears,NetPay  ) " +
                                   "VALUES (@Emp_ID,@Emp_Location, @Emp_Month, @Emp_Year, @Emp_Name, @CTC_Gross, @Hike, @CTC_Basic, @CTC_HRA, @CA, @Medical, @Others, @EPC,@TotalPaidGross,@ActualBasic,@ActualHRA,@ActualCA,@ActualMedical,@Others1,@LOP,@EPF,@ESI,@PT,@TDS,@Advance,@Travel,@Medical1,@TotalDeduction,@Arrears,@NetPay)";

                            using (SqlCommand cmd = new SqlCommand(query, connection))
                            {
                                // Set parameter values from the TextBoxes
                                
                                cmd.Parameters.AddWithValue("@Emp_ID", empId.Text);
                                cmd.Parameters.AddWithValue("@Emp_Location", ddlOfficeLocation.SelectedValue);
                                cmd.Parameters.AddWithValue("@Emp_Month", DateTimeFormatInfo.CurrentInfo.GetMonthName(int.Parse(ddlMonth.SelectedValue)));
                                cmd.Parameters.AddWithValue("@Emp_Year", ddlYear.SelectedValue);
                                cmd.Parameters.AddWithValue("@Emp_Name", empName.Text);
                                cmd.Parameters.AddWithValue("@CTC_Gross", ctcGross.Text);
                                cmd.Parameters.AddWithValue("@Hike", hike.Text);
                                cmd.Parameters.AddWithValue("@CTC_Basic", view_ctcBasicValue);
                                cmd.Parameters.AddWithValue("@CTC_HRA", view_ctcHRAValue);
                                cmd.Parameters.AddWithValue("@CA", view_caValue);
                                cmd.Parameters.AddWithValue("@Medical", view_medicalValue);
                                cmd.Parameters.AddWithValue("@Others", view_othersValue);
                                cmd.Parameters.AddWithValue("@EPC", epc.Text);
                                cmd.Parameters.AddWithValue("@TotalPaidGross", view_totalPaidGross);
                                cmd.Parameters.AddWithValue("@ActualBasic", view_actualBasic);
                                cmd.Parameters.AddWithValue("@ActualHRA", view_actualHRA);
                                cmd.Parameters.AddWithValue("@ActualCA", view_actualca);
                                cmd.Parameters.AddWithValue("@ActualMedical", view_actualMedical);
                                cmd.Parameters.AddWithValue("@Others1", view_others1);
                                cmd.Parameters.AddWithValue("@LOP", view_lop);
                                cmd.Parameters.AddWithValue("@EPF", view_EPF);
                                cmd.Parameters.AddWithValue("@ESI", view_ESI);
                                cmd.Parameters.AddWithValue("@PT", view_PT);
                                cmd.Parameters.AddWithValue("@TDS", tds.Text);
                                cmd.Parameters.AddWithValue("@Advance", advance.Text);
                                cmd.Parameters.AddWithValue("@Travel", ta.Text);
                                cmd.Parameters.AddWithValue("@Medical1", view_medical1);
                                cmd.Parameters.AddWithValue("@TotalDeduction", view_totalDeduction);
                                cmd.Parameters.AddWithValue("@Arrears", view_arrears);
                                cmd.Parameters.AddWithValue("@NetPay", view_NetPay);



                               
                                int rowsAffected = cmd.ExecuteNonQuery();

                                if (rowsAffected > 0)
                                {
                                    // Show a success notification using Toastr
                                    ScriptManager.RegisterStartupScript(this, GetType(), "SuccessNotification", "showSuccessNotification('Salary');", true);
                                }
                                else
                                {
                                    // Show an error notification using Toastr
                                    ScriptManager.RegisterStartupScript(this, GetType(), "ErrorNotification", "showErrorNotification('Salary', 'Error adding Salary details.');", true);
                                }
                            }
                        }

                    }
                }
            }
            catch (Exception ex)
            {
                // Show an error notification using Toastr
                ScriptManager.RegisterStartupScript(this, GetType(), "ErrorNotification", $"showErrorNotification('Salary', 'Error adding Salary details: {ex.Message}');", true);
            }
        }
    
        private void ClearSalaryDetailsFields()
        {
            // Clear account details fields here
            empId.Text = "";
            empName.Text = "";
            ctcGross.Text = "";
            hike.Text = "";
            epc.Text = "";
            tds.Text = "";
            advance.Text = "";
            ta.Text = "";
            ctcBasic.Text = "";
            ctcHRA.Text = "";
            ca.Text = "";
            medical.Text = "";
            others.Text = "";
            totalGross.Text = "";
            ActualBasic.Text = "";
            ActualHRA.Text = "";
            actualCA.Text = "";
            ActualMedical.Text = "";
            Others1.Text = "";

            // Clear the labels in the second block
            LOP.Text = "";
            epf.Text = "";
            esi.Text = "";
            pt.Text = "";
            Medical1.Text = "";
            TotalDeduction.Text = "";
            Arrears.Text = "";
            netPay.Text = "";
            ddlMonth.Items.Clear();
            ddlYear.SelectedIndex = 0;
        }
        protected void CancelSalaryDetails_Click(object sender, EventArgs e)
        {

            ClearSalaryDetailsFields();

        }
        protected void Salaries_Download_Click(object sender, EventArgs e)
        {
            // Call a method to fetch all salary records from the database and export them as an Excel file.
            ExportSalaryDetailsToExcel();
        }

        private void ExportSalaryDetailsToExcel()
        {
            // Create a DataTable to store the salary details
            DataTable dt = new DataTable();

            // Define the columns of the DataTable
            dt.Columns.Add("Emp_ID");
            dt.Columns.Add("Emp_Location");
            dt.Columns.Add("Emp_Month");
            dt.Columns.Add("Emp_Year");
            dt.Columns.Add("Emp_Name");
            dt.Columns.Add("CTC_Gross");
            dt.Columns.Add("Hike");
            dt.Columns.Add("CTC_Basic");
            dt.Columns.Add("CTC_HRA");
            dt.Columns.Add("CA");
            dt.Columns.Add("Medical");
            dt.Columns.Add("Others");
            dt.Columns.Add("EPC");
            dt.Columns.Add("TotalPaidGross");
            dt.Columns.Add("ActualBasic");
            dt.Columns.Add("ActualHRA");
            dt.Columns.Add("ActualCA");
            dt.Columns.Add("ActualMedical");
            dt.Columns.Add("Others1");
            dt.Columns.Add("LOP");
            dt.Columns.Add("EPF");
            dt.Columns.Add("ESI");
            dt.Columns.Add("PT");
            dt.Columns.Add("TDS");
            dt.Columns.Add("Advance");
            dt.Columns.Add("Travel");
            dt.Columns.Add("Medical1");
            dt.Columns.Add("TotalDeduction");
            dt.Columns.Add("Arrears");
            dt.Columns.Add("NetPay");

            // Fetch all salary records from the database
            string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "SELECT * FROM Emp_Salary ORDER BY Emp_ID";

                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }

            // Create an Excel package and add the DataTable to it
            using (ExcelPackage excelPackage = new ExcelPackage())
            {
                ExcelWorksheet worksheet = excelPackage.Workbook.Worksheets.Add("SalaryDetails");
                worksheet.Cells["A1"].LoadFromDataTable(dt, true);

                // Save the Excel package to a file or stream
                string fileName = "SalaryDetails.xlsx";
                Response.Clear();
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", "attachment; filename=" + fileName);
                Response.BinaryWrite(excelPackage.GetAsByteArray());
                Response.End();
            }
        }


    }
}