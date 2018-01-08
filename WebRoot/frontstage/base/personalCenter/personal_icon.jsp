<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>
<link href="${pageContext.request.contextPath}/frontstage/css/my-space.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/frontstage/js/Jcrop/css/jquery.Jcrop.css">
<link href="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.js"></script>
<script src="${pageContext.request.contextPath}/frontstage/js/Jcrop/js/jquery.Jcrop.js"></script>
<div class="cn-wrap">

	<div id="content-container" class="container">

		<jsp:include page="./personal_header.jsp"></jsp:include>

		<div class="row row-3-9">

			<jsp:include page="./personal_left.jsp"></jsp:include>

			<div class="col-md-9">

				<div class="">

					<div class="panel panel-default panel-col setting-tabs">
						<div class="panel-heading">头像设置</div>

						<div class="panel-body">

							<form id="form" action="${pageContext.request.contextPath}/my_setting/upload.action" method="post" enctype="multipart/form-data" class="form-horizontal">

								<div id="fileList" class="form-group" style="">
									<div class="col-md-offset-2 col-md-4 controls">
										<img id="myimg" class="img-responsive" 
									    <c:if test="${empty fileName}">src="${pageContext.request.contextPath}/picture/default/default.png"</c:if>
									    <c:if test="${!empty fileName}">src="${pageContext.request.contextPath}${fileName}"</c:if>>
									</div>

									<div id="upload_picture" class="col-md-8 col-md-offset-2 controls" style="margin-top: 10px;">
										<a class="btn btn-primary" href="javascript:void (0);" data-toggle="modal"  style="margin-left: 20px;">更换头像</a>
									</div>
									
									<div id="backupload" class="col-md-8 col-md-offset-2 controls" style="margin-top: 10px;display: none;">
										<a class="btn btn-primary" href="javascript:void (0);" onclick="backUpload();" style="margin-left: 20px;">重新选择图片</a>
									</div>
									
								</div>

							</form>
							<form class="form-horizontal"  action="${pageContext.request.contextPath}/my_setting/updateMySetting.action?state=11&stamp=7&upload=1" method="post" id="my_form">
							<input type="hidden" name="id" value="${mySetting.id }">
							<input type="hidden" name="userId" value="${currentUser.id}">
							<input type="hidden" name="icon" class="hidden" id="icon"
                            <c:if test="${empty mySetting.picture}">value="/picture/default/default.jpg"</c:if>
                            <c:if test="${!empty mySetting.picture}">value="${mySetting.picture }"</c:if>>
							<input type="hidden" name="is_default_img" value="1">
							<input id="x" name="x" value="" type="hidden">
							<input id="y" name="y" value="" type="hidden">
							<input id="w" name="w" value="" type="hidden">
							<input id="width" name="width" value="" type="hidden">
							<input id="height" name="height" value="" type="hidden">
							<input id="h" name="h" value="" type="hidden">
							</form>

							<div class="controls col-md-8" style="margin-left: 130px;">
								<button type="submit" class="btn btn-primary btn-fat" id="setting_submit">提交</button>
							</div>

						</div >

					</div>

				</div>

			</div>
		</div>
	</div>
	<jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
</div>


<script type="text/javascript">
 var jcropApi;
 
	$(function(){
		$("#setting_submit").click(function(){
			
			$("#my_form").submit();
		});
	});

	function backUpload(){
		window.location.href="${pageContext.request.contextPath}/my_setting/showMyIcon.action?state=11&stamp=7";
	}
	
    $(function(){
   
    	var uploader = WebUploader.create({

			auto: true,
			// swf文件路径
			swf: '${pageContext.request.contextPath}/frontstage/js/webuploader/Uploader.swf',
			// 文件接收服务端。
			server: '${pageContext.request.contextPath}/cert_model/upload_img.action?realpath=userImages',

			// 选择文件的按钮。可选。
			// 内部根据当前运行是创建，可能是input元素，也可能是flash.
			pick: '#upload_picture',

			// 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
			resize: false,
			accept: {
				title: 'Images',
				extensions: 'jpg,jpeg,bmp,png',
				mimeTypes: 'image/jpg,image/jpeg,image/png'   //修改这行
			}
		});
		/**
		 *上传成功后
		 *file:文件
		 *response:服务器返回
		 */
		uploader.on( 'uploadSuccess', function( file,response  ) {
			$("#icon").val(response.filepath);
			$("#myimg").attr("src","${pageContext.request.contextPath}"+response.filepath);
			$("#upload_picture").hide();
			$("#backupload").show();
			if(jcropApi!=null){
			jcropApi.destroy();
			}
$('#myimg').Jcrop({
  allowSelect: false,
  baseClass: 'jcrop',
  aspectRatio:1,
  minSize:[50,50],
  onSelect:updateCoords
}, function() {
  jcropApi = this;
  jcropApi.getBounds();
  var w=jcropApi.getWidgetSize()[0];
  var h=jcropApi.getWidgetSize()[1];
  $('#width').val(w);
  $('#height').val(h);
  var l=(w<=h)?w:h;
  jcropApi.setSelect([0,0,l,l]);
  jcropApi.enable();
});
		});
		// 当有文件添加进来的时候
		

    })
function updateCoords(c) {

	$('#x').val(c.x);
  $('#y').val(c.y);
  $('#w').val(c.w);
  $('#h').val(c.h);
}
</script>








