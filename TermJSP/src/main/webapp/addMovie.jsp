<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
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

	out.print(movieID);
	boolean addResult = as.addMovie(movieID, movieTitle, director, cast, grade, information);
	
	if( addResult == true) {
		%>
	  	<script>alert("��ȭ�� �߰��Ǿ����ϴ�."); history.go(-1);</script>
		<%
	}
	else {
		%>
		<script>alert("��ȭ�� �߰��� �� �����ϴ�."); history.go(-1);</script>
		<%
	}
	
%>