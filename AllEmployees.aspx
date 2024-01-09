<%@ Page Title="Employee Directory" Language="C#" MasterPageFile="~/Admindashboard.Master" AutoEventWireup="true" CodeBehind="AllEmployees.aspx.cs" Inherits="Payroll_Mangmt_sys.AllEmployees" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>


    <style>
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
       .fetch-button {
        background-color: #007bff;
        color: #fff;
        padding: 8px 10px;
        border: none;
        border-radius: 5px;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s, box-shadow 0.3s;
    }

    .fetch-button:hover {
        background-color: #0056b3;
    }

    /* Style the GridView */
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
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s, box-shadow 0.3s;
            float: right; /* Align the button to the right */
        }

        .export-button:hover {
            background-color: #45a049;
        }
        a {
            color: #007bff; /* Sky-blue color for all hyperlink states */
            text-decoration: underline; /* Add underline to the link text */
        }

        /* Remove the underline when hovering */
        a:hover {
            text-decoration: none; /* Remove underline on hover */
        }
    </style>



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <center>
        <h1 class="page-heading">GET EMPLOYEE DETAILS</h1>
    </center>
    <asp:Button ID="btnAddEmployee" runat="server" CssClass="fetch-button" Text="Add Employee" OnClick="btnAddEmployee_Click" />
    
    <!-- Add the file input and upload button -->
<asp:FileUpload ID="fileUpload" runat="server" />
<asp:Button ID="btnUploadData" runat="server" CssClass="fetch-button" Text="Upload Excel Data" OnClick="btnUploadData_Click" />

    <asp:Button ID="btnExportToExcel" runat="server" CssClass="export-button" Text="Export to Excel" OnClientClick="return confirmExport();" OnClick="btnExportToExcel_Click" />
    <br /><br />
  <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="grid-view">
    <HeaderStyle CssClass="header" />
    <Columns>
        
        <asp:HyperLinkField DataNavigateUrlFields="Emp_ID" DataNavigateUrlFormatString="~/Update_details.aspx?EmployeeID={0}" DataTextField="Emp_ID" HeaderText="Employee ID" ItemStyle-CssClass="cell" HeaderStyle-CssClass="header" />
        <asp:BoundField DataField="Emp_Name" HeaderText="Employee Name" ItemStyle-CssClass="cell" />
        <asp:BoundField DataField="Mobile" HeaderText="Mobile Number" ItemStyle-CssClass="cell" />
        <asp:BoundField DataField="Email_ID" HeaderText="Email ID" ItemStyle-CssClass="cell" />
        <asp:BoundField DataField="Designation" HeaderText="Designation" ItemStyle-CssClass="cell" />
        <asp:BoundField DataField="Bloodgroup" HeaderText="Blood Group" ItemStyle-CssClass="cell" />
        <asp:BoundField DataField="City" HeaderText="City" ItemStyle-CssClass="cell" />
        <asp:BoundField DataField="CTC_Gross" HeaderText="CTC Gross" ItemStyle-CssClass="cell" />
        <asp:BoundField DataField="Date_Of_Joining" HeaderText="Date of Joining" ItemStyle-CssClass="cell" DataFormatString="{0:dd-MM-yyyy}" />
    </Columns>
</asp:GridView>

  <script>
      function confirmExport() {
          var confirmResult = confirm('Are you sure you want to export data to Excel?');
          return confirmResult;
      }
  </script>
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
    </script>
    <script>
        function logout() {
            $.ajax({
                type: "POST",
                url: "login1.aspx/Logout", // Replace with your actual page name
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    // Redirect to the login page
                    window.location.href = response.d;
                },
                error: function (error) {
                    // Handle the error, if any
                    console.log(error);
                }
            });
        }
    </script>

</asp:Content>
