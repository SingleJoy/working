<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<div class="cn-wrap">


	<div id="content-container" class="container">

		<jsp:include page="/frontstage/xbjy/lesson/lesson_header.jsp"></jsp:include>

		<div class="course-detail row" style="margin-top: 20px;">

			<jsp:include page="/frontstage/xbjy/lesson/lesson_left.jsp"></jsp:include>

			<div class="col-lg-9 col-md-8  course-detail-main">
				<div class="panel panel-default panel-col" style="border: none;">
					<div class="panel-heading">课例评价</div>
					<div class="panel-body">



						<div class="clearfix">
							<c:if test="${empty user_appraise}">
								<button class="btn btn-primary btn-sm pull-right " style="display: none;" type="button" id="pingjia">评价</button>
								<div class="evaluation_again_content">
									<span>请打分&nbsp;:</span>
									<img class="score_star" src="${pageContext.request.contextPath}/frontstage/images/score_star_icon_black.png"
										 name="${pageContext.request.contextPath}/frontstage/images/" title="很差">
									<img class="score_star" src="${pageContext.request.contextPath}/frontstage/images/score_star_icon_black.png"
										 title="较差" name="${pageContext.request.contextPath}/frontstage/images/">
									<img class="score_star" src="${pageContext.request.contextPath}/frontstage/images/score_star_icon_black.png"
										 title="还行" name="${pageContext.request.contextPath}/frontstage/images/">
									<img class="score_star" src="${pageContext.request.contextPath}/frontstage/images/score_star_icon_black.png"
										 title="推荐" name="${pageContext.request.contextPath}/frontstage/images/">
									<img class="score_star" src="${pageContext.request.contextPath}/frontstage/images/score_star_icon_black.png"
										 title="力荐" name="${pageContext.request.contextPath}/frontstage/images/">
									<br/>
									<div class="comment_content" style="margin-top: 20px;">
										<c:forEach items="${appraiseReasonViews }" var="reason">
                    <button type="button" class="btn btn-default" data-reason="${reason.id }">${reason.title }(${reason.count })</button>
                        <span class="mlm mrm text-muted"></span>
                    </c:forEach>
									</div>

									<div class="form-group controls" style="margin-top: 20px;">
											<textarea class="form-control" rows="8" name="appraise_content" id="appraise_content"></textarea>
										<div class="help-block" style="display: none;"></div>
									</div>

									<div class="form-group clearfix pull-right">
										<a class="btn btn-link pull-right">取消</a>
										<button class="btn btn-primary pull-right" id="appraise_button" type="button">发表</button>
									</div>
								</div>
							</c:if>

							<c:if test="${!empty user_appraise }">
								<button class="btn btn-primary btn-sm pull-right" type="button"
										id="pingjia">重新评价</button>
								<div class="evaluation_again_content" style="display: none;">
									<span>请打分&nbsp;:</span>
									<c:forEach end="5" begin="1" varStatus="varStatus">
										<c:choose>
											<c:when test="${varStatus.index>user_appraise.score }">
												<img class="score_star"
													 src="${pageContext.request.contextPath}/frontstage/images/score_star_icon_black.png"
													 name="${pageContext.request.contextPath}/frontstage/images/">
											</c:when>
											<c:otherwise>
												<img class="score_star"
													 src="${pageContext.request.contextPath}/frontstage/images/score_star_icon.png"
													 name="${pageContext.request.contextPath}/frontstage/images/">
											</c:otherwise>
										</c:choose>

									</c:forEach>

									<br/>
									

									<div class="form-group controls" style="margin-top: 30px;">
											<textarea class="form-control" rows="8"
													  name="appraise_content" id="appraise_content">${user_appraise.appraise_content }</textarea>
									</div>

									<div class="form-group clearfix pull-right">
										<a class="btn btn-link ">取消</a>
										<button class="btn btn-primary" value="${user_appraise.id}"
												type="button" id="appraise_button">发表</button>
									</div>
								</div>
							</c:if>
							<c:if test="${empty appraise }">
								<div class="empty"
									 style="text-align: center; margin-top: 30px;">暂无评价</div>
								<input type="hidden" name="score"
									   value="${user_appraise.score}" id="score_value">
							</c:if>
						</div>
						<c:if test="${!empty appraise }">
							<c:forEach items="${appraise }" var="app">
								<div class="js-reviews">
									<div class="media media-evaluate">
										<div class="media-left">
											<a class=" js-user-card"
											   href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id=${app.user_id}">
												<img class="avatar-sm"
													 src="${pageContext.request.contextPath}${app.icon }">
											</a>
										</div>
										<div class="media-body thread-post">
											<div class="title">
												<a class="link-dark"
												   href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id=${app.user_id}">${app.username
														}</a> <span> <fmt:formatDate
													value="${app.appraise_time }" type="date" />
													</span>
											</div>

											<div class="score">
												<c:forEach begin="1" end="${app.score }">
													<i class="es-icon es-icon-star color-warning"></i>
												</c:forEach>

											</div>

											<div class="content">
												<div class="short-content">${app.appraise_content }</div>
												<div class="full-content" style="display: none;">${app.appraise_content
														}</div>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>

							<c:if test="${totalAppraise>10}">
								<br>
								<div class="text-center" style=" margin-bottom: 30px;" id="pointer_more1">加载更多</div>
								<input type="hidden" id="pointer_number1" value="2">
							</c:if>
							<input type="hidden" name="score" value="${user_appraise.score}" id="score_value">

						</c:if>


					</div>

				</div>
			</div>

		</div>
	</div>
	<jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>

