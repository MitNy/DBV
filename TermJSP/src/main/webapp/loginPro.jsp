<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="Dao.Database" %>
<%@ page import="Dao.loginCheck" %>
<% 
	Database dbCon = new Database();
	loginCheck check = new loginCheck();
	Connection conn = dbCon.GetConnection();
	String userID = request.getParameter("user-id");
	String pwd = request.getParameter("password");
	
	String loginResult = check.loginCheck(userID,pwd);
	if( loginResult == "isCustomer") {
		session.setAttribute("user-session",userID);
		response.sendRedirect("index.jsp");
	}
	else if( loginResult == "isAdmin" ) {
		session.setAttribute("admin-session",userID);
		response.sendRedirect("movieManager.jsp");
	}
	else {
		%> <script>alert('���̵� �Ǵ� ��й�ȣ�� ��ġ���� �ʽ��ϴ�.');window.location.href='login.jsp';</script>
		<%
	}
	
	
%>