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
		response.getWriter().write("Ż�� �Ϸ�Ǿ����ϴ�.");
		session.invalidate();
	}
	else {
		response.setContentType("text/html");
		response.getWriter().write("Ż�� �� �� �����ϴ�.");
	}
	
	
%>