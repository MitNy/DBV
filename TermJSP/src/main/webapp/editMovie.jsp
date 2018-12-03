<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
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
		response.getWriter().write("영화 정보가 수정되었습니다.");
	}
	else {
		response.setContentType("text/html");
		response.getWriter().write("영화 정보를 수정할 수 없습니다.");
	}
	
	
%>