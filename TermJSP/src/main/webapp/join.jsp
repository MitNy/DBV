<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		 <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

		<title>2018 DB Term Project</title>

		<!-- Google font -->
		<link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

		<!-- Bootstrap -->
		<link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>

		<!-- Slick -->
		<link type="text/css" rel="stylesheet" href="css/slick.css"/>
		<link type="text/css" rel="stylesheet" href="css/slick-theme.css"/>

		<!-- nouislider -->
		<link type="text/css" rel="stylesheet" href="css/nouislider.min.css"/>

		<!-- Font Awesome Icon -->
		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">

		<!-- Custom stlylesheet -->
		<link type="text/css" rel="stylesheet" href="css/style.css"/>
    </head>
	<body>
		<!-- HEADER -->
		<header>
			<!-- TOP HEADER -->
			<div id="top-header">
				<div class="container">
					<ul class="header-links pull-right">
				<li class="menu-toggle"><a href="#"><i class="fa fa-bars"></i><span>Menu</span></a></li>
                        <li class="dropdown" id="user-toggle">
        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
        <i class="fa fa-user"></i><% 
        	// �Ϲ� ����� �α���
        	if( session.getAttribute("user-session") != null && session.getAttribute("admin-session") == null ){
        	Object user = session.getAttribute("user-session");
        	out.print(user);
        	}
        	else if(session.getAttribute("user-session") == null && session.getAttribute("admin-session") != null ) {
        		Object admin = session.getAttribute("admin-session");
            	out.print(admin);
        	}
        	else {
        		out.print("User");
        	}
        %>
        	</a>
        <ul class="dropdown-menu user-dropdown">
          <li><a href="userInfo.jsp"><i class="fas fa-user-circle"></i>&nbsp;&nbsp;��������</a></li>
          <%
          	if( session.getAttribute("user-session") != null || session.getAttribute("admin-session") != null) {        	  %>
				<li><a href="logout.jsp"><i class="fas fa-sign-out-alt"></i>&nbsp;&nbsp;�α׾ƿ�</a></li>
          <% } else { %>
          <li><a href="login.jsp"><i class="fas fa-sign-out-alt"></i>&nbsp;&nbsp;�α���</a></li>
          <% } %>
        </ul>
      </li>
					</ul>
				</div>
			</div>
			<!-- /TOP HEADER -->

			<!-- MAIN HEADER -->
			<div id="header">
				<!-- container -->
				<div class="container">
					<!-- row -->
					<div class="row">
						<!-- LOGO -->
						<div class="col-md-3">
							<div class="header-logo">
								<a href="index.jsp" class="logo">
                                    DBV
								</a>
							</div>
						</div>
						<!-- /LOGO -->

						<!-- SEARCH BAR -->
						<div class="col-md-6">
							<div class="header-search">
								<form>
									<select class="input-select">
										<option value="0">��ü</option>
										<option value="1">��ȭ</option>
										<option value="1"></option>
									</select>
									<input class="input" placeholder="">
									<button class="search-btn">�˻�</button>
								</form>
							</div>
						</div>
						<!-- /SEARCH BAR -->

						<!-- ACCOUNT -->

						<!-- /ACCOUNT -->
					</div>
					<!-- row -->
				</div>
				<!-- container -->
			</div>
			<!-- /MAIN HEADER -->
		</header>
		<!-- /HEADER -->

		<!-- NAVIGATION -->
		<nav id="navigation">
			<!-- container -->
			<div class="container">
				<!-- responsive-nav -->
				<div id="responsive-nav">
					<!-- NAV -->
					<ul class="main-nav nav navbar-nav">
						<li><a href="index.jsp">Ȩ</a></li>
						<li><a href="theater.jsp">��ȭ��</a></li>
						<li><a href="reservation.jsp">����</a></li>
					</ul>
					<!-- /NAV -->
				</div>
				<!-- /responsive-nav -->
			</div>
			<!-- /container -->
		</nav>
		<!-- /NAVIGATION -->
<!-- BREADCRUMB -->
		<div id="breadcrumb" class="section">
			<!-- container -->
			<div class="container">
				<!-- row -->
				<div class="row">
					<div class="col-md-12">
						<h3 class="breadcrumb-header">ȸ������</h3>
					</div>
				</div>
				<!-- /row -->
			</div>
			<!-- /container -->
		</div>
		<!-- /BREADCRUMB -->
		<!-- SECTION -->
		<!-- SECTION -->
		<div class="section">
			<!-- container -->
			<div class="container">
				<!-- row -->
				<div class="row">
                    <div class="join-box">
                    <form action="joinPro.jsp" method="post" name="join" onsubmit="return checkValue()">
							<div class="form-group">
								<p class="form-title">���̵�</p>
								<input class="input" type="text" id="user-id" name="user-id">
							</div>
                        <div class="form-group">
                        	<p class="form-title">��й�ȣ</p>
								<input class="input" type="password" id="password" name="password">
							</div>
                            <div class="form-group">
                            	<p class="form-title">��й�ȣ Ȯ��</p>
								<input class="input" type="password" id="password-check" name="password-check">
							</div>
                            <div class="form-group">
                            	<p class="form-title">�̸�</p>
								<input class="input" type="text" id="user-name" name="user-name">
							</div>
							<div class="form-group">
								<p class="form-title">�������</p>
								<input class="input" type="date" id="birthday" name="birthday">
							</div>
                        <div class="form-group">
                        		<p class="form-title">�ּ�</p>
								<input class="input" type="text" id="address" name="address">
							</div>
                            <div class="form-group">
                            	<p class="form-title">����ó</p>
								<input class="input" type="tel" name="tel">
							</div>
                        
                            <input type="submit" id="join-btn" value="ȸ������">
                            </form>
					<!-- /product -->
				</div>
                </div>
                 <br><br>
				<!-- /row -->
			</div>
			<!-- /container -->
            
		</div>

        <div style="height:400px"></div>
		<!-- FOOTER -->
		<footer id="footer">
			<!-- bottom footer -->
			<div id="bottom-footer" class="section">
				<div class="container">
					<!-- row -->
					<div class="row">
						<div class="col-md-12 text-center">
							<ul class="footer-payments">
								<li><a href="#"><i class="fa fa-cc-visa"></i></a></li>
								<li><a href="#"><i class="fa fa-credit-card"></i></a></li>
								<li><a href="#"><i class="fa fa-cc-paypal"></i></a></li>
								<li><a href="#"><i class="fa fa-cc-mastercard"></i></a></li>
								<li><a href="#"><i class="fa fa-cc-discover"></i></a></li>
								<li><a href="#"><i class="fa fa-cc-amex"></i></a></li>
							</ul>
							<span class="copyright">
								<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
								Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved
							<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
							</span>
						</div>
					</div>
						<!-- /row -->
				</div>
				<!-- /container -->
			</div>
			<!-- /bottom footer -->
		</footer>
		<!-- /FOOTER -->

		<!-- jQuery Plugins -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/slick.min.js"></script>
		<script src="js/nouislider.min.js"></script>
		<script src="js/jquery.zoom.min.js"></script>
		<script src="js/main.js"></script>
		<script type="text/javascript">
			function checkValue() {
				if(!document.getElementById("user-id").value) {
					alert("���̵� �Է��ϼ���");
					return false;
				}
				if(!document.getElementById("password").value) {
					alert("��й�ȣ�� �Է��ϼ���");
					return false;
				}
				if( document.getElementById("password").value != document.getElementById("password-check").value ) {
					alert("��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
					return false;
				}
			}
		</script>
	</body>
</html>