<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Date" %>
<%@ page import="Dao.Database" %>
<%@ page import="Service.adminService" %>
<% 
	adminService as = new adminService();
	String theaterID = request.getParameter("theaterID");
	String theaterName = request.getParameter("theaterName");
	String theaterAddress = request.getParameter("theaterAddress");
	String theaterTel = request.getParameter("theaterTel");
	String sangyounggwan = request.getParameter("sangyounggwan");
	String seats = request.getParameter("seats");
	boolean addResult = as.addTheater(theaterID, theaterName, theaterAddress, theaterTel, sangyounggwan, seats);
	
	if( addResult == true) {
		%>
	  	<script>alert("��ȭ���� �߰��Ǿ����ϴ�."); window.location.href="theaterManager.jsp";</script>
		<%
	}
	else {
		%>
		<script>alert("��ȭ���� �߰��� �� �����ϴ�."); history.go(-1);</script>
		<%
	}
	
%>