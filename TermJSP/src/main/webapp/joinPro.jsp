<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Date" %>
<%@ page import="Dao.Database" %>
<%@ page import="Dao.join" %>
<% 
	Database dbCon = new Database();
	join join = new join();
	Connection conn = dbCon.GetConnection();
	String userID = request.getParameter("user-id");
	String pwd = request.getParameter("password");
	String pwdCheck = request.getParameter("password");
	String name = request.getParameter("user-name");
	String birthday = request.getParameter("birthday");
	String address = request.getParameter("address");
	String tel = request.getParameter("tel");
	
	boolean joinResult = join.joinCheck(userID, pwd, name, birthday, address, tel);
	if( joinResult == true) {
		%>
		<script>alert("회원가입이 완료되었습니다."); window.location.href="login.jsp";</script>
		<%
	}
	else {
		%>
		<script>alert("회원가입이 불가능합니다."); history.go(-1);</script>
		<%
	}
	
%>