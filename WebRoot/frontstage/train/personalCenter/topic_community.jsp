<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!--我发起的话题-->
<div class="my-group">
    <h5 style="margin: 10px 0 20px 0;">我发起的话题:
        <a href="#">
            <span class="pull-right  num num_num" >${topicQuestionViews.size() }</span>

        </a>
    </h5>

    <ul class="course-wide-list">
        <c:forEach items="${topicQuestionViews }" var="question">
            <li class="course-item clearfix">
                <a class="course-picture-link" href="javascript:void(0);" target="_blank">
                    <img class="course-picture" src="http://edusoho-demo.b0.upaiyun.com/files/default/2015/06-10/155158e4340f775236.jpg" style="width: 80px;height:80px;margin: 10px;">
                </a>
                <div class="course-body" style="margin-left: 110px;">
                    <div style="float:right;" class="text-muted mrm mls">
                        <div>
                            <i class="es-icon es-icon-people"></i>
                            <span style="margin-left: 10px;">参与人数:${question.answerNum }</span>
                        </div>
                    </div>
                    <h4 class="mbl"><a href="#" target="_blank">${question.querstionName }</a></h4>

                    <div class="course-footer clearfix mtl">
                        发起人: ${question.teacherName } &nbsp;&nbsp;
                        发起时间 <fmt:formatDate type="date"
                                             value="${question.question_time }" /> &nbsp;&nbsp;
                    </div>
                    <div class="pull-right topic_operation" style="margin-top: -50px;margin-right: 20px;" >
                        <c:if test="${question.is_delete==0}">
                            <a href="javascript:void(0);" class="btn btn-danger btn-sm" onclick="openOrClose(${question.questionId})">关闭话题</a>
                            <img src="${pageContext.request.contextPath}/frontstage/images/close.png" style="display: none;">
                        </c:if>
                        <c:if test="${question.is_delete==1}">
                            <img src="${pageContext.request.contextPath}/frontstage/images/close.png" >
                        </c:if>

                    </div>

                </div>
            </li>
        </c:forEach>

    </ul>

    <a class="pull-right more_data" href="javascript:void(0);" onclick="doMore();">更多 ></a>

    <h5 style="margin:70px 0 20px 0;">我回复的话题:
        <a href="#">
            <span class="pull-right  num num_num" >${topicAnswerCount }</span>

        </a>
    </h5>
    <div class="my_topic_list">
<c:forEach items="${topicAnswerViews }" var="answer">
        <div class="js-reviews">
            <div class="media media-evaluate">
                <div class="media-left">
                    <a class=" js-user-card" href="#">
                        <img class="avatar-sm" src="${pageContext.request.contextPath}${answer.icon }">
                    </a>

                </div>
                <div class="media-body thread-post">
                    <div class="title">
                        <a class="link-dark" href="#">
                            <span class="text-danger">${answer.username }:</span>
                            <span style="padding: 0 3px;opacity: 0.8;">${answer.question_content }</span>
                        </a>
                        <br/>

                        <div style="padding-top: 15px;">发起日期:&nbsp;&nbsp;<fmt:formatDate type="date"
                                             value="${answer.question_time }" /></div>
                    </div>

                    <div class="content" style="background-color:#f9f9f9;">
                        <div class="full-content" style="padding: 5px;">
                            <span class="text-danger">我的回复:&nbsp;&nbsp;&nbsp;&nbsp;</span>
                            ${answer.answer_content }

                        </div>
                        <div style="padding: 5px;opacity: 0.8;">回复时间:&nbsp;&nbsp;<fmt:formatDate type="date"
                                             value="${answer.answer_time }" />
                           
                        </div>
                    </div>

                </div>
            </div>
        </div>
</c:forEach>
    </div>
    <c:if test="${topicAnswerCount>3}">
    <a class="pull-right more_data" id="more_answer">更多 ></a>
</c:if>
</div>

<script type="text/javascript">
 var page=0;
 var count=3;
   $("#more_answer").click(function() {
   var topicAnswerCount='${topicAnswerCount}';
	page++;
	 $.ajax({
            type: 'POST',
            url : '${pageContext.request.contextPath}/topic_question/more_answer.action',
            dataType: "json",
            data:{
            page:page,
            source_type:'${topicAnswerView.source_type}',
            },
            success : function(response) {
            	count+=3;
            	if(count>=topicAnswerCount){
            	$("#more_answer").remove();
            	}
                $(".my_topic_list").append(response.html);
              
            }
        });
});
   
    function doClose(value){
        window.location.href="${pageContext.request.contextPath}/community/save_community.action?stamp=0&state=0&sign=2&flag=0&id="+value;
    }

</script>