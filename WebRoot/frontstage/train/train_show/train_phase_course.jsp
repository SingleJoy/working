<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<style>
	.stage-circle{width:50px;height: 50px;float: left;margin-left: 10px;}
	.stage-num{float: left;margin-right: 20px;font-size: 18px;padding-top: 40px;}
	.stage-num>span{padding:0 10px;line-height: 20px;}
	.required_course_no{background: url("${pageContext.request.contextPath}/frontstage/images/require_course_thumbtack.png") no-repeat;}
	.required_course_yes{background: url("${pageContext.request.contextPath}/frontstage/images/train_course_complete.png") no-repeat;}
	.selective_course_no{background: url("${pageContext.request.contextPath}/frontstage/images/selected_course_thumbtack.png") no-repeat;}
	.elective_course_yes{background: url("${pageContext.request.contextPath}/frontstage/images/train_course_complete.png") no-repeat;}
	.course-list{height: 40px;}
	.course-metas{display: block;float: right;cursor: pointer;padding-right: 20px;}
	.course-metas>span{z-index:100;color:red;font-size:16px;margin-top:4px;}
	.course-name{padding: 0 20px 0 10px;}
	.course-table tbody th td{overflow: hidden;}
	.course-show{float: right;margin:0 20px;cursor: pointer;}
     .course_info{padding-top:35px;font-size: 16px;}
     .course_info>img{margin-top: -18px;margin-right: 15px;}
	.stage-circle{background: url("${pageContext.request.contextPath}/frontstage/images/phase_clock.png") 5px 8px no-repeat;margin-top: 20px;}
	.stage-list{border: none;margin-bottom: 0;padding: 0;}
	.train_list_content{display: none;clear: both;margin-top: 20px;}
	.train_list_content>h5{margin-left: 15px;margin-bottom: 20px;}
	.stage_page{border: 1px solid #e1e1e1;border-radius: 4px;margin-bottom: 30px;}
</style>
<br/>
<c:forEach items="${trainPhaseList}" var="trainPhase" varStatus="phaseStatus">

	<div class="stage_page" >
		<div class="panel panel-default stage-list">
			<div class="panel-body" style="padding: 0;">

				<div style="height: 100px;background-color: #f5f5f5;">
					<div class="stage-circle"></div>

					<div class="stage-num">
						<span >第${phaseStatus.index+1}阶段:${trainPhase.name}</span>
					</div>

					<div class="pull-right course_info">

						<c:if test="${!empty currentUser }">
							<c:if test="${trainPhase.is_studyed==1}">
								<img src="${pageContext.request.contextPath}/frontstage/images/course_OK.png">
							</c:if>
						</c:if>

						<span class="course-show">
							<i class="glyphicon glyphicon-chevron-right"></i>
						</span>
						<div class="pull-right">已选
							<span id="optionCourseNum${trainPhase.id}" style="color:#ff0000;padding: 0 3px;">${trainPhase.optionCourseNum}</span>门
						</div>
					</div>
					<div style="margin-left: 70px;margin-top: 70px;position: absolute;opacity: 0.6;font-size: 14px;">
						已学<span class="text-danger">&nbsp;${trainPhase.finish_coursehour_total}&nbsp;</span>学时,
						还剩<span class="text-danger">&nbsp;
						<c:choose>
							<c:when test="${trainPhase.hour_require<=trainPhase.finish_coursehour_total}">
								0
							</c:when>
							<c:otherwise>
								${trainPhase.hour_require-trainPhase.finish_coursehour_total}
							</c:otherwise>
						</c:choose>
						&nbsp;</span>学时，
						必修课<span class="text-danger">&nbsp;${trainPhase.requiredCount}&nbsp;</span>门，已学完<span class="text-danger">&nbsp;${trainPhase.requiredFinishCount}&nbsp;</span>门
					</div>

				</div>

				<div class="train_list_content">
					<div style="margin-left: 15px;" class="pull-left">
						<img src="${pageContext.request.contextPath}/frontstage/images/require_course_thumbtack.png">&nbsp;必修课
						<img src="${pageContext.request.contextPath}/frontstage/images/selected_course_thumbtack.png">&nbsp;选修课
					</div>

					<h5 style="clear: both;line-height: 30px;">
						<label>阶段目标&nbsp;:&nbsp;</label>${trainPhase.target}<br/>
						<label>学习要求&nbsp;:&nbsp;</label>
						<span class="text-danger">${trainPhase.hour_require}&nbsp;&nbsp;</span>课时
					</h5>

					<c:forEach items="${trainPhase.requiredCourse}" var="course">
						<c:if test="${userStudyStatus != 3}">
							<input type="hidden" name="phase_course" value="${trainPhase.id}-${course.id}">
						</c:if>
						<div class="course-list col-md-6">

							<div class="title" style="display: inline;">
								<!--必修-->
									<%--注意若必修课已经学完required_course_yes变更为required_course_no--%>
								<a id="train_course_1_${course.id}" class="link-dark required_course_no"
									<c:choose>
								    	<c:when test="${(userStudyStatus==3&&trainPhase.is_studyed!=1) && (trainView.is_sort==0 && (phaseStatus.index>0&&phaseStatus.index>trainView.already_studyed_phase)) }">
								    		onclick="showSortStudy(${phaseStatus.index })"
								    	</c:when>
								    	<c:otherwise>
								    		onclick="doSearchCourse(${course.id},1);"
								    	</c:otherwise>
								    </c:choose>
								     href="javascript:void(0);" target="_blank" style="height:22px;padding-left: 20px;display:inline-block;">
									<span style="padding-left: 10px;">${course.title} </span>
									<c:if test="${course.is_studyed==1}">
										<img class="pull-right" src="${pageContext.request.contextPath}/frontstage/images/train_course_complete.png" style="margin-top: -10px;">
									</c:if>
								</a>


							</div>
						</div>
					</c:forEach>

					<div id="optionCourseDiv${trainPhase.id}">
						<c:if test="${!empty currentUser }">
							<c:if test="${userStudyStatus == 3}">
								<c:forEach items="${trainPhase.optionCourse}" var="course">
									<div class="course-list col-md-6" >
										<div class="title" style="display: inline;">
                                            <%--注意若选修课已经学完elective_course_no变更为elective_course_yes--%>
											<a id="train_course_1_${course.id}" class="link-dark selective_course_no"
											 onclick="doSearchCourse(${course.id},1);" href="javascript:void(0);" target="_blank" style="height:22px;padding-left: 20px;display: inline-block;">
											  <span style="padding-left: 10px;">${course.title} </span>
												<c:if test="${course.is_studyed==1}">
													<img class="pull-right" src="${pageContext.request.contextPath}/frontstage/images/train_course_complete.png">

												</c:if>
											</a>

										</div>

									</div>
								</c:forEach>
							</c:if>
						</c:if>
					</div>

                    <br/>
					<c:if test="${!empty trainPhase.unOptionCourse}">
					<div class="form-group clearfix" style="clear: both;">
						<label class="pull-left col-md-2">选择选修课</label>
						<div class="pull-right" style="margin-right: 10px;">
							<button class="btn btn-fat btn-primary" type="button" 
							<c:if test="${isTeacher&&(trainDetailView.viewType==1||trainDetailView.viewType==2) }">
								disabled="disabled"
							</c:if>
							<c:choose>
								<c:when test="${(userStudyStatus==3&&trainPhase.is_studyed!=1) && (trainView.is_sort==0 && (phaseStatus.index>0&&phaseStatus.index>trainView.already_studyed_phase)) }">
									onclick="showSortStudy(${phaseStatus.index })"
								</c:when>
								<c:otherwise>
								    onclick="doSave(${trainPhase.id});"
								</c:otherwise>
							</c:choose>
							>保存</button>
						</div>
                    </div>

						<div class="form-group" style="margin-top: 25px;">
							<div class="col-md-12 controls">
								<table class="table table-hover">
									<thead>
									<c:forEach items="${trainPhase.unOptionCourse}" var="course">
										<tr id="optionTr${trainPhase.id}-${course.id}">
											<td style="width: 6%;">
												<input type="checkbox" id="optionCheckbox${trainPhase.id}-${course.id}" name="optionCheckbox${trainPhase.id }" value="${course.id}">
												<input type="hidden" id="optionTitle${trainPhase.id}-${course.id}" value="${course.title }"/>
											</td>
											<td style="width: 80%;">
												<a id="train_course_1_${course.id}" class="course-name link-dark" href="javascript:void(0)" 
												<c:choose>
								    				<c:when test="${(userStudyStatus==3&&trainPhase.is_studyed!=1) && (trainView.is_sort==0 && (phaseStatus.index>0&&phaseStatus.index>trainView.already_studyed_phase)) }">
								    					onclick="showSortStudy(${phaseStatus.index })"
								    				</c:when>
								    				<c:otherwise>
								    					onclick="doSearchCourse(${course.id},1);"
								    				</c:otherwise>
								    			</c:choose>
												>${course.title }</a>
											</td>
											<td style="width: 14%">
												<span class="course-hour">${course.hours}学时</span>
											</td>
										</tr>
									</c:forEach>
									</thead>
								</table>
							</div>
						</div>
					</c:if>

				</div>

			</div>
		</div>
	</div>
</c:forEach>

<script type="text/javascript">

	//保存
	function doSave(phaseId){
		if(flag){
			check_login();
			return false;
		}
		
		if("${userStudyStatus!=3}"=="true"){
			alert("请先报名学习！");
			return false;
		}
		
		var	a = document.getElementsByName("optionCheckbox"+phaseId);
		var ids = "";
		var optionHtml = "";
		var optionCourseNum = document.getElementById('optionCourseNum'+phaseId).innerHTML;
		for(var i = 0;i<a.length;i++){
			if(a[i].checked){
				optionCourseNum = parseInt(optionCourseNum)+1;
				var courseId = a[i].value;
				var optionTitle = $("#optionTitle"+phaseId+"-"+courseId).val();
				ids +=courseId +",";
				optionHtml +='<div onmouseover="doMouseOver('+phaseId+','+courseId+');" onmouseout="doMouseOut('+phaseId+','+courseId+');" class=" course-list col-md-6"  id="optionDiv'+phaseId+'-'+courseId+'">'+
				'<input type="hidden" name="phase_course" value="'+phaseId+'-'+courseId+'">'+
				'<div class="title" style="display: inline;">'+
				'<a class="link-dark elective_course_no" id="train_course_1_'+courseId+'" onclick="doSearchCourse('+courseId+',1);" href="javascript:void(0);" target="_blank" style="height:22px;padding-left: 20px;display: inline-block;">'+
					'<span style="padding-left: 10px;">'+optionTitle+'</span>'+
				'</a>'+
				'</div></div>';
				$("#optionTr"+phaseId+"-"+courseId).hide();
			}
		}
		if(ids!=''){
			$("#optionCourseNum"+phaseId).empty().append(optionCourseNum);
			$("#optionCourseDiv"+phaseId).append(optionHtml);
			joinOptionCourse(0);
		}else{
			alert("请选择选修课!");
		}
	}

	function doMouseOver(phaseId,courseId){
		$("#course-metas"+phaseId+"-"+courseId).show();
	}
	function doMouseOut(phaseId,courseId){
		$("#course-metas"+phaseId+"-"+courseId).hide();
	}
	
	function showSortStudy(index){
		alert("请先完成第"+index+"阶段！");
	}

</script>
 