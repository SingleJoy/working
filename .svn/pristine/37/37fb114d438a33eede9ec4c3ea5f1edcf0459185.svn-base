<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!--教师 -->
<div class="panel panel-col">

    <div class="panel-body">
        <div class="course-list">
            <div class="row">

                <c:if test="${!empty studentList }">

                    <c:forEach items="${studentList}" var="student">
                        <div class="col-md-3 col-xs-6 attent" data-user="${student.user_id }">
                            <div class="teacher-item" >
                                <div class="teacher-top">
                                    <a class="teacher-img" href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id=${student.user_id}">
                                        <img class="avatar-lg" src="${pageContext.request.contextPath}${student.icon}" alt="" style="height: 120px;display: inline-block;">
                                    </a>
                                    <h3 class="title">
                                        <a class="link-dark" href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id=${student.user_id}">${student.true_name}</a>
                                    </h3>
                                    <div class="position">
                                        <c:if test="${empty student.titles}">无职称</c:if>
                                        <c:if test="${!empty student.titles}">${student.titles}</c:if>
                                    </div>
                                </div>
                                <div class="teacher-bottom">
                                    <div class="about">
                                            ${student.course}
                                    </div>
                                    <div class="metas">
                                        <a class="btn btn-primary btn-sm follow-btn" href="javascript:;"  style="display:none;"  data-user="${student.user_id }">关注</a>
                                        <a class="btn btn-default btn-sm unfollow-btn" href="javascript:;"  >已关注</a>
                                        <a class="btn btn-default btn-sm"  href="#private-modal" data-toggle="modal" onclick="send_private_messages(${student.user_id },'${student.username}')">私信</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                </c:if>

                <c:if test="${empty studentList }">
                    <div class="empty">暂无数据</div>
                </c:if>

            </div>

            <c:if test="${!empty studentList }">
                <div id="test" class="pager" ></div>
            </c:if>

        </div>
    </div>
</div>
