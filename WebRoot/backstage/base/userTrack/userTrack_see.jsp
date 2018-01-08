<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" charset="utf-8">
    <%
 %>
</script>

<div style="padding: 5px;">

	<table id="dg" style="height:330px"data-options="pageSize : 10,pageList : [ 10, 20, 30, 40 ],fitColumns:true,singleSelect:true,pagination:true,url:'${pageContext.request.contextPath}/back_user_track/user_track_datagrid.action?order=desc&user_id=${user_id}&username=${username}&index=${index }',method:'get'">
		<thead>
		<c:if test="${index==0 }">
			<tr>
				<th data-options="field:'start_time',width:240">登录时间</th>
				<th data-options="field:'end_time',width:240">登出时间</th>
				<th data-options="field:'total_ms',width:180">总时间(毫秒)</th>
			</tr>
		</c:if>
		<c:if test="${index==1 }">
			<tr>
				<th data-options="field:'course_title',width:180">课程名</th>
				<th data-options="field:'course_hour_title',width:180">课时名</th>
				<th data-options="field:'start_time',width:240">开始时间</th>
				<th data-options="field:'study_time',width:180">学习时间(毫秒)</th>
			</tr>
		</c:if>
		<c:if test="${index==2||index==3 }">
			<tr>
				<th data-options="field:'name',width:180">名称</th>
				<th data-options="field:'add_time',width:240">加入时间</th>
			</tr>
		</c:if>
		<c:if test="${index==4||index==5 }">
			<tr>
				<th data-options="field:'filename',width:180">文件名称</th>
				<th data-options="field:'time',width:240">操作时间</th>
			</tr>
		</c:if>
		<c:if test="${index==6 }">
			<th data-options="field:'appraise_content',width:240">评价内容</th>
			<th data-options="field:'appraise_time',width:240">操作时间</th>
		</c:if>
		<c:if test="${index==7||index==8 }">
			<th data-options="field:'realName',width:240">用户名</th>
			<th data-options="field:'attent_time',width:240">关注时间</th>
		</c:if>
		<c:if test="${index==9 }">
			<th data-options="field:'querstionName',width:240">问题名称</th>
			<th data-options="field:'question_time',width:240">提问时间</th>
		</c:if>
		<c:if test="${index==10}">
			<th data-options="field:'question_content',width:240">问题名称</th>
			<th data-options="field:'answer_content',width:240">回答内容</th>
			<th data-options="field:'answer_time',width:240">回答时间</th>
		</c:if>
		<c:if test="${index==11}">
			<th data-options="field:'course_title',width:180">课程名</th>
			<th data-options="field:'noteContent',width:240">笔记内容</th>
			<th data-options="field:'noteTime',width:240">笔记时间</th>
		</c:if>
		</thead>
	</table>



</div>

<script type="text/javascript">
    $(function(){
        var pager = $('#dg').datagrid().datagrid('getPager');	// get the pager of datagrid

    });
    function description(value){
        alert(value);
    }
</script>