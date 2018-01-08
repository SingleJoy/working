<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<jsp:include page="/backstage/base/inc.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var datagrid;
	$(function(){
		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/back_order/datagrid.action',
			title : '订单列表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			fitColumns : false,
			nowrap : false,
			border : false,
			idField : 'id',
			sortName : 'create_time',
			sortOrder : 'desc',
			checkOnSelect : true,
			selectOnCheck : true,
			frozenColumns : [ [  {
				title : '编号',
				field : 'id',
				width : 150,
				sortable : true,
				checkbox : true
			}, {
				title : '用户名',
				field : 'user',
				width : 200,
				sortable : true,
				formatter:function(v){
				var userName=v.username;
				return userName;
				}
			} ] ],
			columns : [ [ {
				title : '资源名称',
				field : 'file_base',
				width : 300,
				formatter:function(v){
				var fileName=v.filename;
				return fileName;
				}
			},{
				title : '订单号',
				field : 'order_number',
				width : 150,
			}, 
			{
				title : '创建时间',
				field : 'create_time',
				sortable : true,
				width : 150
			}, 
			 {
				title : '交易时间',
				field : 'transaction_time',
				width : 150
			},
			 {
				title : '金额',
				sortable : true,
				field : 'transaction_amount',
				width : 50,
				formatter:function(v){
				
				return v+"元";
				}
		    }, {
				title : '状态',
				field : 'is_success',
				width : 70,
				sortable : true,
				formatter:function(v){
					if(v=="0"){
						return '关闭交易';
					}else if(v=="1"){
						return '未支付';
					}else if(v=="2"){
						return "已支付";
					}
				} 
			}/* ,{
				title : '操作',
				field : 'statusType',
				width : 150,
				sortable : true,
				formatter:function(value, rowData, rowIndex){
					var rows = datagrid.datagrid('getRows');
					var row = rows[rowIndex];
					
				}
				
			} */ ] ],
			toolbar : [{
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
					datagrid.datagrid('clearSelections');
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
			var p = parent.sy.dialog({
				title : '编辑用户',
				href : '${pageContext.request.contextPath}/back_order/to_order_edit.action',
				width : 500,
				height : 280,
				buttons : [ {
					text : '编辑',
					handler : function() {
						var f = p.find('form');
						f.form('submit', {
							url : '${pageContext.request.contextPath}/back_order/edit_order.action',
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
						transaction_amount : rows[0].transaction_amount,
						is_success: rows[0].is_success,
					});
				}
			});
		} else if (rows.length > 1) {
			parent.sy.messagerAlert('提示', '同一时间只能编辑一条记录！', 'error');
		} else {
			parent.sy.messagerAlert('提示', '请选择要编辑的记录！', 'error');
		}
	}
	
	function remove() {
		var rows = datagrid.datagrid('getChecked');
		
		var ids = [];
		if (rows.length > 0) {
			parent.sy.messagerConfirm('请确认', '您要删除当前所选记录？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						ids.push(rows[i].id);
					}
					$.ajax({
						url : '${pageContext.request.contextPath}/back_order/delete_order.action',
						data : {
							ids : ids.join(',')
						},
						dataType : 'json',
						success : function(d) {
						if (d.success) {
						datagrid.datagrid('reload');
							datagrid.datagrid('unselectAll');
						}
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
	function _search() {
		datagrid.datagrid('load', sy.serializeObject($('#searchForm')));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		$('#searchForm input').val('');
	}
</script>

<body class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north',border:false,title:'过滤条件'" style="height: 160px;overflow: hidden;" align="left">
		<form id="searchForm" style="width: 100%;height: 100%;">
			<table class="tableForm datagrid-toolbar" style="width: 100%;height: 100%;">
				<tr>
					<th>用户名</th>
					<td><input name="username" style="width:317px;" /></td>
				</tr>
				<tr>
					<th>订单号</th>
					<td>
					<input name="order_number" style="width:317px;" />
						<a href="javascript:void(0);" class="easyui-linkbutton" onclick="_search();">查询</a><a href="javascript:void(0);" class="easyui-linkbutton" onclick="cleanSearch();">清空</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',border:false" style="overflow: hidden;">
		<table id="datagrid"></table>
	</div>

	<div id="menu" class="easyui-menu" style="width:120px;display: none;">
		<div onclick="append();" data-options="iconCls:'icon-add'">增加</div>
		<div onclick="remove();" data-options="iconCls:'icon-remove'">删除</div>
		<div onclick="edit();" data-options="iconCls:'icon-edit'">编辑</div>
	</div>
</body>
