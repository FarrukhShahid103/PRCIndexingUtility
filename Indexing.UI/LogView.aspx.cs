using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using Indexing.EL;
using Indexing.BLL;

namespace Indexing.UI
{
    public partial class LogView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod()]
        public static List<eUsersLog> bindLogViewRecord(string userName, string operationId, string dateFrom, string dateTo)
        {
            eUsersLog oeUsersLog = new eUsersLog();
            List<eUsersLog> oeListUsersLog = new List<eUsersLog>();
            oeUsersLog.User_name = userName;
            oeUsersLog.Operation_id = ValidateFields.GetSafeInteger(operationId);
            //if (date != string.Empty)
            oeUsersLog.Log_dateFrom = dateFrom;
            oeUsersLog.Log_dateTo = dateTo;
            //else
            //oeUsersLog.Log_datetime = null;
            oeListUsersLog = bUsersLog.GetUsersLog(oeUsersLog);
            return oeListUsersLog;
        }

        [WebMethod()]
        public static List<eUser> LoadUsers()
        {
            eUser oeUser = new eUser();
            List<eUser> oeListUser = new List<eUser>();
            oeListUser = bUser.GetUser(oeUser);
            return oeListUser;
        }
    }
}