<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="multipleFile.aspx.cs" Inherits="Indexing.UI.multipleFile" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Import Namespace="System.IO" %>
<script type="text/c#" runat="server">
    protected void BtnUpload_Click(object sender, EventArgs e)
    {
        if (Request.Files != null)
        {
            foreach (string file in Request.Files)
            {
                var uploadedFile = Request.Files[file];
                if (uploadedFile.ContentLength > 0)
                {
                    var appData = Server.MapPath("~/app_data");
                    var fileName = Path.GetFileName(uploadedFile.FileName);
                    uploadedFile.SaveAs(Path.Combine(appData, fileName));
                }
            }
        }
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <%--<form id="Form1" runat="server" enctype="multipart/form-data">
        <a href="#" id="add">Add file</a>
        <div id="files"></div>
        <asp:LinkButton ID="BtnUpload" runat="server" Text="Upload" OnClick="BtnUpload_Click" />
    </form>
    <script src="script/jquery-1.9.1.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $('#add').click(function () {
            $('#files').append($('<input/>', {
                type: 'file',
                name: 'file' + new Date().getTime()
            }));
            return false;
        });
    </script>--%>


</body>
</html>
