using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Drawing;
using System.Runtime.InteropServices;
using OfficeOpenXml;
using System.IO;



namespace Payroll_Mangmt_sys
{
    public partial class AllEmployees : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["SelectedLocation"] == null)
            {
                // Session variable is null, indicating session expiration
                ShowSessionExpiredAlert();
            }
            else
            {
                BindEmployeeDetails();
            }
            
        }
        private void ShowSessionExpiredAlert()
        {
            // Display an alert message to the user
            string script = "alert('Session expired. You will be logged out.'); window.location.href = 'login1.aspx';";
            ScriptManager.RegisterStartupScript(this, GetType(), "SessionExpiredScript", script, true);

            // Abandon the session and log the user out
            Session.Abandon();
        }
        protected void btnAddEmployee_Click(object sender, EventArgs e)
        {
            // Redirect to the Add Employee page (change "AddEmployee.aspx" to the actual page URL)
            Response.Redirect("AddEmployee.aspx");
        }

        private void BindEmployeeDetails()
        {
            // Connection string for your SQL Server database
            
            string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT Emp_ID, Emp_Name, Mobile, Email_ID, Designation, Bloodgroup, City, CTC_Gross, Date_Of_Joining FROM addemployee_personal";

                // Check if the selected location is not "Medchal"
                if (Session["SelectedLocation"].ToString() != "Medchal")
                {
                    // If it's not "Medchal," add a condition to filter by location
                    query += " WHERE Emp_Location = @Emp_Location";
                }

                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    cmd.Parameters.AddWithValue("@Emp_Location", Session["SelectedLocation"]);
                    try
                    {
                        connection.Open();

                        // Create a DataTable to hold the retrieved data
                        DataTable dt = new DataTable();

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            // Load data into the DataTable
                            dt.Load(reader);
                        }

                        // Bind the DataTable to the GridView
                        GridView1.DataSource = dt;
                        GridView1.DataBind();



                        foreach (GridViewRow row in GridView1.Rows)
                        {
                            if (row.RowType == DataControlRowType.DataRow)
                            {
                                // Find the HyperLink control in the row
                                HyperLink empIDLink = row.FindControl("lnkEmployeeID") as HyperLink;

                                if (empIDLink != null)
                                {
                                    // Get the Employee ID from the row data
                                    string employeeID = GridView1.DataKeys[row.RowIndex]["Emp_ID"].ToString();

                                    // Set the navigate URL to the Update_details.aspx page with the EmployeeID parameter
                                    empIDLink.NavigateUrl = $"Update_details.aspx?EmployeeID={employeeID}";
                                }
                            }
                        }
                    }
                    catch (Exception ex)
                    {

                        throw ex;
                    }

                }

            }
        }
        protected void btnUploadData_Click(object sender, EventArgs e)
        {
            if (fileUpload.HasFile)
            {
                try
                {
                    // Get the uploaded file
                    HttpPostedFile file = fileUpload.PostedFile;

                    // Parse the Excel file using the EPPlus library
                    using (var package = new ExcelPackage(file.InputStream))
                    {
                        var worksheet = package.Workbook.Worksheets[0];
                        int rowCount = worksheet.Dimension.Rows;

                        // Define your connection string
                        string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

                        using (SqlConnection connection = new SqlConnection(connectionString))
                        {
                            connection.Open();

                            // Iterate through rows and insert data into the database
                            for (int row = 2; row <= rowCount; row++)
                            {

                                string nextEmpID = worksheet.Cells[row + 1, 1].Text;
                                if (string.IsNullOrEmpty(nextEmpID))
                                {
                                    // Stop the iteration if Emp_ID is null or empty for the next row
                                    break;
                                }

                                string empID = worksheet.Cells[row, 1].Text;
                                string empbio = worksheet.Cells[row, 2].Text;
                                string empLocation = worksheet.Cells[row, 3].Text;
                                string empName = worksheet.Cells[row, 4].Text;
                                string designation = worksheet.Cells[row, 5].Text;
                                decimal ctcGross = decimal.Parse(worksheet.Cells[row, 6].Text);
                                string ctcbasic = worksheet.Cells[row,7].Text;
                                string mobile = worksheet.Cells[row, 8].Text;
                                string email = worksheet.Cells[row, 9].Text;
                                DateTime dob = DateTime.Parse(worksheet.Cells[row, 10].Text);
                                int age = int.Parse(worksheet.Cells[row, 11].Text);
                                string fatherName = worksheet.Cells[row, 12].Text;
                                string gender = worksheet.Cells[row, 13].Text;
                                string city = worksheet.Cells[row, 14].Text;
                                int pincode = int.Parse(worksheet.Cells[row, 15].Text);
                                string address = worksheet.Cells[row, 16].Text;
                                string bloodgroup = worksheet.Cells[row, 17].Text;
                                string pfNumber = worksheet.Cells[row, 18].Text;
                                string esiNumber = worksheet.Cells[row, 19].Text;
                                string pan = worksheet.Cells[row, 20].Text;
                                string aadhar = worksheet.Cells[row, 21].Text;
                                DateTime dateOfJoining = DateTime.Parse(worksheet.Cells[row, 22].Text);
                                string emptype = worksheet.Cells[row, 23].Text;

                                // Define your INSERT SQL query
                                string insertQuery = "INSERT INTO addemployee_personal (Emp_ID,Emp_Bio, Emp_Location, Emp_Name, Designation, CTC_Gross,CTC_Basic, Mobile, Email_ID, DOB, Age, Father_Name, Gender, City, Pincode, Address, Bloodgroup, PF_Number, ESI_Number,PAN, Aadhar_Number, Date_Of_Joining, Emp_Type) " +
                                    "VALUES (@EmpID,@Emp_Bio, @EmpLocation, @EmpName, @Designation, @CTCGross,@CTC_Basic, @Mobile, @Email, @DOB, @Age, @FatherName, @Gender, @City, @Pincode, @Address, @Bloodgroup, @PFNumber, @ESINumber,@PAN, @Aadhar_Number, @DateOfJoining, @Emp_Type)";
                                // Add parameters for the remaining columns in your query

                                using (SqlCommand cmd = new SqlCommand(insertQuery, connection))
                                {
                                    // Set parameter values for the remaining columns
                                    cmd.Parameters.AddWithValue("@EmpID", empID);
                                    cmd.Parameters.AddWithValue("@Emp_Bio", empbio);
                                    cmd.Parameters.AddWithValue("@EmpLocation", empLocation);
                                    cmd.Parameters.AddWithValue("@EmpName", empName);
                                    cmd.Parameters.AddWithValue("@Designation", designation);
                                    cmd.Parameters.AddWithValue("@CTCGross", ctcGross);
                                    cmd.Parameters.AddWithValue("@CTC_Basic", ctcbasic);
                                    cmd.Parameters.AddWithValue("@Mobile", mobile);
                                    cmd.Parameters.AddWithValue("@Email", email);
                                    cmd.Parameters.AddWithValue("@DOB", dob);
                                    cmd.Parameters.AddWithValue("@Age", age);
                                    cmd.Parameters.AddWithValue("@FatherName", fatherName);
                                    cmd.Parameters.AddWithValue("@Gender", gender);
                                    cmd.Parameters.AddWithValue("@City", city);
                                    cmd.Parameters.AddWithValue("@Pincode", pincode);
                                    cmd.Parameters.AddWithValue("@Address", address);
                                    cmd.Parameters.AddWithValue("@Bloodgroup", bloodgroup);
                                    cmd.Parameters.AddWithValue("@PFNumber", pfNumber);
                                    cmd.Parameters.AddWithValue("@ESINumber", esiNumber);
                                    cmd.Parameters.AddWithValue("@PAN", pan);
                                    cmd.Parameters.AddWithValue("@Aadhar_Number", aadhar);
                                    cmd.Parameters.AddWithValue("@DateOfJoining", dateOfJoining);
                                    cmd.Parameters.AddWithValue("@Emp_Type", emptype);

                                    // Execute the SQL command
                                    cmd.ExecuteNonQuery();
                                }

                            }
                        }

                        // Show a success notification
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "Success", "showSuccessNotification('Excel file uploaded and data imported successfully');", true);
                    }
                }
                catch (Exception ex)
                {
                    // Handle exceptions and show an error notification
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "Error", $"showErrorNotification('Error: {ex.Message}');", true);

                }
            }
            else
            {
                // Show a warning notification
                Page.ClientScript.RegisterStartupScript(this.GetType(), "WarningNotification", "showErrorNotification('Please select an Excel file to upload.');", true);
            }
        }





        protected void btnExportToExcel_Click(object sender, EventArgs e)
        {
    try
    {
        // Create a new Excel package
        using (ExcelPackage package = new ExcelPackage())
        {
            // Create a worksheet
            ExcelWorksheet worksheet = package.Workbook.Worksheets.Add("EmployeeDetails");

            // Add the header row to the worksheet
            int columnIndex = 1;
            foreach (DataControlFieldHeaderCell headerCell in GridView1.HeaderRow.Cells)
            {
                worksheet.Cells[1, columnIndex].Value = headerCell.Text;
                columnIndex++;
            }

            // Add the data rows to the worksheet
            int rowIndex = 2;
            foreach (GridViewRow row in GridView1.Rows)
            {
                columnIndex = 1;
                foreach (TableCell cell in row.Cells)
                {
                    // Use the HttpUtility.HtmlDecode method to decode HTML-encoded characters
                    worksheet.Cells[rowIndex, columnIndex].Value = HttpUtility.HtmlDecode(cell.Text);
                    columnIndex++;
                }
                rowIndex++;
            }

            // Save the Excel package to a memory stream
            using (MemoryStream memoryStream = new MemoryStream())
            {
                package.SaveAs(memoryStream);
                memoryStream.Seek(0, SeekOrigin.Begin);

                // Prepare the response for download
                Response.Clear();
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", "attachment;  filename=EmployeeDetails.xlsx");
                Response.BinaryWrite(memoryStream.ToArray());
                Response.End();
            }
        }
    }
    catch (Exception ex)
    {
        // Handle any exceptions here
        // You can log the error or display an error message
    }
}






    }
}




