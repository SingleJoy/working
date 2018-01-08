<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>
<div class="cn-wrap">

	<div id="content-container" class="container">

		<c:if test="${communityView.source_type==0 }">
			<jsp:include page="community_header.jsp"></jsp:include>
		</c:if>

		<div class="row">

			<c:if test="${communityView.source_type==0 }">
				<jsp:include page="community_left.jsp"></jsp:include>
			</c:if>

			<div class="col-md-9">

				<div class="panel panel-default panel-col">

					<div class="panel-heading">
						<a href="${pageContext.request.contextPath }/plan/to_add_or_update_plan.action?community_id=${communityView.id }&source_type=${communityView.source_type }" class="btn btn-info pull-right">创建计划</a>
						计划管理
					</div>
					<c:if test="${!empty plans }">

	                    <div class="panel-body">
	
	                        <div class="row">
	
	                            <div class="col-md-12">
	
									<form class="form-horizontal form-inline well well-sm" method="post" action="${pageContext.request.contextPath}/plan/to_plan_managers.action" id="planForm">
											<input type="hidden" name="id" value="${planView.community_id }"/>
											<input type="hidden" name="source_type" value="${planView.source_type }"/>
											<input type="hidden" name="stamp" value="${planView.stamp }"/>
	                                        <input type="hidden" name="page" id="page" value="${planView.page}" /> 
											<input type="hidden" name="rows" id="rows" value="${planView.rows}" />
											<input type="hidden" name="total" id="total" value="${planView.total}" />
						    				<input type="hidden" name="totalPage" id="totalPage" value="${planView.totalPage}" />
						    				<input type="hidden" name="sort_type" id="sort_type" value="${planView.sort_type}" />
						    				<input type="hidden" name="sort_desc" id="sort_desc" value="${planView.sort_desc}" />
	                                        <div class="form-group">
	                                            <input type="text"  name="name" class="form-control" value="${planView.name }" placeholder="关键词">
	                                            <button class="btn btn-primary btn-sm" onclick="onSubmit()">搜索</button>
	                                        </div>
	
	                                        <table class="table table-striped" >
	                                            <!--默认箭头向下,即caret,点击重新排序之后箭头向上,即caret_01-->
	                                            <tbody>
	                                            <tr>
	                                                <th  width="4%"><input type="checkbox" class="checkAll"></th>
	                                                <th >计划名称</th>
	                                                <th>学时
	                                                	<c:choose>
	                                                		<c:when test="${planView.sort_type==1&&planView.sort_desc==1 }">
	                                                			<span class="caret_01" onclick="planSort(1,0)"></span>
	                                                		</c:when>
	                                                		<c:otherwise>
	                                                			<span class="caret" onclick="planSort(1,1)"></span>
	                                                		</c:otherwise>
	                                                	</c:choose>
	                                                </th>
	                                                <th >学分
	                                                	<c:choose>
	                                                		<c:when test="${planView.sort_type==2&&planView.sort_desc==1 }">
	                                                			<span class="caret_01" onclick="planSort(2,0)"></span>
	                                                		</c:when>
	                                                		<c:otherwise>
	                                                			<span class="caret" onclick="planSort(2,1)"></span>
	                                                		</c:otherwise>
	                                                	</c:choose>
	                                                </th>
	                                                <th >开始日期</th>
	                                                <th >结束日期</th>
	                                                <th >创建日期</th>
	                                                <th >状态</th>
	                                                <th >
	                                                    <div class="btn-group" >
	                                                        <a href="#" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown">管理</a>
	                                                        <button type="button" class="btn btn-default dropdown-toggle btn-sm" data-toggle="dropdown" aria-expanded="false">
	                                                            <span class="caret"></span>
	                                                        </button>
	                                                        <ul class="dropdown-menu pull-right" role="menu">
	                                                            <li><a href="javascript:void (0);" onclick="updatePlanStatus(1)">发布</a></li>
	                                                            <li><a href="javascript:void (0);" onclick="updatePlanStatus(0)">取消发布</a></li>
	                                                            <li><a href="javascript:void (0);" onclick="delPlans()">删除</a></li>
	                                                        </ul>
	                                                    </div>
	                                                </th>
	                                            </tr>
												<c:choose>
													<c:when test="${empty plans }">
														<tr>
															<td colspan="9" align="center">暂无数据</td>
														</tr>
													</c:when>
													<c:otherwise>
														<c:forEach items="${plans }" var="plan">
															<tr>
				                                                <td class="active"><input type="checkbox" name="subId" value="${plan.id }"></td>
				                                                <td style="text-overflow:ellipsis;white-space: nowrap;max-width: 100px;overflow: hidden;" title="${plan.name }">${plan.name }</td>
				                                                <td>${plan.hour }</td>
				                                                <td>${plan.credit }</td>
				                                                <td style="font-size: 10px;"><fmt:formatDate value="${plan.start_time }" pattern="yyyy-MM-dd"/></td>
				                                                <td style="font-size: 10px;"><fmt:formatDate value="${plan.end_time }" pattern="yyyy-MM-dd"/></td>
				                                                <td style="font-size: 10px;"><fmt:formatDate value="${plan.create_time }" pattern="yyyy-MM-dd"/></td>
				                                                <td>
				                                                	<c:choose>
				                                                		<c:when test="${plan.status==0 }">
				                                                			未发布
				                                                		</c:when>
				                                                		<c:when test="${plan.status==1 }">
				                                                			发布
				                                                		</c:when>
				                                                	</c:choose>
				                                                </td>
				                                                <td>
				                                               		&nbsp;<a href="${pageContext.request.contextPath }/plan/to_add_or_update_plan.action?id=${plan.id}&community_id=${planView.community_id}&source_type=${planView.source_type}&stamp=${planView.stamp}">编辑</a>&nbsp;
				                                               		&nbsp;<a href="${pageContext.request.contextPath }/plan/del_plan.action?id=${plan.id}&community_id=${planView.community_id}&source_type=${planView.source_type}&stamp=${planView.stamp}">删除</a>&nbsp;
				                                                </td>
	                                            			</tr>
														</c:forEach>
													</c:otherwise>
												</c:choose>
	                                            </tbody>
	                                        </table>
										  <div id="test" class="pager" ></div>
									</form>
								</div>
							</div>
						</div>
                    	</c:if>
					<c:if test="${empty plans }">
						<div class="empty">然而确还没有课任何计划安排，快去添加计划安排吧！</div>

					</c:if>




                	</div>
				</div>
			</div>
		</div>
