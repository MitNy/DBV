<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
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
		<script>alert("���������� �����Ǿ����ϴ�."); history.go(-1);</script>
		<%
	}
	else {
		%>
		<script>alert("���������� ������ �� �����ϴ�."); history.go(-1);</script>
		<%
	}
	
%>