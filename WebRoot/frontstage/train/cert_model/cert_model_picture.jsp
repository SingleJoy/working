<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<link href="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.js"></script>

<div class="cn-wrap">

    <div id="content-container" class="container">
        <jsp:include page="/frontstage/base/personalCenter/personal_header.jsp"></jsp:include>
        <div class="row row-3-9">

            <jsp:include page="/frontstage/base/personalCenter/personal_left.jsp"></jsp:include>
           <div class="col-md-9">
			
			    <div class="panel panel-default panel-col">
			        <div class="panel-heading">
			            <div class="pull-right">
			                <a href="#" class="btn btn-info btn-sm" data-target="#new_certificate_model_pic" data-toggle="modal" onclick="doUpload(0);">
			                    <span class="glyphicon glyphicon-plus"></span>
			                    新增底版</a>
			                <a href="#" class="btn btn-info btn-sm" data-target="#new_certificate_model_pic" data-toggle="modal" onclick="doUpload(1);">
			                    <span class="glyphicon glyphicon-plus"></span>
			                    新增印章</a>
			                    
			               <%-- <a href="${pageContext.request.contextPath}/cert_model/to_create_cert_model.action?&stamp=1&state=29" class="btn btn-info btn-sm"><span class="glyphicon glyphicon-plus"></span> 新建证书</a>
			               <a href="${pageContext.request.contextPath}/cert_model/to_cert_model_manager.action?stamp=1&state=29" class="btn btn-info btn-sm"><span class="glyphicon glyphicon-plus"></span> 返回证书管理</a> --%>
			            </div>
			            模板证书
			        </div>
			
			        <div class="panel-body">
			            <ul class="nav nav-tabs" style="border: none;">
			
			                <li class="<c:if test="${certModelPictureView.type==0}">active</c:if> certificate_background"><a href="${pageContext.request.contextPath}/cert_model/to_cert_model_picture.action?type=0&stamp=1&state=29">证书底版</a></li>
			                <li class="<c:if test="${certModelPictureView.type==1}">active</c:if> seal">                  <a href="${pageContext.request.contextPath}/cert_model/to_cert_model_picture.action?type=1&stamp=1&state=29">电子印章</a></li>
			            </ul>
			        <form id="modelpicture" class="form-inline well well-sm" action="${pageContext.request.contextPath}/cert_model/to_cert_model_picture.action?&stamp=1&state=29" method="post">
			            <div class="form-group col-md-7">
                             <input type="hidden" name="stamp" id="stamp" value="${stamp}"/>
                             <input type="hidden" name="state" id="state" value="${state}"/>
                             <input type="hidden" name="type"  value="${certModelPictureView.type}" />
                             <input type="hidden" name="page" id="page" value="${certModelPictureView.page}" />
                             <input type="hidden" name="rows" id="rows" value="${certModelPictureView.rows}" />
                             <input type="hidden" name="total" id="total" value="${certModelPictureView.total}" />
                             <input type="hidden" name="totalPage" id="totalPage" value="${certModelPictureView.totalPage}" />
                         </div>
                         <div class="clearfix"></div>
			           
			        </form>
			             <!--证书底版-->
			            <table class="table table-hover certificate_table"  style="word-break:break-all;">
			                <thead>
			                <tr>
			                    <th style="width: 50%;"><c:if test="${certModelPictureView.type==0}">底板名称</c:if>
			                                            <c:if test="${certModelPictureView.type==1}">印章名称</c:if></th>
			                    <th>上传日期</th>
			                    <th>操作</th>
			                </tr>
			                </thead>
			
			                <tbody>
			                <c:forEach items="${certModelPictureList}" var="modelPicture">
				                <tr>
				                    <td>
				                        <a href="javascript:void(0);" class="pull-left mrm">
				                            <img style="width: 90px;height: 60px;" class="course-picture" width="100" 
				                                 <c:if test="${empty modelPicture.path}">src="${pageContext.request.contextPath}/frontstage/picture/Default.png"</c:if>
                                                 <c:if test="${!empty modelPicture.path}">src="${pageContext.request.contextPath}${modelPicture.path}"</c:if>>
                                        </a>
				                        <div class="mlm">
				                            <a href="javascript:void(0);" class="course_title_name">${modelPicture.name}</a>
				                        </div>
				                    </td>
				                    <td><c:if test="${!empty modelPicture.upload_time }"><fmt:formatDate value="${modelPicture.upload_time}" type="date"/></c:if></td>
				                    <td>
				                        <div class="btn-group">
				                            <a class="btn btn-default btn-sm" href="${pageContext.request.contextPath}/cert_model/to_cert_model_img_show.action?id=${modelPicture.id}" target="_blank">预览</a>
				                            <a href="#" type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></a>
				                            <ul class="dropdown-menu pull-right">
				                                <li><a href="${pageContext.request.contextPath}/cert_model/del_cert_model_picture.action?id=${modelPicture.id}&type=${modelPicture.type}"><span class="glyphicon glyphicon-remove-circle"></span> 删除</a></li>
				                            </ul>
				                        </div>
				                    </td>
				                </tr>
			                </c:forEach>
			                </tbody>
			            </table>
			            <c:if test="${empty certModelPictureList&&certModelPictureView.type==0 }">
                            <div class="empty">您需要上传自己的证书底板</div>
                        </c:if>
                        <c:if test="${empty certModelPictureList&&certModelPictureView.type==1 }">
                            <div class="empty">您需要上传自己的电子印章</div>
                        </c:if>
                        <c:if test="${!empty certModelPictureList }">
                            <div class="main_content_switch_directory">
                                <div id="test" class="pager" style="padding-top: 10px;"></div>
                            </div>
                        </c:if>
                        <form id="cert_model_picture" action="${pageContext.request.contextPath}/cert_model/save_cert_model_picture.action" method="post">
				            <input type="hidden" name="name" id="name">
				            <input type="hidden" name="path" id="path">
				            <input type="hidden" name="upload_time" id="upload_time">
				            <input type="hidden" name="type" id="type">
				        </form> 
			        </div>
			
			    </div>
			</div>
			<!--新增证书背景图片弹窗-->
			<div id="new_certificate_model_pic" class="modal" aria-hidden="false" style="display: none;">
			    <div class="modal-dialog  modal-lg">
			        <div class="modal-content">
			            <div class="modal-header">
			                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			                <h4 id="modal_title" class="modal-title"></h4>
			            </div>
			            <div class="modal-body">
			                <div id="fileList" class="" ></div>
		                    <div id="upload_picture" >
		                        <p class="plus_number" style="font-size: 100px;opacity: 0.3;margin-left: 380px;cursor: pointer;z-index: 999;">+</p>
		                    </div>
		                    <div id="modal_reminder" class="help-block"></div>
			            </div>
			            <div class="modal-footer">
			                <button type="button" class="btn btn-primary" onclick="doSumbit();">保存</button>
			                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			            </div>
			        </div>
			    </div>
			</div>
        </div>
    </div>

    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
</div>



<script >

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
            $('#modelpicture').submit(); 

        }
    });
});
function doSumbit(){
	document.getElementById('cert_model_picture').submit();
}
function doUpload(type){
   if(type==0){
	   $("#modal_title").html("上传证书背景图片");
	   $("#modal_reminder").html("注意:背景图片大小必须是1080x800像素");
   }else{
	   $("#modal_title").html("上传证书印章图片");
	   $("#modal_reminder").html("");
   }
   var uploader = WebUploader.create({
		auto: true,
		// swf文件路径
		swf: '${pageContext.request.contextPath}/frontstage/js/webuploader/Uploader.swf',
		// 文件接收服务端。
		server: '${pageContext.request.contextPath}/cert_model/upload_img.action?type='+type+'&realpath=certModelPicture',
		
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
		$("#name").val(response.filename);
		$("#path").val(response.filepath);
		$("#upload_time").val(response.uploadtime); 
		$("#type").val(type);
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
	  
};

</script>
