<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Territory.aspx.cs" Inherits="Indexing.UI.Territory"
    MasterPageFile="~/PRC_Master.Master" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <script type="text/javascript" language="javascript">
        function fillZilla() {
            var ddlZilla = $("select[id$='_ddlZilla']");
            if (ddlZilla.length > 0) {
                $.ajax({
                    type: "POST",
                    url: "Territory.aspx/getZillaForDropDown",
                    data: '',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (result) {
                        if (result.d != null) {
                            if (result.d.length > 0) {
                                ddlZilla.html("");
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

        function fillTaluka() {
            var ddlZilla = "";
            var ddlTaluka = "";
            var ddlDeh = "";
            ddlZilla = $("select[id$='_ddlZilla']");
            ddlTaluka = $("select[id$='_ddlTaluka']");
            ddlDeh = $("select[id$='_ddlDeh']");
            if (ddlDeh.length > 0) {
                ddlDeh.empty();
            }
            if (ddlZilla.length > 0) {
                ddlTaluka.empty();
                if (ddlTaluka.length > 0 && ddlZilla.val() != "" && ddlZilla.val() != "0") {
                    $.ajax({
                        type: "POST",
                        url: "Territory.aspx/getTalukaForDropDown",
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
                            MessegeArea("An error has occurred during fillTaluka processing.", "Error");
                        }
                    });
                }
            }
        }

        function fillDeh() {
            var ddlTaluka = "";
            var ddlDeh = "";
            ddlTaluka = $("select[id$='_ddlTaluka']");
            ddlDeh = $("select[id$='_ddlDeh']");
            if (ddlTaluka.length > 0) {
                if (ddlDeh.length > 0) {
                    ddlDeh.empty();
                    if (ddlDeh.length > 0 && ddlTaluka.val() != "" && ddlTaluka.val() != "0") {
                        $.ajax({
                            type: "POST",
                            url: "Territory.aspx/getDehForDropDown",
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
                                        //setTimeout(function () {
                                        for (var i = 0; i < result.d.length; i++) {
                                            var opt = document.createElement("option");
                                            opt.text = result.d[i].Deh_name_eng;
                                            opt.value = result.d[i].Deh_id;
                                            ddlDeh[0].options.add(opt);
                                        }
                                        //}, 1000);
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
        }

        function AddNewItems(idAdd, idText) {
            $("#" + idAdd).slideToggle("slow");
            $("#" + idText).slideToggle("slow");
            $("input[id$='_hfControlId']").val('');
        }

        function DeleteItem(idControl, dropdown) {
            var ddlControl = $("select[id$='_" + idControl + "']");
            if (ddlControl.length > 0) {
                if (ddlControl.val() != null && ddlControl.val() != "" && ddlControl.val() != "0") {
                    ddlControl.removeClass("DropDownError").addClass("DropDownBG");
                    if (confirm("Are you sure to delete?")) {
                        $.ajax({
                            type: "POST",
                            url: "Territory.aspx/DeleteItem",
                            data: "{'Id':'" + ddlControl.val() + "', 'dropdown':'" + dropdown + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (result) {
                                if (result.d != null) {
                                    if (result.d == "success") {
                                        MessegeArea(dropdown + " record is deleted", "success");
                                        if (dropdown == "zilla") {
                                            fillZilla();
                                            $("select[id$='_ddlZilla']").val("0");
                                        }
                                        else if (dropdown == "taluka") {
                                            fillTaluka();
                                        }
                                        else if (dropdown == "deh") {
                                            fillDeh();
                                        }
                                    }
                                    else if (result.d == "childexist") {
                                        MessegeArea("Child record exist, Please delete child record", "Error");
                                    }
                                    else {
                                        MessegeArea(result.d, "error");
                                    }
                                }
                            },
                            error: function () {
                                MessegeArea("An error has occurred during DeleteItem processing.", "Error");
                            }
                        });
                    }
                }
                else {
                    MessegeArea("Please select control to delete record", "error");
                    ddlControl.removeClass("DropDownBG").addClass("DropDownError");
                    ddlControl.focus();
                }
            }
            else {
                MessegeArea("Control not find, Please contact administrator", "error");
            }
        }

        function UpdateRecord(textControl, dropdown) {
            var hfControlId = $("input[id$='_hfControlId']");
            var controlText = $("input[id$='_" + textControl + "']");
            if (controlText.val() != null && controlText.val() != "" && hfControlId.val() != "") {
                $.ajax({
                    type: "POST",
                    url: "Territory.aspx/UpdateRecord",
                    data: "{'Id':'" + hfControlId.val() + "', 'textValue':'" + controlText.val() + "', 'dropdown':'" + dropdown + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (result) {
                        if (result.d != null) {
                            if (result.d == "success") {
                                MessegeArea(dropdown + " record is udpated", "success");
                                if (dropdown == "zilla") {
                                    fillZilla();
                                    AddNewItems("divAddNewZilla", "divUpdateZilla");
                                    $("select[id$='_ddlZilla']").val("0");
                                    MessegeArea("Zilla Updated successfully", "success");
                                }
                                else if (dropdown == "taluka") {
                                    fillTaluka();
                                    AddNewItems("divAddNewTaluka", "divUpdateTaluka");
                                    MessegeArea("Taluka updated successfully", "success");
                                }
                                else if (dropdown == "deh") {
                                    fillDeh();
                                    AddNewItems("divAddNewDeh", "divUpdateDeh");
                                    MessegeArea("Deh updated successfully", "success");
                                }
                            }
                            else {
                                MessegeArea(result.d, "error");
                            }
                        }
                    },
                    error: function () {
                        MessegeArea("An error has occurred during UpdateRecord processing.", "Error");
                    }
                });
            }
            else {
                MessegeArea("Please select control to update record", "error");
            }
        }

        function UpdateItem(idAdd, idText, idControl, textControl) {
            var ddlControl = $("select[id$='_" + idControl + "']");
            if (ddlControl.val() != null && ddlControl.val() != "" && ddlControl.val() != "0") {
                $("input[id$='_hfControlId']").val(ddlControl.val());
                ddlControl.removeClass("DropDownError").addClass("DropDownBG");
                $("#" + idAdd).slideUp("slow");
                $("#" + idText).slideDown("slow");

                var ddlControl = $("select[id$='_" + idControl + "']");
                var ddlControlText = $("[id*='" + idControl + "'] :selected").text();
                $("input[id$='_" + textControl + "']").val(ddlControlText);
            }
            else {
                MessegeArea("Please select control", "Error");
                ddlControl.removeClass("DropDownBG").addClass("DropDownError");
                ddlControl.focus();
            }
        }

    </script>
    <div style="width: 100%; clear: both;">
        <div id="divZilla" style="width: 98%; float: left; border: 1px solid #DEDEDE; border-radius: 10px 10px 10px 10px;
            margin: 10px;">
            <div style="float: left; width: 100%; padding: 5px;">
                <div style="clear: both; width: 30%; float: left;">
                    <div style="float: left; width: 30%; padding-left: 70px; padding-top: 8px;">
                        Zilla:</div>
                    <div style="float: left;">
                        <asp:DropDownList ID="ddlZilla" runat="server" CssClass="DropDownBG" onchange="javascript:fillTaluka();">
                        </asp:DropDownList>
                    </div>
                </div>
                <div id="divAddNewZilla" style="width: 50%; float: left; padding-left: 15px;">
                    <div style="float: left; width: 22%;">
                        <a href="javascript:void(0);" onclick="AddNewItems('divAddNewZilla', 'divAddZilla');">
                            <img src="image/Add-icon.png" alt="" style="float: left; padding-right: 7px;" />
                            <div style="float: left; padding-top: 10px;">
                                Add New</div>
                        </a>
                    </div>
                    <div style="float: left; width: 22%;">
                        <a href="javascript:void(0);" onclick="UpdateItem('divAddNewZilla', 'divUpdateZilla', 'ddlZilla', 'txtZillaNameUpdate');">
                            <img src="image/update-icon.png" alt="" style="float: left; padding-right: 7px;" />
                            <div style="float: left; padding-top: 10px;">
                                Update</div>
                        </a>
                    </div>
                    <div style="float: left; width: 22%;">
                        <a href="javascript:void(0);" onclick="DeleteItem('ddlZilla', 'zilla');">
                            <img src="image/Delete1-icon.png" alt="" style="float: left; padding-right: 7px;" />
                            <div style="float: left; padding-top: 10px;">
                                Delete</div>
                        </a>
                    </div>
                </div>
                <div id="divAddZilla" style="width: 50%; float: left; display: none;">
                    <div style="width: 60%; float: left;">
                        <div style="float: left; width: 35%; padding-left: 15px; padding-top: 8px;">
                            <asp:Label ID="lblZillaName" runat="server" Text="Zilla Name:"></asp:Label>
                        </div>
                        <div style="float: left;">
                            <asp:TextBox ID="txtZillaName" runat="server" CssClass="textBoxBG" Width="165px"></asp:TextBox>
                        </div>
                    </div>
                    <div style="width: 30%; float: left; padding-top: 2px;">
                        <div style="float: left;">
                            <asp:Button ID="btnSaveZilla" runat="server" Text="Save" CssClass="LoginButton"
                                OnClientClick="addZilla(); return false;" />
                        </div>
                        <div style="float: left; padding-left: 10px; ">
                            <a href="javascript:void(0);" onclick="AddNewItems('divAddNewZilla', 'divAddZilla');">
                                <img src="image/hide-icon.png" alt="" style="float: left; padding-right: 7px;" />
                                <div style="float: left; padding-top: 7px;">Hide</div>
                            </a>
                        </div>
                    </div>
                </div>
                <div id="divUpdateZilla" style="width: 50%; float: left; display: none;">
                    <div style="width: 60%; float: left;">
                        <div style="float: left; width: 35%; padding-left: 15px; padding-top: 8px;">
                            <asp:Label ID="lblZillaNameUpdate" runat="server" Text="Zilla Name:"></asp:Label>
                        </div>
                        <div style="float: left;">
                            <asp:TextBox ID="txtZillaNameUpdate" runat="server" CssClass="textBoxBG" Width="165px"></asp:TextBox>
                        </div>
                    </div>
                    <div style="width: 30%; float: left; padding-top: 2px;">
                        <div style="float: left; ">
                            <asp:Button ID="btnUpdateZilla" runat="server" Text="Update" CssClass="LoginButton"
                                OnClientClick="UpdateRecord('txtZillaNameUpdate','zilla'); return false;" />
                        </div>
                        <div style="float: left; padding-left: 10px; ">
                            <a href="javascript:void(0);" onclick="AddNewItems('divAddNewZilla', 'divUpdateZilla');">
                                <img src="image/hide-icon.png" alt="" style="float: left; padding-right: 7px;" />
                                <div style="float: left; padding-top: 7px;">Hide</div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="divTaluka" style="width: 98%; float: left; border: 1px solid #DEDEDE; border-radius: 10px 10px 10px 10px;
            margin: 10px;">
            <div style="float: left; width: 100%; padding: 5px;">
                <div style="clear: both; width: 30%; float: left;">
                    <div style="float: left; width: 30%; padding-left: 70px; padding-top: 8px;">
                        Taluka:</div>
                    <div style="float: left;">
                        <asp:DropDownList ID="ddlTaluka" runat="server" CssClass="DropDownBG" onchange="javascript:fillDeh();">
                        </asp:DropDownList>
                    </div>
                </div>
                <div id="divAddNewTaluka" style="width: 50%; float: left; padding-left: 15px;">
                    <div style="float: left; width: 22%;">
                        <a href="javascript:void(0);" onclick="AddNewItems('divAddNewTaluka', 'divAddTaluka');">
                            <img src="image/Add-icon.png" alt="" style="float: left; padding-right: 10px;" />
                            <div style="float: left; padding-top: 10px;">
                                Add New</div>
                        </a>
                    </div>
                    <div style="float: left; width: 22%;">
                        <a href="javascript:void(0);" onclick="UpdateItem('divAddNewTaluka', 'divUpdateTaluka', 'ddlTaluka', 'txtTalukaNameUpdate');">
                            <img src="image/update-icon.png" alt="" style="float: left; padding-right: 7px;" />
                            <div style="float: left; padding-top: 10px;">
                                Update</div>
                        </a>
                    </div>
                    <div style="float: left; width: 22%;">
                        <a href="javascript:void(0);" onclick="DeleteItem('ddlTaluka', 'taluka');">
                            <img src="image/Delete1-icon.png" alt="" style="float: left; padding-right: 7px;" />
                            <div style="float: left; padding-top: 10px;">
                                Delete</div>
                        </a>
                    </div>
                </div>
                <div id="divAddTaluka" style="width: 50%; float: left; display: none;">
                    <div style="width: 60%; float: left;">
                        <div style="float: left; width: 35%; padding-left: 15px; padding-top: 8px;">
                            <asp:Label ID="lblTalukaName" runat="server" Text="Taluka Name:"></asp:Label>
                        </div>
                        <div style="float: left;">
                            <asp:TextBox ID="txtTalukaName" runat="server" CssClass="textBoxBG" Width="165px"></asp:TextBox>
                        </div>
                    </div>
                    <div style="width: 30%; float: left; padding-left: 2px;">
                        <div style="float: left; padding-top:2px;">
                            <asp:Button ID="btnSaveTaluka" runat="server" Text="Save" CssClass="LoginButton"
                                OnClientClick="addTaluka(); return false;" />
                        </div>
                        <div style="float: left; padding-left: 10px; ">
                            <a href="javascript:void(0);" onclick="AddNewItems('divAddNewTaluka', 'divAddTaluka');">
                                <img src="image/hide-icon.png" alt="" style="float: left; padding-right: 7px;" />
                                <div style="float: left; padding-top: 7px;">Hide</div>
                            </a>
                        </div>
                    </div>
                </div>
                <div id="divUpdateTaluka" style="width: 50%; float: left; display: none;">
                    <div style="width: 60%; float: left;">
                        <div style="float: left; width: 35%; padding-left: 15px; padding-top: 8px;">
                            <asp:Label ID="lblTalukaNameUpdate" runat="server" Text="Taluka Name:"></asp:Label>
                        </div>
                        <div style="float: left;">
                            <asp:TextBox ID="txtTalukaNameUpdate" runat="server" CssClass="textBoxBG" Width="165px"></asp:TextBox>
                        </div>
                    </div>
                    <div style="width: 30%; float: left; padding-left: 2px;">
                        <div style="float: left; padding-top:2px;">
                            <asp:Button ID="btnUpdateTaluka" runat="server" Text="Update" CssClass="LoginButton"
                                OnClientClick="UpdateRecord('txtTalukaNameUpdate','taluka'); return false;" />
                        </div>
                        <div style="float: left; padding-left: 10px; ">
                            <a href="javascript:void(0);" onclick="AddNewItems('divAddNewTaluka', 'divUpdateTaluka');">
                                <img src="image/hide-icon.png" alt="" style="float: left; padding-right: 7px;" />
                                <div style="float: left; padding-top: 7px;">Hide</div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="divDeh" style="width: 98%; float: left; border: 1px solid #DEDEDE; border-radius: 10px 10px 10px 10px;
            margin: 10px;">
            <div style="float: left; width: 100%; padding: 5px;">
                <div style="clear: both; width: 30%; float: left;">
                    <div style="float: left; width: 30%; padding-left: 70px; padding-top: 8px;">
                        Deh:</div>
                    <div style="float: left;">
                        <asp:DropDownList ID="ddlDeh" runat="server" CssClass="DropDownBG">
                        </asp:DropDownList>
                    </div>
                </div>
                <div id="divAddNewDeh" style="width: 50%; float: left; padding-left: 15px;">
                    <div style="float: left; width: 22%;">
                        <a href="javascript:void(0);" onclick="AddNewItems('divAddNewDeh', 'divAddDeh');">
                            <img src="image/Add-icon.png" alt="" style="float: left; padding-right: 10px;" />
                            <div style="float: left; padding-top: 10px;">
                                Add New</div>
                        </a>
                    </div>
                    <div style="float: left; width: 22%;">
                        <a href="javascript:void(0);" onclick="UpdateItem('divAddNewDeh', 'divUpdateDeh', 'ddlDeh', 'txtDehNameUpdate');">
                            <img src="image/update-icon.png" alt="" style="float: left; padding-right: 7px;" />
                            <div style="float: left; padding-top: 10px;">
                                Update</div>
                        </a>
                    </div>
                    <div style="float: left; width: 22%;">
                        <a href="javascript:void(0);" onclick="DeleteItem('ddlDeh', 'deh');">
                            <img src="image/Delete1-icon.png" alt="" style="float: left; padding-right: 7px;" />
                            <div style="float: left; padding-top: 10px;">
                                Delete</div>
                        </a>
                    </div>
                </div>
                <div id="divAddDeh" style="width: 50%; float: left; display: none;">
                    <div style="width: 60%; float: left;">
                        <div style="float: left; width: 35%; padding-left: 15px; padding-top: 8px;">
                            <asp:Label ID="lblDehName" runat="server" Text="Deh Name:"></asp:Label>
                        </div>
                        <div style="float: left;">
                            <asp:TextBox ID="txtDehName" runat="server" CssClass="textBoxBG" Width="165px"></asp:TextBox>
                        </div>
                    </div>
                    <div style="width: 30%; float: left; padding-left: 2px;">
                        <div style="float: left;padding-top:2px;">
                            <asp:Button ID="btnSaveDeh" runat="server" Text="Save" CssClass="LoginButton" OnClientClick="addDeh(); return false;" />
                        </div>
                        <div style="float: left; padding-left: 10px; ">
                            <a href="javascript:void(0);" onclick="AddNewItems('divAddNewDeh', 'divAddDeh');">
                                <img src="image/hide-icon.png" alt="" style="float: left; padding-right: 7px;" />
                                <div style="float: left; padding-top: 7px;">Hide</div>
                            </a>
                        </div>
                    </div>
                </div>
                <div id="divUpdateDeh" style="width: 50%; float: left; display: none;">
                    <div style="width: 60%; float: left;">
                        <div style="float: left; width: 35%; padding-left: 15px; padding-top: 8px;">
                            <asp:Label ID="lblDehNameUpdate" runat="server" Text="Deh Name:"></asp:Label>
                        </div>
                        <div style="float: left;">
                            <asp:TextBox ID="txtDehNameUpdate" runat="server" CssClass="textBoxBG" Width="165px"></asp:TextBox>
                        </div>
                    </div>
                    <div style="width: 30%; float: left; padding-left: 2px;">
                        <div style="float: left;padding-top:2px;">
                            <asp:Button ID="btnUpdateDeh" runat="server" Text="Update" CssClass="LoginButton" 
                            OnClientClick="UpdateRecord('txtDehNameUpdate','deh'); return false;" />
                        </div>
                        <div style="float: left; padding-left: 10px; ">
                            <a href="javascript:void(0);" onclick="AddNewItems('divAddNewDeh', 'divUpdateDeh');">
                                <img src="image/hide-icon.png" alt="" style="float: left; padding-right: 7px;" />
                                <div style="float: left; padding-top: 7px;">Hide</div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hfControlId" runat="server" />
</asp:Content>
