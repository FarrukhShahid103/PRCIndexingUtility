<%@ Page Title="" Language="C#" MasterPageFile="~/PRC_Master.Master" AutoEventWireup="true" CodeBehind="LogView.aspx.cs" Inherits="Indexing.UI.LogView" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<script language="javascript" type="text/javascript">
    $(document).ready(function () {
        loadUsers();
    });

    function loadUsers() {
        var ddlUserName = $("select[id$='_ddlUserName']");
        if (ddlUserName.length > 0) {
            $.ajax({
                type: "POST",
                url: "LogView.aspx/LoadUsers",
                data: '',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    if (result.d != null) {
                        if (result.d.length > 0) {
                            var choose = document.createElement("option");
                            choose.text = "<-- SELECT -->";
                            choose.value = "0";
                            ddlUserName[0].options.add(choose);
                            for (var i = 0; i < result.d.length; i++) {
                                var opt = document.createElement("option");
                                opt.text = result.d[i].User_name;
                                opt.value = result.d[i].User_id;
                                ddlUserName[0].options.add(opt);
                            }
                            //$("#divEntryForm").fadeOut("faste");
                        }
                    }
                },
                error: function () {
                    MessegeArea("An error has occurred during loadUsers processing.", "error");
                }
            });
        }
    }


    function bindLogViewRecord() {
        var ddlUserName = $("select[id$='_ddlUserName']");
        var ddlUsernameText = $("[id*='_ddlUserName'] :selected").text();
        var ddlOperation = $("select[id$='_ddlOperation']");
        var txtDateFrom = $("input[id$='_txtDateFrom']");
        var txtDateTo = $("input[id$='_txtDateTo']");

        var userNameId = ""
        if (ddlUserName.length > 0) {
            userNameId = ddlUserName.val();
        }

        if (userNameId == "0") {
            ddlUsernameText = "";
        }

        var operationId = "";
        if (ddlOperation.length > 0) {
            operationId = ddlOperation.val();
        }
        var dateFrom = "";
        if (txtDateFrom.length > 0) {
            dateFrom = txtDateFrom.val();
        }
        var filter = /(?!3[2-9]|00|02-3[01]|04-31|06-31|09-31|11-31)[0-3][0-9]-(?!1[3-9]|00)[01][0-9]-(?!10|28|29)[12][089][0-9][0-9]/;
        if (txtDateFrom.val() != "" && !filter.test(txtDateFrom.val())) {
            txtDateFrom.removeClass("textBoxLogDate").addClass("textBoxLogDateError");
            txtDateFrom.focus();
            MessegeArea("Please enter correct date scanning date format e.g dd-MM-yyyy", "error");
            return true;
        }
        else {
            txtDateFrom.removeClass("textBoxLogDateError").addClass("textBoxLogDate");
        }

        var dateTo = "";
        if (txtDateTo.length > 0) {
            dateTo = txtDateTo.val();
        }
        var filter = /(?!3[2-9]|00|02-3[01]|04-31|06-31|09-31|11-31)[0-3][0-9]-(?!1[3-9]|00)[01][0-9]-(?!10|28|29)[12][089][0-9][0-9]/;
        if (txtDateTo.val() != "" && !filter.test(txtDateTo.val())) {
            txtDateTo.removeClass("textBoxLogDate").addClass("textBoxLogDateError");
            txtDateTo.focus();
            MessegeArea("Please enter correct date scanning date format e.g dd-MM-yyyy", "error");
            return true;
        }
        else {
            txtDateTo.removeClass("textBoxLogDateError").addClass("textBoxLogDate");
        }

        var lblTotalRows = $("span[id$='_lblTotalRows']");
        var totalRows = "";
        if (lblTotalRows.length > 0) {
            totalRows = 0;
        }

        var gvLogView = $("#gvLogView");
        $.ajax({
            async: false,
            type: "POST",
            url: "LogView.aspx/bindLogViewRecord",
            data: "{'userName': '" + ddlUsernameText + "', 'operationId': '" + operationId + "', 'dateFrom': '" + dateFrom + "', 'dateTo': '" + dateTo + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                if (result.d != null) {
                    gvLogView.html("");
                    lblTotalRows.val("");
                    if (result.d.length > 0) {
                        if (gvLogView.length > 0) {
                            gvLogView.append("<thead><tr>" +
                                                    "<th>User name</th>" +
                                                    "<th>Date</th>" +
                                                    "<th>Operation</th>" +
                                                    "<th>Scan Number</th>" +
                                                    "<th>IP Address</th>" +
                                                    "</tr>" +
                                                    "</thead>");
                            for (var i = 0; i < result.d.length; i++) {

                                if (result.d[i].Operation_id == 1) {
                                    gvLogView.append("<tr style='background-color:#EDF3EB;'>"
                                + "<td>" + result.d[i].User_name + "</td>"
                                + "<td>" + result.d[i].Log_datetime + "</td>"
                                + "<td>Add</td>"
                                + "<td>" + result.d[i].Scan_no + "</td>"
                                + "<td>" + result.d[i].Ipadress + "</td>"
                                + "</tr>");
                                }
                                else {
                                    gvLogView.append("<tr style='background-color:#CDE3E4;'>"
                                + "<td>" + result.d[i].User_name + "</td>"
                                + "<td>" + result.d[i].Log_datetime + "</td>"
                                + "<td>Update</td>"
                                + "<td>" + result.d[i].Scan_no + "</td>"
                                + "<td>" + result.d[i].Ipadress + "</td>"
                                + "</tr>");
                                }
                                totalRows++;
                            }
                        }
                        var options = {
                            currPage: 1,
                            optionsForRows: [10, 15, 20, 25, 30, 35, 40, 45, 50, 100, 150, 200],
                            rowsPerPage: 10,
                            firstArrow: (new Image()).src = "image/FirstIco.png",
                            prevArrow: (new Image()).src = "image/PreviousIco.png",
                            lastArrow: (new Image()).src = "image/LastIco.png",
                            nextArrow: (new Image()).src = "image/NextIco.png",
                            topNav: false
                        }
                        $('#gvLogView').tablePagination(options);
                    }
                    else {
                        gvLogView.append("<div style='width:100%; padding-left:7px;'>No record found</div>");
                    }
                    lblTotalRows.text("Total Record: " + totalRows);
                    $("#LogView").show();
                }
                return true;
            },
            error: function () {
                MessegeArea("An error has occurred during bindLogViewRecord processing.", "error");
            }
        });
        return true;
    }

    function resetFields() {
        $("select[id$='_ddlUserName']").val("0");
        $("select[id$='_ddlOperation']").val("0");
        $("input[id$='_txtDateFrom']").val("");
        $("input[id$='_txtDateTo']").val("");
    }

