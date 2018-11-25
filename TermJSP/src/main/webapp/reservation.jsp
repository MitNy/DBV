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
	is.getUserInfo(sessionID);
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
						<li class="active"><a href="reservation.jsp">예매</a></li>
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
						<h3 class="breadcrumb-header">예매</h3>
						<ul class="breadcrumb-tree">
							<li><a href="#">홈</a></li>
							<li class="active">예매</li>
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
                        <form>
					<div class="col-md-7">
						<!-- Billing Details -->
						<div class="select-movie">
							<div class="section-title">
								<h3 class="title">영화 선택</h3>
							</div>
                            <select class="input-select" name="selected-movie" style="width:100%;">
								<option value="0">보헤미안랩소디</option>
                                <option value="0">신비한동물들과그린델왈드의범죄</option>
                                <option value="0">성난황소</option>
                                <option value="0">완벽한타인</option>
                                <option value="0">툴리</option>
                                <option value="0">영주</option>
                                <option value="0">라라랜드</option>
                                <option value="0">올드보이</option>
				            </select>
                            
                            
						</div>
                        <br>
						<!-- /Billing Details -->
                        <div class="select-the">
							<div class="section-title">
								<h3 class="title">영화관 선택</h3>
							</div>
                            <select class="input-select" name="selected-sang" style="width:100%;">
                                <option value="0">대전유성</option>
                                <option value="0">대전노은</option>
                                <option value="0">대전둔산</option>
                                <option value="0">대전탄방</option>
                                <option value="0">대전갤러리아</option>
				            </select>
                            
                            
						</div>
                        <br>
						<!-- /Billing Details -->
                        <div class="select-date">
							<div class="section-title">
								<h3 class="title">날짜 선택</h3>
							</div>
                            <input class="input" type="date" name="date">
						</div>
                        <br>
						<!-- /Billing Details -->
                        <div class="select-time">
							<div class="section-title">
								<h3 class="title">시간 선택</h3>
							</div>
                            <select class="input-select" name="selected-time" style="width:100%;">
                                <option value="0">09:40 (150석)</option>
                                <option value="0">12:40 (111석)</option>
                                <option value="0">15:40 (124석)</option>
                                <option value="0">18:40 (10석)</option>
                                <option value="0">20:40 (17석)</option>
				            </select>
						</div><br>
                        <div class="select-seats">
							<div class="section-title">
								<h3 class="title">좌석 선택</h3>
							</div>
                            <select class="input-select" name="seleted-seats" style="width:100%;">
                                <option value="0">09:40 (150석)</option>
                                <option value="0">12:40 (111석)</option>
                                <option value="0">15:40 (124석)</option>
                                <option value="0">18:40 (10석)</option>
                                <option value="0">20:40 (17석)</option>
				            </select>
						</div>

					</div>
                    <br><br>
					<!-- Order Details -->
					<div class="col-md-5 order-details">
						<div class="section-title text-center">
							<h3 class="title">예매 내역</h3>
						</div>
						<div class="order-summary">
							<div class="order-products">
								<div class="order-col">
									<div>영화</div>
									<div><strong>보헤미안랩소디</strong></div>
								</div>
								<div class="order-col">
									<div>영화관</div>
									<div><strong>대전유성</strong></div>
								</div>
                                <div class="order-col">
								<div>날짜</div>
                                <div><strong>2018.11.22.</strong></div>
							</div>
                                <div class="order-col">
								<div>시간</div>
                                <div><strong>09:40</strong></div>
							</div>
                                <div class="order-col">
								<div>좌석</div>
                                <div><strong>H1,H2</strong></div>
							</div>
                                <div class="order-col">
								<div>티켓 가격</div>
                                <div><strong>12,000</strong></div>
							</div>
							</div><br><br>
							<ul>
                                        <li>보유 포인트가 1,000점 이상일 경우만 사용 가능합니다.</li>
                                        <li>티켓 매수당 100포인트가 적립됩니다.</li>
                                    </ul>
                                    <br>
                                    <strong>보유 포인트</strong> : <p id="user-point"><% out.print(is.getUserPoint()); %></p>
                        <br><br>
						<div class="input-checkbox">
							<input type="checkbox" id="terms">
							<label for="terms">
								<span></span>
								포인트 사용
							</label>
						</div>
							<div class="order-col">
								<div><strong>TOTAL</strong></div>
								<div><strong class="order-total">24000</strong></div>
							</div>
						</div>
						
                        <input class="primary-btn order-submit" type="submit" value="결제 하기">
					</div>
					<!-- /Order Details -->
                            </form> <!-- /form -->
				</div>
				<!-- /row -->
			</div>
			<!-- /container -->
		</div>
		<!-- /SECTION -->

        <div style="height:300px"></div>
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
		<!-- checkbox -->
				<script>
			$("#terms").click(function() {
				var chkbox = document.getElementById("terms");
				var point = parseInt($("#user-point").html());
				var total = parseInt($(".order-total").html());
				if(chkbox.checked) {
					$(".order-total").html(total-point);
				}
				else {
					$(".order-total").html(total+point);
				}
			});
		</script>
	</body>
</html>
