<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div align="center" style="padding: 5px;overflow: hidden;">
	<form method="post">
		<input name="id" type="hidden" />
		<table class="tableForm">
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<th style="width: 55px;">名称:</th>
				<td><input name="title" class="easyui-validatebox" data-options="required:true,missingMessage:'请填写评价项名称'" />
				</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<th style="width: 55px;">类型:</th>
				<td><select  name="type">
				<option value="0">课程</option>
				<option value="1">培训</option>
				<option value="2">课例</option>
				<option value="3">资源</option>
				</select> 
				</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<th style="width: 55px;">星级:</th>
				<td><select  name="level">
				<option value="1">1</option>
				<option value="2">2</option>
				<option value="3">3</option>
				<option value="4">4</option>
				<option value="5" selected="selected">5</option>
				</select> 
				</td>
			</tr>
		</table>
	</form>
</div>