<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/My97DatePicker/WdatePicker.js"></script>

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
                        <a href="#" class="btn btn-default pull-right" onclick="cannelPlan()">返回</a>
                        创建计划
                    </div>

                    <div class="panel-body">
                        <form class="form-horizontal" action="${pageContext.request.contextPath }/plan/save_plan.action" method="post" id="planForm"  novalidate="novalidate" >
							<c:if test="${!empty plan }">
								<input type="hidden" name="id" value="${plan.id }"/>
							</c:if>
							<input type="hidden" name="community_id" value="${communityView.id }" id="cid"/>
                            <div class="form-group">
                                <div class="col-md-2 control-label"><label><span class="text-danger">*</span>计划名称:</label></div>
                                <div class="col-md-6 controls">
                                    <input type="text"  class="form-control" name="name" <c:if test="${!empty plan }">value="${plan.name }"</c:if>/>
                                   
                                </div>
                            </div>


                            <div class="form-group">
                                <div class="col-md-2 control-label"><label><span class="text-danger">*</span>学时:</label></div>
                                <div class="col-md-2 controls">
                                    <input type="text"  class="form-control" name="hour" <c:if test="${!empty plan}">value="${plan.hour }"</c:if>/>
                                    
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-md-2 control-label"><label><span class="text-danger">*</span>学分:</label></div>
                                <div class="col-md-2 controls">
                                    <input type="text"  class="form-control" name="credit" <c:if test="${!empty plan}">value="${plan.credit }"</c:if>/>
                                    
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-md-2 control-label"><label><span class="text-danger">*</span>开始时间:</label></div>
                                <div class="col-md-2 controls">
                                    <input type="text"  class="form-control" name="start_time" onClick="WdatePicker()" <c:if test="${!empty plan}">value='<fmt:formatDate value="${plan.start_time }" type="date"/>'</c:if>/>
                                    
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-md-2 control-label"><label><span class="text-danger">*</span>结束时间:</label></div>
                                <div class="col-md-2 controls">
                                    <input type="text"  class="form-control" name="end_time" onClick="WdatePicker()" <c:if test="${!empty plan}">value='<fmt:formatDate value="${plan.end_time }" type="date"></fmt:formatDate>'</c:if>/>
                                    
                                </div>
                            </div>

                            <div class="form-group clearfix">
                                <div class="col-md-2 controls col-md-offset-1" >
                                    <button class="btn btn-fat btn-info" type="submit">
                                    	<c:choose>
                                    		<c:when test="${empty plan}">
                                    			创建
                                    		</c:when>
                                    		<c:otherwise>
                                    			编辑
                                    		</c:otherwise>
                                    	</c:choose>
                                    </button>
                                </div>
                                <div class="col-md-2 controls">
                                    <button class="btn btn-fat btn-danger" type="button" onclick="cannelPlan()">取消</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
	function cannelPlan(){
		var id=$("#cid").attr("value");
		window.location.href = "${pageContext.request.contextPath }/plan/to_plan_managers.action?id="+id+"&source_type=0&stamp=7";
	}
	
	$(document).ready(function(){
		$("#planForm").bootstrapValidator({
			message:'此值无效',
			feedbackIcons:{
				valid: 'glyphicon glyphicon-ok',
				invalid:'glyphicon glyphicon-remove',
				validating:'glyphicon glyphicon-refresh'
			},
			fields:{
				name:{
					message:"计划名称验证失败",
					validators:{
						notEmpty:{
							message:"计划名称不能为空"
						},
						stringLength:{
							min:4,
							max:20,
							message:"计划名称长度为4-20"
						}
					}
				},
				hour:{
					validators:{
						noEmpty:{
							message:"学时不能为空"
						},
						digits:{
							message:"学时只能是数字"
						}
					}
				},
				credit:{
					validators:{
						notEmpty:{
							message:"学分不能为空"
						},
						digits:{
							message:"学分只能是数字"
						}
					}
				}
			}
		}).on("success.form.bv",function(e){
			if(e.type){//验证通过
				document.getElementById('planForm').submit();
			}else{
				e.preventDefault();
			}
		});
	});
</script>