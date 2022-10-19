using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Indexing.EL;
using System.Text;
using System.Globalization;

public class General
{
    public static string TokenizeRolesList(List<eRoles> rolesList)
    {
        StringBuilder tokens = new StringBuilder("|");
        if (rolesList != null && rolesList.Count > 0)
        {
            foreach (eRoles role in rolesList)
            {
                if (!String.IsNullOrEmpty(role.Role_id.ToString()))
                {
                    tokens.Append(role.Role_id.ToString() + "|");
                }
            }
        }

        string strTokens = tokens.ToString()
            .TrimStart(new char[] { '|' })
            .TrimEnd(new char[] { '|' });

        return strTokens;
    }

    public static string CombineLoginUserTokens(Guid? userId, string userName, string displayName)
    {
        if (String.IsNullOrEmpty(userName) || (userId == null))
            return null;
        else
        {
            DateTime today = DateTime.Now;
            CultureInfo c = new CultureInfo("en-US");
            string strDate = today.ToString("dd-MMM-yyyy hh:mm tt", c.DateTimeFormat);
            return userId.Value.ToString() + "|" + userName + "|" + displayName + "|" + strDate;
        }
    }

}
