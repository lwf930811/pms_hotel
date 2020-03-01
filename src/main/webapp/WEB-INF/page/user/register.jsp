<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/static/js/jquery-1.12.4.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/static/validate/jquery.validate.js"></script>
	<script src="https://static.runoob.com/assets/jquery-validation-1.14.0/dist/localization/messages_zh.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/static/layer/layer.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/static/md5/md5-min.js"></script>
<style type="text/css">
	.error{
		color:red;
	}
</style>
</head>
<body>
	<form id = "frm">
				<input type = "hidden" name = "isDel" value="1" ><br>
		<input type = "text" name = "userName" id="userName" placeholder="请输入用户名" ><br>
		<input type = "password" name = "password" id="pwd" placeholder="请输入密码"><br>
		<input type="hidden" name="salt" value="${salt}" id="salt"/>
		<input type = "text" name = "phone" id="phone" placeholder="请输入手机号"><br>
		<input type = "text" name = "hotelName"  placeholder="请填写酒店名"><br>
		<div id="hotelType" class="error" >
		<c:forEach items="${baseData}" var="base">
			<input type = "radio" name = "hotelType"  value="${base.id}">${base.name}
		</c:forEach>
		</div><br>
		<div id="userRole" class="error" >
			<c:forEach items="${role}" var="role">
				<input type = "radio" name = "userRole"  value="${role.id}">${role.roleName}
			</c:forEach>
		</div><br>
		<input type = "text" name = "hotelAddress"  placeholder="请填写地区"><br>
		<a href="<%=request.getContextPath()%>/user/toLogin">已有账号?前去登录</a><br>
		<input type = "submit" value = "提交">
	</form>
</body>
	<script type="text/javascript">
 $(function (){
		$("#frm").validate({
			errorPlacement: function(error, element) {
				if(element.is("[name='hotelType']")){//如果需要验证的元素名为userSex
					error.appendTo($("#hotelType"));   //错误信息增加在id为‘radio-lang’中
				} else if (element.is("[name='userRole']")){
					error.appendTo($("#userRole"));
				} else {
					error.insertAfter(element);//其他的就显示在添加框后
				}
			},
			rules:{
					userName:{
						required:true,
						remote:{
							type: "post",
							url:"<%=request.getContextPath()%>/user/findName",
							data: {
								userName:function () {
									return $("#userName").val();
								},
								dataType: "json",
								dataFilter:function (data,type){
									if (data == "true"){
										return true;
									} else {
										return false;
									}
								}
							}
							
						}
					},
				password:{
						required:true,
						digits:true  
					},
					phone:{
						required:true,
						digits:true,
						phone:true,
						remote:{
							type: "post",
							url:"<%=request.getContextPath()%>/user/findPhone",
							data: {
								phone:function () {
									return $("#phone").val();
								},
								dataType: "json",
								dataFilter:function (data,type){
									if (data == "true"){
										return true;
									} else {
										return false;
									}
								}
							}
							
						}
				},
				hotelName:{
					required:true,
				},
				hotelType:{
					required:true,
				},
				userRole:{
					required:true,
				},
				hotelAddress:{
					required:true,
				},

			},
		messages:{
				userName:{
					required:"请输入用户名",
					remote: "該用户名已存在，請重新输入"
				},
				userPwd:{
					required:"请输入密码",
					digits:"必须输入数字"
				},
				phone:{
					required:"请输入电话号",
					remote: "該电话号已存在，請重新输入"
				},
			hotelName:{
					required:"请输入酒店名",
				},
			hotelType:{
					required:"必须选一个",
				},
			userRole:{
					required:"必须选一个",
				},
			hotelAddress:{
				required:"请输入酒店地址",
			},
				}
		})
	})

		
//手机验证
 jQuery.validator.addMethod("phone", 
		 function(value, element) { 
			 var ph =/^1[3578]\d{9}$/; 
		 return ph.test(value)
		  }, "请正确填写您的电话号码");
 
		// 注册
		$.validator.setDefaults({
			submitHandler: function (){
				var index = layer.load(1, {shade: 0.3}, {shadeClose: true});
				//密码加盐
				var pwd = md5($("#pwd").val());
				var salt = $("#salt").val();
				var newPassword = md5(pwd + salt);
				$("#pwd").val(newPassword);
				$.post(
						"<%=request.getContextPath()%>/user/insertUser",
						$("#frm").serialize(),
						function (data){
						if(data.code != 200){
							layer.msg(data.msg, {icon: 5});
							layer.close(index);
							return;
						}
						layer.msg(data.msg, {
							  icon: 6,
							  time: 2000 //2秒关闭（如果不配置，默认是3秒）
							}, function(){
							  //do something
							    layer.close(index);
								parent.window.location.href = "<%=request.getContextPath()%>/user/toLogin";
							});
				})
			}
			
		})
	</script>
</html>