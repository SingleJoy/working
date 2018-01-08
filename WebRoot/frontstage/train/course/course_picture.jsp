<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<link rel="stylesheet" href="${pageContext.request.contextPath}/frontstage/js/Jcrop/css/jquery.Jcrop.css">
<script src="${pageContext.request.contextPath}/frontstage/js/Jcrop/js/jquery.Jcrop.js"></script>


<link href="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.js"></script>
<style>
	
</style>
<div class="cn-wrap">

	<div id="content-container" class="container">
		<jsp:include page="course_header.jsp"></jsp:include>

		<div class="row">
			<jsp:include page="course_left.jsp"></jsp:include>
			<div class="col-md-9">


				<div class="panel panel-default panel-col">
					<div class="panel-heading">
						课程图片
					</div>
					<form id="coursePicture" action="${pageContext.request.contextPath}/course_info/save_course_detail.action" method="post" style="height: 700px;">
						<input type="hidden" name="courseInfoId" value="${courseView.courseInfoId }"/>
						<input type="hidden" name="id" value="${courseView.id }"/>
						<input type="hidden" name="sign" value="${courseView.sign }"/>
                        <input type="hidden" name="is_default_img" value="1"/>
						<input id="x" name="x" value="" type="hidden">
							<input id="y" name="y" value="" type="hidden">
							<input id="w" name="w" value="" type="hidden">
							<input id="width" name="width" value="" type="hidden">
							<input id="height" name="height" value="" type="hidden">
							<input id="h" name="h" value="" type="hidden">
						<div class="panel-body" >

							<div id="fileList" class="upload_course_picture" ></div>


							<div class="form-group clearfix">
								<div class="col-md-offset-2 col-md-4 controls">
									<img id="defaultImg" class="" src="${pageContext.request.contextPath}${courseView.img}"  style="width: 400px"/>
								</div>
							</div>

						</div>

						<div class="form-group clearfix">
							<div class="col-md-offset-2 col-md-8 controls">
								<div class="help-block">你可以上传jpg, gif, png格式的文件, 图片建议尺寸至少为480x270。<br>文件大小不能超过<strong>2M</strong>。</div>
							</div>
						</div>


						<div class="form-group clearfix" id="upload_picture">
							<div class="col-md-offset-2 col-md-8 controls" >
								<a class="file btn btn-info btn-fat" href="javascript:void(0);">
									选择要上传的图片</a>
							</div>
						</div>

						<div class="form-group clearfix save_course_picture_content" style="display: none;" id="backupload" >
							<div class="col-md-offset-2 col-md-8 controls">
								<button class="btn btn-fat btn-primary" onclick="doSumbit();">保存</button>
								<a href="javascript:;" class="go-back btn btn-link" onclick="backUpload();">重新选择图片</a>
							</div>
						</div>


					</form >
			</div>
		</div>
	</div>
</div>
<jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
</div>


<script type="text/javascript">
 var jcropApi;
    function doSumbit(){
        document.getElementById('coursePicture').submit();
    }
    function backUpload(){
        window.location.href="${pageContext.request.contextPath}/course_info/to_course_detail.action?id="+${courseView.id }+"&flag=2&sign=3";
    }
    $(function(){
        var uploader = WebUploader.create({
            auto: true,
            // swf文件路径
            swf: '${pageContext.request.contextPath}/frontstage/js/webuploader/Uploader.swf',
            // 文件接收服务端。
            server: '${pageContext.request.contextPath}/course_info/upload_img.action',

            // 选择文件的按钮。可选。
            // 内部根据当前运行是创建，可能是input元素，也可能是flash.
            pick: '.file',

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
            var $form=$("#coursePicture");
            $("#defaultImg").attr("src","${pageContext.request.contextPath}"+response.fileName);
            $form.append(hidden);
            $("#upload_picture").hide();
			$("#backupload").show();
			if(jcropApi!=null){
			jcropApi.destroy();
			}
$('#defaultImg').Jcrop({
  allowSelect: false,
  baseClass: 'jcrop',
  aspectRatio:16/9,
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

 
    });

function updateCoords(c) {

	$('#x').val(parseInt(c.x+""));
  $('#y').val(parseInt(c.y+""));
  $('#w').val(parseInt(c.w+""));
  $('#h').val(parseInt(c.h+""));
};
</script>

