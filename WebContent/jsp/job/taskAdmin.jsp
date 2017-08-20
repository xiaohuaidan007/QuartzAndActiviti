<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<!DOCTYPE html>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html lang="en">
<head>
	<%@ include file="/common/global.jsp"%>
	<title>�����б�</title>
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
        // ���ö�̬���Ĺ��ܣ���һ����ʾ
        var processType = '${empty processType ? param.processType : processType}';
        
        function _alert_start(){
             alert("����������");
        }
        
        function _alert_pause(){
             alert("��������ͣ");
        }
        
        function _alert_resume(){
             alert("�����ѻָ�");
        }
        
        function _del_confirm(){
            if (!confirm("ȷ��Ҫɾ����")) {
            window.event.returnValue = false;
            }
        }
        
    </script>
	<script src="${ctx }/js/module/form/dynamic/dynamic-process-list.js" type="text/javascript"></script>
</head>
<body>
	<c:if test="${not empty message}">
		<div id="message" class="alert alert-success">${message}</div>
		<!-- �Զ�������ʾ��Ϣ -->
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
				<th>��������</th>
				<th>��ͣ</th>
				<th>�ָ�</th>
				<th>�޸�</th>
				<th>ɾ��</th>
				<th>����</th>
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
      <td><a href="${mvcCtx}/job/pauseTask?triggerName=${scheduleJob.triggerName}&triggerGroup=${scheduleJob.triggerGroup}" onclick="_alert_pause()">��ͣ</a></td>
      <td><a href="${mvcCtx}/job/resumeTask?triggerName=${scheduleJob.triggerName}&triggerGroup=${scheduleJob.triggerGroup}" onclick="_alert_resume()">�ָ�</a></td>
      <td><a href="${mvcCtx}/job/updateTask?triggerName=${scheduleJob.triggerName}&triggerGroup=${scheduleJob.triggerGroup}">�޸�</a></td>
      <td><a href="${mvcCtx}/job/deleteTask?triggerName=${scheduleJob.triggerName}&triggerGroup=${scheduleJob.triggerGroup}" onclick="_del_confirm()">ɾ��</a></td>
      <td><a href="${mvcCtx}/job/triggerTask?jobName=${scheduleJob.jobName}&jobGroup=${scheduleJob.jobGroup}" onclick="_alert_start()">����</a></td>
    </tr>
    </c:forEach>

  </table>
</body>
<html>