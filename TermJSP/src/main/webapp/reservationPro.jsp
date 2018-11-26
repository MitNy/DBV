<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Date" %>
<%@ page import="Dao.Database" %>
<%@ page import="Service.reservationService" %>
<% 
	Database dbCon = new Database();
	reservationService rs = new reservationService();
	Connection conn = dbCon.GetConnection();
	String userID = request.getParameter("user-id");
	String movieName = request.getParameter("selected-movie");
	String theaterName = request.getParameter("selected-theater");
	String date = request.getParameter("selected-date");
	String time = request.getParameter("selected-time");
	String seats = request.getParameter("selected-seats");
	String ticketNumber= request.getParameter("seats-number");
	String usePoint = request.getParameter("use-point");
	String usedPoint = request.getParameter("used-point");
	String totalPrice = request.getParameter("total-price");
	boolean addResult = rs.reservation(userID, movieName, theaterName, date, time, seats, ticketNumber,usePoint,usedPoint,totalPrice);
	if( addResult == true) {
		%>
		<script>alert("예매가 완료되었습니다."); history.go(-1);</script>
		<%
	}
	else {
		%>
		<script>alert("예매가 불가능합니다."); history.go(-1);</script>
		<%
	}
	
%>