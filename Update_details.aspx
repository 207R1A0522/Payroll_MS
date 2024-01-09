<%@ Page Title="Update_Employee" Language="C#" MasterPageFile="~/Admindashboard.Master" AutoEventWireup="true" CodeBehind="Update_details.aspx.cs" Inherits="Payroll_Mangmt_sys.Update_details" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
       .form-section {
            margin-bottom: 20px;
        }

        .form-field {
            margin-bottom: 10px;
        }
        .form-field-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            grid-gap: 10px;
        }

        .required-field {
            color: red;
            margin-left: 5px;
        }
        .form-field {
            margin-bottom: 10px;
            margin-left: 20px;
            margin-right: 20px;
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
            width: 150px; /* Adjust the width as needed */
            text-align: right;
            margin-right: 10px;
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
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <center>
        <h1 class="page-heading">UPDATE EMPLOYEE</h1>
    </center>
    <div>
        <a href="AllEmployees.aspx" class="back-button">Back</a>
    </div>
    
    <!-- Personal Details Section -->

    <div class="form-section">
        <h2>Personal Details</h2>
        <div class="form-field-grid">
        <div class="form-field">
            <label>Employee ID: </label>
            <asp:TextBox ID="txtEmployeeID" runat="server" ></asp:TextBox>
        </div>
            <div class="form-field">
            <label>Biometric Code: </label>
            <asp:TextBox ID="TextBox8" runat="server" ></asp:TextBox>
        </div>
        <div class="form-field">
                <label>Employee Name: </label>
                <asp:TextBox ID="txtEmployeeName" runat="server" ></asp:TextBox>
        </div>
            <div class="form-field">
                <label>Mobile Number: </label>
                <asp:TextBox ID="TextBox6" runat="server" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvMobile" runat="server"
                        ControlToValidate="TextBox6"
                        InitialValue=""
                        ErrorMessage="Enter Mobile Number"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="AccountGroup"/>
            </div>
            <div class="form-field">
                <label>Email ID: </label>
                <asp:TextBox ID="TextBox1" runat="server" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                        ControlToValidate="TextBox1"
                        InitialValue=""
                        ErrorMessage="Enter EmailID"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="AccountGroup"/>
            </div>
            <div class="form-field">
                <label>Date of Birth: </label>
                <asp:TextBox ID="txtDOB" runat="server"  ClientIDMode="Static" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvDOB" runat="server"
                        ControlToValidate="txtDOB"
                        InitialValue=""
                        ErrorMessage="Enter DOB"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="AccountGroup"/>
            </div>
            <div class="form-field">
                <label>Age:</label>
                <asp:TextBox ID="txtAge" runat="server" ReadOnly="true" ClientIDMode="Static"></asp:TextBox>
            </div>
                
            
            <div class="form-field">
                <label>Father Name:</label>
                <asp:TextBox ID="txtFatherName" runat="server"></asp:TextBox>
            </div>
            <div class="form-field">
                <label>Gender: </label>
                <asp:DropDownList ID="ddlGender" runat="server">
                    <asp:ListItem Text="Select" Value=""></asp:ListItem>
                    <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                    <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvGender" runat="server"
                        ControlToValidate="ddlGender"
                        InitialValue=""
                        ErrorMessage="Select Gender"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="AccountGroup"/>
               
            </div>

                 <div class="form-field">
                <label>Designation: </label>
                <asp:TextBox ID="TextBox4" runat="server" ></asp:TextBox>
                     <asp:RequiredFieldValidator ID="rfvDesignation" runat="server"
                        ControlToValidate="TextBox4"
                        InitialValue=""
                        ErrorMessage="Enter Designation"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="AccountGroup"/>
            </div>
            <div class="form-field">
                <label>CTC Gross: </label>
                <asp:TextBox ID="TextBox5" runat="server" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvCTC" runat="server"
                        ControlToValidate="TextBox5"
                        InitialValue=""
                        ErrorMessage="Enter CTC Gross"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="AccountGroup"/>
            </div>
            <div class="form-field">
                <label>CTC_Basic:<span class="required-field">*</span> </label>
                <asp:DropDownList ID="ddlCTCBasic" runat="server">
                    <asp:ListItem Text="Select" Value=""></asp:ListItem>
                    <asp:ListItem Text="40%" Value="40%"></asp:ListItem>
                    <asp:ListItem Text="50%" Value="50%"></asp:ListItem>
                    <asp:ListItem Text="60%" Value="60%"></asp:ListItem>
                </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvCTCBasic" runat="server"
                        ControlToValidate="ddlCTCBasic"
                        InitialValue=""
                        ErrorMessage="CTCBasic is required"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="AccountGroup"/>
                </div>
                <div class="form-field">
                        <label>Blood Group:</label>
                        <asp:DropDownList ID="ddlBloodgroup" runat="server">
                            <asp:ListItem Text="Select" Value=""></asp:ListItem>
                            <asp:ListItem Text="A+" Value="A+"></asp:ListItem>
                            <asp:ListItem Text="A-" Value="A-"></asp:ListItem>
                            <asp:ListItem Text="B+" Value="B+"></asp:ListItem>
                            <asp:ListItem Text="B-" Value="B-"></asp:ListItem>
                            <asp:ListItem Text="AB+" Value="AB+"></asp:ListItem>
                            <asp:ListItem Text="AB-" Value="AB-"></asp:ListItem>
                            <asp:ListItem Text="O+" Value="O+"></asp:ListItem>
                            <asp:ListItem Text="O-" Value="O-"></asp:ListItem>
                        </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvBlood" runat="server"
                        ControlToValidate="ddlBloodgroup"
                        InitialValue=""
                        ErrorMessage="Select Blood Group"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="AccountGroup"/>
                </div>
                 <div class="form-field">
                    <label>PF Number:</label>
                    <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="rfvPF" runat="server"
                        ControlToValidate="TextBox2"
                        InitialValue=""
                        ErrorMessage="Enter PF Number"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="AccountGroup"/>
                </div>
                <div class="form-field">
                    <label>ESI Number:</label>
                    <asp:TextBox ID="txtESI_Number" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvESI" runat="server"
                        ControlToValidate="txtESI_Number"
                        InitialValue=""
                        ErrorMessage="Enter ESI Number"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="AccountGroup"/>
                </div>
            <div class="form-field">
                <label>PAN:  </label>
                <asp:TextBox ID="TextBox3" runat="server" ></asp:TextBox>
            </div>

            <div class="form-field">
                <label>Aadhar Number:</label>
                <asp:TextBox ID="TextBox7" runat="server" oninput="validateAadharNumber(this);" ></asp:TextBox>
                <span id="aadharError" class="required-validator" style="display: none;">Please enter a valid 12-digit Aadhar Number (numeric only).</span>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                        ControlToValidate="TextBox7"
                        InitialValue=""
                        ErrorMessage="Enter Aadhar Number"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="AccountGroup"/>
            </div>
                <div class="form-field">
                <label>Date of Joining:</label>
                <asp:TextBox ID="txtDate_Of_Joining" runat="server"  ClientIDMode="Static"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfv" runat="server"
                        ControlToValidate="txtDate_Of_Joining"
                        InitialValue=""
                        ErrorMessage="Enter DOJ"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="AccountGroup"/>
                </div>
            <div class="form-field">
                <label>City: </label>
                <asp:TextBox ID="txtCity" runat="server" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvCity" runat="server"
                        ControlToValidate="txtCity"
                        InitialValue=""
                        ErrorMessage="Enter City"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="AccountGroup"/>
            </div>
            <div class="form-field">
                <label>Pincode: </label>
                <asp:TextBox ID="txtPincode" runat="server" oninput="validatePincode(this);"></asp:TextBox>
                <span id="pincodeError" class="required-validator" style="display: none;">Please enter a valid Pincode (numeric only).</span>
                <asp:RequiredFieldValidator ID="rfvPincode" runat="server"
                        ControlToValidate="txtPincode"
                        InitialValue=""
                        ErrorMessage="Enter Pincode"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="AccountGroup"/>
            </div>
           
            <div class="form-field">
                <label>Address: </label>
                <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Rows="3" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvAddress" runat="server"
                        ControlToValidate="txtAddress"
                        InitialValue=""
                        ErrorMessage="Enter Address"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="AccountGroup"/>
            </div>
                
        </div>
    </div>

    <!-- Account Details Section -->
    <div class="form-section">
        <h2>Account Details</h2>
        <div class="form-field">
            <label>Employee ID:</label>
            <asp:TextBox ID="txtEmpID_account" runat="server" ></asp:TextBox>
        </div>
        <div class="form-field">
                <label>Employee Name: </label>
                <asp:TextBox ID="txtEmpName_account" runat="server" ></asp:TextBox>
        </div>
 
            <div class="form-field">
                <label>Bank Name:  </label>
                <asp:TextBox ID="txtBankName" runat="server" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvBank" runat="server"
                        ControlToValidate="txtBankName"
                        InitialValue=""
                        ErrorMessage="Enter Bank Name"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="AccountGroup"/>
            </div>
            <div class="form-field">
                <label>Account Number:  </label>
                <asp:TextBox ID="txtAccountNumber" runat="server" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvAccount" runat="server"
                        ControlToValidate="txtAccountNumber"
                        InitialValue=""
                        ErrorMessage="Enter Account Number"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="AccountGroup"/>
            </div>
            <div class="form-field">
                <label>Branch:  </label>
                <asp:TextBox ID="txtBranch" runat="server" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvBranch" runat="server"
                        ControlToValidate="txtBranch"
                        InitialValue=""
                        ErrorMessage="Enter Branch"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="AccountGroup"/>
            </div>
            <div class="form-field">
                <label>IFSC Code:  </label>
                <asp:TextBox ID="txtIFSCCode" runat="server" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvIFSC" runat="server"
                        ControlToValidate="txtIFSCCode"
                        InitialValue=""
                        ErrorMessage="Enter IFSC Code"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="AccountGroup"/>
            </div>
        
    </div>
     
    <!-- Family Details Section -->
    <div class="form-section">
        <h2>Family Details</h2>
        <div class="form-field">
            <label>Employee ID: </label>
            <asp:TextBox ID="txtEmpID_family" runat="server" ></asp:TextBox>
        </div>
        <div class="form-field">
                <label>Employee Name: </label>
                <asp:TextBox ID="txtEmpName_family" runat="server" ></asp:TextBox>
        </div>
        <div class="form-field">
            <label>Marital Status:</label>
            <asp:DropDownList ID="ddlMaritalStatus" runat="server" onchange="toggleSpouseOption()">
                <asp:ListItem Text="Select" Value=""></asp:ListItem>
                <asp:ListItem Text="Married" Value="Married"></asp:ListItem>
                <asp:ListItem Text="Unmarried" Value="Unmarried"></asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfvMarital" runat="server"
                        ControlToValidate="ddlMaritalStatus"
                        InitialValue=""
                        ErrorMessage="Select Marital Status"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="AccountGroup"/>
        </div>
         <div class="form-field">
                <label>Nominee Name: </label>
                <asp:TextBox ID="txtnn" runat="server" ></asp:TextBox>
             <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                        ControlToValidate="txtnn"
                        InitialValue=""
                        ErrorMessage="Enter Nominee Name"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="AccountGroup"/>
                
            </div>
         <div class="form-field">
                <label>Nominee Relation to Employee: </label>
                <asp:DropDownList ID="ddlnr" runat="server">
                <asp:ListItem Text="Select" Value=""></asp:ListItem>
                <asp:ListItem Text="Spouse" Value="Spouse"></asp:ListItem>
                <asp:ListItem Text="Sister" Value="Sister"></asp:ListItem>
                <asp:ListItem Text="Brother" Value="Brother"></asp:ListItem>
                <asp:ListItem Text="Son" Value="Son"></asp:ListItem>
                <asp:ListItem Text="Daughter" Value="Daughter"></asp:ListItem>
                <asp:ListItem Text="Others" Value="Others"></asp:ListItem>
                    </asp:DropDownList>
             <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                        ControlToValidate="ddlnr"
                        InitialValue=""
                        ErrorMessage="Select Relationship"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="AccountGroup"/>
                
            </div>
         <div class="form-field">
                <label>Nominee Mobile: </label>
                <asp:TextBox ID="txtnm" runat="server" ></asp:TextBox>
             <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                        ControlToValidate="txtnm"
                        InitialValue=""
                        ErrorMessage="Enter Nominee Mobile No."
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="AccountGroup"/>
                
            </div>
         <div class="form-field">
                <label>Nominee Bank Account Number: </label>
                <asp:TextBox ID="txtnban" runat="server" ></asp:TextBox>
             <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                        ControlToValidate="txtnban"
                        InitialValue=""
                        ErrorMessage="Enter Nominee Account No."
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="AccountGroup"/>
                
            </div>
      
</div>

     
    
    <asp:Button ID="btnSaveDetails" runat="server" Text="Save Details" OnClick="btnSaveDetails_Click" CssClass="fetch-button" ValidationGroup="AccountGroup"/>

    <script>
        $("#txtDOB").datepicker({
            dateFormat: "dd-mm-yy", 
            changeMonth: true,
            changeYear: true,
            yearRange: "-100:+0",
            onSelect: function (dateText) {
                calculateAge(dateText);
            }
        });

        $("#txtDate_Of_Joining").datepicker({
            dateFormat: "dd-mm-yy", 
            changeMonth: true,
            changeYear: true,
            yearRange: "-100:+0",
        });

        function calculateAge(dateOfBirth) {
            // Split the date into day, month, and year
            var parts = dateOfBirth.split('-');
            var day = parseInt(parts[0], 10);
            var month = parseInt(parts[1], 10);
            var year = parseInt(parts[2], 10);

            // Create Date objects for birthdate and today
            var dob = new Date(year, month - 1, day); // Month is 0-based
            var today = new Date();

            // Calculate the age
            var age = today.getFullYear() - dob.getFullYear();
            var monthDiff = today.getMonth() - dob.getMonth();

            if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < dob.getDate())) {
                age--;
            }

            // Update the age field
            $("#txtAge").val(age);
        }
        function validatePincode(input) {
            var pincode = input.value;
            var pincodeError = document.getElementById("pincodeError");

            // Use regular expression to check if the input is numeric
            var isNumeric = /^\d+$/.test(pincode);

            if (!isNumeric) {
                // Display the error message
                pincodeError.style.display = "inline";
            } else {
                // Hide the error message
                pincodeError.style.display = "none";
            }
        }
        function validateAadharNumber(input) {
            var aadharNumber = input.value;
            var aadharError = document.getElementById("aadharError");

            // Use regular expression to check if the input is numeric and exactly 12 digits
            var isNumeric = /^\d+$/.test(aadharNumber);
            var hasCorrectLength = aadharNumber.length === 12;

            if (!isNumeric || !hasCorrectLength) {
                // Display the error message
                aadharError.style.display = "inline";
            } else {
                // Hide the error message
                aadharError.style.display = "none";
            }
        }
        function showSuccessNotification() {
            toastr.success('Employee details updated successfully.', 'Success', {
                positionClass: 'toast-top-right',
                closeButton: true,
                progressBar: true
            });
        }

        function showErrorNotification(errorMessage) {
            toastr.error('Error updating employee details.' + errorMessage, {
                positionClass: 'toast-top-right',
                closeButton: true,
                progressBar: true
            });
        }



    </script>


     <script type="text/javascript">
         function toggleSpouseOption() {
             var maritalStatus = document.getElementById('<%= ddlMaritalStatus.ClientID %>').value;
        var nomineeRelationDropdown = document.getElementById('<%= ddlnr.ClientID %>');

             // If Marital Status is "Unmarried", hide the "Spouse" option
             if (maritalStatus === "Unmarried") {
                 for (var i = 0; i < nomineeRelationDropdown.options.length; i++) {
                     if (nomineeRelationDropdown.options[i].value === "Spouse") {
                         nomineeRelationDropdown.options[i].style.display = 'none';
                     }
                 }
             } else {
                 // If Marital Status is not "Unmarried", show the "Spouse" option
                 for (var i = 0; i < nomineeRelationDropdown.options.length; i++) {
                     if (nomineeRelationDropdown.options[i].value === "Spouse") {
                         nomineeRelationDropdown.options[i].style.display = '';
                     }
                 }
             }
         }
     </script>

</asp:Content>
