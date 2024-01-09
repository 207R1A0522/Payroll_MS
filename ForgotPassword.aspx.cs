using System;
using System.IO;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Net.Mail;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;

namespace Payroll_Mangmt_sys
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyconnectionString"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["email"] != null)
                {
                    Response.Redirect("login1.aspx");
                }
            }
        }

        protected void ForgotPwdBtn_Click(object sender, EventArgs e)
        {
            if (con.State == ConnectionState.Closed)
                con.Open();
            SqlCommand checkemail = new SqlCommand("select Email from [Login_Cred] where Email = @Email", con);
            checkemail.Parameters.AddWithValue("@Email", email.Text);
            SqlDataReader read = checkemail.ExecuteReader();
            if (read.HasRows)
            {
                con.Close();
                if (con.State == ConnectionState.Closed)
                    con.Open();

                Random forgototp = new Random();
                int frgtOTP = forgototp.Next(1000, 9999);
                string myfotgototpOTP = frgtOTP.ToString();

                string qr = "update [Login_Cred] set fotgototp='" + myfotgototpOTP + "' where Email='" + email.Text.ToString() + "'";
                SqlCommand cmd = new SqlCommand();
                //cmd.Parameters.AddWithValue("@otp_created", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.CommandText = qr;
                cmd.Connection = con;
                cmd.ExecuteNonQuery();
                con.Close();

                MailMessage mail = new MailMessage();
                mail.To.Add(email.Text.Trim());
                mail.From = new MailAddress("subodhsohoni2@gmail.com");
                mail.Subject = "Reset password link";
                string emailBody = "";

                emailBody += "<div style='background:#FFFFFF; font-family:Arial,Helvetica,Verdana,sans-serif; font-size:14px; margin:0; padding:0;'>";
                emailBody += "<table cellspacing='0' cellpadding='0' border='0' width='100%' style='font-family:Arial,Helvetica,Verdana,sans-serif; font-size:14px;'>";
                emailBody += "<tbody>";
                emailBody += "<tr>";
                emailBody += "<td valign='top' style='font-family:Arial,Helvetica,Verdana,sans-serif; font-size:14px;'>";
                emailBody += "<div style='width:600px;margin-left:auto;margin-right:auto;clear:both;'>";
                emailBody += "<div style='float:left;width:600px;min-height:35px;font-size:26px;font-weight:bold;text-align:left'>";
                emailBody += "<div style='clear:both;width:100%;text-align:center;'>   Website</div>";
                emailBody += "<div style='clear:both;width:100%;text-align:center;font-size:11px;font-style:italic;'>    website World!</div>";
                emailBody += "</div>";
                emailBody += "</div>";
                emailBody += "</td>";
                emailBody += "</tr>";
                emailBody += "</tbody>";
                emailBody += "</table>";
                emailBody += "<table cellspacing='0' cellpadding='0' border='0' width='600' style='font-family:Arial,Helvetica,Verdana,sans-serif; font-size:14px;margin-left:auto;margin-right:auto;'>";
                emailBody += "<tbody>";
                emailBody += "<tr>";
                emailBody += "<td valign='top' colspan='2' style='width:600px;padding-left:20px;padding-right:20px;font-family:Arial,Helvetica,Verdana,sans-serif; font-size:14px;'>";
                emailBody += "<p style='font-family:Arial,Helvetica,Verdana,sans-serif; font-size:14px;padding-top:15px;line-height:22px;margin:0px;font-weight:bold;padding-bottom:5px'>Hello User,</p>";
                emailBody += "<p><a href='" + "https://localhost:44320/ResetPassword.aspx?fotgototp=" + myfotgototpOTP + "&Email=" + Base64Encode(email.Text.Trim()) + "'>Click here to Reset your password.</a></p>";
                emailBody += "<p style='font-family:Arial,Helvetica,Verdana,sans-serif; font-size:14px;line-height:22px;color:rgb(41,41,41)'>Thanks for reaching us.. We ll contact you ASAP.</p>";
                emailBody += "<p> </p><p style='font-family:Arial,Helvetica,Verdana,sans-serif; font-size:14px;line-height:22px;margin:0px'>If you have any additional queries, please feel free to reach out us at +91 XXXXX XXXXX or drop us an email at <a href='mailto:Websiteweb.com' style='text-decoration:none;font-style:normal;font-variant:normal;font-weight:normal;font-family:Arial,Helvetica,Verdana,sans-serif; font-size:14px;line-height:normal;color:rgb(162,49,35)' target='_blank'>example@domain.com</a>. We are here to help you.</p>";
                emailBody += "<p> </p>";
                emailBody += "<p style='font-family:Arial,Helvetica,Verdana,sans-serif; font-size:14px;line-height:22px;margin:0px;font-weight:bold'>Best Regards,</p>";
                emailBody += "<p style='font-family:Arial,Helvetica,Verdana,sans-serif; font-size:14px;color:rgb(41,41,41);line-height:22px;margin:0px'>WebsiteSupport</p>";
                emailBody += "</td>";
                emailBody += "</tr>";
                emailBody += "</tbody>";
                emailBody += "</table>";
                emailBody += "</div>";

                mail.Body = emailBody;
                mail.IsBodyHtml = true;

                SmtpClient smtp = new SmtpClient();
                smtp.Port = 587;
                smtp.EnableSsl = true;
                smtp.UseDefaultCredentials = false;
                smtp.Host = "smtp.gmail.com"; //Or Your SMTP Server Address
                smtp.Credentials = new System.Net.NetworkCredential("subodhsohoni2@gmail.com", "wqwpznmqgtjqxonx");
                smtp.Send(mail);

                lblErrorMsg.Text = "Reset password link sent to your email address. Please check your Inbox/Spam folder for reset password link.";
                lblErrorMsg.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                lblErrorMsg.Text = "Your are not registered with us or your account is not activated.";
                lblErrorMsg.ForeColor = System.Drawing.Color.Red;
            }

        }
        public static string Base64Encode(string plainText)
        {
            var plainTextBytes = System.Text.Encoding.UTF8.GetBytes(plainText);
            return System.Convert.ToBase64String(plainTextBytes);
        }
        public static string Base64Decode(string base64EncodedData)
        {
            var base64EncodedBytes = System.Convert.FromBase64String(base64EncodedData);
            return System.Text.Encoding.UTF8.GetString(base64EncodedBytes);
        }
        private string MyEncrypt(string returnText)
        {
            string EncryptionKey = "E5C2B81A3B2B2";
            byte[] clearBytes = Encoding.Unicode.GetBytes(returnText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(clearBytes, 0, clearBytes.Length);
                        cs.Close();
                    }
                    returnText = Convert.ToBase64String(ms.ToArray());
                }
            }
            return returnText;
        }
        /*private string MyDecrypt(string returnText)
        {
        string EncryptionKey = "E5C2B81A3B2B2";
        byte[] cipherBytes = Convert.FromBase64String(returnText);
        using (Aes encryptor = Aes.Create())
        {
        Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
        encryptor.Key = pdb.GetBytes(32);
        encryptor.IV = pdb.GetBytes(16);
        using (MemoryStream ms = new MemoryStream())
        {
        using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(), CryptoStreamMode.Write))
        {
        cs.Write(cipherBytes, 0, cipherBytes.Length);
        cs.Close();
        }
        returnText = Encoding.Unicode.GetString(ms.ToArray());
        }
        }
        return returnText;
        }*/
    }
}