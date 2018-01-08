<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>



<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/JMEditor/jmeditor/jquery-1.8.3.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/JMEditor/jmeditor/JMEditor.js"></script>

<link href="${pageContext.request.contextPath}/frontstage/css/xbjy.css" rel="stylesheet" type="text/css">
<script type="text/javascript"
        src="${pageContext.request.contextPath}/frontstage/js/My97DatePicker/WdatePicker.js"></script>
<link href="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.js"></script>
<script>


    $(function(){
        $(".more_categories").click(function(){
            if($(this).next().css("display")=='none'){
                $(".more_categories_list").slideUp();
                $(this).next().slideDown();
                $(".more_categories").find("a").find("span").removeClass("glyphicon-chevron-down").addClass("glyphicon-chevron-right");
                $(this).find("a").find("span").removeClass("glyphicon-chevron-right").addClass("glyphicon-chevron-down");
            }else{
                $(".more_categories_list").slideUp();
                $(".more_categories").find("a").find("span").removeClass("glyphicon-chevron-down").addClass("glyphicon-chevron-right");
            }

        })
    });

</script>


<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<div class="cn-wrap " style="background-color: #f3f3f3;">


    <div id="content-container" class="container" >

        <!-- 分类 -->
        <div class="tabs-wrapper" style="margin-top: 20px;">

            <div class="tabs-group">
                <div class="title " style="width: 50px;">学段</div>
                <ul class="content " style="margin-left: 50px;">
                    <li><a class="items nav-link <c:if test="${empty lessonView.stage_id}">text-info</c:if>" href="javascript:;" data-stage="">全部</a></li>
                    <li><a class="items nav-link <c:if test="${lessonView.stage_id=='XX'}">text-info</c:if>" href="javascript:;" data-stage="XX">小学</a></li>
                    <li><a class="items nav-link <c:if test="${lessonView.stage_id=='CZ'}">text-info</c:if>" href="javascript:;" data-stage="CZ">初中</a></li>
                    <li><a class="items nav-link <c:if test="${lessonView.stage_id=='GZ'}">text-info</c:if>" href="javascript:;" data-stage="GZ">高中</a></li>
                </ul>
            </div>
            <div class="tabs-group">
                <div class="title" style="width: 50px;">年级</div>
                <ul class="content " style="margin-left: 50px;">
                    <li class="<c:if test="${empty lessonView.grade_id}">active</c:if>"><a class="nav-link items" href="#" data-grade="">全部</a></li>
                    <c:if test="${lessonView.stage_id=='XX'||empty lessonView.stage_id}">
                        <li ><a class="items nav-link tag <c:if test="${lessonView.grade_id=='1'}">text-info</c:if>" href="javascript:;" data-grade="1">一年级</a></li>
                        <li ><a class="items nav-link tag <c:if test="${lessonView.grade_id=='2'}">text-info</c:if>" href="javascript:;" data-grade="2">二年级</a></li>
                        <li ><a class="items nav-link tag <c:if test="${lessonView.grade_id=='3'}">text-info</c:if>" href="javascript:;" data-grade="3">三年级</a></li>
                        <li ><a class="items nav-link tag <c:if test="${lessonView.grade_id=='4'}">text-info</c:if>" href="javascript:;" data-grade="4">四年级</a></li>
                        <li ><a class="items nav-link tag <c:if test="${lessonView.grade_id=='5'}">text-info</c:if>" href="javascript:;" data-grade="5">五年级</a></li>
                        <li ><a class="items nav-link tag <c:if test="${lessonView.grade_id=='6'}">text-info</c:if>" href="javascript:;" data-grade="6">六年级</a></li>
                    </c:if>
                    <c:if test="${lessonView.stage_id=='CZ'}">
                        <li ><a class="items nav-link tag <c:if test="${lessonView.grade_id=='7'}">text-info</c:if>" href="javascript:;" data-grade="7">七年级</a></li>
                        <li><a class="items nav-link tag <c:if test="${lessonView.grade_id=='8'}">text-info</c:if>"  href="javascript:;" data-grade="8">八年级</a></li>
                        <li ><a class="items nav-link tag <c:if test="${lessonView.grade_id=='9'}">text-info</c:if>" href="javascript:;" data-grade="9">九年级</a></li>
                    </c:if>
                    <c:if test="${lessonView.stage_id=='GZ'}">
                        <li class=""><a class="items nav-link tag <c:if test="${lessonView.grade_id=='10'}">text-info</c:if>"   href="javascript:;" data-grade="10">一年级</a></li>
                        <li class=""><a class="items nav-link tag <c:if test="${lessonView.grade_id=='11'}">text-info</c:if>" href="javascript:;" data-grade="11">二年级</a></li>
                        <li class=""><a class="items nav-link tag <c:if test="${lessonView.grade_id=='12'}">text-info</c:if>" href="javascript:;" data-grade="12">三年级</a></li>
                    </c:if>
                </ul>
            </div>

            <div class="tabs-group">
                <div class="title" style="width: 50px;">学科</div>
                <ul class="content " style="margin-left: 50px;">
                    <li class="<c:if test="${empty lessonView.subject_id}">active</c:if>">
                        <a class="nav-link items" href="javascript:void(0);" data-subject="">全部</a>
                    </li>
                    <c:forEach items="${subjectList}" var="s" begin="0" end="9">
                        <li class=""><a class="items nav-link tag <c:if test="${lessonView.subject_id==s.id}">text-info</c:if>" href="javascript:;" data-subject="${s.id}">${s.subjectName}</a></li>
                    </c:forEach>
                </ul>
                <div class="pull-right more_categories" style="margin-top: -32px;cursor: pointer;">
                    <a href="javascript:"><span class="glyphicon glyphicon-chevron-right"></span></a>
                </div>
                <ul class="content  more_categories_list" style="padding-left: 15px;display: none;">
                    <c:forEach items="${subjectList}" var="s" begin="10" >
                        <li class=""><a class="items nav-link tag <c:if test="${lessonView.subject_id==s.id}">text-info</c:if>" href="javascript:;" data-subject="${s.id}">${s.subjectName}</a></li>
                    </c:forEach>
                </ul>
            </div>

            <div class="tabs-group">
                <div class="title" style="width: 50px;">教材</div>
                <ul class="content" style="margin-left: 50px;">
                    <li class="<c:if test="${empty lessonView.press_id}">active</c:if>">
                        <a class="nav-link items" href="javascript:void(0);" data-press="">全部</a>
                    </li>
                    <c:forEach items="${editionList}" var="e" begin="0"  end="5">
                        <li class=""><a class="items nav-link tag <c:if test="${lessonView.press_id==e.id}">text-info</c:if>" href="javascript:;" data-press="${e.id }">${e.versionName }</a></li>
                    </c:forEach>
                </ul>
                <div class="pull-right more_categories" style="margin-top: -32px;cursor: pointer;"><a href="javascript:"><span class="glyphicon glyphicon-chevron-right"></span></a></div>
                <ul class="content clearfix more_categories_list" style="padding-left: 15px;display: none;">
                    <c:forEach items="${editionList}" var="e" begin="6">
                        <li class=""><a class="items nav-link tag <c:if test="${lessonView.press_id==e.id}">text-info</c:if>" href="javascript:;" data-press="${e.id }">${e.versionName }</a></li>
                    </c:forEach>

                </ul>
            </div>

            <div class="tabs-group">
                <div class="title" style="width: 50px;">区域</div>
                <ul class="content  " style="margin-left: 50px;">
                    <li><a class="items nav-link tag" href="javascript:;">全国</a></li>
                    <li><a class="items nav-link tag" href="javascript:;">北京</a></li>
                    <li><a class="items nav-link tag" href="javascript:;">天津</a></li>
                    <li><a class="items nav-link tag" href="javascript:;">河北</a></li>
                    <li><a class="items nav-link tag" href="javascript:;">辽宁</a></li>
                    <li><a class="items nav-link tag" href="javascript:;">吉林</a></li>
                    <li><a class="items nav-link tag" href="javascript:;">山西</a></li>
                    <li><a class="items nav-link tag" href="javascript:;">湖南</a></li>
                    <li><a class="items nav-link tag" href="javascript:;">安徽</a></li>
                    <li><a class="items nav-link tag" href="javascript:;">江苏</a></li>
                    <li><a class="items nav-link tag" href="javascript:;">贵州</a></li>
                    <li><a class="items nav-link tag" href="javascript:;">重庆</a></li>
                    <li><a class="items nav-link tag" href="javascript:;">浙江</a></li>
                    <li ><a class="items nav-link tag" href="javascript:;">黑龙江</a></li>
                    <li ><a class="items nav-link tag" href="javascript:;">湖北</a></li>
                    <li ><a class="items nav-link tag" href="javascript:;">四川</a></li>
                </ul>

                <div class="pull-right more_categories" style="margin-top: -32px;cursor: pointer;">
                    <a href="javascript:"><span class="glyphicon glyphicon-chevron-right"></span></a>
                </div>

                <ul class="content more_categories_list" style="padding-left: 15px;display: none;">

                    <li ><a class="items nav-link tag" href="javascript:;">上海</a></li>
                    <li ><a class="items nav-link tag" href="javascript:;">福建</a></li>
                    <li ><a class="items nav-link tag" href="javascript:;">江西</a></li>
                    <li><a class="items nav-link tag" href="javascript:;">山东</a></li>
                    <li ><a class="items nav-link tag"  href="javascript:;">河南</a></li>
                    <li><a class="items nav-link tag"  href="javascript:;">广东</a></li>
                    <li ><a class="items nav-link tag" href="javascript:;">海南</a></li>
                    <li ><a class="items nav-link tag" href="javascript:;">云南</a></li>
                    <li ><a class="items nav-link tag" href="javascript:;">陕西</a></li>
                    <li ><a class="items nav-link tag" href="javascript:;">甘肃</a></li>
                    <li ><a class="items nav-link tag" href="javascript:;">陕西</a></li>
                    <li ><a class="items nav-link tag" href="javascript:;">青海</a></li>
                    <li ><a class="items nav-link tag" href="javascript:;">台湾</a></li>
                    <li ><a class="items nav-link tag" href="javascript:;">内蒙古</a></li>
                    <li><a class="items nav-link tag" href="javascript:;">广西</a></li>
                    <li ><a class="items nav-link tag" href="javascript:;">宁夏</a></li>
                    <li ><a class="items nav-link tag" href="javascript:;">新疆</a></li>
                    <li ><a class="items nav-link tag" href="javascript:;">西藏</a></li>
                </ul>
            </div>

        </div>

        <div class="cn-filter">

            <ul class="nav nav-sort clearfix">

                <li><a href="javascript:;"  class="<c:if test="${lessonView.sort=='create_time'}">active </c:if> items" data-sort="create_time">最新</a></li>
                <li><a href="javascript:;"  class="<c:if test="${lessonView.sort=='scan_count'}">active </c:if> items" data-sort="scan_count">最热</a></li>
                <%--<li><a href="javascript:;" class="<c:if test="${lessonView.sort=='recommended'}">active </c:if> items" data-sort="recommended">推荐</a></li>--%>
            </ul>

            <div class="filter hidden-xs" style="width: 350px;">

                <label class="checkbox-inline">
                    <!--分类为已完成课例添加class为text-info-->
                    <span class="<c:if test="${lessonView.list=='finish'}">text-info</c:if> items" data-list="finish">已完成课例</span>
                </label>
                <label class="checkbox-inline items">
                    <span class="<c:if test="${lessonView.list=='unfinish'}">text-info</c:if> items" data-list="unfinish">未完成课例</span>
                </label>
                <label class="checkbox-inline items">
                    <span class="<c:if test="${lessonView.list=='best'}">text-info</c:if> items" data-list="best">优秀课例</span>
                </label>
            </div>
        </div>
        <form id="lessonForm" action="${pageContext.request.contextPath}/lesson_main/to_lesson_main.action" method="post">
            <input type="hidden" name="page" id="page" value="${lessonView.page}"/>
            <input type="hidden" name="rows" id="rows" value="${lessonView.rows}"/>
            <input type="hidden" name="total" id="total" value="${lessonView.total}"/>
            <input type="hidden" name="totalPage" id="totalPage" value="${lessonView.totalPage}"/>
            <input type="hidden" name="press_id" id="press_id" value="${lessonView.press_id}"/>
            <input type="hidden" name="grade_id" id="grade_id" value="${lessonView.grade_id}"/>
            <input type="hidden" name="subject_id" id="subject_id" value="${lessonView.subject_id}"/>
            <input type="hidden" name="stage_id" id="stage_id" value="${lessonView.stage_id}"/>
            <input type="hidden" name="list" id="list" value="${lessonView.list}"/>
            <input type="hidden" name="sort" id="sort" value="${lessonView.sort}"/>
        </form>

        <!-- 课例展示目录 -->

        <div class="course-list clearfix" >

            <c:forEach items="${lessonViews }" var="l">
                <div class="col-lg-3 col-md-4 col-xs-6">
                        <div class="course-item">

                            <div class="course-img">
                                <a href="${pageContext.request.contextPath}/lesson_main/to_lesson.action?id=${l.id }" target="_blank">
                                    <img <c:if test="${empty l.lesson_pic}">src="${pageContext.request.contextPath}/frontstage/images/course.png"</c:if>
                                         <c:if test="${!empty l.lesson_pic}">src="${pageContext.request.contextPath}/${l.lesson_pic}"</c:if>  alt="" class="img-responsive" style="height: 160px;">

                                </a>
                                <c:if test="${l.excellent==1}">
                                       <span class="text-center good_lesson">
                                           &nbsp;&nbsp;优
                                       </span>
                                </c:if>
                            </div>

                            <div class="course-info" style="left:0;padding:5px 10px;">

                                <div class="lesson_info_text">
                                    <span class="lesson_grade">${l.stageName }${l.subjectName }</span>
                                    <span class="lesson_teacher pull-right">主讲教师:&nbsp;${l.user_sk_name }</span>
                                </div>

                                <a class="link-dark" href="${pageContext.request.contextPath}/lesson_main/to_lesson.action?id=${l.id }" target="_blank" style="padding:5px;">
                                    <div title="${l.name }">${l.name }</div>
                                    <div title="${l.workshop_name }工作坊">${l.workshop_name }</div>
                                </a>

                                <div class="text-muted lesson_target">
                                    目标：${l.research }
                                </div>
                            </div>

                            <div class="progress" style="margin:10px;max-width: 245px;">
                                <c:if test="${l.finish_count/l.all_count>=0.11 }">
                                    <c:set var="width" value="${l.finish_count/l.all_count }"></c:set>
                                </c:if>
                                <c:if test="${l.finish_count/l.all_count<0.11 }">
                                    <c:set var="width" value="0.11"></c:set>
                                </c:if>
                                <div class="progress-bar progress-bar-success"  role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width:<fmt:formatNumber type="percent" maxFractionDigits="3" value="${width }" />"><fmt:formatNumber type="percent" maxFractionDigits="0" value="${l.finish_count/l.all_count }" /></div>
                                <span class="pull-right">${l.finish_count}/${l.all_count}</span>
                            </div>

                        </div>
                    </div>
            </c:forEach>

        </div>

            <c:if test="${empty lessonViews }">
                <div class="empty" style="min-height: 300px;">抱歉，你搜索条件暂时没有课例...</div>
            </c:if>
            <c:if test="${!empty lessonViews }">
                <div id="test" class="pager"></div>

            </c:if>
        </div>

    </div>

</div>

<jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>


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
                $('#lessonForm').submit();

            }
        });

        $(".items").click(function () {
            var flag=false;
            var press=$(this).data("press");
            var subject=$(this).data("subject");
            var grade=$(this).data("grade");
            var stage=$(this).data("stage");
            var list=$(this).data("list");
            var sort=$(this).data("sort");
            if(press!=null){
                flag=true;
                $("#press_id").val(press);
            }
            if(subject!=null){
                $("#subject_id").val(subject);
                flag=true;
            }
            if(grade!=null){
                $("#grade_id").val(grade);
                flag=true;
            }
            if(stage!=null){
                $("#stage_id").val(stage);
                flag=true;
            }
            if(list!=null){
                $("#list").val(list);
                flag=true;
            }
            if(sort!=null){
                $("#sort").val(sort);
                flag=true;
            }
            if(flag){
                $('#lessonForm').submit();
            }else{
                return flag;

            }

        });

    });
</script>

