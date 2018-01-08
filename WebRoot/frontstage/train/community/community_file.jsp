<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>


<div class="cn-wrap">

	<div id="content-container" class="container" style="margin-top: 20px;">
		<c:if test="${communityView.source_type==0 }">
			<jsp:include page="community_header.jsp"></jsp:include>
		</c:if>
		<c:if test="${workshopView.source_type==1 }">
			<jsp:include page="workshop_header.jsp"></jsp:include>
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
					<div class="panel-heading">资源列表</div>
					<c:if test="${!empty resourceList }">
						<div class="panel-body">
							<form class="form-horizontal form-inline well well-sm" action="${pageContext.request.contextPath }/workshop/to_file.action" method="post" id="communityCourseForm">
								<input type="hidden" name="source_id" value="${resourceView.source_id }"/>
								<input type="hidden" name="source_type" value="${resourceView.source_type }"/>
								<input type="hidden" name="page" id="page" value="${resourceView.page}" />
								<input type="hidden" name="rows" id="rows" value="${resourceView.rows}" />
								<input type="hidden" name="total" id="total" value="${resourceView.total}" />
								<input type="hidden" name="totalPage" id="totalPage" value="${resourceView.totalPage}" />
								
								<div class="form-group">
									<input type="text" name="name"  class="form-control" value="${communityCourseView.name }" placeholder="关键词">
									<input type="button" class="btn btn-primary btn-sm" value="搜索" onclick="onSubmit()">
								</div>
							</form>
							<table class="table table-striped">
								<!--默认箭头向下,即caret,点击重新排序之后箭头向上,即caret_01-->
								<tbody>
								<tr class="border">
									<th  width="4%"><input type="checkbox" class="checkAll"></th>

									<th	 width="25%">资源名称</th>
									<th  width="10%">类型</th>
									<th  width="10%">上传人</th>
									<th width="20%">上传时间</th>
									
									<th  width="10%">状态</th>
									
									<th width="10%">
									操作
									</th>
								</tr>
							<c:forEach items="${resourceList }" var="r">
											<tr class="border">
												<td class="active"><input type="checkbox" name="subId" value="${r.fileId }"/></td>
												<td>${r.fileName }</td>
															<td>
															<c:if test="${r.file_type==0 }">文档</c:if>
															<c:if test="${r.file_type==1 }">教案</c:if>
															</td>
												
												<td>${r.uploadName }</td>
												
														<td>${r.uploadTime }</td>
														<td>
														<c:if test="${r.status==0 }">通过</c:if>
														<c:if test="${r.status==1 }">未审核</c:if>
														<c:if test="${r.status==2 }">不通过</c:if>
														
																		</td>
												<td>
													<span class="text-info openStatus review"  style="cursor: pointer;" data-id="${r.fileId }">审核</span>
												<span class="text-info openStatus watch" style="cursor: pointer;"  data-id="${r.fileId }">预览</span>
											</td>
											</tr>
										</c:forEach>
								
								</tbody>
							</table>
							<div id="test" class="pager" style="padding-top:10px;"></div>
						</div>
					</c:if>

					<c:if test="${empty resourceList }">
						<div class="empty">还没有课程，快去添加课程吧！</div>
					</c:if>

				</div>
			</div>

		</div>
	</div>
	    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
</div>

<div class="modal" data-toggle="modal" style="display: none;" id="add_review">
    <div class="modal-dialog modal-lg">
        <div class="panel panel-default panel-col " >
            <div class="panel-heading">
                <button class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <div class="panel-body">
                    <form class="form-horizontal" action="" method="post"  id="reviewForm">
						<input  name="ids" type="hidden" id="review_id">
                        <div class="form-group">
                            <div class="col-md-2 control-label"><label><span class="text-danger">*</span>审核:</label></div>
                            <div class="col-md-6 controls">
                                
                               <select class="form-control" name="status" id="status">
                              <option value="0">---审核通过---</option>
                              <option value="2">---审核不通过---</option>
                               </select>
                            </div>
                        </div>


                        <div class="form-group">
                            <div class="col-md-2 control-label"><label><span class="text-danger"></span>原因:</label></div>
                            <div class="col-md-6 controls">
                                <textarea   class="form-control" rows="4" name="reason" id="reason"></textarea>
                                <div class="help-block" style="display: none;">
                                    <span class="text-danger">请输入内容</span>
                                </div>
                            </div>
                        </div>


                        <div class="form-group clearfix">

                            <div class="col-md-2 controls col-md-offset-2" >
                                <button class="btn btn-fat btn-info" type="button" id="review_btn">保存</button>
                            </div>

                            <div class="col-md-2 controls">
                                <button class="btn btn-fat btn-danger " type="button"  data-dismiss="modal" aria-hidden="true">取消</button>
                            </div>

                        </div>



                    </form>
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

  $(".watch").click(function () {
	 var a=$("<a id='download_a' target='_blank'>");
	 var id=$(this).data("id");
            a.attr("href","${pageContext.request.contextPath}/userFile/to_file.action?id="+id+"&see=see");
            $("body").append(a);
            document.getElementById("download_a").click();
});
	

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
				$('#communityCourseForm').submit();

			}
		});
	});
	$(".review").click(function () {
		 var id=$(this).data("id");
		 $("#review_id").val(id);
		 $("#add_review").modal("show");
	});
	$("#review_btn").click(function () {
		var form=$("#reviewForm");
		 $.ajax({
                    url : '${pageContext.request.contextPath}/my_file_base/save_review_file.action',
                    data :form.serialize() ,
                    dataType : 'json',
                    success : function(response) {
                        location.replace(location.href);
                    }
                });
	})
</script>