<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>流程列表</title>
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
	
	/**
	* EasyUI DataGrid根据字段动态合并单元格
	* 参数 tableID 要合并table的id
	* 参数 colList 要合并的列,用逗号分隔(例如："name,department,office");
	*/
	function mergeCellsByField(tableID, colList) {
	    var ColArray = colList.split(",");
	    var tTable = $("#" + tableID);
	    var TableRowCnts = tTable.datagrid("getRows").length;
	    var tmpA;
	    var tmpB;
	    var PerTxt = "";
	    var CurTxt = "";
	    var alertStr = "";
	    for (j = ColArray.length - 1; j >= 0; j--) {
	        PerTxt = "";
	        tmpA = 1;
	        tmpB = 0;

	        for (i = 0; i <= TableRowCnts; i++) {
	            if (i == TableRowCnts) {
	                CurTxt = "";
	            }
	            else {
	                CurTxt = tTable.datagrid("getRows")[i][ColArray[j]];
	            }
	            if (PerTxt == CurTxt) {
	                tmpA += 1;
	            }
	            else {
	                tmpB += tmpA;
	                
	                tTable.datagrid("mergeCells", {
	                    index: i - tmpA,
	                    field: ColArray[j],　　//合并字段
	                    rowspan: tmpA,
	                    colspan: null
	                });
	                tTable.datagrid("mergeCells", { //根据ColArray[j]进行合并
	                    index: i - tmpA,
	                    field: "Ideparture",
	                    rowspan: tmpA,
	                    colspan: null
	                });
	               
	                tmpA = 1;
	            }
	            PerTxt = CurTxt;
	        }
	    }
	}
	
