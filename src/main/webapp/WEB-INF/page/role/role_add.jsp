<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
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
    <!-- 错误时提示颜色 -->
    <style>
        .error{
            color:red;
        }
    </style>
</head>
<body>
<form id="frm">
    <input type="text" name="roleName" id="roleName" placeholder="角色名"><br />
    <input type="hidden" name="isDel" value="1">
    <input type="submit" value="新增角色">
</form>
</body>
    <script type="text/javascript">

        $(function(){
            $("#frm").validate({
                //效验规则
                rules: {
                    roleName:{
                        required:true,
                        remote: {
                            type: 'POST',
                            url: "<%=request.getContextPath()%>/role/findByRoleName",
                            data:{
                                userName:function() {
                                    return $("#roleName").val();
                                },
                                dataType:"json",
                                dataFilter:function(data,type){
                                    if (data == 'true'){
                                        return true;
                                    }else {
                                        return false	;
                                    }
                                }
                            }
                        }
                    },
                },
                messages:{
                    roleName:{
                        required:"角色名字必填",
                        remote: "該角色已存在，請重新输入"
                    },
                },
            })
        })

        $.validator.setDefaults({
            submitHandler: function (){
                var index = layer.load(0,{shade:0.5});
                $.post(
                    "<%=request.getContextPath()%>/role/addRoleName",
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
                            parent.window.location.href = "<%=request.getContextPath()%>/role/toList";
                        });
                    })
            }
        });

    </script>
</html>