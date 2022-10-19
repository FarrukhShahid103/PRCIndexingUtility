using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using Indexing.EL;
using Indexing.BLL;

namespace Indexing.UI
{
    public partial class Territory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Zilla", "fillZilla()", true);
            }
        }

        [WebMethod()]
        public static List<string> AddZilla(string zillaName)
        {
            eUser oeUser = (eUser)HttpContext.Current.Session["LoginUserInfo"];
            List<string> oeList = new List<string>();
            Zilla objZila = new Zilla();
            objZila.Zilla_name_eng = zillaName;
            objZila.Zilla_id = Guid.NewGuid();
            objZila.Division_id = 2;
            objZila.Province_id = 5;
            objZila.Is_locked = false;
            objZila.Access_date_time = DateTime.Now;
            if (oeUser != null)
                objZila.User_id = oeUser.User_id;
            UpdateEntryInfo info = new UpdateEntryInfo();
            info = bTeritory.InsertZilla(objZila);
            if (info.Success)
                oeList.Add("success");
            else
                oeList.Add("error: " + info.Exception);

            return oeList;
        }

        [WebMethod()]
        public static List<string> AddTaluka(string talukaName, string zillaId)
        {
            eUser oeUser = (eUser)HttpContext.Current.Session["LoginUserInfo"];
            List<string> oeList = new List<string>();
            Taluka oTaluka = new Taluka();
            oTaluka.Taluka_id = Guid.NewGuid();
            oTaluka.Zilla_id = ValidateFields.GetSafeGuid(zillaId);
            oTaluka.Taluka_name_eng = talukaName;
            oTaluka.Is_locked = false;
            oTaluka.Access_date_time = DateTime.Now;
            if (oeUser != null)
                oTaluka.User_id = oeUser.User_id;
            UpdateEntryInfo info = new UpdateEntryInfo();
            info = bTeritory.InsertTaluka(oTaluka);
            if (info.Success)
                oeList.Add("success");
            else
                oeList.Add("error: " + info.Exception);

            return oeList;
        }

        [WebMethod()]
        public static List<string> AddDeh(string dehName, string talukaId)
        {
            eUser oeUser = (eUser)HttpContext.Current.Session["LoginUserInfo"];
            List<string> oeList = new List<string>();
            Deh oDeh = new Deh();
            oDeh.Deh_id = Guid.NewGuid();
            oDeh.Taluka_id = ValidateFields.GetSafeGuid(talukaId);
            oDeh.Deh_name_eng = dehName;
            oDeh.Is_locked = false;
            oDeh.Access_date_time = DateTime.Now;
            if (oeUser != null)
                oDeh.User_id = oeUser.User_id;
            UpdateEntryInfo info = new UpdateEntryInfo();
            info = bTeritory.InsertDeh(oDeh);
            if (info.Success)
                oeList.Add("success");
            else
                oeList.Add("error");

            return oeList;
        }

        [WebMethod()]
        public static List<Zilla> getZillaForDropDown()
        {
            //bTeritory obTeritory = new bTeritory();
            Zilla objZila = new Zilla();
            List<Zilla> oeListZila = new List<Zilla>();
            oeListZila = bTeritory.GetZilla(objZila);
            return oeListZila;
        }

        [WebMethod()]
        public static List<Taluka> getTalukaForDropDown(string zillaId)
        {
            Guid zilla_id = ValidateFields.GetSafeGuid(zillaId);
            //bTeritory obTeritory = new bTeritory();
            Taluka objTaluka = new Taluka();
            objTaluka.Zilla_id = zilla_id;
            List<Taluka> oeListTaluka = new List<Taluka>();
            oeListTaluka = bTeritory.GetTaluka(objTaluka);
            return oeListTaluka;
        }

        [WebMethod()]
        public static List<Deh> getDehForDropDown(string talukaId)
        {
            Guid taluka_id = ValidateFields.GetSafeGuid(talukaId);
            //bTeritory obTeritory = new bTeritory();
            Deh objDeh = new Deh();
            objDeh.Taluka_id = taluka_id;
            List<Deh> oeListDeh = new List<Deh>();
            oeListDeh = bTeritory.GetDeh(objDeh);
            return oeListDeh;
        }

        [WebMethod()]
        public static List<string> DeleteItem(string Id, string dropdown)
        {
            List<string> oList = new List<string>();
            UpdateEntryInfo info = new UpdateEntryInfo();
            if (dropdown.ToLower() == "zilla")
            {
                Zilla oZilla = new Zilla();
                oZilla.Zilla_id = ValidateFields.GetSafeGuid(Id);
                info = bTeritory.DeleteZilla(oZilla);
                if (info.Success)
                    oList.Add("success");
                else if (info.Exception.ToLower().Contains("fk_taluka_zilla"))
                    oList.Add("childexist");
                else
                    oList.Add("Error: " + info.Exception);
            }
            else if (dropdown.ToLower() == "taluka")
            {
                Taluka oTaluka = new Taluka();
                oTaluka.Taluka_id = ValidateFields.GetSafeGuid(Id);
                info = bTeritory.DeleteTaluka(oTaluka);
                if (info.Success)
                    oList.Add("success");
                else if (info.Exception.ToLower().Contains("fk_deh_taluka"))
                    oList.Add("childexist");
                else
                    oList.Add("Error: " + info.Exception);
            }
            else if (dropdown.ToLower() == "deh")
            {
                Deh oDeh = new Deh();
                oDeh.Deh_id = ValidateFields.GetSafeGuid(Id);
                info = bTeritory.DeleteDeh(oDeh);
                if (info.Success)
                    oList.Add("success");
                else
                    oList.Add("Error: " + info.Exception);
            }

            return oList;
        }

        [WebMethod()]
        public static List<string> UpdateRecord(string Id, string textValue, string dropdown)
        {
            List<string> oList = new List<string>();
            UpdateEntryInfo info = new UpdateEntryInfo();
            eUser oeUser = (eUser)HttpContext.Current.Session["LoginUserInfo"];
            if (dropdown.ToLower() == "zilla")
            {
                Zilla oZilla = new Zilla();
                oZilla.Zilla_id = ValidateFields.GetSafeGuid(Id);
                oZilla.Zilla_name_eng = textValue;
                oZilla.Is_locked = false;
                oZilla.Access_date_time = DateTime.Now;
                if (oeUser != null)
                    oZilla.User_id = oeUser.User_id;
                info = bTeritory.UpdateZilla(oZilla);
                if (info.Success)
                    oList.Add("success");
                else
                    oList.Add("Error: " + info.Exception);
            }
            else if (dropdown.ToLower() == "taluka")
            {
                Taluka oTaluka = new Taluka();
                oTaluka.Taluka_id = ValidateFields.GetSafeGuid(Id);
                oTaluka.Taluka_name_eng = textValue;
                oTaluka.Is_locked = false;
                oTaluka.Access_date_time = DateTime.Now;
                if (oeUser != null)
                    oTaluka.User_id = oeUser.User_id;
                info = bTeritory.UpdateTaluka(oTaluka);
                if (info.Success)
                    oList.Add("success");
                else
                    oList.Add("Error: " + info.Exception);
            }
            else if (dropdown.ToLower() == "deh")
            {
                Deh oDeh = new Deh();
                oDeh.Deh_id = ValidateFields.GetSafeGuid(Id);
                oDeh.Deh_name_eng = textValue;
                oDeh.Is_locked = false;
                oDeh.Access_date_time = DateTime.Now;
                if (oeUser != null)
                    oDeh.User_id = oeUser.User_id;
                info = bTeritory.UpdateDeh(oDeh);
                if (info.Success)
                    oList.Add("success");
                else
                    oList.Add("Error: " + info.Exception);
            }

            return oList;
        }
    }
}