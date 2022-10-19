using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Indexing.EL
{
    public class Deh
    {
        private Guid deh_id;

        public Guid Deh_id
        {
            get { return deh_id; }
            set { deh_id = value; }
        }
        private Guid taluka_id;

        public Guid Taluka_id
        {
            get { return taluka_id; }
            set { taluka_id = value; }
        }
        private string deh_name_eng;

        public string Deh_name_eng
        {
            get { return deh_name_eng; }
            set { deh_name_eng = value; }
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
    }
}
