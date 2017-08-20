<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/common/global.jsp"%>
<%@ include file="/common/meta.jsp"%>
<title>LOANPLUS-CC|������ƽ̨</title>
<%@ include file="/common/include-jquery-ui-theme.jsp"%>
<script type="text/javascript" src="${ctx }/js/common/function.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx }/js/jeasyui/themes/bootstrap/easyui.css">
<link rel="stylesheet" type="text/css" href="${ctx }/js/jeasyui/themes/icon.css">
<script type="text/javascript" src="${ctx }/js/jeasyui/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/js/jeasyui/jquery.easyui.min.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx }/css/home.css">
<script type="text/javascript" src="${ctx }/js/common/home.js"></script>
<script type="text/javascript">
</script>
</head>

<body class="easyui-layout">

	<div region="north" split="false" border="false"
		style="overflow: hidden; height: 45px; background: no-repeat #2985d2 left 50%; line-height: 20px; color: #fff; font-family: Verdana, ΢���ź�, ����">
		<span style="float: right; padding-right: 20px;padding-top:15px;" class="head">
			��ӭ:&nbsp; &nbsp;&nbsp; <%= session.getAttribute("CURRENT_USER_ID") %>
			&nbsp;&nbsp; <!-- <a href="/j_spring_cas_security_logout" id="loginOut">��ȫ�˳�</a> -->
			<a href="#" onclick="logout()" id="loginOut">��ȫ�˳�</a>
			<input type="hidden" id="juserid" value="<%= session.getAttribute("CURRENT_USER_ID") %>"/>
		</span> <span
			style="padding-left: 5px; font-size: 22px; height: 97px; line-height: 48px; margin-left: 30px;">LOANPLUS-CC | ������ƽ̨</span>
	</div>

	<div region="south" split="false" border="false"
		style="height: 30px; background: #fff6ef;">
		<div class="footer" style="margin-top:5px;">��Ȩ���� @ 2016 �й�ƽ�����йɷ����޹�˾</div>
	</div>

	<div region="west" hide="true" split="false" collapsible="false"
		title="�����˵�" style="width: 180px;" id="west">
		<div id="nav" class="easyui-accordion" fit="true" border="false">
		</div>
	</div>

	<div id="mainPanle" region="center" split="false" border="false"
		style="background: #eee;">
		<div id="tabs" class="easyui-tabs" fit="true" border="false">
			<div title="��ҳ" style="padding: 50px;">
				<jsp:include page="/jsp/main/manage/faq.html"/>
			</div>
		</div>
	</div>
	<input id="userCode" name="userCode" type="hidden" value="guanjiang290"></input>
	<input id="modle" name="modle" type="hidden" value=""></input>
	<div id="resetWindow" title="��������" class="easyui-window"
		style="width: 400px; height: 250px;" closed="true"
		data-options="modal:true"></div>


</body>

</html>