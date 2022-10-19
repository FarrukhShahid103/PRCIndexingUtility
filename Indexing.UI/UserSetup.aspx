<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserSetup.aspx.cs" Inherits="Indexing.UI.UserSetup"
    MasterPageFile="~/PRC_Master.Master" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    &nbsp;<script type="text/javascript" src="script/jquery-1.4.min.js"></script><script src="script/jquery.simplemodal.js" type="text/javascript"></script><script type="text/javascript" src="script/jquery.confirm.js"></script>
    <script language="javascript" type="text/javascript">
        function loadUserRecord() {
            $.ajax({
                async: false,
                type: "POST",
                url: "UserSetup.aspx/LoadUserRecord",
                data: '',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    if (result.d != null) {
                        if (result.d.length > 0) {
                            //                        var gvSearchRecord = $("table[id$='_gvSearchRecord']");
                            var gvSearchRecord = $("#gvSearchRecord");
                            if (gvSearchRecord.length > 0) {
                                gvSearchRecord.html("");
                                gvSearchRecord.append("<thead><tr>" +
                                                    "<th style='display:none;'>UserId</th>" +
                                                    "<th>User Name</th>" +
                                                    "<th>Display Name</th>" +
                                                    "<th>Edit</th>" +
                                                    "<th>IsActive</th>" +
                                                    "<th>Delete</th>" +
                                                    "</tr>" +
                                                    "</thead>");
                                for (var i = 0; i < result.d.length; i++) {
                                    if (result.d[i].User_status == true) {
                                        gvSearchRecord.append("<tr><td style='display:none;'>" + result.d[i].User_id + "</td>"
                                + "<td style='padding-left:10px;'>" + result.d[i].User_name + "</td>"
                                + "<td style='padding-left:10px;'>" + result.d[i].Display_name + "</td>"
                                + "<td style='text-align:center; width:50px;'><a href='#' onclick=javascript:editUser(\'" + result.d[i].User_id + "');><img src='image/edit.png' /></a></td>"
                                + " <td style='text-align:center; width:50px;'><a href='#'><img src='image/tick.png' /></a></td>"
                                + "<td style='text-align:center; width:50px;'><a href='#' onclick=javascript:deleteUser(\'" + result.d[i].User_id + "');><img src='image/delete.png' /></a></td>"
                                + "</tr>");
                                    }
                                    else {
                                        gvSearchRecord.append("<tr><td style='display:none;'>" + result.d[i].User_id + "</td>"
                                + "<td style='padding-left:10px;'>" + result.d[i].User_name + "</td>"
                                + "<td style='padding-left:10px;'>" + result.d[i].Display_name + "</td>"
                                + "<td style='text-align:center; width:50px;'><a href='#' onclick=javascript:editUser(\'" + result.d[i].User_id + "');><img src='image/edit.png' /></a></td>"
                                + "<td style='text-align:center; width:50px;'><img src='image/unlock-green.png' /></td>"
                                + "<td style='text-align:center; width:50px;'><a href='#' onclick=javascript:deleteUser(\'" + result.d[i].User_id + "');><img src='image/delete.png' /></a></td>"
                                + "</tr>");
                                    }
                                }
                            }
                            var options = {
                                currPage: 1,
                                optionsForRows: [10, 15, 20, 25, 30, 35, 40, 45, 50, 100, 150, 200],
                                rowsPerPage: 10,
                                firstArrow: (new Image()).src = "../image/FirstIco.png",
                                prevArrow: (new Image()).src = "../image/PreviousIco.png",
                                lastArrow: (new Image()).src = "../image/LastIco.png",
                                nextArrow: (new Image()).src = "../image/NextIco.png",
                                topNav: false
                            }
                            $('#gvSearchRecord').tablePagination(options);
                        }
                        else {
                            gvSearchRecord.html("");
                            gvSearchRecord.append("<div style='width:100%; padding-left:7px;'>No record found</div>");
                        }
                        $("#UserRecordHead").show();
                    }
                    return true;
                },
                error: function () {
                    MessegeArea("An error has occurred during LoadUserRecord processing.", "error");
                }
            });
        }

        function deleteUser(userId) {
            $.confirm({
                'title': 'Delete Confirmation',
                'message': 'Are you sure you want to delete the record?',
                'buttons': {
                    'Yes': {
                        'class': 'blue',
                        'action': function () {
                            $.ajax({
                                type: "POST",
                                url: "UserSetup.aspx/DeleteUser",
                                data: "{'userId':'" + userId + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (result) {
                                    if (result.d != null) {
                                        if (result.d == "success") {
                                            MessegeArea("User delete successfully", 'success');
                                            loadUserRecord();
                                        }
                                        else {
                                            MessegeArea("User not delete due to " + result.d, "error");
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

        function editUser(userId) {
            displayPopup();
            $.ajax({
                type: "POST",
                url: "UserSetup.aspx/LoadUser",
                data: "{'userId':'" + userId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    if (result.d != null) {
                        if (result.d.length > 0) {
                            $("input[id$='_hdUserId']").val(result.d[0].User_id);
                            $("input[id$='_txtUsername']").val(result.d[0].User_name);
                            $("input[id$='_txtPassword']").val("");
                            $("input[id$='_txtDisplayName']").val(result.d[0].Display_name);
                            $("input[id$='_chkIsActive']").attr("checked", result.d[0].User_status)
                            var rdButton = $("#RadioDiv input:radio");
                            for (var i = 0; i < rdButton.length; i++) {
                                if (rdButton[i].value == result.d[0].ObjRoles[0].Role_id) {
                                    $("#RadioDiv input:radio")[i].checked = true;
                                }
                            }
                        }
                        else {
                            resetFields();
                            $("input[id$='_hdUserId']").val("");
                        }

                    }
                },
                error: function () {
                    MessegeArea("An error has occurred during editUser processing.", "Error");
                }
            });
        }

        function displayPopup() {
            $("input[id$='_hdUserId']").val("");
            $('#divUserPopup').modal({
                closeHTML: "<a href='#' title='Close' class='modal-close commentclose' ></a>",
                position: ["20%", ],
                overlayId: 'model-overlay',
                containerId: 'tastygoModal',
                onShow: function (dialog) {
                    var modal = this;
                    $('.yes', dialog.data[0]).click(function () {
                        if ($.isFunction(callback)) {
                            callback.apply();
                        }
                        modal.close();
                    });
                }
            });
            fillRole();
        }

        function resetFields() {
            $("input[id$='_txtUsername']").val("");
            $("input[id$='_txtPassword']").val("");
            $("input[id$='_txtDisplayName']").val("");
        }

        function closePopup() {
            $(".modal-close").click();
        }

        function validateUserFields(txtUsername, txtPassword, txtDisplayName, rdValue) {
            if (txtUsername.val() == "") {
                txtUsername.removeClass("textBoxBG").addClass("textBoxError");
                txtUsername.focus();
                MessegeArea("Please enter username", "error");
                return false;
            }
            else {
                txtUsername.removeClass("textBoxError").addClass("textBoxBG");
            }
            if (txtPassword.val() == "") {
                txtPassword.removeClass("textBoxBG").addClass("textBoxError");
                txtPassword.focus();
                MessegeArea("Please enter password", "error");
                txtPassword.focus();
                return false;
            }
            else {
                txtPassword.removeClass("textBoxError").addClass("textBoxBG");
            }
            if (txtDisplayName.val() == "") {
                txtDisplayName.removeClass("textBoxBG").addClass("textBoxError");
                txtDisplayName.focus();
                MessegeArea("Please enter display name", "error");
                txtDisplayName.focus();
                return false;
            }
            else {
                txtDisplayName.removeClass("textBoxError").addClass("textBoxBG");
            }
            if (rdValue == undefined || rdValue == "") {
                MessegeArea("Please select user role", "error");
                return false;
            }
            return true;
        }

        function saveUser() {
            var hdUserId = $("input[id$='_hdUserId']");
            var txtUsername = $("input[id$='_txtUsername']");
            var txtPassword = $("input[id$='_txtPassword']");
            var txtDisplayName = $("input[id$='_txtDisplayName']");
            var rdValue = $("#RadioDiv input:radio:checked").val();
            var chkIsActive = $("input[id$='_chkIsActive']").is(':checked');

            if (txtUsername.val() != "" && txtPassword.val() != "" && txtDisplayName.val() != "" && (rdValue != undefined || rdValue != "")) {
                $.ajax({
                    type: "POST",
                    url: "UserSetup.aspx/SaveUser",
                    data: "{'userId':'" + hdUserId.val() + "', 'userName':'" + txtUsername.val() + "', 'password': '" + txtPassword.val() + "', 'displayName': '" + txtDisplayName.val() +
                "', 'roleId':'" + rdValue + "', 'isActive': '" + chkIsActive + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (result) {
                        if (result.d != null) {
                            if (result.d == 'InsertWithRole') {
                                MessegeArea('User successfully created', 'success');
                                closePopup();
                                loadUserRecord();
                            }
                            else if (result.d == 'SaveUserButNotRole') {
                                MessegeArea('user create successfully but role cannot assign, Please contact administrator', 'error');
                            }
                            else if (result.d == 'duplicate') {
                                MessegeArea('User name already exist.', 'error');
                                }
                            else if (result.d == 'ErrorInsertUser') {
                                MessegeArea('User cannot create, please contact administrator.', 'error');
                            }
                            else if (result.d == 'UpdateWithRole') {
                                MessegeArea('User successfully updated', 'success');
                                closePopup();
                                loadUserRecord();
                            }
                            else if(result.d == 'ErrorUpdate') {
                                MessegeArea('User name already exist.', 'error');
                            }
                        }
                    },
                    error: function () {
                        MessegeArea("An error has occurred during saveUser processing.", "Error");
                    }
                });
            }
            else {
                validateUserFields(txtUsername, txtPassword, txtDisplayName, rdValue);
            }
        }

        var rbSelectedValue = "";

        function fillRole() {
            var rbRoleList = $("table[id$='_rbRoleList']");
            if (rbRoleList.length > 0) {
                $.ajax({
                    type: "POST",
                    url: "UserSetup.aspx/FillRole",
                    data: '',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (result) {
                        if (result.d != null) {
                            if (result.d.length > 0) {
                                rbRoleList.html("");
                                for (var i = 0; i < result.d.length; i++) {
                                    var rdb = "<div style='clear:both;'><input id=RadioButton" + i + " type=radio name=chk value=" + result.d[i].Role_id + " /><label for=RadioButton" + i + ">" + result.d[i].Description_eng + "</label></div>";
                                    $("table[id$='_rbRoleList']").append(rdb);
                                }
                            }
                        }
                    },
                    error: function () {
                        MessegeArea("An error has occurred during fillRole processing.", "error");
                    }
                });
            }
        }

    </script><div style="width: 100%;">
        <div style="width: 100%; clear: both;" id="divSearch">
            <div style="width:100%; float:left; padding-bottom:10; height:25px; padding-top:5px; background-color:#B0CCD7;">
                <div style="width: 10%; vertical-align: middle; float:left; text-align:center;">
                    <a href="javascript:displayPopup();">Add New User</a>
                </div>
                <div style="width: 10%; vertical-align: middle; float:left; text-align:center;">
                    <a href="javascript:loadUserRecord();">Load Users</a>
                </div>
            </div>
            <div style="clear: both; float: left; width: 100%; padding-top: 20px;">
                <div style="float: left; padding: 5px 0px 5px 0px; width: 99%;">
                    <div id="UserRecordHead" style="width: 100%; padding: 7px 0px 7px 10px; box-shadow: 0 0 18px #70B2CD inset; display:none;">
                        User Record</div>
                </div>
                <div style="width: 100%; clear: both;">
                    <table id="gvSearchRecord">
                    </table>
                </div>
            </div>
        </div>
        <div id="divUserPopup" style="display: none;">
            <div style="width: 100%;" id="divLoadImage">
                <div style="clear: both; width: 100%;">
                    <div class="leftCaptionLoadPopup">
                        <asp:Label ID="lblUsername" runat="server" Text="User Name:"></asp:Label>
                    </div>
                    <div class="RightValueDivControlPopup">
                        <asp:TextBox ID="txtUsername" runat="server" CssClass="textBoxBG"></asp:TextBox>
                    </div>
                </div>
                <div style="clear: both; width: 100%;">
                    <div class="leftCaptionLoadPopup">
                        <asp:Label ID="lblPassword" runat="server" Text="Password:"></asp:Label>
                    </div>
                    <div class="RightValueDivControlPopup">
                        <asp:TextBox ID="txtPassword" TextMode="Password" runat="server" CssClass="textBoxBG"></asp:TextBox>
                    </div>
                </div>
                <div style="clear: both; width: 100%;">
                    <div class="leftCaptionLoadPopup">
                        <asp:Label ID="lblDisplayName" runat="server" Text="Display Name:"></asp:Label>
                    </div>
                    <div class="RightValueDivControlPopup">
                        <asp:TextBox ID="txtDisplayName" runat="server" CssClass="textBoxBG"></asp:TextBox>
                    </div>
                </div>
                <div style="clear: both; width: 100%;">
                    <div class="leftCaptionLoadPopup">
                        <asp:Label ID="lblRole" runat="server" Text="Role:"></asp:Label>
                    </div>
                    <div class="RightValueDivControlPopup" id="RadioDiv">
                        <asp:RadioButtonList ID="rbRoleList" runat="server">
                            <asp:ListItem Text="0" Value="0"></asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                </div>
                <div style="clear: both; width: 100%;">
                    <div class="leftCaptionLoadPopup">
                        <asp:CheckBox ID="chkIsActive" runat="server" Text="Is Active" />
                    </div>
                </div>
                <div style="clear: both; width: 100%;">
                    <div style="float: right; clear: both; padding-right: 15px; padding-top: 15px;">
                        <asp:Button ID="btnSave" runat="server" Text="Save" OnClientClick="saveUser();" />&nbsp;
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClientClick="closePopup();" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hdUserId" runat="server" />
</asp:Content>
