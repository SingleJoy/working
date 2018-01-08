<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!--社区培训分类 -->
<div class="community-container">
	<div class="tabs-wrapper">


		<div class="tabs-group">
			<div class="title">分类：</div>
			<ul class="content ">
				<li <c:if test="${communityCenterView.classifyId==-1}"> class="active" </c:if>>
					<a class="nav-link" href="javascript:void(0)" onclick="doClassify(-1,'');" >全部</a></li>
				<c:forEach items="${classifyList }" var="classify">
					<li <c:if test="${classify.id==communityCenterView.classifyId}"> class="active" </c:if>>
						<a class="nav-link" href="javascript:void(0)" onclick="doClassify(${classify.id},'${classify.name}');">${classify.name }</a>
					</li>
				</c:forEach>
			</ul>
		</div>

		<div class="tabs-group" id="sonClassify" <c:if test="${communityCenterView.classifyId==-1}">style="display:none;"</c:if>>
			<ul class="content">
				<li <c:if test="${communityCenterView.sonClassifyId==-1}"> class="active" </c:if>>
					<a class="nav-link" href="javascript:void(0)" onclick="doSonClassify(-1,'');" >全部</a></li>
				<c:forEach items="${sonClassifyList}" var="sonClassify">
					<li <c:if test="${sonClassify.id==communityCenterView.sonClassifyId}"> class="active" </c:if>>
						<a class="nav-link" href="javascript:void(0)" onclick="doSonClassify(${sonClassify.id},'${sonClassify.name}');">${sonClassify.name }</a>
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>

	<div class="cn-filter">
		<ul class="nav nav-sort ">
			<li><a href="javascript:void(0);" onclick="searchSortType(0);"
				   <c:if test="${communityCenterView.sortType==0}">class="active"</c:if>>最新</a></li>
			<li><a href="javascript:void(0);" onclick="searchSortType(1);"
				   <c:if test="${communityCenterView.sortType==1}">class="active"</c:if>>最热</a></li>
			<%--<li><a href="javascript:void(0);" onclick="searchSortType(2);"--%>
			<%--<c:if test="${communityCenterView.sortType==2}">class="active"</c:if>>推荐</a></li>--%>
		</ul>

		<div class="filter hidden-xs">
			<label class="checkbox-inline">
				<input type="checkbox" onclick="doSearchType();" name="simple_train" <c:if test="${communityCenterView.type==0}">checked="true"</c:if>/>
				专业培训
			</label>
			<label class="checkbox-inline">
				<input type="checkbox" onclick="doSearchType();" name="complex_train" <c:if test="${communityCenterView.type==1}">checked="true"</c:if> />
				进阶培训
			</label>
		</div>
	</div>
</div>



<!--社区培训列表 -->
<div class="panel panel-col">

	<div class="panel-body">

		<div class="course-list">
			<div class="row">
				<c:forEach items="${trainList}" var="train">
					<div class="col-lg-3 col-md-4 col-xs-6">
						<div class="course-item">
							<div class="course-img">
								<a href="javascript:void(0);" onclick="toDetail(${train.id},2);">
									<img src="${pageContext.request.contextPath}${train.img}" style="width:260px;height:155px;"class="img-responsive">
								</a>
							</div>
							<div class="course-info ">
								<div class="title text-center">
									<a class="link-dark text-center" href="javascript:void(0)" target="_blank">${train.name }</a>
								</div>
								<div class="metas clearfix text-center">
									<span>创建人:${train.username }</span>
									<span class="num" style="margin-left: 30px;"><i class="es-icon es-icon-people"></i>${train.studentNum }</span>

								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<c:if test="${empty trainList }">
				<div class="empty">暂无数据</div>
			</c:if>
			<c:if test="${!empty trainList }">
				<div id="test" class="pager" style="clear: both;"></div>
			</c:if>

		</div>
	</div>
</div>
<script type="text/javascript">
    function doSearchType(){
        var simple_type = $("input[name = 'simple_train']").prop("checked")?1:0;
        var complex_type = $("input[name = 'complex_train']").prop("checked")?2:0;
        var train_type = simple_type+complex_type;
        if(train_type==0||train_type==3){
            train_type=-1
        }else{
            train_type-=1;
        }
        $("#page").val(0);
        $("#type").val(train_type);
        $('#communityForm').submit();
    }
</script>