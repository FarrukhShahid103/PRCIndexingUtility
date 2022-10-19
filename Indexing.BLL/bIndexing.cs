using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Indexing.DLL;
using Indexing.EL;

namespace Indexing.BLL
{
    public class bIndexing
    {
        private static long m_totalRecords = -1;
        //public static List<eIndexing> GetIndexing(eIndexing oeIndexing)
        //{
        //    string condition = BuildCondition(oeIndexing);
        //    List<eIndexing> oeListIndexing = new List<eIndexing>();
        //    oeListIndexing = dIndexing.GetIndexing(condition);
        //    return oeListIndexing;
        //}

        public static List<eIndexing> GetTerritoryInfoWithIndexing(eIndexing oeIndexing)
        {
            string condition = BuildCondition(oeIndexing);
            List<eIndexing> oeListIndexing = new List<eIndexing>();
            oeListIndexing = dIndexing.GetTerritoryInfoWithIndexing(condition);
            return oeListIndexing;
        }

        public static List<eIndexing> SearchIndexingData(eSearchIndexingData oeSearchIndexingData, string startIndex, string endIndex)
        {
            string condition = BuildCondition(oeSearchIndexingData);
            List<eIndexing> oeListIndexing = new List<eIndexing>();
            oeListIndexing = dIndexing.GetIndexing(condition, startIndex, endIndex, ref m_totalRecords);
            return oeListIndexing;
        }

        public static UpdateEntryInfo insertIndexing(eIndexing oeIndexing)
        {
            UpdateEntryInfo insertInfo = new UpdateEntryInfo();
            insertInfo = dIndexing.InsertIndexing(oeIndexing);
            return insertInfo;
        }

        public static long getTotalRecord()
        {
            return m_totalRecords;
        }

        public static string getTotalRows(eSearchIndexingData oeSearchIndexingData)
        {
            string condition = BuildCondition(oeSearchIndexingData);
            string totalRecord;
            totalRecord = dIndexing.getTotalRows(condition);
            return totalRecord;
        }

        public static UpdateEntryInfo InsertIndexingWithImage(eIndexing oeIndexing)
        {
            UpdateEntryInfo insertInfo = new UpdateEntryInfo();
            insertInfo = dIndexing.InsertIndexingWithImage(oeIndexing);
            return insertInfo;
        }

        public static UpdateEntryInfo updateIndexing(eIndexing oeIndexing)
        {
            UpdateEntryInfo updateInfo = new UpdateEntryInfo();
            updateInfo = dIndexing.UpdateIndexing(oeIndexing);
            return updateInfo;
        }

        public static UpdateEntryInfo deleteIndexing(eIndexing oeIndexing)
        {
            UpdateEntryInfo deleteInfo = new UpdateEntryInfo();
            deleteInfo = dIndexing.DeleteIndexing(oeIndexing.Indexing_id);
            return deleteInfo;
        }

        public static UpdateEntryInfo DeleteIndexingWithImage(eIndexing oeIndexing)
        {
            UpdateEntryInfo deleteInfo = new UpdateEntryInfo();
            deleteInfo = dIndexing.DeleteIndexingWithImage(oeIndexing.Indexing_id);
            return deleteInfo;
        }

