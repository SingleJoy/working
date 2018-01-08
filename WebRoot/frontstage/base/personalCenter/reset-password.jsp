<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../layout/header.jsp"></jsp:include>
<%--<link href="${pageContext.request.contextPath}/frontstage/css/my-space.css" rel="stylesheet" type="text/css">--%>
<%--<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/my-space.js"></script>--%>
<style>
	label{font-weight: normal;}
</style>
<div class="cn-wrap">

	<div id="content-container" class="container">

		<jsp:include page="./personal_header.jsp"></jsp:include>

		<div class="row">

			<jsp:include page="./personal_left.jsp"></jsp:include>

			<div class="col-md-9">
				<div class="">

					<div class="panel panel-default panel-col ">

						<div class="panel-heading">密码修改</div>
						<div class="panel-body">
                             <form id="form" method="post" action="${pageContext.request.contextPath}/user/reset.action" class="form-horizontal">

							<!-- 	 <div class="row form-group">
									 <div class="col-md-2 control-label">
										 <label>原密码</label>
									 </div>
									 <div class="controls col-md-6">
										 <input type="password" id="pas" name="password"  class="form-control"/>
									 </div>
								 </div> -->

								 <div class="row form-group">
									 <div class="col-md-2 control-label">
										 <label>新密码</label>
									 </div>
									 <div class="controls col-md-6">
										 <input type="password" id="pas1" name="newPassword"  class="form-control"/>
									 </div>
								 </div>

								 <div class="row form-group">
									 <div class="col-md-2 control-label">
										 <label>确认新密码</label>
									 </div>
									 <div class="controls col-md-6">
										 <input type="password" id="pas2" name="repetitionNewPassword"  class="form-control"/>
										 <span id = "mm" style="display: none" class="text-danger">两次密码必须一致</span>
									 </div>
								 </div>


								 <div class="form-group">
									 <div class="col-md-offset-2 col-md-8 controls">
										 <button class="btn btn-fat btn-primary"  type="button"  id="save">保存</button>
									 </div>
								 </div>


                        </form>

                    </div>
				</div>
			</div>
		</div>
	</div>
</div>
	<jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
</div>



 <script type="text/javascript">
    var edit_pwd_ok="${flag1}";
    $(document).ready(function(){
        if(edit_pwd_ok=="0"){
        	alert("密码修改失败");
        }else if(edit_pwd_ok=="1"){
        	alert("密码已修改");
        }
    	$("#pas2").keyup(function(){
    		if($("#pas1").val()==$("#pas2").val()){
    		$("#mm").css("display","none");
    	}
    	else{
    	$("#mm").css("display","");
    	}
    	});
    	$("#pas1").keyup(function(){
    		if($("#pas1").val()==$("#pas2").val()){
    		$("#mm").css("display","none");
    	
    	}
    	else{
    	$("#mm").css("display","");
    	}
    	});
    	
    	$("#save").click(function(){
    	if($("#pas1").val()==""&&$("#pas2").val()==""){
    	alert("请输入内容");
    	}
    	else if($("#pas1").val()!=""&&$("#pas2").val()!=""){
    		
    		if($("#pas1").val()==$("#pas2").val()){
    		$("#form").submit();
    		}
    	
    	else{
    	
    	alert("两次输入不一致");
    	
    	}
    	
    	}
    	else{
    	
    	alert("请输入新密码");
    	
    	}
    	});
    		
    	});
    </script>

