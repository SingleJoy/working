<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<style>
    .nav-pills>li>a{padding: 6px 10px;}
</style>


<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<div class="cn-wrap" >

    <div id="content-container" class="container">

        <jsp:include page="/frontstage/xbjy/lesson/lesson_header.jsp"></jsp:include>

        <div class="course-detail row" style="margin-top: 20px;">

            <jsp:include page="/frontstage/xbjy/lesson/lesson_left.jsp"></jsp:include>

            <div class="col-lg-9 col-md-8  course-detail-main">

                <div class="panel panel-default">
                    <div class="panel-heading">修改/制定计划</div>
                    <div class="panel-body">
                        <form id="saveLessonPlan" action="${pageContext.request.contextPath}/lesson/save_lesson_plan.action" method="post" class="form-horizontal">
                            <input id="lesson_id" name="lesson_id" value="${lesson.id}" type="hidden">
                            <input type="hidden" name="period" id="period" value="${lesson.period}">
                            <input type="hidden" name="credit" id="credit" value="${lesson.credit}">
                            <input id="user_id" name="user_id" value="${lesson.user_id}" type="hidden">

                            <div id="lessonPicture" style="position: absolute;margin-left: 660px;">
                                <div id="fileList" class="">
                                	<img id="defaultImg" class="img-responsive" 
                                	<c:if test="${empty lesson.lesson_pic}">src="${pageContext.request.contextPath}/frontstage/images/course.png"</c:if>
                                	<c:if test="${!empty lesson.lesson_pic}">src="${pageContext.request.contextPath}/${lesson.lesson_pic}"</c:if>
                                	style="width: 120px;height: 90px;">
                                </div>

                                <div class="" id="upload_course_picture_content" style="margin-top: 10px;margin-left: 10px;">
                                    <div class="">
                                        <a class="btn btn-primary" id="file">选择上传图片</a>
                                    </div>
                                </div>
                            </div>

                            <input type="hidden" value="${lesson.lesson_pic}" name="lesson_pic" id="lesson_pic" class="hidden">

                            <div class="form-group">
                                <div class="col-md-2 control-label"><label><span class="text-danger">*</span>课例名称</label></div>
                                <div class="col-md-7 controls">
                                    <input type="text" id="lesson_name" name="name"  value="${lesson.name }" class="form-control" placeholder="不超过30个字">

                                    <div class="text-warning" id="lesson_name_msg" style="display: none;">请输入课例名称</div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-md-2 control-label"> <label><span class="text-danger">*</span>学段</label></div>
                                <div class="col-md-2 controls">
                                    <select id="stage" class="form-control width-input width-input-large" name="stage_id" onclick="delStage(this.value)" onchange="_stage(this.value);">
                                        <option id="nullStage"
                                                 value="-1">--请选择！--</option>
                                        <option value="XX" <c:if test="${lesson.stage_id=='XX' }">selected="selected"</c:if>
                                                >小学</option>
                                        <option value="CZ" <c:if test="${lesson.stage_id=='CZ' }">selected="selected"</c:if>
                                                >初中</option>
                                        <option value="GZ" <c:if test="${lesson.stage_id=='GZ' }">selected="selected"</c:if>
                                               >高中</option>
                                    </select>
                                    <div class="text-warning" id="stage_msg" style="display: none;">请选择学段</div>
                                </div>

                                <div class="col-md-2 control-label"> <label><span class="text-danger">*</span>学科</label></div>
                                <div class="col-md-2 controls">
                                    <select id="subject" onchange="_subject(this.value);"  class="form-control width-input width-input-large" name="subject_id">
                                        <c:if test="${empty subjectList}">
                                            <option  value="-1">--请选择！--</option>
                                        </c:if>
                                        <c:forEach items="${subjectList}" var="sub">
                                            <c:if test="${lesson.subject_id == sub.id}">
                                                <option selected="selected" value="${sub.id}">${sub.subjectName}</option>
                                            </c:if>
                                            <c:if test="${lesson.subject_id != sub.id}">
                                                <option value="${sub.id}">${sub.subjectName}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                    <div class="text-warning" id="subject_msg" style="display: none;">请选择学科</div>

                                </div>
                            </div>

                            <div class="form-group form-line">
                                <div class="col-md-2 control-label"> <label><span class="text-danger">*</span>年级</label></div>
                                <div class="col-md-2 controls">
                                    <select id="grade" class="form-control width-input width-input-large" name="grade_id">
                                        <c:if test="${empty lesson.grade_id}">
                                            <option id="nullGrade" value="-1">--请选择！--</option>
                                        </c:if>
                                        
                                            <c:if test="${lesson.stage_id=='XX' }">
                                            	<option value="1" <c:if test="${lesson.grade_id == 1 }">selected="selected"</c:if>
                                                >一年级</option>
                                                <option value="2" <c:if test="${lesson.grade_id == 2 }">selected="selected"</c:if>
                                                >二年级</option>
                                                <option value="3" <c:if test="${lesson.grade_id == 3 }">selected="selected"</c:if>
                                                >三年级</option>
                                                <option value="4" <c:if test="${lesson.grade_id == 4 }">selected="selected"</c:if>
                                                >四年级</option>
                                                <option value="5" <c:if test="${lesson.grade_id == 5 }">selected="selected"</c:if>
                                                >五年级</option>
                                                <option value="6" <c:if test="${lesson.grade_id == 6 }">selected="selected"</c:if>
                                                >六年级</option>
                                            </c:if>
                                            <c:if test="${lesson.stage_id=='CZ' }">
                                            	<option value="7" <c:if test="${lesson.grade_id == 7 }">selected="selected"</c:if>
                                                >初一</option>
                                                <option value="8" <c:if test="${lesson.grade_id == 8 }">selected="selected"</c:if>
                                                >初二</option>
                                                <option value="9" <c:if test="${lesson.grade_id == 9 }">selected="selected"</c:if>
                                                >初三</option>
                                            </c:if>
                                            <c:if test="${lesson.stage_id=='GZ' }">
                                            	<option value="10" <c:if test="${lesson.grade_id == 10 }">selected="selected"</c:if>
                                                >高一</option>
                                                <option value="11" <c:if test="${lesson.grade_id == 11 }">selected="selected"</c:if>
                                                >高二</option>
                                                <option value="12" <c:if test="${lesson.grade_id == 12 }">selected="selected"</c:if>
                                                >高三</option>
                                            </c:if>
                                            <!-- 
                                            <c:forEach items="${gradeList}" var="gra">
                                            <c:if test="${lesson.grade_id == gra.id}">
                                                <option selected="selected" value="${gra.id}">${gra.grade_name}</option>
                                            </c:if>
                                            <c:if test="${lesson.grade_id != gra.id}">
                                                <option value="${gra.id}">${gra.grade_name}</option>
                                            </c:if>
                                             </c:forEach>
                                             -->
                                    </select>

                                    <%--<div class="text-warning" id="grade_msg" style="display: none;">请选择年级</div>--%>
                                </div>
                                <div class="col-md-2 control-label"> <label><span class="text-danger">*</span>版本</label></div>
                                <div class="col-md-2 controls">
                                    <select id="edition" class="form-control width-input width-input-large" name="press_id">
                                        <c:if test="${empty editionList}">
                                            <option value="-1">--请选择！--</option>
                                        </c:if>
                                        <c:forEach items="${editionList}" var="edi">
                                            <c:if test="${lesson.press_id == edi.id}">
                                                <option selected="selected" value="${edi.id}">${edi.versionName}</option>
                                            </c:if>
                                            <c:if test="${lesson.press_id != edi.id}">
                                                <option value="${edi.id}">${edi.versionName}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>

                                    <div class="text-warning" id="edition_msg" style="display: none;">版本</div>
                                </div>
                            </div>
                            
                            <div class="form-group" >
                                <label class="col-md-2 control-label"><span class="text-danger">*</span>研究目标</label>
                                <div class="col-md-8 controls">
                                    <textarea id="research"  name="research" class="form-control" placeholder="（本课题研究对象对教师教学行为改进的预期结果）">${lesson.research}</textarea>
                                    <div class="help-block" id="research_msg" style="display:none;">请填写研究目标</div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label">关键词</label>
                                <div class="col-md-8 controls">
                                    <input type="text" id="research_key" name="research_key" value="${lesson.research_key}" class="form-control">
                                    <div class="help-block" id="research_key_msg" style="display:none;">请填写关键词</div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-2 control-label"><span class="text-danger">*</span>研究问题</label>
                                <div class="col-md-8 controls">
                                    <input type="text" id="plan_que" name="plan_que"  value="${lessonProblemView.plan_que}" class="form-control" placeholder="计划环节问题研讨">
                                    <div class="text-warning" id="plan_que_msg" style="display: none;">请填写计划节问题</div>
                                </div>
                            </div>

                            <div class="form-group" style="margin-top: -20px;">
                                <label class="col-md-2 control-label"></label>
                                <div class="col-md-8 controls">
                                    <input type="text" id="prepare_que" name="prepare_que" value="${lessonProblemView.prepare_que}" class="form-control"  placeholder="备课环节问题研讨">
                                    <div class="text-warning" id="prepare_que_msg" style="display: none;">请填写备课环节问题</div>
                                </div>
                            </div>

                            <div class="form-group" style="margin-top: -20px;">
                                <label class="col-md-2 control-label"></label>
                                <div class="col-md-8 controls">
                                    <input type="text" id="class_que" name="class_que" class="form-control" value="${lessonProblemView.class_que}"  placeholder="上课环节问题研讨">
                                    <div class="text-warning" id="class_que_msg" style="display: none;">请填写上课环节问题</div>
                                </div>
                            </div>

                            <div class="form-group" style="margin-top: -20px;">
                                <label class="col-md-2 control-label"></label>
                                <div class="col-md-8 controls">
                                    <input type="text" id="assessment_que" name="assessment_que" class="form-control" value="${lessonProblemView.assessment_que}"  placeholder="评课环节问题研讨">
                                    <div class="text-warning" id="assessment_que_msg" style="display: none;">请填写评课环节问题</div>
                                </div>
                            </div>


                            <div class="form-group" >
                                <label class="col-md-2 control-label"><span class="text-danger">*</span>研究措施</label>
                                <div class="col-md-8 controls">
                                    <textarea id="measures" name="measures" class="form-control" placeholder="（为解决教学行为问题和实现课例研究目标，研修组拟采取的研究措施与主要活动）">${lesson.measures}</textarea>
                                    <div class="text-warning" id="measures_msg" style="display: none;">请填写研究措施</div>

                                </div>
                            </div>

                            <div class="form-group" >
                                <div class="col-md-2 control-label">
                                    <label><span class="text-danger">*</span>上课老师</label>
                                </div>
                                <div class="col-md-4 controls">
                                    <ul class="nav nav-pills tutor_list0">
                                        <c:if test="${!empty lesson.user_sk_name}">
                                            <li class="active" id="0teacher${lesson.user_sk }">
                                                <a href="javascript:return false;">${lesson.user_sk_name }&nbsp;&nbsp;
                                                    <input name="user_id0" value="${lesson.user_sk }" type="hidden" data-name="save0">
                                                </a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </div>
                                <div class="col-md-4 controls col-md-offset-2">
                                    <c:if test="${empty lesson.user_sk_name}">
                                        <a href="javascript:void(0);" id="skteacher" class="btn btn-info" data-toggle="modal" data-target="#add-teachers" onclick="showTeacher(0);" >
                                            <span class="glyphicon glyphicon-plus"></span>添加
                                        </a>
                                    </c:if>
                                </div>
                            </div>

                            <!--计划环节   -->
                            <div class="form-group clearfix" style="margin-top:20px;">
                                <div class="col-md-2 control-label">
                                    <label>计划环节</label>
                                </div>
                                <div class="col-md-2 control-label col-md-offset-2">
                                    <div><span class="text-danger">*</span>开始时间</div>
                                </div>
                                <div class="col-md-2 controls">
                                    <input id="plan_sta" name="plan_sta"  type="text" value="<fmt:formatDate value="${lessonTimeView.plan_sta}" type="date"/>" class="form-control"  onClick="WdatePicker()">
                                    <div id="plan_sta_msg" class="help-block"></div>
                                </div>
                                <div class="col-md-2 control-label" style="margin-left:-70px;">
                                   <div><span class="text-danger">*</span>结束时间</div>
                                </div>
                                <div class="col-md-2 controls">
                                    <input id="plan_end" name="plan_end" type="text" value="<fmt:formatDate value="${lessonTimeView.plan_end}" type="date"/>" class="form-control" onClick="WdatePicker()" >
                                    <div id="plan_end_msg" class="help-block"></div>
                                </div>
                            </div>
                            <div class="form-group" style="margin-top: -30px;">
                                <div class="col-md-10 controls col-md-offset-1">
                                    <table class="table table-striped all-statistics">
                                        <tbody>
                                        <tr>
                                            <td class="active"><span class="text-danger">*</span>1.制定计划</td>
                                            <td style="width:65%">
                                                <ul class="nav nav-pills  tutor_list101">
                                                    <c:forEach items="${lessonUserTaskList }" var="lessonUser">
                                                        <c:if test="${lessonUser.purview ==101}">
                                                            <li class="active" id="101teacher${lessonUser.id }" style="display: inline-block;">
                                                                <a href="javascript:return false;"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>&nbsp;&nbsp;
                                                                    <input name="user_id101" value="${lessonUser.user_id }" type="hidden" data-name="save101">
                                                                    <input name="mark" value="101" type="hidden" data-name="mark">
                                                                </a>
                                                            </li>
                                                        </c:if>
                                                    </c:forEach>
                                                </ul>

                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="active"><span class="text-danger">*</span>2.提交教学设计及课件</td>
                                            <td style="width:65%">
                                                <ul class="nav nav-pills  tutor_list102">
                                                    <c:forEach items="${lessonUserTaskList }" var="lessonUser">
                                                        <c:if test="${lessonUser.purview ==102}">
                                                            <li class="active" id="102teacher${lessonUser.id }" style="display: inline-block;">
                                                                <a href="javascript:return false;"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>&nbsp;&nbsp;
                                                                    <input name="user_id102" value="${lessonUser.user_id }" type="hidden" data-name="save102">
                                                                    <input name="mark" value="102" type="hidden" data-name="mark">
                                                                </a>
                                                            </li>
                                                        </c:if>
                                                    </c:forEach>
                                                </ul>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="active">3.问题研讨</td>
                                            <td style="width:65%">
                                                <a href="javascript:void(0)" class="pull-right" data-toggle="modal" data-target="#add-teachers" onclick="showTeacher(103);">
                                                    <span class="text-warning pull-right">分配任务&nbsp;&gt;</span>
                                                </a>

                                                <ul class="nav nav-pills  tutor_list103">
                                                    <c:forEach items="${lessonUserTaskList }" var="lessonUser">
                                                        <c:if test="${lessonUser.purview ==103}">
                                                            <li class="active" id="103teacher${lessonUser.id }" >
                                                                <a href="javascript:return false;"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>&nbsp;&nbsp;
                                                                    <input name="user_id103" value="${lessonUser.user_id }" type="hidden" data-name="save103">
                                                                    <input name="mark" value="103" type="hidden" data-name="mark">
                                                                    <span class="tutor_del" onclick="delTeacherAC(${lessonUser.id },103);">X</span>
                                                                </a>
                                                            </li>
                                                        </c:if>
                                                    </c:forEach>
                                                </ul>
                                            </td>
                                        </tr>

                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <!--备课环节   -->
                            <div class="form-group clearfix" >
                                <div class="col-md-2 control-label">
                                    <label>备课环节</label>
                                </div>
                                <div class="col-md-2 control-label col-md-offset-2">
                                    <div><span class="text-danger">*</span>开始时间</div>
                                </div>
                                <div class="col-md-2 controls">
                                    <input id="prepare_sta" name="prepare_sta" type="text" value="<fmt:formatDate value="${lessonTimeView.prepare_sta}" type="date"/>" class="form-control"  onClick="WdatePicker()">
                                    <div id="prepare_sta_msg" class="help-block"></div>
                                </div>
                                <div class="col-md-2 control-label" style="margin-left: -70px;">
                                   <div><span class="text-danger">*</span>结束时间</div>
                                </div>
                                <div class="col-md-2 controls">
                                    <input id="prepare_end" name="prepare_end" type="text" value="<fmt:formatDate value="${lessonTimeView.prepare_end}" type="date"/>" class="form-control"  onClick="WdatePicker()">
                                    <div id="prepare_end_msg" class="help-block"></div>
                                </div>
                            </div>
                            <div class="form-group" style="margin-top: -30px;">
                                <div class="col-md-10 controls col-md-offset-1">
                                    <table class="table table-striped all-statistics" >
                                        <tbody>
                                        <tr>
                                            <td class="active">
                                                <span class="text-danger">*</span>1.初始教学设计协同修改</td>
                                            <td style="width:65%">
                                                <a href="javascript:void(0)" class="pull-right" data-toggle="modal" data-target="#add-teachers" onclick="showTeacher(201);">
                                                    <span class="text-warning pull-right">分配任务&nbsp;&gt;</span>
                                                </a>
                                                <ul class="nav nav-pills  tutor_list201">
                                                    <c:forEach items="${lessonUserTaskList }" var="lessonUser">
                                                        <c:if test="${lessonUser.purview ==201}">
                                                            <li class="active" id="201teacher${lessonUser.id }">
                                                                <a href="javascript:return false;"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>&nbsp;&nbsp;
                                                                    <input name="user_id201" value="${lessonUser.user_id }" type="hidden" data-name="save201">
                                                                    <input name="mark" value="201" type="hidden" data-name="mark">
                                                                    <span class="tutor_del" onclick="delTeacherAC(${lessonUser.id },201);">X</span>
                                                                </a>
                                                            </li>
                                                        </c:if>
                                                    </c:forEach>
                                                </ul>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="active">2.备课研讨会会议纪要</td>
                                            <td style="width:65%">
                                                <a href="javascript:void(0)" class="pull-right" data-toggle="modal" data-target="#add-teachers" onclick="showTeacher(202);">
                                                    <span class="text-warning pull-right">分配任务&nbsp;&gt;</span>
                                                </a>
                                                <ul class="nav nav-pills  tutor_list202">
                                                    <c:forEach items="${lessonUserTaskList }" var="lessonUser">
                                                        <c:if test="${lessonUser.purview ==202}">
                                                            <li class="active" id="202teacher${lessonUser.id }">
                                                                <a href="javascript:return false;"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>&nbsp;&nbsp;
                                                                    <input name="user_id202" value="${lessonUser.user_id }" type="hidden" data-name="save202">
                                                                    <input name="mark" value="202" type="hidden" data-name="mark">
                                                                    <span class="tutor_del" onclick="delTeacherAC(${lessonUser.id },202);">X</span>
                                                                </a>
                                                            </li>
                                                        </c:if>
                                                    </c:forEach>
                                                </ul>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="active">3.问题研讨</td>
                                            <td style="width:65%">
                                                <a href="javascript:void(0)" class="pull-right" data-toggle="modal" data-target="#add-teachers" onclick="showTeacher(203);">
                                                    <span class="text-warning pull-right">分配任务&nbsp;&gt;</span>
                                                </a>
                                                <ul class="nav nav-pills tutor_list203">
                                                    <c:forEach items="${lessonUserTaskList }" var="lessonUser">
                                                        <c:if test="${lessonUser.purview ==203}">
                                                            <li class="active" id="203teacher${lessonUser.id }">
                                                                <a href="javascript:return false;"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>&nbsp;&nbsp;
                                                                    <input name="user_id203" value="${lessonUser.user_id }" type="hidden" data-name="save203">
                                                                    <input name="mark" value="203" type="hidden" data-name="mark">
                                                                    <span class="tutor_del" onclick="delTeacherAC(${lessonUser.id },203);">X</span>
                                                                </a>
                                                            </li>
                                                        </c:if>
                                                    </c:forEach>
                                                </ul>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="active"><span class="text-danger">*</span>4.提交修改后的教学设计</td>
                                            <td style="width:65%">
                                                <ul class="nav nav-pills tutor_list204">
                                                    <c:forEach items="${lessonUserTaskList }" var="lessonUser">

                                                        <c:if test="${lessonUser.purview ==204}">
                                                            <li class="active" id="204teacher${lessonUser.id }">
                                                                <a href="javascript:return false;"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>&nbsp;&nbsp;
                                                                    <input name="user_id204" value="${lessonUser.user_id }" type="hidden" data-name="save204">
                                                                    <input name="mark" value="204" type="hidden" data-name="mark">
                                                                </a>
                                                            </li>
                                                        </c:if>
                                                    </c:forEach>
                                                </ul>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <!--上课环节   -->
                            <div class="form-group clearfix" >
                                <div class="col-md-2 control-label">
                                    <label>上课环节</label>
                                </div>
                                <div class="col-md-2 control-label col-md-offset-1">
                                    <div><span class="text-danger">*</span>开始时间</div>
                                </div>
                                <div class="col-md-2 controls">
                                    <input id="class_sta" name="class_sta" type="text" value="<fmt:formatDate value="${lessonTimeView.class_sta}" type="date"/>" class="form-control" onClick="WdatePicker()" >
                                    <div id="class_sta_msg" class="help-block"></div>
                                </div>
                                <div class="col-md-2 control-label">
                                   <div><span class="text-danger">*</span>结束时间</div>
                                </div>
                                <div class="col-md-2 controls">
                                    <input id="class_end" name="class_end" type="text" value="<fmt:formatDate value="${lessonTimeView.class_end}" type="date"/>" class="form-control" onClick="WdatePicker()" >
                                    <div id="class_end_msg" class="help-block"></div>
                                </div>
                            </div>

                            <div class="form-group" style="margin-top: -30px;">
                                <div class="col-md-10 controls col-md-offset-1">
                                    <table class="table table-striped all-statistics" >
                                        <tbody>
                                        <tr>
                                            <td class="active">1.观课准备会会议纪要</td>
                                            <td style="width:65%">
                                                <a href="javascript:void(0)" class="pull-right" data-toggle="modal" data-target="#add-teachers" onclick="showTeacher(301);">
                                                    <span class="text-warning pull-right">分配任务&nbsp;&gt;</span>
                                                </a>
                                                <ul class="nav nav-pills tutor_list301">
                                                    <c:forEach items="${lessonUserTaskList }" var="lessonUser">

                                                        <c:if test="${lessonUser.purview ==301}">
                                                            <li class="active" id="301teacher${lessonUser.id }">
                                                                <a href="javascript:return false;"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>&nbsp;&nbsp;
                                                                    <input name="user_id301" value="${lessonUser.user_id }" type="hidden" data-name="save301">
                                                                    <input name="mark" value="301" type="hidden" data-name="mark">
                                                                    <span class="tutor_del" onclick="delTeacherAC(${lessonUser.id },301);">X</span>
                                                                </a>
                                                            </li>
                                                        </c:if>
                                                    </c:forEach>
                                                </ul>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="active"><span class="text-danger">*</span>2.观课量表</td>
                                            <td style="width:65%">
                                                <a href="javascript:void(0)" class="pull-right" data-toggle="modal" data-target="#add-teachers" onclick="showTeacher(302);">
                                                    <span class="text-warning pull-right">分配任务&nbsp;&gt;</span>
                                                </a>
                                                <ul class="nav nav-pills tutor_list302">
                                                    <c:forEach items="${lessonUserTaskList }" var="lessonUser">
                                                        <c:if test="${lessonUser.purview ==302}">
                                                            <li class="active" id="302teacher${lessonUser.id }">
                                                                <a href="javascript:return false;"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>&nbsp;&nbsp;
                                                                    <input name="user_id302" value="${lessonUser.user_id }" type="hidden" data-name="save302">
                                                                    <input name="mark" value="302" type="hidden" data-name="mark">
                                                                    <span class="tutor_del" onclick="delTeacherAC(${lessonUser.id },302);">X</span>
                                                                </a>
                                                            </li>
                                                        </c:if>
                                                    </c:forEach>
                                                </ul>

                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="active">3.问题研讨</td>
                                            <td style="width:65%">
                                                <a href="javascript:void(0)" class="pull-right" data-toggle="modal" data-target="#add-teachers" onclick="showTeacher(303);">
                                                    <span class="text-warning pull-right">分配任务&nbsp;&gt;</span>
                                                </a>
                                                <ul class="nav nav-pills  tutor_list303">
                                                    <c:forEach items="${lessonUserTaskList }" var="lessonUser">
                                                        <c:if test="${lessonUser.purview ==303}">
                                                            <li class="active" id="303teacher${lessonUser.id }">
                                                                <a href="javascript:return false;"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>&nbsp;&nbsp;
                                                                    <input name="user_id303" value="${lessonUser.user_id }" type="hidden" data-name="save303">
                                                                    <input name="mark" value="303" type="hidden" data-name="mark">
                                                                    <span class="tutor_del" onclick="delTeacherAC(${lessonUser.id },303);">X</span>
                                                                </a>
                                                            </li>
                                                        </c:if>
                                                    </c:forEach>
                                                </ul>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="active"><span class="text-danger">*</span>4.提交上课实录</td>
                                            <td style="width:65%;">

                                                <ul class="nav nav-pills  tutor_list304">
                                                    <c:forEach items="${lessonUserTaskList }" var="lessonUser">
                                                        <c:if test="${lessonUser.purview ==304}">
                                                            <li class="active" id="304teacher${lessonUser.id }">
                                                                <a href="javascript:return false;"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>&nbsp;&nbsp;
                                                                    <input name="user_id304" value="${lessonUser.user_id }" type="hidden" data-name="save304">
                                                                    <input name="mark" value="304" type="hidden" data-name="mark">
                                                                </a>
                                                            </li>
                                                        </c:if>
                                                    </c:forEach>
                                                </ul>

                                            </td>
                                        </tr>

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <!--评课环节   -->
                            <div class="form-group clearfix" >
                                <div class="col-md-2 control-label">
                                    <label>评课环节</label>
                                </div>
                                <div class="col-md-2 control-label col-md-offset-1">
                                    <div><span class="text-danger">*</span>开始时间</div>
                                </div>
                                <div class="col-md-2 controls">
                                    <input id="assessment_sta" name="assessment_sta" type="text" value="<fmt:formatDate value="${lessonTimeView.assessment_sta}" type="date"/>" class="form-control"  onClick="WdatePicker()">
                                    <div id="assessment_sta_msg" class="help-block"></div>
                                </div>
                                <div class="col-md-2 control-label">
                                   <div><span class="text-danger">*</span>结束时间</div>
                                </div>
                                <div class="col-md-2 controls">
                                    <input id="assessment_end" name="assessment_end" type="text" value="<fmt:formatDate value="${lessonTimeView.assessment_end}" type="date"/>"  class="form-control"  onClick="WdatePicker()">
                                    <div id="assessment_end_msg" class="help-block"></div>
                                </div>
                            </div>

                            <div class="form-group" style="margin-top: -30px;">
                                <div class="col-md-10 controls col-md-offset-1">
                                    <table class="table table-striped all-statistics" >
                                        <tbody>
                                        <tr>
                                            <td class="active"><span class="text-danger">*</span>1.观课报告</td>
                                            <td style="width:65%">
                                                <a href="javascript:void(0)" class="pull-right" data-toggle="modal" data-target="#add-teachers" onclick="showTeacher(401);">
                                                    <span class="text-warning pull-right">分配任务&nbsp;&gt;</span>
                                                </a>
                                                <ul class="nav nav-pills clearfix tutor_list401">
                                                    <c:forEach items="${lessonUserTaskList }" var="lessonUser">
                                                        <c:if test="${lessonUser.purview ==401}">
                                                            <li class="active" id="401teacher${lessonUser.id }">
                                                                <a href="javascript:return false;"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>&nbsp;&nbsp;
                                                                    <input name="user_id401" value="${lessonUser.user_id }" type="hidden" data-name="save401">
                                                                    <input name="mark" value="401" type="hidden" data-name="mark">
                                                                    <span class="tutor_del" onclick="delTeacherAC(${lessonUser.id },401);">X</span>
                                                                </a>
                                                            </li>
                                                        </c:if>
                                                    </c:forEach>
                                                </ul>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="active"> 2.课后评议会会议纪要</td>
                                            <td style="width:65%;">
                                                <a href="javascript:void(0)" class="pull-right" data-toggle="modal" data-target="#add-teachers" onclick="showTeacher(402);">
                                                    <span class="text-warning pull-right">分配任务&nbsp;&gt;</span>
                                                </a>
                                                <ul class="nav nav-pills tutor_list402">
                                                    <c:forEach items="${lessonUserTaskList }" var="lessonUser">
                                                        <c:if test="${lessonUser.purview ==402}">
                                                            <li class="active" id="402teacher${lessonUser.id }">
                                                                <a href="javascript:return false;"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>&nbsp;&nbsp;
                                                                    <input name="user_id402" value="${lessonUser.user_id }" type="hidden" data-name="save402">
                                                                    <input name="mark" value="402" type="hidden" data-name="mark">
                                                                    <span class="tutor_del" onclick="delTeacherAC(${lessonUser.id },402);">X</span>
                                                                </a>
                                                            </li>
                                                        </c:if>
                                                    </c:forEach>
                                                </ul>

                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="active">3.问题研讨</td>
                                            <td style="width:65%;">

                                                <a href="javascript:void(0)" class="pull-right" data-toggle="modal" data-target="#add-teachers" onclick="showTeacher(403);">
                                                    <span class="text-warning pull-right">分配任务&nbsp;&gt;</span>
                                                </a>
                                                <ul class="nav nav-pills tutor_list403">
                                                    <c:forEach items="${lessonUserTaskList }" var="lessonUser">
                                                        <c:if test="${lessonUser.purview ==403}">
                                                            <li class="active" id="403teacher${lessonUser.id }">
                                                                <a href="javascript:return false;"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>&nbsp;&nbsp;
                                                                    <input name="user_id403" value="${lessonUser.user_id }" type="hidden" data-name="save403">
                                                                    <input name="mark" value="403" type="hidden" data-name="mark">
                                                                    <span class="tutor_del" onclick="delTeacherAC(${lessonUser.id },403);">X</span>
                                                                </a>
                                                            </li>
                                                        </c:if>
                                                    </c:forEach>
                                                </ul>

                                            </td>
                                        </tr>


                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <!--反思环节   -->
                            <div class="form-group clearfix" >
                                <div class="col-md-2 control-label">
                                    <label>反思环节</label>
                                </div>
                                <div class="col-md-2 control-label col-md-offset-1">
                                    <div><span class="text-danger">*</span>开始时间</div>
                                </div>
                                <div class="col-md-2 controls ">
                                    <input id="introspection_sta" name="introspection_sta" type="text" value="<fmt:formatDate value="${lessonTimeView.introspection_sta}" type="date"/>" class="form-control"  onClick="WdatePicker()">
                                    <div id="introspection_sta_msg" class="help-block"></div>
                                </div>
                                <div class="col-md-2 control-label">
                                   <div><span class="text-danger">*</span>结束时间</div>
                                </div>
                                <div class="col-md-2 controls">
                                    <input id="introspection_end" name="introspection_end" type="text" value="<fmt:formatDate value="${lessonTimeView.introspection_end}" type="date"/>"  class="form-control"  onClick="WdatePicker()">
                                    <div id="introspection_end_msg" class="help-block"></div>
                                </div>
                            </div>
                            <div class="form-group" style="margin-top: -30px;">
                                <div class="col-md-10 controls col-md-offset-1">
                                    <table class="table table-striped all-statistics" >
                                        <tbody>
                                        <tr>
                                            <td class="active">1.反思心得</td>
                                            <td style="width:65%;">
                                                <a href="javascript:void(0)" class="pull-right" data-toggle="modal" data-target="#add-teachers" onclick="showTeacher(501);">
                                                    <span class="text-warning pull-right">分配任务&nbsp;&gt;</span>
                                                </a>
                                                <ul class="nav nav-pills  tutor_list501">
                                                    <c:forEach items="${lessonUserTaskList }" var="lessonUser">
                                                        <c:if test="${lessonUser.purview ==501}">
                                                            <li class="active" id="501teacher${lessonUser.id }">
                                                                <a href="javascript:return false;"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>&nbsp;&nbsp;
                                                                    <input name="user_id501" value="${lessonUser.user_id }" type="hidden" data-name="save501">
                                                                    <input name="mark" value="501" type="hidden" data-name="mark">
                                                                    <span class="tutor_del" onclick="delTeacherAC(${lessonUser.id },501);">X</span>
                                                                </a>
                                                            </li>
                                                        </c:if>
                                                    </c:forEach>
                                                </ul>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="active"> <span class="text-danger">*</span>2.提交实践反思后教学设计及课件</td>
                                            <td style="width:65%;">
                                                <ul class="nav nav-pills tutor_list502">
                                                    <c:forEach items="${lessonUserTaskList }" var="lessonUser">
                                                        <c:if test="${lessonUser.purview ==502}">
                                                            <li class="active" id="502teacher${lessonUser.id }">
                                                                <a href="javascript:return false;"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>&nbsp;&nbsp;
                                                                    <input name="user_id502" value="${lessonUser.user_id }" type="hidden" data-name="save502">
                                                                    <input name="mark" value="502" type="hidden" data-name="mark">
                                                                </a>
                                                            </li>
                                                        </c:if>
                                                    </c:forEach>
                                                </ul>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="active"><span class="text-danger">*</span>3.自评总结</td>
                                            <td style="width:65%;">
                                                <ul class="nav nav-pills tutor_list503">
                                                    <c:forEach items="${lessonUserTaskList }" var="lessonUser">
                                                        <c:if test="${lessonUser.purview ==503}">
                                                            <li class="active" id="503teacher${lessonUser.id }">
                                                                <a href="javascript:return false;"><c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>&nbsp;&nbsp;
                                                                    <input name="user_id503" value="${lessonUser.user_id }" type="hidden" data-name="save503">
                                                                    <input name="mark" value="503" type="hidden" data-name="mark">
                                                                </a>
                                                            </li>
                                                        </c:if>
                                                    </c:forEach>
                                                </ul>
                                            </td>
                                        </tr>

                                        </tbody>
                                    </table>

                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-md-offset-1 col-md-2 controls ">
                                    <button type="button"  class="btn btn-fat btn-primary" onclick="doSumbit();">保存</button>
                                </div>

                            </div>

                        </form>
                    </div>

                </div>
            </div>

        </div>
    </div>
    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
