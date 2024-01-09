<%@ Page Title="AddEmployee" Language="C#" MasterPageFile="~/Admindashboard.Master" AutoEventWireup="true" CodeBehind="AddEmployee.aspx.cs" Inherits="Payroll_Mangmt_sys.AddEmployee" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   
    <style>
        
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
            width: 150px; /* Adjust the width as needed */
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
    .form-field-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            grid-gap: 10px;
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

    </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:HiddenField ID="hidSuccessMessage" runat="server" />
    
    <center>
        
        <h1 class="page-heading">ADD EMPLOYEE DETAILS</h1>
    </center>
    <div>
        <a href="AllEmployees.aspx" class="back-button">Back</a>
    </div>
    
    <!-- Personal Details Section -->
    <div class="form-section">
        <h2>Personal Details</h2>
        <div class="form-field-grid">
            <div class="form-field">
                <label>Location:</label>
                <asp:DropDownList ID="ddlOfficeLocation" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlLocation_SelectedIndexChanged">
                    <asp:ListItem Text="Select Location" Value=""></asp:ListItem>
                    <asp:ListItem Text="Pathur" Value="Pathur"></asp:ListItem>
                    <asp:ListItem Text="Tunikibollaram" Value="Tunikibollaram"></asp:ListItem>
                    <asp:ListItem Text="Westbengal" Value="WestBengal"></asp:ListItem>
                    <asp:ListItem Text="Toopran" Value="Toopran"></asp:ListItem>
                    <asp:ListItem Text="Kodakandla" Value="Kodakandla"></asp:ListItem>
                    <asp:ListItem Text="Eluru" Value="Eluru"></asp:ListItem>
                    <asp:ListItem Text="Medchal" Value="Medchal"></asp:ListItem>
                </asp:DropDownList>
            </div>
        <div class="form-field">
            <label>Employee ID: <span class="required-field">*</span></label>
            <asp:TextBox ID="txtEmployeeID" runat="server" ></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvEmpID" runat="server"
                    ControlToValidate="txtEmployeeID"
                    InitialValue=""
                    ErrorMessage="Employee ID is required"
                    Display="Dynamic"
                    ForeColor="Red"
                    CssClass="required-validator"
                    ValidationGroup="PersonalGroup"/>
        </div>
            <div class="form-field">
            <label>Biometric Code: <span class="required-field">*</span></label>
            <asp:TextBox ID="TextBox3" runat="server" ></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server"
                    ControlToValidate="TextBox3"
                    InitialValue=""
                    ErrorMessage="Biometric Code is required"
                    Display="Dynamic"
                    ForeColor="Red"
                    CssClass="required-validator"
                    ValidationGroup="PersonalGroup"/>
        </div>
        <div class="form-field">
                <label>Employee Name:<span class="required-field">*</span> </label>
                <asp:TextBox ID="txtEmployeeName" runat="server" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEmpName" runat="server"
                        ControlToValidate="txtEmployeeName"
                        InitialValue=""
                        ErrorMessage="Employee Name is required"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="PersonalGroup"/>
        </div>
            <div class="form-field">
                <label>Mobile Number:<span class="required-field">*</span> </label>
                <asp:TextBox ID="TextBox6" runat="server" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvMobile" runat="server"
                        ControlToValidate="TextBox6"
                        InitialValue=""
                        ErrorMessage="Mobile No. is required"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="PersonalGroup"/>

            </div>
            <div class="form-field">
                <label>Email ID:<span class="required-field">*</span> </label>
                <asp:TextBox ID="TextBox1" runat="server" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                        ControlToValidate="TextBox1"
                        InitialValue=""
                        ErrorMessage="EmailID is required"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="PersonalGroup"/>
            </div>
            <div class="form-field">
                <label>Date of Birth:<span class="required-field">*</span> </label>
                <asp:TextBox ID="txtDOB" runat="server"  ClientIDMode="Static" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvDOB" runat="server"
                        ControlToValidate="txtDOB"
                        InitialValue=""
                        ErrorMessage="DOB is required"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="PersonalGroup"/>
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
                <label>Gender:<span class="required-field">*</span> </label>
                <asp:DropDownList ID="ddlGender" runat="server">
                    <asp:ListItem Text="Select" Value=""></asp:ListItem>
                    <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                    <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                    <asp:ListItem Text="Others" Value="Female"></asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvGender" runat="server"
                        ControlToValidate="ddlGender"
                        InitialValue=""
                        ErrorMessage="Gender is required"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="PersonalGroup"/>
               
            </div>

                 <div class="form-field">
                <label>Designation: <span class="required-field">*</span></label>
                <asp:TextBox ID="TextBox4" runat="server" ></asp:TextBox>
                     <asp:RequiredFieldValidator ID="rfvDesignation" runat="server"
                        ControlToValidate="TextBox4"
                        InitialValue=""
                        ErrorMessage="Designation is required"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="PersonalGroup"/>
            </div>
            <div class="form-field">
                <label>CTC Gross: <span class="required-field">*</span></label>
                <asp:TextBox ID="TextBox5" runat="server" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvCTC" runat="server"
                        ControlToValidate="TextBox5"
                        InitialValue=""
                        ErrorMessage="CTC is required"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="PersonalGroup"/>
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
                        ValidationGroup="PersonalGroup"/>
                </div>
                <div class="form-field">
                        <label>Blood Group:<span class="required-field">*</span></label>
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
                        ErrorMessage="BloodGroup is required"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="PersonalGroup"/>
                </div>
                 <div class="form-field">
                    <label>PF Number:</label>
                    <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                    
                </div>
                <div class="form-field">
                    <label>ESI Number:</label>
                    <asp:TextBox ID="txtESI_Number" runat="server"></asp:TextBox>
                    
                </div>
                <div class="form-field">
                <label>PAN:  </label>
                <asp:TextBox ID="txtPAN" runat="server" ></asp:TextBox>
            </div>

            <div class="form-field">
                <label>Aadhar Number: <span class="required-field">*</span> </label>
                <asp:TextBox ID="txtAadharNumber" runat="server" oninput="validateAadharNumber(this);" ></asp:TextBox>
                <span id="aadharError" class="required-validator" style="display: none;">Please enter a valid 12-digit Aadhar Number (numeric only).</span>
                <asp:RequiredFieldValidator ID="rfvAadhar" runat="server"
                        ControlToValidate="txtAadharNumber"
                        InitialValue=""
                        ErrorMessage="Enter Aadhar Number"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="PersonalGroup"/>
            </div>

                <div class="form-field">
                <label>Date of Joining:<span class="required-field">*</span></label>
                <asp:TextBox ID="txtDate_Of_Joining" runat="server"  ClientIDMode="Static"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvDOJ" runat="server"
                        ControlToValidate="txtDate_Of_Joining"
                        InitialValue=""
                        ErrorMessage="DOJ is required"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="PersonalGroup"/>
                </div>
            <div class="form-field">
                <label>City: <span class="required-field">*</span></label>
                <asp:TextBox ID="txtCity" runat="server" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvCity" runat="server"
                        ControlToValidate="txtCity"
                        InitialValue=""
                        ErrorMessage="City is required"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="PersonalGroup"/>
            </div>
            <div class="form-field">
                <label>Pincode: <span class="required-field">*</span></label>
                <asp:TextBox ID="txtPincode" runat="server" oninput="validatePincode(this);"></asp:TextBox>
                <span id="pincodeError" class="required-validator" style="display: none;">Please enter a valid Pincode (numeric only).</span>
                <asp:RequiredFieldValidator ID="rfvPin" runat="server"
                        ControlToValidate="txtPincode"
                        InitialValue=""
                        ErrorMessage="Pincode is required"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="PersonalGroup"/>
            </div>
           
            <div class="form-field">
                <label>Address: <span class="required-field">*</span></label>
                <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Rows="3" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvAddress" runat="server"
                        ControlToValidate="txtAddress"
                        InitialValue=""
                        ErrorMessage="Address is required"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="PersonalGroup"/>
            </div>
                 <div class="form-field">
                        <label>Employee Type:<span class="required-field">*</span></label>
                        <asp:DropDownList ID="Emp_type" runat="server">
                            <asp:ListItem Text="Select" Value=""></asp:ListItem>
                            <asp:ListItem Text="FullTime Employee" Value="Contract"></asp:ListItem>
                            <asp:ListItem Text="Temporary Employee" Value="Fulltime"></asp:ListItem>
                        </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                        ControlToValidate="Emp_type"
                        InitialValue=""
                        ErrorMessage="Employee Type is required"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="PersonalGroup"/>
                </div>
        </div>
        <asp:Button ID="SavePersonalDetails" runat="server" Text="Save" OnClick="SavePersonalDetails_Click" CssClass="save-button" ValidationGroup="PersonalGroup" OnClientClick="return validateDOBAndDOJ();"/>
            <asp:Button ID="CancelPersonalDetails" runat="server" Text="Cancel" OnClick="CancelPersonalDetails_Click" CssClass="cancel-button" />
    </div>

    <!-- Account Details Section -->
    <div class="form-section">
        <h2>Account Details</h2>
        <div class="form-field">
                <label>Location:</label>
                <asp:DropDownList ID="ddlOfficeLocation_Account" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlLocation_SelectedIndexChanged">
                    <asp:ListItem Text="Select Location" Value=""></asp:ListItem>
                    <asp:ListItem Text="Pathur" Value="Pathur"></asp:ListItem>
                    <asp:ListItem Text="Tunikibollaram" Value="Tunikibollaram"></asp:ListItem>
                    <asp:ListItem Text="Westbengal" Value="WestBengal"></asp:ListItem>
                    <asp:ListItem Text="Toopran" Value="Toopran"></asp:ListItem>
                    <asp:ListItem Text="Kodakandla" Value="Kodakandla"></asp:ListItem>
                    <asp:ListItem Text="Eluru" Value="Eluru"></asp:ListItem>
                    <asp:ListItem Text="Medchal" Value="Medchal"></asp:ListItem>
                </asp:DropDownList>
            </div>
        <div class="form-field">
            <label>Employee ID:<span class="required-field">*</span></label>
            <asp:ScriptManager ID="ScriptManager1" runat="server" />
            <asp:TextBox ID="txtEmpID_account" runat="server" onblur="fetchEmployeeNameAccount();" AutoPostBack="false" OnTextChanged="txtEmployeeID_TextChanged"></asp:TextBox>
               <ajaxToolkit:AutoCompleteExtender ID="autoCompleteEmployeeID" runat="server"
                TargetControlID="txtEmpID_account"
                ServiceMethod="GetEmployeeIDSuggestions"
                MinimumPrefixLength="1"
                CompletionInterval="1000"
                EnableCaching="true"
                CompletionSetCount="10"
                FirstRowSelected="true"
                CompletionListCssClass="autocomplete-list"
                CompletionListItemCssClass="autocomplete-item" />
            <asp:RequiredFieldValidator ID="rfvEmpID_Account" runat="server"
                        ControlToValidate="txtEmpID_account"
                        InitialValue=""
                        ErrorMessage="Enter EmployeeID"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="AccountGroup"/>
        </div>
        <div class="form-field">
                <label>Employee Name: </label>
                <asp:TextBox ID="txtEmpName_account" runat="server" ></asp:TextBox>

        </div>
        
            <div class="form-field">
                 <label for="DropDownList1">Bank Name:<span class="required-field">*</span>  </label>
 
              <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="False">
                    <asp:ListItem Text="Select Bank" Value="" Selected="True"></asp:ListItem>
                  <asp:ListItem Value="AIRP" Text="Airtel Payments Bank"></asp:ListItem>
                    <asp:ListItem Value="APGB" Text="Andhra Pragathi Grameena Bank"></asp:ListItem>
                    <asp:ListItem Value="APGV" Text="Andhra Pradesh Grameena Vikas Bank"></asp:ListItem>
                    <asp:ListItem Value="BARB" Text="Bank of Baroda"></asp:ListItem>
                    <asp:ListItem Value="BKID" Text="Bank of India"></asp:ListItem>
                    <asp:ListItem Value="CBIN" Text="Central Bank of India"></asp:ListItem>
                    <asp:ListItem Value="CIUB" Text="City Union Bank"></asp:ListItem>
                    <asp:ListItem Value="DCBL" Text="DCB Bank"></asp:ListItem>
                    <asp:ListItem Value="DLXB" Text="Dhanlaxmi Bank"></asp:ListItem>
                    <asp:ListItem Value="EDBK" Text="Ellaquai Dehati Bank"></asp:ListItem>
                    <asp:ListItem Value="ESFB" Text="Equitas Small Finance Bank"></asp:ListItem>
                    <asp:ListItem Value="FDRL" Text="Federal Bank"></asp:ListItem>
                    <asp:ListItem Value="FINO" Text="Fino Payments Bank"></asp:ListItem>
                    <asp:ListItem Value="GSCB" Text="Goa State Co-operative Bank Ltd."></asp:ListItem>
                    <asp:ListItem Value="HDFC" Text="HDFC Bank"></asp:ListItem>
                    <asp:ListItem Value="HPGB" Text="Himachal Pradesh Gramin Bank"></asp:ListItem>
                    <asp:ListItem Value="IBKL" Text="IDBI Bank"></asp:ListItem>
                    <asp:ListItem Value="IDFB" Text="IDFC First Bank"></asp:ListItem>
                    <asp:ListItem Value="IDIB" Text="Indian Bank"></asp:ListItem>
                    <asp:ListItem Value="JIOP" Text="Jio Payments Bank"></asp:ListItem>
                    <asp:ListItem Value="JAKA" Text="Jammu and Kashmir Bank"></asp:ListItem>
                    <asp:ListItem Value="JSCB" Text="Jharkhand State Cooperative Bank Ltd."></asp:ListItem>
                    <asp:ListItem Value="KARB" Text="Karnataka Bank"></asp:ListItem>
                    <asp:ListItem Value="KSCAB" Text="Karnataka State Co-operative Apex Bank Ltd."></asp:ListItem>
                    <asp:ListItem Value="KUCB" Text="Karad Urban Co-operative Bank Ltd."></asp:ListItem>
                    <asp:ListItem Value="MAHB" Text="Bank of Maharashtra"></asp:ListItem>
                    <asp:ListItem Value="MCAB" Text="Mahanagar Co-operative Bank Ltd."></asp:ListItem>
                    <asp:ListItem Value="MGBL" Text="Meghalaya Rural Bank"></asp:ListItem>
                    <asp:ListItem Value="NESF" Text="North East Small Finance Bank"></asp:ListItem>
                    <asp:ListItem Value="NNSB" Text="Nagpur Nagrik Sahakari Bank Ltd."></asp:ListItem>
                    <asp:ListItem Value="NSDL" Text="NSDL Payments Bank"></asp:ListItem>
                    <asp:ListItem Value="ODGB" Text="Odisha Gramya Bank"></asp:ListItem>
                    <asp:ListItem Value="ODCB" Text="The Odisha State Co-operative Bank Ltd."></asp:ListItem>
                    <asp:ListItem Value="PSIB" Text="Punjab and Sind Bank"></asp:ListItem>
                    <asp:ListItem Value="PUNB" Text="Punjab National Bank"></asp:ListItem>
                    <asp:ListItem Value="PTPB" Text="Paytm Payments Bank"></asp:ListItem>
                    <asp:ListItem Value="RATN" Text="RBL Bank"></asp:ListItem>
                    <asp:ListItem Value="RNSB" Text="Rajkot Nagrik Sahakari Bank Ltd."></asp:ListItem>
                    <asp:ListItem Value="SBIN" Text="State Bank of India"></asp:ListItem>
                    <asp:ListItem Value="SVCB" Text="Shamrao Vithal Co-operative Bank Ltd."></asp:ListItem>
                    <asp:ListItem Value="UTSF" Text="Unity Small Finance Bank"></asp:ListItem>
                    <asp:ListItem Value="UTSF1" Text="Utkarsh Small Finance Bank"></asp:ListItem>
                    <asp:ListItem Value="UTGB" Text="Uttarakhand Gramin Bank"></asp:ListItem>
                    <asp:ListItem Value="VCUB" Text="Vasavi Coop Urban Bank Limited"></asp:ListItem>
                    <asp:ListItem Text="Others" Value="Others"></asp:ListItem>
                    
                </asp:DropDownList>

                <div id="otherBankDetails" style="display: none;">
                    <label for="bankNameInput">Enter Bank Name:</label>
                    <input type="text" id="bankNameInput" runat="server" />
                    <br />
                    <label for="ifscCodeInput">Enter IFSC Code:</label>
                    <input type="text" id="ifscCodeInput" runat="server"/>
                </div>
                 <span></span>
                <asp:RequiredFieldValidator ID="rfvBankName" runat="server"
                        ControlToValidate="DropDownList1"
                        InitialValue=""
                        ErrorMessage="Enter Bank Name"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="AccountGroup"/>
            </div>
            <div class="form-field">
                <label>Account Number: <span class="required-field">*</span> </label>
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
                <label>Branch: </label>
                <asp:TextBox ID="txtBranch" runat="server" ></asp:TextBox>
                
            </div>
           <div class="form-field">
                    <label id="cod">IFSC Code: <span class="required-field">*</span> </label>
                    
                        <span id="prefilledIFSC" runat="server"></span>
                        <input type="text" id="txtEditableIFSC" runat="server" onkeyup="ValidateIFSC();" onchange="ValidateIFSC();" />
                   
                    <span ID="ifscValidationMessage" runat="server" style="color: red;"></span><br /><br />
                   
                </div>
        <asp:Button ID="SaveAccountDetails" runat="server" Text="Save" OnClick="SaveAccountDetails_Click" CssClass="save-button" ValidationGroup="AccountGroup"/>
            <asp:Button ID="CancelAccountDetails" runat="server" Text="Cancel" OnClick="CancelAccountDetails_Click" CssClass="cancel-button" />
        
    </div>
     
    <!-- Family Details Section -->
    <div class="form-section">
        <h2>Family Details</h2>
        <div class="form-field">
                <label>Location:</label>
                <asp:DropDownList ID="ddlOfficeLocation_Family" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlLocation_SelectedIndexChanged">
                    <asp:ListItem Text="Select Location" Value=""></asp:ListItem>
                    <asp:ListItem Text="Pathur" Value="Pathur"></asp:ListItem>
                    <asp:ListItem Text="Tunikibollaram" Value="Tunikibollaram"></asp:ListItem>
                    <asp:ListItem Text="Westbengal" Value="WestBengal"></asp:ListItem>
                    <asp:ListItem Text="Toopran" Value="Toopran"></asp:ListItem>
                    <asp:ListItem Text="Kodakandla" Value="Kodakandla"></asp:ListItem>
                    <asp:ListItem Text="Eluru" Value="Eluru"></asp:ListItem>
                    <asp:ListItem Text="Medchal" Value="Medchal"></asp:ListItem>
                </asp:DropDownList>
            </div>
        <div class="form-field">
            <label>Employee ID:<span class="required-field">*</span> </label>
             <asp:TextBox ID="txtEmpID_family" runat="server" onblur="fetchEmployeeNameFamily();" AutoPostBack="false" OnTextChanged="txtEmployeeID_TextChanged"></asp:TextBox>
                  <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server"
                TargetControlID="txtEmpID_family"
                ServiceMethod="GetEmployeeIDSuggestions"
                MinimumPrefixLength="1"
                CompletionInterval="1000"
                EnableCaching="true"
                CompletionSetCount="10"
                FirstRowSelected="true"
                CompletionListCssClass="autocomplete-list"
                CompletionListItemCssClass="autocomplete-item"/>
            <asp:RequiredFieldValidator ID="rfvEmpID_Family" runat="server"
                        ControlToValidate="txtEmpID_family"
                        InitialValue=""
                        ErrorMessage="Enter EmployeeID"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="FamilyGroup"/>
        </div>
        <div class="form-field">
                <label>Employee Name: </label>
                <asp:TextBox ID="txtEmpName_family" runat="server" ></asp:TextBox>
        </div>
        <div class="form-field">
            <label>Marital Status:<span class="required-field">*</span></label>
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
                        ValidationGroup="FamilyGroup"/>

        </div>
         <div class="form-field">
                <label>Nominee Name:<span class="required-field">*</span></label>
                <asp:TextBox ID="txtnn" runat="server" ></asp:TextBox>
             <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                        ControlToValidate="txtnn"
                        InitialValue=""
                        ErrorMessage="Enter Nominee Name"
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="FamilyGroup"/>
                
            </div>
         <div class="form-field">
                <label>Nominee Relation to Employee:<span class="required-field">*</span></label>
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
                        ValidationGroup="FamilyGroup"/>
                
            </div>
         <div class="form-field">
                <label>Nominee Mobile:<span class="required-field">*</span></label>
                <asp:TextBox ID="txtnm" runat="server" ></asp:TextBox>
             <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                        ControlToValidate="txtnm"
                        InitialValue=""
                        ErrorMessage="Enter Nominee Mobile No."
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="FamilyGroup"/>
                
            </div>
         <div class="form-field">
                <label>Nominee Bank Account Number:<span class="required-field">*</span></label>
                <asp:TextBox ID="txtnban" runat="server" ></asp:TextBox>
             <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                        ControlToValidate="txtnban"
                        InitialValue=""
                        ErrorMessage="Enter Nominee Account No."
                        Display="Dynamic"
                        ForeColor="Red"
                        CssClass="required-validator"
                        ValidationGroup="FamilyGroup"/>
                
            </div>
        <asp:Button ID="SaveFamilyDetails" runat="server" Text="Save" OnClick="SaveFamilyDetails_Click" CssClass="save-button" ValidationGroup="FamilyGroup"/>
            <asp:Button ID="CancelFamilyDetails" runat="server" Text="Cancel" OnClick="CancelFamilyDetails_Click" CssClass="cancel-button" />
      
