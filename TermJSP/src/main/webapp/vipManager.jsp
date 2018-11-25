<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% if(session.getAttribute("admin-session") == null ) {
		%><script>alert("������ �����ϴ�."); history.go(-1);</script>
		<%
	}
%>
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
        <i class="fa fa-user"></i><% if( session.getAttribute("admin-session") == null ) { out.print("Admin"); }
        else { 
        	Object user = session.getAttribute("admin-session");
        	out.print(user);
        } %></a>
        <ul class="dropdown-menu user-dropdown">
          <li><a href="userInfo.jsp"><i class="fas fa-user-circle"></i>&nbsp;&nbsp;��������</a></li>
          <%
          	if( session.getAttribute("admin-session") != null) {        	  %>
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
                                    <h1>DBV</h1>
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
						<li><a href="movieManager.jsp">��ȭ ����</a></li>
                        <li><a href="theaterManager.jsp">��ȭ�� ����</a></li>
						<li><a href="ticket.jsp">Ƽ�� �߱�</a></li>
                        <li class="active"><a href="vipManager.jsp">VIP ȸ�� ����</a></li>
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
						<h3 class="breadcrumb-header">VIP ȸ�� ����</h3>
						<ul class="breadcrumb-tree">
							<li><a href="#">������ ������</a></li>
							<li class="active">VIP ȸ�� ����</li>
						</ul>
					</div>
				</div>
				<!-- /row -->
			</div>
			<!-- /container -->
		</div>
		<!-- /BREADCRUMB -->

		<!-- SECTION -->
		<div class="section">
			<!-- container -->
			<div class="container">
				<!-- row -->
				<div class="row">
					<!-- /Product main img -->
                <div class="billing-details">
                    <!-- SEARCH BAR -->
				    <div class="vip-search">
								<form>
									<input class="input" placeholder="">
									<button class="search-btn">�˻�</button>
								</form>
				    </div>
						<!-- /SEARCH BAR -->
				<table id="reservation-list">
                            <thead>
                                <tr>
                                    <th>����</th>
                                    <th>���� ���̵�</th>
                                    <th>���� ����</th>
                                    <th>����Ʈ</th>
                                    <th>���</th>
                                </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>1</td>
                                        <td>mmjlee314</td>
                                        <td>100</td>
                                        <td>10000</td>
                                        <td>VIP</td>
                                    </tr>
                                </tbody>
                    </table>
                </div>
                    
                    
                </div>
<!-- row -->
				<div class="row">
					<!-- Product main img -->

				</div>
				<!-- /row -->
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
        <!--modal-->
        <div id="addModal" class="modal fade" role="dialog">
<div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">���� ����</h4>
      </div>
      <div class="modal-body">
          <h5>���� ���̵�</h5>
          <input class="input" type="text" name="userID">
          <br><br>
            <h5>��ȭ ����</h5>
                            <select class="input-select" style="width:100%;">
								<option value="0">����̾ȷ��ҵ�</option>
                                <option value="0">�ź��ѵ�������׸����е��ǹ���</option>
                                <option value="0">����Ȳ��</option>
                                <option value="0">�Ϻ���Ÿ��</option>
                                <option value="0">����</option>
                                <option value="0">����</option>
                                <option value="0">��󷣵�</option>
                                <option value="0">�õ庸��</option>
				            </select>
                        <br><br>
          <h5>��ȭ�� ����</h5>
                            <select class="input-select" style="width:100%;">
                                <option value="0">��������</option>
                                <option value="0">��������</option>
                                <option value="0">�����л�</option>
                                <option value="0">����ź��</option>
                                <option value="0">������������</option>
				            </select>
                            <br><br>
          <h5>��¥ ����</h5>
          <input class="input" type="date" name="date">
          <br><br>
          <h5>�ð� ����</h5>
                            <select class="input-select" style="width:100%;">
                                <option value="0">09:40 (150��)</option>
                                <option value="0">12:40 (111��)</option>
                                <option value="0">15:40 (124��)</option>
                                <option value="0">18:40 (10��)</option>
                                <option value="0">20:40 (17��)</option>
				            </select>
          <br><br>
          <h5>�¼�</h5>
          <input class="input" type="text" name="seat">
          <br><br>
          <ul>
                                        <li>���� ����Ʈ�� 1,000�� �̻��� ��츸 ��� �����մϴ�.</li>
                                        <li>Ƽ�� �ż��� 100����Ʈ�� �����˴ϴ�.</li>
                                    </ul>
                                    <br>
                                    <strong>���� ����Ʈ</strong> : 900
                        <br><br>
						<div class="input-checkbox">
							<input type="checkbox" id="terms">
							<label for="terms">
								<span></span>
								����Ʈ ���
							</label>
						</div>
          
      </div>
      <div class="modal-footer">
          <p style="float:left; font-size: 20px; margin:0;"><strong>Total</strong>&nbsp;&nbsp;&nbsp;12,000
        &nbsp;&nbsp;</p><button type="button" class="btn btn-default" data-dismiss="modal">����</button>
      </div>
    </div>
            </div>
        </div>
        <!-- /modal -->
        

		<!-- jQuery Plugins -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/slick.min.js"></script>
		<script src="js/nouislider.min.js"></script>
		<script src="js/jquery.zoom.min.js"></script>
		<script src="js/main.js"></script>
        <script>
            $(".theater-selector li").click(function() {
                if( $(this).hasClass("active")) {
                    $(this).removeClass("active");
                }
                else {
                    $(this).addClass("active");
                }
            })
        </script>
	</body>
</html>