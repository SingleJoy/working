<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/backstage/base/inc.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var treegrid;
	$(function() {

		treegrid = $('#treegrid').treegrid({
			url : '${pageContext.request.contextPath}/back_auth/treegrid.action',
			toolbar : [ {
				text : '展开',
				iconCls : 'icon-redo',
				handler : function() {
					var node = treegrid.treegrid('getSelected');
					if (node) {
						treegrid.treegrid('expandAll', node.id);
					} else {
						treegrid.treegrid('expandAll');
					}
				}
			}, '-', {
				text : '折叠',
				iconCls : 'icon-undo',
				handler : function() {
					var node = treegrid.treegrid('getSelected');
					if (node) {
						treegrid.treegrid('collapseAll', node.id);
					} else {
						treegrid.treegrid('collapseAll');
					}
				}
			}, '-', {
				text : '修改',
				iconCls : 'icon-edit',
				handler : function() {
					edit();
				}
			}, '-', {
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
			}, '-',{
				text : '刷新',
				iconCls : 'icon-reload',
				handler : function() {
					treegrid.treegrid('reload');
				}
			} , '-', {
				text : '取消选中',
				iconCls : 'icon-undo',
				handler : function() {
					treegrid.treegrid('unselectAll');
				}
			}, '-' ],
			title : '',
			iconCls : 'icon-save',
			fit : true,
			fitColumns : false,
			nowrap : false,
			animate : false,
			border : false,
			idField : 'id',
			treeField : 'name',
			frozenColumns : [ [ {
				title : 'id',
				field : 'id',
				width : 150,
				hidden : true
			}, {
				field : 'name',
				title : '权限名称',
				width : 240,
				formatter : function(value) {
					if (value) {
						return sy.fs('<span title="{0}">{1}</span>', value, value);
					}
				}
			} ] ],
			columns : [ [ {
				field : 'url',
				title : '权限地址',
				width : 250,
				formatter : function(value) {
					if (value) {
						return sy.fs('<span title="{0}">{1}</span>', value, value);
					}
				}
			}, {
				field : 'remarks',
				title : '权限描述',
				width : 250,
				formatter : function(value) {
					if (value) {
						return sy.fs('<span title="{0}">{1}</span>', value, value);
					}
				}
			}, {
				field : 'seq',
				title : '排序',
				width : 150
			}, {
				field : 'pid',
				title : '上级权限ID',
				width : 150,
				hidden : true
			}, {
				field : 'pname',
				title : '上级权限',
				width : 150
			} ] ],
			onContextMenu : function(e, row) {
				e.preventDefault();
				$(this).treegrid('unselectAll');
				$(this).treegrid('select', row.id);
				$('#menu').menu('show', {
					left : e.pageX,
					top : e.pageY
				});
			},
			onLoadSuccess : function(row, data) {
				/*var t = $(this);
				if (data) {
					$(data).each(function(index, d) {
						if (this.state == 'closed') {
							t.treegrid('expandAll');
						}
					});
				}*/
			},
			onExpand : function(row) {
				treegrid.treegrid('unselectAll');
			},
			onCollapse : function(row) {
				treegrid.treegrid('unselectAll');
			}
		});

	});

	function edit() {
		var node = treegrid.treegrid('getSelected');
		if (node) {
			var p = parent.sy.dialog({
				title : '修改权限',
				href : '${pageContext.request.contextPath}/back_auth/to_auth_edit.action',
				width : 500,
				height : 280,
				buttons : [ {
					text : '修改',
					handler : function() {
						var f = p.find('form');
						f.form('submit', {
							url : '${pageContext.request.contextPath}/back_auth/edit_auth.action',
							success : function(d) {
								var json = $.parseJSON(d);
								if (json.success) {
									treegrid.treegrid('reload');
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
					var pid = f.find('input[name=pid]');
					var ptree = pid.combotree({
						lines : true,
						url : '${pageContext.request.contextPath}/back_auth/doNotNeedSession_tree_recursive.action',
						onLoadSuccess : function() {
							parent.$.messager.progress('close');
						}
					});
					f.form('load', node);
				}
			});
		} else {
			parent.sy.messagerAlert('提示', '请选中要修改的记录！', 'error');
		}
	}
	function append() {
		var p = parent.sy.dialog({
			title : '添加权限',
			href : '${pageContext.request.contextPath}/back_auth/to_auth_add.action',
			width : 500,
			height : 280,
			buttons : [ {
				text : '添加',
				handler : function() {
					var f = p.find('form');	
					f.form('submit', {
						url : '${pageContext.request.contextPath}/back_auth/save_auth.action',
						success : function(d) {
							var json = $.parseJSON(d);
							if (json.success) {
								treegrid.treegrid('reload');
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
				var pid = f.find('input[name=pid]');
				var ptree = pid.combotree({
					lines : true,
					url : '${pageContext.request.contextPath}/back_auth/doNotNeedSession_tree_recursive.action'
				});
			}
		});
	}
	function remove() {
		var node = treegrid.treegrid('getSelected');
		if (node) {
			parent.sy.messagerConfirm('询问', '您确定要删除【' + node.name + '】？', function(b) {
				if (b) {
					$.ajax({
						url : '${pageContext.request.contextPath}/back_auth/delete_auth.action',
						data : {
							id : node.id
						},
						cache : false,
						dataType : 'JSON',
						success : function(r) {
							if (r.success) {
								treegrid.treegrid('remove', r.obj);
							}
							parent.sy.messagerShow({
								msg : r.msg,
								title : '提示'
							});
						}
					});
				}
			});
		}else{
			parent.sy.messagerAlert('提示', '请选中要删除的记录！', 'error');
		}
	}
</script>

<body class="easyui-layout" data-options="fit:true">
	<div data-options="region:'center',border:false" style="overflow: hidden;">
		<table id="treegrid"></table>
	</div>

	<div id="menu" class="easyui-menu" style="width:120px;display: none;">
		<div onclick="append();" data-options="iconCls:'icon-add'">增加</div>
		<div onclick="remove();" data-options="iconCls:'icon-remove'">删除</div>
		<div onclick="edit();" data-options="iconCls:'icon-edit'">修改</div>
	</div>
</body>
