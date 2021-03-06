<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
    <%@page import="mid.bean.blogBean, mid.factory.DaoFactory" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>主页</title>
<%@ include file="include.jsp" %>
</head>
<%
blogBean blog = DaoFactory.getblogBean();
int n = ((int)(Math.random() * 10) % 7) + 1;
String img_url = "../images/search-bg" + n + ".jpg";
%>
<body style="background: url(<%= img_url %>)">
<div class="row center-input-group">
<div class="col-lg-3">
<p class="home-user-name btn"><a href="personal_home.jsp" style="color: #EE2C2C;"><%= session.getAttribute("user_name") %></a></p>
</div>
<div class="col-lg-7" >
<div class="input-group">
<input onkeyup="search_click(event)" id="key" style="height: 38px; border-radius: 20px 0 0 20px;" type="text" class="form-control" placeholder="请输入你想要搜索的文章">
<span class="input-group-btn" id="search">
<button class="btn btn-default search-btn" type="button">搜索</button>
</span>
</div>
<div class="navbar navbar-inverse" role="navigation" style="margin-top: 10px;">
<div class="container-fluid">
<div class="navbar-header">
<a class="navbar-brand" href="http://www.oschina.net/">开源中国</a>
</div>
<div>
<ul class="nav navbar-nav">
<li class=""><a href="https://www.csdn.net/">CSDN</a></li>
<li class="dropdown active">
<a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown">Java<b class="caret"></b></a>
<ul class="dropdown-menu">
<li><a href="https://www.jcp.org/en/home/index">JCP</a></li>
<li><a href="http://man.lupaworld.com/content/develop/open-open/">Java开源大全</a></li>
<li><a href="http://outofmemory.cn/#csdn">内存-溢出</a></li>
<li><a href="http://www.importnew.com/">ImportNew</a></li>
<li><a href="http://ifeve.com/">并发编程网</a></li>
</ul>
</li>
</ul>
</div>
</div>
</div>
<div id="blogs_list" style="float: left; margin-top: 10px; padding: 10px; width: 100%;">
<div>
<div class="recommend">
<span>最新文章：</span>
</div>
<div class="row" style="margin-top: 10px;">
<div class="col-md-6">
<ul style="width: 100%;" id="show_blog">
<%
ResultSet rs = blog.getAllBlogs();
String title = "";
while(rs.next()) {
	title = rs.getString("title");
	if (title.length() > 15) {
	/*
	int count = 20;
	byte[] bs = title.getBytes("GBK");
	for (int i = 0; i < 20; i++) {
		if(bs[i] < 0) { // 判断是否为汉字
			count++;
		}
	}
	if (count % 2 == 0) {
		count = 20;
	}else {
		count = 21;
	}
	*/
	title = title.substring(0, 15) + "...";
	}
	%>
	<li class="recommend-blog-content">
	<form action='show_blog.jsp' method='POST'>
	<div style="text-align: left;">
	<input style='display: none;' name='blog_id'value="<%=rs.getString("id") %>">
	<input style='display: none;' name='author' value="<%=rs.getString("author_name") %>">
	<input class='recommend-blog-title' type='submit' value="<%=title %>">
	<span class="access_count">(访问量 : <%=rs.getInt("access_count") %>)</span>
	</div>
	</form>
	</li>
	<%
}
%>
</ul>
<ul id="pageList" class="pagination" style="float: left;">
<%
ResultSet pageRs = blog.initBlog();
pageRs.last();
int count = pageRs.getRow();
pageRs.first();
if(count >= 50) {
	%>
	<li><a id="previous" href="javascript:void(0);" name="1" onclick="showPage(this.name)">&laquo;</a></li>
	<li><a href="javascript:void(0);" name="1" onclick="showPage(this.name)">1</a></li>
	<li><a href="javascript:void(0);" name="2" onclick="showPage(this.name)">2</a></li>
	<li><a href="javascript:void(0);" name="3" onclick="showPage(this.name)">3</a></li>
	<li><a href="javascript:void(0);" name="4" onclick="showPage(this.name)">4</a></li>
	<li><a href="javascript:void(0);" name="5" onclick="showPage(this.name)">5</a></li>
	<li><a id="next" href="javascript:void(0);" name="2" onclick="showPage(this.name)">&raquo;</a></li>
	<%
}
else {
	int pageNum = (int)(Math.ceil(((double)count)/10));
	if(pageNum != 0) {
		if(pageNum != 1) {
			%>
			<li><a id="previous" href="javascript:void(0);" name="1" onclick="showPage(this.name)">&laquo;</a></li>
			<%
		}
		for (int i = 1; i <= pageNum; i++) {
			%>
			<li><a href="javascript:void(0);" name="<%=i %>" onclick="showPage(this.name)"><%=i %></a></li>
			<%
		}
		if(pageNum != 1) {
			%>
			<li><a id="next" href="javascript:void(0);" name="2" onclick="showPage(this.name)">&raquo;</a></li>
			<%
		}
	}
}
%>
</ul>
</div>
</div>
</div>
</div>
</div>
</div>
<script>
$(document).ready(function() {
	$("a").attr("target", "_blank");
	$("form").attr("target","_blank");
	$(".pagination a").attr("target", "_self");
});
function search_click(e) {
	e = e ? e : (window.event ? window.event : null);
	var enterId = e.srcElement.id;
	if(e.keyCode == 13) {
		if(enterId == "key") {
			$("#search").click();
		}
	}
}
var bghtml;
var blog;
$("#search").click(function() {
	var key = $("#key").val();
	if(key == "") {
		return;
	}
	$.ajax({
		url: "../getBlogsByKey",
		type: "POST",
		data: {
			key: key
		},
		success: function(data) {
			if (data == "{}") {
				alert("没有这样的文章");
				return;
			}
			bghtml = "";
			json = JSON.parse(data);
			for(var i in json) {
				var blog = JSON.parse(json[i]);
				if (blog['title'].length > 15) {
					blog['title'] = blog['title'].substring(0, 15) + "...";
				}
				bghtml += '<div style="float:left; width: 100%; border-bottom: 1px solid #969696;">' + 
				'<form action="show_blog.jsp" method="POST"><div style="float: left;">' + 
				'<input style="display: none;" name="blog_id"value=' + blog['id'] + 
				'><input style="display: none;" name="author" value='+ blog['author'] + 
				'><input class="search-title" type="submit" value=' + blog["title"] +
				'></div></form></div>';
			}
			$("#blogs_list").html(bghtml);
		},
		error: function(error) {
			alert("错误");
		}
	});
});
</script>
</body>
</html>