using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Indexing.EL;
using Indexing.DLL;

namespace Indexing.BLL
{
    public class bScanImages
    {
        public static List<eScanImages> GetScanImages(eScanImages oeScanImages)
        {
            string condition = BuildCondition(oeScanImages);
            List<eScanImages> oeListIndexing = new List<eScanImages>();
            oeListIndexing = dScanImages.GetScanImages(condition);
            return oeListIndexing;
        }

        public static UpdateEntryInfo insertScanImages(eScanImages oeScanImages)
        {
            UpdateEntryInfo insertInfo = new UpdateEntryInfo();
            insertInfo = dScanImages.InsertScanImages(oeScanImages);
            return insertInfo;
        }

        public static UpdateEntryInfo udpateScanImages(eScanImages oeScanImages)
        {
            UpdateEntryInfo updateInfo = new UpdateEntryInfo();
            updateInfo = dScanImages.UpdateScanImages(oeScanImages);
            return updateInfo;
        }

        public static UpdateEntryInfo deleteScanImages(eScanImages oeScanImages)
        {
            UpdateEntryInfo deleteInfo = new UpdateEntryInfo();
            deleteInfo = dScanImages.DeleteScanImages(oeScanImages.Image_id);
            return deleteInfo;
        }


        private static string BuildCondition(eScanImages oeScanImages)
        {
            string result = "";
            if (oeScanImages.Image_id != Guid.Empty)
                result += (result == "" ? "" : " AND ") + "image_id = '" + oeScanImages.Image_id + "'";
            if (oeScanImages.User_id != Guid.Empty)
                result += (result == "" ? "" : " AND ") + "user_id = '" + oeScanImages.User_id + "'";
            if (oeScanImages.Access_date_time != DateTime.MinValue)
                result += (result == "" ? "" : " AND ") + "access_date_time = '" + oeScanImages.Access_date_time + "'";

            if (result != "")
                result = (" WHERE " + result);
            return result;
        }
    }
}
