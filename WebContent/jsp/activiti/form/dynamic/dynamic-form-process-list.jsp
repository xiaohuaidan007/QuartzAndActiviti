<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>���̶���</title>
	<%@ include file="/common/global.jsp"%>
	<%@ include file="/common/meta.jsp" %>
	<link rel="stylesheet" type="text/css" href="${ctx }/js/jeasyui/themes/bootstrap/easyui.css">
	<link rel="stylesheet" type="text/css" href="${ctx }/js/jeasyui/themes/icon.css">
	<script type="text/javascript" src="${ctx }/js/jeasyui/jquery.min.js"></script>
	<script type="text/javascript" src="${ctx }/js/jeasyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${ctx }/js/common/json2.js"></script>
	<script src="${ctx }/js/module/form/dynamic/dynamic-process-list.js" type="text/javascript"></script>
	<script type="text/javascript" src="${ctx }/js/common/function.js"></script>
    <script type="text/javascript">
    var path="";
	
	$(document).ready(function()
	{
		loadDataGrid();
		
	});
	
	function loadDataGrid(){
		
		$("#flex").datagrid({
		url:activitiCtx+'/bpmn/data/process-list',//���ص�URL
		method:'POST',
		loadMsg : '���ݼ����У����Ժ󡭡�',
		fitColumns : true,
		rownumbers : true,
		pagination : true,
		remoteSort : false,
		multiSort:true,
		sortName : '',
		sortOrder : '',
		selectOnCheck : true,
		striped:true,
// 		queryParams:paramToJSON($("#searchForm").formToArray()),
		//singleSelect : true,
// 		pageSize : 20,//ÿҳ��ʾ�ļ�¼������Ĭ��Ϊ20 
// 	    pageList : [10,20,50,100],//��������ÿҳ��¼�������б� 
		pagination : false,
		toolbar:'#tb',
		singleSelect : true,
		columns : [ [ 
		  {field : 'process.id',title : '���̶���Id',sortable : false,align : 'center',width : '100px'},
		  {field : 'process.deploymentId',title : '���̲���Id',sortable : false,align : 'center',width : '100px'},
		  {field : 'process.key',title : '���̶���KEY',sortable : true,align : 'center'},
		  {field : 'process.name',title : '��������',sortable : true,align : 'center',width : '150px'},
		  {field : 'process.version',title : '���̰汾��',sortable : true,align : 'center'},
		  {field : 'process.resourceName',title : 'XML',sortable : false,align : 'center',formatter: function(value,row,index){
							return '<a target="_blank" href="${activitiCtx }/workflow/resource/read?processDefinitionId='+row['process.id']+'&resourceType=xml">'+value+'</a>'
						}
			},
		  {field : 'process.diagramResourceName',title : 'ͼƬ',sortable : false,align : 'center',formatter: function(value,row,index){
				return '<a target="_blank" href="${activitiCtx }/workflow/resource/read?processDefinitionId='+row['process.id']+'&resourceType=image">'+value+'</a>'
			}},
		  {field : 'deployment.deploymentTime',title : '����ʱ��',sortable : true,align : 'center',width : '150px'},
		  {field : 'process.suspended',title : '�Ƿ����',sortable : false,align : 'center'},
		  {field : 'EDIT_ABLE_',title : '����',sortable : false,align : 'center',width : '100px',formatter: function(value,row,index){
			  return '<a name="startProc" href="#" class="easyui-linkbutton" procid="'+row["process.id"]+'" procname="'+row["process.name"]+'">����</a> ';
		  }}
		] ],
		onLoadSuccess : function(data){
			$('[name="startProc"]').bind('click', function(){
		        var procid = $(this).attr("procid");
		        var procname = $(this).attr("procname");
		        $('#dynamic-form-dialog').dialog({
		        	title: '��������['+procname+']',   
		            width: 500,   
		            height: 350,   
		            closed: false,   
		            cache: false,   
		            content: '<div id="dynamic-form-content" style="align:center;"></div>',   
		            modal: true,
		            iconCls: 'icon-save',
	                buttons: [{
	                    text:'����',
	                    iconCls:'icon-ok',
	                    handler:function(){
	                        sendStartupRequest();
	                    }
	                }],
	                onBeforeOpen:function(){
	                	readFormFields(procid);
	                }
		        });  
		    });    
		}
	})
	}
	
	function searchInfo(){
		$('#flex').datagrid('load',{});
	}
    </script>
</head>
<body class="easyui-layout">
	<div id="tb" style="height:auto;height:28px" class="datagrid-toolbar">
		<span>&nbsp;<a id="btn" href="#" class="easyui-linkbutton" onclick="searchInfo()" data-options="iconCls:'icon-search'">��ѯ</a></span>
		<form id="confirmForm" action="" method="post"></form>
		<input type="hidden" id="startProcessId"/>
		<div id="dynamic-form-dialog"></div>
	</div>
	<div id="mainPanle" region="center" split="false" border="false"
		style="background: #eee;">
		<table id="flex" fit="true"></table>
	</div>
	
</body>
</html>