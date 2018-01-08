<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<jsp:include page="/backstage/base/inc.jsp"></jsp:include>
	<script type="text/javascript" >
        var datagrid;
        $(function() {

            datagrid = $('#datagrid').datagrid({
                url : '${pageContext.request.contextPath}/back_default_img/datagrid.action',
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
                    title : '名称',
                    field : 'name',
                    width : 200
                }/* ,{
                    title : '路径',
                    field : 'path',
                    sortable : true,
                    width : 300
                } */,{
                    title : '类型',
                    field : 'type',
                    width : 80,
                    formatter:function(value,rowData,rowIndex){
                    	if(value==0){return "轮播图";}
                    }
                },{
                    title : '来源',
                    field : 'source_type',
                    width : 80,
                    formatter:function(value,rowData,rowIndex){
                        if(value=='0'){//是
                            return "培训";
                        }else if(value=='1'){//是
                            return "教研";
                        }else if(value=='2'){//是
                            return "资源";
                        }else if(value=='3'){//是
                            return "工作坊";
                        }else if(value=='4'){//是
                            return "社区";
                        }
                    }
                }] ],
                columns : [ [ {
                    title : '上传人',
                    field : 'username',
                    width : 100
                }, {
                    title : '上传时间',
                    field : 'upload_time',
                    width : 200
                }, {
                    title : '设备',
                    field : 'device',
                    width : 60,
                    formatter:function(value,rowData,rowIndex){
                    	if(value==0){
                    		return "PC";
                    	}else if(value==1){
                    		return "mobile";
                    	}
                    }
                }, {
                    title : '序号',
                    field : 'sequence',
                    sortable : true,
                    width : 60
                }, {
                    title : '位置',
                    field : 'location',
                    width : 80,
                    formatter:function(v){
                        if(v=="0"){
                            return '主页';
                        }
                    }
                }, {
                    title : '状态',
                    field : 'status',
                    width : 80,
                    formatter:function(v){
                        if(v=="0"){
                            return '启用';
                        }else if(v=="1"){
                        	return '禁用';
                        }
                    }
                },{
                    title : '操作',
                    field : 'statusType',
                    width : 150,
                    formatter:function(value, rowData, rowIndex){
                        var rows = datagrid.datagrid('getRows');
                        var row = rows[rowIndex];
                        var stats = 0;
                        var str = "启用"
                        if(row.status=="0"){
                        	stats = 1;
                        	str = "禁用";
                        }
                        var htmlval = '<a href="javascript:void(0);" onclick="append('+row.id+');"  >查看</a>&nbsp;&nbsp;<a href="javascript:void(0);" onclick="update('+row.id+','+stats+');" >'+str+'</a>';
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
        
        
        function edit() {
    		var rows = datagrid.datagrid('getSelections');
    		if (rows.length == 1) {
    			var id = rows[0].id;
    			var p = parent.sy.dialog({
					title : '编辑图片',
					href : '${pageContext.request.contextPath}/back_default_img/to_default_img_add.action?id='+id,
					width : 600,
					height : 450,
					buttons : [ {
						text : '编辑',
						handler : function() {
							var f = p.find('form');
							f.form('submit', {
								url : '${pageContext.request.contextPath}/back_default_img/update_img.action',
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
        
        
        function append(id){
        	id = id!=null?id+"&see=1":"";
        	var p = parent.sy.dialog({
    			title : '添加默认图片',
    			href : '${pageContext.request.contextPath}/back_default_img/to_default_img_add.action?id='+id,
    			width : 600,
    			height : 450, 
    			resizable : true, 
    			buttons : [ {
    				text : '添加',
    				handler : function() {
    					var f = p.find('form');
    					var name = f.find('#name').val();
    					var path = f.find('#path').val();
    					var time0 = f.find('#upload_time').val();
    					if(f.find('#succe').val()!="1"){
    						parent.sy.messagerShow({
								msg : "您上传图片的尺寸不符合规范！",
								title : '提示'
							});
    						return false;
    					} 
    					if(name.length>0&&path.length>0&&time0.length>0){
    						f.form('submit', {
        						url : '${pageContext.request.contextPath}/back_default_img/add_default_img.action',
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
    					}else{
    						parent.sy.messagerShow({
								msg : "请上传图片！",
								title : '提示'
							});
    					} 
    				}
    			} ]
    		});
        }


        //取消推荐课程
        function removeRecommend(value){
            $.ajax({
                url : '${pageContext.request.contextPath}/back_course/is_recommend_course.action',
                data:{
                    courseInfoId : value,
                    isRecommend : 1
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

        //设置推荐课程
        function doRecommend(value) {
            var p = parent.sy.dialog({
                title : '设置推荐课程',
                href : '${pageContext.request.contextPath}/back_course/to_recommend_course.action',
                width : 420,
                height : 260,
                buttons : [ {
                    text : '确定',
                    handler : function() {
                        var f = p.find('form');
                        f.form('submit', {
                            url : '${pageContext.request.contextPath}/back_course/is_recommend_course.action',
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
                        url : '${pageContext.request.contextPath}/back_course/get_max_seq.action',
                        data : {
                            id : value
                        },
                        dataType : 'json',
                        success : function(d) {
                            if(d.success){
                                f.form('load', {
                                    recommendSeq : d.obj,
                                    courseInfoId : value
                                });
                            }
                        }
                    });
                }
            });
        }


        function update(id,status) {//关闭
            $.ajax({
                url : '${pageContext.request.contextPath}/back_default_img/update_img.action',
                data : {
                    id : id,
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
        function updateStatus2(id,status) {//发布
            var result = confirm('您真的要发布该课程吗？');
            if(result){
                $.ajax({
                    url : '${pageContext.request.contextPath}/back_course/is_exist_class.action',
                    dataType : 'json',
                    data:{
                        source_id : id,
                        source_type : 0
                    },
                    success:function(data){
                        if(data.num>0&&data.courseHour_num>0){
                            $.ajax({
                                url : '${pageContext.request.contextPath}/back_course/update_status.action',
                                data : {
                                    id : id,
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
                        }else{
                            if(data.num<=0){
                                alert("该课程还没有开班，请联系建课老师创建班级！");
                            }else if(data.courseHour_num<=0){
                                alert("该课程还没有建立课时，请联系建课老师创建课时！");
                            }
                        }
                    }
                });
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
<div data-options="region:'north',border:false,title:'过滤条件'" style="height: 90px;overflow: hidden;" align="left">
	<form id="searchForm" style="width: 100%;height: 100%;">
		<div style="height:100%;background-color: #efefef;padding-top: 20px;padding-left: 20px;">
			<span style="margin-left: 20px;">设备</span>
			<span style="margin-left: 20px;">
				<select name="device" style="height: 21px;">
					<option value="-1">请选择</option>
					<option value="0">PC</option>
					<option value="1">mobile</option>
				</select>
			</span>
			<span style="margin-left: 20px;">启用</span>
			<span style="margin-left: 20px;">
				<select name="status" style="height: 21px;">
					<option value="-1">请选择</option>
					<option value="0">启用</option>
					<option value="1">禁用</option>
				</select>
			</span>
			<span style="margin-left: 20px;">来源</span>
			<span style="margin-left: 20px;">
				<select name="source_type" style="height: 21px;">
					<option value="-1">请选择</option>
					<option value="0">培训</option>
					<option value="1">教研</option>
					<option value="2">资源</option>
					<option value="3">工作坊</option>
					<option value="4">社区</option>
				</select>
				<a href="javascript:void(0);" class="easyui-linkbutton" onclick="_search();" style="margin-left: 20px;">查询</a>
				<a href="javascript:void(0);" class="easyui-linkbutton" onclick="cleanSearch();" style="margin-left: 20px;">清空</a>
			</span>
		</div>
	</form>
</div>

<div data-options="region:'center',border:false" >
	<table id="datagrid"></table>
</div>

<div id="menu" class="easyui-menu" style="width:120px;display: none;">
	<div onclick="append();" data-options="iconCls:'icon-add'">增加</div>
	<div onclick="remove();" data-options="iconCls:'icon-remove'">删除</div>
	<div onclick="edit();" data-options="iconCls:'icon-edit'">编辑</div>
</div>

</body>
</html>