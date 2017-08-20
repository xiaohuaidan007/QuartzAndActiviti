function graphTrace(options) {

    var _defaults = {
        srcEle: this,
        pid: $(this).attr('pid'),
	    pdid: $(this).attr('pdid')
    };
    var opts = $.extend(true, _defaults, options);

    // ����ʹ��js���ٵ�ǰ�ڵ������������
    $('#changeImg').live('click', function() {
        $('#workflowTraceDialog').dialog('close');
        if ($('#imgDialog').length > 0) {
            $('#imgDialog').remove();
        }
        $('<div/>', {
            'id': 'imgDialog',
            title: '�˶Ի�����ʾ��ͼƬ���������Զ����ɵģ����ú�ɫ��ǵ�ǰ�Ľڵ�<button id="diagram-viewer">Diagram-Viewer</button>',
            html: "<img src='" + activitiCtx + '/workflow/process/trace/auto/' + opts.pid + "' />"
        }).appendTo('body').dialog({
            modal: true,
            resizable: false,
            dragable: false,
            width: document.documentElement.clientWidth * 0.95,
            height: document.documentElement.clientHeight * 0.95
        });
    });

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
			width: document.documentElement.clientWidth * 0.95,
			height: document.documentElement.clientHeight * 0.95
		});
	});

    // ��ȡͼƬ��Դ
    var imageUrl = activitiCtx + "/workflow/resource/process-instance?pid=" + opts.pid + "&type=image";
    $.getJSON(activitiCtx + '/workflow/process/trace?pid=' + opts.pid, function(infos) {

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
                $('#workflowTraceDialog').dialog('option', 'title', '�鿴���̣���ESC�����Թرգ�<button id="changeImg">������������������</button><button id="diagram-viewer">Diagram-Viewer</button>');
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
            width: document.documentElement.clientWidth * 0.95,
            height: document.documentElement.clientHeight * 0.95
        });

    });
}
