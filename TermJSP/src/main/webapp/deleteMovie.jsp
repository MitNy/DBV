<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="Dao.Database" %>
<%@ page import="Service.movieService" %>
<% 
	movieService ms = new movieService();
	String movieName = request.getParameter("movieName");
	
	boolean deleteResult = ms.deleteMovie(movieName);
	if( deleteResult) {
		response.setContentType("text/html");
		response.getWriter().write("��ȭ�� �����߽��ϴ�.");
	}
	else {
		response.setContentType("text/html");
		response.getWriter().write("��ȭ�� ������ �� �����ϴ�.");
	}
	
	
%>