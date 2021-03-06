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
// 访问servlet时以js代码所在文件路径为基准
function checkrepeat() {
	var email = $("#useremail").val();
	var username = $("#username").val();
	$.ajax({
		url: "../isRepeat",
		type: "POST",
		data: {
			email: email,
			username: username
		},
		success: function(data) {
			var repeat = JSON.parse(data);
			if (repeat['reemail'] == "true") {
				$("#nullemail").html('<span style="color: red;">该邮箱已被注册！</span>');
				$("#nullemail").css("display", "block");
				return false;
			}else {
				$("#nullemail").css("display", "none");
			}
			if (repeat['rename'] == "true") {
				$("#nullname").html('<span style="color: red;">该用户名已被注册！</span>');
				$("#nullname").css("display", "block");
				return false;
			}else {
				$("#nullname").css("display", "none");
				return false;
			}
		},
		error: function(error) {
			
		}
	});
}