<%@ Page Title="Leave" Language="C#" MasterPageFile="~/Admindashboard.Master" AutoEventWireup="true" CodeBehind="Leave.aspx.cs" Inherits="Payroll_Mangmt_sys.Leave" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

    <style>
        /* Add your CSS styles for input fields and headings */


        

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

        /* Adjust the button styles */
        
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
         .section-heading {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            font-size: 20px;
            font-weight: bold;
            color: #333;
            
            margin-top: 5px;
            align-self: flex-start; /* Align the heading to the top */
             /* Add 3D text-shadow effect */
           animation: fadeInUp 0.5s ease-in-out;
        }
         @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }


        .export-button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s, box-shadow 0.3s;
            margin-top: 10px;
        }

         .export-button:hover {
            background-color: #45a049;
        }
        .required-validator {
            font-size: 12px; /* Adjust the font size as needed */
            display: block;
            margin-top: 4px; /* Adjust the margin-top as needed */
            color: Red; /* Red color for the error message */
        }
        .upload-container {
            margin-top: 20px;
            margin-bottom: 0;
            background-color: #fff;
            border-radius: 8px;
            padding: 80px; /* Adjust the padding to increase vertical space */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s;
            display: inline-block;
            margin-right: 20px; /* Adjust the spacing between containers */
        }

        .upload-container:hover {
            transform: scale(1.02);
        }

        #fileUpload {
            display: none;
        }

         .custom-file-upload {
            cursor: pointer;
            display: inline-block;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border-radius: 5px;
        }

        .custom-file-upload:hover {
            background-color: #0056b3;
        }
        .file-upload-container {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
        }
        .upload-format-info {
            margin-top: 8px;
            margin-bottom: 80px;
        }
         .excel-download-link {
        text-decoration: none; /* Remove underline from the link */
    }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <center>
        <h1 class="page-heading">EMPLOYEE LEAVE</h1>
    </center>

  <div class="upload-container">
               <div class="section-heading">Staff Attendance</div>
      <div class="upload-format-info">
        <p>Please see the Excel uploading format. <a href="javascript:void(0);" onclick="downloadExcelFormat('downloads/Staff_Biometric_Format.xlsx'); return false;" class="excel-download-link">Click here</a></p>
    </div>
     
                
       <div class="file-upload-container">
          
            <asp:FileUpload ID="FileUpload1" runat="server" CssClass="custom-file-upload" />
            <asp:Button ID="UploadButton" runat="server" Text="Upload" OnClick="UploadButton_Click" CssClass="export-button" />
           </div>
        </div>

        <!-- Temporary Attendance Section -->
        <div class="upload-container">
            <div class="section-heading">Temporary Attendance</div>
             <div class="upload-format-info">
                <p>Please see the Excel uploading format. <a href="javascript:void(0);" onclick="downloadExcelFormat('downloads/Temporary_Biometric_Format.xlsx'); return false;" class="excel-download-link">Click here</a></p>
            </div>
                
             <div class="file-upload-container">
               
           <asp:FileUpload ID="FileUpload2" runat="server" CssClass="custom-file-upload" />
            <asp:Button ID="Button1" runat="server" Text="Upload" OnClick="UploadButton_Click2" CssClass="export-button" />
                 </div>
        </div>

   
    <script>
        function showSuccessNotification(section) {
            toastr.success(section, 'Success', {
                positionClass: 'toast-top-right',
                closeButton: true,
                progressBar: true
            });
        }

        function showErrorNotification(errorMessage) {
            toastr.error(errorMessage, 'Error', {
                positionClass: 'toast-top-right',
                closeButton: true,
                progressBar: true
            });
        }
    </script>
    <script>
        function downloadExcelFormat(fileUrl) {
            // Logic to initiate the download
            var link = document.createElement('a');
            link.href = fileUrl;
            link.download = fileUrl.split('/').pop(); // Extracting the filename from the URL
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }
    </script>

</asp:Content>
