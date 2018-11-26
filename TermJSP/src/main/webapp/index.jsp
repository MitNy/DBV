<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="Dao.Database" %>
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
        <% if( session.getAttribute("admin-session") != null ) { %>
        		<li><a href="movieManager.jsp"><i class="fas fa-wrench"></i>&nbsp;&nbsp;관리자 페이지</a></li>
        	<%
        	}
        	%>
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
						<li class="active"><a href="index.jsp">홈</a></li>
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

		<!-- SECTION -->
		<div class="section">
			<!-- container -->
			<div class="container">
				<!-- row -->
				<!-- /row -->
			</div>
			<!-- /container -->
		</div>
		<!-- /SECTION -->

		<!-- SECTION -->
		<div class="section">
			<!-- container -->
			<div class="container">
				<!-- row -->
				<div class="row">

					<!-- section title -->
					<div class="col-md-12">
						<div class="section-title">
							<h3 class="title">무비 차트</h3>
						</div>
					</div>
					<!-- /section title -->

					<!-- Products tab & slick -->
					<div class="col-md-12">
						<div class="row">
							<div class="products-tabs">
								<!-- tab -->
								<div id="tab1" class="tab-pane active">
									<div class="products-slick" data-nav="#slick-nav-1">
										<!-- product -->
										<div class="product">
											<div class="product-img">
												<img src="./img/81127_1000.png" alt="">
												<div class="product-label">
													<span class="new">TOP 1</span>
												</div>
											</div>
											<div class="product-body">
												<h3 class="product-name"><a href="#">보헤미안 랩소디</a></h3>
                                                <p class="product-category">예매율 50.0% </p>
												<p class="product-category">2018. 10. 31. 개봉 </p>
                                                
												<div class="product-rating">
													<i class="fa fa-star"></i>
													<i class="fa fa-star"></i>
													<i class="fa fa-star"></i>
													<i class="fa fa-star"></i>
													<i class="fa fa-star"></i>
												</div>
                                                    <button class="detail-view" data-toggle="collapse" data-target="#movie1-detail">자세히 보기</button>
                                                <br><br>
                                                    <div id="movie1-detail" class="collapse">
                                                        <p class="product-category">감독 호엥</p>
												        <p class="product-category">출연 누구,누구,누구</p>
                                                        <p class="product-category">15세 이상 관람가</p>
												        <p class="product-category">주저리주저리 줄거리</p>
                                                    </div>

											</div>
											<div class="add-to-cart">
												<button class="add-to-cart-btn" onclick="location.href='reservation.jsp'">예매 하기</button>
											</div>
										</div>
										<!-- /product -->

										<!-- product -->
										<div class="product">
											<div class="product-img">
												<img src="./img/81075_1000.png" alt="">
												<div class="product-label">
													<span class="new">TOP 2</span>
												</div>
											</div>
											<div class="product-body">
												<h3 class="product-name"><a href="#">신비한 동물들과 그린델왈드의 범죄</a></h3>
                                                <p class="product-category">예매율 21.0% </p>
												<p class="product-category">2018. 11. 14. 개봉 </p>
												<div class="product-rating">
													<i class="fa fa-star"></i>
													<i class="fa fa-star"></i>
													<i class="fa fa-star"></i>
													<i class="fa fa-star"></i>
													<i class="fa fa-star"></i>
												</div>
												<button class="detail-view" data-toggle="collapse" data-target="#movie2-detail">자세히 보기</button>
                                                <br><br>
                                                    <div id="movie2-detail" class="collapse">
                                                        <p class="product-category">감독 호엥</p>
												        <p class="product-category">출연 누구,누구,누구</p>
                                                        <p class="product-category">15세 이상 관람가</p>
												        <p class="product-category">주저리주저리 줄거리</p>
                                                    </div>
											</div>
											<div class="add-to-cart">
                                                <button class="add-to-cart-btn" onclick="location.href='reservation.jsp'">예매 하기</button>
											</div>
										</div>
										<!-- /product -->

										<!-- product -->
										<div class="product">
											<div class="product-img">
												<img src="./img/81332_1000.png" alt="">
                                                <div class="product-label">
													<span class="new">TOP 3</span>
												</div>
											</div>
											<div class="product-body">
												<h3 class="product-name"><a href="#">성난황소</a></h3>
                                                <p class="product-category">예매율 11.6% </p>
												<p class="product-category">2018. 11. 22. 개봉 </p>
												<div class="product-rating">
													<i class="fa fa-star"></i>
													<i class="fa fa-star"></i>
													<i class="fa fa-star"></i>
													<i class="fa fa-star"></i>
													<i class="fa fa-star"></i>
												</div>
												<button class="detail-view" data-toggle="collapse" data-target="#movie3-detail">자세히 보기</button><br><br>
                                                    <div id="movie3-detail" class="collapse">
                                                        <p class="product-category">감독 호엥</p>
												        <p class="product-category">출연 누구,누구,누구</p>
                                                        <p class="product-category">15세 이상 관람가</p>
												        <p class="product-category">주저리주저리 줄거리</p>
                                                    </div>
											</div>
											<div class="add-to-cart">
												<button class="add-to-cart-btn" onclick="location.href='reservation.jsp'">예매 하기</button>
											</div>
										</div>
										<!-- /product -->

										<!-- product -->
										<div class="product">
											<div class="product-img">
												<img src="./img/81181_1000.png" alt="">
                                                <div class="product-label">
													<span class="new">TOP 4</span>
												</div>
											</div>
											<div class="product-body">
												<h3 class="product-name"><a href="#">완벽한 타인</a></h3>
                                                <p class="product-category">예매율 5.7%</p>
												<p class="product-category">2018. 10. 31. 개봉 </p>
												<div class="product-rating">
													<i class="fa fa-star"></i>
													<i class="fa fa-star"></i>
													<i class="fa fa-star"></i>
													<i class="fa fa-star"></i>
													<i class="fa fa-star"></i>
												</div>
												<button class="detail-view" data-toggle="collapse" data-target="#movie4-detail">자세히 보기</button><br><br>
                                                    <div id="movie4-detail" class="collapse">
                                                        <p class="product-category">감독 호엥</p>
												        <p class="product-category">출연 누구,누구,누구</p>
                                                        <p class="product-category">15세 이상 관람가</p>
												        <p class="product-category">주저리주저리 줄거리</p>
                                                    </div>
											</div>
											<div class="add-to-cart">
												<button class="add-to-cart-btn" onclick="location.href='reservation.jsp'">예매 하기</button>
											</div>
										</div>
										<!-- /product -->
									</div>
									<div id="slick-nav-1" class="products-slick-nav"></div>
								</div>
								<!-- /tab -->
							</div>
						</div>
					</div>
					<!-- Products tab & slick -->
				</div>
				<!-- /row -->
			</div>
			<!-- /container -->
		</div>
		<!-- /SECTION -->


