<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DisplayScanImage.aspx.cs" Inherits="Indexing.UI.DisplayScanImage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script language="javascript" type="text/javascript">
        function PrintGridData() {
            var prtGrid = document.getElementById('<%=grdScanImage.ClientID %>');
            //        var rowElement = prtGrids.rows[0];
            //        var Image = rowElement.cells[0].firstChild;
            //        prtGrid = Image;
            prtGrid.border = 0;
            var prtwin = window.open('', 'grdScanImage', 'left=100,top=100,width=1000,height=1000,tollbar=0,scrollbars=0,status=0,resizable=0');
            //        var prtwin = window.open('', 'PrintGridViewData', 'left=100,top=100,width=2392,height=3534,tollbar=0,scrollbars=0,status=0,resizable=1');
            prtwin.document.write(prtGrid.innerHTML);
            prtwin.document.close();
            prtwin.focus();
            prtwin.print();

            prtwin.close();
        }

        window.onload = function () {
            var ViewType = document.getElementById('<%=hidViewType.ClientID %>').value;

            if (ViewType != null) {
                if (ViewType == 'print') {
                    PrintGridData();
                    window.close();
                }
            }
        }


        var zoomfactor = 0.06;
        function zoomImage() {
            if (parseInt(cache.style.width) > 8 && parseInt(cache.style.height) > 8) {

                var width = parseInt(cache.style.width) + parseInt(cache.style.width) * zoomfactor * prefix
                var height = parseInt(cache.style.height) + parseInt(cache.style.height) * zoomfactor * prefix
                cache.style.width = width + "px";
                cache.style.height = height + "px";
            }
        }
        function zoom(originalWidth, originalHeight, state) {
            var img = $("img[id$='_imgVForm']");
            if (img.length > 0) {
                cache = eval("document.images." + img[0].id)
                prefix = (state == "in") ? 1 : -1
                if (cache.style.width == "" || state == "restore") {
                    cache.style.width = originalWidth + "px"
                    cache.style.height = originalHeight + "px"
                    //if (state=="restore")
                    //return
                    //zoomImage()
                }
                else {
                    zoomImage()
                }
            }
            else {
                img = $(".rvml");
                cache = img[0];
                prefix = (state == "in") ? 1 : -1
                if (cache.style.width == "" || state == "restore") {
                    cache.style.width = originalWidth + "px"
                    cache.style.height = originalHeight + "px"
                    //if (state=="restore")
                    //return
                    //zoomImage()
                }
                else {
                    zoomImage()
                }
            }
            //beginzoom=setInterval("zoomImage()",100)
        }
        function stopZoom() {
            if (window.beginzoom)
                clearInterval(beginzoom)
        }
        function RotateRight() {
            var Image1 = $("img[id$='_imgVForm']");

            if (Image1.length > 0) {
                var angle = 0;
                if ($(Image1).getRotateAngle() == '') {
                    angle = parseInt(90);
                }
                else {
                    angle = parseInt($(Image1).getRotateAngle()) + parseInt(90);
                }
                $(Image1).rotate(angle);
                $(Image1).css("position", "");
            }
        }
        function RotateLeft() {
            var Image1 = $("img[id$='_imgVForm']");
            if (Image1.length > 0) {
                var angle = 0;
                if ($(Image1).getRotateAngle() == '') {
                    angle = parseInt(-90);
                }
                else {
                    angle = parseInt($(Image1).getRotateAngle()) - parseInt(90);
                }
                $(Image1).rotate(angle);
                $(Image1).css("position", "");
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ImageButton ID="ImagebtnZoomIn" ImageUrl="~/Image/zoom_in.png" runat="server"
            Visible="false" OnClientClick="zoom(650,550,'in'); return false;" />
        <asp:ImageButton ID="ImagebtnZoomOut" ImageUrl="~/Image/zoom_out.png" runat="server"
            Visible="false" />
        <asp:GridView ID="grdScanImage" runat="server" AutoGenerateColumns="False" CssClass="MainGridViewStyle"
            CellPadding="4" GridLines="Both" AllowPaging="True" ShowHeader="false" ShowFooter="false"
            Height="100%" Width="100%" PageSize="1">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <div id="divImageContainer" style="width: 100%; height: 100%; overflow: auto; background-color: Gray;
                            vertical-align: middle;" align="center">
                            <asp:Image ID="imgVForm" CssClass="Pointer" Width="100%" Height="100%" runat="server"
                                BorderColor="Black" BorderWidth="1" ImageUrl='<%# "~/ShowScanImageImageHandler.ashx?ImageID=" +  Eval("Image_id") %>' />
                        </div>
                    </ItemTemplate>
                    <ItemStyle CssClass="Width20 DynamicCellAlign" />
                </asp:TemplateField>
            </Columns>
            <PagerSettings Position="TopAndBottom" />
            <EmptyDataTemplate>
                <asp:Label ID="lblNoImage" runat="server" Text="No Image Found"></asp:Label>
            </EmptyDataTemplate>
        </asp:GridView>
        <asp:HiddenField ID="hidViewType" runat="server" />
        <asp:HiddenField ID="hidImageId" runat="server" />
    </form>
</body>
</html>
