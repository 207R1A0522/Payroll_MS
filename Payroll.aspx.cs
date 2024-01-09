using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ClosedXML.Excel;

namespace Payroll_Mangmt_sys
{
    public partial class Payroll : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Your existing Page_Load logic

                // Register the event handler for the export button click
                btnExportExcel.Click += new EventHandler(btnExportExcel_Click);
                ddlSelectOption.SelectedIndexChanged += new EventHandler(ddlSelectOption_SelectedIndexChanged);
            }
        }
        protected void btnExportExcel_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable dt = null; // Retrieve the data to export
                string selectedPayrollType = ddlPayrollType.SelectedValue;

                if (selectedPayrollType == "StaffPayroll")
                {
                    dt = GetStaffPayrollData();
                }
                else if (selectedPayrollType == "TempEmployeePayroll")
                {
                    dt = GetTempEmployeePayrollData();
                }



                if (dt != null && dt.Rows.Count > 0)
                {
                    // Set the response type and headers for Excel file
                    Response.Clear();
                    Response.Buffer = true;
                    Response.Charset = "";
                    Response.ContentType = "application/vnd.ms-excel";
                    Response.AddHeader("content-disposition", "attachment;filename=PayrollData.xlsx");

                    // Create a new Excel workbook and worksheet
                    using (var workbook = new XLWorkbook())
                    {
                        var worksheet = workbook.Worksheets.Add("PayrollData");

                        // Add column headers
                        for (int i = 1; i <= dt.Columns.Count; i++)
                        {
                            worksheet.Cell(1, i).Value = dt.Columns[i - 1].ColumnName;
                        }

                        // Add data rows
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            for (int j = 0; j < dt.Columns.Count; j++)
                            {
                                worksheet.Cell(i + 2, j + 1).Value = dt.Rows[i][j].ToString();
                            }
                        }

                        // Save the Excel file to the response stream
                        using (MemoryStream memoryStream = new MemoryStream())
                        {
                            workbook.SaveAs(memoryStream);
                            memoryStream.WriteTo(Response.OutputStream);
                            Response.Flush();
                            Response.End();
                        }
                    }
                }
                else
                {
                    // Handle case where there is no data to export
                    // You can show a message or take appropriate action
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "noDataNotification", "showErrorNotification('No data available for export.');", true);
                }
            }
            catch (Exception ex)
            {
                HandleException(ex);
            }
        }

        protected void ddlPayrollType_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                string selectedPayrollType = ddlPayrollType.SelectedValue;

                if (!string.IsNullOrEmpty(selectedPayrollType))
                {
                    // Set the visibility of the GridView based on the selected payroll type
                    gvPayrollDetails.Visible = true;

                    // Populate the date DropDownList based on the selected payroll type
                    if (selectedPayrollType == "StaffPayroll")
                    {
                        BindAttendanceDates("Attendance_table_f");
                    }
                    else if (selectedPayrollType == "TempEmployeePayroll")
                    {
                        BindAttendanceDates("Attendance_table_c");
                    }

                    // Show or hide the Export button based on the selected payroll type
                    btnExportExcel.Visible = selectedPayrollType == "TempEmployeePayroll";
                }
                else
                {
                    // If no payroll type is selected, hide the GridView and date DropDownList
                    gvPayrollDetails.Visible = false;
                    ddlSelectOption.Visible = false;
                }
            }
            catch (Exception ex)
            {
                HandleException(ex);
            }
        }

        private void BindAttendanceDates(string tableName)
        {
            try
            {
                // Fetch unique dates from the specified table
                List<string> uniqueDates = GetUniqueDates(tableName);

                // Bind the date DropDownList with the retrieved unique dates
                ddlSelectOption.DataSource = uniqueDates;
                ddlSelectOption.DataBind();

                // Show the date DropDownList
                ddlSelectOption.Visible = true;
            }
            catch (Exception ex)
            {
                HandleException(ex);
            }
        }

        private List<string> GetUniqueDates(string tableName)
        {
            List<string> uniqueDates = new List<string>();
            try
            {
                // TODO: Replace the connection string with your actual database connection string
                string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    // Replace "YourDateColumnName" with the actual name of the date column in the specified table
                    string query = $"SELECT DISTINCT Attendance_to FROM {tableName}";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            uniqueDates.Add("Select");
                            while (reader.Read())
                            {
                                // Assuming the date column is of DateTime type in the database
                                DateTime dateValue = reader.GetDateTime(0);

                                // Format the date to display without the time part
                                string formattedDate = dateValue.ToString("dd-MM-yyyy");

                                uniqueDates.Add(formattedDate);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                HandleException(ex);
            }

            return uniqueDates;
        }


        private void BindTempEmployeePayrollData()
        {
            try
            {
                if (ddlSelectOption.SelectedIndex > 0)
                {
                    // TODO: Fetch data from the database for Staff Payroll based on the selected date
                    // Replace the following example data with actual data retrieval logic

                    DataTable tempPayrollData = GetTempEmployeePayrollData();

                    // Bind the GridView with the retrieved data
                    gvPayrollDetails.DataSource = tempPayrollData;
                    gvPayrollDetails.DataBind();
                    btnExportExcel.Visible = tempPayrollData.Rows.Count > 0;
                }
                else
                {
                    // If "Select" is chosen, clear the GridView
                    gvPayrollDetails.DataSource = null;
                    gvPayrollDetails.DataBind();
                    btnExportExcel.Visible = false;
                }
            }
            catch (Exception ex)
            {
                HandleException(ex);
            }
        }

        private DataTable GetTempEmployeePayrollData()
        {
            DataTable dataTable = new DataTable();
            dataTable.Columns.Add("EmployeeID", typeof(string));
            dataTable.Columns.Add("EmployeeName", typeof(string));
            dataTable.Columns.Add("BankName", typeof(string));
            dataTable.Columns.Add("BankAccountNumber", typeof(string));
            dataTable.Columns.Add("IFSCCode", typeof(string));
            dataTable.Columns.Add("NetPay", typeof(decimal));
            dataTable.Columns.Add("Message", typeof(string));

            try
            {
                // TODO: Replace the connection string with your actual database connection string
                string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    DateTime selectedDate = DateTime.ParseExact(ddlSelectOption.SelectedValue, "dd-MM-yyyy", null);
                    string selectedLocation = Session["SelectedLocation"].ToString();

                    string query = "SELECT c.Emp_ID, c.Emp_Name, p.Bank_Name, p.Account_Number, p.IFSC_Code, c.Net_Pay " +
                                   "FROM Attendance_table_c c " +
                                   "LEFT JOIN addemployee_account p ON p.Emp_ID = c.Emp_ID " +
                                   "WHERE CONVERT(date, c.Attendance_to) = @SelectedDate " +
                                   "AND c.Emp_Location = @SelectedLocation ";


                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.Add("@SelectedDate", SqlDbType.Date).Value = selectedDate;
                        command.Parameters.AddWithValue("@SelectedLocation", selectedLocation);

                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                string employeeID = reader["Emp_ID"].ToString();
                                string employeeName = reader["Emp_Name"].ToString();
                                string bankName = reader["Bank_Name"].ToString();
                                string bankAccountNumber = reader["Account_Number"].ToString();
                                string ifscCode = reader["IFSC_Code"].ToString();
                                decimal netPay = Convert.ToDecimal(reader["Net_Pay"]);
                                if (string.IsNullOrEmpty(bankName) || string.IsNullOrEmpty(bankAccountNumber) || string.IsNullOrEmpty(ifscCode) || netPay == 0)
                                {
                                    // Add a message if any related data is missing
                                    string message = "Employee data incomplete in related tables.";
                                    dataTable.Rows.Add(employeeID, employeeName, bankName, bankAccountNumber, ifscCode, netPay, message);
                                }
                                else
                                {
                                    dataTable.Rows.Add(employeeID, employeeName, bankName, bankAccountNumber, ifscCode, netPay, string.Empty);
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {

                HandleException(ex);
            }

            return dataTable;
        }


        protected void ddlSelectOption_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                string selectedPayrollType = ddlPayrollType.SelectedValue;

                if (!string.IsNullOrEmpty(selectedPayrollType))
                {
                    // Determine the selected payroll type and call the appropriate method
                    if (selectedPayrollType == "StaffPayroll")
                    {
                        BindStaffPayrollData();
                    }
                    else if (selectedPayrollType == "TempEmployeePayroll")
                    {
                        BindTempEmployeePayrollData();
                    }
                }
            }
            catch (Exception ex)
            {
                HandleException(ex);
            }
        }


        private void BindStaffPayrollData()
        {
            try
            {
                if (ddlSelectOption.SelectedIndex > 0)
                {
                    // TODO: Fetch data from the database for Staff Payroll based on the selected date
                    // Replace the following example data with actual data retrieval logic

                    DataTable staffPayrollData = GetStaffPayrollData();

                    // Bind the GridView with the retrieved data
                    gvPayrollDetails.DataSource = staffPayrollData;
                    gvPayrollDetails.DataBind();
                    btnExportExcel.Visible = staffPayrollData.Rows.Count > 0;
                }
                else
                {
                    // If "Select" is chosen, clear the GridView
                    gvPayrollDetails.DataSource = null;
                    gvPayrollDetails.DataBind();
                    btnExportExcel.Visible = false;
                }
            }
            catch (Exception ex)
            {
                HandleException(ex);
            }
        }



        private DataTable GetStaffPayrollData()
        {
            DataTable dataTable = new DataTable();
            dataTable.Columns.Add("EmployeeID", typeof(string));
            dataTable.Columns.Add("EmployeeName", typeof(string));
            dataTable.Columns.Add("BankName", typeof(string));
            dataTable.Columns.Add("BankAccountNumber", typeof(string));
            dataTable.Columns.Add("IFSCCode", typeof(string));
            dataTable.Columns.Add("NetPay", typeof(decimal));
            dataTable.Columns.Add("Message", typeof(string));

            try
            {
                // TODO: Replace the connection string with your actual database connection string
                string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    DateTime selectedDate = DateTime.ParseExact(ddlSelectOption.SelectedValue, "dd-MM-yyyy", null);
                    string selectedLocation = Session["SelectedLocation"].ToString();

                    string query = "SELECT a.Emp_ID, a.Emp_Name, c.Bank_Name, c.Account_Number, c.IFSC_Code, s.NetPay " +
                                   "FROM Attendance_table_f a " +
                                   "LEFT JOIN addemployee_personal p ON a.Emp_ID = p.Emp_Bio " +
                                   "LEFT JOIN addemployee_account c ON p.Emp_ID = c.Emp_ID " +
                                   "LEFT JOIN Emp_Salary s ON p.Emp_ID = s.Emp_ID " +
                                   "WHERE CONVERT(date, a.Attendance_to) = @SelectedDate " +
                                   "AND a.Emp_Location = @SelectedLocation " +
                                   "AND CAST(MONTH(a.Attendance_to) AS NVARCHAR(2)) = s.Emp_Month " +
                                   "AND CAST(YEAR(a.Attendance_to) AS NVARCHAR(4)) = s.Emp_Year";
                    

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.Add("@SelectedDate", SqlDbType.Date).Value = selectedDate;
                        command.Parameters.AddWithValue("@SelectedLocation", selectedLocation);

                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                string employeeID = reader["Emp_ID"].ToString();
                                string employeeName = reader["Emp_Name"].ToString();
                                string bankName = reader["Bank_Name"].ToString();
                                string bankAccountNumber = reader["Account_Number"].ToString();
                                string ifscCode = reader["IFSC_Code"].ToString();
                                decimal netPay = Convert.ToDecimal(reader["NetPay"]);
                                if (string.IsNullOrEmpty(bankName) || string.IsNullOrEmpty(bankAccountNumber) || string.IsNullOrEmpty(ifscCode) || netPay==0)
                                {
                                    // Add a message if any related data is missing
                                    string message = "Employee data incomplete in related tables.";
                                    dataTable.Rows.Add(employeeID, employeeName, bankName, bankAccountNumber, ifscCode, netPay, message);
                                }
                                else
                                {
                                    dataTable.Rows.Add(employeeID, employeeName, bankName, bankAccountNumber, ifscCode, netPay, string.Empty);
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                
                HandleException(ex);
            }

            return dataTable;
        }


        private void HandleException(Exception ex)
        {
            // Handle the exception (e.g., log it)
            // You may also want to inform the user about the error
            Page.ClientScript.RegisterStartupScript(this.GetType(), "error", $"showErrorNotification('Error: {ex.Message}');", true);
        }


    }
}