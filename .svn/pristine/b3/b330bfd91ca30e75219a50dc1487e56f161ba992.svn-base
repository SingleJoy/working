<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>


<div class="cn-wrap">

	<div id="content-container" class="container">
		<jsp:include page="class_header.jsp"></jsp:include>

		<div class="row">

			<jsp:include page="class_left.jsp"></jsp:include>

			<div class="col-lg-9 col-md-9">

				<div class="panel panel-default panel-col">

					<div class="panel-heading">
						用户轨迹
					</div>

					<div class="panel-body">

						<div class="form-horizontal stage-form">

							<div class="table-responsive" >
								<table class="table table-striped table-bordered" style="font-size: 12px;">
									<thead >
									<tr class="active">
										<th>用户名</th>
										<th >学习时间</th>
										<th >学习天数</th>
										<th>连续学习天数</th>
										<th>提问数</th>
										<th>回答数</th>
										<th>笔记数</th>
									</tr>

									</thead>
									<tbody id="databody">
									<c:forEach items="${userTrackViews }" var="view">
										<tr>
											<td>${view.username }</td>
											<td class="t1" data-user_id="${view.user_id}">
												<fmt:formatNumber type="number" maxFractionDigits="2" value="${view.studyTime/1000/60 }" />分钟</td>
											<td class="t1" data-user_id="${view.user_id}">${view.studyDays }</td>
											<td class="t1" data-user_id="${view.user_id}">${view.continuityDays }</td>
											<td class="t2" data-user_id="${view.user_id}">${view.questionCount }</td>
											<td class="t3" data-user_id="${view.user_id}">${view.answerCount }</td>
											<td class="t4" data-user_id="${view.user_id}">${view.noteCount }</td>
										</tr>
									</c:forEach>

									</tbody>
								</table>
							</div>
						</div>

					</div>

				</div>
			</div>
		</div>
	</div>
</div>

<div id="add-assistant" class="modal"  data-toggle="modal" style="display: none;" >
	<div class="modal-dialog  modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button class="close" data-dismiss="modal" aria-hidden="true">×</button>
				
			</div>
			<div class="modal-body">

				<form class="form-horizontal form-inline" id="assistant">
					<input type="hidden" id="pageFlag" value="0"/>
					<input type="hidden" name="page" id="page" value="0"/>
					
				</form>
				<table class="table table-condensed">
					<thead id="datahead">
					
					</thead>
					<tbody id="showAssistant"></tbody>
				</table>
				<nav class="text-center">
					<div id="test" class="pager"></div>
				</nav>
				<div class="modal-footer">
					<button type="button" class="btn btn-info pull-right tutor_confirm" data-dismiss="modal">确定</button>
				</div>

			</div>
		</div>
	</div>
