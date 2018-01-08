<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<div class="cn-wrap">

    <div id="content-container" class="container">

        <jsp:include page="community_header.jsp"></jsp:include>

        <div class="row row-3-9">

            <jsp:include page="community_left.jsp"></jsp:include>

            <div class="col-lg-9 col-md-8  course-detail-main" >

                <div class="panel panel-default panel-col course-data">
                    <div class="panel-heading">

                        <a href="${pageContext.request.contextPath}/workshop/to_add_workshop.action?community_id=${communityView.id}&source_type=0" class="btn btn-info pull-right">添加工作坊</a>
                        工作坊列表
                    </div>
                    <c:if test="${!empty workshopViews }">
                        <div class="panel-body">
                            <form method="post"  class="form-horizontal form-inline well well-sm" action="${pageContext.request.contextPath}/workshop/to_workshop.action?community_id=${communityView.id}&source_type=0">

                                <div class="form-group">
                                    <input type="text"   class="form-control" value="" placeholder="关键词"  id="search" name="search">
                                    <button  class="btn btn-primary btn-sm" id="search_btn">搜索</button>
                                </div>

                                <table class="table table-striped">
                                    <!--默认箭头向下,即caret,点击重新排序之后箭头向上,即caret_01-->
                                    <tbody>
                                    <tr>
                                        <th  width="2%;"><input type="checkbox" class="checkAll subCheckbox"></th>
                                        <th  width="20%">工作坊</th>
                                        <th  width="10%">坊主</th>
                                        <th  width="8%">学段</th>
                                        <th  width="8%">学科</th>
                                        <th  width="8%">人数<c:if test="${workshopView.sort=='user_count' }">
                                            <c:if test="${workshopView.order!='desc'}"><span class="caret_01"  data-sort="user_count"></span></c:if>
                                            <c:if test="${workshopView.order=='desc'}"><span class="caret"  data-sort="user_count"></span></c:if>
                                        </c:if>
                                            <c:if test="${workshopView.sort!='user_count' }"><span class="caret"  data-sort="user_count"></span></c:if>
                                        </th>
                                        <th  width="11%">创建日期<c:if test="${workshopView.sort=='w.create_time' }">
                                            <c:if test="${workshopView.order!='desc'}"><span class="caret_01" data-sort="w.create_time"></span></c:if>
                                            <c:if test="${workshopView.order=='desc'}"><span class="caret" data-sort="w.create_time"></span></c:if>
                                            </c:if>
                                            <c:if test="${workshopView.sort!='w.create_time' }"><span class="caret" data-sort="w.create_time"></span></c:if>
                                        <th width="6%" >推荐</th>
                                        <th  width="10%">状态<c:if test="${workshopView.sort=='w.status' }">
                                            <c:if test="${workshopView.order!='desc'}"><span class="caret_01" data-sort="w.status"></span></c:if>
                                            <c:if test="${workshopView.order=='desc'}"><span class="caret" data-sort="w.status"></span></c:if>
                                        </c:if>
                                            <c:if test="${workshopView.sort!='w.status' }"><span  class="caret"  data-sort="w.status"></span></c:if></th>
                                        <th>
                                            <div class="btn-group">
                                                <a href="javascript:void(0);" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown">操作</a>
                                                <button type="button" class="btn btn-default dropdown-toggle btn-sm" data-toggle="dropdown" aria-expanded="false">
                                                    <span class="caret"></span>
                                                </button>
                                                <ul class="dropdown-menu pull-right" role="menu">
                                                    <li><a href="javascript:void (0);">置顶</a></li>
                                                    <li><a href="javascript:void (0);" onclick="openOrClose(0)">开启</a></li>
                                                    <li><a href="javascript:void (0);" onclick="openOrClose(1)">关闭</a></li>
                                                </ul>
                                            </div>
                                        </th>
                                    </tr>
                                    <c:forEach items="${workshopViews}" var="workshopView">
                                        <tr>
                                            <td ><input type="checkbox" class="subCheckbox" value="${workshopView.id}"></td>
                                            <td>${workshopView.name }</td>
                                            <td title="${workshopView.workshop_user }" style="cursor: pointer;">${fn:split(workshopView.workshop_user, ',')[0]}</td>
                                            <td>${workshopView.periodName }</td>
                                            <td>${workshopView.subjectName }</td>
                                            <td>${workshopView.user_count }</td>
                                            <td><fmt:formatDate type="date" value="${workshopView.create_time }" /></td>
                                            <td>
                                                <c:if test="${workshopView.recommended==0 }">否</c:if>
                                                <c:if test="${workshopView.recommended!=0 }">是</c:if>
                                            </td>
                                            <c:if test="${workshopView.status==1}"><td class="text-danger">已关闭</td></c:if>
                                            <c:if test="${workshopView.status==0}"><td class="text-info">已开启</td></c:if>

                                            <td>
                                                <c:if test="${workshopView.status==1}"><span class="text-info openStatus" onclick="openOrClose(0,${workshopView.id})" style="cursor: pointer;">开启</span>
                                                </c:if>
                                                <c:if test="${workshopView.status==0}"><span class="text-info closeStatus" onclick="openOrClose(1,${workshopView.id})" style="cursor: pointer;">关闭</span>
                                                </c:if>
                                                <c:if test="${workshopView.recommended==0 }"><span class="text-info recommended"  style="cursor: pointer;" data-workshop="${workshopView.id}">推荐</span></c:if>
                                                <c:if test="${workshopView.recommended!=0 }"><span class="text-info unrecommended"  style="cursor: pointer;" data-workshop="${workshopView.id}">取消推荐</span></c:if>

                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>

                            </form>
                            <div id="test" class="pager" ></div>
                        </div>
                    </c:if>
                    <c:if test="${empty workshopViews }">
                        <div class="empty"> 竟然还没有工作坊，快去建立工作坊吧！</div>
                    </c:if>
                </div>
            </div>

        </div>
    </div>
    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
