<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>
<div class="cn-wrap">

    <div id="content-container" class="container">
        <jsp:include page="/frontstage/base/personalCenter/personal_header.jsp"></jsp:include>
        <div class="row row-3-9">

            <jsp:include page="/frontstage/base/personalCenter/personal_left.jsp"></jsp:include>
            <div class="col-md-9">
                <form id="courseForm" action="${pageContext.request.contextPath}/cert_model/to_cert_model_manager.action" method="post">
                    <input type="hidden" name="stamp" id="stamp" value="${stamp}"/>
                    <input type="hidden" name="state" id="state" value="${state}"/>
                    <input type="hidden" name="page" id="page" value="${certModelView.page}"/>
                    <input type="hidden" name="rows" id="rows" value="${certModelView.rows}"/>
                    <input type="hidden" name="total" id="total" value="${certModelView.total}"/>
                    <input type="hidden" name="totalPage" id="totalPage" value="${certModelView.totalPage}"/>
                </form> 
			    <div class="panel panel-default panel-col">
			        <div class="panel-heading">
			            <div class="pull-right">
			                <%-- <a href="${pageContext.request.contextPath}/cert_model/to_cert_model_picture.action?type=0&stamp=1&state=29" class="btn btn-info btn-sm"><span class="glyphicon glyphicon-plus"></span> 模板管理</a> --%>
			                <a href="${pageContext.request.contextPath}/cert_model/to_create_cert_model.action?&stamp=1&state=29" class="btn btn-info btn-sm"><span class="glyphicon glyphicon-plus"></span> 新建证书</a>
			            </div>
			           证书管理
			        </div>
			
			        <div class="panel-body" >
			            <table class="table  table-hover" >
			                <thead>
			                <tr>
			                    <!-- <th><input type="checkbox" ></th> -->
			                    <th width="50%">证书名称</th>
			                    <th>创建者</th>
			                    <!-- <th>类型</th> -->
			                    <th>最后更新</th>
			                    <th>操作</th>
			                </tr>
			                </thead>
			                <tbody>
			                <c:forEach items="${certModelList}" var="certModel">
			                <tr >
			                    <!-- <td><input  type="checkbox" ></td> -->
			                    <td>${certModel.title}</td>
			                    <td>${certModel.username}</td>
			                    <%-- <td><c:if test="${certModel.type eq 0}">自建模板</c:if>
			                        <c:if test="${certModel.type eq 1}">原有模板</c:if></td> --%>
			                    <td><span class="text-muted text-sm"><c:if test="${!empty certModel.update_time }"><fmt:formatDate value="${certModel.update_time}" type="both"/></c:if></span></td>
			                    <td>
			                        <div class="btn-group">
			                            <a class="btn btn-default btn-sm" href="${pageContext.request.contextPath}/cert_model/to_cert_model_show.action?id=${certModel.id}" target="_blank">预览</a>
			                            <a href="#" type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></a>
			                            <ul class="dropdown-menu pull-right">
			                                <li><a href="${pageContext.request.contextPath}/cert_model/to_create_cert_model.action?id=${certModel.id}&stamp=1&state=29" ><span class="glyphicon glyphicon-edit"></span> 编辑</a></li>
			                                <li><a href="${pageContext.request.contextPath}/cert_model/del_cert_model.action?id=${certModel.id}"><span class="glyphicon glyphicon-remove-circle"></span> 删除</a></li>
			                            </ul>
			                        </div>
			                    </td>
			                </tr>
			                </c:forEach>
			                </tbody>
			
			            </table>
			             <c:if test="${empty certModelList }">
                            <div class="empty">您还没有创建证书</div>
                        </c:if>
                        <c:if test="${!empty certModelList }">
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
                $('#courseForm').submit();

            }
        });
    });

</script>
