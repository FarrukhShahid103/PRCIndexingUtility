using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Indexing.EL
{
    public class eScanImages
    {
        private Guid image_id;
        public Guid Image_id
        {
            get { return image_id; }
            set { image_id = value; }
        }

        private byte[] image_file;
        public byte[] Image_file
        {
            get { return image_file; }
            set { image_file = value; }
        }

        private DateTime access_date_time;
        public DateTime Access_date_time
        {
            get { return access_date_time; }
            set { access_date_time = value; }
        }

        private Guid user_id;
        public Guid User_id
        {
            get { return user_id; }
            set { user_id = value; }
        }

    }
}
