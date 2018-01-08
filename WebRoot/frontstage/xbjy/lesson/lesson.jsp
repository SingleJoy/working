<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>
<link href="${pageContext.request.contextPath}/frontstage/css/xbjy.css" rel="stylesheet" type="text/css">

<div class="cn-wrap">

    <div id="content-container" class="container">
        <c:if test="${!empty workshopView.id}">
            <jsp:include page="../../train/community/workshop_header.jsp"></jsp:include>
        </c:if>
        <c:if test="${empty workshopView.id}">
            <jsp:include page="../../train/community/community_header.jsp"></jsp:include>
        </c:if>

        <div class="row row-3-9">
            <c:if test="${!empty workshopView.id}">
                <jsp:include page="../../train/community/workshop_left.jsp"></jsp:include>
            </c:if>
            <c:if test="${empty workshopView.id}">
                <jsp:include page="../../train/community/community_left.jsp"></jsp:include>
            </c:if>

            <div class="col-lg-9 col-md-9  course-detail-main" >


                <div class="panel panel-default panel-col">
                    <div class="panel-heading">
                        <c:if test="${lessonView.source_type==1}">
                        <c:if test="${workshopView.user_count>1}">
                            <a href="${pageContext.request.contextPath}/lesson/to_create_lesson.action?source_id=${lessonView.workshop_id}" class="btn btn-info pull-right">创建课例</a>
                        </c:if>
                        <c:if test="${workshopView.user_count<2}">
                            <a href="javascript:void(0)" class="btn btn-info pull-right count1">创建课例</a>
                        </c:if>
                        </c:if>
                        课例列表</div>

                    <c:if test="${!empty lessonList }">
                        <div class="panel-body">
                            <form id="lessonForm" action="${pageContext.request.contextPath}/lesson/to_lesson.action" method="post" class="form-horizontal form-inline well well-sm" >
                                <div class="form-group">
                                    <input type="text"   class="form-control" value="${lessonView.search}" placeholder="关键词"  id="search" name="search">
                                    <button  class="btn btn-primary btn-sm" id="search_btn">搜索</button>
                                </div>
                                <input type="hidden" name="page" id="page" value="${lessonView.page}"/>
                                <input type="hidden" name="rows" id="rows" value="${lessonView.rows}"/>
                                <input type="hidden" name="total" id="total" value="${lessonView.total}"/>
                                <input type="hidden" name="totalPage" id="totalPage" value="${lessonView.totalPage}"/>
                                <input type="hidden" name="community_id" id="community_id" value="${lessonView.community_id}"/>
                                <input type="hidden" name="workshop_id" id="workshop_id" value="${lessonView.workshop_id}"/>
                                <input type="hidden" name="source_type" id="source_type" value="${lessonView.source_type}"/>
                                <input type="hidden" name="sort" id="sort" value="${lessonView.sort}"/>
                                <input type="hidden" name="order" id="order" value="${lessonView.order}"/>


                                <table class="table table-striped">
                                    <!--默认箭头向下,即caret,点击重新排序之后箭头向上,即caret_01-->
                                    <tbody>
                                    <tr>
                                        <th  width="4%"><input type="checkbox" class="checkAll subCheckbox"></th>
                                        <th  width="15%">课例名称</th>
                                        <th width="10%" >组长</th>
                                        <th width="13%" >所属工作坊</th>
                                        <th width="8%" >年级</th>
                                        <th width="8%" >学科</th>
                                        <th  width="12%">创建日期<c:if test="${lessonView.sort=='l.create_time' }">
                                            <c:if test="${lessonView.order!='desc'}"><span  class="caret_01"  data-sort="l.create_time"></span></c:if>
                                            <c:if test="${lessonView.order=='desc'}"><span  class="caret"  data-sort="l.create_time"></span></c:if>
                                        </c:if>
                                            <c:if test="${lessonView.sort!='l.create_time' }"><span  class="caret"  data-sort="l.create_time"></span></c:if></th>
                                        <th width="6%" >推荐</th>
                                        <th  width="10%">状态<c:if test="${lessonView.sort=='l.open_status' }">
                                            <c:if test="${lessonView.order!='desc'}"><span  class="caret_01"  data-sort="l.open_status"></span></c:if>
                                            <c:if test="${lessonView.order=='desc'}"><span  class="caret"  data-sort="l.open_status"></span></c:if>
                                        </c:if>
                                            <c:if test="${lessonView.sort!='l.open_status' }"><span  class="caret"  data-sort="l.open_status"></span></c:if></th>
                                        <th >
                                            <div class="btn-group" >
                                                <a href="#" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown">管理</a>
                                                <button type="button" class="btn btn-default dropdown-toggle btn-sm" data-toggle="dropdown" aria-expanded="false">
                                                    <span class="caret"></span>
                                                </button>

                                            </div>
                                        </th>
                                    </tr>
                                    <c:forEach items="${lessonList}" var="lesson">
                                        <tr>
                                            <td ><input type="checkbox" class="subCheckbox" value="${lesson.id}"></td>
                                            <td><a href="${pageContext.request.contextPath}/lesson/to_lesson_plan.action?lesson_id=${lesson.id}&show=1&stamp=0&state=101">${lesson.name }</a></td>
                                            <td>${lesson.lesson_username }</td>
                                            <td>${lesson.workshop_name }</td>
                                            <td>${lesson.grade }</td>
                                            <td>${lesson.subject }</td>
                                            <td>${fn:substring(lesson.create_time, 0, 10)}</td>
                                            <td>
                                                <c:if test="${lesson.recommended==0 }">否</c:if>
                                                <c:if test="${lesson.recommended!=0 }">是</c:if>
                                            </td>
                                            <c:if test="${lesson.open_status!=0}"><td class="text-danger">已关闭</td></c:if>
                                            <c:if test="${lesson.open_status==0}"><td class="text-info">已开启</td></c:if>

                                            <td>
                                                <c:if test="${lesson.open_status!=0}"><span class="text-info openStatus" onclick="openOrClose(0,${lesson.id})" style="cursor: pointer;">开启</span>
                                                </c:if>
                                                <c:if test="${lesson.open_status==0}"><span class="text-info closeStatus" onclick="openOrClose(1,${lesson.id})" style="cursor: pointer;">关闭</span>
                                                </c:if>
                                                <span class="text-info openStatus" onclick="toLesson(${lesson.id})" style="cursor: pointer;">管理</span>
                                                <c:if test="${lesson.recommended==0 }"> <span class="text-info recommended"  style="cursor: pointer;" data-lesson="${lesson.id}">推荐</span></c:if>
                                                <c:if test="${lesson.recommended!=0 }"><span class="text-info unrecommended"  style="cursor: pointer;" data-lesson="${lesson.id}">取消推荐</span></c:if>

                                            </td>
                                        </tr>

                                    </c:forEach>

                                    </tbody>
                                </table>

                            </form>
                            <div id="test" class="pager" style="clear: both;"></div>
                        </div>
                    </c:if>

                    <c:if test="${empty lessonList }">
                        <div class="empty">还没有任何课例，快去新建课例吧！</div>
                    </c:if>
                </div>


            </div>

        </div>
    </div>

    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
