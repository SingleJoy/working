<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div style="padding: 5px;">
	<form id="userForm" method="post">
		<input name="id" id="id" type="hidden" />
		<table class="tableForm">
		 		<tr>
					<th>&nbsp;金额：</th>
					<td><input id="amount" name="transaction_amount"  onchange="check_amount()"/></td>
					<!-- <th>&nbsp;邮箱：</th>
					<td><input name="email" onchange="check_exises(this,'email','邮箱')" /></td> -->
				</tr>
			
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th>&nbsp;状态：</th>
				<td><select name="is_success">
				<option value="1">未支付</option>
				<option value="2">已支付</option>
				<option value="0">关闭交易</option>
				</select>
				</td>
				<td colspan="2" style="text-align: left;"></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				
			</tr>
		</table>
	</form>
</div>

<script>
function check_amount(){
var myreg=/^[0-9]*$/;
var amount=$("#amount").val();
if(!myreg.test(amount)){
 		return false;
 	}
 	return true;
}

</script>