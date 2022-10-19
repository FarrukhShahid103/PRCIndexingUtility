using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class ShowScanImage : System.Web.UI.Page
{
    public Guid? IdImage
    {
        get
        {
            return (ViewState["IdImage"] == null) ? null : ((Guid?)Guid.Parse(ViewState["IdImage"].ToString()));
        }
        set
        {
            ViewState["IdImage"] = value;
        }
    }
    public String FormName
    {
        get
        {
            return (ViewState["FormName"] == null) ? null : Convert.ToString(ViewState["FormName"].ToString());
        }
        set
        {
            ViewState["FormName"] = value;
        }
    }

    public string ViewType;

    protected void Page_Load(object sender, EventArgs e)
    {
        //hidViewType.Value = Request.QueryString["ViewType"];
        //if (!Page.IsPostBack)
        //{
        //    FillGrid();
        //}
        //if (!Page.IsPostBack)
        //{
        //    if (Request["FormName"] != null && Request["IdImage"] != null)
        //    {
        //        if (Request["IsUpdate"] != null)
        //        {
        //            int IsUpdate = int.Parse(Request["IsUpdate"]);
        //            if (IsUpdate == 1)
        //            {
        //                ShowScanImageControl1.Visible = false;
        //               // UpdateScanImageControl1.FormName = Convert.ToString(Request["FormName"]);
        //                //UpdateScanImageControl1.IdImage = Guid.Parse(Request["IdImage"]);
        //            }
        //            else
        //            {
        //                ShowScanImageControl1.Visible = false;
        //               // UpdateScanImageControl1.Visible = false;
        //            }
        //        }
        //        else
        //        {
        //           // UpdateScanImageControl1.Visible = false;
        //            ShowScanImageControl1.FormName = Convert.ToString(Request["FormName"]);
        //            ShowScanImageControl1.IdImage = Guid.Parse(Request["IdImage"]);
        //        }
        //    }
        //}
    }
    private void FillGrid()
    {
        try
        {

            //General gen = new General();
            ////string IdImage = string.Empty;
            //DataTable dt = gen.GetScanImage(Convert.ToString(IdImage));
            ////DataTable dt = gen.GetSearchedRecord(obj, param);
            //grdScanImage.DataSource = dt;
            //grdScanImage.DataBind();

        }
        catch (Exception ex)
        {
            //  EntityUpdateInfo _Error = LogException.AddMessage("ScanImage", Resources.LRMIS.FailToLoad, Page.Request.UserHostName, Guid.Parse(Util.LoginUserId).ToString(), ex, System.DateTime.Now);
            ////  ((IMainMaster)this.Page.Master).SetStatusMessage(Resources.LRMIS.FailToLoad, StatusMessageType.ERROR, _Error.Id.ToString());
            //  ScriptManager.RegisterStartupScript(this, this.GetType(), "ClosePopup", "window.parent.RefreshShowScanImage(4);", true);
        }
        //Util.MakeAccessible(grdScanImage, false);
    }

    protected void grdScanImage_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            Label lblNoImage = e.Row.FindControl("lblNoImage") as Label;
            if (lblNoImage != null)
            {
                // lblNoImage.Text = LanguageManager.GetStringResource("NoImage", "");
            }
            
            //ImagebtnRotateRight.Visible = false;
            //ImagebtnRotateLeft.Visible = false;
            //ImagebtnZoomIn.Visible = false;
            //ImagebtnZoomOut.Visible = false;
        }
    }


}