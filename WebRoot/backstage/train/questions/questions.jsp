<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/backstage/base/inc.jsp"></jsp:include>
<%--培训管理->问答管理--%>
<script type="text/javascript" charset="utf-8">
    var datagrid;
    $(function() {
        datagrid = $('#datagrid').datagrid({
            url : '${pageContext.request.contextPath}/back_questions/questions_datagrid.action',
            title : '',
            iconCls : 'icon-save',
            pagination : true,
            pageSize : 10,
            pageList : [ 10, 20, 30, 40 ],
            fit : true,
            fitColumns : true,
            nowrap : false,
            border : false,
            idField : 'questionId',
            sortName : 'question_time',
            sortOrder : 'desc',
            checkOnSelect : true,
            selectOnCheck : true,
            frozenColumns : [ [ {
                title : '编号',
                field : 'questionId',
                width : 100,
                sortable : true,
                checkbox : true
            }, {
                title : '标题',
                field : 'querstionName',
                width : 200
            },{
                title : '类型',
                field : 'source_type',
                width : 50,
                formatter : function(value,rowData,rowIndex){
                    if(value==0){
                        return "课程";
                    }else if(value==1){
                        return "培训";
                    }else if(value==2){
                        return "社区";
                    }else if(value==3){
                        return "工作坊";
                    }
                }
            },{
                title : '名称',
                field : 'sourceName',
                width : 240
            }
                /* ,{
                    title : '问题内容',
                    field : 'questionContent',
                    width : 230,
                    formatter:function(value,rowData,rowIndex){
                        var content = value.replace(/<.*?>/ig,"");
                        return '<span title="'+content+'" >'+lencut(content,40)+'</span>';
                    }
                }  */
            ] ],
            columns : [ [ {
                title : '提问者',
                field : 'quizzerName',
                width : 130
            },{
                title : '回复',
                field : 'answerNum',
                sortable : true,
                width : 100
            },{
                title : '查看',
                field : 'browseNum',
                sortable : true,
                width : 100
            },{
                title : '提问时间',
                field : 'question_time',
                width : 200,
                sortable : true
            },{
                title : '操作',
                width : 150,
                field : 'do',
                formatter:function(value, rowData, rowIndex){
                    return '<a href="javascript:void(0);" onclick="windowOpen0('+rowData.source_id+','+rowData.source_type+');">查看</a>&nbsp;<a href="javascript:void(0);" onclick="remove();">删除</a>&nbsp;';
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

    function windowOpen0(id,type){
        if(type==0){
            $.ajax({
                url : '${pageContext.request.contextPath}/back_course/is_exist_class.action',
                dataType : 'json',
                async : false,
                data:{
                    source_id : id,
                    source_type : 0
                },
                success:function(data){
                    if(data.num<=0){//此条件查询下的班级数量会默认包含培训班级
                        alert("该用户的班级被禁用，请联系建课老师！");// class status=5  删除
                    }else if(data.courseHour_num<=0){
                        alert("该课程的课时被禁用，请联系建课老师！");
                    }else{
                        window.open("${pageContext.request.contextPath}/user_study/to_course_study.action?page=1&learnId="+id+"&sourceType=0&jumpType=0&tab=2&is_direct=0");
                    }
                }
            });
        }else if(type==1){
            $.ajax({
                url : '${pageContext.request.contextPath}/back_course/is_exist_class.action',
                dataType : 'json',
                async : false,
                data:{
                    source_id : id,
                    source_type : 1
                },
                success:function(data){
                    if(data.num<=0){
                        alert("该用户的班级被禁用，请联系培训主办方！");// class status=5  删除
                    }else{
                        window.open("${pageContext.request.contextPath}/train/to_train_detail.action?id="+id+"&jumpType=0&sign=3");
                    }
                }
            });
        }else if(type==2){
            window.open("${pageContext.request.contextPath}/community/to_community_index.action?classifyId=-1&sourceType=0&stamp=4&id="+id);
        }else if(type==3){
            window.open("${pageContext.request.contextPath}/community/to_community_index.action?sourceType=1&classifyId=-1&stamp=4&id="+id);
        }
    }

    function remove() {
        var rows = datagrid.datagrid('getChecked');
        var ids = [];
        if (rows.length > 0) {
            parent.sy.messagerConfirm('请确认', '您要删除当前所选问题？', function(r) {
                if (r) {
                    for ( var i = 0; i < rows.length; i++) {
                        ids.push(rows[i].questionId);
                    }
                    $.ajax({
                        url : '${pageContext.request.contextPath}/back_questions/delete_questions.action',
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
            parent.sy.messagerAlert('提示', '请勾选要删除的问题！', 'error');
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
<div data-options="region:'north',border:false,title:'过滤条件'" style="height: 140px;overflow: hidden;" align="left">
	<form id="searchForm" style="width: 100%;height: 100%;">
		<div style="height:100%;background-color: #efefef;padding-top: 20px;padding-left: 20px;">

			<div>
			    <span>
					<span>提问者</span>
					<input name="quizzerName" style="width:150px;margin-left: 10px;" />
				</span>

				<span style="margin-left: 60px;">
					<span>标题</span>
					<input name="querstionName" style="width:145px;margin-left: 10px;" />
				</span>

				<span style="margin-left: 20px;">
					<span>类型</span>

					<select  name="source_type" style="width:100px;height: 21px;">
					    <option value="" selected="selected">请选择</option>
					    <option value="0">课程</option>
						<option value="1">培训</option>
						<option value="2">社区</option>
						<option value="3">工作坊</option>
					</select>
				</span>
			</div>

			<div style="margin-top: 20px;">
				<span >
					<span>名称</span>
					<input name="sourceName" style="width:157px;margin-left: 20px;" />
				</span>

				<span style="margin-left: 30px;">
					<span>提问时间</span>&nbsp;&nbsp;
					<input name="timeStart" class="easyui-datebox" data-options="editable:false" style="width: 150px;" />
					&nbsp;至&nbsp;
					<input name="timeEnd" class="easyui-datebox" data-options="editable:false" style="width: 150px;margin-left: 10px;" />

					<a href="javascript:void(0);" class="easyui-linkbutton" onclick="_search();" style="margin-left: 10px;">查询</a>
					<a href="javascript:void(0);" class="easyui-linkbutton" onclick="cleanSearch();" style="margin-left: 10px;">清空</a>
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
