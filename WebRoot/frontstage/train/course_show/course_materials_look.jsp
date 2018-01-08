<%@ page language="java" contentType="text/html; charset=utf-8"
		 pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link href="${pageContext.request.contextPath}/frontstage/css/bootstrap/bootstrap.css" rel="stylesheet" />

<link rel="stylesheet" media="screen" href="${pageContext.request.contextPath}/frontstage/css/bootstrap/font-awesome.min.css" />
<link rel="stylesheet" media="screen" href="${pageContext.request.contextPath}/frontstage/css/bootstrap/es-icon.css" />

<link href="${pageContext.request.contextPath}/frontstage/css/bootstrap/main.css" rel="stylesheet" />

<title>课程资料<c:if test="${!empty courseFileView.name }">(${courseFileView.name })</c:if></title>
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/frontstage/images/qiuzi_ico.ico" media="screen" />
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/jquery-1.11.0.min.js"></script>


<div class="cn-wrap">
	<c:choose>
		<c:when test="${courseFileView.type==0 }">
			<%-- 视频 --%>
			<div class="lesson-content lesson-content-audio" id="lesson-audio-content"  style="background-color: #000;">
				<video controls preload="none" style="width: 100%;height: 100%;"
					   poster="http://video-js.zencoder.com/oceans-clip.png" autoplay oncontextmenu="return false">
					<source id="video_source" src="${file_server_path }${courseFileView.path }" type='video/mp4' />
				</video>
			</div>
			<span>暂不支持视频资料</span>
		</c:when>
		<c:when test="${courseFileView.type==1 }">
			<%-- 文档--%>
			<div id="doc_container">

			</div>
		</c:when>
		<c:when test="${courseFileView.type==4 }">
			<%-- 图片--%>
			<div>
				<img src="${file_server_path}${courseFileView.path }" alt="${courseFileView.name }"/>
			</div>
		</c:when>
	</c:choose>
</div>


<script type="text/javascript">
    $(function(){
        if("${courseFileView.type }"==="0"){
            initvideo();
        }else if("${courseFileView.type }"==="1"){
            initdoc();
        }
    });

    /* 视频初始化 */
    function initvideo(){
        //创建XMLHttpRequest对象
        var xhr = new XMLHttpRequest();
        //配置请求方式、请求地址以及是否同步
        xhr.open('POST', '${pageContext.request.contextPath}/course_study/read_video.action?id=${courseFileView.id }', true);
        //设置请求结果类型为blob
        xhr.responseType = 'blob';
        //请求成功回调函数
        xhr.onload = function(e) {
            if (this.status == 200) {//请求成功
                //获取blob对象
                var blob = this.response;
                //获取blob对象地址，并把值赋给容器
                $("#video_source").attr("src", URL.createObjectURL(blob));
            }
        };
        xhr.send();
    }

    /* 文档初始化 */
    function initdoc(){
        var d_path="${courseFileView.path }";
        $("#doc_container").html("");
        $.ajax({
            type:'get',
            url:"${pageContext.request.contextPath}/userFile/get_dcs.action?path="+d_path,
            dataType:'json',
            success:function(response){
                var iframe_txt='<iframe src="'+response.path+'" frameborder=0 width=100% height=500 style="margin-top: 20px;" allowfullscreen></iframe>'
                $("#doc_container").html(iframe_txt);
            }
        });
    }
</script>