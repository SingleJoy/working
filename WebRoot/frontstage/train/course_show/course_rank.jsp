<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<style>
    .course_rank_square{width:35px; height: 35px;text-align: center;line-height: 35px;font-size: 16px;color: #fff;border-radius: 50%;}
    .rank_01{background-color:#ff2600;}
    .rank_02{background-color:#ff3901;}
    .rank_03{background-color:#ff6b03;}
    .rank_04{background-color:#ff9902;}
    .rank_05{background-color:#ffca00;}
    .rank_06, .rank_07, .rank_08,.rank_09, .rank_010{background-color:#cdcb9d;}
    .course_user_info{margin-left: 20px;width: 120px;margin-top: -20px;}
    .course_user_info>a{margin-top: -15px;display: inline-block;}
    .avatar-square-lg-md{width: 90px;height: 90px;-webkit-border-radius: 4px;-moz-border-radius: 4px;border-radius: 4px;}
    .learning_info{margin-left: 72%;margin-top: -30px;}

</style>

<!--排行榜-->
<div class="piece-body">
    <div class="cn-filter">

        <ul class="pull-right nav nav-sort clearfix ">
            <li><a href="javascript:void(0);" class="active btn-sm " id="learning_process">学习进度</a></li>
            <li><a href="javascript:void(0);" class="btn-sm" id="learning_time">学习时长</a></li>
        </ul>
    </div>
    <br/>
    <br/>
    <br/>

    <%--按照学习进度排序--%>
    <div class="learning_process" >
        <ul class="media-list "   >

            <!--排名第一-->
            <c:forEach items="${courseRankViews}" var="view" end="9">
                <li class="media" style="padding-bottom: 0;border-bottom: 1px dotted #bfbfbf;">

                    <div class="media media-default">

                        <div class="media-left">

                            <div class="course_rank_square rank_0${view.rank } pull-left">${view.rank }</div>
                        </div>

                        <div class="media-body" >
                            <div class="pull-left" style="margin-left: 20px;">
                                <a class="js-user-card"  id="userCard_2${view.user_id }" onmouseover="mouseOver(2,${view.user_id});" onmouseout="mouseOut(2,${view.user_id });" href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id=${view.user_id }">
                                    <img class="avatar-square-sm" src="${pageContext.request.contextPath}${view.icon }">
                                </a>

                                <span class="course_user_info" >${view.username }</span>
                            </div>

                            <div class="pull-left learning_info" >
                                <span >学习进度：${view.pace }%</span>
                                <span class="mlm mrm text-muted"></span>
                                <span ><fmt:formatDate value="${view.complete_time }" type="date"/></span>


                            </div>
                        </div>
                    </div>
                </li>
            </c:forEach>

        </ul>
    </div>


    <%--按照学习时长排序--%>
    <div class="learning_time " style="display: none;">
        <ul class="media-list" >

            <!--排名第一-->
            <c:forEach items="${courseRankViews1}" var="view" end="9">
                <li class="media" style="padding-bottom: 0;border-bottom: 1px dotted #bfbfbf;">
                    <div class="media media-default">

                        <div class="media-left">
                            <div class="course_rank_square rank_0${view.rank } pull-left">${view.rank }</div>
                        </div>
                        <div class="media-body">
                            <div class="pull-left" style="margin-left: 20px;">
                                <a class="js-user-card"  id="userCard_1${view.user_id }" onmouseover="mouseOver(1,${view.user_id});" onmouseout="mouseOut(1,${view.user_id });" href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id=${view.user_id }">
                                    <img class="avatar-square-sm" src="${pageContext.request.contextPath}${view.icon }">
                                </a>
                                <span class="course_user_info " >${view.username }</span>
                            </div>

                            <div class="pull-left learning_info" >
                                <span >学习时长：<fmt:formatNumber type="number" maxFractionDigits="1" value="${view.total_time/1000/60 }" />分钟</span>
                                <span class="mlm mrm text-muted"></span>
                                <span ><fmt:formatDate value="${view.complete_time }" type="date"/></span>

                            </div>

                        </div>
                    </div>

                </li>

            </c:forEach>

        </ul>
    </div>
</div>



<script type="text/javascript">
    $("#learning_process").click(function () {
      $(this).addClass("active");
      $(".learning_process").show();
      $(".learning_time").hide();
      $("#learning_time").removeClass("active");

    });
    $("#learning_time").click(function () {
        $(this).addClass("active");
        $(".learning_process").hide();
        $(".learning_time").show();
        $("#learning_process").removeClass("active");

    });
</script>