</div>
<script type="text/javascript">
  $(function () {
    
      $(".comment_content>button").each(function () {
		
		if($(this).is(".btn-success")){
		return false;
		}else{
		  $(this).removeClass("btn-default").addClass("btn-success");
		  return false;
		}
	});
    
        $(".comment_content>button").click(function () {
            if($(this).is(".btn-default")){
                $(this).removeClass("btn-default").addClass("btn-success");
            }else if($(this).is(".btn-success")){
            if($(".comment_content>.btn-success").length==1){
            alert("必须有一个评价项");
            return false;
            }
                $(this).removeClass("btn-success").addClass("btn-default");
            }else {
                return false;
            }
        })
    });
	$(function() {
		//重新评价点击
		$("#pingjia").click(function() {
			if ($(".evaluation_again_content").css("display") == "none") {
				$(".evaluation_again_content").show();
				$(this).hide();
			} else {
				$(".evaluation_again_content").hide();
				$(this).show();
			}
		});
		//点击取消
		$(".evaluation_again_content div a").click(function() {
			$(".evaluation_again_content").hide();
			$("#pingjia").show();
		});
		/**
		 *评分
		 */
		$(".score_star").click(function() {
			var star = "score_star_icon.png";
			var black = "score_star_icon_black.png";
			var name = $(this).attr("name");
			$(this).prevAll().attr("src", name + star);
			$(this).attr("src", name + star);
			$(this).nextAll().attr("src", name + black);
			$("#score_value").val($(this).prevAll().length);
		});
		$("#appraise_button").click(
				function() {
					if(flag){
						check_login();
						return false;
					}
					var score = $("#score_value").val();

					if (score == "") {
						alert("请打分");
						return false;
					}
					if (typeof(score) == "undefined") {
						alert("请打分");
						return false;
					}
					var content = $("#appraise_content").val();
					if (content == "") {
						alert("请评论");
						return false;
					}
					var reason="";
             $(".comment_content>.btn-success").each(function () {
             
             reason+=$(this).data("reason");
             reason+=",";
             });
					$.ajax({
						url : '${pageContext.request.contextPath}/user_appraise/appraise.action',
						data : {
							appraise_content : content,
							score : score,
							id : $(this).val(),
							source_id : '${lesson.id}',
							source_type : 3,
							reason:reason,
						},
						dataType : 'json',
						success : function(response) {
							window.location.reload();
						}
					});
				});
		$("#pointer_number1").val(2);
		$("#pointer_more1").click(function(){
			if(flag){
				check_login();
				return false;
			}
			var _this=$(this);
			var number=$("#pointer_number1").val();
			$.ajax({
				type:'get',
				url : "${pageContext.request.contextPath}/user_study/ajax_appraise.action?id=${lesson.id}&type=3&page="+number,
				dataType:'json',
				success : function(response) {
					if(!response.flag){
						_this.remove();
					}
					for(var i=0;i<response.appraise.length;i++){
						var div_js_reviews=$("<div>");
						div_js_reviews.attr("class","js-reviews");
						var div_media_evaluate=$("<div>");
						div_media_evaluate.attr("class","media media-evaluate");
						var div_media_left=$("<div>");
						div_media_left.attr("class","media-left");
						var a_js_user_card=$("<a>");
						a_js_user_card.attr("class","js-user-card");
						a_js_user_card.attr("href","${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id="+response.appraise[i].user_id);
						var img=$("<img>");
						img.attr("src","${pageContext.request.contextPath}"+response.appraise[i].icon);
						img.attr("class","avatar-sm");
						a_js_user_card.append(img);
						div_media_left.append(a_js_user_card);
						var div_media_body=$("<div>");
						div_media_body.attr("class","media-body thread-post");
						var div_title=$("<div>");
						div_title.attr("class","title");
						var a_link_dark=$("<a>");
						a_link_dark.attr("class","link-dark");
						a_link_dark.attr("href","${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id="+response.appraise[i].user_id);
						a_link_dark.html(response.appraise[i].username);
						var span=$("<span>");
						var myDate=new Date();
						myDate.setTime(response.appraise[i].appraise_time.time);
						var year=myDate.getFullYear();
						var month=myDate.getMonth()+1;
						var date=myDate.getDate();
						var time=year+"-"+month+"-"+date;
						span.html(time);
						div_title.append(a_link_dark);
						div_title.append("&nbsp;");
						div_title.append("&nbsp;");
						div_title.append("&nbsp;");
						div_title.append(span);
						var div_score=$("<div>");
						div_score.attr("class","score");
						for(var j=0;j<response.appraise[i].score;j++){
							var i_=$("<i>");
							i_.attr("class","es-icon es-icon-star color-warning");
							div_score.append(i_);
							div_score.append("&nbsp;");
						}
						var div_content=$("<div>");
						div_content.attr("class","content");
						var div_short_content=$("<div>");
						div_short_content.attr("class","short-content");
						div_short_content.html(response.appraise[i].appraise_content);
						var div_full_content=$("<div>");
						div_full_content.attr("class","full-content");
						div_full_content.attr("style","display:none;");
						div_full_content.html(response.appraise[i].appraise_content);
						div_content.append(div_short_content);
						div_content.append(div_full_content);
						div_media_body.append(div_title);
						div_media_body.append(div_score);
						div_media_body.append(div_content);
						div_media_evaluate.append(div_media_left);
						div_media_evaluate.append(div_media_body);
						div_js_reviews.append(div_media_evaluate);
						$(".js-reviews:last").after(div_js_reviews);
						$("#pointer_number1").val(parseInt(number)+1);
					}
				}
			});
		});


	});

</script>

