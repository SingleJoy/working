<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>
<div class="cn-wrap">



    <div id="content-container" class="container">
        <jsp:include page="/frontstage/base/personalCenter/personal_header.jsp"></jsp:include>

        <div class="row row-3-9">
            <form id="myCertForm" action="${pageContext.request.contextPath}/user_certificate/to_user_certificate.action" method="post">
                 <input type="hidden" name="stamp" id="stamp" value="${stamp}"/>
                 <input type="hidden" name="state" id="state" value="${state}"/>
                 <input type="hidden" name="source_type" value="${userCertificateView.source_type}"/>
                 <input type="hidden" name="page" id="page" value="${userCertificateView.page}"/>
                 <input type="hidden" name="rows" id="rows" value="${userCertificateView.rows}"/>
                 <input type="hidden" name="total" id="total" value="${userCertificateView.total}"/>
                 <input type="hidden" name="totalPage" id="totalPage" value="${userCertificateView.totalPage}"/>
             </form>
            <jsp:include page="/frontstage/base/personalCenter/personal_left.jsp"></jsp:include>

            <div class="col-md-9">
                    <div class="panel panel-default panel-col">
				        <div class="panel-heading">
				            我的证书
				        </div>
				
				        <div class="panel-body">
				            <ul class="nav nav-tabs " id="course-type">
				                <li <c:if test="${userCertificateView.source_type==0}">class="active"</c:if>>
				                    <a href="${pageContext.request.contextPath}/user_certificate/to_user_certificate.action?stamp=2&state=30&source_type=0">课程证书</a>
				                </li>
				                <li <c:if test="${userCertificateView.source_type==1}">class="active"</c:if>>
				                    <a href="${pageContext.request.contextPath}/user_certificate/to_user_certificate.action?stamp=2&state=30&source_type=1">培训证书</a>
				                </li>
				            </ul>
				
				            <table class="table table-hover course-table">
				                <thead>
				                <tr>
				                    <th><c:if test="${userCertificateView.source_type==0}">课程名称</c:if>
				                        <c:if test="${userCertificateView.source_type==1}">培训名称</c:if></th>
				                    <th>成绩</th>
				                    <th>完成时间</th>
				                    <th>证书</th>
				                </tr>
				                </thead>
				                <tbody>
				                <c:forEach items="${myCertList}" var="myCert">
				                   <tr>
				                    <td>${myCert.course_name}</td>
				                    <td>${myCert.score}</td>
				                    <td><c:if test="${!empty myCert.complete_time}"><fmt:formatDate value="${myCert.complete_time}" type="date"/></c:if></td>
				                    <td><a href="${pageContext.request.contextPath}/user_certificate/to_my_cert_detail.action?cert_id=${myCert.cert_id}&user_id=${myCert.user_id}" target="_blank">${myCert.cert_name}</a></td>
				                </tr>
				                </c:forEach>
				                </tbody>
				            </table>
				            
				            <!--表格无数据时显示 -->
				             <c:if test="${empty myCertList }">
	                            <div class="empty">暂无数据</div>
	                        </c:if>
	                        <c:if test="${!empty myCertList }">
	                            <div class="main_content_switch_directory">
	                                <div id="test" class="pager" style="padding-top: 10px;"></div>
	                            </div>
	                        </c:if>
				        </div>
				    </div>
                </div>
            </div>
        </div>
    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
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
            $('#myCertForm').submit();

        }
    });
});

</script>

