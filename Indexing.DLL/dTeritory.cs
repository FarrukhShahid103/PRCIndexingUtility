using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Common;
using System.Data;
using Indexing.EL;

namespace Indexing.DLL
{
    public class dTeritory : DatabaseConnection
    {
        //DbCommand oCmd;
        //IDataReader oDReader;

        public override void InitializeAccessors()
        {
            throw new NotImplementedException();
        }

        public static List<Zilla> GetZilla(string condition)
        {
            List<Zilla> oeListObject = new List<Zilla>();
            string storePro = "proc_GetAllZillas";
            DbCommand oCmd = Db.GetStoredProcCommand(storePro);
            Db.AddInParameter(oCmd, "@condition", DbType.String, condition);
            
            IDataReader oDReader = Db.ExecuteReader(oCmd);
            
            while (oDReader.Read())
            {
                Zilla obj = new Zilla();
                obj.Zilla_id = ValidateFields.GetSafeGuid(oDReader["zilla_id"].ToString());
                obj.Zilla_name_eng = ValidateFields.GetSafeString(oDReader["zilla_name_eng"].ToString());
                //obj.Zilla_name_sin = ValidateFields.GetSafeString(oDReader["zilla_name_sin"].ToString());
                //obj.Zilla_name_urd = ValidateFields.GetSafeString(oDReader["zilla_name_urd"].ToString());
                obj.Province_id = ValidateFields.GetSafeInteger(oDReader["province_id"].ToString());
                obj.Is_locked = ValidateFields.GetSafeBoolean(oDReader["is_locked"].ToString());
                obj.User_id = ValidateFields.GetSafeGuid(oDReader["user_id"].ToString());
                obj.Access_date_time = ValidateFields.GetSafeDateTime(oDReader["access_date_time"].ToString());
                obj.Division_id = ValidateFields.GetSafeInteger(oDReader["division_id"].ToString());
                oeListObject.Add(obj);
            }
            return oeListObject;
        }

        public static List<Taluka> GetTaluka(string condition)
        {
            List<Taluka> oeListObject = new List<Taluka>();
            string storePro = "proc_GetAllTalukasByZilla";
            DbCommand oCmd = Db.GetStoredProcCommand(storePro);
            Db.AddInParameter(oCmd, "@condition", DbType.String, condition);
            IDataReader oDReader = Db.ExecuteReader(oCmd);
            while (oDReader.Read())
            {
                Taluka obj = new Taluka();
                obj.Taluka_id = ValidateFields.GetSafeGuid(oDReader["taluka_id"].ToString());
                obj.Zilla_id = ValidateFields.GetSafeGuid(oDReader["zilla_id"].ToString());
                obj.Taluka_name_eng = ValidateFields.GetSafeString(oDReader["taluka_name_eng"].ToString());
                //obj.Taluka_name_sin = ValidateFields.GetSafeString(oDReader["taluka_name_sin"].ToString());
                //obj.Taluka_name_urd = ValidateFields.GetSafeString(oDReader["taluka_name_urd"].ToString());
                //obj.Is_city = ValidateFields.GetSafeBoolean(oDReader["is_city"].ToString());
                obj.Is_locked = ValidateFields.GetSafeBoolean(oDReader["is_locked"].ToString());
                obj.User_id = ValidateFields.GetSafeGuid(oDReader["user_id"].ToString());
                obj.Access_date_time = ValidateFields.GetSafeDateTime(oDReader["access_date_time"].ToString());
                //obj.Subdivision_id = ValidateFields.GetSafeInteger(oDReader["subdivision_id"].ToString());
                oeListObject.Add(obj);
            }
            return oeListObject;
        }

        public static List<Deh> GetDeh(string condition)
        {
            List<Deh> oeListObject = new List<Deh>();
            string storePro = "proc_GetAllDehsByTaluka";
            DbCommand oCmd = Db.GetStoredProcCommand(storePro);
            Db.AddInParameter(oCmd, "@condition", DbType.String, condition);
            IDataReader oDReader = Db.ExecuteReader(oCmd);
            while (oDReader.Read())
            {
                Deh obj = new Deh();
                obj.Deh_id = ValidateFields.GetSafeGuid(oDReader["deh_id"].ToString());
                obj.Taluka_id = ValidateFields.GetSafeGuid(oDReader["taluka_id"].ToString());
                obj.Deh_name_eng = ValidateFields.GetSafeString(oDReader["deh_name_eng"].ToString());
                //obj.Deh_name_sin = ValidateFields.GetSafeString(oDReader["deh_name_sin"].ToString());
                //obj.Deh_name_urd = ValidateFields.GetSafeString(oDReader["deh_name_urd"].ToString());
                obj.Is_locked = ValidateFields.GetSafeBoolean(oDReader["is_locked"].ToString());
                obj.User_id = ValidateFields.GetSafeGuid(oDReader["user_id"].ToString());
                obj.Access_date_time = ValidateFields.GetSafeDateTime(oDReader["access_date_time"].ToString());
                oeListObject.Add(obj);
            }
            return oeListObject;
        }

