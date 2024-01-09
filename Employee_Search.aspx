<%@ Page Title="Employee Search" Language="C#" MasterPageFile="~/Admindashboard.Master" AutoEventWireup="true" CodeBehind="Employee_Search.aspx.cs" Inherits="Payroll_Mangmt_sys.Employee_Search" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <style>
        /* Add your CSS styles for input fields and headings */
       .form-field {
        display: table-row; /* Change from 'block' to 'inline-block' */
        margin: 10px 10px;
        vertical-align: top; /* Align elements to the top */
    }
       .form-container {
        text-align: center; /* Center align the elements within the container */
        
    }
       .label-message {
        font-weight: bold;
        color: #333;
        font-size: 15px;
        margin-top: 5px;
        text-align: left; /* Align label messages to the left */
    }
    .form-field label {
        display: inline-block;
        font-weight: bold;
        color: #444;
        width: 150px;
        text-align: right;
        margin-right: 10px;
    }

    .form-field select,
    .form-field input[type="text"] {
        margin: 5px 0;
        padding: 5px;
        border: 1px solid #ccc;
        border-radius: 5px;
        transition: border-color 0.3s;
        width: 200px;
    }

    .form-field select:focus,
    .form-field input[type="text"]:focus {
        outline: none;
        border-color: #007bff;
        box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
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

    .required-field {
        color: red;
    }

    .submit-button {
        cursor: pointer;
        background-color: #007bff;
        color: #fff;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        transition: box-shadow 0.3s;
        font-size: 16px;
        margin-top: 10px;
    }

    .submit-button:hover {
        box-shadow: 0 0 8px rgba(0, 0, 0, 0.3);
    }

    /* Style the GridView */
    .grid-view {
        margin-top: 20px;
        border-collapse: collapse;
        width: 50%;
    }

    .grid-view th,
    .grid-view td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: left;
    }

    .grid-view th {
        background-color: #dcdcdc;
    }

    .grid-view tr:hover {
        background-color: #eee;
    }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <asp:HiddenField ID="hidSuccessMessage" runat="server" />
   <center>
    <h1 class="page-heading">FILTER EMPLOYEES</h1>
    </center>
    <div class="form-container">
   <div class="form-field">
        <label for="ddlLocation">Location:</label>
        <asp:DropDownList ID="ddlLocation" runat="server">
            <asp:ListItem Text="All" Value="" />
            <asp:ListItem Text="Pathur" Value="Pathur">Pathur</asp:ListItem>
            <asp:ListItem Text="Kodakandla" Value="Kodakandla">Kodakandla</asp:ListItem>
            <asp:ListItem Text="Tunikibollaram" Value="Tunikibollaram">Tunikibollaram</asp:ListItem>
            <asp:ListItem Text="Eluru" Value="Eluru">Eluru</asp:ListItem>
             <asp:ListItem Text="Toopran" Value="Toopran">Toopran</asp:ListItem>
             <asp:ListItem Text="Westbengal" Value="Westbengal">Westbengal</asp:ListItem>
             <asp:ListItem Text="Medchal" Value="Medchal">Medchal</asp:ListItem>
        </asp:DropDownList>
    </div>
         <div class="form-field" style="margin-bottom: 50px;">
            <label for="ddlDesignation" style="width: 150px;">Designation:</label>
            <asp:DropDownList ID="ddlDesignation" runat="server" CssClass="input-text" style="width: 200px MaxLength: 50px;"></asp:DropDownList>
        </div>
        <div class="form-field" style="margin-bottom: 50px;">
            <label for="txtSalary" style="width: 150px;">Salary:</label>
            <asp:TextBox ID="txtSalary" runat="server" CssClass="input-text" style="width: 200px;"></asp:TextBox>
        </div>
    <div class="form-field">
        <label for="ddlGender">Gender:</label>
        <asp:DropDownList ID="ddlGender" runat="server">
            <asp:ListItem Text="All" Value="" />
            <asp:ListItem Text="Male" Value="Male" />
            <asp:ListItem Text="Female" Value="Female" />
            <asp:ListItem Text="Others" Value="Others" />
        </asp:DropDownList>
    </div>

    <div class="form-field">
        <label for="ddlBloodgroup">Blood Group:</label>
        <asp:DropDownList ID="ddlBloodgroup" runat="server">
            <asp:ListItem Text="All" Value="" />
            <asp:ListItem Text="A+" Value="A+">A+</asp:ListItem>
            <asp:ListItem Text="A-" Value="A-">A-</asp:ListItem>
            <asp:ListItem Text="B+" Value="B+">B+</asp:ListItem>
            <asp:ListItem Text="B-" Value="B-">B-</asp:ListItem>
            <asp:ListItem Text="AB+" Value="AB+">AB+</asp:ListItem>
            <asp:ListItem Text="AB-" Value="AB-">AB-</asp:ListItem>
            <asp:ListItem Text="O+" Value="O+">O+</asp:ListItem>
            <asp:ListItem Text="O-" Value="O-">O-</asp:ListItem>
        </asp:DropDownList>
    </div>
        </div>
    <div class="form-field">
        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="submit-button" OnClick="btnSearch_Click" />
    </div>
    <br />
    <br />

    <!-- Display a message if no matching records are found -->
   <asp:Label ID="lblRowCount" runat="server" CssClass="label-message"></asp:Label>



    <!-- Add a GridView to display search results -->
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="grid-view">
        <Columns>
            <asp:BoundField DataField="Emp_ID" HeaderText="Employee ID" />
            <asp:BoundField DataField="Emp_Name" HeaderText="Employee Name" />
        </Columns>
    </asp:GridView>
    <script>
        function showSuccessNotification(message) {
            toastr.success(message, 'Success', {
                positionClass: 'toast-top-right',
                closeButton: true,
                progressBar: true
            });
        }
   </script>
</asp:Content>