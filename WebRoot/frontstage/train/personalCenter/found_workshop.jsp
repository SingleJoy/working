<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
 
 
<!--我管理的工作坊-->
<div class="my-group">

    <h5 style="margin: 40px 0 20px 0;">我管理的工作坊:
        <a href="javascript:void (0)">
            <span class="pull-right num num_num" style="background: #3ebbce;padding: 0 10px;border-radius: 20px;color: #fff;">${workshopView.total}</span>
        </a>
    </h5>

    <div class="row">
		<c:forEach items="${workshopViewList}" var="workshop">
			<div class="col-lg-4 col-md-4 col-sm-6">
	            <div class="teacher-item">
	                <div class="teacher-top" style="padding: 5px;">
	                    <a href="javascript:void(0)" class="pull-left"  onclick="doIndex(${workshop.id});">
	                        <img class="media-object" src="${pageContext.request.contextPath}${workshop.img}" style="width: 100px;height: 100px;">
	                    </a>

	                    <div class="title" >
	                        <a class="link-dark" href="javascript:void(0);">${workshop.name }</a>
	                    </div>
						<br/>
	                    <div  class="student_num " >
	                        <i class="es-icon es-icon-people"></i>${workshop.studentNum }
	                     </div>
						<br/>
						<div class="message_num">
	                        <i class="es-icon es-icon-textsms"></i>${workshop.topicNum }
	                    </div>

					</div>
	                <div class="teacher-bottom">
	                    <div class="metas" >
	                        <a class="btn btn-primary btn-sm btn-danger" href="javascript:void(0)" onclick="openOrClose(1,${workshop.id})"><c:if test="${workshop.status==1 }">已</c:if>关闭</a>
	                        <a class="btn btn-default btn-sm btn-info" href="${pageContext.request.contextPath}/workshop/to_workshop_main.action?id=${workshop.id}" target="_blank">管理</a>
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
	//window.location.href="${pageContext.request.contextPath}/community/save_workshop.action?stamp=0&state=0&sign=2&flag=0&id="+value;
}
 function openOrClose(status,ids){
        if(ids==null){
            ids="";
            $("td").find(".subCheckbox").each(function () {
                var isChecked = $(this).prop("checked");
                if(isChecked){
                    ids+=$(this).val();
                    ids+=",";
                }
            });
            if(ids==""||ids==null){
                alert("没有选定工作坊");
                return false;
            }
        }
//改变工作坊的开启状态
 $.ajax({
            type: 'POST',
            url : '${pageContext.request.contextPath}/workshop/openOrClose.action',
            dataType: "json",
            data:{
            ids:ids,
            status:status,
            },
            success : function(response) {
                var href=location.href;
               location.replace(href);
            }
        });
};
</script>