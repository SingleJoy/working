<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="col-md-3">
    <div class="sidenav locked">
        <ul class="list-group">
            <li class="list-group-heading">工作坊信息</li>
            <li class="list-group-item <c:if test="${workshopView.stamp==11}">active</c:if>">
               <a href="${pageContext.request.contextPath}/workshop/to_workshop_main.action?id=${workshopView.id}">
                    <span ></span>基础信息
                </a>
            </li>
            <li class="list-group-item <c:if test="${workshopView.stamp==0}">active</c:if>">
                <a href="${pageContext.request.contextPath}/class_belongs/to_community_course.action?id=${workshopView.id}&source_type=1&stamp=0">
                    <span  ></span>工作坊课程
                </a>
            </li>
            <li class="list-group-item <c:if test="${workshopView.stamp==1}">active</c:if>">
                <a href="${pageContext.request.contextPath}/class_belongs/to_community_train.action?id=${workshopView.id}&source_type=1&stamp=1">
                    <span  ></span>工作坊培训
                </a>
            </li>
            <li class="list-group-item <c:if test="${workshopView.stamp==2}">active</c:if>">
                <a href="${pageContext.request.contextPath}/lesson/to_lesson.action?workshop_id=${workshopView.id}&source_type=1">
                    <span  ></span>工作坊课例
                </a>
            </li>
         <li class="list-group-item <c:if test="${workshopView.stamp==12}">active</c:if>">
                <a href="${pageContext.request.contextPath}/workshop/to_file.action?source_id=${workshopView.id}&source_type=2">
                    <span  ></span>资源管理
                </a>
            </li>
            <li class="list-group-item <c:if test="${workshopView.stamp==4}">active</c:if>">
                <a href="${pageContext.request.contextPath}/topic_question/to_topic.action?source_id=${workshopView.id}&source_type=1">
                    <span  ></span>话题
                </a>
            </li>
            <li class="list-group-item <c:if test="${workshopView.stamp==5}">active</c:if>">
                <a href="${pageContext.request.contextPath}/message/to_info_manager.action?source_id=${workshopView.id}&source_type=1&stamp=5&sort=id&order=desc">
                    <span  ></span>公共管理
                </a>
            </li>
            <li class="list-group-item <c:if test="${workshopView.stamp==6}">active</c:if>">
                <a href="${pageContext.request.contextPath}/student_relation/to_student_relation_manager.action?id=${workshopView.id}&source_id=${workshopView.id}&source_type=1&stamp=6">
                    <span  ></span>用户管理
                </a>
            </li>
            <%--<li class="list-group-item <c:if test="${workshopView.stamp==7}">active</c:if>">--%>
                <%--<a href="">--%>
                    <%--<span  ></span>计划管理--%>
                <%--</a>--%>
            <%--</li>--%>
        </ul>
        <ul class="list-group">
            <li class="list-group-heading">分类管理</li>
            <li class="list-group-item <c:if test="${workshopView.stamp==8}">active</c:if>">
                <a href="${pageContext.request.contextPath}/classify_relation/to_classif_manager.action?id=${workshopView.id}&source_id=${workshopView.id}&source_type=1&type=0&stamp=8">
                    <span  ></span>课程分类管理
                </a>
            </li>
            <li class="list-group-item <c:if test="${workshopView.stamp==9}">active</c:if>">
                <a href="${pageContext.request.contextPath}/classify_relation/to_classif_manager.action?id=${workshopView.id}&source_id=${workshopView.id}&source_type=1&type=1&stamp=9">
                    <span  ></span>培训分类管理
                </a>
            </li>
        </ul>
        <ul class="list-group">
            <li class="list-group-heading">统计</li>
            <li class="list-group-item <c:if test="${workshopView.stamp==10}">active</c:if>">
                <a href="${pageContext.request.contextPath}/community/to_data_stats.action?id=${workshopView.id}&stamp=10&dataType=1">
                    <span  ></span>数据统计
                </a>
            </li>
        </ul>
    </div>
</div>