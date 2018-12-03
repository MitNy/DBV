<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.sql.Connection" %>
<%@ page import="Dao.Database" %>
<%@ page import="Service.infoService" %>
<% 	
	infoService is = new infoService();
	String userID = request.getParameter("userID");
	
	boolean deleteResult = is.userDelete(userID);
	if( deleteResult) {
		response.setContentType("text/html");
		response.getWriter().write("탈퇴가 완료되었습니다.");
		session.invalidate();
	}
	else {
		response.setContentType("text/html");
		response.getWriter().write("탈퇴를 할 수 없습니다.");
	}
	
	
%>