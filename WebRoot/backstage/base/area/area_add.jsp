<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div align="center" style="padding: 5px;">
	<form method="post">
	
		<table class="tableForm">
		<tr><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td></tr>
			<tr>
				<th>地区名称:</th>
				<td><input name="name" class="easyui-validatebox" data-options="required:true,missingMessage:'请填写栏目名称'" />
				</td>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<th>上级菜单:</th>
				<td><input name="pid" style="width:160px;" />
				</td>
			
			</tr>
		</table>
	</form>
</div>