// 	function loadGraphTraceDialog(){
// 		$('.trace').click(function(){
// 			var eid = $(this).attr('eid');
//         	var pid = $(this).attr('pid');
//         	var pdid = $(this).attr('pdid');
//         	var bsk = $(this).attr('bsk');
//         	var src = '${activitiCtx}/workflow/graphtrace/view/'+eid+'/'+pid+'/'+pdid+'/'+bsk+'/00';
//         	$('#graphtrace-dialog').dialog({    
//         	    title: '流程追踪',
//         	    fit:true,
//         	    style:{'overflow':'hidden'},
// //         	    width: document.documentElement.clientWidth * 0.98,    
// //         	    height: document.documentElement.clientHeight * 0.98,    
//         	    closed: false,    
//         	    cache: false,    
//         	    content: '<iframe scrolling="auto" frameborder="0" src="'+src+'" style="width:100%;height:100%;"></iframe>',    
//         	    modal: true   
//         	});  
//         });
// 	};
	
	function loadJobManageDialog(){
		$('.jobManage').click(function(){
        	var jobid = $(this).attr('jobid');
        	var src = '${activitiCtx}/management/job/manage/'+jobid;
        	$('#graphtrace-dialog').dialog({    
        	    title: '作业管理',
//         	    fit:true,
        	    style:{'overflow':'hidden'},
        	    width: document.documentElement.clientWidth * 0.98,    
        	    height: document.documentElement.clientHeight * 0.5,    
        	    closed: false,    
        	    cache: false,    
        	    content: '<iframe scrolling="auto" frameborder="0" src="'+src+'" style="width:100%;height:100%;"></iframe>',    
        	    modal: true   
        	});  
        });
	};
	
	function loadDataGrid(){
		
		$("#flex").datagrid({
		url:activitiCtx+'/bpmn/data/execution-list',//加载的URL
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
 		queryParams:{'processBusinessKey':$("#processBusinessKey").val(),'processDefinitionKey':$("#processDefinitionKey").val(),
 						'processDefinitionVersion':$("#processDefinitionVersion").val(),'exception':serchExceptionVal()},
		//singleSelect : true,
		pageSize : 20,//每页显示的记录条数，默认为20 
	    pageList : [10,20,50,100],//可以设置每页记录条数的列表 
		toolbar:'#tb',
		singleSelect : true,
		columns : [ [ 
		  {field : 'processInstanceId',title : '流程实例ID',sortable : true,align : 'center',width : '150px'},
		  {field : 'processDefinitionKey',title : '流程定义KEY',sortable : true,align : 'center'},
		  {field : 'processDefinitionName',title : '流程定义名称',sortable : true,align : 'center',width : '150px'},
		  {field : 'processDefinitionVersion',title : '流程定义版本',sortable : true,align : 'center'},
		  {field : 'processBusinessKey',title : '业务主键',sortable : true,align : 'center'},
// 		  {field : 'id',title : '主干/分支执行实例ID',sortable : true,align : 'center',width : '150px'},
		  {field : 'superExecutionId',title : '父执行实例ID',sortable : true,align : 'center'},
// 		  {field : 'startingExecution',title : '启动节点',sortable : false,align : 'center',width : '150px'},
// 		  {field : 'suspensionState',title : '挂起标志',sortable : false,align : 'center',width : '150px'},
		  {field : 'currentActivityId',title : '当前节点ID',sortable : true,align : 'center',width : '150px'},
		  {field : 'currentActivityName',title : '当前节点名称',sortable : false,align : 'center',width : '150px',formatter: function(value,row,index){
// 				return '<a class="trace" href="javascript:void(0);" eid="'+row['realActiveExecutionId']+'" pid="'+row['processInstanceId']+'" pdid="'+row['processDefinitionId']+'" bsk="'+row['processBusinessKey']+'" title="点击查看流程追踪图">'+value+'</a>';
			  return '<a class="trace" target="_blank" href="${activitiCtx}/workflow/graphtrace/view/'+row['realActiveExecutionId']+'/'+row['processInstanceId']+'/'+row['processDefinitionId']+'/'+row['processBusinessKey']+'/00/1" title="点击查看流程追踪图">'+value+'</a>';
		  }},
		  {field : 'startTime',title : '启动时间',sortable : true,align : 'center'},
		  {field : 'startUserId',title : '启动用户',sortable : false,align : 'center'}
		] ],
		view: detailview,
		detailFormatter: function(rowIndex, rowData){
			return '<div style="padding:2px"><table id="ddv-' + rowIndex + '"></table></div>'+
					'<div style="padding:2px"><table id="ddv2-' + rowIndex + '"></table></div>'+
					'<div style="padding:2px"><table id="ddv3-' + rowIndex + '"></table></div>';
		},
		rowStyler:function(index,row){
			if (row.exception == true){
				return 'background-color:pink;font-weight:bold;';
			}
		},
		onExpandRow:function(index,row){//注意3
            $('#ddv-'+index).datagrid({
            	title:'主干/分支执行实例',
				data:row.executions,
                fitColumns:true,
                singleSelect:true,
                height:'auto',
                columns:[[
                    {field:'id',title:'执行实例ID'},
                    {field:'currentActivityId',title:'当前节点ID',width:150},
                    {field:'currentActivityName',title:'当前节点名称',width:150,formatter: function(value,row,index){
// 						return '<a class="trace" href="javascript:void(0);" eid="'+row['id']+'" pid="'+row['processInstanceId']+'" pdid="'+row['processDefinitionId']+'" bsk="'+row['processBusinessKey']+'" title="点击查看流程追踪图">'+value+'</a>'
                    	return '<a class="trace" target="_blank" href="${activitiCtx}/workflow/graphtrace/view/'+row['id']+'/'+row['processInstanceId']+'/'+row['processDefinitionId']+'/'+row['processBusinessKey']+'/00/1" title="点击查看流程追踪图">'+value+'</a>';
                    }},
					{field:'active',title:'是否活动的'},
                    {field:'suspensionState',title:'是否挂起',formatter: function(value,row,index){
						if(value==1){
							return '激活';
						}else{
							return '挂起';
						}
					}},
                    {field:'parentId',title:'父执行实例ID',width:150},
                    {field:'lockTime',title:'锁定时间',width:150,align:'center'},
                    {field:'revision',title:'版本号',width:150},
                ]],
                onResize:function(){
                    $('#flex').datagrid('fixDetailRowHeight',index);
                },
                onLoadSuccess:function(){
                    setTimeout(function(){
                        $('#flex').datagrid('fixDetailRowHeight',index);
                    },0);
//                     loadGraphTraceDialog();
                    $("#graphtrace-dialog").css("overflow","hidden");
                }
            });
            $('#ddv2-'+index).datagrid({
            	title:'流程变量',
				data:row.variables,
                fitColumns:true,
                singleSelect:true,
                height:'auto',
                columns:[[
                    {field:'name',title:'流程变量',sortable : true},
                    {field:'value',title:'变量值',sortable : true,width:150},
                    {field:'type',title:'变量类型',sortable : true,width:150},
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
            $('#ddv3-'+index).datagrid({
            	title:'节点作业',
				data:row.jobs,
                fitColumns:true,
                singleSelect:true,
                height:'auto',
                columns:[[
                    {field:'id',title:'作业ID',formatter: function(value,row,index){
        				return '<a class="jobManage" href="javascript:void(0);" jobid="'+value+'" title="点击管理作业">'+value+'</a>';
        			}},
        			{field:'name',title:'节点名称',width:150},
                    {field:'lockExpirationTime',title:'锁定到期时间'},
                    {field:'duedate',title:'到期时间'},
                    {field:'retries',title:'剩余重试次数'},
                    {field:'lockOwner',title:'锁定者'},
                    {field:'jobType',title:'作业类型'},
                    {field:'exceptionMessage',title:'异常信息'},
                    {field:'revision',title:'版本'},
                    {field:'jobHandlerType',title:'作业处理类型'}
                ]],
                rowStyler:function(index,row){
        			if (row.retries < 1){
        				return 'background-color:pink;font-weight:bold;';
        			}
        		},
                onResize:function(){
                    $('#flex').datagrid('fixDetailRowHeight',index);
                },
                onLoadSuccess:function(){
                    setTimeout(function(){
                        $('#flex').datagrid('fixDetailRowHeight',index);
                    },0);
                    loadJobManageDialog();
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
		$('#flex').datagrid('load',{
			'processBusinessKey':$("#processBusinessKey").val(),
			'processDefinitionKey':$("#processDefinitionKey").val(),
			'processDefinitionVersion':$("#processDefinitionVersion").val(),
			'exception':serchExceptionVal()
		});
	}
	function serchExceptionVal(){
		var qx = $("input[name='exception']:checked").map(function () {
            return $(this).val();
        }).get().join(',');
		return qx;
	}
    </script>
</head>
<body class="easyui-layout">
	<div id="tb" style="height:auto;height:28px" class="datagrid-toolbar">
		<form id="searchForm">
			<span>业务主键：</span>
			<span><input type="text" id="processBusinessKey" value="" class="easyui-textbox" style="width: 100px;"></span>
			&nbsp;<span>流程定义KEY：</span>
			<span><input type="text" id="processDefinitionKey" value="" class="easyui-textbox" style="width: 100px;"/></span>
			&nbsp;<span>流程定义版本：</span>
			<span><input type="text" id="processDefinitionVersion" value="" class="easyui-textbox" style="width: 100px;"/></span>
			&nbsp;
			<span><input type="checkbox" name="exception" value="1"/>仅查询异常流程</span>
			<span><a id="btn" href="#" class="easyui-linkbutton" onclick="searchInfo()" data-options="iconCls:'icon-search'">查询</a></span>
		</form>
		<form id="confirmForm" action="" method="post"></form>
		<div id="graphtrace-dialog"></div>
		<div id="jobmanage-dialog"></div>
	</div>
	<div id="mainPanle" region="center" split="false" border="false"
		style="background: #eee;">
		<table id="flex" fit="true"></table>
	</div>
	
</body>
</html>