<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/common/global.jsp"%>
<%@ include file="/common/meta.jsp"%>
<title>LOANPLUS|������ƽ̨</title>
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
		<span style="float: right; padding-right: 20px;" class="head">
			��ӭ:&nbsp; &nbsp;&nbsp; <a href="#"
			onclick="fileRight('/ht/user/userReset.do?id=26e72543-9bf6-4dc2-80e6-dcd50a5421fb');return false;">�޸�����</a>
			&nbsp;&nbsp; <!-- <a href="/j_spring_cas_security_logout" id="loginOut">��ȫ�˳�</a> -->
			<a href="#" onclick="logout()" id="loginOut">��ȫ�˳�</a>
		</span> <span
			style="padding-left: 5px; font-size: 19px; height: 97px; line-height: 60px; margin-left: 20px;">LOANPLUS-CC | ������ƽ̨</span>
	</div>

	<div region="south" split="false" border="false"
		style="height: 30px; background: #fff6ef;">
		<div class="footer">��Ȩ���� # 2016�й�ƽ�����գ����ţ��ɷ����޹�˾</div>
	</div>

	<div region="west" hide="true" split="false" collapsible="false"
		title="�����˵�" style="width: 180px;" id="west">
		<div id="nav" class="easyui-accordion" fit="true" border="false">
		</div>
	</div>

	<div id="mainPanle" region="center" split="false" border="false"
		style="background: #eee;">
		<div id="tabs" class="easyui-tabs" fit="true" border="false">
			<div title="��ҳ" style="padding: 50px;"></div>
		</div>
	</div>
	<input id="userCode" name="userCode" type="hidden" value="guanjiang290"></input>
	<div id="resetWindow" title="��������" class="easyui-window"
		style="width: 400px; height: 250px;" closed="true"
		data-options="modal:true"></div>


</body>

</html>