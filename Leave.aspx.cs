using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Collections.Generic;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web;
using System.Web.UI;
using System.IO;
using OfficeOpenXml;
using System.Web.Services.Description;
using System.Xml.Linq;
using System.Drawing.Imaging;
using System.Windows.Media.TextFormatting;

namespace Payroll_Mangmt_sys
{
    public partial class Leave : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        private bool IsAttendanceToExists(string empLocation, DateTime attendanceToDate)
        {
            // Replace the following code with your actual database query logic
            string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM Attendance_table_f WHERE Emp_Location = @Emp_Location AND Attendance_to = @Attendance_to";

                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    cmd.Parameters.AddWithValue("@Emp_Location", empLocation);
                    cmd.Parameters.AddWithValue("@Attendance_to", attendanceToDate);
                    connection.Open();

                    int count = (int)cmd.ExecuteScalar();

                    // If count is greater than 0, it means the date already exists
                    return count > 0;
                }
            }
        }

        protected void UploadButton_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
            {
                try
                {
                    string fileName = Path.GetFileName(FileUpload1.FileName);
                    string filePath = Path.Combine(Server.MapPath("~"), fileName);

                    // Save the file to the server
                    FileUpload1.SaveAs(filePath);

                    // Read data from the Excel file using EPPlus
                    using (ExcelPackage package = new ExcelPackage(new FileInfo(filePath)))
                    {
                        // Assuming the data starts from B4 in the Excel sheet
                        ExcelWorksheet worksheet = package.Workbook.Worksheets[0];
                        int startRow = 4;

                        string empLocation = worksheet.Cells[2, 1].Value?.ToString() ?? "";
                        string[] dateFormats = { "dd-MM-yyyy", "yyyy-MM-dd"};

                        // Assuming 'attendanceFromDate' and 'attendanceToDate' are DateTime cells
                        DateTime attendanceFromDate = worksheet.Cells[2, 2].GetValue<DateTime>();
                        DateTime attendanceToDate = worksheet.Cells[2, 3].GetValue<DateTime>();
                        if (!string.IsNullOrEmpty(empLocation) && Session["SelectedLocation"] != null)
                        {
                            string sessionLocation = Session["SelectedLocation"].ToString();

                            if (!empLocation.Equals(sessionLocation, StringComparison.OrdinalIgnoreCase))
                            {
                                // Display toaster notification for location mismatch
                                string errorMessage = $"Location in the Excel file ({empLocation}) does not match the selected location ({Session["SelectedLocation"]}).";
                                ScriptManager.RegisterStartupScript(this, GetType(), "error", $"showErrorNotification('{errorMessage}');", true);
                                return; // Exit the method
                            }
                        }
                        else
                        {
                            if (IsAttendanceToExists(empLocation, attendanceToDate))
                            {
                                // Display toaster notification
                                ScriptManager.RegisterStartupScript(this, GetType(), "error", "showErrorNotification('Biometric data for this location and month already exists.');", true);
                                return; // Exit the method
                            }
                            else
                            {
                                int empCodeColumnIndex = FindColumnIndex(worksheet, "Emp. Code");
                                int empNameColumnIndex = FindColumnIndex(worksheet, "Name");
                                int halfDayColumnIndex = FindColumnIndex(worksheet, "1/2 day");
                                int presentColumnIndex = FindColumnIndex(worksheet, "P");
                                int absentColumnIndex = FindColumnIndex(worksheet, "A");
                                int leavesColumnIndex = FindColumnIndex(worksheet, "L");
                                int holidaysColumnIndex = FindColumnIndex(worksheet, "H");
                                int hpColumnIndex = FindColumnIndex(worksheet, "HP");
                                int woColumnIndex = FindColumnIndex(worksheet, "WO");
                                int wopColumnIndex = FindColumnIndex(worksheet, "WOP");
                                int paidDaysColumnIndex = FindColumnIndex(worksheet, "Paid Days");

                                while (!string.IsNullOrEmpty(worksheet.Cells[startRow, empCodeColumnIndex].Text))
                                {
                                    string empCode = worksheet.Cells[startRow, empCodeColumnIndex].Value.ToString();
                                    string empName = worksheet.Cells[startRow, empNameColumnIndex].Value.ToString();
                                    string halfDay = worksheet.Cells[startRow, halfDayColumnIndex].Value?.ToString() ?? "";
                                    string present = worksheet.Cells[startRow, presentColumnIndex].Value?.ToString() ?? "";
                                    string absent = worksheet.Cells[startRow, absentColumnIndex].Value?.ToString() ?? "";
                                    string leaves = worksheet.Cells[startRow, leavesColumnIndex].Value?.ToString() ?? "";
                                    string holidays = worksheet.Cells[startRow, holidaysColumnIndex].Value?.ToString() ?? "";
                                    string hp = worksheet.Cells[startRow, hpColumnIndex].Value?.ToString() ?? "";
                                    string wo = worksheet.Cells[startRow, woColumnIndex].Value?.ToString() ?? "";
                                    string wop = worksheet.Cells[startRow, wopColumnIndex].Value?.ToString() ?? "";
                                    string paidDays = worksheet.Cells[startRow, paidDaysColumnIndex].Value?.ToString() ?? "";

                                    // Save the data to the database
                                    SaveToDatabase(empCode, empName, empLocation, attendanceFromDate, attendanceToDate, halfDay, present, absent, leaves, holidays, hp, wo, wop, paidDays);

                                    startRow++;
                                }
                                ScriptManager.RegisterStartupScript(this, GetType(), "success", "showSuccessNotification('File uploaded and data saved successfully!');", true);
                            }
                        }
                    }

                   
                   
                }
                catch (Exception ex)
                {
                    // Display error notification
                    ScriptManager.RegisterStartupScript(this, GetType(), "error", $"showErrorNotification('{ex.Message.Replace("'", "\\'")}');", true);
                }
            }
            else
            {
                // Display error notification if no file is selected
                ScriptManager.RegisterStartupScript(this, GetType(), "error", "showErrorNotification('Please select a file.');", true);
            }
        }

        private int FindColumnIndex(ExcelWorksheet worksheet, string columnName)
        {
            int columnCount = worksheet.Dimension.Columns;
            for (int i = 1; i <= columnCount; i++)
            {
                if (worksheet.Cells[3, i].Text.Equals(columnName, StringComparison.OrdinalIgnoreCase))
                {
                    return i;
                }
            }
            // Handle the case where the column name is not found
            throw new InvalidOperationException($"Column '{columnName}' not found in the worksheet.");
        }
        private void SaveToDatabase(string empCode, string empName, string empLocation, DateTime attendanceFromDate, DateTime attendanceToDate, string halfDay, string present, string absent, string leaves, string holidays, string hp, string wo, string wop, string paidDays)
        {

            string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    string query = "INSERT INTO Attendance_table_f(Emp_ID, Emp_Name, Emp_Location, Attendance_from, Attendance_to, Half_day, Present_days, Absent_days, Leaves, Holidays, HP, WO, WOP, Paid_Days) " +
                                       "VALUES (@Emp_ID, @Emp_Name, @Emp_Location, @Attendance_from, @Attendance_to, @Half_day, @Present_days, @Absent_days, @Leaves, @Holidays, @HP, @WO, @WOP, @Paid_Days)";

                            using (SqlCommand cmd = new SqlCommand(query, connection))
                            {
                                // Set parameter values from the TextBoxes
                                cmd.Parameters.AddWithValue("@Emp_ID", empCode);
                                cmd.Parameters.AddWithValue("@Emp_Name", empName);
                                cmd.Parameters.AddWithValue("@Emp_Location", empLocation);
                                cmd.Parameters.AddWithValue("@Attendance_from", attendanceFromDate);
                                cmd.Parameters.AddWithValue("@Attendance_to", attendanceToDate);
                                cmd.Parameters.AddWithValue("@Half_day", halfDay);
                                cmd.Parameters.AddWithValue("@Present_days", present);
                                cmd.Parameters.AddWithValue("@Absent_days", absent);
                                cmd.Parameters.AddWithValue("@Leaves", leaves);
                                cmd.Parameters.AddWithValue("@Holidays", holidays);
                                cmd.Parameters.AddWithValue("@HP", hp);
                                cmd.Parameters.AddWithValue("@WO", wo);
                                cmd.Parameters.AddWithValue("@WOP", wop);
                                cmd.Parameters.AddWithValue("@Paid_Days", paidDays);
                                int rowsAffected = cmd.ExecuteNonQuery();

                                if (rowsAffected > 0)
                                {
                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "success", "showSuccessNotification('Biometric details updated successfully');", true);
                                    
                                }
                                else
                                {
                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "showErrorNotification('Biometric');", true);
                                }

                            }
                        }

            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "error", $"showErrorNotification('{ex.Message.Replace("'", "\\'")}');", true);
            }

           

        }

        private bool IsAttendanceToExists2(string empLocation, DateTime attendanceToDate)
        {
            // Replace the following code with your actual database query logic
            string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM Attendance_table_c WHERE Emp_Location = @Emp_Location AND Attendance_to = @Attendance_to";

                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    cmd.Parameters.AddWithValue("@Emp_Location", empLocation);
                    cmd.Parameters.AddWithValue("@Attendance_to", attendanceToDate);
                    connection.Open();

                    int count = (int)cmd.ExecuteScalar();

                    // If count is greater than 0, it means the date already exists
                    return count > 0;
                }
            }
        }
        protected void UploadButton_Click2(object sender, EventArgs e)
        {
            if (FileUpload2.HasFile)
            {
                try
                {
                    string fileName = Path.GetFileName(FileUpload2.FileName);
                    string filePath = Path.Combine(Server.MapPath("~"), fileName);

                    // Save the file to the server
                    FileUpload2.SaveAs(filePath);

                    // Read data from the Excel file using EPPlus
                    using (ExcelPackage package = new ExcelPackage(new FileInfo(filePath)))
                    {
                        // Assuming the data starts from B4 in the Excel sheet
                        ExcelWorksheet worksheet = package.Workbook.Worksheets[0];
                        int startRow = 4;

                        string empLocation = worksheet.Cells[2, 1].Value?.ToString() ?? "";
                        string[] dateFormats = { "dd-MM-yyyy", "yyyy-MM-dd" };

                        // Assuming 'attendanceFromDate' and 'attendanceToDate' are DateTime cells
                        DateTime attendanceFromDate = worksheet.Cells[2, 2].GetValue<DateTime>();
                        DateTime attendanceToDate = worksheet.Cells[2, 3].GetValue<DateTime>();
                        if (!string.IsNullOrEmpty(empLocation) && Session["SelectedLocation"] != null)
                        {
                            string sessionLocation = Session["SelectedLocation"].ToString();

                            if (!empLocation.Equals(sessionLocation, StringComparison.OrdinalIgnoreCase))
                            {
                                // Display toaster notification for location mismatch
                                string errorMessage = $"Location in the Excel file ({empLocation}) does not match the selected location ({Session["SelectedLocation"]}).";
                                ScriptManager.RegisterStartupScript(this, GetType(), "error", $"showErrorNotification('{errorMessage}');", true);
                                return; // Exit the method
                            }
                        }
                        else
                        {
                            if (IsAttendanceToExists2(empLocation, attendanceToDate))
                            {
                                // Display toaster notification
                                ScriptManager.RegisterStartupScript(this, GetType(), "error", "showErrorNotification('Biometric data for this location and month already exists.');", true);
                                return; // Exit the method
                            }
                            else
                            {

                                int empCodeColumnIndex = FindColumnIndex2(worksheet, "Bio_No");
                                int empNameColumnIndex = FindColumnIndex2(worksheet, "Name");
                                int wagesColumnIndex = FindColumnIndex2(worksheet, "Wages");
                                int presentColumnIndex = FindColumnIndex2(worksheet, "Total_days");
                                int netpayColumnIndex = FindColumnIndex2(worksheet, "Net_Pay");


                                while (!string.IsNullOrEmpty(worksheet.Cells[startRow, empCodeColumnIndex].Text))
                                {
                                    string empCode = worksheet.Cells[startRow, empCodeColumnIndex].Value.ToString();
                                    string empName = worksheet.Cells[startRow, empNameColumnIndex].Value.ToString();
                                    string wages = worksheet.Cells[startRow, wagesColumnIndex].Value?.ToString() ?? "";
                                    string present = worksheet.Cells[startRow, presentColumnIndex].Value?.ToString() ?? "";
                                    string netpay = worksheet.Cells[startRow, netpayColumnIndex].Value?.ToString() ?? "";

                                    // Save the data to the database
                                    SaveToDatabase2(empCode, empName, empLocation, attendanceFromDate, attendanceToDate, wages, present, netpay);

                                    startRow++;
                                }
                                ScriptManager.RegisterStartupScript(this, GetType(), "success", "showSuccessNotification('File uploaded and data saved successfully!');", true);
                            }
                        }
                    }

                    
                }
                catch (Exception ex)
                {
                    // Display error notification
                    ScriptManager.RegisterStartupScript(this, GetType(), "error", $"showErrorNotification('{ex.Message.Replace("'", "\\'")}');", true);
                }
            }
            else
            {
                // Display error notification if no file is selected
                ScriptManager.RegisterStartupScript(this, GetType(), "error", "showErrorNotification('Please select a file.');", true);
            }
        }

        private int FindColumnIndex2(ExcelWorksheet worksheet, string columnName)
        {
            int columnCount = worksheet.Dimension.Columns;
            for (int i = 1; i <= columnCount; i++)
            {
                if (worksheet.Cells[3, i].Text.Equals(columnName, StringComparison.OrdinalIgnoreCase))
                {
                    return i;
                }
            }
            // Handle the case where the column name is not found
            throw new InvalidOperationException($"Column '{columnName}' not found in the worksheet.");
        }
        private void SaveToDatabase2(string empCode, string empName, string empLocation, DateTime attendanceFromDate, DateTime attendanceToDate, string wages, string present, string netpay)
        {

            string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    string query = "INSERT INTO Attendance_table_c(Emp_ID, Emp_Name, Emp_Location, Attendance_from, Attendance_to, Per_day_Wage, Total_Days, Net_Pay) " +
                                       "VALUES (@Emp_ID, @Emp_Name, @Emp_Location, @Attendance_from, @Attendance_to, @Per_day_Wage, @Total_Days, @Net_Pay)";

                    using (SqlCommand cmd = new SqlCommand(query, connection))
                    {
                        // Set parameter values from the TextBoxes
                        cmd.Parameters.AddWithValue("@Emp_ID", empCode);
                        cmd.Parameters.AddWithValue("@Emp_Name", empName);
                        cmd.Parameters.AddWithValue("@Emp_Location", empLocation);
                        cmd.Parameters.AddWithValue("@Attendance_from", attendanceFromDate);
                        cmd.Parameters.AddWithValue("@Attendance_to", attendanceToDate);
                        cmd.Parameters.AddWithValue("@Per_day_Wage", wages);
                        cmd.Parameters.AddWithValue("@Total_Days", present);
                        cmd.Parameters.AddWithValue("@Net_Pay", netpay);
                        
                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "success", "showSuccessNotification('Biometric details updated successfully');", true);

                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "showErrorNotification('Biometric');", true);
                        }

                    }
                }

            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "error", $"showErrorNotification('{ex.Message.Replace("'", "\\'")}');", true);
            }



        }

    }
}
