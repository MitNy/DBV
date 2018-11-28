<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
 <%@ page import="Service.reservationService" %>
  <%@ page import="Service.theaterService" %>
  <%@ page import="Service.infoService" %>
  <%@ page import="Service.movieService" %>
    <%@ page import="org.json.simple.JSONArray" %>
    <%@ page import="org.json.simple.JSONObject" %>

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
	theaterService ts = new theaterService();
	reservationService rvs = new reservationService();
	movieService ms = new movieService();
	
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
					<div class="col-md-7">
						<!-- Billing Details -->
						<div class="select-movie">
							<div class="section-title">
								<h3 class="title">영화 선택</h3>
							</div>
                            <select class="input-select" id="select-movie" name="select-movie" style="width:100%;">
                            	<option value='' selected>-- 선택 --</option>
								<%
									JSONArray movieList = ms.getMovieList();
									for( int i=0; i<movieList.size(); i++ ) {
										out.print("<option value='"+i+"'>"+movieList.get(i)+"</option>");
									}
								%>
				            </select>
                            
                            
						</div>
                        <br>
						<!-- /Billing Details -->
                        <div class="select-the">
							<div class="section-title">
								<h3 class="title">영화관 선택</h3>
							</div>
                            <select class="input-select" id="select-theater" name="select-theater" style="width:100%;">
                            <option value='' selected>-- 선택 --</option>
                                <%
									JSONArray theaterList = ts.getTheaterList();
									for( int i=0; i<theaterList.size(); i++ ) {
										out.print("<option value='"+i+"'>"+theaterList.get(i)+"</option>");
									}
								%>

				            </select>
                            
                            
						</div>
                        <br>
						<!-- /Billing Details -->
                        <div class="select-date">
							<div class="section-title">
								<h3 class="title">날짜 선택</h3>
							</div>
                            <input class="input" type="date" id="select-date" name="select-date">
						</div>
                        <br>
						<!-- /Billing Details -->
                        <div class="select-time">
							<div class="section-title">
								<h3 class="title">시간 선택</h3>
							</div>
                            <select class="input-select" id="select-time" name="select-time" style="width:100%;">
                            	<option value='' selected>-- 선택 --</option>
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
							<div class="col-md-5">
								<input type="number" class="input" id="seat-number" name="seat-number" min="1" max="15" required> 명
								<button class="black-btn" id="select-button">좌석 선택하기</button>
							</div>
						</div>
								<div id="seats-script" style="display:none;">
								<div class="seatStructure">
										<table class='table borderless' id="seatsBlock">
										  <tr>
										    <td colspan="14"><div class="screen">SCREEN</div></td>
										    <td rowspan="20">
										      <div class="smallBox greenBox">Selected Seat</div> <br/>
										      <div class="smallBox redBox">Reserved Seat</div><br/>
										      <div class="smallBox emptyBox">Empty Seat</div><br/>
										    </td>
										    
										    <br>
										  </tr>
										  
										  <tr>
										    <td></td>
										    <td>1</td>
										    <td>2</td>
										    <td>3</td>
										    <td>4</td>
										    <td>5</td>
										    <td></td>
										    <td>6</td>
										    <td>7</td>
										    <td>8</td>
										    <td>9</td>
										    <td>10</td>
										    <td>11</td>
										    <td>12</td>
										</tr>
										  
										<tr>
										    <td>A</td>
										    <td><input type="checkbox" class="seats" value="A1"></td>
										    <td><input type="checkbox" class="seats" value="A2"></td>
										    <td><input type="checkbox" class="seats" value="A3"></td>
										    <td><input type="checkbox" class="seats" value="A4"></td>
										    <td><input type="checkbox" class="seats" value="A5"></td>
										    <td class="seatGap"></td>
										    <td><input type="checkbox" class="seats" value="A6"></td>
										    <td><input type="checkbox" class="seats" value="A7"></td>
										    <td><input type="checkbox" class="seats" value="A8"></td>
										    <td><input type="checkbox" class="seats" value="A9"></td>
										    <td><input type="checkbox" class="seats" value="A10"></td>
										    <td><input type="checkbox" class="seats" value="A11"></td>
										    <td><input type="checkbox" class="seats" value="A12"></td>
										  </tr>
										  
										  <tr>
										    <td>B</td>
										    <td><input type="checkbox" class="seats" value="B1"></td>
										    <td><input type="checkbox" class="seats" value="B2"></td>
										    <td><input type="checkbox" class="seats" value="B3"></td>
										    <td><input type="checkbox" class="seats" value="B4"></td>
										    <td><input type="checkbox" class="seats" value="B5"></td>
										    <td></td>
										    <td><input type="checkbox" class="seats" value="B6"></td>
										    <td><input type="checkbox" class="seats" value="B7"></td>
										    <td><input type="checkbox" class="seats" value="B8"></td>
										    <td><input type="checkbox" class="seats" value="B9"></td>
										    <td><input type="checkbox" class="seats" value="B10"></td>
										    <td><input type="checkbox" class="seats" value="B11"></td>
										    <td><input type="checkbox" class="seats" value="B12"></td>
										  </tr>
										  
										  <tr>
										    <td>C</td>
										    <td><input type="checkbox" class="seats" value="C1"></td>
										    <td><input type="checkbox" class="seats" value="C2"></td>
										    <td><input type="checkbox" class="seats" value="C3"></td>
										    <td><input type="checkbox" class="seats" value="C4"></td>
										    <td><input type="checkbox" class="seats" value="C5"></td>
										    <td></td>
										    <td><input type="checkbox" class="seats" value="C6"></td>
										    <td><input type="checkbox" class="seats" value="C7"></td>
										    <td><input type="checkbox" class="seats" value="C8"></td>
										    <td><input type="checkbox" class="seats" value="C9"></td>
										    <td><input type="checkbox" class="seats" value="C10"></td>
										    <td><input type="checkbox" class="seats" value="C11"></td>
										    <td><input type="checkbox" class="seats" value="C12"></td>
										</tr>
										  
										<tr>
										    <td>D</td>
										    <td><input type="checkbox" class="seats" value="D1"></td>
										    <td><input type="checkbox" class="seats" value="D2"></td>
										    <td><input type="checkbox" class="seats" value="D3"></td>
										    <td><input type="checkbox" class="seats" value="D4"></td>
										    <td><input type="checkbox" class="seats" value="D5"></td>
										    <td></td>
										    <td><input type="checkbox" class="seats" value="D6"></td>
										    <td><input type="checkbox" class="seats" value="D7"></td>
										    <td><input type="checkbox" class="seats" value="D8"></td>
										    <td><input type="checkbox" class="seats" value="D9"></td>
										    <td><input type="checkbox" class="seats" value="D10"></td>
										    <td><input type="checkbox" class="seats" value="D11"></td>
										    <td><input type="checkbox" class="seats" value="D12"></td>
										</tr>
										  
										<tr>
										    <td>E</td>
										    <td><input type="checkbox" class="seats" value="E1"></td>
										    <td><input type="checkbox" class="seats" value="E2"></td>
										    <td><input type="checkbox" class="seats" value="E3"></td>
										    <td><input type="checkbox" class="seats" value="E4"></td>
										    <td><input type="checkbox" class="seats" value="E5"></td>
										    <td></td>
										    <td><input type="checkbox" class="seats" value="E6"></td>
										    <td><input type="checkbox" class="seats" value="E7"></td>
										    <td><input type="checkbox" class="seats" value="E8"></td>
										    <td><input type="checkbox" class="seats" value="E9"></td>
										    <td><input type="checkbox" class="seats" value="E10"></td>
										    <td><input type="checkbox" class="seats" value="E11"></td>
										    <td><input type="checkbox" class="seats" value="E12"></td>
										</tr>
										  
										<tr class="seatVGap"></tr>
										  
										<tr>
										    <td>F</td>
										    <td><input type="checkbox" class="seats" value="F1"></td>
										    <td><input type="checkbox" class="seats" value="F2"></td>
										    <td><input type="checkbox" class="seats" value="F3"></td>
										    <td><input type="checkbox" class="seats" value="F4"></td>
										    <td><input type="checkbox" class="seats" value="F5"></td>
										    <td></td>
										    <td><input type="checkbox" class="seats" value="F6"></td>
										    <td><input type="checkbox" class="seats" value="F7"></td>
										    <td><input type="checkbox" class="seats" value="F8"></td>
										    <td><input type="checkbox" class="seats" value="F9"></td>
										    <td><input type="checkbox" class="seats" value="F10"></td>
										    <td><input type="checkbox" class="seats" value="F11"></td>
										    <td><input type="checkbox" class="seats" value="F12"></td>
										</tr>
										  
										<tr>
										    <td>G</td>
										    <td><input type="checkbox" class="seats" value="G1"></td>
										    <td><input type="checkbox" class="seats" value="G2"></td>
										    <td><input type="checkbox" class="seats" value="G3"></td>
										    <td><input type="checkbox" class="seats" value="G4"></td>
										    <td><input type="checkbox" class="seats" value="G5"></td>
										    <td></td>
										    <td><input type="checkbox" class="seats" value="G6"></td>
										    <td><input type="checkbox" class="seats" value="G7"></td>
										    <td><input type="checkbox" class="seats" value="G8"></td>
										    <td><input type="checkbox" class="seats" value="G9"></td>
										    <td><input type="checkbox" class="seats" value="G10"></td>
										    <td><input type="checkbox" class="seats" value="G11"></td>
										    <td><input type="checkbox" class="seats" value="G12"></td>
										</tr>
										  
										<tr>
										    <td>H</td>
										    <td><input type="checkbox" class="seats" value="H1"></td>
										    <td><input type="checkbox" class="seats" value="H2"></td>
										    <td><input type="checkbox" class="seats" value="H3"></td>
										    <td><input type="checkbox" class="seats" value="H4"></td>
										    <td><input type="checkbox" class="seats" value="H5"></td>
										    <td></td>
										    <td><input type="checkbox" class="seats" value="H6"></td>
										    <td><input type="checkbox" class="seats" value="H7"></td>
										    <td><input type="checkbox" class="seats" value="H8"></td>
										    <td><input type="checkbox" class="seats" value="H9"></td>
										    <td><input type="checkbox" class="seats" value="H10"></td>
										    <td><input type="checkbox" class="seats" value="H11"></td>
										    <td><input type="checkbox" class="seats" value="H12"></td>
										</tr>
										  
										<tr>
										    <td>I</td>
										    <td><input type="checkbox" class="seats" value="I1"></td>
										    <td><input type="checkbox" class="seats" value="I2"></td>
										    <td><input type="checkbox" class="seats" value="I3"></td>
										    <td><input type="checkbox" class="seats" value="I4"></td>
										    <td><input type="checkbox" class="seats" value="I5"></td>
										    <td></td>
										    <td><input type="checkbox" class="seats" value="I6"></td>
										    <td><input type="checkbox" class="seats" value="I7"></td>
										    <td><input type="checkbox" class="seats" value="I8"></td>
										    <td><input type="checkbox" class="seats" value="I9"></td>
										    <td><input type="checkbox" class="seats" value="I10"></td>
										    <td><input type="checkbox" class="seats" value="I11"></td>
										    <td><input type="checkbox" class="seats" value="I12"></td>
										</tr>
										  
										<tr>
										    <td>J</td>
										    <td><input type="checkbox" class="seats" value="J1"></td>
										    <td><input type="checkbox" class="seats" value="J2"></td>
										    <td><input type="checkbox" class="seats" value="J3"></td>
										    <td><input type="checkbox" class="seats" value="J4"></td>
										    <td><input type="checkbox" class="seats" value="J5"></td>
										    <td></td>
										    <td><input type="checkbox" class="seats" value="J6"></td>
										    <td><input type="checkbox" class="seats" value="J7"></td>
										    <td><input type="checkbox" class="seats" value="J8"></td>
										    <td><input type="checkbox" class="seats" value="J9"></td>
										    <td><input type="checkbox" class="seats" value="J10"></td>
										    <td><input type="checkbox" class="seats" value="J11"></td>
										    <td><input type="checkbox" class="seats" value="J12"></td>
										</tr>
										  
										  
										</table>
										  
										<br/><button class="black-btn" id="confirm">선택한 좌석으로 예매하기</button>
