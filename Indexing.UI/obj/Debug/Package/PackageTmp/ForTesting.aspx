<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForTesting.aspx.cs" Inherits="Indexing.UI.ForTesting" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="script/jquery-1.4.0.min.js" type="text/javascript"></script>
    <script src="script/jquery-ui-1.8.18.custom.min.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">
        function displayControl() {
            $("#divLoadButton").slideToggle("slow");
            $("#divFiles").slideToggle("slow");
        }
    </script>
</head>
<body style="margin: 0 auto; width: 100%;">
    <form id="form1" runat="server">
    <ajax:ToolkitScriptManager EnablePartialRendering="true" runat="Server" ID="ScriptManager" />
    <div style="padding-left: 50px; padding-right: 50px; width: 100%;">
        <div style="width: 100%;">
            <div style="float: left; width: 25%;">
            </div>
        </div>
        <div style="clear: both; width: 100%; height: 75px; background-color: #DEDEDE;">
            <div id="divLoadButton" style="width: 100%; float: left; background-color: #EDEDED;">
                <div style="width: 100%; clear: both; padding: 20px 0px 20px 10px;">
                    <a href="javascript:void(0);" onclick="displayControl()">Load Files</a>
                </div>
            </div>
            <div id="divFiles" style="float: left; display: none; width: 100%;">
                <div style="float: left; width: 100%; padding: 15px 0px 0px 10px;">
                    <div style="float: left; width: 10%;">
                        <asp:Label ID="lblScanningDate" runat="server" Text="Scanning Date"></asp:Label>
                    </div>
                    <div style="float: left; width: 20%;">
                        <asp:TextBox ID="txtScanningDate" runat="server"></asp:TextBox>
                    </div>
                    <div style="float: left; width: 10%;">
                        <asp:Label ID="lblEntryDate" runat="server" Text="Entry Date"></asp:Label>
                    </div>
                    <div style="float: left; width: 20%;">
                        <asp:TextBox ID="txtEntryDate" runat="server"></asp:TextBox><input type="button" id="btnCalander" value="Cal" />
                        <ajax:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtEntryDate"  Mask="99-99-9999" MessageValidatorTip="true" MaskType="Date"
                                ErrorTooltipEnabled="True"/>
                        <ajax:CalendarExtender ID="cxCal" runat="server" TargetControlID="txtEntryDate" Format="dd-MM-yyyy" PopupButtonID="btnCalander" ></ajax:CalendarExtender>
                    </div>
                    <div style="float: left; width: 15%;">
                        <asp:Button ID="btnLoad" runat="server" Text="Load" OnClientClick="displayControl(); return false;" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
