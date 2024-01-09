using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Payroll_Mangmt_sys
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["SelectedLocation"] == null)
            {
                // Session variable is null, indicating session expiration
                ShowSessionExpiredAlert();
            }


        }
        private void ShowSessionExpiredAlert()
        {
            // Display an alert message to the user
            string script = "alert('Session expired. You will be logged out.'); window.location.href = 'login1.aspx';";
            ScriptManager.RegisterStartupScript(this, GetType(), "SessionExpiredScript", script, true);

            // Abandon the session and log the user out
            Session.Abandon();
        }

    }
}