</div>
							
							</div>

					</div>
                    <br><br>
					<!-- Order Details -->
					<div class="col-md-5 order-details">
                        <form action="reservationPro.jsp" method="post">
						<div class="section-title text-center">
							<h3 class="title">예매 내역</h3>
						</div>
						<div class="order-summary">
							<div class="order-products">
								<input type="hidden" name="user-id" value="<%=sessionID%>">
								<div class="order-col">
									<div>영화</div>
									<input type="hidden" name="selected-movie">
									<div><strong id="selected-movie"></strong></div>
									
								</div>
								<div class="order-col">
									<div>영화관</div>
									<input type="hidden" name="selected-theater">
									<div><strong id="selected-theater"></strong></div>
									
								</div>
                                <div class="order-col">
								<div>날짜</div>
								<input type="hidden" name="selected-date">
                                <div><strong id="selected-date"></strong></div>
                                
							</div>
                                <div class="order-col">
								<div>시간</div>
								<input type="hidden" name="selected-time">
                                <div><strong id="selected-time"></strong></div>
                                
							</div>
                                <div class="order-col">
								<div>좌석</div>
								<input type="hidden" name="selected-seats">
                                <input type="hidden" name="seats-number">
                                <div><strong id="selected-seats"></strong></div>
							</div>
                                <div class="order-col">
								<div>티켓 가격</div>
                                <div><strong id="ticket-price">12000</strong></div>
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
							<input type="hidden" name="use-point">
							<input type="checkbox" id="terms">
							<label for="terms">
								<span></span>
								포인트 사용
							</label>
						</div>
							<div class="order-col">
								<div><strong>TOTAL</strong></div>
								<input type="hidden" name="used-point">
								<input type="hidden" name="total-price">
								<div><strong class="order-total" id="total-price"></strong></div>
							</div>
						</div>
                        <input class="primary-btn order-submit" type="submit" value="결제 하기">
					</form> <!-- /form -->
					</div>
					<!-- /Order Details -->
                            
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
		<script>​
			$("input[name=use-point]").val("F");
			$("input[name=used-point]").val(0);
			$("#terms").click(function() {
				var chkbox = document.getElementById("terms");
				var point = parseInt($("#user-point").html());
				var total = parseInt($(".order-total").html());
				if( point >= 1000 ) {
					if(chkbox.checked) {
							if( point >= total ) {
								$(".order-total").html(0);
								$("input[name=used-point]").val(total);
							}
							else {
								$(".order-total").html(total-point);
								$("input[name=used-point]").val(point);
							}
							$("input[name=use-point]").val("T");
							
					}
					else {
						if ( point >= total ) {
							$(".order-total").html(total);
							$("input[name=used-point]").val(0);
						}
						else {
							$(".order-total").html(total+point);
							$("input[name=used-point]").val(point);
						}
						$("input[name=use-point]").val("F");
					}
				}
				else {
					$("input[name=use-point]").val("F");
					alert("1000포인트 이상만 사용가능합니다.");
					chkbox.checked = false;
				}
			});
			
			$("#confirm").click(function() {
				if ($("input:checked").length == ($("#seat-number").val())) {
			      $(".seatStructure *").prop("disabled", true);
			      
			     var allSeatsVals = [];
			     $('#seatsBlock :checked').each(function() {
			       allSeatsVals.push($(this).val()+" ");
			     });
			     $('#selected-seats').html(allSeatsVals);
			     $("input[name=selected-seats]").val(allSeatsVals);
			     $("input[name=seats-number]").val($("#seat-number").val());
			     $("#total-price").html(parseInt($("#ticket-price").html())*$("#seat-number").val());
			     $("input[name=total-price]").val($(".order-total").html());
			    }
			  else
			    {
			      alert(($("#seat-number").val()) + " 자리를 선택해주세요.")
			    }
			});
			
			$("#select-button").click(function() {
				if( $("#seat-number").html() != null ){
					$("#seats-script").show();
				}
			})
			
			$("#select-movie").change(function() {
				$("#selected-movie").html($("#select-movie option:selected").text());
				$("input[name=selected-movie]").val($("#select-movie option:selected").text());
				
			});
			$("#select-theater").change(function() {
				$("#selected-theater").html($("#select-theater option:selected").text());
				$("input[name=selected-theater]").val($("#select-theater option:selected").text());
				
			});
			$("#select-date").change(function() {
				$("#selected-date").html($("#select-date").val());
				$("input[name=selected-date]").val($("#select-date").val());
			});
			$("#select-time").change(function() {
				$("#selected-time").html($("#select-time option:selected").text());
				$("input[name=selected-time]").val($("#select-time option:selected").text());
				
			});
			
			
		</script>
	</body>
</html>
