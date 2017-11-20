<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="mid.bean.blogBean, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>我的主页</title>
  <%@ include file="include.jsp" %>
</head>

<body>
<%
blogBean blogs = new blogBean();
ResultSet rs = blogs.getBlogs((String)(session.getAttribute("user_name")));
rs.last();
int n = rs.getRow();
String[] title = new String[n];
int[] id = new int[n];
int i = 0;
rs.first();
try {
	do{
		title[i] = rs.getString("title");
		id[i] = rs.getInt("id");
		//out.print(title[i]);
		i++;
	}while(rs.next());
}catch(SQLException e) {
	e.printStackTrace();
}
%>
<div class='headstyle'>
<img src="../images/luntan.jpg" width="30px" height="30px" style='float:left'/>
<div style='float:left' class='titlestyle'>在线Java技术论坛</div>
</div>
<div class='nav1'>
  <ul>
    <li><a href='home.jsp'>主页</a></li>
    <li ><a href='write_blog.jsp?type=1'>写博客</a>
     <ul>
      <li><a href='#'>未完待续</a></li>
      </ul>
    </li>
    <li class='lamp'><span></span></li>
  </ul>
</div>
<div class='bodystyle'>
  <div class='bodystyle1'>
    <div>
       <img src="../images/luntan.jpg" width="100px" height="100px" style='float:left'/>
    </div>
    <div style='float:left'>
       <ul>
         <li><h3><%= session.getAttribute("user_name") %></h3></li>
         <li><%= session.getAttribute("user_email") %></li>
       </ul>
    </div>
  </div>
  <div class='bodystyle2'>
  <div class="container">
  <ul class="nav nav-tabs">
    <!-- <li class="active"><a data-toggle="tab" href="#menu1">写博客</a></li>  -->
    <li class="active"><a data-toggle="tab" onclick="show_blogs()">我的博客</a></li>
    <li><a data-toggle="tab">我的个人信息</a></li>
  </ul>

  <div class="tab-content">
    <div id="menu1" style="text-align: left; padding: 10px 20px;">
      <%
      	for(int j = 0; j < n; j++) {
      		%>
      		<p>
      		<form action="show_blog.jsp" method="POST">
      		<input style="display: none;" name="author" value="<%= session.getAttribute("user_name") %>">
      		<input style="display: none;" name="blog_id" value="<%= id[j] %>">
      		<input class="btn btn-link" style="border: none;" type="submit" value="<%= title[j] %>">
      		<a style="height: 35px; line-height: 35px;" href='write_blog.jsp?type=2&blog_id=<%= id[j] %>'>修改</a>
      		</form>
      		</p>
      		<%
      	}
      %>
    </div>
    <div id="menu2" style="display: none;">
      <h3>我的个人信息</h3>
      <p>哦哦哦</p>
    </div>
  </div>
</div>
  </div>
</div>
<div>
</div>
<script>
function show_blogs() {
	
}
</script>
</body>

</html>