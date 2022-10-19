using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Indexing.EL;
using System.Data.Common;
using System.Data;

namespace Indexing.DLL
{
    public class dUser : DatabaseConnection
    {
        public static List<eUser> GetUser(string condition)
        {
            List<eUser> oeListObject = new List<eUser>();
            string storePro = "[dbo].[proc_GetAllUsers]";
            DbCommand oCmd = Db.GetStoredProcCommand(storePro);
            //Db.AddInParameter(oCmd, "@condition", DbType.String, condition);
            IDataReader oDReader = Db.ExecuteReader(oCmd);
            while (oDReader.Read())
            {
                eUser obj = new eUser();
                obj.User_id = ValidateFields.GetSafeGuid(oDReader["user_id"].ToString());
                obj.User_status = ValidateFields.GetSafeBoolean(oDReader["user_status"].ToString());
                obj.Display_name = ValidateFields.GetSafeString(oDReader["display_name"].ToString());
                obj.User_name = ValidateFields.GetSafeString(oDReader["user_name"].ToString());
                obj.Login_status = ValidateFields.GetSafeBoolean(oDReader["login_status"].ToString());
                obj.Access_datetime = ValidateFields.GetSafeDateTime(oDReader["access_datetime"].ToString());
                oeListObject.Add(obj);
            }
            return oeListObject;
        }

        public static List<eUser> GetUserWithRole(Guid userId)
        {
            List<eUser> oeListObject = new List<eUser>();
            string storePro = "[dbo].[proc_GetRolesByIdUser]";
            DbCommand oCmd = Db.GetStoredProcCommand(storePro);
            Db.AddInParameter(oCmd, "@IdUser", DbType.Guid, userId);
            IDataReader oDReader = Db.ExecuteReader(oCmd);
            while (oDReader.Read())
            {
                eUser obj = new eUser();
                eRoles objRole = new eRoles();
                objRole.Role_id = ValidateFields.GetSafeGuid(oDReader["role_id"].ToString());
                objRole.Description_eng = ValidateFields.GetSafeString(oDReader["description_eng"].ToString());
                obj.User_id = ValidateFields.GetSafeGuid(oDReader["user_id"].ToString());
                obj.User_status = ValidateFields.GetSafeBoolean(oDReader["user_status"].ToString());
                obj.Display_name = ValidateFields.GetSafeString(oDReader["display_name"].ToString());
                obj.User_name = ValidateFields.GetSafeString(oDReader["user_name"].ToString());
                obj.ObjRoles.Add(objRole);
                oeListObject.Add(obj);
            }
            return oeListObject;
        }

        public static UpdateEntryInfo InsertUser(eUser oeUser)
        {
            string storProc = "[dbo].[proc_CreateUser]";
            int effectRow = 0;
            UpdateEntryInfo insertInfo = new UpdateEntryInfo();
            if (oeUser != null)
            {
                using (DbCommand oCmd = Db.GetStoredProcCommand(storProc))
                {
                    try
                    {
                        Db.AddInParameter(oCmd, "@IdUser", DbType.Guid, oeUser.User_id);
                        Db.AddInParameter(oCmd, "@UserName", DbType.String, oeUser.User_name);
                        Db.AddInParameter(oCmd, "@Password", DbType.String, oeUser.Password);
                        Db.AddInParameter(oCmd, "@UserStatus", DbType.Boolean, oeUser.User_status);
                        Db.AddInParameter(oCmd, "@DisplayName", DbType.String, oeUser.Display_name);
                        Db.AddInParameter(oCmd, "@AccessDateTime", DbType.DateTime, oeUser.Access_datetime);
                        effectRow = Db.ExecuteNonQuery(oCmd);
                        if (effectRow != 0)
                        {
                            insertInfo.Id = oeUser.User_id;
                            insertInfo.Success = true;
                        }
                        else
                        {
                            insertInfo.Success = false;
                        }
                    }
                    catch (Exception ex)
                    {
                        insertInfo.Exception = ex.Message;
                    }
                }
            }
            return insertInfo;
        }

        public static UpdateEntryInfo InsertUserRoles(eUser oeUser)
        {
            string storProc = "[dbo].[proc_CreateUserRoles]";
            int effectRow = 0;
            UpdateEntryInfo insertInfo = new UpdateEntryInfo();
            if (oeUser != null)
            {
                using (DbCommand oCmd = Db.GetStoredProcCommand(storProc))
                {
                    try
                    {
                        Db.AddInParameter(oCmd, "@IdUserRole", DbType.Guid, Guid.NewGuid());
                        Db.AddInParameter(oCmd, "@IdRole", DbType.Guid, oeUser.ObjRoles[0].Role_id);
                        Db.AddInParameter(oCmd, "@IdUser", DbType.Guid, oeUser.User_id);
                        effectRow = Db.ExecuteNonQuery(oCmd);
                        if (effectRow != 0)
                        {
                            insertInfo.Id = oeUser.User_id;
                            insertInfo.Success = true;
                        }
                        else
                        {
                            insertInfo.Success = false;
                        }
                    }
                    catch (Exception ex)
                    {
                        insertInfo.Exception = ex.Message;
                    }
                }
            }
            return insertInfo;
        }

