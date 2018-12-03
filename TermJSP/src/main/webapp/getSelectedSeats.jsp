<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.sql.Connection" %>
<%@ page import="Dao.Database" %>
<%@ page import="Service.reservationService" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<% 
	reservationService rs = new reservationService();
	String movieName = request.getParameter("movieName");
	String theaterName = request.getParameter("theaterName");
	String date = request.getParameter("date");
	String time = request.getParameter("time");

	JSONArray seatsList = rs.getSelectedSeats(movieName, theaterName, date, time);
	response.setContentType("text/html");
	response.getWriter().print(seatsList);
	
%>