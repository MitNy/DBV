<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
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
		response.getWriter().write("�󿵰��� �߰��Ǿ����ϴ�.");
	}
	else {
		response.setContentType("text/html");
		response.getWriter().write("�󿵰��� �߰��� �� �����ϴ�.");
	}
	
%>