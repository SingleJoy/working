<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%		String user_type = request.getParameter("user_type");
%>
<jsp:include page="/backstage/base/inc.jsp"></jsp:include>
<%--用户登录日志--%>
<script type="text/javascript" charset="utf-8">
    var datagrid;
    $(function(){
        datagrid = $('#datagrid').datagrid({
            url : '${pageContext.request.contextPath}/back_user_log/datagrid.action',
            title : '用户日志',
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
            sortName : 'create_time',
            sortOrder : 'DESC',
            checkOnSelect : true,
            selectOnCheck : true,
            frozenColumns : [ [  {
                title : '编号',
                field : 'id',
                width : 100,
                sortable : true,
                checkbox : true
            }, {
                title : '登录名',
                field : 'username',
                width : 150,
                sortable : true
            } ] ],
            columns : [ [ {
                title : '手机号',
                field : 'phone',
                width : 150,
            }, {
                title : '登陆时间（IP）',
                field : 'create_time',
                sortable : true,
                width : 300,
                formatter:function(value, rowData, rowIndex){
                    var rows = datagrid.datagrid('getRows');
                    var row = rows[rowIndex];
                    if(row.login_ip!=null){
                        return row.create_time+"（"+row.login_ip+"）";
                    }else{
                        return row.create_time;
                    }

                }
            }, {
                title : '登陆地点',
                field : 'login_address',
                width : 250
            },{
                title : '操作系统类型',
                field : 'sys_name',
                width : 150
            },{
                title : '查看记录',
                field : 'statusType',
                width : 150,
                sortable : true,
                formatter:function(value, rowData, rowIndex){
                    var rows = datagrid.datagrid('getRows');
                    var row = rows[rowIndex];
                    return '<a href="javascript:void(0);" onclick="see(\''+row.username+'\',\''+ row.user_id +'\');">查看</a>';
                }

            } ] ],
            toolbar : [  ],
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


    function see(username,user_id) {
        if(username=="undefined"){
            username="";
        }
        if(user_id=="undefined"){
            user_id="";
        }
        var p = parent.sy.dialog({
            title : username+'登录日志',
            href : '${pageContext.request.contextPath}/back_user_log/to_user_log_see.action?username='+username+'&user_id='+user_id,
            width : 600,
            height : 430,
            buttons : [ {
                text : '确定',
                handler : function() {
                    p.dialog('close');
                }
            }]
        });
    }

    function _search() {
        datagrid.datagrid('load', sy.serializeObject($('#searchForm')));
    }
    function cleanSearch() {
        datagrid.datagrid('load', {});
        $('#searchForm input').val('');
        /* $('#searchForm select').val('-1'); */

    }
    function changeKey(obj){
        if(obj.value!="-1"){
            $("#keyname").attr("name",obj.value);
        }
    }

</script>


<body class="easyui-layout" data-options="fit:true">
<div data-options="region:'north',border:false,title:'过滤条件'" style="height: 130px;overflow: hidden;" align="left">
	<form id="searchForm" style="width: 100%;height: 100%;">
		<div style="height:100%;background-color: #efefef;padding-top: 20px;padding-left: 20px;">

			<div>
				<span>关键词：</span>
				<select id="aa"   style="width:150px;height:21px;" onchange="changeKey(this)">
					<option value="-1" selected="selected" >请选择</option>
					<option value="username">用户名</option>
					<option value="phone">手机号</option>
				</select>

				<span style="margin-left: 20px;"><input id="keyname" style="width:150px;" /></span>
				
				<span style="margin-left: 20px;">日志来源</span>

				<span style="margin-left: 20px;">
					<select id="do_from" name="do_from" style="width: 150px;height: 21px;">
						<option value="">请选择日志来源</option>
						<option value="1">web前台日志</option>
						<option value="2">web后台日志</option>
						<option value="3">Android日志</option>
						<option value="4">IOS日志</option>
					</select>
				</span>
			</div>


			<div style="margin-top: 20px;">
                  <span >时&nbsp;间：&nbsp;&nbsp;
					  <input name="timeStart" class="easyui-datebox" data-options="editable:false" style="width: 155px;" />
					  &nbsp;至&nbsp;
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


</body>



