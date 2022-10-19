using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Indexing.EL
{
    public class Taluka
    {
        private Guid taluka_id;

        public Guid Taluka_id
        {
            get { return taluka_id; }
            set { taluka_id = value; }
        }
        private Guid zilla_id;

        public Guid Zilla_id
        {
            get { return zilla_id; }
            set { zilla_id = value; }
        }
        private string taluka_name_eng;

        public string Taluka_name_eng
        {
            get { return taluka_name_eng; }
            set { taluka_name_eng = value; }
        }
        private bool is_city;

        public bool Is_city
        {
            get { return is_city; }
            set { is_city = value; }
        }
        private bool is_locked;

        public bool Is_locked
        {
            get { return is_locked; }
            set { is_locked = value; }
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
        private int subdivision_id;

        public int Subdivision_id
        {
            get { return subdivision_id; }
            set { subdivision_id = value; }
        }
    }
}
