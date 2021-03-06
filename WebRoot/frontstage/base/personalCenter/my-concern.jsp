<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>
<link href="${pageContext.request.contextPath}/frontstage/css/my-space.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/frontstage/css/teaching-center.css" rel="stylesheet" type="text/css">


<div class="cn-wrap">

    <div id="content-container" class="container">

        <jsp:include page="/frontstage/base/personalCenter/personal_header.jsp"></jsp:include>

        <div class="row">

            <jsp:include page="/frontstage/base/personalCenter/personal_left.jsp"></jsp:include>

            <div class="col-md-9">

                <form  id="form" action="" method="post">

                    <input type="hidden" name="page" id="page" value="${userAttent.page}"/>
                    <input type="hidden" name="rows" id="rows" value="${userAttent.rows}"/>
                    <input type="hidden" name="total" id="total" value="${userAttent.total}"/>
                    <input type="hidden" name="totalPage" id="totalPage" value="${userAttent.totalPage}"/>
                    <input type="hidden" id="type" name = "type" value="${type }">

                </form>

                <form id="dz_my_attention" action="" method="post"></form>
                <form id="dz_my_fans" action="" method="post"></form>

                <div class="panel panel-default panel-col">
                    <div class="panel-heading">我的关注</div>

                    <div class="panel-body"  >

                        <ul class="nav nav-tabs" >
                            <li class="<c:if test="${type==1 }">active</c:if>" onclick="myAttention()">
                                <a href="javascript:void(0);">我关注的人
                                    <small class="text-muted">( ${userProperty.attent_count } )</small>
                                </a>
                            </li>
                            <li class="<c:if test="${type==2 }">active</c:if>" onclick="myFans()" >
                                <a href="javascript:void(0);">我的粉丝
                                    <small class="text-muted">( ${userProperty.is_attented_count } )</small>
                                </a>
                            </li>

                        </ul>


                        <div class="concern_main" >

                            <%--我的关注--%>
                            <c:if test="${type==1 }">
                                <div class="row" >

                                    <c:if test="${empty  myAttention}">
                                        <div class="empty">暂无数据</div>
                                    </c:if>

                                    <c:forEach items="${myAttention }" var="m">
                                        <div class="col-lg-4 col-md-4 col-xs-6 attent" >
                                            <div class="teacher-item">
                                                <div class="teacher-top">
                                                    <a class="teacher-img" href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id=${m.id}" style="height: 60px;display: inline-block;">
                                                        <img class="avatar-md" src="${pageContext.request.contextPath}${m.img}">
                                                    </a>
                                                    <h3 class="title">
                                                        <a class="link-dark" href="javascript:void(0);"> ${m.realName }</a>
                                                    </h3>
                                                    <div class="position">

                                                        工作地址
                                                        <span class="empty" style="display: none;">暂无</span>

                                                    </div>
                                                </div>

                                                <div class="teacher-bottom">
                                                    <div class="about">
                                                            ${m.titles }
                                                        <span class="empty" style="display: none;">暂无</span>
                                                    </div>
                                                    <div class="metas" >
                                                        <a class="btn btn-primary btn-sm follow-btn" href="javascript:void(0);"  onclick="qx(${m.id })">取消关注</a>

                                                        <a class="btn btn-default btn-sm" href="#private-modal" data-toggle="modal" >私信</a>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>


                                    </c:forEach>

                                </div>
                                <c:if test="${!empty myAttention}">

                                    <div id="test" class="pager"></div>
                                </c:if>
                            </c:if>



                            <%--我的粉丝--%>
                            <c:if test="${type==2 }">
                                <div class="row" >

                                    <c:if test="${empty  myFans}">
                                        <div class="empty">暂无数据</div>

                                    </c:if>

                                    <c:forEach items="${myFans }" var="m">
                                        <div class="col-lg-4 col-md-4 col-xs-6 attent" >
                                            <div class="teacher-item">
                                                <div class="teacher-top">
                                                    <a class="teacher-img" href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id=${m.id}" style="height: 60px;display: inline-block;">
                                                        <img class="avatar-md" src="${pageContext.request.contextPath}${m.img }">
                                                    </a>
                                                    <h3 class="title">
                                                        <a class="link-dark" href="javascript:void(0);"> ${m.realName }</a>
                                                    </h3>
                                                    <div class="position">
                                                        工作地址
                                                        <span class="empty" style="display: none;">暂无</span>

                                                    </div>
                                                </div>

                                                <div class="teacher-bottom">
                                                    <div class="about">
                                                            ${m.titles }
                                                        <span class="empty" style="display: none;">暂无</span>
                                                    </div>
                                                    <div class="metas" >
                                                        <a class="btn btn-primary btn-sm follow-btn" href="javascript:void(0);"  >关注</a>

                                                        <a class="btn btn-default btn-sm" href="#private-modal" data-toggle="modal" >私信</a>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>


                                    </c:forEach>

                                    <c:if test="${!empty myFans}">

                                        <div id="test" class="pager "></div>

                                    </c:if>
                                </div>
                            </c:if>
                        </div>


                    </div>


                </div>

            </div>

        </div>
    </div>
    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
</div>



<script type="text/javascript">
    function myAttention(){
        //alert(1111);
        $("#type").val(1);
        $("#page").val(0);
        //<c:if test="${type==1 }">"${pageContext.request.contextPath}/my_attention/showMyAttention.action"</c:if> <c:if test="${type==2 }">"${pageContext.request.contextPath}/my_attention/showMyFans.action"</c:if>
        var url="${pageContext.request.contextPath}/my_attention/showMyAttention.action"
        $("#form").attr("action",url);
        $("#form").submit();

    }
    function myFans(){
        $("#type").val(2);
        $("#page").val(0);
        var url="${pageContext.request.contextPath}/my_attention/showMyFans.action"
        $("#form").attr("action",url);
        $("#form").submit();

    }
    function dzMyAttention(id,value){
        if(value==0){
            var url="${pageContext.request.contextPath}/my_attention/dzMyAttention.action?type=1&dz="+id+"&page="+$("#page").val();
            $("#dz_my_attention").attr("action",url);
            $("#dz_my_attention").submit();
        }else{
            alert("已经点过赞了!");
        }

    }
    function dzMyFans(id,value){
        if(value==0){
            var url="${pageContext.request.contextPath}/my_attention/dzMyAttention.action?type=2&dz="+id+"&page="+$("#page").val();
            $("#dz_my_fans").attr("action",url);
            $("#dz_my_fans").submit();
        }else{
            alert("已经点过赞了!");
        }

    }
    function qx(value){

        $.ajax({

            url : "/edu_yun/attent/delete_attent.action?user_id="+value,
            dataType:'json',
            success : function(response) {
                alert(response.msg);
                location=location;
            },
            error :function(response) {

            }
        });


    }

</script>
<script>

    function _searchLeft(){
        var page = $("#page").val();
        if(page!=0){
            $("#page").val(page-1);
            $('#form').submit();
        }
    }
    function _searchRight(){
        var page =  parseInt($("#page").val())+1;
        var total = $("#total").val();
        if(page<total){
            $("#page").val(page);
            $('#form').submit();
        }
    }

</script>
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
            pageSize: 10,           //一页记录数
            onPageChange: function (page) {
                document.title = page;
                $("#page").val(page-1);
                $('#form').submit();

            }
        });
    });

    //我的粉丝页面布局
    $(function(){
        window.status = "put your message here"
        $(".concern_page:odd").css("margin-left","380px");
        $(".concern_page:odd").css("margin-top","-140px");

    });
</script>







