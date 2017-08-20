<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>��ʷ������־</title>
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
		url:'/loanplus-cc/view/job/queryHisTaskByCondition',//���ص�URL
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
 		queryParams:{'jobId':$("#jobId").val(),'jobName':$("#jobName").val(),'taskStatus':$("#taskStatus").val()},
		pageSize : 20,//ÿҳ��ʾ�ļ�¼������Ĭ��Ϊ20 
	    pageList : [10,20,50,100],//��������ÿҳ��¼�������б� 
		toolbar:'#tb',
		singleSelect : true,
		columns : [ [ 
		  {field : 'idJobLog',title : '����',sortable : true,align : 'center',width : '150px'},
		  {field : 'jobId',title : '��ʱ����ID',sortable : true,align : 'center',width : '150px'},
		  {field : 'jobName',title : '��ʱ��������',sortable : true,align : 'center',width : '150px'},
		  {field : 'dateTaskStart',title : '��������ʱ��',sortable : true,align : 'center',width : '150px',formatter:function(value,row,index){
		         var datetime = formatDatebox(value);
		         return datetime;
		  }},
		  {field : 'dateTaskEnd',title : '�������ʱ��',sortable : true,align : 'center',width : '150px',formatter:function(value,row,index){
		         var datetime = formatDatebox(value);
		         return datetime;
		  }},
 		  {field : 'taskStatus',title : '����ִ��״̬',sortable : false,align : 'center',width : '150px'},
		  {field : 'runErrMsg',title : '��������',sortable : false,align : 'center',width : '150px'},
 		  {field : 'runIp',title : '���з�����IP��ַ',sortable : false,align : 'center',width : '150px'},
 		  {field : 'dateCreated',title : '��������',sortable : false,align : 'center',width : '150px',formatter:function(value,row,index){
		         var datetime = formatDatebox(value);
		         return datetime;
		  }},
		  {field : 'dateUpdated',title : '��������',sortable : false,align : 'center',width : '150px',formatter:function(value,row,index){
		         var datetime = formatDatebox(value);
		         return datetime;
		  }},
		  {field : 'EDIT_ABLE_',title : '����',sortable : false,align : 'center',width : '250px',formatter: function(value,row,index){
			  return '<a name="deleteHisTask" href="#" idJobLog="'+row['idJobLog']+'">[ɾ��]</a>';
		  }}
		] ],
		view: detailview,
		detailFormatter: function(rowIndex, rowData){
			return '<div style="padding:2px"><table id="ddv-' + rowIndex + '"></table></div>';
		},
		onLoadSuccess : function(data){
$('[name="deleteHisTask"]').click(function() {
	    		var idJobLog = $(this).attr("idJobLog");
	    		$.messager.confirm('Confirm','ȷ��ɾ��?',function(r){
	    		    if (r){
		    			$.ajax({
		    	    		url : '/loanplus-cc/view/job/deleteHisTaskByJobId?idJobLog='+idJobLog,
		    	    		type : 'get',
		    	    		dataType : 'json',
		    	            success:function(data){  
		    	            	var obj = data;  
		    	                if(obj.success){  
		    	                    $.messager.alert('��Ϣ',obj.message);  
		    	                    $('#flex').datagrid('reload');
		    	                }else{  
		    	                    $.messager.alert('��Ϣ',obj.message);  
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
        beforePageText : '��',//ҳ���ı���ǰ��ʾ�ĺ��� 
        afterPageText : 'ҳ    �� {pages} ҳ',
        displayMsg : '��ǰ��ʾ {from} - {to} ����¼   �� {total} ����¼',
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
			<span>����ID��</span>
			<span><input type="text" id="jobId" value="" class="easyui-textbox" style="width: 100px;"></span>
			<span>�������ƣ�</span>
			<span><input type="text" id="jobName" value="" class="easyui-textbox" style="width: 100px;"></span>
			<span>����״̬��</span>
			<span><input type="text" id="taskStatus" value="" class="easyui-textbox" style="width: 100px;"></span>
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