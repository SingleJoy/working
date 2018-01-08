<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
function checkName(){
	var username = $("#username").val();
	if(username!=''){
		if(!check_username1(username)){
			$("#username").val("");
			return false;
		}else{
			$.ajax({
				url : '${pageContext.request.contextPath}/back_user/doNotNeedSession_checkExis.action',
				data:{
					username : username
				},
				type:'POST',
				success : function(data) {
					var m = $.parseJSON(data);
					if(m.msg=='1'){
						$("#username").val("");
						parent.sy.messagerShow({
							msg : "用户名已存在！",
							title : '提示'
						});
						return false;
					}
				}
			});
		}
	}
	
}
//验证用户名   字母开头 
function check_username1(str){
	var myreg = /^[a-zA-Z][0-9a-zA-Z\_\-]{1,15}$/g;
	if(!myreg.test(str)){
		return false;
	}
	return true;
}
//验证手机号格式是否正确
function check_phone(value) {
    var reg = /^1[3|4|5|8|9]\d{9}$/;
    return reg.test(value);
}

function check_phone_isexit(){
	var reg_phone = $("#phone").val();
	if(reg_phone!=''){
		//验证手机号格式是否正确
		if(!check_phone(reg_phone)){
			$("#phone").val('');
			parent.sy.messagerShow({
				msg : "手机号码格式不正确！",
				title : '提示'
			});
			
			return false;
		}else{
			//验证手机号是否存在
			$.ajax({
				url : '${pageContext.request.contextPath}/back_user/doNotNeedSession_checkExis.action',
				data:{
					'phone':reg_phone
				},
				type:'POST',
				async:false,
				success : function(data) {
					var m = $.parseJSON(data);
					if(m.msg=='1'){
						$("#phone").val("");
						parent.sy.messagerShow({
							msg : "手机号已存在！",
							title : '提示'
						});
						return false;;
					}
				}
			});
		}
	}
	
}

</script>
<div style="padding: 5px; overflow: hidden;">
	<form id="userForm" method="post">
		<table class="tableForm">
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<th>&nbsp;登录名：</th>
					<td><input name="username" id="username" onblur="checkName();" placeholder="支持英文、数字组合"  maxlength="16" class="easyui-validatebox"
						data-options="required:'true',missingMessage:'请填写登录名称'" /></td>
					<th>&nbsp;所属角色：</th>
					<td><input name="roleIds" style="width: 145px;" data-options="required:'true',missingMessage:'请选择用户角色'"/></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
			<c:if test="${user_type==1}">
				<tr>
					<th>&nbsp;手机号：</th>
						<td><input name="phone" id ="phone" onblur="check_phone_isexit();" style="width: 145px;" class="easyui-validatebox"
							data-options="required:'true',missingMessage:'请填写手机号'" /></td>
				</tr>
			</c:if>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th>&nbsp;密码：</th>
				<td><input name="password" type="password"
					class="easyui-validatebox"
					data-options="required:'true',missingMessage:'请填写登录密码'" /></td>
				<th>&nbsp;重复密码：</th>
				<td><input type="password" style="width: 140px;"
					class="easyui-validatebox"
					data-options="required:'true',missingMessage:'请再次填写密码',validType:'eqPassword[\'#userForm input[name=password]\']'" />
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th>&nbsp;备注：</th>
				<td colspan="3"><textarea name="remarks"
						style="height: 50px; width: 97%;"></textarea></td>
			</tr>
		</table>
	</form>
</div>