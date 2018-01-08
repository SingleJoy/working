<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" charset="utf-8">
	<%		
 %>
</script>

<div style="padding: 5px;">
	
		
		
		
	<table id="dg" style="height:330px"
			data-options="fitColumns:true,singleSelect:true,pagination:true,url:'${pageContext.request.contextPath}/back_wealth/msg.action?id=${id}&type=${type}',method:'get'">
		<thead>
			<tr>
				<th data-options="field:'operation_description',width:240">操作描述</th>
				<th data-options="field:'operation_time',width:150">操作时间</th>
				<th data-options="field:'value',width:80,align:'center'">金额</th>
				<th data-options="field:'total_value',width:100">总额</th>
			</tr>
			
		</thead>
	</table>
		
		
	
</div>

	<script type="text/javascript">
		$(function(){
			var pager = $('#dg').datagrid().datagrid('getPager');	// get the pager of datagrid
			
		});
		function description(value){
		alert(value);
		}
	</script>