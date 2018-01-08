<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%		String user_type = 1+"";
 %>
<jsp:include page="/backstage/base/inc.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var datagrid;
	$(function(){
		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/back_user/datagrid.action?user_type='+<%=user_type%>,
			title : '用户列表',
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
			sortOrder : 'asc',
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
				field : 'username',
				width : 150,
				sortable : true
			} ] ],
			columns : [ [ {
				title : '金额',
				field : 'wealth',
				sortable : true,
				width : 100,
			},{
				title : '积分',
				field : 'score',
				sortable : true,
				width : 100,
			},{
				title : '操作',
				field : 'statusType',
				width : 150,
				formatter:function(value, rowData, rowIndex){
					
			return '<a href="javascript:void(0);" onclick="doWealth(\'' + rowData.id+ '\');">金额详情</a>&nbsp;<a href="javascript:void(0);" onclick="doScore(\'' + rowData.id + '\');">积分详情</a>';
				
					
				}
				
			} ] ],
			toolbar : [ {
				text : '编辑',
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
	function doWealth(id){
	var p = parent.sy.dialog({
				title : '金额详情',
				href : '${pageContext.request.contextPath}/back_wealth/to_msg.action?type=1&id='+id,
				width : 600,
				height : 420,
				buttons : [ {
					text : '确定',
					handler : function() {
					p.dialog('close');
					}
						}],
				onLoad : function() {
				
				}
			});
		}
	function doScore(id){
	var p = parent.sy.dialog({
				title : '积分详情',
				href : '${pageContext.request.contextPath}/back_wealth/to_msg.action?type=2&id='+id,
				width : 600,
				height : 420,
				buttons : [ {
					text : '确定',
					handler : function() {
					p.dialog('close');
					}
						}],
				onLoad : function() {
				
				}
			});
	}
  
	function edit() {
		var rows = datagrid.datagrid('getSelections');
		if (rows.length >0) {
			var p = parent.sy.dialog({
				title : '编辑',
				href : '${pageContext.request.contextPath}/back_wealth/to_wealth_edit.action',
				width : 500,
				height : 280,
				buttons : [ {
					text : '编辑',
					handler : function() {
						var f = p.find('form');
						f.form('submit', {
							url : '${pageContext.request.contextPath}/back_wealth/edit_wealth.action',
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
				var ids="";
					for ( var i = 0; i < rows.length; i++) {
					ids+=rows[i].id+",";
					}
					 f.form('load', {
						ids : ids
						
					});
				}
			});
		
		} else {
			parent.sy.messagerAlert('提示', '请选择要编辑的记录！', 'error');
		}
	}
	
	function _search() {
		datagrid.datagrid('load', sy.serializeObject($('#searchForm')));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		$('#searchForm input').val('');
	}
	function change(){
	var weath_to_score=$("#weath_to_score").val();
	          
	          var myreg=/^[0-9]*$/;

if(!myreg.test(weath_to_score)){
parent.sy.messagerShow({
								msg : '请输入数字',
								title : '提示'
							});
 		return false;
 	}
	          
	          $.ajax({
	          
	          url : '${pageContext.request.contextPath}/back_wealth/change.action',
						data : {
							weath_to_score : weath_to_score
							
						},
						cache : false,
						dataType : 'JSON',
						success : function(r) {
							if (r.success) {
							parent.sy.messagerShow({
								msg : r.msg,
								title : '提示'
							});
							datagrid.datagrid('reload');
								
							}
							
						}
	          
	          });
	
	
	}
</script>

<body class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north',border:false,title:'过滤条件'" style="height: 160px;overflow: hidden;" align="left">
		<form id="searchForm" style="width: 100%;height: 100%;">
			<table class="tableForm datagrid-toolbar" style="width: 100%;height: 100%;">
				<tr>
					<th>用户名</th>
					<td><input name="username" style="width:317px;" />
					<a href="javascript:void(0);" class="easyui-linkbutton" onclick="_search();">查询</a><a href="javascript:void(0);" class="easyui-linkbutton" onclick="cleanSearch();">清空</a>
				</td>
				</tr>
				<tr>
					<th>积分规则</th>
					<td><input id="weath_to_score" name="weath_to_score" style="width:317px;"value="${weath_to_score}"/>
					<a href="javascript:void(0);" class="easyui-linkbutton" onclick="change();">修改</a>
					<i style="color: red;font-size: 8pt">财富转换积分的倍数</i>
				</td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',border:false" style="overflow: hidden;">
		<table id="datagrid"></table>
	</div>

</body>
