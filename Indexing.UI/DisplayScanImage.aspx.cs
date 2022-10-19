using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Indexing.EL;
using Indexing.BLL;

namespace Indexing.UI
{
    public partial class DisplayScanImage : System.Web.UI.Page
    {
        public string ViewType;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["viewType"] != null)
            {
                hidViewType.Value = Request.QueryString["viewType"];
            }
            if (Request.QueryString["idImage"] != null)
            {
                hidImageId.Value = Request.QueryString["idImage"];
            }


            if (!Page.IsPostBack)
            {
                FillGrid();
            }
        }

        private void FillGrid()
        {
            try
            {
                eScanImages oeScanImages = new eScanImages();
                List<eScanImages> oeListScanImages = new List<eScanImages>();
                Guid image_id = Guid.Empty;
                if (hidImageId.Value != string.Empty)
                {
                    image_id = ValidateFields.GetSafeGuid(hidImageId.Value);
                }
                oeScanImages.Image_id = image_id;
                //string IdImage = string.Empty;
                oeListScanImages = bScanImages.GetScanImages(oeScanImages);
                //DataTable dt = gen.GetScanImage(Convert.ToString(IdImage));
                //DataTable dt = gen.GetSearchedRecord(obj, param);
                if (oeListScanImages != null && oeListScanImages.Count > 0)
                {
                    grdScanImage.DataSource = oeListScanImages;
                    grdScanImage.DataBind();
                }

            }
            catch (Exception ex)
            {
                //  EntityUpdateInfo _Error = LogException.AddMessage("ScanImage", Resources.LRMIS.FailToLoad, Page.Request.UserHostName, Guid.Parse(Util.LoginUserId).ToString(), ex, System.DateTime.Now);
                ////  ((IMainMaster)this.Page.Master).SetStatusMessage(Resources.LRMIS.FailToLoad, StatusMessageType.ERROR, _Error.Id.ToString());
                //  ScriptManager.RegisterStartupScript(this, this.GetType(), "ClosePopup", "window.parent.RefreshShowScanImage(4);", true);
            }
            //Util.MakeAccessible(grdScanImage, false);
        }

    }
}