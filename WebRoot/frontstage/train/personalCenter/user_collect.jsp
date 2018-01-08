<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>




<div class="cn-wrap">


    <div id="content-container" class="container">
        <jsp:include page="/frontstage/base/personalCenter/personal_header.jsp"></jsp:include>


        <div class="row row-3-9">

            <jsp:include page="/frontstage/base/personalCenter/personal_left.jsp"></jsp:include>

            <div class="col-md-9">

                <form id="userCollectForm" action="${pageContext.request.contextPath}/user_collect/to_user_collect.action" method="post">
                    <input type="hidden" name="page" id="page" value="${userCollectView.page}"/>
                    <input type="hidden" name="rows" id="rows" value="${userCollectView.rows}"/>
                    <input type="hidden" name="total" id="total" value="${userCollectView.total}"/>
                    <input type="hidden" name="totalPage" id="totalPage" value="${userCollectView.totalPage}"/>
                    <input type="hidden" name="state" id="state" value="${state}"/>
                    <input type="hidden" name="stamp" id="stamp" value="${stamp}"/>
                    <input type="hidden" name="source_type" id="source_type" value="${userCollectView.source_type}"/>
                </form>

                <div class="panel panel-default panel-col">
                    <div class="panel-heading">我的收藏</div>
                    <div class="panel-body">
                        <ul class="nav nav-pills">
                            <li class="<c:if test="${userCollectView.source_type==0 }"> active </c:if>">
                                <a href="javascript:void(0);" onclick="doSearch(0);">课程</a>
                            </li>
                            <li class="<c:if test="${userCollectView.source_type==1}">active</c:if>">
                                <a href="javascript:void(0);" onclick="doSearch(1);">培训</a>
                            </li>
                            <li class="<c:if test="${userCollectView.source_type==2}">active</c:if>">
                                <a href="javascript:void(0);" onclick="doSearch(2);">课例</a>
                            </li>
                        </ul>
                    </div>
                    <div class="course-list">
                        <div class="row">
                            <c:if test="${userCollectView.source_type!=2}">

                                <c:forEach items="${userCollectList}" var="userCollect">
                                    <div class="col-md-4 ">
                                        <div class="course-item">
                                            <div class="course-img">
                                                <a class="grid-body" 
                                                	<c:choose>
                                                		<c:when test="${userCollectView.source_type==0 }">
                                                			href="${pageContext.request.contextPath}/user_study/to_course_study.action?page=1&learnId=${userCollect.id }&sourceType=0&tab=1&is_direct=0"
                                                		</c:when>
                                                		<c:when test="${userCollectView.source_type==1 }">
                                                			href="${pageContext.request.contextPath}/train/to_train_detail.action?id=${userCollect.id }&sign=0"
                                                		</c:when>
                                                	</c:choose>
                                                	>
                                                    <img  src="${pageContext.request.contextPath}${userCollect.img }" class="img-responsive"  style="height: 160px;">
                                                </a>
                                            </div>
                                            <div class="course-info">

                                                <div class="title">
                                                    <a class="link-dark" href="javascript:void(0);" >${userCollect.title }</a>
                                                    <div class="teacher_info" style="padding: 5px 0;">
                                                        <span class="teacher_name pull-left" ><c:if test="${userCollectView.source_type==1}">主办方&nbsp;:&nbsp;</c:if>${userCollect.userName }</span>
                                                        <span class="teacher_address pull-right" >${userCollect.school }</span>
                                                    </div>
                                                </div>

                                                <div class="metas clearfix">
                                                    <span class="num">
                                                        <i class="es-icon es-icon-people"></i>${userCollect.studentNum }人参加
                                                    </span>

                                                    <span class="course-price-widget">
                                                        <c:choose>
                                                        	<%--免费--%>
                                                        	<c:when test="${empty userCollect.price || userCollect.price==0 }">
                                                        		<span class="text-success">免费</span>
                                                            </c:when>
                                                            <%--非免费--%>
                                                            <c:otherwise>
                                                            	<span class="price">${userCollect.price }元</span>
                                                            </c:otherwise>
                                                         </c:choose>
                                                    </span>

                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>

                            </c:if>

                            <c:if test="${userCollectView.source_type==2}">

                                <c:forEach items="${lessonList}" var="lesson">
                                    <div class="col-md-4">
                                        <div class="course-item">
                                            <div class="course-img">

                                                <a class="grid-body" href="${pageContext.request.contextPath}/lesson/to_lesson_plan.action?lesson_id=${lesson.id}&show=1&stamp=0&state=101" target="_blank">

                                                    <img class="img-responsive " style="height:160px;"
                                                         <c:if test="${empty lesson.lesson_pic}">src="${pageContext.request.contextPath}/frontstage/images/course.png"</c:if> <c:if test="${!empty lesson.lesson_pic}">src="${pageContext.request.contextPath}${lesson.lesson_pic}"</c:if>>
                                                    <c:if test="${lesson.excellent==1}">
                                                        <div class="tags" style="left: 0;top:0;position: absolute;">
                                                            <img src="${pageContext.request.contextPath}/frontstage/images/excellent_teaching_plan.png" title="优秀课例">
                                                        </div>
                                                    </c:if>
                                                </a>
                                                <div class="course-info" style="padding: 10px;">

                                                    <div class="lesson_info_text">
                                                        <span class="lesson_grade"><c:if test="${empty lesson.stageName }">&nbsp;</c:if>
                                                                ${lesson.stageName }${lesson.subjectName }</span>
                                                        <span class="lesson_teacher pull-right">
                                    					<c:if test="${empty lesson.user_sk_name }">&nbsp;</c:if>
                                    					<c:if test="${!empty lesson.user_sk_name }">主讲老师:&nbsp;${lesson.user_sk_name }
                                                        </c:if>
                                    					</span>
                                                    </div>

                                                    <a class="link-dark" style="line-height: 30px;">
                                                        <span class="pull-left">${lesson.name }</span>

                                                        <span class="pull-right">工作坊&nbsp; ${lesson.workshop_name }</span>
                                                    </a>

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
                                                    </div>

                                                    <div class="action text-center" id="${lesson.id }">
                                                        <span class="btn btn-primary btn-sm">进入课例</span>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>

                            </c:if>
                            <c:if test="${empty userCollectList }">
                                <div class="empty">暂无数据</div>
                            </c:if>
                        </div>
                        <div id="test" class="pager" ></div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
<jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>

<script type="text/javascript">

    function doSearch(value){
        $("#page").val(0);
        $("#source_type").val(value);
        $("#userCollectForm").submit();
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
            pageSize: $("#rows").val(),           //一页记录数
            onPageChange: function (page) {
                document.title = page;
                $("#page").val(page-1);
                $('#userCollectForm').submit();

            }
        });
    });
</script>


