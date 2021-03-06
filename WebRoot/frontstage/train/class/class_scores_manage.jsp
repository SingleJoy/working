<%@ page language="java" import="java.util.*,cn.bnsr.edu_yun.frontstage.base.po.User" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
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

                    <div class="panel-heading">
                        <c:if test="${empty commonTrain }">成绩管理</c:if>
                        <c:if test="${!empty commonTrain && testView.exam_type==0}">考试成绩</c:if>
                        <c:if test="${!empty commonTrain && testView.exam_type==1}">作业成绩</c:if>
                        <c:if test="${!empty commonTrain && testView.exam_type==2}">研讨成绩</c:if>
                        <c:if test="${empty train_type&&!empty commonTrain}">
                            <a href="${pageContext.request.contextPath}/class/to_class_scores_manage.action?required=${required}&id=${classView.id}&flag=2&sign=7&exam_type=${testView.exam_type}&source_id=${classView.source_id}&source_type=${classView.source_type}" class="btn btn-default pull-right">返回</a>
                        </c:if>
                        <c:if test="${!empty train_type&&!empty commonTrain }">
                           <a href="${pageContext.request.contextPath}/class/to_class_scores_manage.action?id=${classView.id}&flag=2&sign=7&exam_type=4&source_id=${classView.source_id}&source_type=${classView.source_type}" class="btn btn-default pull-right">返回</a>
                    	</c:if>
                        <%--返回按钮只有当前页面是考试成绩,作业成绩,研讨成绩才显示--%>


                    </div>

                    <div class="panel-body">
                        <c:if test="${empty commonTrain}">
                            <div class="nav-btn-tab">
                                <ul class="nav nav-tabs mbl" style="border: none;">
                                    <li <c:if test="${testView.exam_type==4}">class="active"</c:if>><a href="${pageContext.request.contextPath}/class/to_class_scores_manage.action?id=${classView.id}&flag=2&sign=7&exam_type=4&source_id=${classView.source_id}&source_type=${classView.source_type}">总成绩</a></li>
                                    <li <c:if test="${testView.exam_type==0}">class="active"</c:if>><a href="${pageContext.request.contextPath}/class/to_class_scores_manage.action?required=1&id=${classView.id}&flag=2&sign=7&exam_type=0&source_id=${classView.source_id}&source_type=${classView.source_type}">考试成绩</a></li>
                                    <li <c:if test="${testView.exam_type==1}">class="active"</c:if>><a href="${pageContext.request.contextPath}/class/to_class_scores_manage.action?required=1&id=${classView.id}&flag=2&sign=7&exam_type=1&source_id=${classView.source_id}&source_type=${classView.source_type}">作业成绩</a></li>
                                    <li <c:if test="${testView.exam_type==2}">class="active"</c:if>><a href="${pageContext.request.contextPath}/class/to_class_scores_manage.action?required=1&id=${classView.id}&flag=2&sign=7&exam_type=2&source_id=${classView.source_id}&source_type=${classView.source_type}">研讨成绩</a></li>
                                </ul>
                            </div>
                        </c:if>

                        <form id="examForm" class="form-horizontal" action="${pageContext.request.contextPath}/class/to_class_scores_manage.action?id=${classView.id}&flag=2&sign=7&exam_type=${testView.exam_type }&source_id=${classView.source_id}&source_type=${classView.source_type}" method="post" novalidate="">

                            <input type="hidden" name="page" id="page" value="${testView.page}" />
                            <input type="hidden" name="rows" id="rows" value="${testView.rows}" />
                            <input type="hidden" name="total" id="total" value="${testView.total}" />
                            <input type="hidden" name="totalPage" id="totalPage" value="${testView.totalPage}" />


                            <c:if test="${testView.exam_type ==4}">
                                <div class="form-group">
                                    <div class="col-md-12 controls ">
                                        <table class="table table-hover" style="font-size: 14px;">
                                            <thead>
                                            <tr>
                                                <th >用户名</th>
                                                <th >姓名</th>
                                                <th >手机号码</th>
                                                <th>
                                                    <c:if test="${classView.type==0 }">分数</c:if>
                                                    <c:if test="${classView.type==1 }">学时</c:if>
                                                </th>
                                                <th> <c:if test="${classView.type==1 }">必修</c:if> </th>

                                                <th> <c:if test="${classView.type==1 }">选修</c:if> </th>

                                                <th >证书</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${userTotalScoreViews }" var="utsv">
                                                <tr>
                                                    <td>${utsv.username }</td>
                                                    <td>${utsv.realname }</td>
                                                    <td>${utsv.phone }</td>
                                                    <td><fmt:formatNumber value="${utsv.score }" type="number" maxIntegerDigits="3" maxFractionDigits="0"/></td>
                                                    <td><a href="javascript:void(0);" class="required" data-user-id="${utsv.user_id }"> <c:if test="${classView.type==1 }">${utsv.required }</c:if></a> </td>
                                                    <td ><a href="javascript:void(0);" class="not_required" data-user-id="${utsv.user_id }">  <c:if test="${classView.type==1 }">${utsv.not_required }</c:if></a> </td>
                                                    <td>${utsv.cer }</td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>

                            </c:if>


                            <c:if test="${train_type==null&&(testView.exam_type == 1||testView.exam_type == 0)}">
                                <div class="form-group">
                                    <div class="col-md-12 controls ">
                                        <table class="table table-hover" style="font-size: 14px;">
                                            <thead>
                                            <tr>
                                                <th width="20%"><c:if test="${testView.exam_type == 0}">考试名称</c:if>
                                                    <c:if test="${testView.exam_type == 1}">作业名称</c:if>
                                                </th>
                                                <th width="10%">总分</th>
                                                <th width="10%">总题数</th>
                                                <th width="15%">所属章节</th>
                                                <c:if test="${testView.exam_type == 0}">
                                                    <th width="15%">时间限制(分钟)</th>
                                                </c:if>

                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${testList }" var="test">
                                                <tr>
                                                    <td class="media" >
                                                        <a target="" href="${pageContext.request.contextPath}/class/to_class_student_scores_manage.action?commonTrain=${commonTrain}&courseId=${test.learn_id}&required=${required}&class_type=${class_type}&id=${classView.id}&flag=2&sign=7&exam_type=${testView.exam_type}&source_id=${classView.source_id}&source_type=${classView.source_type}&course_hour_id=${test.course_hour_id}">${test.name }</a>

                                                    </td>
                                                    <td>${test.total_score }</td>
                                                    <td>${test.total_number }</td>
                                                    <td >${test.chapter }</td>
                                                    <c:if test="${testView.exam_type == 0}">
                                                        <td style="vertical-align: middle;">
                                                                ${test.timeless }
                                                        </td>
                                                    </c:if>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </c:if>

                            <c:if test="${train_type==null&&testView.exam_type == 2}">
                                <div class="form-group">
                                    <div class="col-md-12 controls ">
                                        <table class="table table-hovered" style="font-size: 14px;">
                                            <thead>
                                            <tr>
                                                <th width="50%">研讨名称</th>
                                                <th width="20%">参与次数</th>
                                                <th width="30%">所属章节</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${testList }" var="test">
                                                <tr>
                                                    <td class="media" >
                                                        <a target="" href="${pageContext.request.contextPath}/class/to_class_student_scores_manage.action?commonTrain=${commonTrain}&courseId=${test.learn_id}&required=${required}&class_type=${class_type}&id=${classView.id}&flag=2&sign=7&exam_type=${testView.exam_type}&source_id=${classView.source_id}&source_type=${classView.source_type}&course_hour_id=${test.course_hour_id}">${test.name }</a>

                                                    </td>
                                                    <td>${test.frequency}</td>
                                                    <td>${test.chapter}</td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </c:if>
                            <!-- 专业培训（罗列课程） -->
                            <c:if test="${classView.source_type==1&&train_type==0}">
                                <div class="nav-btn-tab">
                                    <ul class="nav nav-tabs">
                                        <li <c:if test="${required==1 }">class="active"</c:if> value="1"><a href="${pageContext.request.contextPath}/class/to_class_scores_manage.action?required=1&id=${classView.id}&flag=2&sign=7&exam_type=${testView.exam_type}&source_id=${classView.source_id}&source_type=${classView.source_type}">必修课程</a></li>
                                        <li <c:if test="${required==0 }">class="active"</c:if> value="0"><a href="${pageContext.request.contextPath}/class/to_class_scores_manage.action?required=0&id=${classView.id}&flag=2&sign=7&exam_type=${testView.exam_type}&source_id=${classView.source_id}&source_type=${classView.source_type}">选修课程</a></li>
                                    </ul>
                                </div>
                                <div id="common_train" class="course-stage" >
                                    <!--课程-->
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
                                                <c:forEach items="${trainCourse}" var="course">
                                                    <tr >
                                                        <td><a href="${pageContext.request.contextPath}/class/to_train_course_exam.action?commonTrain=1&required=${required}&id=${classView.id}&flag=2&sign=7&exam_type=${testView.exam_type}&source_id=${course.id}&source_type=${classView.source_type}">${course.title}</a></td>
                                                        <td>${course.hours}</td>
                                                        <td>${course.studentNum}</td>
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

                                    <div class="course-stage-abbreviation" id="phaseShow${trainPhase.id}" style="min-height: 100px;" >

                                        <div class="form-group">
                                            <div  class="phase_logo" style="margin-top: 30px;margin-left: 20px;"></div>
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
                                                                        <td><a href="${pageContext.request.contextPath}/class/to_train_course_exam.action?required=0&id=${classView.id}&flag=2&sign=7&exam_type=${testView.exam_type}&source_id=${course.id}&source_type=${classView.source_type}">${course.title}</a></td>
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
                                                                        <td><a href="${pageContext.request.contextPath}/class/to_train_course_exam.action?required=1&id=${classView.id}&flag=2&sign=7&exam_type=${testView.exam_type}&source_id=${course.id}&source_type=${classView.source_type}">${course.title}</a></td>
                                                                        <td>${course.hours}</td>
                                                                        <td>${course.studentNum}</td>
                                                                    </tr>
                                                                </c:if>
                                                            </c:forEach>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                        </div>
                                    </div>


                                </c:forEach>
                            </c:if>
                            <%-- <c:if test="${empty train_type && empty testList && testView.exam_type==0 }"><div class="empty">还没有学生进行考试</div> </c:if>
                            <c:if test="${empty train_type && empty testList && testView.exam_type==1 }"><div class="empty">还没有学生做作业</div> </c:if>
                            <c:if test="${empty train_type && empty testList && testView.exam_type==2 }"><div class="empty">还没有学生参与研讨</div> </c:if> --%>
                            <c:if test="${!empty testList }"><div id="test" class="pager" style="clear: both;"></div></c:if>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
