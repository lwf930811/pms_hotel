<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登陆页面</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/static/js/jquery-1.12.4.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/static/layer/layer.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/static/md5/md5-min.js"></script>
</head>
<body>
	<form id = "frm">
		用户：<input type ="text" name = "userName" placeholder="用户名/手机号" onblur="getSalt(this)"><br>
			 <input type="hidden" name="salt"  id="salt"/><br>
		密码：<input type = "password" name = "password" id="pwd" placeholder="密码"><br>
		     <input type = "button" value = "登录" onclick = "login()"><br>
		<p><span><a href="<%=request.getContextPath()%>/user/toRegister">还有没有账号?点我去注册</a></span></p>
		<p><span><a href="<%=request.getContextPath()%>/user/findPassword">忘记密码?</a></span></p><br>
	</form>
</body>
	<script type="text/javascript">
		function login(){
			var index = layer.load(1, {shade: 0.3}, {shadeClose: true}); //解决网络延迟的加载重复操作问题
			var pwd = md5($("#pwd").val());
			var salt = $("#salt").val();
			var newPassword = md5(pwd + salt);
			$("#pwd").val(newPassword)
			$.post(
					"<%=request.getContextPath()%>/user/login",
					$("#frm").serialize(),
					function (data){
					layer.close(index);
					if(data.code != 200){
						layer.msg(data.msg, {icon: 5});
						return;
					}
					layer.msg("登录成功", {icon: 6});
					window.location.href="<%=request.getContextPath()%>/index/toIndex";
			})
		}

		//获取盐
		function getSalt(obj) {
			$.post("<%=request.getContextPath()%>/user/getSalt",
					{userName: obj.value},
					function (data) {
						if (data.code == 200) {
							$("#salt").val(data.data);
						} else {
							layer.msg(data.msg, {icon: 5});
						}
					})
		}
		
		function register(){
			layer.open({
			      type: 2,
				  title: '注册页面',
				  shadeClose: true,
				  shade: 0.8,
				  area: ['380px', '70%'],
				  //路径
		           content:  '<%=request.getContextPath()%>/user/toRegister'
				});
		}

	</script>
</html>