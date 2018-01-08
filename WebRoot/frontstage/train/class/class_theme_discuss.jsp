<%@ page language="java" import="java.util.*,cn.bnsr.edu_yun.frontstage.base.po.User" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% User user = (User)request.getSession().getAttribute("currentUser");%>
<style>
    .stage_NO{font-size: 16px;margin-top: 20px;}
    .phase_info{margin-top: 10px;float: left;}
    .phase_info>p{font-size: 14px;float: left;}
    .phase_info>div{margin-left: 80px;font-size: 14px;float: left;}
    .phase_logo{background: url("${pageContext.request.contextPath}/frontstage/images/train_phase.png")  no-repeat;width: 65px;height: 33px;float: left;margin:15px;}
    .course-stage{clear: both;display: none;margin-bottom:20px;}
    .course-stage-abbreviation{clear: both;width: 100%;border: 1px solid #ddd;border-radius: 4px;margin-bottom: 20px;}
    .spread_out{margin-right: 30px;margin-top: 20px;}
</style>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>
<div class="cn-wrap">

    <div id="content-container" class="container">
        <jsp:include page="class_header.jsp"></jsp:include>
        <div class="row">
            <jsp:include page="class_left.jsp"></jsp:include>
            <div class="col-md-9">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        主题讨论
                        <c:if test="${classView.type==2}">
                            <a href="${pageContext.request.contextPath}/class/to_class_theme_discuss.action?required=${required}&id=${classView.id}&flag=2&sign=6&source_id=${classView.source_id}&source_type=${classView.source_type}" class="btn btn-default pull-right">返回</a>
                        </c:if>

                    </div>
                    <div class="panel-body">

                        <p><c:if test="${classView.type==2}">
                            ${courseTitle}
                        </c:if></p>

                        <c:if test="${train_type==null}">
                            <div class="form-group">
                                <div class="col-md-12">
                                    <table class="table table-hovered " style="font-size: 14px;">
                                        <thead>
                                        <tr>
                                            <th width="25%">研讨</th>
                                            <th>章节</th>
                                            <th>讨论数</th>
                                            <th>完成人数</th>
                                            <th>未完成人数</th>
                                        </tr>
                                        </thead>
                                        <tbody class="sel-div">
                                        <c:forEach items="${themeDiscuss}" var="discuss">
                                            <tr>
                                                <td><a href="${pageContext.request.contextPath}/class/to_class_subject_student_discuss.action?required=${required}&id=${classView.id}&class_id=${classView.class_id}&courseId=${classView.courseId}&source_id=${classView.source_id}&source_type=${classView.source_type}&course_hour_id=${discuss.id}">${discuss.name}</a></td>
                                                <td>${discuss.chapter}</td>
                                                <td><c:if test="${empty discuss.discuss_num}">0</c:if>
                                                    <c:if test="${!empty discuss.discuss_num}">${discuss.discuss_num}</c:if></td>
                                                <td><c:if test="${empty discuss.finished_num}">0</c:if>
                                                    <c:if test="${!empty discuss.finished_num}">${discuss.finished_num}</c:if></td>
                                                <td><c:if test="${empty discuss.unfinished_num}">0</c:if>
                                                    <c:if test="${!empty discuss.unfinished_num}">${discuss.unfinished_num}</c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <c:if test="${empty themeDiscuss}">
                                    <div class="empty">这么有趣的课程不可能没有研讨。。。</div>
                                </c:if>
                            </div>
                        </c:if>
                        <!-- 专业培训（罗列课程） -->
                        <c:if test="${classView.source_type==1&&train_type==0}">
                            <div class="nav-btn-tab" style="margin-top: -10px;">
                                <ul class="nav nav-tabs">
                                    <li <c:if test="${required==1 }">class="active"</c:if> value="1"><a href="${pageContext.request.contextPath}/class/to_class_theme_discuss.action?required=1&id=${classView.id}&flag=2&sign=6&source_id=${classView.source_id}&source_type=${classView.source_type}">必修课程</a></li>
                                    <li <c:if test="${required==0 }">class="active"</c:if> value="0"><a href="${pageContext.request.contextPath}/class/to_class_theme_discuss.action?required=0&id=${classView.id}&flag=2&sign=6&source_id=${classView.source_id}&source_type=${classView.source_type}">选修课程</a></li>
                                </ul>
                            </div>
                            <div id="common_train" class="course-stage" >
                                <!--必修课程-->
                                <div class="form-group">
                                    <div class="col-md-12 controls ">
                                        <table class="table table-hovered " style="font-size: 14px;">
                                            <thead>
                                            <tr>
                                                <th style="width: 50%;">课程名称</th>
                                                <th style="width: 30%;text-align: center;">学时</th>
                                                <th style="width: 20%;text-align: center;">学员数</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${trainCourse}" var="course">
                                                <tr >
                                                    <td><a href="${pageContext.request.contextPath}/class/course_discuss.action?required=${required}&id=${classView.id}&class_id=${course.class_id}&flag=2&sign=6&source_id=${course.id}&source_type=${classView.source_type}">${course.title}</a></td>
                                                    <td class="text-center">${course.hours}</td>
                                                    <td class="text-center">${course.studentNum}</td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        <!-- 阶段培训课程 -->
                        <c:if test="${classView.source_type==1&&train_type==1}">
                            <c:forEach items="${trainPhaseList}" var="trainPhase" varStatus="phaseStatus">

                                <div class="course-stage-abbreviation" id="phaseShow${trainPhase.id}" style="min-height: 100px;">

                                    <div class="form-group">
                                        <div  class="phase_logo"></div>
                                        <div style="" class="stage_NO">
                                            第${phaseStatus.index+1}阶段
                                            <a class="pull-right spread_out" href="javascript:void(0);" onclick="doPhaseShow(${trainPhase.id});" >
                                                展开<span class="glyphicon glyphicon-chevron-right"></span></a>
                                        </div>
                                        <div class="phase_info">
                                            <p >学习周期：<span class="text-danger">${trainPhase.cycle}</span>&nbsp;天 </p>
                                            <div>学习要求：<span class="text-danger">${trainPhase.hour_require}</span>&nbsp;学时</div>
                                            <div>包含课程：<span class="text-danger">${trainPhase.totleNum}</span>&nbsp;门</div>
                                        </div>
                                    </div>
                                    <div class="course-stage" id="course-stage${trainPhase.id}" >
                                        <form class="form-horizontal stage-form" >
                                            <br/>
                                            <!--必修课程-->
                                            <div class="form-group">
                                                <div class="col-md-2 control-label">
                                                    <label>必修课程</label>
                                                </div>
                                                <br/>
                                                <br/>
                                                <div class="col-md-10 controls col-md-offset-1">
                                                    <table class="table table-striped" style="font-size: 14px;">
                                                        <thead>
                                                        <tr>
                                                            <th style="width: 50%;">课程名称</th>
                                                            <th style="width: 30%;">学时</th>
                                                            <th style="width: 20%;">学员数</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody id="requiredTbody${trainPhase.id }">

                                                        <c:forEach items="${trainPhase.requiredCourse}" var="course">
                                                            <c:if test="${trainPhase.id==course.phaseId}">
                                                                <tr >
                                                                    <td><a href="${pageContext.request.contextPath}/class/course_discuss.action?required=${required}&id=${classView.id}&class_id=${course.class_id}&flag=2&sign=6&source_id=${course.id}&source_type=${classView.source_type}">${course.title}</a></td>
                                                                    <td>${course.hours}</td>
                                                                    <td>${course.studentNum}</td>
                                                                </tr>
                                                            </c:if>
                                                        </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                            <!--选修课程-->
                                            <div class="form-group">

                                                <div class="col-md-2 control-label">
                                                    <label>选修课程</label>
                                                </div>
                                                <br/>
                                                <br/>

                                                <div class="col-md-10 controls col-md-offset-1">
                                                    <table class="table table-striped " style="font-size: 14px;">
                                                        <thead>
                                                        <tr>
                                                            <th style="width:50%;">课程名称</th>
                                                            <th style="width:30%;">学时</th>
                                                            <th style="width:20%;">学员数</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody id="optionTbody${trainPhase.id }">
                                                        <c:forEach items="${trainPhase.optionCourse}" var="course">
                                                            <c:if test="${trainPhase.id==course.phaseId}">
                                                                <tr>
                                                                    <td><a href="${pageContext.request.contextPath}/class/course_discuss.action?required=${required}&id=${classView.id}&class_id=${course.class_id}&flag=2&sign=6&source_id=${course.id}&source_type=${classView.source_type}">${course.title}</a></td>
                                                                    <td>${course.hours}</td>
                                                                    <td>${course.studentNum}</td>
                                                                </tr>
                                                            </c:if>
                                                        </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>


                            </c:forEach>
                        </c:if>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
</div>

<script type="text/javascript">
    function doSumbit(){
        document.getElementById('class_service').submit();
    }
    $(function(){
        var train_type = "${train_type}";
        if(train_type==0){
            $("#common_train").show();
        }
    });
    //阶段显示与隐藏
    function doPhaseShow(value){
        if($("#course-stage"+value).css("display")=="none"){
            $(".course-stage").slideUp();
            $("#course-stage"+value).slideDown();
            $(".course-stage-abbreviation").find("div").find("div").find(".spread_out").html("展开&nbsp;"+"<span class=\'glyphicon glyphicon-chevron-right\'>"+"</span>")
            $("#phaseShow"+value).find("div").find("div").find(".spread_out").html("收起&nbsp;"+"<span class=\'glyphicon glyphicon-chevron-left\'>"+"</span>")

        }else{
            $(".course-stage").slideUp();
            $("#course-stage"+value).slideUp();
            $(".course-stage-abbreviation").find("div").find("div").find(".spread_out").html("展开&nbsp;"+"<span class=\'glyphicon glyphicon-chevron-right\'>"+"</span>")

        }
    }
</script>