</div>



<script type="text/javascript">
    //排序
    $(document).on("click",".caret_01",function(){
        $(this).attr("class","caret");
        var sort=$(this).data("sort");
        list(sort,"desc");
    });
    $(document).on("click",".caret",function(){
        $(this).attr("class","caret_01");
        var sort=$(this).data("sort");
        list(sort,"asc");
    });
    //排序点击
    function list(sort,order){

        var form=$("#lessonForm");//定义一个form表单
        $("#sort").val(sort);
        $("#order").val(order);

        form.submit();//表单提交 });

    }
    // 全选
    $(".checkAll").click(function () {
        var isChecked = $(this).prop("checked");
        $(".subCheckbox").prop("checked", isChecked);
    });
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
    });
    //开启关闭
    function openOrClose(open_status,ids){
        $.ajax({
            type: 'POST',
            url : '${pageContext.request.contextPath}/lesson/openOrClose.action',
            dataType: "json",
            data:{
                ids:ids,
                open_status:open_status,
            },
            success : function(response) {
                var href=location.href;
                location.replace(href);
            }
        });
    };
    function toLesson(id) {
        var href='${pageContext.request.contextPath}/lesson/to_lesson_user_identity.action?lesson_id='+id;
        location.replace(href);
    };

    function toCourseDetail(value){
//        window.location.href="${pageContext.request.contextPath}/user_study/to_course_study.action?page=1&learnId="+value+"&sourceType=0&tab=1";
    }
    $(".recommended").click(function () {
        var source_id=  $(this).data("lesson");
        $("#recommended_source_id").val(source_id);
        $("#recommended_source_type").val(5);
        $("#recommended_modal").modal("show");

    });
    $(".unrecommended").click(function () {
        var source_id=  $(this).data("lesson");
        unrecommended(source_id,5);

    });
	$(".count1").click(function () {
		alert("工作坊人数不足2人");
	})
</script>
