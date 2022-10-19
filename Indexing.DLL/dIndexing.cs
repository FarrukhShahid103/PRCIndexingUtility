using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Indexing.EL;
using System.Data.Common;
using System.Data;

namespace Indexing.DLL
{
    public class dIndexing : DatabaseConnection
    {      
        public static List<eIndexing> GetIndexing(string condition)
        {
            List<eIndexing> oeListObject = new List<eIndexing>();
            string storePro = "[transactions].[proc_GetIndexing]";
            DbCommand oCmd = Db.GetStoredProcCommand(storePro);
            Db.AddInParameter(oCmd, "@condition", DbType.String, condition);
            //Db.AddInParameter(oCmd, "@recordFrom", DbType.String, recordFrom);
            //Db.AddInParameter(oCmd, "@recordTo", DbType.String, recordTo);
            IDataReader oDReader = Db.ExecuteReader(oCmd);
            while (oDReader.Read())
            {
                eIndexing obj = new eIndexing();
                obj.Indexing_id = ValidateFields.GetSafeGuid(oDReader["indexing_id"].ToString());
                obj.Image_id = ValidateFields.GetSafeGuid(oDReader["image_id"].ToString());
                obj.Indexing_metadata = ValidateFields.GetSafeString(oDReader["indexing_metadata"].ToString());
                obj.Zilla_id = ValidateFields.GetSafeGuid(oDReader["zilla_id"].ToString());
                obj.Taluka_id = ValidateFields.GetSafeGuid(oDReader["taluka_id"].ToString());
                obj.Deh_id = ValidateFields.GetSafeGuid(oDReader["deh_id"].ToString());
                obj.Register_id = ValidateFields.GetSafeInteger(oDReader["register_id"].ToString());
                obj.Register_name = ValidateFields.GetSafeString(oDReader["register_name"].ToString());
                obj.Scheme_name = ValidateFields.GetSafeString(oDReader["scheme_name"].ToString());
                obj.Scan_no = ValidateFields.GetSafeString(oDReader["scan_no"].ToString());
                //obj.Scan_date = ValidateFields.GetSafeDateTime(oDReader["scan_date"].ToString());
                obj.Scan_date = ValidateFields.GetSafeString(oDReader["scan_date"].ToString());
                obj.Entry_no = ValidateFields.GetSafeString(oDReader["entry_no"].ToString());
                //obj.Entry_date = ValidateFields.GetSafeDateTime(oDReader["entry_date"].ToString());
                obj.Entry_date = ValidateFields.GetSafeString(oDReader["entry_date"].ToString());
                obj.Survey_no = ValidateFields.GetSafeString(oDReader["survey_no"].ToString());
                obj.Book_no = ValidateFields.GetSafeString(oDReader["book_no"].ToString());
                obj.Page_no = ValidateFields.GetSafeString(oDReader["page_no"].ToString());
                obj.Owner_name = ValidateFields.GetSafeString(oDReader["owner_name"].ToString());
                obj.Cnic = ValidateFields.GetSafeString(oDReader["cnic"].ToString());
                obj.User_id = ValidateFields.GetSafeGuid(oDReader["user_id"].ToString());
                obj.Access_date_time = ValidateFields.GetSafeDateTime(oDReader["access_date_time"].ToString());
                oeListObject.Add(obj);
            }
            return oeListObject;
        }

