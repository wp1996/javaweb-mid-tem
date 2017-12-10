// 检查用户名是否符合要求
function checkname() {
	var name = document.getElementsByName("username")[0].value;
	if (name == "") {
		document.getElementById("nullname").style.display = "block";
		return false;
	}else {
		document.getElementById("nullname").style.display = "none";
	}
	return true;
}
// 检查密码是否符合要求
function checkpsd() {
	var password = document.getElementsByName("password")[0].value;
	if (password == "") {
		document.getElementById("nullpsd").style.display = "block";
		return false;
	}else {
		document.getElementById("nullpsd").style.display = "none";
	}
	return true;
}

// 检测邮箱
function checkemail() {
	var email = $("#useremail").val();
	if (email == "") {
		$("#nullemail").html('<span style="color: red;">邮箱不能为空！</span>');
		$("#nullemail").css("display", "block");
		return false;
	}else {
		$("#nullemail").css("display", "none");
	}
	// 一定要注意js里边的正则表达式不能加引号，
	// 不论是单独赋值还是直接做某个匹配函数的参数
	var reg = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
	var re = new RegExp(reg);
	if (!re.test(email)) {
		$("#nullemail").html('<span style="color: red;">邮箱格式不正确！</span>');
		$("#nullemail").css("display", "block");
		return false;
	}else {
		$("#nullemail").css("display", "none");
	}
	
	return true;
}

// 检测注册时的密码
function checkpsd_regist() {
	var password = $("#password").val();
	if (password == "") {
		$("#nullpsd").html('<span style="color: red;">密码不能为空！</span>');
		document.getElementById("nullpsd").style.display = "block";
		return false;
	}else {
		document.getElementById("nullpsd").style.display = "none";
	}
	if (password.length < 8) {
		$("#nullpsd").html('<span style="color: red;">密码至少8位！</span>');
		document.getElementById("nullpsd").style.display = "block";
		return false;
	}else {
		document.getElementById("nullpsd").style.display = "none";
	}
	// js查找正则表达式时匹配单个字符时下划线_一定不能放在中括号[]的第一个位置
	// 因为这样会导致除谷歌之外的浏览器识别不了，这样整个js文件都会加载不成功
	if(password.search(/[a-zA-Z]/) == -1 || password.search(/[0-9]/) == -1
			 || password.search(/[-*&#!$%@_]/) == -1) {
		$("#nullpsd").html('<span style="color: red;">密码必须包含字母、数字、特殊字符！</span>');
		document.getElementById("nullpsd").style.display = "block";
		return false;
	}else {
		document.getElementById("nullpsd").style.display = "none";
	}
	return true;
}

// 检测注册时的确认密码
function checkconfirm() {
	var confirm = $("#confirm").val();
	var password = $("#password").val();
	if (confirm == "") {
		$("#nullconfirm").html('<span style="color: red;">请确认密码！</span>');
		$("#nullconfirm").css("display", "block");
		return false;
	}else {
		$("#nullconfirm").css("display", "none");
	}
	if (confirm != password) {
		$("#nullconfirm").html('<span style="color: red;">两次输入的密码不一致！</span>');
		$("#nullconfirm").css("display", "block");
		return false;
	}else {
		$("#nullconfirm").css("display", "none");
	}
	return true;
}

// 检测邮箱和用户名是否重复
// 访问servlet时以引用js代码的文件路径为基准
function checkrepeat() {
	var email = $("#useremail").val();
	var username = $("#username").val();
	var tag = false;
	$.ajax({
		url: "isRepeat",
		type: "POST",
		async: false,
		data: {
			email: email,
			username: username
		},
		success: function(data) {
			var repeat = JSON.parse(data);
			if (repeat['reemail'] == "true") {
				$("#nullemail").html('<span style="color: red;">该邮箱已被注册！</span>');
				$("#nullemail").css("display", "block");
				return;
			}else {
				$("#nullemail").css("display", "none");
			}
			if (repeat['rename'] == "true") {
				$("#nullname").html('<span style="color: red;">该用户名已被注册！</span>');
				$("#nullname").css("display", "block");
				return;
			}else {
				$("#nullname").css("display", "none");
				tag = true;
			}
		},
		error: function(error) {
		}
	});
	return tag;
}

function checkrepeat_home(check) {
	if (check == "name"){
		var username = $("#username").val();
	}
	if (check == "email"){
		var email = $("#useremail").val();
	}
	var tag = false;
	$.ajax({
		url: "../isRepeat",
		type: "POST",
		async: false,
		data: {
			email: email,
			username: username
		},
		success: function(data) {
			var repeat = JSON.parse(data);
			if (repeat['reemail'] == "true") {
				$("#nullemail").html('<span style="color: red;">该邮箱已被注册！</span>');
				$("#nullemail").css("display", "block");
				return;
			}else {
				$("#nullemail").css("display", "none");
			}
			if (repeat['rename'] == "true") {
				$("#nullname").html('<span style="color: red;">该用户名已被注册！</span>');
				$("#nullname").css("display", "block");
				return;
			}else {
				$("#nullname").css("display", "none");
				tag = true;
			}
		},
		error: function(error) {
		}
	});
	return tag;
}

function showPage(page) {
	$.ajax({
		url: "../getPageBlogs",
		data: {
			page: page
		},
		type: "POST",
		dataType: "json",
		success: function(json) {
			if(json['isnull'] == 'true') return;
			var html = "";
			for(var i in json) {
				if(i == 'isnull') continue;
				blog = JSON.parse(json[i]);
				if (blog['title'].length > 15) {
					blog['title'] = blog['title'].substring(0, 15) + "...";
				}
				html += "<li class='recommend-blog-content'>" + 
				"<form action='show_blog.jsp' method='POST'>" +
				"<div style='text-align: left;'>" +
				"<input style='display: none;' name='blog_id'value="+ blog['id'] +">" +
				"<input style='display: none;' name='author' value="+ blog['author_name'] +">" +
				"<input class='recommend-blog-title' type='submit' value="+ blog['title'] +">" +
				"<span class='access_count'>(访问量 : "+ blog['access_count'] +")</span></div></form></li>";
			}
			$("#show_blog").html(html);
			$("#next").attr("name", parseInt(page) + 1);
			var pageInt = parseInt(page)
			if(pageInt > 1) $("#previous").attr("name", pageInt - 1);
			else $("#previous").attr("name",  1);
			//if(pageInt != 1) {
				var lastnode = $("#pageList").children("li:last-child").prev().children("a");
				var firstnode = $("#pageList").children("li:first-child").next().children("a");
				var firstcount = parseInt(firstnode.attr("name"));
				var lastcount = parseInt(lastnode.attr("name"));
				if(page > lastcount) {
					var childs = $("#pageList a");
					for(var i = 1; i < childs.length-1; i++) {
						// 注意在这里childs[i]是对象，并不完全相当于节点对象
						// 所以取其属性值和设置其属性值时与节点操作不完全相同
						childs[i].name = parseInt(childs[i].name) + 1;
						childs[i].text = parseInt(childs[i].text) + 1;
					}
				}
				if(page < firstcount) {
					var childs = $("#pageList a");
					for(var i = 1; i < childs.length - 1; i++) {
						childs[i].name = parseInt(childs[i].name) - 1;
						childs[i].text = parseInt(childs[i].text)- 1;
					}
				}
			//}
		},
		error: function(error) {
			confirm("系统错误！");
		}
	});
}