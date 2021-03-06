<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>主页</title>
<%@ include file="include.jsp" %>
</head>
<%
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
<input id="key" style="height: 38px; border-radius: 20px 0 0 20px;" type="text" class="form-control" placeholder="请输入你想要搜索的文章">
<span class="input-group-btn" id="search">
<button class="btn btn-default search-btn" type="button">搜索</button>
</span>
</div>
<div id="blogs_list" style="float: left; margin-top: 10px; padding: 10px;">
</div>
</div>
</div>
<script>
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
				bghtml += "<p style='float:left; margin-top: 10px;'><form action='show_blog.jsp' method='POST'><input style='display: none;' name='blog_id'" +
				" value="+ blog['id'] +"><input style='display: none;' name='author' value="+ blog['author'] + "><input type='submit' value=" + blog["title"] +
				" class='btn btn-link'>" +
				"</form></p>";
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