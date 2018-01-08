<%@ page language="java" import="java.util.*,cn.bnsr.edu_yun.frontstage.base.po.User" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="col-md-3">
    <div class="sidenav locked">
        <ul class="list-group">
            <li class="list-group-heading">课程信息</li>

            <li class="list-group-item <c:if test="${courseView.sign==1 }">active</c:if>">
                <a href="${pageContext.request.contextPath}/course/to_course_info.action?id=${courseView.id}&flag=2&sign=1">
                    <span  ></span>基本信息
                </a>
            </li>
            <li class="list-group-item <c:if test="${courseView.sign==2 }">active</c:if>">
                <a href="${pageContext.request.contextPath}/course_info/to_course_detail.action?id=${courseView.id}&flag=2&sign=2">
                    <span  ></span>详细信息
                </a>
            </li>
            <li class="list-group-item <c:if test="${courseView.sign==3 }">active</c:if>">
                <a href="${pageContext.request.contextPath}/course_info/to_course_detail.action?id=${courseView.id}&flag=2&sign=3">
                    <span  ></span>课程图片
                </a>
            </li>
            <li class="list-group-item <c:if test="${courseView.sign==4 }">active</c:if>">
                <a href="${pageContext.request.contextPath}/course_hour/to_course_hour.action?id=${courseView.id}&flag=2&sign=4">
                    <span ></span>课时管理
                </a>
            </li>
            <li class="list-group-item <c:if test="${courseView.sign==5 }">active</c:if>">
                <a href="${pageContext.request.contextPath}/course_file/to_course_file.action?id=${courseView.id}&flag=2&sign=5">
                    <span ></span>课程文件
                </a>
            </li>
        </ul>

        <ul class="list-group">
            <li class="list-group-heading ">课程设置</li>
            <li class="list-group-item <c:if test="${courseView.sign==6 }">active</c:if>">
                <a href="${pageContext.request.contextPath}/course_info/to_course_detail.action?id=${courseView.id}&flag=2&sign=6">
                    <span ></span>价格设置
                </a>
            </li>
            <li class="list-group-item <c:if test="${courseView.sign==7 }">active</c:if>">
                <a href="${pageContext.request.contextPath}/teacher_relation/to_teacher_relation.action?id=${courseView.id}&flag=2&sign=7">
                    <span ></span>教师设置
                </a>
            </li>
             <%--    <li class="list-group-item <c:if test="${courseView.sign==8 }">active</c:if>">
                            <a href="${pageContext.request.contextPath}/user_study/to_class_student_manage.action?id=${courseView.id}&flag=2&sign=8">
                                <span></span>学员管理
                            </a>
                        </li> --%>
            <c:if test="${courseView.is_check==0 }">
	            <li class="list-group-item <c:if test="${courseView.sign==9 }">active</c:if>">
	                <a href="${pageContext.request.contextPath}/course_exam_standard/to_course_exam_standard.action?id=${courseView.id}&flag=2&sign=9&course_id=${courseView.id}">
	                    <span></span>考核标准设置
	                </a>
	            </li>
            </c:if>
        </ul>

        <ul class="list-group">
            <li class="list-group-heading">题库</li>
            <li class="list-group-item <c:if test="${courseView.sign==10 }">active</c:if>">
                <a href=" ${pageContext.request.contextPath}/question/to_question.action?courseId=${courseView.id}&flag=2&sign=10&type=-1">
                    <span ></span>题目管理
                </a>
            </li>


            <li class="list-group-item <c:if test="${courseView.sign==11 }">active</c:if>">
                <a href="${pageContext.request.contextPath}/testPaper/to_testPaper.action?courseId=${courseView.id}&flag=2&sign=11"><span ></span>试卷管理</a>
            </li>
          
        </ul>
<!-- 
                  <ul class="list-group">
                        <li class="list-group-heading">课程运营</li>
                        <li class="list-group-item <c:if test="${courseView.sign==12 }">active</c:if>">
                            <a href="${pageContext.request.contextPath}/course_data/to_data.action?id=${courseView.id}&flag=2&sign=12">
                                <span></span>课程学习数据</a>
                        </li>

                        <li class="list-group-item ">
                            <a href="javascript:void(0);"><span></span>课程订单查询</a>
                        </li>
                    </ul> -->
        <ul class="list-group">
            <li class="list-group-heading">班级</li>
            <li class="list-group-item <c:if test="${courseView.sign==14 }">active</c:if>">
                <a href="${pageContext.request.contextPath}/class/to_class.action?id=${courseView.id}&flag=2&sign=14&source_id=${courseView.id}&source_type=0&jumpType=-1">
                    <span></span>班级管理
                </a>
            </li>
            <%-- <li class="list-group-item <c:if test="${courseView.sign==15 }">active</c:if>">
                <a href="${pageContext.request.contextPath}/class/to_class_data.action?id=${courseView.id}&flag=2&sign=15&source_id=${courseView.id}&source_type=0">
                    <span></span>课程学习数据
                </a>
            </li> --%>
        </ul>
    </div>
</div>









