<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<style>
	.teacher_info{padding: 5px 0;}
	.course_center_banner>ul>li>a{color: #fff;line-height: 50px;}
</style>

<div class="cn-wrap">



	<div id="content-container" class="container" style="margin-top: 20px;">

		<form id="courseForm" action="${pageContext.request.contextPath}/course/to_course_center.action" method="post">
			<input type="hidden" name="type" id="type" value="${ccv.type}" />
			<input type="hidden" name="page" id="page" value="${ccv.page}" />
			<input type="hidden" name="rows" id="rows" value="${ccv.rows}" />
			<input type="hidden" name="total" id="total" value="${ccv.total}" />
			<input type="hidden" name="totalPage" id="totalPage" value="${ccv.totalPage}" />
			<input type="hidden" name="sortType" id="sortType" value="${ccv.sortType}" />
			<input type="hidden" name="classifyId" id="classifyId" value="${ccv.classifyId}" />
			<input type="hidden" name="classifyName" id="classifyName" value="${ccv.classifyName}"/>
			<input type="hidden" name="sonClassifyId" id="sonClassifyId" value="${ccv.sonClassifyId}"/>
			<input type="hidden" name="sonClassifyName" id="sonClassifyName" value="${ccv.sonClassifyName}"/>
			<input type="hidden" name="price" id="price" value="${ccv.price}" />
			<input type="hidden" name="currSignUp" id="currSignUp" value="${ccv.currSignUp }">
		</form>

		<div class="tabs-wrapper">
			<%--<div class="tabs-mark-group plm ptm" style="min-height: 50px;">--%>
				<%--<div class="title">所有分类：</div>--%>
				<%--<ul class="content list-unstyled list-inline">--%>
					<%--<c:if test="${ccv.classifyId==-1}">--%>
						<%--<li class="classify">--%>
							<%--<a href="javascript:void(0)">--%>

                                <%--全部--%>
								<%--<i class="es-icon es-icon-chevronright"></i>--%>
							<%--</a>--%>
						<%--</li>--%>
					<%--</c:if>--%>
					<%--<c:if test="${ccv.classifyId!=-1}">--%>
						<%--<li class="classify">--%>
							<%--<a href="javascript:void(0)">--%>

									<%--${ccv.classifyName}--%>

								<%--<i class="es-icon es-icon-chevronright"></i>--%>
							<%--</a>--%>
						<%--</li>--%>
						<%--<c:if test="${ccv.sonClassifyId!=-1}">--%>
							<%--<li class="classify">--%>
								<%--<a href="javascript:void(0)">${ccv.sonClassifyName}<i class="es-icon es-icon-chevronright"></i></a>--%>
							<%--</li>--%>
						<%--</c:if>--%>
					<%--</c:if>--%>
				<%--</ul>--%>
			<%--</div>--%>

			<div class="tabs-group">
				<div class="title" onclick="searchClassify(-1,0,-1);" >分类：</div>
				<ul class="content " >
					<li <c:if test="${ccv.classifyId==-1}"> class="active" </c:if>>
						<a class="nav-link" href="javascript:void(0)" onclick="doClassify(-1,'');" >全部</a></li>
					<c:forEach items="${classifyList }" var="classify">
						<li <c:if test="${classify.id==ccv.classifyId}"> class="active" </c:if>>
							<a class="nav-link" href="javascript:void(0)" onclick="doClassify(${classify.id},'${classify.classify_name}');">${classify.classify_name }</a>
						</li>
					</c:forEach>
				</ul>
			</div>

			<div class="tabs-group" id="sonClassify" style="<c:if test="${ccv.classifyId==-1}">display:none;</c:if>">
				<ul class="content clearfix" >
					<li <c:if test="${ccv.sonClassifyId==-1}"> class="active" </c:if>>
						<%--<a class="nav-link" href="javascript:void(0)" onclick="doSonClassify(-1,'');" >全部</a></li>--%>
						<c:forEach items="${sonClassifyList}" var="sonClassify">
					<li <c:if test="${sonClassify.id==ccv.sonClassifyId}"> class="active" </c:if>>
						<a class="nav-link" href="javascript:void(0)" onclick="doSonClassify(${sonClassify.id},'${sonClassify.classify_name}');">${sonClassify.classify_name }</a>
					</li>
					</c:forEach>
				</ul>
			</div>
		</div>

		<div class="cn-filter">

			<ul class="nav nav-sort clearfix">
				<li><a href="javascript:void(0);" onclick="searchSortType(1);"
					   <c:if test="${ccv.sortType==1}">class="active"</c:if>>最新</a></li>
				<li><a href="javascript:void(0);" onclick="searchSortType(2);"
					   <c:if test="${ccv.sortType==2}">class="active"</c:if>>最热</a></li>
				<%--<li><a href="javascript:void(0);" onclick="searchSortType(3);"--%>
					   <%--<c:if test="${ccv.sortType==3}">class="active"</c:if>>推荐</a></li>--%>

			</ul>

			<div class="filter hidden-xs" id="class_type_sort">
				<label class="checkbox-inline">
					<input type="checkbox" onclick="doCurSignUp();" name="isCurSignUp" <c:if test="${ccv.currSignUp==1}">checked="checked"</c:if> />
					正在报名
				</label>
				<label class="checkbox-inline">
					<input type="checkbox" onclick="searchType();" name="isType" <c:if test="${ccv.type==2}">checked="checked"</c:if> />
					直播课程
				</label>
				<label class="checkbox-inline" onclick="doFree();">
					<input type="checkbox" onclick="doFree();" id="live" value="" name="isFree" <c:if test="${ccv.price==0}">checked="checked"</c:if> />
					免费课程
				</label>

			</div>
		</div>

		<div class="panel panel-col">
			<div class="panel-body">
				<div class="course-list">
					<div class="row">
						<c:forEach items="${courseList}" var="course">
							<div class="col-lg-3 col-md-4 col-xs-6">
								<div class="course-item">
									<div class="course-img">
										<a href="${pageContext.request.contextPath}/user_study/to_course_study.action?page=1&learnId=${course.id }&sourceType=0&tab=-1&is_direct=0" target="_blank">
											<img src="${pageContext.request.contextPath}${course.img}" alt="" class="img-responsive"  style="height: 160px;"/>
										</a>
									</div>
									<div class="course-info">

										<div class="title">
											<a class="link-dark" href="${pageContext.request.contextPath}/user_study/to_course_study.action?page=1&learnId=${course.id }&sourceType=0&tab=-1&is_direct=0"
											   target="_blank" >
													${course.title }
											</a>
											<div class="teacher_info">
												<span class="teacher_name pull-left" title="${course.userName}">
														${fn:substring(course.userName,0,10)}
												</span>
												<span class="teacher_address pull-right" title="${course.school}">

													${fn:substring(course.school,0,11)}
												</span>
											</div>

										</div>

										<div class="metas clearfix">

											<span class="num"><i class="es-icon es-icon-people"></i>${course.studentNum }人参加</span>

											<span class="course-price-widget"> 

												<c:if test="${course.price==0 }">
													<span class="text-success">免费</span>
												</c:if>
												<c:if test="${course.price!=0 }">
													<span class="price"> ￥${course.price }</span>
												</c:if>
											</span>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>

					</div>
					<c:if test="${empty courseList }">
						<div class="empty">暂无数据</div>
					</c:if>
					<c:if test="${!empty courseList }">
						<div id="test" class="pager" ></div>
					</c:if>
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
            pageSize:  $("#rows").val(),            //一页记录数
            onPageChange: function (page) {
                document.title = page;
                $("#page").val(page-1);
                $('#courseForm').submit();

            }
        });
    });

    function searchSortType(value){
        $("#page").val(0);
        $("#sortType").val(value);
        $('#courseForm').submit();
    }

    function searchType(){
        $("#page").val(0);
        var a = document.getElementsByName("isType");
        if(a[0].checked){
            $("#type").val(2);
        }else{
            $("#type").val(0);
        }
        $('#courseForm').submit();
    }

    //一级分类搜索
    function doClassify(id,name){
        $("#page").val(0);
        $("#classifyId").val(id);
        $("#classifyName").val(name);
        $("#sonClassifyId").val(-1);
        $("#courseForm").submit();
    }
    //二级分类搜索
    function doSonClassify(id,name){
        $("#page").val(0);
        $("#sonClassifyId").val(id);
        $("#sonClassifyName").val(name);
        $("#courseForm").submit();
    }

    function doFree(){
        $("#page").val(0);
        var a = document.getElementsByName("isFree");
        if(a[0].checked){
            $("#price").val(0);
        }else{
            $("#price").val(1);
        }
        $('#courseForm').submit();
    }
    
    function doCurSignUp(){
    	$("#page").val(0);
    	var a = document.getElementsByName("isCurSignUp");
        if(a[0].checked){
            $("#currSignUp").val(1);
        }else{
            $("#currSignUp").val(0);
        }
        $('#courseForm').submit();
    }

    function toCourseDetail(value){
        window.location.href="${pageContext.request.contextPath}/user_study/to_course_study.action?page=1&learnId="+value+"&sourceType=0&tab=1&is_direct=0";
    }



</script>



