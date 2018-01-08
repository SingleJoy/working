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

                <div class="panel panel-default panel-col course-data">
                    <div class="panel-heading">${lesson.name}课例研究</div>
                    <div class="panel-body">
                        <div class="table-responsive">

                            <table class="table table-striped learning-data-table"  >
                                <tbody>
                                <tr>
                                    <td class="active">教学课题 / 教材版本</td>
                                    <td >${lessonShow.name}(${lessonShow.versionName})</td>
                                </tr>
                                <tr>
                                    <td class="active">学段 / 学科 / 年级</td>
                                    <td >${lessonShow.stageName } / ${lessonShow.subjectName } / ${lessonShow.grade_name }</td>
                                </tr>
                                <tr>
                                    <td class="active">上课教师</td>
                                    <td >${lessonShow.school }     ${lessonShow.username }</td>
                                </tr>
                                <tr>
                                    <td rowspan="2" class="active">研究目标</td>
                                    <td >${lesson.research }</td>

                                </tr>
                                <tr>
                                    <td >关键词:${lesson.research_key }</td>
                                </tr>
                                <tr>
                                    <td class="active">研究措施</td>
                                    <td >${lesson.measures }</td>

                                </tr>


                                </tbody>
                            </table>

                            <table class="table table-striped">
                                <tbody>
                                <!--计划环节-->
                                <tr>
                                    <td rowspan="3" style="width: 27%;" class="active">计划环节<br/>
                                        <fmt:formatDate value="${lessonTimeView.plan_sta}" type="date"/>至<fmt:formatDate value="${lessonTimeView.plan_end}" type="date"/>
                                    </td>
                                    <td style="left: 37%;">1.制定计划</td>
                                    <td style="width: 36%;">
										<c:forEach items="${lessonUserTaskList }" var="lessonUser">
											<c:if test="${lessonUser.purview ==101}">
												<c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>
											</c:if>
										</c:forEach>
									</td>

                                </tr>

                                <tr>
                                    <td style="left: 37%;">2.教学内容及参考</td>
                                    <td style="width: 36%;">
									<c:forEach items="${lessonUserTaskList }" var="lessonUser">
											<c:if test="${lessonUser.purview ==102}">
												<c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>
											</c:if>
									</c:forEach>
									</td>

                                </tr>
                                <tr>
                                    <td style="left: 37%;">3.问题研讨</td>
                                    <td style="width: 36%;">
                                    <c:forEach items="${lessonUserTaskList }" var="lessonUser">
											<c:if test="${lessonUser.purview ==103}">
												<c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>
											</c:if>
									</c:forEach>
                                    </td>
                                </tr>

                                <!--备课环节-->
                                <tr>
                                    <td rowspan="4" style="width: 27%;" class="active">备课环节<br/>
                                        <fmt:formatDate value="${lessonTimeView.prepare_sta}" type="date"/>至<fmt:formatDate value="${lessonTimeView.prepare_end}" type="date"/>
                                    </td>
                                    <td >1.初始教案协同修该</td>
                                    <td>
                                    <c:forEach items="${lessonUserTaskList }" var="lessonUser">
											<c:if test="${lessonUser.purview ==201}">
												<c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>
											</c:if>
									</c:forEach>
                                    </td>

                                </tr>

                                <tr>
                                    <td style="left: 37%;">2.备课研讨会</td>
                                    <td style="width: 36%;">
                                    <c:forEach items="${lessonUserTaskList }" var="lessonUser">
											<c:if test="${lessonUser.purview ==202}">
												<c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>
											</c:if>
									</c:forEach>
                                    </td>

                                </tr>
                                <tr>
                                    <td style="left: 37%;">3.备课:问题研讨</td>
                                    <td style="width: 36%;">
                                    <c:forEach items="${lessonUserTaskList }" var="lessonUser">
											<c:if test="${lessonUser.purview ==203}">
												<c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>
											</c:if>
									</c:forEach>
                                    </td>
                                </tr>

                                <tr>
                                    <td style="left: 37%;">4.发布修改后教案</td>
                                    <td style="width: 36%;">
                                    <c:forEach items="${lessonUserTaskList }" var="lessonUser">
											<c:if test="${lessonUser.purview ==204}">
												<c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>
											</c:if>
									</c:forEach>
                                    </td>
                                </tr>
                                <!--上课环节-->
                                <tr>
                                    <td rowspan="4" style="width: 27%;" class="active">上课环节<br/>
                                        <fmt:formatDate value="${lessonTimeView.class_sta}" type="date"/>至<fmt:formatDate value="${lessonTimeView.class_end}" type="date"/>
                                    </td>
                                    <td>1.观课准备会(提交记录)</td>
                                    <td>
                                    <c:forEach items="${lessonUserTaskList }" var="lessonUser">
											<c:if test="${lessonUser.purview ==301}">
												<c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>
											</c:if>
									</c:forEach>
                                    </td>

                                </tr>

                                <tr>
                                    <td style="left: 37%;">2.提交观课量化表</td>
                                    <td style="width: 36%;">
                                    <c:forEach items="${lessonUserTaskList }" var="lessonUser">
											<c:if test="${lessonUser.purview ==302}">
												<c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>
											</c:if>
									</c:forEach>
                                    </td>

                                </tr>
                                <tr>
                                    <td style="left: 37%;">3.观课:问题研讨</td>
                                    <td style="width: 36%;">
                                    <c:forEach items="${lessonUserTaskList }" var="lessonUser">
											<c:if test="${lessonUser.purview ==303}">
												<c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>
											</c:if>
									</c:forEach>
                                    </td>
                                </tr>

                                <tr>
                                    <td style="left: 37%;">4.提交上课实录(视频或者实录)</td>
                                    <td style="width: 36%;">
                                    <c:forEach items="${lessonUserTaskList }" var="lessonUser">
											<c:if test="${lessonUser.purview ==304}">
												<c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>
											</c:if>
									</c:forEach>
                                    </td>
                                </tr>
                                
                                <!--评课环节-->
                                <tr>
                                    <td rowspan="3" style="width: 27%;" class="active">评课环节<br/>
                                        <fmt:formatDate value="${lessonTimeView.assessment_sta}" type="date"/>至<fmt:formatDate value="${lessonTimeView.assessment_end}" type="date"/>
                                    </td>
                                    <td >1.发布观课报告</td>
                                    <td >
                                    <c:forEach items="${lessonUserTaskList }" var="lessonUser">
											<c:if test="${lessonUser.purview ==401}">
												<c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>
											</c:if>
									</c:forEach>
                                    </td>

                                </tr>

                                <tr>
                                    <td style="left: 37%;">2.课后评议会(提交会议记录)</td>
                                    <td style="width: 36%;">
                                    <c:forEach items="${lessonUserTaskList }" var="lessonUser">
											<c:if test="${lessonUser.purview ==402}">
												<c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>
											</c:if>
									</c:forEach>
                                    </td>

                                </tr>
                                <tr>
                                    <td style="left: 37%;">3.评课:问题研讨</td>
                                    <td style="width: 36%;">
                                    <c:forEach items="${lessonUserTaskList }" var="lessonUser">
											<c:if test="${lessonUser.purview ==403}">
												<c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>
											</c:if>
									</c:forEach>
                                    </td>
                                </tr>
                                <!--反思环节-->
                                <tr>
                                    <td rowspan="3" style="width: 27%;" class="active">反思环节<br/>
                                        <fmt:formatDate value="${lessonTimeView.introspection_sta}" type="date"/>至<fmt:formatDate value="${lessonTimeView.introspection_end}" type="date"/>
                                    </td>
                                    <td >1.实践反思后备课</td>
                                    <td >
                                    <c:forEach items="${lessonUserTaskList }" var="lessonUser">
											<c:if test="${lessonUser.purview ==501}">
												<c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>
											</c:if>
									</c:forEach>
                                    </td>

                                </tr>

                                <tr>
                                    <td style="left: 37%;">2.撰写发表反思心得</td>
                                    <td style="width: 36%;">
                                    <c:forEach items="${lessonUserTaskList }" var="lessonUser">
											<c:if test="${lessonUser.purview ==502}">
												<c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>
											</c:if>
									</c:forEach>
                                    </td>

                                </tr>
                                
                                <tr>
                                    <td style="left: 37%;">2.自评总结</td>
                                    <td style="width: 36%;">
                                    <c:forEach items="${lessonUserTaskList }" var="lessonUser">
											<c:if test="${lessonUser.purview ==503}">
												<c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>
											</c:if>
									</c:forEach>
                                    </td>

                                </tr>


                                </tbody>
                            </table>

                        </div>
                    </div>
                    <form id="" method="post" action="" novalidate="novalidate" >
                        <div class="form-group controls">
                            请打分：
                            <span data-rating="0"  class="rating-btn" style="cursor: pointer; width: 100px;">
                                <img src="http://scc1a8b2s6-static.qiqiuyun.net/assets/img/raty/star-on.png" alt="1" title="很差">&nbsp;
                                <img src="http://scc1a8b2s6-static.qiqiuyun.net/assets/img/raty/star-on.png" alt="2" title="较差">&nbsp;
                                <img src="http://scc1a8b2s6-static.qiqiuyun.net/assets/img/raty/star-on.png" alt="3" title="还行">&nbsp;
                                <img src="http://scc1a8b2s6-static.qiqiuyun.net/assets/img/raty/star-on.png" alt="4" title="推荐">&nbsp;
                                <img src="http://scc1a8b2s6-static.qiqiuyun.net/assets/img/raty/star-off.png" alt="5" title="力荐">

                            </span>
                            <div class="help-block" style="display:none;"></div>
                        </div>

                        <div class="form-group controls">
                            <textarea class="form-control" rows="8"  name=""  placeholder="最多输入500字"></textarea>
                            <div class="help-block" style="display:none;"></div>
                        </div>

                        <div class="form-group clearfix">
                            <span class="text-success pull-left" style="display: none;">评价已保存！</span>
                            <a href="javascript:;" class="btn btn-primary pull-right js-btn-save" >保存</a>
                            <a href="javascript:;" class="btn btn-link pull-right js-hide-review-form">取消</a>
                        </div>

                        <div class="js-reviews" >
                            <div class="media media-evaluate">
                                <div class="media-left">
                                    <a class=" js-user-card" href="javascript:void(0);" >
                                        <img class="avatar-sm" src="http://scc1a8b2s6-static.qiqiuyun.net/files/user/2016/07-03/073023f91615826360.jpg">

                                    </a>

                                </div>
                                <div class="media-body thread-post">
                                    <div class="title">
                                        <a class="link-dark " href="javascript:void (0);">我亦所望</a>
                                        &nbsp;&nbsp;
                                        2016-09-25
                                    </div>
                                    <div class="score">

                                        <i class="es-icon es-icon-star color-warning"></i>
                                        <i class="es-icon es-icon-star color-warning"></i>
                                        <i class="es-icon es-icon-star color-warning"></i>
                                        <i class="es-icon es-icon-star color-warning"></i>
                                        <i class="es-icon es-icon-star"></i>

                                    </div>
                                    <div class="content">
                                        <div class="full-content" >非常好001</div>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <div class="js-reviews" >
                            <div class="media media-evaluate">
                                <div class="media-left">
                                    <a class=" js-user-card" href="javascript:void(0);" >
                                        <img class="avatar-sm" src="http://scc1a8b2s6-static.qiqiuyun.net/files/user/2016/07-03/073023f91615826360.jpg">
                                    </a>

                                </div>
                                <div class="media-body thread-post">
                                    <div class="title">    <a class="link-dark " href="/user/23365">我亦所望</a>
                                        &nbsp;&nbsp;
                                        2016-09-25
                                    </div>
                                    <div class="score">
                                        <i class="es-icon es-icon-star color-warning"></i>
                                        <i class="es-icon es-icon-star color-warning"></i>
                                        <i class="es-icon es-icon-star color-warning"></i>
                                        <i class="es-icon es-icon-star color-warning"></i>
                                        <i class="es-icon es-icon-star"></i>

                                    </div>
                                    <div class="content">
                                        <div class="full-content" >非常好
                                        </div>
                                    </div>


                                </div>
                            </div>
                        </div>
                    </form>

                </div>
            </div>

        </div>
    </div>

    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>

</div>


