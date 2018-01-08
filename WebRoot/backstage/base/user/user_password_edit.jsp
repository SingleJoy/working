<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" charset="utf-8">
	/* $.messager.progress({
		text : '数据加载中....',
		interval : 100
	}); */
</script>
<div style="padding: 5px;">
	<form id="userForm" method="post">
		<input name="id" id="id" type="hidden" />
		 <table class="tableForm">
		 		<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<th>&nbsp;登录名：</th>
					<td><input name="username" id="username" disabled="disabled"  /></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
			<c:if test="${user_type==1}">
				<tr>
					<th>&nbsp;手机号：</th>
					<td><input name="phone" disabled="disabled"/></td>
					<!-- <th>&nbsp;邮箱：</th>
					<td><input name="email" onchange="check_exises(this,'email','邮箱')" /></td> -->
				</tr>
			</c:if>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th>&nbsp;新密码：</th>
				<td><input id="pwd" class="easyui-validatebox" name="password"  required="required"  type="password" />
				</td>
				<td colspan="2" style="text-align: left;"><font color="red"></font></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th>&nbsp;确认密码：</th>
				<td><input id="rpwd" class="easyui-validatebox"  type="password" required="required" validType="equals['#pwd']" />
				</td>
				<td colspan="2" style="text-align: left;"><font color="red">请再次输入密码</font></td>
			</tr>
		</table>
	</form>
</div>
<script>
$(function(){
	$.extend($.fn.validatebox.defaults.rules, {  
		/*checkpwd: {    
	        validator: function(value, param){    
	        	var myreg = new RegExp(/[A-Za-z].*[0-9]|[0-9].*[A-Za-z]/); 
	        	var pwd = $(param[0]).val();
	        	return myreg.test(pwd)&&pwd.length>5&&pwd.length<31;
	        },    
	        message: '密码格式错误！'   
	    }, */
	    equals: {    
	        validator: function(value,param){    
	            return value == $(param[0]).val();    
	        },    
	        message: '两次输入密码不一致！'   
	    }
	});
})
</script>