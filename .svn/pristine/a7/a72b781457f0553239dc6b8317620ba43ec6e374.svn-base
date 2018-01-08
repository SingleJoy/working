<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<div class="cn-wrap" >

    <div id="content-container" class="container">

        <jsp:include page="/frontstage/xbjy/lesson/lesson_header.jsp"></jsp:include>

        <div class="course-detail row" style="margin-top: 20px;">

            <jsp:include page="/frontstage/xbjy/lesson/lesson_left.jsp"></jsp:include>

            <div class="col-lg-9 col-md-8  course-detail-main">
            	<c:if test="${lessonHead.accomplishedTotal<lessonHead.taskTotal-1}">
                    <div class="panel panel-default panel-col ">
                        <div class="panel-heading">自我总结</div>
                        <div class="panel-body" style="text-align: center;">
                            <img src="${pageContext.request.contextPath}/frontstage/images/lesson_task_unfinshed.png" style="margin: 20px auto;">
                            <div>前面有未完成任务，不可总结</div>
                        </div>
                    </div>
                    
                </c:if>
                <c:if test="${lessonHead.accomplishedTotal>=lessonHead.taskTotal-1}">

                <div class="panel panel-default panel-col course-data">
                    <div class="panel-heading">小组总结

                    </div>
                    <div class="panel-body">


                        <form id="saveLessonSelf" method="post" action="${pageContext.request.contextPath}/lesson/save_lesson_self.action" novalidate="novalidate" class="form-horizontal">
                            <input type="hidden" value="${lesson.id}" name="lesson_id">

                            <div class="form-group controls">
                                <div class="col-md-10 controls col-md-offset-1">
                                    <textarea id="self_evaluation" name="self_evaluation" class="form-control" rows="8"  placeholder="[经过全组成员的努力，本次课例研究任务终于完成了，在这个过程中你们的小组一定收获了很多经验与不足，请组长针对本次课例的研修过程，发表本小组的自评总结，请记录在这里:]">${lesson.self_evaluation}</textarea>

                                    <div class="help-block" style="display:none;"></div>
                                </div>
                            </div>

                            <div class="form-group controls">
                                <div class="col-md-2 controls col-md-offset-1">
                                	<button type="button"  class="btn btn-info js-btn-save" onclick="doSumbit();">保存</button>
                                </div>
                            </div>

                        </form>

                </div>
            </div>
            </c:if>
            </div>

        </div>
    </div>


    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>

</div>

<script type="text/javascript">
    function doSumbit(){
            document.getElementById('saveLessonSelf').submit();
    }
</script>
