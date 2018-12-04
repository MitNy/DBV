<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
    <%@ page import="Service.adminService" %>
    <%@ page import="Service.theaterService" %>
    <%@ page import="Service.movieService" %>
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
	<% if(session.getAttribute("admin-session") == null ) {
		%><script>alert("권한이 없습니다."); history.go(-1);</script>
		<%
	}
    adminService as = new adminService();
    theaterService ts = new theaterService();
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
						<li><a href="movieManager.jsp">영화 관리</a></li>
                        <li class="active"><a href="theaterManager.jsp">영화관 관리</a></li>
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
						<h3 class="breadcrumb-header">영화관 관리</h3>
						<ul class="breadcrumb-tree">
							<li><a href="#">관리자 페이지</a></li>
							<li class="active">영화관 관리</li>
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
                    <button id="addButton" data-toggle="modal" data-target="#addModal">영화관 추가</button>
				<table id="reservation-list">
                            <thead>
                                <tr>
                                	<th>영화관 아이디</th>
                                    <th>영화관 이름</th>
                                    <th>주소</th>
                                    <th>전화번호</th>
                                    <th>상영관</th>
                                    <th>총 좌석 수</th>
                                    <th colspan="3">관리</th>
                                </tr>
                                </thead>
                                <tbody>
                                <%
                                	JSONArray theaterList = ts.getTheater();
                                	for(int i=0; i< theaterList.size(); i++ ) {
                                		JSONObject theater = (JSONObject) theaterList.get(i);
                                		String target = theater.get("theaterID-"+i).toString();
                                		String list = ts.getSList(target);
                                		int totalSeats = ts.getSeatsNumber(target);
                                		out.print("<tr id='"+target+"'>");
                                		out.print("<td>"+theater.get("theaterID-"+i)+"</td>");
                                		out.print("<td>"+theater.get("theaterName-"+i)+"</td>");
                                		out.print("<td>"+theater.get("address-"+i)+"</td>");
                                		out.print("<td>"+theater.get("number-"+i)+"</td>");
                                		out.print("<td>"+list+"</td>");
                                		out.print("<td>"+(120*totalSeats)+"</td>");
                                		out.print("<td><a class='tableBtn' onclick=dynamicManagerModal('"+target+"')>상영관 관리</a></td>");
                                		out.print("<td><a class='tableBtn' onclick=dynamicEditModal('"+target+"')>수정</a></td>");
                                		out.print("<td><a class='tableBtn' onclick=dynamicDeleteModal('"+target+"')>삭제</a></td>");
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
        <!--modal-->
<div id="addModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">영화 추가</h4>
      </div>
      <form action="addTheater.jsp" method="post">
      <div class="modal-body">
      		
      					<div class="form-group">
								<input class="input" type="text" id="theaterID" name="theaterID" placeholder="영화관 아이디">
						</div>
                        <div class="form-group">
								<input class="input" type="text" id="theaterName" name="theaterName" placeholder="영화관 이름">
							</div>
                        <div class="form-group">
								<input class="input" type="text" id="theaterAddress" name="theaterAddress" placeholder="주소">
							</div>
                        <div class="form-group">
								<input class="input" type="tel" name="theaterTel" placeholder="전화번호">
							</div>
							</div>
      <div class="modal-footer">
        <input type="submit" class="btn btn-default"  value="추가">
      </div>
      </form>
    </div>
  </div>
</div>
        <!-- /modal -->
        
        
        <!--  sangyounggwan modal -->
        <div id="sModal" class="modal fade" role="dialog">
  	<div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">상영관 관리</h4>
      </div>
      <div class="modal-body">
      		
      					<!--  <div class="form-group">
      							<p id="form-title">영화관 아이디</p>
								<input class="input" type="text" id="theaterID" name="theaterID" readonly>
						</div>-->
						<table id="theaterInfo">
								<tr>
									<th>영화관 아이디</th>
									<th>영화관 이름</th>
								</tr>
								<tr>
									<td id="theaterID"></td>
									<td id="theaterName"></td>
								</tr>
						</table>
						<br>
						<table>
							<tr>
								<td id="sAdd">
								상영관 이름 <input class="input" type="text" id="sName" name="sName"><br><br>
								상영 영화 
								<select class="input-select" id="movieName" name="movieName">
                            	<option value='' selected>-- 선택 --</option>
								<%
									JSONArray movieList = ms.getMovieList();
									for( int i=0; i<movieList.size(); i++ ) {
										out.print("<option value='"+i+"'>"+movieList.get(i)+"</option>");
									}
								%>
				            </select>
								<br><br>
								상영 시간<br>(0시0분 부터 0시간 간격으로)<input class="input" type="text" id="movieTime" name="movieTime" placeholder="00:00/00">
								<p id="message"></p><button class="black-btn" id="sAddBtn">추가</button>
								</td>
								<td id="sList">
								
								</td>
								</tr>
						</table>
                        
							</div>
    </div>
  </div>
</div>
        
        <!--  /sangyounggwan modal -->
        <!--edit modal-->
        <div id="editModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">영화관 수정</h4>
      </div>
      <div class="modal-body">
      			
                        <div class="form-group">
                        		<p class="form-title">영화관 아이디</p>
								<input class="input" type="text" id="theaterID" name="theaterID" placeholder="영화관 아이디">
							</div>
                        <div class="form-group">
                        		<p class="form-title">영화관 이름</p>
								<input class="input" type="text" id="theaterName" name="theaterName" placeholder="영화관 이름">
							</div>
                        <div class="form-group">
                        		<p class="form-title">주소</p>
								<input class="input" type="text" id="address" name="address" placeholder="주소">
							</div>
                        <div class="form-group">
                        		<p class="form-title">전화번호</p>
								<input class="input" type="text" id="number" name="number" placeholder="전화번호">
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
        <!--delete modal-->
	   <div class="modal fade" id="deleteSModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
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
            
            function dynamicManagerModal(target) {
            	$("#sModal").modal("show");
            	$("#sModal #theaterID").html(target);
            	$("#sModal #theaterName").html($("#"+target).find("td:nth-child(2)").text());
            	getSangyounggwanInfo(target);
            	
            }
            
            function getSangyounggwanInfo(theaterID) {
            	$.ajax({
            		url:"getSangyounggwan.jsp",
            		type:"post",
            		data:{
            			"theaterID":theaterID
            		},
            		dataType:"json",
            		success:function(data) {
            			var target = theaterID;
            			var json = jQuery.parseJSON(JSON.stringify(data));
            			var totalLength = Object.keys(json).length;
            			var divValue = "";
            			var result = "";
            			
            			for( var i=0; i<totalLength; i++ ) {
            				var jsonLength = Object.keys(json[i]).length;
            				divValue = "<div class='d-inline-block'>";
            				divValue += "<strong id='sID'>"+json[i].sID+"</strong>&nbsp;"+json[i].movieName;
            				divValue += "<button type='button' class='close' onclick=dynamicDeleteS('"+target+"','"+json[i].sID+"')>&times;</button>&nbsp;";
            				divValue += "<select class='input-select' style='width:auto;'>";
            				for( var j=0; j<jsonLength-2; j++ ) {
            					var jsonKey = "time-"+j;
            					divValue += "<option value=''>"+json[i][jsonKey]+"</option>";
            				}
            				divValue+= "</select></div>";
            				result += divValue;
            				
            			}
            			$("#sList").html(result);
            				
            			}
            	});
            }
            
            $("#sAddBtn").click(function() {
            	var theaterID = $("#sModal #theaterID").html();
            	var sName = $("#sName").val();
            	var movieName = $("#movieName option:selected").text();
            	var movieTime = $("#movieTime").val();
            	$.post("addSangyounggwan.jsp",
       			{
            		"theaterID":theaterID,
    				"sName":sName,
					"movieName":movieName,
					"movieTime":movieTime
       			},
       			function(data,status) {
       				$("#sAdd #message").html(data);
       				window.location.reload();
       			}	
       			
       			// ajax로  getSangyounggwanInfo 에 요청 -> json object받아옴 
       			);
            });
            
            function dynamicEditModal(target) {
            	$("#target-name").html(target);
            	var originID = $("#"+target).find("td:nth-child(1)").text();
            	$("#editModal #theaterID").val($("#"+target).find("td:nth-child(1)").text());
            	$("#editModal #theaterName").val($("#"+target).find("td:nth-child(2)").text());
            	$("#editModal #address").val($("#"+target).find("td:nth-child(3)").text());
            	$("#editModal #number").val($("#"+target).find("td:nth-child(4)").text());
            	$("#editModal").modal("show");
            	
            	if( $("#editSubmit").click(function() {
            		$.post("editTheater.jsp",
           					{
            					"originID": originID,
           						"theaterID": $("#editModal #theaterID").val(),
           						"theaterName":$("#editModal #theaterName").val(),
           						"address":$("#editModal #address").val(),
           						"number":$("#editModal #number").val(),
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
            	$("#deleteModal #target-name").html(target);
            	$("#deleteModal").modal("show");
           		$("#deleteModal #yes").click(function() {
           			$.post("deleteTheater.jsp",
           					{
           						"theaterID":target
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
            
            function dynamicDeleteS(theaterID, sID) {
            	$("#deleteSModal #target-name").html(theaterID+"-"+sID);
            	$("#deleteSModal").modal("show");
           		$("#deleteSModal #yes").click(function() {
           			$.post("deleteSangyounggwan.jsp",
           					{
           						"theaterID":theaterID,
           						"sID":sID
           					},
           					function(data,status) {
           						$("#deleteSModal .modal-footer").hide();
           						$("#deleteSModal .modal-body").html(data);
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