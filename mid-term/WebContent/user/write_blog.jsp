<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="mid.term.*, java.sql.*, mid.bean.*"%>
<%
String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<title>享受过程</title>
<link href="../editormd/css/editormd.min.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/jquery-3.2.1.js"></script>
<script type="text/javascript" src="../js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="../editormd/editormd.min.js"></script>
<link rel="stylesheet" href="../css/bootstrap-theme.css">
<link rel="stylesheet" href="../css/bootstrap-theme.min.css">
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/bootstrap.min.css">
<style type="text/css">
input::-webkit-input-placeholder {
         /* placeholder颜色  */
        color: #BDBDBD;
        /* placeholder字体大小  
        font-size: 12px;*/
         /* placeholder位置  
        text-align: right;*/
    }
::-webkit-input-placeholder { /* WebKit, Blink, Edge */
    color: #CCCCCC;
}
:-moz-placeholder { /* Mozilla Firefox 4 to 18 */
   color: #CCCCCC;
}
::-moz-placeholder { /* Mozilla Firefox 19+ */
   color: #CCCCCC;
}
:-ms-input-placeholder { /* Internet Explorer 10-11 */
   color:    #909;
}


.title {
width: 90%; 
margin-left: 5%; 
overflow-x: hidden; 
height: 8vh; 
line-height: 8vh; 
maxlength: 100; 
font-size: 5vh;
border: none;
color: #4A4A4A;
font-family: KaiTi;
font-weight: bold;
}
</style>
<script type="text/javascript">
  var testEditor;
  testEditor=$(function() {
      editormd("test-editormd", {
           width   : "90%",
           height  : 640,
           //markdown : md,
           codeFold : true,
           syncScrolling : "single",
           //你的lib目录的路径
           path    : "../editormd/lib/",
           imageUpload: false,//关闭图片上传功能
          /*  theme: "dark",//工具栏主题
           previewTheme: "dark",//预览主题
           editorTheme: "pastel-on-dark",//编辑主题 */
           emoji: false,
           taskList: true, 
           tocm: true,         // Using [TOCM]
           tex: true,                   // 开启科学公式TeX语言支持，默认关闭
           flowChart: true,             // 开启流程图支持，默认关闭
           sequenceDiagram: true,       // 开启时序/序列图支持，默认关闭,
          //这个配置在simple.html中并没有，但是为了能够提交表单，使用这个配置可以让构造出来的HTML代码直接在第二个隐藏的textarea域中，方便post提交表单。
           saveHTMLToTextarea : true            
      });

  });

</script>
</head>
<body>
<a id="type" name="<%= request.getParameter("type") %>"></a>
<%
String title = "";
String content = "";
if(request.getParameter("type").equals("2")) {
	String blog_id = request.getParameter("blog_id");
	blogBean blog = new blogBean();
	ResultSet rs = blog.getBlogById(Integer.parseInt(blog_id));
	if (rs.first()) {
		title = rs.getString("title");
		content = rs.getString("content");
	}else {
		response.sendRedirect("../errorpage/service_error.jsp");
	}
	%>
	<a id="blog_id" name="<%= blog_id %>"></a>
	<%
}
if (request.getParameter("type").equals("1")){
	%>
<div style="height: 8vh">
<input class="title" maxlength="30" placeholder="请输入标题" id="title" name="title"></input>
</div>
<div class="editormd" id="test-editormd">
    <textarea class="editormd-markdown-textarea" name="test-editormd-markdown-doc" id="editormd"></textarea>
    <!-- 第二个隐藏文本域，用来构造生成的HTML代码，方便表单POST提交，这里的name可以任意取，后台接受时以这个name键为准 -->
    <!-- html textarea 需要开启配置项 saveHTMLToTextarea == true -->
    <textarea class="editormd-html-textarea" name="editorhtml" id="editorhtml"></textarea>       
</div>
<%
}else {
	%>
	<div style="height: 8vh">
<input class="title" placeholder="请输入标题" id="title" name="title" type="text" value="<%= title %>"></input>
</div>
<div class="editormd" id="test-editormd">
    <textarea class="editormd-markdown-textarea" name="test-editormd-markdown-doc" id="editormd"><%= content %></textarea>
    <!-- 第二个隐藏文本域，用来构造生成的HTML代码，方便表单POST提交，这里的name可以任意取，后台接受时以这个name键为准 -->
    <!-- html textarea 需要开启配置项 saveHTMLToTextarea == true -->
    <textarea class="editormd-html-textarea" name="editorhtml" id="editorhtml"></textarea>       
</div>
	<%
}
%>
<a id="user_name" name="<%= (String)(session.getAttribute("user_name"))%>"></a>
<button id="save" class="btn" style="float: right; margin-right: 5%;">保存</button>
<button id="cancel" class="btn" style="float: right; margin-right: 2%;">取消</button>
<script type="text/javascript">
$("#cancel").click(function (){
	window.location.href="./personal_home.jsp";
});
$('#save').click(function() {
var title = $("#title").val();
var content = $("#editormd").val();
var type = $("#type").attr("name");
var blog_id;
if (type == "2") {
	blog_id = $("#blog_id").attr("name");
}else {
	blog_id = 0;
}
$.ajax({
	url: "../saveblogServlet",
	type: "POST",
	data: {
		title: title,
		content: content,
		authorname: $("#user_name").attr("name"),
		type: type,
		blog_id: blog_id
	},
	//contentType: "charset=utf-8",
	//dataType: "json",
	success: function(data) {
		var issave = JSON.parse(data);
		if (issave['issave'] == 'true') {
			alert("保存成功");
		} else {
			alert("保存失败");
		}
	},
	error: function(error) {
		alert("123");
	}
});
});
</script>
</body>
</html>