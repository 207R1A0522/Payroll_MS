<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Intermediate_Superadmin.aspx.cs" Inherits="Payroll_Mangmt_sys.WebForm1" %>

<!DOCTYPE html>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
   <style>
        /* Style for tab buttons */
        .tab-button {
            position: relative;
            overflow: hidden;
            border-radius: 10px; /* Adjust the border-radius as needed */
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
            position: relative;
            transition: transform 0.2s, box-shadow 0.2s,filter 0.2s;
        }

        .tab-button:hover {
            transform: scale(1.05);
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
        }

        .tab-button::before {
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(243, 238, 238, 1.05); /* Adjust opacity here */
    border-radius: inherit;
    pointer-events: none; /* Allow clicks to pass through */
    z-index: -1; /* Place it behind the text */
}

        .tab-button::before {
            left: 0;
            border-bottom-right-radius: 10px;
        }

        .tab-button::after {
            right: 0;
            border-bottom-left-radius: 10px;
        }

        .tab {
            display: inline-block;
            padding: 10px 20px;
            cursor: pointer;
            border: none;
            outline: none;
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
        }

        /* Set background images for tabs */
        .top-row {
            display: flex;
            justify-content: center;
            margin-top: 90px; /* Adjust the margin as needed to move tabs down */
        }

        .bottom-row {
            display: flex;
            justify-content: center;
        }

        .third-row {
            display: flex;
            justify-content: center;
            /* Adjust the margin as needed to move tabs down */
        }

        .tab-button {
            display: inline-block;
            padding: 80px 80px; /* Increase padding for width and height */
            cursor: pointer;
            border: none;
            outline: none;
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
            background-color: transparent;
            margin: 30px;
            cursor: pointer;
            color: #fff; /* Text color */
            font-weight: bold; /* Bold text */
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.8); /* Text shadow for better visibility */
            font-size: 18px;
            width: 300px;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        
        .tab-button:hover {
            transform: scale(1.05);
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
        }

        /* Set background images for tabs */
        #Pathur-tab {
            background-image: url('/images/Pathur.jpeg'); /* Replace with the URL of your image for Pathur */
            color: white;
            /* Replace with the URL of your image */
            font-size: 20px;
            
        }

        #Kodakandla-tab {
            background-image: url('/images/Kodakandla.jpeg'); /* Replace with the URL of your image for Kodakandla */
            color: white;
            font-size: 20px;
        }

        #Tunikibollarm-tab {
            background-image: url('/images/Tunikibollaram.jpeg'); /* Replace with the URL of your image for Tunikibollaram */
            color: white;
            font-size: 20px;
        }

        #Westbengal-tab {
            background-image: url('/images/Westbengal.jpeg'); /* Replace with the URL of your image for West Bengal */
            color: white;
            font-size: 20px;
        }

        #Eluru-tab {
            background-image: url('/images/Eluru.jpeg'); /* Replace with the URL of your image for Eluru */
            color: white;
            font-size: 20px;
        }

        #Toopran-tab {
            background-image: url('/images/Toopran.jpeg'); /* Replace with the URL of your image for Toopran */
            color: white;
            font-size: 20px;
        }

        #Medchal-tab {
            background-image: url('/images/Medchal.jpeg'); /* Replace with the URL of your image for Medchal */
            color: white;
            font-size: 20px;
        }

        /* Show content when tab is clicked */
        .content {
            display: none;
            padding: 20px;
        }

       .logo {
            position: absolute;
            top: 20px; /* Adjust the top position as needed */
            right: 20px; /* Adjust the right position as needed */
            border-radius: 10px;
            width: 115px; /* Adjust the width of the logo */
        }
       .tab-button:hover {
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
        
    }

    .tab-button:hover::before,
    .tab-button:hover::after {
        /* Added styles for highlighting */
        background-color: rgb(243, 238, 238, 0.75);
        
    }
   
    .update-credentials-button {
        position: absolute;
        top: 20px;
        right: 20px;
        cursor: pointer;
    }

    .update-credentials-window {
        display: none;
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        padding: 20px;
        background-color: white;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
        z-index: 999;
    }
    
    .menu-button {
        position: absolute;
        top: 20px;
        left: 20px;
        cursor: pointer;
    }

    .line {
        width: 30px;
        height: 3px;
        background-color: #000;
        margin: 6px 0;
    }

    .menu-content {
        display: none;
        position: absolute;
        top: 50px;
        left: 20px;
        background-color: white;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
        z-index: 999;
    }

    .menu-content button {
        display: block;
        width: 100%;
        padding: 10px;
        text-align: left;
        border: none;
        background: none;
        cursor: pointer;
    }

