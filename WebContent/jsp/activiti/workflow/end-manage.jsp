<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>�ѽ�������</title>
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
        	    title: '����׷��',
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
		url:'',//���ص�URL
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
 		queryParams:{'processBusinessKey':$("#processBusinessKey").val()},
		//singleSelect : true,
		pageSize : 20,//ÿҳ��ʾ�ļ�¼������Ĭ��Ϊ20 
	    pageList : [10,20,50,100],//��������ÿҳ��¼�������б� 
		toolbar:'#tb',
		singleSelect : true,
		columns : [ [ 
		  {field : 'id',title : '����ʵ��ID',sortable : false,align : 'center',width : '150px',formatter: function(value,row,index){
// 				return '<a class="trace" href="javascript:void(0);" pid="'+row['id']+'" pdid="'+row['processDefinitionId']+'" bsk="'+row['processBusinessKey']+'" title="����鿴����׷��ͼ">'+value+'</a>'
			  return '<a class="trace" target="_blank" href="${activitiCtx}/workflow/graphtrace/view/'+row['id']+'/'+row['id']+'/'+row['processDefinitionId']+'/'+row['processBusinessKey']+'/11/1" title="����鿴����׷��ͼ">'+value+'</a>';
		  }},
		  {field : 'processDefinitionKey',title : '���̶���KEY',sortable : false,align : 'center'},
		  {field : 'processDefinitionName',title : '���̶�������',sortable : true,align : 'center',width : '150px'},
		  {field : 'processDefinitionVersion',title : '���̶���汾',sortable : true,align : 'center'},
		  {field : 'processBusinessKey',title : 'ҵ������',sortable : true,align : 'center'},
// 		  {field : 'id',title : '����/��ִ֧��ʵ��ID',sortable : true,align : 'center',width : '150px'},
		  {field : 'parentId',title : '������ʵ��ID',sortable : false,align : 'center'},
// 		  {field : 'startingExecution',title : '�����ڵ�',sortable : false,align : 'center',width : '150px'},
// 		  {field : 'suspensionState',title : '�����־',sortable : false,align : 'center',width : '150px'},
		  {field : 'name',title : '����',sortable : false,align : 'center'},
		  {field : 'startTime',title : '����ʱ��',sortable : true,align : 'center'},
		  {field : 'endTime',title : '����ʱ��',sortable : true,align : 'center'},
		  {field : 'startUserId',title : '�����û�',sortable : false,align : 'center'}
		] ],
		view: detailview,
		detailFormatter: function(rowIndex, rowData){
			return '<div style="padding:2px"><table id="ddv-' + rowIndex + '"></table></div>';
		},
		onExpandRow:function(index,row){//ע��3
            $('#ddv-'+index).datagrid({
            	title:'���̱���',
				data:row.variables,
                fitColumns:true,
                singleSelect:true,
                height:'auto',
                columns:[[
                    {field:'name',title:'���̱���'},
                    {field:'value',title:'����ֵ'},
                    {field:'type',title:'��������'},
                    {field:'createTime',title:'����ʱ��'},
                    {field:'lastUpdatedTime',title:'������ʱ��',width:150},
                    {field:'time',title:'ʱ��',width:150},
                    {field:'taskId',title:'TaskID',width:150},
                    {field:'executionId',title:'ִ��ʵ��ID',width:150}
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
        beforePageText : '��',//ҳ���ı���ǰ��ʾ�ĺ��� 
        afterPageText : 'ҳ    �� {pages} ҳ',
        displayMsg : '��ǰ��ʾ {from} - {to} ����¼   �� {total} ����¼',
    	onBeforeRefresh : function() {
    		return true;
    	}
    	});
	}
	
	
	function searchInfo(){
		var bk = $('#processBusinessKey').val();
		if(bk==null || bk=='' || bk==undefined){
			$.messager.alert('��Ϣ',"��������ҵ������");
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
			<span>ҵ��������</span>
			<span><input type="text" id="processBusinessKey" value="" class="easyui-textbox" style="width: 100px;"></span>
<!-- 			&nbsp;<span>���̶���KEY��</span> -->
<!-- 			<span><input type="text" id="processDefinitionKey" value="" class="easyui-textbox" style="width: 100px;"/></span> -->
<!-- 			&nbsp;<span>���̶���汾��</span> -->
<!-- 			<span><input type="text" id="processDefinitionVersion" value="" class="easyui-textbox" style="width: 100px;"/></span> -->
<!-- 			&nbsp;<span>���̶������ƣ�</span> -->
<!-- 			<span><input type="text" id="processDefinitionName" value="" class="easyui-textbox" style="width: 100px;"/></span> -->
<!-- 			<span>��ʼʱ��:</span> -->
<!-- 			<span><input class="easyui-datetimebox" id="startTime" name="startTime"      -->
<!--         			data-options="required:false,showSeconds:true" value="" style="width:150px">   -->
<!-- 			</span> -->
<!-- 			<span>����ʱ��:</span> -->
<!-- 			<span><input class="easyui-datetimebox" id="startTime" name="startTime"      -->
<!--         			data-options="required:false,showSeconds:true" value="" style="width:150px">   -->
<!--         	</span> -->
			<span><a id="btn" href="#" class="easyui-linkbutton" onclick="searchInfo()" data-options="iconCls:'icon-search'">��ѯ</a></span>
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