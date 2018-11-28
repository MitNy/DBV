<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="Dao.Database" %>
<%@ page import="Service.infoService" %>
<% 	
	infoService is = new infoService();
	String userID = request.getParameter("userID");
	
	boolean deleteResult = is.userDelete(userID);
	if( deleteResult) {
		response.setContentType("text/html");
		response.getWriter().write("Å»Åð°¡ ¿Ï·áµÇ¾ú½À´Ï´Ù.");
		session.invalidate();
	}
	else {
		response.setContentType("text/html");
		response.getWriter().write("Å»Åð¸¦ ÇÒ ¼ö ¾ø½À´Ï´Ù.");
	}
	
	
%>