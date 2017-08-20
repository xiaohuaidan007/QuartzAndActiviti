<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>已结束流程</title>
	<%@ include file="/common/global.jsp"%>
	<%@ include file="/common/meta.jsp" %>
	<link rel="stylesheet" type="text/css" href="${ctx }/js/jeasyui/themes/bootstrap/easyui.css">
	<link rel="stylesheet" type="text/css" href="${ctx }/js/jeasyui/themes/icon.css">
	<script type="text/javascript" src="${ctx }/js/jeasyui/jquery.min.js"></script>
	<script type="text/javascript" src="${ctx }/js/jeasyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${ctx }/js/jeasyui/extension/jquery-easyui-datagridview/datagrid-detailview.js"></script>
    <script type="text/javascript">
    var path="";
	
	$(document).ready(function()
	{
		loadDataGrid();
	});
	
	function loadGraphTraceDialog(){
		$('.trace').click(function(){
        	var pid = $(this).attr('pid');
        	var pdid = $(this).attr('pdid');
        	var bsk = $(this).attr('bsk');
        	var src = '${activitiCtx}/workflow/graphtrace/view/'+pid+'/'+pdid+'/'+bsk+'/11';
        	$('#graphtrace-dialog').dialog({    
        	    title: '流程追踪',
        	    fit:true,
        	    style:{'overflow':'hidden'},
//         	    width: document.documentElement.clientWidth * 0.98,    
//         	    height: document.documentElement.clientHeight * 0.98,    
        	    closed: false,    
        	    cache: false,    
        	    content: '<iframe scrolling="auto" frameborder="0" src="'+src+'" style="width:100%;height:100%;"></iframe>',    
        	    modal: true   
        	});  
        });
	};
	
	function loadDataGrid(){
		
		$("#flex").datagrid({
		url:'',//加载的URL
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
 		queryParams:{'processBusinessKey':$("#processBusinessKey").val()},
		//singleSelect : true,
		pageSize : 20,//每页显示的记录条数，默认为20 
	    pageList : [10,20,50,100],//可以设置每页记录条数的列表 
		toolbar:'#tb',
		singleSelect : true,
		columns : [ [ 
		  {field : 'id',title : '流程实例ID',sortable : false,align : 'center',width : '150px',formatter: function(value,row,index){
// 				return '<a class="trace" href="javascript:void(0);" pid="'+row['id']+'" pdid="'+row['processDefinitionId']+'" bsk="'+row['processBusinessKey']+'" title="点击查看流程追踪图">'+value+'</a>'
			  return '<a class="trace" target="_blank" href="${activitiCtx}/workflow/graphtrace/view/'+row['id']+'/'+row['id']+'/'+row['processDefinitionId']+'/'+row['processBusinessKey']+'/11/1" title="点击查看流程追踪图">'+value+'</a>';
		  }},
		  {field : 'processDefinitionKey',title : '流程定义KEY',sortable : false,align : 'center'},
		  {field : 'processDefinitionName',title : '流程定义名称',sortable : true,align : 'center',width : '150px'},
		  {field : 'processDefinitionVersion',title : '流程定义版本',sortable : true,align : 'center'},
		  {field : 'processBusinessKey',title : '业务主键',sortable : true,align : 'center'},
// 		  {field : 'id',title : '主干/分支执行实例ID',sortable : true,align : 'center',width : '150px'},
		  {field : 'parentId',title : '父流程实例ID',sortable : false,align : 'center'},
// 		  {field : 'startingExecution',title : '启动节点',sortable : false,align : 'center',width : '150px'},
// 		  {field : 'suspensionState',title : '挂起标志',sortable : false,align : 'center',width : '150px'},
		  {field : 'name',title : '名称',sortable : false,align : 'center'},
		  {field : 'startTime',title : '启动时间',sortable : true,align : 'center'},
		  {field : 'endTime',title : '结束时间',sortable : true,align : 'center'},
		  {field : 'startUserId',title : '启动用户',sortable : false,align : 'center'}
		] ],
		view: detailview,
		detailFormatter: function(rowIndex, rowData){
			return '<div style="padding:2px"><table id="ddv-' + rowIndex + '"></table></div>';
		},
		onExpandRow:function(index,row){//注意3
            $('#ddv-'+index).datagrid({
            	title:'流程变量',
				data:row.variables,
                fitColumns:true,
                singleSelect:true,
                height:'auto',
                columns:[[
                    {field:'name',title:'流程变量'},
                    {field:'value',title:'变量值'},
                    {field:'type',title:'变量类型'},
                    {field:'createTime',title:'创建时间'},
                    {field:'lastUpdatedTime',title:'最后更新时间',width:150},
                    {field:'time',title:'时间',width:150},
                    {field:'taskId',title:'TaskID',width:150},
                    {field:'executionId',title:'执行实例ID',width:150}
                ]],
                onResize:function(){
                    $('#flex').datagrid('fixDetailRowHeight',index);
                },
                onLoadSuccess:function(){
                    setTimeout(function(){
                        $('#flex').datagrid('fixDetailRowHeight',index);
                    },0);
                    $("#graphtrace-dialog").css("overflow","hidden");
                }
            });
            $('#flex').datagrid('fixDetailRowHeight',index);
        },
		onLoadSuccess : function(data){
// 			loadGraphTraceDialog();
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
		var bk = $('#processBusinessKey').val();
		if(bk==null || bk=='' || bk==undefined){
			$.messager.alert('消息',"必须输入业务主键");
			return;
		}
		var opts = $("#flex").datagrid("options");
	    opts.url = activitiCtx+'/bpmn/data/endexecution-list';
		$('#flex').datagrid('load',{
			'processBusinessKey':$("#processBusinessKey").val()
		});
	}
    </script>
</head>
<body class="easyui-layout">
	<div id="tb" style="height:auto;height:28px" class="datagrid-toolbar">
		<form id="searchForm">
			<span>业务主键：</span>
			<span><input type="text" id="processBusinessKey" value="" class="easyui-textbox" style="width: 100px;"></span>
<!-- 			&nbsp;<span>流程定义KEY：</span> -->
<!-- 			<span><input type="text" id="processDefinitionKey" value="" class="easyui-textbox" style="width: 100px;"/></span> -->
<!-- 			&nbsp;<span>流程定义版本：</span> -->
<!-- 			<span><input type="text" id="processDefinitionVersion" value="" class="easyui-textbox" style="width: 100px;"/></span> -->
<!-- 			&nbsp;<span>流程定义名称：</span> -->
<!-- 			<span><input type="text" id="processDefinitionName" value="" class="easyui-textbox" style="width: 100px;"/></span> -->
<!-- 			<span>开始时间:</span> -->
<!-- 			<span><input class="easyui-datetimebox" id="startTime" name="startTime"      -->
<!--         			data-options="required:false,showSeconds:true" value="" style="width:150px">   -->
<!-- 			</span> -->
<!-- 			<span>结束时间:</span> -->
<!-- 			<span><input class="easyui-datetimebox" id="startTime" name="startTime"      -->
<!--         			data-options="required:false,showSeconds:true" value="" style="width:150px">   -->
<!--         	</span> -->
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