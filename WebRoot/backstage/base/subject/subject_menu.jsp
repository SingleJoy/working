<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/backstage/base/inc.jsp"></jsp:include>
<script type="text/javascript" >
	var treegrid;
	var iconData;
	$(function() {

		iconData = [ {
			value : '',
			text : '默认'
		}, {
			value : 'icon-add',
			text : 'icon-add'
		}, {
			value : 'icon-edit',
			text : 'icon-edit'
		}, {
			value : 'icon-remove',
			text : 'icon-remove'
		}, {
			value : 'icon-save',
			text : 'icon-save'
		}, {
			value : 'icon-cut',
			text : 'icon-cut'
		}, {
			value : 'icon-ok',
			text : 'icon-ok'
		}, {
			value : 'icon-no',
			text : 'icon-no'
		}, {
			value : 'icon-cancel',
			text : 'icon-cancel'
		}, {
			value : 'icon-reload',
			text : 'icon-reload'
		}, {
			value : 'icon-search',
			text : 'icon-search'
		}, {
			value : 'icon-print',
			text : 'icon-print'
		}, {
			value : 'icon-help',
			text : 'icon-help'
		}, {
			value : 'icon-undo',
			text : 'icon-undo'
		}, {
			value : 'icon-redo',
			text : 'icon-redo'
		}, {
			value : 'icon-back',
			text : 'icon-back'
		}, {
			value : 'icon-sum',
			text : 'icon-sum'
		}, {
			value : 'icon-tip',
			text : 'icon-tip'
		} ];

		treegrid = $('#treegrid').treegrid({
			url : '${pageContext.request.contextPath}/back_subject/toListSub.action',
			toolbar : [ {
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
				text : '刷新',
				iconCls : 'icon-reload',
				handler : function() {
					treegrid.treegrid('reload');
				}
			}, '-', {
				text : '增加根节点',
				iconCls : 'icon-add',
				handler : function() {
					append1();
				}
			},'-', {
				text : '增加子节点',
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
					treegrid.treegrid('unselectAll');
				}
			}, '-' ],
			title : '',
			iconCls : 'icon-save',
			fit : true,
			fitColumns : true,
			nowrap : false,
			animate : false,
			border : false,
			idField : 'id',
			treeField : 'name',
			columns : [ [ {
				title : 'id',
				field : 'id',
				width : 150,
				hidden : true
			}, {
				field : 'name',
				title : '栏目名称',
				width : 1400,
				formatter : function(value) {
					if (value) {
						return sy.fs('<span title="{0}">{1}</span>', value, value);
					}
				}
			}] ],
			
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
				title : '修改菜单',
				href : '${pageContext.request.contextPath}/back_subject/to_subject_edit.action',
				width : 500,
				height : 280,
				buttons : [ {
					text : '修改',
					handler : function() {
						var f = p.find('form');
						f.form('submit', {
							url : '${pageContext.request.contextPath}/back_subject/edit_subject.action',
							success : function(d) {
								var json = $.parseJSON(d);
								if (json.success) {
									treegrid.treegrid('reload');
									p.dialog('close');
									parent.ctrlTree.tree('reload');/*刷新左侧菜单树*/
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
					
			
					f.form('load', node);
				}
			});
		} else {
			parent.sy.messagerAlert('提示', '请选中要修改的记录！', 'error');
		}
	}
	function append() {
		var p = parent.sy.dialog({
			title : '添加菜单',
			href : '${pageContext.request.contextPath}/back_subject/to_subject_add.action',
			width : 500,
			height : 280,
			buttons : [ {
				text : '添加',
				handler : function() {
					var f = p.find('form');
					f.form('submit', {
						url : '${pageContext.request.contextPath}/back_subject/save_subject.action',
						success : function(d) {
							var json = $.parseJSON(d);
							if (json.success) {
								treegrid.treegrid('reload');
								p.dialog('close');
								parent.ctrlTree.tree('reload');/*刷新左侧菜单树*/
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
					url : '${pageContext.request.contextPath}/back_subject/toListSub.action'
				});
			}
		});
	}
	function append1() {
		var p = parent.sy.dialog({
			title : '添加菜单',
			href : '${pageContext.request.contextPath}/back_subject/to_subject_add0.action',
			width : 500,
			height : 280,
			buttons : [ {
				text : '添加',
				handler : function() {
					var f = p.find('form');
					f.form('submit', {
						url : '${pageContext.request.contextPath}/back_subject/save_subject0.action',
						success : function(d) {
							var json = $.parseJSON(d);
							if (json.success) {
								treegrid.treegrid('reload');
								p.dialog('close');
								parent.ctrlTree.tree('reload');/*刷新左侧菜单树*/
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
				
			}
		});
	}
	function remove() {
		var node = treegrid.treegrid('getSelected');
		if (node) {
		if(node.children!=null||node.state=="closed"){
		parent.sy.messagerAlert('提示', '只能删除字节点', 'error');
		}else{
			parent.sy.messagerConfirm('询问', '您确定要删除【' + node.name + '】？', function(b) {
				if (b) {
					$.ajax({
						url : '${pageContext.request.contextPath}/back_subject/delete_subject.action',
						data : {
							id : node.id
							
						},
						cache : false,
						dataType : 'JSON',
						success : function(r) {
							if (r.success) {
							parent.sy.messagerShow({
								msg : r.msg,
								title : '提示'
							});
							treegrid.treegrid('reload');
								
							}
							
						}
					});
				}
			});
			}
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
	<div onclick="append1();" data-options="iconCls:'icon-add'">增加根节点</div>
		<div onclick="append();" data-options="iconCls:'icon-add'">增加子节点</div>
		<div onclick="remove();" data-options="iconCls:'icon-remove'">删除</div>
		<div onclick="edit();" data-options="iconCls:'icon-edit'">修改</div>
	</div>
</body>
