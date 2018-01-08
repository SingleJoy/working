<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<link href="${pageContext.request.contextPath}/frontstage/css/xbjy.css" rel="stylesheet" type="text/css">
<link  href="${pageContext.request.contextPath}/frontstage/js/sharejs/dist/css/share.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/frontstage/js/sharejs/dist/js/jquery.share.min.js"></script>
<script>

    function GetString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null)
            return unescape(r[2]);
        return null;
    }

    $(function() {

        showCollet();

        $("#all-task").click(function() {
            $(this).addClass("task1");
            $("#my-task").removeClass("task2");
            $(".all-task").show();
            $(".my-task").hide();
        });

        $("#my-task").click(function() {
            $(this).addClass("task2");
            $("#all-task").removeClass("task1");
            $(".my-task").show();
            $(".all-task").hide();
        });
    });
    $(function() {
        $(".task-list>a").click(function() {
            $(".task-list").find("ul").find("li").hide();
            $(this).siblings("ul").show().find("li").toggle();
        });

        $('#updateStatus').click(function() {
            var lesson_id = GetString("lesson_id");;
            $.ajax({
                type : "post",
                url : '${pageContext.request.contextPath}/lesson/updateStatus.action',
                data : {
                    "lesson_id" : lesson_id,
                    "status" : 2
                },
                dataType : "json",
                success : function(response) {
                    alert(response.msg);
                    location.replace(location.href);
                },
                error : function(response) {
                    alert("失败！！！！！！");
                    location.replace(location.href);

                }
            });
        });

    });
    function showCollet(){
        $.ajax({
            url : '${pageContext.request.contextPath}/lesson/selectOne.action',
            dataType : 'json',
            data:{
                id:'${lesson.id}',

            },
            success:function(data){
                var lessonView=data.lessonView;
                $("#workshop_name").html(lessonView.workshop_name);
                $("#workshop_name").attr("href","${pageContext.request.contextPath}/community/to_community_index.action?sourceType=1&stamp=5&id="+lessonView.workshop_id);
                $("#community_name").html(lessonView.community_name);
                $("#community_name").attr("href","${pageContext.request.contextPath}/community/to_community_index.action?sourceType=0&stamp=5&id="+lessonView.community_id);
                var user ='${currentUser}';
                if(user!=''){//用户登录
                    var userCollect = data.userCollect;
                    if(userCollect != undefined){//收藏
                        $("#isUserCollect").show();
                        $("#unUserCollect").hide();
                    }else{//未收藏
                        $("#unUserCollect").show();
                        $("#isUserCollect").hide();
                    }
                }else{//未登录
                    $("#unUserCollect").show();
                    $("#isUserCollect").hide();
                }
            }
        });
    }
</script>

<section class="course-detail-header after">


	<ol class="breadcrumb breadcrumb-o">
			<li><a href="#" id="community_name"></a></li>
			<li><a href="#" id="workshop_name"></a></li>
			<li><a href="#">${lesson.name}</a></li>
		</ol>

	<div class="cn-section clearfix">


			<div class="course-header-top ">

				<div class="course-img" >

					<img class="img-responsive"
						 <c:if test="${empty lesson.lesson_pic}">src="${pageContext.request.contextPath}/frontstage/images/course.png"</c:if>
						 <c:if test="${!empty lesson.lesson_pic}">src="${pageContext.request.contextPath}/${lesson.lesson_pic}"</c:if> style="height: 180px;">


					<c:if test="${lesson.excellent==1}">

						<span class="lesson_lever text-center">
							&nbsp;&nbsp;优

						</span>
					</c:if>
				</div>

				<div class="course-info" style="padding: 15px;">
					<h2 class="title">${lesson.name}</h2>

					<div class="lesson_info">
						<div class="score">
							<c:forEach begin="1" end="${lessonHead.lessonTotalScore}">
								<i class="es-icon es-icon-star color-warning"></i>
							</c:forEach>
							<span>(${lessonHead.lessonTotalAppraise}评价)</span>
						</div>
						浏览数&nbsp;<span class="mrm text-danger">${lesson.scan_count}</span><span class="mlm mrm"></span>
						问题研讨&nbsp;<span class="mrm text-danger">${lessonHead.problemTotal} </span><span class="mlm mrm"></span>
						文章资源&nbsp;<span class="mrm text-danger">${lessonHead.articleTotal} </span><br/><br/>
						指导老师&nbsp;
						<span class="mrm text-danger">
							<c:forEach items="${lessonLeft.lessonUserList }" var="lessonUser">
								<c:if test="${lessonUser.identity ==2}">
									<c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if>
									<c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>
								</c:if>
							</c:forEach>
							</span>
						<span class="mlm mrm"></span>
						组长&nbsp;&nbsp;
						<span class="mrm text-danger">
								<c:forEach items="${lessonLeft.lessonUserList }" var="lessonUser">
									<c:if test="${lessonUser.identity ==0}">
										<c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if>
										<c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>
									</c:if>
								</c:forEach>
							</span>

					</div>
					<div class="progress col-md-10" style="height: 18px;background-color: #eaeaea;padding: 0;margin-top: 15px;" >
						<c:if test="${lessonHead.accomplishedTotal/lessonHead.taskTotal>=0.15 }">
							<c:set var="width" value="${lessonHead.accomplishedTotal/lessonHead.taskTotal}"></c:set>
						</c:if>
						<c:if test="${lessonHead.accomplishedTotal/lessonHead.taskTotal<0.15 }">
							<c:set var="width" value="0.15"></c:set>
						</c:if>
						<c:if test="${empty lessonHead.accomplishedTotal}">
							<c:set var="width" value="0.00"></c:set>
						</c:if>

						<div class="progress-bar progress-bar-success"  role="progressbar" aria-valuenow="20" aria-valuemin="0"
							 aria-valuemax="100" style="width:<fmt:formatNumber type="percent" maxFractionDigits="3" value="${width }" />">
							<span class="text-center">完成：${lessonHead.accomplishedTotal}/${lessonHead.taskTotal}</span>
						</div>

					</div>


				</div>

				<div class="course-operation ">

					<ul class="course-data clearfix two-col " >

						<li style="margin-left: 50px;">
							<p style="font-size: 25px;"><i class="es-icon es-icon-people"></i></p>
							<p id="students">${lessonHead.memberTotal}人</p>
						</li>

						<li id="isUserCollect" style="display:none;clear: both;padding-top: 7px;">
							<a href="javascript:;" class="color-primary" onclick="doCollect();">
								<p><i class="es-icon es-icon-bookmark"></i></p>
								<p>已收藏</p>
							</a>
						</li>

						<li id="unUserCollect" style="display:none;clear: both;padding-top: 7px;">
							<a href="javascript:;" onclick="doCollect();">
								<p><i class="es-icon es-icon-bookmarkoutline"></i></p>
								<p>收藏</p>
							</a>
						</li>

						<li style="padding: 0;" class="text-center">
							<div id="share-2" style="margin-top: -42px;position: relative;text-align: center;margin-left: 20px;min-width: 112px;min-height: 35px;" class="social-share dropdown-menu pull-right" data-sites="weibo,qq,qzone,wechat"></div>
							<a href="javascript:void(0);" class="btn  btn-sm dropdown-toggle" data-toggle="dropdown" id="share" >
								<p><i class="es-icon es-icon-share"></i></p>
								<p style="font-size: 15px;margin-top: 5px;">分享</p>
							</a>
						</li>

					</ul>


				</div>

			</div>

		</div>


</section>