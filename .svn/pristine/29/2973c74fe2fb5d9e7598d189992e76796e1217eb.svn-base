<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<link href="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.js"></script>
<style>
	#defaultImg{
		width:540px;height:270px;}
	.file:hover{color: #fff;}
	.webuploader-pick>div>label:hover{color: #fff;}
</style>
<div class="cn-wrap">

	<div id="content-container" class="container">

		<jsp:include page="train_header.jsp"></jsp:include>

		<div class="row">

			<jsp:include page="train_left.jsp"></jsp:include>

			<div class="col-md-9">
				<div class="panel panel-default panel-col">
					<div class="panel-heading">封面图片</div>
					<div class="panel-body">
						<form id="trainPicture" action="${pageContext.request.contextPath}/train/save_train.action" method="post" style="height: 700px;">
							<input type="hidden" name="id" value="${trainView.id }"/>
							<input type="hidden" name="sign" value="${trainView.sign }"/>
							<input type="hidden" name="type" value="${trainView.type }"/>
							<input type="hidden" name="is_default_img" value="1"/>
							<input type="hidden" name="flag" value="1"/>

							<div class="course_save_succ alert alert-success" <c:if test="${trainView.flag!=1}">style="display:none;"</c:if>>培训图片上传成功!</div>
							<div class="form-group clearfix">
								<div id="fileList" class="col-md-offset-2 col-md-8 controls">
									<img class="img-responsive" id="defaultImg" src="${pageContext.request.contextPath}${trainView.img}">
								</div>
							</div>

							<div class="form-group clearfix">
								<div class="col-md-offset-2 col-md-8 controls">
									<div class="help-block">你可以上传jpg, gif, png格式的文件, 图片建议尺寸至少为525x350。<br>
										文件大小不能超过<strong>2M</strong>。
									</div>
								</div>
							</div>

							<div class="form-group clearfix" id="upload_course_picture_content">
								<div class="col-md-offset-2 col-md-8 controls">
									<a class="btn btn-fat btn-primary" id="file">选择要上传的图片</a>
								</div>
							</div>
							<div style="display:none" class="form-group clearfix col-md-offset-2 col-md-8 controls" id="save_course_picture_content">
								<button onclick="doSumbit();" type="button" class="btn btn-primary btn-fat">保存</button>
								<a href="javascript:void(0);" onclick="backUpload();" class="go-back btn btn-link">重新选择</a>
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
		document.getElementById('trainPicture').submit();
	}
	function backUpload(){
		window.location.href="${pageContext.request.contextPath}/train/to_train_info.action?id="+${trainView.id }+"&flag=2&sign=2";
	}
	$(function(){
		var uploader = WebUploader.create({
			auto: true,
			// swf文件路径
			swf: '${pageContext.request.contextPath}/frontstage/js/webuploader/Uploader.swf',
			// 文件接收服务端。
			server: '${pageContext.request.contextPath}/train/upload_img.action',

			// 选择文件的按钮。可选。
			// 内部根据当前运行是创建，可能是input元素，也可能是flash.
			pick: '#file',

			// 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
			resize: false,
			accept: {
				title: 'Images',
				extensions: 'gif,jpg,jpeg,bmp,png',
				mimeTypes: 'image/jpg,image/jpeg,image/png'   //修改这行
			}
		});
		/**
		 *上传成功后
		 *file:文件
		 *response:服务器返回
		 */
		uploader.on( 'uploadSuccess', function( file,response  ) {
			var hidden=$('<input type="hidden" value="'+response.fileName+'" name="img" class="hidden">' );
			var $form=$("#trainPicture");
			$form.append(hidden);
		});

		// 当有文件添加进来的时候
		uploader.on( 'fileQueued', function( file ) {

			// <input type="hidden">
			var $img;
			var $li = $(
							'<div id="' + file.id + '" class="file-item thumbnail">' +
							'<img style="margin:20 0 0 110">' +
								/*  '<div class="info">' + file.name + '</div>' + */
							'</div>'
					),
					$img = $li.find('img');
			var   $list=$("#fileList");

			// $list为容器jQuery实例
			$list.append( $li );
			$("#defaultImg").css("display","none");
			$("#upload_course_picture_content").css("display","none");
			$("#save_course_picture_content").css("display","");


			// 创建缩略图
			// 如果为非图片文件，可以不用调用此方法。
			// thumbnailWidth x thumbnailHeight 为 100 x 100
			uploader.makeThumb( file, function( error, src ) {
				if ( error ) {
					$img.replaceWith('<span>不能预览</span>');
					return;
				}

				$img.attr( 'src', src );
			}, 480, 270 );
		});
	});

</script>

<%--<jsp:include page="../layout/footer.jsp"></jsp:include>--%>