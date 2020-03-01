<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/static/zTree_v3/css/zTreeStyle/zTreeStyle.css" type="text/css">
	<script type="text/javascript" src="<%=request.getContextPath()%>/static/js/jquery-1.12.4.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/static/zTree_v3/api/apiCss/jquery.ztree.core.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/static/zTree_v3/js/jquery.ztree.exedit.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/static/zTree_v3/js/jquery.ztree.excheck.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/static/zTree_v3/js/jquery.ztree.exhide.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/static/zTree_v3/js/jquery.ztree.all.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/static/layer/layer.js"></script>
	<style type="text/css">
		#a01 {
			text-decoration: none;
			color: red;
		}

		#a02 {
			text-decoration: none;
			color: black;
		}
	</style>
	<style type="text/css">
		#bgc {
			color: red;
		}
	</style>
</head>
<body>
<div id="ztreeDiv" class="ztree"></div>
<input type="hidden" name="roleId" id="${roleId}"/>
<input type="button" value="保存" onclick="saveRoleResource()">
</body>
<script type="text/javascript">
	var treeObj;
	var setting = {
		check: {
			enable: true
		},
		data: {
			simpleData: {
				enable: true,
				pIdKey: "pid"
			},
			key: {
				name: "resourceName",
				url: "xUrl"
			}
		},
	};
	$(document).ready(function(){
		$.post(
				"<%=request.getContextPath()%>/role/roleResource/${roleId}",
				function (data) {
					treeObj = $.fn.zTree.init($("#ztreeDiv"), setting, data.data);
				}
		)
	})
	function saveRoleResource() {
		var index = layer.load();
		var nodes = treeObj.getCheckedNodes(true);//获取全部被勾选的树节点
		var resourceIds = "";
		for (var i = 0; i < nodes.length; i++) {
			resourceIds += "," + nodes[i].id;
			//resourceIds += nodes[i].id + ",";
		}
		/* resourceIds=resourceIds.substr(0,nodes.length-1);*/
		resourceIds = resourceIds.substring(1);

		$.post(
				"<%=request.getContextPath()%>/role/saveRoleResource/${roleId}",
				{"resourceIds": resourceIds},
				function (data) {
					layer.close(index);
					if (data.code == 200) {
						layer.msg(data.msg, {
							icon: 6,
							time: 1000 //1秒关闭（如果不配置，默认是3秒）
						}, function () {
							window.parent.location.reload();
						});
					} else {
						layer.msg(data.msg, {icon: 5})
					}
				}
		)

	}
</script>
</html>