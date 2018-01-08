<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/backstage/base/inc.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	$(function() {
		treegrid = $('#treegrid').treegrid({
			url : '${pageContext.request.contextPath}/back_classify/treegrid.action',
			toolbar : [ {
				text : '展开',
				iconCls : 'icon-redo',
				handler : function() {
					var node = treegrid.treegrid('getSelected');
					if (node) {
						treegrid.treegrid('expandAll', node.id);
					} else {
						treegrid.treegrid('expandAll');
					}
				}
			}, '-', {
				text : '折叠',
				iconCls : 'icon-undo',
				handler : function() {
					var node = treegrid.treegrid('getSelected');
					if (node) {
						treegrid.treegrid('collapseAll', node.id);
					} else {
						treegrid.treegrid('collapseAll');
					}
				}
			}, '-', {
				text : '刷新',
				iconCls : 'icon-reload',
				handler : function() {
					treegrid.treegrid('reload');
				}
			}, '-', {
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
					treegrid.treegrid('unselectAll');
				}
			}, '-' ],
			title : '',
			iconCls : 'icon-save',
			fit : true,
			fitColumns : true,
			nowrap : false,
			animate : false,
			border : false,
			idField : 'id',
			treeField : 'classify_name',
			frozenColumns : [ [{
				title : '编号',
				field : 'id',
				width : 150,
				hidden : true
			}, {
				title : '分类名称',
				field : 'classify_name',
				width : 150
			}/* , {
				title : '类型名称',
				field : 'type',
				width : 150,
				formatter:function(value,options,rowData){
                    if(value=="0"){
                       return '资源';
                    }else if(value=="1"){
                       return '课程';
                    }else if(value=="2"){
                       return '开班范围';
                    }else if(value=="3"){
                       return '职称';
                    }else if(value=="4"){
                       return '职务';
                    }else if(value=="5"){
                       return '培训';
                    }
                }
			}  */, {
				title : '描述',
				field : 'remarks',
				width : 200
			} ] ],
			columns : [ [ {
				title : '排序',
				field : 'seq',
				width : 40
			},{
				title : '创建时间',
				field : 'create_time',
				width : 150
			} ] ],
			onContextMenu : function(e, row) {
				e.preventDefault();
				$(this).treegrid('unselectAll');
				$(this).treegrid('select', row.id);
				$('#menu').menu('show', {
					left : e.pageX,
					top : e.pageY
				});
			},
			onLoadSuccess : function(row, data) {
			},
			onExpand : function(row) {
				treegrid.treegrid('unselectAll');
			},
			onCollapse : function(row) {
				treegrid.treegrid('unselectAll');
			}
			
		});

	});
		function append() {
			var p = parent.sy.dialog({
				title : '添加分类',
				href : '${pageContext.request.contextPath}/back_classify/to_classify_add.action',
				width : 500,
				height : 310,
				buttons : [ {
					text : '添加',
					handler : function() {
						var f = p.find('form');
						var type = $("#parents").find('option:selected').attr('title');
						f.append("<input type='hidden' name='type' value='"+type+"'>");
						var pid = $("#parents").val();
						f.append("<input type='hidden' name='pid' value='"+pid+"'>");
						f.form('submit', {
							url : '${pageContext.request.contextPath}/back_classify/save_classify.action',
							success : function(d) {
								var json = $.parseJSON(d);
								if (json.success) {
									treegrid.treegrid('reload');
									p.dialog('close');
								}
								parent.sy.messagerShow({
									msg : json.msg,
									title : '提示'
								});
								/* window.location.reload(); */
							}
						});  
					}
				} ],
				onLoad : function() {
					var f = p.find('form');
					var pid = $("#parents").val();
					var parent_id = f.find('input[name=parent_id]');
					var ptree = parent_id.combotree({
						lines : true,
						url : '${pageContext.request.contextPath}/back_classify/doNotNeedSession_tree_recursive.action?id='+pid
					});
				}
			});
		}
		
		function edit() {
			var node = treegrid.treegrid('getSelected');
			if (node) {
				var p = parent.sy.dialog({
					title : '修改菜单',
					href : '${pageContext.request.contextPath}/back_classify/to_classify_edit.action',
					width : 500,
					height : 350,
					buttons : [ {
						text : '修改',
						handler : function() {
							var f = p.find('form');
							var type = $("#parents").find('option:selected').attr('title');
							f.append("<input type='hidden' name='type' value='"+type+"'>");
							f.form('submit', {
								url : '${pageContext.request.contextPath}/back_classify/edit_classify.action',
								success : function(d) {
									var json = $.parseJSON(d);
									if (json.success) {
										treegrid.treegrid('reload');
										p.dialog('close');
									}
									parent.sy.messagerShow({
										msg : json.msg,
										title : '提示'
									});
									/* window.location.reload(); */
								}
							}); 
						}
					} ],
					onLoad : function() {
						var f = p.find('form');
						var parent_id = f.find('input[name=parent_id]');
						var pid = $("#parents").val();
						var ptree = parent_id.combotree({
							lines : true,
							url : '${pageContext.request.contextPath}/back_classify/doNotNeedSession_tree_recursive.action?id='+pid,
							onLoadSuccess : function() {
								parent.$.messager.progress('close');
							}
						});
						f.form('load', node);
					}
				});
			}else {
				parent.sy.messagerAlert('提示', '请选中要修改的记录！', 'error');
			}
		}
		
		function remove() {
			var node = treegrid.treegrid('getSelected');
			if (node) {
				parent.sy.messagerConfirm('询问', '您确定要删除【' + node.classify_name + '】？', function(b) {
					if (b) {
						$.ajax({
							url : '${pageContext.request.contextPath}/back_classify/delete_classify.action',
							data : {
								id : node.id
							},
							cache : false,
							dataType : 'JSON',
							success : function(r) {
								if (r.success) {
									treegrid.treegrid('remove', r.obj);
								}
								parent.sy.messagerShow({
									msg : r.msg,
									title : '提示'
								});
							}
						});
					}
				});
			}else{
				parent.sy.messagerAlert('提示', '请选中要删除的记录！', 'error');
			}
		}
		function _search() {
			var p = $("#parents").val();
			$.post('${pageContext.request.contextPath}/back_classify/treegrid.action',
				   {id:p},
				   function(data){
				     treegrid.treegrid('loadData',data);
				   },
				   'json');
			/* treegrid.treegrid({url:'${pageContext.request.contextPath}/back_classify/treegrid.action?parent_id='+$("#parents").val()});   */
		}
		function cleanSearch() {
			$('#searchForm select').val(''); 
			treegrid.treegrid({url:'${pageContext.request.contextPath}/back_classify/treegrid.action'});  
		}