        public static List<eIndexing> GetIndexing(string condition, string startIndex, string endIndex, ref long totalRecords)
        {
            List<eIndexing> oeListObject = new List<eIndexing>();
            string storePro = "[transactions].[proc_GetIndexing]";
            DbCommand oCmd = Db.GetStoredProcCommand(storePro);
            Db.AddInParameter(oCmd, "@condition", DbType.String, condition);
            Db.AddInParameter(oCmd, "@startIndex", DbType.String, startIndex);
            Db.AddInParameter(oCmd, "@endIndex", DbType.String, endIndex);
            Db.AddOutParameter(oCmd, "@totrecord", DbType.Int64, -1); 
            IDataReader oDReader = Db.ExecuteReader(oCmd);
            while (oDReader.Read())
            {
                eIndexing obj = new eIndexing();
                obj.Indexing_id = ValidateFields.GetSafeGuid(oDReader["indexing_id"].ToString());
                obj.Image_id = ValidateFields.GetSafeGuid(oDReader["image_id"].ToString());
                obj.Indexing_metadata = ValidateFields.GetSafeString(oDReader["indexing_metadata"].ToString());
                obj.Zilla_id = ValidateFields.GetSafeGuid(oDReader["zilla_id"].ToString());
                obj.Taluka_id = ValidateFields.GetSafeGuid(oDReader["taluka_id"].ToString());
                obj.Deh_id = ValidateFields.GetSafeGuid(oDReader["deh_id"].ToString());
                obj.Register_id = ValidateFields.GetSafeInteger(oDReader["register_id"].ToString());
                obj.Register_name = ValidateFields.GetSafeString(oDReader["register_name"].ToString());
                obj.Scheme_name = ValidateFields.GetSafeString(oDReader["scheme_name"].ToString());
                obj.Scan_no = ValidateFields.GetSafeString(oDReader["scan_no"].ToString());
                obj.Scan_date = ValidateFields.GetSafeString(oDReader["scan_date"].ToString());
                obj.Entry_no = ValidateFields.GetSafeString(oDReader["entry_no"].ToString());
                obj.Entry_date = ValidateFields.GetSafeString(oDReader["entry_date"].ToString());
                obj.Survey_no = ValidateFields.GetSafeString(oDReader["survey_no"].ToString());
                obj.Book_no = ValidateFields.GetSafeString(oDReader["book_no"].ToString());
                obj.Page_no = ValidateFields.GetSafeString(oDReader["page_no"].ToString());
                obj.Owner_name = ValidateFields.GetSafeString(oDReader["owner_name"].ToString());
                obj.Cnic = ValidateFields.GetSafeString(oDReader["cnic"].ToString());
                obj.User_id = ValidateFields.GetSafeGuid(oDReader["user_id"].ToString());
                obj.Access_date_time = ValidateFields.GetSafeDateTime(oDReader["access_date_time"].ToString());
                obj.Zilla_name = ValidateFields.GetSafeString(oDReader["zilla_name_eng"].ToString());
                obj.Taluka_name = ValidateFields.GetSafeString(oDReader["taluka_name_eng"].ToString());
                obj.Deh_name = ValidateFields.GetSafeString(oDReader["deh_name_eng"].ToString());
                oeListObject.Add(obj);
            }
            //totalRecords = (Int32)Db.GetParameterValue(oCmd, "@totrecord");
            return oeListObject;
        }

        public static List<eIndexing> GetTerritoryInfoWithIndexing(string condition)
        {
            List<eIndexing> oeListObject = new List<eIndexing>();
            string storePro = "[transactions].[proc_GetTerritoryInfoWithIndexing]";
            DbCommand oCmd = Db.GetStoredProcCommand(storePro);
            Db.AddInParameter(oCmd, "@condition", DbType.String, condition);
            IDataReader oDReader = Db.ExecuteReader(oCmd);
            while (oDReader.Read())
            {
                eIndexing obj = new eIndexing();
                obj.Indexing_id = ValidateFields.GetSafeGuid(oDReader["indexing_id"].ToString());
                obj.Image_id = ValidateFields.GetSafeGuid(oDReader["image_id"].ToString());
                obj.Zilla_name = ValidateFields.GetSafeString(oDReader["zilla_name"].ToString());
                obj.Taluka_name = ValidateFields.GetSafeString(oDReader["taluka_name"].ToString());
                obj.Deh_name = ValidateFields.GetSafeString(oDReader["deh_name"].ToString());
                obj.Indexing_metadata = ValidateFields.GetSafeString(oDReader["indexing_metadata"].ToString());
                obj.Zilla_id = ValidateFields.GetSafeGuid(oDReader["zilla_id"].ToString());
                obj.Taluka_id = ValidateFields.GetSafeGuid(oDReader["taluka_id"].ToString());
                obj.Deh_id = ValidateFields.GetSafeGuid(oDReader["deh_id"].ToString());
                obj.Register_id = ValidateFields.GetSafeInteger(oDReader["register_id"].ToString());
                obj.Register_name = ValidateFields.GetSafeString(oDReader["register_name"].ToString());
                obj.Scheme_name = ValidateFields.GetSafeString(oDReader["scheme_name"].ToString());
                obj.Scan_no = ValidateFields.GetSafeString(oDReader["scan_no"].ToString());
                obj.Scan_date = ValidateFields.GetSafeString(oDReader["scan_date"].ToString());
                obj.Entry_no = ValidateFields.GetSafeString(oDReader["entry_no"].ToString());
                obj.Entry_date = ValidateFields.GetSafeString(oDReader["entry_date"].ToString());
                obj.Survey_no = ValidateFields.GetSafeString(oDReader["survey_no"].ToString());
                obj.Book_no = ValidateFields.GetSafeString(oDReader["book_no"].ToString());
                obj.Page_no = ValidateFields.GetSafeString(oDReader["page_no"].ToString());
                obj.Owner_name = ValidateFields.GetSafeString(oDReader["owner_name"].ToString());
                obj.Cnic = ValidateFields.GetSafeString(oDReader["cnic"].ToString());
                obj.User_id = ValidateFields.GetSafeGuid(oDReader["user_id"].ToString());
                obj.Access_date_time = ValidateFields.GetSafeDateTime(oDReader["access_date_time"].ToString());
                oeListObject.Add(obj);
            }
            return oeListObject;
        }

