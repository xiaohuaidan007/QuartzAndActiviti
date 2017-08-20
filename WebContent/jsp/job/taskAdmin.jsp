<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<!DOCTYPE html>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html lang="en">
<head>
	<%@ include file="/common/global.jsp"%>
	<title>流程列表</title>
	<%@ include file="/common/meta.jsp" %>
    <%@ include file="/common/include-base-styles.jsp" %>
    <%@ include file="/common/include-jquery-ui-theme.jsp" %>
    <link href="${ctx }/js/common/plugins/jui/extends/timepicker/jquery-ui-timepicker-addon.css" type="text/css" rel="stylesheet" />
    <link href="${ctx }/js/common/plugins/qtip/jquery.qtip.min.css" type="text/css" rel="stylesheet" />
    <%@ include file="/common/include-custom-styles.jsp" %>

    <script src="${ctx }/js/common/jquery-1.8.3.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/plugins/jui/jquery-ui-1.9.2.min.js" type="text/javascript"></script>
	<script src="${ctx }/js/common/plugins/jui/extends/i18n/jquery-ui-date_time-picker-zh-CN.js" type="text/javascript"></script>
	<script src="${ctx }/js/common/plugins/validate/jquery.validate.pack.js" type="text/javascript"></script>
	<script src="${ctx }/js/common/plugins/validate/messages_cn.js" type="text/javascript"></script>
	<script src="${ctx }/js/common/plugins/qtip/jquery.qtip.pack.js" type="text/javascript"></script>
<%-- 	<script src="${ctx }/js/common/common.js" type="text/javascript"></script> --%>
    <script type="text/javascript">
        // 利用动态表单的功能，做一个标示
        var processType = '${empty processType ? param.processType : processType}';
        
        function _alert_start(){
             alert("任务已启动");
        }
        
        function _alert_pause(){
             alert("任务已暂停");
        }
        
        function _alert_resume(){
             alert("任务已恢复");
        }
        
        function _del_confirm(){
            if (!confirm("确认要删除？")) {
            window.event.returnValue = false;
            }
        }
        
    </script>
	<script src="${ctx }/js/module/form/dynamic/dynamic-process-list.js" type="text/javascript"></script>
</head>
<body>
	<c:if test="${not empty message}">
		<div id="message" class="alert alert-success">${message}</div>
		<!-- 自动隐藏提示信息 -->
		<script type="text/javascript">
		setTimeout(function() {
			$('#message').hide('slow');
		}, 5000);
		</script>
	</c:if>
  <table width="100%" class="bordered">
  
    <tr>
				<th>Job Id</th>
				<th>Job Name</th>
				<th>Job Group</th>
				<th>Job Status</th>
				<th>Cron Expression</th>
				<th>Description</th>
				<th>Next Fire Time</th>
				<th>Pre Fire Time</th>
				<th>Bean Name</th>
				<th>Dependency</th>
				<th>启动参数</th>
				<th>暂停</th>
				<th>恢复</th>
				<th>修改</th>
				<th>删除</th>
				<th>启动</th>
	   </tr>
 

    <c:forEach var="scheduleJob" items="${scheduleJobList}">
    <tr>
      <td><c:out value="${scheduleJob.jobId}"/></td>
      <td><c:out value="${scheduleJob.jobName}"/></td>
      <td><c:out value="${scheduleJob.jobGroup}"/></td>
      <td><c:out value="${scheduleJob.jobStatus}"/></td>
      <td><c:out value="${scheduleJob.cronExpression}"/></td>
      <td><c:out value="${scheduleJob.description}"/></td>
      <td><c:out value="${scheduleJob.nextFireTime}"/></td>
      <td><c:out value="${scheduleJob.previousFireTime}"/></td>
      <td><c:out value="${scheduleJob.beanName}"/></td>
      <td><c:out value="${scheduleJob.dependency}"/></td>
      <td><c:out value="${scheduleJob.startParam}"/></td>
      <td><a href="${mvcCtx}/job/pauseTask?triggerName=${scheduleJob.triggerName}&triggerGroup=${scheduleJob.triggerGroup}" onclick="_alert_pause()">暂停</a></td>
      <td><a href="${mvcCtx}/job/resumeTask?triggerName=${scheduleJob.triggerName}&triggerGroup=${scheduleJob.triggerGroup}" onclick="_alert_resume()">恢复</a></td>
      <td><a href="${mvcCtx}/job/updateTask?triggerName=${scheduleJob.triggerName}&triggerGroup=${scheduleJob.triggerGroup}">修改</a></td>
      <td><a href="${mvcCtx}/job/deleteTask?triggerName=${scheduleJob.triggerName}&triggerGroup=${scheduleJob.triggerGroup}" onclick="_del_confirm()">删除</a></td>
      <td><a href="${mvcCtx}/job/triggerTask?jobName=${scheduleJob.jobName}&jobGroup=${scheduleJob.jobGroup}" onclick="_alert_start()">启动</a></td>
    </tr>
    </c:forEach>

  </table>
</body>
<html>