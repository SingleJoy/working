<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/backstage/base/inc.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
    var datagrid;
	$(function() {
		var questionId = "<%=request.getParameter("questionId")%>";
		$.ajax({
			url : '${pageContext.request.contextPath}/back_questions/queryOneQuestion.action',
			data : {
				questionId : questionId
			},
			dataType : 'json',
			success : function(d) {
				if(d.success){
					$('#questionForm').form('load', {
						querstionName : d.obj.querstionName,
						courseName : d.obj.courseName,
						courseHourName : d.obj.courseHourName,
						questionContent : d.obj.questionContent.replace("<p>", "").replace("</p>", ""),
						browseNum : d.obj.browseNum,
						answerNum : d.obj.answerNum,
						quizzerName : d.obj.quizzerName,
						question_time : d.obj.question_time 
					});
					if(d.obj.answerNum==0){
						$("#panelID").panel("close");
					}
				}
			}
		}); 
		
		datagrid = $('#datagrid').datagrid({
			data : {'questionId' : questionId},
			url : '${pageContext.request.contextPath}/back_questions/answers_datagrid.action?questionId='+questionId,
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
			sortName : 'answerTime',
			sortOrder : 'desc',
			checkOnSelect : true,
			selectOnCheck : true,
			frozenColumns : [ [ {
				title : '编号',
				field : 'id',
				width : 100,
				sortable : true,
				checkbox : true
			},{
				title : '问题编号',
				field : 'questionId',
				width : 150,
				sortable : true,
				checkbox : true,
				hidden : true
			},{
				title : '回复内容',
				field : 'answerContent',
				width : 350,
				formatter:function(value,rowData,rowIndex){
					var content = value.replace(/<.*?>/ig,"");
					return '<span title="'+value+'" style="display:block;overflow: hidden;">'+lencut(content,35)+'</span>'
				}
			} ] ],
			columns : [ [ {
				title : '回复者',
				field : 'answererName',
				width : 100
			},{
				title : '回复时间',
				field : 'answerTime',
				width : 200,
				sortable : true
			},{
				title : '操作',
				width : 150,
				field : 'do',  
				formatter:function(value, rowData, rowIndex){
					return '<a href="${pageContext.request.contextPath}/back_questions/to_answer_detail.action?id='+rowData.id+'" >查看</a>&nbsp;<a href="javascript:void(0);" onclick="remove();">删除</a>&nbsp;';
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
	
	function remove() {
		var rows = datagrid.datagrid('getChecked');
		var ids = [];
		if (rows.length > 0) {
			parent.sy.messagerConfirm('请确认', '您要删除当前所选回复？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						ids.push(rows[i].id);
					}
					$.ajax({
						url : '${pageContext.request.contextPath}/back_questions/delete_answers.action',
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
			parent.sy.messagerAlert('提示', '请勾选要删除的回复！', 'error');
		}
	}
</script>

</head>
<body class="easyui-layout" data-options="fit:true">
<div data-options="region:'north',border:false,title:'过滤条件'" style="height: 160px;overflow: hidden;" align="center">
	<form id="questionForm" style="width: 100%;height: 100%;">
		<table class="tableForm datagrid-toolbar" style="width: 100%;height: 100%;">
			<tr>
				<th>标题</th>
				<td><input name="querstionName" disabled="disabled" style="width:100px;" /></td>
				<th>课程名</th>
				<td><input name="courseName" disabled="disabled" style="width:100px;" /></td>
				<th>课时名称</th>
				<td><input name="courseHourName" disabled="disabled" style="width:200px;" /></td>
			</tr>
			<tr>
				<th>问题内容</th>
				<td><input name="questionContent" disabled="disabled" style="width:400px;" /></td>
			    <th>提问时间</th>
				<td><input name="question_time" disabled="disabled" style="width:150px;" /></td>
			</tr>
			<tr>
			    <th>作者昵称</th>
				<td><input name="quizzerName" disabled="disabled" style="width:150px;" /></td>
				<th>查看</th>
				<td><input name="browseNum" disabled="disabled" style="width:50px;" /></td>
				<th>回复</th>
				<td><input name="answerNum" disabled="disabled" style="width:50px;" /></td>
				<td><input type="button" value="返回" onclick="location.href='javascript:history.go(-1);'"/></td>
			</tr>
		</table>
	</form>
</div> 

<div id="panelID" data-options="region:'center',border:false" style="overflow: hidden;">
	<table id="datagrid"></table>
</div>

<div id="menu" class="easyui-menu" style="width:120px;display: none;">
	<div onclick="append();" data-options="iconCls:'icon-add'">增加</div>
	<div onclick="remove();" data-options="iconCls:'icon-remove'">删除</div>
	<div onclick="edit();" data-options="iconCls:'icon-edit'">编辑</div>
</div>
</body>
</html>