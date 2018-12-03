<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.sql.Connection" %>
<%@ page import="Dao.Database" %>
<%@ page import="Dao.join" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<% 
	join j = new join();
	String userID = request.getParameter("userID");

	boolean getResult = j.idCheck(userID);
	if(getResult) {
		response.setContentType("text/html");
		response.getWriter().write("아이디가 이미 존재합니다.");
	}
	else {
		response.setContentType("text/html");
		response.getWriter().write("");
	}
	
%>