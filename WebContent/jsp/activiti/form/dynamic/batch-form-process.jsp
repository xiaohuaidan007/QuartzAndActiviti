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
	<script src="${ctx }/js/module/form/dynamic/dynamic-process-list.js" type="text/javascript"></script>
	<script type="text/javascript" src="${ctx }/js/common/function.js"></script>
    <script type="text/javascript">
    var path="";
	
	$(document).ready(function()
	{
		loadDataGrid();
		
		$('#batchStartFileBtn').click(function(){
			var pdefid = $('#processDefinitionIdHidden').val();
			$('#batchStartForm').form('submit', {
                url:'${activitiCtx }/form/dynamic/batchStart/'+pdefid,  
                onSubmit: function(){  
                        if($('#batchStartForm').form('validate')){
                        	var fileName = $('#batchStartFile').val();
                        	if(validateFile($('#batchStartFile').val(),'txt')){
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
//                         $.messager.alert('消息',obj.message);
						$('#successMessageDiv').html(obj.message);
						$("#batchStartSuccessMsgDialog").dialog("open");
                        $('#batchStartForm').form('clear');  
                    }else{  
                        $.messager.alert('消息',obj.message);  
                    }  
                },
                onClose : function(){
                	$('#successMessageDiv').html('');
                }
              });  
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
// 		frozenColumns : ['process.key'],
		rownumbers : true,
		checkOnSelect : true,
		selectOnCheck : true,
		columns : [ [
		  {field : 'ck',title:"",checkbox:"true"},
		  {field : 'process.key',title : '流程定义KEY',sortable : true,align : 'center'},
		  {field : 'process.name',title : '流程名称',sortable : true,align : 'center'},
		  {field : 'process.version',title : '流程版本号',sortable : true,align : 'center'},
		  {field : 'process.resourceName',title : 'XML',sortable : false,align : 'center',formatter: function(value,row,index){
							return '<a target="_blank" href="${activitiCtx }/workflow/resource/read?processDefinitionId='+row['process.id']+'&resourceType=xml">'+value+'</a>'
						}
			},
		  {field : 'process.diagramResourceName',title : '图片',sortable : false,align : 'center',formatter: function(value,row,index){
				return '<a target="_blank" href="${activitiCtx }/workflow/resource/read?processDefinitionId='+row['process.id']+'&resourceType=image">'+value+'</a>'
			}},
		  {field : 'deployment.deploymentTime',title : '部署时间',sortable : true,align : 'center'},
		  {field : 'process.suspended',title : '是否挂起',sortable : false,align : 'center'}
// 		  {field : 'EDIT_ABLE_',title : '操作',sortable : false,align : 'center',width : '100px',formatter: function(value,row,index){
// 			  return '<a name="startProc" href="#" class="easyui-linkbutton" procid="'+row["process.id"]+'" procname="'+row["process.name"]+'">启动</a> ';
// 		  }}
		] ],
		onSelect : function(index, row){
			var processDefinitionId = row['process.id'];
			var processDefinitionKey = row['process.key'];
			var processDefinitionVersion = row['process.version'];
			var processDefinitionName = row['process.name'];
			$('#processDefinitionIdHidden').val(processDefinitionId);
			$('#processDefSpan').html(processDefinitionKey+":"+processDefinitionName+":"+processDefinitionVersion);
			// 清空对话框内容
			$('#dynamic-form-content').html("<form id='dynamic-form' method='post'><table class='dynamic-form-table'></table></form>");
			// 读取启动时的表单
			$.getJSON(activitiCtx + '/form/dynamic/get-form/start/' + processDefinitionId, function(data) {
				$.each(data.form.formProperties, function() {
					var className = '';var data_options='';
					$('.dynamic-form-table').append(createFieldSimpleHtml(data, this, className, data_options, this.required));
				});
				$('#dowload-templdate').html('<a href="${activitiCtx}/form/dynamic/export/batchtemplate/'+processDefinitionId+'" target="_blank"><font style="font-weight:bold;">下载批量导入模版</font></a>');
			});
			$('#batchStartDiv').show();
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
	<div region="west" hide="true" split="false" collapsible="false"
		title="流程定义" style="width: 50%;" id="west">
		<table id="flex" fit="true"></table>
	</div>
	
	<div id="mainPanle" region="center" split="false" border="false"
		style="background: #eee;">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'north',split:true" style="height:50%">
				<div id="dynamic-form-content" class="easyui-panel" title="启动参数">
				</div>
				<div>
					<div id="dowload-templdate" style="margin-top:20px;margin-left:10px;">
					</div>
				</div>
			</div>
			<div data-options="region:'center'">
				<div id="dynamic-form-batchstart" class="easyui-panel" title="批量启动">
					<div id="batchStartDiv" style="display:none;">
						<form id="batchStartForm" action="${activitiCtx}/workflow/model/create" class="easyui-form" method="post" enctype="multipart/form-data">
							<table>
								<tr>
									<td>流程：<font id="processDefSpan" style="font-weight:bold;"></font></td>
								</tr>
								<tr>
									<td>上传启动文件</td>
								</tr>
								<tr>
									<td><b>支持文件格式：</b>txt</td>
								</tr>
								<tr>
									<td><input type="file" name="file" id="batchStartFile"/></td>
								</tr>
								<tr>
									<td><input type="button" id="batchStartFileBtn" value="导入"/></td>
								</tr>
							</table>
				        </form>
					</div>
					<div style="padding-top:30px;">
						<font style="font-weight:bold;color:red;">操作步骤:</font>
						<br />
						<font style="font-weight:bold;color:red;">1、点击左侧需要启动的流程，注意流程版本号；</font>
						<font style="font-weight:bold;color:red;">2、下载导入模版，并按照要求填充模版数据；</font>
						<font style="font-weight:bold;color:red;">3、上传模版；</font>
					</div>
			        <input type="hidden" id="processDefinitionIdHidden"/>
				</div>
				<div id="batchStartSuccessMsgDialog" class="easyui-dialog" title="消息" style="width:500px;height:400px;"   
			        data-options="resizable:true,modal:true,closed:true,cache:false">   
			    	<div id="successMessageDiv"></div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>