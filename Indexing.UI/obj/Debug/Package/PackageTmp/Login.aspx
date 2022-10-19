<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Indexing.UI.Login" MasterPageFile="~/PRC_Master.Master" %>
<asp:Content ID="content1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <script type="text/javascript" language="javascript">
    function getLogin() {
        var txtUsername = $("input[id$='_txtUsername']");
        var txtPassword = $("input[id$='_txtPassword']");
        if (txtUsername.length > 0 && txtUsername.val() == "") {
            txtUsername.removeClass("loginTextBoxBG").addClass("loginTextBoxError");
            txtUsername.focus();
            return false;
        }
        else {
            txtUsername.removeClass("loginTextBoxError").addClass("loginTextBoxBG");
        }

        if (txtPassword.length > 0 && txtPassword.val() == "") {
            txtPassword.removeClass("loginTextBoxBG").addClass("loginTextBoxError");
            txtPassword.focus();
            return false;
        }
        else {
            txtPassword.removeClass("loginTextBoxError").addClass("loginTextBoxBG");
        }
//        debugger;
//        $.ajax({
//            async: false,
//            type: "POST",
//            url: "Login.aspx/getLogin",
//            data: "{'username':'" + txtUsername.val() + "', 'password':'" + txtPassword.val() + "'}",
//            contentType: "application/json; charset=utf-8",
//            dataType: "json",
//            success: function (result) {
//                alert("success");
//                debugger;
//                if (result.d != null) {
//                    if (result.d.length > 0) {
//                        debugger;
//                        alert("user login");
//                    }
//                }
//            },
//            error: function () {
//                alert("An error has occurred during getLogin processing.");
//            }
//        });
        return true;
    }

</script>

<asp:UpdatePanel ID="upLogin" runat="server" UpdateMode="Conditional">
    <ContentTemplate>    
        <div style="float:left; padding-left:350px; padding-top:50px;">
            <div style="float:left; width:340px; float:left;">
                <div style="float:left; border: 2px solid white; border-radius:25px; width:100%; background-color:#73B5D9;">
                    <div style="width:80%; float:left; padding-left:25px; padding-top:15px;">
                        <div class="userImage"></div>
                        <div style="float:left;">Login</div>
                        <div style="clear:both; float:left; padding-bottom:10px;">Login with your user name and password</div>
                    </div>
                    <div style="clear:both; float:left; padding-bottom:10px; padding-left:25px;">
                        <asp:TextBox ID="txtUsername" runat="server" Width="270px" CssClass="loginTextBoxBG"></asp:TextBox>
                    </div>
                    <div style="clear:both; float:left; padding-bottom:15px; padding-left:25px;">
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Width="270px" CssClass="loginTextBoxBG"></asp:TextBox>
                    </div>
                    <div style="clear:both; float:right; padding-bottom:30px; padding-right:35px;">
                        <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="LoginButton" 
                            OnClientClick="javascript:if(!getLogin()) return false;" 
                            onclick="btnLogin_Click" />
                    </div>
                </div>
            </div>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>
</asp:Content>