<%@page language="java" import="java.util.*,cn.bnsr.edu_yun.frontstage.base.po.User" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% User user = (User)request.getSession().getAttribute("currentUser"); %>

<jsp:include page="../base/layout/header.jsp"></jsp:include>

<script>

    //轮播图
    $(document).ready(function() {
        $('.carousel').carousel({
            interval: 2000
        })
    });

    function showSelectedClassifyCourse(index){
        $("#ul_classifys li").removeClass("active");
        $("#li_classify"+index).addClass("active");
        $(".course_page").hide();
        $("#classify_course"+index).show();
    }

</script>
<style>
    .lesson_img{background-color: #ffd54f;border-radius: 4px;}
    .lesson_img>a>img{margin: 15px;}
    .lesson_img>a>span{color: #fff;}
    .head_list>li>a{font-size: 14px;color: #fff;}
    .carousel-inner>div{width: 100%;}
    .carousel-inner>div>img{max-width: 1160px;margin: 0 auto;height: 400px;}
    .bannerbox{background: url("${pageContext.request.contextPath}/frontstage/images/train_ads_banner.jpg") top center no-repeat;}
</style>

<div class="cn-wrap " style="background-color: #fff;">

    <!-- js轮播图 -->
    <section class="cn-posterswiper-container">

        <div id="myCarousel" class="carousel slide">

            <!-- 轮播（Carousel）指标 -->
            <ol class="carousel-indicators">
            <c:forEach items="${carousel}" var="cimg" varStatus="t">
               <li data-target="#myCarousel" data-slide-to="${t.index}"  data-interval="3000" <c:if test="${t.index==0}"> class="active"</c:if>></li>
            </c:forEach>
                
                <!-- <li data-target="#myCarousel" data-slide-to="1"  data-interval="3000"></li>
                <li data-target="#myCarousel" data-slide-to="2"  data-interval="3000"></li>
                <li data-target="#myCarousel" data-slide-to="3"  data-interval="3000"></li> -->
            </ol>

            <!-- 轮播（Carousel）项目 -->
            <div class="carousel-inner">
                <c:forEach items="${carousel}" var="cimg" varStatus="t">
                   <div class="item<c:if test="${t.index==0}"> active</c:if>" style="background-color:#0ac895;">
	                    <img class="img-responsive" src="${pageContext.request.contextPath}${cimg.path}">
	                </div>
                
                </c:forEach>
                
                <%-- <div class="item" style="background-color:#0ac895;">
                    <img class="img-responsive" src="${pageContext.request.contextPath}/frontstage/images/train_flash_02.png">
                </div>
                <div class="item" style="background-color:#0ac895;">
                    <img class="img-responsive" src="${pageContext.request.contextPath}/frontstage/images/train_flash_03.png">
                </div>
                <div class="item" style="background-color:#0ac895;">
                    <img class="img-responsive" src="${pageContext.request.contextPath}/frontstage/images/train_flash_04.png">
                </div> --%>
            </div>

        </div>

    </section>

    <!-- 热门课程 -->
    <div class="container">
        <div class="text-line">
            <h5><span>热门课程</span>
                <div class="line"></div>
            </h5>
            <div class="subtitle">精选热门课程，满足你的学习兴趣。</div>
        </div>

        <div class="course-list">
            <div class="row">
                <c:forEach items="${hotCourseList}" var="course">
                    <div class="col-lg-3 col-md-4 col-xs-6">
                        <div class="course-item">
                            <div class="course-img">
                                <a href="${pageContext.request.contextPath}/user_study/to_course_study.action?page=1&learnId=${course.id }&sourceType=0&tab=1&is_direct=0" <%-- onclick="toCourseDetail(${course.id});" --%> target="_blank">
                                    <img src="${pageContext.request.contextPath}${course.img}" alt="" class="img-responsive" style="height: 160px;" />
                                </a>
                            </div>
                            <div class="course-info">
                                <div class="title">
                                    <a class="link-dark" href="${pageContext.request.contextPath}/user_study/to_course_study.action?page=1&learnId=${course.id }&sourceType=0&tab=1&is_direct=0" target="_blank" >
                                            ${course.title }
                                    </a>
                                    <div class="teacher_info" style="padding: 5px 0;">
                                        <span class="teacher_name pull-left" >${course.userName}</span>
                                        <span class="teacher_address pull-right" >${course.school}</span>
                                    </div>
                                </div>

                                <div class="metas clearfix">
                                    <span class="num"><i class="es-icon es-icon-people"></i>${course.studentNum }人参加</span>

                                    <span class="course-price-widget">

                                    <span class="price">
                                       <c:if test="${course.price==0 }">
                                           <span class="text-success">免费</span>
                                       </c:if>
										<c:if test="${course.price!=0 }">
                                            <span class="price"> ￥${course.price }</span>
                                        </c:if>
                                    </span>

                                </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        <div class="section-more-btn">
            <a href="${pageContext.request.contextPath}/course/to_course_center.action?type=0&sortType=1&classifyId=-1&isParent=0&parentId=-1" target="_blank" class="btn btn-default btn-lg">
                更多课程 <i class="mrs-o es-icon es-icon-chevronright"></i>
            </a>
        </div>
    </div>

    <!-- Banner图 -->
    <div class="bannerbox" style="width: 100%;height: 300px;margin-top: 30px;">

        <div class="banner-picture">

        </div>
    </div>

    <!-- 最新培训 -->
    <div class="container">
        <div class="text-line">
            <h5>
                <span>最新培训</span>
                <div class="line">最新培训课程，了解行业动态</div>
            </h5>

        </div>

        <div class="course-list">
            <div class="row">

                <c:forEach items="${trainList}" var="train">

                    <div class="col-lg-3 col-md-4 col-xs-6">
                        <div class="course-item">
                            <div class="course-img">
                                <a href="javascript:void(0);" onclick="toTrainDetail(${train.id});" target="_blank">
                                    <img src="${pageContext.request.contextPath}${train.img}" class="img-responsive" style="width: 260px; height: 150px;" />
                                </a>
                            </div>
                            <div class="course-info">

                                <div class="title">
                                    <a class="link-dark" href="javascript:void(0);" onclick="toCourseDetail(${train.id});">
                                            ${train.name }
                                    </a>
                                    <div style="padding: 5px 0;">
                                        <span class="teacher pull-left" style="padding-right: 10px;">主办方&nbsp;:&nbsp;${train.sponsor}</span>
                                    </div>
                                </div>

                                <div class="metas clearfix">
                                    <span class="num"><i class="es-icon es-icon-people"></i>${train.studentNum }人参加</span>

                                    <span class="course-price-widget">
										<span class="price"><c:if test="${train.price==0 }">
                                            <span class="text-success">免费</span>
                                        </c:if>
									   </span>
										<c:if test="${train.price!=0 }">
                                            <span class="price"> ￥${train.price }</span>
                                        </c:if>

									</span>
                                </div>

                            </div>
                        </div>
                    </div>

                </c:forEach>
            </div>
        </div>
        <div class="section-more-btn">
            <a href="${pageContext.request.contextPath}/train/to_train_center.action?type=0&classify_id=-1" target="_blank" class="btn btn-default btn-lg">
                更多培训<i class="mrs-o es-icon es-icon-chevronright"></i>
            </a>
        </div>
    </div>

    <!-- 入驻学校 -->
    <div class="container">
        <div class="text-line">
            <h5>
                <span>入驻学校</span>
                <div class="line"></div>
            </h5>
        </div>
        <div class="course-list">
            <div class="row">
                <c:forEach items="${communityViews }" var="community">
                    <div class="col-lg-3 col-md-3 col-xs-6" style="margin-bottom: 20px;">
                        <div class="lesson_item">
                            <div class="lesson_img" style="background-color:#9ccc65;">
                                <a class="link-dark" href="${pageContext.request.contextPath}/community/to_community_index.action?sourceType=0&stamp=5&id=${community.id}" target="_blank">

                                    <img src="${pageContext.request.contextPath}${community.head_img}" class="avatar-lg" >

                                    <span class="text-muted text-center" style=""> ${community.name}</span>
                                </a>

                            </div>
                        </div>
                    </div>

                </c:forEach>
            </div>
        </div>
        <c:if test="${total>8 }">
            <div class="section-more-btn">
                <a href="${pageContext.request.contextPath}/community/to_community_home.action" target="_blank" class="btn btn-default btn-lg">
                    更多学校<i class="mrs-o es-icon es-icon-chevronright"></i>
                </a>
            </div>
        </c:if>
    </div>

</div>


<script  type="text/javascript">
    function toTrainDetail(value){
        window.location.href="${pageContext.request.contextPath}/train/to_train_detail.action?id="+value+"&sign=0";
    }
</script>

<jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
