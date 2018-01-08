<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>



<div class="col-md-3 col-lg-3 col-sm-3">
    <div class="sidenav locked">
        <input type="hidden" id="stamp" value="${stamp}"/>

        <ul class="list-group">

            <li class="list-group-heading" id="stamp_0">社区</li>
            <li class="list-group-item <c:if test="${state==39 }">active</c:if>">
                <a href="${pageContext.request.contextPath}/my_chart/to_my_chart.action?stamp=2&state=39">
                    <span ></span>我的首页
                </a>
            </li>
            <li class="list-group-item <c:if test="${state==0}">active</c:if> "><a href="${pageContext.request.contextPath}/community/to_community_center.action?stamp=0&state=0&sign=0">我的社区</a></li>
       		<li class="list-group-item <c:if test="${state==1}">active</c:if> "><a href="${pageContext.request.contextPath}/workshop/to_workshop_center.action?stamp=0&state=1&sign=0">我的工作坊</a></li>

            <li class="list-group-item <c:if test="${state==9 }">active</c:if> "><a href="${pageContext.request.contextPath}/my_attention/showMyAttention.action?state=9&type=1&page=0&stamp=6"><span></span>我的关注</a></li>
            <li class="list-group-item <c:if test="${state==20 }">active</c:if>">
                <a href="${pageContext.request.contextPath}/user_collect/to_user_collect.action?stamp=2&state=20">
                    <span ></span>我的收藏
                </a>
            </li>
        </ul>

        <ul class="list-group">
            <li class="list-group-heading" id="stamp_8">教研中心</li>
            <%--<li class="list-group-item <c:if test="${state==30}">active</c:if>">--%>
            	<%--<a href="${pageContext.request.contextPath}/lesson/to_lesson.action?state=30">--%>
            	<%--课例管理--%>
            	<%--</a>--%>
            <%--</li>--%>
            <li class="list-group-item <c:if test="${state==31 }">active</c:if>">
                <a href="${pageContext.request.contextPath}/lesson/to_my_lesson.action?state=31&status=-1">
                    <span ></span>我的课例
                </a>
            </li>
        </ul>

        <c:if test="${user.user_type==3}"><!-- 教师 -->
        <ul class="list-group">
            <li class="list-group-heading" id="stamp_1">教学中心</li>
            <li class="list-group-item <c:if test="${state==12 }">active</c:if> "><a href="${pageContext.request.contextPath}/course/to_course.action?&stamp=1&state=12&sign=1&type=0&status=-1">课程管理</a></li>
            <li class="list-group-item <c:if test="${state==13 }">active</c:if> "><a href="${pageContext.request.contextPath}/train/to_train.action?&stamp=1&state=13&sign=1&type=0">培训管理</a></li>
            <li class="list-group-item <c:if test="${state==14 }">active</c:if> "><a href="${pageContext.request.contextPath}/topic_question/query_question.action?&stamp=1&state=14"><span ></span>学员问答</a></li>
            <li class="list-group-item <c:if test="${state==15 }">active</c:if> "><a href="${pageContext.request.contextPath}/class/to_tutor_class.action?&stamp=1&state=15&sourceType=0"><span ></span>助教班级</a></li>
            <li class="list-group-item <c:if test="${state==29 }">active</c:if> "><a href="${pageContext.request.contextPath}/cert_model/to_cert_model_manager.action?stamp=1&state=29"><span ></span>证书管理</a></li>
        </ul>
        <ul class="list-group">
            <li class="list-group-heading" id="stamp_9">资料中心</li>
            <li class="list-group-item <c:if test="${state==32 }">active</c:if> "><a href="${pageContext.request.contextPath}/course_file/to_file_base.action?stamp=9&state=32&type=-1"><span ></span>教学资料库</a></li>
            <li class="list-group-item <c:if test="${state==37 }">active</c:if> "><a href="${pageContext.request.contextPath}/userFile/to_user_file.action?stamp=9&state=37&type=1&status=-1&flag=-1&file_type=-1"><span ></span>我的上传</a></li>
            <li class="list-group-item <c:if test="${state==38 }">active</c:if> "><a href="${pageContext.request.contextPath}/userFile/to_user_file.action?stamp=9&state=38&type=5&status=-1&flag=-1"><span ></span>我的下载</a></li>
        </ul>
        </c:if>

        <c:if test="${user.user_type==2}"><!-- 学校管理 -->
        <ul class="list-group">
            <li class="list-group-heading" id="stamp_2">学校中心</li>
            <li class="list-group-item <c:if test="${state==17 }">active </c:if>" ><a href="${pageContext.request.contextPath}/school_center/query_course.action?&stamp=3&state=17"><span ></span>学校课程</a></li>
            <li class="list-group-item <c:if test="${state==18 }">active </c:if> "><a href="${pageContext.request.contextPath}/school_center/query_teacher.action?&stamp=3&state=18"><span ></span>学校老师</a></li>
            <li class="list-group-item <c:if test="${state==19 }">active </c:if> "><a href="${pageContext.request.contextPath}/school_center/query_resourse.action?&stamp=3&state=19"><span ></span>学校资源</a></li>
            <li class="list-group-item"><a href="javascript:void(0);"><span ></span>我的研修</a></li>
        </ul>
        </c:if>

        <ul class="list-group">
            <li class="list-group-heading" id="stamp_3">学习中心</li>
            <li class="list-group-item <c:if test="${state==22 }">active</c:if>">
                <a href="${pageContext.request.contextPath}/user_study/to_user_study.action?stamp=2&state=22&is_studyed=0&source_type=0">
                    <span ></span>我的课程
                </a>
            </li>
            <li class="list-group-item <c:if test="${state==23 }">active</c:if>">
                <a href="${pageContext.request.contextPath}/user_study/to_user_study.action?stamp=2&state=23&is_studyed=0&source_type=1">
                    <span ></span>我的培训
                </a>
            </li>

            <li class="list-group-item <c:if test="${state==24 }">active</c:if>">
                <a href="${pageContext.request.contextPath}/topic_question/user_question.action?stamp=2&state=24">
                    <span ></span>我的问答
                </a>
            </li>
            <%--<li class="list-group-item ">--%>
                <%--<a href="javascript:void(0);">--%>
                    <%--<span ></span>我的话题--%>
                <%--</a>--%>
            <%--</li>--%>
            <li class="list-group-item <c:if test="${state==26 }">active</c:if>">
                <a href="${pageContext.request.contextPath}/course_note/to_my_notes.action?stamp=2&state=26">
                    <span ></span>我的笔记
                </a>
            </li>
            <li class="list-group-item <c:if test="${state==27 }">active</c:if>">
                <a href="${pageContext.request.contextPath}/exam/to_my_exam.action?stamp=2&state=27">
                    <span ></span>我的考试
                </a>
            </li>
            <li class="list-group-item <c:if test="${state==28 }">active</c:if>">
                <a href="${pageContext.request.contextPath}/exam/to_my_homework.action?stamp=2&state=28">
                    <span ></span>我的作业
                </a>
            </li>

            <li class="list-group-item <c:if test="${state==30 }">active</c:if>">
                <a href="${pageContext.request.contextPath}/user_certificate/to_user_certificate.action?stamp=2&state=30&source_type=0">
                    <span ></span>我的证书
                </a>
            </li>

        </ul>

        <%--<ul class="list-group" >--%>
        <%--<li class="list-group-heading " id="stamp_4">资源中心</li>--%>
        <%--<li class="list-group-item <c:if test="${stage==1 }">active</c:if>">--%>
        <%--<a href="${pageContext.request.contextPath}/my_contribution/showMyContribution.action?state=1&fileType=0&page=0&stamp=4">--%>
        <%--<span ></span>我的贡献--%>
        <%--</a>--%>
        <%--</li>--%>

        <%--<li class="list-group-item <c:if test="${stage==3 }">active</c:if>">--%>
        <%--<a href="${pageContext.request.contextPath}/my_download/showDownload.action?state=3&page=0&stamp=4">--%>
        <%--<span></span>我的下载--%>
        <%--</a>--%>
        <%--</li>--%>
        <%--<li class="list-group-item <c:if test="${stage==4 }">active</c:if>">--%>
        <%--<a href="${pageContext.request.contextPath}/my_resources/showMyResources.action?state=4&page=0&columnId=0&stamp=4">--%>
        <%--<span></span>我的资源--%>
        <%--</a>--%>
        <%--</li>--%>
        <%--<li class="list-group-item <c:if test="${stage==5 }">active</c:if>">--%>
        <%--<a href="${pageContext.request.contextPath}/my_resource_arrange/showResourceArrange.action?state=5&columnId=0&secondary=0&section=0&userId=${activeentUser.id }&stamp=4">--%>
        <%--<span></span>资源排行--%>
        <%--</a>--%>
        <%--</li>--%>
        <%--</ul>--%>

        <%--<ul class="list-group">--%>
        <%--<li class="list-group-heading" id="stamp_5">订单中心</li>--%>
        <%--<li class="list-group-item <c:if test="${state==6 }">active</c:if> "><a href="${pageContext.request.contextPath}/my_resources/goScore.action?state=6&pageNo=0&pageSize=7&stamp=5"><span></span>我的积分</a></li>--%>
        <%--<li class="list-group-item <c:if test="${state==7 }">active</c:if> "><a href="${pageContext.request.contextPath}/my_resources/goIncome.action?state=7&pageNo=0&pageSize=10&stamp=5"><span></span>我的收益</a></li>--%>
        <%--<li class="list-group-item <c:if test="${state==8 }">active</c:if> "><a href="${pageContext.request.contextPath}/order/goOrder.action?state=8&pageNo=0&pageSize=4&stamp=5"><span></span>我的订单</a></li>--%>

        <%--</ul>--%>



        <ul class="list-group">
            <li class="list-group-heading" id="stamp_7">设置</li>
            <li class="list-group-item <c:if test="${state==36 }">active</c:if> "><a href="${pageContext.request.contextPath}/certification/to_certification.action?state=36&stamp=7"><span></span>实名认证</a></li>
            <li class="list-group-item <c:if test="${state==35 }">active</c:if> "><a href="${pageContext.request.contextPath}/my_setting/showMySetting.action?state=35&stamp=7"><span></span>个人设置</a></li>
            <li class="list-group-item <c:if test="${state==33 }">active</c:if> "><a href="${pageContext.request.contextPath}/my_setting/showMyIcon.action?state=33&stamp=7"><span></span>头像设置</a></li>
            <li class="list-group-item <c:if test="${state==34 }">active</c:if> "><a href="${pageContext.request.contextPath}/user/resetPassword.action?state=34&stamp=7"><span></span>密码修改</a></li>

        </ul>
    </div>
</div>






<script type="text/javascript">
    $(function(){
        var stamp = $("#stamp").val();
        $("#stamp_"+stamp).siblings().show();

    });
</script>
