<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%		String openId = request.getParameter("openId");
%>
<jsp:include page="/backstage/base/inc.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var datagrid;
    $(function() {
        datagrid = $('#datagrid').datagrid({
            url : '${pageContext.request.contextPath}/back_private_letter/datagrid.action',
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
            sortName : 'send_time',
            sortOrder : 'desc',
            checkOnSelect : true,
            selectOnCheck : true,
            frozenColumns : [ [ {
                title : '编号',
                field : 'id',
                width : 100,
                sortable : true,
                checkbox : true
            }, {
                title : '发信人',
                field : 'sender',
                width : 160
            }, {
                title : '收信人',
                field : 'receiver',
                width : 160
            } ] ],
            columns : [ [  {
                title : '内容',
                field : 'letter_content',
                width : 200  ,
                formatter:function(value, rowData, rowIndex){
                    if(value!=null&&value!=""){
                        var display1 = "";
                        var display2 = "";
                        if(rowData.id==rowData.openId){
                            display1 = "display:none;";
                        }else if(rowData.id!=rowData.openId||rowData.openId==0){
                            display2 = "display:none;";
                        }
                        return '<div id="flip_'+rowData.id+'"  title="'+value+'"  style="'+display1+'overflow: hidden;">'+lencut(value,35)+'&nbsp;&nbsp;<span style="color:grey" onclick="slip('+rowData.id+',0);">展开</span></div><div id="panel_'+rowData.id+'" style="'+display2+'">'+value+'&nbsp;&nbsp;<span style="color:grey" onclick="slip('+rowData.id+',1);">收起</span></div>';
                    }else{
                        return "";
                    }

                }
            },{
                title : '发送时间',
                field : 'send_time',
                width : 150
            }] ],
            toolbar : [ {
                text : '删除',
                iconCls : 'icon-remove',
                handler : function() {
                    remove();
                }
            }, '-', {
                text : '取消选中',
                iconCls : 'icon-undo',
                handler : function() {
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
    function slip(id,value){
        if(value==0){
            $("#flip_"+id).hide();
            $("#panel_"+id).show();
            $("#openId").val(id);
        }else if(value==1){
            $("#flip_"+id).show();
            $("#panel_"+id).hide();
            $("#openId").val(0);
        }
        datagrid.datagrid('load', sy.serializeObject($('#searchForm')));
    }

    function remove() {
        var rows = datagrid.datagrid('getChecked');
        var ids = [];
        if (rows.length > 0) {
            parent.sy.messagerConfirm('请确认', '您要删除当前所选项目？', function(r) {
                if (r) {
                    for ( var i = 0; i < rows.length; i++) {
                        ids.push(rows[i].id);
                    }
                    $.ajax({
                        url : '${pageContext.request.contextPath}/back_private_letter/delete_private_letter.action',
                        data : {
                            ids : ids.join(',')
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
            parent.sy.messagerAlert('提示', '请勾选要删除的记录！', 'error');
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


<body class="easyui-layout" data-options="fit:true">
<div data-options="region:'north',border:false,title:'过滤条件'" style="height: 90px;overflow: hidden;" align="left">
	<form id="searchForm" style="width: 100%;height: 100%;">
		<div style="height:100%;background-color: #efefef;padding-top: 20px;padding-left: 20px;">

			<span>时间:&nbsp;&nbsp;
				<input name="timeStart" class="easyui-datebox" data-options="editable:false" style="width: 135px;" />
				&nbsp;&nbsp;至&nbsp;&nbsp;
				<input name="timeEnd" class="easyui-datebox" data-options="editable:false" style="width: 135px;" />
			</span>
			<span style="margin-left: 50px;">
				发信人:&nbsp;&nbsp;
				<input type="hidden" id="openId" name="openId"/>
				<input name="sender" style="width:120px;" />
			</span>
			<span style="margin-left: 20px;">
				私信内容&nbsp;&nbsp;
				<input name="letter_content" style="width:120px;" />

				<a href="javascript:void(0);" class="easyui-linkbutton" onclick="_search();" style="margin-left: 20px;">查询</a>
				<a href="javascript:void(0);" class="easyui-linkbutton" onclick="cleanSearch();" style="margin-left: 10px;">清空</a>
			</span>
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
