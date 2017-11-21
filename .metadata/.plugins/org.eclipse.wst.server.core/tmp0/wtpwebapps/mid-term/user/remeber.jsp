<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "org.json.JSONObject" %>
<%
String name = "";
String password = "";
//JSONArray jsonArray = new JSONArray();
JSONObject json = new JSONObject();
Cookie c[] = request.getCookies();
for (int i = 0; i < c.length; i++) {
	Cookie user = c[i];
	if (user.getName().equals("username")) name = user.getValue();
	if (user.getName().equals("userpsd")) password = user.getValue();
}
if (name.equals("") && password.equals("")) {
	json.put("isnull", "true");
}else {
	json.put("username",name);
	json.put("password",password);
	json.put("isnull","false");
}
response.setContentType("text/html; charset=utf-8");
PrintWriter outRem = response.getWriter();
//jsonArray.add(json);
outRem.print(json.toString());
%>