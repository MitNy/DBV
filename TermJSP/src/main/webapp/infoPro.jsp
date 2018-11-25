<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Date" %>
<%@ page import="Dao.Database" %>
<%@ page import="Service.infoService" %>
<% 
	Database dbCon = new Database();
	infoService is = new infoService();
	Connection conn = dbCon.GetConnection();
	String id = request.getParameter("user-id");
	String pwd = request.getParameter("password");
	String name = request.getParameter("user-name");
	String address = request.getParameter("address");
	String tel = request.getParameter("tel");
	
	boolean editResult = is.editInfo(id, pwd, name, address, tel);
	if( editResult == true) {
		%>
		<script>alert("개인정보가 수정되었습니다."); history.go(-1);</script>
		<%
	}
	else {
		%>
		<script>alert("개인정보를 수정할 수 없습니다."); history.go(-1);</script>
		<%
	}
	
%>