<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Date" %>
<%@ page import="Dao.Database" %>
<%@ page import="Service.adminService" %>
<% 
	adminService as = new adminService();
	String movieID = request.getParameter("movieID");
	String movieTitle = request.getParameter("movieTitle");
	String director = request.getParameter("director");
	String cast = request.getParameter("cast");
	String grade = request.getParameter("grade");
	String information = request.getParameter("information");

	boolean addResult = as.addMovie(movieID, movieTitle, director, cast, grade, information);
	
	if( addResult == true) {
		%>
	  	<script>alert("영화가 추가되었습니다."); window.location.href="movieManager.jsp";</script>
		<%
	}
	else {
		%>
		<script>alert("영화를 추가할 수 없습니다."); history.go(-1);</script>
		<%
	}
	
%>