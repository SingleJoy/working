<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<div class="cn-wrap" >


	<div id="content-container" class="container">

		<jsp:include page="/frontstage/xbjy/lesson/lesson_header.jsp"></jsp:include>

		<div class="course-detail row" style="margin-top: 20px;">

			<jsp:include page="/frontstage/xbjy/lesson/lesson_left.jsp"></jsp:include>

			<div class="col-lg-9 col-md-8  course-detail-main">
				<c:if test="${lessonLeft.plan101!=1}">
                    <div class="panel panel-default panel-col ">
                        <div class="panel-heading">
							全组完成情况
                        </div>
						<div class="panel-body">
							<div class="empty">暂无数据</div>
						</div>
                    </div>
                </c:if>
                <c:if test="${lessonLeft.plan101==1}">

				<div class="panel panel-default panel-col course-data">
					<div class="panel-heading"> 全组完成情况</div>

					<div class="panel-body">
						<div class="table-responsive">
							<h5>上课老师:
								${lesson.user_sk_name }
							</h5>
							<!--计划环节-->

							<h4 class="text-warning" style="margin-top: 40px;"><span class="pull-left">计划环节</span>
								<h5 class="pull-right">
									开始时间:<fmt:formatDate value="${lessonTimeView.plan_sta}" type="date"/>
									&nbsp; &nbsp;结束时间:<fmt:formatDate value="${lessonTimeView.plan_end}" type="date"/></h5>
							</h4>
							<table class="table table-striped all-statistics"  >
								<tbody>
								<tr>
									<td class="active">1.制定计划</td>
									<td>
										<c:forEach items="${lessonUserTaskList }" var="lessonUser">

											<c:if test="${lessonUser.purview ==101}">
												<c:if test="${lessonUser.status !=2}">
													<span class="mission-fail"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></span>
												</c:if>
												<c:if test="${lessonUser.status ==2}">
													<span class="mission-accomplished"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></span>
												</c:if>
											</c:if>
										</c:forEach>
									</td>
								</tr>
								<tr>
									<td class="active">2.教学内容及参考</td>
									<td >
										<c:forEach items="${lessonUserTaskList }" var="lessonUser">

											<c:if test="${lessonUser.purview ==102}">
												<c:if test="${lessonUser.status !=2}">
													<span class="mission-fail"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></span>
												</c:if>
												<c:if test="${lessonUser.status ==2}">
													<span class="mission-accomplished"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></span>
												</c:if>
											</c:if>
										</c:forEach>
									</td>
								</tr>
								<tr>
									<td class="active">3.计划:问题研讨</td>
									<td >
										<c:forEach items="${lessonUserTaskList }" var="lessonUser">

											<c:if test="${lessonUser.purview ==103}">
												<c:if test="${lessonUser.status !=2}">
													<span class="mission-fail"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></span>
												</c:if>
												<c:if test="${lessonUser.status ==2}">
													<span class="mission-accomplished"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></span>
												</c:if>
											</c:if>
										</c:forEach>
									</td>
								</tr>


								</tbody>
							</table>

							<!--备课环节-->


							<h4 class="text-warning " style="margin-top: 40px;"><span class="pull-left">备课环节</span>
								<h5 class="pull-right">开始时间:<fmt:formatDate value="${lessonTimeView.prepare_sta}" type="date"/>
									&nbsp; &nbsp; 结束时间:<fmt:formatDate value="${lessonTimeView.prepare_end}" type="date"/>
								</h5>
							</h4>
							<table class="table table-striped all-statistics"  >
								<tbody>
								<tr>
									<td class="active">1.初始教案协同修该</td>
									<td>
										<c:forEach items="${lessonUserTaskList }" var="lessonUser">
											<c:if test="${lessonUser.purview ==201}">
												<c:if test="${lessonUser.status !=2}">
													<span class="mission-fail"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></span>
												</c:if>
												<c:if test="${lessonUser.status ==2}">
													<span class="mission-accomplished"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></span>
												</c:if>
											</c:if>
										</c:forEach>
									</td>
								</tr>
								<tr>
									<td class="active">2.备课研讨会(提交记录)</td>
									<td >
										<c:forEach items="${lessonUserTaskList }" var="lessonUser">
											<c:if test="${lessonUser.purview ==202}">
												<c:if test="${lessonUser.status !=2}">
													<span class="mission-fail"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></span>
												</c:if>
												<c:if test="${lessonUser.status ==2}">
													<span class="mission-accomplished"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></span>
												</c:if>
											</c:if>
										</c:forEach>

									</td>
								</tr>
								<tr>
									<td class="active">3.备课:问题研讨</td>
									<td >
										<c:forEach items="${lessonUserTaskList }" var="lessonUser">
											<c:if test="${lessonUser.purview ==203}">
												<c:if test="${lessonUser.status !=2}">
													<span class="mission-fail"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></span>
												</c:if>
												<c:if test="${lessonUser.status ==2}">
													<span class="mission-accomplished"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></span>
												</c:if>
											</c:if>
										</c:forEach>
									</td>
								</tr>
								<tr>
									<td class="active">4.发布修改后教案</td>
									<td >
										<c:forEach items="${lessonUserTaskList }" var="lessonUser">
											<c:if test="${lessonUser.purview ==204}">
												<c:if test="${lessonUser.status !=2}">
													<span class="mission-fail"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></span>
												</c:if>
												<c:if test="${lessonUser.status ==2}">
													<span class="mission-accomplished"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></span>
												</c:if>
											</c:if>
										</c:forEach>
									</td>
								</tr>

								</tbody>
							</table>

							<!--上课环节-->

							<h4 class="text-warning" style="margin-top: 40px;"><span class="pull-left">上课环节</span>
								<h5 class="pull-right">
									开始时间:<fmt:formatDate value="${lessonTimeView.class_sta}" type="date"/>
									&nbsp; &nbsp;结束时间:<fmt:formatDate value="${lessonTimeView.class_end}" type="date"/>
								</h5>
							</h4>
							<table class="table table-striped all-statistics">
								<tbody>
								<tr>
									<td class="active">1.观课准备会(提交记录)</td>
									<td>
										<c:forEach items="${lessonUserTaskList }" var="lessonUser">
											<c:if test="${lessonUser.purview ==301}">
												<c:if test="${lessonUser.status !=2}">
													<span class="mission-fail"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></span>
												</c:if>
												<c:if test="${lessonUser.status ==2}">
													<span class="mission-accomplished"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></span>
												</c:if>
											</c:if>
										</c:forEach>
									</td>
								</tr>
								<tr>
									<td class="active">2.提交观课量表</td>
									<td >
										<c:forEach items="${lessonUserTaskList }" var="lessonUser">
											<c:if test="${lessonUser.purview ==302}">
												<c:if test="${lessonUser.status !=2}">
													<span class="mission-fail"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></span>
												</c:if>
												<c:if test="${lessonUser.status ==2}">
													<span class="mission-accomplished"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></span>
												</c:if>
											</c:if>
										</c:forEach>
									</td>
								</tr>
								<tr>
									<td class="active">3.观课:问题研讨</td>
									<td >
										<c:forEach items="${lessonUserTaskList }" var="lessonUser">
											<c:if test="${lessonUser.purview ==303}">
												<c:if test="${lessonUser.status !=2}">
													<span class="mission-fail"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></span>
												</c:if>
												<c:if test="${lessonUser.status ==2}">
													<span class="mission-accomplished"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></span>
												</c:if>
											</c:if>
										</c:forEach>
									</td>
								</tr>
								<tr>
									<td class="active">4.提交上课实录(视频或实录)</td>
									<td >
										<c:forEach items="${lessonUserTaskList }" var="lessonUser">
											<c:if test="${lessonUser.purview ==304}">
												<c:if test="${lessonUser.status !=2}">
													<span class="mission-fail"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></span>
												</c:if>
												<c:if test="${lessonUser.status ==2}">
													<span class="mission-accomplished"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></span>
												</c:if>
											</c:if>
										</c:forEach>
									</td>
								</tr>

								</tbody>
							</table>

							<!--评课环节-->

							<h4 class="text-warning" style="margin-top: 40px;"><span class="pull-left">评课环节</span>
								<h5 class="pull-right">
									开始时间:<fmt:formatDate value="${lessonTimeView.assessment_sta}" type="date"/>
									&nbsp; &nbsp;结束时间:<fmt:formatDate value="${lessonTimeView.assessment_end}" type="date"/>
								</h5>
							</h4>
							<table class="table table-striped all-statistics"  >
								<tbody>
								<tr>
									<td class="active">1.发布观课报告</td>
									<td>
										<c:forEach items="${lessonUserTaskList }" var="lessonUser">
											<c:if test="${lessonUser.purview ==401}">
												<c:if test="${lessonUser.status !=2}">
													<span class="mission-fail"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></span>
												</c:if>
												<c:if test="${lessonUser.status ==2}">
													<span class="mission-accomplished"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></span>
												</c:if>
											</c:if>
										</c:forEach>
									</td>
								</tr>
								<tr>
									<td class="active">2.课后评议会(提交会议记录)</td>
									<td >
										<c:forEach items="${lessonUserTaskList }" var="lessonUser">
											<c:if test="${lessonUser.purview ==402}">
												<c:if test="${lessonUser.status !=2}">
													<span class="mission-fail"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></span>
												</c:if>
												<c:if test="${lessonUser.status ==2}">
													<span class="mission-accomplished"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></span>
												</c:if>
											</c:if>
										</c:forEach>
									</td>
								</tr>

								<tr>
									<td class="active">3.观课:问题研讨</td>
									<td >
										<c:forEach items="${lessonUserTaskList }" var="lessonUser">
											<c:if test="${lessonUser.purview ==403}">
												<c:if test="${lessonUser.status !=2}">
													<span class="mission-fail"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></span>
												</c:if>
												<c:if test="${lessonUser.status ==2}">
													<span class="mission-accomplished"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></span>
												</c:if>
											</c:if>
										</c:forEach>
									</td>
								</tr>

								</tbody>
							</table>

							<!--反思环节-->

							<h4 class="text-warning " style="margin-top: 40px;"><span class="pull-left">反思环节</span>
								<h5 class="pull-right">
									开始时间:<fmt:formatDate value="${lessonTimeView.introspection_sta}" type="date"/>
									&nbsp; &nbsp;结束时间:<fmt:formatDate value="${lessonTimeView.introspection_end}" type="date"/>
								</h5>
							</h4>
							<table class="table table-striped all-statistics"  >
								<tbody>
								<tr>
									<td class="active">1.时间反思后的备课(提交调整后的教案)</td>
									<td>
										<c:forEach items="${lessonUserTaskList }" var="lessonUser">
											<c:if test="${lessonUser.purview ==501}">
												<c:if test="${lessonUser.status !=2}">
													<span class="mission-fail"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></span>
												</c:if>
												<c:if test="${lessonUser.status ==2}">
													<span class="mission-accomplished"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></span>
												</c:if>
											</c:if>
										</c:forEach>
									</td>
								</tr>
								<tr>
									<td class="active">2.撰写反思心得</td>
									<td >
										<c:forEach items="${lessonUserTaskList }" var="lessonUser">
											<c:if test="${lessonUser.purview ==502}">
												<c:if test="${lessonUser.status !=2}">
													<span class="mission-fail"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></span>
												</c:if>
												<c:if test="${lessonUser.status ==2}">
													<span class="mission-accomplished"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></span>
												</c:if>
											</c:if>
										</c:forEach>
									</td>
								</tr>
								<tr>
									<td class="active">3.自评总结</td>
									<td >
										<c:forEach items="${lessonUserTaskList }" var="lessonUser">
											<c:if test="${lessonUser.purview ==503}">
												<c:if test="${lessonUser.status !=2}">
													<span class="mission-fail"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></span>
												</c:if>
												<c:if test="${lessonUser.status ==2}">
													<span class="mission-accomplished"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></span>
												</c:if>
											</c:if>
										</c:forEach>
									</td>
								</tr>

								</tbody>
							</table>

						</div>
					</div>
				</div>
				</c:if>
			</div>

		</div>
	</div>

</div>


<jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