        public static UpdateEntryInfo DeleteUser(Guid? user_id)
        {
            string storProc = "[dbo].[proc_DeleteUser]";
            UpdateEntryInfo deleteInfo = new UpdateEntryInfo();
            int effectRow = 0;
            using (DbCommand oCmd = Db.GetStoredProcCommand(storProc))
            {
                try
                {
                    Db.AddInParameter(oCmd, "@IdUser", DbType.Guid, user_id);
                    effectRow = Db.ExecuteNonQuery(oCmd);
                    if (effectRow != 0)
                    {
                        deleteInfo.Id = user_id;
                        deleteInfo.Success = true;
                    }
                    else
                    {
                        deleteInfo.Success = false;
                    }
                }
                catch (Exception ex)
                {
                    deleteInfo.Exception = ex.Message;
                }
            }
            return deleteInfo;
        }

        public static UpdateEntryInfo UpdateUser(eUser oeUser)
        {
            string storProc = "[dbo].[proc_UpdateUser]";
            UpdateEntryInfo updateInfo = new UpdateEntryInfo();
            int effectRow = 0;
            if (oeUser != null)
            {
                using (DbCommand oCmd = Db.GetStoredProcCommand(storProc))
                {
                    try
                    {
                        Db.AddInParameter(oCmd, "@IdUser", DbType.Guid, oeUser.User_id);
                        Db.AddInParameter(oCmd, "@UserName", DbType.String, oeUser.User_name);
                        Db.AddInParameter(oCmd, "@Password", DbType.String, oeUser.Password);
                        Db.AddInParameter(oCmd, "@UserStatus", DbType.Boolean, oeUser.User_status);
                        Db.AddInParameter(oCmd, "@DisplayName", DbType.String, oeUser.Display_name);
                        Db.AddInParameter(oCmd, "@AccessDateTime", DbType.DateTime, oeUser.Access_datetime);
                        effectRow = Db.ExecuteNonQuery(oCmd);
                        if (effectRow != 0)
                        {
                            updateInfo.Id = oeUser.User_id;
                            updateInfo.Success = true;
                        }
                        else
                        {
                            updateInfo.Success = false;
                        }
                    }
                    catch (Exception ex)
                    {
                        updateInfo.Exception = ex.Message;
                    }
                }
            }
            return updateInfo;
        }

        public static UpdateEntryInfo UpdateUserWithRoleByUserId(eUser oeUser)
        {
            string storProc = "[dbo].[proc_UpdateUserWithRoleByUserId]";
            UpdateEntryInfo updateInfo = new UpdateEntryInfo();
            int effectRow = 0;
            if (oeUser != null)
            {
                using (DbCommand oCmd = Db.GetStoredProcCommand(storProc))
                {
                    try
                    {
                        Db.AddInParameter(oCmd, "@IdUser", DbType.Guid, oeUser.User_id);
                        Db.AddInParameter(oCmd, "@UserName", DbType.String, oeUser.User_name);
                        Db.AddInParameter(oCmd, "@Password", DbType.String, oeUser.Password);
                        Db.AddInParameter(oCmd, "@UserStatus", DbType.Boolean, oeUser.User_status);
                        Db.AddInParameter(oCmd, "@DisplayName", DbType.String, oeUser.Display_name);
                        Db.AddInParameter(oCmd, "@AccessDateTime", DbType.DateTime, oeUser.Access_datetime);
                        Db.AddInParameter(oCmd, "@RoleId", DbType.Guid, oeUser.ObjRoles[0].Role_id);
                        effectRow = Db.ExecuteNonQuery(oCmd);
                        if (effectRow != 0)
                        {
                            updateInfo.Id = oeUser.User_id;
                            updateInfo.Success = true;
                        }
                        else
                        {
                            updateInfo.Success = false;
                        }
                    }
                    catch (Exception ex)
                    {
                        updateInfo.Exception = ex.Message;
                    }
                }
            }
            return updateInfo;
        }

        public static List<eUser> ValidateLogin(string username, string password)
        {
            List<eUser> oeListObject = new List<eUser>();
            string storePro = "[dbo].[proc_ValidateUser]";
            DbCommand oCmd = Db.GetStoredProcCommand(storePro);
            Db.AddInParameter(oCmd, "@UserName", DbType.String, username);
            Db.AddInParameter(oCmd, "@UserPassword", DbType.String, password);
            IDataReader oDReader = Db.ExecuteReader(oCmd);
            while (oDReader.Read())
            {
                eUser obj = new eUser();
                eRoles objRole = new eRoles();
                obj.User_id = ValidateFields.GetSafeGuid(oDReader["user_id"].ToString());
                obj.User_status = ValidateFields.GetSafeBoolean(oDReader["user_status"].ToString());
                obj.Display_name = ValidateFields.GetSafeString(oDReader["display_name"].ToString());
                obj.User_name = ValidateFields.GetSafeString(oDReader["user_name"].ToString());
                //obj.Password = ValidateFields.GetSafeString(oDReader["password"].ToString());
                obj.Login_status = ValidateFields.GetSafeBoolean(oDReader["login_status"].ToString());
                //obj.Access_datetime = ValidateFields.GetSafeDateTime(oDReader["access_datetime"].ToString());
                obj.System_name = ValidateFields.GetSafeString(oDReader["system_name"].ToString());
                objRole.Role_id = ValidateFields.GetSafeGuid(oDReader["role_id"].ToString());
                obj.ObjRoles.Add(objRole); 
                oeListObject.Add(obj);
            }
            return oeListObject;
        }



        public override void InitializeAccessors()
        {
            throw new NotImplementedException();
        }
    }
}
