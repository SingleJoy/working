<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- <script type="text/javascript" charset="utf-8">
	$.messager.progress({
		text : '数据加载中....',
		interval : 100
	});
</script> -->
<div style="padding: 5px;">
	<form id="userForm" method="post">
		<input name="id" id="id" type="hidden" />
		 <table class="tableForm">
		 		<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<th>&nbsp;登录名：</th>
					<td><input name="username" value="${info.username}" disabled="disabled"  maxlength="16"class="easyui-validatebox" /></td>
					<th>&nbsp;所属角色：</th>
					<td><input name="roleIds" value="${info.roleNames}" style="width: 145px;" disabled="disabled"/></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
			<tr>
				<th>&nbsp;登陆次数：</th>
				<td><input name="login_count" value="${info.login_count}" disabled="disabled"  /></td>
				<th>&nbsp;注册IP：</th>
				<td><input name="sign_ip" value="${info.sign_ip}"  disabled="disabled"/></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th>&nbsp;最近登录时间：</th>
				<td><input name="last_login_time" value="${info.logintime}"  disabled="disabled"/>
				</td>
				<th>&nbsp;最近登录IP：</th>
				<td><input name="last_login_ip" value="${info.last_login_ip}"  disabled="disabled"/></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th>&nbsp;备注：</th>
				<td colspan="3"><textarea name="remarks"   style="height: 70px;width: 97%;" disabled="disabled">${info.remarks}</textarea>
				</td>
			</tr>
		</table>
	</form>
</div>

