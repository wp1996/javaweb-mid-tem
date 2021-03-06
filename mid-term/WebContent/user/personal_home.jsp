<%@page import="org.apache.catalina.connector.Request"%>
<%@page import="javax.websocket.Session"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="mid.bean.blogBean, java.sql.*"%>
    <%@page import="mid.bean.User, mid.factory.DaoFactory, mid.dao.impl.UserDaoImpl" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>我的主页</title>
  <%@ include file="include.jsp" %>
  <style>
  a:hover {text-decoration: none; cursor: pointer}
  </style>
  <script type="text/javascript" src="../js/jquery.form.js"></script>
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
<!-- 
<img src="../images/luntan.jpg" width="30px" height="30px" style='float:left'/>
-->
<div style='float:left' class='titlestyle'>在线Java技术论坛</div>
<a onclick="sign_out()" style='float:right; margin-right: 20px; color: #FFFFFF;' class='titlestyle'>注销</a>
</div>
<div class='nav1'>
  <ul>
    <li><a href='home.jsp'>主页</a></li>
    <li ><a href='write_blog.jsp?type=1'>写文章</a>
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
       <img id="author_image" src="<%=session.getAttribute("image_url") %>" data-toggle="modal" data-target="#upload" width="70px" height="70px" style='float:left; border-radius: 50%; cursor: pointer;'/>
    </div>
    <div class="modal fade" id="upload" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <form id="form_upload" method="POST" action="../uploadImage" enctype="multipart/form-data">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">修改头像</h4>
            </div>
            <div class="modal-body">
            <div class="control-group">
                 <input id="lefile" type="file" name="lefile" style="display:none"> 
			 	 <div class="input-append"> 
				 <input id="photoCover" class="input-large" type="text" style="height:34px;"> 
				 <a class="btn" onclick="$('input[id=lefile]').click();">浏览</a> 
				 </div> 
             </div>
			</div>
            <div class="modal-footer"> 
                <button type="button" id="saveImage" class="btn btn-primary" style="color: #8B7765;">保存</button>
            </div>
        </div>
    </div>
    </form>
</div>
    <div style='float:left'>
       <div style="height: 70px; line-height: 70px;">
       <div>
         <h3><%= session.getAttribute("user_name") %></h3>
         <span><%= session.getAttribute("user_email") %></span>
       </div>
       </div>
    </div>
  </div>
  <div class='bodystyle2'>
  <div class="container">
  <ul class="nav nav-tabs">
    <!-- <li class="active"><a data-toggle="tab" href="#menu1">写博客</a></li>  -->
    <li class="active"><a data-toggle="tab" href="#menu1">我的文章</a></li>
    <li><a data-toggle="tab" href="#menu2">我的个人信息</a></li>
  </ul>

  <div class="tab-content">
    <div id="menu1" class="tab-pane fade in active" style="text-align: left; padding: 10px 20px;">
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
    <div id="menu2" class="tab-pane fade">
      <%
      UserDaoImpl uDaoImpl = (UserDaoImpl)DaoFactory.getUserDaoInstance();
      User user = uDaoImpl.getUserByName(session.getAttribute("user_name").toString());
      %>
      <div class="row" style="width: 100%; margin-top: 20px;">
      <span class="col-md-1 common-span">用户名：</span>
      <input class="col-md-6 common-input form-control" style="width: 30%;" type="text" id="username" name="username" readonly="readonly" value="<%=user.getUser_name() %>">
      <a id="user_name_1" name="<%=user.getUser_name() %>"></a>
      <!-- <a id="reset_name" class="common-a">重置</a> -->
      <div id="nullname" class="common-span" style="display: none; color: red; float: left; margin-left: 20px;"><span>用户名不能为空！</span></div>
      </div>
      <div class="row" style="width: 100%; margin-top: 10px;">
      <span class="col-md-1 common-span">邮箱：</span>
      <input class="col-md-6 common-input form-control" style="width: 30%;" type="text" id="useremail" name="useremail" readonly="readonly" value="<%=user.getUser_email() %>">
      <a id="user_email_1" name="<%=user.getUser_email() %>"></a>
      <a id="reset_email" class="common-a">重置</a>
      <div id="nullemail" class="common-span" style="display: none; color: red; float: left; margin-left: 20px;"><span>邮箱不能为空！</span></div>
      </div>
      <div class="row" style="width: 100%; margin-top: 10px;">
      <span id="psd_span" class="col-md-1 common-span">密码：</span>
      <input class="col-md-6 common-input form-control" style="width: 30%;" type="password" id="old_password" name="old_password" readonly="readonly" value="<%=user.getUser_psd() %>">
      <a id="old_psd" name="<%=user.getUser_psd() %>"></a>
      <a id="reset_psd" class="common-a">重置</a>
      <div id="nulloldpsd" class="common-span" style="display: none; color: red; float: left; margin-left: 20px;"><span>请输入旧密码！</span></div>
      </div>
      <div id="newpsd_div">
      
      </div>
      <div class="row">
      <sapn class="col-md-1"></sapn>
      <button id="save" class="btn btn-success" style="float: left; margin-top: 20px; color: #0A0A0A;width: 29%;">保存</button>
      </div>
      <div class="row">
      <sapn class="col-md-1"></sapn>
      <button id="cancel" class="btn btn-success" style="float: left; margin-top: 10px; color: #0A0A0A;width: 29%;">取消</button>
      </div>
    </div>
  </div>
