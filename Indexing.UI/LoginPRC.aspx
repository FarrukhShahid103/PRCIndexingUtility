<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPRC.aspx.cs" Inherits="Indexing.UI.LoginPRC" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="author" content="Farrukh Shahid">

	<!-- The styles -->
	<link href="style/bootstrap-cerulean.css" rel="stylesheet">
	<style type="text/css">
	  body {
		padding-bottom: 40px;
	  }
	  .sidebar-nav {
		padding: 9px 0;
	  }
	</style>
    <link href="style/bootstrap-responsive.css" rel="stylesheet" type="text/css" />
    <link href="style/charisma-app.css" rel="stylesheet" type="text/css" />
    <script src="script/jquery-1.9.1.min.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">
        function getLogin() {
            var txtUsername = $("#txtUsername");
            var txtPassword = $("#txtPassword");
            if (txtUsername.length > 0 && txtUsername.val() == "") {
                txtUsername.removeClass("input-large span10").addClass("loginTextBoxError span10");
                txtUsername.focus();
                return false;
            }
            else {
                txtUsername.removeClass("input-large-error span10").addClass("input-large span10");
            }

            if (txtPassword.length > 0 && txtPassword.val() == "") {
                txtPassword.removeClass("input-large span10").addClass("input-large-error span10");
                txtPassword.focus();
                return false;
            }
            else {
                txtPassword.removeClass("input-large-error span10").addClass("input-large span10");
            }
            return true;
        }

</script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="container-fluid">
		<div class="row-fluid">
		
			<div class="row-fluid">
				<div class="span12 center login-header">
					<h2>Welcome to LARMIS Provincial Record Cell</h2>
				</div><!--/span-->
			</div><!--/row-->
			
			<div class="row-fluid">
				<div class="well span5 center login-box">
					<div class="alert alert-info">
						Please login with your Username and Password.
					</div>
					<form class="form-horizontal" action="#" method="post">
						<fieldset>
							<div class="input-prepend" title="Username" data-rel="tooltip">
								<span class="add-on"><i class="icon-user"></i></span>
                                <asp:TextBox ID="txtUsername" runat="server" CssClass="input-large span10"></asp:TextBox>
                                <%--<input autofocus class="input-large span10" name="username" id="username" type="text" value="admin" />--%>
							</div>
							<div class="clearfix"></div>

							<div class="input-prepend" title="Password" data-rel="tooltip">
								<span class="add-on"><i class="icon-lock"></i></span>
                                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="input-large span10"></asp:TextBox>
                                <%--<input class="input-large span10" name="password" id="password" type="password" value="admin123456" />--%>
							</div>
							<div class="clearfix"></div>

							<%--<div class="input-prepend">
							    <label class="remember" for="remember"><input type="checkbox" id="remember" />Remember me</label>
							</div>--%>
							<div class="clearfix"></div>

							<p class="center span5">
                            <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-primary" Text="Login"
                             OnClientClick="javascript:if(!getLogin()) return false;" onclick="btnLogin_Click"/>
							<%--<button type="submit" class="btn btn-primary">Login</button>--%>
							</p>
						</fieldset>
					</form>
				</div><!--/span-->
			</div><!--/row-->
				</div><!--/fluid-row-->
		
	</div><!--/.fluid-container-->
    </form>
</body>
</html>
