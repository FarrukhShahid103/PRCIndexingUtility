using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Indexing.EL;
using System.Data.Common;
using System.Data;

namespace Indexing.DLL
{
    public class dUsersLog : DatabaseConnection
    {
        public static List<eUsersLog> GetUsersLog(string condition)
        {
            List<eUsersLog> oeListObject = new List<eUsersLog>();
            string storePro = "[users].[proc_GetUsersLog]";
            DbCommand oCmd = Db.GetStoredProcCommand(storePro);
            Db.AddInParameter(oCmd, "@condition", DbType.String, condition);
            IDataReader oDReader = Db.ExecuteReader(oCmd);
            while (oDReader.Read())
            {
                eUsersLog obj = new eUsersLog();
                obj.Userlog_id = ValidateFields.GetSafeGuid(oDReader["userlog_id"].ToString());
                obj.User_name = ValidateFields.GetSafeString(oDReader["user_name"].ToString());
                obj.Operation_id = ValidateFields.GetSafeInteger(oDReader["operation_id"].ToString());
                obj.Log_datetime = ValidateFields.GetSafeString(oDReader["log_datetime"].ToString());
                obj.Scan_no = ValidateFields.GetSafeString(oDReader["scan_no"].ToString());
                obj.Ipadress = ValidateFields.GetSafeString(oDReader["ipadress"].ToString());
                obj.Access_datetime = ValidateFields.GetSafeDateTime(oDReader["access_datetime"].ToString());
                oeListObject.Add(obj);
            }
            return oeListObject;
        }

        public static UpdateEntryInfo InsertUsersLog(eUsersLog oeUsersLog)
        {
            string storProc = "[users].[proc_InsertUsersLog]";
            int effectRow = 0;
            UpdateEntryInfo insertInfo = new UpdateEntryInfo();
            if (oeUsersLog != null)
            {
                using (DbCommand oCmd = Db.GetStoredProcCommand(storProc))
                {
                    try
                    {
                        Db.AddInParameter(oCmd, "@userlog_id", DbType.Guid, oeUsersLog.Userlog_id);
                        Db.AddInParameter(oCmd, "@user_name", DbType.String, oeUsersLog.User_name);
                        Db.AddInParameter(oCmd, "@operation_id", DbType.Guid, oeUsersLog.Operation_id);
                        Db.AddInParameter(oCmd, "@log_datetime", DbType.Guid, oeUsersLog.Log_datetime);
                        Db.AddInParameter(oCmd, "@scan_no", DbType.Guid, oeUsersLog.Scan_no);
                        Db.AddInParameter(oCmd, "@ipadress", DbType.Guid, oeUsersLog.Ipadress);
                        Db.AddInParameter(oCmd, "@access_datetime", DbType.Guid, oeUsersLog.Access_datetime);
                        effectRow = Db.ExecuteNonQuery(oCmd);
                        if (effectRow != 0)
                        {
                            insertInfo.Id = oeUsersLog.Userlog_id;
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

        public static UpdateEntryInfo DeleteUsersLog(Guid? userlog_id)
        {
            string storProc = "[users].[proc_DeleteUsersLog]";
            UpdateEntryInfo deleteInfo = new UpdateEntryInfo();
            int effectRow = 0;
            using (DbCommand oCmd = Db.GetStoredProcCommand(storProc))
            {
                try
                {
                    Db.AddInParameter(oCmd, "@userlog_id", DbType.Guid, userlog_id);
                    effectRow = Db.ExecuteNonQuery(oCmd);
                    if (effectRow != 0)
                    {
                        deleteInfo.Id = userlog_id;
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

        public static UpdateEntryInfo UpdateUsersLog(eUsersLog oeUsersLog)
        {
            string storProc = "[users].[proc_UpdateUsersLog]";
            UpdateEntryInfo updateInfo = new UpdateEntryInfo();
            int effectRow = 0;
            if (oeUsersLog != null)
            {
                using (DbCommand oCmd = Db.GetStoredProcCommand(storProc))
                {
                    try
                    {
                        Db.AddInParameter(oCmd, "@userlog_id", DbType.Guid, oeUsersLog.Userlog_id);
                        Db.AddInParameter(oCmd, "@user_name", DbType.String, oeUsersLog.User_name);
                        Db.AddInParameter(oCmd, "@operation_id", DbType.Guid, oeUsersLog.Operation_id);
                        Db.AddInParameter(oCmd, "@log_datetime", DbType.Guid, oeUsersLog.Log_datetime);
                        Db.AddInParameter(oCmd, "@scan_no", DbType.Guid, oeUsersLog.Scan_no);
                        Db.AddInParameter(oCmd, "@ipadress", DbType.Guid, oeUsersLog.Ipadress);
                        Db.AddInParameter(oCmd, "@access_datetime", DbType.Guid, oeUsersLog.Access_datetime);
                        effectRow = Db.ExecuteNonQuery(oCmd);
                        if (effectRow != 0)
                        {
                            updateInfo.Id = oeUsersLog.Userlog_id;
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

        public override void InitializeAccessors()
        {
            throw new NotImplementedException();
        }

    }
}
