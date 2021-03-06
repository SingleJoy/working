<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>
<%--<link href="${pageContext.request.contextPath}/frontstage/css/my-space.css" rel="stylesheet" type="text/css">--%>
<link href="${pageContext.request.contextPath}/frontstage/css/teaching-center.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/my-space.js"></script>
<style>
    #course-table thead tr th,#course-table tbody tr td{padding: 20px 0;}
</style>
<div class="cn-wrap">

    <div id="content-container" class="container">

        <jsp:include page="/frontstage/base/personalCenter/personal_header.jsp"></jsp:include>

        <div class="row row-3-9">

            <jsp:include page="/frontstage/base/personalCenter/personal_left.jsp"></jsp:include>

            <div class="col-md-9">
                    <form id="studyCenterForm" action="${pageContext.request.contextPath}/school_center/query_resourse.action" method="post">
			            <input type="hidden" name="page" id="page" value="${view.page}"/>
			            <input type="hidden" name="rows" id="rows" value="${view.rows}"/>
			            <input type="hidden" name="total" id="total" value="${view.total}"/>
			            <input type="hidden" name="totalPage" id="totalPage" value="${view.totalPage}"/>
			            <input type="hidden" name="tab" id="tab" value="${tab}"/>
			            <input type="hidden" name="state" id="state" value="${state}"/>
			           <input type="hidden" name="stamp" id="stamp" value="${stamp}"/>
	                </form>

            <!--学校资源 -->

                <div class="panel panel-default panel-col lesson-manage-panel">

                    <div class="panel-heading">
                        <span class="pull-right">
                             <a  href="javascript:void(0);" class="btn btn-info btn-sm" target="_blank">
                              <span class="glyphicon glyphicon-plus"></span>
                              新增
                            </a>
                            <a href="javascript:void(0);" class="btn btn-info btn-sm" target="_blank">
                                 删除
                            </a>
                             <a href="javascript:void(0);" class="btn btn-info btn-sm" target="_blank">
                                 审核
                             </a>

                        </span>
                        学校老师
                    </div>


                    <!--学校资源-->

                    <table class="table  table-hover" id="course-table" style="word-break:break-all;">
                        <thead>

                        <tr>
                            <th ><input type="checkbox"  class="check_all" style="margin-left: 5px;"></th>
                            <th >名称</th>
                            <th >上传人</th>
                            <th >上传时间</th>
                            <th >分类</th>
                            <th >评分</th>
                            <th >状态</th>
                            <th >操作</th>
                        </tr>
                        </thead>
                        <tbody>
			          <c:forEach items="${schoolCenterViews }" var="s">
                          <tr >
                              <th ><input type="checkbox" style="margin-top:14px;"></th>
                              <td >${s.file_name}</td>
                              <td >${s.username}</td>
                              <td ><fmt:formatDate
												value="${s.upload_time }" type="both" /></td>
                              <td >
                                <c:if test="${s.price>0 }">付费</c:if>
                                <c:if test="${s.price==0 }">免费</c:if>
                              </td>
                               <td >4.6</td>
                              <td >
                                 <span style="opacity: 0.8;">
                                    <c:if test="${s.f_status==0 }">已审核</c:if>
                                    <c:if test="${s.f_status==1 }">未审核</c:if>
                                    <c:if test="${s.f_status==2 }">未通过</c:if>
                                 </span>

                             </td>
                             <td >
                                <a href="javascript:return false;">查看</a>
                             </td>
                           </tr>
			          </c:forEach>
                        </tbody>
                    </table>
                    <div id="test" class="pager" style="margin-top: 90px;padding-top: 0;"></div>

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
      		$('#studyCenterForm').submit();

          }
      });
  });
</script>

<jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
