<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>历史任务日志</title>
	<%@ include file="/common/global.jsp"%>
	<%@ include file="/common/meta.jsp" %>
	<link rel="stylesheet" type="text/css" href="${ctx }/js/jeasyui/themes/bootstrap/easyui.css">
	<link rel="stylesheet" type="text/css" href="${ctx }/js/jeasyui/themes/icon.css">
	<script type="text/javascript" src="${ctx }/js/jeasyui/jquery.min.js"></script>
	<script type="text/javascript" src="${ctx }/js/jeasyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${ctx }/js/jeasyui/extension/jquery-easyui-datagridview/datagrid-detailview.js"></script>
	<script type="text/javascript" src="${ctx }/js/common/easyui/common.js"></script>
    <script type="text/javascript">
    var path="";
	
	$(document).ready(function()
	{
		loadDataGrid();
	});
	
	function loadDataGrid(){
		
		$("#flex").datagrid({
		url:'/loanplus-cc/view/job/queryHisTaskByCondition',//加载的URL
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
 		queryParams:{'jobId':$("#jobId").val(),'jobName':$("#jobName").val(),'taskStatus':$("#taskStatus").val()},
		pageSize : 20,//每页显示的记录条数，默认为20 
	    pageList : [10,20,50,100],//可以设置每页记录条数的列表 
		toolbar:'#tb',
		singleSelect : true,
		columns : [ [ 
		  {field : 'idJobLog',title : '主键',sortable : true,align : 'center',width : '150px'},
		  {field : 'jobId',title : '定时任务ID',sortable : true,align : 'center',width : '150px'},
		  {field : 'jobName',title : '定时任务名称',sortable : true,align : 'center',width : '150px'},
		  {field : 'dateTaskStart',title : '任务启动时间',sortable : true,align : 'center',width : '150px',formatter:function(value,row,index){
		         var datetime = formatDatebox(value);
		         return datetime;
		  }},
		  {field : 'dateTaskEnd',title : '任务结束时间',sortable : true,align : 'center',width : '150px',formatter:function(value,row,index){
		         var datetime = formatDatebox(value);
		         return datetime;
		  }},
 		  {field : 'taskStatus',title : '任务执行状态',sortable : false,align : 'center',width : '150px'},
		  {field : 'runErrMsg',title : '任务描述',sortable : false,align : 'center',width : '150px'},
 		  {field : 'runIp',title : '运行服务器IP地址',sortable : false,align : 'center',width : '150px'},
 		  {field : 'dateCreated',title : '创建日期',sortable : false,align : 'center',width : '150px',formatter:function(value,row,index){
		         var datetime = formatDatebox(value);
		         return datetime;
		  }},
		  {field : 'dateUpdated',title : '更新日期',sortable : false,align : 'center',width : '150px',formatter:function(value,row,index){
		         var datetime = formatDatebox(value);
		         return datetime;
		  }},
		  {field : 'EDIT_ABLE_',title : '操作',sortable : false,align : 'center',width : '250px',formatter: function(value,row,index){
			  return '<a name="deleteHisTask" href="#" idJobLog="'+row['idJobLog']+'">[删除]</a>';
		  }}
		] ],
		view: detailview,
		detailFormatter: function(rowIndex, rowData){
			return '<div style="padding:2px"><table id="ddv-' + rowIndex + '"></table></div>';
		},
		onLoadSuccess : function(data){
$('[name="deleteHisTask"]').click(function() {
	    		var idJobLog = $(this).attr("idJobLog");
	    		$.messager.confirm('Confirm','确定删除?',function(r){
	    		    if (r){
		    			$.ajax({
		    	    		url : '/loanplus-cc/view/job/deleteHisTaskByJobId?idJobLog='+idJobLog,
		    	    		type : 'get',
		    	    		dataType : 'json',
		    	            success:function(data){  
		    	            	var obj = data;  
		    	                if(obj.success){  
		    	                    $.messager.alert('消息',obj.message);  
		    	                    $('#flex').datagrid('reload');
		    	                }else{  
		    	                    $.messager.alert('消息',obj.message);  
		    	                }  
		    	             }  
		    	    	});
	    		    }
	    		});
	    	});

		}
	})
		var pager = $('#flex').datagrid('getPager');
    	
    	pager.pagination({
    	showPageList : true,
        beforePageText : '第',//页数文本框前显示的汉字 
        afterPageText : '页    共 {pages} 页',
        displayMsg : '当前显示 {from} - {to} 条记录   共 {total} 条记录',
    	onBeforeRefresh : function() {
    		return true;
    	}
    	});
	}
	
	
	function searchInfo(){
		$('#flex').datagrid('load',{
			'jobId':$("#jobId").val(),
			'jobName':$("#jobName").val(),
			'taskStatus':$("#taskStatus").val()
		});
	}
	
    </script>
</head>
<body class="easyui-layout">
	<div id="tb" style="height:auto;height:28px" class="datagrid-toolbar">
		<form id="searchForm">
			<span>任务ID：</span>
			<span><input type="text" id="jobId" value="" class="easyui-textbox" style="width: 100px;"></span>
			<span>任务名称：</span>
			<span><input type="text" id="jobName" value="" class="easyui-textbox" style="width: 100px;"></span>
			<span>任务状态：</span>
			<span><input type="text" id="taskStatus" value="" class="easyui-textbox" style="width: 100px;"></span>
			<span><a id="btn" href="#" class="easyui-linkbutton" onclick="searchInfo()" data-options="iconCls:'icon-search'">查询</a></span>
		</form>
		<form id="confirmForm" action="" method="post"></form>
		<div id="graphtrace-dialog"></div>
	</div>
	<div id="mainPanle" region="center" split="false" border="false"
		style="background: #eee;">
		<table id="flex" fit="true"></table>
	</div>
	
</body>
</html>