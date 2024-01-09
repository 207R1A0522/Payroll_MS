<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Admindashboard.Master" AutoEventWireup="true" CodeBehind="Admindashboard.aspx.cs" Inherits="Payroll_Mangmt_sys.Admindashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
            /* Define CSS styles for the grid container */
           
            .grid-container {
                padding-top :60px;
                padding-left:50px;
                padding-right:50px;
                display: grid;
                grid-template-columns: 1fr 2fr; /* Two columns for greeting and content */
                gap: 10px; /* Adjust the gap as needed */
                align-items: normal; /* Center items vertically */
                
            }
            .goo{
                display :grid;
                grid-template-columns:1fr 1fr;
                align-items:center;
            }

            /* Define CSS styles for the boxes */
            .box {
                border: 1px solid #ccc;
                padding: 10px;
                text-align: justify;
                box-shadow: 0 0 5px #888888;
                background-color: #f9f9f9;
                border-radius: 10px;
                transition: background-color 0.3s, transform 0.3s;
                
            }

            /* Hover effect for the first box */
            .box:nth-child(1):hover {
                background-color: #B0E0E6; /* Light Blue */
                color: #000; /* Black text */
            }

            /* Hover effect for the second box */
            .box:nth-child(2):hover {
                background-color: #E6E6FA; /* Light Pink */
                color: #000; /* Black text */
            }

            /* Hover effect for the third box */
            .box:nth-child(3):hover {
                background-color: #B0C4DE; 
                color: #000; /* Black text */
            }

            /* Hover effect for the fourth box */
            .box:nth-child(4):hover {
                background-color: #CFD8DC; 
                color: #000; /* Black text */
            }
            /* Style for the fancy image */
            .fancy-image {
                 
                height:60px;
                width:200px;
                padding-top:0;
                margin-top:0px;
                margin-left:140px;
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
            .quick-access-link {
                background-color: #f9f9f9; /* Default background color */
                color: #007BFF; /* Default text color */
                transition: background-color 0.3s, color 0.3s; /* Smooth transition for background and text color */
                border: 1px solid #ccc; /* Default border */
                border-radius: 5px; /* Default border radius */
                padding: 5px; /* Default padding */
            }

            .quick-access-link:hover {
                background-color: #007BFF; /* Change the background color on hover */
                border-color: #007BFF; /* Change the border color on hover */
                box-shadow: 0 0 5px #007BFF; /* Add a subtle box shadow on hover */
                color: #333; /* Change the text color to dark gray on hover */
            }
                 .previous-message-box {
                       border: 1px solid #ddd;
                        padding: 15px;
                        border-radius: 8px;
                        background-color: #f5f5f5;
                        box-shadow: 0 0 6px rgba(0, 0, 0, 0.1);
                        margin-top: 15px;
                        height:200px;
                    }

                        #dataLabel {
                        font-size: 16px;
                        color: #333;
                        }
            
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <asp:HiddenField ID="netPayHiddenField" runat="server" ClientIDMode="Static" />
<asp:HiddenField ID="ctcGrossHiddenField" runat="server" ClientIDMode="Static" />

        
           <!-- Greeting Message -->
    <div class="goo">
        <div>
            <h1 id="greeting">Welcome to Payroll Management System</h1>
            <h2 class="additional-message">Payroll: Where time, effort, and precision converge to ensure everyone gets their fair share.</h2>
        </div>

        <!-- Fancy Image -->
         <div class="fancy-image">
            <img class="fancy-image" src="images/logor.png" alt="Fancy Image" ">
        </div>
    </div>

    <!-- Create a separate grid for the other boxes -->
    <div class="grid-container">
        <div class="box">
            <!-- Quick Access Links -->
            <div id="report-form" class="chart-container">
              <h2 style="font-size: 20px; color: #333;">Notice Board</h2>
     
             <div id="displayData" class="form-group" >
               <div class="previous-message-box">
                  <asp:Label ID="dataLabel" runat="server" Text="" CssClass="additional-message"></asp:Label>
                    
              </div>
           </div>
            
          </div>
        </div>
          <div class="box">
            <!-- Payslip -->
            <div class="goo">
                <h2 style="font-size: 20px; color: #333;">Payroll Expenses</h2>
                
            </div>
            <div style="display: flex; justify-content: space-between;">
                <div style="flex: 1; padding: 10px;">
                    <canvas id="payslipChart" width="250" height="250"></canvas>
                </div>
               <div style="flex: 1; text-align: right;">
                    <p style="font-size: 16px; color: #333;">
                        <strong>Net Pay:</strong> Rs. <span id="netPayValueSpan">**</span>
                    </p>
                    <p style="font-size: 16px; color: #333;">
                        <strong>CTC Gross:</strong> Rs. <span id="ctcGrossValueSpan">**</span>
                    </p>
                    <a href="javascript:void(0);" id="showHideLink" onclick="toggleValues()">Show</a>
                </div>

            </div>
        </div>
        <div class="box">
    <!-- Quick Access Links -->
                <div class="goo">
                    <h2 style="font-size: 20px; color: #333;">Quick Access</h2>
                    <h3 class="additional-message" style="font-size: 14px; color: #555;">Use quick access to get important details.</h3>
                </div>
                <ul style="list-style-type: none; padding: 0;">
                    <li style="margin-bottom: 5px;">
                        <a href="Salary.aspx" style="text-decoration: none; color: #007BFF; display: block;">
                            <div class="quick-access-link" style="background-color: #f9f9f9; border: 1px solid #ccc; border-radius: 5px; padding: 5px;">
                                Get the Salary Details
                            </div>
                        </a>
                    </li>
                    <li style="margin-bottom: 5px;">
                        <a href="Leave.aspx" style="text-decoration: none; color: #007BFF; display: block;">
                            <div class="quick-access-link" style="background-color: #f9f9f9; border: 1px solid #ccc; border-radius: 5px; padding: 5px;">
                                Check employee leave details
                            </div>
                        </a>
                    </li>
                    <li>
                        <a href="Employee_Search.aspx" style="text-decoration: none; color: #007BFF; display: block;">
                            <div class="quick-access-link" style="background-color: #f9f9f9; border: 1px solid #ccc; border-radius: 5px; padding: 5px;">
                                Search for data
                            </div>
                        </a>
                    </li>
                    <!-- Add more quick access links here -->
                </ul>
            </div>
        
        <div class="box">
            <!-- Upcoming Holidays -->
            <h2 style="font-size: 20px; color: #333;">Upcoming Holidays</h2>
            <div style="display: flex; align-items: center;">
                <div style="flex: 1;">
                    <div id="holidayInfo" style="font-size: 16px; color: #555;">
                        <!-- Holiday information will be displayed here -->
                    </div>
                </div>
                <div style="flex: 1; text-align: right;">
                    <img src="images/holiday_image.jpeg" alt="Upcoming Holidays" style="max-width: 80%; height: auto;">
                </div>
            </div>
        </div>
    </div>
        
    <script>

        function toggleValues() {
            var netPayValueSpan = document.getElementById("netPayValueSpan");
            var ctcGrossValueSpan = document.getElementById("ctcGrossValueSpan");
            var showHideLink = document.getElementById("showHideLink");

            // Initially hide the values
            netPayValueSpan.textContent = "******";
            ctcGrossValueSpan.textContent = "******";
            showHideLink.textContent = "Show";

            showHideLink.onclick = function () {
                if (showHideLink.textContent === "Show") {
                    // Show actual values
                    // Replace with the actual values
                    var netPayValue = parseFloat(document.getElementById("netPayHiddenField").value);
                    var ctcGrossValue = parseFloat(document.getElementById("ctcGrossHiddenField").value);
                    netPayValueSpan.textContent = netPayValue.toFixed(2); // Adjust the format as needed
                    ctcGrossValueSpan.textContent = ctcGrossValue.toFixed(2); // Adjust the format as needed
                    showHideLink.textContent = "Hide";
                } else {
                    // Hide the values
                    netPayValueSpan.textContent = "******";
                    ctcGrossValueSpan.textContent = "******";
                    showHideLink.textContent = "Show";
                }
            };
        }

        


       
            


            // Function to set the greeting message based on the current time
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
                document.getElementById("greeting").innerHTML = greetingMessage ;
            }

            // Call the setGreeting function when the page loads
            window.onload = setGreeting;
        </script>
        <script>
            // Access the values from the hidden fields or JavaScript variables
            var netPayValue = parseFloat(document.getElementById("netPayHiddenField").value);
            var ctcGrossValue = parseFloat(document.getElementById("ctcGrossHiddenField").value);
            document.getElementById("netPayValueSpan").textContent = netPayValue.toFixed(2); // Adjust the format as needed
            document.getElementById("ctcGrossValueSpan").textContent = ctcGrossValue.toFixed(2); // Adjust the format as needed
            // Get the canvas element
            var canvas = document.getElementById("payslipChart");

            // Create a pie chart
            var payslipChart = new Chart(canvas, {
                type: 'pie',
                data: {
                    labels: ['Net Pay', 'CTC Gross'],
                    datasets: [{
                        data: [netPayValue, ctcGrossValue],
                        backgroundColor: ['#36A2EB', '#FFCE56'], // Colors for the segments
                    }]
                },
                options: {
                    responsive: false, // Ensure the chart size remains fixed
                }
            });
        </script>
        <script>
            // Function to calculate the number of national holidays and their dates
            function calculateUpcomingHolidays() {
                var today = new Date();
                var endOfYear = new Date(today.getFullYear(), 11, 31); // December 31st of the current year

                // Sample list of national holidays (you can replace this with your own data)
                var nationalHolidays = [
                    { date: new Date(today.getFullYear(), 0, 1), name: "New Year's Day" },
                    { date: new Date(today.getFullYear(), 0, 26), name: "Republic Day" },
                    { date: new Date(today.getFullYear(), 1, 14), name: "Valentine's Day" },
                    { date: new Date(today.getFullYear(), 2, 8), name: "International Women's Day" },
                    { date: new Date(today.getFullYear(), 3, 1), name: "April Fools' Day" },
                    { date: new Date(today.getFullYear(), 4, 1), name: "Labor Day" },
                    { date: new Date(today.getFullYear(), 4, 7), name: "World Health Day" },
                    { date: new Date(today.getFullYear(), 4, 25), name: "World Malaria Day" },
                    { date: new Date(today.getFullYear(), 6, 1), name: "Doctors' Day" },
                    { date: new Date(today.getFullYear(), 7, 15), name: "Independence Day" },
                    { date: new Date(today.getFullYear(), 8, 2), name: "Ganesh Chaturthi" },
                    { date: new Date(today.getFullYear(), 8, 5), name: "Teachers' Day" },
                    { date: new Date(today.getFullYear(), 9, 2), name: "Gandhi Jayanti" },
                    { date: new Date(today.getFullYear(), 9, 8), name: "Indian Air Force Day" },
                    { date: new Date(today.getFullYear(), 9, 31), name: "Halloween" },
                    { date: new Date(today.getFullYear(), 10, 14), name: "Children's Day" },
                    { date: new Date(today.getFullYear(), 10, 26), name: "Constitution Day" },
                    { date: new Date(today.getFullYear(), 11, 25), name: "Christmas Day" },
                    // Add more holidays here
                    // Add more holidays here
                ];

                var upcomingHolidays = [];

                for (var i = 0; i < nationalHolidays.length; i++) {
                    if (nationalHolidays[i].date > today && nationalHolidays[i].date <= endOfYear) {
                        upcomingHolidays.push(nationalHolidays[i]);
                    }
                }

                return upcomingHolidays;
            }

            // Function to update the holiday information
            function updateHolidayInfo() {
                var upcomingHolidays = calculateUpcomingHolidays();

                var holidayInfo = document.getElementById("holidayInfo");
                holidayInfo.innerHTML = "";

                if (upcomingHolidays.length === 0) {
                    holidayInfo.innerHTML = "Uh oh ! No holidays to show.";
                } else {
                    holidayInfo.innerHTML = "<ul>";
                    for (var i = 0; i < upcomingHolidays.length; i++) {
                        var holiday = upcomingHolidays[i];
                        holidayInfo.innerHTML += "<li>" + holiday.name + " - " + holiday.date.toDateString() + "</li>";
                    }
                    holidayInfo.innerHTML += "</ul>";
                }
            }

            // Call the updateHolidayInfo function initially
            updateHolidayInfo();

            // Update the holiday information as the date changes
            setInterval(updateHolidayInfo, 1000 * 60); // Update every minute
        </script>
    
</asp:Content>