using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Indexing.EL;
using System.Web.Services;

namespace Indexing.UI
{
    public partial class PRC_Master : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["LoginUserInfo"] != null)
            {
                lnkLogout.Text = "Logout";
                eUser oeUser = (eUser)Session["LoginUserInfo"];
                lblUsername.Text = oeUser.Display_name.ToUpper();
                if (!IsPostBack)
                {
                    lblLoginDateTime.Text = oeUser.Access_datetime.ToString();
                }
                if (oeUser.ObjRoles.Count > 0)
                {
                    if (oeUser.ObjRoles[0].Role_id == ValidateFields.GetSafeGuid("B689436A-8951-46E0-9211-09E72B44991A"))
                    {
                        divMetaData.Visible = true;
                        divSearch.Visible = true;
                        divUserManagement.Visible = true;
                        divTerritory.Visible = true;
                        divLogView.Visible = true;
                    }
                    else
                    {
                        divUserManagement.Visible = false;
                        divTerritory.Visible = false;
                        divLogView.Visible = false;
                    }
                }
            }
            else
            {
                lnkLogout.Text = "Login";
                Response.Redirect("~/SignIn.aspx");
            }
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            if (lnkLogout.Text == "Logout")
            {
                if (Session["LoginUserInfo"] != null)
                {
                    Session["LoginUserInfo"] = null;
                    if (Session["RolesListCookie"] != null)
                    {
                        Session["RolesListCookie"] = null;
                    }
                    Session.Abandon();
                    Response.Redirect("~/SignIn.aspx");
                }
            }
            else
            {
                Response.Redirect("~/SignIn.aspx");
            }
        }

        //[WebMethod]
        //public static List<string> logout()
        //{
        //    List<string> oeList = new List<string>();
        //        if (HttpContext.Current.Session["LoginUserInfo"] != null)
        //        {
        //            HttpContext.Current.Session["LoginUserInfo"] = null;
        //            if (HttpContext.Current.Session["RolesListCookie"] != null)
        //            {
        //                HttpContext.Current.Session["RolesListCookie"] = null;
        //            }
        //            HttpContext.Current.Session.Abandon();
        //            HttpContext.Current.Response.Redirect("~/SignIn.aspx");
        //    }
        //    else
        //    {
        //        HttpContext.Current.Response.Redirect("~/SignIn.aspx");
        //    }

        //    return oeList;
        //}

    }
}