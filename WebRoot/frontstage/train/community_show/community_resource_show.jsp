<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<div class="community-container">
    <div class="tabs-wrapper">


        <div class="tabs-group">

            <ul class="content clearfix" style="margin-left: 0;">
                <li class="<c:if test="${empty communityCenterView.stage_id}">active</c:if>"><a class="items nav-link" href="javascript:void(0);" data-stage="">全部</a></li>
                <li class="<c:if test="${communityCenterView.stage_id=='XX'}">active</c:if>"><a class="items nav-link " href="javascript:;" data-stage="XX">小学</a></li>
                <li class="<c:if test="${communityCenterView.stage_id=='CZ'}">active</c:if>"><a class="items nav-link " href="javascript:;" data-stage="CZ">初中</a></li>
                <li class="<c:if test="${communityCenterView.stage_id=='GZ'}">active</c:if>"><a class="items nav-link " href="javascript:;" data-stage="GZ">高中</a></li>

            </ul>
        </div>



        <div class="tabs-group">

            <ul class="content clearfix" style="margin-left: 0;">
                <li class="<c:if test="${empty communityCenterView.subject_id}">active</c:if>">
                    <a class="nav-link items" href="javascript:void(0);" data-subject="">全部</a>
                </li>
                <c:forEach items="${subjectList}" var="s" begin="0" end="7">
                    <li class="<c:if test="${communityCenterView.subject_id==s.id}">active</c:if>">
                        <a class="items nav-link tag " href="javascript:;" data-subject="${s.id}">${s.subjectName}</a>
                    </li>
                </c:forEach>
            </ul>
            <div class="pull-right more_categories" style="margin-top: -32px;cursor: pointer;">
                <a href="javascript:"><span class="glyphicon glyphicon-chevron-right"></span></a>
            </div>
            <ul class="content clearfix more_categories_list" style="padding-left: 15px;display: none;">
                <c:forEach items="${subjectList}" var="s" begin="8" >
                    <li class="<c:if test="${communityCenterView.subject_id==s.id}">active</c:if>"><a class="items nav-link tag " href="javascript:;" data-subject="${s.id}">${s.subjectName}</a></li>
                </c:forEach>
            </ul>
        </div>

    </div>
    <div class="cn-filter">
        <ul class="nav nav-sort clearfix">
            <li><a href="javascript:void(0);" onclick="searchSortType(0);"
                   <c:if test="${communityCenterView.sortType==0}">class="active"</c:if>>最新</a></li>
            <li><a href="javascript:void(0);" onclick="searchSortType(2);"
                   <c:if test="${communityCenterView.sortType==2}">class="active"</c:if>>最热</a></li>
        </ul>

    </div>
</div>


<!--社区课例列表 -->

<div class="panel panel-col">

    <div class="panel-body">
        <div class="course-list">


            <c:forEach items="${resourceList }" var="r">
                    <div class="col-lg-3 col-md-4 col-xs-6">
                        <div class="course-item">
                            <div class="course-img">
                                <a href="${pageContext.request.contextPath}/userFile/to_file.action?id=${r.fileId}" target="_blank">
                                    <img src="${pageContext.request.contextPath}${r.icon}" style="height:155px;" class="img-responsive">
                                    <span class="tags">
                                <span class="course_tags" style="color: #fff;padding-left: 5px;font-size: 12px;">
                                <c:if test="${r.file_type==0 }">
                                    文档
                                </c:if>
                                <c:if test="${r.file_type==1 }">
                                    教案
                                </c:if>
                                </span>
                            </span>
                                </a>
                            </div>
                            <div class="course-info">
                                <div class="title ">
                                    <a class="link-dark " href="${pageContext.request.contextPath}/userFile/to_file.action?id=${r.fileId}" target="_blank">
                                            ${r.fileName }
                                    </a>
                                    <span class="pull-right">上传人&nbsp;:&nbsp; ${r.uploadName }</span>
                                </div>
                                <div class="metas clearfix">

                                    <span class="pull-left"><i class="glyphicon glyphicon-download-alt"></i>${r.downloadNum }次</span>
                                    <span class="price pull-right">
                                   <%--免费    --%>
                                   <c:if test="${empty r.value||r.value==0 }">
                                       <span class="text-success">免费</span>
                                   </c:if>
							<c:if test="${!empty r.value&&r.value!=0 }">
                                ${r.value }元
                            </c:if>
                               
                            </span>
                                </div>
                            </div>

                        </div>
                    </div>
                </c:forEach>


        </div>

    </div>
</div>
<script>
    $(".statusType").click(function() {
        var isChecked = $(this).prop("checked");
        var status=0;
        if(isChecked){
            $(".statusType").prop("checked", !isChecked);
            status=$('.statusType').index(this)+1;
        }
        $(this).prop("checked", isChecked);
        $("#page").val(0);
        $("#status").val(status);
        $('#communityForm').submit();
    });

</script>