</div>

<div class="modal in" id="course_info_modal" role="dialog" aria-hidden="false" style="display: none;">
    <div class="modal-dialog  modal-lg">
        <div class="modal-content">

            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"> 必/选修课课程信息</h4>
            </div>

            <div class="modal-body">

                <form class="form-horizontal" action="" method="post">
                    <table class="table table-hover" >
                        <thead>
                        <tr>
                            <th width="25%" >课程名称</th>
                            <th ></th>
                            <th ></th>
                        
                            <th >是否通过</th>
                        </tr>
                        </thead>
                        <tbody id="modalInfo">


					 </tbody>
                    </table>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-link" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>



<script type="text/javascript">
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
    $(function(){
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
                document.title = page;
                $("#page").val(page-1);
                $('#examForm').submit();

            }
        });
    });
$(".required").click(function () {
var user_id=$(this).data("userId");
var source_id='${classView.source_id}';

	queryUserCourse(source_id,user_id,0);
});
$(".not_required").click(function () {
var user_id=$(this).data("userId");
var source_id='${classView.source_id}';

	queryUserCourse(source_id,user_id,1);
});
function queryUserCourse(source_id,user_id,is_required) {

 $.ajax({
            url : '${pageContext.request.contextPath}/class/query_user_ajax.action',
            data : {
                is_required:is_required,
                user_id:user_id,
                source_id:source_id,
            },
            dataType : 'json',
            success : function(response) {
            $("#modalInfo").html("");
           var html="";
           for(var i=0;i<response.trainCourseViews.length;i++){
        var title=   response.trainCourseViews[i].title;
        var is_studyed=response.trainCourseViews[i].is_studyed;
       
        var str="";
        if(is_studyed==0){
        str="否";
        }
         if(is_studyed==1){
        str="是";
        }
           html+="<tr><td>"+title+"</td><td></td><td> </td><td>"+str+"</td></tr>";
           }

             $("#modalInfo").html(html);
            $("#course_info_modal").modal("show");
            }
        });
	
}
</script>


