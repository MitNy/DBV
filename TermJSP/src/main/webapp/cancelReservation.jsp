<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="Dao.Database" %>
<%@ page import="Service.reservationService" %>
<% 
	reservationService rvs = new reservationService();
	String reserv_number = request.getParameter("reserv_number");
	
	boolean deleteResult = rvs.cancelReservation(reserv_number);
	if( deleteResult) {
		response.setContentType("text/html");
		response.getWriter().write("���Ÿ� ����߽��ϴ�.");
	}
	else {
		response.setContentType("text/html");
		response.getWriter().write("���Ÿ� ����� �� �����ϴ�.");
	}
	
	
%>