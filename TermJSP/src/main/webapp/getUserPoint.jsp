<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.sql.Connection" %>
<%@ page import="Dao.Database" %>
<%@ page import="Service.infoService" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<% 
	infoService is = new infoService();
	String userID = request.getParameter("userID");

	int userPoint = is.getUserPoint(userID);
	response.setContentType("text/html");
	response.getWriter().print(userPoint);
	
%>