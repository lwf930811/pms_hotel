<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <script type="text/javascript" src = "<%=request.getContextPath()%>/static/js/jquery-1.12.4.min.js"></script>
    <script type="text/javascript" src = "<%=request.getContextPath()%>/static/layer/layer.js"></script>
</head>
<body>
    <form id = "frm">
        <input type="hidden" name="id" value="${role.id}"><br />
        角色名:<input type="text" name="roleName" value="${role.roleName}"><br />
        <input type="button" value="修改提交" onclick="update()"><br />
    </form>
</body>
<script type="text/javascript">
    function update(){
        var index = layer.load(1,{shade:0.5});
        $.post(
            "<%=request.getContextPath()%>/role/updateRole",
            $("#frm").serialize(),
            function (data){
                layer.close(index);
                if(data.code != 200){
                    layer.msg(data.msg, {icon: 5});
                    return;
                }
                layer.msg(data.msg, {
                    icon: 6,
                    time: 2000 //2秒关闭（如果不配置，默认是3秒）
                }, function(){
                    //do something
                    parent.window.location.href = "<%=request.getContextPath()%>/role/toList";
                });
            })
    }

</script>
</html>