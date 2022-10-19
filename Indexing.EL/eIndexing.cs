using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Indexing.EL
{
    public class eIndexing
    {
        private Guid indexing_id;
        public Guid Indexing_id
        {
            get { return indexing_id; }
            set { indexing_id = value; }
        }

        private Guid image_id;
        public Guid Image_id
        {
            get { return image_id; }
            set { image_id = value; }
        }

        private string indexing_metadata;
        public string Indexing_metadata
        {
            get { return indexing_metadata; }
            set { indexing_metadata = value; }
        }

        private Guid zilla_id;
        public Guid Zilla_id
        {
            get { return zilla_id; }
            set { zilla_id = value; }
        }

        private Guid taluka_id;
        public Guid Taluka_id
        {
            get { return taluka_id; }
            set { taluka_id = value; }
        }

        private Guid deh_id;
        public Guid Deh_id
        {
            get { return deh_id; }
            set { deh_id = value; }
        }

        private int? register_id;
        public int? Register_id
        {
            get { return register_id; }
            set { register_id = value; }
        }

        private string register_name;
        public string Register_name
        {
            get { return register_name; }
            set { register_name = value; }
        }

        private string scheme_name;
        public string Scheme_name
        {
            get { return scheme_name; }
            set { scheme_name = value; }
        }

        private string scan_no;
        public string Scan_no
        {
            get { return scan_no; }
            set { scan_no = value; }
        }

        private string scan_date;
        public string Scan_date
        {
            get { return scan_date; }
            set { scan_date = value; }
        }

        private string entry_no;
        public string Entry_no
        {
            get { return entry_no; }
            set { entry_no = value; }
        }

        private string entry_date;
        public string Entry_date
        {
            get { return entry_date; }
            set { entry_date = value; }
        }

        private string survey_no;
        public string Survey_no
        {
            get { return survey_no; }
            set { survey_no = value; }
        }

        private string book_no;
        public string Book_no
        {
            get { return book_no; }
            set { book_no = value; }
        }

        private string page_no;
        public string Page_no
        {
            get { return page_no; }
            set { page_no = value; }
        }

        private string owner_name;
        public string Owner_name
        {
            get { return owner_name; }
            set { owner_name = value; }
        }

        private string cnic;
        public string Cnic
        {
            get { return cnic; }
            set { cnic = value; }
        }

        private Guid user_id;
        public Guid User_id
        {
            get { return user_id; }
            set { user_id = value; }
        }

        private DateTime access_date_time;
        public DateTime Access_date_time
        {
            get { return access_date_time; }
            set { access_date_time = value; }
        }

        private eScanImages objScanImages;
        public eScanImages ObjScanImages
        {
            get { return objScanImages; }
            set { objScanImages = value; }
        }

        private string zilla_name;
        public string Zilla_name
        {
            get { return zilla_name; }
            set { zilla_name = value; }
        }

        private string taluka_name;
        public string Taluka_name
        {
            get { return taluka_name; }
            set { taluka_name = value; }
        }

        private string deh_name;
        public string Deh_name
        {
            get { return deh_name; }
            set { deh_name = value; }
        }

        private eUsersLog oeUsersLog;
        public eUsersLog OeUsersLog
        {
            get { return oeUsersLog; }
            set { oeUsersLog = value; }
        }

        public eIndexing()
        {
            this.ObjScanImages = new eScanImages();
        }

    }
}
