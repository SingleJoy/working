<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

 <h5 style="margin: 10px 0 20px 0;">我加入的工作坊:
     <a href="javascript:void(0)">
         <span class="pull-right num num_num" >${workshopView.total}</span>
     </a>
 </h5>

 <div class="row">
	<c:forEach items="${workshopViewList}" var="workshop">
     <!--每一页最多10个,多余10个社区的话显示更多,并有更多加载其他社区-->
     <div class="col-md-4 community_list">
         <div class="media" style="padding:5px 0;">
             <a class="pull-left" href="javascript:void(0)" onclick="doIndex(${workshop.id});" >
                 <img class="media-object" src="${pageContext.request.contextPath}${workshop.img}" style="width: 80px;height: 80px;">
             </a>
             <div class="media-body">
                 <h5 class="media-heading" style="line-height: 25px;">${workshop.name}</h5>
                 <div class="student_num hidden-xs"><i class="es-icon es-icon-people"></i>${workshop.studentNum}</div>
                 <div class="message_num"><i class="es-icon es-icon-textsms"></i>${workshop.topicNum}</div>
             </div>
         </div>	
     </div>
	</c:forEach>
	<c:if test="${communityView.totalPage>communityView.page+1}">
		<a class="pull-right" href="javascript:void(0)" onclick="doMore();" style="padding-right: 20px;margin-top: 20px;color: #616161;">更多 ></a>
	</c:if>
 </div>