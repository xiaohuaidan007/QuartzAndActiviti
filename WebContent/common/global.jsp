<%@ page contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="java.util.*,org.apache.commons.lang3.StringUtils,org.apache.commons.lang3.ObjectUtils" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="activitiCtx" value="${pageContext.request.contextPath}/view/activiti"/>
<c:set var="mvcCtx" value="${pageContext.request.contextPath}"/>
<c:set var="loginCtx" value="${pageContext.request.contextPath}"/>

<script type="text/javascript">
	var ctx = '<%=request.getContextPath() %>';
	var activitiCtx = '<%=request.getContextPath() %>/view/activiti';
	var mvcCtx = '<%=request.getContextPath() %>/view';
	var path = '<%=request.getContextPath() %>';
</script>