<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div align="center" style="padding: 5px;overflow: hidden;">
	<form method="post">
		<table class="tableForm">
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<th style="width: 55px;">分类名称:</th>
				<td><input name="classify_name" class="easyui-validatebox" data-options="required:true,missingMessage:'请填写分类名称'" />
				</td>
			</tr>
			<!-- <tr><td>&nbsp;</td></tr>
			<tr>
				<th style="width: 55px;">类型名称:</th>
				<td><select  name="type">
				<option value="0" selected="selected">资源</option>
				<option value="1">课程</option>
				<option value="2">开班范围</option>
				<option value="3">职称</option>
				<option value="4">职务</option>
				<option value="5">培训</option>
				</select> 
				</td>
			</tr> -->
			<tr><td>&nbsp;</td></tr>
			<tr>
				<th style="width: 55px;">编码:</th>
				<td><input name="code" class="easyui-validatebox" data-options="required:true,missingMessage:'请填写编码'" />
				</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<th style="width: 55px;">序号:</th>
				<td><input name="seq" style="width:140px;" class="easyui-numberspinner" data-options="min:0,max:999,editable:false,required:true,missingMessage:'请选择分类排序'" value="10" style="width:150px;" />
				</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<th style="width: 55px;">描述:</th>
				<td><input name="remarks" class="easyui-validatebox" data-options="required:true,missingMessage:'请填写描述'" />
				</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<th style="width: 55px;">上级分类:</th>
				<td><input id="pid" name="parent_id" style="width:140px;"/>
				</td>
			</tr>
		</table>
	</form>
</div>