
function AddNewItems(idAdd, idText) {
    $("#" + idAdd).slideToggle("slow");
    $("#" + idText).slideToggle("slow");
}

function addZilla() {
    var ddlZilla = $("select[id$='_ddlZilla']");
    var Zilla = "";
    if (ddlZilla.length > 0) {
        Zilla = ddlZilla.val();
    }
    var txtZillaName = $("input[id$='_txtZillaName']");
    var ZillaName = "";
    if (txtZillaName.length > 0) {
        ZillaName = txtZillaName.val();
    }
    if (ZillaName != "") {
        $.ajax({
            type: "POST",
            url: "Territory.aspx/AddZilla",
            data: "{'zillaName':'" + ZillaName + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                if (result.d != null) {
                    if (result.d == "success") {
                        fillZilla();
                        AddNewItems("divAddNewZilla", "divAddZilla");
                        $("input[id$='_txtZillaName']").val('');
                        MessegeArea("Zilla added successfully", "success");
                    }
                    else {
                        MessegeArea("Zilla Already exist", "Error");
                    }
                }
                else {
                    MessegeArea("addZilla has null value.", "Error");
                }
            },
            error: function () {
                MessegeArea("An error has occurred during addZilla processing.", "Error");
            }
        });
    }
    else {
        MessegeArea("Please enter Zilla Name", "Error");
        txtZillaName.removeClass("textBoxBG").addClass("textBoxError");
        txtZillaName.focus();
    }
}

function requiredTalukaFields(ddlZilla, TalukaName) {
    if (ddlZilla.val() == null || ddlZilla[0].value == "" || ddlZilla.val() == "" || ddlZilla.val() == "0") {
        ddlZilla.removeClass("DropDownBG").addClass("DropDownError");
        ddlZilla.focus();
        MessegeArea("Please select Zilla", "error");
        return false;
    }
    else {
        ddlZilla.removeClass("DropDownError").addClass("DropDownBG");
    }
    if (TalukaName.val() == "") {
        TalukaName.removeClass("textBoxBG").addClass("textBoxError");
        TalukaName.focus();
        MessegeArea("Please enter taluka name", "error");
        return false;
    }
    else {
        TalukaName.removeClass("textBoxError").addClass("textBoxBG");
    }
    return true;
}

function addTaluka() {
    var ddlTaluka = $("select[id$='_ddlTaluka']");
    var ddlZilla = $("select[id$='_ddlZilla']");
    var txtTalukaName = $("input[id$='_txtTalukaName']");
    var Taluka = "";
    if (ddlTaluka.length > 0) {
        Taluka = ddlTaluka.val();
    }

    var ZillaId = "";
    if (ddlZilla.length > 0) {
        ZillaId = ddlZilla.val();
    }
    var TalukaName = "";
    if (txtTalukaName.length > 0) {
        TalukaName = txtTalukaName.val();
    }
    if (txtTalukaName.val() != "" && ddlZilla.val() != "" && ddlZilla.val() != "0") {
        $.ajax({
            type: "POST",
            url: "Territory.aspx/AddTaluka",
            data: "{'talukaName':'" + TalukaName + "', 'zillaId':'" + ZillaId + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                if (result.d != null) {
                    if (result.d == "success") {
                        fillTaluka('');
                        AddNewItems("divAddNewTaluka", "divAddTaluka");
                        MessegeArea("Taluka added successfully", "success");
                    }
                    else {
                        MessegeArea(result.d, "error");
                    }
                }
                else {
                    MessegeArea("addTaluka has null value.", "Error");
                }
            },
            error: function () {
                MessegeArea("An error has occurred during addTaluka processing.", "Error");
            }
        });
    }
    else {
        requiredTalukaFields(ddlZilla, txtTalukaName);
    }
}

function addDeh() {
    var ddlDeh = $("select[id$='_ddlDeh']");
    var ddlTaluka = $("select[id$='_ddlTaluka']");
    var ddlZilla = $("select[id$='_ddlZilla']");
    var txtDehName = $("input[id$='_txtDehName']");

    var ZillaId = "";
    if (ddlZilla.length > 0) {
        ZillaId = ddlZilla.val();
    }
    var TalukaId = "";
    if (ddlTaluka.length > 0) {
        TalukaId = ddlTaluka.val();
    }
    var DehName = "";
    if (txtDehName.length > 0) {
        DehName = txtDehName.val();
    }

    if (txtDehName.val() != "" && ddlZilla.val() != "" && ddlZilla.val() != "0" && ddlTaluka.val() != null && ddlTaluka.val() != "" && ddlTaluka.val() != "0") {
        $.ajax({
            type: "POST",
            url: "Territory.aspx/AddDeh",
            data: "{'dehName':'" + DehName + "', 'talukaId':'" + TalukaId + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (result) {
                if (result.d != null) {
                    fillDeh('');
                    AddNewItems("divAddNewDeh", "divAddDeh");
                    MessegeArea("Deh added successfully", "success");
                }
                else {
                    MessegeArea("addDeh has null value.", "Error");
                }
            },
            error: function () {
                MessegeArea("An error has occurred during addDeh processing.", "Error");
            }
        });
    }
    else {
        requiredDehFields(ddlTaluka, ddlZilla, txtDehName);
    }
}

function requiredDehFields(ddlTaluka, ddlZilla, txtDehName) {
    if (ddlZilla.val() == "" || ddlZilla.val() == "0") {
        ddlZilla.removeClass("DropDownBG").addClass("DropDownError");
        ddlZilla.focus();
        MessegeArea("Please select Zilla", "error");
        return false;
    }
    else {
        ddlZilla.removeClass("DropDownError").addClass("DropDownBG");
    }
    if (ddlTaluka.val() == null || ddlTaluka.val() == "" || ddlTaluka.val() == "0") {
        ddlTaluka.removeClass("DropDownBG").addClass("DropDownError");
        ddlTaluka.focus();
        MessegeArea("Please select Taluka", "error");
        return false;
    }
    else {
        ddlTaluka.removeClass("DropDownError").addClass("DropDownBG");
    }
    if (txtDehName.val() == "") {
        txtDehName.removeClass("textBoxBG").addClass("textBoxError");
        txtDehName.focus();
        MessegeArea("Please enter deh name", "error");
        return false;
    }
    else {
        txtDehName.removeClass("textBoxError").addClass("textBoxBG");
    }
}
