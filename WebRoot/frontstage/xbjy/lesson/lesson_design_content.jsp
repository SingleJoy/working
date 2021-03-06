<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>



<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/JMEditor/jmeditor/jquery-1.8.3.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/JMEditor/jmeditor/JMEditor.js"></script>


<script type="text/javascript"
        src="${pageContext.request.contextPath}/frontstage/js/My97DatePicker/WdatePicker.js"></script>
<link href="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.js"></script>


<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<div class="cn-wrap" >


        <div class="row" style="margin-top: 20px;">

            <div class="col-lg-8 col-md-8 col-md-offset-2">

                <div class="panel panel-default panel-col course-data">
                    <div class="panel-heading">${lessonView.name }教学设计与参考<span class="text-warning">(<c:if test="${empty lessonDesign1.true_name }">${lessonDesign1.username }</c:if><c:if test="${!empty lessonDesign1.true_name }">${lessonDesign1.true_name }</c:if>的版本)</span></div>
					<a href="${pageContext.request.contextPath}/lesson_design/to_lesson_design.action?lesson_id=${lessonView.id }&tab=1&stamp=1&state=201" class="btn btn-warning pull-right">返回</a>
                    <br>
                    <div class="panel-body">
                        <h2 class="text-center" style="font-weight: bold;margin:15px 0;">教学设计及参考</h2>
                        <div class="table-responsive">

                            <table class="table table-striped " >
                                <tbody>
                                <tr>
                                    <td class="active">教学课题 / 教材版本</td>
                                    <td >${lessonView.name } / ${lessonView.versionName }</td>
                                </tr>
                                <tr>
                                    <td class="active">学段 / 学科 / 年级</td>
                                    <td >${lessonView.stageName } / ${lessonView.subjectName } / ${lessonView.grade_name }</td>
                                </tr>
                                <tr>
                                    <td class="active">上课老师</td>
                                    <td >${lessonView.username } / ${lessonView.school }</td>
                                </tr>
                                <tr>
                                    <td class="active">教育目标</td>
                                    <td >${lessonDesign1.edu_goal }</td>
                                </tr>
                                <tr>
                                    <td class="active">课例划分</td>
                                    <td >${lessonDesign1.lesson_divide } </td>
                                </tr>
                                <tr>
                                    <td class="active">教材及内容分析</td>
                                    <td >${lessonDesign1.materials_analysis }</td>
                                </tr>
                                <tr>
                                    <td class="active">学生学情分析</td>
                                    <td >${lessonDesign1.student_analysis }</td>
                                </tr>
                                <tr>
                                    <td class="active">教学策略选择与设计</td>
                                    <td >${lessonDesign1.strategy_design }</td>
                                </tr>

                                <tr>
                                    <td class="active">教学重点与难点</td>
                                    <td >${lessonDesign1.focus_difficulty }</td>
                                </tr>

                                <tr>
                                    <td class="active">教学媒体（资源）选择</td>
                                    <td >${lessonDesign1.media_selection }</td>
                                </tr>
                                <tr>
                                    <td class="active">教学过程</td>
                                    <td >${lessonDesign1.teaching_process }</td>
                                </tr>
                                <tr>
                                    <td class="active">板书设计</td>
                                    <td >${lessonDesign1.typography_design }</td>
                                </tr>


                                </tbody>
                            </table>


                        </div>
                    </div>


                </div>
            </div>

           

        </div>



    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
</div>



