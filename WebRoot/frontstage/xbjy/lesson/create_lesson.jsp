<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>
<div class="cn-wrap">

	<div id="content-container" class="container">
		<c:if test="${!empty workshopView.id}">
	        	<jsp:include page="../../train/community/workshop_header.jsp"></jsp:include>
	        </c:if>
	       	<c:if test="${empty workshopView.id}">
				<jsp:include page="../../train/community/community_header.jsp"></jsp:include>
	       	</c:if>
	        
		<div class="row row-3-9">
			<c:if test="${!empty workshopView.id}">
				<jsp:include page="../../train/community/workshop_left.jsp"></jsp:include>
			</c:if>
			<c:if test="${empty workshopView.id}">
	       	 	<jsp:include page="../../train/community/community_left.jsp"></jsp:include>
			</c:if>
			
		    <div class="col-lg-9 col-md-8  course-detail-main" >


				<div class="panel panel-default panel-col">
					<div class="panel-heading">
						创建课例&nbsp;:&nbsp;输入课例信息
					</div>
					<form id="lessonPage" action="${pageContext.request.contextPath}/lesson/to_create_lesson.action" method="post">
						<input type="hidden" name="page" id="page" value="${teacherView.page}"/>
						<input type="hidden" name="rows" id="rows" value="${teacherView.rows}"/>
						<input type="hidden" name="total" id="total" value="${teacherView.total}"/>
						<input type="hidden" name="totalPage" id="totalPage" value="${teacherView.totalPage}"/>
						<input type="hidden" name="checkedIds" id="checkedIds" value="${checkedIds}"/>
					</form>
					<div class="panel-body">
						<form id="saveLesson" action="${pageContext.request.contextPath}/lesson/save_lesson.action" class="form-horizontal" method="post">
							<input name="flag" type="hidden" value="0"/>
							<input name="sign" type="hidden" value="1"/>
							<input type="hidden" name="checkedId" id="checkedId" value="${checkedIds}"/>

							<div class="form-group">
								<label class="col-md-2 control-label col-md-offset-1">课例名称</label>
								<div class="col-md-7 controls">
									<input  name="name" id="name" value="${lessonView.name}" class="form-control width-input width-input-large">
								</div>
							</div>

							

							<div class="form-group clearfix">
								<label class="col-md-2 control-label col-md-offset-1">学时</label>
								<div class="col-md-7 controls">
									<input  name="period" id="period" value="${lessonView.period}" class="form-control width-input width-input-large">
								</div>
							</div>

							<div class="form-group clearfix">
								<label class="col-md-2 control-label col-md-offset-1">学分</label>
								<div class="col-md-7 controls">
									<input name="credit" id="credit" value="${lessonView.credit}"  class="form-control width-input width-input-large">
								</div>
							</div>

							<div class="text-center">
								<button class="btn btn-fat btn-primary" type="button" data-toggle="modal" data-target="#add_members">添加成员</button>
							</div>
							<input name="workshop_id" id="workshop_id" value="${workshopView.id}" type="hidden">
							
						</form>
					</div>
				</div>
			</div>
		</div>

	</div>
	<jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
</div>

<!-- 添加成员弹窗 -->
<div id="add_members" class="modal" data-toggle="modal" style="display: none;">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title">选择人员</h4>
			</div>

			<div class="modal-body">
				<form class="form-horizontal" id="boxesForm">

					<div class="form-group">
						<div class="col-md-12 controls">

							<table class="table table-hovered " style="text-align: center;">
								<thead>
								<tr >
									<th width="6%" style="text-align: center;">选择</th>
									<th width="20%" style="text-align: center;">成员</th>
									<th width="20%" style="text-align: center;">单位</th>
									<th width="20%" style="text-align: center;">角色</th>
								</tr>
								</thead>
								<tbody>
								<c:forEach items="${userList}" var="uesr" varStatus="status">
									<tr>
										<td><input type="checkbox" name="boxes" data-name="user_id" id="boxes" value="${uesr.user_id}"></td>
										<td align="center">${uesr.true_name}(${uesr.username})</td>
										<td align="center">${uesr.school}</td>
										<td align="center">
										<c:if test="${uesr.role_type==0}">管理员</c:if>
										<c:if test="${uesr.role_type==1}">专家</c:if>
										<c:if test="${uesr.role_type==2}">普通学员</c:if>
										<c:if test="${uesr.role_type==3}">坊主</c:if>
										</td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
					<div class="text-center">
						<input class="btn btn-fat btn-primary" type="button" onclick="doSumbit();" value="下一步">
					</div>
				</form>
			</div>

		</div>
	</div>
</div>
<script type="text/javascript">

	function validate(){
		var name = $("#name").val();
		var lesson_num= $("#lesson_num").val();
		var period= $("#period").val();
		var credit= $("#credit").val();
		var option = $(":checked");
		if(option.length<3){
			alert("必需选择组员");
			return false;
		}
		if(name==""){
			alert("课例名称不能为空");
			return false;
		}
		if(lesson_num==""){
			alert("课例编号不能为空");
			return false;
		}
		pattern=/^[0-9]{0,8}$/;
		if(!pattern.test(period)){
			alert("学时必须为数字");
			return false;
		}

//	pattern=/^[0-9]{1,8}([.][0-9]{1,5})?$/;
		pattern=/^[0-9]{0,8}$/;
		if(credit==""){
			alert("学分必须为数字");
			return false;
		}
		else{
			return true;
		}
	}
	function doSumbit(){
		var val = validate();
		if(val){
			var url=$("#boxesForm").serialize();
			var action=$("#saveLesson").attr("action");
			$("#saveLesson").attr("action",action+"?"+url);
			document.getElementById('saveLesson').submit();
		}
	}

	checkedIds=$("#checkedIds").val();//翻页保存选中的id
	getChecked();
	function changeIds(){
		var oneches=document.getElementsByName("boxes");
		for(var i=0;i<oneches.length;i++){
			if(oneches[i].checked==true){
				//避免重复累计id （不含该id时进行累加）
				if(checkedIds.indexOf(oneches[i].value)==-1){
					checkedIds=checkedIds+oneches[i].value+","
				}
			}
			if(oneches[i].checked==false){
				//取消复选框时 含有该id时将id从全局变量中去除
				if(checkedIds.indexOf(oneches[i].value)!=-1){
					checkedIds=checkedIds.replace((oneches[i].value+","),"");
				}
			}
		}
		alert(checkedIds);
		$("#checkedIds").val(checkedIds);
		$("#checkedId").val(checkedIds);
	}

	function getChecked(){
		var oneches=document.getElementsByName("boxes");
		for(var i=0;i<oneches.length;i++){
			//全局变量中含有id，则该复选框选中
			if(checkedIds.indexOf(oneches[i].value)!=-1){
				oneches[i].checked=true;
			}
		}
	}

	$(function(){
		//翻页
		var total = $("#total").val();
		var page =  parseInt($("#page").val())+1;

		$("#btn5").on('click', function () {
			$("#div1").PageChanged(5);
		});

		$(".pager").pagination({
			thisPageIndex:page,
			recordCount: total,       //总记录数
			pageSize: $("#rows").val(),           //一页记录数
			onPageChange: function (page) {
				document.title = page;
				$("#page").val(page-1);
				$('#lessonPage').submit();

			}
		});
	});
</script>