<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	session.invalidate();
	%>
	<script>alert('로그아웃 되었습니다.'); window.location.href='index.jsp';</script>
	
	<%
//	response.sendRedirect("index.jsp");
%>