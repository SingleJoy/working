<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" charset="utf-8">
	
</script>
<div style="padding: 5px;">
	<form id="userForm" method="post">
		<input name="ids" id="ids" type="hidden" />
		
		 <table class="tableForm">
		 		<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<th>&nbsp;类型：</th>
				<td><select name="type">
				<option value="1">金额</option>
				<option value="2">积分</option>
				</select>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
		
				<tr>
					<th>&nbsp;数值：</th>
					<td><input name="value" id="value" onchange="check_value()"/></td>
					</tr>
		
			<tr>
				<td>&nbsp;</td>
			</tr>
			
			<tr>
				<th>&nbsp;描述：</th>
				<td colspan="3"><textarea name="operation_description" style="height: 70px;width: 120%;" onchange="check_textarea()" id="textarea"></textarea>
				</td>
			</tr>
		</table>
	</form>
</div>

<script>
function check_value(){
var myreg=/^[0-9]*$/;
var value=$("#value").val();
if(!myreg.test(value)){
 		return false;
 	}
 	return true;
}
function check_textarea(){
	var textarea=$("textarea").val();
	if(textarea.length>200){
	return false;
	}
	return true;
}
</script>