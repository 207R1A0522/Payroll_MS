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
using AjaxControlToolkit.HtmlEditor.ToolbarButtons;

namespace Payroll_Mangmt_sys
{
    public partial class ResetPassword : System.Web.UI.Page
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
                con.Open();
                //if (Request.QueryString["email"].ToString())
                //{
                // Response.Redirect("Home.aspx");
                //}
                string email_id = Request.QueryString["Email"].ToString();
                string email = Base64Decode(email_id);
                string fotgototp = Request.QueryString["fotgototp"].ToString();


                string cmds = "select Username from [Login_Cred] where Email ='" + email.ToString() + "' and fotgototp = '" + fotgototp.ToString() + "' and fotgototp !=0";
                SqlCommand checkemail = new SqlCommand(cmds, con);
                SqlDataReader read = checkemail.ExecuteReader();
                if (!read.HasRows)
                {
                    con.Close();
                    lblErrorMsg.Text = "Reset password link is expired1.";
                    lblErrorMsg.ForeColor = System.Drawing.Color.Red;
                }
                else
                {
                    con.Close();
                }
            }
        }
        protected void ResetPwdBtn_Click(object sender, EventArgs e)
        {
            string email_id = Request.QueryString["Email"].ToString();
            string email = Base64Decode(email_id);

            string fotgototp = Request.QueryString["fotgototp"].ToString();
            if (con.State == ConnectionState.Closed)
                con.Open();
            string cmds = "select Username from [Login_Cred] where Email ='" + email.ToString() + "' and fotgototp = '" + fotgototp.ToString() + "'";
            SqlCommand checkemail = new SqlCommand(cmds, con);
            SqlDataReader read = checkemail.ExecuteReader();
            if (read.Read())
            {
                if (password.Text == cpassword.Text)
                {
                    con.Close();
                    if (con.State == ConnectionState.Closed)
                        con.Open();
                    string qr = "update [Login_Cred] set Password='" + password.Text.ToString() + "', fotgototp = 0 where Email='" + email.ToString() + "' and fotgototp = '" + fotgototp.ToString() + "'";
                    SqlCommand cmd = new SqlCommand();
                    cmd.CommandText = qr;
                    cmd.Connection = con;
                    cmd.ExecuteNonQuery();
                    con.Close();
                    lblErrorMsg.Text = "Your password is reset successfully.";
                    lblErrorMsg.ForeColor = System.Drawing.Color.Green;
                    Response.Redirect("login1.aspx");
                }
                else
                {
                    lblErrorMsg.Text = "Password and Confirm password is not same.";
                    lblErrorMsg.ForeColor = System.Drawing.Color.Red;
                    con.Close();
                }

            }
            else
            {
                lblErrorMsg.Text = "Reset password link is expired.";
                lblErrorMsg.ForeColor = System.Drawing.Color.Red;
                con.Close();
            }
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
        private string MyDecrypt(string returnText)
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
        }
    }
}