        public static string getTotalRows(string condition)
        {
            string totalRows = "";
            string storProc = "[transactions].[proc_GetTotalRows]";
            DbCommand oCmd = Db.GetStoredProcCommand(storProc);
            Db.AddInParameter(oCmd, "@condition", DbType.String, condition);
            IDataReader oDReader = Db.ExecuteReader(oCmd);
            while (oDReader.Read())
            {
                totalRows = ValidateFields.GetSafeString(oDReader[0].ToString());
            }
            return totalRows;
        }

        public static UpdateEntryInfo InsertIndexing(eIndexing oeIndexing)
        {
            string storProc = "[transactions].[proc_CreateIndexing]";
            int effectRow = 0;
            UpdateEntryInfo insertInfo = new UpdateEntryInfo();
            if (oeIndexing != null)
            {
                using (DbCommand oCmd = Db.GetStoredProcCommand(storProc))
                {
                    try
                    {
                        Db.AddInParameter(oCmd, "@Indexing_id", DbType.Guid, oeIndexing.Indexing_id);
                        Db.AddInParameter(oCmd, "@Image_id", DbType.Guid, oeIndexing.Image_id);
                        Db.AddInParameter(oCmd, "@Indexing_metadata", DbType.String, oeIndexing.Indexing_metadata);
                        Db.AddInParameter(oCmd, "@Zilla_id", DbType.Guid, oeIndexing.Zilla_id);
                        Db.AddInParameter(oCmd, "@Taluka_id", DbType.Guid, oeIndexing.Taluka_id);
                        Db.AddInParameter(oCmd, "@Deh_id", DbType.Guid, oeIndexing.Deh_id);
                        Db.AddInParameter(oCmd, "@Register_id", DbType.Int32, oeIndexing.Register_id);
                        Db.AddInParameter(oCmd, "@Register_name", DbType.String, oeIndexing.Register_name);
                        Db.AddInParameter(oCmd, "@Scheme_name", DbType.String, oeIndexing.Scheme_name);
                        Db.AddInParameter(oCmd, "@Scan_no", DbType.String, oeIndexing.Scan_no);
                        Db.AddInParameter(oCmd, "@Scan_date", DbType.Date, oeIndexing.Scan_date);
                        Db.AddInParameter(oCmd, "@Entry_no", DbType.String, oeIndexing.Entry_no);
                        Db.AddInParameter(oCmd, "@Entry_date", DbType.Date, oeIndexing.Entry_date);
                        Db.AddInParameter(oCmd, "@Survey_no", DbType.String, oeIndexing.Survey_no);
                        Db.AddInParameter(oCmd, "@Book_no", DbType.String, oeIndexing.Book_no);
                        Db.AddInParameter(oCmd, "@Page_no", DbType.String, oeIndexing.Page_no);
                        Db.AddInParameter(oCmd, "@Owner_name", DbType.String, oeIndexing.Owner_name);
                        Db.AddInParameter(oCmd, "@Cnic", DbType.String, oeIndexing.Cnic);
                        Db.AddInParameter(oCmd, "@User_id", DbType.Guid, oeIndexing.User_id);
                        Db.AddInParameter(oCmd, "@Access_date_time", DbType.DateTime, oeIndexing.Access_date_time);
                        effectRow = Db.ExecuteNonQuery(oCmd);
                        if (effectRow != 0)
                        {
                            insertInfo.Id = oeIndexing.Indexing_id;
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

        public static UpdateEntryInfo InsertIndexingWithImage(eIndexing oeIndexing)
        {
            string storProc = "[transactions].[proc_InsertIndexingWithImage]";
            int effectRow = 0;
            UpdateEntryInfo insertInfo = new UpdateEntryInfo();
            if (oeIndexing != null)
            {
                using (DbCommand oCmd = Db.GetStoredProcCommand(storProc))
                {
                    try
                    {
                        Db.AddInParameter(oCmd, "@Indexing_id", DbType.Guid, oeIndexing.Indexing_id);
                        Db.AddInParameter(oCmd, "@Indexing_metadata", DbType.String, oeIndexing.Indexing_metadata);
                        Db.AddInParameter(oCmd, "@Zilla_id", DbType.Guid, oeIndexing.Zilla_id);
                        Db.AddInParameter(oCmd, "@Taluka_id", DbType.Guid, oeIndexing.Taluka_id);
                        Db.AddInParameter(oCmd, "@Deh_id", DbType.Guid, oeIndexing.Deh_id);
                        Db.AddInParameter(oCmd, "@Register_id", DbType.Int32, oeIndexing.Register_id);
                        Db.AddInParameter(oCmd, "@Register_name", DbType.String, oeIndexing.Register_name);
                        Db.AddInParameter(oCmd, "@Scheme_name", DbType.String, oeIndexing.Scheme_name);
                        Db.AddInParameter(oCmd, "@Scan_no", DbType.String, oeIndexing.Scan_no);
                        Db.AddInParameter(oCmd, "@Scan_date", DbType.String, oeIndexing.Scan_date);
                        Db.AddInParameter(oCmd, "@Entry_no", DbType.String, oeIndexing.Entry_no);
                        Db.AddInParameter(oCmd, "@Entry_date", DbType.String, oeIndexing.Entry_date);
                        Db.AddInParameter(oCmd, "@Survey_no", DbType.String, oeIndexing.Survey_no);
                        Db.AddInParameter(oCmd, "@Book_no", DbType.String, oeIndexing.Book_no);
                        Db.AddInParameter(oCmd, "@Page_no", DbType.String, oeIndexing.Page_no);
                        Db.AddInParameter(oCmd, "@Owner_name", DbType.String, oeIndexing.Owner_name);
                        Db.AddInParameter(oCmd, "@Cnic", DbType.String, oeIndexing.Cnic);
                        Db.AddInParameter(oCmd, "@User_id", DbType.Guid, oeIndexing.User_id);
                        Db.AddInParameter(oCmd, "@Access_date_time", DbType.DateTime, oeIndexing.Access_date_time);
                        Db.AddInParameter(oCmd, "@Image_id", DbType.Guid, oeIndexing.Image_id);
                        Db.AddInParameter(oCmd, "@Image_file", DbType.Binary, oeIndexing.ObjScanImages.Image_file);
                        //For UsersLog
                        Db.AddInParameter(oCmd, "@Userlog_id", DbType.Guid, oeIndexing.OeUsersLog.Userlog_id);
                        Db.AddInParameter(oCmd, "@user_name", DbType.String, oeIndexing.OeUsersLog.User_name);
                        Db.AddInParameter(oCmd, "@Ipadress", DbType.String, oeIndexing.OeUsersLog.Ipadress);
                        Db.AddInParameter(oCmd, "@Operation_id", DbType.Int32, oeIndexing.OeUsersLog.Operation_id);
                        Db.AddInParameter(oCmd, "@Log_datetime", DbType.DateTime, oeIndexing.OeUsersLog.Log_datetime);
                        //End UsersLog
                        effectRow = Db.ExecuteNonQuery(oCmd);
                        if (effectRow != 0)
                        {
                            insertInfo.Id = oeIndexing.Indexing_id;
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

        public static UpdateEntryInfo DeleteIndexing(Guid? indexingId)
        {
            string storProc = "[transactions].[proc_DeleteIndexing]";
            UpdateEntryInfo deleteInfo = new UpdateEntryInfo();
            int effectRow = 0;
            using (DbCommand oCmd = Db.GetStoredProcCommand(storProc))
            {
                try
                {
                    Db.AddInParameter(oCmd, "@Indexing_id", DbType.Guid, indexingId);
                    effectRow = Db.ExecuteNonQuery(oCmd);
                    if (effectRow != 0)
                    {
                        deleteInfo.Id = indexingId;
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

        public static UpdateEntryInfo DeleteIndexingWithImage(Guid? indexingId)
        {
            string storProc = "[transactions].[proc_DeleteIndexingWithImage]";
            UpdateEntryInfo deleteInfo = new UpdateEntryInfo();
            int effectRow = 0;
            using (DbCommand oCmd = Db.GetStoredProcCommand(storProc))
            {
                try
                {
                    Db.AddInParameter(oCmd, "@Indexing_id", DbType.Guid, indexingId);
                    effectRow = Db.ExecuteNonQuery(oCmd);
                    if (effectRow != 0)
                    {
                        deleteInfo.Id = indexingId;
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

        public static UpdateEntryInfo UpdateIndexing(eIndexing oeIndexing)
        {
            string storProc = "[transactions].[proc_UpdateIndexing]";
            UpdateEntryInfo updateInfo = new UpdateEntryInfo();
            int effectRow = 0;
            if (oeIndexing != null)
            {
                using (DbCommand oCmd = Db.GetStoredProcCommand(storProc))
                {
                    try
                    {
                        Db.AddInParameter(oCmd, "@Indexing_id", DbType.Guid, oeIndexing.Indexing_id);
                        //Db.AddInParameter(oCmd, "@Image_id", DbType.Guid, oeIndexing.Image_id);
                        Db.AddInParameter(oCmd, "@Indexing_metadata", DbType.String, oeIndexing.Indexing_metadata);
                        Db.AddInParameter(oCmd, "@Zilla_id", DbType.Guid, oeIndexing.Zilla_id);
                        Db.AddInParameter(oCmd, "@Taluka_id", DbType.Guid, oeIndexing.Taluka_id);
                        Db.AddInParameter(oCmd, "@Deh_id", DbType.Guid, oeIndexing.Deh_id);
                        Db.AddInParameter(oCmd, "@Register_id", DbType.Int32, oeIndexing.Register_id);
                        Db.AddInParameter(oCmd, "@Register_name", DbType.String, oeIndexing.Register_name);
                        Db.AddInParameter(oCmd, "@Scheme_name", DbType.String, oeIndexing.Scheme_name);
                        Db.AddInParameter(oCmd, "@Scan_no", DbType.String, oeIndexing.Scan_no);
                        Db.AddInParameter(oCmd, "@Scan_date", DbType.String, oeIndexing.Scan_date);
                        Db.AddInParameter(oCmd, "@Entry_no", DbType.String, oeIndexing.Entry_no);
                        Db.AddInParameter(oCmd, "@Entry_date", DbType.String, oeIndexing.Entry_date);
                        Db.AddInParameter(oCmd, "@Survey_no", DbType.String, oeIndexing.Survey_no);
                        Db.AddInParameter(oCmd, "@Book_no", DbType.String, oeIndexing.Book_no);
                        Db.AddInParameter(oCmd, "@Page_no", DbType.String, oeIndexing.Page_no);
                        Db.AddInParameter(oCmd, "@Owner_name", DbType.String, oeIndexing.Owner_name);
                        Db.AddInParameter(oCmd, "@Cnic", DbType.String, oeIndexing.Cnic);
                        Db.AddInParameter(oCmd, "@User_id", DbType.Guid, oeIndexing.User_id);
                        Db.AddInParameter(oCmd, "@Access_date_time", DbType.DateTime, oeIndexing.Access_date_time);
                        //For UsersLog
                        Db.AddInParameter(oCmd, "@Userlog_id", DbType.Guid, oeIndexing.OeUsersLog.Userlog_id);
                        Db.AddInParameter(oCmd, "@user_name", DbType.String, oeIndexing.OeUsersLog.User_name);
                        Db.AddInParameter(oCmd, "@Ipadress", DbType.String, oeIndexing.OeUsersLog.Ipadress);
                        Db.AddInParameter(oCmd, "@Operation_id", DbType.Int32, oeIndexing.OeUsersLog.Operation_id);
                        Db.AddInParameter(oCmd, "@Log_datetime", DbType.DateTime, oeIndexing.OeUsersLog.Log_datetime);
                        //End UsersLog
                        effectRow = Db.ExecuteNonQuery(oCmd);
                        if (effectRow != 0)
                        {
                            updateInfo.Id = oeIndexing.Indexing_id;
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
