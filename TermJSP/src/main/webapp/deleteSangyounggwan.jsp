<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="Dao.Database" %>
<%@ page import="Service.theaterService" %>
<% 
	theaterService ts = new theaterService();
	String theaterID = request.getParameter("theaterID");
	String sID = request.getParameter("sID");
	
	boolean deleteResult = ts.deleteSangyounggwan(theaterID, sID);
	if( deleteResult) {
		response.setContentType("text/html");
		response.getWriter().write("�󿵰��� �����߽��ϴ�.");
	}
	else {
		response.setContentType("text/html");
		response.getWriter().write("�󿵰��� ������ �� �����ϴ�.");
	}
	
	
%>