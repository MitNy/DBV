<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@page import="Dao.Database" %>
<%@page import="Service.movieService" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
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
                                    DBV
								</a>
							</div>
						</div>
						<!-- /LOGO -->

						<!-- SEARCH BAR -->
						<div class="col-md-6">
							<div class="header-search">
								<form action="index.jsp" method="get" name="movieSearch">
									<input class="input" name="movie" placeholder="">
									<input type="submit" class="search-btn" value="검색">
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
									<div class="products-slick" data-nav="#slick-nav-1" id="slick-nav-1">
										<%
											movieService ms = new movieService();
											String searchValue = request.getParameter("movie");
											if( searchValue == null ) {
		                                		JSONArray movieList = ms.getMovie();
		                                		for(int i=0; i<4; i++ ) {
			                                		JSONObject movie = (JSONObject) movieList.get(i);
			                                		out.print("<div class='product'>");
			                                		out.print("<div class='product-img'>");
			                                		out.print("<img src='./img/"+movie.get("movieID-"+i)+".png' alt=''><div class='product-label'><span class='new'>TOP "+(i+1)+"</span></div></div>");
			                                		out.print("<div class='product-body'>");
			                                		out.print("<h3 class='product-name'><a href='#'>"+movie.get("movieTitle-"+i)+"</a></h3>");
			                                		out.print("<button class='detail-view' data-toggle='collapse' data-target='#movie"+i+"-detail'>자세히 보기</button><br><br>");
			                                		out.print("<div id='movie"+i+"-detail' class='collapse'>");
			                                		out.print("<p class='product-category'>감독 "+movie.get("director-"+i)+"</p>");
			                                		out.print("<p class='product-category'>출연 "+movie.get("cast-"+i)+"</p>");
			                                		out.print("<p class='product-category'>"+movie.get("grade-"+i)+"세 이상 관람가</p>");
			                                		out.print("<p class='product-category'>"+movie.get("information-"+i)+"</p>");
			                                		out.print("</div></div><div class='add-to-cart'>");
			                                		out.print("<button class='add-to-cart-btn' onclick=location.href='reservation.jsp?movieID="+movie.get("movieID-"+i)+"'>예매 하기</button>");
			                                		out.print("</div></div>");
		                                		}
	                                
	                                %>
									</div>
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
									<div class="products-slick" data-nav="#slick-nav-1" id='slick-nav-2'>
										<%
											movieService ms2 = new movieService();
	                                		JSONArray movieList2 = ms2.getMovie();
	                                		for(int i=4; i<8; i++ ) {
		                                		JSONObject movie2 = (JSONObject) movieList2.get(i);
		                                		out.print("<div class='product'>");
		                                		out.print("<div class='product-img'>");
		                                		out.print("<img src='./img/"+movie2.get("movieID-"+i)+".png' alt=''></div><div class='product-body'>");
		                                		out.print("<h3 class='product-name'><a href='#'>"+movie2.get("movieTitle-"+i)+"</a></h3>");
		                                		out.print("<button class='detail-view' data-toggle='collapse' data-target='#movie"+i+"-detail'>자세히 보기</button><br><br>");
		                                		out.print("<div id='movie"+i+"-detail' class='collapse'>");
		                                		out.print("<p class='product-category'>감독 "+movie2.get("director-"+i)+"</p>");
		                                		out.print("<p class='product-category'>출연 "+movie2.get("cast-"+i)+"</p>");
		                                		out.print("<p class='product-category'>"+movie2.get("grade-"+i)+"세 이상 관람가</p>");
		                                		out.print("<p class='product-category'>"+movie2.get("information-"+i)+"</p>");
		                                		out.print("</div></div><div class='add-to-cart'>");
		                                		out.print("<button class='add-to-cart-btn' onclick=location.href='reservation.jsp?movieID="+movie2.get("movieID-"+i)+"'>예매 하기</button>");
		                                		out.print("</div></div>");
	                                	}
											}
											else {
												JSONArray movieList = ms.getSearchMovie(searchValue);
		                                		for(int i=0; i<movieList.size(); i++ ) {
			                                		JSONObject movie = (JSONObject) movieList.get(i);
			                                		out.print("<div class='product'>");
			                                		out.print("<div class='product-img'>");
			                                		out.print("<img src='./img/"+movie.get("movieID-"+i)+".png' alt=''></div>");
			                                		out.print("<div class='product-body'>");
			                                		out.print("<h3 class='product-name'><a href='#'>"+movie.get("movieTitle-"+i)+"</a></h3>");
			                                		out.print("<button class='detail-view' data-toggle='collapse' data-target='#movie"+i+"-detail'>자세히 보기</button><br><br>");
			                                		out.print("<div id='movie"+i+"-detail' class='collapse'>");
			                                		out.print("<p class='product-category'>감독 "+movie.get("director-"+i)+"</p>");
			                                		out.print("<p class='product-category'>출연 "+movie.get("cast-"+i)+"</p>");
			                                		out.print("<p class='product-category'>"+movie.get("grade-"+i)+"세 이상 관람가</p>");
			                                		out.print("<p class='product-category'>"+movie.get("information-"+i)+"</p>");
			                                		out.print("</div></div><div class='add-to-cart'>");
			                                		out.print("<button class='add-to-cart-btn' onclick=location.href='reservation.jsp?movieID="+movie.get("movieID-"+i)+"'>예매 하기</button>");
			                                		out.print("</div></div>");
		                                		}
											}
	                                %>
									</div>
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