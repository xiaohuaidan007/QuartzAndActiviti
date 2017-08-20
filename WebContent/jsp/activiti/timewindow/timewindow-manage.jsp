<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>ʱ�䴰��</title>
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
		
		$("#addTimeWindow").click(function(){
			$("#addTimeWindowDialog").dialog("open");
		});
		
	});
	
	function loadDataGrid(){
		
		$("#flex").datagrid({
		url:activitiCtx+'/bpmn/data/timewindow/list',//���ص�URL
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
		  {field : 'activityId',title : '�ڵ㶨��Id',sortable : false,align : 'center'},
		  {field : 'activityName',title : '�ڵ㶨������',sortable : false,align : 'center'},
		  {field : 'processDefinitionKey',title : '���̶���KEY',sortable : true,align : 'center'},
		  {field : 'processDefName',title : '��������',sortable : true,align : 'center'},
		  {field : 'cronExpression',title : '��ʼ�߽�CRON���ʽ',sortable : true,align : 'center'},
		  {field : 'continuous',title : 'ʱ�䴰�ڳ���ʱ��(��)',sortable : false,align : 'center'},
		  {field : 'isValid',title : '�Ƿ���Ч',sortable : true,align : 'center'},
		  {field : 'timeWindowStart',title : '�´δ��ڿ�ʼʱ��',sortable : false,align : 'center'},
		  {field : 'timeWindowEnd',title : '�´δ��ڽ���ʱ��',sortable : false,align : 'center'},
		  {field : 'dateCreated',title : '����ʱ��',sortable : true,align : 'center'},
		  {field : 'createdBy',title : '������',sortable : true,align : 'center'},
		  {field : 'dateUpdated',title : '����ʱ��',sortable : true,align : 'center'},
		  {field : 'updatedBy',title : '������',sortable : true,align : 'center'},
		  {field : 'EDIT_ABLE_',title : '����',sortable : false,align : 'center',width : '100px',formatter: function(value,row,index){
			  return '<a name="modifyTimeWindow" href="#" class="easyui-linkbutton" rowindex="'+index+'">�޸�</a>&nbsp;&nbsp;'+
			  	'<a name="deleteTimeWindow" href="#" class="easyui-linkbutton" idTableKey="'+row['idTableKey']+'">ɾ��</a>';
		  }}
		] ],
		onLoadSuccess : function(data){
			$('[name="modifyTimeWindow"]').bind('click', function(){
		        var rowindex = $(this).attr("rowindex");
		        var rows = $('#flex').datagrid('getRows');
		        var row = rows[rowindex];
		        $('#m_idTableKey').val(row['idTableKey']);
		        $('#m_isValid').val(row['isValid']);
		        
		        $('#modifyModelForm').form('load',{
		        	m_activityId : row['activityId'],
		        	m_processDefinitionKey : row['processDefinitionKey'],
		        	m_cronExpression : row['cronExpression'],
		        	m_continuous : row['continuous'],
		        	m_isValid : row['isValid'],
		        	m_activityName : row['activityName'],
		        	m_processDefName : row['processDefName'],
		        	language:7
		        });
		        $("#modifyTimeWindowDialog").dialog("open");
		    });    
			$('[name="deleteTimeWindow"]').bind('click', function(){
		        var idTableKey = $(this).attr("idTableKey");
		        $.messager.confirm('Confirm','ȷ��ɾ��?',function(r){
	    		    if (r){
	    		    	loadMask();
		    			$.ajax({
		    	    		url : '${activitiCtx }/timewindow/delete/'+idTableKey,
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
		<form id="searchForm">
		<span>&nbsp;<a id="addTimeWindow" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">����</a></span>
			<span>&nbsp;<a id="btn" href="#" class="easyui-linkbutton" onclick="searchInfo()" data-options="iconCls:'icon-search'">��ѯ</a></span>
			
		</form>
		<form id="confirmForm" action="" method="post"></form>
		<input type="hidden" id="startProcessId"/>
		<div id="dynamic-form-dialog"></div>
		<div id="addTimeWindowDialog" class="easyui-dialog" title="���ʱ�䴰��" style="width:500px;height:400px;"
			data-options="iconCls:'icon-save',
			resizable:true,
			modal:true,
			closed:true,
			cache:false,
			buttons:[{
				text:'����',
				handler:function(){
					$('#addModelForm').form('submit', {
		                url:'${activitiCtx}/timewindow/add',  
		                onSubmit: function(){  
		                        if($('#addModelForm').form('validate')){
		                            loadMask();
		                            var validate = $('#isValid').val();
		                            if(validate==null || validate=='' || validate==undefined){
		                            	$.messager.alert('��Ϣ','�Ƿ���Ч����Ϊ��'); 
		                            	disLoadMask();
		                            	return;
		                            }
		                            $.ajax({
							    		url : '${activitiCtx}/timewindow/add',
							    		type : 'post',
							    		dataType : 'json',
							    		data:{'activityId':$('#activityId').val(),'processDefinitionKey':$('#processDefinitionKey').val(),
							    		'cronExpression':$('#cronExpression').val(),'continuous':$('#continuous').val(),
							    		'isValid':$('#isValid').val(),'activityName':$('#activityName').val(),'processDefName':$('#processDefName').val()},
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
							    	return false;
							    }else{
							    	return false;  
							    }
		                    }
		              });  
				}
			}]">
	        <form id="addModelForm" action="${activitiCtx}/timewindow/add" class="easyui-form" target="_blank" method="post">
			<table>
				<tr>
					<td>�ڵ㶨��ID��</td>
					<td>
						<input id="activityId" name="activityId" type="text"  class="easyui-textbox" data-options="required:true"/>
					</td>
				</tr>
				<tr>
					<td>���̶���KEY��</td>
					<td>
						<input id="processDefinitionKey" name="processDefinitionKey" type="text" class="easyui-textbox" data-options=""/>
					</td>
				</tr>
				<tr>
					<td>��ʼ�߽�CRON���ʽ��</td>
					<td>
						<input id="cronExpression" name="cronExpression" type="text" class="easyui-textbox" data-options="required:true"/>
					</td>
				</tr>
				<tr>
					<td>ʱ�䴰�ڳ���ʱ��(��)��</td>
					<td>
						<input id="continuous" name="continuous" type="text" class="easyui-textbox" data-options="required:true,validType:'integer'"/>
					</td>
				</tr>
				<tr>
					<td>�Ƿ���Ч��</td>
					<td>
						<select id="isValid" name="isValid">
							<option value ="Y" selected="selected">��Ч</option>
							<option value ="N">��Ч</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>�ڵ㶨�����ƣ�</td>
					<td>
						<input id="activityName" name="activityName" type="text" class="easyui-textbox" data-options=""/>
					</td>
				</tr>
				<tr>
					<td>���̶������ƣ�</td>
					<td>
						<input id="processDefName" name="processDefName" type="text" class="easyui-textbox" data-options=""/>
					</td>
				</tr>
			</table>
	        </form>
		</div>
		<div id="modifyTimeWindowDialog" class="easyui-dialog" title="�޸�ʱ�䴰��" style="width:500px;height:400px;"
			data-options="iconCls:'icon-save',
			resizable:true,
			modal:true,
			closed:true,
			cache:false,
			buttons:[{
				text:'����',
				handler:function(){
					$('#modifyModelForm').form('submit', {
		                url:'${activitiCtx}/timewindow/modify',  
		                onSubmit: function(){  
		                        if($('#modifyModelForm').form('validate')){
		                            loadMask();
		                            var validate = $('#m_isValid').val();
		                            if(validate==null || validate=='' || validate==undefined){
		                            	$.messager.alert('��Ϣ','�Ƿ���Ч����Ϊ��'); 
		                            	disLoadMask();
		                            	return;
		                            }
		                            $.ajax({
							    		url : '${activitiCtx}/timewindow/modify',
							    		type : 'post',
							    		dataType : 'json',
							    		data:{'idTableKey':$('#m_idTableKey').val(),'activityId':$('#m_activityId').val(),
							    		'processDefinitionKey':$('#m_processDefinitionKey').val(),'cronExpression':$('#m_cronExpression').val(),
							    		'continuous':$('#m_continuous').val(),'isValid':$('#m_isValid').val(),'activityName':$('#m_activityName').val(),
							    		'processDefName':$('#m_processDefName').val()},
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
							    	return false;
							    }else{
							    	return false;  
							    }
		                    }
		              });  
				}
			}]">
	        <form id="modifyModelForm" action="${activitiCtx}/timewindow/modify" class="easyui-form" target="_blank" method="post">
	        <input type="hidden" id="m_idTableKey" name="m_idTableKey" />
			<table>
				<tr>
					<td>�ڵ㶨��ID��</td>
					<td>
						<input id="m_activityId" name="m_activityId" type="text" value="1111" class="easyui-textbox" data-options="required:true"/>
					</td>
				</tr>
				<tr>
					<td>���̶���KEY��</td>
					<td>
						<input id="m_processDefinitionKey" name="m_processDefinitionKey" type="text" class="easyui-textbox" data-options=""/>
					</td>
				</tr>
				<tr>
					<td>��ʼ�߽�CRON���ʽ��</td>
					<td>
						<input id="m_cronExpression" name="m_cronExpression" type="text" class="easyui-textbox" data-options="required:true"/>
					</td>
				</tr>
				<tr>
					<td>ʱ�䴰�ڳ���ʱ��(��)��</td>
					<td>
						<input id="m_continuous" name="m_continuous" type="text" class="easyui-textbox" data-options="required:true,validType:'integer'"/>
					</td>
				</tr>
				<tr>
					<td>�Ƿ���Ч��</td>
					<td>
						<select id="m_isValid" name="m_isValid">
							<option value ="Y" selected="selected">��Ч</option>
							<option value ="N">��Ч</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>�ڵ㶨�����ƣ�</td>
					<td>
						<input id="m_activityName" name="m_activityName" type="text" class="easyui-textbox" data-options=""/>
					</td>
				</tr>
				<tr>
					<td>���̶������ƣ�</td>
					<td>
						<input id="m_processDefName" name="m_processDefName" type="text" class="easyui-textbox" data-options=""/>
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
	<div region="south" split="false" border="false"
		style="height: 80px; ">
		<div class="footer" style="margin-top:5px;">
			<pre>
 FAQ��
 1�������̶���KEYΪ�գ���ʱ�䴰�����������������ж���IDΪ��дֵ�Ľڵ㣻
 2�������̶���KEY��Ϊ�գ���ʱ�䴰��ֻ�������ڸ������ж���IDΪ��дֵ�Ľڵ㣻
			</pre>
		</div>
	</div>
</body>
</html>