<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
var datagrid1;
$(function() {

	datagrid1 = $('#datagrid2').datagrid({
		url : '${pageContext.request.contextPath}/back_workshop/master_datagrid.action?source_id='+$("#community_id").val(),
		title : '',
		iconCls : 'icon-save',
		fit : true,
		fitColumns : true,
		nowrap : false,
		border : false,
		idField : 'id',
		sortName : 'create_time',
		sortOrder : 'desc',
		checkOnSelect : true,
		selectOnCheck : true,
		frozenColumns : [ [ {
			title : '编号',
			field : 'user_id',
			width : 10,
			hidden: true
		}] ],
		columns : [ [ {
			title : '用户名',
			field : 'username',
			sortable : true,
			width : 50
		}, {
			title : '真实姓名',
			field : 'true_name',
			sortable : true,
			width : 50
		}, {
			title : '性别',
			field : 'sex',
			sortable : true,
			width : 35,
			formatter : function(value){
				if(value==0){
					return '女';
				}else if(value==1){
					return '男';
				}else{
					return '';
				}
			}
		}, {
			title : '工作单位',
			field : 'school',
			sortable : true,
			width : 120
		}, {
			title : '学段学科',
			field : 'course',
			sortable : true,
			width : 60
		}, {
			title : '手机号',
			field : 'phone',
			sortable : true,
			width : 70
		}] ],
		onClickRow : function(rowIndex, rowData) {
			var rows = $('#datagrid2').datagrid('getSelections');
			if(rows.length>3){
				$('#datagrid2').datagrid('unselectRow',rowIndex); 
				console.log(rows.length)
			}
		}
	});

});
</script>
<div data-options="region:'center',border:false" style=" height: 450px;">
	
	<table id="datagrid2"></table>
	
</div>