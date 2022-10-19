using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Indexing.EL;
using Indexing.DLL;

namespace Indexing.BLL
{
    public class bRoles
    {
        public static List<eRoles> GetRoles(eRoles oeRoles)
        {
            string condition = BuildCondition(oeRoles);
            List<eRoles> oeListIndexing = new List<eRoles>();
            oeListIndexing = dRoles.GetRoles(condition);
            return oeListIndexing;
        }

        public static UpdateEntryInfo insertRoles(eRoles oeRoles)
        {
            UpdateEntryInfo insertInfo = new UpdateEntryInfo();
            insertInfo = dRoles.InsertRoles(oeRoles);
            return insertInfo;
        }

        public static UpdateEntryInfo udpateRoles(eRoles oeRoles)
        {
            UpdateEntryInfo updateInfo = new UpdateEntryInfo();
            updateInfo = dRoles.UpdateRoles(oeRoles);
            return updateInfo;
        }

        public static UpdateEntryInfo deleteRoles(eRoles oeRoles)
        {
            UpdateEntryInfo deleteInfo = new UpdateEntryInfo();
            deleteInfo = dRoles.DeleteRoles(oeRoles.Role_id);
            return deleteInfo;
        }


        private static string BuildCondition(eRoles oeRoles)
        {
            string result = "";
            if (oeRoles.Role_id != Guid.Empty)
                result += (result == "" ? "" : " AND ") + "role_id = '" + oeRoles.Role_id + "'";
            if (oeRoles.Role_name != null && oeRoles.Role_name != string.Empty)
                result += (result == "" ? "" : " AND ") + "role_name = '" + oeRoles.Role_name + "'";
            if (oeRoles.Description_eng != null && oeRoles.Description_eng != string.Empty)
                result += (result == "" ? "" : " AND ") + "description_eng = '" + oeRoles.Description_eng + "'";
            if (oeRoles.Role_type != null && oeRoles.Role_type != string.Empty)
                result += (result == "" ? "" : " AND ") + "role_type = '" + oeRoles.Role_type + "'";

            if (result != "")
                result = (" WHERE " + result);
            return result;
        }
    }
}
