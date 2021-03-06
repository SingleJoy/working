<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
        <jsp:include page="/frontstage/train/class/class_header.jsp"></jsp:include>

        <div class="row">

            <jsp:include page="/frontstage/train/class/class_left.jsp"></jsp:include>

            <div class="col-md-9">

                <div class="panel panel-default panel-col course-data">
                    <div class="panel-heading"><c:if test="${classView.type==0 }">课程</c:if><c:if test="${classView.type==1 }">培训</c:if>学习数据</div>
                    <div class="panel-body">
                        <form class="form-horizontal stage-form">
                            <c:if test="${classView.type==1 }">
                                <c:if test="${classView.trainType==0 }">
                                    <div class="form-group col-md-12">
                                        <div class="table-responsive ">
                                            <table class="table table-striped text-center" style="font-size: 12px;">

                                                <tbody>
                                                <tr class="active">
                                                    <th class="text-center">培训名</th>
                                                    <th>培训学习人数</th>
                                                    <th>培训完成人数</th>
                                                    <th>必修课程数</th>
                                                    <th>选修课程数</th>
                                                    <th></th>

                                                </tr>

                                                <tr>
                                                    <td><a data-toggle="modal" data-target="#modal"  href="javascript:">${courseDataView.title }</a></td>
                                                    <td>${courseDataView.studentCount }</td>
                                                    <td>${courseDataView.finishCount }</td>
                                                    <td>${courseDataView.requiredCount }</td>
                                                    <td>${courseDataView.unrequiredCount }</td>
                                                    <td>----</td>

                                                </tr>

                                                <tr class="active">
                                                    <td width="35%">课程名</td>
                                                    <td>课程学习人数</td>
                                                    <td>课程完成人数</td>
                                                    <td>考试人数</td>
                                                    <td>作业人数</td>
                                                    <td>研讨人数</td>

                                                </tr>
                                                <c:forEach items="${courseDataViews }" var="view">
                                                    <tr>
                                                        <td><a data-toggle="modal" data-target="#modal"  href="javascript:">${view.title }
                                                            <c:if test="${view.is_required==0 }">(必修)</c:if>
                                                            <c:if test="${view.is_required==1 }">(选修)</c:if>
                                                        </a></td>
                                                        <td>${view.studentCount }</td>
                                                        <td>${view.finishCount }</td>
                                                        <td>${view.examCount }</td>
                                                        <td>${view.homeworkCount }</td>
                                                        <td>${view.discussCount }</td>

                                                    </tr>
                                                </c:forEach>

                                                </tbody>
                                            </table>
                                        </div>
                                    </div>

                                </c:if>

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
                                                <div class="form-group">

                                                    <div class="table-responsive col-md-11" style="margin-left: 20px;">
                                                        <table class="table table-striped text-center"  style="font-size: 12px;">

                                                            <tbody>
                                                            <tr class="active">
                                                                <th style="text-align: center;">课程名</th>
                                                                <th>课程学习人数</th>
                                                                <th>课程完成人数</th>
                                                                <th>考试人数</th>
                                                                <th>作业人数</th>
                                                                <th>研讨人数</th>

                                                            </tr>
                                                            <c:forEach items="${trainPhase.courseDataViewList }" var="view">
                                                                <tr>
                                                                    <td><a data-toggle="modal" data-target="#modal"  href="javascript:">${view.title }
                                                                        <c:if test="${view.is_required==0 }">(必修)</c:if>
                                                                        <c:if test="${view.is_required==1 }">(选修)</c:if>
                                                                    </a></td>
                                                                    <td>${view.studentCount }</td>
                                                                    <td>${view.finishCount }</td>
                                                                    <td>${view.examCount }</td>
                                                                    <td>${view.homeworkCount }</td>
                                                                    <td>${view.discussCount }</td>

                                                                </tr>
                                                            </c:forEach>

                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>



                                    </c:forEach>
                                </c:if>
                            </c:if>

                            <c:if test="${classView.type==0 }">
                                <div class="table-responsive" >
                                    <table class="table table-striped" id="learning-data-table" style="word-break:break-all;text-align:center;font-size: 12px;">

                                        <tbody>
                                        <tr class="active">
                                            <th>课程名</th>
                                            <th>课程学习人数</th>
                                            <th>课程完成人数</th>
                                            <th>考试人数</th>
                                            <th>作业人数</th>
                                            <th>研讨人数</th>

                                        </tr>

                                        <tr>
                                            <td><a data-toggle="modal" data-target="#modal"  href="javascript:">${courseDataView.title }</a></td>
                                            <td>${courseDataView.studentCount }</td>
                                            <td>${courseDataView.finishCount }</td>
                                            <td>${courseDataView.examCount }</td>
                                            <td>${courseDataView.homeworkCount }</td>
                                            <td>${courseDataView.discussCount }</td>

                                        </tr>

                                        <tr class="active">
                                            <td width="35%">课时名</td>
                                            <td>课时学习人数</td>
                                            <td>课时完成人数</td>
                                            <td>考试合格率</td>
                                            <td>作业合格率</td>
                                            <td>研讨合格率</td>

                                        </tr>
                                        <c:forEach items="${courseDataViews }" var="view">
                                            <tr>
                                                <td><a   href="javascript:void(0);">${view.hour_title }
                                                    <c:if test="${view.attribute_type==0 }">（考试 }）</c:if>
                                                    <c:if test="${view.attribute_type==2 }">（视频）</c:if>
                                                    <c:if test="${view.attribute_type==3 }">（研讨）</c:if>
                                                    <c:if test="${view.attribute_type==4 }">（作业）</c:if>
                                                </a></td>
                                                <td>${view.studentHourCount}</td>
                                                <td>${view.finishHourCount}</td>
                                                <c:if test="${view.attribute_type==0 }">
                                                    <td>${view.examPer*100}%</td>
                                                </c:if>
                                                <c:if test="${view.attribute_type!=0 }">
                                                    <td>----</td>
                                                </c:if>
                                                <c:if test="${view.attribute_type==4 }">
                                                    <td>${view.homeworkPer*100}%</td>
                                                </c:if>
                                                <c:if test="${view.attribute_type!=4 }">
                                                    <td>----</td>
                                                </c:if>
                                                <c:if test="${view.attribute_type==3 }">
                                                    <td>${view.discussPer*100}%</td>
                                                </c:if>
                                                <c:if test="${view.attribute_type!=3 }">
                                                    <td>----</td>
                                                </c:if>

                                            </tr>
                                        </c:forEach>

                                        </tbody>
                                    </table>

                                </div>
                            </c:if>
                        </form>


                    </div>
                </div>

            </div>

        </div>
    </div>



</div>

<script>

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
