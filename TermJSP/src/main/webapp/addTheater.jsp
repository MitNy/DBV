<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Date" %>
<%@ page import="Dao.Database" %>
<%@ page import="Service.adminService" %>
<% 
	adminService as = new adminService();
	String theaterID = request.getParameter("theaterID");
	String theaterName = request.getParameter("theaterName");
	String theaterAddress = request.getParameter("theaterAddress");
	String theaterTel = request.getParameter("theaterTel");
	boolean addResult = as.addTheater(theaterID, theaterName, theaterAddress, theaterTel);
	
	if( addResult == true) {
		%>
	  	<script>alert("영화관이 추가되었습니다."); window.location.href="theaterManager.jsp";</script>
		<%
	}
	else {
		%>
		<script>alert("영화관을 추가할 수 없습니다."); history.go(-1);</script>
		<%
	}
	
%>