<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="Service.infoService" %>

<%
	String sessionID="";
	if( session.getAttribute("user-session") == null && session.getAttribute("admin-session")== null) {
		%>
			<script>alert("로그인이 필요합니다."); history.go(-1);</script>
		<%
	}
	else {
		if( session.getAttribute("user-session") != null && session.getAttribute("admin-session")== null) {
			sessionID = session.getAttribute("user-session").toString();
		}
		else {
			sessionID = session.getAttribute("admin-session").toString();
		}
		
	}
	infoService is = new infoService();
	is.getUserInto(sessionID);
%>
<!DOCTYPE html>
<html lang="kr">
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
        	// 일반 사용자 로그인
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
        %></a>
        <ul class="dropdown-menu user-dropdown">
          <li><a href="userInfo.jsp"><i class="fas fa-user-circle"></i>&nbsp;&nbsp;개인정보</a></li>
          <%
          	if( session.getAttribute("user-session") != null || session.getAttribute("admin-session") != null) {        	  %>
				<li><a href="logout.jsp"><i class="fas fa-sign-out-alt"></i>&nbsp;&nbsp;로그아웃</a></li>
          <% } else { %>
          <li><a href="login.jsp"><i class="fas fa-sign-out-alt"></i>&nbsp;&nbsp;로그인</a></li>
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
										<option value="0">전체</option>
										<option value="1">영화</option>
										<option value="1"></option>
									</select>
									<input class="input" placeholder="">
									<button class="search-btn">검색</button>
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
						<li><a href="index.jsp">홈</a></li>
						<li><a href="theater.jsp">영화관</a></li>
						<li><a href="reservation.jsp">예매</a></li>
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
						<h3 class="breadcrumb-header">개인정보</h3>
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

					<div class="col-md-7">
                        <form action="infoPro.jsp" method="post">
                        	<div class="form-group">
                        		<p class="form-title">아이디</p>
								<input class="input" type="text" id="user-id" name="user-id" value="<%=sessionID %>" readonly>
							</div>
							<div class="form-group">
								<p class="form-title">비밀번호</p>
								<input class="input" type="password" id="password" name="password" placeholder="비밀번호">
							</div>
							<div class="form-group">
								<p class="form-title">비밀번호 확인</p>
								<input class="input" type="password" id="password-check" name="password-check" placeholder="비밀번호 확인">
							</div>
							<div class="form-group">
							<p class="form-title">이름</p>
								<input class="input" type="text" id="user-name" name="user-name" value="<% out.print(is.getUserName()); %>">
							</div>
                        <div class="form-group">
                        		<p class="form-title">생년월일</p>
								<input class="input" type="text" id="user-birth" value="<% out.print(is.getUserBirthday()); %>" readonly>
							</div>
							<div class="form-group">
								<p class="form-title">주소</p>
								<input class="input" type="text" id="user-address" name="user-address" value="<% out.print(is.getUserAddress()); %>">
							</div>
							<div class="form-group">
								<p class="form-title">연락처</p>
								<input class="input" type="tel" id="user-tel" name="user-tel" value="<% out.print(is.getUserPhone()); %>">
							</div>
                        
                            <div>
                        </div>
                        <input type="submit" id="save" value="저장">
                            </form>
					</div>
                   <div class="col-sm-3">
						<div class="product">
							<div class="product-body">
								<h4>보유 포인트</h4>
                                <div class="product-rating">
								</div>
								<h4 class="product-price">
								<% out.print(is.getUserPoint()); %>
								
								</h4>
								
							</div>
						</div>
					</div>
					<!-- /product -->
<!-- product -->
					<div class="col-sm-3">
						<div class="product">
							<div class="product-body">
								<h4>회원 등급</h4>
                                <div class="product-rating">
								</div>
								<h4 class="product-price">VIP</h4>
								
							</div>
						</div>
					</div>
				</div>
                 <br><br>
				<!-- /row -->
                <div class="billing-details">
							<div class="section-title">
								<h3 class="title">최근 예매 내역</h3>
							</div>
							<table id="reservation-list">
                            <thead>
                                <tr>
                                    <th>영화</th>
                                    <th>영화관</th>
                                    <th>날짜</th>
                                    <th>시간</th>
                                    <th>좌석</th>
                                    <th>결제 여부</th>
                                </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>보헤미안랩소디</td>
                                        <td>대전유성</td>
                                        <td>2018. 11. 22.</td>
                                        <td>09:40</td>
                                        <td>H1,H2</td>
                                        <td>Y</td>
                                    </tr>
                                </tbody>
                    </table>
                </div>
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
				if(!document.getElementById("password").value) {
					alert("비밀번호를 입력하세요");
					return false;
				}
				if( document.getElementById("password").value != document.getElementById("password-check").value ) {
					alert("비밀번호가 일치하지 않습니다.");
					return false;
				}
			}
		</script>
	</body>
</html>