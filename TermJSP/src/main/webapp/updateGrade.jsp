<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="Dao.Database" %>
<%@ page import="Service.adminService" %>
<% 
	adminService as = new adminService();
	String userID = request.getParameter("userID");
	String grade = request.getParameter("grade");
	boolean updateResult = as.updateUserGrade(userID, grade);
	if( updateResult) {
		response.setContentType("text/html");
		response.getWriter().write("ȸ�� ����� ����Ǿ����ϴ�.");
	}
	else {
		response.setContentType("text/html");
		response.getWriter().write("ȸ�� ����� ������ �� �����ϴ�.");
	}
	
	
%>