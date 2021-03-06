<%@page import="javax.xml.stream.events.Comment"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="mid.bean.blogBean, mid.servlet.saveComment, mid.bean.commentBean"%>
<%@page import="mid.factory.DaoFactory" %>
<%
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");
int blog_id = 0;
if (request.getParameter("blog_id") != null) {
blog_id = Integer.parseInt(request.getParameter("blog_id"));
/*
blogBean blogbean = DaoFactory.getblogBean();
ResultSet blogrs = blogbean.getBlogById(blog_id);
String author = blogrs.getString("author_name");
if (!author.equals(session.getAttribute("user_name"))) {
	blogbean.setAccess_count((blogrs.getInt("access_count")+1), blog_id);
}
*/
%>
<a id="blog_id" name="<%= blog_id %>"></a>
<%
}else {
	//out.print(comment_id);
	response.sendRedirect("../errorpage/noblog.jsp");
	return;
}
blogBean blog = DaoFactory.getblogBean();
ResultSet rs = blog.getBlogById(blog_id);
//out.print(rs.first());
if (!rs.first()) {
	response.sendRedirect("../errorpage/noblog.jsp");
	return;
}
String author = rs.getString("author_name");
if (!author.equals(session.getAttribute("user_name"))) {
	blog.setAccesscount((rs.getInt("access_count")+1), blog_id);
}else {
	blog.setAccess_count(rs.getInt("access_count"));
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<%@ include file="include.jsp" %>
<style>
a:hover {text-decoration: none;}
</style>
</head>
<body style="background: url('../images/regist-bg1.jpg')">
<a id="commenter_name" name="<%= session.getAttribute("user_name") %>"></a>
<div class="mt-toolbar">
<div class="container row">
<span class="logo-text col-md-3">享受阅读</span>
<span class="col-md-9 tohome"><a href="home.jsp" style="color: #FFFFF0;">主页</a></span>
</div>
</div>
<div id="body">
<div class="row">
<div class="col-md-3">
<ul class="panel-head">
<span>个人资料</span>
</ul>
<img src="<%=DaoFactory.getUser().getUrlByName(request.getParameter("author")) %>" width="35%" style="margin: 0 auto; margin-left: 5%;">
<div class="username"><%= request.getParameter("author") %></div>
</div>

<div class="col-md-7">
<div class="blog-title">
<p id="blog_title"><%= rs.getString("title") %></p>
</div>
<textarea id="blog_content" style="display: none;"><%= rs.getString("content") %></textarea>
<div id="testEditorMdview" style="background-color: #FFFAFA; height: 90vh; margin-top: 1vh;">
        <textarea id="appendTest" style="display:none;"></textarea>
</div>
<div class="comment">
<div class="panel-comment">
<span style="float: left;">查看评论</span>
</div>
<div id="comments" name="comments" style="padding-bottom: 10px;">
<%
commentBean cmbean = new commentBean();
cmbean.setId(blog_id);
ResultSet cmrs = cmbean.getCommentsById();
if (cmrs.first()) {
	do {
		%>
		<div class="row">
		<div class="col-md-3">
		<span class="cmleft"><%= cmrs.getString("commenter_name") %></span>
		</div>
		<div class="col-md-9">
		<span class="cmright"><%= cmrs.getString("addtime") %></span>
		</div>
		</div>
		<div style="margin-top: 7px;">
		<span class="cm_show"><%= cmrs.getString("comment") %></span>
		</div>
		<%
	}while(cmrs.next());
}
%>
</div>
</div>
<div class="comment">
<div class="panel-comment">
<span style="float: left;">发表评论</span>
</div>
<ul class="comment-ul">
<li class="left">用户名：</li>
<li class="right"><%= session.getAttribute("user_name") %></li>
</ul>
<ul class="comment-ul">
<li class="left">评论内容：</li>
<li class="right">
<textarea id="comment_content" class="comment-content" style="width: 400px; height: 200px;"></textarea>
</li>
</ul>
<ul class="comment-ul" style="text-align: left;">
<input class="btn btn-primary" value="提交" type="submit" id="saveComment">
</ul>
</div>
</div>
<div class="col-md-2">
<div style="margin-top: 10px; float: left;">
<span>此文章访问量：<%=blog.getAccess_count() %></span>
</div>
</div>
</div>
</div>
<script type="text/javascript">
$(document).ready(function (){
$("#testEditorMdview").html('<textarea id="appendTest" style="display:none;"></textarea>');
$("#appendTest").val($("#blog_content").val());
editormd.markdownToHTML("testEditorMdview", {
    htmlDecode: "style,script,iframe", //可以过滤标签解码
    emoji: true,
    taskList:true,
    tex: true,               // 默认不解析
    flowChart:true,         // 默认不解析
    sequenceDiagram:true,  // 默认不解析
});
});
var comment;
var cmhtml;
$("#saveComment").click(function() {
	var commenter_name = $("#commenter_name").attr("name");
	var comment = $("#comment_content").val();
	if (comment == "") {
		return;
	}
	$("#comment_content").val("");
	$.ajax({
		url: "../saveComment",
		type: "POST",
		data: {
			commenter_name: commenter_name,
			comment: comment,
			blog_id: $("#blog_id").attr("name")
		},
		success: function(data) {
			var json = JSON.parse(data);
			$("#comments").html("");
			cmhtml = "";
			for (var i in json) {
				comment = JSON.parse(json[i]);
				cmhtml += '<div class="row">' + 
				'<div class="col-md-3">' +
				'<span class="cmleft">' + comment['commenter_name'] + '</span>' +
				'</div>' +
				'<div class="col-md-9">' +
				'<span class="cmright">' + comment['addtime'] + '</span>' +
				'</div>' +
				'</div><div style="margin-top: 7px;">' +
				'<span class="cm_show">' + comment['comment'] + '</span></div>';
			}
			$("#comments").html(cmhtml);
		},
		error: function(error) {
			alert("失败");
		}
	});
});
</script>
</body>
</html>