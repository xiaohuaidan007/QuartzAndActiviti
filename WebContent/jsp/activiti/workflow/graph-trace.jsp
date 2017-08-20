<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="/common/global.jsp"%>
	<title>流程追踪</title>
	<%@ include file="/common/meta.jsp" %>
    <%@ include file="/common/include-base-styles.jsp" %>
    <%@ include file="/common/include-jquery-ui-theme.jsp" %>
    <link href="${ctx }/js/common/plugins/jui/extends/timepicker/jquery-ui-timepicker-addon.css" type="text/css" rel="stylesheet" />
    <link href="${ctx }/js/common/plugins/qtip/jquery.qtip.min.css" type="text/css" rel="stylesheet" />
    <%@ include file="/common/include-custom-styles.jsp" %>

    <script src="${ctx }/js/common/jquery-1.8.3.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/plugins/jui/jquery-ui-1.9.2.min.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/plugins/jui/extends/timepicker/jquery-ui-timepicker-addon.js" type="text/javascript"></script>
	<script src="${ctx }/js/common/plugins/jui/extends/i18n/jquery-ui-date_time-picker-zh-CN.js" type="text/javascript"></script>
	<script src="${ctx }/js/common/plugins/qtip/jquery.qtip.pack.js" type="text/javascript"></script>
	<script src="${ctx }/js/common/plugins/html/jquery.outerhtml.js" type="text/javascript"></script>
	<script type="text/javascript">
	$(function() {
		// 跟踪
// 	    $('.trace').click(graphTrace);
		graphTrace({},$("#pid").val(),$("#pdid").val());
	});
	function graphTrace(options,pid,pdid) {

	    var _defaults = {
	        srcEle: this,
	        eid: $("#eid").val(),
	        pid: $("#pid").val(),
		    pdid: $("#pdid").val()
	    };
	    var opts = $.extend(true, _defaults, options);

	    // 处理使用js跟踪当前节点坐标错乱问题
// 	    $('#changeImg').live('click', function() {
// 	        $('#workflowTraceDialog').dialog('close');
// 	        if ($('#imgDialog').length > 0) {
// 	            $('#imgDialog').remove();
// 	        }
// 	        $('<div/>', {
// 	            'id': 'imgDialog',
// 	            title: '此对话框显示的图片是由引擎自动生成的，并用红色标记当前的节点<button id="diagram-viewer">Diagram-Viewer</button>',
// 	            html: "<img src='" + activitiCtx + '/workflow/process/trace/auto/' + opts.pid + "' />"
// 	        }).appendTo('body').dialog({
// 	            modal: true,
// 	            resizable: false,
// 	            dragable: false,
// 	            width: document.documentElement.clientWidth * 0.99,
// 	            height: document.documentElement.clientHeight * 0.99
// 	        });
// 	    });

		/*
		用官方开发的Diagram-Viewer跟踪
		 */
		$('#diagram-viewer').live('click', function() {
			$('#workflowTraceDialog').dialog('close');

			if ($('#imgDialog').length > 0) {
				$('#imgDialog').remove();
			}

			var url = ctx + '/diagram-viewer/index.html?processDefinitionId=' + opts.pdid + '&processInstanceId=' + opts.pid;

			$('<div/>', {
				'id': 'imgDialog',
				title: '此对话框显示的图片是由引擎自动生成的，并用红色标记当前的节点',
				html: '<iframe src="' + url + '" width="100%" height="' + document.documentElement.clientHeight * 0.90 + '" />'
			}).appendTo('body').dialog({
				modal: true,
				resizable: false,
				dragable: false,
				width: document.documentElement.clientWidth * 0.99,
				height: document.documentElement.clientHeight * 0.99
			});
		});

	    // 获取图片资源
	    var imageUrl = '';
	    if($('#diagramType').val()=='1'){
	    	//简易版流程追踪图
	    	imageUrl = activitiCtx + "/workflow/resource/process-instance?pdid=" + opts.pdid + "&type=image";
	    }else{
	    	//高亮追踪流程图
	    	imageUrl = activitiCtx + "/workflow/resource/instanceDiagram/" + opts.pdid + "/"+opts.pid;
	    }
	    var jsonUrl = '';
	    var state = $('#state').val();
	    if(state=='00'){
	    	jsonUrl = activitiCtx + '/workflow/process/trace?eid=' + opts.eid +'&pid='+opts.pid;
	    }else if(state=='11'){
	    	jsonUrl = activitiCtx + '/workflow/process/trace/end?pid=' + opts.pid;
	    }
	    $.getJSON(jsonUrl, function(infos) {

	        var positionHtml = "";

	        // 生成图片
	        var varsArray = new Array();
	        $.each(infos, function(i, v) {
	            var $positionDiv = $('<div/>', {
	                'class': 'activity-attr'
	            }).css({
	                position: 'absolute',
	                left: (v.x - 1),
	                top: (v.y - 1),
	                width: (v.width - 2),
	                height: (v.height - 2),
	                backgroundColor: 'black',
	                opacity: 0,
	                zIndex: $.fn.qtip.zindex - 1
	            });

	            // 节点边框
	            var $border = $('<div/>', {
	                'class': 'activity-attr-border'
	            }).css({
	                position: 'absolute',
	                left: (v.x - 1),
	                top: (v.y - 1),
	                width: (v.width - 4),
	                height: (v.height - 3),
	                zIndex: $.fn.qtip.zindex - 2
	            });
				
	            if(v.historyActiviti){
	            	$border.addClass('ui-corner-all-12').css({
	                    border: '3px solid blue'
	                });
	            }
	            if (v.currentActiviti) {
	                $border.addClass('ui-corner-all-12').css({
	                    border: '3px solid red'
	                });
	            }
	            positionHtml += $positionDiv.outerHTML() + $border.outerHTML();
	            varsArray[varsArray.length] = v.vars;
	        });
	        
	        if ($('#workflowTraceDialog').length == 0) {
	            $('<div/>', {
	                id: 'workflowTraceDialog',
	                title: '查看流程（按ESC键可以关闭）<button id="changeImg">如果坐标错乱请点击这里</button><button id="diagram-viewer">Diagram-Viewer</button>',
	                html: "<div><img src='" + imageUrl + "' style='position:absolute; left:0px; top:0px;' />" +
	                "<div id='processImageBorder'>" +
	                positionHtml +
	                "</div>" +
	                "</div>"
	            }).appendTo('body');
	        } else {
	            $('#workflowTraceDialog img').attr('src', imageUrl);
	            $('#workflowTraceDialog #processImageBorder').html(positionHtml);
	        }

	        // 设置每个节点的data
	        $('#workflowTraceDialog .activity-attr').each(function(i, v) {
	            $(this).data('vars', varsArray[i]);
	        });

	        // 打开对话框
	        $('#workflowTraceDialog').dialog({
	            modal: true,
	            resizable: false,
	            dragable: false,
	            open: function() {
	            	var title = '';
	            	if($('#diagramType').val()=='1'){
	            		title = '[简易版流程图-<button id="instanceDiagramBtn">点击查看高亮追踪版流程图</button>]业务主键:'+$('#bsk').val()+' 流程定义ID:'+$('#pdid').val();
	            	}else{
	            		title = '[高亮追踪版流程图-<button id="simpleDiagramBtn">点击查看简易版流程图</button>]业务主键:'+$('#bsk').val()+' 流程定义ID:'+$('#pdid').val();
	            	}
	                $('#workflowTraceDialog').dialog('option', 'title', title);
	                $('#workflowTraceDialog').css('padding', '0.2em');
	                $('#workflowTraceDialog .ui-accordion-content').css('padding', '0.2em').height($('#workflowTraceDialog').height() - 75);

	                // 此处用于显示每个节点的信息，如果不需要可以删除
	                $('.activity-attr').qtip({
	                    content: function() {
	                        var vars = $(this).data('vars');
	                        var tipContent = "<table class='need-border'>";
	                        $.each(vars, function(varKey, varValue) {
	                            if (varValue) {
	                                tipContent += "<tr><td class='label'>" + varKey + "</td><td>" + varValue + "<td/></tr>";
	                            }
	                        });
	                        tipContent += "</table>";
	                        return tipContent;
	                    },
	                    position: {
	                        at: 'bottom left',
	                        adjust: {
	                            x: 3
	                        }
	                    }
	                });
	                // end qtip
	            },
	            close: function() {
	                $('#workflowTraceDialog').remove();
	            },
	            width: document.documentElement.clientWidth * 0.99,
	            height: document.documentElement.clientHeight * 0.99
	        });
			
	        $('#instanceDiagramBtn').click(function(){
	        	window.location.href = '${activitiCtx}/workflow/graphtrace/view/'+$('#eid').val()+'/'+$('#pid').val()+'/'+$('#pdid').val()+'/'+$('#bsk').val()+'/'+$('#state').val()+'/2';
	        });
	        
	        $('#simpleDiagramBtn').click(function(){
	        	window.location.href = '${activitiCtx}/workflow/graphtrace/view/'+$('#eid').val()+'/'+$('#pid').val()+'/'+$('#pdid').val()+'/'+$('#bsk').val()+'/'+$('#state').val()+'/1';
	        });
	        
	    });
	}
	</script>
</head>

<body>
	<div>
		<input type="hidden" id="eid" value="${eid}"/>
		<input type="hidden" id="pid" value="${pid}"/>
		<input type="hidden" id="pdid" value="${pdid}"/>
		<input type="hidden" id="bsk" value="${bsk}"/>
		<input type="hidden" id="state" value="${state}"/>
		<input type="hidden" id="diagramType" value="${diagramType}"/>
	</div>
	<!-- 办理任务对话框 -->
	<div id="handleTemplate" class="template"></div>

</body>
</html>