</div>


<script type="text/javascript">
	$(".checkAll").click(function(){
		if($(".checkAll").prop("checked")){
			$("[name='subId']").prop("checked","checked");
		}else{
			$("[name='subId']").removeAttr("checked");
		}		
	});
	
	function onSubmit(){
		$("#page").val(0);
		$('#planForm').submit();
	}
	
	function updatePlanStatus(status){
		if(status!==0&&status!==1&&status!==2){
			return ;
		}
		var ids="";
		$("[name='subId']:checked").each(function(){
			ids+=$(this).val()+",";
		});
		if(ids.length<=1){
			return ;
		}
		ids=ids.substring(0,ids.length-1);
		window.location.href="${pageContext.request.contextPath}/plan/to_update_plan_status.action?id="+${planView.id}+"&source_type="+${planView.source_type}+"&stamp="+${planView.stamp}+"&ids="+ids+"&status="+status;
	}
	
	function delPlans(){
		var ids="";
		$("[name='subId']:checked").each(function(){
			ids+=$(this).val()+",";
		});
		if(ids.length<=1){
			return ;
		}
		ids=ids.substring(0,ids.length-1);
		window.location.href="${pageContext.request.contextPath}/plan/del_plans.action?id="+${planView.id}+"&source_type="+${planView.source_type}+"&stamp="+${planView.stamp}+"&ids="+ids;
	}
	
	function planSort(sort_type,sort_desc){
		$("#sort_type").attr("value",sort_type);
		$("#sort_desc").attr("value",sort_desc);
		onSubmit();
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
	            $('#planForm').submit();

	        }
	    });
	});
</script>