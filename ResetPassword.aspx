<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResetPassword.aspx.cs" Inherits="Payroll_Mangmt_sys.ResetPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Forgot Password</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500&display=swap"/>
<style>
    body {
        font-family: 'Roboto', sans-serif;
        margin: 0;
        display:flex;
        height:100vh;
        align-items: center;
        padding-left: 150px;
    }
    .forgotpassword-form {
        width: 350px;
        height: 350px;
        padding: 40px;
        padding-top:50px;
        padding-bottom:30px;
        border-radius: 10px;
        background-color:floralwhite; /* Background color */
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.2); /* Box shadow */
        margin-left:200px;
        text-align: center;
        position: relative;
    }
    .form-group {
        margin-bottom: 20px; /* Increased spacing between form elements */
    }
    .btn {
        background-color: #4CAF50;
        color: white;
        padding: 12px 24px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
        transition: background-color 0.3s ease;
        width: 75%;
    }

    .btn:hover {
        background-color: #45a049;
    }

    .logo-image {
        width: 180px;
        padding-top:0px;
        padding-bottom:380px;
        padding-left:0;
       margin-bottom:0;
        height:180px;
        background-image: url('images/logor.png'); /* Update the path to your logo image */
        background-size: contain;
    
        background-repeat: no-repeat;

    }
    .error-message {
        color: red;
        font-weight: bold;
    
        position: absolute;
        text-align: center;
        bottom:0;

        left: 0;
        right: 0;
    }
    .error-message {
        position: absolute;
        bottom: 10px;
        left: 0;
        right: 0;
    }
    .form-control {
            width: 80%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            outline: none;
            transition: border-color 0.3s ease;
        }

        .form-control:focus {
            border-color: #4CAF50; /* Highlight on focus */
        }
    .h2 {
            font-size: 24px;
            font-weight: bold;
            color: #4CAF50;
            margin-bottom: 20px;
        }
    .form-image{
        height:80px;
        width:80px;
        margin-left:600px;
        margin-top:100px;
        padding-top:120px;
    }
    .forgotpassword-form{
        margin-left:60px;
        margin-top: 10px;
        margin-bottom:150px;

    }
    .formForgotPassword{
        margin-top:100px;
        height:50%;
    }
    .control-group{
    margin-top:40px;
    margin-bottom:30px;
    }
    
</style>
</head>
<body>
    <div class="logo-image"></div>
    <form id="formForgotPassword" runat="server">
        <div class="form-image">
        <img src="images/emmm.png" alt="Login Image" />
        </div>
            <div class="forgotpassword-form">
                
                      <div class="container-fluid bg-white">
<div class="container">
<div class="row">
<div class="col-lg-6 mb-5 my-lg-5 py-5 pl-lg-5 offset-3">
<div class="contact-form">
<div id="success"></div>
<h2>Reset Password</h2>
<asp:Label ID="lblErrorMsg" runat="server" Text=""></asp:Label>
<div>
<div class="control-group" style="padding-bottom:5px;">
<asp:TextBox ID="password" runat="server" class="form-control p-4" Placeholder="Enter your password" TextMode="Password"></asp:TextBox>
<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="password" ErrorMessage="Password is required" CssClass="requiredField" ForeColor="Red"></asp:RequiredFieldValidator>
</div>
<div class="control-group" style="padding-bottom:5px;">
<asp:TextBox ID="cpassword" runat="server" class="form-control p-4" Placeholder="Enter your confirm password" TextMode="Password"></asp:TextBox>
<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="cpassword" ErrorMessage="Confirm Password is required" CssClass="requiredField" ForeColor="Red"></asp:RequiredFieldValidator>
<asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="password" ControlToValidate="cpassword" ErrorMessage="Password and confirm password should be same." CssClass="requiredField" ForeColor="Red"></asp:CompareValidator>
</div>
<div style="padding-bottom:5px;">
<asp:Button ID="ResetPwdBtn" runat="server" class="btn btn-primary py-3 px-5" Text="Submit" OnClick="ResetPwdBtn_Click" />
</div>
</div>
</div>
</div>
</div>
</div>
</div>
  </div>
    </form>
</body>
</html>