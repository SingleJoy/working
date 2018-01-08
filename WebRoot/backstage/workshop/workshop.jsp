<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/backstage/base/inc.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var datagrid;
	$(function() {

		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/back_workshop/datagrid.action',
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
				title : '工作坊',
				field : 'name',
				width : 200,
				formatter:function(value,rowData,rowIndex){
					return lencut(value,15);
				} 
			},{
				title : '坊主',
				field : 'workshop_user',
				sortable : true,
				width : 80
			},{
				title : '所属社区',
				field : 'community_name',
				width : 150,
			},{
				title : '学段',
				field : 'periodName',
		/* 		sortable : true, */
				width : 60
			}] ],
			columns : [ [ {
				title : '学科',
				field : 'subjectName',
				width : 80
			}, {
				title : '人数',
				field : 'user_count',
				sortable : true,
				width : 50
			}, {
				title : '创建日期',
				field : 'create_time',
				sortable : true,
				width : 170
			}, {
				title : '推荐',
				field : 'recommended',
				sortable : true,
				width : 50,
				formatter:function(value, rowData, rowIndex){
					 if(value==0){
						return "否";
					}else if(value>0){
						return "是";
					}else{
						return "";
					} 
				}
			}, {
				title : '状态',
				field : 'status',
				sortable : true,
				width : 50,
				formatter:function(value, rowData, rowIndex){
					if(value==0){
						return "已开启";
					}else if(value==1){
						return "已关闭";
					}else{
						return "";
					}
				}
			},{
				title : '操作',
				field : 'statusType',
				width : 150,
				formatter:function(value, rowData, rowIndex){
					var rows = datagrid.datagrid('getRows');
					var row = rows[rowIndex];
					var htmlval = '<a href="javascript:void(0);" onclick="toWorkshopDetail('+row.id+');"  >查看</a>&nbsp;&nbsp;';
					if(row.status==0){//已开启
						htmlval += '<a href="javascript:void(0);" onclick="updateStatus(1,'+row.id+')" >关闭</a>&nbsp;&nbsp;';
					}else {//已关闭
						htmlval += '<a href="javascript:void(0);" onclick="updateStatus(0,'+row.id+')" >开启</a>&nbsp;&nbsp;';
					}
					if(row.recommended==0){//未推荐
						htmlval += '<a href="javascript:void(0);" onclick="doRecommend('+row.id+','+row.community_id+')" >推荐</a>&nbsp';
					}else{
						htmlval += '<a href="javascript:void(0);" onclick="removeRecommend('+row.id+')" >取消推荐</a>&nbsp';
					}
					
					return htmlval;
				}
			} ] ],
			toolbar : [ {
				text : '增加',
				iconCls : 'icon-add',
				handler : function() {
					append();
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
			}, '-'],
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
	
	function append() {
		var p = parent.sy.dialog({
			title : '添加工作坊',
			href : '${pageContext.request.contextPath}/back_workshop/to_workshop_add.action',
			width : 600,
			height : 450, 
			resizable : true, 
			buttons : [ {
				text : '添加',
				handler : function() {
					var f = p.find('form');
					f.form('submit', {
						url : '${pageContext.request.contextPath}/back_workshop/add_workshop.action',
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
	function edit() {
		var rows = datagrid.datagrid('getSelections');
		if (rows.length == 1) {
			var p = parent.sy.dialog({
				title : '编辑工作坊',
				href : '${pageContext.request.contextPath}/back_workshop/to_workshop_add.action?id='+rows[0].id,
				width : 700,
				height : 600,
				buttons : [ {
					text : '编辑',
					handler : function() {
						var f = p.find('form');
						f.form('submit', {
							url : '${pageContext.request.contextPath}/back_workshop/add_workshop.action',
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
		} else if (rows.length > 1) {
			parent.sy.messagerAlert('提示', '同一时间只能编辑一条记录！', 'error');
		} else {
			parent.sy.messagerAlert('提示', '请选择要编辑的记录！', 'error');
		}
	}
	
    function toWorkshopDetail(value){
    	window.open("${pageContext.request.contextPath}/community/to_community_index.action?sourceType=1&stamp=5&id="+value);
    }
	
	//取消推荐工作坊
	function removeRecommend(value){
		$.ajax({
			url : '${pageContext.request.contextPath}/back_workshop/unrecommended.action',
			data:{
				source_id : value,
				source_type : 6
			},
			success : function(d) {
				var json = $.parseJSON(d);
				if (json.success) {
					datagrid.datagrid('reload');
				}
				parent.sy.messagerShow({
					msg : json.msg,
					title : '提示'
				});
			}
		});
	}
	
	//设置推荐工作坊
	function doRecommend(source_id,community_id) {
		var p = parent.sy.dialog({
			title : '设置推荐工作坊',
			href : '${pageContext.request.contextPath}/back_workshop/to_recommend_workshop.action',
			width : 420,
			height : 260,
			buttons : [ {
				text : '确定',
				handler : function() {
					var f = p.find('form');
					f.form('submit', {
						url : '${pageContext.request.contextPath}/back_workshop/recommended.action',
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
				$.ajax({
					url : '${pageContext.request.contextPath}/back_workshop/get_max_seq.action',
					data : {
						community_id : community_id
					},
					dataType : 'json',
					success : function(d) {
						if(d.success){
							f.form('load', {
								seq : d.obj,
								source_id : source_id,
								source_type : 6
							});
						}
						
					}
				});
			}
		});
	}
	
	
	function updateStatus(status,id) {//关闭
		var rows = datagrid.datagrid('getSelections');
		var ids = [];
		if (rows.length > 0||id!=null) {
			parent.sy.messagerConfirm('请确认', '您要更改当前所选工作坊状态？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						ids.push(rows[i].id);
					}
					if($.inArray(id, ids)==-1){
						ids.push(id)
					}
					$.ajax({
						url : '${pageContext.request.contextPath}/back_workshop/update_status.action',
						data : {
							ids : ids.join(','),
							status : status
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
			parent.sy.messagerAlert('提示', '请勾选要更改的工作坊！', 'error');
		}
	}
	
	
	function _search() {
		datagrid.datagrid('load', sy.serializeObject($('#searchForm')));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		$('#searchForm input').val('');
		$('#searchForm select').val('-1');
	}
</script>
</head>
<body class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north',border:false,title:'过滤条件'" style="height: 140px;overflow: hidden;" align="left">
		<form id="searchForm" style="width: 100%;height: 100%;">
			<div style="height:100%;background-color: #efefef;padding-top: 20px;padding-left: 20px;">
				<div>
					<span>工作坊：&nbsp;&nbsp;

						<input name="name" style="width:150px;" />
					</span>
					<span style="margin-left: 20px;">所属社区：&nbsp;&nbsp;
						<input name="community_name" style="width:150px;" />
					</span>
				</div>
				<div style="margin-top: 20px;">
					<span>状&nbsp;&nbsp;&nbsp; 态：

						<select name="status" style="height: 21px;width: 150px;margin-left: 5px;">
							<option value="-1">请选择</option>
							<option value="0">已开启</option>
							<option value="1">已关闭</option>
						</select>
					</span>

					<span style="margin-left: 25px;">创建时间：&nbsp;&nbsp;

						<input name="timeStart" class="easyui-datebox" data-options="editable:false" style="width: 155px;" />
					     &nbsp;至&nbsp;
						<input name="timeEnd" class="easyui-datebox" data-options="editable:false" style="width: 155px;" />
						<a href="javascript:void(0);" class="easyui-linkbutton" onclick="_search();" style="margin-left: 20px;">查询</a>
						<a href="javascript:void(0);" class="easyui-linkbutton" onclick="cleanSearch();" style="margin-left: 20px;"> 清空</a>
					</span>

				</div>
			</div>
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
</html>