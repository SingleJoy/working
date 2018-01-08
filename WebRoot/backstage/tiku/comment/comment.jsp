<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/backstage/base/inc.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var datagrid;
	$(function() {

		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/back_comment/datagrid.action',
			title : '',
			iconCls : 'icon-save',
			pagination : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
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
				sortable : true,
				checkbox : true
			}, {
				title : '评语',
				field : 'content',
				width : 300,
				formatter:function(value,rowData,rowIndex){
					return '<span title="'+value+'" style="display:block;overflow: hidden;">'+lencut(value,35)+'</span>';
				}
			}] ],
			columns : [ [{
				title : '序号',
				field : 'seq',
				sortable : true,
				width : 150
			
			},{
				title : '评论时间',
				field : 'create_time',
				sortable : true,
				width : 150
			
			} ] ], 
			toolbar : [ {
				text : '详细',
				iconCls : 'icon-search',
				handler : function() {
					detail();
				}
			}, '-',{
				text : '增加',
				iconCls : 'icon-add',
				handler : function() {
					append();
				}
			}, '-', {
				text : '删除',
				iconCls : 'icon-remove',
				handler : function() {
					remove();
				}
			}, '-', {
				text : '修改',
				iconCls : 'icon-edit',
				handler : function() {
					edit();
				}
			}, '-', {
				text : '取消选中',
				iconCls : 'icon-undo',
				handler : function() {
					datagrid.datagrid('unselectAll');
				}
			}, '-' ],
			onRowContextMenu : function(e, rowIndex, rowData) {
				e.preventDefault();
				$(this).datagrid('unselectAll');
				$(this).datagrid('selectRow', rowIndex);
				$('#menu').menu('show', {
					left : e.pageX,
					top : e.pageY
				});
			}
		});

	});

	function detail() {
		var rows = datagrid.datagrid('getSelections');
		if (rows.length == 1) {
			var p = parent.sy.dialog({
				title : '详细评语',
				href : '${pageContext.request.contextPath}/back_comment/to_comment_detail.action',
				width : 420,
				height : 260,
				buttons : [ {
					text : '返回',
					handler : function() {
						var f = p.find('form');
						p.dialog('close');
					}
				} ],
				onLoad : function() {
					var f = p.find('form');
					$.ajax({
						url : '${pageContext.request.contextPath}/back_comment/query_detail.action',
						data : {
							id : rows[0].id
						},
						dataType : 'json',
						success : function(d) {
							if(d.success){
								f.form('load', {
									seq : d.obj.seq,
									content : d.obj.content,
									create_time : d.obj.create_time
								});
							}
						}
					});
				}
			});
		} else if (rows.length > 1) {
			parent.sy.messagerAlert('提示', '同一时间只能查看一条记录！', 'error');
		} else {
			parent.sy.messagerAlert('提示', '请勾选要查看的记录！', 'error');
		}
	}
	function edit() {
		var rows = datagrid.datagrid('getSelections');
		if (rows.length == 1) {
			var p = parent.sy.dialog({
				title : '编辑标签',
				href : '${pageContext.request.contextPath}/back_comment/to_comment_edit.action',
				width : 420,
				height : 260,
				buttons : [ {
					text : '编辑',
					handler : function() {
						var f = p.find('form');
						f.form('submit', {
							url : '${pageContext.request.contextPath}/back_comment/edit_comment.action',
							success : function(d) {
								var json = $.parseJSON(d);
								if (json.success) {
									datagrid.datagrid('reload');
									p.dialog('close');
								}
								parent.sy.messagerShow({
									msg : json.msg,
									title : '提示'
								});
							}
						});
					}
				} ],
				onLoad : function() {
					var f = p.find('form');
					f.form('load', {
						id : rows[0].id,
						content : rows[0].content,
						seq : rows[0].seq
						
					});
				}
			});
		} else if (rows.length > 1) {
			parent.sy.messagerAlert('提示', '同一时间只能编辑一条记录！', 'error');
		} else {
			parent.sy.messagerAlert('提示', '请勾选要编辑的记录！', 'error');
		}
	}
	function append() {
		var p = parent.sy.dialog({
			title : '添加标签',
			href : '${pageContext.request.contextPath}/back_comment/to_comment_add.action',
			width : 420,
			height : 260,
			buttons : [ {
				text : '添加',
				handler : function() {
					var f = p.find('form');
					f.form('submit', {
						url : '${pageContext.request.contextPath}/back_comment/save_comment.action',
						success : function(d) {
							var json = $.parseJSON(d);
							if (json.success) {
								datagrid.datagrid('reload');
								p.dialog('close');
							}
							parent.sy.messagerShow({
								msg : json.msg,
								title : '提示'
							});
						}
					});
				}
			} ]
		});
	}
	function remove() {
		var rows = datagrid.datagrid('getChecked');
		var ids = [];
		if (rows.length > 0) {
			parent.sy.messagerConfirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						ids.push(rows[i].id);
					}
					$.ajax({
						url : '${pageContext.request.contextPath}/back_comment/delete_comment.action',
						data : {
							ids : ids.join(',')
						},
						dataType : 'json',
						success : function(d) {
							datagrid.datagrid('load');
							datagrid.datagrid('unselectAll');
							parent.sy.messagerShow({
								title : '提示',
								msg : d.msg
							});
						}
					});
				}
			});
		} else {
			parent.sy.messagerAlert('提示', '请勾选要删除的记录！', 'error');
		}
	}
</script>
</head>
<body class="easyui-layout" data-options="fit:true">
	<div data-options="region:'center',border:false" style="overflow: hidden;">
		<table id="datagrid"></table>
	</div>
	
	<div id="menu" class="easyui-menu" style="width:120px;display: none;">
	    <div onclick="detail();" data-options="iconCls:'icon-search'">详细</div>
		<div onclick="append();" data-options="iconCls:'icon-add'">增加</div>
		<div onclick="remove();" data-options="iconCls:'icon-remove'">删除</div>
		<div onclick="edit();" data-options="iconCls:'icon-edit'">编辑</div>
	</div>
</body>
</html>