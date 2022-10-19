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
    public partial class Search : System.Web.UI.Page
    {
        public static long totalRecord;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["LoginUserInfo"] != null)
            {
                eUser oeUser = (eUser)Session["LoginUserInfo"];
                if (oeUser.ObjRoles.Count > 0)
                {
                    hfRoleId.Value = oeUser.ObjRoles[0].Role_id.ToString().ToUpper();
                }
            }
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
        public static List<string> DeleteIndexingWithImage(string IndexingId)
        {
            eIndexing oeIndexing = new eIndexing();
            oeIndexing.Indexing_id = ValidateFields.GetSafeGuid(IndexingId);
            UpdateEntryInfo info = new UpdateEntryInfo();
            List<string> oeList = new List<string>();
            info = bIndexing.DeleteIndexingWithImage(oeIndexing);
            if (info.Success)
                oeList.Add("success");
            else
                oeList.Add("Please consult administrator : " + info.Exception);

            return oeList;
        }

        [WebMethod()]
        public static List<eIndexing> bindSearchRecord(string zillaId, string zillaText, string talukaId, string talukaText, string dehId, string dehText
            , string bookTypeId, string bookTypeText, string scheme, string schemeLike, string scanningNoFrom, string scanningNoTo, string scanningDateFrom
            , string scanningDateTo, string entryNoFrom, string entryNoTo, string entryDateFrom, string entryDateTo, string surveyNoFrom, string surveyNoTo
            , string bookNoFrom, string bookNoTo, string pageNoFrom, string pageNoTo, string ownerName, string ownerNameLike, string cnicNo, string sortedBy
            , string ascDesc, string startIndex, string endIndex)
        {
            List<eIndexing> oeListIndexing = new List<eIndexing>();
            eSearchIndexingData oeSearchIndexingData = new eSearchIndexingData();
            
            if (zillaId != null && zillaId != "" && zillaId != "0")
            {
                oeSearchIndexingData.Zilla_id = ValidateFields.GetSafeGuid(zillaId);
            }
            if (talukaId != null && talukaId != "")
            {
                oeSearchIndexingData.Taluka_id = ValidateFields.GetSafeGuid(talukaId);
            }
            if (dehId != null && dehId != "")
            {
                oeSearchIndexingData.Deh_id = ValidateFields.GetSafeGuid(dehId);
            }
            if (bookTypeId != "" && bookTypeId != "0")
            {
                oeSearchIndexingData.Register_id = ValidateFields.GetSafeInteger(bookTypeId);
            }
            if (bookTypeText != "" && !bookTypeText.Contains("SELECT"))
            {
                oeSearchIndexingData.Register_name = bookTypeText;
            }
            oeSearchIndexingData.Scheme_name = scheme;
            oeSearchIndexingData.SchemeLike = schemeLike;
            oeSearchIndexingData.Scanning_no_from = scanningNoFrom;
            oeSearchIndexingData.Scanning_no_to = scanningNoTo;
            if (scanningDateFrom != string.Empty)
                oeSearchIndexingData.Scanning_date_from = scanningDateFrom;
            else
                oeSearchIndexingData.Scanning_date_from = null;
            if (scanningDateTo != string.Empty)
                oeSearchIndexingData.Scanning_date_to = scanningDateTo;
            else
                oeSearchIndexingData.Scanning_date_to = null;
            oeSearchIndexingData.Entry_no_from = entryNoFrom;
            oeSearchIndexingData.Entry_no_to = entryNoTo;
            if (entryDateFrom != string.Empty)
                oeSearchIndexingData.Entry_date_from = entryDateFrom;
            else
                oeSearchIndexingData.Entry_date_from = null;
            if (entryDateTo != "")
                oeSearchIndexingData.Entry_date_to = entryDateTo;
            else
                oeSearchIndexingData.Entry_date_to = null;
            oeSearchIndexingData.Survey_no_from = surveyNoFrom;
            oeSearchIndexingData.Survey_no_to = surveyNoTo;
            oeSearchIndexingData.Book_no_from = bookNoFrom;
            oeSearchIndexingData.Book_no_to = bookNoTo;
            oeSearchIndexingData.Page_no_from = pageNoFrom;
            oeSearchIndexingData.Page_no_to = pageNoTo;
            oeSearchIndexingData.Owner_name = ownerName;
            oeSearchIndexingData.OwnerNameLike = ownerNameLike;
            oeSearchIndexingData.CnicNo = cnicNo;
            oeSearchIndexingData.SortedBy = sortedBy;
            oeSearchIndexingData.AscDesc = ascDesc;
            oeListIndexing = bIndexing.SearchIndexingData(oeSearchIndexingData, startIndex, endIndex);
            return oeListIndexing;
        }

        [WebMethod()]
        public static List<string> getTotalRows(string zillaId, string zillaText, string talukaId, string talukaText, string dehId, string dehText
            , string bookTypeId, string bookTypeText, string scheme, string schemeLike, string scanningNoFrom, string scanningNoTo, string scanningDateFrom
            , string scanningDateTo, string entryNoFrom, string entryNoTo, string entryDateFrom, string entryDateTo, string surveyNoFrom, string surveyNoTo
            , string bookNoFrom, string bookNoTo, string pageNoFrom, string pageNoTo, string ownerName, string ownerNameLike, string cnicNo, string sortedBy
            , string ascDesc)
        {
            List<string> oList = new List<string>();
            List<eIndexing> oeListIndexing = new List<eIndexing>();
            eSearchIndexingData oeSearchIndexingData = new eSearchIndexingData();

            if (zillaId != null && zillaId != "" && zillaId != "0")
            {
                oeSearchIndexingData.Zilla_id = ValidateFields.GetSafeGuid(zillaId);
            }
            if (talukaId != null && talukaId != "")
            {
                oeSearchIndexingData.Taluka_id = ValidateFields.GetSafeGuid(talukaId);
            }
            if (dehId != null && dehId != "")
            {
                oeSearchIndexingData.Deh_id = ValidateFields.GetSafeGuid(dehId);
            }
            if (bookTypeId != "" && bookTypeId != "0")
            {
                oeSearchIndexingData.Register_id = ValidateFields.GetSafeInteger(bookTypeId);
            }
            if (bookTypeText != "" && !bookTypeText.Contains("SELECT"))
            {
                oeSearchIndexingData.Register_name = bookTypeText;
            }
            oeSearchIndexingData.Scheme_name = scheme;
            oeSearchIndexingData.SchemeLike = schemeLike;
            oeSearchIndexingData.Scanning_no_from = scanningNoFrom;
            oeSearchIndexingData.Scanning_no_to = scanningNoTo;
            if (scanningDateFrom != string.Empty)
                oeSearchIndexingData.Scanning_date_from = scanningDateFrom;
            else
                oeSearchIndexingData.Scanning_date_from = null;
            if (scanningDateTo != string.Empty)
                oeSearchIndexingData.Scanning_date_to = scanningDateTo;
            else
                oeSearchIndexingData.Scanning_date_to = null;
            oeSearchIndexingData.Entry_no_from = entryNoFrom;
            oeSearchIndexingData.Entry_no_to = entryNoTo;
            if (entryDateFrom != string.Empty)
                oeSearchIndexingData.Entry_date_from = entryDateFrom;
            else
                oeSearchIndexingData.Entry_date_from = null;
            if (entryDateTo != "")
                oeSearchIndexingData.Entry_date_to = entryDateTo;
            else
                oeSearchIndexingData.Entry_date_to = null;
            oeSearchIndexingData.Survey_no_from = surveyNoFrom;
            oeSearchIndexingData.Survey_no_to = surveyNoTo;
            oeSearchIndexingData.Book_no_from = bookNoFrom;
            oeSearchIndexingData.Book_no_to = bookNoTo;
            oeSearchIndexingData.Page_no_from = pageNoFrom;
            oeSearchIndexingData.Page_no_to = pageNoTo;
            oeSearchIndexingData.Owner_name = ownerName;
            oeSearchIndexingData.OwnerNameLike = ownerNameLike;
            oeSearchIndexingData.CnicNo = cnicNo;
            oeSearchIndexingData.SortedBy = "";
            oeSearchIndexingData.AscDesc = "";
            //totalRecord = bIndexing.getTotalRecord();
            string totalRows;
            eIndexing oeIndexing = new eIndexing();
            totalRows = bIndexing.getTotalRows(oeSearchIndexingData);
            oList.Add(totalRows);
            return oList;
        }
    }
}