        public static UpdateEntryInfo InsertZilla(Zilla oZilla)
        {
            string storProc = "[territory].[proc_InsertZilla]";
            int effectRow = 0;
            UpdateEntryInfo insertInfo = new UpdateEntryInfo();
            if (oZilla != null)
            {
                using (DbCommand oCmd = Db.GetStoredProcCommand(storProc))
                {
                    try
                    {
                        Db.AddInParameter(oCmd, "@zilla_id", DbType.Guid, oZilla.Zilla_id);
                        Db.AddInParameter(oCmd, "@division_id", DbType.Int32, oZilla.Division_id);
                        Db.AddInParameter(oCmd, "@province_id", DbType.Int32, oZilla.Province_id);
                        Db.AddInParameter(oCmd, "@is_locked", DbType.Boolean, oZilla.Is_locked);
                        Db.AddInParameter(oCmd, "@zilla_name_eng", DbType.String, oZilla.Zilla_name_eng);
                        Db.AddInParameter(oCmd, "@user_Id", DbType.Guid, oZilla.User_id);
                        Db.AddInParameter(oCmd, "@access_date_time", DbType.DateTime, oZilla.Access_date_time);
                        effectRow = Db.ExecuteNonQuery(oCmd);
                        if (effectRow != 0)
                        {
                            insertInfo.Id = oZilla.Zilla_id;
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

        public static UpdateEntryInfo DeleteZilla(Guid? ZillaId)
        {
            string storProc = "[territory].[proc_DeleteZilla]";
            UpdateEntryInfo deleteInfo = new UpdateEntryInfo();
            int effectRow = 0;
            using (DbCommand oCmd = Db.GetStoredProcCommand(storProc))
            {
                try
                {
                    Db.AddInParameter(oCmd, "@zilla_id", DbType.Guid, ZillaId);
                    effectRow = Db.ExecuteNonQuery(oCmd);
                    if (effectRow != 0)
                    {
                        deleteInfo.Id = ZillaId;
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

        public static UpdateEntryInfo UpdateZilla(Zilla oZilla)
        {
            string storProc = "[territory].[proc_UpdateZilla]";
            UpdateEntryInfo updateInfo = new UpdateEntryInfo();
            int effectRow = 0;
            if (oZilla != null)
            {
                using (DbCommand oCmd = Db.GetStoredProcCommand(storProc))
                {
                    try
                    {
                        Db.AddInParameter(oCmd, "@zilla_id", DbType.Guid, oZilla.Zilla_id);
                        Db.AddInParameter(oCmd, "@zilla_name_eng", DbType.String, oZilla.Zilla_name_eng);
                        Db.AddInParameter(oCmd, "@is_locked", DbType.Boolean, oZilla.Is_locked);
                        Db.AddInParameter(oCmd, "@user_id", DbType.Guid, oZilla.User_id);
                        Db.AddInParameter(oCmd, "@access_date_time", DbType.DateTime, oZilla.Access_date_time);
                        effectRow = Db.ExecuteNonQuery(oCmd);
                        if (effectRow != 0)
                        {
                            updateInfo.Id = oZilla.Zilla_id;
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

        public static UpdateEntryInfo InsertTaluka(Taluka oTaluka)
        {
            string storProc = "[territory].[proc_InsertTaluka]";
            int effectRow = 0;
            UpdateEntryInfo insertInfo = new UpdateEntryInfo();
            if (oTaluka != null)
            {
                using (DbCommand oCmd = Db.GetStoredProcCommand(storProc))
                {
                    try
                    {
                        Db.AddInParameter(oCmd, "@taluka_id", DbType.Guid, oTaluka.Taluka_id);
                        Db.AddInParameter(oCmd, "@zilla_id", DbType.Guid, oTaluka.Zilla_id);
                        //Db.AddInParameter(oCmd, "@ubdivision_id", DbType.Guid, oTaluka.Subdivision_id);
                        //Db.AddInParameter(oCmd, "@Is_city", DbType.Boolean, oTaluka.Is_city);
                        Db.AddInParameter(oCmd, "@is_locked", DbType.Boolean, oTaluka.Is_locked);
                        Db.AddInParameter(oCmd, "@taluka_name_eng", DbType.String, oTaluka.Taluka_name_eng);
                        Db.AddInParameter(oCmd, "@user_Id", DbType.Guid, oTaluka.User_id);
                        Db.AddInParameter(oCmd, "@access_date_time", DbType.DateTime, oTaluka.Access_date_time);
                        effectRow = Db.ExecuteNonQuery(oCmd);
                        if (effectRow != 0)
                        {
                            insertInfo.Id = oTaluka.Taluka_id;
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

        public static UpdateEntryInfo DeleteTaluka(Guid? TalukaId)
        {
            string storProc = "[territory].[proc_DeleteTaluka]";
            UpdateEntryInfo deleteInfo = new UpdateEntryInfo();
            int effectRow = 0;
            using (DbCommand oCmd = Db.GetStoredProcCommand(storProc))
            {
                try
                {
                    Db.AddInParameter(oCmd, "@taluka_id", DbType.Guid, TalukaId);
                    effectRow = Db.ExecuteNonQuery(oCmd);
                    if (effectRow != 0)
                    {
                        deleteInfo.Id = TalukaId;
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

        public static UpdateEntryInfo UpdateTaluka(Taluka oTaluka)
        {
            string storProc = "[territory].[proc_UpdateTaluka]";
            UpdateEntryInfo updateInfo = new UpdateEntryInfo();
            int effectRow = 0;
            if (oTaluka != null)
            {
                using (DbCommand oCmd = Db.GetStoredProcCommand(storProc))
                {
                    try
                    {
                        Db.AddInParameter(oCmd, "@taluka_id", DbType.Guid, oTaluka.Taluka_id);
                        //Db.AddInParameter(oCmd, "@zilla_id", DbType.Guid, oTaluka.Zilla_id);
                        Db.AddInParameter(oCmd, "@taluka_name_eng", DbType.String, oTaluka.Taluka_name_eng);
                        Db.AddInParameter(oCmd, "@is_locked", DbType.Boolean, oTaluka.Is_locked);
                        Db.AddInParameter(oCmd, "@user_id", DbType.Guid, oTaluka.User_id);
                        Db.AddInParameter(oCmd, "@access_date_time", DbType.DateTime, oTaluka.Access_date_time);
                        effectRow = Db.ExecuteNonQuery(oCmd);
                        if (effectRow != 0)
                        {
                            updateInfo.Id = oTaluka.Taluka_id;
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

        public static UpdateEntryInfo InsertDeh(Deh oDeh)
        {
            string storProc = "[territory].[proc_InsertDeh]";
            int effectRow = 0;
            UpdateEntryInfo insertInfo = new UpdateEntryInfo();
            if (oDeh != null)
            {
                using (DbCommand oCmd = Db.GetStoredProcCommand(storProc))
                {
                    try
                    {
                        Db.AddInParameter(oCmd, "@deh_id", DbType.Guid, oDeh.Deh_id);
                        Db.AddInParameter(oCmd, "@taluka_id", DbType.Guid, oDeh.Taluka_id);
                        Db.AddInParameter(oCmd, "@deh_name_eng", DbType.String, oDeh.Deh_name_eng);
                        Db.AddInParameter(oCmd, "@is_locked", DbType.Boolean, oDeh.Is_locked);
                        Db.AddInParameter(oCmd, "@user_Id", DbType.Guid, oDeh.User_id);
                        Db.AddInParameter(oCmd, "@access_date_time", DbType.DateTime, oDeh.Access_date_time);
                        effectRow = Db.ExecuteNonQuery(oCmd);
                        if (effectRow != 0)
                        {
                            insertInfo.Id = oDeh.Deh_id;
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

        public static UpdateEntryInfo DeleteDeh(Guid? DehId)
        {
            string storProc = "[territory].[proc_DeleteDeh]";
            UpdateEntryInfo deleteInfo = new UpdateEntryInfo();
            int effectRow = 0;
            using (DbCommand oCmd = Db.GetStoredProcCommand(storProc))
            {
                try
                {
                    Db.AddInParameter(oCmd, "@deh_id", DbType.Guid, DehId);
                    effectRow = Db.ExecuteNonQuery(oCmd);
                    if (effectRow != 0)
                    {
                        deleteInfo.Id = DehId;
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

        public static UpdateEntryInfo UpdateDeh(Deh oDeh)
        {
            string storProc = "[territory].[proc_UpdateDeh]";
            UpdateEntryInfo updateInfo = new UpdateEntryInfo();
            int effectRow = 0;
            if (oDeh != null)
            {
                using (DbCommand oCmd = Db.GetStoredProcCommand(storProc))
                {
                    try
                    {
                        Db.AddInParameter(oCmd, "@deh_id", DbType.Guid, oDeh.Deh_id);
                        //Db.AddInParameter(oCmd, "@taluka_id", DbType.Guid, oDeh.Taluka_id);
                        Db.AddInParameter(oCmd, "@deh_name_eng", DbType.String, oDeh.Deh_name_eng);
                        Db.AddInParameter(oCmd, "@is_locked", DbType.Boolean, oDeh.Is_locked);
                        Db.AddInParameter(oCmd, "@user_id", DbType.Guid, oDeh.User_id);
                        Db.AddInParameter(oCmd, "@access_date_time", DbType.DateTime, oDeh.Access_date_time);
                        effectRow = Db.ExecuteNonQuery(oCmd);
                        if (effectRow != 0)
                        {
                            updateInfo.Id = oDeh.Deh_id;
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
    }
}
