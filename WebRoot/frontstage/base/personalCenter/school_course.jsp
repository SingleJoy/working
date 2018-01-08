<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>
<link href="${pageContext.request.contextPath}/frontstage/css/my-space.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/frontstage/css/teaching-center.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/my-space.js"></script>
<div class="cn-wrap">

    <div id="content-container" class="container">
        <jsp:include page="/frontstage/base/personalCenter/personal_header.jsp"></jsp:include>
        <div class="row row-3-9">

            <jsp:include page="/frontstage/base/personalCenter/personal_left.jsp"></jsp:include>

            <div class="col-md-9">
       
                     <form id="studyCenterForm" action="${pageContext.request.contextPath}/school_center/query_course.action" method="post">
		             	<input type="hidden" name="page" id="page" value="${view.page}"/>
		     	        <input type="hidden" name="rows" id="rows" value="${view.rows}"/>
			            <input type="hidden" name="total" id="total" value="${view.total}"/>
			            <input type="hidden" name="totalPage" id="totalPage" value="${view.totalPage}"/>
			            <input type="hidden" name="tab" id="tab" value="${tab}"/>
			            <input type="hidden" name="state" id="state" value="${state}"/>
			            <input type="hidden" name="stamp" id="stamp" value="${stamp}"/>
	                 </form>

                     <div class="panel panel-default panel-col lesson-manage-panel">
                         <div class="panel-heading">学校课程</div>

                          <div class="panel-body">
                             <ul class="nav nav-pills">
                                 <li class="active">
                                     <a href="javascript:void(0);">普通课程</a>
                                 </li>
                                 <li >
                                    <a href="javascript:void(0);">直播课程</a>
                                 </li>

                             </ul>

                               <!--普通课程-->


                               <table class="table  table-hover" id="course-table" style="word-break:break-all;">
                                   <thead>

                                       <tr >
                                         <th style="width: 40%;">名称</th>
                                         <th >授课老师</th>
                                         <th >学员数</th>
                                         <th>价格(元)</th>
                                         <th>收入(元)</th>
                                         <th>状态</th>
                                         <th>操作</th>
                                      </tr>
                                   </thead>
                                   <tbody>
			                       <c:forEach items="${schoolCenterViews }" var="s">

                                      <tr>

                                      <td style="width: 40%;">
                                        <a href="${pageContext.request.contextPath}/user_study/to_course_study.action?page=1&learnId=${s.course_id }&sourceType=0&tab=1&is_direct=0">
                                        <img style="width: 100px;height: 56px;"
                                          <c:if test="${empty s.course_picture}">src="${pageContext.request.contextPath}/frontstage/images/course.png"</c:if>
                                         <c:if test="${!empty s.course_picture}">src="${pageContext.request.contextPath}${s.course_picture }"</c:if>>
                                        </a>
                                        <a href="javascript:return false;" class="course_title_name">${s.course_title }</a>
                                      </td>

                                     <td >${s.real_name }</td>
                                     <td >${s.student_total }</td>

                                     <td >${s.price }</td>
                                     <td >0</td>

                                     <td>
                                       <span style="opacity: 0.8;">${s.status_str }</span>
                                       <!--<span style="color: #a94442;">已关闭</span>-->
                                      <!--<span style="color: #3ebbce;">已发布</span>-->
                                     </td>
                                    <td style="width:100px;text-align: center;">
                                       <c:if test="${s.status==0}">
                                        <a href="${pageContext.request.contextPath}/back_course/update_status.action?id=${s.course_id }&status=3" class="course_operation" onclick="return false">
                                          删除
                                        </a>
                                        </c:if>
                                        <c:if test="${s.status==1}">
                                          <a href="${pageContext.request.contextPath}/back_course/update_status.action?id=${s.course_id }&status=2" class="course_operation" onclick="return false">
                                             关闭
                                          </a>
                                        </c:if>
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
      
      $(".course_operation").click(function(){
    	  var url=$(this).attr("href");
      	$.ajax({
      		 type:'get',
               url : url,
           	dataType:'json',
				success : function(response) {
				alert(response.msg);
				location.replace(location.href);
				},
				error :function(response) {
					alert(response.msg);
				}
      		 
      	 });
      });
  });
</script>


