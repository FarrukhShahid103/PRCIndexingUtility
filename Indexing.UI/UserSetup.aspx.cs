using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using Indexing.EL;
using Indexing.BLL;

namespace Indexing.UI
{
    public partial class UserSetup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        [WebMethod()]
        public static List<eUser> LoadUserRecord()
        {
            List<eUser> oeListUser = new List<eUser>();
            eUser oeUser = new eUser();
            oeListUser = bUser.GetUser(oeUser);
            return oeListUser;
        }

        [WebMethod()]
        public static List<eRoles> FillRole()
        {
            List<eRoles> oeListRoles = new List<eRoles>();
            eRoles oeRoles = new eRoles();
            oeListRoles = bRoles.GetRoles(oeRoles);
            return oeListRoles;
        }

        [WebMethod()]
        public static List<eUser> LoadUser(string userId)
        {
            List<eUser> oeListUser = new List<eUser>();
            eUser oeUser = new eUser();
            oeUser.User_id = ValidateFields.GetSafeGuid(userId);
            oeListUser = bUser.GetUserWithRole(oeUser);
            return oeListUser;
        }

        [WebMethod()]
        public static List<string> DeleteUser(string userId)
        {
            List<string> oeList = new List<string>();
            UpdateEntryInfo info = new UpdateEntryInfo();
            eUser oeUser = new eUser();
            oeUser.User_id = ValidateFields.GetSafeGuid(userId);
            info = bUser.deleteUser(oeUser);
            if (info.Success)
            {
                oeList.Add("success");
            }
            else
            {
                oeList.Add(info.Exception);
            }
            return oeList;
        }

        [WebMethod()]
        public static List<string> SaveUser(string userId, string userName, string password, string displayName, string roleId, string isActive)
        {
            List<string> oeList = new List<string>();
            bool active = false;
            if (isActive == "true")
            {
                active = true;
            }
            UpdateEntryInfo info = new UpdateEntryInfo();
            eUser oeUser = new eUser();
            oeUser.User_name = userName;
            oeUser.Password = password;
            oeUser.Display_name = displayName;
            oeUser.User_status = active;
            oeUser.Access_datetime = DateTime.Now;

            //  For Update
            if (userId != string.Empty)
            {
                //string[] UserIdAndRoleId = userId.Split('|');
                oeUser.User_id = ValidateFields.GetSafeGuid(userId);
                eRoles oeRole = new eRoles();
                oeRole.Role_id = ValidateFields.GetSafeGuid(roleId);
                oeUser.ObjRoles.Add(oeRole);
                info = bUser.UpdateUserWithRoleByUserId(oeUser);
                if (info.Success)
                {
                    oeList.Add("UpdateWithRole");
                }
                else if (info.Exception.ToLower().Contains("duplicate"))
                {
                    oeList.Add("duplicate");
                }
                else
                {
                    oeList.Add("ErrorUpdate");
                }
            }
            else    //For Insert
            {
                oeUser.User_id = Guid.NewGuid();
                info = bUser.insertUser(oeUser);
                if (info.Success)
                {
                    eRoles oeRoles = new eRoles();
                    oeRoles.Role_id = ValidateFields.GetSafeGuid(roleId);
                    oeUser.ObjRoles.Add(oeRoles);
                    info = bUser.InsertUserRoles(oeUser);
                    if (info.Success)
                    {
                        oeList.Add("InsertWithRole");
                    }
                    else
                    {
                        oeList.Add("SaveUserButNotRole");
                    }
                }
                else if (info.Exception.ToLower().Contains("duplicate"))
                {
                    oeList.Add("duplicate");
                }
                else
                {
                    oeList.Add("ErrorInsertUser");
                }
            } 
            return oeList;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                eUser oeUser = new eUser();
                oeUser.User_name = txtUsername.Text.Trim();
                oeUser.Password = txtPassword.Text.Trim();
                oeUser.Display_name = txtDisplayName.Text.Trim();
                oeUser.Login_status = chkIsActive.Checked;
                UpdateEntryInfo info = new UpdateEntryInfo();
                info = bUser.insertUser(oeUser);
                if (info.Success)
                {
                    eRoles oeRole = new eRoles();
                    oeRole.Role_id = ValidateFields.GetSafeGuid(rbRoleList.SelectedValue);
                    oeUser.ObjRoles.Add(oeRole);

                    info = bUser.InsertUserRoles(oeUser);
                    if (info.Success)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "Message", "MessegeArea('User successfully created', 'success');", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "Message", "MessegeArea('user create successfully but role can't assign, Please contact administrator', 'error');", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "Message", "MessegeArea('An error has occurred during btnSave processing.', 'error');", true);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}