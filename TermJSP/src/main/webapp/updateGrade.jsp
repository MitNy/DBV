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
		response.getWriter().write("회원 등급이 변경되었습니다.");
	}
	else {
		response.setContentType("text/html");
		response.getWriter().write("회원 등급을 변경할 수 없습니다.");
	}
	
	
%>