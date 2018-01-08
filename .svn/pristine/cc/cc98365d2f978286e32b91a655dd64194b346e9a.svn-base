<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>



<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<div class="cn-wrap">

    <div id="content-container" class="container">

        <jsp:include page="/frontstage/xbjy/lesson/lesson_header.jsp"></jsp:include>

        <div class="course-detail row" style="margin-top: 20px;">

            <jsp:include page="/frontstage/xbjy/lesson/lesson_left.jsp"></jsp:include>

            <div class="col-lg-9 col-md-8  course-detail-main">
            	<c:if test="${lessonLeft.plan101!=1}">
                    <div class="panel panel-default panel-col ">
                        <div class="panel-heading">
                           成员统计
                        </div>
                        <div class="panel-body">
                            <div class="empty">暂无数据</div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${lessonLeft.plan101==1}">

                <div class="panel panel-default panel-col course-data">

                    <div class="panel-heading">成员统计</div>

                    <div class="panel-body">
                        <div class="table-responsive">


                            <table class="table table-striped member-statistics" style="text-align: center;">
                                <tbody>
                                <tr>
                                    <td class="active" width="20%">姓名</td>
                                    <td class="active" width="20%">分配任务</td>
                                    <td class="active" width="20%">完成任务</td>
                                    <td class="active" width="20%">文章资源</td>
                                    <td class="active" width="20%">研讨评论</td>
                                </tr>
                                <c:forEach items="${memberStatisticsList }" var="memberStatistics">
                                    <tr>
                                        <td>${ memberStatistics.true_name}</td>
                                        <td>${ memberStatistics.taskTotal}</td>
                                        <td>${ memberStatistics.accomplishedTotal}</td>
                                        <td>${ memberStatistics.articleTotal}</td>
                                        <td>${ memberStatistics.problemTotal}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                </c:if>
            </div>

        </div>
    </div>


    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
</div>


