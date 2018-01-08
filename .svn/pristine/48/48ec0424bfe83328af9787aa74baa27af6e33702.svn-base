<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div align="center" style="padding: 5px;">
	<form method="post">
	
		<table class="tableForm">
		<tr><td>&nbsp;</td></tr>
		<tr><td>&nbsp;</td></tr>
			<tr>
				<th>栏目名称:</th>
				<td><input name="name" class="easyui-validatebox" data-options="required:true,missingMessage:'请填写栏目名称'" />
				</td>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<th>栏目ID:</th>
				<td><input name="id"  id="vv"/>
				</td>
			
			</tr>
		</table>
	</form>
</div>
<script>
//${pageContext.request.contextPath}/back_subject/check_id.action','paramName']']
    $('#vv').validatebox({
        required: true,
        validType: "remote['${pageContext.request.contextPath}/back_subject/check_id.action','paramName']",
        invalidMessage:"请填写2位字符，且不能与已存在的重复"
    });

</script>