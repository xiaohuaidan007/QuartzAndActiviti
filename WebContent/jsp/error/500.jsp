<%@ page contentType="text/html;charset=GBK" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="org.slf4j.Logger,org.slf4j.LoggerFactory" %>
<%response.setStatus(200);%>

<%
	Throwable ex = null;
	if (exception != null)
		ex = exception;
	if (request.getAttribute("javax.servlet.error.exception") != null)
		ex = (Throwable) request.getAttribute("javax.servlet.error.exception");

	//��¼��־
	Logger logger = LoggerFactory.getLogger("500.jsp");
	logger.error(ex.getMessage(), ex);
%>

<!DOCTYPE html>
<html lang="en">
<head>
	<title>500 - ϵͳ�ڲ�����</title>
</head>

<body>
<div><h1>ϵͳ�����ڲ�����.</h1></div>
<div><a href="<c:url value="/"/>">������ҳ</a></div>
</body>
</html>
