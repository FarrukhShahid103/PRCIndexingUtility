<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="Indexing.UI.Search" MasterPageFile="~/PRC_Master.Master" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <script src="script/jPrint.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
//    $(function () {
//        // Hook up the print link.
//        $("a").attr("href", "javascript:void( 0 )").click(function () {
//            // Print the DIV.
//            $("#gvSearchRecord").print();
//            // Cancel click event.
//            return (false);
//        });
//    });

//    $("a").attr("href", "javascript:void(0)").click(function () {
//        var divContents = $("#gvSearchRecord").html();
//        var printWindow = window.open('', '', 'height=400,width=800');
//        printWindow.document.write('<html><head><title>DIV Contents</title>');
//        printWindow.document.write('</head><body >');
//        printWindow.document.write(divContents);
//        printWindow.document.write('</body></html>');
//        printWindow.document.close();
//        printWindow.print();
//    });

    function fillZilla() {
        var ddlZilla = $("select[id$='_ddlZilla']");
        if (ddlZilla.length > 0) {
            $.ajax({
                type: "POST",
                url: "Search.aspx/getZillaForDropDown",
                data: '',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    if (result.d != null) {
                        if (result.d.length > 0) {
                            var choose = document.createElement("option");
                            choose.text = "<-- SELECT -->";
                            choose.value = "0";
                            ddlZilla[0].options.add(choose);
                            for (var i = 0; i < result.d.length; i++) {
                                var opt = document.createElement("option");
                                opt.text = result.d[i].Zilla_name_eng;
                                opt.value = result.d[i].Zilla_id;
                                ddlZilla[0].options.add(opt);
                            }
                            $("#divEntryForm").fadeOut("faste");
                        }
                    }
                },
                error: function () {
                    MessegeArea("An error has occurred during fillZilla processing.", "error");
                }
            });
        }
    }

    function fillTaluka() {
        var ddlZilla = $("select[id$='_ddlZilla']");
        var ddlTaluka = $("select[id$='_ddlTaluka']");
        var ddlDeh = $("select[id$='_ddlDeh']");
        if (ddlDeh.length > 0) {
            ddlDeh.empty();
        }
        if (ddlZilla.length > 0) {
            ddlTaluka.empty();
            if (ddlTaluka.length > 0) {
                $.ajax({
                    type: "POST",
                    url: "Search.aspx/getTalukaForDropDown",
                    data: "{'zillaId':'" + ddlZilla.val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (result) {
                        if (result.d != null) {
                            if (result.d.length > 0) {
                                var choose = document.createElement("option");
                                choose.text = "<-- SELECT -->";
                                choose.value = "0";
                                ddlTaluka[0].options.add(choose);
                                for (var i = 0; i < result.d.length; i++) {
                                    var opt = document.createElement("option");
                                    opt.text = result.d[i].Taluka_name_eng;
                                    opt.value = result.d[i].Taluka_id;
                                    ddlTaluka[0].options.add(opt);
                                }
                            }
                        }
                    },
                    error: function () {
                        MessegeArea("An error has occurred during fillTaluka processing.", "error");
                    }
                });
            }
        }
    }

    function fillDeh() {
        var ddlTaluka = $("select[id$='_ddlTaluka']");
        var ddlDeh = $("select[id$='_ddlDeh']");
        if (ddlTaluka.length > 0) {
            if (ddlDeh.length > 0) {
                ddlDeh.empty();
                $.ajax({
                    type: "POST",
                    url: "Search.aspx/getDehForDropDown",
                    data: "{'talukaId':'" + ddlTaluka.val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (result) {
                        if (result.d != null) {
                            if (result.d.length > 0) {
                                var choose = document.createElement("option");
                                choose.text = "<-- SELECT -->";
                                choose.value = "0";
                                ddlDeh[0].options.add(choose);
                                for (var i = 0; i < result.d.length; i++) {
                                    var opt = document.createElement("option");
                                    opt.text = result.d[i].Deh_name_eng;
                                    opt.value = result.d[i].Deh_id;
                                    ddlDeh[0].options.add(opt);
                                }
                            }
                        }
                    },
                    error: function () {
                        MessegeArea("An error has occurred during fillDeh processing.", "error");
                    }
                });
            }
        }
    }

    function requiredFields(ddlZilla, ddlTaluka, ddlDeh) {
        var isValid = true;
        if (ddlZilla.val() == "" || ddlZilla.val() == "0") {
            ddlZilla.removeClass("DropDownBG").addClass("DropDownError");
            ddlZilla.focus();
            MessegeArea("Please select zilla", "error");
            isValid = false;
            return isValid;
        }
        else {
            ddlZilla.removeClass("DropDownError").addClass("DropDownBG");
        }
        if (ddlTaluka.val() == null || ddlTaluka.val() == "" || ddlTaluka.val() == "0") {
            ddlTaluka.removeClass("DropDownBG").addClass("DropDownError");
            ddlTaluka.focus();
            MessegeArea("Please select taluka", "error");
            isValid = false;
            return isValid;
        }
        else {
            ddlTaluka.removeClass("DropDownError").addClass("DropDownBG");
        }
        if (ddlDeh.val() == null || ddlDeh.val() == "" || ddlDeh.val() == "0") {
            ddlDeh.removeClass("DropDownBG").addClass("DropDownError");
            ddlDeh.focus();
            MessegeArea("Please select deh", "error");
            isValid = false;
            return isValid;
        }
        else {
            ddlDeh.removeClass("DropDownError").addClass("DropDownBG");
        }        
        return isValid;
    }

    $(document).ready(function () {
        fillZilla();
        ResetPageRecord();
        //getTotalRows();
        //resetTotalPages();
        //bindSearchRecord();
    });

    function bindSearchRecord(Search) {
        var ddlZilla = $("select[id$='_ddlZilla']");
        var ddlZillaText = $("[id*='ddlZilla'] :selected").text();
        var ddlTaluka = $("select[id$='_ddlTaluka']");
        var ddlTalukaText = $("[id*='ddlTaluka'] :selected").text();
        var ddlDeh = $("select[id$='_ddlDeh']");
        var ddlDehText = $("[id*='ddlDeh'] :selected").text();
        var ddlBookType = $("select[id$='_ddlBookType']");
        var ddlBookTypeText = $("[id*='ddlBookType'] :selected").text();
        var txtScheme = $("input[id$='_txtScheme']");
        var ddlSchemeLike = $("select[id$='_ddlSchemeLike']");
        var txtScanningNoFrom = $("input[id$='_txtScanningNoFrom']");
        var txtScanningNoTo = $("input[id$='_txtScanningNoTo']");
        var txtScanningDateFrom = $("input[id$='_txtScanningDateFrom']");
        var txtScanningDateTo = $("input[id$='_txtScanningDateTo']");
        var txtEntryNoFrom = $("input[id$='_txtEntryNoFrom']");
        var txtEntryNoTo = $("input[id$='_txtEntryNoTo']");
        var txtEntryDateFrom = $("input[id$='_txtEntryDateFrom']");
        var txtEntryDateTo = $("input[id$='_txtEntryDateTo']");
        var txtSurveyNoFrom = $("input[id$='_txtSurveyNoFrom']");
        var txtSurveyNoTo = $("input[id$='_txtSurveyNoTo']");
        var txtBookNoFrom = $("input[id$='_txtBookNoFrom']");
        var txtBookNoTo = $("input[id$='_txtBookNoTo']");
        var txtPageNoFrom = $("input[id$='_txtPageNoFrom']");
        var txtPageNoTo = $("input[id$='_txtPageNoTo']");
        var txtOwnerName = $("input[id$='_txtOwnerName']");
        var ddlOwnerNameLike = $("select[id$='_ddlOwnerNameLike']");
        var txtCNIC = $("input[id$='_txtCNIC']");
        var ddlSortedBy = $("select[id$='_ddlSortedBy']");
        var ddlAscDesc = $("select[id$='_ddlAscDesc']");

        var hfRoleId = $("input[id$='_hfRoleId']");
        var roleId = "";
        if (hfRoleId.length > 0) {
            roleId = hfRoleId.val();
        }
        //if (ddlZilla.val() != "" && ddlZilla.val() != "0" && ddlTaluka.val() != null && ddlTaluka.val() != "" && ddlTaluka.val() != "0" && ddlDeh.val() != null && ddlDeh.val() != "" && ddlDeh.val() != "0") {
            var zillaId = ""
            if (ddlZilla.length > 0) {
                zillaId = ddlZilla.val();
            }
            var talukaId = "";
            if (ddlTaluka.length > 0) {
                talukaId = ddlTaluka.val();
            }
            var dehId = "";
            if (ddlDeh.length > 0) {
                dehId = ddlDeh.val();
            }
            var bookTypeId = "";
            if (ddlBookType.length > 0) {
                bookTypeId = ddlBookType.val();
            }
            var scheme = "";
            if (txtScheme.length > 0) {
                scheme = txtScheme.val();
            }
            var schemeLike = "";
            if (ddlSchemeLike.length > 0) {
                schemeLike = ddlSchemeLike.val();
            }
            var scanningNoFrom = "";
            if (txtScanningNoFrom.length > 0) {
                scanningNoFrom = txtScanningNoFrom.val();
            }
            var scanningNoTo = "";
            if (txtScanningNoTo.length > 0) {
                scanningNoTo = txtScanningNoTo.val();
            }
            var scanningDateFrom = "";
            if (txtScanningDateFrom.length > 0) {
                scanningDateFrom = txtScanningDateFrom.val();
            }
            var scanningDateTo = "";
            if (txtScanningDateTo.length > 0) {
                scanningDateTo = txtScanningDateTo.val();
            }

            var filter = /(?!3[2-9]|00|02-3[01]|04-31|06-31|09-31|11-31)[0-3][0-9]-(?!1[3-9]|00)[01][0-9]-(?!10|28|29)[12][089][0-9][0-9]/;
            if (txtScanningDateFrom.val() != "" && !filter.test(txtScanningDateFrom.val())) {
                txtScanningDateFrom.removeClass("textBoxSearchDate").addClass("textBoxSearchDateError");
                txtScanningDateFrom.focus();
                MessegeArea("Please enter correct date scanning date format e.g dd-MM-yyyy", "error");
                return true;
            }
            else {
                txtScanningDateFrom.removeClass("textBoxSearchDateError").addClass("textBoxSearchDate");
            }

            if (txtScanningDateTo.val() != "" && !filter.test(txtScanningDateTo.val())) {
                txtScanningDateTo.removeClass("textBoxSearchDate").addClass("textBoxSearchDateError");
                txtScanningDateTo.focus();
                MessegeArea("Please enter correct date scanning date format e.g dd-MM-yyyy", "error");
                return true;
            }
            else {
                txtScanningDateTo.removeClass("textBoxSearchDateError").addClass("textBoxSearchDate");
            }
            var entryNoFrom = "";
            if (txtEntryNoFrom.length > 0) {
                entryNoFrom = txtEntryNoFrom.val();
            }
            var entryNoTo = "";
            if (txtEntryNoTo.length > 0) {
                entryNoTo = txtEntryNoTo.val();
            }
            var entryDateFrom = "";
            if (txtEntryDateFrom.length > 0) {
                entryDateFrom = txtEntryDateFrom.val();
            }
            if (txtEntryDateFrom.val() != "" && !filter.test(txtEntryDateFrom.val())) {
                txtEntryDateFrom.removeClass("textBoxSearchDate").addClass("textBoxSearchDateError");
                txtEntryDateFrom.focus();
                MessegeArea("Please enter correct date entry date format e.g dd-MM-yyyy", "error");
                return true;
            }
            else {
                txtEntryDateFrom.removeClass("textBoxSearchDateError").addClass("textBoxSearchDate");
            }
            var entryDateTo = "";
            if (txtEntryDateTo.length > 0) {
                entryDateTo = txtEntryDateTo.val();
            }
            if (txtEntryDateTo.val() != "" && !filter.test(txtEntryDateTo.val())) {
                txtEntryDateTo.removeClass("textBoxSearchDate").addClass("textBoxSearchDateError");
                txtEntryDateTo.focus();
                MessegeArea("Please enter correct date entry date format e.g dd-MM-yyyy", "error");
                return true;
            }
            else {
                txtEntryDateTo.removeClass("textBoxSearchDateError").addClass("textBoxSearchDate");
            }
            var surveyNoFrom = "";
            if (txtSurveyNoFrom.length > 0) {
                surveyNoFrom = txtSurveyNoFrom.val();
            }
            var surveyNoTo = "";
            if (txtSurveyNoTo.length > 0) {
                surveyNoTo = txtSurveyNoTo.val();
            }
            var bookNoFrom = "";
            if (txtBookNoFrom.length > 0) {
                bookNoFrom = txtBookNoFrom.val();
            }
            var bookNoTo = "";
            if (txtBookNoTo.length > 0) {
                bookNoTo = txtBookNoTo.val();
            }

            var pageNoFrom = "";
            if (txtPageNoFrom.length > 0) {
                pageNoFrom = txtPageNoFrom.val();
            }
            var pageNoTo = "";
            if (txtPageNoTo.length > 0) {
                pageNoTo = txtPageNoTo.val();
            }
            var ownerName = "";
            if (txtOwnerName.length > 0) {
                ownerName = txtOwnerName.val();
            }
            var ownerNameLike = "";
            if (ddlOwnerNameLike.length > 0) {
                ownerNameLike = ddlOwnerNameLike.val();
            }
            var cnicNo = "";
            if (txtCNIC.length > 0) {
                cnicNo = txtCNIC.val();
            }
            var sortedBy = "";
            if (ddlSortedBy.length > 0) {
                sortedBy = ddlSortedBy.val();
            }
            var ascDesc = "";
            if (ddlAscDesc.length > 0) {
                ascDesc = ddlAscDesc.val();
            }

            var lblTotalRows = $("span[id$='_lblTotalRows']");
            var totalRows = "";
            if (lblTotalRows.length > 0) {
                totalRows = 0;
            }
            var gvSearchRecord = $("#gvSearchRecord");
            if (Search != "") {
                start = 0;
            }
            $.ajax({
                async: false,
                type: "POST",
                url: "Search.aspx/bindSearchRecord",
                data: "{'zillaId':'" + zillaId + "', 'zillaText': '" + ddlZillaText + "', 'talukaId': '" + talukaId + "', 'talukaText': '" + ddlTalukaText +
                    "', 'dehId': '" + dehId + "', 'dehText': '" + ddlDehText + "', 'bookTypeId': '" + bookTypeId + "', 'bookTypeText': '" + ddlBookTypeText +
                    "', 'scheme': '" + scheme + "', 'schemeLike': '" + schemeLike + "', 'scanningNoFrom': '" + scanningNoFrom + "', 'scanningNoTo': '" + scanningNoTo +
                    "', 'scanningDateFrom': '" + scanningDateFrom + "', 'scanningDateTo': '" + scanningDateTo +
                    "', 'entryNoFrom': '" + entryNoFrom + "', 'entryNoTo': '" + entryNoTo + "', 'entryDateFrom': '" + entryDateFrom + "', 'entryDateTo': '" + entryDateTo +
                    "', 'surveyNoFrom': '" + surveyNoFrom + "', 'surveyNoTo': '" + surveyNoTo + "', 'bookNoFrom': '" + bookNoFrom + "', 'bookNoTo': '" + bookNoTo +
                    "', 'pageNoFrom': '" + pageNoFrom + "', 'pageNoTo': '" + pageNoTo + "', 'ownerName': '" + ownerName + "', 'ownerNameLike': '" + ownerNameLike +
                    "', 'cnicNo': '" + cnicNo + "', 'sortedBy': '" + sortedBy + "', 'ascDesc': '" + ascDesc + "', 'startIndex': '" + start +
                    "', 'endIndex': '" + end + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    if (result.d != null) {
                        gvSearchRecord.html("");
                        resetTotalPages();
                        //lblTotalRows.val("");
                        if (result.d.length > 0) {
                            if (gvSearchRecord.length > 0) {
                                if (roleId != "B689436A-8951-46E0-9211-09E72B44991A") {
                                    gvSearchRecord.append("<thead><tr>" +
                                                    "<th style='display:none;'>IndexingId</th>" +
                                                    "<th style='display:none;'>ImageId</th>" +
                                                    "<th>Zilla</th>" +
                                                    "<th>Taluka</th>" +
                                                    "<th>Deh</th>" +
                                                    "<th>Owner Name</th>" +
                                                    "<th>Book Type</th>" +
                                                    "<th>Scheme Name</th>" +
                                                    "<th>Scan No</th>" +
                                                    "<th>Scan Date</th>" +
                                                    "<th>Entry No</th>" +
                                                    "<th>Entry Date</th>" +
                                                    "<th>Survey No</th>" +
                                                    "<th>Book No</th>" +
                                                    "<th>Page No</th>" +
                                                    "<th>CNIC</th>" +
                                                    "<th>Print</th>" +
                                                    "<th>Edit</th>" +
                                                    "<th style='display:none;'>Delete</th>" +
                                                    "</tr>" +
                                                    "</thead>");
                                    for (var i = 0; i < result.d.length; i++) {
                                        gvSearchRecord.append("<tr><td style='display:none;'>" + result.d[i].Indexing_id + "</td><td style='display:none;'>" + result.d[i].Image_id + "</td>"
                                    + "<td>" + result.d[i].Zilla_name + "</td>"
                                    + "<td>" + result.d[i].Taluka_name + "</td>"
                                    + "<td>" + result.d[i].Deh_name + "</td>"
                                    + "<td style='width:140px; white-space:normal;'>" + result.d[i].Owner_name + "</td>"
                                    + "<td>" + result.d[i].Register_name + "</td><td style='width:140px; white-space:normal;'>" + result.d[i].Scheme_name + "</td><td>" + result.d[i].Scan_no + "</td><td>" + result.d[i].Scan_date + "</td>"
                                    + "<td>" + result.d[i].Entry_no + "</td><td>" + result.d[i].Entry_date + "</td><td>" + result.d[i].Survey_no + "</td><td>" + result.d[i].Book_no + "</td>"
                                    + "<td>" + result.d[i].Page_no + "</td><td>" + result.d[i].Cnic + "</td>"
                                    + "<td style='text-align:center;'><a href=javascript:IndexingImage(\'" + result.d[i].Indexing_id + "','print'); title='Print'><img src='image/print.png' /></a></td>"
                                        //+ "<td style='text-align:center;'><a href=javascript:IndexingImage(\'" + result.d[i].Indexing_id + "','edit'); title='Edit'><img src='image/edit.png' /></a></td>"
                                    + "<td style='text-align:center;'><a href=javascript:IndexingImage(\'" + result.d[i].Indexing_id + "','edit'); title='Edit'>Edit</a></td>"
                                    + "<td style='text-align:center; display:none;'><a href=javascript:deleteIndexingWithImage(\'" + result.d[i].Indexing_id + "'); title='Delete'><img src='image/delete.png' /></a></td>"
                                    + "</tr>");
                                        totalRows++;
                                    }
                                }
                                else {
                                    gvSearchRecord.append("<thead><tr>" +
                                                    "<th style='display:none;'>IndexingId</th>" +
                                                    "<th style='display:none;'>ImageId</th>" +
                                                    "<th>Zilla</th>" +
                                                    "<th>Taluka</th>" +
                                                    "<th>Deh</th>" +
                                                    "<th>Owner Name</th>" +
                                                    "<th>Book Type</th>" +
                                                    "<th>Scheme Name</th>" +
                                                    "<th>Scan No</th>" +
                                                    "<th>Scan Date</th>" +
                                                    "<th>Entry No</th>" +
                                                    "<th>Entry Date</th>" +
                                                    "<th>Survey No</th>" +
                                                    "<th>Book No</th>" +
                                                    "<th>Page No</th>" +
                                                    "<th>CNIC</th>" +
                                                    "<th>Print</th>" +
                                                    "<th>Edit</th>" +
                                                    "<th>Delete</th>" +
                                                    "</tr>" +
                                                    "</thead>");
                                    for (var i = 0; i < result.d.length; i++) {
                                        gvSearchRecord.append("<tr><td style='display:none;'>" + result.d[i].Indexing_id + "</td><td style='display:none;'>" + result.d[i].Image_id + "</td>"
                                    + "<td>" + result.d[i].Zilla_name + "</td>"
                                    + "<td>" + result.d[i].Taluka_name + "</td>"
                                    + "<td>" + result.d[i].Deh_name + "</td>"
                                    + "<td style='width:140px; white-space:normal;'>" + result.d[i].Owner_name + "</td>"
                                    + "<td>" + result.d[i].Register_name + "</td><td style='width:140px; white-space:normal;'>" + result.d[i].Scheme_name + "</td><td>" + result.d[i].Scan_no + "</td><td>" + result.d[i].Scan_date + "</td>"
                                    + "<td>" + result.d[i].Entry_no + "</td><td>" + result.d[i].Entry_date + "</td><td>" + result.d[i].Survey_no + "</td><td>" + result.d[i].Book_no + "</td>"
                                    + "<td>" + result.d[i].Page_no + "</td><td>" + result.d[i].Cnic + "</td>"
                                        //+ "<td style='text-align:center;'><a href=javascript:IndexingImage(\'" + result.d[i].Indexing_id + "','print'); title='Print'><img src='image/print.png' /></a></td>"
                                    + "<td style='text-align:center;'><a href=Indexing.aspx?IndexingId=" + result.d[i].Indexing_id + "&state=print title='Print'><img src='image/print.png' /></a></td>"
                                    //+ "<td style='text-align:center;'><a href=javascript:IndexingImage(\'" + result.d[i].Indexing_id + "','edit'); title='Edit'><img src='image/edit.png' /></a></td>"
                                    + "<td style='text-align:center;'><a href=Indexing.aspx?IndexingId=" + result.d[i].Indexing_id + "&state=edit title='Edit'><img src='image/edit.png' /></a></td>"
                                    + "<td style='text-align:center;'><a href=javascript:deleteIndexingWithImage(\'" + result.d[i].Indexing_id + "'); title='Delete'><img src='image/delete.png' /></a></td>"
                                    + "</tr>");
                                        totalRows++;
                                    }
                                }
                            }
                            //    var options = {
                            //        currPage: 1,
                            //        //ignoreRows: $('tbody tr:odd', $('#gvLogView')),
                            //        optionsForRows: [10, 20, 30, 50, 100, 150, 200],
                            //        rowsPerPage: 10,
                            //        firstArrow: (new Image()).src = "../image/FirstIco.png",
                            //        prevArrow: (new Image()).src = "../image/PreviousIco.png",
                            //        lastArrow: (new Image()).src = "../image/LastIco.png",
                            //        nextArrow: (new Image()).src = "../image/NextIco.png",
                            //        topNav: false
                            //    }
                            //    $('#gvSearchRecord').tablePagination(options);

                        }
                        else {
                            gvSearchRecord.append("<div style='width:100%; padding-left:7px;'>No record found</div>");
                        }
                        //lblTotalRows.text("Total Record: " + totalRows);
                        $("#SearchRecordHead").show();
                    }
                    return true;
                },
                error: function () {
                    gvSearchRecord.html("");
                    MessegeArea("An error has occurred during bindSearchRecord processing.", "error");
                }
            });