</script>


<div style="width:100%;">
    <div style="width:100%; clear:both;" id="divSearch">
        <div style="width:100%; float:left;">
            <div style="float:left; width:100%;">
                <div class="searchLeftCaption">
                    <asp:Label ID="lblUserName" runat="server" Text="User name:"></asp:Label>
                </div>
                <div class="SearchRightValueDivControl">
                    <asp:DropDownList ID="ddlUserName" runat="server" CssClass="LongWidthDropDownBG" ></asp:DropDownList>
                </div>
            </div>
            <div style="clear:both; width:100%;">
                <div class="searchLeftCaption">
                    <asp:Label ID="lblOperation" runat="server" Text="Operation:"></asp:Label>
                </div>
                <div class="SearchRightValueDivControl">
                    <asp:DropDownList ID="ddlOperation" runat="server" CssClass="LongWidthDropDownBG">
                        <asp:ListItem Value="0" Text="<-- SELECT -->"></asp:ListItem>
                        <asp:ListItem Value="1" Text="Add"></asp:ListItem>
                        <asp:ListItem Value="2" Text="Update"></asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div style="clear:both; width:100%; float:left; padding-top:5px;">
                <div class="searchLeftCaption">
                    <asp:Label ID="lblDate" runat="server" Text="From Date:"></asp:Label>
                </div>
                <div style="float:left;">
                    <asp:TextBox ID="txtDateFrom" runat="server" CssClass="textBoxLogDate" placeholder="dd-MM-yyyy"></asp:TextBox>
                    <div style="float:right; padding:3px 5px 0px 5px;"><img src="image/calendar-icon.png" alt="" id="imgDateFrom" style="cursor:pointer;" /></div>
                        <ajax:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtDateFrom" Format="dd-MM-yyyy" CssClass="calendarCss" PopupButtonID="imgDateFrom" ></ajax:CalendarExtender>
                </div>
                <div style="float:left; padding:10px 6px 0 3px; width:50px;">
                    <asp:Label ID="lblDateTo" runat="server" Text="To Date:"></asp:Label>
                </div>
                <div style="float:left;">
                    <asp:TextBox ID="txtDateTo" runat="server" CssClass="textBoxLogDate" placeholder="dd-MM-yyyy"></asp:TextBox>
                    <div style="float:right; padding:3px 0px 0px 5px;"><img src="image/calendar-icon.png" alt="" id="imgDateTo" style="cursor:pointer;" /></div>
                        <ajax:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtDateTo" Format="dd-MM-yyyy" CssClass="calendarCss" PopupButtonID="imgDateTo" ></ajax:CalendarExtender>
                </div>
            </div>
            <%--<div style="clear:both; width:100%;">
                <div class="searchLeftCaption">
                    <asp:Label ID="lblDate" runat="server" Text="Operation:"></asp:Label>
                </div>
                <div style="float:left; padding:4px 0px; width:335px;">
                     <asp:TextBox ID="txtDate" runat="server" CssClass="textBoxBG" Width="275px" placeholder="dd-MM-yyyy" ></asp:TextBox>
                        <div style="float:right; padding-right:10px;"><img src="image/calendar-icon.png" alt="" id="scanCal" style="cursor:pointer;" /></div>
                        <ajax:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtDate" Format="dd-MM-yyyy" CssClass="calendarCss" PopupButtonID="scanCal" ></ajax:CalendarExtender>
                </div>
            </div>--%>
            <div style="clear:both; width:100%;">
                <div style="float:left; width:225px; padding-left:155px; padding-top:15px;">
                    <asp:Button ID="btnLoad" runat="server" Text="Search" CssClass="LoginButton" OnClientClick="if(bindLogViewRecord()) return false;" />&nbsp; <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="LoginButton" OnClientClick="javascript:resetFields(); return false;" />
                </div>
            </div>
        </div>
        <div style="clear:both; float:left; width:100%; padding-top:20px; ">
            <div style="float:left; padding:5px 0px 5px 0px; width:99%;">
                <div id="LogView" style="width:100%; padding:7px 0px 7px 10px; box-shadow:0 0 18px #70B2CD inset; display:none;">Log View Record
                    <div style="float:right; padding-right:10px;"><asp:Label ID="lblTotalRows" runat="server" Text=""></asp:Label></div>
                </div>
            </div>
            <div style="width:100%; clear:both;">
                <table id="gvLogView" >
                </table>
            </div>
        </div>
    </div>
</div>
</asp:Content>
