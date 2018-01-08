<%@ page language="java" import="java.util.*,cn.bnsr.edu_yun.frontstage.base.po.User" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% User user = (User)request.getSession().getAttribute("currentUser");%>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>
<link href="${pageContext.request.contextPath}/frontstage/css/course_center.css" rel="stylesheet" type="text/css">

<div class="management_background_course_main" style="height:900px;">

<%--   <jsp:include page="/frontstage/train/course/course_center.jsp"></jsp:include>
 --%>  
    <div  class="management_background_course_main_right">
          <h1>课程管理</h1>

        <div class="create_course">
            <a href="${pageContext.request.contextPath}/course/to_create_course.action?type=${courseView.type}"  target="_blank">创建课程</a>
            <a href="javascript:void(0);">创建直播课程</a>
        </div>

        <div class="course_management">
            <ul>
                <li class="active"><a href="javascript:void(0);" class="active">课程管理</a></li>
                <li class="active_01"><a href="javascript:void(0);">课程推荐</a></li>
                <li class="active_01"><a href="javascript:void(0);">课程统计</a></li>

            </ul>
            <p></p>
        </div>
        <div class="course_type">
            <a href="javascript:void(0);" onclick="searchType(0);" <c:if test="${courseView.type==0}">class="curr"</c:if>>普通课程</a>
            <a href="javascript:void(0);" onclick="searchType(1);" <c:if test="${courseView.type==1}">class="curr"</c:if>>班级课程</a>
        </div>
		<form id="courseForm" action="${pageContext.request.contextPath}/course/to_course.action" method="post">
			<input type="hidden" name="sign" id="sign" value="${courseView.sign}"/>
			<input type="hidden" name="type" id="type" value="${courseView.type}"/>
			<input type="hidden" name="page" id="page" value="${courseView.page}"/>
			<input type="hidden" name="state" id="state" value="${courseView.page}"/>
			<input type="hidden" name="rows" id="rows" value="${courseView.rows}"/>
			<input type="hidden" name="total" id="total" value="${courseView.total}"/>
			<input type="hidden" name="totalPage" id="totalPage" value="${courseView.totalPage}"/>
	        <div class="course_classify">
	
	             <select name="classify_id">
	                 <option value="-1">课程分类</option>
	             	<c:forEach items="${classifyList}" var="classify">
	                 	<option <c:if test="${courseView.classify_id==classify.id}">selected="selected"</c:if>value="${classify.id }">${classify.classify_name }</option>
	             	</c:forEach>
	             </select>
	
	            <select name="status">
	                <option value="-1">课程状态</option>
	                <option <c:if test="${courseView.status==1}">selected="selected"</c:if> value="1">已发布</option>
	                <option <c:if test="${courseView.status==0}">selected="selected"</c:if> value="0">未发布</option>
	                <option <c:if test="${courseView.status==2}">selected="selected"</c:if> value="2">已关闭</option>
	            </select>
	            <input type="text" name="title" value="${courseView.title}" placeholder="标题">
	            <!-- <input type="text" placeholder="创建者"> -->
	            <button type="submit">搜索</button>
	        </div>
		</form>
        <div class="course_management_table">
            <table>
           		<tr>
                    <th style="width: 57px;">编号</th>
                    <th style="width: 30%;">名称</th>
                    <th style="width: 110px;">连载状态</th>
                    <th style="width: 75px;">学员数</th>
                    <th style="width: 88px;">收入(元)</th>
                    <th style="width: 74px;">状态</th>
                    <th style="width: 146px;">创建者</th>
                    <th style="width: 112px;">操作</th>
                </tr>
            	<c:forEach  items="${courseList}" var="course">
            		<tr style="z-index:-1">
		                <td style="width: 57px;">${course.id}</td>
		                <td style="width: 30%;" class="name">${fn:substring(course.title,0,16)}<br/>
		                    <span>分类:-${course.classifyName }</span>
		                    <c:if test="${course.isRecommend==0}">
			                    <span>荐:${course.recommendTime } / 序号:${course.recommendSeq }</span>
		                    </c:if>
		                </td>
		                <td style="width: 110px;" class="serialized_state">
		                	<c:if test="${course.serial_status == 0}">非连载</c:if>
		                	<c:if test="${course.serial_status == 1}">更新中</c:if>
		                	<c:if test="${course.serial_status == 2}">已完结</c:if>
						</td>
		                <td style="width: 75px;">0</td>
		                <td style="width: 88px;" class="income">0.00</td>
		                <td style="width: 74px;">
		                	<c:if test="${course.status == 0}">未发布</c:if>
		                	<c:if test="${course.status == 1}"><span style="color:green;">已发布</span></c:if>
		                	<c:if test="${course.status == 2}"><span style="color:red;">已关闭</span></c:if>
		                	<c:if test="${course.status == 3}">已删除</c:if>
						</td>
		                <td style="width: 146px;" class="author">
		                    <a href="javascript:void(0);" style="color:#428bca"><%=user.getUsername() %></a><br/>
		                    <span class="create_time">${fn:substring(course.createTime,0,16)}</span>
		                </td>
		                <td style="width: 112px;">
		                    <a class="operation" href="${pageContext.request.contextPath}/course/to_course_info.action?id=${course.id}&flag=2&sign=1">管理</a>
		                    <a class="triangle_down" onclick="doManager(${course.id});" href="javascript:void(0);"></a>
		                    <a class="operation_type" href="javascript:void(0);" >
		                        <ul style="display: none;" class="ul_tabs" id="ul_${course.id}">
		                            <%--<li class=""><a href="javascript:void(0);" class="">推荐课程</a></li>--%>
		                            <li class=""><a href="javascript:void(0);">复制课程</a></li>
		                            <li class=""><a href="javascript:void(0);">预览:作为未购买用户</a></li>
		                            <li class=""><a href="javascript:void(0);">预览:作为已购买用户</a></li>
		                            <li class=""><a href="javascript:void(0);">发布课程</a></li>
		                            <li class=""><a href="javascript:void(0);">删除课程</a></li>
		                        </ul>
		                    </a>
		                </td>
	           		 </tr>
            	</c:forEach>
             </table>
        </div>
         <c:if test="${empty courseList }">
			 <div class="empty">暂无数据</div>
   		 </c:if>
       	<c:if test="${!empty courseList }">

		        <div id="test" class="pager"></div>

		</c:if>
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
          pageSize: 8,           //一页记录数
          onPageChange: function (page) {
              document.title = page;
      		$("#page").val(page-1);
      		$('#courseForm').submit();

          }
      });
  });
  
  function searchType(value){
	  $("#type").val(value);
	  $('#courseForm').submit();
  }
  function doManager(value){
	  if($("#ul_"+value).css("display")=="none"){
          $("#ul_"+value).show();

     }else{
          $("#ul_"+value).hide();
      }
  }
  
      //课程选择
   $(function(){
       $(".course_management ul li").click(function(){
           $(".course_management ul li").removeClass("active").removeClass("active_01").find("a").removeClass("active");
          $(this).addClass("active").find("a").addClass("active");
           $(this).addClass("active").siblings().addClass("active_01");
       })
   });
   //  课程类型选择
   $(function(){
       $(".course_type a").click(function(){
           $(".course_type a").removeClass("curr");
           $(this).addClass("curr");

       })
   });

</script>

<jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>

