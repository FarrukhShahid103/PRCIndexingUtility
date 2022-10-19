using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Indexing.EL;
using Indexing.DLL;

namespace Indexing.BLL
{
    public class bUsersLog
    {
        public static List<eUsersLog> GetUsersLog(eUsersLog oeUsersLog)
        {
            string condition = BuildCondition(oeUsersLog);
            List<eUsersLog> oeListIndexing = new List<eUsersLog>();
            oeListIndexing = dUsersLog.GetUsersLog(condition);
            return oeListIndexing;
        }

        public static UpdateEntryInfo insertUsersLog(eUsersLog oeUsersLog)
        {
            UpdateEntryInfo insertInfo = new UpdateEntryInfo();
            insertInfo = dUsersLog.InsertUsersLog(oeUsersLog);
            return insertInfo;
        }

        public static UpdateEntryInfo udpateUsersLog(eUsersLog oeUsersLog)
        {
            UpdateEntryInfo updateInfo = new UpdateEntryInfo();
            updateInfo = dUsersLog.UpdateUsersLog(oeUsersLog);
            return updateInfo;
        }

        public static UpdateEntryInfo deleteUsersLog(eUsersLog oeUsersLog)
        {
            UpdateEntryInfo deleteInfo = new UpdateEntryInfo();
            deleteInfo = dUsersLog.DeleteUsersLog(oeUsersLog.Userlog_id);
            return deleteInfo;
        }


        private static string BuildCondition(eUsersLog oeUsersLog)
        {
            string result = "";
            if (oeUsersLog.Userlog_id != Guid.Empty)
                result += (result == "" ? "" : " AND ") + "userlog_id = '" + oeUsersLog.Userlog_id + "'";
            if (oeUsersLog.User_name != null && oeUsersLog.User_name != string.Empty)
                result += (result == "" ? "" : " AND ") + "user_name = '" + oeUsersLog.User_name + "'";
            if (oeUsersLog.Operation_id != 0)
                result += (result == "" ? "" : " AND ") + "operation_id = '" + oeUsersLog.Operation_id + "'";

            if ((oeUsersLog.Log_dateFrom != null && ValidateFields.GetSafeString(oeUsersLog.Log_dateFrom) != String.Empty)
                || (oeUsersLog.Log_dateTo != null && ValidateFields.GetSafeString(oeUsersLog.Log_dateTo) != String.Empty))
            {
                if ((oeUsersLog.Log_dateFrom != null && ValidateFields.GetSafeString(oeUsersLog.Log_dateFrom) != String.Empty)
                && (oeUsersLog.Log_dateTo != null && ValidateFields.GetSafeString(oeUsersLog.Log_dateTo) != String.Empty))
                {
                    result += (result == "" ? "" : " AND ") + "(convert(date,log_datetime,105) >= TRY_PARSE('" + oeUsersLog.Log_dateFrom + "' AS date USING 'en-gb') AND convert(date,log_datetime,105) <= TRY_PARSE('" + oeUsersLog.Log_dateTo + "' AS date USING 'en-gb')) ";
                }
                else if (oeUsersLog.Log_dateFrom != null && ValidateFields.GetSafeString(oeUsersLog.Log_dateFrom) != String.Empty)
                {
                    result += (result == "" ? "" : " AND ") + "convert(date,log_datetime,105) >= TRY_PARSE('" + oeUsersLog.Log_dateFrom + "' AS date USING 'en-gb') ";
                }
                else if (oeUsersLog.Log_dateTo != null && ValidateFields.GetSafeString(oeUsersLog.Log_dateTo) != String.Empty)
                {
                    result += (result == "" ? "" : " AND ") + "convert(date,log_datetime,105) <= TRY_PARSE('" + oeUsersLog.Log_dateTo + "' AS date USING 'en-gb') ";
                }
            }

            //if (oeUsersLog.Log_datetime != null && oeUsersLog.Log_datetime != string.Empty)
            //    result += (result == "" ? "" : " AND ") + "convert(date,log_datetime,105) = convert(date,'" + oeUsersLog.Log_datetime + "',105)";
            if (oeUsersLog.Scan_no != null && oeUsersLog.Scan_no != string.Empty)
                result += (result == "" ? "" : " AND ") + "scan_no = '" + oeUsersLog.Scan_no + "'";
            if (oeUsersLog.Ipadress != null && oeUsersLog.Ipadress != string.Empty)
                result += (result == "" ? "" : " AND ") + "ipadress = '" + oeUsersLog.Ipadress + "'";
            if (oeUsersLog.Access_datetime != DateTime.MinValue)
                result += (result == "" ? "" : " AND ") + "access_datetime = '" + oeUsersLog.Access_datetime + "'";

            if (result != "")
                result = (" WHERE " + result);
            return result;
        }
    }
}
