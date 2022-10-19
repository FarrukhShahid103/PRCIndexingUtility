using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Indexing.EL;
using System.Web.Security;
using Indexing.BLL;
using System.Web.Services;

namespace Indexing.UI
{
    public partial class LoginPRC : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["LoginUserInfo"] != null)
            {
                Response.Redirect("Indexing.aspx");
            }
        }

        [WebMethod()]
        public static List<eUser> getLogin(string username, string password)
        {
            eUser oeUser = null;
            List<eUser> objList = new List<eUser>();
            try
            {
                if (username != string.Empty && password != string.Empty)
                {
                    List<eUser> oeListUser = new List<eUser>();
                    oeListUser = bUser.ValidateLogin(username, password);
                    if (oeListUser != null && oeListUser.Count > 0)
                    {
                        oeUser = new eUser();
                        oeUser.User_id = ValidateFields.GetSafeGuid(oeListUser[0].User_id);
                        oeUser.User_name = ValidateFields.GetSafeString(oeListUser[0].User_name);
                        oeUser.Display_name = ValidateFields.GetSafeString(oeListUser[0].Display_name);
                        //user.Roles = Util.GetUserRoles(DataLayer.LARMIS_Util.GetRolesByUserID(user.Id));
                        HttpContext.Current.Session["LoginUserInfo"] = oeUser;
                        //Session["username"] = oeUser.UserName;
                        //Session["DisplayName"] = oeUser.DisplayName;
                        //Session["user_id"] = oeUser.Id;
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
                    HttpContext.Current.Response.Cookies.Add(authCookie);
                    HttpContext.Current.Session["RolesListCookie"] = roles;
                    string redirUrl = FormsAuthentication.GetRedirectUrl(loginUserTokens, false);
                    oeUser.Login_status = true;

                    //user.SystemName = Util.GetIPAddress(); 
                    oeUser.Access_datetime = DateTime.Now;
                    oeUser.Password = password;
                    //manager.Update(user, ddlDatabase.SelectedValue);

                    objList.Add(oeUser);
                    if (!String.IsNullOrEmpty(redirUrl))
                    {
                        HttpContext.Current.Response.Redirect(redirUrl, false);
                    }
                    else
                    {
                        HttpContext.Current.Response.Redirect("Indexing.aspx");
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return objList;
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
                        eRoles oeRole = new eRoles();
                        oeUser.User_id = ValidateFields.GetSafeGuid(oeListUser[0].User_id);
                        oeUser.User_name = ValidateFields.GetSafeString(oeListUser[0].User_name);
                        oeUser.Display_name = ValidateFields.GetSafeString(oeListUser[0].Display_name);
                        oeUser.Access_datetime = DateTime.Now;
                        oeRole.Role_id = oeListUser[0].ObjRoles[0].Role_id;
                        oeUser.ObjRoles.Add(oeRole);
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
                        //ScriptManager.RegisterStartupScript(this, GetType(), "message", "slideUpDown();", true);
                        Response.Redirect(redirUrl);
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
    }
}