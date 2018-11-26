<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="Service.adminService" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%
	adminService as = new adminService();
	String targetTheater = request.getParameter("theater");
	JSONObject theaterInfo = as.getSpecificTheater(targetTheater);
	
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
						<li class="active"><a href="theater.jsp">영화관</a></li>
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
						<h3 class="breadcrumb-header">영화관</h3>
						<ul class="breadcrumb-tree">
							<li><a href="#">홈</a></li>
							<li class="active">영화관</li>
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
					<div id="aside" class="col-md-3">
						<!-- aside Widget -->
						<div class="aside">
							<h3 class="aside-title">영화관 정보</h3>
							<div class="checkbox-filter">
                                <div>
								    <ul class="theater-selector" id="theater-selector">
                                        <li id="daejeonYuseong">대전유성</li>
                                        <li id="daejeonNoeun">대전노은</li>
                                    </ul> 
							</div>
							</div>
						</div>
						<!-- /aside Widget -->


					</div>
                    <br><br>
					<!-- /Product main img -->
					<!-- Product details -->
  					<div class="col-md-5">
                        <div id="map" style="width:100%;height:350px;"></div>
                        <br><br><br>
						<div class="product-details">
							<h2 class="product-name"><% out.print(theaterInfo.get("theaterName")); %></h2>
							<div>
								<div class="product-rating">
									<i class="fa fa-star"></i>
									<i class="fa fa-star"></i>
									<i class="fa fa-star"></i>
									<i class="fa fa-star"></i>
									<i class="fa fa-star-o"></i>
								</div>
							</div>
							<div>
							</div>
                            
							<p id="targetAddress"><% out.print(theaterInfo.get("address")); %> </p>
                            <p><% out.print(theaterInfo.get("number")); %></p>

						</div>
					</div>
					
					<!-- /Product details -->
                    
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

		<!-- jQuery Plugins -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/slick.min.js"></script>
		<script src="js/nouislider.min.js"></script>
		<script src="js/jquery.zoom.min.js"></script>
		<script src="js/main.js"></script>
		<%
			String command="<script>var redirect = $('.theater-selector li').first().attr('id');window.location.href='http://localhost:8080/Term/theater.jsp?theater='+redirect;</script>";
			if( targetTheater == null ) {
				out.print(command);
			}
		%>
        <script>
       		var target_theater = "<%=targetTheater%>";
       		if( target_theater == "" ) {
       			var redirect = $(".theater-selector li").first().attr('id');
       			window.location.href="http://localhost:8080/Term/theater.jsp?theater="+redirect;
       		}
        	if($(".theater-selector #"+target_theater).length != 0) {
        		$(".theater-selector #"+target_theater).addClass("active");
        		
        	}
        
            $(".theater-selector li").click(function() {
            	window.location.href="http://localhost:8080/Term/theater.jsp?theater="+$(this).attr('id');
            });
            
        </script>
        <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2b06ab207ca0cfe7e4e67dcecc63238a&libraries=services"></script>
<script>

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  
	
	// 지도를 생성합니다    
	var map = new daum.maps.Map(mapContainer, mapOption); 
	
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new daum.maps.services.Geocoder();
	
	// 주소로 좌표를 검색합니다
	geocoder.addressSearch($("#targetAddress").html(), function(result, status) {
	
	    // 정상적으로 검색이 완료됐으면 
	     if (status === daum.maps.services.Status.OK) {
	
	        var coords = new daum.maps.LatLng(result[0].y, result[0].x);
	
	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new daum.maps.Marker({
	            map: map,
	            position: coords
	        });
	
	        // 인포윈도우로 장소에 대한 설명을 표시합니다
	        var infowindow = new daum.maps.InfoWindow({
	            content: '<div style="width:150px;text-align:center;padding:6px 0;">'+$(".product-name").html()+'</div>'
	        });
	        infowindow.open(map, marker);
	
	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	    } 
	});
</script>
	</body>
</html>