</div>

     
    
    
        


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

        function validateDOBAndDOJ() {
            var dob = $("#txtDOB").val(); // Get DOB value
            var doj = $("#txtDate_Of_Joining").val(); // Get DOJ value

            if (dob !== '' && doj !== '') {
                var dobDate = new Date(dob);
                var dojDate = new Date(doj);

                if (dobDate >= dojDate) {
                    // Display an error message
                    toastr.error("Date of Birth must be greater than Date of Joining.");
                    return false; // Prevent form submission
                }
            }

            return true; // Allow form submission
        }



        function calculateAge(dateOfBirth) {
            var dob = new Date(dateOfBirth);
            var today = new Date();
            var age = today.getFullYear() - dob.getFullYear();
            var monthDiff = today.getMonth() - dob.getMonth();
            if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < dob.getDate())) {
                age--;
            }
            $("#txtAge").val(age);
        }

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

    
            
            function fetchEmployeeNameAccount()
            {
                var txtEmployeeID = document.getElementById('<%= txtEmpID_account.ClientID %>');
                var txtEmployeeName = document.getElementById('<%= txtEmpName_account.ClientID %>');

                 // Get the entered or selected Employee ID
                 var selectedEmpID = txtEmployeeID.value;
                
                 // Make an AJAX request to fetch the Employee Name
                $.ajax({
                    type: "POST",
                    url: "AddEmployee.aspx/GetEmployeeName",
                    data: JSON.stringify({ selectedEmpID: selectedEmpID }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        // Check if the response contains a valid employee name
                        if (response.d) {
                            // Update the Employee Name field with the fetched name
                            txtEmployeeName.value = response.d;
                        } else {
                            // Display an error message for invalid Employee ID
                            toastr.error('Account Details: Invalid EmployeeID');
                        }
                    },
                    error: function (xhr) {
                        // Handle other errors (e.g., network issues)
                        var errorMessage = xhr.status + ': ' + xhr.statusText;
                        toastr.error('Error fetching data: ' + errorMessage);
                    }
                });
                
            }
            
       
        function fetchEmployeeNameFamily() {
            var txtEmployeeID = document.getElementById('<%= txtEmpID_family.ClientID %>');
             var txtEmployeeName = document.getElementById('<%= txtEmpName_family.ClientID %>');

             // Get the entered or selected Employee ID
             var selectedEmpID = txtEmployeeID.value;
            
             // Make an AJAX request to fetch the Employee Name
            $.ajax({
                type: "POST",
                url: "AddEmployee.aspx/GetEmployeeName",
                data: JSON.stringify({ selectedEmpID: selectedEmpID }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    // Check if the response contains a valid employee name
                    if (response.d) {
                        // Update the Employee Name field with the fetched name
                        txtEmployeeName.value = response.d;
                    } else {
                        // Display an error message for invalid Employee ID
                        toastr.error('Family Details: Invalid EmployeeID');
                    }
                },
                error: function (xhr) {
                    // Handle other errors (e.g., network issues)
                    var errorMessage = xhr.status + ': ' + xhr.statusText;
                    toastr.error('Error fetching data: ' + errorMessage);
                }
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
 <script type="text/javascript">
         $(document).ready(function () {
             $('#<%= DropDownList1.ClientID %>').change(function () {
                 var selectedValue = $(this).val();
                 if (selectedValue === "Others") {
                     $('#otherBankDetails').show();
                     $('#<%= prefilledIFSC.ClientID %>').hide();
                $('#<%=txtEditableIFSC.ClientID %>').hide();
                $('#cod').hide();
                


            } else {
                $('#otherBankDetails').hide();
                $('#<%= prefilledIFSC.ClientID %>').text(selectedValue).show();
                    $('#<%=txtEditableIFSC.ClientID %>').show();
                    $('#cod').show();

                }
            });
    });
 </script>
</asp:Content>



