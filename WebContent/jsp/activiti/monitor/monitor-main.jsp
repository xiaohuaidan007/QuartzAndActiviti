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
		loadDataGrid();
		loadDataGrid2();
	});
	
	function loadDataGrid(){
		$("#nodejob-flex").datagrid({
		title:'节点作业', 
		url:activitiCtx+'/bpmn/data/moni/nodejob/statistics',//加载的URL
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
		toolbar:'#tb',
		singleSelect : true,
		columns : [ [ 
// 		  {field : 'processDefinitionKey',title : '流程定义KEY',sortable : true,align : 'center'},
// 		  {field : 'processDefinitionVersion',title : '流程版本号',sortable : true,align : 'center'},
// 		  {field : 'processDefinitionName',title : '流程定义名称',sortable : true,align : 'center'},
		  {field : 'activityId',title : '节点定义ID',sortable : true,align : 'center'},
		  {field : 'activityName',title : '节点名称',sortable : true,align : 'center'},
		  {field : 'nonRetryCount',title : '异常压件数',sortable : true,align : 'center',formatter: function(value,row,index){
		      if(row['nonRetryCount']>0){
		    	  var str = '<div style="color:red;">'+row['nonRetryCount']+'</div>';
			      return str;
		      }else{
		    	  return row['nonRetryCount'];
		      }
		  }},
		  {field : 'timeWindowCount',title : '时间窗口压件数',sortable : true,align : 'center',formatter: function(value,row,index){
		      if(row['timeWindowCount']>0){
		    	  var str = '<div style="color:red;">'+row['timeWindowCount']+'</div>';
			      return str;
		      }else{
		    	  return row['timeWindowCount'];
		      }
		  }},
		  {field : 'endLessLoopCount',title : '死循环压件数',sortable : true,align : 'center',formatter: function(value,row,index){
		      if(row['endLessLoopCount']>0){
		    	  var str = '<div style="color:red;">'+row['endLessLoopCount']+'</div>';
			      return str;
		      }else{
		    	  return row['endLessLoopCount'];
		      }
		  }},
		  {field : 'EDIT_ABLE_',title : '操作',sortable : false,align : 'center',formatter: function(value,row,index){
		      if(row['nonRetryCount']>0){
		    	  var str = '<span><a name="batchRestart" href="javascript:void(0);" psKey="'+row['processDefinitionKey']+'" psVersion="'+row['processDefinitionVersion']+'" activityId="'+row['activityId']+'">[批量重启]</a>';
			      return str;  
		      }else{
		    	  return '';
		      }
		  }}
		] ],
		groupField:'processDefinitionId', 
		view: groupview, 
		groupFormatter:function(value, rows){ 
			if(rows.length>0){
				if(rows[0]['processDefinitionVersion']==0){
					return rows[0]['processDefinitionKey']+"-刷新时间:"+rows[0]['statisticTime'];
				}else{
					return rows[0]['processDefinitionKey']+"-"+rows[0]['processDefinitionVersion']+"-"+rows[0]['processDefinitionName']+"-刷新时间:"+rows[0]['statisticTime'];
				}
			}
		},
		onLoadSuccess : function(data){
			$('[name="batchRestart"]').click(function() {
				var psKey = $(this).attr("psKey");
				var psVersion = $(this).attr("psVersion");
				var activityId = $(this).attr("activityId");
				$.messager.confirm('Confirm','确定重启?',function(r){
				    if (r){
				    	loadMask();
		    			$.ajax({
		    	    		url : '${activitiCtx }/monitor/restart/job/'+psKey+'/'+psVersion+'/'+activityId,
		    	    		type : 'post',
		    	    		dataType : 'json',
		    	            success:function(data){
		    	            	disLoadMask();
		    	            	var obj = data;  
		    	                if(obj.success){  
		    	                    $.messager.alert('消息',obj.message);  
		    	                    $('#nodejob-flex').datagrid('reload');
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
	};
	
	function loadDataGrid2(){
		$("#traffic-flex").datagrid({
		title:'流量', 
		url:activitiCtx+'/bpmn/data/moni/traffic/statistics',//加载的URL
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
		  {field : 'pway',title : '通道',sortable : true,align : 'center'},
		  {field : 'bufferValue',title : '缓冲资源 (等待/容量)',sortable : true,align : 'center'},
		  {field : 'executeValue',title : '执行资源(活动线程/等待/容量)',sortable : true,align : 'center'}
		] ],
		groupField:'lockOwner', 
		view: groupview, 
		groupFormatter:function(value, rows){ 
			if(rows.length>0){
				return rows[0]['lockOwner']+"-刷新时间:"+rows[0]['refreshTime'];
			}
		},
		onLoadSuccess : function(data){
			
		}
	})
	};
	
	function searchInfo(){
		$('#nodejob-flex').datagrid('load',{});
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
			<div title="节点作业监控">
				<table id="nodejob-flex" fit="true"></table>
			</div>
			<div title="流量监控">
				<table id="traffic-flex" fit="true"></table>
			</div>
		</div>
	</div>
</body>
</html>