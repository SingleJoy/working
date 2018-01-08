<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/backstage/base/inc.jsp"></jsp:include>
<%--教研管理->教研管理--%>
<script type="text/javascript" charset="utf-8">
	var datagrid;
	$(function() {

		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/back_lesson/datagrid.action',
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
				title : '课例名称',
				field : 'name',
				width : 200,
				formatter:function(value,rowData,rowIndex){
					return lencut(value,15);
				} 
			},{
				title : '组长',
				field : 'lesson_username',
				sortable : true,
				width : 80
			},{
				title : '所属工作坊',
				field : 'workshop_name',
				width : 150,
			},{
				title : '年级',
				field : 'grade',
		/* 		sortable : true, */
				width : 80
			}] ],
			columns : [ [ {
				title : '学科',
				field : 'subject',
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
				field : 'open_status',
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
					var htmlval = '<a href="javascript:void(0);" onclick="toLessonDetail('+row.id+');"  >查看</a>&nbsp;&nbsp;';
					if(row.open_status==0){//已开启
						htmlval += '<a href="javascript:void(0);" onclick="updateOpenStatus(1)" >关闭</a>&nbsp;&nbsp;';
					}else {//已关闭
						htmlval += '<a href="javascript:void(0);" onclick="updateOpenStatus(0)" >开启</a>&nbsp;&nbsp;';
					}
					if(row.recommended==0){//未推荐
						htmlval += '<a href="javascript:void(0);" onclick="doRecommend('+row.id+','+row.workshop_id+')" >推荐</a>&nbsp';
					}else{
						htmlval += '<a href="javascript:void(0);" onclick="removeRecommend('+row.id+')" >取消推荐</a>&nbsp';
					}
					
					return htmlval;
				}
			} ] ],
			toolbar : [ {
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
	
    function toLessonDetail(value){
    	window.open("${pageContext.request.contextPath}/lesson/to_lesson_plan.action?lesson_id="+value+"&show=1&stamp=0&state=101");
    }
	
	//取消推荐课例
	function removeRecommend(value){
		$.ajax({
			url : '${pageContext.request.contextPath}/back_workshop/unrecommended.action',
			data:{
				source_id : value,
				source_type : 5
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
	
	//设置推荐课例
	function doRecommend(source_id,workshop_id) {
		var p = parent.sy.dialog({
			title : '设置推荐课例',
			href : '${pageContext.request.contextPath}/back_lesson/to_recommend_lesson.action',
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
					url : '${pageContext.request.contextPath}/back_lesson/get_max_seq.action',
					data : {
						workshop_id : workshop_id
					},
					dataType : 'json',
					success : function(d) {
						if(d.success){
							f.form('load', {
								seq : d.obj,
								source_id : source_id,
								source_type : 5
							});
						}
						
					}
				});
			}
		});
	}
	
	
	function updateOpenStatus(open_status) {//关闭
		var rows = datagrid.datagrid('getChecked');
		var ids = [];
		if (rows.length > 0) {
			parent.sy.messagerConfirm('请确认', '您要更改当前所选课例状态？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						ids.push(rows[i].id);
					}
					$.ajax({
						url : '${pageContext.request.contextPath}/back_lesson/update_open_status.action',
						data : {
							ids : ids.join(','),
							open_status : open_status
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
			parent.sy.messagerAlert('提示', '请勾选要更改的课例！', 'error');
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

<body class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north',border:false,title:'过滤条件'" style="height: 120px;overflow: hidden;" align="left">
		<form id="searchForm" style="width: 100%;height: 100%;">
			<div style="height:100%;background-color: #efefef;padding-top: 20px;padding-left: 20px;">
				<div>
					<span>课例名称:&nbsp;&nbsp;

						<input name="name" style="width:150px;" />
					</span>
					<span style="margin-left: 20px;">所属工作坊:&nbsp;&nbsp;
						<input name="workshop_name" style="width:150px;" />
					</span>
				</div>

			   <div style="margin-top:20px;">
				   
					<span>课例状态:&nbsp;&nbsp;

						<select name="open_status" style="height: 21px;width: 70px;">
							<option value="-1">请选择</option>
							<option value="0">已开启</option>
							<option value="1">已关闭</option>
						</select>
					</span>

					<span style="margin-left: 20px;">创建时间：&nbsp;&nbsp;

						<input name="timeStart" class="easyui-datebox" data-options="editable:false" style="width: 155px;" />
						&nbsp;&nbsp;至&nbsp;&nbsp;
						<input name="timeEnd" class="easyui-datebox" data-options="editable:false" style="width: 155px;" />
						<a href="javascript:void(0);" class="easyui-linkbutton" onclick="_search();" style="margin-left: 20px;">查询</a>
						<a href="javascript:void(0);" class="easyui-linkbutton" onclick="cleanSearch();" style="margin-left: 20px;">清空</a>
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
