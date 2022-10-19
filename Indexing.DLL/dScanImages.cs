using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Indexing.EL;
using System.Data.Common;
using System.Data;

namespace Indexing.DLL
{
    public class dScanImages : DatabaseConnection
    {
        public static List<eScanImages> GetScanImages(string condition)
        {
            List<eScanImages> oeListObject = new List<eScanImages>();
            string storePro = "[transactions].[proc_GetScanImageByImageId]";
            DbCommand oCmd = Db.GetStoredProcCommand(storePro);
            Db.AddInParameter(oCmd, "@condition", DbType.String, condition);
            IDataReader oDReader = Db.ExecuteReader(oCmd);
            while (oDReader.Read())
            {
                eScanImages obj = new eScanImages();
                obj.Image_id = ValidateFields.GetSafeGuid(oDReader["image_id"].ToString());
                if (oDReader["image_file"] != DBNull.Value)
                    obj.Image_file = (byte[])oDReader["image_file"];
                //obj.Image_file = ValidateFields.GetSafeByte(oDReader["image_file"].ToString());
                obj.User_id = ValidateFields.GetSafeGuid(oDReader["user_id"].ToString());
                obj.Access_date_time = ValidateFields.GetSafeDateTime(oDReader["access_date_time"].ToString());
                oeListObject.Add(obj);
            }
            return oeListObject;
        }

        public static UpdateEntryInfo InsertScanImages(eScanImages oeScanImages)
        {
            string storProc = "[transactions].[proc_CreateScanImages]";
            int effectRow = 0;
            UpdateEntryInfo insertInfo = new UpdateEntryInfo();
            if (oeScanImages != null)
            {
                using (DbCommand oCmd = Db.GetStoredProcCommand(storProc))
                {
                    try
                    {
                        Db.AddInParameter(oCmd, "@image_id", DbType.Guid, oeScanImages.Image_id);
                        Db.AddInParameter(oCmd, "@image_file", DbType.Byte, oeScanImages.Image_file);
                        Db.AddInParameter(oCmd, "@user_id", DbType.Guid, oeScanImages.User_id);
                        Db.AddInParameter(oCmd, "@access_date_time", DbType.DateTime, oeScanImages.Access_date_time);
                        effectRow = Db.ExecuteNonQuery(oCmd);
                        if (effectRow != 0)
                        {
                            insertInfo.Id = oeScanImages.Image_id;
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

        public static UpdateEntryInfo DeleteScanImages(Guid? images_id)
        {
            string storProc = "[transactions].[proc_DeleteScanImages]";
            UpdateEntryInfo deleteInfo = new UpdateEntryInfo();
            int effectRow = 0;
            using (DbCommand oCmd = Db.GetStoredProcCommand(storProc))
            {
                try
                {
                    Db.AddInParameter(oCmd, "@image_id", DbType.Guid, images_id);
                    effectRow = Db.ExecuteNonQuery(oCmd);
                    if (effectRow != 0)
                    {
                        deleteInfo.Id = images_id;
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

        public static UpdateEntryInfo UpdateScanImages(eScanImages oeScanImages)
        {
            string storProc = "[transactions].[proc_UpdateScanImages]";
            UpdateEntryInfo updateInfo = new UpdateEntryInfo();
            int effectRow = 0;
            if (oeScanImages != null)
            {
                using (DbCommand oCmd = Db.GetStoredProcCommand(storProc))
                {
                    try
                    {
                        Db.AddInParameter(oCmd, "@image_id", DbType.Guid, oeScanImages.Image_id);
                        Db.AddInParameter(oCmd, "@image_file", DbType.Byte, oeScanImages.Image_file);
                        Db.AddInParameter(oCmd, "@user_id", DbType.Guid, oeScanImages.User_id);
                        Db.AddInParameter(oCmd, "@access_date_time", DbType.DateTime, oeScanImages.Access_date_time);
                        //Db.AddInParameter(oCmd, "@time_stamp", DbType.Binary, oeDistrict.Time_stamp);
                        effectRow = Db.ExecuteNonQuery(oCmd);
                        if (effectRow != 0)
                        {
                            updateInfo.Id = oeScanImages.Image_id;
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
