<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="col-lg-3 col-md-4 class-sidebar">

	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">

				培训老师
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
						<div class="empty">暂无培训老师信息</div>
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
				<h3 class="panel-title"><i class="es-icon es-icon-personadd"></i>最新班级公告</h3>
			</div>
			<div class="panel-body">
				<div id="messageList" class="user-avatar-list clearfix">
					<c:forEach items="${messageList }" var="message">
						<div class="media media-number-o color-gray text-overflow" >
							<a data-toggle="moodal" href="javascript:void(0);" title="${message.title}" onclick="showMsgDetail(${message.id})" class="color-gray">${message.title}</a>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</c:if>

<c:if test="${empty messageList||empty classList }">

	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title"><i class="es-icon es-icon-personadd"></i>最新班级公告</h3>
		</div>
		<div class="panel-body">
			<div class="empty">暂无班级公告</div>
		</div>
	</div>

</c:if>

	<div class="panel panel-default student-dynamic">

		<div class="panel-heading">
			<h3 class="panel-title"><i class="es-icon es-icon-recentactors"></i>学员动态</h3>
		</div>

		<div class="panel-body" id="userStudyRecords">
		</div>

	</div>

</div>
<div class="modal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="show_notice" >
	<div class="modal-dialog">
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
    function mouseOver(type,userId){

        var _this = $('#userCard_'+type+userId);

        var loadingHtml = '<div class="card-body"><div class="card-loader"><span class="loader-inner"><span></span><span></span><span></span></span> 名片加载中</div>';

        var timer = setTimeout(function(){

            if ($('#user-card-' + userId).length == 0 || !_this.data('popover')) {

                function beforeSend () {

                    _this.popover({
                        trigger: 'manual',
                        placement: 'auto top',
                        html: 'true',
                        content: function(){
                            return loadingHtml;
                        },
                        template: '<div class="popover cn-card"><div class="arrow"></div><div class="popover-content"></div></div>',
                        container: 'body',
                        animation: true
                    });

                    // _this.popover("show");

                };

                function callback(html) {

                    _this.popover('destroy');

                    if ($('#user-card-' + userId).length == 0) {
                        if ($('body').find('#user-card-store').length > 0 ) {
                            $('#user-card-store').append(html);
                        } else {
                            $('body').append('<div id="user-card-store" class="hidden"></div>');
                            $('#user-card-store').append(html);
                        }
                    }

                    _this.popover({
                        trigger: 'manual',
                        placement: 'auto top',
                        html: 'true',
                        content: function(){
                            return html;
                        },
                        template: '<div class="popover cn-card"><div class="arrow"></div><div class="popover-content"></div></div>',
                        container: 'body',
                        animation: true
                    });

                    _this.popover("show");

                    _this.data('popover', true);

                    $(".popover").on("mouseleave", function () {
                        $(_this).popover('hide');
                    });
                };

                $.ajax ({
                    type:"post",
                    url: '${pageContext.request.contextPath}/user_study/ajax_user.action?id='+userId,
                    dataType: "html",
                    beforeSend: beforeSend,
                    success: callback

                });

            } else {
                _this.popover("show");
            }



        },100);

        _this.data('timerId', timer);
    }
    function mouseOut(type,userId){

        var _this = $('#userCard_'+type+userId);
        setTimeout(function () {

            if (!$(".popover:hover").length) {

                _this.popover("hide")

            }

        }, 100);

        clearTimeout(_this.data('timerId'));
    }
    $(function () { $("[data-toggle='popover']").popover(); });
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
