<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<jsp:include page="/backstage/base/inc.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var datagrid;
	var currLevel = "${sessionInfo.level}";
	var adminName = "${sessionInfo.userName}";
	$(function() {

		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/back_role/datagrid.action',
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
			sortName : 'name',
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
				title : '角色名称',
				field : 'name',
				width : 150,
				sortable : true
			} ] ],
			columns : [ [ {
				title : '备注',
				field : 'remarks',
				width : 150
			},  {
				title : '等级',
				field : 'level',
				sortable : true,
				width : 50
			}, {
				title : '拥有权限ID',
				field : 'authIds',
				width : 300,
				hidden : true
			}, {
				title : '拥有权限',
				field : 'authNames',
				width : 300,
				sortable : true,
				formatter:function(v){
					return lencut(v,60);
				}
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
	
	function edit() {
		var rows = datagrid.datagrid('getSelections');
		if (rows.length == 1) {
			if(rows[0].level>currLevel||adminName=='admin'){
				var p = parent.sy.dialog({
					title : '编辑角色',
					href : '${pageContext.request.contextPath}/back_role/to_role_edit.action',
					width : 410,
					height : 330,
					buttons : [ {
						text : '编辑',
						handler : function() {
							var f = p.find('form');
							f.form('submit', {
								url : '${pageContext.request.contextPath}/back_role/edit_role.action',
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
						var authIds = f.find('input[name=authIds]');
						var authIdsTree = authIds.combotree({
							lines : true,
							url : '${pageContext.request.contextPath}/back_auth/doNotNeedSession_tree_recursive.action',
							checkbox : true,
							multiple : true,
							cascadeCheck : false,
							onLoadSuccess : function() {
								parent.$.messager.progress('close');
							},
							onCheck : function(node,checked){
								var tt = authIds.combotree("tree");
				                var childNode = tt.tree("getChildren",node.target);
								if(checked){
					                for(var i=0;i<childNode.length;i++){
					                	 tt.tree("check", childNode[i].target);
					                }
								}else{
									for(var i=0;i<childNode.length;i++){
					                	 tt.tree("uncheck", childNode[i].target);
					                }
								}
							}
							
						});
						f.form('load', {
							id : rows[0].id,
							name : rows[0].name,
							level : rows[0].level,
							remarks : rows[0].remarks,
							authIds : sy.getList(rows[0].authIds)
						});
					}
				});
			}else{
				parent.sy.messagerAlert('提示', '您没有权限编辑该角色，请联系admin用户解决！', 'error');
			}
		} else if (rows.length > 1) {
			parent.sy.messagerAlert('提示', '同一时间只能编辑一条记录！', 'error');
		} else {
			parent.sy.messagerAlert('提示', '请勾选要编辑的记录！', 'error');
		}
	}
	function append() {
		var p = parent.sy.dialog({
			title : '添加角色',
			href : '${pageContext.request.contextPath}/back_role/to_role_add.action',
			width : 410,
			height : 300,
			buttons : [ {
				text : '添加',
				handler : function() {
					var f = p.find('form');
					f.form('submit', {
						url : '${pageContext.request.contextPath}/back_role/save_role.action',
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
				var authIds = f.find('input[name=authIds]');
				var authIdsTree = authIds.combotree({
					lines : true,
					url : '${pageContext.request.contextPath}/back_auth/doNotNeedSession_tree_recursive.action',
					checkbox : true,
					multiple : true,
					cascadeCheck:false,
					onCheck : function(node,checked){
						var tt = authIds.combotree("tree");
		                var childNode = tt.tree("getChildren",node.target);
						if(checked){
			                for(var i=0;i<childNode.length;i++){
			                	 tt.tree("check", childNode[i].target);
			                }
						}else{
							for(var i=0;i<childNode.length;i++){
			                	 tt.tree("uncheck", childNode[i].target);
			                }
						}
					}
				});
			}
		});
	}
	function remove() {
		var rows = datagrid.datagrid('getChecked');
		var ids = [];
		if (rows.length > 0) {
			for ( var i = 0; i < rows.length; i++) {
				if(rows[i].level<=currLevel&&adminName!='admin'){
					parent.sy.messagerAlert('提示', '您的角色等级低于您勾选的角色等级，请联系admin用户解决！', 'error');
					return;
				}
			}
			parent.sy.messagerConfirm('请确认', '您要删除当前所选项目？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						ids.push(rows[i].id);
					}
					$.ajax({
						url : '${pageContext.request.contextPath}/back_role/delete_role.action',
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
