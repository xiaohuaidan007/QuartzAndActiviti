<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/common/global.jsp"%>
    <%@ include file="/common/meta.jsp" %>
    <link rel="stylesheet" href="${ctx }/css/bootstrap.min.css" type="text/css"/>
    <link rel="stylesheet" href="${ctx }/css/bootstrap-responsive.min.css" type="text/css"/>
    <link rel="stylesheet" href="${ctx }/css/style.css" type="text/css"/>

    <script src="${ctx }/js/common/jquery-1.8.3.js" type="text/javascript"></script>
    <script type="text/javascript" src="${ctx }/js/common/bootstrap.min.js"></script>
    <title>定时任务添加</title>
    <script type="text/javascript">
        $(function() {
            $('.edit-user').click(function() {
                var $tr = $('#' + $(this).data('id'));
                $('#userId').val($tr.find('.prop-id').text());
                $('#firstName').val($tr.find('.prop-firstName').text());
                $('#lastName').val($tr.find('.prop-lastName').text());
                $('#email').val($tr.find('.prop-email').text());
            });

            // 组提示
            $('.groups').tooltip();

            // 点击按钮设置用户的组
            $('.set-group').click(function() {
                $('#setGroupsModal input[name=userId]').val($(this).data('userid'));
                $('#setGroupsModal input[name=group]').attr('checked', false);
                var groupIds = $(this).data('groupids').split(',');
                $(groupIds).each(function() {
                    $('#setGroupsModal input[name=group][value=' + this + ']').attr('checked', true);
                });
                $('#setGroupsModal').modal();
            });
        });
    </script>
</head>
<body>
<hr>
<c:if test="${not empty message}">
    <div id="message" class="alert alert-success">${message}</div>
    <!-- 自动隐藏提示信息 -->
    <script type="text/javascript">
        setTimeout(function() {
            $('#message').hide('slow');
        }, 5000);
    </script>
</c:if>
<c:if test="${not empty errorMsg}">
    <div id="messageError" class="alert alert-error">${errorMsg}</div>
    <!-- 自动隐藏提示信息 -->
    <script type="text/javascript">
        setTimeout(function() {
            $('#messageError').hide('slow');
        }, 5000);
    </script>
</c:if>
    <div class="span4">
        <form action="${mvcCtx}/job/modifyTask" class="form-horizontal" method="post">
            <fieldset>
                <legend><small>修改任务</small></legend>
                <div id="messageBox" class="alert alert-error input-large controls" style="display:none">输入有误，请先更正。</div>
                <input type="hidden" id="triggerName" name="triggerName" value="${scheduleJob.triggerName}"/>
                <input type="hidden" id="triggerGroup" name="triggerGroup" value="${scheduleJob.triggerGroup}"/>
                <input type="hidden" id="jobName" name="jobName" value="${scheduleJob.jobName}"/>
                <input type="hidden" id="jobGroup" name="jobGroup" value="${scheduleJob.jobGroup}"/>
                <div class="control-group">
                    <label for="beanName" class="control-label">任务名:</label>
                    <div class="controls">
                        <input type="text" id="beanName" name="beanName" class="required" value="${scheduleJob.beanName}" readonly="readonly"/>
                    </div>
                </div>
                <div class="control-group">
                    <label for="jobGroup" class="control-label">任务组:</label>
                    <div class="controls">
                        <input type="text" id="jobGroup" name="jobGroup" class="required" value="${scheduleJob.jobGroup}" readonly="readonly"/>
                    </div>
                </div>
                <div class="control-group">
                    <label for="jobId" class="control-label">任务ID:</label>
                    <div class="controls">
                        <input type="text" id="jobId" name="jobId" class="required" value="${scheduleJob.jobId}"/>
                    </div>
                </div>
                <div class="control-group">
                    <label for="description" class="control-label">任务描述:</label>
                    <div class="controls">
                        <input type="text" id="description" name="description" class="required" value="${scheduleJob.description}"/>
                    </div>
                </div>
                <div class="control-group">
                    <label for="expression" class="control-label">表达式:</label>
                    <div class="controls">
                        <input type="text" id="expression" name="expression" class="required" value="${scheduleJob.cronExpression}"/>
                    </div>
                </div>
                <div class="control-group">
                    <label for="expression" class="control-label">启动参数:</label>
                    <div class="controls">
                    	<textarea rows="3" cols="1" id="startParam" name="startParam" class="required">${scheduleJob.startParam}</textarea>
                    </div>
                    <label for="expression" class="control-label" style="width:100%">(key=value,多个参数以"&"分割，例如rownum=1000&state=0)</label>
                </div>
                <div class="control-group">
                    <label for="dependency" class="control-label">任务依赖:</label>
                    <div class="controls">
                        <input type="text" id="dependency" name="dependency" class="required" value="${scheduleJob.dependency}"/>
                    </div>
                </div>
                <div class="form-actions">
                    <button type="reset" class="btn"><i class="icon-remove"></i>重置</button>
                    <button type="submit" class="btn btn-primary"><i class="icon-ok-sign"></i>提效</button>
                </div>
            </fieldset>
        </form>
    </div>

</div>
</body>
</html>