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
	<script type="text/javascript" src="${ctx }/js/common/json2.js"></script>
	<script type="text/javascript" src="${ctx }/js/common/function.js"></script>
    <script type="text/javascript">
    var path="";
	
	$(document).ready(function()
	{
		loadDataGrid();
		
		$("#uploadDeployment").click(function(){
			$("#upload-deployment-dialog").dialog("open");
		});
	});
	
	function loadDataGrid(){
		
		$("#flex").datagrid({
		url:activitiCtx+'/bpmn/data/process-list',//加载的URL
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
		  {field : 'process.id',title : '流程定义Id',sortable : true,align : 'center',width : '150px'},
		  {field : 'process.deploymentId',title : '流程部署Id',sortable : true,align : 'center',width : '150px'},
		  {field : 'process.key',title : '流程定义KEY',sortable : true,align : 'center',width : '150px'},
		  {field : 'process.name',title : '流程名称',sortable : true,align : 'center',width : '150px'},
		  {field : 'process.version',title : '流程版本号',sortable : true,align : 'center',width : '150px'},
		  {field : 'process.resourceName',title : 'XML',sortable : false,align : 'center',width : '150px',formatter: function(value,row,index){
							return '<a target="_blank" href="${activitiCtx }/workflow/resource/read?processDefinitionId='+row['process.id']+'&resourceType=xml">'+value+'</a>'
						}
			},
		  {field : 'process.diagramResourceName',title : '图片',sortable : false,align : 'center',width : '150px',formatter: function(value,row,index){
				return '<a target="_blank" href="${activitiCtx }/workflow/resource/read?processDefinitionId='+row['process.id']+'&resourceType=image">'+value+'</a>'
			}},
		  {field : 'deployment.deploymentTime',title : '部署时间',sortable : true,align : 'center',width : '150px'},
		  {field : 'process.suspended',title : '是否挂起',sortable : true,align : 'center',width : '150px',formatter: function(value,row,index){
// 			  if(value==true){
// 				  return '<span>'+value+'|&nbsp;<a name="activeRel" href="javascript:void(0);" rel="${activitiCtx }/workflow/processdefinition/update/active/'+row['process.id']+'" >[激活]</a></span>'
// 			  }else{
// 				  return '<span>'+value+'|&nbsp;<a name="suspendRel" href="javascript:void(0);" rel="${activitiCtx }/workflow/processdefinition/update/suspend/'+row['process.id']+'">[挂起]</a></span>'
// 			  }

			  if(value==true){
				  return '<span>'+value+'|&nbsp;<a name="activeRel" href="javascript:void(0);" procid="'+row['process.id']+'" >[激活]</a></span>'
			  }else{
				  return '<span>'+value+'|&nbsp;<a name="suspendRel" href="javascript:void(0);" procid="'+row['process.id']+'">[挂起]</a></span>'
			  }
			}},
		  {field : 'EDIT_ABLE_',title : '操作',sortable : false,align : 'center',width : '150px',formatter: function(value,row,index){
// 			  var str = '<span><a name="deleteRel" href="javascript:void(0);" rel="${activitiCtx }/workflow/process/delete?deploymentId='+row['process.deploymentId']+'">[删除]</a>';
// 		      str +='&nbsp;<a name="modelTranRel" href="javascript:void(0);" rel="${activitiCtx }/workflow/process/convert-to-model/'+row['process.id']+'">[转换为Model]</a></span>';
		      
		      var str = '<span><a name="deleteRel" href="javascript:void(0);" deploymentId="'+row['process.deploymentId']+'">[删除]</a>';
		      str +='&nbsp;<a name="modelTranRel" href="javascript:void(0);" procid="'+row['process.id']+'">[转换为Model]</a></span>';
		      return str;
		  }}
		] ],
		onLoadSuccess : function(data){
			$('[name="activeRel"]').click(function() {
				var procid = $(this).attr("procid");
				$.messager.confirm('Confirm','确定激活?',function(r){
				    if (r){
				    	loadMask();
		    			$.ajax({
		    	    		url : '${activitiCtx }/workflow/processdefinition/update/active/'+procid,
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
	    	$('[name="suspendRel"]').click(function() {
	    		var procid = $(this).attr("procid");
	    		$.messager.confirm('Confirm','确定挂起?',function(r){
	    		    if (r){
	    		    	loadMask();
		    			$.ajax({
		    	    		url : '${activitiCtx }/workflow/processdefinition/update/suspend/'+procid,
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
	    	$('[name="deleteRel"]').click(function() {
	    		var deploymentId = $(this).attr("deploymentId");
	    		$.messager.confirm('Confirm','确定删除?',function(r){
	    		    if (r){
	    		    	loadMask();
		    			$.ajax({
		    	    		url : '${activitiCtx }/workflow/process/delete/'+deploymentId,
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
	    	$('[name="modelTranRel"]').click(function() {
	    		var procid = $(this).attr("procid");
	    		$.messager.confirm('Confirm','确定转换?',function(r){
	    		    if (r){
	    		    	loadMask();
		    			$.ajax({
		    	    		url : '${activitiCtx }/workflow/process/convert-to-model/'+procid,
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
	
	function validateFile(fileName,subfix){
		if(fileName.substring(fileName.lastIndexOf(".")+1,fileName.length) !=subfix){
		    alert("请选择zip文件！");
			return false;
		}
		else{
			return true;
		}
	}
    </script>
</head>
<body class="easyui-layout">
	<div id="tb" style="height:auto;height:28px" class="datagrid-toolbar">
		<a id="uploadDeployment" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">上传部署</a>
		<span>&nbsp;<a id="btn" href="#" class="easyui-linkbutton" onclick="searchInfo()" data-options="iconCls:'icon-search'">查询</a></span>
		<form id="confirmForm" action="" method="post"></form>
		<div id="upload-deployment-dialog" class="easyui-dialog" title="部署新流程" style="width:400px;height:200px;"
			data-options="iconCls:'icon-save',
			resizable:true,
			modal:true,
			closed:true,
			cache:false,
			buttons:[{
				text:'提交',
				handler:function(){
					$('#deploymentForm').form('submit', {
		                url:'${activitiCtx }/workflow/deploy',  
		                onSubmit: function(){  
		                        if($('#deploymentForm').form('validate')){
		                        	var fileName = $('#deploymentFile').val();
		                        	if(validateFile($('#deploymentFile').val(),'zip')){
		                        		loadMask();
		                        		return true;
		                        	}else{
		                        		return false;
		                        	}
		                        } 
		                        else{
		                        	return false;  
		                        }
		                    },  
		                success:function(data){
		                	disLoadMask();
		                    var obj = JSON.parse(data);  
		                    if(obj.success){  
		                        $.messager.alert('消息',obj.message);  
		                        $('#flex').datagrid('reload');  
		                        $('#deploymentForm').form('clear');  
		                    }else{  
		                        $.messager.alert('消息',obj.message);  
		                    }  
		                }  
		              });  
				}
			}]">
	        <form id="deploymentForm" action="${activitiCtx}/workflow/model/create" class="easyui-form" method="post" enctype="multipart/form-data">
			<table>
				<tr>
					<td>部署新流程</td>
				</tr>
				<tr>
					<td><b>支持文件格式：</b>zip</td>
				</tr>
				<tr>
					<td><input type="file" name="file" id="deploymentFile"/></td>
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