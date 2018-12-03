<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.sql.Connection" %>
<%@ page import="Dao.Database" %>
<%@ page import="Service.theaterService" %>
<% 
	theaterService ts = new theaterService();
	String theaterID = request.getParameter("theaterID");
	String sName = request.getParameter("sName");
	String movieName = request.getParameter("movieName");
	String movieTime = request.getParameter("movieTime");
	
	boolean addResult = ts.addSangyounggwan(sName, theaterID, movieName,movieTime);
	if( addResult) {
		response.setContentType("text/html");
		response.getWriter().write("상영관이 추가되었습니다.");
	}
	else {
		response.setContentType("text/html");
		response.getWriter().write("상영관을 추가할 수 없습니다.");
	}
	
%>