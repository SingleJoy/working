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
					<td><input name="username" disabled="disabled"  maxlength="16"class="easyui-validatebox" /></td>
					<c:if test="${user_type==0}">
					<th>&nbsp;所属角色：</th>
					<td><input name="roleIds" style="width: 145px;" disabled="disabled"/></td>
					</c:if>
					<c:if test="${user_type!=0}">
					<th>&nbsp;性别：</th>
					<td><input name="sex"  disabled="disabled"/></td>
					</c:if>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<th>&nbsp;用户类型：</th>
					<td><input name="user_type" disabled="disabled"  maxlength="16" class="easyui-validatebox" /></td>
					<th>&nbsp;状态：</th>
					<td><input name="status" disabled="disabled"  /></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
			<c:if test="${user_type!=0}">
				<tr>
					<th>&nbsp;手机号：</th>
					<td><input name="phone" disabled="disabled"/></td>
					<th>&nbsp;邮箱：</th>
					<td><input name="email" type="email" disabled="disabled" /></td> 
				</tr>
				<tr>
				<td>&nbsp;</td>
			</tr>
			</c:if>
			<tr>
				<th>&nbsp;注册时间：</th>
				<td><input name="create_time" type="text" disabled="disabled"/>
				</td>
				<th>&nbsp;注册IP：</th>
				<td><input name="sign_ip"  disabled="disabled"/></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th>&nbsp;最近登录时间：</th>
				<td><input name="last_login_time" type="text" disabled="disabled"/>
				</td>
				<th>&nbsp;最近登录IP：</th>
				<td><input name="last_login_ip"  disabled="disabled"/></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th>&nbsp;注册类型：</th>
				<td><input name="sign_type"  disabled="disabled"/></td>
				<th>&nbsp;登陆次数：</th>
				<td><input name="login_count" disabled="disabled"  /></td>
			</tr>
			
			<tr>
				<td>&nbsp;</td>
			</tr>
			<c:if test="${user_type!=0}">
				<tr>
					<th>&nbsp;真实姓名：</th>
					<td><input name="realname" disabled="disabled"  maxlength="16" class="easyui-validatebox" /></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
				</c:if>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th>&nbsp;备注：</th>
				<td colspan="3"><textarea name="remarks" style="height: 70px;width: 97%;" disabled="disabled"></textarea>
				</td>
			</tr>
		</table>
	</form>
</div>

