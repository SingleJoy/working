<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<div class="cn-wrap">

    <div id="content-container" class="container">
        <jsp:include page="/frontstage/base/personalCenter/personal_header.jsp"></jsp:include>

        <div class="row row-3-9">

            <jsp:include page="/frontstage/base/personalCenter/personal_left.jsp"></jsp:include>

            <div class="col-md-9">

                <form id="userStudyForm" action="${pageContext.request.contextPath}/user_study/to_user_study.action" method="post">
                    <input type="hidden" name="page" id="page" value="${studyView.page}"/>
                    <input type="hidden" name="rows" id="rows" value="${studyView.rows}"/>
                    <input type="hidden" name="total" id="total" value="${studyView.total}"/>
                    <input type="hidden" name="totalPage" id="totalPage" value="${studyView.totalPage}"/>
                    <input type="hidden" name="state" id="state" value="${state}"/>
                    <input type="hidden" name="stamp" id="stamp" value="${stamp}"/>
                    <input type="hidden" name="is_studyed" id="is_studyed" value="${studyView.is_studyed}"/>
                    <input type="hidden" name="source_type" id="source_type" value="${studyView.source_type}"/>
                    <input type="hidden" name="sortEndTime" id="sortEndTime" value="${studyView.sortEndTime}"/>
                </form>

                <div class="panel panel-default panel-col">

                    <div class="panel-heading">
                        我的<c:if test="${studyView.source_type==0}">课程</c:if><c:if test="${studyView.source_type==1}">培训</c:if>
                    </div>
                    <div class="panel-body">
                        <ul class="nav nav-pills">
                            <li class="<c:if test="${studyView.is_studyed==0 }"> active </c:if>">
                                <a href="javascript:void(0);" onclick="doSearch(0);">学习中</a>
                            </li>
                            <li class="<c:if test="${studyView.is_studyed==1}">active</c:if>">
                                <a href="javascript:void(0);" onclick="doSearch(1);">已结束</a>
                            </li>
                        </ul>
                        <div class="filter hidden-xs pull-right">

                            <label class="checkbox-inline hidden-xs">
                                <input type="checkbox" onclick="sortCourse()" name="sort_endtime_course" <c:if test="${studyView.sortEndTime==1}">checked="checked"</c:if>> 按结束时间排序
                            </label>
                        </div>


                        <div class="course_learning course_type_tabs course-list">

                            <div class="row" style="margin-top: 30px;">
                                <c:forEach items="${userStudyList}" var="userStudy">
                                    <div class="col-md-4">
                                        <div class="course-item">
                                            <div class="course-img">
                                                <c:choose>
                                                    <c:when test="${studyView.source_type==0&&(studyView.is_studyed==0||studyView.is_studyed==1)}">
                                                        <a class="grid-body" href="${pageContext.request.contextPath}/user_study/to_course_study.action?page=1&learnId=${userStudy.id }&sourceType=0&tab=1&is_direct=0" target="_blank">
                                                            <img src="${pageContext.request.contextPath}${userStudy.img }" class="img-responsive" style="height:160px;"/>
                                                        </a>
                                                    </c:when>

                                                    <c:when test="${studyView.source_type==1&&(studyView.is_studyed==0||studyView.is_studyed==1)}">
                                                        <a class="grid-body" href="${pageContext.request.contextPath}/train/to_train_detail.action?id=${userStudy.id}&sign=0" target="_blank">
                                                            <img src="${pageContext.request.contextPath}${userStudy.img }" class="img-responsive" style="height:160px;"/>
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>

                                                        <a class="grid-body" href="javascript:void(0)">
                                                            <img src="${pageContext.request.contextPath}${userStudy.img }" class="img-responsive" style="height:160px;"/>
                                                        </a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>

                                            <div class="course-info">
                                                <div class="title" style="font-weight: normal;">${userStudy.name }</div>

                                                <c:if test="${studyView.source_type==0 }">
                                                    <div style="padding: 5px 10px;">
                                                        <span class="pull-left">结束时间:<fmt:formatDate type="date" dateStyle="medium" value="${userStudy.end_time }"/></span>
                                                        <span class="pull-right">学时:${userStudy.hours }</span>
                                                    </div>
                                                </c:if>
                                                <div  style="clear: both;padding: 10px;">
                                                    <div class="learn-status">
                                                        <c:if test="${studyView.is_studyed==0}">
                                                            <c:choose>
                                                                <c:when test="${studyView.source_type==0 }">
                                                                    <div class="progress">
                                                                        <div class="progress-bar progress-bar-success" style="height: 20px;width:${userStudy.studyNum/userStudy.allNum*100 }%;"	>
                                                                                ${userStudy.studyNum }/${userStudy.allNum }课时
                                                                        </div>
                                                                    </div>
                                                                </c:when>
                                                                <c:when test="${studyView.source_type==1&&userStudy.type==0 }">
                                                                    <div>
                                                                        <span>必修课：${userStudy.finishReqHour }/${userStudy.allNum }</span>
                                                                        <span>选修课：
                                                   					<c:choose>
                                                                        <c:when test="${userStudy.finishReqHour>=userStudy.allNum }">
                                                                            0/${userStudy.allNum }
                                                                        </c:when>
                                                                        <c:when test="${userStudy.finishReqHour<userStudy.allNum }">
                                                                            <c:choose>
                                                                                <c:when test="${userStudy.allNum-(userStudy.finishReqHour+userStudy.finishOptHour)<=0 }">
                                                                                    ${userStudy.allNum-userStudy.finishReqHour }/${userStudy.allNum }
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    ${userStudy.finishOptHour }/${userStudy.allNum }
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </c:when>
                                                                    </c:choose>
                                                   				</span>
                                                                    </div>
                                                                </c:when>
                                                                <c:when test="${studyView.source_type==1&&userStudy.type==1 }">
                                                                    <div>
                                                                        <span>阶段：${userStudy.studyNum }/${userStudy.allNum }</span>
                                                                    </div>
                                                                </c:when>
                                                            </c:choose>
                                                        </c:if>
                                                        <c:if test="${studyView.source_type==1 }">

                                                            结束时间:<fmt:formatDate type="date" dateStyle="medium" value="${userStudy.end_time }"/>

                                                        </c:if>

                                                        <c:if test="${studyView.source_type==0 }">

                                                            <c:if test="${studyView.is_studyed==1 }">
                                                                <span  class="pull-left">成绩:${userStudy.score }</span>
                                                                <c:if test="${!empty userStudy.cert_name }">
                                                                    <span class="pull-right" style="text-overflow:ellipsis;white-space: nowrap;max-width: 90px;overflow: hidden;" title="${userStudy.cert_name }">
                                                                            ${userStudy.cert_name }
                                                                    </span>

                                                                </c:if>

                                                            </c:if>
                                                        </c:if>
                                                        <div class="learn-status text-center" style="margin-top:20px;clear: both;">
                                                            <c:if test="${studyView.is_studyed==0}">
                                                                <div class="action" id="${userStudy.id }">
                                                                    <a class="grid-body" href="
                                                            <c:choose>
                                                            	<c:when test="${studyView.source_type==0 }">
                                                            		${pageContext.request.contextPath}/user_study/to_course_study.action?page=1&learnId=${userStudy.id }&sourceType=0&tab=1&is_direct=0
                                                            	</c:when>
                                                            	<c:when test="${studyView.source_type==1 }">
                                                            		${pageContext.request.contextPath}/train/to_train_detail.action?id=${userStudy.id}&sign=0
                                                            	</c:when>
                                                            </c:choose>" target="_blank">
                                                                        <span class="btn btn-primary btn-sm">继续学习</span>
                                                                    </a>
                                                                </div>
                                                            </c:if>
                                                            <c:if test="${studyView.is_studyed==1}">
                                                                <div class="action text-center" style="padding-top: 10px;">
                                                                    <c:choose>
                                                                        <c:when test="${!empty userStudy.cert_id }">
                                                                            <a href="${pageContext.request.contextPath }/user_certificate/to_my_cert_detail.action?cert_id=${userStudy.cert_id }&user_id=${studyView.user_id }" target="_blank">
                                                                       <span class="btn btn-primary btn-sm" id="${userStudy.id }">
                                                                                                                                                                                                                                 查看证书
                                                                       </span>
                                                                            </a>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <button class="btn btn-warning btn-sm" id="${userStudy.id }" type="button">
                                                                                未获得证书
                                                                            </button>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>

                                        </div>
                                    </div>
                                </c:forEach>

                            </div>
                        </div>
                        <div id="test" class="pager" ></div>
                        <c:if test="${empty userStudyList }">
                            <div class="empty">暂无数据</div>
                        </c:if>

                    </div>
                </div>
            </div>
        </div>

    </div>

    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>

</div>
<script type="text/javascript">

    function doSearch(value){
        $("#page").val(0);
        $("#is_studyed").val(value);
        $("#userStudyForm").submit();
    }

    function sortCourse(){
        $("#page").val(0);
        if($("input[ name = 'sort_endtime_course']").prop("checked")){
            $("#sortEndTime").val(1);
        }else{
            $("#sortEndTime").val(0);
        }
        $("#userStudyForm").submit();
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
                $('#userStudyForm').submit();

            }
        });
    });
</script>


