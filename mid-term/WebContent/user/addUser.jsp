<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "mid.term.CommonDb"
    %>
    <%@ page import = "java.sql.*, mid.bean.User, mid.factory.DaoFactory" %>
<%
String reurl = request.getHeader("Referer");
if (reurl == null) {
	response.sendRedirect("../errorpage/nopermission.jsp");
	return;
}
request.setCharacterEncoding("UTF-8");
String username = request.getParameter("username").trim();
String useremail = request.getParameter("useremail").trim();
String password = request.getParameter("password").trim();
String sql = "INSERT INTO user(user_name,user_psd,user_email) VALUES(?,?,?)";
int result = 0;
try {
	PreparedStatement ps = CommonDb.executePreparedStatement(sql);
	ps.setString(1,username);
	ps.setString(2,password);
	ps.setString(3, useremail);
	result = ps.executeUpdate();
	//ResultSet rs = ps.getGeneratedKeys();
	if (result > 0) {
		session.setAttribute("user_name", username);
		session.setAttribute("user_email", useremail);
		//session.setAttribute("userid", rs.getInt(1));
		User user = DaoFactory.getUser();
		user.setUser_name(username);
		user.setUser_email(useremail);
		user.setUser_psd(password);
		response.sendRedirect("personal_home.jsp");
	}else {
		out.print("注册失败！ 3秒后跳回注册界面<br/>点击   <a href='../regist.html'>这里</a>  直接跳转");
		response.setHeader("Refresh", "3;URL=../regist.html");
	}
	ps.close();
}catch(SQLException e) {
	e.printStackTrace();
}
%>