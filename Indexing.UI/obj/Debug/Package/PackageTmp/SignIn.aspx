<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignIn.aspx.cs" Inherits="Indexing.UI.SignIn" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="script/jquery-1.4.0.min.js" type="text/javascript"></script>
    <script src="script/jquery-ui-1.8.18.custom.min.js" type="text/javascript"></script>
    <link href="style/LoginSignup.css" rel="stylesheet" type="text/css" />
    <script src="script/LoginSignup.js" type="text/javascript"></script>
    <title></title>
    <script type="text/javascript">
        function EnterKey(e) {
            if (e.keyCode == 13) {
                DoLogin();
            }
        }

        $(document).ready(function () {
            SetContentHeight();
        });

        $(window).resize(function () {
            SetContentHeight();
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
   <%--<div id="toptile">
        <div style="padding-top: 5px; float: left;">
            <a href='<%= ConfigurationManager.AppSettings["YourSite"].ToString() +"/Default.aspx" %>' style="text-decoration: none;">
                <img src="Images/logosmall.png" alt="" />
            </a>
        </div>
        <div style="margin-left: 15px; z-index: 1111111; float: left; background-color: #cec6bf;
            width: 2px; height: 51px;">
        </div>
    </div>--%>
    <div id="page-wrap">
        <div style="background-color: Black; width: 300px; text-align: left; height: 320px;
            float: left; margin-left: 115px; margin-top: 200px; font-family: Helvetica;">
            <div style="clear:both; text-align:center; margin-top:25px;">
                <img src="image/sindhLogoGray.png" width="100px" height="100px" alt="" />
            </div>
            <div style="color: #8c9090; font-size: 25px; margin-top: 25px; text-align:center; text-transform:uppercase;">
                Welcome to</div>
            <div style="color: White; font-size: 34px; padding-top:20px; text-align:center; text-transform:uppercase;">
                Provincial Record Cell</div>
        </div>
        <div style="float: left; font-family: Helvetica;" class="loginArea">
            <asp:Panel ID="pngLogin" runat="server" DefaultButton="">
                <div id="loginArea" style="margin-left: 20px; margin-top: 40px; clear: both; overflow: hidden;
                    display: block;">
                    <div style="color: White; text-align: left; font-size: 33px;">
                        Member Sign in</div>
                    <div style="font-size: 13px; margin-top: 20px; text-align: left; color: #a0a1a1;">
                        USER NAME</div>
                    <div style="float: left; margin-top: 5px; clear: both; overflow: hidden;">
                        <asp:TextBox onfocus="this.className='loginTextBox'" ID="txtEmail" runat="server"
                            CssClass="loginTextBox" onkeypress="return EnterKey(event)"></asp:TextBox>
                    </div>
                    <div style="font-size: 13px; margin-top: 45px; text-align: left; color: #a0a1a1;">
                        PASSWORD</div>
                    <div style="float: left; margin-top: 5px; clear: both; overflow: hidden;">
                        <asp:TextBox onfocus="this.className='loginTextBox'" TextMode="Password" CssClass="loginTextBox"
                            ID="txtPwd" runat="server" onkeypress="return EnterKey(event)"></asp:TextBox>
                    </div>
                    <div style="margin-top: 20px; float: left; clear: both; overflow: hidden;">
                        <div style="float: left;">
                            <a href="javascript:void(0)" onclick="javascript:DoLogin();">
                                <img src="Images/login-button.png" />
                            </a>
                        </div>
                    </div>
                    <%--<div onclick="javascript:AreaSwitching('ForgotPassword');" style="color: #888986;
                        font-size: 20px; text-align: left; font-family: Helvetica; text-decoration: underline;
                        cursor: pointer; margin-top: 95px;">
                        Forgot your password?
                    </div>--%>
                </div>
            </asp:Panel>
            <%--<div id="signUpArea" style="margin-left: 20px; margin-top: 20px; clear: both; overflow: hidden;
                display: none;">
                <div style="color: White; text-align: left; font-size: 33px;">
                    Join Today!</div>
                <div style="font-size: 13px; margin-top: 20px; text-align: left; color: #a0a1a1;">
                    EMAIL</div>
                <div style="float: left; margin-top: 5px; clear: both; overflow: hidden;">
                    <asp:TextBox onfocus="this.className='loginTextBox'" ID="TextBox1" runat="server"
                        CssClass="loginTextBox"></asp:TextBox>
                </div>
                <div style="margin-top: 20px; float: left; clear: both; overflow: hidden;">
                    <div style="width: 93px;">
                        <img src="Images/signup-button.png" />
                    </div>
                    <div style="color: White; font-size: 14px; margin: 5px 5px;">
                        or</div>
                    <%--<div style="margin-left: 5px;">
                        <img src="Images/facebook-btn.png" />
                    </div>
                </div>
            </div>
            <div id="ForgotPassword" style="margin-left: 20px; margin-top: 20px; clear: both;
                overflow: hidden; display: none;">
                <div style="color: White; text-align: left; font-size: 33px;">
                    Forgot Password?</div>
                <div style="font-size: 13px; margin-top: 20px; text-align: left; color: #a0a1a1;">
                    EMAIL</div>
                <div style="float: left; margin-top: 5px; clear: both; overflow: hidden;">
                    <asp:TextBox onfocus="this.className='loginTextBox'" ID="txtEmailAddress" runat="server"
                        CssClass="loginTextBox"></asp:TextBox>
                </div>
                <div style="margin-top: 20px; float: left; clear: both; overflow: hidden;">
                    <div style="width: 93px; float: left;">
                        <a href="javascript:void(0)" id="forgot" onclick="javascript:RecoverPassword();">
                            <img src="Images/signup-button.png" />
                        </a>
                    </div>
                    <div style="float: left; padding-top: 8px;">
                        <div style="float: left; padding-left: 5px; color: White; font-size: 14px;">
                            or</div>
                        <div onclick="javascript:ToggleSignup();" style="float: left; padding-left: 5px;
                            color: Red; font-size: 14px; cursor: pointer;">
                            Back to Login
                        </div>
                    </div>
                </div>
            </div>--%>
            <div id="LoadingArea" style="margin-left: 20px; margin-top: 20px; clear: both; overflow: hidden;
                display: none;">
                <div style="float: left; clear: both;">
                    <div style="color: White; text-align: left; font-size: 33px; text-align: center;">
                        Please Wait...
                    </div>
                    <center>
                        <div style="clear: both; padding-top: 100px;">
                            <img src="images/LoginLoader.gif" />
                        </div>
                    </center>
                </div>
            </div>
            <div id="MessageArea" style="margin-left: 20px; margin-top: 20px; clear: both; overflow: hidden;
                display: none;">
                <div style="float: right; padding-right: 20px;">
                    <a href="javascript:void(0);" onclick="javascript:CloseMessageArea();">
                        <img id="CloseImage" src="images/CloseMessageArea.png" />
                    </a>
                </div>
                <div style="padding-top: 80px; clear: both;">
                    <div style="float: left; padding-left: 100px;">
                        <img id="ErrorImage" src="images/ErrorIcon.png" />
                    </div>
                    <div id="ErrorMessageLabel" style="color: #F77700; float: left; font-weight: bold;
                        padding-top: 10px; text-align: center; width: 100%;">
                        Invalid username or password.
                    </div>
                </div>
            </div>
        </div>
        <div id="footerWrapper">
            <%--<div id="footer">
                <ul class="footerLinks floatLeft">
                    <li><a target="_blank" href="#">About</a></li>
                    <li><a target="_blank" href="#">Careers</a></li>
                    <li><a target="_blank" href="#">Blog</a></li>
                    <li><a target="_blank" href="#">Help</a></li>
                    <li><a target="_blank" href="#">Contact Us</a></li>
                    <li><a target="_blank" href="#">Return Policy</a></li>
                    <li><a target="_blank" href="#">Shipping</a></li>
                    <li><a target="_blank" href="#">Terms</a></li>
                    <li><a target="_blank" href="#">Privacy</a></li>
                </ul>
                <span style="margin-right: 0px" class="copyText floatRight">Tazzling.com &copy; 2012</span>
                <ul style="" class="socialLinks floatRight">
                    <li><a style="cursor: pointer; text-decoration: none;">
                        <img width="19px" height="19px" src="Images/Twitter.png" alt="" />
                    </a></li>
                    <li><a style="cursor: pointer; text-decoration: none;">
                        <img width="19px" height="19px" src="Images/FaceBookSignIn.png" alt="" />
                    </a></li>
                </ul>
                <!-- SAL Admin Check# -->
                <!-- SAL Admin Check# -->
            </div>--%>
        </div>
    </div>
    </form>
</body>
</html>