</div>
  </div>
</div>
<div>
</div>
<script>
$("#saveImage").click(function() {
	var options = {
			url: "../uploadImage",
			type: "POST",
			success: function(url) {
				$("#author_image").attr("src", url);
			},
			error: function(error) {
				alert("修改失败");
			}
	};
	$("#form_upload").ajaxSubmit(options);
});
$('input[id=lefile]').change(function() { 
	 $('#photoCover').val($(this).val()); 
}); 
$(function() {
    $('#upload').modal({
        keyboard: true
    })
});
$("#reset_name").click(function() {
	$("#username").removeAttr("readonly");
});
$("#reset_email").click(function() {
	$("#useremail").removeAttr("readonly");
});
$("#reset_psd").click(function() {
	$("#psd_span").text("旧密码：");
	$("#old_password").removeAttr("readonly");
	$("#old_password").val("");
	$("#old_password").attr("placeholder", "请确认旧密码");
	var newpsd = '<div class="row" style="width: 100%; margin-top: 10px;">' +
	      '<span class="col-md-1 common-span">密码：</span>' +
	      '<input class="col-md-6 common-input form-control" style="width: 30%;" type="password" placeholder="请输入新密码" id="password" name="password">' +
	      '<div id="nullpsd" class="common-span" style="display: none; color: red; float: left; margin-left: 20px;"><span>密码不能为空！</span></div>'
	$("#newpsd_div").html(newpsd);
});
var user_name;
var user_email;
var user_psd;
var check;
var up_user = $("#user_name_1").attr("name");
$("#save").click(function() {
	user_name = user_email = user_psd = check =  "";
	if ($("#username").attr("readonly") == null){
		check = "name"
		if(checkname()) {
			user_name = $("#username").val();
		}else {
			return;
		}
		if (!checkrepeat_home(check)) {
			return;
		}
	}else {
		user_name = $("#user_name_1").attr("name");
	}
	if ($("#useremail").attr("readonly") == null) {
		check = "email"
		if(checkemail()) {
			user_email = $("#useremail").val();
		}else {
			return;
		}
		if (!checkrepeat_home(check)) {
			return;
		}
	}else {
		user_email = $("#user_email_1").attr("name");
	}
	if ($("#old_password").attr("readonly") == null) {
		if ($("#old_password").val() != $("#old_psd").attr("name")) {
			$("#nulloldpsd").html('<span style="color: red;">密码不正确！</span>');
			$("#nulloldpsd").css("display", "block");
			return;
		}else {
			$("#nulloldpsd").css("display", "none");
		}
		if (!checkpsd_regist()) {
			return;
		}
		if ($("#password").val() == $("#old_password").val()) {
			$("#nullpsd").html('<span style="color: red;">密码不能与旧密码相同！</span>');
			document.getElementById("nullpsd").style.display = "block";
			return;
		}else {
			user_psd = $("#password").val();
			$("#nullpsd").css("display", "none");
		}
	}else {
		user_psd = $("#old_psd").attr("name");
	}
	$.ajax({
		url: "../updateUser",
		type: "POST",
		data: {
			user_name: user_name,
			user_email: user_email,
			user_psd: user_psd,
			up_user: up_user
		},
		success: function(data) {
			if(data == "true") {
				$("#username").val(user_name);
				$("#username").attr("readonly", "readonly");
				$("#useremail").val(user_email);
				$("#useremail").attr("readonly", "readonly");
				$("#old_password").val(user_psd);
				$("#old_password").attr("readonly", "readonly");
				$("#newpsd_div").html("");
				alert("修改成功");
			}else {
				$("#username").val($("#user_name_1").attr("name"));
				$("#username").attr("readonly", "readonly");
				$("#useremail").val($("#user_email_1").attr("name"));
				$("#useremail").attr("readonly", "readonly");
				$("#old_password").val($("#old_psd").attr("name"));
				$("#old_password").attr("readonly", "readonly");
				$("#newpsd_div").html("");
				alert("修改失败");
			}
		},
		error: function(error) {
			
		}
	});
});
$("#cancel").click(function() {
	$("#username").val($("#user_name_1").attr("name"));
	$("#username").attr("readonly", "readonly");
	$("#useremail").val($("#user_email_1").attr("name"));
	$("#useremail").attr("readonly", "readonly");
	$("#old_password").val($("#old_psd").attr("name"));
	$("#old_password").attr("readonly", "readonly");
	$("#psd_span").text("密码：");
	$("#newpsd_div").html("");
	$("#nullemail").css("display", "none");
	$("#nulloldpsd").css("display", "none");
	$("#nullpsd").css("display", "none");
});
function sign_out() {
	$.ajax({
		url: "../sign_out",
		type: "POST",
		success: function(data) {
			$(window).attr("location","../login.html");
		},
		error: function(error) {
		}
	});
}
</script>
</body>
</html>