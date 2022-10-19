using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Indexing.BLL;
using System.Collections;
using System.Reflection;
using Indexing.EL;
using System.Web.Services;
//using iTextSharp.text.pdf;
//using iTextSharp.text;
using PdfSharp.Pdf;
using PdfSharp.Pdf.IO;
using System.Configuration;
using System.IO;
using System.Text.RegularExpressions;

namespace Indexing.UI
{
    public partial class Indexing : System.Web.UI.Page
    {
        //public string filePath = @"D:\Farrukh\PRC_PDF";
        protected void Page_Load(object sender, EventArgs e)
        {
            //mpeLoad.Show();
            if (!IsPostBack)
            {
                if (Session["LoginUserInfo"] != null)
                {

                }
                else
                {
                    Response.Redirect("SignIn.aspx");
                    //ScriptManager.RegisterStartupScript(this, GetType(), "message", "WithoutSession();", true);
                }
                //fillZilla();
                if (Request.QueryString["Status"] != null && Request.QueryString["Status"] == "Edit")
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "Zilla", "fillZilla('Edit');", true);
                }
                else if(Request.QueryString["Status"] == null)
                { 
                    ScriptManager.RegisterStartupScript(this, GetType(), "Zilla", "fillZilla('');", true);
                }
            }
        }

        #region teritory

        private void fillZilla()
        {
            Zilla objZila = new Zilla();
            List<Zilla> oeListZila = new List<Zilla>();
            oeListZila = bTeritory.GetZilla(objZila);
            AddItem(oeListZila, typeof(Zilla), "Zilla_id", "Zilla_name_eng", "< - SELECT - >");
            if (oeListZila != null && oeListZila.Count > 0)
            {
                ddlZilla.DataSource = oeListZila;
                ddlZilla.DataValueField = "zilla_id";
                ddlZilla.DataTextField = "zilla_name_eng";
            }
        }

        private void fillTaluka()
        {
            Taluka objTaluka = new Taluka();
            objTaluka.Zilla_id = ValidateFields.GetSafeGuid(ddlZilla.SelectedValue);
            List<Taluka> oeListTaluka = new List<Taluka>();
            oeListTaluka = bTeritory.GetTaluka(objTaluka);
            AddItem(oeListTaluka, typeof(Taluka), "Taluka_id", "Taluka_name_eng", "< - SELECT - >");
            if (oeListTaluka != null && oeListTaluka.Count > 0)
            {
                ddlTaluka.DataSource = oeListTaluka;
                ddlTaluka.DataValueField = "taluka_id";
                ddlTaluka.DataTextField = "taluka_name_eng";
            }
        }

        private void fillDeh()
        {
            Deh objDeh = new Deh();
            objDeh.Taluka_id = ValidateFields.GetSafeGuid(ddlTaluka.SelectedValue);
            List<Deh> oeListDeh = new List<Deh>();
            oeListDeh = bTeritory.GetDeh(objDeh);
            AddItem(oeListDeh, typeof(Deh), "Deh_id", "Deh_name_eng", "< - SELECT - >");
            if (oeListDeh != null && oeListDeh.Count > 0)
            {
                ddlTaluka.DataSource = oeListDeh;
                ddlTaluka.DataValueField = "deh_id";
                ddlTaluka.DataTextField = "deh_name_eng";
            }
        }

        private void AddItem(IList list, Type type, string valueMember, string displayMember, string displayText)
        {
            Object obj = Activator.CreateInstance(type);
            PropertyInfo displayProperty = type.GetProperty(displayMember);
            displayProperty.SetValue(obj, displayText, null);
            PropertyInfo valueProperty = type.GetProperty(valueMember);
            Guid i = new Guid();
            valueProperty.SetValue(obj, i, null);
            list.Insert(0, obj);
            
        }

        [WebMethod()]
        public static List<Zilla> getZillaForDropDown()
        {
            Zilla objZila = new Zilla();
            List<Zilla> oeListZila = new List<Zilla>();
            oeListZila = bTeritory.GetZilla(objZila);
            return oeListZila;
        }

        [WebMethod()]
        public static List<Taluka> getTalukaForDropDown(string zillaId)
        {
            Guid zilla_id = ValidateFields.GetSafeGuid(zillaId);
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
            Deh objDeh = new Deh();
            objDeh.Taluka_id = taluka_id;
            List<Deh> oeListDeh = new List<Deh>();
            oeListDeh = bTeritory.GetDeh(objDeh);
            return oeListDeh;
        }

        #endregion 

        [WebMethod()]
        public static List<string> getPath(string entryDateInfo)
        {
            List<string> objList = new List<string>();
            /*
            string filePath = System.Environment.GetFolderPath(System.Environment.SpecialFolder.MyDocuments);

            FileInfo[] objFileInfo = dInfo.GetFiles();
            if (objFileInfo.Length > 0)
            {
                string localPath = string.Empty;
                //localPath = filePath + "\\" + entryDateSplit[2] + "\\" + entryDateSplit[1] + "\\" + entryDateInfo + "\\";
                foreach (FileInfo currentFile in objFileInfo)
                {
                    if (currentFile.Extension.ToLower() == ".pdf")
                    {
                        PdfDocument pdfDoc = PdfReader.Open(filePath + "\\" + currentFile.Name);
                        if (pdfDoc.Info.Creator.ToUpper() != "AOS PVT LTD")
                        {
                            string fielNameCurrent = filePath + "\\" + currentFile.Name;
                            objList.Add(fielNameCurrent);
                        }
                    }
                    //string fielNameCurrent = localPath + currentFile.Name;
                    //objList.Add(fielNameCurrent);
                }
                //HttpContext.Current.Session["localPath"] = localPath;
            }
            */

            string filePath = ConfigurationManager.AppSettings["fileDirectoryPath"];
            DirectoryInfo dInfo = new DirectoryInfo(filePath);
            
            string[] entryDateSplit = entryDateInfo.Split('-');
            try
            {
                if (entryDateSplit.Length == 3)
                {
                    if (dInfo.Exists)
                    {
                        DirectoryInfo[] subDirYear = dInfo.GetDirectories();
                        for (int i = 0; i < subDirYear.Length; i++)
                        {
                            if (subDirYear[i].Exists)
                            {
                                if (subDirYear[i].Name == entryDateSplit[2].ToString())
                                {
                                    DirectoryInfo[] subDirMonth = subDirYear[i].GetDirectories();
                                    for (int j = 0; j < subDirMonth.Length; j++)
                                    {
                                        if (subDirMonth[j].Exists)
                                        {
                                            if (subDirMonth[j].Name == entryDateSplit[1].ToString())
                                            {
                                                DirectoryInfo[] subDirDay = subDirMonth[j].GetDirectories();
                                                for (int k = 0; k < subDirDay.Length; k++)
                                                {
                                                    if (subDirDay[k].Exists)
                                                    {
                                                        if (subDirDay[k].Name == entryDateInfo)
                                                        {
                                                            FileInfo[] objFileInfo = subDirDay[k].GetFiles();
                                                            if (objFileInfo.Length > 0)
                                                            {
                                                                string localPath = string.Empty;
                                                                localPath = filePath + "\\" + entryDateSplit[2] + "\\" + entryDateSplit[1] + "\\" + entryDateInfo + "\\";
                                                                int totalFolderFiles = 0;
                                                                int totalIndexFiles = 0;
                                                                //HttpContext.Current.Session["TotalIndexFiles"] = null;
                                                                foreach (FileInfo currentFile in objFileInfo)
                                                                {
                                                                    if (currentFile.Extension.ToLower() == ".pdf" && currentFile.Length > 0)
                                                                    {
                                                                        totalFolderFiles++;
                                                                        PdfDocument pdfDoc = PdfReader.Open(localPath + currentFile.Name);
                                                                        if (pdfDoc.Info.Creator.ToUpper() != "AOS PVT LTD")
                                                                        {
                                                                            string fielNameCurrent = localPath + currentFile.Name;
                                                                            objList.Add(fielNameCurrent);
                                                                        }
                                                                        else
                                                                        {
                                                                            totalIndexFiles++;
                                                                        }
                                                                    }
                                                                }
                                                                HttpContext.Current.Session["TotalIndexFiles"] = totalIndexFiles;
                                                                if (totalFolderFiles == totalIndexFiles)
                                                                {
                                                                    objList.Add("equal");
                                                                }
                                                                //HttpContext.Current.Session["localPath"] = localPath;
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ;
            }
            return objList;
        }

        private void requiredFields()
        {

        }


        private static string metaDateValidate(string zillaId, string talukaId, string dehId, string bookType, string scanningDate, 
            string entryNo, string entryDate, string surveyNo, string ownerName)
        {
            string msg = string.Empty;
            if (zillaId == string.Empty)
            {
                msg = "Please select zilla";
                return msg;
            }
            if (talukaId == string.Empty)
            {
                msg = "Please select taluka";
                return msg;
            }
            if (dehId == string.Empty)
            {
                msg = "Please select deh";
                return msg;
            }
            if (bookType == string.Empty)
            {
                msg = "Please select book type";
                return msg;
            }
            if (scanningDate == string.Empty)
            {
                msg = "Please enter scanning date";
                return msg;
            }
            if (scanningDate != string.Empty)
            {
                if (!Regex.IsMatch(scanningDate, @"^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$"))
                {
                    msg = "Please enter correct scanning date";
                    return msg;
                }
            }
            if (entryNo == string.Empty)
            {
                msg = "Please enter entry no";
                return msg;
            }
            if (entryDate == string.Empty)
            {
                msg = "Please enter entry date";
                return msg;
            }
            if (entryDate != string.Empty)
            {
                if (!Regex.IsMatch(entryDate, @"^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$"))
                {
                    msg = "Please enter correct entry date";
                    return msg;
                }
            }
            if (surveyNo == string.Empty)
            {
                msg = "Please enter survey no";
                return msg;
            }
            if (ownerName == string.Empty)
            {
                msg = "Please enter owner name";
                return msg;
            }

            return msg;
        }

        [WebMethod()]
        public static List<string> saveMetaData(string zillaId, string zillaText, string talukaId, string talukaText, string dehId, string dehText,
            string bookTypeId, string bookTypeText, string scheme, string scanningNo, string scanningDate, string entryNo, string entryDate, 
            string surveyNo, string bookNo, string pageNo, string ownerName, string cnicNo, string currentPDfFile, string IndexingId)
        {
            eUser oeUser = null;
            if (HttpContext.Current.Session["LoginUserInfo"] != null)
            {
                oeUser = (eUser)HttpContext.Current.Session["LoginUserInfo"];
            }
            string validateResult = metaDateValidate(zillaId, talukaId, dehId, bookTypeId, scanningDate, entryNo, entryDate, surveyNo, ownerName);
            List<string> listString = new List<string>();
            if (validateResult == string.Empty)
            {
                bTeritory obj = new bTeritory();
                string strResult = string.Empty;

                string keyword = "zilla=" + zillaText + ",";
                keyword += "taluka=" + talukaText + ",";
                keyword += "deh=" + dehText + ",";
                keyword += "bookType=" + bookTypeId + ",";
                keyword += "scheme=" + scheme + ",";
                keyword += "scanningNo=" + scanningNo + ",";
                keyword += "scanningDate=" + scanningDate + ",";
                keyword += "entryNo=" + entryNo + ",";
                keyword += "entryDate=" + entryDate + ",";
                keyword += "surveyNo=" + surveyNo + ",";
                keyword += "bookNo=" + bookNo + ",";
                keyword += "pageNo=" + pageNo + ",";
                keyword += "ownerName=" + ownerName + ",";
                keyword += "cnicNo=" + cnicNo;

                try
                {
                    eIndexing oeIndexing = new eIndexing();
                    oeIndexing.Indexing_metadata = keyword;
                    oeIndexing.Zilla_id = ValidateFields.GetSafeGuid(zillaId);
                    oeIndexing.Taluka_id = ValidateFields.GetSafeGuid(talukaId);
                    oeIndexing.Deh_id = ValidateFields.GetSafeGuid(dehId);
                    oeIndexing.Register_id = ValidateFields.GetSafeInteger(bookTypeId);
                    oeIndexing.Register_name = bookTypeText;
                    oeIndexing.Scheme_name = scheme;
                    oeIndexing.Scan_no = scanningNo;
                    oeIndexing.Scan_date = ValidateFields.GetSafeString(scanningDate);
                    oeIndexing.Entry_no = entryNo;
                    oeIndexing.Entry_date = ValidateFields.GetSafeString(entryDate);
                    oeIndexing.Survey_no = surveyNo;
                    oeIndexing.Book_no = bookNo;
                    oeIndexing.Page_no = pageNo;
                    oeIndexing.Owner_name = ownerName;
                    oeIndexing.Cnic = cnicNo;
                    oeIndexing.User_id = oeUser.User_id;
                    oeIndexing.Access_date_time = DateTime.Now;
                    UpdateEntryInfo info = new UpdateEntryInfo();
                    if (IndexingId == string.Empty)
                    {
                        oeIndexing.Indexing_id = Guid.NewGuid();
                        oeIndexing.Image_id = Guid.NewGuid();
                        PdfDocument pdfDoc = PdfReader.Open(currentPDfFile);

                        oeIndexing.ObjScanImages.Image_file = System.IO.File.ReadAllBytes(currentPDfFile);
                        oeIndexing.OeUsersLog = new eUsersLog();
                        oeIndexing.OeUsersLog.Userlog_id = Guid.NewGuid();
                        oeIndexing.OeUsersLog.User_name = oeUser.User_name;
                        //oeIndexing.OeUsersLog.Ipadress = System.Net.Dns.GetHostEntry(System.Net.Dns.GetHostName()).AddressList[2].ToString();
                        //string ip = System.Net.Dns.GetHostByName(Environment.MachineName).AddressList[0].ToString();
                        if (System.Net.Dns.GetHostAddresses(HttpContext.Current.Request.UserHostName).Length > 0)
                            oeIndexing.OeUsersLog.Ipadress = System.Net.Dns.GetHostAddresses(HttpContext.Current.Request.UserHostName).GetValue(0).ToString();
                        else
                            oeIndexing.OeUsersLog.Ipadress = "";
                        oeIndexing.OeUsersLog.Operation_id = 1; //For Add;
                        oeIndexing.OeUsersLog.Log_datetime = DateTime.Now.ToString();
                        pdfDoc.Info.Keywords = keyword;
                        pdfDoc.Info.Subject = "Metadata stored file";
                        pdfDoc.Info.Author = "Ayaz Khan (IT Director), Farrukh Shahid (SSE)";
                        pdfDoc.Info.Creator = "AOS Pvt Ltd";
                        pdfDoc.Save(currentPDfFile);
                        info = bIndexing.InsertIndexingWithImage(oeIndexing);
                        if (info.Success)
                        {
                            strResult = "success";
                            listString.Add(strResult);
                        }
                        else
                        {
                            pdfDoc.Info.Keywords = "";
                            pdfDoc.Info.Author = "";
                            pdfDoc.Info.Creator = "";
                            pdfDoc.Save(currentPDfFile);
                            pdfDoc.Close();
                            strResult = info.Exception;
                            if (strResult == string.Empty)
                            {
                                strResult = "An error accur during InsertIndexingImage Method, Please contact administrator";
                            }
                            listString.Add(strResult);
                        }
                    }
                    else
                    {
                        oeIndexing.Indexing_id = ValidateFields.GetSafeGuid(IndexingId);
                        oeIndexing.OeUsersLog = new eUsersLog();
                        oeIndexing.OeUsersLog.Userlog_id = Guid.NewGuid();
                        oeIndexing.OeUsersLog.User_name = oeUser.User_name;
                        //oeIndexing.OeUsersLog.Ipadress = System.Net.Dns.GetHostEntry(System.Net.Dns.GetHostName()).AddressList[2].ToString();
                        if (System.Net.Dns.GetHostAddresses(HttpContext.Current.Request.UserHostName).Length > 0)
                            oeIndexing.OeUsersLog.Ipadress = System.Net.Dns.GetHostAddresses(HttpContext.Current.Request.UserHostName).GetValue(0).ToString();
                        else
                            oeIndexing.OeUsersLog.Ipadress = "";
                        oeIndexing.OeUsersLog.Operation_id = 2; //For Update;
                        oeIndexing.OeUsersLog.Log_datetime = DateTime.Now.ToString();
                        info = bIndexing.updateIndexing(oeIndexing);
                        if (info.Success)
                        {  
                            strResult = "update";
                            listString.Add(strResult);
                        }
                        else
                        {
                            strResult = info.Exception;
                            listString.Add(strResult);
                        }
                    }
                }
                catch (Exception ex)
                {
                    strResult = ex.Message;
                    listString.Add(strResult);
                }
            }
            else
            {
                listString.Add(validateResult);
            }
            return listString;
        }

        [WebMethod()]
        public static List<eIndexing> loadPrintData(string IndexingId)
        {
            Guid indexing_id = ValidateFields.GetSafeGuid(IndexingId);            
            eIndexing oeIndexing = new eIndexing();
            List<eIndexing> oeListIndexing = new List<eIndexing>();
            oeIndexing.Indexing_id = indexing_id;
            oeListIndexing = bIndexing.GetTerritoryInfoWithIndexing(oeIndexing);
            return oeListIndexing;
        }
    }
}