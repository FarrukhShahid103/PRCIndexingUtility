using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Indexing.EL
{
    public class eRoles
    {
        private Guid role_id;

        public Guid Role_id
        {
            get { return role_id; }
            set { role_id = value; }
        }
        private string role_name;

        public string Role_name
        {
            get { return role_name; }
            set { role_name = value; }
        }
        private string description_eng;

        public string Description_eng
        {
            get { return description_eng; }
            set { description_eng = value; }
        }
        private string role_type;

        public string Role_type
        {
            get { return role_type; }
            set { role_type = value; }
        }
    }
}
