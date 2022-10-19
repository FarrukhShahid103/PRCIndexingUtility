using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Indexing.EL
{
    public class Division
    {
        private Guid division_id;

        public Guid Division_id
        {
            get { return division_id; }
            set { division_id = value; }
        }
        private string division_desc_eng;

        public string Division_desc_eng
        {
            get { return division_desc_eng; }
            set { division_desc_eng = value; }
        }
        private string division_desc_sin;

        public string Division_desc_sin
        {
            get { return division_desc_sin; }
            set { division_desc_sin = value; }
        }
        private string division_desc_urd;

        public string Division_desc_urd
        {
            get { return division_desc_urd; }
            set { division_desc_urd = value; }
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
