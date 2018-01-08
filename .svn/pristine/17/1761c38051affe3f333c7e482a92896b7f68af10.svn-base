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
			url : '${pageContext.request.contextPath}/back_user_appraise/datagrid1.action',
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
			}
			 ] ],
			columns : [ [ 	  {
				title : '名称',
				field : 'title',
				width : 150,
				sortable : true,
			}, {
				title : '星级',
				field : 'level',
				width : 150,
				sortable : true,
				
			},
			{
				title : '类型',
				field : 'type',
				width : 150,
				sortable : true,
				formatter:function(value, rowData, rowIndex){
					if(value=='0'){
						return '课程';
					}else if(value=='1'){
						return '培训';
					}else if(value=='2'){
						return '课例';
					}else if(value=='3'){
						return '资源';
					}
				}
			} ,
			{
				title : '创建时间',
				field : 'create_time',
				sortable : true,
				width : 150
			
			} ] ], 
			toolbar : [ {
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
			}, '-', {
				text : '列显示隐藏',
				iconCls : 'icon-add',
				handler : function(e) {
					menu(e);
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
   function menu(e) {
   var headerContextMenu = this.headerContextMenu;/* 得到grid的列头菜单对象 */
if (!headerContextMenu) {
   var tmenu = $('<div style="width:100px;"></div>').appendTo('body');
   var grid=$('#datagrid');
var fields = $('#datagrid').datagrid('getColumnFields');
for ( var i = 0; i < fields.length; i++) {
var fildOption = grid.datagrid('getColumnOption', fields[i]);
if (!fildOption.hidden) {
$('<div iconCls="icon-ok" field="' + fields[i] + '"/>').html(fildOption.title).appendTo(tmenu);
} else {
$('<div iconCls="icon-empty" field="' + fields[i] + '"/>').html(fildOption.title).appendTo(tmenu);
}
}

headerContextMenu = this.headerContextMenu = tmenu.menu({
onClick : function(item) {
var field = $(item.target).attr('field');
if (item.iconCls == 'icon-ok') {
grid.datagrid('hideColumn', field);
$(this).menu('setIcon', {
target : item.target,
iconCls : 'icon-empty'
});
} else {
grid.datagrid('showColumn', field);
$(this).menu('setIcon', {
target : item.target,
iconCls : 'icon-ok'
});
}
}
});
}
headerContextMenu.menu('show', {
left : e.pageX,
top : e.pageY
});
};
$.fn.datagrid.defaults.onHeaderContextMenu = createGridHeaderContextMenu;
$.fn.treegrid.defaults.onHeaderContextMenu = createGridHeaderContextMenu; 








	function edit() {
		var rows = datagrid.datagrid('getSelections');
		if (rows.length == 1) {
			var p = parent.sy.dialog({
				title : '编辑评价项',
				href : '${pageContext.request.contextPath}/back_user_appraise/to_appraise_edit.action',
				width : 420,
				height : 260,
				buttons : [ {
					text : '编辑',
					handler : function() {
						var f = p.find('form');
						f.form('submit', {
							url : '${pageContext.request.contextPath}/back_user_appraise/edit_appraise.action',
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
						type : rows[0].type,
				        level : rows[0].level,
						title : rows[0].title
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
			title : '添加评价项',
			href : '${pageContext.request.contextPath}/back_user_appraise/to_appraise_add.action',
			width : 420,
			height : 260,
			buttons : [ {
				text : '添加',
				handler : function() {
					var f = p.find('form');
					f.form('submit', {
						url : '${pageContext.request.contextPath}/back_user_appraise/save_appraise.action',
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
						url : '${pageContext.request.contextPath}/back_user_appraise/delete_appraise.action',
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
		<div onclick="append();" data-options="iconCls:'icon-add'">增加</div>
		<div onclick="remove();" data-options="iconCls:'icon-remove'">删除</div>
		<div onclick="edit();" data-options="iconCls:'icon-edit'">编辑</div>
	</div>
</body>
</html>