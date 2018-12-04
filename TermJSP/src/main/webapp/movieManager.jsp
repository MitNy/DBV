<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="Service.adminService" %>
<%@ page import="Service.movieService" %>
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
    adminService as = new adminService();
    movieService ms = new movieService();
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
						<li class="active"><a href="movieManager.jsp">영화 관리</a></li>
                        <li><a href="theaterManager.jsp">영화관 관리</a></li>
						<li><a href="ticket.jsp">티켓 발권</a></li>
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
						<h3 class="breadcrumb-header">영화 관리</h3>
						<ul class="breadcrumb-tree">
							<li><a href="#">관리자 페이지</a></li>
							<li class="active">영화 관리</li>
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
                    <button id="addButton" data-toggle="modal" data-target="#addModal">영화 추가</button>
				<table id="reservation-list">
                            <thead>
                                <tr>
                                    <th>영화 아이디</th>
                                    <th>영화 제목</th>
                                    <th>감독</th>
                                    <th>출연</th>
                                    <th>등급</th>
                                    <th>주요 정보</th>
                                    <th colspan="2">관리</th>
                                </tr>
                                </thead>
                                <tbody>
                                <%
                                	JSONArray movieList = ms.getMovie();
                                	for(int i=0; i<movieList.size(); i++ ) {
                                		JSONObject movie = (JSONObject) movieList.get(i);
                                		String target = movie.get("movieTitle-"+i).toString();
                                		out.print("<tr id='"+target+"'>");
                                		out.print("<td id='movieID'>"+movie.get("movieID-"+i)+"</td>");
                                		out.print("<td style='width:20%;'>"+movie.get("movieTitle-"+i)+"</td>");
                                		out.print("<td style='width:10%;'>"+movie.get("director-"+i)+"</td>");
                                		out.print("<td style='width:20%;'>"+movie.get("cast-"+i)+"</td>");
                                		out.print("<td style='width:3%;'>"+movie.get("grade-"+i)+"</td>");
                                		out.print("<td>"+movie.get("information-"+i)+"</td>");
                                		out.print("<td style='width:4%;'><a class='tableBtn' onclick=dynamicEditModal('"+target+"')>수정</a></td>");
                                		out.print("<td style='width:4%;'><a class='tableBtn' onclick=dynamicDeleteModal('"+target+"')>삭제</a></td>");
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
        <!--add modal-->
        <div id="addModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">영화 추가</h4>
      </div>
      <form action="addMovie.jsp" method="post">
      <div class="modal-body">
      			
                        <div class="form-group">
								<input class="input" type="text" id="movieID" name="movieID" placeholder="영화 아이디">
							</div>
                        <div class="form-group">
								<input class="input" type="text" id="movieTitle" name="movieTitle" placeholder="영화 제목">
							</div>
                        <div class="form-group">
								<input class="input" type="text" id="director" name="director" placeholder="감독">
							</div>
                        <div class="form-group">
								<input class="input" type="text" id="cast" name="cast" placeholder="출연">
							</div>
                        <div class="form-group">
								<input class="input" type="text" id="grade" name="grade" placeholder="등급">
							</div>
                        <div class="form-group">
								<input class="input" type="text" id="information" name="information" placeholder="주요 정보">
							</div>
							
      </div>
      <div class="modal-footer">
      <input type="submit" class="btn btn-default"  value="추가">
        <!--  data-dismiss="modal"  -->
      </div>
      </form>
    </div>

  </div>
</div>
        <!-- /add modal -->

        <!--edit modal-->
        <div id="editModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">영화 수정</h4>
      </div>
      <div class="modal-body">
      			
                        <div class="form-group">
                        		<p class="form-title">영화 아이디</p>
								<input class="input" type="text" id="movieID" name="movieID" placeholder="영화 아이디">
							</div>
                        <div class="form-group">
                        		<p class="form-title">영화 제목</p>
								<input class="input" type="text" id="movieTitle" name="movieTitle" placeholder="영화 제목">
							</div>
                        <div class="form-group">
                        		<p class="form-title">감독</p>
								<input class="input" type="text" id="director" name="director" placeholder="감독">
							</div>
                        <div class="form-group">
                        		<p class="form-title">출연</p>
								<input class="input" type="text" id="cast" name="cast" placeholder="출연">
							</div>
                        <div class="form-group">
                        		<p class="form-title">등급</p>
								<input class="input" type="text" id="grade" name="grade" placeholder="등급">
							</div>
                        <div class="form-group">
                        		<p class="form-title">주요 정보</p>
								<input class="input" type="text" id="information" name="information" placeholder="주요 정보">
							</div>
							
      </div>
      	<div class="modal-footer">
      	<input type="button" class="btn btn-default" id="editSubmit" value="수정">
        <!--  data-dismiss="modal"  -->
      </div>
    </div>

  </div>
</div>
        <!-- /edit modal -->
	     
	     <!--delete modal-->
	   <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
      <div class="modal-body">
      	<p><strong id="target-name"></strong> 삭제 하시겠습니까?</p>
      </div>
      <div class="modal-footer">
      <button type="button" class="btn btn-primary" id="yes">예</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">아니오</button>
      </div>
    </div>
  </div>
</div>
        <!-- /delete modal -->
        
        <!--  alert modal -->
	     <div class="modal fade" id="alertModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
      <div class="modal-body">
      	
      </div>
    </div>
  </div>
</div>

		<!--  /alert modal -->
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
            
            function dynamicEditModal(target) {
            	$("#target-name").html(target);
            	var originID = $("#"+target).find("td:nth-child(1)").text();
            	$("#editModal #movieID").val($("#"+target).find("td:nth-child(1)").text());
            	$("#editModal #movieTitle").val($("#"+target).find("td:nth-child(2)").text());
            	$("#editModal #director").val($("#"+target).find("td:nth-child(3)").text());
            	$("#editModal #cast").val($("#"+target).find("td:nth-child(4)").text());
            	$("#editModal #grade").val($("#"+target).find("td:nth-child(5)").text());
            	$("#editModal #information").val($("#"+target).find("td:nth-child(6)").text());
            	$("#editModal").modal("show");
            	
            	if( $("#editSubmit").click(function() {
            		$.post("editMovie.jsp",
           					{
            					"originID": originID,
           						"movieID": $("#editModal #movieID").val(),
           						"movieTitle":$("#editModal #movieTitle").val(),
           						"director":$("#editModal #director").val(),
           						"cast":$("#editModal #cast").val(),
           						"grade":$("#editModal #grade").val(),
           						"information":$("#editModal #information").val()
           					},
           					function(data,status) {
           						$("#editModal .modal-footer").hide();
           						$("#editModal .modal-body").html(data);
           						setTimeout(function(){
           						},5000);
           						window.location.reload();
           					}	
           			);
            	}));
            }
            
            function dynamicDeleteModal(target) {
            	$("#target-name").html(target);
            	$("#deleteModal").modal("show");
           		$("#yes").click(function() {
           			$.post("deleteMovie.jsp",
           					{
           						"movieName":target
           					},
           					function(data,status) {
           						$("#deleteModal .modal-footer").hide();
           						$("#deleteModal .modal-body").html(data);
           						setTimeout(function(){
           						},5000);
           						window.location.reload();
           					}	
           			);
           		});
            }
        </script>
	</body>
</html>