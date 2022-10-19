using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Indexing.EL
{
    public class eUser
    {
        private Guid user_id;

        public Guid User_id
        {
            get { return user_id; }
            set { user_id = value; }
        }
        private bool user_status;

        public bool User_status
        {
            get { return user_status; }
            set { user_status = value; }
        }
        private string display_name;

        public string Display_name
        {
            get { return display_name; }
            set { display_name = value; }
        }
        private string user_name;

        public string User_name
        {
            get { return user_name; }
            set { user_name = value; }
        }
        private string password;

        public string Password
        {
            get { return password; }
            set { password = value; }
        }
        private bool login_status;

        public bool Login_status
        {
            get { return login_status; }
            set { login_status = value; }
        }
        private DateTime access_datetime;

        public DateTime Access_datetime
        {
            get { return access_datetime; }
            set { access_datetime = value; }
        }
        private string system_name;

        public string System_name
        {
            get { return system_name; }
            set { system_name = value; }
        }

        private List<eRoles> objRoles;

        public List<eRoles> ObjRoles
        {
            get { return objRoles; }
            set { objRoles = value; }
        }

        public eUser()
        {
            objRoles = new List<eRoles>();
        }
    }
}