</div>



<!-- 添加老师弹窗 -->
<div id="add-teachers" class="modal" data-toggle="modal" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">选择人员</h4>
            </div>
            <div class="modal-body">
                <form class="form-inline well well-sm" >
                    <input type="hidden" name="page" id="page" value="" />
                    <input type="hidden" name="rows" id="rows" value="" />
                    <input type="hidden" name="total" id="total" value="" />
                    <input type="hidden" name="totalPage" id="totalPage" value="" />

                    <div id="showPage" class="row">


                        <table class="table table-condensed" id="try">
                            <thead>
                            <tr style="border: none;">
                                <th></th>
                                <th></th>
                                <th>姓名</th>
                            </tr>
                            </thead>
                            <tbody id="showAssistant"> </tbody>
                        </table>
                    </div>
                    <div id="fenye" class="pager" style="clear: both;"></div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-info pull-right tutor_confirm" data-dismiss="modal">确定</button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>

<script type="text/javascript">
    function doSumbit(){
        var val = validate();
        var status="${lesson.status}";
        if(status==2){
        alert("课例已经完成，无法进行修改");
		return false;
		}
        
//	alert(val);
        if(val){
            document.getElementById('saveLessonPlan').submit();
        }else{
            alert("信息填写有误或者不完整");
        }
    }

    function validate(){
    	var lesson_name = $('#lesson_name').val();
        if(lesson_name==""){
            $('#lesson_name_msg').show();
            return false;
        }else{
            $('#lesson_name_msg').hide();
        }
        var stage = $('#stage').val();
        if(stage==-1){
            $('#stage_msg').show();
            return false;
        }else{
            $('#stage_msg').hide();
        }
        var subject = $('#subject').val();
        if(subject==-1){
            $('#subject_msg').show();
            return false;
        }else{
            $('#subject_msg').hide();
        }
        var grade = $('#grade').val();
        if(grade==-1){
            $('#grade_msg').show();
            return false;
        }else{
            $('#grade_msg').hide();
        }
        var edition = $('#edition').val();
        if(edition==-1){
            $('#edition_msg').show();
            return false;
        }else{
            $('#edition_msg').hide();
        }
        var research = $('#research').val();
        if(research==""){
            $('#research_msg').show();
            return false;
        }else{
            $('#research_msg').hide();
        }
     
        var plan_que = $('#plan_que').val();
        if(plan_que==""){
            $('#plan_que_msg').show();
            return false;
        }else{
            $('#plan_que_msg').hide();
        }
        var prepare_que = $('#prepare_que').val();
        if(prepare_que==""){
            $('#prepare_que_msg').show();
            return false;
        }else{
            $('#prepare_que_msg').hide();
        }
        var class_que = $('#class_que').val();
        if(class_que==""){
            $('#class_que_msg').show();
            return false;
        }else{
            $('#class_que_msg').hide();
        }
        var assessment_que = $('#assessment_que').val();
        if(assessment_que==""){
            $('#assessment_que_msg').show();
            return false;
        }else{
            $('#assessment_que_msg').hide();
        }
        var measures = $('#measures').val();
        if(measures==""){
            $('#measures_msg').show();
            return false;
        }else{
            $('#measures_msg').hide();
        }
        var teacher0 = $('input[data-name="save0"]').val();
        if(typeof(teacher0)=='undefined'){
            alert("必须选择上课老师");
//		   $('#sk').show();
            return false;
        }else{
//		   $('#sk').hide();
        }

        var plan_sta = $('#plan_sta').val();
        if(plan_sta==""){
            $('#plan_sta_msg').html("请选择计划环节开始时间");
            return false;
        }else{
            $('#plan_sta_msg').html("");
        }

        var plan_end = $('#plan_end').val();
        if(plan_end==""){
            $('#plan_end_msg').html("请选择计划环节结束时间");
            return false;
        }else{
            $('#plan_end_msg').html("");
        }

        var startPlan=plan_sta.split("-");
        var endPlan=plan_end.split("-");
        var sdPlan=new Date(startPlan[0],startPlan[1],startPlan[2]);
        var edPlan=new Date(endPlan[0],endPlan[1],endPlan[2]);
        if(sdPlan.getTime()>edPlan.getTime()){
            alert("计划阶段开始日期不能大于结束日期");
            return false;
        }
        var prepare_sta = $('#prepare_sta').val();
        if(prepare_sta==""){
            $('#prepare_sta_msg').html("请选择备课环节开始时间");
            return false;
        }else{
            $('#prepare_sta_msg').html("");
        }

        var prepare_end = $('#prepare_end').val();
        if(prepare_end==""){
            $('#prepare_end_msg').html("请选择备课环节结束时间");
            return false;
        }else{
            $('#prepare_end_msg').html("");
        }
        var startprepare=prepare_sta.split("-");
        var endprepare=prepare_end.split("-");
        var sdprepare=new Date(startprepare[0],startprepare[1],startprepare[2]);
        var edprepare=new Date(endprepare[0],endprepare[1],endprepare[2]);
        if(sdprepare.getTime()>edprepare.getTime()){
            alert("准备阶段开始日期不能大于结束日期");
            return false;
        }
        var teacher201 = $('input[data-name="save201"]').val();
        if(typeof(teacher201)=='undefined'){
            alert("必须选择初始教学设计协同修改人员");
            return false;
        }
        var class_sta = $('#class_sta').val();
        if(class_sta==""){
            $('#class_sta_msg').html("请选择上课环节开始时间");
            return false;
        }else{
            $('#class_sta_msg').html("");
        }

        var class_end = $('#class_end').val();
        if(class_end==""){
            $('#class_end_msg').html("请选择上课环节结束时间");
            return false;
        }else{
            $('#class_end_msg').html("");
        }

        var startClass=class_sta.split("-");
        var endClass=class_end.split("-");
        var sdClass=new Date(startClass[0],startClass[1],startClass[2]);
        var edClass=new Date(endClass[0],endClass[1],endClass[2]);
        if(sdClass.getTime()>edClass.getTime()){
            alert("上课阶段开始日期不能大于结束日期");
            return false;
        }
        var teacher302 = $('input[data-name="save302"]').val();
        if(typeof(teacher302)=='undefined'){
            alert("必须选择观课量表人员");
            return false;
        }
        var assessment_sta = $('#assessment_sta').val();
        if(assessment_sta==""){
            $('#assessment_sta_msg').html("请选择评课环节开始时间");
            return false;
        }else{
            $('#assessment_sta_msg').html("");
        }

        var assessment_end = $('#assessment_end').val();
        if(assessment_end==""){
            $('#assessment_end_msg').html("请选择评课环节结束时间");
            return false;
        }else{
            $('#assessment_end_msg').html("");
        }

        var startAssessment=assessment_sta.split("-");
        var endAssessment=assessment_end.split("-");
        var sdAssessment=new Date(startAssessment[0],startAssessment[1],startAssessment[2]);
        var edAssessment=new Date(endAssessment[0],endAssessment[1],endAssessment[2]);
        if(sdAssessment.getTime()>edAssessment.getTime()){
            alert("评课阶段开始日期不能大于结束日期");
            return false;
        }
        var teacher401 = $('input[data-name="save401"]').val();
        if(typeof(teacher401)=='undefined'){
            alert("必须选择观课报告人员");
            return false;
        }
        var introspection_sta = $('#introspection_sta').val();
        if(introspection_sta==""){
            $('#introspection_sta_msg').html("请选择反思环节开始时间");
            return false;
        }else{
            $('#introspection_sta_msg').html("");
        }

        var introspection_end = $('#introspection_end').val();
        if(introspection_end==""){
            $('#introspection_end_msg').html("请选择反思环节结束时间");
            return false;
        }else{
            $('#introspection_end_msg').html("");
        }
        var startIntrospection=introspection_sta.split("-");
        var endIntrospection=introspection_end.split("-");
        var sdIntrospection=new Date(startIntrospection[0],startIntrospection[1],startIntrospection[2]);
        var edIntrospection=new Date(endIntrospection[0],endIntrospection[1],endIntrospection[2]);
        if(sdIntrospection.getTime()>edIntrospection.getTime()){
            alert("反思阶段开始日期不能大于结束日期");
            return false;
        }

        return true;
    }
    function delStage(value){
  //  	alert(value);
        $("#nullStage").remove();
        if(value==-1){
        _stage("XX")
        }
    }
    function _stage(value){
 //       alert(value);
        $("#subject").find("option").remove();
        $("#edition").find("option").remove();
        $("#grade").find("option").remove();
        $.ajax({
            url : "${pageContext.request.contextPath}/subject/query_subject.action?subId="+value,
            dataType:'json',
            success : function(json) {
                var a = JSON.stringify(json);
                var o = eval( "(" + a + ")" );
                var sub = o[0].subjectList;
                var edi = o[0].editionList;
                var gra = o[0].gradeList;
                for(var i in sub){
                    $("#subject").append('<option   value='+sub[i].id+' >'+sub[i].subjectName+'</option>');
                }


                for(var i in edi){
                    $("#edition").append('<option  value='+edi[i].id+' >'+edi[i].versionName+'</option>');
                }

                /* for(var i in gra){
                 $("#grade").append('<option value='+gra[i].bookCatelogId+' >'+gra[i].bookCatelogName+'</option>');
                 }
                 $("#gradeId").val(gra[0].bookCatelogId); */
            }
        });
        if(value=="XX"){
        	$("#grade").append('<option value=1 >一年级</option>');
        	$("#grade").append('<option value=2 >二年级</option>');
        	$("#grade").append('<option value=3 >三年级</option>');
        	$("#grade").append('<option value=4 >四年级</option>');
        	$("#grade").append('<option value=5 >五年级</option>');
        	$("#grade").append('<option value=6 >六年级</option>');
        }else if(value=="CZ"){
        	$("#grade").append('<option value=7 >初一</option>');
        	$("#grade").append('<option value=8 >初二</option>');
        	$("#grade").append('<option value=9 >初三</option>');
        }else if(value=="GZ"){
        	$("#grade").append('<option value=10 >高一</option>');
        	$("#grade").append('<option value=11 >高二</option>');
        	$("#grade").append('<option value=12 >高三</option>');
        }
    }
    function _subject(value){
//    	alert(value);
        $("#edition").find("option").remove();
        $.ajax({
            url : "${pageContext.request.contextPath}/pubver/query_pubver.action?pubId="+value,
            dataType:'json',
            success : function(json){
                var a = JSON.stringify(json);
                var o = eval( "(" + a + ")" );
                var edi = o[0].editionList;
                var gra = o[0].gradeList;
                for(var i in edi){
                    $("#edition").append('<option  value='+edi[i].id+' >'+edi[i].versionName+'</option>');
                }
                $("#editionId").val(edi[0].id);

            }
        });
    }

    /*****
    function _grade(){


        if($("#grade").val()==null||$("#grade").val()=="-1"){
            $("#nullGrade").remove();
            $.ajax({
                url : "${pageContext.request.contextPath}/my_setting/selectGrade.action",
                dataType:'json',
                success : function(json){
                    var a = JSON.stringify(json);
                    var o = eval( "(" + a + ")" );
                    for(var i in o){
                        $("#grade").append('<option  value='+o[i].id+' >'+o[i].grade_name+'</option>');
                    }
                }
            });
        }


    }**********/

    //事物删除教师
    function delTeacherAC(value,mark){
        $.ajax({
            url : '${pageContext.request.contextPath}/lesson_user_task/delTeacher.action',
            dataType : 'json',
            data:{
                id : value
            },
            success:function(data){
                var num = data.num;
                if(num==0){
                    $("#"+mark+"teacher"+value).remove();
                }else{
                    alert("删除失败该成员已经开始任务");
                }
            }
        });
    }
    //nosession移除教师
    function delTeacher(value,mark){
        $("#"+mark+"teacher"+value).remove();
        if(mark==0){
            $('#skteacher').show();
        }
    }

    //展示教师
    $("#showTeacher").click(function(){
//  $("#add-t").modal();
        showTeacher();
    });

    function doPages(){
        //翻页
        var total = $("#total").val();
        var page =  parseInt($("#page").val())+1;

        $("#btn5").on('click', function () {
            $("#div1").PageChanged(5);
        });

        $(".pager").pagination({
            thisPageIndex:page,
            recordCount: total,       //总记录数
            pageSize:  $("#rows").val(),            //一页记录数
            onPageChange: function (page) {
                var page = $("#page").val(page-1).val();
                showTeacher(page);
            }
        });
    }

    function showTeacher(value){
//	alert(value);
        var test = value;
        $.ajax({
            url : '${pageContext.request.contextPath}/lesson/show_teacher.action',
            dataType : 'json',
            data:{
                lesson_id :$('#lesson_id').val(),
                mark : test
            },
            success : function(data){
                var list = data.lessonUserIdentityZzs;
                var len = list.length;
                $("#showAssistant").html('');
                if(len > 0) {
//				   $('#test').show();
                    for(var i=0; i<len; i++) {
                        var row = ' <tr>'+
                                '<td><input type="checkbox" name="'+list[i].true_name+'" data-username="'+list[i].user_name+'" data-name="user_id" value="'+list[i].user_id+'"></td>'+
                                '<td><input type="hidden" id="mark" value="'+test+'"></td>'+
                                '<td>'+list[i].true_name+'('+list[i].user_name+')</td>'+
                                '</tr>';
                        $("#showAssistant").append(row);
                    }
                    $("#page").val(view.page);
                    $("#rows").val(view.rows);
                    $("#total").val(view.total);
                    $("#totalPage").val(view.totalPage);
                    doPages();
                }else{
                    $('#fenye').hide();
                }
            }
        });
    }

    $(document).ready(function(e){


        //确定组员
        $('.tutor_confirm').on('click',function(){
            var len = $('input[data-name="user_id"]:checked').length;
            var test =$("#mark").val();
//	 alert(test);
            if(len>1&&test==0){
                alert('只能有一个上课老师');
                return flase;
            }
            if(len==0){
                alert('请选择老师');
                return flase;
            }
            $('input[data-name="user_id"]:checked').each(function(){//嵌入的文件里有type="checkbox",故区分
                var tutor_name = $(this).attr('name');
                if(tutor_name==null||tutor_name==""){
                tutor_name=$(this).data("username");
                }
                var user_id = $(this).val();
                $('input[data-name="save'+test+'"]').each(function(){
                    var user = $(this).val();
                    if(user==user_id){
                        $('input[data-name="mark"]').each(function(){
                            var mark = $(this).val();
                            if(mark==test){
                                alert("您已选过该老师！");
                                return flase;
                            }
                        });
                    }
                });
                var str = '<li class="active" id="'+test+'teacher'+user_id+'" ><a href="javascript:;">'+tutor_name+'&nbsp;&nbsp;<input name="user_id'+test+'" value="'+user_id+'" type="hidden" data-name="save'+test+'"><input name="user_name'+test+'" value="'+tutor_name+'" type="hidden" data-name="name_sk"><input name="mark" value="'+test+'" type="hidden" data-name="mark"><span class="tutor_del" onclick="delTeacher('+user_id+','+test+');">X</span></a></li>';
                $('.tutor_list'+test).append(str);
            });
            if(test==0){
                $('#skteacher').hide();
            }
            $('#modal').hide();
            $('.modal-backdrop').remove();
        });
        $('.class_range .nav-pills li').on("click",function(){
            $(this).siblings().removeClass('active');
            $(this).addClass('active');
        })
    })



    $(function(){
        var uploader = WebUploader.create({
            auto: true,
            // swf文件路径
            swf: '${pageContext.request.contextPath}/frontstage/js/webuploader/Uploader.swf',
            // 文件接收服务端。
            server: '${pageContext.request.contextPath}/lesson/upload_img.action',

            // 选择文件的按钮。可选。
            // 内部根据当前运行是创建，可能是input元素，也可能是flash.
            pick: '#file',

            // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
            resize: false,
            accept: {
                title: 'Images',
                extensions: 'gif,jpg,jpeg,bmp,png',
                mimeTypes: 'image/*'
            }
        });
        /**
         *上传成功后
         *file:文件
         *response:服务器返回
         */
        uploader.on( 'uploadSuccess', function( file,response  ) {
		var hidden=$('<input type="hidden" value="1" name="is_default_img" class="hidden">' );
		var $form=$("#saveLessonPlan");
		$form.append(hidden);
            document.getElementById("lesson_pic").value = response.fileName;
        });

        // 当有文件添加进来的时候
        uploader.on( 'fileQueued', function( file ) {

            // <input type="hidden">
            var $img;
            var $li = $(
                            '<div id="' + file.id + '" class="file-item thumbnail">' +
                            '<img style="">' +
                                /*  '<div class="info">' + file.name + '</div>' + */
                            '</div>'
                    ),
                    $img = $li.find('img');
            var   $list=$("#fileList");

            // $list为容器jQuery实例
//		$list.append( $li );
//		$("#defaultImg").css("display","none");
//		$("#upload_course_picture_content").css("display","none");
            $("#save_course_picture_content").css("display","");


            // 创建缩略图
            // 如果为非图片文件，可以不用调用此方法。
            // thumbnailWidth x thumbnailHeight 为 100 x 100
            uploader.makeThumb( file, function( error, src ) {
                if ( error ) {
                    $img.replaceWith('<span>不能预览</span>');
                    return;
                }

                $img.attr( 'src', src );
                document.getElementById("defaultImg").src = src;
            }, 480, 270 );
        });
    });
</script>
<script>
    $(function(){
        $("#lesson_pic,.choose_pic,.mask").mouseover(function(){
            $(".mask,.choose_pic").show()
        }).mouseout(function(){
            $(".mask,.choose_pic").hide()
        });
    })
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/My97DatePicker/WdatePicker.js"></script>
<link href="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.js"></script>
<style>
    #defaultImg{
        width:190px;height:110px;}
    .file:hover{color: #fff;}
    .webuploader-pick>div>label:hover{color: #fff;}
</style>