        private static string BuildCondition(eIndexing oeIndexing)
        {
            string result = "";
            if (oeIndexing.Indexing_id != Guid.Empty)
                result += (result == "" ? "" : " AND ") + "indexing_id = '" + oeIndexing.Indexing_id + "'";
            if (oeIndexing.Image_id != Guid.Empty)
                result += (result == "" ? "" : " AND ") + "image_id = '" + oeIndexing.Image_id + "'";
            if (oeIndexing.Indexing_metadata != null && oeIndexing.Indexing_metadata != string.Empty)
                result += (result == "" ? "" : " AND ") + "indexing_metadata = '" + oeIndexing.Indexing_metadata + "'";
            if (oeIndexing.Zilla_id != Guid.Empty)
                result += (result == "" ? "" : " AND ") + "zilla_id = '" + oeIndexing.Zilla_id + "'";
            if (oeIndexing.Taluka_id != Guid.Empty)
                result += (result == "" ? "" : " AND ") + "taluka_id = '" + oeIndexing.Taluka_id + "'";
            if (oeIndexing.Deh_id != Guid.Empty)
                result += (result == "" ? "" : " AND ") + "deh_id = '" + oeIndexing.Deh_id + "'";
            if (oeIndexing.Register_id != null)
                result += (result == "" ? "" : " AND ") + "register_id = '" + oeIndexing.Register_id + "'";
            if (oeIndexing.Register_name != null && oeIndexing.Register_name != String.Empty)
                result += (result == "" ? "" : " AND ") + "register_name = '" + oeIndexing.Register_name + "'";
            if (oeIndexing.Scheme_name != null && oeIndexing.Scheme_name != String.Empty)
                result += (result == "" ? "" : " AND ") + "scheme_name = '" + oeIndexing.Scheme_name + "'";
            if (oeIndexing.Scan_no != null && oeIndexing.Scan_no != String.Empty)
                result += (result == "" ? "" : " AND ") + "scan_no = '" + oeIndexing.Scan_no + "'";
            if (oeIndexing.Scan_date != null)
                result += (result == "" ? "" : " AND ") + "scan_date = '" + oeIndexing.Scan_date + "'";
            if (oeIndexing.Entry_no != null && oeIndexing.Entry_no != String.Empty)
                result += (result == "" ? "" : " AND ") + "entry_no = '" + oeIndexing.Entry_no + "'";
            if (oeIndexing.Entry_date != null)
                result += (result == "" ? "" : " AND ") + "entry_date = '" + oeIndexing.Entry_date + "'";
            if (oeIndexing.Survey_no != null && oeIndexing.Survey_no != String.Empty)
                result += (result == "" ? "" : " AND ") + "survey_no = '" + oeIndexing.Survey_no + "'";
            if (oeIndexing.Book_no != null && oeIndexing.Book_no != String.Empty)
                result += (result == "" ? "" : " AND ") + "book_no = '" + oeIndexing.Book_no + "'";
            if (oeIndexing.Page_no != null && oeIndexing.Page_no != String.Empty)
                result += (result == "" ? "" : " AND ") + "page_no = '" + oeIndexing.Page_no + "'";
            if (oeIndexing.Owner_name != null && oeIndexing.Owner_name != String.Empty)
                result += (result == "" ? "" : " AND ") + "owner_name = '" + oeIndexing.Owner_name + "'";
            if (oeIndexing.Cnic != null && oeIndexing.Cnic != String.Empty)
                result += (result == "" ? "" : " AND ") + "cnic = '" + oeIndexing.Cnic + "'";
            if (oeIndexing.User_id != Guid.Empty)
                result += (result == "" ? "" : " AND ") + "user_id = '" + oeIndexing.User_id + "'";
            if (oeIndexing.Access_date_time != DateTime.MinValue)
                result += (result == "" ? "" : " AND ") + "access_date_time = '" + oeIndexing.Access_date_time + "'";

            if (result != "")
                result = (" WHERE " + result);
            return result;
        }

