<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="/common/global.jsp"%>
	<title>����׷��</title>
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
		// ����
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

	    // ����ʹ��js���ٵ�ǰ�ڵ������������
// 	    $('#changeImg').live('click', function() {
// 	        $('#workflowTraceDialog').dialog('close');
// 	        if ($('#imgDialog').length > 0) {
// 	            $('#imgDialog').remove();
// 	        }
// 	        $('<div/>', {
// 	            'id': 'imgDialog',
// 	            title: '�˶Ի�����ʾ��ͼƬ���������Զ����ɵģ����ú�ɫ��ǵ�ǰ�Ľڵ�<button id="diagram-viewer">Diagram-Viewer</button>',
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
		�ùٷ�������Diagram-Viewer����
		 */
		$('#diagram-viewer').live('click', function() {
			$('#workflowTraceDialog').dialog('close');

			if ($('#imgDialog').length > 0) {
				$('#imgDialog').remove();
			}

			var url = ctx + '/diagram-viewer/index.html?processDefinitionId=' + opts.pdid + '&processInstanceId=' + opts.pid;

			$('<div/>', {
				'id': 'imgDialog',
				title: '�˶Ի�����ʾ��ͼƬ���������Զ����ɵģ����ú�ɫ��ǵ�ǰ�Ľڵ�',
				html: '<iframe src="' + url + '" width="100%" height="' + document.documentElement.clientHeight * 0.90 + '" />'
			}).appendTo('body').dialog({
				modal: true,
				resizable: false,
				dragable: false,
				width: document.documentElement.clientWidth * 0.99,
				height: document.documentElement.clientHeight * 0.99
			});
		});

	    // ��ȡͼƬ��Դ
	    var imageUrl = '';
	    if($('#diagramType').val()=='1'){
	    	//���װ�����׷��ͼ
	    	imageUrl = activitiCtx + "/workflow/resource/process-instance?pdid=" + opts.pdid + "&type=image";
	    }else{
	    	//����׷������ͼ
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

	        // ����ͼƬ
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

	            // �ڵ�߿�
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
	                title: '�鿴���̣���ESC�����Թرգ�<button id="changeImg">������������������</button><button id="diagram-viewer">Diagram-Viewer</button>',
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

	        // ����ÿ���ڵ��data
	        $('#workflowTraceDialog .activity-attr').each(function(i, v) {
	            $(this).data('vars', varsArray[i]);
	        });

	        // �򿪶Ի���
	        $('#workflowTraceDialog').dialog({
	            modal: true,
	            resizable: false,
	            dragable: false,
	            open: function() {
	            	var title = '';
	            	if($('#diagramType').val()=='1'){
	            		title = '[���װ�����ͼ-<button id="instanceDiagramBtn">����鿴����׷�ٰ�����ͼ</button>]ҵ������:'+$('#bsk').val()+' ���̶���ID:'+$('#pdid').val();
	            	}else{
	            		title = '[����׷�ٰ�����ͼ-<button id="simpleDiagramBtn">����鿴���װ�����ͼ</button>]ҵ������:'+$('#bsk').val()+' ���̶���ID:'+$('#pdid').val();
	            	}
	                $('#workflowTraceDialog').dialog('option', 'title', title);
	                $('#workflowTraceDialog').css('padding', '0.2em');
	                $('#workflowTraceDialog .ui-accordion-content').css('padding', '0.2em').height($('#workflowTraceDialog').height() - 75);

	                // �˴�������ʾÿ���ڵ����Ϣ���������Ҫ����ɾ��
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
	<!-- ��������Ի��� -->
	<div id="handleTemplate" class="template"></div>

</body>
</html>