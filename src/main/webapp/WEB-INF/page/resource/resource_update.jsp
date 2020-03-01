<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>list</title>
    <script type="text/javascript" src="<%=request.getContextPath()%>/static/js/jquery-1.12.4.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/static/layer/layer.js"></script>
    <script src="<%=request.getContextPath()%>/static/validate/jquery.validate.js"></script>
    <script src="https://static.runoob.com/assets/jquery-validation-1.14.0/dist/localization/messages_zh.js"></script>
    <style>
        .error{
            color: red;
        }
    </style>
</head>
<body>
    <form id="frm">
        角色名：<input type="text" name="resourceName" value="${resource.resourceName}"/><br>
        路径：<input type="text" name="url" value="${resource.url}"/><br>
            <input type="hidden" name="id" value="${resource.id}"><br>
        资源类型：
        <input type = "radio" name = "userSex"  value="1"  <c:if test="${user.userSex == 1}">checked</c:if>>菜单
        <input type = "radio" name = "userSex"  value="2"  <c:if test="${user.userSex == 2}">checked</c:if>>按钮</br>
        <input type="submit" value="修改" />
    </form>
</body>
<script type="text/javascript">
    $(function(){
        $("#frm").validate({
            rules:{
                resourceName:{
                    required:true,
                }
            },
            messages:{
                resourceName:{
                    required:"请填写角色名"
                }
            }
        })

    })

    //修改
    $.validator.setDefaults({
        submitHandler: function() {
            var index = layer.load(1,{shade:0.3},{shadeClose:true}); //解决网络延迟的加载重复操作问题
            layer.msg('请稍等', {
                icon: 1,
                time: 2000, //2秒关闭（如果不配置，默认是3秒）
                shade: [0.8, '#393D49']
            }, function(){
                //do something

                $.post("<%=request.getContextPath()%>/resource/updateResource ",
                    $("#frm").serialize(),
                    function(data){
                        layer.close(index);
                        if (data.code == -1){
                            layer.msg(data.msg, {icon: 5});
                            return;
                        }
                        parent.window.location.href="<%=request.getContextPath()%>/resource/toShow";
                    });
            });
            layer.msg("成功", {icon: 6});
        }
    });


</script>
</html>
