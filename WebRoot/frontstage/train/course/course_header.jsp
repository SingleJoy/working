<%@ page language="java" import="java.util.*,cn.bnsr.edu_yun.frontstage.base.po.User" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% User user = (User)request.getSession().getAttribute("currentUser");%>


<div class="cn-section course-manage-header clearfix" style="margin-top: 20px;border: none;">
    <a href="javascript:void(0);">
        <img src="${pageContext.request.contextPath}${courseView.img}" onclick="toCourseDetail(${courseView.id},0);" class="picture" >
    </a>
    <h1 class="title" >
        <a class="link-dark" href="javascript:void(0);" onclick="toCourseDetail(${courseView.id},0);" title="${courseView.title}">${courseView.title}</a>
        <c:if test="${courseView.status==0}"><span class="label label-warning ">未发布</span></c:if>
       
    </h1>
 
    <div class="teachers">
        教师：
        <a href="javascript:void(0);" style="line-height: 25px;">
            <c:if test="${empty courseView.teachers}"><%=user.getUsername() %></c:if>
            <c:if test="${!empty courseView.teachers}">${courseView.teachers}</c:if>
        </a>
    </div>

    <div class="toolbar hidden-xs">

        <c:if test="${courseView.status==1}">
            <div class="btn-group">
                <a class="btn btn-default btn-sm" href="javascript:void(0);" onclick="toCourseDetail(${courseView.id},0);">返回课程主页</a>
            </div>
        </c:if>

        <div class="btn-group">
            <button class="btn btn-default btn-sm dropdown-toggle " data-toggle="dropdown" id="preview_course">预览
                <span class="caret"></span>
            </button>
            <ul class="dropdown-menu pull-right">
                <li><a href="javascript:void(0);"   onclick="toCourseDetail(${courseView.id},1);">作为 已购买用户</a></li>
                <li><a href="javascript:void(0);"  onclick="toCourseDetail(${courseView.id},2);">作为 未购买用户</a></li>
            </ul>
        </div>
        <c:if test="${courseView.status==0}">
            <div class="btn-group">
                <button class="btn btn-success btn-sm course-publish-btn" onclick="doRelease();">发布课程</button>
            </div>
        </c:if> 
    </div>

</div>



<script type="text/javascript">

    function toCourseDetail(value,viewType){
        window.open("${pageContext.request.contextPath}/user_study/to_course_study.action?page=1&learnId="+value+"&sourceType=0&tab=1&viewType="+viewType+"&is_direct=0");
    }
    
    function doRelease(){
        var result = confirm('您真的要发布该课程吗？');
        if(result){
        	 $.ajax({
   			  url : '${pageContext.request.contextPath}/class/is_exist_class.action',
   			  dataType : 'json',
   			  data:{
   				  source_id : '${courseView.id}',
   	   			  source_type : 0
   	   		  }, 
   	   		  success:function(data){
   	   			  if(data.set_check==0){
   	   				if(data.courseHour_num>0&&data.course_hours===1){
   	   			 		window.location.href="${pageContext.request.contextPath}/course/release_course.action?id=${courseView.id}";
   	   				} else{
   	   					if(data.courseHour_num<=0){
   	   						alert("该课程还没有建立课时，请先建立课时！");
   	   				 	}else if(data.course_hours<0){
   	   				 		alert("该课程学时必须大于等于0！");
   	   				 	}
   	   				} 
   	   			}else{
	   	   			  if(data.courseHour_num>0&&(data.course_hours===1&&data.total_ratio===100)){
			           	 window.location.href="${pageContext.request.contextPath}/course/release_course.action?id=${courseView.id}";
	   	   			  }else{
	   	   				 if(data.courseHour_num<=0){
	   	   					alert("该课程还没有建立课时，请先建立课时！");
	   	   				 }else if(data.course_hours<0){
	   	   				 	alert("该课程学时必须大于等于0！");
	   	   				 }else if(data.total_ratio!==100){
	   	   					alert("该课程考核标准各项总占比需达到100%，请核对并设置正确的课程考核标准！");
	   	   				 }
	   	   			  }
   	   			  }
   	   		  }
        	});
        }
    }
</script>