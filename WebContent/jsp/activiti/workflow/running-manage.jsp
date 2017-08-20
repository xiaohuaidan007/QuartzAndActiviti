<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>�����б�</title>
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
	* EasyUI DataGrid�����ֶζ�̬�ϲ���Ԫ��
	* ���� tableID Ҫ�ϲ�table��id
	* ���� colList Ҫ�ϲ�����,�ö��ŷָ�(���磺"name,department,office");
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
	                    field: ColArray[j],����//�ϲ��ֶ�
	                    rowspan: tmpA,
	                    colspan: null
	                });
	                tTable.datagrid("mergeCells", { //����ColArray[j]���кϲ�
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
//         	    title: '����׷��',
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
        	    title: '��ҵ����',
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
		url:activitiCtx+'/bpmn/data/execution-list',//���ص�URL
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
 		queryParams:{'processBusinessKey':$("#processBusinessKey").val(),'processDefinitionKey':$("#processDefinitionKey").val(),
 						'processDefinitionVersion':$("#processDefinitionVersion").val(),'exception':serchExceptionVal()},
		//singleSelect : true,
		pageSize : 20,//ÿҳ��ʾ�ļ�¼������Ĭ��Ϊ20 
	    pageList : [10,20,50,100],//��������ÿҳ��¼�������б� 
		toolbar:'#tb',
		singleSelect : true,
		columns : [ [ 
		  {field : 'processInstanceId',title : '����ʵ��ID',sortable : true,align : 'center',width : '150px'},
		  {field : 'processDefinitionKey',title : '���̶���KEY',sortable : true,align : 'center'},
		  {field : 'processDefinitionName',title : '���̶�������',sortable : true,align : 'center',width : '150px'},
		  {field : 'processDefinitionVersion',title : '���̶���汾',sortable : true,align : 'center'},
		  {field : 'processBusinessKey',title : 'ҵ������',sortable : true,align : 'center'},
// 		  {field : 'id',title : '����/��ִ֧��ʵ��ID',sortable : true,align : 'center',width : '150px'},
		  {field : 'superExecutionId',title : '��ִ��ʵ��ID',sortable : true,align : 'center'},
// 		  {field : 'startingExecution',title : '�����ڵ�',sortable : false,align : 'center',width : '150px'},
// 		  {field : 'suspensionState',title : '�����־',sortable : false,align : 'center',width : '150px'},
		  {field : 'currentActivityId',title : '��ǰ�ڵ�ID',sortable : true,align : 'center',width : '150px'},
		  {field : 'currentActivityName',title : '��ǰ�ڵ�����',sortable : false,align : 'center',width : '150px',formatter: function(value,row,index){
// 				return '<a class="trace" href="javascript:void(0);" eid="'+row['realActiveExecutionId']+'" pid="'+row['processInstanceId']+'" pdid="'+row['processDefinitionId']+'" bsk="'+row['processBusinessKey']+'" title="����鿴����׷��ͼ">'+value+'</a>';
			  return '<a class="trace" target="_blank" href="${activitiCtx}/workflow/graphtrace/view/'+row['realActiveExecutionId']+'/'+row['processInstanceId']+'/'+row['processDefinitionId']+'/'+row['processBusinessKey']+'/00/1" title="����鿴����׷��ͼ">'+value+'</a>';
		  }},
		  {field : 'startTime',title : '����ʱ��',sortable : true,align : 'center'},
		  {field : 'startUserId',title : '�����û�',sortable : false,align : 'center'}
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
		onExpandRow:function(index,row){//ע��3
            $('#ddv-'+index).datagrid({
            	title:'����/��ִ֧��ʵ��',
				data:row.executions,
                fitColumns:true,
                singleSelect:true,
                height:'auto',
                columns:[[
                    {field:'id',title:'ִ��ʵ��ID'},
                    {field:'currentActivityId',title:'��ǰ�ڵ�ID',width:150},
                    {field:'currentActivityName',title:'��ǰ�ڵ�����',width:150,formatter: function(value,row,index){
// 						return '<a class="trace" href="javascript:void(0);" eid="'+row['id']+'" pid="'+row['processInstanceId']+'" pdid="'+row['processDefinitionId']+'" bsk="'+row['processBusinessKey']+'" title="����鿴����׷��ͼ">'+value+'</a>'
                    	return '<a class="trace" target="_blank" href="${activitiCtx}/workflow/graphtrace/view/'+row['id']+'/'+row['processInstanceId']+'/'+row['processDefinitionId']+'/'+row['processBusinessKey']+'/00/1" title="����鿴����׷��ͼ">'+value+'</a>';
                    }},
					{field:'active',title:'�Ƿ���'},
                    {field:'suspensionState',title:'�Ƿ����',formatter: function(value,row,index){
						if(value==1){
							return '����';
						}else{
							return '����';
						}
					}},
                    {field:'parentId',title:'��ִ��ʵ��ID',width:150},
                    {field:'lockTime',title:'����ʱ��',width:150,align:'center'},
                    {field:'revision',title:'�汾��',width:150},
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
            	title:'���̱���',
				data:row.variables,
                fitColumns:true,
                singleSelect:true,
                height:'auto',
                columns:[[
                    {field:'name',title:'���̱���',sortable : true},
                    {field:'value',title:'����ֵ',sortable : true,width:150},
                    {field:'type',title:'��������',sortable : true,width:150},
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
            $('#ddv3-'+index).datagrid({
            	title:'�ڵ���ҵ',
				data:row.jobs,
                fitColumns:true,
                singleSelect:true,
                height:'auto',
                columns:[[
                    {field:'id',title:'��ҵID',formatter: function(value,row,index){
        				return '<a class="jobManage" href="javascript:void(0);" jobid="'+value+'" title="���������ҵ">'+value+'</a>';
        			}},
        			{field:'name',title:'�ڵ�����',width:150},
                    {field:'lockExpirationTime',title:'��������ʱ��'},
                    {field:'duedate',title:'����ʱ��'},
                    {field:'retries',title:'ʣ�����Դ���'},
                    {field:'lockOwner',title:'������'},
                    {field:'jobType',title:'��ҵ����'},
                    {field:'exceptionMessage',title:'�쳣��Ϣ'},
                    {field:'revision',title:'�汾'},
                    {field:'jobHandlerType',title:'��ҵ��������'}
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
			<span>ҵ��������</span>
			<span><input type="text" id="processBusinessKey" value="" class="easyui-textbox" style="width: 100px;"></span>
			&nbsp;<span>���̶���KEY��</span>
			<span><input type="text" id="processDefinitionKey" value="" class="easyui-textbox" style="width: 100px;"/></span>
			&nbsp;<span>���̶���汾��</span>
			<span><input type="text" id="processDefinitionVersion" value="" class="easyui-textbox" style="width: 100px;"/></span>
			&nbsp;
			<span><input type="checkbox" name="exception" value="1"/>����ѯ�쳣����</span>
			<span><a id="btn" href="#" class="easyui-linkbutton" onclick="searchInfo()" data-options="iconCls:'icon-search'">��ѯ</a></span>
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