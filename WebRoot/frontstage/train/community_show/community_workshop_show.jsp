<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:if test="${home}">
    <c:if test="${empty head_title}"><title>求资网</title></c:if>
    <c:if test="${!empty head_title}"><title>${head_title}</title></c:if>
    <jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>
</c:if>
<style>
    .content_tag {
        background-color: #000;
        opacity: 0.5;
        font-size: 12px;
        border-radius: 30px;
        height: 22px;
        min-width: 70px;
        z-index: 99;
        text-align: center;
        color: #fff;
        display: inline-block;
        margin-top: 105px;
        line-height: 22px;
        position: absolute;
        margin-left: 20px;
    }
</style>

<div >

    <!--社区工作坊分类 -->
    <div class="community-container container" style="margin-top: 20px;">
        <div class="tabs-wrapper">

            <div class="tabs-group">

                <ul class="content clearfix" style="margin-left: 0;">
                    <li class="<c:if test="${empty communityCenterView.stage_id}">active</c:if>"><a class="items nav-link" href="javascript:;" data-stage="">全部</a></li>

                    <li class="<c:if test="${communityCenterView.stage_id=='XX'}">active</c:if>"><a class="items nav-link " href="javascript:;" data-stage="XX">小学</a></li>
                    <li class="<c:if test="${communityCenterView.stage_id=='CZ'}">active</c:if>"><a class="items nav-link " href="javascript:;" data-stage="CZ">初中</a></li>
                    <li class="<c:if test="${communityCenterView.stage_id=='GZ'}">active</c:if>"><a class="items nav-link " href="javascript:;" data-stage="GZ">高中</a></li>

                </ul>
            </div>


            <div class="tabs-group">

                <ul class="content clearfix" style="margin-left: 0;">
                    <li class="<c:if test="${empty communityCenterView.subject_id}">active</c:if>">
                        <a class="nav-link items" href="javascript:;" data-subject="">全部</a>
                    </li>
                    <c:forEach items="${subjectList}" var="s" begin="0" end="7">
                        <li class="<c:if test="${communityCenterView.subject_id==s.id}">active</c:if>">
                            <a class="items nav-link tag " href="javascript:;" data-subject="${s.id}">${s.subjectName}</a>
                        </li>
                    </c:forEach>
                </ul>
                <div class="pull-right more_categories" style="margin-top: -32px;cursor: pointer;">
                    <a href="javascript:"><span class="glyphicon glyphicon-chevron-right"></span></a></div>
                <ul class="content clearfix more_categories_list" style="display: none;margin-left: 0;">
                    <c:forEach items="${subjectList}" var="s" begin="8" >
                        <li class="<c:if test="${communityCenterView.subject_id==s.id}">active</c:if>">
                            <a class="items nav-link tag " href="javascript:;" data-subject="${s.id}">${s.subjectName}</a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <div class="cn-filter">
            <ul class="nav nav-sort clearfix">
                <li><a href="javascript:void(0);" onclick="searchSortType(0);"
                       <c:if test="${communityCenterView.sortType==0}">class="active"</c:if>>最新</a></li>
                <li><a href="javascript:void(0);" onclick="searchSortType(1);"
                       <c:if test="${communityCenterView.sortType==1}">class="active"</c:if>>最热</a></li>
                <%--<li><a href="javascript:void(0);" onclick="searchSortType(2);"--%>
                <%--<c:if test="${communityCenterView.sortType==2}">class="active"</c:if>>推荐</a></li>--%>
            </ul>

        </div>
    </div>

    <!--社区工作坊列表 -->
    <div class="course-list container">
        <div class="panel panel-col">
            <div class="panel-body">
                <div class="row">
                    <c:if test="${!empty workshopViews }">
                        <c:forEach items="${workshopViews}" var="workshopView">
                            <div class="col-lg-3 col-md-4 col-xs-6">
                                <div class="course-item">
                                    <div class="course-img">
                                        <a href="${pageContext.request.contextPath}/community/to_community_index.action?sourceType=1&stamp=5&id=${workshopView.id}" target="_blank">
                                            <img src="${pageContext.request.contextPath}${workshopView.img }" style="width:260px;height:155px;" class="img-responsive">
                                            <c:if test="${!empty workshopView.periodName }">
                                            <span class="tags">
                                                <span class="content_tag" >${workshopView.periodName }${workshopView.subjectName }</span>
                                            </span>
                                            </c:if>
                                        </a>
                                    </div>
                                    <div class="course-info text-center workshop_name">
                                        <div class="title">
                                            <span class="mlm"></span>
                                            <a class="link-dark " href="${pageContext.request.contextPath}/community/to_community_index.action?sourceType=1&stamp=5&id=${workshopView.id}" target="_blank">
                                                    ${workshopView.name }
                                            </a>

                                        </div>
                                        <div class="metas clearfix">
                                            <span>坊主:${workshopView.workshop_user }</span>
                                            <span class="num" style="margin-left: 30px;">
                                                <i class="es-icon es-icon-people"></i>${workshopView.user_count }
                                        </span>

                                        </div>
                                    </div>

                                </div>
                            </div>
                        </c:forEach>
                        <div id="test" class="pager" ></div>
                    </c:if>
                    <c:if test="${empty workshopViews }">
                        <div class="empty">抱歉，您想找的工作坊目前还没建立...</div>
                    </c:if>
                </div>

            </div>
        </div>


    </div>



    <form id="communityForm1" action="${pageContext.request.contextPath}/workshop/to_workshop_home_2nd.action" method="post">
        <input type="hidden" name="id" id="id" value="${communityCenterView.id}"/>
        <input type="hidden" name="rows" id="rows" value="${communityCenterView.rows}"/>
        <input type="hidden" name="page" id="page" value="${communityCenterView.page}"/>
        <input type="hidden" name="total" id="total" value="${communityCenterView.total}" />
        <input type="hidden" name="stamp" id="stamp" value="${communityCenterView.stamp}"/>
        <input type="hidden" name="classifyId" id="classifyId" value="${communityCenterView.classifyId}"/>
        <input type="hidden" name="classifyName" id="classifyName" value="${communityCenterView.classifyName}"/>
        <input type="hidden" name="sonClassifyId" id="sonClassifyId" value="${communityCenterView.sonClassifyId}"/>
        <input type="hidden" name="sonClassifyName" id="sonClassifyName" value="${communityCenterView.sonClassifyName}"/>
        <input type="hidden" name="sortType" id="sortType" value="${communityCenterView.sortType}"/>
        <input type="hidden" name="type" id="type" value="${communityCenterView.type}"/>
        <input type="hidden" name="sourceType" id="sourceType" value="${communityCenterView.sourceType}"/>
        <input type="hidden" name="grade_id" id="grade_id" value="${communityCenterView.grade_id}"/>
        <input type="hidden" name="subject_id" id="subject_id" value="${communityCenterView.subject_id}"/>
        <input type="hidden" name="stage_id" id="stage_id" value="${communityCenterView.stage_id}"/>
        <input type="hidden" name="status" id="status" value="${communityCenterView.status}"/>
    </form>

</div>
<c:if test="${home}">
    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
    <script>
        function searchSortType(value){
            $("#page").val(0);
            $("#sortType").val(value);
            $('#communityForm1').submit();
        }

    </script>
</c:if>
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
            $('#communityForm').submit();

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
            var flag1='${home}';
            if(flag1){
                $('#communityForm1').submit();
            }else{
                $('#communityForm').submit();
            }
        }else{
            return flag;

        }

    });

</script>