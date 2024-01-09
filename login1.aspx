<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login1.aspx.cs" Inherits="Payroll_Mangmt_sys.login1" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login Page</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500&display=swap"/>
      <style>
        body {
            font-family: 'Roboto', sans-serif;
            margin: 0;
            display: flex;
            justify-content: flex-start;
            align-items: center;
            height: 100vh;
            padding-left: 150px;
            padding-bottom:0;
        }

        .error-message 
        {
            color: red;
            font-weight: bold;
            position: absolute;
            text-align: center;
            bottom:0;
            left: 0;
            right: 0;
        }

        .login-form {
            width: 350px;
            height: 400px;
            padding: 30px;
            padding-top:40px;
            
            border-radius: 10px;
            margin-top:100px;
            background-color: #f5f5f5; /* Background color */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2); /* Box shadow */
            margin-left: 400px;
            text-align: center;
            position: relative;
            align-items:end;
        }

        .form-group {
            margin-bottom: 20px; /* Increased spacing between form elements */
        }

        label {
            
            text-align: left; /* Align labels to the left */
            display: block; /* Display labels as blocks for line break */
            margin-bottom: 5px; /* Add some margin to separate labels */
        }

        input[type="text"],
        input[type="password"] {
            width: 90%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            transition: border-color 0.3s ease;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            border-color: #4CAF50;
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
            width: 100%;
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
            background-image: url('images/logor.png');
            background-size: contain;
            
            background-repeat: no-repeat;

        }

        .error-message {
            position: absolute;
            bottom: 10px;
            left: 0;
            right: 0;
        }

        .side-panel {
            width: 400px;
            height: 400px;
           
            margin-left: 10px;
            margin-right:120px;
            position: absolute;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: start;
            border-radius: 10px;
            
        }

        .sideup{
            width: 400px;
            height: 400px;
           margin-bottom:180px;
            margin-left: 100px;
            margin-right:10px;
            position: absolute;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: start;
            border-radius: 10px;
        }

        .image-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100%;
            margin-top:100px;
        }

        .image-container img {
            max-width: 100%;
            max-height: 100%;
            display: none; /* Initially hide images */
        }

        .image-container img.active {
            display: block; /* Display the active image */
        }
        .image-dots {
            display: flex;
            justify-content: center;
            margin-top: 10px;
        }

        .image-dot {
            width: 8px;
            height: 8px;
            margin: 0 5px;
            background-color: transparent;
            border: 1px solid #4CAF50; /* Sky blue outline */
            border-radius: 50%;
            cursor: pointer;
        }

        .image-dot.active {
            background-color: #4CAF50; /* Full sky blue for the active dot */
            border-radius: 50%;
            border: 1px solid #4CAF50;
            
        }
        .hidden {
    display: none;
}
        .login-form.initial {
        width: 350px;
        height: 250px; /* Adjust the initial height as needed */
    }

    .login-form.expanded {
        width: 350px;
        height: 400px; /* Adjust the expanded height as needed */
    }
    .dropdown-box {
        width: 90%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        transition: border-color 0.3s ease;
    }

    /* Style for username and password input boxes */
    .input-box {
        width: 90%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        transition: border-color 0.3s ease;
    }
    .sidep{
            width: 400px;
            height: 400px;
           margin-bottom:180px;
            margin-left: 700px;
            margin-right:10px;
            margin-top:0px;
            position: absolute;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: start;
            border-radius: 10px;
        }

    .sidetr {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 10px; /* Add space between logos and location names */
            margin-left: 20px; /* Adjust as needed */
            padding-top: 0;
            text-align: justify;
            font-family: 'Your Chosen Font', sans-serif; /* Replace 'Your Chosen Font' with the desired font */
            
        }

        .sidetr span {
            display: flex;
            align-items: center;
            margin: 10px;
            color: #333;
            transition: background-color 0.3s ease, color 0.3s ease;
            padding: 5px; /* Adjust padding for spacing */
        }

        .sidetr img {
            width: 25px; /* Adjust the image size as needed */
            height: 20px; /* Adjust the image size as needed */
            margin-right: 5px; /* Add space between image and location name */
        }



        
    </style>
</head>
    <body>
    <div class="sidep">
    <div class="sidetr">
        <span><img src="images/pslogo.png" alt="Location 1"/> Pathur</span>
        <span><img src="images/pslogo.png" alt="Location 2"/> Kodakandla</span>
        <span><img src="images/pslogo.png" alt="Location 3"/> Tunikibollaram</span>
        <span><img src="images/pslogo.png" alt="Location 4"/> Eluru</span>
        <span><img src="images/pslogo.png" alt="Location 5"/> Toopran</span>
        <span><img src="images/pslogo.png" alt="Location 6"/> Westbengal</span>
        <span><img src="images/pslogo.png" alt="Location 7"/> Medchal</span>
    </div>
    </div>
      <div class="logo-image"></div>
    
 <div class="side-panel">
    <div class="image-container">
        <img src="images/login4.png" alt="Image 1" class="active" />
        <img src="images/login5.png" alt="Image 2" />
        <img src="images/login6.png" alt="Image 3" />
    </div>
    <div class="image-dots" id="imageDots"></div>
