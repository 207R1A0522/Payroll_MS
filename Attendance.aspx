<%@ Page Title="" Language="C#" MasterPageFile="~/Admindashboard.Master" AutoEventWireup="true" CodeBehind="Attendance.aspx.cs" Inherits="Payroll_Mangmt_sys.Attendance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Include the Toastr CSS and JavaScript files -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>

      <style>
        /* General styles */
        body {
            font-family: Arial, sans-serif;
        }

        /* Page heading styles */
        .page-heading {
            font-size: 36px;
            font-weight: normal;
            color: #333;
            border-bottom: 2px solid darkviolet;
            padding-bottom: 5px;
            animation: fadeInMove 2s ease-in-out;
            margin-bottom: 30px;
            font-family: Arial, sans-serif;
            text-transform: uppercase;
            letter-spacing: 2px;
        }
         @keyframes fadeInMove {
            from {
                opacity: 0;
                transform: translateX(-20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        /* Dropdown list styles */
       .dropdown-list {
            width: 200px;
            margin: 10px 0;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        /* GridView styles */
        .custom-table {
            width: 100%;
            border-collapse: collapse;
            border: 1px solid #ccc;
        }

        .custom-table th, .custom-table td {
            padding: 10px;
            text-align: center;
            border: 1px solid #ccc;
        }

        .custom-table th {
            background-color: #333;
            color: #fff;
        }

        /* Checkbox styles */
        .custom-checkbox {
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* Button styles */
        .save-button {
            display: block;
            margin: 20px auto;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
            font-size: 16px;
        }

        .save-button:hover {
            background-color: #0056b3;
        }
        .overtime-column {
        width: 80px; /* Adjust the width as needed */
    }
        </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <center>
        <h1 class="page-heading">EMPLOYEE ATTENDANCE</h1>
    </center>
    <label for="employeeType">Employee Type:</label>
    <asp:DropDownList ID="employeeType" runat="server" AutoPostBack="true" CssClass="dropdown-list" OnSelectedIndexChanged="employeeType_SelectedIndexChanged">
        <asp:ListItem Text="Select" Value="" />
        <asp:ListItem Text="Full-Time Employee" Value="Fulltime" />
        <asp:ListItem Text="Temporary Employee" Value="Contract" />
    </asp:DropDownList>

  
    <div id="fullTimeSection">
         <h2>Full-Time Employee Attendance</h2>
    <asp:GridView ID="fullTimeAttendanceTable" runat="server" CssClass="custom-table" AutoGenerateColumns="False">
        <Columns>
            <asp:BoundField DataField="Emp_ID" HeaderText="Employee ID" />
            <asp:BoundField DataField="Emp_Name" HeaderText="Employee Name" />
            <asp:BoundField DataField="Designation" HeaderText="Designation" />
            <asp:BoundField DataField="Date" HeaderText="Date" ReadOnly="true" DataFormatString="{0:dd-MM-yyyy}" />
            <asp:TemplateField HeaderText="Present">
                <ItemTemplate>
                    <asp:CheckBox ID="PresentCheckBox" runat="server" Checked='<%# Eval("IsPresent") %>' Enabled="true" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Absent">
                <ItemTemplate>
                    <asp:CheckBox ID="AbsentCheckBox" runat="server" Checked='<%# Eval("IsAbsent") %>' Enabled="true" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
        </div>
    <div id="contractSection">
    <h2>Temporary Employee Attendance</h2>
        <label for="seasonDropDown">Season: </label>
        <asp:DropDownList ID="seasonDropDown" runat="server" CssClass="dropdown-list" AutoPostBack="true" OnSelectedIndexChanged="seasonDropDown_SelectedIndexChanged">
            <asp:ListItem Text="Select" Value="" />
            <asp:ListItem Text="Winter" Value="Winter" />
            <asp:ListItem Text="Summer" Value="Summer" />
        </asp:DropDownList>
        <br /> <br />
    <asp:GridView ID="contractAttendanceTable" runat="server" CssClass="custom-table" AutoGenerateColumns="False">
    <Columns>
        <asp:BoundField DataField="Emp_ID" HeaderText="Employee ID" />
        <asp:BoundField DataField="Emp_Name" HeaderText="Employee Name" />
        <asp:BoundField DataField="Designation" HeaderText="Designation" />
        <asp:BoundField DataField="Date" HeaderText="Date" ReadOnly="true" DataFormatString="{0:dd-MM-yyyy}" />
        <asp:TemplateField HeaderText="Overtime (hours)">
            <ItemTemplate>
                <asp:TextBox ID="OvertimeTextBox" CssClass="overtime-column" runat="server" Text='<%# Bind("Overtime") %>' Enabled="false" AutoPostBack="true" OnTextChanged="OvertimeTextBox_TextChanged" data-present='<%# Eval("IsPresent") %>'></asp:TextBox>
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Present">
            <ItemTemplate>
                <asp:CheckBox ID="PresentCheckBox" runat="server" Checked='<%# Eval("IsPresent") %>' Enabled="true" AutoPostBack="true" OnCheckedChanged="PresentCheckBox_CheckedChanged" />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Absent">
                <ItemTemplate>
                    <asp:CheckBox ID="AbsentCheckBox" runat="server" Checked='<%# Eval("IsAbsent") %>' Enabled="true" />
                </ItemTemplate>
            </asp:TemplateField>
        <asp:TemplateField HeaderText="Total Hours">
            <ItemTemplate>
                <asp:Label ID="TotalHoursLabel" runat="server" Text='<%# Eval("TotalHours") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
        </div>

<asp:Button ID="SaveFullTimeAttendanceButton" runat="server" CssClass="save-button" Text="Save Full-Time Attendance" OnClick="SaveFullTimeAttendance_Click" style="display:none" />
<asp:Button ID="SaveContractAttendanceButton" runat="server" CssClass="save-button" Text="Save Contract Attendance" OnClick="SaveContractAttendance_Click" style="display:none" />
    <script>
        function showSuccessNotification(section) {
            toastr.success(section, 'Success', {
                positionClass: 'toast-top-right',
                closeButton: true,
                progressBar: true
            });
        }

        function showErrorNotification(section, errorMessage) {
            toastr.error('Error adding ' + section + ' details. ' + errorMessage, 'Error', {
                positionClass: 'toast-top-right',
                closeButton: true,
                progressBar: true
            });
        }
    </script>
   

<script>
    function showAttendanceForm() {
        var employeeType = document.getElementById('<%= employeeType.ClientID %>').value;
        var fullTimeSection = document.getElementById('fullTimeSection');
        var contractSection = document.getElementById('contractSection');
        var saveFullTimeButton = document.getElementById('<%= SaveFullTimeAttendanceButton.ClientID %>');
        var saveContractButton = document.getElementById('<%= SaveContractAttendanceButton.ClientID %>');

        if (employeeType === 'Fulltime') {
            fullTimeSection.style.display = 'block';
            contractSection.style.display = 'none';
            saveFullTimeButton.style.display = 'block';
            saveContractButton.style.display = 'none';
        } else if (employeeType === 'Contract') {
            fullTimeSection.style.display = 'none';
            contractSection.style.display = 'block';
            saveFullTimeButton.style.display = 'none';
            saveContractButton.style.display = 'block';
        } else {
            fullTimeSection.style.display = 'none';
            contractSection.style.display = 'none';
            saveFullTimeButton.style.display = 'none';
            saveContractButton.style.display = 'none';
        }

    }

    


    // Call showAttendanceForm() initially to display the correct form based on the default dropdown selection
    showAttendanceForm();
</script>
   
</asp:Content>