<div class="section">
			<!-- container -->
			<div class="container">
				<!-- row -->
				<div class="row">

					<!-- Products tab & slick -->
					<div class="col-md-12">
						<div class="row">
							<div class="products-tabs">
								<!-- tab -->
								<div id="tab1" class="tab-pane active">
									<div class="products-slick" data-nav="#slick-nav-1">
										<!-- product -->
										<div class="product">
											<div class="product-img">
												<img src="./img/81330_1000.png" alt="">
												<div class="product-label">
												</div>
											</div>
											<div class="product-body">
												<h3 class="product-name"><a href="#">툴리</a></h3>
                                                <p class="product-category">예매율 1.7% </p>
												<p class="product-category">2018. 11. 22. 개봉 </p>
												<div class="product-rating">
													<i class="fa fa-star"></i>
													<i class="fa fa-star"></i>
													<i class="fa fa-star"></i>
													<i class="fa fa-star"></i>
													<i class="fa fa-star"></i>
												</div>
												<button class="detail-view" data-toggle="collapse" data-target="#movie5-detail">자세히 보기</button><br><br>
                                                    <div id="movie5-detail" class="collapse">
                                                        <p class="product-category">감독 호엥</p>
												        <p class="product-category">출연 누구,누구,누구</p>
                                                        <p class="product-category">15세 이상 관람가</p>
												        <p class="product-category">주저리주저리 줄거리</p>
                                                    </div>
											</div>
											<div class="add-to-cart">
												<button class="add-to-cart-btn" onclick="location.href='reservation.jsp'">예매 하기</button>
                                            </div>
										</div>
										<!-- /product -->


										<!-- product -->
										<div class="product">
											<div class="product-img">
												<img src="./img/81368_1000.png" alt="">
												<div class="product-label">
												</div>
											</div>
											<div class="product-body">
												<h3 class="product-name"><a href="#">영주</a></h3>
                                                <p class="product-category">예매율 1.2%</p>
												<p class="product-category">2018.11.22 개봉 </p>
												<div class="product-rating">
													<i class="fa fa-star"></i>
													<i class="fa fa-star"></i>
													<i class="fa fa-star"></i>
													<i class="fa fa-star"></i>
													<i class="fa fa-star"></i>
												</div>
												<button class="detail-view" data-toggle="collapse" data-target="#movie6-detail">자세히 보기</button><br><br>
                                                    <div id="movie6-detail" class="collapse">
                                                        <p class="product-category">감독 호엥</p>
												        <p class="product-category">출연 누구,누구,누구</p>
                                                        <p class="product-category">15세 이상 관람가</p>
												        <p class="product-category">주저리주저리 줄거리</p>
                                                    </div>
											</div>
											<div class="add-to-cart">
												<button class="add-to-cart-btn" onclick="location.href='reservation.jsp'">예매 하기</button>
											</div>
										</div>
										<!-- /product -->

										<!-- product -->
										<div class="product">
											<div class="product-img">
												<img src="./img/79273_1000.png" alt="">
											</div>
											<div class="product-body">
												<h3 class="product-name"><a href="#">라라랜드</a></h3>
                                                <p class="product-category">예매율 0.2% </p>
												<p class="product-category">2016.12.07 개봉 </p>
												<div class="product-rating">
													<i class="fa fa-star"></i>
													<i class="fa fa-star"></i>
													<i class="fa fa-star"></i>
													<i class="fa fa-star"></i>
													<i class="fa fa-star"></i>
												</div>
												<button class="detail-view" data-toggle="collapse" data-target="#movie7-detail">자세히 보기</button><br><br>
                                                    <div id="movie7-detail" class="collapse">
                                                        <p class="product-category">감독 호엥</p>
												        <p class="product-category">출연 누구,누구,누구</p>
                                                        <p class="product-category">15세 이상 관람가</p>
												        <p class="product-category">주저리주저리 줄거리</p>
                                                    </div>
											</div>
											<div class="add-to-cart">
												<button class="add-to-cart-btn" onclick="location.href='reservation.jsp'">예매 하기</button>
											</div>
										</div>
										<!-- /product -->

										<!-- product -->
										<div class="product">
											<div class="product-img">
												<img src="./img/79861_1000.png" alt="">
											</div>
											<div class="product-body">
												<h3 class="product-name"><a href="#">올드보이</a></h3>
                                                <p class="product-category">예매율 0.1%</p>
												<p class="product-category">2017.07.27 재개봉 </p>
												<div class="product-rating">
													<i class="fa fa-star"></i>
													<i class="fa fa-star"></i>
													<i class="fa fa-star"></i>
													<i class="fa fa-star"></i>
													<i class="fa fa-star"></i>
												</div>
												<button class="detail-view" data-toggle="collapse" data-target="#movie8-detail">자세히 보기</button><br><br>
                                                    <div id="movie8-detail" class="collapse">
                                                        <p class="product-category">감독 호엥</p>
												        <p class="product-category">출연 누구,누구,누구</p>
                                                        <p class="product-category">15세 이상 관람가</p>
												        <p class="product-category">주저리주저리 줄거리</p>
                                                    </div>
											</div>
											<div class="add-to-cart">
												<button class="add-to-cart-btn" onclick="location.href='reservation.jsp'">예매 하기</button>
											</div>
										</div>
										<!-- /product -->
									</div>
									<div id="slick-nav-1" class="products-slick-nav"></div>
								</div>
								<!-- /tab -->
							</div>
						</div>
					</div>
					<!-- Products tab & slick -->
				</div>
				<!-- /row -->
			</div>
			<!-- /container -->
		</div>
        <br><br><br>
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

	</body>
</html>