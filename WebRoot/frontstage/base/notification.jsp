<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<jsp:include page="./layout/header.jsp"></jsp:include>



<!--通知-->
<div class="cn-wrap">
    <div id="content-container" class="container">

        <div class="row row-8" style="margin-top: 20px;">

            <div class="col-md-8 col-md-offset-2">
                <div class="panel panel-default panel-page">
                    <div class="panel-heading">
                        <h2> 通知 </h2>
                    </div>

                    <ul class="media-list notification-list">
                        <c:forEach items="${notificationViews}" var="n">
                            <li class="media">
                                <div class="pull-left">
                                    <span class="glyphicon glyphicon-volume-down media-object"></span>
                                </div>

                                <div class="media-body">
                                    <div class="notification-body">${n.msg }

                                        <div class="notification-footer">
                                            <fmt:formatDate value="${n.notice_time}" type="both" />
                                        </div>
                                    </div>
                            </li>
                        </c:forEach>
                    </ul>
                    <form id="studyCenterForm" action="${pageContext.request.contextPath}/notice/queryNotice.action" method="post">
                        <input type="hidden" name="page" id="page" value="${notificationView.page}"/>
                        <input type="hidden" name="rows" id="rows" value="${notificationView.rows}"/>
                        <input type="hidden" name="total" id="total" value="${notificationView.total}"/>
                        <input type="hidden" name="totalPage" id="totalPage" value="${notificationView.totalPage}"/>
                        <input type="hidden" id="type" name = "type" value="${notificationView.type }"> 
                    </form>
                    <div id="test" class="pager" style="padding-top: 0;margin-bottom: 20px;"></div>
                </div>
            </div>
        </div>
    </div>

</div>





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
                $('#studyCenterForm').submit();

            }
        });
    });
</script>


<jsp:include page="./layout/footer.jsp"></jsp:include>