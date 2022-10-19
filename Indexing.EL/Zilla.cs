using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Indexing.EL
{
    public class Zilla
    {
        private Guid zilla_id;
        private string zilla_name_eng;
        private int province_id;
        private bool is_locked;
        private Guid user_id;
        private DateTime access_date_time;
        private int division_id;
        private Taluka talukaInfo;

        public Taluka TalukaInfo
        {
            get { return talukaInfo; }
            set { talukaInfo = value; }
        }

        public Guid Zilla_id
        {
            get { return zilla_id; }
            set { zilla_id = value; }
        }

        public string Zilla_name_eng
        {
            get { return zilla_name_eng; }
            set { zilla_name_eng = value; }
        }

        public int Province_id
        {
            get { return province_id; }
            set { province_id = value; }
        }

        public bool Is_locked
        {
            get { return is_locked; }
            set { is_locked = value; }
        }

        public Guid User_id
        {
            get { return user_id; }
            set { user_id = value; }
        }

        public DateTime Access_date_time
        {
            get { return access_date_time; }
            set { access_date_time = value; }
        }

        public int Division_id
        {
            get { return division_id; }
            set { division_id = value; }
        }

        public Zilla()
        {
            this.talukaInfo = new Taluka();
        }

    }
}
