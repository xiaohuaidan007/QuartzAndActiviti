<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page import="com.paic.loanplus.creditcard.base.util.prop.PropertyFactory"%>
<%
	String UMLoginURL = null;
	String basePath =null;
	String path=null;
	try {
	  path = request.getContextPath();
  		basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
		UMLoginURL = PropertyFactory.getFactory().getPropertyUtil(
				"context-loanplus-cc.properties").getProperty("um.UMLoginURL");
	} catch (Exception e) {
		e.printStackTrace();
		out.println(e.getMessage());
		System.out.println(e.getMessage());
	}
%>
<%@ include file="/common/global.jsp"%>
<meta http-equiv="Cache-Control" content="no-store"/>
<meta http-equiv="Pragma" content="no-cache"/>
<meta http-equiv="Expires" content="0"/>
<script id="script_umlogin" language="javascript" ssl="off" sso="off"
	src="<%=path%>/umlogin/login.js" umbaseurl="<%=UMLoginURL%>" portno="443"
	title="平安银行零售融资平台"></script>