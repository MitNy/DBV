<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="Dao.Database" %>
<%@ page import="Service.movieService" %>
<% 
	movieService ms = new movieService();
	String originID = request.getParameter("originID");
	String movieID = request.getParameter("movieID");
	String movieTitle = request.getParameter("movieTitle");
	String director = request.getParameter("director");
	String cast = request.getParameter("cast");
	String grade = request.getParameter("grade");
	String information = request.getParameter("information");
	
	boolean editResult = ms.editMovie(originID,movieID, movieTitle, director, cast, grade, information);
	if( editResult) {
		response.setContentType("text/html");
		response.getWriter().write("��ȭ ������ �����Ǿ����ϴ�.");
	}
	else {
		response.setContentType("text/html");
		response.getWriter().write("��ȭ ������ ������ �� �����ϴ�.");
	}
	
	
%>