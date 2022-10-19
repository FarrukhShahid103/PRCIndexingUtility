using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Indexing.EL
{
    public class ValidateFields
    {
        public static int GetSafeInteger(Object value)
        {
            int returnValue;

            if ((value == DBNull.Value) || (value == null) || (value.ToString() == String.Empty))
            {
                returnValue = 0;
            }
            else
            {
                try
                {
                    returnValue = System.Convert.ToInt32(value);
                }
                catch
                {
                    returnValue = 0;
                }
            }

            return returnValue;
        }

        public static byte[] GetSafeByte(Object value)
        {
            byte[] returnValue;

            if ((value == DBNull.Value) || (value == null) || (value.ToString() == String.Empty))
            {
                returnValue = null;
            }
            else
            {
                try
                {
                    returnValue = (byte[])value;
                }
                catch
                {
                    returnValue = null;
                }
            }

            return returnValue;
        }

        public static string GetSafeString(Object value)
        {
            string returnValue;

            if ((value == DBNull.Value) || (value == null) || (value.ToString() == string.Empty))
            {
                returnValue = "";
            }
            else
            {
                try
                {
                    returnValue = value.ToString().Trim();
                }
                catch
                {
                    returnValue = "";
                }

            }

            return returnValue;
        }

        public static long GetSafeLong(Object value)
        {
            long returnValue;

            if ((value == DBNull.Value) || (value == null) || (value.ToString() == String.Empty))
            {
                returnValue = 0;
            }
            else
            {
                try
                {
                    returnValue = System.Convert.ToInt64(value);
                }
                catch
                {
                    returnValue = 0;
                }
            }

            return returnValue;
        }

        public static DateTime GetSafeDateTime(Object value)
        {
            DateTime returnValue;

            if ((value == DBNull.Value) || (value == null)) //''OrElse (value Is String.Empty) Then
            {
                returnValue = DateTime.MinValue;
            }
            else
            {
                try
                {
                    returnValue = System.Convert.ToDateTime(value);
                }
                catch
                {
                    returnValue = DateTime.MinValue;
                }
            }
            return returnValue;
        }

        public static Guid GetSafeGuid(Object value)
        {
            Guid returnValue;

            if ((value == DBNull.Value) || (value == null) || (value.ToString() == Guid.Empty.ToString()))
            {
                returnValue = Guid.Empty;
            }
            else
            {
                try
                {
                    returnValue = new Guid(value.ToString());
                }
                catch
                {
                    returnValue = Guid.Empty;
                }
            }

            return returnValue;
        }

        public static Int64 GetSafeInt64(Object value)
        {
            Int64 returnValue;

            if ((value == DBNull.Value) || (value == null) || (value.ToString() == Guid.Empty.ToString()) || (value == string.Empty))
            {
                returnValue = 0;
            }
            else
            {
                try
                {
                    returnValue = Convert.ToInt64(value.ToString());
                }
                catch
                {
                    returnValue = 0;
                }
            }

            return returnValue;
        }


        public static bool GetSafeBoolean(Object value)
        {
            bool returnValue;

            if ((value == DBNull.Value) || (value == null) || (value.ToString() == string.Empty))
            {
                returnValue = false;
            }
            else
            {
                try
                {
                    returnValue = System.Convert.ToBoolean(value);
                }
                catch
                {
                    returnValue = false;
                }
            }

            return returnValue;
        }

    }
}
