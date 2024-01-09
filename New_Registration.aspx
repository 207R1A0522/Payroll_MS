<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="New_Registration.aspx.cs" Inherits="Payroll_Mangmt_sys.New_Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>New Registration</title>
     <style>
        /* Add your CSS styling here */
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            width: 300px;
            background-color: #fff;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        }

        .container h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            font-weight: bold;
        }

        input[type="text"],
        input[type="password"],
        input[type="email"] {
            width: 80%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }

        button {
            background-color: #007bff;
            color: #fff;
            padding: 12px 15px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            width: 100%;
        }

        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Admin Registration</h2>
        <form runat="server" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="Username">Username</label>
                <input type="text" id="Username" name="Username" />
            </div>
            <div class="form-group">
                <label for="Password">Password</label>
                <input type="password" id="Password" name="Password" />
            </div>
            <div class="form-group">
                <label for="ConfirmPassword">Confirm Password</label>
                <input type="password" id="ConfirmPassword" name="ConfirmPassword" />
            </div>
            <div class="form-group">
                <label for="Email">Email</label>
                <input type="email" id="Email" name="Email" />
            </div>
            <button type="submit">Submit</button>
           
        </form>
        <div id="warning" style="color: red; text-align: center;"></div>
    </div>

    <script>
        function validateForm() {
            var username = document.getElementById("Username").value;
            var password = document.getElementById("Password").value;
            var confirmPassword = document.getElementById("ConfirmPassword").value;
            var email = document.getElementById("Email").value;
            var warningDiv = document.getElementById("warning");

            if (username === '' || password === '' || confirmPassword === '' || email === '') {
                warningDiv.innerHTML = "Please fill in all the fields";
                return false; // Prevent form submission
            } else if (password !== confirmPassword) {
                warningDiv.innerHTML = "Password and Confirm Password do not match";
                return false; // Prevent form submission
            } else {
                warningDiv.innerHTML = ''; // Clear the warning message
                window.location.href = 'login1.aspx';
                return false;  // Allow form submission
            }
        }
    </script>
</body></html>
