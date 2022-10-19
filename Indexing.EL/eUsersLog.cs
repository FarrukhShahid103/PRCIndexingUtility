using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Indexing.EL
{
    public class eUsersLog
    {
        private Guid userlog_id;
        public Guid Userlog_id
        {
            get { return userlog_id; }
            set { userlog_id = value; }
        }

        private string user_name;
        public string User_name
        {
            get { return user_name; }
            set { user_name = value; }
        }

        private int operation_id;
        public int Operation_id
        {
            get { return operation_id; }
            set { operation_id = value; }
        }

        private string log_datetime;
        public string Log_datetime
        {
            get { return log_datetime; }
            set { log_datetime = value; }
        }

        private string log_dateFrom;
        public string Log_dateFrom
        {
            get { return log_dateFrom; }
            set { log_dateFrom = value; }
        }

        private string log_dateTo;
        public string Log_dateTo
        {
            get { return log_dateTo; }
            set { log_dateTo = value; }
        }

        private string scan_no;
        public string Scan_no
        {
            get { return scan_no; }
            set { scan_no = value; }
        }

        private string ipadress;
        public string Ipadress
        {
            get { return ipadress; }
            set { ipadress = value; }
        }

        private DateTime access_datetime;
        public DateTime Access_datetime
        {
            get { return access_datetime; }
            set { access_datetime = value; }
        }

    }
}
