using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using Indexing.EL;
using Indexing.BLL;

namespace Indexing.UI
{
    public partial class Master : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["LoginUserInfo"] != null)
                {
                    //Response.Redirect("Indexing.aspx");
                    ScriptManager.RegisterStartupScript(this, GetType(), "message", "hasSession();", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "message", "WithoutSession();", true);
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            eUser oeUser = null;
            List<eUser> objList = new List<eUser>();
            try
            {
                if (txtUsername.Text.Trim() != string.Empty && txtPassword.Text.Trim() != string.Empty)
                {
                    List<eUser> oeListUser = new List<eUser>();
                    oeListUser = bUser.ValidateLogin(txtUsername.Text.Trim(), txtPassword.Text.Trim());
                    if (oeListUser != null && oeListUser.Count > 0)
                    {
                        oeUser = new eUser();
                        oeUser.User_id = ValidateFields.GetSafeGuid(oeListUser[0].User_id);
                        oeUser.User_name = ValidateFields.GetSafeString(oeListUser[0].User_name);
                        oeUser.Display_name = ValidateFields.GetSafeString(oeListUser[0].Display_name);
                        //user.Roles = Util.GetUserRoles(DataLayer.LARMIS_Util.GetRolesByUserID(user.Id));
                        Session["LoginUserInfo"] = oeUser;
                    }
                }

                if (oeUser != null)
                {
                    List<eRoles> oeListRoles = oeUser.ObjRoles;
                    string roles = General.TokenizeRolesList(oeListRoles);
                    string loginUserTokens = General.CombineLoginUserTokens(oeUser.User_id, oeUser.User_name, oeUser.Display_name);

                    HttpCookie authCookie = FormsAuthentication.GetAuthCookie(loginUserTokens, false);
                    FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(authCookie.Value);
                    DateTime CurrentDateTimeOfSystem = DateTime.Now;
                    DateTime TicketExpiryDateTime = CurrentDateTimeOfSystem.AddHours(1.0);

                    FormsAuthenticationTicket newTicket = new FormsAuthenticationTicket(
                        ticket.Version,
                        loginUserTokens,
                        ticket.IssueDate,
                        TicketExpiryDateTime,//ticket.Expiration,
                        ticket.IsPersistent,
                        roles);
                    authCookie.Value = FormsAuthentication.Encrypt(newTicket);
                    //Response.Cookies.Add(authCookie);
                    Response.Cookies.Add(authCookie);
                    Session["RolesListCookie"] = roles;
                    string redirUrl = FormsAuthentication.GetRedirectUrl(loginUserTokens, false);
                    oeUser.Login_status = true;

                    //user.SystemName = Util.GetIPAddress(); 
                    oeUser.Access_datetime = DateTime.Now;
                    oeUser.Password = txtPassword.Text.Trim();
                    //manager.Update(user, ddlDatabase.SelectedValue);

                    objList.Add(oeUser);
                    if (!String.IsNullOrEmpty(redirUrl))
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "message", "hasSession();", true);
                        //Response.Redirect(redirUrl);
                    }
                    else
                    {
                        Response.Redirect("Indexing.aspx");
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
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
                    //Response.Redirect("~/loginprc.aspx");
                    ScriptManager.RegisterStartupScript(this, GetType(), "message", "WithoutSession();", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "message", "WithoutSession();", true);
                }
            }
            else
            {
                //Response.Redirect("~/loginprc.aspx");
                ScriptManager.RegisterStartupScript(this, GetType(), "message", "WithoutSession();", true);
            }
            //Page_Load(sender, e);
        }
    }
}