<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Indexing.aspx.cs" Inherits="Indexing.UI.Indexing"
    MasterPageFile="~/PRC_Master.Master" EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <script type="text/javascript" language="javascript">
        $(document).ready(function () {
            var queryString = window.location.search.substring(1);
            if (queryString != undefined && queryString != "") {
                var splitQueryString = queryString.split('&');
                if (splitQueryString != undefined && splitQueryString.length > 1) {
                    var IndexingId = splitQueryString[0].split('=');
                    var State = splitQueryString[1].split('=');
                    if (IndexingId.length > 1 && State.length > 1) {
                        //For print Labeled
                        var lblZillaName = $("span[id$='_lblZillaName']");
                        var lblTalukaName = $("span[id$='_lblTalukaName']");
                        var lblDehName = $("span[id$='_lblDehName']");
                        var lblBookTypeName = $("span[id$='_lblBookTypeName']");
                        var lblSchemeName = $("span[id$='_lblSchemeName']");
                        var lblScanNoName = $("span[id$='_lblScanNoName']");
                        var lblScanDateName = $("span[id$='_lblScanDateName']");
                        var lblEntryNoName = $("span[id$='_lblEntryNoName']");
                        var lblEntryDateName = $("span[id$='_lblEntryDateName']");
                        var lblSurveyNoName = $("span[id$='_lblSurveyNoName']");
                        var lblBookNoName = $("span[id$='_lblBookNoName']");
                        var lblPageNoName = $("span[id$='_lblPageNoName']");
                        var lblOwnerNameName = $("span[id$='_lblOwnerNameName']");
                        var lblCNICNoName = $("span[id$='_lblCNICNoName']");
                        //End Print Labeled

                        //Edit Textbox
                        var ddlZilla = $("select[id$='_ddlZillaEdit']");
                        var ddlZillaText = $("[id*='ddlZillaEdit'] :selected").text();
                        var ddlTaluka = $("select[id$='_ddlTalukaEdit']");
                        var ddlTalukaText = $("[id*='ddlTalukaEdit'] :selected").text();
                        var ddlDeh = $("select[id$='_ddlDehEdit']");
                        var ddlDehText = $("[id*='ddlDehEdit'] :selected").text();
                        var ddlBookType = $("select[id$='_ddlBookTypeEdit']");
                        var ddlBookTypeText = $("[id*='ddlBookTypeEdit'] :selected").text();
                        var txtScheme = $("input[id$='_txtSchemeEdit']");
                        var txtScanningNo = $("input[id$='_txtScanNoEdit']");
                        var txtScanningDate = $("input[id$='_txtScanDateEdit']");
                        var txtEntryNo = $("input[id$='_txtEntryNoEdit']");
                        var txtEntryDate = $("input[id$='_txtEntryDateEdit']");
                        var txtSurveyNo = $("input[id$='_txtSurveyNoEdit']");
                        var txtBookNo = $("input[id$='_txtBookNoEdit']");
                        var txtPageNo = $("input[id$='_txtPageNoEdit']");
                        var txtOwnerName = $("input[id$='_txtOwnerNameEdit']");
                        var txtCNICNo = $("input[id$='_txtCNICNoEdit']");
                        //End Edit Textbox
                        fillZilla("Edit");
                        $.ajax({
                            async: false,
                            type: "POST",
                            url: "Indexing.aspx/loadPrintData",
                            data: "{'IndexingId':'" + IndexingId[1] + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (result) {
                                if (result.d != null) {
                                    if (result.d.length > 0) {
                                        if (State[1] == "print") {
                                            lblZillaName.text(result.d[0].Zilla_name);
                                            lblTalukaName.text(result.d[0].Taluka_name);
                                            lblDehName.text(result.d[0].Deh_name);
                                            lblBookTypeName.text(result.d[0].Register_name);
                                            lblSchemeName.text(result.d[0].Scheme_name);
                                            lblScanNoName.text(result.d[0].Scan_no);
                                            lblScanDateName.text(result.d[0].Scan_date);
                                            lblEntryNoName.text(result.d[0].Entry_no);
                                            lblEntryDateName.text(result.d[0].Entry_date);
                                            lblSurveyNoName.text(result.d[0].Survey_no);
                                            lblBookNoName.text(result.d[0].Book_no);
                                            lblPageNoName.text(result.d[0].Page_no);
                                            lblOwnerNameName.text(result.d[0].Owner_name);
                                            lblCNICNoName.text(result.d[0].Cnic);
                                            var iframe = $("iframe[id$='_frmPDFViewer']");
                                            if (iframe.length > 0) {
                                                iframe.attr("src", "PDFViewer.aspx?imageId=" + result.d[0].Image_id);
                                            }
                                            $("#divEntryForm").show('fast');
                                            $("#LoadImage").hide('fast');
                                            $("#HeadingMenu").hide('fast');
                                        }
                                        else {

                                            $("input[id$='_hfIndexingId']").val(result.d[0].Indexing_id);
                                            ddlZilla.val(result.d[0].Zilla_id).select();
                                            //$("select[id$='_ddlZillaEdit'] option:contains(" + result.d[0].Zilla_id + ")").attr('selected', 'selected');
                                            //$("#HowYouKnow option:contains(" + theText + ")").attr('selected', 'selected');
                                            //$("[id*='ddlZillaEdit'] :selected").val(result.d[0].Zilla_id);
                                            fillTaluka("Edit");
                                            //setTimeout(function () {
                                                ddlTaluka.val(result.d[0].Taluka_id).select();
                                            //}, 1500);
                                            //setTimeout(function () {
                                                fillDeh("Edit");
                                            //}, 2500);
                                            //setTimeout(function () {
                                                ddlDeh.val(result.d[0].Deh_id);
                                            //}, 5000);
                                            ddlBookType.val(result.d[0].Register_id);
                                            txtScheme.val(result.d[0].Scheme_name);
                                            txtScanningNo.val(result.d[0].Scan_no);
                                            txtScanningDate.val(result.d[0].Scan_date);
                                            txtEntryNo.val(result.d[0].Entry_no);
                                            txtEntryDate.val(result.d[0].Entry_date);
                                            txtSurveyNo.val(result.d[0].Survey_no);
                                            txtBookNo.val(result.d[0].Book_no);
                                            txtPageNo.val(result.d[0].Page_no);
                                            txtOwnerName.val(result.d[0].Owner_name);
                                            txtCNICNo.val(result.d[0].Cnic);
                                            var iframe = $("iframe[id$='_frmPDFViewer']");
                                            if (iframe.length > 0) {
                                                iframe.attr("src", "PDFViewer.aspx?imageId=" + result.d[0].Image_id);
                                            }
                                            $("#divEntryForm").show('fast');
                                            $("#LoadImage").hide('fast');
                                        }
                                    }
                                }
                            },
                            error: function () {
                                MessegeArea("An error has occurred during Loading Editing Value processing.", "Error");
                            }
                        });
                    }
                }
            }
        });

        var images;
        var currentImageIndex = 0;
        function GetImages() {
            PageMethods.GetImages(GetImagesCompleted);
        }

        function GetImagesCompleted(result) {
            images = result;
            ShowImage();
        }

        function ShowImage() {
            var currentImage = images[currentImageIndex];
            var date = currentImage.Date;
            var imgImage = "<img id='imgImage' width='500px' height='475px' alt='" + date +
            "' title='" + date +
            "' src='" + currentImage.VirtualPath + "' />";
            var dp = document.getElementById("divImage");
            dp.innerHTML = imgImage;
            document.title = date;
            ShowButtons();
        }

        function ShowButtons() {
            var first = "<<";
            var previous = "<";
            var next = ">";
            var last = ">>";
            var button1 = "<div style='float:left;'><input type='button' style='width: 35px;'";
            var btnFirst = button1 + " value='" + first + "' onclick='ShowFirstImage();'";
            var btnPrevious = button1 + " value='" + previous + "' onclick='ShowPreviousImage();'";
            var btnNext = button1 + " value='" + next + "' onclick='ShowNextImage();'";
            var btnLast = button1 + " value='" + last + "' onclick='ShowLastImage();'";
            if (currentImageIndex == 0) {
                btnFirst += " disabled='disabled'";
                btnPrevious += " disabled='disabled'";
            }
            if (currentImageIndex == images.length - 1) {
                btnNext += " disabled='disabled'";
                btnLast += " disabled='disabled'";
            }
            var button2 = " /></div>";
            btnFirst += button2;
            btnPrevious += button2;
            btnNext += button2;
            btnLast += button2;
            var db1 = document.getElementById("divButtons");
            db1.innerHTML = btnFirst + btnPrevious + btnNext + btnLast;
        }

        // Shows the first Image:
        function ShowFirstImage() {
            currentImageIndex = 0;
            ShowImage();
        }

        // Shows the previous Image:
        function ShowPreviousImage() {
            if (currentImageIndex > 0) {
                currentImageIndex -= 1;
                ShowImage();
            }
        }

        // Shows the next Image:
        function ShowNextImage() {
            if (currentImageIndex < images.length - 1) {
                currentImageIndex += 1;
                ShowImage();
            }
        }

        // Shows the last Image:
        function ShowLastImage() {
            currentImageIndex = images.length - 1;
            ShowImage();
        }

        function fillZilla(Edit) {
            var ddlZilla = "";
            if (Edit != "") {
                ddlZilla = $("select[id$='_ddlZillaEdit']");
            }
            else {
                ddlZilla = $("select[id$='_ddlZilla']");
            }
            if (ddlZilla.length > 0) {
                $.ajax({
                    async: false,
                    type: "POST",
                    url: "Indexing.aspx/getZillaForDropDown",
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
                                //setTimeout(function () {
                                    for (var i = 0; i < result.d.length; i++) {
                                        var opt = document.createElement("option");
                                        opt.text = result.d[i].Zilla_name_eng;
                                        opt.value = result.d[i].Zilla_id;
                                        ddlZilla[0].options.add(opt);
                                    }
                                //}, 1000);
                                $("#divEntryForm").fadeOut("faste");
                            }
                        }
                        else {
                            MessegeArea("fillZilla has null value.", "Error");
                        }
                    },
                    error: function () {
                        MessegeArea("An error has occurred during fillZilla processing.", "Error");
                    }
                });
            }
        }

        function fillTaluka(Edit) {
            var ddlZilla = "";
            var ddlTaluka = "";
            var ddlDeh = "";
            if (Edit != "") {
                ddlZilla = $("select[id$='_ddlZillaEdit']");
                ddlTaluka = $("select[id$='_ddlTalukaEdit']");
                ddlDeh = $("select[id$='_ddlDehEdit']");
            }
            else {
                ddlZilla = $("select[id$='_ddlZilla']");
                ddlTaluka = $("select[id$='_ddlTaluka']");
                ddlDeh = $("select[id$='_ddlDeh']");
            }
            if (ddlDeh.length > 0) {
                ddlDeh.empty();
            }
            if (ddlZilla.length > 0 && ddlZilla[0].value != undefined && ddlZilla[0].value != null && ddlZilla[0].value != "" && ddlZilla[0].value != "0") {
                ddlTaluka.empty();
                if (ddlTaluka.length > 0) {
                    $.ajax({
                        async: false,
                        type: "POST",
                        url: "Indexing.aspx/getTalukaForDropDown",
                        data: "{'zillaId':'" + ddlZilla[0].value + "'}",
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
                            MessegeArea("An error has occurred during fillTaluka processing.", "Error");
                        }
                    });
                }
            }
        }

        function fillDeh(Edit) {
            var ddlTaluka = "";
            var ddlDeh = "";
            if (Edit != "") {
                ddlTaluka = $("select[id$='_ddlTalukaEdit']");
                ddlDeh = $("select[id$='_ddlDehEdit']");
            }
            else {
                ddlTaluka = $("select[id$='_ddlTaluka']");
                ddlDeh = $("select[id$='_ddlDeh']");
            }
            if (ddlTaluka.length > 0 && ddlTaluka[0].value != null && ddlTaluka[0].value != undefined && ddlTaluka[0].value != "" && ddlTaluka[0].value != "0") {
                if (ddlDeh.length > 0) {
                    ddlDeh.empty();
                    $.ajax({
                        async: false,
                        type: "POST",
                        url: "Indexing.aspx/getDehForDropDown",
                        data: "{'talukaId':'" + ddlTaluka[0].value + "'}",
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
                            MessegeArea("An error has occurred during fillDeh processing.", "Error");
                        }
                    });
                }
            }
        }

        var currentPDfFilePath = "";

        function uploadImage() {
            var valueReturn = true;
            var txtLoadImageScanningDate = $("input[id$='_txtLoadImageScanDate']");
            var lblTotalFiles = $("span[id$='_lblTotalFiles']");
            if (txtLoadImageScanningDate.length > 0 && txtLoadImageScanningDate[0].value == "") {
                txtLoadImageScanningDate.removeClass("textBoxBG").addClass("textBoxError");
                txtLoadImageScanningDate.focus();
                return false;
            }
            var divIcons = $("#divIcons");
            if (divIcons.length > 0) {
                var hfScanningDate = $("input[id$='_hfScanningDate']");
                var hfEntryDate = $("input[id$='_hfEntryDate']");
                var txtLoadImageScanningDate = $("input[id$='_txtLoadImageScanDate']");
                var txtLoadImageEntryDate = $("input[id$='_txtLoadImageEntryDate']");
                if (txtLoadImageScanningDate.length > 0 && txtLoadImageEntryDate.length > 0) {
                    hfScanningDate.val(txtLoadImageScanningDate[0].value);
                    hfEntryDate.val(txtLoadImageEntryDate[0].value);
                    var txtScanningDate = $("input[id$='_txtScanDate']");
                    var txtEntryDate = $("input[id$='_txtEntryDate']");
                    if (txtScanningDate.length > 0 && txtEntryDate.length > 0) {
                        txtScanningDate.val(hfScanningDate.val());
                        txtEntryDate.val(hfEntryDate.val());
                    }
                }
                var filePath;
                var totalFiles = 0;
                $("#Loading").slideDown("fast");
                $.ajax({
                    async: false,
                    type: "POST",
                    url: "Indexing.aspx/getPath",
                    data: "{'entryDateInfo':'" + hfScanningDate.val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (result) {
                        if (result.d != null) {
                            if (result.d.length > 0) {
                                if (result.d != "equal") {
                                    divIcons.html("");
                                    //divIcons.append("<ul>");
                                    for (var i = 0; i < result.d.length; i++) {
                                        var iframe = $("iframe[id$='_frmPDFViewer']");
                                        if (iframe.length > 0) {
                                            currentPDfFilePath = result.d[0];
                                            currentPDfFilePath = currentPDfFilePath.replace(/\\/g, "\\\\");
                                            iframe.attr("src", "PDFViewer.aspx?filePath=" + currentPDfFilePath);
                                        }
                                        var localFileWithPath = result.d[i];
                                        var fileArryList = localFileWithPath.split('\\');
                                        var fileName = fileArryList[fileArryList.length - 1];
                                        var fileWordLength = fileName.length;
                                        localFileWithPath = localFileWithPath.replace(/\\/g, "\\\\");
                                        if (fileWordLength > 9) {
                                            divIcons.append("<div id='" + fileName + "' class='pdfImg' title='" + fileName + "' path='PDFViewer.aspx?filePath=" + localFileWithPath + "' onclick=javascript:if(previewPdf(\'PDFViewer.aspx?filePath=" + localFileWithPath + "'));>" + fileName.substring(0, 6) + "...</div>");
                                            //divIcons.append("<li><img id='" + fileName + "' src='../image/pdfIcon1.png' title='" + fileName + "' path='PDFViewer.aspx?filePath=" + localFileWithPath + "' onclick=javascript:if(previewPdf(\'PDFViewer.aspx?filePath=" + localFileWithPath + "')); />" + fileName.substring(0, 6) + "...</li>");
                                        }
                                        else {
                                            divIcons.append("<div id='" + fileName + "' class='pdfImg' title='" + fileName + "' path='PDFViewer.aspx?filePath=" + localFileWithPath + "' onclick=javascript:if(previewPdf(\'PDFViewer.aspx?filePath=" + localFileWithPath + "'));>" + fileName + "</div>");
                                            //divIcons.append("<li><img id='" + fileName + "' src='../image/pdfIcon1.png' title='" + fileName + "' path='PDFViewer.aspx?filePath=" + localFileWithPath + "' onclick=javascript:if(previewPdf(\'PDFViewer.aspx?filePath=" + localFileWithPath + "')); />" + fileName + "</li>");
                                        }
                                        totalFiles++;
                                    }
                                    //divIcons.append("</ul>");
                                    var sessVal = '<%=Session["TotalIndexFiles"]%>';
                                    MessegeArea("Unindexed files: " + totalFiles + ", Indexed files: " + sessVal, 'success');
                                    $(".fancybox-close").click();
                                    lblTotalFiles.text("Unindexed files: " + totalFiles);
                                    //$.session.get('TotalIndexFiles')
                                    $("#divEntryForm").show('fast');
                                    HidePopup();
                                }
                                else {
                                    MessegeArea("All files are already indexed", "Error");
                                }
                            }
                            else {
                                MessegeArea("There is no file to load", "Error");
                            }
                        }
                    },
                    error: function () {
                        MessegeArea("An error has occurred during uploadImage processing.", "Error");
                        $("#Loading").slideUp("fast");
                    }
                });
            }
            $("#Loading").slideUp("fast");
            removeTabAtt();
            return false;
        }

        function previewPdf(url, fileName) {
            var iframe = $("iframe[id$='_frmPDFViewer']");
            if (iframe.length > 0) {
                if (fileName != undefined) {
                    currentPDfFilePath = fileName;
                    iframe.attr("src", url + fileName);
                }
                else {
                    currentPDfFilePath = url;
                    iframe.attr("src", url);
                }
                return true;
            }
        }

        function getPdf() {
            var scanningDate = $("input[id$='_txtScanDate']");
            var dayMonthYear = scanningDate.split('-');
            $.ajax({
                async: false,
                type: "POST",
                url: "Indexing.aspx/getDehForDropDown",
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
                    MessegeArea("An error has occurred during GetPDF processing.", "Error");
                }
            });
        }

        function metaDataValidation(ddlZilla, ddlTaluka, ddlDeh, ddlBookType, txtScanningNo, txtScanningDate, txtEntryNo,
                 txtEntryDate, txtSurveyNo, txtBookNo, txtPageNo, txtOwnerName) {
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
            if (ddlBookType.val() == "" || ddlBookType.val() == "0") {
                ddlBookType.removeClass("DropDownBG").addClass("DropDownError");
                ddlBookType.focus();
                MessegeArea("Please select book type", "error");
                isValid = false;
                return isValid;
            }
            else {
                ddlBookType.removeClass("DropDownError").addClass("DropDownBG");
            }
            if (txtScanningDate.val() == "") {
                txtScanningDate.removeClass("textBoxBG").addClass("textBoxError");
                txtScanningDate.focus();
                MessegeArea("Please enter scanning date", "error");
                isValid = false;
                return isValid;
            }
            else {
                txtScanningDate.removeClass("textBoxError").addClass("textBoxBG");
            }
            var filter = /(?!3[2-9]|00|02-3[01]|04-31|06-31|09-31|11-31)[0-3][0-9]-(?!1[3-9]|00)[01][0-9]-(?!10|28|29)[12][089][0-9][0-9]/;
            if (txtScanningDate.val() != "" && !filter.test(txtScanningDate.val())) {
                txtScanningDate.removeClass("textBoxBG").addClass("textBoxError");
                txtScanningDate.focus();
                MessegeArea("Please enter correct scanning date format e.g dd-MM-yyyy", "error");
                isValid = false;
                return isValid;
            }
            else {
                txtScanningDate.removeClass("textBoxError").addClass("textBoxBG");
            }

            if (txtEntryNo.val() == "") {
                txtEntryNo.removeClass("textBoxBG").addClass("textBoxError");
                txtEntryNo.focus();
                MessegeArea("Please enter entry number", "error");
                isValid = false;
                return isValid;
            }
            else {
                txtEntryNo.removeClass("textBoxError").addClass("textBoxBG");
            }
            if (txtEntryDate.val() == "") {
                txtEntryDate.removeClass("textBoxBG").addClass("textBoxError");
                txtEntryDate.focus();
                MessegeArea("Please enter entry date", "error");
                isValid = false;
                return isValid;
            }
            else {
                txtEntryDate.removeClass("textBoxError").addClass("textBoxBG");
            }
            if (txtEntryDate.val() != "" && !filter.test(txtEntryDate.val())) {
                txtEntryDate.removeClass("textBoxBG").addClass("textBoxError");
                txtEntryDate.focus();
                MessegeArea("Please enter correct entry date format e.g dd-MM-yyyy", "error");
                isValid = false;
                return isValid;
            }
            else {
                txtEntryDate.removeClass("textBoxError").addClass("textBoxBG");
            }
            if (txtSurveyNo.val() == "") {
                txtSurveyNo.removeClass("textBoxBG").addClass("textBoxError");
                txtSurveyNo.focus();
                MessegeArea("Please enter survey number", "error");
                isValid = false;
                return isValid;
            }
            else {
                txtSurveyNo.removeClass("textBoxError").addClass("textBoxBG");
            }
            if (txtOwnerName.val() == "") {
                txtOwnerName.removeClass("textBoxBG").addClass("textBoxError");
                txtOwnerName.focus();
                MessegeArea("Please enter owner name", "error");
                isValid = false;
                return isValid;
            }
            else {
                txtOwnerName.removeClass("textBoxError").addClass("textBoxBG");
            }
            return isValid;
        }

        function saveMetaData(Edit) {
        var ddlZilla = "";
        var ddlZillaText = ""; 
        var ddlTaluka = "";
        var ddlTalukaText = "";
        var ddlDeh = "";
        var ddlDehText = "";
        var ddlBookType = "";
        var ddlBookTypeText = "";
        var txtScheme = "";
        var txtScanningNo = "";
        var txtScanningDate = "";
        var txtEntryNo = "";
        var txtEntryDate = "";
        var txtSurveyNo = "";
        var txtBookNo = "";
        var txtPageNo = "";
        var txtOwnerName = "";
        var txtCNICNo = "";
        if (Edit != "") {
            ddlZilla = $("select[id$='_ddlZillaEdit']");
            ddlZillaText = $("[id*='ddlZillaEdit'] :selected").text();
            ddlTaluka = $("select[id$='_ddlTalukaEdit']");
            ddlTalukaText = $("[id*='ddlTalukaEdit'] :selected").text();
            ddlDeh = $("select[id$='_ddlDehEdit']");
            ddlDehText = $("[id*='ddlDehEdit'] :selected").text();
            ddlBookType = $("select[id$='_ddlBookTypeEdit']");
            ddlBookTypeText = $("[id*='ddlBookTypeEdit'] :selected").text();
            txtScheme = $("input[id$='_txtSchemeEdit']");
            txtScanningNo = $("input[id$='_txtScanNoEdit']");
            txtScanningDate = $("input[id$='_txtScanDateEdit']");
            txtEntryNo = $("input[id$='_txtEntryNoEdit']");
            txtEntryDate = $("input[id$='_txtEntryDateEdit']");
            txtSurveyNo = $("input[id$='_txtSurveyNoEdit']");
            txtBookNo = $("input[id$='_txtBookNoEdit']");
            txtPageNo = $("input[id$='_txtPageNoEdit']");
            txtOwnerName = $("input[id$='_txtOwnerNameEdit']");
            txtCNICNo = $("input[id$='_txtCNICNoEdit']");
        }
        else {
            ddlZilla = $("select[id$='_ddlZilla']");
            ddlZillaText = $("[id*='ddlZilla'] :selected").text();
            ddlTaluka = $("select[id$='_ddlTaluka']");
            ddlTalukaText = $("[id*='ddlTaluka'] :selected").text();
            ddlDeh = $("select[id$='_ddlDeh']");
            ddlDehText = $("[id*='ddlDeh'] :selected").text();
            ddlBookType = $("select[id$='_ddlBookType']");
            ddlBookTypeText = $("[id*='ddlBookType'] :selected").text();
            txtScheme = $("input[id$='_txtScheme']");
            txtScanningNo = $("input[id$='_txtScanNo']");
            txtScanningDate = $("input[id$='_txtScanDate']");
            txtEntryNo = $("input[id$='_txtEntryNo']");
            txtEntryDate = $("input[id$='_txtEntryDate']");
            txtSurveyNo = $("input[id$='_txtSurveyNo']");
            txtBookNo = $("input[id$='_txtBookNo']");
            txtPageNo = $("input[id$='_txtPageNo']");
            txtOwnerName = $("input[id$='_txtOwnerName']");
            txtCNICNo = $("input[id$='_txtCNICNo']");

        }
            if (ddlZilla.val() != "" && ddlZilla.val() != "0" && ddlTaluka.val() != "" && ddlTaluka.val() != "0" && ddlDeh.val() != "" && ddlDeh.val() != "0"
            && ddlBookType.val() != "" && ddlBookType.val() != "0" && txtScanningDate.val() != "" && txtEntryNo.val() != "" && txtEntryDate.val() != ""
            && txtSurveyNo.val() != "" && txtOwnerName.val() != "") {
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
                var scanningNo = "";
                if (txtScanningNo.length > 0) {
                    scanningNo = txtScanningNo.val();
                }
                var scanningDate = "";
                if (txtScanningDate.length > 0) {
                    scanningDate = txtScanningDate.val();
                }
                var entryNo = "";
                if (txtEntryNo.length > 0) {
                    entryNo = txtEntryNo.val();
                }
                var entryDate = "";
                if (txtEntryDate.length > 0) {
                    entryDate = txtEntryDate.val();
                }
                var surveyNo = "";
                if (txtSurveyNo.length > 0) {
                    surveyNo = txtSurveyNo.val();
                }
                var bookNo = "";
                if (txtBookNo.length > 0) {
                    bookNo = txtBookNo.val();
                }
                var pageNo = "";
                if (txtPageNo.length > 0) {
                    pageNo = txtPageNo.val();
                }
                var ownerName = "";
                if (txtOwnerName.length > 0) {
                    ownerName = txtOwnerName.val();
                }
                var cnicNo = "";
                if (txtCNICNo.length > 0) {
                    cnicNo = txtCNICNo.val();
                }
                currentPDfFilePath = currentPDfFilePath.replace(/\\/g, "\\\\");
                var splitFilePath = currentPDfFilePath.split('=');
                var filePath = "";
                if (splitFilePath.length > 1) {
                    filePath = splitFilePath[1];
                }
                else {
                    filePath = splitFilePath[0];
                }
                var hfIndexingId = $("input[id$='_hfIndexingId']").val();
                var lblTotalFiles = $("span[id$='_lblTotalFiles']");
                var totalFiles = lblTotalFiles.text();
                $.ajax({
                    async: false,
                    type: "POST",
                    url: "Indexing.aspx/saveMetaData",
                    data: "{'zillaId':'" + zillaId + "', 'zillaText': '" + ddlZillaText + "', 'talukaId': '" + talukaId + "', 'talukaText': '" + ddlTalukaText +
                    "', 'dehId': '" + dehId + "', 'dehText': '" + ddlDehText + "', 'bookTypeId': '" + bookTypeId + "', 'bookTypeText': '" + ddlBookTypeText +
                    "', 'scheme': '" + scheme + "', 'scanningNo': '" + scanningNo + "', 'scanningDate': '" + scanningDate + "', 'entryNo': '" + entryNo +
                    "', 'entryDate': '" + entryDate + "', 'surveyNo': '" + surveyNo + "', 'bookNo': '" + bookNo + "', 'pageNo': '" + pageNo +
                    "', 'ownerName': '" + ownerName + "', 'cnicNo': '" + cnicNo + "', 'currentPDfFile': '" + filePath + "', 'IndexingId': '" + hfIndexingId + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (result) {
                        if (result.d != null) {
                            if (result.d.length > 0) {
                                if (result.d == "success") {
                                    // var fileArryList = currentPDfFilePath.split('\\\\');
                                    // var divId = fileArryList[fileArryList.length - 1];
                                    // var divIcons = $("#divIcons");
                                    // divIcons.find($("div[id$='" + divId + "']").remove());
                                    // //divIcons.find(document.getElementById(divId).remove());
                                    // MessegeArea("Metadata store successfully.", "success");
                                    // totalFiles = totalFiles - 1;
                                    // resetFields();
                                    // if (divIcons[0].children.length > 0) {
                                    //     currentPDfFilePath = divIcons[0].children[0].attributes.path.value;
                                    //     previewPdf(currentPDfFilePath, undefined);
                                    // }
                                    // else {
                                    //     previewPdf("", undefined);
                                    // }
                                    nextLoadFile(result.d);

                                }
                                else if (result.d == "update") {
                                    MessegeArea("Metadata udpate successfully.", "success");
                                }
                                else {
                                    MessegeArea(result.d, "error");
                                }
                            }
                        }
                    },
                    error: function () {
                        MessegeArea("An error has occurred during saveMetaData processing.", "error");
                    }
                });
            }
            else {
                metaDataValidation(ddlZilla, ddlTaluka, ddlDeh, ddlBookType, txtScanningNo, txtScanningDate, txtEntryNo, txtEntryDate, txtSurveyNo, txtBookNo, txtPageNo, txtOwnerName);
            }
            return true;
        }

        function nextLoadFile(result) {
            var fileArryList = currentPDfFilePath.split('\\\\');
            var divId = fileArryList[fileArryList.length - 1];
            var divIcons = $("#divIcons");
            divIcons.find($("div[id$='" + divId + "']").remove());
            //divIcons.find(document.getElementById(divId).remove());
            if (result == 'success') {
                MessegeArea("Metadata store successfully.", "success");
            }
            else {
                MessegeArea("File <b>" + divId + "</b> is skip", "success");
            }
            //totalFiles = totalFiles - 1;
            resetFields();
            if (divIcons[0].children.length > 0) {
                currentPDfFilePath = divIcons[0].children[0].attributes.path.value;
                previewPdf(currentPDfFilePath, undefined);
            }
            else {
                previewPdf("", undefined);
            }
        }

        function resetFields() {
            //var ddlZilla = $("select[id$='_ddlZilla']").val("0");
            //var ddlTaluka = $("select[id$='_ddlTaluka']").val("");
            //var ddlDeh = $("select[id$='_ddlDeh']").val("");
            //var ddlBookType = $("select[id$='_ddlBookType']");
            //var txtScheme = $("input[id$='_txtScheme']").val("");
            //var txtScanningNo = $("input[id$='_txtScanNo']").val("");
            //var txtEntryNo = $("input[id$='_txtEntryNo']").val("");
            var txtSurveyNo = $("input[id$='_txtSurveyNo']").val("");
            var txtOwnerName = $("input[id$='_txtOwnerName']").val("");
            var txtCNICNo = $("input[id$='_txtCNICNo']").val("");
        }


        function showFancybox() {
            $.fancybox($("#divPopup").html(),
            {
                'autoDimensions': false,
                'width': 'auto',
                'height': 'auto',
                'transitionIn': 'none',
                'transitionOut': 'none'
            });
        }

        function ShowPopup() {
            //$("input[id$='_mpeLoad']").show();
            $("input[id$='_txtLoadImageScanDate']").val("");
            $("input[id$='_txtLoadImageEntryDate']").val("");
        }

        function HidePopup() {
            $(".modelPopup").hide();
            $("#divPopup").hide("slow");
        }

        function removeTabAtt() {
            $("select").removeAttr("tabindex");
            $("input").removeAttr("tabindex");
        }

        function runScript(e) {
            if (e.keyCode == 13) {
                saveMetaData('');
            }
        }

    </script>
    <div id="header" class="container_12">
    </div>
    <ajax:ModalPopupExtender ID="mpeLoad" runat="server" TargetControlID="popup" PopupControlID="divPopup" BackgroundCssClass="modelPopup" PopupDragHandleControlID="divPopup"></ajax:ModalPopupExtender>
    
    <div id="IndexingDiv" style="width: 100%; min-height:350px;">
        <div id="LoadImage" style="width:100%; float:left; padding-bottom:10; height:25px; padding-top:5px; background-color:#B0CCD7;">
            <%--<a id="popup" href="javascript:showFancybox();" class='fancybox' style="padding-left:24px; color:White;">Load Image</a>--%>
            <a id="popup" runat="server" href="javascript:void(0);" onclick="ShowPopup();" class='fancybox' style="padding-left:24px; color:White;">Load PDf Files</a>
        </div>
        <%if (Request.QueryString["IndexingId"] == null)
          {%>
        <div id="divPopup" style="display: none;">
            <div style="width:100%; text-align:right; left:10px; top:-15px; position:absolute;">
                <img id="closePop" src="image/Close_Popup.png" alt="" style="cursor:pointer;" onclick="HidePopup();" />
            </div>
            <div style="width: 340px;" id="divLoadImage">
                <div style="clear: both; width: 100%;">
                    <div class="leftCaptionLoadPopup">
                        <asp:Label ID="lblLoadImageScanningDate" runat="server" Text="Scanning Date"></asp:Label>
                    </div>
                    <div class="RightValueDivControlPopup">
                        <asp:TextBox ID="txtLoadImageScanDate" runat="server" CssClass="textBoxBG" Width="165px" placeholder="dd-MM-yyyy" ></asp:TextBox>
                        <div style="float:right; padding-right:10px;"><img src="image/calendar-icon.png" alt="" id="scanCal" style="cursor:pointer;" /></div>
                            <%--<ajax:TextBoxWatermarkExtender ID="watermarkCon" runat="server" Enabled="true" TargetControlID="txtLoadImageScanDate" WatermarkText="dd-MM-yyyy"></ajax:TextBoxWatermarkExtender>--%>
                        <ajax:CalendarExtender runat="server" TargetControlID="txtLoadImageScanDate" Format="dd-MM-yyyy" PopupButtonID="scanCal" ></ajax:CalendarExtender>
                    </div>
                </div>
                <div style="clear: both; width: 100%;">
                    <div class="leftCaptionLoadPopup">
                        <asp:Label ID="lblLoadImageEntryDate" runat="server" Text="Entry Date"></asp:Label>
                    </div>
                    <div class="RightValueDivControlPopup">
                        <asp:TextBox ID="txtLoadImageEntryDate" runat="server" CssClass="textBoxBG" Width="165px" placeholder="dd-MM-yyyy"></asp:TextBox>
                        <div style="float:right; padding-right:10px;"><img src="image/calendar-icon.png" alt="" id="entryCal" style="cursor:pointer;" /></div>
                        <%--<ajax:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1" runat="server" Enabled="true" TargetControlID="txtLoadImageEntryDate" WatermarkText="dd-MM-yyyy"></ajax:TextBoxWatermarkExtender>--%>
                        <ajax:CalendarExtender runat="server" TargetControlID="txtLoadImageEntryDate" Format="dd-MM-yyyy" PopupButtonID="entryCal" ></ajax:CalendarExtender>
                    </div>
                </div>
                <div style="clear: both; width: 100%;">
                    <%--<div style="width: 100%; padding-top:7px;">
                        <asp:FileUpload ID="fuImageFile" runat="server" CssClass="textBoxBG" Width="292px"
                            multiple="true" />&nbsp;
                    </div>--%>
                    <div style="float:right; clear:both; padding-right:54px; padding-top:5px;">
                        <asp:Button ID="btnUpload" runat="server" Text="Load images" CssClass="LoginButton" OnClientClick="if(!uploadImage()) return false;" />
                    </div>
                </div>
            </div>
        </div>
        <%}%>
        <%if (Request.QueryString["state"] != null && Request.QueryString["state"] == "print")
          {%>
            <div style="width:100%; padding-top:10px;">
                <div style="float:left; width:33%; text-align:right;">
                    <img src="image/sindhLogoBlack.png" alt="" />
                </div>
                <div style="float:left; width:60%; padding-top:25px; padding-left:25px;">
                    <div style="float:left; font-size:30px; text-align:center;">Provincial Record Cell, Board Of Revenue Sindh</div>
                    <div style="float:left; clear:both; text-align:center; font-size:21px; padding-top:8px;">1st Floor, Shahbaz Building Block "D" Hyderabad Ph:9201116-1117</div>
                </div>
            </div>
            <%} %>
        <div style="width: 100%; clear: both; display:none; padding-top:20px;" id="divEntryForm">
            <div style="width: 23%; min-height: 400px; float: left;">
                <%if (Request.QueryString["state"] == null)
                  {%>
                  <asp:UpdatePanel ID="upState" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                    <div style="clear: both; width: 100%;">
                        <div class="leftCaptionDivControl">
                            <asp:Label ID="lblZillaEntry" runat="server" Text="Zilla:"></asp:Label>
                        </div>
                        <div class="RightValueDivControl">
                            <asp:DropDownList ID="ddlZilla" runat="server" CssClass="DropDownBG" onchange="javascript:fillTaluka('');">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div style="clear: both; width: 100%;">
                        <div class="leftCaptionDivControl">
                            <asp:Label ID="lblTalukaEntry" runat="server" Text="Taluka:"></asp:Label>
                        </div>
                        <div class="RightValueDivControl">
                            <asp:DropDownList ID="ddlTaluka" runat="server" CssClass="DropDownBG" onchange="javascript:fillDeh('');" >
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div style="clear: both; width: 100%;">
                        <div class="leftCaptionDivControl">
                            <asp:Label ID="lblDehEntry" runat="server" Text="Deh:"></asp:Label>
                        </div>
                        <div class="RightValueDivControl">
                            <asp:DropDownList ID="ddlDeh" runat="server" CssClass="DropDownBG" >
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div style="clear: both; width: 100%;">
                        <div class="leftCaptionDivControl">
                            <asp:Label ID="lblBookTypeEntry" runat="server" Text="Book Type:"></asp:Label>
                        </div>
                        <div class="RightValueDivControl">
                            <asp:DropDownList ID="ddlBookType" runat="server" CssClass="DropDownBG" >
                                <asp:ListItem Value="0" Text="<-- SELECT -->"></asp:ListItem>
                                <asp:ListItem Value="2" Text="VF-II"></asp:ListItem>
                                <asp:ListItem Value="7" Text="VF-VII-A"></asp:ListItem>
                                <asp:ListItem Value="15" Text="VF-VII-B"></asp:ListItem>
                                <asp:ListItem Value="3" Text="DK Book"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div style="clear: both; width: 100%;">
                        <div class="leftCaptionDivControl">
                            <asp:Label ID="lblSchemeEntry" runat="server" Text="Scheme:"></asp:Label>
                        </div>
                        <div class="RightValueDivControl">
                            <asp:TextBox ID="txtScheme" runat="server" CssClass="textBoxBG" ></asp:TextBox>
                        </div>
                    </div>
                    <div style="clear: both; width: 100%;">
                        <div class="leftCaptionDivControl">
                            <asp:Label ID="lblScanNoEntry" runat="server" Text="Scan No:"></asp:Label>
                        </div>
                        <div class="RightValueDivControl">
                            <asp:TextBox ID="txtScanNo" runat="server" CssClass="textBoxBG" ></asp:TextBox>
                        </div>
                    </div>
                    <div style="clear: both; width: 100%;">
                        <div class="leftCaptionDivControl">
                            <asp:Label ID="lblScanDateEntry" runat="server" Text="Scan Date:"></asp:Label>
                        </div>
                        <div class="RightValueDivControl">
                            <asp:TextBox ID="txtScanDate" runat="server" CssClass="textBoxBG"></asp:TextBox>
                        </div>
                    </div>
                    <div style="clear: both; width: 100%;">
                        <div class="leftCaptionDivControl">
                            <asp:Label ID="lblEntryNoEntry" runat="server" Text="Entry No:"></asp:Label>
                        </div>
                        <div class="RightValueDivControl">
                            <asp:TextBox ID="txtEntryNo" runat="server" CssClass="textBoxBG" ></asp:TextBox>
                        </div>
                    </div>
                    <div style="clear: both; width: 100%;">
                        <div class="leftCaptionDivControl">
                            <asp:Label ID="lblEntryDateEntry" runat="server" Text="Entry Date:"></asp:Label>
                        </div>
                        <div class="RightValueDivControl">
                            <asp:TextBox ID="txtEntryDate" runat="server" CssClass="textBoxBG" ></asp:TextBox>
                        </div>
                    </div>
                    <div style="clear: both; width: 100%;">
                        <div class="leftCaptionDivControl">
                            <asp:Label ID="lblSurveyNoEntry" runat="server" Text="Survey No:"></asp:Label>
                        </div>
                        <div class="RightValueDivControl">
                            <asp:TextBox ID="txtSurveyNo" runat="server" CssClass="textBoxBG" ></asp:TextBox>
                        </div>
                    </div>
                    <div style="clear: both; width: 100%;">
                        <div class="leftCaptionDivControl">
                            <asp:Label ID="lblBookNoEntry" runat="server" Text="Book No:"></asp:Label>
                        </div>
                        <div class="RightValueDivControl">
                            <asp:TextBox ID="txtBookNo" runat="server" CssClass="textBoxBG" ></asp:TextBox>
                        </div>
                    </div>
                    <div style="clear: both; width: 100%;">
                        <div class="leftCaptionDivControl">
                            <asp:Label ID="lblPageNoEntry" runat="server" Text="Page No:"></asp:Label>
                        </div>
                        <div class="RightValueDivControl">
                            <asp:TextBox ID="txtPageNo" runat="server" CssClass="textBoxBG" ></asp:TextBox>
                        </div>
                    </div>
                    <div style="clear: both; width: 100%;">
                        <div class="leftCaptionDivControl">
                            <asp:Label ID="lblOwnerNameEntry" runat="server" Text="Owner Name:"></asp:Label>
                        </div>
                        <div class="RightValueDivControl">
                            <asp:TextBox ID="txtOwnerName" runat="server" CssClass="textBoxBG"></asp:TextBox>
                        </div>
                    </div>
                    <div style="clear: both; width: 100%;">
                        <div class="leftCaptionDivControl">
                            <asp:Label ID="lblCNICNoEntry" runat="server" Text="CNIC No:"></asp:Label>
                        </div>
                        <div class="RightValueDivControl">
                            <asp:TextBox ID="txtCNICNo" runat="server" CssClass="textBoxBG" ></asp:TextBox>
                        </div>
                    </div>
                    <div style="clear: both; width: 100%; padding-top:20px;">
                        <div style="width: 95%; padding-left:15px;">
                            <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="LoginButton" OnClientClick="javascript:saveMetaData(''); return false;" />&nbsp;
                            <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="LoginButton" OnClientClick="javascript:resetFields(); return false;" />
                            <asp:Button ID="btnSkip" runat="server" Text="Skip" CssClass="LoginButton" OnClientClick="javascript:nextLoadFile(); return false;" />
                        </div>
                    </div>
                    </ContentTemplate>
                  </asp:UpdatePanel>
                  <%}
                  else if (Request.QueryString["state"] != null && Request.QueryString["state"] == "edit")
                    {%>
                    <asp:UpdatePanel ID="upEdit" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                    <div style="clear: both; width: 100%;">
                        <div class="leftCaptionDivControl">
                            <asp:Label ID="lblZillaEdit" runat="server" Text="Zilla:"></asp:Label>
                        </div>
                        <div class="RightValueDivControl">
                            <asp:DropDownList ID="ddlZillaEdit" runat="server" CssClass="DropDownBG" onchange="javascript:fillTaluka('Edit');">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div style="clear: both; width: 100%;">
                        <div class="leftCaptionDivControl">
                            <asp:Label ID="lblTalukaEdit" runat="server" Text="Taluka:"></asp:Label>
                        </div>
                        <div class="RightValueDivControl">
                            <asp:DropDownList ID="ddlTalukaEdit" runat="server" CssClass="DropDownBG" onchange="javascript:fillDeh('Edit');">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div style="clear: both; width: 100%;">
                        <div class="leftCaptionDivControl">
                            <asp:Label ID="lblDehEdit" runat="server" Text="Deh:"></asp:Label>
                        </div>
                        <div class="RightValueDivControl">
                            <asp:DropDownList ID="ddlDehEdit" runat="server" CssClass="DropDownBG">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div style="clear: both; width: 100%;">
                        <div class="leftCaptionDivControl">
                            <asp:Label ID="lblBookTypeEdit" runat="server" Text="Book Type:"></asp:Label>
                        </div>
                        <div class="RightValueDivControl">
                            <asp:DropDownList ID="ddlBookTypeEdit" runat="server" CssClass="DropDownBG">
                                <asp:ListItem Value="0" Text="<-- SELECT -->"></asp:ListItem>
                                <asp:ListItem Value="2" Text="VF-II"></asp:ListItem>
                                <asp:ListItem Value="7" Text="VF-VII-A"></asp:ListItem>
                                <asp:ListItem Value="15" Text="VF-VII-B"></asp:ListItem>
                                <asp:ListItem Value="3" Text="DK Book"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div style="clear: both; width: 100%;">
                        <div class="leftCaptionDivControl">
                            <asp:Label ID="lblSchemeEdit" runat="server" Text="Scheme:"></asp:Label>
                        </div>
                        <div class="RightValueDivControl">
                            <asp:TextBox ID="txtSchemeEdit" runat="server" CssClass="textBoxBG"></asp:TextBox>
                        </div>
                    </div>
                    <div style="clear: both; width: 100%;">
                        <div class="leftCaptionDivControl">
                            <asp:Label ID="lblScanNoEdit" runat="server" Text="Scan No:"></asp:Label>
                        </div>
                        <div class="RightValueDivControl">
                            <asp:TextBox ID="txtScanNoEdit" runat="server" CssClass="textBoxBG"></asp:TextBox>
                        </div>
                    </div>
                    <div style="clear: both; width: 100%;">
                        <div class="leftCaptionDivControl">
                            <asp:Label ID="lblScanDateEdit" runat="server" Text="Scan Date:"></asp:Label>
                        </div>
                        <div class="RightValueDivControl">
                            <asp:TextBox ID="txtScanDateEdit" runat="server" CssClass="textBoxBG"></asp:TextBox>
                        </div>
                    </div>
                    <div style="clear: both; width: 100%;">
                        <div class="leftCaptionDivControl">
                            <asp:Label ID="lblEntryNoEdit" runat="server" Text="Entry No:"></asp:Label>
                        </div>
                        <div class="RightValueDivControl">
                            <asp:TextBox ID="txtEntryNoEdit" runat="server" CssClass="textBoxBG"></asp:TextBox>
                        </div>
                    </div>
                    <div style="clear: both; width: 100%;">
                        <div class="leftCaptionDivControl">
                            <asp:Label ID="lblEntryDateEdit" runat="server" Text="Entry Date:"></asp:Label>
                        </div>
                        <div class="RightValueDivControl">
                            <asp:TextBox ID="txtEntryDateEdit" runat="server" CssClass="textBoxBG"></asp:TextBox>
                        </div>
                    </div>
                    <div style="clear: both; width: 100%;">
                        <div class="leftCaptionDivControl">
                            <asp:Label ID="lblSurveyNoEdit" runat="server" Text="Survey No:"></asp:Label>
                        </div>
                        <div class="RightValueDivControl">
                            <asp:TextBox ID="txtSurveyNoEdit" runat="server" CssClass="textBoxBG"></asp:TextBox>
                        </div>
                    </div>
                    <div style="clear: both; width: 100%;">
                        <div class="leftCaptionDivControl">
                            <asp:Label ID="lblBookNoEdit" runat="server" Text="Book No:"></asp:Label>
                        </div>
                        <div class="RightValueDivControl">
                            <asp:TextBox ID="txtBookNoEdit" runat="server" CssClass="textBoxBG"></asp:TextBox>
                        </div>
                    </div>
                    <div style="clear: both; width: 100%;">
                        <div class="leftCaptionDivControl">
                            <asp:Label ID="lblPageNoEdit" runat="server" Text="Page No:"></asp:Label>
                        </div>
                        <div class="RightValueDivControl">
                            <asp:TextBox ID="txtPageNoEdit" runat="server" CssClass="textBoxBG"></asp:TextBox>
                        </div>
                    </div>
                    <div style="clear: both; width: 100%;">
                        <div class="leftCaptionDivControl">
                            <asp:Label ID="lblOwnerNameEdit" runat="server" Text="Owner Name:"></asp:Label>
                        </div>
                        <div class="RightValueDivControl">
                            <asp:TextBox ID="txtOwnerNameEdit" runat="server" CssClass="textBoxBG"></asp:TextBox>
                        </div>
                    </div>
                    <div style="clear: both; width: 100%;">
                        <div class="leftCaptionDivControl">
                            <asp:Label ID="lblCNICNoEdit" runat="server" Text="CNIC No:"></asp:Label>
                        </div>
                        <div class="RightValueDivControl">
                            <asp:TextBox ID="txtCNICNoEdit" runat="server" CssClass="textBoxBG"></asp:TextBox>
                        </div>
                    </div>
                    <div style="clear: both; width: 100%; padding-top:20px;">
                        <div style="width: 95%; padding-left:15px;">
                            <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="LoginButton" OnClientClick="javascript:saveMetaData('Edit'); return false;" />
                        </div>
                    </div>
                    </ContentTemplate>
                  </asp:UpdatePanel>
                <%}
                  else
                  { %>
                  <asp:UpdatePanel ID="upPrint" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                    <div style="float:left; line-height:28px;">
                        <div style="clear: both; width: 100%;">
                            <div class="LeftLabelPrint">
                                <asp:Label ID="lblZillaView" runat="server" Text="Zilla:"></asp:Label>
                            </div>
                            <div class="RightValueDivControlLabelPrint">
                                <asp:Label ID="lblZillaName" runat="server" Text="" CssClass="labelValue"></asp:Label>
                            </div>
                        </div>
                        <div style="clear: both; width: 100%;">
                            <div class="LeftLabelPrint">
                                <asp:Label ID="lblTalukaView" runat="server" Text="Taluka:"></asp:Label>
                            </div>
                            <div class="RightValueDivControlLabelPrint">
                                <asp:Label ID="lblTalukaName" runat="server" Text="" CssClass="labelValue"></asp:Label>
                            </div>
                        </div>
                        <div style="clear: both; width: 100%;">
                            <div class="LeftLabelPrint">
                                <asp:Label ID="lblDehView" runat="server" Text="Deh:"></asp:Label>
                            </div>
                            <div class="RightValueDivControlLabelPrint">
                                <asp:Label ID="lblDehName" runat="server" Text="" CssClass="labelValue"></asp:Label>
                            </div>
                        </div>
                        <div style="clear: both; width: 100%;">
                            <div class="LeftLabelPrint">
                                <asp:Label ID="lblBookTypeView" runat="server" Text="Book Type:"></asp:Label>
                            </div>
                            <div class="RightValueDivControlLabelPrint">
                                <asp:Label ID="lblBookTypeName" runat="server" Text="" CssClass="labelValue"></asp:Label>
                            </div>
                        </div>
                        <div style="clear: both; width: 100%;">
                            <div class="LeftLabelPrint">
                                <asp:Label ID="lblSchemeView" runat="server" Text="Scheme:"></asp:Label>
                            </div>
                            <div class="RightValueDivControlLabelPrint">
                                <asp:Label ID="lblSchemeName" runat="server" Text="" CssClass="labelValue"></asp:Label>
                            </div>
                        </div>
                        <div style="clear: both; width: 100%;">
                            <div class="LeftLabelPrint">
                                <asp:Label ID="lblScanNoView" runat="server" Text="Scan No:"></asp:Label>
                            </div>
                            <div class="RightValueDivControlLabelPrint">
                                <asp:Label ID="lblScanNoName" runat="server" Text="" CssClass="labelValue"></asp:Label>
                            </div>
                        </div>
                        <div style="clear: both; width: 100%;">
                            <div class="LeftLabelPrint">
                                <asp:Label ID="lblScanDateView" runat="server" Text="Scan Date:"></asp:Label>
                            </div>
                            <div class="RightValueDivControlLabelPrint">
                                <asp:Label ID="lblScanDateName" runat="server" Text="" CssClass="labelValue"></asp:Label>
                            </div>
                        </div>
                        <div style="clear: both; width: 100%;">
                            <div class="LeftLabelPrint">
                                <asp:Label ID="lblEntryNoView" runat="server" Text="Entry No:"></asp:Label>
                            </div>
                            <div class="RightValueDivControlLabelPrint">
                                <asp:Label ID="lblEntryNoName" runat="server" Text="" CssClass="labelValue"></asp:Label>
                            </div>
                        </div>
                        <div style="clear: both; width: 100%;">
                            <div class="LeftLabelPrint">
                                <asp:Label ID="lblEntryDateView" runat="server" Text="Entry Date:"></asp:Label>
                            </div>
                            <div class="RightValueDivControlLabelPrint">
                                <asp:Label ID="lblEntryDateName" runat="server" Text="" CssClass="labelValue"></asp:Label>
                            </div>
                        </div>
                        <div style="clear: both; width: 100%;">
                            <div class="LeftLabelPrint">
                                <asp:Label ID="lblSurveyNoView" runat="server" Text="Survey No:"></asp:Label>
                            </div>
                            <div class="RightValueDivControlLabelPrint">
                                <asp:Label ID="lblSurveyNoName" runat="server" Text="" CssClass="labelValue"></asp:Label>
                            </div>
                        </div>
                        <div style="clear: both; width: 100%;">
                            <div class="LeftLabelPrint">
                                <asp:Label ID="lblBookNoView" runat="server" Text="Book No:"></asp:Label>
                            </div>
                            <div class="RightValueDivControlLabelPrint">
                                <asp:Label ID="lblBookNoName" runat="server" Text="" CssClass="labelValue"></asp:Label>
                            </div>
                        </div>
                        <div style="clear: both; width: 100%;">
                            <div class="LeftLabelPrint">
                                <asp:Label ID="lblPageNoView" runat="server" Text="Page No:"></asp:Label>
                            </div>
                            <div class="RightValueDivControlLabelPrint">
                                <asp:Label ID="lblPageNoName" runat="server" Text="" CssClass="labelValue"></asp:Label>
                            </div>
                        </div>
                        <div style="clear: both; width: 100%;">
                            <div class="LeftLabelPrint">
                                <asp:Label ID="lblOwnerNameView" runat="server" Text="Owner Name:"></asp:Label>
                            </div>
                            <div class="RightValueDivControlLabelPrint">
                                <asp:Label ID="lblOwnerNameName" runat="server" Text="" CssClass="labelValue"></asp:Label>
                            </div>
                        </div>
                        <div style="clear: both; width: 100%;">
                            <div class="LeftLabelPrint">
                                <asp:Label ID="lblCNICNoView" runat="server" Text="CNIC No:"></asp:Label>
                            </div>
                            <div class="RightValueDivControlLabelPrint">
                                <asp:Label ID="lblCNICNoName" runat="server" Text="" CssClass="labelValue"></asp:Label>
                            </div>
                        </div>
                        <div style="clear: both; width: 100%;">
                            <div style="width: 80%;">
                                <div id="aside" class="grid_3 push_1">
                                </div>
                            </div>
                        </div>
                    </div>
                    </ContentTemplate>
                  </asp:UpdatePanel>
                <% }%>
            </div>
            <div style="width: 77%; min-height: 400px; float: left;">
                <div style="width: 100%;">
                    <div style="width: 98%; overflow: hidden; padding:5px;">
                        <iframe id="frmPDFViewer" runat="server" height="600px" width="100%" name="PDF-Viewer" />
                    </div>
                </div>
                <div style="width: 100%; clear: both; float: left;">
                    <div style="float: left; overflow: hidden; width: 100%; height: 25px;">
                        <asp:Label ID="lblTotalFiles" runat="server" Text=""></asp:Label>
                    </div>
                </div>
            </div>
            <div style="width: 100%; clear: both; padding-left:10px; padding-top:20px;">
                <div id="divIcons" style="float: left; width: 98%; white-space:nowrap; min-height: 50px;">
                </div>
            </div>
        </div>
        <asp:HiddenField ID="hfScanningDate" runat="server" />
        <asp:HiddenField ID="hfEntryDate" runat="server" />
        <asp:HiddenField ID="hfIndexingId" runat="server" />
    </div>
</asp:Content>
