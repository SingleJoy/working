<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div align="center" style="padding: 5px;overflow: hidden;">
	<form method="post">
		<table class="tableForm">
			<tr>
				<th style="width: 55px;">角色名称:</th>
				<td><input name="name" class="easyui-validatebox" data-options="required:true,missingMessage:'请填写角色名称'" style="width:323px;" />
				</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<th>拥有权限:</th>
				<td><input name="authIds" style="width:327px;" /><span style="color:red;">选择时要选到最小子权限</span>
				</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<th>等级:</th>
				<td><input name="level" style="width:327px;" type="number" min="${sessionInfo.level+1}" value="${sessionInfo.level+1}"/><span style="color:red;">请赋予角色等级</span>
				</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<th>备注:</th>
				<td><textarea name="remarks" style="height: 100px;width:327px;"></textarea>
				</td>
			</tr>
		</table>
	</form>
</div>