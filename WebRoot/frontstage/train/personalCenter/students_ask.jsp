<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>
<%--<link href="${pageContext.request.contextPath}/frontstage/css/my-space.css" rel="stylesheet" type="text/css">--%>
<link href="${pageContext.request.contextPath}/frontstage/css/teaching-center.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/my-space.js"></script>
<div class="cn-wrap">

	<div id="content-container" class="container">
		<jsp:include page="/frontstage/base/personalCenter/personal_header.jsp"></jsp:include>

		<div class="row row-3-9">

			<jsp:include page="/frontstage/base/personalCenter/personal_left.jsp"></jsp:include>

			<div class="col-md-9">
				<div class="panel panel-default panel-col">
                   <div class="panel-heading"><c:if test="${state==14}">学员</c:if><c:if test="${state==24}">我的</c:if>问答</div>
                     <div class="panel-body">

    	                  <form id="questionForm"
			                    <c:if test="${state==14}">action="${pageContext.request.contextPath}/topic_question/query_question.action"
    	                        </c:if>
    	                        <c:if test="${state==24}">
    	                         action="${pageContext.request.contextPath}/topic_question/user_question.action"
    	                        </c:if>
    	                        method="post">
			                    <input type="hidden" name="page" id="page" value="${topicQuestionView.page}"/>
			                    <input type="hidden" name="rows" id="rows" value="${topicQuestionView.rows}"/>
			                    <input type="hidden" name="total" id="total" value="${topicQuestionView.total}"/>
			                    <input type="hidden" name="totalPage" id="totalPage" value="${topicQuestionView.totalPage}"/>
			                    <input type="hidden" name="state" id="state" value="${state}"/>
			                    <input type="hidden" name="stamp" id="stamp" value="${stamp}"/>
	                      </form>

                         <ul class="media-list">
                       	<c:forEach items="${questionList}" var="question">
                                <li class="media" style="padding-bottom: 0;">
									<div class="media-body">
                                        <span class="badge pull-right">${question.answerNum }</span>
										<div class="mbm">
                                           <label class="label label-info">问</label>
                                            <c:if test="${question.source_type==0 }">
                                           <a href="${pageContext.request.contextPath}/user_study/to_course_study.action?page=1&learnId=${question.courseId}&sourceType=0&tab=7&is_direct=0&questionId=${question.questionId}" class="question_title">${question.querstionName}</a>
											</c:if>
											<c:if test="${question.source_type==1 }">
                                          <a href="${pageContext.request.contextPath}/train/to_train_detail.action?id=${question.trainId}&sign=6&questionId=${question.questionId}" class="question_title">${question.querstionName}</a>
											</c:if>
											<c:if test="${question.source_type==2 }">
                                           <a href="${pageContext.request.contextPath}/community/to_community_index.action?sourceType=0&classifyId=-1&stamp=6&id=${question.communityId}&sign=6&questionId=${question.questionId}" class="question_title">${question.querstionName}</a>
											</c:if>
											<c:if test="${question.source_type==3 }">
                                           <a href="${pageContext.request.contextPath}/community/to_community_index.action?sourceType=0&classifyId=-1&stamp=6&id=${question.workshopId}&sign=6&questionId=${question.questionId}" class="question_title">${question.querstionName}</a>
											</c:if>
										</div>
                                        <div class="text-muted text-normal">
									    <span>
									    <c:if test="${question.source_type==0 }">
									    发表于课程<a href="${pageContext.request.contextPath}/user_study/to_course_study.action?page=1&learnId=${question.courseId}&sourceType=0&tab=1&is_direct=0" class="link-muted">${question.courseName}</a>
									    </c:if>
									      <c:if test="${question.source_type==1 }">
									    发表于培训<a href="#" class="link-muted">${question.trainName}</a>
									    </c:if>
									      <c:if test="${question.source_type==2 }">
									    发表于社区<a href="#" class="link-muted">${question.communityName}</a>
									    </c:if>
									      <c:if test="${question.source_type==3 }">
									    发表于工作坊<a href="#" class="link-muted">${question.workshopName}</a>
									    </c:if>
									    </span>
                                           <c:if test="${!empty question.teacherName}">
									           <span class="bullet">•</span>
											   <span>最后回复
                                                  <a class="link-light link-muted" href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id=${question.teacherId}">${question.teacherName}</a>
                                               </span>,
	                                          <c:if test="${empty question.dayNum}">0</c:if>
											   <c:if test="${!empty question.dayNum}">${question.dayNum}天前</c:if>
											   <span> ${question.browseNum }浏览</span>
                                           </c:if>
								        </div>
									</div>
                                </li>
       	               </c:forEach>
                       </ul>
                     </div>
					<c:if test="${empty questionList }">
						<div class="empty">暂无数据</div>
					</c:if>
					<c:if test="${!empty questionList }">
						<div id="test" class="pager"></div>
					</c:if>
				</div>
			</div>

        </div>
    </div>

	<jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>

</div>
<script type="text/javascript">
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
      		$('#questionForm').submit();

          }
      });
  });
</script>

