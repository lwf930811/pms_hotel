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
    上级节点:${parentName}<br />
    资源名:<input type="text" name="resourceName" id="resourceName"><br />
    资源路径:<input type="text" name="url" ><br />
    资源类型:<select name="resourceType">
        <option value="1">菜单</option>
        <option value="2">按钮</option>
        </select><br />
    <input type="hidden" name="isDel" value="1">
    <input type="hidden" name="pId" value="${pId}">
    <input type="submit" value="添加">
</form>
</body>
<script type="text/javascript">
    $(function(){
        $("#frm").validate({
            rules:{
                resourceName:{
                    required:true,
                    remote: {//ajax验证。server result:{"valid",true or false} 向服务发送当前input name值，获得一个json数据。例表示正确：{"valid",true}
                        type: 'POST',
                        url: "<%=request.getContextPath()%>/resource/findByResourceName",
                        data:{
                            userName:function() {
                                return $("#resourceName").val();
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
                url: {
                    required: true,
                }
            },
            messages:{
                resourceName:{
                    required:"请填写资源名",
                    remote:"资源已存在"
                },
                url:{
                    required:"请填写路径"
                }
            }
        })

    })

    //注册
    $.validator.setDefaults({
        submitHandler: function() {
            var index = layer.load(1,{shade:0.3},{shadeClose:true}); //解决网络延迟的加载重复操作问题
            layer.msg('请稍等', {
                icon: 1,
                time: 2000, //2秒关闭（如果不配置，默认是3秒）
                shade: [0.8, '#393D49']
            }, function(){
                //do something

                $.post("<%=request.getContextPath()%>/resource/addResource ",
                    $("#frm").serialize(),
                    function(data){
                        layer.close(index);
                        if (data.code == -1){
                            layer.msg(data.msg, {icon: 5});
                            return;
                        }
                        parent.window.location.href="<%=request.getContextPath()%>/resource/toList";
                    });
            });
            layer.msg("成功", {icon: 6});
        }
    });

</script>
</html>
