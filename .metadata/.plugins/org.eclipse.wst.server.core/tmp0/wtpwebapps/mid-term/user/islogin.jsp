<%@page import="javax.websocket.Session"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
if(session.getAttribute("user_name") == null || session.getAttribute("user_name").equals("")) {
	response.sendRedirect("../login.html");
	return;
}
%>