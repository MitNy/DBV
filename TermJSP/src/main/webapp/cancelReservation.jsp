<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.sql.Connection" %>
<%@ page import="Dao.Database" %>
<%@ page import="Service.reservationService" %>
<% 
	reservationService rvs = new reservationService();
	String reserv_number = request.getParameter("reserv_number");
	
	boolean deleteResult = rvs.cancelReservation(reserv_number);
	if( deleteResult) {
		response.setContentType("text/html");
		response.getWriter().write("예매를 취소했습니다.");
	}
	else {
		response.setContentType("text/html");
		response.getWriter().write("예매를 취소할 수 없습니다.");
	}
	
	
%>