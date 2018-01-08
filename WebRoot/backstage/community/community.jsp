<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/backstage/base/inc.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var datagrid;
	$(function() {

		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/back_community/datagrid.action',
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
				title : '社区',
				field : 'name',
				width : 150,
				formatter:function(value,rowData,rowIndex){
					return lencut(value,15);
				} 
			},{
				title : '创建者',
				field : 'community_user',
				sortable : true,
				width : 70
			},{
				title : '类型',
				field : 'type',
				sortable : true,
				width : 60,
				formatter:function(value, rowData, rowIndex){
					if(value==0){
						return "普通";
					}else if(value==1){
						return "教师培训";
					}else{
						return "";
					}
				}
			},{
				title : '等级',
				field : 'grade',
				sortable : true,
				width : 40,
				formatter:function(value, rowData, rowIndex){
					if(value==0){
						return "省级";
					}else if(value==1){
						return "市级";
					}else if(value==2){
						return "县级";
					}else{
						return "";
					}
				}
			}] ],
			columns : [ [ {
				title : '学时',
				field : 'hour',
				sortable : true,
				width : 35
			}, {
				title : '学分',
				field : 'credit',
				sortable : true,
				width : 35
			}, {
				title : '计划人数',
				field : 'plan_num',
				sortable : true,
				width : 60
			}, {
				title : '参与人数',
				field : 'studentNum',
				sortable : true,
				width : 60
			}, {
				title : '创建时间',
				field : 'create_time',
				sortable : true,
				width : 80,
				formatter:function(v){
					var dt;
					if (v instanceof Date) {
				        dt = v;
				    } else {
				        dt = new Date(v);
				    }
				 	return dt.format("yyyy-MM-dd"); 
				}
			}, {
				title : '开始时间',
				field : 'start_time',
				sortable : true,
				width : 80,
				formatter:function(v){
					var dt;
					if (v instanceof Date) {
				        dt = v;
				    } else {
				        dt = new Date(v);
				    }
				 	return dt.format("yyyy-MM-dd"); 
				}
			},{
				title : '截止时间',
				field : 'end_time',
				sortable : true,
				width : 80,
				formatter:function(v){
					var dt;
					if (v instanceof Date) {
				        dt = v;
				    } else {
				        dt = new Date(v);
				    }
				 	return dt.format("yyyy-MM-dd"); 
				}
			}, {
				title : '推荐',
				field : 'recommended',
				sortable : true,
				width : 35,
				formatter:function(value, rowData, rowIndex){
					if(value==0){
						return "否";
					}else if(value==1){
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
				title : '需要审核',
				field : 'is_examine',
				sortable : true,
				width : 55,
				formatter:function(value, rowData, rowIndex){
					if(value==0){
						return "是";
					}else if(value==1){
						return "否";
					}else{
						return "";
					}
				}
			},{
				title : '操作',
				field : 'statusType',
				width : 100,
				formatter:function(value, rowData, rowIndex){
					var rows = datagrid.datagrid('getRows');
					var row = rows[rowIndex];
					var htmlval = '<a href="javascript:void(0);" onclick="toCommunityDetail('+row.id+');"  >查看</a>&nbsp;&nbsp;';
					if(row.status==0){//已开启
						htmlval += '<a href="javascript:void(0);" onclick="updateStatus('+rowData.id+',1)" >关闭</a>&nbsp;&nbsp;';
					}else {//已关闭
						htmlval += '<a href="javascript:void(0);" onclick="updateStatus('+rowData.id+',0)" >开启</a>&nbsp;&nbsp;';
					}
					if(row.recommended==0){//未推荐
						htmlval += '<a href="javascript:void(0);" onclick="doRecommend('+row.id+')" >推荐</a>&nbsp';
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
			},  '-', {
				text : '修改',
				iconCls : 'icon-edit',
				handler : function() {
					edit();
				}
			},'-',{
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
			title : '添加社区',
			href : '${pageContext.request.contextPath}/back_community/to_community_add.action',
			width : 700,
			height : 600,
			buttons : [ {
				text : '添加',
				handler : function() {
					var f = p.find('form');
					f.form('submit', {
						url : '${pageContext.request.contextPath}/back_community/save_community.action',
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
			}  ]
		});
	}
	
	function edit() {
		var rows = datagrid.datagrid('getSelections');
		if (rows.length == 1) {
			var p = parent.sy.dialog({
				title : '编辑社区',
				href : '${pageContext.request.contextPath}/back_community/to_community_add.action?id='+rows[0].id,
				width : 700,
				height : 600,
				buttons : [ {
					text : '编辑',
					handler : function() {
						var f = p.find('form');
						f.form('submit', {
							url : '${pageContext.request.contextPath}/back_community/save_community.action',
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
				} ]/* ,
				onLoad : function() {
					var f = p.find('form');
					var roleIds = f.find('input[name=roleIds]');
					var roleIdsCombobox = roleIds.combobox({
						url : '${pageContext.request.contextPath}/back_role/doNotNeedSession_combobox.action',
						valueField : 'id',
						textField : 'name',
						multiple : true,
						editable : false,
						panelHeight : 'auto',
						onLoadSuccess : function() {
							parent.$.messager.progress('close');
						}
					});
					f.form('load', {
						id : rows[0].id,
						name : rows[0].name,
						province : rows[0].province,
						roleIds : sy.getList(rows[0].roleIds),
						phone_old : rows[0].phone,
						name_old : rows[0].username,
						email_old : rows[0].email,
						email : rows[0].email,
					});
				} */
			});
		} else if (rows.length > 1) {
			parent.sy.messagerAlert('提示', '同一时间只能编辑一条记录！', 'error');
		} else {
			parent.sy.messagerAlert('提示', '请选择要编辑的记录！', 'error');
		}
	}
    function toCommunityDetail(value){
    	window.open("${pageContext.request.contextPath}/community/to_community_index.action?sourceType=0&stamp=5&id="+value);
    }
	
	 //取消推荐社区
	function removeRecommend(value){
		$.ajax({
			url : '${pageContext.request.contextPath}/back_workshop/unrecommended.action',
			data:{
				source_id : value,
				source_type : 7
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
	
	//设置推荐社区
	function doRecommend(source_id) {
		var p = parent.sy.dialog({
			title : '设置推荐社区',
			href : '${pageContext.request.contextPath}/back_community/to_recommend_community.action',
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
					url : '${pageContext.request.contextPath}/back_community/get_max_seq.action',
					dataType : 'json',
					success : function(d) {
						if(d.success){
							f.form('load', {
								seq : d.obj,
								source_id : source_id,
								source_type : 7
							});
						}
						
					}
				});
			}
		});
	}
	
	
	function updateStatus(id,status) {//关闭
		var rows = datagrid.datagrid('getChecked');
		var ids = [];
		parent.sy.messagerConfirm('请确认', '您要更改当前所社区状态？', function(r) {
			if (r) {
				if (rows.length > 0) {
					for ( var i = 0; i < rows.length; i++) {
						ids.push(rows[i].id);
					}
				} else{
					ids.push(id);
				}
				$.ajax({
					url : '${pageContext.request.contextPath}/back_community/update_status.action',
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
		
	}
	
	
	function _search() {
		datagrid.datagrid('load', sy.serializeObject($('#searchForm')));
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		$('#searchForm input').val('');
		$('#searchForm select').val('-1');
	}
	function changeKey(obj){
		if(obj.value!="-1"){
			$("#keyname").attr("name",obj.value);
		}
	}
</script>

<body class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north',border:false,title:'过滤条件'" style="height: 120px;overflow: hidden;" align="left">
		<form id="searchForm" style="width: 100%;height: 100%;">
			<div style="height:100%;background-color: #efefef;padding-top: 20px;padding-left: 20px;">
				<div>
					<span>关键词：&nbsp;&nbsp;
						<select  style="width:100px;height: 21px;" onchange="changeKey(this)">
							<option value="-1" selected="selected">请选择</option>
							<option value="name">社区</option>
							<option value="community_user">创建者</option>
						</select>
					</span>

					<span style="margin-left: 20px;">
						<input id="keyname" style="width:330px;" />
					</span>
					<span style="margin-left: 20px;">类型：&nbsp;&nbsp;


					    <select name="type"  style="width:100px;height: 21px;">
					    <option value="-1" selected="selected">请选择</option>
					    <option value="0">普通</option>   
					    <option value="1">教师培训</option>
						</select>
					</span>

				</div>

				<div style="margin-top: 20px;">
					<span>时&nbsp;&nbsp;&nbsp;&nbsp;间：&nbsp;
						<select  name="serach_time"  style="width:100px;height: 21px;">
							<option value="-1" selected="selected">请选择</option>
							<option value="0">创建时间</option>
							<option value="1">开始时间</option>
							<option value="2">截止时间</option>
						</select>
					</span>
					
					<span style="margin-left: 20px;">
					    <input name="timeStart" class="easyui-datebox" data-options="editable:false" style="width: 155px;" />
						&nbsp;至&nbsp;
						<input name="timeEnd" class="easyui-datebox" data-options="editable:false" style="width: 155px;" />
					</span>
					<span style="margin-left: 20px;">等级：&nbsp;&nbsp;

						<select  name="grade"  style="width:100px;height: 21px;">
							<option value="-1" selected="selected">请选择</option>
							<option value="0">省级</option>
							<option value="1">市级</option>
							<option value="2">县级</option>
						</select>

					    <a href="javascript:void(0);" class="easyui-linkbutton" onclick="_search();" style="margin-left: 20px;">查询</a>
						<a href="javascript:void(0);" class="easyui-linkbutton" onclick="cleanSearch();" style="margin-left: 20px;">清空</a>
					</span>
					
				</div>
				<!-- <tr>
					<th>类&nbsp;&nbsp;&nbsp;型：<select name="type"  style="width:100px;">   
					    <option value="-1" selected="selected">请选择</option>
					    <option value="0">普通</option>   
					    <option value="1">教师培训</option>   
					    </select></th>
					<td>
					等&nbsp;&nbsp;&nbsp;级：<select  name="grade"  style="width:100px;">   
					    <option value="-1" selected="selected">请选择</option>
					    <option value="0">省级</option>   
					    <option value="1">市级</option>
					    <option value="2">县级</option>   
					    </select>
					<a href="javascript:void(0);" class="easyui-linkbutton" onclick="_search();">查询</a><a href="javascript:void(0);" class="easyui-linkbutton" onclick="cleanSearch();">清空</a>
					</td>
				</tr> -->
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