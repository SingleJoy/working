<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>
<%-- 
<link href="${pageContext.request.contextPath}/frontstage/js/JMEditor/style/default.css" rel="stylesheet" media="screen" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/JMEditor/jmeditor/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/JMEditor/jmeditor/JMEditor.js"></script>
--%>
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/wangEditor/wangEditor.min.js"></script>
<%-- 
<style>
	#cke_profile{margin-left:150px;}

</style>
--%>
<div class="cn-wrap">

	<div id="content-container" class="container">

		<jsp:include page="course_header.jsp"></jsp:include>
		<div class="row">
			<jsp:include page="course_left.jsp"></jsp:include>
			<div class="col-md-9" >
				<div class="panel panel-default panel-col">
					<div class="panel-heading">详细信息</div>

					<div class="panel-body">

						<form id="courseDetail" action="${pageContext.request.contextPath}/course_info/save_course_detail.action" method="post" class="form-horizontal">
							<input type="hidden" name="courseInfoId" value="${courseView.courseInfoId }"/>
							<input type="hidden" name="id" value="${courseView.id }"/>
							<input type="hidden" name="sign" value="${courseView.sign }"/>
							<div class="course_save_succ alert alert-success" <c:if test="${courseView.flag!=1}">style="display:none;"</c:if>>课程详细信息已保存!</div>

							<div class="form-group">
								<div class="col-md-2 control-label">
									<label><span class="text-danger">*</span>课程简介</label>
								</div>
								<%-- 
								<div class="col-md-8 controls editDemo" id="profile"  contentEditable="true"></div>
								--%>
								<div id="profile" style="width:620px;margin-left:150px;">
									${courseView.profile }
								</div>
								<%-- 
								<input type="hidden" name="profile" value="${courseView.profile }"/>
								--%>
								<textarea style="display: none;" name="profile">
									${courseView.profile }
								</textarea>
								<div class="text-danger" id="profile_message" style="display: none;">课程简介不能为空</div>
								<script type="text/javascript">
                                    var E = window.wangEditor;
                                    var weditor = new E("#profile");
                                    //保存图片到服务器
                                    weditor.customConfig.uploadImgServer = "${pageContext.request.contextPath}/upload_file/upload_resource.action?source_id=${courseView.id}&source_type=0";
                                    //限制图片大小
                                    weditor.customConfig.uploadImgMaxSize = 3*1024*1024;
                                    //图片上传上限
                                    weditor.customConfig.uploadImgMaxLength = 1;
                                    //隐藏"网络图片"选项
                                    weditor.customConfig.showLinkImg = false;
                                    weditor.create();
								</script>
							</div>
							

							<div class="form-group">
								<div class="col-md-2 control-label">
									<label>课程目标</label>
								</div>
								<div class="col-md-8 controls">
									<input type="text" name="target" value="${courseView.target }" class="form-control"></div>

							</div>

							<div class="form-group">
								<div class="col-md-2 control-label">
									<label>适应人群</label>
								</div>
								<div class="col-md-8 controls">
									<input type="text" name="crowd" value="${courseView.crowd }" class="form-control"></div>
							</div>

							<div class="form-group">
								<div class="col-md-8 col-md-offset-2 controls">
										<button type="button" onclick="doSumbit();" class="btn btn-fat btn-primary">保存</button>
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
	$(function(){
		<%-- 
		var profileVal = $("input[name='profile']").val();
		//给JMEditor赋值
		var editor = CKEDITOR.replace("profile",{
			skin: "moono-lisa",width:540, height:200,margin:"0,0,0,120", 
		});
		if(profileVal!=''){
			weditor.txt.html(profileVal);
		}
		--%>
		<%--
		$("#cke_profile").blur(function(){
			$("input[name='profile']").val(JMEditor.html('profile'));
		});
		--%>
	});

	
	function vaildate(){
		var profile = $("textarea[name='profile']").val();
		if(profile!=null&&profile.trim()!=="<p><br></p>"){
			$("#profile_message").css("display","none");	
			return true;
		}
		$("#profile_message").css("display","");
		return false;
	}
	
	function doSumbit(){
		$("textarea[name='profile']").val(weditor.txt.html());
		if(vaildate()){
			document.getElementById('courseDetail').submit();
		}
	};
</script>

