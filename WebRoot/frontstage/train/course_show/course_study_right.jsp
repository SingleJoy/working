<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<div class="col-lg-3 col-md-4  course-sidebar">

	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">
				课程老师
			</h3>
		</div>

		<div class="panel-body">
			<div id="myCarousel1" class="carousel slide" data-interval="3000">

				<ol class="carousel-indicators">
					<c:forEach items="${classTeacherList }" varStatus="vsta">
						<li style="display: none;" data-target="#myCarousel1" data-slide-to="${vsta.index }"<c:if test="${vsta.index==0 }"> class="active"</c:if>></li>
					</c:forEach>
				</ol>

				<div class="carousel-inner">
					<c:choose>
						<c:when test="${!empty classList}">
							<c:forEach items="${classTeacherList }" var="class_tearcher" varStatus="vsta">
								<div class="item<c:if test="${vsta.index==0 }"> active</c:if>">
									<div class="panel">
										<div class="panel-body " style="margin-top: 20px;">
											<div class="media media-default">
												<div class="media-left">
													<a id="userCard_1${class_tearcher.userId }" onmouseover="mouseOver(1,${class_tearcher.userId });" onmouseout="mouseOut(1,${class_tearcher.userId });" href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id=${class_tearcher.userId }">
														<img class="avatar-md" src="${pageContext.request.contextPath}${class_tearcher.icon }">
													</a>
												</div>
												<div class="media-body">
													<div class="title">
														<a class="link-dark link-light" href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id=${class_tearcher.userId }">${class_tearcher.teacherName }</a>
													</div>
														<%--<div class="content">${t_user.username }</div>--%>
													<div class="content">
														<c:choose>
															<c:when test="${class_tearcher.type==0}">
																教师
															</c:when>
															<c:when test="${class_tearcher.type==1}">
																助教
															</c:when>
															<c:when test="${class_tearcher.type==2}">
																班主任
															</c:when>
														</c:choose>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<div class="empty">暂无课程老师信息</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>

			<!-- 轮播（Carousel）导航 -->
			<c:if test="${!empty classTeacherList }">
				<a class="carousel-control left" href="#myCarousel1" data-slide="prev" style="background-image: none;color: #616161">&lsaquo;</a>
				<a class="carousel-control right" href="#myCarousel1" data-slide="next" style="background-image: none;color: #616161">&rsaquo;</a>
			</c:if>

		</div>
	</div>
	<c:if test="${!empty messageList }">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">
					<i class="es-icon es-icon-personadd"></i>
					最新班级公告
				</h3>
			</div>
			<div class="panel-body">
				<div id="messageList" >
					<c:forEach items="${messageList }" var="message">
						<div class="media media-number-o color-gray text-overflow" >
							<a href="javascript:void(0);" data-toggle="modal" title="${message.title}" onclick="showMsgDetail(${message.id})" class="text-warning">${message.title}</a>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</c:if>

<c:if test="${empty messageList||empty classList}">

	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">
				<i class="es-icon es-icon-personadd"></i>
				最新班级公告
			</h3>
		</div>
		<div class="panel-body">
			<div class="empty">暂无班级公告</div>
		</div>
	</div>

</c:if>

	<div class="panel panel-default student-dynamic">

		<div class="panel-heading">
			<h3 class="panel-title">
				<i class="es-icon es-icon-recentactors"></i>
				学员动态
			</h3>
		</div>

		<div class="panel-body" id="userStudyRecords"></div>

	</div>


</div>


<%--报名选择班级--%>
<div class="modal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="show_notice" >
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title">公告</h4>
			</div>
			<div class="modal-body">
				<div class="announcement-detail clearfix">
					<div id="msg_context">

					</div>
					<div class="text-muted pull-right mtm" id="msg_release_time">

					</div>
				</div>

			</div>
		</div>
	</div>


</div>


<script type="text/javascript">


    $(function () {
        $('#myCarousel1').carousel({
            interval: 2000
        });
    })

    function showMsgDetail(msgid){
        $("#show_notice").modal();
        getMsg(msgid);
    }

    function getMsg(msgid){
        $.ajax({
            url:"${pageContext.request.contextPath}/class/show_msg_detail.action",
            data:{
                id:msgid
            },
            dataType:"json",
            success:function(data){
                loadNoticeMessage(data.messageView);
            }
        });
    }

    function loadNoticeMessage(data){
        if(data==null){
            return;
        }
        $("#msg_context").text(data.content);
        $("#msg_release_time").text("发布于"+data.release_time);
    }
</script>
