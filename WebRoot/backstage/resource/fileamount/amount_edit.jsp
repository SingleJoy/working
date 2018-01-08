<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div align="center" style="padding: 5px;overflow: hidden;">
	<form method="post">
		<input name="id" type="hidden" />
		<table class="tableForm">
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<th style="width: 55px;">金额:</th>
				<td><input name="amount" class="easyui-numberbox" precision="2" min="0" max="99999.99"
												size="8" maxlength="8" value="0.0" data-options="required:true,missingMessage:'请填写金额'">
					元
				</td>
			</tr>
		</table>
	</form>
</div>