</script>


<body class="easyui-layout" data-options="fit:true">
<div data-options="region:'north',border:false,title:'过滤条件'" style="height: 90px;overflow: hidden;" align="left">
		<form id="searchForm" style="width: 100%;height: 100%;">
			<div style="height:100%;background-color: #efefef;padding-top: 20px;padding-left: 20px;">

				    <span>请选择：</span>
					<select id="parents" name="id" style="margin-left: 20px;height: 21px;">
					<c:forEach items="${list}" var="p">
						<option value="${p.id}" title="${p.type}">${p.classify_name}</option>
					</c:forEach>
					</select>

					<a href="javascript:void(0);" class="easyui-linkbutton" onclick="_search();" style="margin-left: 20px;">查询</a>
				    <a href="javascript:void(0);" class="easyui-linkbutton" onclick="cleanSearch();" style="margin-left: 20px;">清空</a>



			</div>
		</form>
	</div>
	<div data-options="region:'center',border:false" style="overflow: hidden;">
		<table id="treegrid" ></table>
	</div>

	<div id="menu" class="easyui-menu" style="width:120px;display: none;">
		<div onclick="append();" data-options="iconCls:'icon-add'">增加</div>
		<div onclick="remove();" data-options="iconCls:'icon-remove'">删除</div>
		<div onclick="edit();" data-options="iconCls:'icon-edit'">修改</div>
	</div>
</body>
