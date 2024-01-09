<%@ Page Title="" Language="C#" MasterPageFile="~/Admindashboard.Master" AutoEventWireup="true" CodeBehind="SuperAdminDashboard.aspx.cs" Inherits="Payroll_Mangmt_sys.SuperAdminDashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        /* Center the chart on the page */
         .container {
            margin: 20px; /* Adjust the margin as needed */
        }
        #greeting{
            height:40px;
        }
        .row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px; /* Add space below the row */
        }

        /* Center the chart on the page */
        
        #barChart {
            width: 58%; /* Make the chart fill its container */
            
            height:80%; 
        }

        .chart-container {
        width: 58%;
        box-sizing: border-box;
        padding: 20px;
        background-color: #fff;
        border-radius: 5px;
        box-shadow: 0 10px 10px rgba(0, 0, 0, 0.1);
    }

    #report-form {
        width: 38%;
        box-sizing: border-box;
        padding: 20px;
        background-color: #fff;
        border-radius: 5px;
        box-shadow: 0 10px 10px rgba(0, 0, 0, 0.1);
         margin-top: 20px;
    }

    .form-title {
        font-size: 24px;
        margin-bottom: 15px;
        color: #333;
        text-align: center;
    }

    .form-group {
        margin-bottom: 15px;
    }

    .form-label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
        color: #555;
    }

    .form-control {
        width: 100%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
        font-size: 16px;
    }

    .btn-primary {
        display: block;
        width: 100%;
        padding: 12px;
        background-color: #007BFF;
        color: #fff;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
        transition: background-color 0.3s ease;
    }
    .btn-primary:hover {
        background-color: #0056b3; /* Darker shade on hover */
    }
    .add-message-text {
        font-size: 16px;
        margin-left: 10px;
        color:deepskyblue;
    }

    /* Additional styling for consistency */
    .edit-icon {
        cursor: pointer;
        margin-right: 20px;
        display: flex;
        align-items: center;
    }
    #displayData {
        font-size: 18px;
        color: #333;
    }
        /* Widget Styles */
        .widget-container {
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 15px;
            width: 50%;
            margin-bottom: 20px;
            display: none; /* Initially hide all widget containers */
        }
        /* Additional widget styles */
        .widget h2 {
            font-size: 24px;
            margin-bottom: 10px;
        }
        .widget ul {
            list-style-type: none;
            padding: 0;
        }
        .widget ul li {
            margin-bottom: 5px;
        }
        /* Tab Styles */
       .widget-tabs {
           width: 50%;
        display: flex;
        cursor: pointer;
        background-color: #fff; /* Background color for the tabs container */
        border: 1px solid #ddd;
        border-radius: 5px;
        overflow: hidden; /* Hide any overflowing content */
    }
    .widget-tab {
        flex: 0.3; /* Decreased width to 30% of the container */
        text-align: center;
        padding: 15px 0;
        background-color: transparent; /* Transparent background color for inactive tabs */
        color: #555; /* Text color for inactive tabs */
        font-size: 16px;
        font-weight: bold;
        border: none;
        border-bottom: 3px solid transparent; /* Add a transparent border at the bottom */
        transition: all 0.3s ease; /* Smooth transition for hover and active states */
        cursor: pointer;
    }
    .widget-tab.active {
        background-color: #fff; /* Background color for the active tab */
        color: darkviolet; /* Text color for the active tab */
        border-bottom: 3px solid darkviolet; /* Border at the bottom for the active tab */
    }
     .additional-message {
                font-family: Arial, sans-serif;
                font-size: 18px;
                color: #555; /* Dark gray text color */
                margin-top: 10px; /* Add some space between the messages */
      }
      #greeting{
          font-size: 36px;
          font-weight: normal;
          color: #333; 
      }
      .goo{
           display :grid;
           grid-template-columns:1fr 1fr;
           align-items:center;
           position:relative;
           width:100%;
           height:200px;
      }
      /* Message Circles Styles */
        .message-circles {
            text-align: center;
            margin-top: 10px; /* Adjust the spacing */
        }

        .message-circle {
            width: 10px;
            height: 10px;
            background-color: #ccc; /* Default circle color */
            border-radius: 50%; /* Make it a circle */
            display: inline-block;
            margin: 0 5px; /* Adjust the spacing between circles */
            transition: background-color 0.3s ease; /* Smooth transition for background color */
        }

        /* Highlight the active circle */
        .message-circle.active {
            background-color: darkviolet; /* Highlight color for the active circle */
        }
        .previous-message-box {
       border: 1px solid #ddd;
        padding: 15px;
        border-radius: 8px;
        background-color: #f5f5f5;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        margin-top: 15px;
    }

        #dataLabel {
        font-size: 16px;
        color: #333;
        }
        
    </style>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <!-- HTML: Add a data-index attribute to each message for tracking -->
    <div class="goo">
        <div>
            <h1 id="greeting"></h1>
            <h2 class="additional-message" data-index="0">
                <span id="dynamic-message">Payroll: Where time, effort, and precision converge to ensure everyone gets their fair share.</span>
            </h2>
            <!-- Add circles below messages -->
            <div class="message-circles">
                <span class="message-circle active"></span>
                <span class="message-circle"></span>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="chart-container">
            <canvas id="barChart"></canvas>
        </div>
        <!-- Inside the #report-form div -->
       <!-- Inside the #report-form div -->
    <!-- Inside the #report-form div -->
                  <div id="report-form" class="chart-container">
                        <h2 class="form-title">
                             
                            Notice Board</h2>
                       
                       <div id="displayData" class="form-group" >
                         <div class="previous-message-box">
                            <asp:Label ID="dataLabel" runat="server" Text="" CssClass="additional-message"></asp:Label>
                        </div>
                     </div>
                      <div id="penIcon" class="edit-icon" onclick="toggleFormVisibility()">
                           <i class="fas fa-pen"></i>
                          <span class="add-message-text">Add message</span>
                      </div>
                     <div id="formSection" style="display:none;">
                        <div class="form-group">
                            <label for="reportInput" class="form-label">Enter Message:</label>
                            <asp:TextBox ID="reportInput" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <asp:Button ID="submitReport" runat="server" Text="Submit" CssClass="btn-primary" OnClick="submitReport_Click" />
                       
                    </div>
                    </div>


    </div>

 
   
        
    <script>

        // JavaScript code to handle form submission
        function toggleFormVisibility() {
            var formSection = document.getElementById("formSection");
            var penIcon = document.getElementById("penIcon");

            if (formSection.style.display === "none") {
                formSection.style.display = "block";
                penIcon.style.display = "none"; // Hide the pen icon when form is displayed
            } else {
                formSection.style.display = "none";
                penIcon.style.display = "inline-block"; // Show the pen icon when form is hidden
            }
        }
        // JavaScript: Update the active circle based on the currently displayed message
        var rotatingMessages = [
            "Payroll: Where time, effort, and precision converge to ensure everyone gets their fair share.",
            "Heyy Super-Admin!!",
            // Add more messages here as needed
        ];

        var dynamicMessage = document.getElementById("dynamic-message");
        var messageCircles = document.querySelectorAll(".message-circle");
        var currentIndex = 0;

        function rotateMessages() {
            dynamicMessage.textContent = rotatingMessages[currentIndex];

            // Remove active class from all circles
            messageCircles.forEach(function (circle, index) {
                circle.classList.remove("active");
                // Add a click event listener to each circle to display the corresponding message
                circle.addEventListener("click", function () {
                    currentIndex = index;
                    rotateMessages();
                });
            });

            // Add active class to the corresponding circle
            messageCircles[currentIndex].classList.add("active");

            currentIndex = (currentIndex + 1) % rotatingMessages.length;
        }

        rotateMessages();

        setInterval(rotateMessages, 3000);

        // Rest of your JavaScript code...


        function setGreeting() {
            var currentHour = new Date().getHours();
            var greetingMessage = "";

            if (currentHour >= 5 && currentHour < 12) {
                greetingMessage = "Good morning";
            } else if (currentHour >= 12 && currentHour < 17) {
                greetingMessage = "Good afternoon";
            } else {
                greetingMessage = "Good evening";
            }

            // Set the greeting message in the HTML
            document.getElementById("greeting").innerHTML = greetingMessage;
        }

        // Call the setGreeting function when the page loads
        window.onload = setGreeting;
        
        </script>
    
      
        
</asp:Content>