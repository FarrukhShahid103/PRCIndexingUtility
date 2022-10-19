using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using Indexing.EL;
using Indexing.BLL;

namespace Indexing.UI
{
    public partial class PDFViewer : System.Web.UI.Page
    {
        public static string filePath = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["filePath"] != null && Request.QueryString["filePath"].ToString() != string.Empty)
            {
                string path = Request.QueryString["filePath"].ToString();
                WebClient client = new WebClient();
                //Byte[] buffer = client.DownloadData(filePath);
                Byte[] buffer = client.DownloadData(path);

                if (buffer != null)
                {
                    Response.ContentType = "application/pdf";
                    Response.AddHeader("content-length", buffer.Length.ToString());
                    Response.BinaryWrite(buffer);
                }
            }
            if (Request.QueryString["imageId"] != null && Request.QueryString["imageId"] != string.Empty)
            {
                Guid imageId = ValidateFields.GetSafeGuid(Request.QueryString["imageId"]);
                eScanImages oeScanImages = new eScanImages();
                oeScanImages.Image_id = imageId;
                List<eScanImages> oeListScanImages = new List<eScanImages>();
                oeListScanImages = bScanImages.GetScanImages(oeScanImages);
                if (oeListScanImages != null && oeListScanImages.Count > 0)
                {
                    Byte[] buffer = oeListScanImages[0].Image_file;
                    if (buffer != null)
                    {
                        Response.ContentType = "application/pdf";
                        Response.AddHeader("content-length", buffer.Length.ToString());
                        Response.BinaryWrite(buffer);
                    }
                }
            }
            //Response.Redirect(filePath);
        }
    }
}