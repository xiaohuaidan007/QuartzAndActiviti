<%@ page language="java" contentType="text/html; charset=GB18030"	pageEncoding="GB18030"%>
<HTML>
<HEAD>
<title>UM统一报错页面模版</title>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<link rel="stylesheet" href="./styles/login.css" type="text/css">
</HEAD>
<BODY BGCOLOR="#F2F2F2" LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0">
<table width="100%" height="90%" border="0" cellpadding="2"
	cellspacing="0" bordercolor="#CC0000" bgcolor="#FFFFFF">
	<tr>
		<td align="center" valign="middle">
		<table width="400" height="300" border="1" cellpadding="2"
			cellspacing="0" bordercolor="#CC0000" bgcolor="#CC0000">
			<tr>
				<td height="21" align="center">
				<p><font color="yellow"><strong>操 作 错 误 提 示</strong></font></p>
				</td>
			</tr>
			<tr>
				<td valign="top" bgcolor="#FFFFFF"><br>
				<table width="98%" border="0" align="center" class="font9pt">
					<tr>
						<td align="left">你可能有如下操作失误:
						<p>
						<li>您的口令或者登录用户名错误, 请重新登录!<br>
						用户名密码问题请参考[常见问题解答]
						<li>可能由于连续多次(5 次以上)输入错误的口令或者违反了现行的其他安全策略，导致您的帐号已经被锁，系统将无法处理您的登录请求，UM帐号被系统锁定后无法手工解锁，只能等半个小时后系统自动解锁。请用户等待半小时后再重新登录，谢谢！
						<li>非工作时间（工作时间一般为：8:30 am -- 17:30 pm，节假日除外），遇到紧急情况可拨打各部门的值班电话。电话清单请点击见下面连接
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td height="21" align="center"><input type="button"
					value="重新登录" onClick="javascript:location.href='./login.jsp'"
					class="button01">&nbsp;<input type="button" name="back"
					value="关闭本窗口" onClick="javascript:window.close()" class="button01"></td>
			</tr>
			<tr>
				<td height="21" align="center"><strong><A
					href="http://paitsm/idcweb/"><font color="white">[问题上报]</font></A>&nbsp;<A
					href="http://oaworkflow/userapp/addrquery/atlevel/print.asp?orgcode=1000289"><font
					color=white>[运营值班电话]</font></A>&nbsp;<A
					href="http://oaworkflow/userapp/addrquery/atlevel/print.asp?orgcode=1000288"><font
					color=white>[网管理值班电话]</font></A>&nbsp;<a
					href="http://paitsm/km/menu/defaultkm.asp?systemno=150">[常见问题解答]</a>&nbsp;</strong>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</BODY>
</HTML>
