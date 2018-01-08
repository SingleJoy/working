<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div align="center" style="padding: 5px;overflow: hidden;">
	<form method="post">
		<input name="id" type="hidden" />
		<input name="isRecommend" type="hidden" value="0" />
		<table class="tableForm">
		<tr><th>&nbsp;<br/>&nbsp;</th></tr>
			<tr>
				<th >有效日期:</th>
				<td> <input id="recommend_time" name="recommendTime" class="easyui-datebox" data-options="editable:false" validType="checktime['#recommend_time']" style="width: 155px;" />
				</td>
			</tr>
			<tr><th>&nbsp;<br/>&nbsp;</th></tr>
			<tr>
				<th >序号:</th>
				<td><input name="recommendSeq" class="easyui-numberbox"
					precision="0" min="0" max="10000" size="5" maxlength="5"
					data-options="required:true,missingMessage:'请填写序号'"
					style="width:150px;" /></td>
			</tr>
			<tr><th>&nbsp;<br/>&nbsp;</th></tr>
			<tr>
				<th>&nbsp;</th>
				<td>请输入0-10000的整数</td>
			</tr>
		</table>
	</form>
</div>
<script>

$(function(){
	$.extend($.fn.validatebox.defaults.rules, {  
		checktime: {    
	        validator: function(value, param){ 
	        	var now = new Date();  
	        	var t = new Date(value);
	        	if(Date.parse(now)-Date.parse(t)<=86400000){
	        		return true;
	        	}
	        },    
	        message: '只能选取大于或等于今天的日期！'   
	    }
	});
})



</script>