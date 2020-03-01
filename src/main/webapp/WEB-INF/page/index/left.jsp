<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/static/zTree_v3/css/zTreeStyle/zTreeStyle.css" type="text/css">
	<script type="text/javascript" src = "<%=request.getContextPath()%>/static/js/jquery-1.12.4.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/static/zTree_v3/api/apiCss/jquery.ztree.core.js"></script>
</head>
<body>
<div id="ztreeDiv" class="ztree"></div>
</body>
<script type="text/javascript">

	var setting = {
		data: {
			simpleData: {
				enable: true,
				// idKey: "resourceId",
				pIdKey: "pid"
			},
			key: {
				name: "resourceName",
				url: "xUrl"
			}
		},
		callback: {
			onClick: function (event, treeId, treeNode) {
				if (!treeNode.isParent){
					parent.right.location.href="<%=request.getContextPath()%>" + treeNode.url;
				}
			}
		}

	};
	$(document).ready(function(){
		$.post("<%=request.getContextPath()%>/resource/dataList",
				{"isDel":1},
				function (data) {
					$.fn.zTree.init($("#ztreeDiv"), setting, data.data);
				})

	});
</script>
</html>