/* Styles for the Update Credentials form */
.update-credentials-window {
    background-color: #ffffff;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
    padding: 30px;
    border-radius: 10px;
    text-align: center;
    max-width: 400px;
    margin: auto;
}

#locationDropdown,
#usernameTextBox,
#passwordTextBox,
#emailTextBox {
    width: 100%;
    padding: 12px;
    margin: 10px 0;
    box-sizing: border-box;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 16px;
}
.required-field {
            color: red;
            margin-left: 5px;
        }
#btnUpdate {
    background-color: #4caf50;
    color: #ffffff;
    padding: 12px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
    transition: background-color 0.3s;
}

#btnUpdate:hover {
    background-color: #45a049;
}

.close-button {
    position: absolute;
    top: 15px;
    right: 15px;
    cursor: pointer;
    font-size: 24px;
    color: #555;
    transition: color 0.3s;
}

.close-button:hover {
    color: #333;
}

/* Add these styles if you want to customize the appearance of the error messages */
.error-message {
    color: #ff4d4d;
    margin-top: 8px;
}

/* Add styles for the form header */
.update-credentials-window h2 {
    color: #333;
    font-size: 24px;
    margin-bottom: 20px;
}

/* Add styles for the form inputs */
.update-credentials-window input[type="text"],
.update-credentials-window input[type="password"],
.update-credentials-window input[type="email"] {
    display: block;
    width: 100%;
    padding: 12px;
    margin: 10px 0;
    box-sizing: border-box;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 16px;
}

/* Add styles for the form button */
.update-credentials-window button {
    background-color: #4caf50;
    color: #ffffff;
    padding: 12px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
    transition: background-color 0.3s;
}

.update-credentials-window button:hover {
    background-color: #45a049;
}

.eye-icon {
        position: absolute;
        top: 50%;
        right: 15px;
        transform: translateY(-50%);
        cursor: pointer;
    }

    /* Set the styles for the eye symbol */
    
   .eye-icon:after {
        content: '\1F441'; /* Unicode character for an eye symbol */
        font-size: 20px;
        color: #666; /* Color of the eye symbol */
        /* Initial state, strikethrough */
    }

    /* Password input styles */
    .password-input {
        position: relative;
    }
    .password-strength {
        margin-top: 10px;
        font-size: 14px;
        color: #555;
    }

    .strength-check {
        color: #ccc;
        margin-right: 5px;
    }

    /* Style for a strong password */
    .strong-password {
        color: #4caf50;
    }
    .strength-check.valid {
    color: #4caf50; /* Green color for valid criteria */
}
    #cornContainer {
    position: fixed;
    top: 0;
    left: 0;
    width: 100vw;
    height: 100vh;
    pointer-events: none; /* Make the container non-interactive */
    z-index: 9999; /* Ensure the seeds are on top of other elements */
}

.cornSeed {
    width: 20px;
    height: 20px;
    background-color: #ffd700; /* Corn color */
    border-radius: 50%;
    position: absolute;
    transform-origin: center bottom;
    clip-path: polygon(50% 0%, 0% 100%, 100% 100%);
    opacity: 0; /* Make it visible */
}

#cornSeed1 {
    animation: fallAnimation 4s ease-out infinite;
}

#cornSeed2 {
    animation: fallAnimation 4s ease-out 1s infinite; /* Delay the animation start */
}
#cornSeed3 {
    animation: fallAnimation 4s ease-out 2s infinite; /* Delay the animation start */
}
#cornSeed4 {
    animation: fallAnimation 4s ease-out 0.5s infinite; /* Delay the animation start */
}
/* Add more styles for additional corn seeds */
@keyframes fallAnimation {
    0% {
        transform: translateY(0) rotate(0);
        opacity: 1;
    }
    100% {
        transform: translateY(100vh) rotate(360deg);
        opacity: 0;
    }
}
  

</style>

</head>
<body>
    <div class="logo">
        <img src="/images/logor.png" alt="Logo" width="120" height="50" />
    </div>
    
