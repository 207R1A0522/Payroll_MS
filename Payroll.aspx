<%@ Page Title="" Language="C#" MasterPageFile="~/Admindashboard.Master" AutoEventWireup="true" CodeBehind="Payroll.aspx.cs" Inherits="Payroll_Mangmt_sys.Payroll" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css" />

    <style>
        /* Add your CSS styles for input fields and headings */

        .form-field {
            margin-bottom: 10px;
            margin-left: 20px;
            margin-right: 20px;
        }
         .required-field {
            color: red;
            margin-left: 5px;
        }

        .form-field input[type="text"],
        .form-field textarea,
        .form-field select{
            margin: 5px 0;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            transition: border-color 0.3s;
            width: 200px;
        }
        
        .form-field input[type="text"]:focus,
    .form-field textarea:focus,
        .form-field select:focus{
        outline: none;
        border-color: #007bff;
        box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
    }

        /* Align labels to the right */
        .form-field label {
            display: inline-block;
            font-weight: bold;
            color: #444;
            width: 200px; /* Adjust the width as needed */
            text-align: right;
            margin-right: 10px;
        }

    /* Styles for the "Add Row" button */
    .save-button {
        cursor: pointer;
        background-color: #007bff;
        color: #fff;
        padding: 10px 20px;
        border: none;
        margin-top: 10px;
        border-radius: 5px;
    }

    .cancel-button {
        cursor: pointer;
        background-color: #dc3545;
        color: #fff;
        padding: 10px 20px; /* Adjust padding as needed */
        border: none;
        margin-top: 10px;
        border-radius: 5px;
    }
       
    .cancel-button:hover, .save-button:hover {
        box-shadow: 0 0 8px rgba(0, 0, 0, 0.3); /* Add a subtle shadow on hover */
    }

   
    .autocomplete-list {
            border: 1px solid #ccc;
            background-color: #fff;
            max-height: 150px;
            overflow-y: auto;
        }

        .autocomplete-item {
            padding: 5px;
            cursor: pointer;
        }

        .autocomplete-item:hover {
            background-color: #f0f0f0;
        }

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
   
        /* CSS animation for the heading */
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
  
        a {
              color: #007bff; /* Sky-blue color for all hyperlink states */
              text-decoration: underline; /* Add underline to the link text */
        }

        /* Remove the underline when hovering */
        a:hover {
            text-decoration: none; /* Remove underline on hover */
        }
         .required-validator {
            font-size: 12px; /* Adjust the font size as needed */
            display: block;
            margin-top: 4px; /* Adjust the margin-top as needed */
            color: Red; /* Red color for the error message */
        }
         .grid-view {
            margin-top: 20px;
            border-collapse: collapse;
            width: 100%;
        }

        .grid-view th, .grid-view td {
            border: 1px solid #ddd;
            padding: 6px;
            text-align: left;
        }

        .grid-view th {
            background-color: #dcdcdc;
        }


        .grid-view tr:hover {
            background-color: #eee;
        }
        .export-button {
        background-color: #28a745; /* Green color */
        color: #fff; /* Text color */
        border: none;
        padding: 10px 20px; /* Adjust padding as needed */
        border-radius: 5px;
        cursor: pointer;
        margin-left: 40px;
    }

    .export-button:hover {
        background-color: #218838; /* Darker green color on hover */
    }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <center>
        <h1 class="page-heading">PAYROLL</h1>
    </center>
     <div class="form-field">
        <label>Select Payroll Type:</label>
        <asp:DropDownList ID="ddlPayrollType" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPayrollType_SelectedIndexChanged">
            <asp:ListItem Text="Select" Value="" />
            <asp:ListItem Text="Staff Payroll" Value="StaffPayroll" />
            <asp:ListItem Text="Temporary Employee Payroll" Value="TempEmployeePayroll" />
        </asp:DropDownList>

    </div>
    <div class="form-field" >
    <label>Select Option:</label>
    <asp:DropDownList ID="ddlSelectOption" runat="server" Autopostback="true" OnSelectedIndexChanged="ddlSelectOption_SelectedIndexChanged" Visible="true">
        
       
    </asp:DropDownList>

 <asp:Button ID="btnExportExcel" runat="server" Text="Export to Excel" OnClick="btnExportExcel_Click" CssClass="export-button"/>

</div>

    <asp:GridView ID="gvPayrollDetails" runat="server" AutoGenerateColumns="False" OnSelectedIndexChanged="ddlPayrollType_SelectedIndexChanged" CssClass="grid-view">
    <HeaderStyle CssClass="header" />
        <Columns>
        <asp:BoundField DataField="EmployeeID" HeaderText="Employee ID" ItemStyle-CssClass="cell" />
        <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" ItemStyle-CssClass="cell" />
        <asp:BoundField DataField="BankName" HeaderText="Bank Name" ItemStyle-CssClass="cell" />
        <asp:BoundField DataField="BankAccountNumber" HeaderText="Bank Account Number" ItemStyle-CssClass="cell" />
        <asp:BoundField DataField="IFSCCode" HeaderText="IFSC Code" ItemStyle-CssClass="cell" />
        <asp:BoundField DataField="NetPay" HeaderText="Net Pay" ItemStyle-CssClass="cell" />
        <asp:BoundField DataField="Message" HeaderText="Remarks" ItemStyle-CssClass="cell" />
    </Columns>
        <EmptyDataTemplate>
        No data available.
    </EmptyDataTemplate>
</asp:GridView>

     <script>
        function showSuccessNotification(message) {
            toastr.success(message, 'Success', {
                positionClass: 'toast-top-right',
                closeButton: true,
                progressBar: true
            });
        }

        function showErrorNotification(message) {
            toastr.error(message, 'Error', {
                positionClass: 'toast-top-right',
                closeButton: true,
                progressBar: true
            });
         }
         function showNoDataNotification() {
             toastr.error('No data available for export.', 'Error', {
                 positionClass: 'toast-top-right',
                 closeButton: true,
                 progressBar: true
             });
         }
     </script>


</asp:Content>
