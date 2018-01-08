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
			url : '${pageContext.request.contextPath}/back_file_comment/datagrid.action',
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
			sortName : 'upload_time',
			sortOrder : 'desc',
			checkOnSelect : false,
			selectOnCheck : true,
			frozenColumns : [ [ {
				title : '编号',
				field : 'id',
				width : 150,
				sortable : true,
				checkbox : true
			}, {
				title : '文档名称',
				field : 'file_base.filename',
				width : 250,
				sortable : true,
				formatter:function(value,rowData,rowIndex){
				
					return '<a href="javascript:void(0);" onclick="viewDetails('+rowData.id+')" >'+rowData.filename+'</a>';
				}
			} ] ],
			columns : [ [ {
				title : '上传人',
				field : 'user.username',
				width : 100,
				sortable : true,
				formatter:function(value, rowData, rowIndex){
				
				return rowData.user.username;
				}
			},{
				title : '上传时间',
				field : 'file_base.upload_time',
				sortable : true,
				width : 150,
				formatter:function(value, rowData, rowIndex){
				
				return rowData.upload_time;
				}
			},
			{
				title : '点击数',
				field : 'file_property.click_times',
				width : 100,
				sortable : true,
				formatter:function(value, rowData, rowIndex){
					
					return rowData.file_property.click_times;
					
				}
			}, {
				title : '收藏数',
				field : 'file_property.collection_times',
				width : 100,
				sortable : true,
				formatter:function(value, rowData, rowIndex){
					
					return rowData.file_property.collection_times;
					
				}
				
			}, {
				title : '下载数',
				field : 'file_property.download_times',
				width : 100,
				sortable : true,
				formatter:function(value, rowData, rowIndex){
					
					return rowData.file_property.download_times;
					
				}
			
			},  {
				title : '评分',
				field : 'file_property.score',
				width : 100,
				sortable : true,
				formatter:function(value, rowData, rowIndex){
					
					return rowData.file_property.score;
					
				}
			},{
				title : '评论详情',
				field : 'commentType',
				width : 150,
				formatter:function(value, rowData, rowIndex){
					
					var fid=rowData.id;
					return '<a href="javascript:void(0);" onclick="comment('+fid+')" >查看</a>';
				}
			} ] ],
			
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
		function comment(id){
	var p = parent.sy.dialog({
				title : '评论详情',
				href : '${pageContext.request.contextPath}/back_file_comment/to_msg.action?id='+id,
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
	function viewDetails(value){
		var p = parent.sy.dialog({
			title : '文档详情',
			href : '${pageContext.request.contextPath}/back_file/to_file_detail.action',
			width : 530,
			height : 400,
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
					url : '${pageContext.request.contextPath}/back_file/query_fileDetail.action',
					data : {
						id : value
					},
					dataType : 'json',
					success : function(d) {
						if(d.success){
							f.form('load', {
								title : d.obj.title,
								profile : d.obj.profile,
								type : d.obj.type,
								labels : d.obj.labels,
								columnName : d.obj.columnName,
								version : d.obj.version,
								grade : d.obj.grade,
								price : d.obj.price,
								status : d.obj.status,
								reason : d.obj.reason,
							});
						}
					}
				});
			},
		});
	}

	function _search() {
		datagrid.datagrid('load', sy.serializeObject($('#searchForm')));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		$('#searchForm input').val('');
	}
</script>
</head>
<body class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north',border:false,title:'过滤条件'" style="height: 160px;overflow: hidden;" align="left">
		<form id="searchForm" style="width: 100%;height: 100%;">
			<table class="tableForm datagrid-toolbar" style="width: 100%;height: 100%;">
				<tr>
					<th>文档名称</th>
					<td>
						<input name="filename" style="width:317px;" />
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
</html>