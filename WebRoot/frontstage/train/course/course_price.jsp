<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>



<div class="cn-wrap">

	<div id="content-container" class="container">
		<jsp:include page="course_header.jsp"></jsp:include>

		<div class="row">
			<jsp:include page="course_left.jsp"></jsp:include>
			<div class="col-md-9">
				<div class="panel panel-default panel-col">
					<div class="panel-heading">价格设置</div>
					<div class="panel-body">
						<form id="coursePrice" action="${pageContext.request.contextPath}/course_info/save_course_detail.action" method="post" class="form-horizontal">
							<input type="hidden" name="courseInfoId" value="${courseView.courseInfoId }"/>
							<input type="hidden" name="id" value="${courseView.id }"/>
							<input type="hidden" name="sign" value="${courseView.sign }"/>

							<div class="course_save_succ alert alert-success" <c:if test="${courseView.flag!=1}">style="display:none;"</c:if>>课程价格已经修改成功!</div>

							<div class="row form-group">
								<div class="col-md-2 control-label"><span class="text-danger">*</span>
									<label for="price">价格(元)</label>
								</div>
								<div class="controls col-md-8">
									<input type="text" id="price" name="price" value="${courseView.price}" class="form-control">
									<div class="help-block text-warning" style="display: none;">请输入合法的price,如:200, 221.99, 0.99, 0等</div>
								</div>
							</div>

							<div class="row form-group">
								<div class="col-md-2 control-label"></div>
								<div class="controls col-md-8">
									<button type="submit" class="btn btn-primary" onclick="doSumbit();">保存</button>
								</div>
							</div>

						</form>

					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
</div>




<script type="text/javascript">
	function doSumbit(){
		if(validate()){
			document.getElementById('coursePrice').submit();
		}else{
			return false;
		}
	}
	function validate(){
		var price = $("#price").val();
		if(!isNaN(price)&&price>=0&&price!=''){

			$(".help-block").css("display","none");
			return true;
		}else{

			$(".help-block").css("display","");
			return false;
		}
	}
	$(function(){
		$("#price").blur(function(){
			validate();
		});
	})
</script>
