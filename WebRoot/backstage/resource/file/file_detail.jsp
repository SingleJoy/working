<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div align="center" style="padding: 5px;overflow: hidden;">
	<form id="fileForm" method="post">
		<table class="tableForm">
			<tr><td>&nbsp;</td></tr>
			<c:if test="${file_type==0}">
			<tr>
				<th >&nbsp;标题：</th>
				<td ><input name="title"  disabled="disabled" /></td>
				<th >&nbsp;分类：</th>
				<td ><input name="columnName"  disabled="disabled" /></td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<th >&nbsp;简介：</th>
				<td colspan="3"><textarea name="profile"  disabled="disabled"  style="height: 70px;width: 100%;"></textarea></td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<th >教材版本：</th>
				<td colspan="3"><input name="version"  disabled="disabled"  style="width: 100%;"/></td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<th >年级分类：</th>
				<td colspan="3"><input name="grade"  disabled="disabled"  style="width: 100%;"/></td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<th >&nbsp;标签：</th>
				<td colspan="3"><input name="labels"  disabled="disabled"  style="width: 100%;"/></td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<th >&nbsp;类型：</th>
				<td><input name="type"  disabled="disabled" /></td>
				<th >&nbsp;价格(元)：</th>
				<td><input name="price" disabled="disabled" class="easyui-numberbox" precision="2" /></td>
			</tr>
			<c:if test="${check==0}">
			<tr><td>&nbsp;</td></tr>
			<tr>
				<th >&nbsp;状态：</th>
				<td>
					<select name="status"  style="width: 175px;" disabled="disabled" >
						<option value="0">审核通过</option>
						<option value="1">未审核</option>
						<option value="2">审核不通过</option>
						<option value="3">删除</option>
					</select>
				</td>
				<th >&nbsp;原因：</th>
				<td>
					<select name="reason"  style="width: 175px;" disabled="disabled" >
						<option value="-1"></option>
						<option value="0">资源不合法</option>
						<option value="1">资源和描述不符</option>
						<option value="2">审核不通过</option>
					</select>
				</td>
			</tr>
			</c:if>
			</c:if>
			<c:if test="${file_type==1}"><!-- 教案 -->
			<tr>
				<th >&nbsp;标题：</th>
				<td ><input name="filename"  disabled="disabled" /></td>
				<th >&nbsp;类型：</th>
				<td ><input name="file_type"  disabled="disabled" /></td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
			    <th >&nbsp;上传人：</th>
				<td><input name="userName" disabled="disabled" class="easyui-textbox"  /></td>
				<th >&nbsp;上传时间：</th>
				<td><input name="upload_time" disabled="disabled" class="easyui-datebox" style="width: 150px;" /></td>
			</tr>
			<c:if test="${check==0}">
			<tr><td>&nbsp;</td></tr>
			<tr>
				<th >&nbsp;状态：</th>
				<td>
					<select name="status"  style="width: 175px;" disabled="disabled" >
						<option value="0">审核通过</option>
						<option value="1">未审核</option>
						<option value="2">审核不通过</option>
						<option value="3">删除</option>
					</select>
				</td>
				<th >&nbsp;原因：</th>
				<td>
					<select name="reason"  style="width: 175px;" disabled="disabled" >
						<option value="-1"></option>
						<option value="0">资源不合法</option>
						<option value="1">资源和描述不符</option>
						<option value="2">审核不通过</option>
					</select>
				</td>
			</tr>
			</c:if>
			</c:if>
		</table>
	</form>
</div>