//        }
//        else {
//            requiredFields(ddlZilla, ddlTaluka, ddlDeh);
//        }
        return true;
    }

    function deleteIndexingWithImage(IndexingId) {
        $.confirm({
            'title': 'Delete Confirmation',
            'message': 'Are you sure you want to delete the record?',
            'buttons': {
                'Yes': {
                    'class': 'blue',
                    'action': function () {
                        $.ajax({
                            type: "POST",
                            url: "Search.aspx/DeleteIndexingWithImage",
                            data: "{'IndexingId':'" + IndexingId + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (result) {
                                if (result.d != null) {
                                    if (result.d == "success") {
                                        MessegeArea("User delete successfully", 'success');
                                        //var rowsPerPage = ("#rowsPerPage").val();
                                        //var currPage = $("#currPage").val();
                                        //bindSearchRecord();
                                        ResetPageRecord();
                                    }
                                    else {
                                        MessegeArea("Record not delete due to " + result.d, "error");
                                    }
                                }
                            },
                            error: function () {
                                MessegeArea("An error has occurred during editUser processing.", "Error");
                            }
                        });
                    }
                },
                'No': {
                    'class': 'gray',
                    'action': function () { } // Nothing to do in this case. You can as well omit the action property.
                }
            }
        });
    }



    function IndexingImage(id,status) {
        var url = "Indexing.aspx?IndexingId=" + id + "&state=" + status;
        window.location.href = url;
    }

    function resetFields() {
        $("select[id$='_ddlZilla']").val("0");
        $("select[id$='_ddlTaluka']").val("");
        $("select[id$='_ddlDeh']").val("");
        $("select[id$='_ddlBookType']").val("0");
        $("input[id$='_txtScheme']").val("");
        $("select[id$='_ddlSchemeLike']");
        $("input[id$='_txtScanningNoFrom']").val("");
        $("input[id$='_txtScanningNoTo']").val("");
        $("input[id$='_txtScanningDateFrom']").val("");
        $("input[id$='_txtScanningDateTo']").val("");
        $("input[id$='_txtEntryNoFrom']").val("");
        $("input[id$='_txtEntryNoTo']").val("");
        $("input[id$='_txtEntryDateFrom']").val("");
        $("input[id$='_txtEntryDateTo']").val("");
        $("input[id$='_txtSurveyNoFrom']").val("");
        $("input[id$='_txtSurveyNoTo']").val("");
        $("input[id$='_txtBookNoFrom']").val("");
        $("input[id$='_txtBookNoTo']").val("");
        $("input[id$='_txtPageNoFrom']").val("");
        $("input[id$='_txtPageNoTo']").val("");
        $("input[id$='_txtOwnerName']").val("");
        $("select[id$='_ddlOwnerNameLike']");
        $("input[id$='_txtCNIC']").val("");
        $("select[id$='_ddlSortedBy']");
        $("select[id$='_ddlAscDesc']");
    }
    var totalPages = 0;
    var numRows;
    var currentPage = 1;
    var start = 0;
    var end;

    function resetTotalPages() {
        getTotalRows();
        var rowsPerPage = $("#rowsPerPage").val();
        var preTotalPages = Math.round(numRows / rowsPerPage);
        totalPages = (preTotalPages * rowsPerPage < numRows) ? preTotalPages + 1 : preTotalPages;
        if ($("#totalPages").length > 0)
            $("#totalPages").html(totalPages);
        return totalPages;
//        currentPage = 1;
//        $("#currPage").val(currentPage);
//        bindSearchRecord();
    }

    function first() {
        $("#Loading").slideDown("fast");
        currentPage = 1;
        $("#currPage").val(currentPage);
        var rowsPerPage = $("#rowsPerPage").val();
        start = rowsPerPage * (currentPage - 1);
        end = rowsPerPage;
        bindSearchRecord("");
        totalPages = resetTotalPages();
        setTimeout(function () {
            $("#Loading").slideUp("fast");
        }, 1000);
    }

    function last() {
    $("#Loading").slideDown("fast");
        totalPages = resetTotalPages();
        currentPage = totalPages
        if (currentPage < 1 || currentPage > totalPages) 
            return;
        $("#currPage").val(currentPage);
        var rowsPerPage = $("#rowsPerPage").val();
        start = rowsPerPage * (totalPages - 1);
        end = rowsPerPage;
        bindSearchRecord("");
        setTimeout(function () {
            $("#Loading").slideUp("fast");
        },1000);
    }

    function next() {
        $("#Loading").slideDown("fast");
        totalPages = resetTotalPages();
        currentPage++;
        if (currentPage < 1 || currentPage > totalPages) {
            $("#Loading").slideUp("fast");
            return;
        }
        $("#currPage").val(currentPage);
        var rowsPerPage = $("#rowsPerPage").val();
        start = rowsPerPage * (currentPage - 1);
        end = rowsPerPage;
        bindSearchRecord("");
        setTimeout(function () {
            $("#Loading").slideUp("fast");
        },1000);
    }

    function ResetPageRecord() {
        $("#Loading").slideDown("fast");
        currentPage = 1;
        totalPages = resetTotalPages();
        if (currentPage < 1 || currentPage > totalPages) {
            $("#Loading").slideUp("fast");
            MessegeArea("Error on ResetPageRecord, Please contact administrator", "Error");
            return;
        }
        $("#currPage").val(currentPage);
        var rowsPerPage = $("#rowsPerPage").val();
        start = rowsPerPage * (currentPage - 1);
        end = rowsPerPage;
        bindSearchRecord("");
        $("#Loading").slideUp("fast");
    }

    function previous() {
        $("#Loading").slideDown("fast");
        currentPage--;
        totalPages = resetTotalPages();
        if (currentPage < 1 || currentPage > totalPages) {
            currentPage = 1;
            $("#Loading").slideUp("fast");
            return;
        }
        $("#currPage").val(currentPage);
        var rowsPerPage = $("#rowsPerPage").val();
        start = rowsPerPage * (currentPage - 1);
        end = rowsPerPage;
        bindSearchRecord("");
        setTimeout(function () {
            $("#Loading").slideUp("fast");
        }, 1000);
    }


    function resetCurrentPage(currPageNum) {
        if (currPageNum < 1 || currPageNum > totalPages)
            return;
        currPageNumber = currPageNum;
        hideOtherPages(currPageNumber);
        $("#currPage").val(currPageNumber)
    }

    function getTotalRows() {
        var ddlZilla = $("select[id$='_ddlZilla']");
        var ddlZillaText = $("[id*='ddlZilla'] :selected").text();
        var ddlTaluka = $("select[id$='_ddlTaluka']");
        var ddlTalukaText = $("[id*='ddlTaluka'] :selected").text();
        var ddlDeh = $("select[id$='_ddlDeh']");
        var ddlDehText = $("[id*='ddlDeh'] :selected").text();
        var ddlBookType = $("select[id$='_ddlBookType']");
        var ddlBookTypeText = $("[id*='ddlBookType'] :selected").text();
        var txtScheme = $("input[id$='_txtScheme']");
        var ddlSchemeLike = $("select[id$='_ddlSchemeLike']");
        var txtScanningNoFrom = $("input[id$='_txtScanningNoFrom']");
        var txtScanningNoTo = $("input[id$='_txtScanningNoTo']");
        var txtScanningDateFrom = $("input[id$='_txtScanningDateFrom']");
        var txtScanningDateTo = $("input[id$='_txtScanningDateTo']");
        var txtEntryNoFrom = $("input[id$='_txtEntryNoFrom']");
        var txtEntryNoTo = $("input[id$='_txtEntryNoTo']");
        var txtEntryDateFrom = $("input[id$='_txtEntryDateFrom']");
        var txtEntryDateTo = $("input[id$='_txtEntryDateTo']");
        var txtSurveyNoFrom = $("input[id$='_txtSurveyNoFrom']");
        var txtSurveyNoTo = $("input[id$='_txtSurveyNoTo']");
        var txtBookNoFrom = $("input[id$='_txtBookNoFrom']");
        var txtBookNoTo = $("input[id$='_txtBookNoTo']");
        var txtPageNoFrom = $("input[id$='_txtPageNoFrom']");
        var txtPageNoTo = $("input[id$='_txtPageNoTo']");
        var txtOwnerName = $("input[id$='_txtOwnerName']");
        var ddlOwnerNameLike = $("select[id$='_ddlOwnerNameLike']");
        var txtCNIC = $("input[id$='_txtCNIC']");
        var ddlSortedBy = $("select[id$='_ddlSortedBy']");
        var ddlAscDesc = $("select[id$='_ddlAscDesc']");
        //if (ddlZilla.val() != "" && ddlZilla.val() != "0" && ddlTaluka.val() != null && ddlTaluka.val() != "" && ddlTaluka.val() != "0" && ddlDeh.val() != null && ddlDeh.val() != "" && ddlDeh.val() != "0") {
        var zillaId = ""
        if (ddlZilla.length > 0) {
            zillaId = ddlZilla.val();
        }
        var talukaId = "";
        if (ddlTaluka.length > 0) {
            talukaId = ddlTaluka.val();
        }
        var dehId = "";
        if (ddlDeh.length > 0) {
            dehId = ddlDeh.val();
        }
        var bookTypeId = "";
        if (ddlBookType.length > 0) {
            bookTypeId = ddlBookType.val();
        }
        var scheme = "";
        if (txtScheme.length > 0) {
            scheme = txtScheme.val();
        }
        var schemeLike = "";
        if (ddlSchemeLike.length > 0) {
            schemeLike = ddlSchemeLike.val();
        }
        var scanningNoFrom = "";
        if (txtScanningNoFrom.length > 0) {
            scanningNoFrom = txtScanningNoFrom.val();
        }
        var scanningNoTo = "";
        if (txtScanningNoTo.length > 0) {
            scanningNoTo = txtScanningNoTo.val();
        }
        var scanningDateFrom = "";
        if (txtScanningDateFrom.length > 0) {
            scanningDateFrom = txtScanningDateFrom.val();
        }
        var scanningDateTo = "";
        if (txtScanningDateTo.length > 0) {
            scanningDateTo = txtScanningDateTo.val();
        }

        var filter = /(?!3[2-9]|00|02-3[01]|04-31|06-31|09-31|11-31)[0-3][0-9]-(?!1[3-9]|00)[01][0-9]-(?!10|28|29)[12][089][0-9][0-9]/;
        if (txtScanningDateFrom.val() != "" && !filter.test(txtScanningDateFrom.val())) {
            txtScanningDateFrom.removeClass("textBoxSearchDate").addClass("textBoxSearchDateError");
            txtScanningDateFrom.focus();
            MessegeArea("Please enter correct date scanning date format e.g dd-MM-yyyy", "error");
            return true;
        }
        else {
            txtScanningDateFrom.removeClass("textBoxSearchDateError").addClass("textBoxSearchDate");
        }

        if (txtScanningDateTo.val() != "" && !filter.test(txtScanningDateTo.val())) {
            txtScanningDateTo.removeClass("textBoxSearchDate").addClass("textBoxSearchDateError");
            txtScanningDateTo.focus();
            MessegeArea("Please enter correct date scanning date format e.g dd-MM-yyyy", "error");
            return true;
        }
        else {
            txtScanningDateTo.removeClass("textBoxSearchDateError").addClass("textBoxSearchDate");
        }
        var entryNoFrom = "";
        if (txtEntryNoFrom.length > 0) {
            entryNoFrom = txtEntryNoFrom.val();
        }
        var entryNoTo = "";
        if (txtEntryNoTo.length > 0) {
            entryNoTo = txtEntryNoTo.val();
        }
        var entryDateFrom = "";
        if (txtEntryDateFrom.length > 0) {
            entryDateFrom = txtEntryDateFrom.val();
        }
        if (txtEntryDateFrom.val() != "" && !filter.test(txtEntryDateFrom.val())) {
            txtEntryDateFrom.removeClass("textBoxSearchDate").addClass("textBoxSearchDateError");
            txtEntryDateFrom.focus();
            MessegeArea("Please enter correct date entry date format e.g dd-MM-yyyy", "error");
            return true;
        }
        else {
            txtEntryDateFrom.removeClass("textBoxSearchDateError").addClass("textBoxSearchDate");
        }
        var entryDateTo = "";
        if (txtEntryDateTo.length > 0) {
            entryDateTo = txtEntryDateTo.val();
        }
        if (txtEntryDateTo.val() != "" && !filter.test(txtEntryDateTo.val())) {
            txtEntryDateTo.removeClass("textBoxSearchDate").addClass("textBoxSearchDateError");
            txtEntryDateTo.focus();
            MessegeArea("Please enter correct date entry date format e.g dd-MM-yyyy", "error");
            return true;
        }
        else {
            txtEntryDateTo.removeClass("textBoxSearchDateError").addClass("textBoxSearchDate");
        }
        var surveyNoFrom = "";
        if (txtSurveyNoFrom.length > 0) {
            surveyNoFrom = txtSurveyNoFrom.val();
        }
        var surveyNoTo = "";
        if (txtSurveyNoTo.length > 0) {
            surveyNoTo = txtSurveyNoTo.val();
        }
        var bookNoFrom = "";
        if (txtBookNoFrom.length > 0) {
            bookNoFrom = txtBookNoFrom.val();
        }
        var bookNoTo = "";
        if (txtBookNoTo.length > 0) {
            bookNoTo = txtBookNoTo.val();
        }

        var pageNoFrom = "";
        if (txtPageNoFrom.length > 0) {
            pageNoFrom = txtPageNoFrom.val();
        }
        var pageNoTo = "";
        if (txtPageNoTo.length > 0) {
            pageNoTo = txtPageNoTo.val();
        }
        var ownerName = "";
        if (txtOwnerName.length > 0) {
            ownerName = txtOwnerName.val();
        }
        var ownerNameLike = "";
        if (ddlOwnerNameLike.length > 0) {
            ownerNameLike = ddlOwnerNameLike.val();
        }
        var cnicNo = "";
        if (txtCNIC.length > 0) {
            cnicNo = txtCNIC.val();
        }
        var sortedBy = "";
        if (ddlSortedBy.length > 0) {
            sortedBy = ddlSortedBy.val();
        }
        var ascDesc = "";
        if (ddlAscDesc.length > 0) {
            ascDesc = ddlAscDesc.val();
        }

        var lblTotalRows = $("span[id$='_lblTotalRows']");
        var totalRows = "";
        if (lblTotalRows.length > 0) {
            totalRows = 0;
        }
        $.ajax({
            async: false,
            type: "POST",
            url: "Search.aspx/getTotalRows",
            data: "{'zillaId':'" + zillaId + "', 'zillaText': '" + ddlZillaText + "', 'talukaId': '" + talukaId + "', 'talukaText': '" + ddlTalukaText +
                    "', 'dehId': '" + dehId + "', 'dehText': '" + ddlDehText + "', 'bookTypeId': '" + bookTypeId + "', 'bookTypeText': '" + ddlBookTypeText +
                    "', 'scheme': '" + scheme + "', 'schemeLike': '" + schemeLike + "', 'scanningNoFrom': '" + scanningNoFrom + "', 'scanningNoTo': '" + scanningNoTo +
                    "', 'scanningDateFrom': '" + scanningDateFrom + "', 'scanningDateTo': '" + scanningDateTo +
                    "', 'entryNoFrom': '" + entryNoFrom + "', 'entryNoTo': '" + entryNoTo + "', 'entryDateFrom': '" + entryDateFrom + "', 'entryDateTo': '" + entryDateTo +
                    "', 'surveyNoFrom': '" + surveyNoFrom + "', 'surveyNoTo': '" + surveyNoTo + "', 'bookNoFrom': '" + bookNoFrom + "', 'bookNoTo': '" + bookNoTo +
                    "', 'pageNoFrom': '" + pageNoFrom + "', 'pageNoTo': '" + pageNoTo + "', 'ownerName': '" + ownerName + "', 'ownerNameLike': '" + ownerNameLike +
                    "', 'cnicNo': '" + cnicNo + "', 'sortedBy': '" + sortedBy + "', 'ascDesc': '" + ascDesc + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                if (result.d != null) {
                    if (result.d != "") {
                        numRows = result.d;
                        lblTotalRows.val("");
                        lblTotalRows.text("Total Record: " + numRows);
                    }
                }
            },
            error: function () {
                MessegeArea("An error has occurred during getTotalRows processing.", "error");
            }
        });
    }
    