</div>

	<jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
	<script type="text/javascript">
	var user_id0;
	var index0;
    $("#databody>tr>td").click(function () {

      var index=$(this).attr("class").substring(1);
    

		showTeacher(0,$(this).data("user_id"),index);
	});
		function doPages(value,row,total){
		//翻页
		var page =  parseInt($("#page").val())+1;
		$("#btn5").on('click', function () {
			$("#div1").PageChanged(5);
		});
		$(".pager").pagination({
			thisPageIndex:page,
			recordCount: total,       //总记录数
			pageSize:  row,            //一页记录数
			onPageChange: function (page) {
				$("#page").val(page-1);
				showTeacher(value);
			}
		});
	}
		function showTeacher(value,user_id,index){
		var page = $("#page").val();
		if(value==0){
			$("#pageFlag").val(0);
			page = 0;
			user_id0=user_id;
			index0=index;
			$("#add-assistant").modal();
		}
		
		$.ajax({
			url : '${pageContext.request.contextPath}/course_track/track_index.action',
			dataType : 'json',
			data:{
			class_id	:'${classView.id}',
			course_id:'${classView.source_id}',
			user_id:user_id0,
			index:index0,
			page : page
			},
			success : function(data){
			if(index0==1){
			var list = data.studyTimeViews;
				var view = data.page;
				var head="<tr>"+
									"	<th>课程名</th>"+
									"		<th >课时名</th>"+
									"		<th >开始时间</th>"+
									"		<th>学习时间</th>"+
								
									"	</tr>";
				
				$("#datahead").empty().append(head);
				var html = "";
				for(var i=0; i<list.length; i++) {
				
				var myDate=new Date();
							myDate.setTime(list[i].start_time.time);
							var year=myDate.getFullYear();
							var month=myDate.getMonth()+1;
							var date=myDate.getDate();
							var hour=myDate.getHours();
							var minute=myDate.getMinutes();
							var second=myDate.getSeconds();
							var time=year+"-"+month+"-"+date+" "+hour+":"+minute+":"+second;
						
				
					html += ' <tr>'+
					'<td>'+list[i].course_title+'</td>'+
					'<td>'+list[i].course_hour_title+'</td>'+
					'<td>'+time+'</td>'+
					'<td>'+list[i].study_time+'</td>'+
					
					'</tr>';
				}
				$("#showAssistant").empty().append(html);
				$("#page").val(view.page);
			}
			
			if(index0==2){
			var list = data.topicQuestionViews;
				var view = data.page;
				var head="<tr>"+
									"	<th>问题名称</th>"+
									"		<th >提问时间</th>"+
								
								
									"	</tr>";
				
				$("#datahead").empty().append(head);
				var html = "";
				for(var i=0; i<list.length; i++) {
				
				var myDate=new Date();
							myDate.setTime(list[i].question_time.time);
							var year=myDate.getFullYear();
							var month=myDate.getMonth()+1;
							var date=myDate.getDate();
							var hour=myDate.getHours();
							var minute=myDate.getMinutes();
							var second=myDate.getSeconds();
							var time=year+"-"+month+"-"+date+" "+hour+":"+minute+":"+second;
						
				
					html += ' <tr>'+
					'<td>'+list[i].querstionName+'</td>'+
				
					'<td>'+time+'</td>'+
					
					
					'</tr>';
				}
				$("#showAssistant").empty().append(html);
				$("#page").val(view.page);
			}
			
			if(index0==3){
			var list = data.topicAnswerViews;
				var view = data.page;
				var head="<tr>"+
								"	<th>问题名称</th>"+
								"	<th>回答内容</th>"+
									"		<th >回答时间</th>"+
								
									"	</tr>";
				
				$("#datahead").empty().append(head);
				var html = "";
				for(var i=0; i<list.length; i++) {
				
				var myDate=new Date();
							myDate.setTime(list[i].answer_time.time);
							var year=myDate.getFullYear();
							var month=myDate.getMonth()+1;
							var date=myDate.getDate();
							var hour=myDate.getHours();
							var minute=myDate.getMinutes();
							var second=myDate.getSeconds();
							var time=year+"-"+month+"-"+date+" "+hour+":"+minute+":"+second;
						
				
					html += ' <tr>'+
					'<td>'+list[i].question_content+'</td>'+
					'<td>'+list[i].answer_content+'</td>'+
					'<td>'+time+'</td>'+
					
					
					'</tr>';
				}
				$("#showAssistant").empty().append(html);
				$("#page").val(view.page);
			}
			
			if(index0==4){
			var list = data.noteViews;
				var view = data.page;
				var head="<tr>"+
									"	<th>课程名</th>"+
								
									"		<th >笔记内容</th>"+
									"		<th>笔记时间</th>"+
								
									"	</tr>";
				
				$("#datahead").empty().append(head);
				var html = "";
				for(var i=0; i<list.length; i++) {
				
				var myDate=new Date();
							myDate.setTime(list[i].noteTime.time);
							var year=myDate.getFullYear();
							var month=myDate.getMonth()+1;
							var date=myDate.getDate();
							var hour=myDate.getHours();
							var minute=myDate.getMinutes();
							var second=myDate.getSeconds();
							var time=year+"-"+month+"-"+date+" "+hour+":"+minute+":"+second;
						
				
					html += ' <tr>'+
					'<td>'+list[i].course_title+'</td>'+
					'<td>'+list[i].noteContent+'</td>'+
					'<td>'+time+'</td>'+
					
					
					'</tr>';
				}
				$("#showAssistant").empty().append(html);
				$("#page").val(view.page);
			}	
				
				if(value==0){
					if($("#pageFlag").val()==0){
						doPages(1,view.rows,view.total);
						$("#pageFlag").val(1);
					}
				}
			}
		});
	}
	</script>

