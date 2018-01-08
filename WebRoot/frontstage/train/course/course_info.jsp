<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>



<div class="cn-wrap">

	<div id="content-container" class="container">

		<jsp:include page="course_header.jsp"></jsp:include>
		<div class="row">
			<jsp:include page="course_left.jsp"></jsp:include>

			<div class="col-md-9" >
				<div class="panel panel-default panel-col">
					<div class="panel-heading">基本信息</div>

					<div class="panel-body">
						<form id="courseInfo" action="${pageContext.request.contextPath}/course/save_course.action" method="post" class="form-horizontal">
							<input type="hidden" name="id" value="${courseView.id }"/>
							<input type="hidden" name="labelId" id="labelId" <c:if test="${empty courseView.labelId }">value="0"</c:if> <c:if test="${!empty courseView.labelId }">value="${courseView.labelId}"</c:if>/>

							<div class="course_save_succ alert alert-success" <c:if test="${courseView.flag!=1}">style="display:none;"</c:if>>课程基本信息已保存!</div>

							<div class="form-group">
								<div class="col-md-2 control-label"><span class="text-danger">*</span><label>标题</label></div>
								<div class="col-md-8 controls"  >
									<div class="col-md-8 controls">
										<input type="text" id="title" name="title" value="${courseView.title}" class="form-control">
									</div>
                                   <div class="text-warning title_val" style="display: none;">请输入标题(标题长度不得超过18个字)</div>
								</div>
							</div>



							<div class="form-group">
								<div class="col-md-2 control-label"><span class="text-danger">*</span><label>学时</label></div>
								<div class="col-md-8 controls"  >
									<div class="col-md-8 controls">
										<input type="text" id="hours" name="hours" value="${courseView.hours}" class="form-control"/>
									</div>
									<div class="text-warning hours_val" style="display: none;">请输入正确学时</div>
								</div>
							</div>

							<%--<div class="form-group" >--%>
								<%--<div class="col-md-2 control-label"><label>标签</label></div>--%>
								<%--<div class="col-md-8 controls">--%>
									<%--<input type="text" name="labelName" <c:if test="${courseView.status ==1 }">disabled="disabled"</c:if> id="labelName" class="form-control"--%>
										   <%--value="${courseView.labelName}" readonly="readonly"--%>
										   <%--placeholder="请选择标签,请不要重复添加" /><br/>--%>
									<%--<c:forEach items="${labelList}" var="label" varStatus="status">--%>
										<%--<a href="javascript:void(0);" class="tags_list_a" <c:if test="${courseView.status !=1 }">onClick="selectTag('${label.id}','${label.label_name}')"</c:if> >${label.label_name}</a>--%>
									<%--</c:forEach>--%>
								<%--</div>--%>
							<%--</div>--%>

							<div class="form-group">
								<div class="col-md-2 control-label"><label>是否设置考核标准 </label></div>
								<div class="col-md-8 controls radios">
									<label><input type="radio" <c:if test="${courseView.is_check==0}">checked="checked"</c:if> name="is_check" value="0"/>是</label>
									<label><input type="radio" <c:if test="${courseView.is_check==1}">checked="checked"</c:if> name="is_check" value="1"/>否</label>
								</div>
							</div>
							
							<div class="form-group">
								<div class="col-md-2 control-label"> <span class="text-danger">*</span><label>分类</label></div>
								<div class="col-md-8 controls"  >
									<select name="classify_id" class="form-control width-input width-input-large select2-offscreen">
										<c:forEach items="${pcList}" var="pc">
											<option <c:if test="${courseView.classify_id==pc.id}">selected = "selected"</c:if>
													value="${pc.id}">${pc.classify_name}</option>";
											<c:forEach items="${classifyList}" var="classify">
												<c:if test="${pc.id == classify.parent_id }">
													<option <c:if test="${courseView.classify_id==classify.id}">selected = "selected"</c:if> value="${classify.id}">&nbsp;&nbsp;&nbsp;&nbsp;${classify.classify_name}</option>";
												</c:if>
											</c:forEach>
										</c:forEach>
									</select>
								</div>
							</div>

							<div class="form-group">
								<div class="col-md-offset-2 col-md-8 controls">
										<button type="button" onclick="doSubmit();" class="btn btn-fat btn-primary" >保存</button>
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
function validate(){
	var title = $("#title").val();
	var hours = $("#hours").val();
	var title_val = false;
	var hours_val = false;
	if(title==""||title.length>18){
		$(".title_val").css("display","");
	}else{

		$(".title_val").hide();
		title_val =  true;
	}
	
	if(!isNaN(hours)&&hours>=0&&hours!=''){ 

		$(".hours_val").hide();
		hours_val =  true;
	}else{
		$(".hours_val").css("display","");
	}
     
     if(title_val==true&&hours_val==true){
    	 return true;
     }else{
    	 return false;
     }
     
}
function doSubmit(){
	var val = validate();
	if(val){
        document.getElementById('courseInfo').submit();
	}else{
		return false;
	}
}
$(function(){
	$("#title").blur(function(){
		validate();
  	});
    $("#hours").blur(function(){
		validate();
    });
});

//标签
function selectTag(value,nameVal){
	var labelId = $("#labelId").val();
	var labelName = $("#labelName").val();
	if(labelId!=""){
		var index = labelId.indexOf(value+"-");
		if(index<0){//不包含
			var label = labelId.split("-");
			var flag = 0;
			for(var i=0;i<label.length;i++){
				if(label[i]==value){
					flag = 1;
					break;
				}else{
					flag = 2;
				}
			}
			if(flag==2){
				$("#labelId").val(labelId + value + "-");
				$("#labelName").val(labelName + nameVal + "-");
			}
		}
	}else{
		$("#labelId").val(value + "-");
		$("#labelName").val(nameVal+"");
	}
}

</script>

