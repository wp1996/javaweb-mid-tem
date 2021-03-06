<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "mid.term.CommonDb, java.sql.*, java.util.*"
    %>
    <%@page import="mid.bean.User, mid.factory.DaoFactory" %>
<%
String reurl = request.getHeader("Referer");
if (reurl == null) {
	response.sendRedirect("../errorpage/nopermission.jsp");
	return;
}
request.setCharacterEncoding("UTF-8");
String username = request.getParameter("username").trim();
//String useremail = request.getParameter("useremail").trim();
String password = request.getParameter("password").trim();
String remeberpsd[] = request.getParameterValues("remeberpsd");
String sql = "SELECT * FROM user WHERE user_name=? AND user_psd=?";
ResultSet rs = null;
PreparedStatement ps = CommonDb.executePreparedStatement(sql);
ps.setString(1,username);
ps.setString(2,password);
rs = ps.executeQuery();
if (rs.first()) {
	session.setAttribute("user_name", username);
	session.setAttribute("user_email", rs.getString("user_email"));
	session.setAttribute("image_url", rs.getString("image_url"));
	if (remeberpsd != null) {
		// 设置客户端cookie
		Cookie c1 = new Cookie("username",username);
		Cookie c2 = new Cookie("userpsd",password);
		c1.setMaxAge(60*60*24*7);
		c2.setMaxAge(60*60*24*7);
		response.addCookie(c1);
		response.addCookie(c2);
	}
	DaoFactory.getUser().initByName(username);
	response.sendRedirect("personal_home.jsp");
}else {
	out.print("登录失败！ 3秒后跳回登录界面<br/>点击  <a href='../login.html'>这里</a>  直接跳转");
	response.setHeader("Refresh", "3;URL=../login.html");
}
%>