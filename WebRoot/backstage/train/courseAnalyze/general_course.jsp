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
                url : '${pageContext.request.contextPath}/back_course/general_course_datagrid.action',
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
                    title : '课程名称',
                    field : 'title',
                    width : 300/* ,
				formatter:function(value,rowData,rowIndex){
					return lencut(value,15);
				}  */
                },{
                    title : '教师',
                    field : 'createUser',
                    width : 80
                },{
                    title : '开班次数',
                    field : 'open_class_num',
                    sortable : true,
                    width : 80
                },{
                    title : '报名数',
                    field : 'studentNum',
                    sortable : true,
                    width : 100,
                },{
                    title : '视频观看数',
                    field : 'studentNum',
                    sortable : true,
                    width : 100,
                }] ],
                columns : [ [{
                    title : '创建时间',
                    field : 'create_time',
                    sortable : true,
                    width : 170,
                    formatter:function(v){
                        var dt;
                        if (v instanceof Date) {
                            dt = v;
                        } else {
                            dt = new Date(v);
                        }
                        return dt.format("yyyy-MM-dd hh:mm:ss");
                    }
                },{
                    title : '详情',
                    field : 'statusType',
                    width : 150,
                    formatter:function(value, rowData, rowIndex){
                    	var rows = datagrid.datagrid('getRows');
                        var row = rows[rowIndex];
                        return '<a href="javascript:void(0);" onclick="toCourseDetail(this,'+row.id+','+row.status+');" >查看详情</a>';
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

        function toCourseDetail(currentElement,value,status){
            if(status=="1"){//已发布课程
                var see=true;
                $.ajax({
                    url : '${pageContext.request.contextPath}/back_course/is_exist_class.action',
                    dataType : 'json',
                    async : false,
                    data:{
                        source_id : value,
                        source_type : 0
                    },
                    success:function(data){
                        if(data.num<=1){
                            alert("该课程还没有开班或班级被屏蔽，请联系建课老师创建班级！");// class status=5  删除
                            see = false;
                        }else if(data.courseHour_num<=0){
                            alert("该课程还没有建立课时，请联系建课老师创建课时！");
                            see = false;
                        }
                    }
                });
                if(see&&value){
                	var p = parent.sy.dialog({
            			title : '查看用户',
            			href : '${pageContext.request.contextPath}/back_course/to_course_static.action?course_id='+value,
            			width : 800,
            			height : 600,
            			onLoad : function() {
            			}
            		}); 
                }
            }else{
                alert("无法查看未发布的课程！");
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
</head>
<body class="easyui-layout" data-options="fit:true">
<div data-options="region:'north',border:false,title:'过滤条件'" style="height: 140px;overflow: hidden;" align="left">
	<form id="searchForm" style="width: 100%;height: 100%;">
		<div style="height:100%;background-color: #efefef;padding-top: 20px;padding-left: 20px;">
			<div>
				<span>名&nbsp;&nbsp;称:

					<input name="title" style="width:150px;margin-left: 24px;" />
				</span>
				<span style="margin-left: 20px;">
					创建者:&nbsp;&nbsp;
					<input name="createUser" style="width:150px;" />
				</span>
			</div>
			<div style="margin-top: 20px;">
				<span>
					创建时间:&nbsp;&nbsp;

					<input name="startTime" class="easyui-datebox" data-options="editable:false" style="width: 155px;" />
					&nbsp;&nbsp;至&nbsp;&nbsp;
					<input name="endTime" class="easyui-datebox" data-options="editable:false" style="width: 155px;" />
					<a href="javascript:void(0);" class="easyui-linkbutton" onclick="_search();" style="margin-left: 20px;">查询</a>
					<a href="javascript:void(0);" class="easyui-linkbutton" onclick="cleanSearch();" style="margin-left: 20px;">清空</a></td>
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