<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="Dao.Database" %>
<%@ page import="Service.theaterService" %>
<% 
theaterService ts = new theaterService();
	String originID = request.getParameter("originID");
	String theaterID = request.getParameter("theaterID");
	String theaterName = request.getParameter("theaterName");
	String address = request.getParameter("address");
	String number = request.getParameter("number");
	
	boolean editResult = ts.editTheater(originID, theaterID, theaterName, address, number);
	if( editResult) {
		response.setContentType("text/html");
		response.getWriter().write("영화관 정보가 수정되었습니다.");
	}
	else {
		response.setContentType("text/html");
		response.getWriter().write("영화관 정보를 수정할 수 없습니다.");
	}
	
	
%>