<%@ page contentType="text/html; charset=GBK"%>
<html>
<head><title>Exception!</title></head>
<body>
<% Exception e = (Exception)request.getAttribute("ex"); %>
<H2>´íÎó: <%= e.getClass().getSimpleName()%></H2>
<hr />
<P>´íÎóÃèÊö£º</P>
<%= e.getMessage()%>
<P>´íÎóÐÅÏ¢£º</P>
<% e.printStackTrace(new java.io.PrintWriter(out)); %>
</body>
</html>