</div>

<form id="communityForm" action="${pageContext.request.contextPath}/workshop/to_workshop.action" method="post">
    <input type="hidden" name="id" id="id" value="${workshopView.id}"/>
    <input type="hidden" name="rows" id="rows" value="${workshopView.rows}"/>
    <input type="hidden" name="community_id" id="community_id" value="${workshopView.community_id}"/>
    <input type="hidden" name="page" id="page" value="${workshopView.page}"/>
    <input type="hidden" name="total" id="total" value="${workshopView.total}" />
    <input type="hidden" name="stamp" id="stamp" value="${workshopView.stamp}"/>
</form>

<script>


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
            pageSize:  $("#rows").val(),            //一页记录数
            onPageChange: function (page) {
                document.title = page;
                $("#page").val(page-1);
                $('#communityForm').submit();

            }
        });
    });
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

    // 全选
    $(".checkAll").click(function () {
        var isChecked = $(this).prop("checked");
        $(".subCheckbox").prop("checked", isChecked);
    });
    //排序点击
    function list(sort,order){

        var form=$("<form>");//定义一个form表单
        form.attr("style","display:none");
        form.attr("target","");
        form.attr("method","post");
        form.attr("action",location.href);
        var input2=$("<input>");
        input2.attr("type","hidden");
        input2.attr("name","sort");
        input2.attr("value",sort);
        var input3=$("<input>");
        input3.attr("type","hidden");
        input3.attr("name","order");
        input3.attr("value",order);

        $("body").append(form);//将表单放置在web中
        form.append(input2);
        form.append(input3);

        form.submit();//表单提交 });

    }

    //开启关闭
    function openOrClose(status,ids){
        if(ids==null){
            ids="";
            $("td").find(".subCheckbox").each(function () {
                var isChecked = $(this).prop("checked");
                if(isChecked){
                    ids+=$(this).val();
                    ids+=",";
                }
            });
            if(ids==""||ids==null){
                alert("没有选定工作坊");
                return false;
            }
        }
       //改变工作坊的开启状态
        $.ajax({
            type: 'POST',
            url : '${pageContext.request.contextPath}/workshop/openOrClose.action',
            dataType: "json",
            data:{
                ids:ids,
                status:status,
            },
            success : function(response) {
                var href=location.href;
                location.replace(href);
            }
        });
    }

    function toWorkshop(id) {
        var href='${pageContext.request.contextPath}/workshop/to_workshop_main.action?id='+id;
        location.replace(href);
    }

    $(".recommended").click(function () {
        var source_id=  $(this).data("workshop");
        $("#recommended_source_id").val(source_id);
        $("#recommended_source_type").val(6);
        $("#recommended_modal").modal("show");

    });
    $(".unrecommended").click(function () {
        var source_id=  $(this).data("workshop");
        unrecommended(source_id,6);

    });


</script>
