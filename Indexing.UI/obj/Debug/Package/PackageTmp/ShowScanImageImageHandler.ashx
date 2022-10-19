<%@ WebHandler Language="C#" Class="ShowScanImageImageHandler" %>

using System;
using System.Web;
using System.Text;
using System.Collections.Generic;
using System.IO;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D;
using System.Drawing.Printing;

//using System;
//using System.Data;
//using System.Configuration;
//using System.Web;
//using System.Web.Security;
//using System.Web.UI;
//using System.Web.UI.WebControls;
//using System.Web.UI.WebControls.WebParts;
//using System.Web.UI.HtmlControls;
//using iTextSharp.text;
//using iTextSharp.text.pdf;
//using iTextSharp.text.html;
//using System.Collections;
//using System.Net;

public class ShowScanImageImageHandler : IHttpHandler
{
    byte[] empPic = null;
    long seq = 0;

    public void ProcessRequest(HttpContext context)
    {
        string Id = context.Request.QueryString["ImageID"];
        Guid? IdImage = Guid.Parse(Id);
        System.Data.SqlClient.SqlConnection sqlConnection = new System.Data.SqlClient.SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["IndexingPortal"].ConnectionString);

        // Image WaterMark Code 2....... START

        //string Filepath = context.Request["Filename"];
        //string ImgHeight = context.Request["Height"];
        //string ImgWidth = context.Request["Width"];

        //CreateJpegThumb(Filepath, ImgHeight, ImgWidth);

        // Image WaterMark Code 2....... END

        System.Data.SqlClient.SqlCommand command = new System.Data.SqlClient.SqlCommand("[transactions].[proc_GetScanImageByImageId]", sqlConnection);
        command.CommandType = System.Data.CommandType.StoredProcedure;
        command.Parameters.AddWithValue("@IdImage", IdImage);
        sqlConnection.Open();
        SqlDataReader dr = command.ExecuteReader();
        if (dr.HasRows)
        {
            dr.Read();
            byte[] volunteerProfilePicture = (byte[])dr["image_file"];

            //// Convert Byte[] to Bitmap
            //Bitmap newBmp = ConvertToBitmap(volunteerProfilePicture);
            //// Watermark Text to be added to image
            //string text = "Board Of Revenue Sindh Gov.";
            ////string text = "";
            //if (newBmp != null)
            //{
            //    Bitmap convBmp = AddTextToImage(newBmp, text);

            //    //convBmp.Save(context.Response.OutputStream, ImageFormat.Jpeg);
            //    convBmp.Dispose();
            //}
            //newBmp.Dispose();

            //using (Bitmap image = new Bitmap(context.Server.MapPath("watermark_final.jpg")))
            //{
            //    using (MemoryStream ms = new MemoryStream())
            //    {
            //        image.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
            //        ms.WriteTo(context.Response.OutputStream);
            //    }
            //}

            context.Response.ContentType = "images/pdf";
            context.Response.ClearContent();
            context.Response.BinaryWrite(volunteerProfilePicture);
            context.Response.End();

            //HttpContext.Current.Response.Clear();
            //HttpContext.Current.Response.Write(volunteerProfilePicture);

            //HttpContext.Current.Response.Write("<script>window.print();</script>");
            //System.Drawing.Printing.PrinterSettings pd = new PrinterSettings();
            //pd.DefaultPageSettings.Landscape = true;
            //HttpContext.Current.Response.End();
            
      
        }
        dr.Close();
        sqlConnection.Close();
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }


}