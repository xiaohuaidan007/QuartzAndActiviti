<%@ page contentType="text/html; charset=GBK"%>
<html>
<head><title>Exception!</title></head>
<body>
<% Exception e = (Exception)request.getAttribute("ex"); %>
<H2>����: <%= e.getClass().getSimpleName()%></H2>
<hr />
<P>����������</P>
<%= e.getMessage()%>
<P>������Ϣ��</P>
<% e.printStackTrace(new java.io.PrintWriter(out)); %>
</body>
</html>