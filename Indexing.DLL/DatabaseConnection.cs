using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace Indexing.DLL
{
    public abstract class DatabaseConnection
    {
        private static string sConStr = "IndexingPortal";
        //private string sConStr;
        private static Database db;

        protected static Database Db
        {
            get
            {
                if (db == null)
                {
                    db = DatabaseFactory.CreateDatabase(sConStr);
                }
                return db;
            }
        }

        public abstract void InitializeAccessors();

        public DatabaseConnection()
        {

        }

        public DatabaseConnection(string dbString)
        {
            sConStr = dbString;
        }

        public Database GetDatabase()
        {
            try
            {
                db = null;
                return db = DatabaseFactory.CreateDatabase(sConStr);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}
