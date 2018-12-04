<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.sql.Connection" %>
<%@ page import="Dao.Database" %>
<%@ page import="Service.theaterService" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<% 
	theaterService ts = new theaterService();
	String theaterID = request.getParameter("theaterID");

	JSONArray getResult = ts.getSangyounggwanInfo(theaterID);
	response.setContentType("text/html");
	response.getWriter().print(getResult);
	
%>