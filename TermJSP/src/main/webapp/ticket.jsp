<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="Service.adminService" %>
<%@ page import="Service.reservationService" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%
	adminService as = new adminService();
	reservationService rvs = new reservationService();
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
						<li><a href="movieManager.jsp">영화 관리</a></li>
                        <li><a href="theaterManager.jsp">영화관 관리</a></li>
						<li class="active"><a href="ticket.jsp">티켓 발권</a></li>
                        <li><a href="vipManager.jsp">VIP 회원 관리</a></li>
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
						<h3 class="breadcrumb-header">티켓 발권</h3>
						<ul class="breadcrumb-tree">
							<li><a href="#">관리자 페이지</a></li>
							<li class="active">티켓 발권</li>
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
                    <button id="addButton" data-toggle="modal" data-target="#addModal">현장 예매</button>
				<table id="reservation-list">
                            <thead>
                                <tr>
                                    <th>예매 아이디</th>
                                    <th>고객 아이디</th>
                                    <th>영화 제목</th>
                                    <th>영화관</th>
                                    <th>날짜</th>
                                    <th>시간</th>
                                    <th>좌석</th>
                                    <th>결제 여부</th>
                                    <th colspan="2">관리</th>
                                </tr>
                                </thead>
                                <tbody>
                                    <%
                                	JSONArray reservationList = rvs.getAllReservation();
                                	for(int i=0; i< reservationList.size(); i++ ) {
                                		JSONObject theater = (JSONObject) reservationList.get(i);
                                		String target = theater.get("reservNumber-"+i).toString();
                                		out.print("<tr id='"+target+"'>");
                                		out.print("<td>"+theater.get("reservNumber-"+i)+"</td>");
                                		out.print("<td>"+theater.get("user-"+i)+"</td>");
                                		out.print("<td>"+theater.get("movie-"+i)+"</td>");
                                		out.print("<td>"+theater.get("theater-"+i)+"</td>");
                                		out.print("<td>"+theater.get("date-"+i)+"</td>");
                                		out.print("<td>"+theater.get("time-"+i)+"</td>");
                                		out.print("<td>"+theater.get("seat-"+i)+"</td>");
                                		out.print("<td>"+theater.get("TF-"+i)+"</td>");
                                		out.print("<td class='tableBtn' onclick=dynamicPayModal('"+target+"')>결제</td>");
                                		out.print("<td class='tableBtn'>발권</td>");
                                		out.print("</tr>");
                                	}
                                
                                %>
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
        <h4 class="modal-title">현장 예매</h4>
      </div>
      <div class="modal-body">
          <h5>고객 아이디</h5>
          <div class="user-input">
                <input class="input" type="text" name="userID">
                <button class="search-btn">입력</button>
				    </div>
          <br>
            <h5>영화 선택</h5>
                            <select class="input-select" style="width:100%;">
								<option value="0">보헤미안랩소디</option>
                                <option value="0">신비한동물들과그린델왈드의범죄</option>
                                <option value="0">성난황소</option>
                                <option value="0">완벽한타인</option>
                                <option value="0">툴리</option>
                                <option value="0">영주</option>
                                <option value="0">라라랜드</option>
                                <option value="0">올드보이</option>
				            </select>
                        <br><br>
          <h5>영화관 선택</h5>
                            <select class="input-select" style="width:100%;">
                                <option value="0">대전유성</option>
                                <option value="0">대전노은</option>
                                <option value="0">대전둔산</option>
                                <option value="0">대전탄방</option>
                                <option value="0">대전갤러리아</option>
				            </select>
                            <br><br>
          <h5>날짜 선택</h5>
          <input class="input" type="date" name="date">
          <br><br>
          <h5>시간 선택</h5>
                            <select class="input-select" style="width:100%;">
                                <option value="0">09:40 (150석)</option>
                                <option value="0">12:40 (111석)</option>
                                <option value="0">15:40 (124석)</option>
                                <option value="0">18:40 (10석)</option>
                                <option value="0">20:40 (17석)</option>
				            </select>
          <br><br>
          <h5>좌석</h5>
          <input class="input" type="text" name="seat">
          <br><br>
          <ul>
                                        <li>보유 포인트가 1,000점 이상일 경우만 사용 가능합니다.</li>
                                        <li>티켓 매수당 100포인트가 적립됩니다.</li>
                                    </ul>
                                    <br>
                                    <strong>보유 포인트</strong> : 900
                        <br><br>
						<div class="input-checkbox">
							<input type="checkbox" id="terms">
							<label for="terms">
								<span></span>
								포인트 사용
							</label>
						</div>
          
      </div>
      <div class="modal-footer">
          <p style="float:left; font-size: 20px; margin:0;"><strong>Total</strong>&nbsp;&nbsp;&nbsp;12,000
        &nbsp;&nbsp;</p><button type="button" class="btn btn-default" data-dismiss="modal">결제</button>
      </div>
    </div>
            </div>
        </div>
        <!-- /modal -->
        <!--pay modal-->
	   <div class="modal fade" id="payModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
        <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body">
      </div>
      <div class="modal-footer">
      <button type="button" class="btn btn-primary" id="yes">예</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">아니오</button>
      </div>
    </div>
  </div>
</div>
        <!-- /pay modal -->

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
            });
            
            function dynamicPayModal(target) {
            	var userID = $("#"+target).find("td:nth-child(2)").text();
            	var TF = $("#"+target).find("td:nth-child(8)").text();
            	if( TF == "T" ) {
            		$("#payModal .modal-body").html("이미 결제되었습니다.");
            		$("#payModal .modal-footer").hide();
            		$("#payModal").modal("show");
            	}
            	else {
            		$("#payModal .modal-body").html("돈 내라");
            	}
            	
            }
        </script>
	</body>
</html>
