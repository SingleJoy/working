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

<link href="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.js"></script>
<div class="cn-wrap">

    <div id="content-container" class="container">
        <jsp:include page="/frontstage/train/class/class_header.jsp"></jsp:include>
        <div class="row">
            <jsp:include page="/frontstage/train/class/class_left.jsp"></jsp:include>
            <div class="col-md-9">
                <div class="panel panel-default panel-col">
                    <div class="panel-heading">
                        <c:if test="${exam_type==1 }">
                            作业批改
                        </c:if>
                        <c:if test="${exam_type==0 }">
                            试卷批阅
                        </c:if>
                        <c:if test="${examView.class_type==2}">
                            <a href="${pageContext.request.contextPath}/exam/exam.action?required=${required}&class_id=${classView.id}&flag=2&sign=4&exam_type=0&status=1&source_id=${classView.source_id}&source_type=${classView.source_type}" class="btn btn-default pull-right">返回</a>
                        </c:if>
                    </div>
                    <div class="panel-body">

                        <div class="nav-btn-tab">
                            <ul class="nav nav-tabs">
                                <c:if test="${train_type == null}">
                                    <li <c:if test="${status==1 }">class="active"</c:if> value="1"><a <c:if test="${classView.source_type==1}">href="${pageContext.request.contextPath}/exam/course_exam.action?required=${required}&id=${classView.id}&class_id=${examView.class_id}&flag=2&sign=${classView.sign}&exam_type=${exam_type}&status=1&source_id=${examView.source_id}&class_type=${examView.class_type}&source_type=${classView.source_type}"</c:if>
                                                                                                      <c:if test="${classView.source_type==0}">href="${pageContext.request.contextPath}/exam/exam.action?class_id=${classView.id}&courseId=${classView.source_id}&flag=2&sign=${classView.sign}&exam_type=${exam_type}&status=1&source_id=${classView.source_id}&source_type=${classView.source_type}"</c:if>>未批<c:if test="${exam_type==1}">改</c:if><c:if test="${exam_type==0 }">阅</c:if>(${not_do_total })</a></li>
                                    <li <c:if test="${status==2 }">class="active"</c:if> value="2"><a <c:if test="${classView.source_type==1}">href="${pageContext.request.contextPath}/exam/course_exam.action?required=${required}&id=${classView.id}&class_id=${examView.class_id}&flag=2&sign=${classView.sign}&exam_type=${exam_type}&status=2&source_id=${examView.source_id}&class_type=${examView.class_type}&source_type=${classView.source_type}"</c:if>
                                                                                                      <c:if test="${classView.source_type==0}">href="${pageContext.request.contextPath}/exam/exam.action?class_id=${classView.id}&courseId=${classView.source_id}&flag=2&sign=${classView.sign}&exam_type=${exam_type}&status=2&source_id=${classView.source_id}&source_type=${classView.source_type}"</c:if>>已批<c:if test="${exam_type==1 }">改</c:if><c:if test="${exam_type==0 }">阅</c:if>(${do_total })</a></li>
                                </c:if>
                                <c:if test="${train_type == 0}">
                                    <li <c:if test="${required==1 }">class="active"</c:if> value="1"><a href="${pageContext.request.contextPath}/exam/exam.action?required=1&class_id=${classView.id}&flag=2&sign=${classView.sign}&exam_type=${exam_type}&status=1&source_id=${classView.source_id}&source_type=${classView.source_type}">必修课程</a></li>
                                    <li <c:if test="${required==0 }">class="active"</c:if> value="0"><a href="${pageContext.request.contextPath}/exam/exam.action?required=0&class_id=${classView.id}&flag=2&sign=${classView.sign}&exam_type=${exam_type}&status=1&source_id=${classView.source_id}&source_type=${classView.source_type}">选修课程</a></li>
                                </c:if>
                            </ul>
                        </div>

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
                                                    <table class="table table-striped " style="font-size: 14px;">
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
                                                                    <td><a href="${pageContext.request.contextPath}/exam/course_exam.action?id=${classView.id}&class_id=${course.class_id}&flag=${classView.flag}&sign=${classView.sign}&exam_type=${exam_type}&status=1&source_id=${course.id}&class_type=${course.class_type}&source_type=${classView.source_type}">${course.title}</a></td>
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
                                                    <table class="table table-striped" style="font-size: 14px;">
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
                                                                    <td><a href="${pageContext.request.contextPath}/exam/course_exam.action?id=${classView.id}&class_id=${course.class_id}&flag=${classView.flag}&sign=${classView.sign}&exam_type=${exam_type}&status=1&source_id=${course.id}&class_type=${course.class_type}&source_type=${classView.source_type}">${course.title}</a></td>
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

                        <c:if test="${classView.source_type==1&&train_type==0}">
                            <div id="common_train" class="course-stage" >
                                <!--课程-->
                                <c:if test="${required==1}">
                                    <div class="form-group">
                                        <div class="col-md-12 controls ">
                                            <table class="table table-hovered " style="font-size: 14px;">
                                                <thead>
                                                <tr>
                                                    <th style="width: 50%;">课程名称</th>
                                                    <th style="width: 30%;">学时</th>
                                                    <th style="width: 20%;">学员数</th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <c:forEach items="${requiredCourse}" var="course">
                                                    <%--  <c:if test="${trainPhase.id==course.phaseId}"> --%>
                                                    <tr >
                                                        <td><a href="${pageContext.request.contextPath}/exam/course_exam.action?required=1&id=${classView.id}&class_id=${course.class_id}&flag=${classView.flag}&sign=${classView.sign}&exam_type=${exam_type}&status=1&source_id=${course.id}&class_type=${course.class_type}&source_type=${classView.source_type}">${course.title}</a></td>
                                                        <td>${course.hours}</td>
                                                        <td>${course.studentNum}</td>
                                                    </tr>
                                                    <%-- </c:if> --%>
                                                </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </c:if>
                                <c:if test="${required==0}">
                                    <!--选修课程-->
                                    <div class="form-group">
                                        <div class="col-md-12 controls ">
                                            <table class="table table-hovered" style="font-size: 14px;">
                                                <thead>
                                                <tr>
                                                    <th style="width:50%;">课程名称</th>
                                                    <th style="width:30%;">学时</th>
                                                    <th style="width:20%;">学员数</th>
                                                </tr>
                                                </thead>
                                                <tbody >
                                                <c:forEach items="${optionCourse}" var="course">
                                                    <%-- <c:if test="${trainPhase.id==course.phaseId}"> --%>
                                                    <tr>
                                                        <td><a href="${pageContext.request.contextPath}/exam/course_exam.action?required=0&id=${classView.id}&class_id=${course.class_id}&flag=${classView.flag}&sign=${classView.sign}&exam_type=${exam_type}&status=1&source_id=${course.id}&class_type=${course.class_type}&source_type=${classView.source_type}">${course.title}</a></td>
                                                        <td>${course.hours}</td>
                                                        <td>${course.studentNum}</td>
                                                    </tr>
                                                    <%-- </c:if> --%>
                                                </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </c:if>

                        <c:if test="${train_type==null&&exam_type==1 }">
                            <table class="table  table-hovered">
                                <tbody>
                                <c:forEach items="${examViews }" var="examView">
                                    <tr>
                                        <td class="media">
                                            <a class="pull-left js-user-card" href="#"  >
                                                <img class="avatar-sm" src="${pageContext.request.contextPath}${examView.user_icon }">
                                            </a>

                                            <a target="_blank" href="javascript:void(0);">${examView.username }</a>

                                            <div class="clear-fix text-sm">
                                                <div class="pull-left"><a class="text-success" href="javascript:void(0)">${examView.hour_title }</a></div>
                                                <div class="mll text-muted pull-left">提交时间：${examView.submit_time }</div>
                                            </div>
                                        </td>
                                        <td>
                                            <a target="_blank" href="${pageContext.request.contextPath}/exam/to_homework.action?id=${examView.test_paper_id}&course_id=${course_id}&source_type=${classView.source_type}&courseId=${classView.source_id}&tab=4&exam_id=${examView.id}&class_id=${classView.id}" class="btn btn-default btn-sm pull-right"><c:if test="${status==1 }">批改</c:if><c:if test="${status==2 }">查看</c:if></a>
                                        </td>

                                    </tr>

                                </c:forEach>
                                </tbody>
                            </table>
                        </c:if>
                        <c:if test="${train_type==null&&exam_type==0 }">
                            <table class="table  table-hovered" style="">
                                <tbody>
                                <c:forEach items="${examViews }" var="examView">
                                    <tr>
                                        <td>
                                            <a href="javascript:void(0)" >${examView.hour_title }</a>
                                            <br>
                                            <c:if test="${status==2 }">
                                            <small class="text-muted">得${examView.exam_score }分 </small>
                                            <small class="text-muted mhs">•</small>
                                            </c:if>
                                            <small class="text-muted">共${examView.total_score }分 / ${examView.total_number }道题  </small>
                                        </td>
                                        <td>
                                            <a class="link-dark " href="#">${examView.username }</a>
                                            <br>
                                            <small class="text-muted">${examView.submit_time } 交卷</small>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/exam/to_test.action?id=${examView.test_paper_id}&course_id=${course_id}&source_type=${classView.source_type}&class_id=${classView.id}&courseId=${classView.source_id}&tab=4&exam_id=${examView.id}" class="btn btn-default btn-sm pull-right"><c:if test="${status==1 }">批阅</c:if><c:if test="${status==2 }">查看</c:if></a>

                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </c:if>
                        <c:if test="${train_type == null }">
                            <div id="test" class="pager" style="padding-top: 0;margin-bottom: 20px;"></div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <form id="examForm" <c:if test="${classView.source_type==0}">action="${pageContext.request.contextPath}/exam/exam.action"</c:if>
          <c:if test="${classView.source_type==1}">action="${pageContext.request.contextPath}/exam/course_exam.action"</c:if> method="post">
        <input type="hidden" name="page" id="page" value="${examView.page}"/>
        <input type="hidden" name="rows" id="rows" value="${examView.rows}"/>
        <input type="hidden" name="total" id="total" value="${examView.total}"/>
        <input type="hidden" name="totalPage" id="totalPage" value="${examView.totalPage}"/>
        <input type="hidden" name="source_id" value="${classView.source_id}">
        <input type="hidden" name="source_type" value="${classView.source_type}">
        <input type="hidden" name="class_id" value="${examView.class_id}">
        <input type="hidden" name="flag" value="${classView.flag}">
        <input type="hidden" name="sign" value="${classView.sign}">
        <input type="hidden" name="exam_type" value="${exam_type}">
        <input type="hidden" name="required" value="${required}">
        <input type="hidden" name="status" value="${status}">

    </form>
    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>

</div>
<!-- 弹窗 -->
<div id="modal" class="modal in" style="display: none;" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog  modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">题目预览</h4>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default pop_close">关闭</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function(e){
        //翻页
        var total = $("#total").val();
        var page =  parseInt($("#page").val())+1;

        $("#btn5").on('click', function () {
            $("#div1").PageChanged(5);
        });

        $(".pager").pagination({
            thisPageIndex:page,
            recordCount: total,       //总记录数
            pageSize: $("#rows").val(),           //一页记录数
            onPageChange: function (page) {
                document.title = page;
                $("#page").val(page-1);
                $('#examForm').submit();

            }
        });


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
    $(function(){
        var train_type = "${train_type}";
        if(train_type==0){
            $("#common_train").show();
        }
    })
</script>  
    

