<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
var datagrid1;
$(function() {

	datagrid1 = $('#datagrid1').datagrid({
		url : '${pageContext.request.contextPath}/back_community/datagrid.action?status=2&paging=0',
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
			field : 'id',
			width : 150,
			hidden: true
		}, {
			title : '社区',
			field : 'name',
			width : 150,
			formatter:function(value,rowData,rowIndex){
				return lencut(value,15);
			} 
		},{
			title : '创建者',
			field : 'community_user',
			sortable : true,
			width : 70
		},{
			title : '类型',
			field : 'type',
			sortable : true,
			width : 60,
			formatter:function(value, rowData, rowIndex){
				if(value==0){
					return "普通";
				}else if(value==1){
					return "教师培训";
				}else{
					return "";
				}
			}
		},{
			title : '等级',
			field : 'grade',
			sortable : true,
			width : 40,
			formatter:function(value, rowData, rowIndex){
				if(value==0){
					return "省级";
				}else if(value==1){
					return "市级";
				}else if(value==2){
					return "县级";
				}else{
					return "";
				}
			}
		}] ],
		columns : [ [ {
			title : '学时',
			field : 'hour',
			sortable : true,
			width : 35
		}, {
			title : '学分',
			field : 'credit',
			sortable : true,
			width : 35
		}, {
			title : '计划人数',
			field : 'plan_num',
			sortable : true,
			width : 60
		}, {
			title : '参与人数',
			field : 'studentNum',
			sortable : true,
			width : 60
		}] ],
		
		onClickRow : function(rowIndex, rowData) {
			$("#community_id").val(rowData.id);
			$("#community_name").val(rowData.name);
			$('#datagrid1').datagrid('uncheckAll'); 
			$('#datagrid1').datagrid('checkRow',rowIndex);
			
		}
	});

});
</script>

<style>
	.datagrid-body{
		overflow-y:hidden;
	}
</style>
<div data-options="region:'center',border:false" style=" height: 450px;">
	
	<table id="datagrid1"></table>
	
</div>