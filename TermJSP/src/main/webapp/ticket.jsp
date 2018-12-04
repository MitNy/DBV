<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="Service.adminService" %>
 <%@ page import="Service.reservationService" %>
  <%@ page import="Service.theaterService" %>
  <%@ page import="Service.infoService" %>
  <%@ page import="Service.movieService" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%
	adminService as = new adminService();
	infoService is = new infoService();
	theaterService ts = new theaterService();
	reservationService rvs = new reservationService();
	movieService ms = new movieService();
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
        		if(session.getAttribute("admin-session") == null ) {
        			%><script>alert("권한이 없습니다."); history.go(-1);</script>
        			<%
        		}
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
                    <button id="addButton" onclick="location.href='sceneReservation.jsp'">현장 예매</button>
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
                                		out.print("<td class='tableBtn' onclick=dynamicTicketModal('"+target+"')>발권</td>");
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
        
        <!--ticket modal-->
	   <div class="modal fade centerModal" id="ticketModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
        <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body">
			<table>
				<tr>
					<th>예매 번호</th>
					<td id="reserv_number"></td>				
				</tr>
				<tr>
					<th>결제 번호</th>
					<td id="payID"></td>				
				</tr>
				<tr>
					<th>티켓 번호</th>
					<td id="ticketID"></td>				
				</tr>
				<tr>
					<th>영화 제목</th>
					<td id="movieName"></td>				
				</tr>
				<tr>
					<th>영화관</th>
					<td id="theaterName"></td>				
				</tr>
				<tr>
					<th>날짜</th>
					<td id="date"></td>				
				</tr>
				<tr>
					<th>시간</th>
					<td id="time"></td>				
				</tr>
				<tr>
					<th>좌석</th>
					<td id="seats"></td>				
				</tr>
				
			</table>
      </div>
    </div>
  </div>
</div>
        <!-- /ticket modal -->

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
            function dynamicTicketModal(target) {
            	$("#ticketModal").modal("show");
            	$.ajax({
            		url:"getUserTicket.jsp",
            		type:"post",
            		data:{
            			"reserv_number":target
            		},
            		dataType:"json",
            		success:function(data) {
            			$("#ticketModal #reserv_number").html(target);
            			$("#ticketModal #payID").html(data.payID);
            			$("#ticketModal #ticketID").html(data.ticketID);
            			$("#ticketModal #movieName").html(data.movieName);
            			$("#ticketModal #theaterName").html(data.theaterName);
            			$("#ticketModal #date").html(data.date);
            			$("#ticketModal #time").html(data.time);
            			$("#ticketModal #seats").html(data.seats);
            		}
            	});
            }
            
        </script>
	</body>
</html>
