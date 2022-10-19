using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Indexing.DLL;
using Indexing.EL;

namespace Indexing.BLL
{
    public class bTeritory
    {
        dTeritory odTeritory;
        public static List<Zilla> GetZilla(Zilla oZilla)
        {
            string condition = BuildCondition(oZilla, null, null);
            //odTeritory = new dTeritory();
            List<Zilla> oeListTeritory = new List<Zilla>();
            oeListTeritory = dTeritory.GetZilla(condition);
            return oeListTeritory;
        }

        public static UpdateEntryInfo InsertZilla(Zilla oZilla)
        {
            UpdateEntryInfo info = new UpdateEntryInfo();
            info = dTeritory.InsertZilla(oZilla);
            return info;
        }

        public static UpdateEntryInfo DeleteZilla(Zilla oZilla)
        {
            UpdateEntryInfo info = new UpdateEntryInfo();
            info = dTeritory.DeleteZilla(oZilla.Zilla_id);
            return info;
        }

        public static UpdateEntryInfo UpdateZilla(Zilla oZilla)
        {
            UpdateEntryInfo info = new UpdateEntryInfo();
            info = dTeritory.UpdateZilla(oZilla);
            return info;
        }

        public static List<Taluka> GetTaluka(Taluka oTaluka)
        {
            string condition = BuildCondition(null, oTaluka, null);
            //odTeritory = new dTeritory();
            List<Taluka> oeListTeritory = new List<Taluka>();
            oeListTeritory = dTeritory.GetTaluka(condition);
            return oeListTeritory;
        }

        public static UpdateEntryInfo InsertTaluka(Taluka oTaluka)
        {
            UpdateEntryInfo info = new UpdateEntryInfo();
            info = dTeritory.InsertTaluka(oTaluka);
            return info;
        }

        public static UpdateEntryInfo DeleteTaluka(Taluka oTaluka)
        {
            UpdateEntryInfo info = new UpdateEntryInfo();
            info = dTeritory.DeleteTaluka(oTaluka.Taluka_id);
            return info;
        }

        public static UpdateEntryInfo UpdateTaluka(Taluka oTaluka)
        {
            UpdateEntryInfo info = new UpdateEntryInfo();
            info = dTeritory.UpdateTaluka(oTaluka);
            return info;
        }

        public static List<Deh> GetDeh(Deh oDeh)
        {
            string condition = BuildCondition(null, null, oDeh);
            //odTeritory = new dTeritory();
            List<Deh> oeListTeritory = new List<Deh>();
            oeListTeritory = dTeritory.GetDeh(condition);
            return oeListTeritory;
        }

        public static UpdateEntryInfo InsertDeh(Deh oDeh)
        {
            UpdateEntryInfo info = new UpdateEntryInfo();
            info = dTeritory.InsertDeh(oDeh);
            return info;
        }

        public static UpdateEntryInfo DeleteDeh(Deh oDeh)
        {
            UpdateEntryInfo info = new UpdateEntryInfo();
            info = dTeritory.DeleteDeh(oDeh.Deh_id);
            return info;
        }

        public static UpdateEntryInfo UpdateDeh(Deh oDeh)
        {
            UpdateEntryInfo info = new UpdateEntryInfo();
            info = dTeritory.UpdateDeh(oDeh);
            return info;
        }

        private static string BuildCondition(Zilla oZilla, Taluka oTaluka, Deh oDeh)
        {
            string result = "";
            if (oZilla != null)
            {
                if (oZilla.Zilla_id != Guid.Empty)
                    result += (result == "" ? "" : " AND ") + "zilla_id = '" + oZilla.Zilla_id + "'";
                if (oZilla.Zilla_name_eng != null && oZilla.Zilla_name_eng != string.Empty)
                    result += (result == "" ? "" : " AND ") + "zilla_name_eng = '" + oZilla.Zilla_name_eng + "'";
                if (oZilla.Is_locked != false)
                    result += (result == "" ? "" : " AND ") + "is_locked = " + oZilla.Is_locked + "";
                if (oZilla.User_id != Guid.Empty)
                    result += (result == "" ? "" : " AND ") + "user_id = " + oZilla.User_id;
                if (oZilla.Access_date_time != DateTime.MinValue)
                    result += (result == "" ? "" : " AND ") + "access_date_time = " + oZilla.Access_date_time;
            }
            if (oTaluka != null)
            {
                if (oTaluka.Taluka_id != Guid.Empty)
                    result += (result == "" ? "" : " AND ") + "taluka_id = '" + oTaluka.Taluka_id + "'";
                if (oTaluka.Zilla_id != Guid.Empty)
                    result += (result == "" ? "" : " AND ") + "[zilla].zilla_id = '" + oTaluka.Zilla_id + "'";
                if (oTaluka.Taluka_name_eng != null && oTaluka.Taluka_name_eng != string.Empty)
                    result += (result == "" ? "" : " AND ") + "taluka_name_eng = '" + oTaluka.Taluka_name_eng + "'";
                if (oTaluka.Is_locked != false)
                    result += (result == "" ? "" : " AND ") + "is_locked = " + oTaluka.Is_locked + "";
                if (oTaluka.User_id != Guid.Empty)
                    result += (result == "" ? "" : " AND ") + "user_id = " + oTaluka.User_id;
                if (oTaluka.Access_date_time != DateTime.MinValue)
                    result += (result == "" ? "" : " AND ") + "access_date_time = " + oTaluka.Access_date_time;
            }

            if (oDeh != null)
            {
                if (oDeh.Deh_id != Guid.Empty)
                    result += (result == "" ? "" : " AND ") + "deh_id = '" + oDeh.Deh_id + "'";
                if (oDeh.Taluka_id != Guid.Empty)
                    result += (result == "" ? "" : " AND ") + "taluka_id = '" + oDeh.Taluka_id + "'";
                if (oDeh.Deh_name_eng != null && oDeh.Deh_name_eng != string.Empty)
                    result += (result == "" ? "" : " AND ") + "deh_name_eng = '" + oDeh.Deh_name_eng + "'";
                if (oDeh.Is_locked != false)
                    result += (result == "" ? "" : " AND ") + "is_locked = " + oDeh.Is_locked + "";
                if (oDeh.User_id != Guid.Empty)
                    result += (result == "" ? "" : " AND ") + "user_id = " + oDeh.User_id;
                if (oDeh.Access_date_time != DateTime.MinValue)
                    result += (result == "" ? "" : " AND ") + "access_date_time = " + oDeh.Access_date_time;
            }
            if (result != "")
                result = (" WHERE " + result);

            return result;
        }
    }
}
