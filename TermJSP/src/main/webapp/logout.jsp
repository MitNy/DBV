<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	session.invalidate();
	%>
	<script>alert('로그아웃 되었습니다.'); window.location.href='index.jsp';</script>
	
	<%
//	response.sendRedirect("index.jsp");
%>