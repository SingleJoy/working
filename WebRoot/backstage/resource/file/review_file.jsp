<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div align="center" style="padding: 5px;overflow: hidden;">
	<form id="fileForm" method="post">
		<input name="ids" type="hidden" />
		<table>
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<th align="right">&nbsp;审核：</th>
				<td>
					<select name="status" onchange="doStatus(this.value);" style="width: 150px;"
						data-options="required:true,missingMessage:'请选择'">
							<option value="0">---审核通过---</option>
							<option value="2">---审核不通过---</option>
					</select>
				</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr id="reasonId" style="display:none">
				<th align="right">&nbsp;原因：</th>
				<td>
					<select name="reason" style="width: 150px;"
						data-options="required:true,missingMessage:'请选择'">
							<option value="0">---资源不合法---</option>
							<option value="1">---资源和描述不符---</option>
							<option value="2">---审核不通过---</option>
					</select>
				</td>
			</tr>
		</table>
	</form>
</div>
<script type="text/javascript" charset="utf-8">
function doStatus(value){
	if(value==2){//审核不通过描述原因
		$("#reasonId").css("display","");
	}else{
		$("#reasonId").css("display","none");
	}
}
</script>