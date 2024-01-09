<%@ Page Title="Salary" Language="C#" MasterPageFile="~/Admindashboard.Master" AutoEventWireup="true" CodeBehind="Salary.aspx.cs" Inherits="Payroll_Mangmt_sys.Salary" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
       <style>
        /* Add your CSS styles for input fields and headings */

        .form-field {
            margin-bottom: 10px;
            margin-left: 20px;
            margin-right: 20px;
        }

        .form-field label {
            display: inline-block;
            font-weight: bold;
            color: #444;
            width: 150px; /* Adjust the width as needed */
            text-align: right;
            margin-right: 10px;
        }

        .form-field input[type="text"],
        .form-field textarea,
        .form-field select {
            margin: 5px 0;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            transition: border-color 0.3s;
            width: 200px;
        }

        .form-field input[type="text"]:focus,
        .form-field textarea:focus,
        .form-field select:focus {
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

        .required-field {
            color: red;
        }

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
        
       .left-column {
            float: left;
            width: 45%; 
            box-sizing: border-box; 
            padding-right: 10px; 
        }

        
        .right-column {
            float: left; 
            width: 45%; 
            box-sizing: border-box; 
            padding-left: 10px; 
        }
        .salary-table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
        margin-top: 20px;
    }

    /* Style table headers */
    .salary-table th {
        background-color: #f2f2f2;
        text-align: left;
        padding: 10px;
        border-bottom: 1px solid #ddd;
        font-weight: bold;
    }

    /* Style table cells */
    .salary-table td {
        padding: 10px;
        border-bottom: 1px solid #ddd;
    }

    
    .block {
        background-color: #fff;
        padding: 20px;
        margin: 20px 60px 20px 0;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        display: inline-block;
        width: 30%;
        vertical-align: top;
        transition: background-color 0.3s ease-in-out, box-shadow 0.3s ease-in-out; /* Add smooth transition */
    }

    .block1 {
        background-color: #fff;
        padding: 20px;
        margin: 20px 0 20px 10px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        display: inline-block;
        width: 30%;
        vertical-align: top;
        transition: background-color 0.3s ease-in-out, box-shadow 0.3s ease-in-out; /* Add smooth transition */
    }

    
    .block:hover, .block1:hover {
        background-color: #f7f7f7;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3); 
    }
    
    .input-field1 {
        font-weight: bold;
    }
    .net-pay-row {
        background-color: #e6ffe6; 
        font-weight: bold;
    }

    .net-pay-value {
        color: #00a000; 
    }
    .total-paid-gross-row {
        background-color: #eff7ff; 
    }

    .total-paid-gross-value {
        color: #007bff; 
    }
    .total-deduction-row {
        background-color: #FFECE6; 
    }

   
    .total-deduction-value {
        color: #FF5733; 
    }
    .center-column {
    text-align: left;
    clear: both; 
    
}
           .payslip{     
               font-size: 18px;
                font-weight: normal;
                color: #333;
                text-align:center;
                border-bottom: 2px solid darkviolet;
                padding-bottom: 5px;
                animation: fadeInMove  ease-in-out;
                margin-bottom: 30px;
                font-family: Arial, sans-serif;
                text-transform: uppercase;
                letter-spacing: 2px;
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
        .error-message {
        position: fixed;
        top: 10px;
        left: 50%;
        transform: translateX(-50%);
        background-color: #ff5733;
        color: white;
        padding: 10px;
        border-radius: 5px;
        text-align: center;
        z-index: 9999;
        display: none; /* Initially hide the error message */
    }

    .error-message.visible {
        display: block; /* Show the error message */
    }

    .error-message.hidden {
        display: none; /* Hide the error message */
    }
    .align-right {
        float: right;
    }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server" />
   <asp:HiddenField ID="hidSuccessMessage" runat="server" />
   <center>
    <h1 class="page-heading">GENERATE SALARY</h1>
    </center>
    <div id="error-container" class="error-message"></div>
      <div class="form-field">
          <div class="left-column">
          <label>Location:</label>
                <asp:DropDownList ID="ddlOfficeLocation" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlLocation_SelectedIndexChanged">
                    <asp:ListItem Text="Select Location" Value=""></asp:ListItem>
                    <asp:ListItem Text="Pathur" Value="Pathur"></asp:ListItem>
                    <asp:ListItem Text="Tunikibollaram" Value="Tunikibollaram"></asp:ListItem>
                    <asp:ListItem Text="Westbengal" Value="Westbengal"></asp:ListItem>
                    <asp:ListItem Text="Toopran" Value="Toopran"></asp:ListItem>
                    <asp:ListItem Text="Kodakandla" Value="Kodakandla"></asp:ListItem>
                    <asp:ListItem Text="Eluru" Value="Eluru"></asp:ListItem>
                    <asp:ListItem Text="Medchal" Value="Medchal"></asp:ListItem>
                </asp:DropDownList>
              <label>Employee ID:<span class="required-field">*</span></label>
            <asp:TextBox ID="empId" runat="server" CssClass="input-field" onblur="fetchEmployeeDetails();" AutoPostBack="false" OnClientItemSelected="onSelectEmployeeID"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvEmpID" runat="server"
                    ControlToValidate="empId"
                    InitialValue=""
                    ErrorMessage="Employee ID is required"
                    Display="Dynamic"
                    ForeColor="Red"
                    CssClass="required-validator"
                    ValidationGroup="SalaryGroup"/>
              <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server"
                TargetControlID="empId"
                ServiceMethod="GetEmployeeIDSuggestions"
                MinimumPrefixLength="1"
                CompletionInterval="1000"
                EnableCaching="true"
                CompletionSetCount="20"
                FirstRowSelected="true"
                CompletionListCssClass="autocomplete-list"
                CompletionListItemCssClass="autocomplete-item" />
           
        <label >Employee Name:</label>
            <asp:TextBox ID="empName" runat="server" CssClass="input-field" ></asp:TextBox>
        <label>CTC Gross:</label>
            <asp:TextBox ID="ctcGross" runat="server" CssClass="input-field" ></asp:TextBox>
         <label>Select Year:</label>
        <asp:DropDownList ID="ddlYear" runat="server" CssClass="input-field" AutoPostBack="true" OnSelectedIndexChanged="ddlYear_SelectedIndexChanged">
            <asp:ListItem Text="Select" Value=""></asp:ListItem>
        </asp:DropDownList>
              <asp:RequiredFieldValidator ID="rfvYear" runat="server"
                    ControlToValidate="ddlYear"
                    InitialValue=""
                    ErrorMessage="Select Year"
                    Display="Dynamic"
                    ForeColor="Red"
                    CssClass="required-validator"
                    ValidationGroup="SalaryGroup"/>
           <label>Select Month:</label>
        <asp:DropDownList ID="ddlMonth" runat="server" CssClass="input-field" >
            <asp:ListItem Text="Select" Value=""></asp:ListItem>
        </asp:DropDownList>
              <asp:RequiredFieldValidator ID="rfvMonth" runat="server"
                    ControlToValidate="ddlMonth"
                    InitialValue=""
                    ErrorMessage="Select Month"
                    Display="Dynamic"
                    ForeColor="Red"
                    CssClass="required-validator"
                    ValidationGroup="SalaryGroup"/>
          
   </div>
    </div>
    <div class="form-field">
        <div class="right-column">
            <label>Hike (if any):</label>
            <asp:TextBox ID="hike" runat="server" CssClass="input-field"></asp:TextBox>
             <label>EPC (if any):</label>
            <asp:TextBox ID="epc" runat="server" CssClass="input-field"></asp:TextBox>
             <label>TDS (if any):</label>
            <asp:TextBox ID="tds" runat="server" CssClass="input-field"></asp:TextBox>
             <label>Advance (if any):</label>
            <asp:TextBox ID="advance" runat="server" CssClass="input-field"></asp:TextBox>
             <label>Travel Allowance (if any):</label>
            <asp:TextBox ID="ta" runat="server" CssClass="input-field"></asp:TextBox>
        </div>
    </div>
    <div class="form-field">
        <div class="center-column">

            <asp:Button ID="calculateSalary" runat="server" Text="Calculate Salary" CssClass="save-button" OnClick="CalculateSalary_Click" ValidationGroup="SalaryGroup"/>
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="cancel-button"  OnClick="CancelSalaryDetails_Click"/>
             <asp:Button ID="All_Salaries" runat="server" CssClass="save-button align-right" Text="Download Salaries" OnClick="Salaries_Download_Click" />
        </div>
       
    </div>
    
                <br>
<hr>
<div class="payslip">
<h3>Pay Slip</h3>
    </div>
   

    <div class="block">
    <table class="salary-table">
            
        <!-- First Block -->
        <tr>
            <th>Component</th>
            <th>Value</th>
        </tr>
       
        <tr>
            <td>CTC Basic :</td>
            <td><asp:Label ID="ctcBasic" runat="server" CssClass="input-field1"></asp:Label></td>
        </tr>
        <tr>
            <td>CTC HRA :</td>
            <td><asp:Label ID="ctcHRA" runat="server" CssClass="input-field1"></asp:Label></td>
        </tr>
        <tr>
            <td>C.A :</td>
            <td><asp:Label ID="ca" runat="server" CssClass="input-field1"></asp:Label></td>
        </tr>
        <tr>
            <td>Medical :</td>
            <td><asp:Label ID="medical" runat="server" CssClass="input-field1"></asp:Label></td>
        </tr>
        <tr>
            <td>Others :</td>
            <td><asp:Label ID="others" runat="server" CssClass="input-field1"></asp:Label></td>
        </tr>
        <tr class="total-paid-gross-row">
            <td class="total-paid-gross-value">Total Paid Gross :</td>
            <td><asp:Label ID="totalGross" runat="server" CssClass="total-paid-gross-value"></asp:Label></td>
        </tr>
        <tr>
            <td>Actual Basic :</td>
            <td><asp:Label ID="ActualBasic" runat="server" CssClass="input-field1"></asp:Label></td>
        </tr>
        <tr>
            <td>Actual HRA :</td>
            <td><asp:Label ID="ActualHRA" runat="server" CssClass="input-field1"></asp:Label></td>
        </tr>
        <tr>
            <td>Actual C.A :</td>
            <td><asp:Label ID="actualCA" runat="server" CssClass="input-field1"></asp:Label></td>
        </tr>
        <tr>
            <td>Actual Medical :</td>
            <td><asp:Label ID="ActualMedical" runat="server" CssClass="input-field1"></asp:Label></td>
        </tr>
        <tr>
            <td>Others :</td>
            <td><asp:Label ID="Others1" runat="server" CssClass="input-field1"></asp:Label></td>
        </tr>
    </table>
    </div>
    
<div class="block1">
    <table class="salary-table">
        <!-- Second Block -->
        <tr>
            <th>Component</th>
            <th>Value</th>
        </tr>
        
        <tr>
            
            <td>LOP :</td>
            <td><asp:Label ID="LOP" runat="server" CssClass="input-field1"></asp:Label></td>
        </tr>
        <tr>
            <td>EPF :</td>
            <td><asp:Label ID="epf" runat="server" CssClass="input-field1"></asp:Label></td>
        </tr>
        <tr>
            <td>ESI :</td>
            <td><asp:Label ID="esi" runat="server" CssClass="input-field1"></asp:Label></td>
        </tr>
        <tr>
            <td>PT :</td>
            <td><asp:Label ID="pt" runat="server" CssClass="input-field1"></asp:Label></td>
        </tr>
  
        <tr>
            <td>Medical :</td>
            <td><asp:Label ID="Medical1" runat="server" CssClass="input-field1"></asp:Label></td>
        </tr>
        <tr class="total-deduction-row">
            <td class="total-deduction-value">Total Deduction :</td>
            <td><asp:Label ID="TotalDeduction" runat="server" CssClass="total-deduction-value"></asp:Label></td>
        </tr>
        <tr>
            <td>Arrears :</td>
            <td><asp:Label ID="Arrears" runat="server" CssClass="input-field1"></asp:Label></td>
        </tr>
        <tr class="net-pay-row">
            <td class="net-pay-value">Net Pay :</td>
            <td><asp:Label ID="netPay" runat="server" CssClass="net-pay-value"></asp:Label></td>
        </tr>
        
    </table>
</div>
       <br />
         
     <asp:Button ID="Download" runat="server" CssClass="save-button " Text="Download" OnClick="Download_Click" />  
    

    <asp:Button ID="btnSave" runat="server" CssClass="save-button" Text="Save" OnClick="BtnSave_Click" />


     <script type="text/javascript">

         function fetchEmployeeDetails() {
             var txtEmployeeID = document.getElementById('<%= empId.ClientID %>');
             var txtEmployeeName = document.getElementById('<%= empName.ClientID %>');
             var txtCTCGross = document.getElementById('<%= ctcGross.ClientID %>');
             var selectedLocation = document.getElementById('<%= ddlOfficeLocation.ClientID %>').value;

             // Get the entered or selected Employee ID
             var selectedEmpID = txtEmployeeID.value;

             // Make an AJAX request to fetch the Employee Details
             $.ajax({
                 type: "POST",
                 url: "Salary.aspx/GetEmployeeDetails",
                 data: JSON.stringify({ selectedEmpID: selectedEmpID, selectedLocation1: selectedLocation }),
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: function (response) {
                     // Update the Employee Name and CTC Gross fields with the fetched values
                     if (response.d.Error) {
                         // Handle error here
                         showErrorNotification('employee', response.d.Error);
                     } else {
                         // Use a delay to ensure that the AJAX request completes before updating the fields
                         setTimeout(function () {
                             txtEmployeeName.value = response.d.Emp_Name;
                             txtCTCGross.value = response.d.CTC_Gross;
                         }, 0);
                     }
                 },
                 error: function (error) {
                     console.error(error.get_message());
                 }
             });
         }

    </script>
    <script>

         function showSuccessNotification(section) {
             toastr.success(section + 'details updated successfully', {
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
</asp:Content>