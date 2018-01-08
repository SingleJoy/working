<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<link href="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/wangEditor/wangEditor.min.js"></script> 
<script>
window.onload = initForm;
function initForm(){
	var nrefuse = document.getElementById("negativeName");
	nrefuse.onfocus = function(){
		this.blur();
	}
	document.getElementById("stampName").onfocus = function(){
		this.blur();
	}
}
$(function(){
	var uploader1 = WebUploader.create({
		auto: true,
		// swf文件路径
		swf: '${pageContext.request.contextPath}/frontstage/js/webuploader/Uploader.swf',
		// 文件接收服务端。
		server: '${pageContext.request.contextPath}/cert_model/upload_img.action?realpath=certModelPicture',

		// 选择文件的按钮。可选。
		// 内部根据当前运行是创建，可能是input元素，也可能是flash.
		pick: "#negativeUpload",

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
	uploader1.on( 'uploadSuccess', function( file,response  ) {
		$("#negativeName").val(response.filename);
		$("#negativeImg").val(response.filepath);
		$("#negativeTime").val(response.uploadtime);
		$("#negativeId").val("")
	});
	var uploader2 = WebUploader.create({
		auto: true,
		// swf文件路径
		swf: '${pageContext.request.contextPath}/frontstage/js/webuploader/Uploader.swf',
		// 文件接收服务端。
		server: '${pageContext.request.contextPath}/cert_model/upload_img.action?realpath=certModelPicture',

		// 选择文件的按钮。可选。
		// 内部根据当前运行是创建，可能是input元素，也可能是flash.
		pick: "#stampUpload",

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
	uploader2.on( 'uploadSuccess', function( file,response  ) {
		$("#stampName").val(response.filename);
		$("#stampImg").val(response.filepath);
		$("#stampTime").val(response.uploadtime);
		$("#stampId").val("");
	});
	

})


</script>
<div class="cn-wrap">
    <div id="content-container" class="container">
        <jsp:include page="/frontstage/base/personalCenter/personal_header.jsp"></jsp:include>
        <div class="row row-3-9">

            <jsp:include page="/frontstage/base/personalCenter/personal_left.jsp"></jsp:include>

            <div class="col-lg-9 col-md-8  course-detail-main" >

			    <div class="panel panel-default panel-col course-data">
			        <div class="panel-heading"><c:if test="${!empty certModel.id}">证书编辑</c:if><c:if test="${empty certModel.id }">证书创建</c:if>
			            <%-- <a href="course_certificate_show.html" class="btn btn-info pull-right" target="_blank">查看证书模板</a>
			            <a href="${pageContext.request.contextPath}/cert_model/to_cert_model_manager.action?stamp=1&state=29" class="btn btn-info pull-right" >返回证书管理</a> --%>
			        </div>
			        <div class="panel-body">
			
			            <form id="certModel" method="post" action="${pageContext.request.contextPath}/cert_model/save_cert_model.action"  class="form-horizontal">
			
			                <div class="form-group">

			                    <input type="hidden" name="id" value="${certModel.id}"/>
			                    <div class="col-md-2 control-label"><label><span class="text-danger">*</span>证书名称</label></div>
			                    <div class="col-md-8 controls">
			                        <input type="text" id="title" class="form-control" name="title"  value="${certModel.title}" placeholder="证书名" >
									<div class="help-block">如:2016年北京市中小学教师培训</div>
			                     </div>

			                </div>
			
			                <div  class="form-group" style="margin-top: -30px;">
			                    <div class="col-md-2 control-label"><label><span class="text-danger">*</span>证书模板</label></div>
			                    <div class="col-md-6 controls">

			                        <input type="hidden" name="negativeId" id="negativeId" value="${cp1.id}" >
			                        <input type="hidden" id="negativeTime"  name="negativeTime"  value="${cp1.upload_time}"  >
			                        <input type="text" id="negativeName" class="form-control" name="negativeName"  value="${cp1.name}" readonly="readonly"  >

									<input type="hidden" id="negativeImg" name="negativeImg" size="70"  <c:if test="${empty certModel.negative_path}">value="${pageContext.request.contextPath}/frontstage/images/certificate_model.png"</c:if>
                                                 <c:if test="${!empty certModel.negative_path}">value="${pageContext.request.contextPath}${certModel.negative_path}"</c:if>>
			                        <div class="help-block">证书背景图片要求必须1080x800,如不符合要求,请剪切后再上传!</div>
			                     </div>
								<div class="col-md-2 control-label">
									<label style="margin-top: -12px;">
									<!--上传图片触发按钮-->
									<a id="negativeUpload" href="javascript:void(0);" class="btn btn-info btn-sm">
										<i class="glyphicon glyphicon-plus"></i>证书背景图片
									</a>
									</label>
								</div>
			                </div>

			                <div class="form-group">
								<div class="col-md-2 control-label" ><label>证书内容:</label></div>
								<div class="col-md-8 controls editDemo" id="profile"  >${certModel.content}</div>
								<%-- 
								<input type="hidden" id="content" name="content" value='${certModel.content}'/>
								--%>
								<textarea style="display: none;" id="content" name="content">
									${certModel.content}
								</textarea>
								<script type="text/javascript">
                                    var E = window.wangEditor;
                                    var weditor = new E("#profile");
                                    weditor.customConfig.menus = [
                                     'head',
                                     'bold',
                                     'italic',
                                     'underline',
                                     'strikeThrough',
                                     'foreColor',
                                     'backColor',
                                     'link',
                                     'list',
                                     'justify',
                                     'quote',
                                     'table',
                                     'undo',
                                     'redo'
                                 	];
                                    weditor.create();
								</script> 
							</div>

			                <div class="form-group">
			                    <div class="col-md-2 control-label"><label><span class="text-danger">*</span>电子印章</label></div>
			                    <div class="col-md-6 controls">
			                        <input type="hidden" id="stampId" value="${cp2.id}" name="stampId" >
			                        <input type="hidden" id="stampTime" name="stampTime"  value="${cp2.upload_time}"  >
			                        <input type="text" id="stampName" class="form-control" name="stampName"  value="${cp2.name}" readonly="readonly"  >
			                        <input id="stampImg" type="hidden" name="stampImg"
			                               <c:if test="${empty certModel.stamp_path}">value="${pageContext.request.contextPath}/frontstage/images/certificate_seal.png"</c:if>
                                           <c:if test="${!empty certModel.stamp_path}">value="${pageContext.request.contextPath}${certModel.stamp_path}"</c:if>>
			                    </div>
								<div class="col-md-2 control-label">
									<label style="margin-top: -12px;">
										<a id="stampUpload" href="javascript:void(0);" class="btn btn-info pull-right" >
											<i class="glyphicon glyphicon-plus"></i>证书印章图片
										</a>
									</label>
								</div>
			                </div>

			                <div class="form-group">
			                    <div class="col-md-offset-2 col-md-2 controls">
			                        <button class="btn btn-fat btn-primary"  type="button" onclick="saveCertModel(0);">保存</button>
			                    </div>
			                    <div class="col-md-2 controls">
			                        <a id="review" class="btn btn-fat btn-primary"  onclick="reviewCertModel();" href="javascript:void(0);">预览</a> 
			                        <!-- <button class="btn btn-fat btn-primary"  type="button" onclick="reviewCertModel(1);" >保存并预览</button>  -->
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


<!--选择证书背景图片弹窗-->
<div id="add_model_pic" class="modal" aria-hidden="false" style="display: none;">
	<div class="modal-dialog  modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 id="h4_title" class="modal-title"></h4>
			</div>
			<div class="modal-body">

				<div class="alert alert-info">
					同一证书只可选择一张背景图片和印章,同一背景图片或印章可以使用多张证书!证书背景图片和印章上传成功并且审核通过之后才能使用!
				</div>

				<form class="form-inline form-search" role="search-form">
					<div class="form-group ">
						<input type="text" class="form-control" name="name" id="name" value="" placeholder="图片名称" >
					</div>
					<button id="search_btn" type="button" class="btn btn-primary" >搜索</button>
				</form>
				<div class="row mtl">
					<div class="col-md-12">
						<div class="courses-list">
						    <input type="hidden" id="pageFlag" value="0"/>
							<input type="hidden" name="page" id="page" value="0"/>
							<ul class="course-wide-list" id="certModelImgList">

							</ul>
							<!--翻页-->
							<nav class="text-center">
								<div id="test" class="pager"></div>
							</nav>
						</div>
					</div>
				</div>

			</div>

			<div class="modal-footer">

				<button type="button" id="save_img_btn" class="btn btn-primary">保存</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>


<script>
$("#pageFlag").val(0);
$(function(){
    //var profileVal = $("#content").val();
    <%-- 
    //给JMEditor赋值
    var editor = CKEDITOR.replace("profile",{
 		skin: "moono-lisa",width:600, height:600,margin:"0,0,0,135",toolbar :'Detail'
    });
    --%>
	<%--
    if(profileVal!=''){
		//editor.setData(profileVal);
		weditor.txt.html(profileVal);
	}
	--%>
    <%-- 
    $("#cke_profile").blur(function(){
 		$("#content").val(JMEditor.html('profile'));
   	});
    --%>   
});

$(function(){
    $(".certificate_content>button").click(function(){
        $(this).find("span").toggle();
    })
});
$(function(){
    $(".course-wide-list>li").click(function(){
        $(this).find("div").find("div").find("div").toggle();
    })
});
var list = [];
/* function chooseModelPicture(value,type){
	var page = $("#page").val();
	if(type==0){
		$("#h4_title").html("选择证书背景图片");
	}else if(type==1){
		$("#h4_title").html("选择证书印章图片");
	}
	if(value==0){
		page = 0;
		$(".disabled").find("a").each(function(index,element){
			if(index==0){
				$(element).click();
			}
		});
		$("#add_model_pic").modal();
		$("#search_btn").removeAttr("onclick");
		$("#search_btn").attr("onclick","chooseModelPicture(1,"+type+")");
		$("#save_img_btn").removeAttr("onclick");
		$("#save_img_btn").attr("onclick","addCertImg("+type+")");
	}
	//搜索
	var name = $("#name").val();
	if(name!=""){
		page = 0;
	}
	$.ajax({
		url:"${pageContext.request.contextPath}/cert_model/query_cert_model_picture.action",
		data:{
			page:page,
			type:type,
			name:name
		},
		dataType:'json',
		success:function(data){
			var view = data.certModelPictureView;
			list = data.certModelPictures;
			var html = "";
			for(var i=0;i<list.length;i++){
				html += '<li class="course-item clearfix" >'+
				            '<a class="course-picture-link" href="javascript:void(0);" >'+
				                '<img style="width:220px;height:120px;" class="course-picture" src="${pageContext.request.contextPath}'+list[i].path+'">'+
				            '</a>'+
				            '<div class="course-body" onclick="doChoose('+list[i].type+','+list[i].id+',\''+list[i].path+'\');">'+
				                '<h4 class="course-title">'+
				                    '<a href="javascript:void(0);" >'+list[i].name+'</a><br/>'+
				                '</h4>'+
				                '<div class="course-footer clearfix">'+
				                    '<div class="course-metas-4" id="meta'+list[i].id+'" style="display: none;">'+
				                        '<span class="glyphicon glyphicon-ok pull-right" style="z-index:100;color:#02b980;font-size:30px;"></span>'+
				                    '</div>'+
				                '</div>'+
				            '</div>'+
				        '</li>';
			}
			if(list.length==0){
				if(type==0){
					html += '<div class="empty">您需要上传自己的证书底板</div>';
				}else if(type==1){
					html += '<div class="empty">您需要上传自己的证书印章</div>';
				}
			}
			$("#certModelImgList").empty().append(html);
			$("#page").val(view.page);
			$("#name").val(view.name);
			if(value==0){
				if($("#pageFlag").val()==0){
					doPages(view.rows,view.total,view.type);
					$("#pageFlag").val(1);
				}
				
			}
		}
	});
} */



function saveCertModel(value){
	if($("#title").val()==""){
		alert("请填写证书名称！");
		return false;
	}
	//var content = CKEDITOR.instances.profile.getData().trim();
	var content = weditor.txt.html();
	if(content!=null&&content!=="<p><br></p>"&&content!="undefined"){
		$("#content").val(content); 
	}
	/* var negativeId = $("#negativeId").val();
	var stampId = $("#stampId").val();
	if(negativeId==""){
		$("#negativeId").val("242");
	}
	if(stampId==""){
		$("#stampId").val("243");
	} */
    document.getElementById('certModel').submit(); 
} 
function uploadModelPicture(){
	var uploader = WebUploader.create({
		auto: true,
		// swf文件路径
		swf: '${pageContext.request.contextPath}/frontstage/js/webuploader/Uploader.swf',
		// 文件接收服务端。
		server: '${pageContext.request.contextPath}/cert_model/upload_img.action',
		
		// 选择文件的按钮。可选。
		// 内部根据当前运行是创建，可能是input元素，也可能是flash.
		pick: '#upload_picture',
		
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
		$("#path").val(response.filepath);
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
		$("#upload_picture").css("display","none");
		$(".upload_course_picture_content").css("display","none");
		$(".save_course_picture_content").css("display","");
		
		
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
}
function doSave(){
	var src = $("#path").val();
	$("#certModelImg").attr('src',"${pageContext.request.contextPath}"+src);
	$("#upload_certificate_model_pic").modal('hide');
}

function reviewCertModel(){
	//var content = CKEDITOR.instances.profile.getData().trim();
	var content = weditor.txt.html();
	content=content.replace(/\&/g,"%26");
	var negativeSrc = $("#negativeImg").val(); 
	var stampSrc = $("#stampImg").val();
	if(content==='<p><br></p>'||negativeSrc==''||stampSrc==''){
		alert("请完成证书模板信息");
		return false;
	}
	$("#review").attr('target','_blank');
	$("#review").attr('href','${pageContext.request.contextPath}/cert_model/to_cert_model_show.action?flag=1&content='+content+'&negative_path='+negativeSrc+'&stamp_path='+stampSrc); 
} 
</script>
