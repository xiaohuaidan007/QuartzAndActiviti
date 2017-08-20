<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>时间窗口</title>
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
		url:activitiCtx+'/bpmn/data/timewindow/list',//加载的URL
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
// 		queryParams:paramToJSON($("#searchForm").formToArray()),
		//singleSelect : true,
// 		pageSize : 20,//每页显示的记录条数，默认为20 
// 	    pageList : [10,20,50,100],//可以设置每页记录条数的列表 
		pagination : false,
		toolbar:'#tb',
		singleSelect : true,
		columns : [ [ 
		  {field : 'activityId',title : '节点定义Id',sortable : false,align : 'center'},
		  {field : 'activityName',title : '节点定义名称',sortable : false,align : 'center'},
		  {field : 'processDefinitionKey',title : '流程定义KEY',sortable : true,align : 'center'},
		  {field : 'processDefName',title : '流程名称',sortable : true,align : 'center'},
		  {field : 'cronExpression',title : '开始边界CRON表达式',sortable : true,align : 'center'},
		  {field : 'continuous',title : '时间窗口持续时间(秒)',sortable : false,align : 'center'},
		  {field : 'isValid',title : '是否有效',sortable : true,align : 'center'},
		  {field : 'timeWindowStart',title : '下次窗口开始时间',sortable : false,align : 'center'},
		  {field : 'timeWindowEnd',title : '下次窗口结束时间',sortable : false,align : 'center'},
		  {field : 'dateCreated',title : '创建时间',sortable : true,align : 'center'},
		  {field : 'createdBy',title : '创建人',sortable : true,align : 'center'},
		  {field : 'dateUpdated',title : '更新时间',sortable : true,align : 'center'},
		  {field : 'updatedBy',title : '更新人',sortable : true,align : 'center'},
		  {field : 'EDIT_ABLE_',title : '操作',sortable : false,align : 'center',width : '100px',formatter: function(value,row,index){
			  return '<a name="modifyTimeWindow" href="#" class="easyui-linkbutton" rowindex="'+index+'">修改</a>&nbsp;&nbsp;'+
			  	'<a name="deleteTimeWindow" href="#" class="easyui-linkbutton" idTableKey="'+row['idTableKey']+'">删除</a>';
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
		        $.messager.confirm('Confirm','确定删除?',function(r){
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
	}
	
	function searchInfo(){
		$('#flex').datagrid('load',{});
	}
    </script>
</head>
<body class="easyui-layout">
	<div id="tb" style="height:auto;height:28px" class="datagrid-toolbar">
		<form id="searchForm">
		<span>&nbsp;<a id="addTimeWindow" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">新增</a></span>
			<span>&nbsp;<a id="btn" href="#" class="easyui-linkbutton" onclick="searchInfo()" data-options="iconCls:'icon-search'">查询</a></span>
			
		</form>
		<form id="confirmForm" action="" method="post"></form>
		<input type="hidden" id="startProcessId"/>
		<div id="dynamic-form-dialog"></div>
		<div id="addTimeWindowDialog" class="easyui-dialog" title="添加时间窗口" style="width:500px;height:400px;"
			data-options="iconCls:'icon-save',
			resizable:true,
			modal:true,
			closed:true,
			cache:false,
			buttons:[{
				text:'保存',
				handler:function(){
					$('#addModelForm').form('submit', {
		                url:'${activitiCtx}/timewindow/add',  
		                onSubmit: function(){  
		                        if($('#addModelForm').form('validate')){
		                            loadMask();
		                            var validate = $('#isValid').val();
		                            if(validate==null || validate=='' || validate==undefined){
		                            	$.messager.alert('消息','是否有效不能为空'); 
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
						                        $.messager.alert('消息',obj.message);  
						                        $('#flex').datagrid('reload');
						                    }else{  
						                        $.messager.alert('消息',obj.message);  
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
					<td>节点定义ID：</td>
					<td>
						<input id="activityId" name="activityId" type="text"  class="easyui-textbox" data-options="required:true"/>
					</td>
				</tr>
				<tr>
					<td>流程定义KEY：</td>
					<td>
						<input id="processDefinitionKey" name="processDefinitionKey" type="text" class="easyui-textbox" data-options=""/>
					</td>
				</tr>
				<tr>
					<td>开始边界CRON表达式：</td>
					<td>
						<input id="cronExpression" name="cronExpression" type="text" class="easyui-textbox" data-options="required:true"/>
					</td>
				</tr>
				<tr>
					<td>时间窗口持续时间(秒)：</td>
					<td>
						<input id="continuous" name="continuous" type="text" class="easyui-textbox" data-options="required:true,validType:'integer'"/>
					</td>
				</tr>
				<tr>
					<td>是否有效：</td>
					<td>
						<select id="isValid" name="isValid">
							<option value ="Y" selected="selected">有效</option>
							<option value ="N">无效</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>节点定义名称：</td>
					<td>
						<input id="activityName" name="activityName" type="text" class="easyui-textbox" data-options=""/>
					</td>
				</tr>
				<tr>
					<td>流程定义名称：</td>
					<td>
						<input id="processDefName" name="processDefName" type="text" class="easyui-textbox" data-options=""/>
					</td>
				</tr>
			</table>
	        </form>
		</div>
		<div id="modifyTimeWindowDialog" class="easyui-dialog" title="修改时间窗口" style="width:500px;height:400px;"
			data-options="iconCls:'icon-save',
			resizable:true,
			modal:true,
			closed:true,
			cache:false,
			buttons:[{
				text:'保存',
				handler:function(){
					$('#modifyModelForm').form('submit', {
		                url:'${activitiCtx}/timewindow/modify',  
		                onSubmit: function(){  
		                        if($('#modifyModelForm').form('validate')){
		                            loadMask();
		                            var validate = $('#m_isValid').val();
		                            if(validate==null || validate=='' || validate==undefined){
		                            	$.messager.alert('消息','是否有效不能为空'); 
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
						                        $.messager.alert('消息',obj.message);  
						                        $('#flex').datagrid('reload');
						                    }else{  
						                        $.messager.alert('消息',obj.message);  
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
					<td>节点定义ID：</td>
					<td>
						<input id="m_activityId" name="m_activityId" type="text" value="1111" class="easyui-textbox" data-options="required:true"/>
					</td>
				</tr>
				<tr>
					<td>流程定义KEY：</td>
					<td>
						<input id="m_processDefinitionKey" name="m_processDefinitionKey" type="text" class="easyui-textbox" data-options=""/>
					</td>
				</tr>
				<tr>
					<td>开始边界CRON表达式：</td>
					<td>
						<input id="m_cronExpression" name="m_cronExpression" type="text" class="easyui-textbox" data-options="required:true"/>
					</td>
				</tr>
				<tr>
					<td>时间窗口持续时间(秒)：</td>
					<td>
						<input id="m_continuous" name="m_continuous" type="text" class="easyui-textbox" data-options="required:true,validType:'integer'"/>
					</td>
				</tr>
				<tr>
					<td>是否有效：</td>
					<td>
						<select id="m_isValid" name="m_isValid">
							<option value ="Y" selected="selected">有效</option>
							<option value ="N">无效</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>节点定义名称：</td>
					<td>
						<input id="m_activityName" name="m_activityName" type="text" class="easyui-textbox" data-options=""/>
					</td>
				</tr>
				<tr>
					<td>流程定义名称：</td>
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
 FAQ：
 1、若流程定义KEY为空，则时间窗口作用于任意流程中定义ID为填写值的节点；
 2、若流程定义KEY不为空，则时间窗口只会作用于该流程中定义ID为填写值的节点；
			</pre>
		</div>
	</div>
</body>
</html>