</script>


<div style="width:100%;">
    <div style="width:100%; clear:both;" id="divSearch">
        <div style="width:100%; float:left;">
            <div style="float:left; width:100%;">
                <div class="searchLeftCaption">
                    <asp:Label ID="lblZilla" runat="server" Text="Zilla:"></asp:Label>
                </div>
                <div class="SearchRightValueDivControl">
                    <asp:DropDownList ID="ddlZilla" runat="server" CssClass="LongWidthDropDownBG"  onchange="javascript:fillTaluka();" ></asp:DropDownList>
                </div>
            </div>
            <div style="clear:both; width:100%;">
                <div class="searchLeftCaption">
                    <asp:Label ID="lblTaluka" runat="server" Text="Taluka:"></asp:Label>    
                </div>
                <div class="SearchRightValueDivControl">
                    <asp:DropDownList ID="ddlTaluka" runat="server" CssClass="LongWidthDropDownBG" onchange="javascript:fillDeh();"></asp:DropDownList>
                </div>
            </div>
            <div style="clear:both; width:100%;">
                <div class="searchLeftCaption">
                    <asp:Label ID="lblDeh" runat="server" Text="Deh:"></asp:Label>    
                </div>
                <div class="SearchRightValueDivControl">
                    <asp:DropDownList ID="ddlDeh" runat="server" CssClass="LongWidthDropDownBG"></asp:DropDownList>
                </div>
            </div>
            <div class="searchDiv">
                <div class="searchLeftCaption">
                    <asp:Label ID="BookType" runat="server" Text="Book Type:"></asp:Label>    
                </div>
                <div class="SearchRightValueDivControl">
                    <asp:DropDownList ID="ddlBookType" runat="server" CssClass="LongWidthDropDownBG">
                        <asp:ListItem Value="0" Text="<-- SELECT -->"></asp:ListItem>
                        <asp:ListItem Value="2" Text="VF-II"></asp:ListItem>
                        <asp:ListItem Value="7" Text="VF-VII-A"></asp:ListItem>
                        <asp:ListItem Value="15" Text="VF-VII-B"></asp:ListItem>
                        <asp:ListItem Value="3" Text="DK Book"></asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="searchDiv">
                <div class="searchLeftCaption">
                    <asp:Label ID="lblScheme" runat="server" Text="Scheme:"></asp:Label>
                </div>
                <div style="float:left;">
                    <asp:TextBox ID="txtScheme" runat="server" CssClass="textBoxBG"></asp:TextBox>
                </div>
                <div style="float:left; padding:10px 6px 0 15px; width:25px;">
                    <asp:Label ID="lblSchemeEmpty" runat="server" Text=""></asp:Label>
                </div>
                <div style="float:left;">
                    <asp:DropDownList ID="ddlSchemeLike" runat="server" CssClass="DropDownBG">
                        <asp:ListItem Value="LIKE" Text="Like">Like</asp:ListItem>
                        <asp:ListItem Value="=" Text="Equal">Equal</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="searchDiv">
                <div class="searchLeftCaption">
                    <asp:Label ID="lblScanningNoFrom" runat="server" Text="Scanning No:"></asp:Label>
                </div>
                <div style="float:left;">
                    <asp:TextBox ID="txtScanningNoFrom" runat="server" CssClass="textBoxBG"></asp:TextBox>
                </div>
                <div style="float:left; padding:10px 6px 0 15px; width:25px;">
                    <asp:Label ID="lblScanningNoTo" runat="server" Text="To"></asp:Label>
                </div>
                <div style="float:left;">
                    <asp:TextBox ID="txtScanningNoTo" runat="server" CssClass="textBoxBG"></asp:TextBox>
                </div>
            </div>
            <div class="searchDiv">
                <div class="searchLeftCaption">
                    <asp:Label ID="lblScanningDateFrom" runat="server" Text="Scanning Date:"></asp:Label>
                </div>
                <div style="float:left; width:12%;">
                    <asp:TextBox ID="txtScanningDateFrom" runat="server" CssClass="textBoxSearchDate" placeholder="dd-MM-yyyy"></asp:TextBox>
                    <div style="float:right; padding:3px 5px 0px 5px;"><img src="image/calendar-icon.png" alt="" id="imgScanDateFrom" style="cursor:pointer;" /></div>
                        <ajax:CalendarExtender ID="calScanDataFrom" runat="server" TargetControlID="txtScanningDateFrom" Format="dd-MM-yyyy" CssClass="calendarCss" PopupButtonID="imgScanDateFrom" ></ajax:CalendarExtender>
                </div>
                <div style="float:left; padding:10px 6px 0 5px; width:25px;">
                    <asp:Label ID="lblScanningDateTo" runat="server" Text="To"></asp:Label>
                </div>
                <div style="float:left; width:12%;">
                    <asp:TextBox ID="txtScanningDateTo" runat="server" CssClass="textBoxSearchDate" placeholder="dd-MM-yyyy"></asp:TextBox>
                    <div style="float:right; padding:3px 5px 0px 5px;"><img src="image/calendar-icon.png" alt="" id="imgScanDateTo" style="cursor:pointer;" /></div>
                        <ajax:CalendarExtender ID="calScanDataTo" runat="server" TargetControlID="txtScanningDateTo" Format="dd-MM-yyyy" CssClass="calendarCss" PopupButtonID="imgScanDateTo" ></ajax:CalendarExtender>
                </div>
            </div>
            <div class="searchDiv">
                <div class="searchLeftCaption">
                    <asp:Label ID="lblEntryNoFrom" runat="server" Text="Entry No:"></asp:Label>
                </div>
                <div style="float:left;">
                    <asp:TextBox ID="txtEntryNoFrom" runat="server" CssClass="textBoxBG"></asp:TextBox>
                </div>
                <div style="float:left; padding:10px 6px 0 15px; width:25px;">
                    <asp:Label ID="lblEntryNoTo" runat="server" Text="To"></asp:Label>
                </div>
                <div style="float:left;">
                    <asp:TextBox ID="txtEntryNoTo" runat="server" CssClass="textBoxBG"></asp:TextBox>
                </div>
            </div>
            <div class="searchDiv">
                <div class="searchLeftCaption">
                    <asp:Label ID="lblEntryDateFrom" runat="server" Text="Entry Date:"></asp:Label>
                </div>
                <div style="float:left; width:12%;">
                    <asp:TextBox ID="txtEntryDateFrom" runat="server" CssClass="textBoxSearchDate" placeholder="dd-MM-yyyy"></asp:TextBox>
                    <div style="float:right; padding:3px 5px 0px 5px;"><img src="image/calendar-icon.png" alt="" id="imgEntryFrom" style="cursor:pointer;" /></div>
                        <ajax:CalendarExtender ID="calEntryDateFrom" runat="server" TargetControlID="txtEntryDateFrom" Format="dd-MM-yyyy" CssClass="calendarCss" PopupButtonID="imgEntryFrom" ></ajax:CalendarExtender>
                </div>
                <div style="float:left; padding:10px 6px 0 5px; width:25px;">
                    <asp:Label ID="lblEntryDateTo" runat="server" Text="To"></asp:Label>
                </div>
                <div style="float:left; width:12%;">
                    <asp:TextBox ID="txtEntryDateTo" runat="server" CssClass="textBoxSearchDate" placeholder="dd-MM-yyyy"></asp:TextBox>
                    <div style="float:right; padding:3px 5px 0px 5px;"><img src="image/calendar-icon.png" alt="" id="imgEntryTo" style="cursor:pointer;" /></div>
                        <ajax:CalendarExtender ID="calEntryDateTo" runat="server" TargetControlID="txtEntryDateTo" Format="dd-MM-yyyy" CssClass="calendarCss" PopupButtonID="imgEntryTo" ></ajax:CalendarExtender>
                </div>
            </div>
            <div class="searchDiv">
                <div class="searchLeftCaption">
                    <asp:Label ID="lblSurveyNoFrom" runat="server" Text="Survey No:"></asp:Label>
                </div>
                <div style="float:left;">
                    <asp:TextBox ID="txtSurveyNoFrom" runat="server" CssClass="textBoxBG"></asp:TextBox>
                </div>
                <div style="float:left; padding:10px 6px 0 15px; width:25px;">
                    <asp:Label ID="lblSurveyNoTo" runat="server" Text="To"></asp:Label>
                </div>
                <div style="float:left;">
                    <asp:TextBox ID="txtSurveyNoTo" runat="server" CssClass="textBoxBG"></asp:TextBox>
                </div>
            </div>
            <div class="searchDiv">
                <div class="searchLeftCaption">
                    <asp:Label ID="lblBookNoFrom" runat="server" Text="Book No:"></asp:Label>
                </div>
                <div style="float:left;">
                    <asp:TextBox ID="txtBookNoFrom" runat="server" CssClass="textBoxBG"></asp:TextBox>
                </div>
                <div style="float:left; padding:10px 6px 0 15px; width:25px;">
                    <asp:Label ID="lblBookNoTo" runat="server" Text="To"></asp:Label>
                </div>
                <div style="float:left;">
                    <asp:TextBox ID="txtBookNoTo" runat="server" CssClass="textBoxBG"></asp:TextBox>
                </div>
            </div>
            <div class="searchDiv">
                <div class="searchLeftCaption">
                    <asp:Label ID="lblPageNoFrom" runat="server" Text="Page No:"></asp:Label>
                </div>
                <div style="float:left;">
                    <asp:TextBox ID="txtPageNoFrom" runat="server" CssClass="textBoxBG"></asp:TextBox>
                </div>
                <div style="float:left; padding:10px 6px 0 15px; width:25px;">
                    <asp:Label ID="lblPageNoTo" runat="server" Text="To"></asp:Label>
                </div>
                <div style="float:left;">
                    <asp:TextBox ID="txtPageNoTo" runat="server" CssClass="textBoxBG"></asp:TextBox>
                </div>
            </div>
            <div class="searchDiv">
                <div class="searchLeftCaption">
                    <asp:Label ID="lblOwnerName" runat="server" Text="Owner Name:"></asp:Label>
                </div>
                <div style="float:left;">
                    <asp:TextBox ID="txtOwnerName" runat="server" CssClass="textBoxBG"></asp:TextBox>
                </div>
                <div style="float:left; padding:10px 6px 0 15px; width:25px;">
                    <asp:Label ID="lblEmpty" runat="server" Text=""></asp:Label>
                </div>
                <div style="float:left;">
                    <asp:DropDownList ID="ddlOwnerNameLike" runat="server" CssClass="DropDownBG">
                        <asp:ListItem Value="LIKE" Text="Like" Selected="True">Like</asp:ListItem>
                        <asp:ListItem Value="=" Text="Equal">Equal</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="searchDiv">
                <div class="searchLeftCaption">
                    <asp:Label ID="lblCNIC" runat="server" Text="CNIC:"></asp:Label>
                </div>
                <div style="float:left;">
                    <asp:TextBox ID="txtCNIC" runat="server" CssClass="CNICtextBoxBG"></asp:TextBox>
                </div>
            </div>
            <div class="searchDiv">
                <div class="searchLeftCaption">
                    <asp:Label ID="lblSortBy" runat="server" Text="Sort By:"></asp:Label>
                </div>
                <div style="float:left;">
                    <asp:DropDownList ID="ddlSortedBy" runat="server" CssClass="DropDownBG">
                        <%--<asp:ListItem Text="Created Date" Value="access_date_time" Selected="True"></asp:ListItem>--%>
                        <asp:ListItem Text="Scan Number" Value="utility.fnc_ParseINT(scan_no)"></asp:ListItem>
                        <asp:ListItem Text="Book Type" Value="register_name"></asp:ListItem>
                        <asp:ListItem Text="Scan Date" Value="utility.fnc_ParseINT(scan_date)"></asp:ListItem>
                        <asp:ListItem Text="Entry Number" Value="utility.fnc_ParseINT(entry_no)"></asp:ListItem>
                        <asp:ListItem Text="Entry Date" Value="utility.fnc_ParseINT(entry_date)"></asp:ListItem>
                        <asp:ListItem Text="Survey Number" Value="utility.fnc_ParseINT(survey_no)"></asp:ListItem>
                        <asp:ListItem Text="Book Number" Value="utility.fnc_ParseINT(book_no)"></asp:ListItem>
                        <asp:ListItem Text="Page Number" Value="utility.fnc_ParseINT(page_no)"></asp:ListItem>
                        <asp:ListItem Text="Owner Name" Value="owner_name"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                 <div style="float:left; padding:10px 6px 0 15px; width:25px;">
                    <asp:Label ID="lblSortByEmpty" runat="server" Text=""></asp:Label>
                </div>
                <div style="float:left;">
                    <asp:DropDownList ID="ddlAscDesc" runat="server" CssClass="DropDownBG">
                        <asp:ListItem Value="ASC" Text="ASCENDING" Selected="True">ASCENDING</asp:ListItem>
                        <asp:ListItem Value="DESC" Text="DESCENDING">DESCENDING</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div style="float:left; padding:10px 6px 0 15px; width:25px;">
                    <asp:Label ID="Label2" runat="server" Text=""></asp:Label>
                </div>
            </div>
            <div style="clear:both; width:100%;">
                <div style="float:left; width:225px; padding-left:155px; padding-top:15px;">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="LoginButton" OnClientClick='if(bindSearchRecord(1)) return false;' />&nbsp; <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="LoginButton" OnClientClick="javascript:resetFields(); return false;" />
                </div>
            </div>
        </div>
        <div style="clear:both; float:left; width:100%; padding-top:20px; ">
            <div style="float:left; padding:5px 0px 5px 0px; width:99%;">
                <div id="SearchRecordHead" style="width:100%; padding:7px 0px 7px 10px; box-shadow:0 0 18px #70B2CD inset; display:none;">Search Record
                    <div style="float:right; padding-right:10px;"><asp:Label ID="lblTotalRows" runat="server" Text=""></asp:Label></div>
                </div>
            </div>
            <div style="width:100%; clear:both;">
                <table id="gvSearchRecord" >
                </table>
                <div style="clear:both; float:left; width:100%;">
                    <div id='tablePagination'>
                        <span id='perPage'>
                            <div style='float:left;'>
                                <select id='rowsPerPage' onchange="javascript:ResetPageRecord();">
                                    <option value="10">10</option>
                                    <option value="20">20</option>
                                    <option value="30">30</option>
                                    <option value="50">50</option>
                                    <option value="75">75</option>
                                    <option value="100">100</option>
                                </select>
                            </div>
                            <div style='float:left; padding-left:5px;'>per page</div>
                        </span>
                        <span id='paginater' style="float:right;">
                            <div style='float:left;'><img id='firstPage' src="image/FirstIco.png" onclick='javascript:first();'/></div>
                            <div style='float:left;'><img id='prevPage' src="image/PreviousIco.png" onclick="javascript:previous();" /></div>
                            <div style='float:left; padding:0px 5px;'>Page</div>
                            <div style='float:left;'><input id='currPage' type="text" value="" size='1' readonly="readonly" style="width:35px; text-align:center;" /></div>
                            <div style='float:left; padding:1px 5px 0px;'>of<span id='totalPages'></span></div>
                            <div style='float:left;'><img id='nextPage' src="image/NextIco.png" onclick="javascript:next();" /></div>
                            <div style='float:left;'><img id='lastPage' src="image/LastIco.png" onclick="javascript:last();" /></div>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <div id="Loading" style="opacity:0.80; position:relative; z-index:1000; background-color:#DEDEDE; display:none; width:100%; height:100%;">
            <div style="clear: both;">                
                <center>
                    <div style="float:left;z-index:1001; left:40%; top:40%; position:fixed; ">
                        <img src="image/Please_wait.gif" alt="" />
                    </div>
                </center>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hfRoleId" runat="server" />
</div>

</asp:Content>