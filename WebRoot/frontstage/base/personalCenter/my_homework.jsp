<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<div class="cn-wrap">

    <div id="content-container" class="container">
        <jsp:include page="/frontstage/base/personalCenter/personal_header.jsp"></jsp:include>

        <div class="row row-3-9">

            <jsp:include page="/frontstage/base/personalCenter/personal_left.jsp"></jsp:include>

            <div class="col-md-9">
                <div class="panel panel-default panel-col">
                    <div class="panel-heading">我的作业</div>
                    <div class="panel-body">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#">我的作业</a></li>
                            <li class=""><a href="${pageContext.request.contextPath}/exam/each_homework.action?stamp=2&state=28">作业互评</a></li>
                        </ul>
                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <th width="40%">作业</th>
                                <th width="20%">提交时间</th>
                                <th width="10%">成绩</th>
                                <th width="30%">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${examViews }" var="examView">
                                <tr>
                                    <td>
                                        <div>
                                            <a class="text-success" href="#">《${examView.title }》</a>
                                            <a class="text-success" href="#">${examView.name }</a>&nbsp;
                                        </div>
                                    </td>
                                    <td>
                                        <span class="text-muted">${examView.submit_time }</span>
                                    </td>
                                    <td>
								<span class="text-muted">
                                    <c:if test="${examView.status==1 }">批改中</c:if>
                                    <c:if test="${examView.status==2 }">
                                        <c:if test="${examView.grade==0 }">优秀</c:if>
                                        <c:if test="${examView.grade==1 }">良好</c:if>
                                        <c:if test="${examView.grade==2 }">合格</c:if>
                                        <c:if test="${examView.grade==3 }">不合格</c:if>
                                    </c:if>
                                </span>
                                    </td>
                                    <td>
                                        <a class="btn btn-default btn-sm" href="to_homework.action?exam_id=${examView.id}&id=${examView.test_paper_id}&courseId=${examView.courseId}&tab=2&class_id=${examView.class_id}" target="_blank">查看</a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <div id="test" class="pager" style="padding-top: 0;margin-bottom: 20px;"></div>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <form id="examForm" action="${pageContext.request.contextPath}/exam/to_my_homework.action" method="post">
        <input type="hidden" name="page" id="page" value="${examView.page}"/>
        <input type="hidden" name="rows" id="rows" value="${examView.rows}"/>
        <input type="hidden" name="total" id="total" value="${examView.total}"/>
        <input type="hidden" name="totalPage" id="totalPage" value="${examView.totalPage}"/>
        <input type="hidden" name="courseId" value="${courseView.id}">
        <input type="hidden" name="flag" value="${courseView.flag}">
        <input type="hidden" name="sign" value="${courseView.sign}">
        <input type="hidden" name="exam_type" value="${exam_type}">
        <input type="hidden" name="stamp" value="${stamp}">
        <input type="hidden" name="state" value="${state}">
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
    //tab选项卡添加下划线样式
    $(function(){
        $(".nav-btn-tab>ul>li.active").css("border-bottom","2px solid #46c37b");
        $(".nav-btn-tab>ul>li").mouseenter(function(){

            $(this).addClass("active");
        }).mouseout(function(){
            $(this).removeClass("active");

        });

    });
</script>  
    

