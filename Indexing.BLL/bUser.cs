using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Indexing.EL;
using Indexing.DLL;

namespace Indexing.BLL
{
    public class bUser
    {

        public static List<eUser> GetUser(eUser oeUser)
        {
            string condition = BuildCondition(oeUser);
            List<eUser> oeListUser = new List<eUser>();
            oeListUser = dUser.GetUser(condition);
            return oeListUser;
        }

        public static List<eUser> GetUserWithRole(eUser oeUser)
        {
            //string condition = BuildCondition(oeUser);
            List<eUser> oeListUser = new List<eUser>();
            oeListUser = dUser.GetUserWithRole(oeUser.User_id);
            return oeListUser;
        }

        public static UpdateEntryInfo insertUser(eUser oeUser)
        {
            UpdateEntryInfo insertInfo = new UpdateEntryInfo();
            insertInfo = dUser.InsertUser(oeUser);
            return insertInfo;
        }

        public static UpdateEntryInfo InsertUserRoles(eUser oeUser)
        {
            UpdateEntryInfo insertInfo = new UpdateEntryInfo();
            insertInfo = dUser.InsertUserRoles(oeUser);
            return insertInfo;
        }

        public static UpdateEntryInfo updateUser(eUser oeUser)
        {
            UpdateEntryInfo updateInfo = new UpdateEntryInfo();
            updateInfo = dUser.UpdateUser(oeUser);
            return updateInfo;
        }

        public static UpdateEntryInfo UpdateUserWithRoleByUserId(eUser oeUser)
        {
            UpdateEntryInfo updateInfo = new UpdateEntryInfo();
            updateInfo = dUser.UpdateUserWithRoleByUserId(oeUser);
            return updateInfo;
        }

        public static UpdateEntryInfo deleteUser(eUser oeUser)
        {
            UpdateEntryInfo deleteInfo = new UpdateEntryInfo();
            deleteInfo = dUser.DeleteUser(oeUser.User_id);
            return deleteInfo;
        }

        public static List<eUser> ValidateLogin(string username, string password)
        {
            //string condition = BuildCondition(oeUser);
            //odTeritory = new dTeritory();
            List<eUser> oeListUser = new List<eUser>();
            oeListUser = dUser.ValidateLogin(username, password);
            return oeListUser;
        }

        private static string BuildCondition(eUser oeUser)
        {
            string result = "";
            if (oeUser.User_id != Guid.Empty)
                result += (result == "" ? "" : " AND ") + "user_id = '" + oeUser.User_id + "'";
            if (oeUser.User_status != null && oeUser.User_status != false)
                result += (result == "" ? "" : " AND ") + "user_status = '" + oeUser.User_status + "'";
            if (oeUser.Display_name != null && oeUser.Display_name != String.Empty)
                result += (result == "" ? "" : " AND ") + "display_name = '" + oeUser.Display_name + "'";
            if (oeUser.User_name != null && oeUser.User_name != String.Empty)
                result += (result == "" ? "" : " AND ") + "user_name = '" + oeUser.User_name + "'";
            if (oeUser.Password != null && oeUser.Password != String.Empty)
                result += (result == "" ? "" : " AND ") + "password = '" + oeUser.Password + "'";
            if (oeUser.Login_status != null && oeUser.Login_status != false)
                result += (result == "" ? "" : " AND ") + "login_status = '" + oeUser.Login_status + "'";
            if (oeUser.Access_datetime != DateTime.MinValue)
                result += (result == "" ? "" : " AND ") + "access_datetime = '" + oeUser.Access_datetime + "'";
            if (oeUser.System_name != null && oeUser.System_name != String.Empty)
                result += (result == "" ? "" : " AND ") + "System_name = '" + oeUser.System_name + "'";

            if (result != "")
                result = (" WHERE " + result);

            return result;
        }

    }
}
