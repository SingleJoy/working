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
            	<c:if test="${empty lessonAttachmentList and empty lessonAssessList}">
                    <div class="panel panel-default panel-col ">
                        <div class="panel-heading">
                           课例评价
                        </div>
                        <div class="panel-body">
                            <div class="empty">暂无数据</div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${!empty lessonAttachmentList or !empty lessonAssessList}">
                <div class="panel panel-default panel-col">

                    <div class="panel-heading">课例评价</div>

                    <div class="panel-body">

                        <table class="table table-striped member-statistics" style="text-align: center;">
                            <tbody>
                            <tr>
                                <td class="active" width="10%">序号</td>
                                <td class="active" width="53%">文章资源名称</td>
                                <td class="active" width="22%">发布时间</td>
                                <td class="active" width="15%">浏览数</td>
                            </tr>
                            <c:forEach items="${lessonAttachmentList }" var="lessonAttachment" varStatus="status">
                                <tr>
                                    <td>${ status.index + 1}</td>
                                    <td>${lessonAttachment.name}</td>
                                    <td>${lessonAttachment.update_time}</td>
                                    <td>${lessonAttachment.scan_count}</td>
                                </tr>
                            </c:forEach>

                            </tbody>
                        </table>
                        <form class="form-horizontal">
                        <c:if test="${!empty lesson.self_evaluation}">
                        	<h5 >自我总结</h5>
                         <div class="form-group controls">
                                    <div class="col-md-12 controls ">
                                        <textarea  class="form-control" disabled rows="4" >${lesson.self_evaluation}</textarea>

                                    </div>
                                </div>
                                </c:if>

                            <c:forEach items="${lessonAssessList }" var="lessonAssess">
                                <h5 >指导教师评价:&nbsp;&nbsp;${lessonAssess.true_name}</h5>
                                <div class="form-group controls">
                                    <div class="col-md-12 controls ">
                                        <textarea  class="form-control" disabled rows="4" >${lessonAssess.opinion}</textarea>

                                    </div>
                                </div>

                            </c:forEach>

                        </form>

                    </div>
                </div>
                </c:if>
            </div>

        </div>
    </div>

</div>


<jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
