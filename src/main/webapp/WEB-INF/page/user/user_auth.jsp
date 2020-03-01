<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/static/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/static/layer/layer.js"></script>
</head>
<body>
<form id="frm">
<input type="button" value="确定" onclick="update()"><br />
<input type="hidden" name="userId" value="${user.id}">
<table border="1px">
	<tr>
		<th>编号</th>
		<th>角色名</th>
	</tr>
	<c:forEach items="${roleList}" var="role">
		<tr>
			<td>
				<input type="radio" name="userRole" value="${role.id}" <c:if test="${role.id == user.userRole}">checked</c:if>>
					${role.id}
			</td>
			<td>${role.roleName}</td>
		</tr>
	</c:forEach>
</table>
</form>
</body>
	<script type="text/javascript">
		function update (){
			var index = layer.load(1,{shade:0.5});
			$.post(
					"<%=request.getContextPath()%>/user/updateRole",
					$("#frm").serialize(),
					function(data){
						layer.close(index);
						if (data.code != -1) {
							layer.msg(data.msg, {icon: 6}, function(){
								parent.window.location.href = "<%=request.getContextPath()%>/user/toList";
							});
							return;
						}
						layer.msg(data.msg, {icon: 5})

					}
			)
		}

	</script>
</html>