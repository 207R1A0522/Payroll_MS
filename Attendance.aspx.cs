using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace Payroll_Mangmt_sys
{
    public partial class Attendance : System.Web.UI.Page
    {
        private decimal defaultHours = 8.00M;
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "DisableCheckBox", "function disableCheckBox(checkBoxId) { document.getElementById(checkBoxId).disabled = true; }", true);
            Page.ClientScript.RegisterStartupScript(this.GetType(), "EnableCheckBox", "function enableCheckBox(checkBoxId) { document.getElementById(checkBoxId).disabled = false; }", true);
            // This code will be called when the page loads initially.
            // It's responsible for binding the GridView based on the selected employee type.

            string selectedEmployeeType = employeeType.SelectedValue;
            if (!IsPostBack)
            {
                if (selectedEmployeeType == "Fulltime")
                {
                    BindFullTimeAttendance();
                }
                else if (selectedEmployeeType == "Contract")
                {
                    BindContractAttendance();
                }
            }
        }
        protected void seasonDropDown_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Handle the season change and update the default hours
            if (seasonDropDown.SelectedValue == "Summer")
            {
                defaultHours = 12.00M; // Update default hours to 12 hours for Summer
            }
            else
            {
                defaultHours = 8.00M; // Update default hours to 8 hours for Winter (or any other season)
            }
        }
        protected void employeeType_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedValue = employeeType.SelectedValue;

            if (selectedValue == "Fulltime")
            {
                // Load and bind data for full-time employees to the fullTimeAttendanceTable
                BindFullTimeAttendance();
            }
            else if (selectedValue == "Contract")
            {
                // Load and bind data for contract employees to the contractAttendanceTable
                BindContractAttendance();
            }

        }


        private void BindFullTimeAttendance()
        {
            DataTable dt = new DataTable();
            try
            {
                string selectedLocation = Session["SelectedLocation"] as string;
                // Assuming you have a connection string in your Web.config file
                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    // Query to fetch data for full-time employees from addemployee_personal table
                    string query = "SELECT Emp_ID, Emp_Name, Designation FROM addemployee_personal WHERE Emp_Type = 'Fulltime'";
                    if (selectedLocation != "Medchal")
                    {
                        query += " AND Emp_Location = @Location";
                    }
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        if (selectedLocation != "Medchal")
                        {
                            command.Parameters.AddWithValue("@Location", selectedLocation);
                        }
                        using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                        {
                            adapter.Fill(dt);
                        }
                    }
                }

                // Add a default "Date" and "Present" column to match the GridView structure
                dt.Columns.Add("Date", typeof(DateTime));
                dt.Columns.Add("IsPresent", typeof(bool));
                dt.Columns.Add("IsAbsent", typeof(bool));

                // Set default values for "Date" and "Present" columns
                foreach (DataRow row in dt.Rows)
                {
                    row["Date"] = DateTime.Now;
                    row["IsPresent"] = false;
                    row["IsAbsent"] = false;
                }

                fullTimeAttendanceTable.DataSource = dt;
                fullTimeAttendanceTable.DataBind();
            }
            catch (Exception ex)
            {
                // Handle the exception here or log it
                // Display an error notification using toastr
                Page.ClientScript.RegisterStartupScript(this.GetType(), "ErrorNotification", $"showErrorNotification('Fulltime Details', '{ex.Message}')", true);
            }

        }

        private void BindContractAttendance()
        {
            DataTable dt = new DataTable();
            try
            {
                string selectedLocation = Session["SelectedLocation"] as string;
                // Assuming you have a connection string in your Web.config file
                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    // Query to fetch data for contract employees from addemployee_personal table
                    string query = "SELECT Emp_ID, Emp_Name, Designation FROM addemployee_personal WHERE Emp_Type = 'Contract'";
                    if (selectedLocation != "Medchal")
                    {
                        query += " AND Emp_Location = @Location";
                    }
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        if (selectedLocation != "Medchal")
                        {
                            command.Parameters.AddWithValue("@Location", selectedLocation);
                        }
                        using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                        {
                            adapter.Fill(dt);
                        }
                    }
                }

                // Add default "Date", "Overtime", and "Present" columns to match the GridView structure
                dt.Columns.Add("Date", typeof(DateTime));
                dt.Columns.Add("Overtime", typeof(decimal));
                dt.Columns.Add("IsPresent", typeof(bool));
                dt.Columns.Add("IsAbsent", typeof(bool));
                dt.Columns.Add("TotalHours", typeof(decimal));
                // Set default values for "Date", "Overtime", and "Present" columns
                foreach (DataRow row in dt.Rows)
                {
                    row["Date"] = DateTime.Now;
                    row["Overtime"] = 0.00M;
                    row["IsPresent"] = false;
                    row["IsAbsent"] = false;
                    row["TotalHours"] = 0M;
                }

                contractAttendanceTable.DataSource = dt;
                contractAttendanceTable.DataBind();
            }
            catch (Exception ex)
            {
                // Handle the exception here or log it
                // Display an error notification using toastr
                Page.ClientScript.RegisterStartupScript(this.GetType(), "ErrorNotification", $"showErrorNotification('Contract Details', '{ex.Message}')", true);
            }
        }

        protected void SaveFullTimeAttendance_Click(object sender, EventArgs e)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    foreach (GridViewRow row in fullTimeAttendanceTable.Rows)
                    {
                        CheckBox PresentCheckBox = (CheckBox)row.FindControl("PresentCheckBox");
                        CheckBox AbsentCheckBox = (CheckBox)row.FindControl("AbsentCheckBox");
                        if (PresentCheckBox != null)
                        {
                            string empID = row.Cells[0].Text;
                            string empName = row.Cells[1].Text;
                            string designation = row.Cells[2].Text;
                            string date = DateTime.ParseExact(row.Cells[3].Text, "dd/MM/yyyy", null).ToString("yyyy-MM-dd");
                            bool isPresent = PresentCheckBox.Checked;
                            bool isAbsent = AbsentCheckBox.Checked;
                            if (!IsRecordExists(connection, "FullTime_Emp_Attendance", empID, date))
                            {
                                using (SqlCommand cmd = new SqlCommand("INSERT INTO FullTime_Emp_Attendance (Emp_ID, Emp_Name, Designation, Date, IsPresent, IsAbsent) VALUES (@Emp_ID, @Emp_Name, @Designation, @Date, @IsPresent, @IsAbsent)", connection))
                                {
                                    cmd.Parameters.AddWithValue("@Emp_ID", empID);
                                    cmd.Parameters.AddWithValue("@Emp_Name", date);
                                    cmd.Parameters.AddWithValue("@Designation", designation);
                                    cmd.Parameters.AddWithValue("@Date", date);
                                    cmd.Parameters.AddWithValue("@IsPresent", isPresent);
                                    cmd.Parameters.AddWithValue("@IsAbsent", isAbsent);
                                    cmd.ExecuteNonQuery();
                                }
                            }
                            else
                            {
                                // Display a message that the record already exists
                                Page.ClientScript.RegisterStartupScript(this.GetType(), "ErrorNotification", "showErrorNotification('Fulltime Attendance', 'Record already exists for Employee ID: " + empID + " and Date: " + date + "')", true);
                            }
                        }
                    }
                }

                // After saving, you may want to rebind the data to the GridView
                BindFullTimeAttendance();
                Page.ClientScript.RegisterStartupScript(this.GetType(), "SuccessNotification", "showSuccessNotification('Fulltime Attendance')", true);
            }
            catch (Exception ex)
            {
                // Display an error notification using toastr
                Page.ClientScript.RegisterStartupScript(this.GetType(), "ErrorNotification", $"showErrorNotification('Fulltime Attendance', '{ex.Message}')", true);
            }
        }

        protected void SaveContractAttendance_Click(object sender, EventArgs e)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    foreach (GridViewRow row in contractAttendanceTable.Rows)
                    {
                        CheckBox PresentCheckBox = (CheckBox)row.FindControl("PresentCheckBox");
                        CheckBox AbsentCheckBox = (CheckBox)row.FindControl("AbsentCheckBox");
                        TextBox OvertimeTextBox = (TextBox)row.FindControl("OvertimeTextBox");
                        if (PresentCheckBox != null)
                        {
                            string empID = row.Cells[0].Text;
                            string empName = row.Cells[1].Text;
                            string designation = row.Cells[2].Text;
                            string date = DateTime.ParseExact(row.Cells[3].Text, "dd/MM/yyyy", null).ToString("yyyy-MM-dd");
                            bool isPresent = PresentCheckBox.Checked;
                            bool isAbsent = AbsentCheckBox.Checked;
                            string overtime = OvertimeTextBox.Text;
                            Label totalHoursLabel = (Label)row.Cells[6].FindControl("TotalHoursLabel");
                            string totalhours = totalHoursLabel.Text;



                            if (!IsRecordExists(connection, "Contract_Emp_Attendance", empID, date))
                            {
                                using (SqlCommand cmd = new SqlCommand("INSERT INTO Contract_Emp_Attendance (Emp_ID, Emp_Name, Designation, Date, IsPresent, IsAbsent, TotalHours, Overtime) VALUES (@EmpID, @Emp_Name, @Designation, @Date, @IsPresent,@IsAbsent, @TotalHours, @Overtime)", connection))
                                {
                                    cmd.Parameters.AddWithValue("@EmpID", empID);
                                    cmd.Parameters.AddWithValue("@Emp_Name", empName);
                                    cmd.Parameters.AddWithValue("@Designation", designation);
                                    cmd.Parameters.AddWithValue("@Date", date);
                                    cmd.Parameters.AddWithValue("@IsPresent", isPresent);
                                    cmd.Parameters.AddWithValue("@IsAbsent", isAbsent);
                                    cmd.Parameters.AddWithValue("@TotalHours", totalhours);
                                    cmd.Parameters.AddWithValue("@Overtime", overtime);
                                    cmd.ExecuteNonQuery();
                                }
                            }
                            else
                            {
                                // Display a message that the record already exists
                                Page.ClientScript.RegisterStartupScript(this.GetType(), "ErrorNotification", "showErrorNotification('Contract Attendance', 'Record already exists for Employee ID: " + empID + " and Date: " + date + "')", true);
                            }
                        }
                    }
                }

                // After saving, you may want to rebind the data to the GridView
                BindContractAttendance();
                Page.ClientScript.RegisterStartupScript(this.GetType(), "SuccessNotification", "showSuccessNotification('Contract Attendance')", true);
            }

            catch (Exception ex)
            {
                // Display an error notification using toastr
                Page.ClientScript.RegisterStartupScript(this.GetType(), "ErrorNotification", $"showErrorNotification('Contract Attendance', '{ex.Message}')", true);
            }
        }
        protected void OvertimeTextBox_TextChanged(object sender, EventArgs e)
        {
            TextBox overtimeTextBox = (TextBox)sender;
            GridViewRow gridViewRow = (GridViewRow)overtimeTextBox.NamingContainer;
            Label totalHoursLabel = (Label)gridViewRow.FindControl("TotalHoursLabel");
            CheckBox presentCheckBox = (CheckBox)gridViewRow.FindControl("PresentCheckBox");

            if (decimal.TryParse(overtimeTextBox.Text, out decimal overtime))
            {
                decimal updatedHours = (seasonDropDown.SelectedValue == "Summer") ? 12.00M : 8.00M;
                // Calculate total hours based on the updated default hours
                decimal totalHours = presentCheckBox.Checked ? updatedHours + overtime : overtime;

                totalHoursLabel.Text = totalHours.ToString("0.00");
            }
            else
            {
                // Handle the case when overtime is not a valid decimal
                totalHoursLabel.Text = "0.00";
            }
        }



        protected void PresentCheckBox_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox checkBox = (CheckBox)sender;
            GridViewRow gridViewRow = (GridViewRow)checkBox.NamingContainer;
            
            TextBox overtimeTextBox = (TextBox)gridViewRow.FindControl("OvertimeTextBox");
            Label totalHoursLabel = (Label)gridViewRow.FindControl("TotalHoursLabel");
            CheckBox absentCheckBox = (CheckBox)gridViewRow.FindControl("AbsentCheckBox");
            if (string.IsNullOrEmpty(seasonDropDown.SelectedValue))
            {
                // Season is not selected, show a toastr message
                string script = "showErrorNotification('Please select a season for contract employees.')";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "SeasonNotSelected", script, true);
            }
            else
            {
                if (checkBox.Checked)
                {
                    // Checkbox is checked, calculate total hours based on overtime and default hours
                    // Default working hours

                    decimal overtime = 0.00M; // Default overtime if not entered

                    if (decimal.TryParse(overtimeTextBox.Text, out overtime))
                    {
                        // Calculate total hours
                        decimal updatedDefaultHours = (seasonDropDown.SelectedValue == "Summer") ? 12.00M : 8.00M;
                        decimal totalHours = updatedDefaultHours + overtime;
                        totalHoursLabel.Text = totalHours.ToString("0.00");
                    }
                    else
                    {
                        // Handle the case when overtime is not entered
                        totalHoursLabel.Text = defaultHours.ToString("0.00");
                    }

                    overtimeTextBox.Enabled = true;
                    absentCheckBox.Enabled = false;
                    absentCheckBox.Checked = false;

                }
                else
                {
                    // Checkbox is unchecked, set overtime and total hours to default (0.00)
                    overtimeTextBox.Text = "0.00";
                    totalHoursLabel.Text = "0.00";
                    overtimeTextBox.Enabled = false;
                    absentCheckBox.Enabled = true;

                }
            }
        }



        private bool IsRecordExists(SqlConnection connection, string tableName, string empID, string date)
        {
            string query = $"SELECT 1 FROM {tableName} WHERE Emp_ID = @Emp_ID AND Date = @Date";
            using (SqlCommand cmd = new SqlCommand(query, connection))
            {
                cmd.Parameters.AddWithValue("@Emp_ID", empID);
                cmd.Parameters.AddWithValue("@Date", date);
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    return reader.HasRows;
                }
            }
        }
        protected void AbsentCheckBox_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox checkBox = (CheckBox)sender;
            GridViewRow gridViewRow = (GridViewRow)checkBox.NamingContainer;

            TextBox overtimeTextBox = (TextBox)gridViewRow.FindControl("OvertimeTextBox");
            Label totalHoursLabel = (Label)gridViewRow.FindControl("TotalHoursLabel");
            CheckBox presentCheckBox = (CheckBox)gridViewRow.FindControl("PresentCheckBox");

            if (checkBox.Checked)
            {
                // Checkbox is checked, disable Present checkbox and set total hours to default (0.00)
                presentCheckBox.Enabled = false;
                presentCheckBox.Checked = false;
                overtimeTextBox.Text = "0.00";
                totalHoursLabel.Text = "0.00";
                overtimeTextBox.Enabled = false;
            }
            else
            {
                // Checkbox is unchecked, enable Present checkbox
                presentCheckBox.Enabled = true;
            }
        }
    }
}
