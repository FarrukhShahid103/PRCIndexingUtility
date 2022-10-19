using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using Indexing.EL;
using Indexing.BLL;
using System.Web.Security;

namespace Indexing.UI
{
    public partial class SignIn : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["LoginUserInfo"] != null)
                {
                    Response.Redirect("Indexing.aspx");
                }
            }
        }


        [WebMethod(EnableSession = true)]
        public static List<string> DoLogin(string username, string password)
        {
            eUser oeUser = null;
            List<string> objList = new List<string>();
            string msg = string.Empty;
            try
            {
                if (username != string.Empty && password != string.Empty)
                {
                    List<eUser> oeListUser = new List<eUser>();
                    oeListUser = bUser.ValidateLogin(username, password);
                    if (oeListUser != null && oeListUser.Count > 0)
                    {
                        if (oeListUser[0].User_status)
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
                            HttpContext.Current.Session["LoginUserInfo"] = oeUser;
                        }
                        else
                        {
                            msg = "You are no more active in system";
                        }
                    }
                }

                if (msg == string.Empty)
                {
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
                        msg = "User login successfully.";
                        //if (!String.IsNullOrEmpty(redirUrl))
                        //    HttpContext.Current.Response.Redirect(redirUrl, false);
                        //else
                        //    HttpContext.Current.Response.Redirect("Indexing.aspx");
                    }
                    else
                    {
                        msg = "Invalid user name or password.";
                    }
                }
                objList.Add(msg);
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                objList.Add(msg);
            }
            return objList;
        }
    }
}