<%@ page language="java" import="java.util.*,cn.bnsr.edu_yun.frontstage.base.po.User" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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

<link href="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.js"></script>
<div class="cn-wrap">

    <div id="content-container" class="container">
        <jsp:include page="class_header.jsp"></jsp:include>
        <div class="row">
            <jsp:include page="class_left.jsp"></jsp:include>

            <div class="col-md-9">
                <div class="panel panel-default panel-col">

                    <div class="row" style="margin-top: 30px;">
                        <div class="col-md-6">
                            <h4>班级学习情况</h4>
                            <table class="table table-hover text-center" style="text-align: center;font-size: 12px;font-weight: normal;">
                                <thead>
                                <tr >
                                    <th style="text-align: center;"></th>
                                    <th style="text-align: center;">昨日</th>
                                    <th style="text-align: center;">今日</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td>全部学员数</td>
                                    <td>${yesterdayStuNum }</td>
                                    <td>${todayStuNum }</td>
                                </tr>
                                <tr>
                                    <td>课时完成学习数</td>
                                    <td>${yesComCourseHourNum }</td>
                                    <td>${toComCourseHourNum }</td>
                                </tr>
                                <tr>
                                    <td>新增研讨数</td>
                                    <td>${yesclassDiscussNum }</td>
                                    <td>${toclassDiscussNum }</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>

                        <div class="col-md-6 reviews">
                            <h4>最新提问</h4>

                            <c:if test="${empty questionList}"><div class="empty">暂无提问</div></c:if>
                            <c:if test="${!empty questionList}"><div>问题总数${questionTotal}</div></c:if>
                            <c:forEach items="${questionList }" var="question">
                                <div class="media topic-item ">
                                    <div class="media-left">
                                  
                                        <a class="pull-left js-user-card" href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id=${question.user_id}" >
                                            <img class="avatar-sm" src="${pageContext.request.contextPath}${question.user.icon }">
                                        </a>
                                      
                                     </div>
                                    <div class="media-body">
                                        <div class="title">
                                            <i class="es-icon es-icon-chatcircle color-info" title="话题"></i>
                                             <c:if test="${classView.source_type==0}">
                                            <a  href="${pageContext.request.contextPath}/user_study/to_course_study.action?page=1&learnId=${classView.source_id}&sourceType=0&tab=7&questionId=${question.id }&is_direct=0">${question.title}</a>
                                            </c:if>
                                            <c:if test="${classView.source_type==1}">
                                            <a  href="${pageContext.request.contextPath}/train/to_train_detail.action?id=${classView.source_id}&sign=6&questionId=${question.id }">${question.title}</a>
                                            </c:if>
                                            <c:if test="${question.stick==1 }">
                                                <span class="label label-primary" title="置顶帖">置顶</span>
                                            </c:if>
                                            <c:if test="${question.elite==1 }">
                                                <span class="label label-danger" title="精华帖">精华</span>
                                            </c:if>
                                        </div>
                                        <div class="metas text-sm">
                                            <a href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id=${question.user_id}" class="color-gray">${question.user.username }</a>
                                            <span>发起了话题</span>
                                            <c:if test="${!empty question.last_answer_name }">•
                                                <span>最后回复
                                                    <a class="link-dark link-muted" href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id=${question.last_answer_id }">${question.last_answer_name }</a>
                                                </span>
                                                <span><fmt:formatDate value="${question.last_reply_time }" type="date" /> </span>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>

                        </div>
                    </div>
                    <c:if test="${classView.type==0 }">
                    <div class="panel-heading">
                        作业
                    </div>
                    <div class="panel-body ">
                        <table class="table table-hover" style="text-align: center;font-size: 12px;">
                            <thead>
                            <tr>
                                <th width="25%" style="text-align: center;">作业名称</th>
                                <th style="text-align: center;">已批阅</th>
                                <th style="text-align: center;">未批阅</th>
                                <th style="text-align: center;">未提交</th>
                                <th style="text-align: center;">发送提醒</th>
                            </tr>
                            </thead>
                            <tbody class="sel-div">

                            <c:forEach items="${classTaskList }" var="task">
                                <tr>
                                    <td> ${task.name } </td>
                                    <td> <a class="link-dark" href="${pageContext.request.contextPath}/exam/exam.action?class_id=${classView.id}&flag=2&sign=5&exam_type=1&status=2&source_id=${classView.source_id}&source_type=${classView.source_type}">${task.read_num } </a></td>
                                    <td> <a class="link-dark" href="${pageContext.request.contextPath}/exam/exam.action?class_id=${classView.id}&flag=2&sign=5&exam_type=1&status=1&source_id=${classView.source_id}&source_type=${classView.source_type}">${task.unread_num }</a> </td>
                                    <td> ${task.unsubmit_num } </td>
                                    <td><a  href="javascript:;" onclick="send(${task.course_hour_id},4,'${task.name }')"> 发送</a> </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <c:if test="${empty classTaskList}"><div class="empty">暂无作业</div></c:if>
                    </div>
                    <div class="panel-heading">
                        考试
                    </div>
                    <div class="panel-body ">
                        <table class="table  table-hover" style="text-align: center;font-size: 12px;">
                            <thead>
                            <tr>
                                <th width="25%" style="text-align: center;">考试名称</th>
                                <th style="text-align: center;">已批阅</th>
                                <th style="text-align: center;">未批阅</th>
                                <th style="text-align: center;">未提交</th>
                                <th style="text-align: center;">发送提醒</th>
                            </tr>
                            </thead>
                            <tbody class="sel-div">

                            <c:forEach items="${classTestList }" var="test">
                                <tr>
                                    <td> ${test.name } </td>
                                    <td> <a class="link-dark" href="${pageContext.request.contextPath}/exam/exam.action?class_id=${classView.id}&flag=2&sign=4&exam_type=0&status=2&source_id=${classView.source_id}&source_type=${classView.source_type}"> ${test.read_num }</a> </td>
                                    <td> <a class="link-dark" href="${pageContext.request.contextPath}/exam/exam.action?class_id=${classView.id}&flag=2&sign=4&exam_type=0&status=1&source_id=${classView.source_id}&source_type=${classView.source_type}"> ${test.unread_num }</a> </td>
                                    <td> ${test.unsubmit_num } </td>
                                    <td> <a  href="javascript:;"  onclick="send(${test.course_hour_id},0,'${test.name }')">发送</a> </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <c:if test="${empty classTestList}"><div class="empty">暂无考试</div></c:if>
                    </div>
                    <div class="panel-heading">
                        主题讨论
                    </div>
                    <div class="panel-body ">
                        <table class="table table-hover" style="text-align: center;font-size: 12px;">
                            <thead>
                            <tr>
                                <th width="25%" style="text-align: center;">讨论名称</th>
                                <th style="text-align: center;">已完成</th>
                                <th style="text-align: center;">未完成</th>
                                <th style="text-align: center;">发送提醒</th>
                            </tr>
                            </thead>
                            <tbody class="sel-div">

                            <c:forEach items="${classTopicList }" var="topic">
                                <tr>
                                    <td> ${topic.name } </td>
                                    <td> ${topic.read_num }</td>
                                    <td> ${topic.unread_num+topic.unsubmit_num }</td>
                                    <td> <a  href="javascript:;" onclick="send(${topic.course_hour_id},3,'${topic.name }')">发送</a> </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <c:if test="${empty classTopicList}"><div class="empty">暂无讨论</div></c:if>
                    </div>
                    </c:if>
                     <c:if test="${classView.type==1 }">
                     <!-- 基础培训 -->
                     <c:if test="${classView.trainType==0 }">
                     
                      <div class="panel-heading">
                        必修课程
                    </div>
                    <div class="panel-body ">
                        <table class="table table-hover" style="text-align: center;font-size: 12px;">
                            <thead>
                            <tr>
                                <th width="25%" style="text-align: center;">课程名称</th>
                                <th style="text-align: center;">已完成</th>
                                <th style="text-align: center;">未完成</th>
                                <th style="text-align: center;">发送提醒</th>
                            </tr>
                            </thead>
                            <tbody class="sel-div">

                            <c:forEach items="${trainCourseView1 }" var="view">
                                <tr>
                                    <td> ${view.title } </td>
                                    <td> ${view.do_count}</td>
                                    <td> ${view.not_do_count }</td>
                                    <td> <a  href="javascript:;" onclick="send(${view.course_id},5,'${view.title }',${view.source_id})">发送</a> </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        
                    </div>
                    <div class="panel-heading">
                       选修课程
                    </div>
                    <div class="panel-body ">
                        <table class="table table-hover" style="text-align: center;font-size: 12px;">
                            <thead>
                            <tr>
                                <th width="25%" style="text-align: center;">课程名称</th>
                                <th style="text-align: center;">已完成</th>
                                <th style="text-align: center;">未完成</th>
                                <th style="text-align: center;">发送提醒</th>
                            </tr>
                            </thead>
                            <tbody class="sel-div">

                            <c:forEach items="${trainCourseView2 }" var="view">
                                <tr>
                                    <td> ${view.title } </td>
                                    <td> ${view.do_count}</td>
                                    <td> ${view.not_do_count }</td>
                                    <td> <a  href="javascript:;" onclick="send(${view.course_id},5,'${view.title }',${view.source_id})">发送</a> </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        
                    </div>  
                     
                     </c:if>
                      <!-- 专业培训 -->
                      <c:if test="${classView.trainType==1 }">
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
                                                    <table class="table table-striped " style="font-size: 14px;">
                                                        <thead>
                                                        <tr>
                                                            <th style="width: 35%;">课程名称</th>
                                                            <th style="width: 10%;">学时</th>
                                                            <th style="width: 10%;">学员数</th>
                                                            <th style="width: 15%;">未学完人数</th>
                                                            <th style="width: 15%;">已学完人数</th>
                                                            <th style="width: 15%;">发送提醒</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody id="requiredTbody${trainPhase.id }">

                                                        <c:forEach items="${trainPhase.requiredCourse}" var="course">
                                                            <c:if test="${trainPhase.id==course.phaseId}">
                                                                <tr >
                                                                    <td><a href="javascript:void(0);">${course.title}</a></td>
                                                                    <td>${course.hours}</td>
                                                                    <td>${course.studentNum}</td>
                                                                    <td>${course.unfinishedNum}</td>
                                                                    <td>${course.finishedNum}</td>
                                                                    <td><a  href="javascript:;" onclick="send(${course.id},5,'${course.title }',${course.phaseId})"> 发送</a></td>
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
                                                    <table class="table table-striped" style="font-size: 14px;">
                                                        <thead>
                                                        <tr>
                                                            <th style="width:35%;">课程名称</th>
                                                            <th style="width:10%;">学时</th>
                                                            <th style="width:10%;">学员数</th>
                                                            <th style="width:15%;">未学完人数</th>
                                                            <th style="width:15%;">已学完人数</th>
                                                            <th style="width:15%;">发送提醒</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody id="optionTbody${trainPhase.id }">
                                                        <c:forEach items="${trainPhase.optionCourse}" var="course">
                                                            <c:if test="${trainPhase.id==course.phaseId}">
                                                                <tr>
                                                                    <td><a href="javascript:void(0);">${course.title}</a></td>
                                                                    <td>${course.hours}</td>
                                                                    <td>${course.studentNum}</td>
                                                                    <td>${course.unfinishedNum}</td>
                                                                    <td>${course.finishedNum}</td>
                                                                    <td><a  href="javascript:;" onclick="send(${course.id},5,'${course.title }',${course.phaseId})"> 发送</a></td>
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
                     </c:if>
                </div>
            </div>
        </div>
    </div>
    <div id="modal" class="modal in" style="display: none;"  role="dialog"  aria-hidden="true">
        <div class="modal-dialog  modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
                    </button>
                    <h4 class="modal-title">用户列表</h4>
                </div>
                <div class="modal-body" >

                    <table class="table table-hover">
                        <caption>
                        <span class="text-danger">"您好，您正在学习的<c:if test="${classView.type==0 }">课程</c:if>
                       <c:if test="${classView.type==1 }">培训</c:if>《${classView.sourceName}》中，《
                            <span id="modal_name"></span>》未完成，请尽快按要求完成"
                        </span>
                        </caption>
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>姓名</th>
                        </tr>
                        </thead>
                        <tbody class="userList">


                        </tbody>
                    </table>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-course_hour_id="" id="modalSubmit" data-course_id="" >确定</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        var users;
        $(function(){

            $("#modalSubmit").click(function(){
                var course_hour_id=$("#modalSubmit").data("course_hour_id");
                var course_id=$("#modalSubmit").data("course_id");
                var source_id=$("#modalSubmit").data("train_id");
                var user_ids="";
                for(var i=0;i<users.length;i++){

                    user_ids+=users[i].id;
                    user_ids+=",";
                }
                $.ajax({
                    url : '${pageContext.request.contextPath}/notice/unfinish_notice.action',
                    dataType : 'json',
                    data:{
                        user_ids:user_ids,
                        course_hour_id:course_hour_id,
                        course_id:course_id,
                        source_id:source_id,
                    },
                    success : function(response) {
                        alert("发送成功");
                        $("#modal").modal('hide');

                    }
                });
            });

        });
        function send(id,attribute_type,name,source_id){
            var class_id='${classView.id}';
            $.ajax({
                url : '${pageContext.request.contextPath}/class/get_unfinish.action',
                dataType : 'json',
                data:{
                    id:id,
                    attribute_type:attribute_type,
                    class_id:class_id,
                    source_id:source_id,
                },
                success : function(response) {
                    $(".userList").html("");
                    users=response.users;

                    for(var i=0;i<users.length;i++){
                        var str="<tr><td>"+users[i].id+"</td><td>"+users[i].username+"</td></tr>";
                        $(".userList").append(str);
                    }
                    if(attribute_type!=5)
                     $("#modalSubmit").attr("data-course_hour_id",id);
                     if(attribute_type==5){
                    $("#modalSubmit").attr("data-course_id",id);
                    $("#modalSubmit").attr("data-train_id",source_id);
                    }
                    var str1="";
                    if(attribute_type==0){
                        str1="考试:";
                    }
                    if(attribute_type==3){
                        str1="研讨:";
                    }
                    if(attribute_type==4){
                        str1="作业:";
                    }
                     if(attribute_type==5){
                     str1="课程:";
                     }
                    $("#modal_name").html(str1+name);
                    $("#modal").modal('show');
                }
            });


        }

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
                $(".course-stage-abbreviation").find("div").find("div").find(".spread_out").html("展开&nbsp;"+"<span class=\'glyphicon glyphicon-chevron-right\'>"+"</span>");

            }
        }

    </script>
    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
</div>






