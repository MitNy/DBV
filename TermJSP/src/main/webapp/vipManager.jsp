<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="Service.infoService" %>
<%@ page import="Service.adminService" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>

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
	<% if(session.getAttribute("admin-session") == null ) {
		%><script>alert("권한이 없습니다."); history.go(-1);</script>
		<%
	}
%>
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
        <% if( session.getAttribute("admin-session") != null ) { %>
        		<li><a href="movieManager.jsp"><i class="fas fa-wrench"></i>&nbsp;&nbsp;관리자 페이지</a></li>
        	<%
        	}
        	%>
          <li><a href="userInfo.jsp"><i class="fas fa-user-circle"></i>&nbsp;&nbsp;개인정보</a></li>
          <%
          	if( session.getAttribute("admin-session") != null) {        	  %>
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
						<li><a href="ticket.jsp">티켓 발권</a></li>
                        <li class="active"><a href="vipManager.jsp">VIP 회원 관리</a></li>
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
						<h3 class="breadcrumb-header">VIP 회원 관리</h3>
						<ul class="breadcrumb-tree">
							<li><a href="#">관리자 페이지</a></li>
							<li class="active">VIP 회원 관리</li>
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
						<form action="vipManager.jsp" method="get" name="vipSearch">
							<input class="input" name="search-value" placeholder="">
							<input type="submit" class="search-btn" value="검색">
						</form>
				    </div>
						<!-- /SEARCH BAR -->
				<table id="reservation-list">
                            <thead>
                                <tr>
                                    <th>순위</th>
                                    <th>고객 아이디</th>
                                    <th>구매 실적</th>
                                    <th>포인트</th>
                                    <th>등급</th>
                                    <!-- <th>관리</th> -->
                                </tr>
                                </thead>
                                <tbody>
                                    <%
                                    	adminService as = new adminService();
                                    	String searchValue = request.getParameter("search-value");
                                    	if( searchValue == null ) {
	                                		JSONArray userList = as.getVipUser();
		                                	for(int i=0; i<userList.size(); i++ ) {
		                                		JSONObject user = (JSONObject) userList.get(i);
		                                		String target = user.get("userID-"+i).toString();
												out.print("<tr id='"+target+"'>");
												out.print("<td>"+(i+1)+"</td>");
												out.print("<td>"+user.get("userID-"+i)+"</td>");
												out.print("<td>"+user.get("result-"+i)+"</td>");
												out.print("<td>"+user.get("userPoint-"+i)+"</td>");
												out.print("<td>"+user.get("userGrade-"+i)+"</td>");
												//out.print("<td><a class='tableBtn' onclick=dynamicGradeModal('"+target+"')>등급 변경</a></td>");
		                                		out.print("</tr>");
		                                	}
                                		}
                                    	else {
                                			JSONArray searchList = as.getVipUser(searchValue);
                                			for(int i=0; i<searchList.size(); i++ ) {
		                                		JSONObject user = (JSONObject) searchList.get(i);
		                                		String target = user.get("userID-"+i).toString();
												out.print("<tr id='"+target+"'>");
												out.print("<td>"+(i+1)+"</td>");
												out.print("<td>"+user.get("userID-"+i)+"</td>");
												out.print("<td>"+user.get("result-"+i)+"</td>");
												out.print("<td>"+user.get("userPoint-"+i)+"</td>");
												out.print("<td>"+user.get("userGrade-"+i)+"</td>");
												//out.print("<td><a class='tableBtn' onclick=dynamicGradeModal('"+target+"')>등급 변경</a></td>");
		                                		out.print("</tr>");
		                                	}
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
		
		 <!--grade modal-->
	   <div class="modal fade centerModal" id="gradeModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
      <div class="modal-body">
      	<p><strong id="target-name"></strong> 회원의 등급 변경</p>
      	<p>현재 등급 : <strong id="target-grade"></strong></p>
      	<select id="select-grade">
      		<option value="">-- * --</option>
      		<option value="general">일반</option>
      		<option value="vip">VIP</option>
      	</select>
      	<p class="alert"></p>
      </div>
      <div class="modal-footer">
      <button type="button" class="btn btn-primary" id="yes">확인</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>
        <!-- /delete modal -->	
		
		<!-- /FOOTER -->
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
            function dynamicGradeModal(target) {
            	$("#gradeModal #target-name").html(target);
            	var currentGrade = $("#"+target).find("td:nth-child(5)").text();
            	$("#gradeModal #target-grade").html(currentGrade);
            	$("#gradeModal").modal("show");
            	
            	var updateGrade = null;
            	$("#select-grade").change(function() {
    				updateGrade = $("#select-grade option:selected").text();
    			});
            	$("#yes").click(function() {
            		if( currentGrade == updateGrade ) {
            			$(".alert").html("동일한 등급으로 변경할 수 없습니다.");
            		}
            		else {
            			$.post("updateGrade.jsp",
            					{
            						"userID":target,
            						"grade":updateGrade
            					},
            					function(data,status) {
            						$("#gradeModal .modal-footer").hide();
               						$("#gradeModal .modal-body").html(data);
               						window.location.reload();
            				}
            		);
            		}
            	});
            }
            
        </script>
	</body>
</html>
