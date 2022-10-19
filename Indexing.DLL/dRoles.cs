using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Indexing.EL;
using System.Data.Common;
using System.Data;

namespace Indexing.DLL
{
    public class dRoles : DatabaseConnection
    {
        public static List<eRoles> GetRoles(string condition)
        {
            List<eRoles> oeListObject = new List<eRoles>();
            string storePro = "[dbo].[proc_GetAllRoles]";
            DbCommand oCmd = Db.GetStoredProcCommand(storePro);
            //Db.AddInParameter(oCmd, "@condition", DbType.String, condition);
            IDataReader oDReader = Db.ExecuteReader(oCmd);
            while (oDReader.Read())
            {
                eRoles obj = new eRoles();
                obj.Role_id = ValidateFields.GetSafeGuid(oDReader["role_id"].ToString());
                //obj.Role_name = ValidateFields.GetSafeString(oDReader["role_name"].ToString());
                obj.Description_eng = ValidateFields.GetSafeString(oDReader["description_eng"].ToString());
                obj.Role_type = ValidateFields.GetSafeString(oDReader["role_type"].ToString());
                oeListObject.Add(obj);
            }
            return oeListObject;
        }

        public static UpdateEntryInfo InsertRoles(eRoles oeRoles)
        {
            string storProc = "[transactions].[proc_CreateRoles]";
            int effectRow = 0;
            UpdateEntryInfo insertInfo = new UpdateEntryInfo();
            if (oeRoles != null)
            {
                using (DbCommand oCmd = Db.GetStoredProcCommand(storProc))
                {
                    try
                    {
                        Db.AddInParameter(oCmd, "@role_id", DbType.Guid, oeRoles.Role_id);
                        Db.AddInParameter(oCmd, "@role_name", DbType.String, oeRoles.Role_name);
                        Db.AddInParameter(oCmd, "@description_eng", DbType.String, oeRoles.Description_eng);
                        Db.AddInParameter(oCmd, "@role_type;", DbType.String, oeRoles.Role_type);
                        effectRow = Db.ExecuteNonQuery(oCmd);
                        if (effectRow != 0)
                        {
                            insertInfo.Id = oeRoles.Role_id;
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

        public static UpdateEntryInfo DeleteRoles(Guid? rold_id)
        {
            string storProc = "[transactions].[proc_DeleteRoles]";
            UpdateEntryInfo deleteInfo = new UpdateEntryInfo();
            int effectRow = 0;
            using (DbCommand oCmd = Db.GetStoredProcCommand(storProc))
            {
                try
                {
                    Db.AddInParameter(oCmd, "@role_id", DbType.Guid, rold_id);
                    effectRow = Db.ExecuteNonQuery(oCmd);
                    if (effectRow != 0)
                    {
                        deleteInfo.Id = rold_id;
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

        public static UpdateEntryInfo UpdateRoles(eRoles oeRoles)
        {
            string storProc = "[transactions].[proc_UpdateRoles]";
            UpdateEntryInfo updateInfo = new UpdateEntryInfo();
            int effectRow = 0;
            if (oeRoles != null)
            {
                using (DbCommand oCmd = Db.GetStoredProcCommand(storProc))
                {
                    try
                    {
                        Db.AddInParameter(oCmd, "@role_id", DbType.Guid, oeRoles.Role_id);
                        Db.AddInParameter(oCmd, "@role_name", DbType.String, oeRoles.Role_name);
                        Db.AddInParameter(oCmd, "@description_eng", DbType.String, oeRoles.Description_eng);
                        Db.AddInParameter(oCmd, "@role_type;", DbType.String, oeRoles.Role_type);
                        effectRow = Db.ExecuteNonQuery(oCmd);
                        if (effectRow != 0)
                        {
                            updateInfo.Id = oeRoles.Role_id;
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
