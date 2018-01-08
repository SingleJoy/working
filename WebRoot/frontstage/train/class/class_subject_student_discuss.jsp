<%@ page language="java" import="java.util.*,cn.bnsr.edu_yun.frontstage.base.po.User" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% User user = (User)request.getSession().getAttribute("currentUser");%>

<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>
<div class="cn-wrap">

   <div id="content-container" class="container">
    <jsp:include page="class_header.jsp"></jsp:include>
        <div class="row">
            <jsp:include page="class_left.jsp"></jsp:include>
            <div class="col-md-9">

                <div class="panel panel-default panel-col course-data">
                    <div class="panel-heading">${courseHour.hour_title}
                       <c:if test="${classView.source_type==0 }">
                        <a href="${pageContext.request.contextPath}/class/to_class_theme_discuss.action?id=${classView.id}&flag=2&sign=6&source_id=${classView.source_id}&source_type=${classView.source_type}" class="btn btn-default pull-right">返回</a>
                       </c:if>
                       <c:if test="${classView.source_type==1 }">
                        <a href="${pageContext.request.contextPath}/class/course_discuss.action?required=${required}&id=${classView.id}&class_id=${classView.class_id}&flag=2&sign=6&source_id=${classView.courseId}&source_type=${classView.source_type}" class="btn btn-default pull-right">返回</a>
                       </c:if>
                    </div>
                    <div class="panel-body">
                        <h4 style="margin-left: 20px;margin-bottom: 30px;">${courseHour.remarks}</h4>
                        <form id="discussForm" class="form-inline well well-sm " action="${pageContext.request.contextPath}/class/to_class_subject_student_discuss.action?required=${required}&class_id=${classView.class_id}&courseId=${classView.courseId}&id=${classView.id}&source_id=${classView.source_id}&source_type=${classView.source_type}&course_hour_id=${userDiscussView.course_hour_id}" method="post" >
                            <div class="form-group col-md-7">
								<input type="hidden" name="page" id="page" value="${userDiscussView.page}" /> 
								<input type="hidden" name="rows" id="rows" value="${userDiscussView.rows}" />
								<input type="hidden" name="total" id="total" value="${userDiscussView.total}" />
							    <input type="hidden" name="totalPage" id="totalPage" value="${userDiscussView.totalPage}" />
                                <input class="form-control " style="width:45%" type="text" id="student_" name="search_info" placeholder="请输入用户名"  value="${search_info}">
                                <button class="btn btn-primary">搜索</button>
                            </div>
                            <div class="clearfix"></div>
                        </form>
                        <c:forEach items="${discussList}" var="discuss">
                        <div class="js-reviews">
                            <div class="media media-evaluate">
                                <div class="media-left">
                                    <a class=" js-user-card" href="javascript:void(0);">
                                        <img class="avatar-sm" src="${pageContext.request.contextPath}${discuss.icon}">
                                    </a>
                                </div>
                                <div class="media-body thread-post">
                                    <div class="title">
                                        <a class="link-dark " href="javascript:void(0);">${discuss.username}</a>
                                        &nbsp;&nbsp;${discuss.discuss_time}
                                    </div>
                                    <div class="content">
                                        <div class="full-content">${discuss.discuss_content}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        </c:forEach>
                        <c:if test="${empty discussList}"><div class="empty" >还没有学生参与研讨</div></c:if>
                        <c:if test="${!empty discussList }"><div id="test" class="pager" style="clear: both;"></div></c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
</div>

<script type="text/javascript">
function doSumbit(){
	document.getElementById('class_service').submit();
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
				$('#discussForm').submit();

			}
		});
	});
</script>


