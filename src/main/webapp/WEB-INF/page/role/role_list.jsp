<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
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
        <input type="button" value="新增" onclick="add()"><br />
        <input type="hidden" value="1" id="pageNo" name="page">
    </form>
        <table border="1px solid red" cellpadding="20" >
            <tr>
                <th>用户id</th>
                <th>角色名</th>
                <th>操作</th>
            </tr>
            <tbody id="tbd">
            </tbody>
        </table>
        <div id="pageInfo"></div>
</body>
<script type="text/javascript">
    $(function(){
        search();
    })

    function search() {
        $.post(
            "<%=request.getContextPath()%>/role/roleList",
            $("#frm").serialize(),
            function(data){
                var html = "";
                for (var i = 0; i < data.data.roleList.length; i++) {
                    var role = data.data.roleList[i];
                    html += "<tr>"
                    html += "<td>"+role.id+"</td>"
                    html += "<td>"+role.roleName+"</td>"
                    html += "<td><input type='button' value='编辑' onclick='updateRole("+role.id+")'>"
                    html += "<input type='button' value='删除' onclick='delRole("+role.id+")'>"
                    html += "<input type='button' value='关联资源' onclick='toRoleResource("+role.id+")'></td>"
                }
                $("#tbd").append(html);
                var pageNo = $("#pageNo").val();
                var pageInfo = "<input type='button' value='上一页'  onclick='page("+(parseInt(pageNo)-1)+")'>"
                pageInfo +="<input type='button' value='下一页'  onclick='page("+(parseInt(pageNo)+1)+","+data.data.total+")'>"
                $("#pageInfo").html(pageInfo);
            })
    }

    function add(){
        layer.open({
            type: 2,
            title: '角色增加',
            shadeClose: true,
            shade: 0.8,
            area: ['380px', '70%'],
            //路径
            content:  '<%=request.getContextPath()%>/role/toAdd'
        });
    }

    function page (page,total) {
        if (page < 1) {
            layer.msg("已经是首页了");
            return;
        }
        if (total < page) {
            layer.msg("已经是尾页了");
            return;
        }
        $("#pageNo").val(page);
    }

    /**
     * 编辑角色
     */
    function updateRole(id){
        layer.open({
            type: 2,
            title: '角色修改',
            shadeClose: true,
            shade: 0.8,
            area: ['380px', '70%'],
            //路径
            content:  '<%=request.getContextPath()%>/role/toUpdateRole?id='+id
        });
    }

    /**
     * 删除角色
     */
    function delRole(id){
        var index = layer.load(1,{shade:0.5});
        layer.confirm('确定删除吗?', {icon: 3, title:'提示'}, function(index) {
            $.post(
                "<%=request.getContextPath()%>/role/delRole",
                {"id": id},
                function (data) {
                    if (data.code != -1) {
                        layer.msg(data.msg, {icon: 6}, function () {
                            window.location.href = "<%=request.getContextPath()%>/role/toList";
                        });
                        return;
                    }
                    layer.msg(data.msg, {icon: 5})
                    layer.close(index);
                }
            )
        })
        layer.close(index);
    }

     function toRoleResource(roleId){
        layer.open({
            type: 2,
            title: '关联资源',
            shadeClose: true,
            shade: 0.8,
            area: ['380px', '70%'],
            //路径
            content:  '<%=request.getContextPath()%>/role/toRoleResource/'+roleId
        });
    }

</script>
</html>