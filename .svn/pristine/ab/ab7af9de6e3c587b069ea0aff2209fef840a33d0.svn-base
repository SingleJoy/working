<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>
<div class="cn-wrap">



	<div id="content-container" class="container">
		<c:if test="${communityView.source_type==0 }">
			<jsp:include page="community_header.jsp" ></jsp:include>
		</c:if>
		<c:if test="${workshopView.source_type==1 }">
			<jsp:include page="workshop_header.jsp" ></jsp:include>
		</c:if>
		<div class="row">
			<c:if test="${communityView.source_type==0 }">
				<jsp:include page="community_left.jsp"></jsp:include>
			</c:if>
			<c:if test="${workshopView.source_type==1 }">
				<jsp:include page="workshop_left.jsp"></jsp:include>
			</c:if>
			<div class="col-md-9">

				<div class="panel panel-default panel-col">
					<div class="panel-heading">培训列表</div>
					<c:if test="${!empty communityTrains }">
						<div class="panel-body">
							<form class="form-horizontal form-inline well well-sm" action="${pageContext.request.contextPath }/class_belongs/to_community_train.action" method="post" id="communityTrainForm">

								<div class="form-group">
									<input type="hidden" name="id" value="${communityTrainView.source_id }"/>
									<input type="hidden" name="source_type" value="${communityTrainView.source_type }"/>
									<input type="hidden" name="stamp" value="${communityTrainView.stamp }"/>
									<input type="hidden" name="page" id="page" value="${communityTrainView.page}" />
									<input type="hidden" name="rows" id="rows" value="${communityTrainView.rows}" />
									<input type="hidden" name="total" id="total" value="${communityTrainView.total}" />
									<input type="hidden" name="totalPage" id="totalPage" value="${communityTrainView.totalPage}" />
									<input type="text"  name="name" class="form-control" value="${communityTrainView.name }" placeholder="关键词">
									<input type="hidden" name="sort_type" id="sort_type" value="${communityTrainView.sort_type}" />
						    				<input type="hidden" name="sort_desc" id="sort_desc" value="${communityTrainView.sort_desc}" />
									<input type="button" class="btn btn-primary btn-sm" value="搜索" onclick="onSubmit()"/>
								</div>
							</form>
							<table class="table table-striped">
								<!--默认箭头向下,即caret,点击重新排序之后箭头向上,即caret_01-->
								<tbody>
								<tr>
									<th class="active" width="4%;"><input type="checkbox" class="checkAll"></th>
									<th class="active" width="15%">培训</th>
									<th class="active" width="15%">班级</th>
									<th class="active" width="10%">主办方</th>
									<th class="active" width="10%">课程数量</th>
									<th class="active" width="12%">学习人数
										<c:choose>
		                                    <c:when test="${communityTrainView.sort_type==1&&communityTrainView.sort_desc==1 }">
		                                           <span class="caret_01" onclick="communityTrainSort(1,0)"></span>
		                                    </c:when>
		                                    <c:otherwise>
		                                           <span class="caret" onclick="communityTrainSort(1,1)"></span>
		                                    </c:otherwise>
		                                </c:choose>
									</th>
									<th width="6%" >推荐</th>
									<th class="active" width="10%">状态
										<c:choose>
	                                        <c:when test="${communityTrainView.sort_type==2&&communityTrainView.sort_desc==1 }">
	                                              <span class="caret_01" onclick="communityTrainSort(2,0)"></span>
	                                        </c:when>
	                                        <c:otherwise>
	                                              <span class="caret" onclick="communityTrainSort(2,1)"></span>
	                                        </c:otherwise>
	                                    </c:choose>
									</th>
									<th class="active" width="14%">
										<div class="btn-group" style="">
											<a href="#" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown">操作</a>
											<button type="button" class="btn btn-default dropdown-toggle btn-sm" data-toggle="dropdown" aria-expanded="false">
												<span class="caret"></span>
											</button>
											<ul class="dropdown-menu pull-right" role="menu">
												<li><a href="javascript:void (0);" onclick="updateCourseStatus(0)">开启</a></li>
												<li><a href="javascript:void (0);" onclick="updateCourseStatus(1)">关闭</a></li>

											</ul>
										</div>
									</th>
								</tr>
								<c:choose>
									<c:when test="${empty communityTrains }">
										<tr class="border">
											<td colspan="7" align="center">
												<span>暂无培训班级信息</span>
											</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach items="${communityTrains }" var="ct">
											<tr class="border">
												<td class="active"><input type="checkbox" name="subId" value="${ct.classifyBelongsId }"/></td>

												<td  style="text-overflow:ellipsis;white-space: nowrap;max-width: 200px;overflow: hidden;" title="${ct.trainName }">${ct.trainName }</td>
												<td>${ct.name }</td>
												<td>${ct.sponsor }</td>
												<td>${ct.courseTotal }</td>
												<td>${ct.total }</td>
												<td>
										<c:if test="${ct.recommended==0 }">否</c:if>
										<c:if test="${ct.recommended!=0 }">是</c:if>
										</td>
												<td>
													<c:choose>
														<c:when test="${ct.status==0 }">
															<span class="text-info">开启</span>
														</c:when>
														<c:when test="${ct.status==1 }">
															<span class="text-danger">关闭</span>
														</c:when>
													</c:choose>
												</td>
												<td>
													<c:choose>
														<c:when test="${ct.status==0 }">
															<span class="text-info"><a href="${pageContext.request.contextPath }/class_belongs/to_update_classbelongs_status.action?id=${communityTrainView.source_id}&source_type=${communityTrainView.source_type}&stamp=${communityTrainView.stamp}&ids=${ct.classifyBelongsId }&status=1">关闭</a></span>
														</c:when>
														<c:when test="${ct.status==1 }">
															<span class="text-danger"><a href="${pageContext.request.contextPath }/class_belongs/to_update_classbelongs_status.action?id=${communityTrainView.source_id}&source_type=${communityTrainView.source_type}&stamp=${communityTrainView.stamp}&ids=${ct.classifyBelongsId }&status=0">开启</a></span>
														</c:when>
													</c:choose>
														<c:if test="${ct.recommended==0 }"><span class="text-info recommended"  style="cursor: pointer;" data-train="${ct.trainId}">推荐</span></c:if>
										<c:if test="${ct.recommended!=0 }"><span class="text-info unrecommended"  style="cursor: pointer;" data-train="${ct.trainId}">取消推荐</span></c:if>
														
													</td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
								</tbody>
							</table>
							<div id="test" class="pager" ></div>
						</div>
					</c:if>

					<c:if test="${empty communityTrains }">
						<div class="empty"> 竟然还没有培训项目，快去添加培训项目吧！</div>
					</c:if>



				</div>
			</div>
		</div>
	</div>
	 <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
