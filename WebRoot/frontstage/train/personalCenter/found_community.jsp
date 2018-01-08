<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
 <c:if test="${false }">
 <a href="${pageContext.request.contextPath}/community/to_create_community.action?stamp=0&state=0" class="btn btn-info pull-right" target="">创建社区</a>
</c:if>
<!--我组建的社区-->
<div class="my-group">

    <h5 style="margin: 70px 0 20px 0;">我创建的社区:
        <a href="javascript:void (0)">
            <span class="pull-right num num_num" style="background: #3ebbce;padding: 0 10px;border-radius: 20px;color: #fff;">${communityList.size()}</span>
        </a>
    </h5>

    <div class="row">
		<c:forEach items="${communityList}" var="community">
			<div class="col-lg-4 col-md-4 col-sm-6">
	            <div class="teacher-item">
	                <div class="teacher-top" style="padding: 5px;">
	                
	                <a href="javascript:void(0)" class="pull-left"  <c:if test="${community.status==0 }">onclick="doIndex(${community.id});"</c:if> >
	                        <img class="media-object" src="${pageContext.request.contextPath}${community.head_img}" style="width: 100px;height: 100px;">
	                    </a>

	                    <div class="title" >
	                        <a class="link-dark" href="javascript:void(0);">${community.name }</a>
	                    </div>
						<br/>
	                    <div  class="student_num " >
	                        <i class="es-icon es-icon-people"></i>${community.studentNum }
	                     </div>
						<br/>
						<div class="message_num">
	                        <i class="es-icon es-icon-textsms"></i>${community.topicNum }
	                    </div>

					</div>
	                <div class="teacher-bottom">
	                    <div class="metas" >
	                       <c:if test="${community.status==0 }"><a class="btn btn-primary btn-sm btn-danger" href="javascript:void(0)" onclick="doClose(${community.id});">关闭</a></c:if>
	                       <c:if test="${community.status==1 }"><a class="btn btn-primary btn-sm btn-success" href="javascript:void(0)" onclick="doOpen(${community.id});">开启</a></c:if>
	                       <a class="btn btn-default btn-sm btn-info" href="${pageContext.request.contextPath}/community/to_community.action?id=${community.id}&stamp=11" target="_blank">管理</a>
	                    </div>
	                </div>
	            </div>
	        </div>
		</c:forEach>
		<c:if test="${communityView.totalPage>communityView.page+1}">
		    <a class="pull-right" href="javascript:void(0)" onclick="doMore();" style="padding-right: 20px;margin-top: 20px;color: #616161;">更多 ></a>
		</c:if>
    </div>
</div>

<script type="text/javascript">
function doClose(value){
	window.location.href="${pageContext.request.contextPath}/community/save_community.action?stamp=0&state=0&sign=2&flag=0&id="+value;
}
function doOpen(value){
	window.location.href="${pageContext.request.contextPath}/community/save_community.action?stamp=0&state=0&sign=2&flag=2&id="+value;
}
</script>