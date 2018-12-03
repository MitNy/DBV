<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.sql.Connection" %>
<%@ page import="Dao.Database" %>
<%@ page import="Service.reservationService" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<% 
	reservationService rs = new reservationService();
	String reserv_number = request.getParameter("reserv_number");
	JSONObject getResult = rs.getSpecificReservation(reserv_number);
	response.setContentType("text/html");
	response.getWriter().print(getResult);
	
%>