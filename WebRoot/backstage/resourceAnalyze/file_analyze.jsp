<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/backstage/base/inc.jsp"></jsp:include>
<script type="text/javascript" src="${pageContext.request.contextPath}/stream/js/stream-v1.js"></script>
<script type="text/javascript" charset="utf-8">
   

	var datagrid;
	$(function() {

		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/back_file_analyze/datagrid.action',
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
			checkOnSelect : true,
			selectOnCheck : true,
			frozenColumns : [ [ {
				title : '编号',
				field : 'id',
				width : 150,
				sortable : true,
				checkbox : true
			}, {
				title : '文档名称',
				field : 'filename',
				width : 200,
				formatter:function(value,rowData,rowIndex){
					var rows = datagrid.datagrid('getRows');
					var row = rows[rowIndex];
					var $row = JSON.stringify(row).replace(/\"/g,"'");
					return '<a href="javascript:void(0);" title="'+value+'" onclick="viewDetails('+row.id+','+$row+')" >'+lencut(value,16)+'</a>';
				}
			} ] ],
			columns : [ [ {
				title : '下载次数',
				field : 'download_times',
				width : 100,
				hidden : true
			},
			{
				title : '类型',
				field : 'file_type',
				width : 50,
				sortable : true,
				formatter:function(v){
					if(v=="0"){
						return '文档';
					}else if(v=="1"){
						return '教案';
					}
				}
			}, {
				title : '收藏量',
				field : 'collection_times',
				width : 50,
				sortable : true
			}, {
				title : '点击数',
				field : 'click_times',
				width : 50,
				sortable : true
			}, {
				title : '评价数',
				field : 'comment_num',
				width : 50,
				sortable : true
			}, {
				title : '平均评分',
				field : 'avg_score',
				sortable : true,
				width : 50,
			}, {
				title : '上传人',
				field : 'userName',
				width : 100,
			},{
				title : '操作',
				field : 'statusType',
				width : 100,
				sortable : true,
				formatter:function(value, rowData, rowIndex){
					return '<a href="${pageContext.request.contextPath}/userFile/to_file.action?id='+rowData.id+'" target="_blank" >预览</a>';
				}
			} ] ],
			toolbar : [  {
				text : '取消选中',
				iconCls : 'icon-undo',
				handler : function() {
					datagrid.datagrid('unselectAll');
				}
			}],
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
	
	
	function viewDetails(value,obj){
		if(obj.file_type==0){
			var p = parent.sy.dialog({
				title : '文档详情',
				href : '${pageContext.request.contextPath}/back_file/to_file_detail.action?check=0&file_type='+obj.file_type,
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
		}else if(obj.file_type==1){
			var p = parent.sy.dialog({
				title : '教案详情',
				href : '${pageContext.request.contextPath}/back_file/to_file_detail.action?check=0&file_type='+obj.file_type,
				width : 530,
				height :200,
				buttons : [ {
					text : '返回',
					handler : function() {
						var f = p.find('form');
						p.dialog('close');
					}
				} ],
				onLoad : function() {
					var f = p.find('form');
					f.form('load', {
						filename : obj.filename,
						file_type : "教案",
						userName : obj.userName,
						status : obj.status,
						reason : obj.reason,
						upload_time : obj.upload_time
					});
				},
			});
		}
		
	}
	

	function _search() {
		datagrid.datagrid('load', sy.serializeObject($('#searchForm')));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		$('#searchForm input').val('');
		$('#searchForm select').val('');
	}
</script>
</head>
<body class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north',border:false,title:'过滤条件'" style="height: 160px;overflow: hidden;" align="left">
		<form id="searchForm" style="width: 100%;height: 100%;">
			<table class="tableForm datagrid-toolbar" style="width: 100%;height: 100%;">
				<tr>
					<th>类型：</th>
					<td>
					<select  name="file_type" style="width:80px;">
					    <option value="" selected="selected">请选择</option>
					    <option value="0">文档</option>
						<option value="1">教案</option>
					</select></td>
					
					<th>文&nbsp;&nbsp;&nbsp;&nbsp;档：</th>
					<td><input name="filename" style="width:207px;" /></td>
					<th>上传人：</th>
					<td><input name="userName" style="width:155px;" />
					<a href="javascript:void(0);" class="easyui-linkbutton" onclick="_search();">查询</a>&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton" onclick="cleanSearch();">清空</a>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',border:false" style="overflow: hidden;">
		<table id="datagrid"></table>
	</div>

</body>
</html>