<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<!DOCTYPE html>

<html lang="en">
<head>
	<%@ include file="/common/global.jsp"%>
	<title>登录页</title>
	<script>
		var logon = ${not empty user};
		if (logon) {
			location.href = '${loginCtx}/manage';
		}
	</script>
	<%@ include file="/common/meta.jsp" %>
	<%@ include file="/common/include-jquery-ui-theme.jsp" %>
    <%@ include file="/common/include-base-styles.jsp" %>
    <style type="text/css">
        .login-center {
            width: 600px;
            margin-left:auto;
            margin-right:auto;
        }
        #loginContainer {
            margin-top: 3em;
        }
        .login-input {
            padding: 4px 6px;
            font-size: 14px;
            vertical-align: middle;
        }
    </style>

    <script src="${ctx }/js/common/jquery-1.8.3.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/plugins/jui/jquery-ui-1.9.2.min.js" type="text/javascript"></script>
    <script type="text/javascript">
	$(function() {
		$('button').button({
			icons: {
				primary: 'ui-icon-key'
			}
		});
	});
	</script>
</head>

<body>
    <div id="loginContainer" class="login-center">
        <c:if test="${not empty param.error}">
            <h2 id="error" class="alert alert-error">用户名或密码错误！！！</h2>
        </c:if>
        <c:if test="${not empty param.timeout}">
            <h2 id="error" class="alert alert-error">未登录或超时！！！</h2>
        </c:if>

		<div style="text-align: center;">
            <h2>LOANPLUS | 管理平台</h2>
		</div>
		<hr />
		<form action="${loginCtx }/manage/logon" method="get">
			<table>
				<tr>
					<td width="200" style="text-align: right;">用户名：</td>
					<td><input id="username" name="username" class="login-input" placeholder="用户名" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">密码：</td>
					<td><input id="password" name="password" type="password" class="login-input"/></td>
				</tr>
				<tr>
					<td colspan="2">
						<div align="center">
							<button type="submit">登录</button>
						</div>
					</td>
				</tr>
			</table>
		</form>
		<hr />
		<div>
			<div style="text-align:center;position:relative;height:240px; font-family:'宋体';margin-bottom:0px">
				<span style="position:absolute; bottom:0;">
				版权所有 # 2016中国平安保险（集团）股份有限公司
				</span>
			</div>
		</div>
        <hr />
    </div>
</body>
</html>
