<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>
<%--<link href="${pageContext.request.contextPath}/frontstage/css/my-space.css" rel="stylesheet" type="text/css">--%>
<%--<link href="${pageContext.request.contextPath}/frontstage/css/teaching-center.css" rel="stylesheet" type="text/css">--%>
<%--<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/my-space.js"></script>--%>
<div class="cn-wrap">

    <div id="content-container" class="container">
        <jsp:include page="/frontstage/base/personalCenter/personal_header.jsp"></jsp:include>

        <div class="row row-3-9">

            <jsp:include page="/frontstage/base/personalCenter/personal_left.jsp"></jsp:include>

            <div class="col-md-9">
                <div class="panel panel-default panel-col">
                    <div class="panel-heading">作业互评</div>
                    <div class="panel-body">
                        <ul class="nav nav-tabs">
                            <li class=""><a href="${pageContext.request.contextPath}/exam/to_my_homework.action?stamp=2&state=28">我的作业</a></li>
                            <li class="active"><a href="#">作业互评(${userHomeworkScoreView.total })</a></li>
                        </ul>
                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <th width="40%">作业</th>
                                <th width="20%">用户名</th>
                                <th width="30%">时间</th>
                                <th width="30%">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${userHomeworkScores }" var="userHomeworkScore">
                                <tr>
                                    <td>
                                        <span class="text-info">${userHomeworkScore.name }</span>
                                    </td>
                                    <td>
                                        <span class="text-muted">${userHomeworkScore.username }</span>
                                    </td>
                                    <td>
                                        <span class="text-muted">${userHomeworkScore.submit_time }</span>
                                    </td>
                                    <td>
                                        <c:if test="${userHomeworkScore.status==0 }">
                                            <a class="btn btn-default btn-sm" href="to_homework.action?exam_id=${userHomeworkScore.exam_id}&id=${userHomeworkScore.test_paper_id}&courseId=${userHomeworkScore.courseId}&tab=2&class_id=${userHomeworkScore.class_id}" target="_blank">互评</a>
                                        </c:if>
                                        <c:if test="${userHomeworkScore.status==1 }">
                                            <span class="text-muted">已评</span>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <div id="test" class="pager" ></div>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <form id="examForm" action="${pageContext.request.contextPath}/exam/each_homework.action?stamp=2&state=28" method="post">
        <input type="hidden" name="page" id="page" value="${userHomeworkScoreView.page}"/>
        <input type="hidden" name="rows" id="rows" value="${userHomeworkScoreView.rows}"/>
        <input type="hidden" name="total" id="total" value="${userHomeworkScoreView.total}"/>
        <input type="hidden" name="totalPage" id="totalPage" value="${userHomeworkScoreView.totalPage}"/>
    </form>
    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>

</div>
<!-- 弹窗 -->
<div id="modal" class="modal in" style="display: none;" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog  modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">题目预览</h4>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default pop_close">关闭</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function(e){
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
                $('#examForm').submit();

            }
        });


    });

</script>  
    

