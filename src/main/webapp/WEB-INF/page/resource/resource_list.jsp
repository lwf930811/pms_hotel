<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/zTree_v3/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/static/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/static/zTree_v3/js/jquery.ztree.core.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/static/layer/layer.js"></script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>展示</title>
</head>

<body>
    <input type="button" value="新增" onclick="addResource()">
    <input type="button" value="修改" onclick="updateResource()">
    <input type="button" value="删除" onclick="delResource()">
    <div id="tree" class="ztree">
    </div>
</body>
<script type="text/javascript">
    var treeObj;
    var setting = {
        data: {
            simpleData: {
                enable: true,
                pIdKey: "pid",
            },
            key: {
                name: "resourceName",
                url: "url"

            }
        },

    };

    $(document).ready(function(){
        $.post(
            "<%=request.getContextPath()%>/resource/ResourceList",
            function (data) {
                treeObj = $.fn.zTree.init($("#tree"), setting, data.data);
            }
        )
    })


    //增加一级二级节点
    function addResource() {
        var treeOb = $.fn.zTree.getZTreeObj("tree");
        var selectNodes = treeOb.getSelectedNodes();
        if (selectNodes.length > 0) {
            var pId = selectNodes[0].id;
        } else {
            var pId = 0;
        }
        layer.open({
            type: 2,
            titel: "新增",
            area: ["400px", "500px"],
            content: "<%=request.getContextPath()%>/resource/toAdd/" + pId,
            end: function () {
                location.reload();
            }
        });
    }

    function updateResource(value) {
        var treeObj = $.fn.zTree.getZTreeObj("tree");
        var selectNode = treeObj.getSelectedNodes();
        if (selectNode.length <= 0) {
            layer.msg("至少选择一个节点操作");
            return false;
        }
        if (selectNode.length > 1) {
            layer.msg("只能选择一个节点操作");
            return false;
        }
        var value = selectNode[0].id;
        layer.open({
            type: 2,
            titel: "修改",
            area: ["400px", "500px"],
            content: "<%=request.getContextPath()%>/resource/toUpdate/"+value,
        });
    }

    function delResource() {
        // 获取选中的节点
        var treeObj = $.fn.zTree.getZTreeObj("tree");
        var selectNode = treeObj.getSelectedNodes()[0];
        if (selectNode == null) {
            layer.msg("至少选择一个节点操作");
            return false;
        }
        // 如果当前选中的节点是 父节点 要获取全部的后代节点信息
        var ids = "";
        if (selectNode.isParent) {
            ids = getChildNode(selectNode);
        }
        ids += selectNode.id;
        layer.msg('确定删除?', {
            time: 0 //不自动关闭
            , btn: ['确定', '取消']
            , yes: function () {
                $.post(
                    "<%=request.getContextPath() %>/resource/delById",
                    {"ids": ids, "isDel":2},
                    function (data) {
                        if (data.code == 200) {
                            layer.msg(data.msg, {
                                icon: 6,
                            }, function () {
                                window.location.href = "<%=request.getContextPath()%>/resource/toList";
                            });
                        } else {
                            layer.msg(data.msg, {icon: 5});
                        }
                    })
            }
        })
    }

    //递归自我调用
    function getChildNode(parentNode) {
        var ids = "";
        // 获取子节点
        var childs = parentNode.children;
        for (var i = 0; i < childs.length; i++) {
            ids += childs[i].id + ",";
            if (childs[i].isParent) {
                ids += getChildNode(childs[i]);
            }
        }
        return ids;
    }


</script>
</html>