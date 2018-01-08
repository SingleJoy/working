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
            	<c:if test="${empty lessonAssessList}">
                    <div class="panel panel-default panel-col ">
                        <div class="panel-heading">
                            查看课例评价
                        </div>
                        <div class="panel-body">
                            <div class="empty">暂无数据</div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${!empty lessonAssessList}">

                <div class="panel panel-default panel-col course-data">
                    <div class="panel-heading">查看课例评价</div>

                    <div class="panel-body">
                        <div class="table-responsive">

                            <table class="table table-striped member-statistics" >
                                <tbody>
                                <tr>
                                    <td class="active" style="width: 10%;">姓名</td>
                                    <td class="active" style="width: 10%;">专家</td>
                                    <td class="active" style="width: 22%;">评价时间</td>
                                    <td class="active" style="text-align: center;width: 50%;">评价意见</td>
                                    <td class="active">推优</td>

                                </tr>
                                <c:forEach items="${lessonAssessList }" var="lessonAssess">
                                    <tr>
                                        <td >${lessonAssess.true_name}</td>
                                        <td >指导老师</td>
                                        <td>${lessonAssess.update_time}</td>
                                        <td style="text-align: left;">${lessonAssess.opinion}</td>
                                        <c:if test="${lessonAssess.excellent==1}">
                                            <td><span class="text-danger">是</span></td>
                                        </c:if>
                                        <c:if test="${lessonAssess.excellent==0}">
                                            <td>否</td>
                                        </c:if>

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

