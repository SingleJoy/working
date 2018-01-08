<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>
<link href="${pageContext.request.contextPath}/frontstage/css/xbjy.css" rel="stylesheet" type="text/css">

<div class="cn-wrap">

    <div id="content-container" class="container">
        <jsp:include page="/frontstage/base/personalCenter/personal_header.jsp"></jsp:include>

        <div class="row row-3-9">

            <jsp:include page="/frontstage/base/personalCenter/personal_left.jsp"></jsp:include>

            <div class="col-md-9">

                <form id="lessonForm" action="${pageContext.request.contextPath}/lesson/to_my_lesson.action" method="post">
                    <input type="hidden" name="stamp" id="stamp" value="${stamp}"/>
                    <input type="hidden" name="state" id="state" value="${state}"/>
                    <input type="hidden" name="page" id="page" value="${lessonView.page}"/>
                    <input type="hidden" name="status" id="status" value="${lessonView.status}"/>
                    <input type="hidden" name="rows" id="rows" value="${lessonView.rows}"/>
                    <input type="hidden" name="total" id="total" value="${lessonView.total}"/>
                    <input type="hidden" name="totalPage" id="totalPage" value="${lessonView.totalPage}"/>
                    <input type="hidden" name="identity" id="identity" value="${lessonView.identity}"/>
                </form>

                <div class="panel panel-default panel-col lesson-manage-panel">

                    <div class="panel-heading">
                        我的课例
                    </div>

                    <div class="panel-body">


                        <form class="form-horizontal">
                            <div class="form-group col-md-5" >
                                <ul class="nav nav-pills ">
                                    <li <c:if test="${lessonView.identity==0}"> class="active"</c:if>>
                                        <a href="javascript:void(0);" onclick="identity(0)">我是组长</a>
                                    </li>
                                    <li <c:if test="${lessonView.identity==3}"> class="active"</c:if>>
                                        <a href="javascript:void(0);" onclick="identity(3)">我是组员</a>
                                    </li>
                                    <li <c:if test="${lessonView.identity==2}"> class="active"</c:if>>
                                        <a href="javascript:void(0);" onclick="identity(2)">我是指导教师</a>
                                    </li>
                                </ul>
                            </div>
                            <div class="form-group col-md-2" >

                                <select class="form-control width-input " onchange="status(this.value)" name="select">
                                    <%--默认未完成--%>
                                    <option value="-1"  <c:if test="${lessonView.status==-1}">selected="selected"</c:if>>--请选择完成状态--</option>
                                    <option value="1" <c:if test="${lessonView.status==1}">selected="selected"</c:if>>未完成</option>
                                    <option value="0" <c:if test="${lessonView.status==0}">selected="selected"</c:if>>未开始</option>
                                    <option value="2" <c:if test="${lessonView.status==2}">selected="selected"</c:if>>已完成</option>
                                </select>

                            </div>

                        </form>


                        <div class="course_learning course_type_tabs" style="clear: both;">
                            <ul class="course-grids">
                                <c:if test="${!empty lessonList }">
                                    <c:forEach items="${lessonList}" var="lesson">
                                        <li class="course-grid">
                                        <c:if test="${lesson.identity==0 }">
                                        <c:set var="stamp0" value="&stamp=1"></c:set>
                                        </c:if>
                                        <c:if test="${lesson.identity!=0 }">
                                        <c:set var="stamp0" value="&show=1&stamp=0"></c:set>
                                        </c:if>
                                            <a class="grid-body" href="${pageContext.request.contextPath}/lesson/to_lesson_plan.action?lesson_id=${lesson.id}${stamp0 }&state=101" target="_blank">
                                                <img class="img-responsive thumb" style="height:141px;width: 100%;"
                                                       <c:if test="${!empty lesson.lesson_pic}">src="${pageContext.request.contextPath}${lesson.lesson_pic}"</c:if>>
                                                <c:if test="${lesson.excellent==1}">
                                                    <span class="good_lesson" style="position: absolute;margin-top: -141px;margin-left: 214px;">
                                                        &nbsp;&nbsp;优
                                                    </span>
                                                </c:if>
                                                <span class="title" style="font-weight: normal;">${lesson.name }</span>
                                                <span class="title" style="font-weight: normal;">完成任务/总数：${lesson.finish_count} /${lesson.all_count}
                                                    <span class="pull-right">${lesson.workshop_name }</span>
                                                </span>

                                                <div class="learn-status">
                                                    <div class="progress" style="width: 240px;height: 18px;">
                                                        <c:if test="${lesson.finish_count/lesson.all_count>=0.08 }">
                                                            <c:set var="width" value="${lesson.finish_count/lesson.all_count}"></c:set>
                                                        </c:if>
                                                        <c:if test="${lesson.finish_count/lesson.all_count<0.08 }">
                                                            <c:set var="width" value="0.08"></c:set>
                                                        </c:if>
                                                        <div class="progress-bar progress-bar-success"  role="progressbar" aria-valuenow="20" aria-valuemin="0"
                                                             aria-valuemax="100" style="width:<fmt:formatNumber type="percent" maxFractionDigits="3" value="${width }" />">
                                                            <fmt:formatNumber type="percent" maxFractionDigits="0" value="${lesson.finish_count/lesson.all_count }" /></div>
                                                    </div>
                                                    <div class="action" id="${lesson.id }">
                                                        <span class="btn btn-primary btn-sm">进入课例</span>
                                                    </div>
                                                </div>
                                            </a>
                                        </li>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${empty lessonList }">

                                    <div class="empty">还没有任何课例数据哦！请前往社区或者工作坊新建课例！</div>
                                </c:if>
                            </ul>
                        </div>
                        <div id="test" class="pager" ></div>
                    </div>


                </div>

            </div>

        </div>
    </div>

    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
</div>




<script type="text/javascript">

    function doSearch(value) {
        $("#page").val(0);
        $("#status").val(value);
        $("#lessonForm").submit();
    }
    $(function() {
        //翻页
        var total = $("#total").val();
        var page = parseInt($("#page").val()) + 1;

        $("#btn5").on('click', function() {
            $("#div1").PageChanged(5);
        });

        $(".pager").pagination({
            thisPageIndex : page,
            recordCount : total, //总记录数
            pageSize : $("#rows").val(), //一页记录数
            onPageChange : function(page) {
                document.title = page;
                $("#page").val(page - 1);
                $('#lessonForm').submit();

            }
        });
    });

    function toCourseDetail(value) {
        //        window.location.href="${pageContext.request.contextPath}/user_study/to_course_study.action?page=1&learnId="+value+"&sourceType=0&tab=1";
    }
    function identity(val) {
        $("#identity").val(val);
        $("#page").val(0);
        $('#lessonForm').submit();
    }
    function status(val) {
        $("#status").val(val);
        $("#page").val(0);
        $('#lessonForm').submit();
    }
</script>
