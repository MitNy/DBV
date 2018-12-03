<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.sql.Connection" %>
<%@ page import="Dao.Database" %>
<%@ page import="Service.reservationService" %>
<%@ page import="Service.errorService" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<% 
	reservationService rs = new reservationService();
	errorService es = new errorService();
	String reserv_number = request.getParameter("reserv_number");

	boolean isTicket = rs.isTicket(reserv_number);
	if(isTicket) {
		JSONObject getResult = rs.getSpecificTicket(reserv_number);
		response.setContentType("text/html");
		response.getWriter().print(getResult);
	}
	else {
		JSONObject error = es.error("none");
		response.setContentType("text/html");
		response.getWriter().print(error);
	}
	
	
%>