</div>
    
    <form id="form1" runat="server">
        
        <div class="login-form">
            <h2 style="color: #333;">Hello there ! 🖐</h2>
            <br />
            <asp:Panel ID="pnlCredentials" runat="server">
                <div class="form-group">
                    <label for="ddlLocation">Location:</label>
                    <asp:DropDownList ID="ddlLocation" runat="server" CssClass="dropdown-box" onchange="toggleLoginFields()">
                        <asp:ListItem Text="Select Location" Value="" />
                        <asp:ListItem Text="Pathur" Value="Pathur" />
                        <asp:ListItem Text="Kodakandla" Value="Kodakandla" />
                        <asp:ListItem Text="Tunikibollaram" Value="Tunikibollaram" />
                        <asp:ListItem Text="Eluru" Value="Eluru" />
                        <asp:ListItem Text="Toopran" Value="Toopran" />
                        <asp:ListItem Text="Westbengal" Value="Westbengal" />
                        <asp:ListItem Text="Corporate Office(Medchal)" Value="Medchal" />
                    </asp:DropDownList>
                </div>
                <div id="loginFieldsDiv" class="hidden">
                        <div class="form-group">
                            <label for="txtUsername">Username:</label>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="input-box" ></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label for="txtPassword">Password:</label>
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="input-box"></asp:TextBox>
                        </div>
                 </div>
               
               
                <br />
                <asp:Button ID="btnLogin" runat="server" Text="Log In" OnClick="btnLogin_Click" CssClass="btn" />
            </asp:Panel>
            <br />
            <div class="error-message" runat="server" id="divErrorMessage"></div>
        </div>
    </form>
    
    
    <!-- End of side panel -->
    
    <!-- JavaScript to rotate images -->

   <script>
       // Check if there's a login error message in session
       var errorMessage = '<%= Session["LoginErrorMessage"] %>';

       if (errorMessage) {
           // Display the error message in the "divErrorMessage" element
           var errorDiv = document.getElementById('divErrorMessage');
           errorDiv.innerHTML = errorMessage;

        // Clear the error message in session
        <%= Session["LoginErrorMessage"] = null %>;

           // Redirect to login1.aspx after 3 seconds (adjust the delay as needed)
           setTimeout(function () {
               window.location.href = 'login1.aspx';
           }, 1000); // 3 seconds delay
       }
   </script>
        <script>
            // Check if there's a login error message in session
            var errorMessage = '<%= Session["LoginErrorMessage"] %>';

            if (errorMessage) {
                // Display the error message in the "divErrorMessage" element
                var errorDiv = document.getElementById('divErrorMessage');
                errorDiv.innerHTML = errorMessage;

        // Clear the error message in session
        <%= Session["LoginErrorMessage"] = null %>;

                // Redirect to login1.aspx after 3 seconds (adjust the delay as needed)
                setTimeout(function () {
                    window.location.href = 'login1.aspx';
                }, 1000); // 3 seconds delay
            }
   </script>
    <script>
        // Function to toggle visibility of login fields div
        function toggleLoginFields() {
            var ddlLocation = document.getElementById('<%= ddlLocation.ClientID %>');
            var loginFieldsDiv = document.getElementById('loginFieldsDiv');

            if (ddlLocation.value === "") {
                // If "Select" is chosen, hide the login fields div
                loginFieldsDiv.style.display = "none";
                // Apply the initial style to the login panel
                document.querySelector('.login-form').classList.remove('expanded');
                document.querySelector('.login-form').classList.add('initial');
            } else {
                // If a location is chosen, show the login fields div
                loginFieldsDiv.style.display = "block";
                // Apply the expanded style to the login panel
                document.querySelector('.login-form').classList.remove('initial');
                document.querySelector('.login-form').classList.add('expanded');
            }
        }


        // Initially, hide the login fields div when the page loads
        window.onload = function () {
            toggleLoginFields();
        };
                </script>


    <script>
        // Function to rotate images
        // Function to rotate images
        function rotateImages() {
            const images = document.querySelectorAll('.image-container img');
            const dotsContainer = document.getElementById('imageDots');
            let currentIndex = 0;

            // Create dots for each image
            images.forEach((image, index) => {
                const dot = document.createElement('div');
                dot.classList.add('image-dot');
                dot.addEventListener('click', () => {
                    currentIndex = index;
                    showImage(currentIndex);
                });
                dotsContainer.appendChild(dot);
            });

            function showImage(index) {
                images.forEach((image, i) => {
                    if (i === index) {
                        image.classList.add('active');
                        dotsContainer.children[i].classList.add('active');
                    } else {
                        image.classList.remove('active');
                        dotsContainer.children[i].classList.remove('active');
                    }
                });
            }

            function nextImage() {
                currentIndex = (currentIndex + 1) % images.length;
                showImage(currentIndex);
            }

            // Show the first image initially
            showImage(currentIndex);

            // Rotate images every 3 seconds (adjust as needed)
            setInterval(nextImage, 4000);
        }

        // Call the rotateImages function when the document is ready
        document.addEventListener('DOMContentLoaded', rotateImages);
        </script>
</body>
</html>