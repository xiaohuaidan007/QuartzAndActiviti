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
				<th>描述</th>
				<th>启动参数</th>
	   </tr>
 

    <c:forEach var="scheduleJob" items="${scheduleJobList}">
    <tr>
      <td><c:out value="${scheduleJob.jobId}"/></td>
      <td><c:out value="${scheduleJob.jobName}"/></td>
      <td><c:out value="${scheduleJob.jobGroup}"/></td>
      <td><c:out value="${scheduleJob.beanName}"/></td>
      <td><c:out value="${scheduleJob.jobStatus}"/></td>
      <td><c:out value="${scheduleJob.description}"/></td>
      <td><c:out value="${scheduleJob.startParam}"/></td>
    </tr>
    </c:forEach>

  </table>
</body>
<html>