<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>����ģ��</title>
	<%@ include file="/common/global.jsp"%>
	<%@ include file="/common/meta.jsp" %>
	<link rel="stylesheet" type="text/css" href="${ctx }/js/jeasyui/themes/bootstrap/easyui.css">
	<link rel="stylesheet" type="text/css" href="${ctx }/js/jeasyui/themes/icon.css">
	<script type="text/javascript" src="${ctx }/js/jeasyui/jquery.min.js"></script>
	<script type="text/javascript" src="${ctx }/js/jeasyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${ctx }/js/common/function.js"></script>
    <script type="text/javascript" src="${ctx }/js/jeasyui/extension/easyui-extend-validatebox.js"></script>
    <script type="text/javascript">
    var path="";
	
	$(document).ready(function()
	{
		loadDataGrid();
		
		$("#addModel").click(function(){
			$("#createModelTemplate").dialog("open");
		});
	});
	
	function loadDataGrid(){
		
		$("#flex").datagrid({
		url:activitiCtx+'/bpmn/data/model-list',//���ص�URL
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
		pagination : false,
		toolbar:'#tb',
		singleSelect : true,
		columns : [ [ 
		  {field : 'id',title : 'ģ��ID',sortable : false,align : 'center',width : '150px'},
		  {field : 'key',title : 'ģ��KEY',sortable : true,align : 'center',width : '150px'},
		  {field : 'name',title : 'ģ������',sortable : true,align : 'center',width : '150px'},
		  {field : 'version',title : 'ģ�Ͱ汾',sortable : true,align : 'center',width : '150px'},
		  {field : 'createTime',title : '����ʱ��',sortable : false,align : 'center',width : '150px'},
		  {field : 'lastUpdateTime',title : '������ʱ��',sortable : true,align : 'center',width : '150px'},
		  {field : 'metaInfo',title : 'Ԫ����',sortable : false,align : 'center',width : '150px'},
		  {field : 'EDIT_ABLE_',title : '����',sortable : false,align : 'center',width : '250px',formatter: function(value,row,index){
			  var str = '<a href="${ctx}/modeler.html?modelId='+row['id']+'" target="_blank">[�༭]</a>'+
					  '&nbsp;<a name="deploymentBtn" href="javascript:void(0);" modelid="'+row['id']+'">[����]</a>'+
					  '&nbsp;<a name="deleteBtn" href="javascript:void(0);" modelid="'+row['id']+'">[ɾ��]</a>'+
					  '&nbsp;����(<a href="${activitiCtx}/workflow/model/export/'+row['id']+'/bpmn" target="_blank">BPMN</a>)';
			  return str;
		  }}
		] ],
		onLoadSuccess : function(data){
			$('[name="deploymentBtn"]').click(function() {
				var modelid = $(this).attr("modelid");
				$.messager.confirm('Confirm','ȷ������?',function(r){
				    if (r){
				    	loadMask();
		    			$.ajax({
		    	    		url : '${activitiCtx}/workflow/model/deploy/'+modelid,
		    	    		type : 'post',
		    	    		dataType : 'json',
		    	            success:function(data){
		    	            	disLoadMask();
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
			$('[name="deleteBtn"]').click(function() {
				var modelid = $(this).attr("modelid");
				$.messager.confirm('Confirm','ȷ��ɾ��?',function(r){
				    if (r){
				    	loadMask();
		    			$.ajax({
		    	    		url : '${activitiCtx}/workflow/model/delete/'+modelid,
		    	    		type : 'post',
		    	    		dataType : 'json',
		    	            success:function(data){
		    	            	disLoadMask();
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
	}
	
	function searchInfo(){
		$('#flex').datagrid('load',{});
	}
    </script>
</head>
<body class="easyui-layout">
	<div id="tb" style="height:auto;height:28px" class="datagrid-toolbar">
		<a id="addModel" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">����</a>
		<span>&nbsp;<a id="btn" href="#" class="easyui-linkbutton" onclick="searchInfo()" data-options="iconCls:'icon-search'">��ѯ</a></span>
		<div id="createModelTemplate" class="easyui-dialog" title="����ģ��" style="width:400px;height:200px;"
			data-options="iconCls:'icon-save',
			resizable:true,
			modal:true,
			closed:true,
			cache:false,
			buttons:[{
				text:'����',
				handler:function(){
					$('#modelForm').form('submit', {
		                url:'${activitiCtx}/workflow/model/create',  
		                onSubmit: function(){  
		                        if($('#modelForm').form('validate')){
		                            loadMask();
		                            $.ajax({
							    		url : '${activitiCtx}/workflow/model/create',
							    		type : 'post',
							    		dataType : 'json',
							    		data:{'name':$('#name').val(),'key':$('#key').val(),'description':$('#description').val()},
							            success:function(data){  
							        	   disLoadMask();
						                    var obj = data;
						                    if(obj.success){  
						                        $.messager.alert('��Ϣ',obj.message);  
						                        $('#flex').datagrid('reload');  
						                        $('#modelForm').form('clear');  
						                    }else{  
						                        $.messager.alert('��Ϣ',obj.message);  
						                    }  
							             }  
							    	});
							    	return false;
							    }else{
							    	return false;  
							    }
		                    }
		              });  
				}
			}]">
	        <form id="modelForm" action="${activitiCtx}/workflow/model/create" class="easyui-form" target="_blank" method="post">
			<table>
				<tr>
					<td>ģ��KEY��</td>
					<td>
						<input id="key" name="key" type="text"  class="easyui-textbox" data-options="required:true,validType:'checkProcessKey'"/>
					</td>
				</tr>
				<tr>
					<td>ģ�����ƣ�</td>
					<td>
						<input id="name" name="name" type="text" class="easyui-textbox" data-options="required:true"/>
					</td>
				</tr>
				<tr>
					<td>������</td>
					<td>
						<textarea id="description" name="description" style="width:300px;height: 50px;"></textarea>
					</td>
				</tr>
			</table>
	        </form>
		</div>
	</div>
	<div id="mainPanle" region="center" split="false" border="false"
		style="background: #eee;">
		<table id="flex" fit="true"></table>
	</div>
	
</body>
</html>