</div>
<script type="text/javascript">
	$(".checkAll").click(function(){
		if($(".checkAll").prop("checked")){
			$("[name='subId']").prop("checked","checked");
		}else{
			$("[name='subId']").removeAttr("checked");
		}
	});

	function updateCourseStatus(status){
		if(status!==0&&status!==1){
			return ;
		}
		var ids="";
		$("[name='subId']:checked").each(function(){
			ids+=$(this).val()+","
		});
		if(ids.length<=1){
			return;
		}
		ids = ids.substring(0,ids.length-1);
		window.location.href
				="${pageContext.request.contextPath }/class_belongs/to_update_classbelongs_status.action?id=${communityTrainView.source_id}&source_type=${communityTrainView.source_type}&stamp=${communityTrainView.stamp}&ids="+ids+"&status="+status;
	}
	
	function communityTrainSort(sort_type,sort_desc){
		$("#sort_type").attr("value",sort_type);
		$("#sort_desc").attr("value",sort_desc);
		onSubmit();
	}

	function onSubmit(){
		$("#page").val(0);
		$('#communityTrainForm').submit();
	}

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
				$('#communityTrainForm').submit();
			}
		});
	});
	$(".recommended").click(function () {
	var source_id=  $(this).data("train");
	$("#recommended_source_id").val(source_id);
	$("#recommended_source_type").val(4);
	 $("#recommended_modal").modal("show");
	
});
$(".unrecommended").click(function () {
	var source_id=  $(this).data("train");
	unrecommended(source_id,4);
	
});
</script>