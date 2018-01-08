<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!-- 默认图片管理 -->
<link href="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.js"></script>
<script>
var psizeMsg = "1920x400像素";
var msizeMsg = "";
$(function(){
	if("${defaultImg.device}"=="1"){
		$("#size").html(msizeMsg);
	}else{
		$("#size").html(psizeMsg);
	}
})
if("${see}"==""){
	function choose_device(v){
		if(v==0){
			$("#size").html(psizeMsg);
		}else if(v==1){
			$("#size").html(msizeMsg);	
		}
		getSequence();
	}

	function getSequence(){
		var source_type = $("#source_type").val();
		var type = $("input[name='type']:checked").val();
		var device = $("input[name='device']:checked").val(); 
		var location = $("input[name='location']:checked").val();
		$.ajax({
			url : '${pageContext.request.contextPath}/back_default_img/get_max_seq.action',
			data : {
				source_type : source_type,
				type : type,
				device : device,
				location : location
			},
			dataType : 'json',
			async : false,
			success : function(d) {
				$("#seq").val(d.obj.toString())
			}
		})
	}
	var uploader = WebUploader.create({
		auto: true,
		// swf文件路径
		swf: '${pageContext.request.contextPath}/frontstage/js/webuploader/Uploader.swf',
		// 文件接收服务端。
		server: '${pageContext.request.contextPath}/back_default_img/upload_img.action?realpath=defalutPicture',

		// 选择文件的按钮。可选。
		// 内部根据当前运行是创建，可能是input元素，也可能是flash.
		pick: "#defImg",

		// 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
		resize: false,
		accept: {
			title: 'Images',
			extensions: 'png',
			mimeTypes: 'image/png'   //修改这行
		}
	});
	var he,wi;
	/**
	 *上传成功后
	 *file:文件
	 *response:服务器返回
	 */

	uploader.on( 'uploadSuccess', function( file,response  ) {
		 var fas = true;
		 var device = $("input[name='device']:checked").val();
		 if(typeof(file._info)=="undefined"){
			 var _info = response.fileinfo;
			 he = _info.imgHeight;
			 wi = _info.imgWidth;
		 }else{
			 he = file._info.height;
			 wi = file._info.width; 
		 }
		 console.log(he+"--"+wi)
		 if(he>0&&wi>0){
			 if(device==0){//pc	
				 if(he!=400||wi<1920){
					 $("#size").attr("style","color:red");
					 fas = false;
				 }else{
					 $("#size").attr("style","");
				 }
			 }else if(device==1){
				 
			 }
		 } 
		 if(fas){
			 $("#succe").val(1);
			 $("#name").val(response.filename);
		     $("#path").val(response.filepath);
		     $("#upload_time").val(response.uploadtime); 
		 }else{
			 $("#succe").val(0);
		 }
	});

	// 当有文件添加进来的时候
	uploader.on( 'fileQueued', function( file) {
		// <input type="hidden">
		/* var $img; */
		var $li = $(
					'<div id="' + file.id + '" class="file-item thumbnail">' +
					'<div style="margin:20 0 0 0">' +
						 '<div class="info">' + file.name + '</div>' + 
					'</div>'
			);
			/* $img = $li.find('img'); */
		var   $list=$("#defFile");

		// $list为容器jQuery实例
		//$list.append( $li );
		$("#img_name").html(file.name);
		/* $("#hedimg").hide(); */

		// 创建缩略图
		// 如果为非图片文件，可以不用调用此方法。
		// thumbnailWidth x thumbnailHeight 为 00 x 00
		/* uploader.makeThumb( file, function( error, src ) {
			if ( error ) {
				$img.replaceWith('<span>不能预览</span>');
				return;
			}

			$img.attr( 'src', src );
		}, 00, 90); */
		
	});
}



</script>
<div id="st" style="padding: 5px; overflow: hidden;">
	<form id="imgForm" method="post">
	    <input name="id" id="id" type="hidden" value="${defaultImg.id}">
		<table class="tableForm">
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th>&nbsp;图片名称：</th>
				<td>
				     <input id="succe" type="hidden" value="0">
				    <input name="name" id="name" type="hidden" value="${defaultImg.name}">
				    <input name="path" id="path" type="hidden" value="${defaultImg.path}">
				    <input name="upload_time" id="upload_time" type="hidden" value="" >
				    <div id="defFile" class="upload_course_picture" ></div>
				    <div id="defImg">
				       <label id="img_name">${defaultImg.name}</label>
				       <c:if test="${see!=1}"><input type="button" value="+默认图片"></c:if>
				       
				    </div>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th>&nbsp;类型：</th>
				<td><label><input type="radio" <c:if test="${see==1}">disabled="disabled"</c:if> onclick="getSequence();" name="type" value="0" <c:if test="${defaultImg.type==0}">checked</c:if> class="" checked>轮播图 </label>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th>&nbsp;来源：</th>
				<td >
				<select name="source_type" id="source_type" <c:if test="${see==1}">disabled="disabled"</c:if> style="width: 180px;" onchange='getSequence();' class="form-control" >
					<option>--请选择--</option>
					<option <c:if test="${defaultImg.source_type==0}">selected="selected"</c:if> value="0" >培训</option>
					<option <c:if test="${defaultImg.source_type==1}">selected="selected"</c:if> value="1" >教研</option>
					<option <c:if test="${defaultImg.source_type==2}">selected="selected"</c:if> value="2" >资源</option>
					<option <c:if test="${defaultImg.source_type==3}">selected="selected"</c:if> value="3" >工作坊</option>
					<option <c:if test="${defaultImg.source_type==4}">selected="selected"</c:if> value="4" >社区</option>
				</select>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th>&nbsp;设备：</th>
				<td><label><input type="radio" <c:if test="${see==1}">disabled="disabled"</c:if> name="device" value="0" onclick="choose_device(0);" <c:if test="${defaultImg.device==0}">checked</c:if> class="" checked>PC</label>
                    <label><input type="radio" <c:if test="${see==1}">disabled="disabled"</c:if> name="device" value="1" onclick="choose_device(1);" <c:if test="${defaultImg.device==1}">checked</c:if> class="">mobile</label>
                </td>    
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th>&nbsp;序号：</th>
				<td>
				<input type="text" id="seq" <c:if test="${see==1}">disabled="disabled"</c:if> name="sequence" value="${defaultImg.sequence}" 
				onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"  
    onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'0')}else{this.value=this.value.replace(/\D/g,'')}"
				>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th>&nbsp;布局：</th>
				<td>
				    <label><input type="radio" <c:if test="${see==1}">disabled="disabled"</c:if> onclick="getSequence();"  name="location" <c:if test="${defaultImg.location==0 }">checked</c:if> value="0" checked>主页</label>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th>&nbsp;尺寸：</th>
				<td>
				    <label id="size" style=""></label>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th>&nbsp;注意：</th>
				<td>
				    <label>为保证一定的观看效果，建议管理员上传轮播图为单一背景颜色</label>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
		</table>
	</form>
</div>
