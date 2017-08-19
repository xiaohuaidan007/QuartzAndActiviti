<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>坏蛋首页</title>
<script type="text/javascript">
	/* 客户信息导入 */
	function inputInfoMethod(){
		window.location.href="/login"
	}
	/* 门店信息统计 */
	function storeInfoMethod(){
		window.location.href="/smt/storeInfo"
	}
	/* 渠道信息统计 */
	function toolInfoMethod(){
		window.location.href="/smt/toolInfo"
	}
	/* 客服信息统计 */
	function serverInfoMethod(){
		window.location.href="/smt/serverInfo"
	}
</script>
</head>
<body>
	<table style="margin-top: 100px">
		<caption style="font-weight: 1px;font-size: 24px;font-family: 微软雅黑;margin-left: 300px">
			功能按钮
		</caption>
		<tr style="height: 100px"></tr>
		<tr align="center">
			<td>
				<button id="inputInfo" onclick="inputInfoMethod()" style="height: 40px;width: 120px;
				font-size: 14px;cursor: pointer;margin-left: 300px">导入信息</button>
			</td>
			<td>
				<button id="storeInfo" onclick="storeInfoMethod()" style="height: 40px;width: 120px;
				font-size: 14px;cursor: pointer;margin-left: 30px">门店统计</button>
			</td>
			<td>
				<button id="toolInfo" onclick="toolInfoMethod()" style="height: 40px;width: 120px;
				font-size: 14px;cursor: pointer;margin-left: 30px">渠道统计</button>
			</td>
			<td>
				<button id="serverInfo" onclick="serverInfoMethod()" style="height: 40px;width: 120px;
				font-size: 14px;cursor: pointer;margin-left: 30px">客服统计</button>
			</td>
		</tr>
		<tr style="height: 80px">
			<td colspan="4">
				<p style="margin-left: 300px;font-size: 14px;color: green;">${message }</p>
			</td>
		</tr>
	</table>
	<p style="margin-left: 300px;font-size: 16px;color: black;">
		<strong>使用说明：</strong>
	</p>
	<p style="margin-left: 300px;font-size: 16px;color: black;">
		1、客户信息必须放到xls格式的Excel文件中才能上传
	</p>
	<p style="margin-left: 300px;font-size: 16px;color: black;">
		2、客户信息<font color="red">序号列必须有值</font>，否则不再继续录入，请注意提示的录入行数和表中实际行数是否一致
	</p>
	<p style="margin-left: 300px;font-size: 16px;color: black;">
		3、客户信息<font color="red">信息来源长度只能为2位</font>，否则会提示错误
	</p>
	<p style="margin-left: 300px;font-size: 16px;color: black;">
		4、客户信息<font color="red">成交金额必须为数字</font>，且<font color="red">成交金额必须大于300</font>才计入成交量
	</p>
	<p style="margin-left: 300px;font-size: 16px;color: black;">
		5、客户信息导入失败时提示信息中行号为Excel的行号，失败信息必须处理；成交金额大于30000会显示警告信息，警告信息可以不用处理
	</p>
</body>
</html>