<div class="top-row">
        <!-- Location images for Pathur, West Bengal, Toopran, Kodakandla, Tunikibollaram, Eluru -->
        <div class="tab-button" id="Pathur-tab" onclick="redirectToLocation('Pathur');">Pathur</div>
        <div class="tab-button" id="Westbengal-tab" onclick="redirectToLocation('WestBengal');">West Bengal</div>
        <div class="tab-button" id="Toopran-tab" onclick="redirectToLocation('Toopran');">Toopran</div>
        <div class="tab-button" id="Kodakandla-tab" onclick="redirectToLocation('Kodakandla');">Kodakandla</div>
        <div class="tab-button" id="Tunikibollarm-tab" onclick="redirectToLocation('Tunikibollaram');">Tuniki Bollaram</div>
        <div class="tab-button" id="Eluru-tab" onclick="redirectToLocation('Eluru');">Eluru</div>
    </div>
    <div class="bottom-row">
        <!-- Location image for Medchal -->
        <div class="tab-button" id="Medchal-tab" onclick="redirectToLocation('Medchal');">Medchal</div>
    </div>
    
    <!-- Add the menu icon -->
    <div class="menu-button" onclick="toggleMenu()">
        <div class="line"></div>
        <div class="line"></div>
        <div class="line"></div>
    </div>

    <!-- Create a menu content div -->
    <div class="menu-content" id="menuContent">
        <button onclick="showUpdateCredentialsForm()">Update Credentials</button>
        <button onclick="logout()">Logout</button>
    </div>


    <form id="form1" runat="server">
    <div class="update-credentials-window" id="updateCredentialsWindow">
    <!-- Your form fields go here -->
        <label>Location:<span class="required-field">*</span> </label>
    <asp:DropDownList ID="locationDropdown" runat="server" OnSelectedIndexChanged="locationDropdown_SelectedIndexChanged" AutoPostBack="true">
        <asp:ListItem Text="Select" Value="" />
         <asp:ListItem Text="Pathur" Value="Pathur" />
        <asp:ListItem Text="West Bengal" Value="WestBengal" />
        <asp:ListItem Text="Toopran" Value="Toopran" />
        <asp:ListItem Text="Kodakandla" Value="Kodakandla" />
        <asp:ListItem Text="Tunikibollaram" Value="Tunikibollaram" />
        <asp:ListItem Text="Eluru" Value="Eluru" />
        <asp:ListItem Text="Medchal" Value="Medchal" />
    </asp:DropDownList>
        <label>Username:<span class="required-field">*</span> </label>
    <asp:TextBox ID="usernameTextBox" runat="server" placeholder="Username"></asp:TextBox>
   <div class="password-input">
       <label>Password:<span class="required-field">*</span> </label>
        <asp:TextBox ID="passwordTextBox" runat="server" placeholder="Password" oninput="checkPasswordStrength(this.value)"></asp:TextBox>
        <div class="eye-icon" onclick="togglePasswordVisibility()" id="eyeIcon"></div>
    <div id="passwordStrength" class="password-strength">
        
    <span id="specialChar" class="strength-check">✓</span>
    <span id="digit" class="strength-check">✓</span>
    <span id="upperCase" class="strength-check">✓</span>
    <span id="lowerCase" class="strength-check">✓</span>
</div>
   </div>
        <br />
        <label>Email ID:<span class="required-field">*</span> </label>
    <asp:TextBox ID="emailTextBox" runat="server" placeholder="Email"></asp:TextBox>
   <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click" OnClientClick="updateCredentials(); return false;" />
    <span class="close-button" onclick="closeUpdateCredentialsForm()">&times;</span>
</div>

        </form>
    <div id="cornContainer">
    <div class="cornSeed" id="cornSeed1">
       
    </div>

    <div class="cornSeed" id="cornSeed2">
         
    </div>
        <div class="cornSeed" id="cornSeed3">
       
    </div>
        <div class="cornSeed" id="cornSeed4">
       
    </div>
    <!-- Add more corn seed elements as needed -->

</div>
 
    

<script>
    function redirectToLocation(location) {
        // Set the session variable based on the selected location
        showContent(location);

        // Redirect to the appropriate page based on the selected location
        if (location === 'Medchal') {
            window.location.href = 'Intermediate_Superadmin.aspx?location=Medchal';
        } else {
            window.location.href = 'Intermediate_Superadmin.aspx?location=' + location;
        }
    }

    function showContent(location) {
        // This function can be used to set the session variable or perform other actions based on the selected location.
        // For demonstration, we'll just alert the location name.
        alert('Selected Location: ' + location);
    }
    function highlightNameOnHover(location) {
        // Find the tab button element by its ID
        var tabButton = document.getElementById(location + '-tab');

        // Add event listener to the tab button for mouseenter and mouseleave
        tabButton.addEventListener('mouseenter', function () {
            // On mouse enter, change the text color to red
            this.style.color = '#000000';
        });

        tabButton.addEventListener('mouseleave', function () {
            // On mouse leave, reset the text color to white
            this.style.color = 'white';
        });
    }

    // Call highlightNameOnHover function for each location
    highlightNameOnHover('Pathur');
    highlightNameOnHover('Westbengal');
    highlightNameOnHover('Toopran');
    highlightNameOnHover('Kodakandla');
    highlightNameOnHover('Tunikibollarm');
    highlightNameOnHover('Eluru');
    highlightNameOnHover('Medchal');
    </script>
   <script>
       $(document).ready(function () {
           // Event handler for the "Update Credentials" button
           $("#update-credentials-button").click(function () {
               // Display the form when the button is clicked
               $("#updatecredentialswindow").css("display", "block");
           });
       });