        private static string BuildCondition(eSearchIndexingData oeSearchIndexingData)
        {
            string result = "";
            if (oeSearchIndexingData.Indexing_id != Guid.Empty)
                result += (result == "" ? "" : " AND ") + "indexing_id = '" + oeSearchIndexingData.Indexing_id + "'";
            if (oeSearchIndexingData.Image_id != Guid.Empty)
                result += (result == "" ? "" : " AND ") + "image_id = '" + oeSearchIndexingData.Image_id + "'";
            if (oeSearchIndexingData.Zilla_id != Guid.Empty)
                result += (result == "" ? "" : " AND ") + "i.zilla_id = '" + oeSearchIndexingData.Zilla_id + "'";
            if (oeSearchIndexingData.Taluka_id != Guid.Empty)
                result += (result == "" ? "" : " AND ") + "i.taluka_id = '" + oeSearchIndexingData.Taluka_id + "'";
            if (oeSearchIndexingData.Deh_id != Guid.Empty)
                result += (result == "" ? "" : " AND ") + "i.deh_id = '" + oeSearchIndexingData.Deh_id + "'";
            if (oeSearchIndexingData.Register_id != null && oeSearchIndexingData.Register_id != 0)
                result += (result == "" ? "" : " AND ") + "register_id = '" + oeSearchIndexingData.Register_id + "'";
            //if (oeSearchIndexingData.Register_name != null && oeSearchIndexingData.Register_name != String.Empty)
              //  result += (result == "" ? "" : " AND ") + "register_name = '" + oeSearchIndexingData.Register_name + "'";
            if (oeSearchIndexingData.Scheme_name != null && oeSearchIndexingData.Scheme_name != String.Empty)
            {
                if (oeSearchIndexingData.SchemeLike == "=")
                {
                    result += (result == "" ? "" : " AND ") + "scheme_name " + oeSearchIndexingData.SchemeLike + " '" + oeSearchIndexingData.Scheme_name + "'";
                }
                else
                {
                    result += (result == "" ? "" : " AND ") + "scheme_name " + oeSearchIndexingData.SchemeLike + " '%" + oeSearchIndexingData.Scheme_name + "%'";
                }
            }
            if ((oeSearchIndexingData.Scanning_no_from != null && oeSearchIndexingData.Scanning_no_from != String.Empty)
                || (oeSearchIndexingData.Scanning_no_to != null && oeSearchIndexingData.Scanning_no_to != String.Empty))
            {
                if ((oeSearchIndexingData.Scanning_no_from != null && oeSearchIndexingData.Scanning_no_from != String.Empty)
                && (oeSearchIndexingData.Scanning_no_to != null && oeSearchIndexingData.Scanning_no_to != String.Empty))
                {
                    result += (result == "" ? "" : " AND ") + "(utility.fnc_ParseINT(utility.fnc_ParseAlphaChars(scan_no)) >= utility.fnc_ParseINT(utility.fnc_ParseAlphaChars('" + oeSearchIndexingData.Scanning_no_from + "')) AND utility.fnc_ParseINT(utility.fnc_ParseAlphaChars(scan_no)) <= utility.fnc_ParseINT(utility.fnc_ParseAlphaChars('" + oeSearchIndexingData.Scanning_no_to + "'))) ";
                }
                else if (oeSearchIndexingData.Scanning_no_from != null && oeSearchIndexingData.Scanning_no_from != String.Empty)
                {
                    result += (result == "" ? "" : " AND ") + "utility.fnc_ParseINT(utility.fnc_ParseAlphaChars(scan_no)) >= utility.fnc_ParseINT(utility.fnc_ParseAlphaChars('" + oeSearchIndexingData.Scanning_no_from + "')) ";
                }
                else if (oeSearchIndexingData.Scanning_no_to != null && oeSearchIndexingData.Scanning_no_to != String.Empty)
                {
                    result += (result == "" ? "" : " AND ") + "utility.fnc_ParseINT(utility.fnc_ParseAlphaChars(scan_no)) <= utility.fnc_ParseINT(utility.fnc_ParseAlphaChars('" + oeSearchIndexingData.Scanning_no_to + "')) ";
                }
            }
            if ((oeSearchIndexingData.Scanning_date_from != null && ValidateFields.GetSafeString(oeSearchIndexingData.Scanning_date_from) != String.Empty)
                || (oeSearchIndexingData.Scanning_date_to != null && ValidateFields.GetSafeString(oeSearchIndexingData.Scanning_date_to) != String.Empty))
            {
                if ((oeSearchIndexingData.Scanning_date_from != null && ValidateFields.GetSafeString(oeSearchIndexingData.Scanning_date_from) != String.Empty)
                && (oeSearchIndexingData.Scanning_date_to != null && ValidateFields.GetSafeString(oeSearchIndexingData.Scanning_date_to) != String.Empty))
                {
                    result += (result == "" ? "" : " AND ") + "(scan_date >= TRY_PARSE('" + oeSearchIndexingData.Scanning_date_from + "' AS date USING 'en-gb') AND scan_date <= TRY_PARSE('" + oeSearchIndexingData.Scanning_date_to + "' AS date USING 'en-gb')) ";
                }
                else if (oeSearchIndexingData.Scanning_date_from != null && ValidateFields.GetSafeString(oeSearchIndexingData.Scanning_date_from) != String.Empty)
                {
                    result += (result == "" ? "" : " AND ") + "scan_date >= TRY_PARSE('" + oeSearchIndexingData.Scanning_date_from + "' AS date USING 'en-gb') ";
                }
                else if (oeSearchIndexingData.Scanning_date_to != null && ValidateFields.GetSafeString(oeSearchIndexingData.Scanning_date_to) != String.Empty)
                {
                    result += (result == "" ? "" : " AND ") + "scan_date <= TRY_PARSE('" + oeSearchIndexingData.Scanning_date_to + "' AS date USING 'en-gb') ";
                }
            }
            if ((oeSearchIndexingData.Entry_no_from != null && oeSearchIndexingData.Entry_no_from != String.Empty)
                || (oeSearchIndexingData.Entry_no_to != null && oeSearchIndexingData.Entry_no_to != String.Empty))
            {
                if ((oeSearchIndexingData.Entry_no_from != null && oeSearchIndexingData.Entry_no_from != String.Empty)
                && (oeSearchIndexingData.Entry_no_to != null && oeSearchIndexingData.Entry_no_to != String.Empty))
                {
                    result += (result == "" ? "" : " AND ") + "(utility.fnc_ParseINT(utility.fnc_ParseAlphaChars(entry_no)) >= utility.fnc_ParseINT(utility.fnc_ParseAlphaChars('" + oeSearchIndexingData.Entry_no_from + "')) AND utility.fnc_ParseINT(utility.fnc_ParseAlphaChars(entry_no)) <= utility.fnc_ParseINT(utility.fnc_ParseAlphaChars('" + oeSearchIndexingData.Entry_no_to + "'))) ";
                }
                else if (oeSearchIndexingData.Entry_no_from != null && oeSearchIndexingData.Entry_no_from != String.Empty)
                {
                    result += (result == "" ? "" : " AND ") + "utility.fnc_ParseINT(utility.fnc_ParseAlphaChars(entry_no)) >= utility.fnc_ParseINT(utility.fnc_ParseAlphaChars('" + oeSearchIndexingData.Entry_no_from + "')) ";
                }
                else if (oeSearchIndexingData.Entry_no_to != null && oeSearchIndexingData.Entry_no_to != String.Empty)
                {
                    result += (result == "" ? "" : " AND ") + "utility.fnc_ParseINT(utility.fnc_ParseAlphaChars(entry_no)) <= utility.fnc_ParseINT(utility.fnc_ParseAlphaChars('" + oeSearchIndexingData.Entry_no_to + "')) ";
                }
            }
            if ((oeSearchIndexingData.Entry_date_from != null && ValidateFields.GetSafeString(oeSearchIndexingData.Entry_date_from) != String.Empty)
                || (oeSearchIndexingData.Entry_date_to != null && ValidateFields.GetSafeString(oeSearchIndexingData.Entry_date_to) != String.Empty))
            {
                if ((oeSearchIndexingData.Entry_date_from != null && ValidateFields.GetSafeString(oeSearchIndexingData.Entry_date_from) != String.Empty)
                && (oeSearchIndexingData.Entry_date_to != null && ValidateFields.GetSafeString(oeSearchIndexingData.Entry_date_to) != String.Empty))
                {
                    result += (result == "" ? "" : " AND ") + "(entry_date >= TRY_PARSE('" + oeSearchIndexingData.Entry_date_from + "' AS date USING 'en-gb') AND entry_date <= TRY_PARSE('" + oeSearchIndexingData.Entry_date_to + "' AS date USING 'en-gb')) ";
                }
                else if (oeSearchIndexingData.Entry_date_from != null && ValidateFields.GetSafeString(oeSearchIndexingData.Entry_date_from) != String.Empty)
                {
                    result += (result == "" ? "" : " AND ") + "entry_date >= TRY_PARSE('" + oeSearchIndexingData.Entry_date_from.Trim().TrimStart(' ') + "' AS date USING 'en-gb') ";
                }
                else if (oeSearchIndexingData.Entry_date_to != null && ValidateFields.GetSafeString(oeSearchIndexingData.Entry_date_to) != String.Empty)
                {
                    result += (result == "" ? "" : " AND ") + "entry_date <= TRY_PARSE('" + oeSearchIndexingData.Entry_date_to + "' AS date USING 'en-gb') ";
                }
            }
            if ((oeSearchIndexingData.Survey_no_from != null && oeSearchIndexingData.Survey_no_from != String.Empty)
                || (oeSearchIndexingData.Survey_no_to != null && oeSearchIndexingData.Survey_no_to != String.Empty))
            {
                if ((oeSearchIndexingData.Survey_no_from != null && oeSearchIndexingData.Survey_no_from != String.Empty)
                && (oeSearchIndexingData.Survey_no_to != null && oeSearchIndexingData.Survey_no_to != String.Empty))
                {
                    result += (result == "" ? "" : " AND ") + "(utility.fnc_ParseINT(utility.fnc_ParseAlphaChars(survey_no)) >= utility.fnc_ParseINT(utility.fnc_ParseAlphaChars('" + oeSearchIndexingData.Survey_no_from + "')) AND utility.fnc_ParseINT(utility.fnc_ParseAlphaChars(survey_no)) <= utility.fnc_ParseINT(utility.fnc_ParseAlphaChars('" + oeSearchIndexingData.Survey_no_to + "'))) ";
                }
                else if (oeSearchIndexingData.Survey_no_from != null && oeSearchIndexingData.Survey_no_from != String.Empty)
                {
                    result += (result == "" ? "" : " AND ") + "utility.fnc_ParseINT(utility.fnc_ParseAlphaChars(survey_no)) >= utility.fnc_ParseINT(utility.fnc_ParseAlphaChars('" + oeSearchIndexingData.Survey_no_from + "')) ";
                }
                else if (oeSearchIndexingData.Survey_no_to != null && oeSearchIndexingData.Survey_no_to != String.Empty)
                {
                    result += (result == "" ? "" : " AND ") + "utility.fnc_ParseINT(utility.fnc_ParseAlphaChars(survey_no)) <= utility.fnc_ParseINT(utility.fnc_ParseAlphaChars('" + oeSearchIndexingData.Survey_no_to + "')) ";
                }
            }
            if ((oeSearchIndexingData.Book_no_from != null && oeSearchIndexingData.Book_no_from != String.Empty)
                || (oeSearchIndexingData.Book_no_to != null && oeSearchIndexingData.Book_no_to != String.Empty))
            {
                if ((oeSearchIndexingData.Book_no_from != null && oeSearchIndexingData.Book_no_from != String.Empty)
                && (oeSearchIndexingData.Book_no_to != null && oeSearchIndexingData.Book_no_to != String.Empty))
                {
                    result += (result == "" ? "" : " AND ") + "(utility.fnc_ParseINT(utility.fnc_ParseAlphaChars(book_no)) >= utility.fnc_ParseINT(utility.fnc_ParseAlphaChars('" + oeSearchIndexingData.Book_no_from + "')) AND utility.fnc_ParseINT(utility.fnc_ParseAlphaChars(book_no)) <= utility.fnc_ParseINT(utility.fnc_ParseAlphaChars('" + oeSearchIndexingData.Book_no_to + "'))) ";
                }
                else if (oeSearchIndexingData.Book_no_from != null && oeSearchIndexingData.Book_no_from != String.Empty)
                {
                    result += (result == "" ? "" : " AND ") + "utility.fnc_ParseINT(utility.fnc_ParseAlphaChars(book_no)) >= utility.fnc_ParseINT(utility.fnc_ParseAlphaChars('" + oeSearchIndexingData.Book_no_from + "')) ";
                }
                else if (oeSearchIndexingData.Book_no_to != null && oeSearchIndexingData.Book_no_to != String.Empty)
                {
                    result += (result == "" ? "" : " AND ") + "utility.fnc_ParseINT(utility.fnc_ParseAlphaChars(book_no)) <= utility.fnc_ParseINT(utility.fnc_ParseAlphaChars('" + oeSearchIndexingData.Book_no_to + "')) ";
                }
            }
            if ((oeSearchIndexingData.Page_no_from != null && oeSearchIndexingData.Page_no_from != String.Empty)
               || (oeSearchIndexingData.Page_no_to != null && oeSearchIndexingData.Page_no_to != String.Empty))
            {
                if ((oeSearchIndexingData.Page_no_from != null && oeSearchIndexingData.Page_no_from != String.Empty)
                && (oeSearchIndexingData.Page_no_to != null && oeSearchIndexingData.Page_no_to != String.Empty))
                {
                    result += (result == "" ? "" : " AND ") + "(utility.fnc_ParseINT(utility.fnc_ParseAlphaChars(page_no)) >= utility.fnc_ParseINT(utility.fnc_ParseAlphaChars('" + oeSearchIndexingData.Page_no_from + "')) AND utility.fnc_ParseINT(utility.fnc_ParseAlphaChars(page_no)) <= utility.fnc_ParseINT(utility.fnc_ParseAlphaChars('" + oeSearchIndexingData.Page_no_to + "'))) ";
                }
                else if (oeSearchIndexingData.Page_no_from != null && oeSearchIndexingData.Page_no_from != String.Empty)
                {
                    result += (result == "" ? "" : " AND ") + "utility.fnc_ParseINT(utility.fnc_ParseAlphaChars(page_no)) >= utility.fnc_ParseINT(utility.fnc_ParseAlphaChars('" + oeSearchIndexingData.Page_no_from + "')) ";
                }
                else if (oeSearchIndexingData.Page_no_to != null && oeSearchIndexingData.Page_no_to != String.Empty)
                {
                    result += (result == "" ? "" : " AND ") + "utility.fnc_ParseINT(utility.fnc_ParseAlphaChars(page_no)) <= utility.fnc_ParseINT(utility.fnc_ParseAlphaChars('" + oeSearchIndexingData.Page_no_to + "')) ";
                }
            }
            if (oeSearchIndexingData.Owner_name != null && oeSearchIndexingData.Owner_name != String.Empty)
            {
                if (oeSearchIndexingData.OwnerNameLike == "=")
                {
                    result += (result == "" ? "" : " AND ") + "owner_name " + oeSearchIndexingData.OwnerNameLike + " '" + oeSearchIndexingData.Owner_name + "'";
                }
                else
                {
                    result += (result == "" ? "" : " AND ") + "owner_name " + oeSearchIndexingData.OwnerNameLike + " '%" + oeSearchIndexingData.Owner_name + "%'";
                }
            }
            if (oeSearchIndexingData.CnicNo != null && oeSearchIndexingData.CnicNo != String.Empty)
                result += (result == "" ? "" : " AND ") + "cnic = '" + oeSearchIndexingData.CnicNo + "'";

            string sort = string.Empty;
            if (oeSearchIndexingData.SortedBy != null && oeSearchIndexingData.SortedBy != String.Empty)
            {
                sort = " ORDER BY " + oeSearchIndexingData.SortedBy + " " + oeSearchIndexingData.AscDesc;
            }

            if (result != "")
                result = (" WHERE " + result);

            if (sort != string.Empty)
                result = result + sort;

            return result;
        }
    }
}
