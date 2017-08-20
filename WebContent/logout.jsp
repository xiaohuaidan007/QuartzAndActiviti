<%@ include file="common/include.jsp"%>
<%@ page import="com.paic.tsds.cams.um.web.util.SecurityUtil"%>
<%
	session = request.getSession(true);
	if (session != null) {
		session.removeAttribute("userinformation");
		session.removeAttribute("cams_user_resource");
		session.invalidate();
		Cookie[] cookies = request.getCookies();
		for (int i = 0; cookies != null && i < cookies.length; i++) {
			if ((cookies[i] != null)
					&& (cookies[i].getName()).equals("SMSESSION")) {
				String val = cookies[i].getValue();
				Cookie cookie = new Cookie("SMSESSION", SecurityUtil.outputfilter(val));
				cookie.setDomain(".paic.com.cn");
				cookie.setPath("/");
				cookie.setMaxAge(0);
				response.addCookie(cookie);
			}
			if((cookies[i] != null)
					&& (cookies[i].getName()).equals("PASESSION")){
				Cookie cookie = new Cookie("PASESSION","");
				cookie.setDomain(".paic.com.cn");
				cookie.setPath("/");
				cookie.setMaxAge(0);
				response.addCookie(cookie);
			}

			if((cookies[i] != null)
					&& (cookies[i].getName()).equals("flag")) {
			    Cookie cookie=new Cookie("flag","");
			    cookie.setDomain(".paic.com.cn");     
			    cookie.setPath("/");
			    cookie.setMaxAge(0);
			    response.addCookie(cookie);
			}
		}
	}
%>
<script language="javascript">
	window.top.location.href = "/cams/login.jsp";
</script>
