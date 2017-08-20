<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>流程部署管理</title>
	<%@ include file="/common/global.jsp"%>
	<%@ include file="/common/meta.jsp" %>
	<link rel="stylesheet" type="text/css" href="${ctx }/js/jeasyui/themes/bootstrap/easyui.css">
	<link rel="stylesheet" type="text/css" href="${ctx }/js/jeasyui/themes/icon.css">
	<script type="text/javascript" src="${ctx }/js/jeasyui/jquery.min.js"></script>
	<script type="text/javascript" src="${ctx }/js/jeasyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${ctx }/js/jeasyui/extension/jquery-easyui-datagridview/datagrid-groupview.js"></script>
	<script type="text/javascript" src="${ctx }/js/common/function.js"></script>
	<script type="text/javascript" src="${ctx }/js/common/json2.js"></script>
	<script type="text/javascript" src="${ctx }/js/common/function.js"></script>
    <script type="text/javascript">
    var path="";
	
	$(document).ready(function()
	{
		loadDataGrid2();
	});
	
	function loadDataGrid2(){
		$("#traffic-flex").datagrid({
		title:'流量', 
		url:mvcCtx+'/datasync/monitor/traffic/statistics',//加载的URL
		method:'POST',
		loadMsg : '数据加载中，请稍后……',
		fitColumns : true,
		rownumbers : true,
		pagination : true,
		remoteSort : false,
		multiSort:true,
		sortName : '',
		sortOrder : '',
		selectOnCheck : true,
		striped:true,
		pagination : false,
		toolbar:'#tb2',
		singleSelect : true,
		columns : [ [
		  {field : 'key',title : '通道',sortable : true,align : 'center'},
		  {field : 'usingSpace',title : '等待',sortable : true,align : 'center'},
		  {field : 'queueCapacity',title : '最大容量',sortable : true,align : 'center'}
		] ]
	})
	};
	
	function searchInfo2(){
		$('#traffic-flex').datagrid('load',{});
	};
    </script>
</head>
<body class="easyui-layout">
	<div id="tb" style="height:auto;height:28px" class="datagrid-toolbar">
		<span>&nbsp;<a id="btn" href="#" class="easyui-linkbutton" onclick="searchInfo()" data-options="iconCls:'icon-search'">查询</a></span>
		<form id="confirmForm" action="" method="post"></form>
	</div>
	<div id="tb2" style="height:auto;height:28px" class="datagrid-toolbar">
		<span>&nbsp;<a id="btn" href="#" class="easyui-linkbutton" onclick="searchInfo2()" data-options="iconCls:'icon-search'">查询</a></span>
		<form id="confirmForm2" action="" method="post"></form>
	</div>
	<div id="mainPanle" region="center" split="false" border="false"
		style="background: #eee;">
		<div id="tabs" class="easyui-tabs" fit="true" border="false">
			<div title="流量监控">
				<table id="traffic-flex" fit="true"></table>
			</div>
		</div>
	</div>
</body>
</html>