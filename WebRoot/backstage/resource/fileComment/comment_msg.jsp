<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" charset="utf-8">
	<%		
 %>
</script>

<div style="padding: 5px;">
	
		
		
	
	<table id="dg" style="height:330px"
			data-options="fitColumns:true,checkOnSelect : true,
			selectOnCheck : true,pagination:true,url:'${pageContext.request.contextPath}/back_file_comment/msg.action?id=${id}',method:'get'">
		<thead>
		
			<tr>
			    <th data-options="field:'id',width:150,sortable : true,
				checkbox : true">评论内容</th>
				<th data-options="field:'content',width:240">评论内容</th>
				<th data-options="field:'comment_time',width:150">评论时间</th>
				<th data-options="field:'score',width:100">评分</th>
				<th data-options="field:'status',width:80,align:'center',formatter:function(value,rowData,rowIndex){
				if(value==1){
				return '正常';} 
				if(value==0){
				return '禁止';
				}
				}">状态</th>
				
			</tr>
			
		</thead>
	</table>
		
		
	
</div>

	<script type="text/javascript">
		$(function(){
			var pager = $('#dg').datagrid().datagrid('getPager');	// get the pager of datagrid
			 $('#dg').datagrid({
	   toolbar: [
	     {
				text : '全部评论',
				iconCls : 'icon-search',
				handler : function() {
					  $('#dg').datagrid('load',{
    	status: null
    	
    });
				}
			},
	    {
				text : '禁止的评论',
				iconCls : 'icon-search',
				handler : function() {
								    $('#dg').datagrid('load',{
    	status: '0'
    	
    });
				}
			},
			 {
				text : '正常的评论',
				iconCls : 'icon-search',
				handler : function() {
				
					    $('#dg').datagrid('load',{
    	status: '1'
    	
    });
				}
			},
	    {
				text : '禁止',
				iconCls : 'icon-remove',
				handler : function() {
							var node = $('#dg').datagrid('getChecked');
							
		var ids = [];
		if (node.length > 0) {
		parent.sy.messagerConfirm('请确认', '您要禁止当前所选评论？', function(b) {
				if (b) {
				for ( var i = 0; i < node.length; i++) {
						ids.push(node[i].id);
					}
					$.ajax({
						url : '${pageContext.request.contextPath}/back_comment/forbidden.action',
						data : {
							ids : ids.join(',')
							
						},
						cache : false,
						dataType : 'JSON',
						success : function(r) {
							if (r.success) {
							parent.sy.messagerShow({
								msg : r.msg,
								title : '提示'
							});
							$('#dg').datagrid('reload');
								
							}
							
						}
					});
				}
			});
			
		}else{
			parent.sy.messagerAlert('提示', '请选中要删除的记录！', 'error');
		}
				}
			}
			,
	    {
				text : '启用',
				iconCls : 'icon-remove',
				handler : function() {
							var node = $('#dg').datagrid('getChecked');
							
		var ids = [];
		if (node.length > 0) {
		parent.sy.messagerConfirm('请确认', '您要恢复当前所选评论？', function(b) {
				if (b) {
				for ( var i = 0; i < node.length; i++) {
						ids.push(node[i].id);
					}
					$.ajax({
						url : '${pageContext.request.contextPath}/back_comment/recovery.action',
						data : {
							ids : ids.join(',')
							
						},
						cache : false,
						dataType : 'JSON',
						success : function(r) {
							if (r.success) {
							parent.sy.messagerShow({
								msg : r.msg,
								title : '提示'
							});
							$('#dg').datagrid('reload');
								
							}
							
						}
					});
				}
			});
			
		}else{
			parent.sy.messagerAlert('提示', '请选中要删除的记录！', 'error');
		}
				}
			}
			]
			
});
		});
		
	</script>