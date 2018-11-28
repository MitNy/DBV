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
		response.getWriter().write("상영관을 삭제했습니다.");
	}
	else {
		response.setContentType("text/html");
		response.getWriter().write("상영관을 삭제할 수 없습니다.");
	}
	
	
%>