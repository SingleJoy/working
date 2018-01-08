<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%		String user_type = 1+"";
 %>
<jsp:include page="../inc.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var datagrid;
	$(function(){
		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/back_certification/certificating.action?type=1',
			title : '管理员申请列表',
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
			sortName : 'apply_time',
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
				field : 'username',
				width : 100,
				sortable : true,
				formatter:function(value, rowData, rowIndex){
				
				return rowData.username;
				}
			} ] ],
			columns : [ [ 
			{
				title : '真实姓名',
				field : 'true_name',
				sortable : true,
				width : 100,
			},
			{
				title : '所属学校或单位',
				field : 'school',
				sortable : true,
				width : 200,
			},
			{
				title : '是否推荐',
				field : 'is_recommended',
				sortable : true,
				width : 60,
				formatter:function(value, rowData, rowIndex){
				if(rowData.is_recommended==0){
				return "否";
				
				}
				else{
				return "是";
				
				}
				
				}
			},
			{
				title : '申请类别',
				field : 'type',
				sortable : true,
				width : 80,
				formatter:function(value, rowData, rowIndex){
				if(rowData.type==0){
				return "老师";
				
				}
				if(rowData.type==1){
				return "学校管理员";
				
				}
				if(rowData.type==2){
				return "县级管理员";
				
				}
				if(rowData.type==3){
				return "市级管理员";
				
				}
				if(rowData.type==4){
				return "省级管理员";
				
				}
				
				
				}
			},
			{
				title : '状态',
				field : 'certificated',
				sortable : true,
				width : 80,
				formatter:function(value, rowData, rowIndex){
				if(rowData.certificated==0){
				return "未审核";
				}
					if(rowData.certificated==1){
					return "审核通过";
				}
					if(rowData.certificated==2){
					return "审核不通过";
				}
				
				
				
				}
			},
			{
				title : '申请时间',
				field : 'apply_time',
				sortable : true,
				width : 150,
			},
				{
				title : '审核时间',
				field : 'review_time',
				sortable : true,
				width : 150,
			},
			{
				title : '详情',
				field : 'statusType',
				width : 150,
				formatter:function(value, rowData, rowIndex){
				var html="";
				html+='<a href="javascript:void(0);" onclick="xiangqing(\'' + rowData.id+ '\');">查看详情</a>&nbsp;';
				if(rowData.certificated==1){
				if(rowData.is_recommended==0){
				 html+='<a href="javascript:void(0);" onclick="recommended(\'' + rowData.id+ '\');">学校推荐</a>';
			}else{
			 html+='<a href="javascript:void(0);" onclick="unRecommended(\'' + rowData.id+ '\');">取消推荐</a>';
			}
	}
			return html;
				
					
				}
				
			} ] ],
			toolbar : [ {
				text : '审核通过',
				iconCls : 'icon-edit',
				handler : function() {
					certificated(1);
				}
			}, '-',
			{
				text : '审核不通过',
				iconCls : 'icon-edit',
				handler : function() {
					certificated(2);
				}
			}, '-',
			{
				text : '全部',
				iconCls : 'icon-edit',
				handler : function() {
					certificated(-1);
				}
			},  '-' ],
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
	function unRecommended(id){
parent.sy.messagerConfirm('请确认', '您要处理当前所选记录？', function(r) {
				if (r) {
			$.ajax({
    		url : "${pageContext.request.contextPath}/back_certification/unRecommended.action?source_type=2&source_id="+id,
    		
    		dataType:'json',
			success : function(d) {
								
								if (d.success) {
									datagrid.datagrid('reload');
								}
								parent.sy.messagerShow({
									msg : d.msg,
									title : '提示'
								});
							}
		});
		}
		
		});
}
function recommended(id){
var p = parent.sy.dialog({
				title : '推荐设置',
				href : '${pageContext.request.contextPath}/back_certification/to_recommended.action',
					width : 420,
					height : 260,
				buttons : [ {
					text : '推荐通过',
					handler : function() {
					
					var f = p.find('form');
					f.form('submit', {
			url : "${pageContext.request.contextPath}/back_certification/recommended.action?source_type=2&source_id="+id,
    		dataType:'json',
			success : function(d) {
			var json = $.parseJSON(d);
								p.dialog('close');
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
						},
						{
					text : '取消',
					handler : function() {
					p.dialog('close');
					}
						}
						],
				onLoad : function() {
				
				}
			});

		
			
	}
function xiangqing(id){

	var p = parent.sy.dialog({
				title : '详情',
				href : '${pageContext.request.contextPath}/back_certification/to_msg.action?id='+id,
				width : 550,
				height : 620,
				buttons : [ {
					text : '审核通过',
					handler : function() {
					p.dialog('close');
					edit(1,id);
					
					}
						},{
					text : '审核不通过',
					handler : function() {
					edit(2,id);
					p.dialog('close');
					}
						},
						{
					text : '取消',
					handler : function() {
					p.dialog('close');
					}
						}
						],
				onLoad : function() {
				
				}
			});
		}
	
	function edit(n,t) {
	//selectRecord
	var rows;
	if(!t)
		 rows = datagrid.datagrid('getSelections');
		else{
		 datagrid.datagrid('unselectAll');
		 datagrid.datagrid('selectRecord',t);
		  rows = datagrid.datagrid('getSelections');
		 }
			var ids = [];
			for ( var i = 0; i < rows.length; i++) {
				    if(rows[i].certificated!=0){
				    
				    	parent.sy.messagerAlert('提示', '已经审核过了！', 'error');
				    					return false;
				    }
				    
				ids.push(rows[i].id);
					}
		if (rows.length >0) {
		if(n==1){
		parent.sy.messagerConfirm('请确认', '您要处理当前所选记录？', function(r) {
				if (r) {
			$.ajax({
    		url : "${pageContext.request.contextPath}/back_certification/certificated.action?status="+n,
    			data : {
						ids : ids.join(',')
					},
    		dataType:'json',
			success : function(d) {
								
								if (d.success) {
									datagrid.datagrid('reload');
								}
								parent.sy.messagerShow({
									msg : d.msg,
									title : '提示'
								});
							}
		});
		}
		
		});
	}
		if(n==2){
			var p = parent.sy.dialog({
				title : '原因',
				href : '${pageContext.request.contextPath}/back_certification/to_msg1.action',
				width : 550,
				height : 320,
				buttons : [ {
					text : '确定',
					handler : function() {
				 		
				var  reason=p.find("#msg").val();
				
			$.ajax({
    		url : "${pageContext.request.contextPath}/back_certification/certificated.action?status="+n+"&reason="+reason,
    			data : {
						ids : ids.join(',')
					},
    		dataType:'json',
			success : function(d) {
								
								if (d.success) {
									datagrid.datagrid('reload');
								}
								parent.sy.messagerShow({
									msg : d.msg,
									title : '提示'
								});
							}
		});
		
					p.dialog('close');
					}
						},
						{
					text : '取消',
					handler : function() {
					p.dialog('close');
					}
						}
						],
				onLoad : function() {
				
				}
			});
	}
		}
		 else {
			parent.sy.messagerAlert('提示', '请选择要编辑的记录！', 'error');
		}
	}
	function _search() {
		datagrid.datagrid('load', sy.serializeObject($('#searchForm')));
	}
	function certificated(id) {
		datagrid.datagrid('load', {certificated:id});
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		$('#searchForm input').val('');
	}

</script>

<body class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north',border:false,title:'过滤条件'" style="height: 130px;overflow: hidden;" align="left">
		<form id="searchForm" style="width: 100%;height: 100%;">
			<div style="height:100%;background-color: #efefef;padding-top: 20px;padding-left: 20px;">
				<div>
					<span>
						用户名:&nbsp;&nbsp;
						<input name="s_username" style="width:317px;" />
					</span>
					<span style="margin-left: 20px;">
						手机号:&nbsp;&nbsp;
						<input name="s_phone" style="width:317px;" />
					</span>
					
				</div>

				<div style="margin-top: 20px;">
					<span>
						地区:&nbsp;&nbsp;
						<input name="s_area" style="width:317px;" />
					</span>

					<span style="margin-left: 20px;">
						学校：&nbsp;&nbsp;
						<input name="s_school" style="width:317px;" />
						<a href="javascript:void(0);" class="easyui-linkbutton" onclick="_search();">查询</a>
						<a href="javascript:void(0);" class="easyui-linkbutton" onclick="cleanSearch();">清空</a>

					</span>

				
				</div>
			</div>
		</form>
	</div>
	<div data-options="region:'center',border:false" style="overflow: hidden;">
		<table id="datagrid"></table>
	</div>

</body>