</script>
    <script>
        function toggleMenu() {
            var menuContent = document.getElementById('menuContent');
            menuContent.style.display = (menuContent.style.display === 'block' ? 'none' : 'block');
        }

        function showUpdateCredentialsForm() {
            // Display the form when the "Update Credentials" button is clicked
            var updateCredentialsWindow = document.getElementById('updateCredentialsWindow');
            updateCredentialsWindow.style.display = 'block';

            // Additional code to populate the location dropdown and other fields can be added here
        }

        function logout() {
            // Implement logout functionality here
            alert('Logout clicked');
            
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
    <script>
        // Function to toggle the visibility of the password
        function togglePasswordVisibility() {
            var passwordInput = document.getElementById('<%= passwordTextBox.ClientID %>');
            var eyeIcon = document.getElementById('eyeIcon');
           
            // Toggle the type attribute of the password input
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                eyeIcon.style.textDecoration = 'none'; // Remove the strikethrough when visible
                eyeIcon.style.color = '#3498db'; // Change the color when the password is visible
                
            } else {
                passwordInput.type = 'password';
                eyeIcon.style.textDecoration = 'line-through'; // Add strikethrough when hidden
                eyeIcon.style.color = '#666'; // Change it back to the original color
               
            }

            
        }
        
        
</script>
    <script>
        function checkPasswordStrength(password) {
            updateStrengthCheck("specialChar", /[!@#$%^&*()_+{}\[\]:;<>,.?~\\/-]/.test(password), "Special Character");
            updateStrengthCheck("digit", /\d/.test(password), "Digit");
            updateStrengthCheck("upperCase", /[A-Z]/.test(password), "Uppercase Letter");
            updateStrengthCheck("lowerCase", /[a-z]/.test(password), "Lowercase Letter");
        }

        function updateStrengthCheck(checkId, isValid, checkName) {
            var checkElement = document.getElementById(checkId);
            if (isValid) {
                checkElement.innerHTML = checkName + ": ✓";
                checkElement.style.color = "green";
            } else {
                checkElement.innerHTML = checkName + ": ✗";
                checkElement.style.color = "black";
            }
            checkElement.innerHTML += "<br>";
        }
</script>
   <script>
       function closeUpdateCredentialsForm() {
           // Close the form when the close button is clicked
           var updateCredentialsWindow = document.getElementById('updateCredentialsWindow');
           updateCredentialsWindow.style.display = 'none';
       }

       function updateCredentials() {
           // Retrieve the updated values from the textboxes
           var updatedUsername = document.getElementById('<%= usernameTextBox.ClientID %>').value;
        var updatedPassword = document.getElementById('<%= passwordTextBox.ClientID %>').value;
        var updatedEmail = document.getElementById('<%= emailTextBox.ClientID %>').value;
           if (!validatePassword(updatedPassword)) {
               // Show an error message or perform any other action based on validation failure
               alert('Password does not meet the required criteria.');
               return;
           }
           // You can perform client-side validation or show a confirmation message here

           // Make an asynchronous call to the server to perform the update
           PageMethods.UpdateCredentials(updatedUsername, updatedPassword, updatedEmail, OnUpdateSuccess, OnUpdateFailure);
       }
       function validatePassword(password) {
           // Use a regular expression to enforce the password criteria
           var passwordRegex = /^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;

           return passwordRegex.test(password);
       }

       function OnUpdateSuccess(result) {
           // Handle success, e.g., show a success message
           alert('Update successful');
       }

       function OnUpdateFailure(error) {
           // Handle failure, e.g., show an error message
           alert('Update failed: ' + error.get_message());
       }
</script>
    <script>
        function showSuccessNotification(section) {
            toastr.success(section, 'Success', {
                positionClass: 'toast-top-right',
                closeButton: true,
                progressBar: true
            });
        }

        function showErrorNotification(section, errorMessage) {
            toastr.error('Error updating '+ errorMessage,{
                positionClass: 'toast-top-right',
                closeButton: true,
                progressBar: true
            });
        }
    </script>
    <script>
    $(document).ready(function () {
    animateCornSeeds();
    });

    function animateCornSeeds() {
        $("#cornContainer").find(".cornSeed").each(function () {
            $(this).css("left", Math.random() * window.innerWidth);
        });
        }
        
    </script>
  
</body>
</html>