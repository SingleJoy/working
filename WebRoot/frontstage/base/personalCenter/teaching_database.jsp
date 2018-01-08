<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="cn.bnsr.edu_yun.util.ConfigInfo"%>
<c:set value='<%=ConfigInfo.getString("file_server_path") %>' var="info"></c:set>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<link href="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/My97DatePicker/WdatePicker.js"></script>

<div class="cn-wrap">

    <div id="content-container" class="container">
        <jsp:include page="/frontstage/base/personalCenter/personal_header.jsp"></jsp:include>
        <div class="row row-3-9">

            <jsp:include page="/frontstage/base/personalCenter/personal_left.jsp"></jsp:include>

            <div class="col-md-9">
                <div class="panel panel-default panel-col">

                    <div class="panel-heading">
                        教学资料库
                    </div>

                    <div class="panel-body material-body">

                        <form class="form-inline" id="fileForm" action="${pageContext.request.contextPath}/course_file/to_file_base.action" method="post">
                            <input type="hidden" name="stamp" id="stamp" value="${stamp}"/>
                            <input type="hidden" name="state" id="state" value="${state}"/>
                            <input type="hidden" name="page" id="page" value="${courseFileView.page}"/>
                            <input type="hidden" name="rows" id="rows" value="${courseFileView.rows}"/>
                            <input type="hidden" name="total" id="total" value="${courseFileView.total}"/>
                            <input type="hidden" name="totalPage" id="totalPage" value="${courseFileView.totalPage}"/>
                            <input type="hidden" name="type" id="type" value="${courseFileView.type}"/>
                            <input type="hidden" name="is_use" id="is_use" value="${courseFileView.is_use}"/>
                            <div class="source-btn" role="group" aria-label="...">
                                <ul class="nav nav-tabs">
                                    <li class="active" ><a href="javascript:;" class="js-source-btn">我的资料</a></li>
                                </ul>

                            </div>
                            <div class="form-group">
                                <input type="text" name="name" class="form-control" value="${courseFileView.name}" placeholder="请输入关键词">
                                <input type="submit" class="btn btn-primary btn-sm" value="搜索" >
                            </div>
                            <div class="material-search-list material-tabs">
                                <span class="all">类型：</span>
                                <ul class="js-material-tabs right-content  clearfix">
                                    <li class="js-type-btn <c:if test='${courseFileView.type==-1}'>active</c:if>" data-value="">
                                        <a href="javascript:;" onclick="doType(-1);">全部</a>
                                    </li>
                                    <li class="js-type-btn <c:if test='${courseFileView.type==0}'>active</c:if>" data-value="video">
                                        <a href="javascript:;" onclick="doType(0);">视频</a>
                                    </li>
                                    <li class="js-type-btn <c:if test='${courseFileView.type==2}'>active</c:if>" data-value="flash">
                                        <a href="javascript:;" onclick="doType(2);">flash</a>
                                    </li>
                                    <li class="js-type-btn <c:if test='${courseFileView.type==3}'>active</c:if>" data-value="audio">
                                        <a href="javascript:;" onclick="doType(3);">音频</a>
                                    </li>
                                    <li class="js-type-btn <c:if test='${courseFileView.type==4}'>active</c:if>" data-value="image">
                                        <a href="javascript:;" onclick="doType(4);">图片</a>
                                    </li>
                                    <li class="js-type-btn <c:if test='${courseFileView.type==1}'>active</c:if>" data-value="document">
                                        <a href="javascript:;" onclick="doType(1);">文档</a>
                                    </li>
                                    <li class="js-type-btn <c:if test='${courseFileView.type==5}'>active</c:if>" data-value="ppt">
                                        <a href="javascript:;" onclick="doType(5);">PPT</a>
                                    </li>
                                    <li class="js-type-btn <c:if test='${courseFileView.type==6}'>active</c:if>" data-value="other">
                                        <a href="javascript:;" onclick="doType(6);">其它</a>
                                    </li>
                                </ul>
                            </div>

                            <div class="material-search-list bottom">
                                <span class="all">筛选：</span>
                                <div class="right-content ">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <input class="form-control input-time" type="text"  name="timeStart" onClick="WdatePicker({onpicked:function(){doSubmit();},dateFmt:'yyyy-MM-dd',minDate:'1970-01-01',maxDate:'%y-%M-{%d+14}'})" <c:if test="${!empty courseFileView.timeStart}"> value='${courseFileView.timeStart }' </c:if> placeholder="起始时间"><span class="input-space">-</span><input class="form-control input-time"  type="text" name="timeEnd" placeholder="结束时间"onClick="WdatePicker({onpicked:function(){doSubmit();},dateFmt:'yyyy-MM-dd',minDate:'1970-01-01',maxDate:'%y-%M-{%d+14}'})" <c:if test="${!empty courseFileView.timeEnd}">value='${courseFileView.timeEnd }'</c:if> placeholder="结束时间">
                                        </div>
                                        <div class="col-sm-2">
                                            <select class="form-control js-use-status-select" onchange="doIsUse(this.value);" >
                                                <option <c:if test="${courseFileView.is_use=='' }">selected</c:if> value="">使用状态</option>
                                                <option <c:if test="${courseFileView.is_use==1 }">selected</c:if> value="1">未使用</option>
                                                <option <c:if test="${courseFileView.is_use==0 }">selected</c:if> value="0">已使用</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </form>

                        <div id="material-lib-items-panel">
                            <a class="btn btn-primary js-upload-file-btn" data-toggle="modal" data-target="#file-modal" title="上传资料" onclick="doUpload();">上传资料</a>
                            <a class="btn btn-info js-manage-batch-btn" href="javascript:void(0);">批量管理</a>

                            <span id="material-lib-batch-btn-bar" style="display:none;">
                                <!-- <a class="btn btn-info js-batch-tag-btn"  href="#add_tag" data-toggle="modal">添加标签</a>
 -->                                <a class="btn btn-danger js-batch-delete-btn"  href="javascript:void(0);" onclick="deleteAll();" >删除</a>
                                <label class="checkbox-inline" data-role="batch-manage">
                                    <input type="checkbox" onclick="selectAll();" data-role="batch-select"> 全选
                                </label>
                            </span>

                            <div class="material-list-container" id="material-item-list" >
                                <div class="row">
                                    <c:forEach  items="${fileList}" var="file">
                                        <div class="col-lg-3 col-sm-4 col-xs-6 materials-list my-materials-list " >
                                            <ul class="materials-ul clearfix">
                                                <li class="img-li" style="position:relative;">
                                                    <input class="batch-item" name="fileId" value="${file.id}" type="checkbox"  style="display:none;">
                                                    <img src="http://ese1a3b0c5d0oo-pub.pub.qiqiuyun.net/materiallib-14/20170615041508-dwboe762bqgock00/5287e3927f0d17df_thumb">

                                                    <div class="mask">
                                                        <div class="icon-operation">
                                                            <i class="glyphicon glyphicon-star js-collect-btn left  material-collection " data-toggle="tooltip" data-placement="bottom" data-original-title="收藏"></i>
                                                            <i  class="glyphicon glyphicon-option-vertical" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></i>
                                                            <ul class="dropdown-menu">
                                                                <li>
                                                                    <a href="${pageContext.request.contextPath}/download/download_file.action?type=1&id=${file.id}" class="js-download-btn" download="w3logo">
                                                                        <i class="glyphicon glyphicon-save prm"></i>下载
                                                                    </a>
                                                                </li>

                                                                <li>
																	 <a href="javascript:void(0);" onclick="deleteFile(${file.id});" class="js-delete-btn" data-toggle="tooltip" data-placement="bottom" >
                                                                        <i class="glyphicon glyphicon-trash prm"></i>删除
                                                                    </a>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                        <div class="btn-operation">
                                                            <!-- 选择一种状态 -->
                                                            <a class="btn btn-info data_look_btn" href="javascript:void(0);" data-toggle="modal" data-path="${file.path}" data-type="${file.type}">资料预览</a>
                                                        </div>

                                                        <div class="time">${fn:split(file.name,".")[1]}</div>

                                                    </div>
                                                </li>
                                                <li class="caption">
                                                    <p class="title text-overflow" data-toggle="tooltip" data-placement="top" >
                                                        <span class="glyphicon glyphicon-cloud"></span>
                                                            ${file.name}</p>
                                                    <p class="status-parent">
                                                        <span class="label label-default">
                                                        	<c:if test="${file.is_use==0 }">
                                                                已使用
                                                            </c:if>
                                                        	<c:if test="${file.is_use==1}">
                                                                未使用
                                                            </c:if>
                                                        </span>
                                                    </p>
                                                    <p class="text-muted text-overflow text-sm mbs" title="">
                                                        时间： <fmt:formatDate value="${file.create_time}" type="date" pattern="yyyy-MM-dd HH:mm"/>
                                                    </p>
                                                </li>
                                            </ul>
                                        </div>
                                    </c:forEach>
                                </div>
                                <c:if test="${empty fileList }">
                                    <div class="empty">暂无数据</div>
                                </c:if>
                                <c:if test="${!empty fileList }">

                                    <div id="test" class="pager"></div>

                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>

<!--资料预览-->
<div id="data_look" class="modal in" aria-hidden="false" style="display: none;">
    <div class="modal-dialog  modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"><span class="text-muted">资料预览</span></h4>
            </div>
            <div class="modal-body">
                <div  style="height:500px;overflow:hidden;" id="look_iframe">
                    预览资料区域
                </div>


            </div>
            <div class="modal-footer">

                <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<!--标签添加-->
<div id="add_tag" class="modal in" aria-hidden="false" data-backdrop="static" style="display: none;" >
    <div class="modal-dialog ">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">标签设置</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal"  action="" method="post" novalidate="novalidate" >
                    <div class="form-group" >
                        <div class="col-md-2 control-label">
                            <label >标签</label>
                        </div>

                        <div class="col-md-8 controls">

                            <input type="text" required="required" class="form-control"  >
                            <div class="help-block">标签来自网校课程标签，由网校管理员统一管理。</div>
                        </div>

                    </div>

                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-link" data-dismiss="modal">取消</button>
                <button  type="submit" class="btn btn-primary" data-toggle="form-submit" >保存</button>
            </div>

        </div>
    </div>
</div>

<%--上传文件弹窗--%>
<div id="file-modal" class="modal in" aria-hidden="false" style="display: none;">
    <div class="modal-dialog  modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">上传课时文件</h4>
            </div>

            <div class="modal-body" style="min-height: 200px;">

                <div id="fileList" class="col-md-8 col-md-offset-2" style="margin-top: 40px;">
                    <div id="uploadFile" class="text-center">
                        <button class="btn btn-default btn-lg ">
                            <i class="glyphicon glyphicon-plus"></i>添加文件
                        </button>
                    </div>
                    <br/><br/>
                </div>

            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
//删除单个
function deleteFile(value){
	 var result = confirm('是否要删除文件？');
     if(result){
         window.location.href="${pageContext.request.contextPath}/course_file/delete_file.action?fileId="+value+"&ver="+Math.ceil(Math.random()*100);
     }
}

//删除
function deleteAll(){
    var a = document.getElementsByName("fileId");
    var check_val="";
    for(k in a){
        if(a[k].checked){
            check_val = check_val+a[k].value+",";
        }
    }
    if(check_val==""){
        alert("请选择要删除文件");
    }else{
    	deleteFile(check_val.trim());
    }
}


//选中全部
function selectAll(){
    var a = document.getElementsByName("fileId");
    if(a[0].checked){
        for(var i = 0;i<a.length;i++){
            if(a[i].type == "checkbox") a[i].checked = false;
        }
    }else{
        for(var i = 0;i<a.length;i++){
            if(a[i].type == "checkbox") a[i].checked = true;
        }
    }
}

    function doType(value){
        $("#type").val(value);
        $('#fileForm').submit();
    }
    function doSubmit(){
        $('#fileForm').submit();
    }
    function doIsUse(value){
        $("#is_use").val(value);
        $('#fileForm').submit();
    }

    $(function(){
    	 $(".js-manage-batch-btn").click(function(){
             $("#material-lib-batch-btn-bar").toggle();
             $(".batch-item").toggle();
         })
         
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
                $('#fileForm').submit();

            }
        });
    });



    //打开上传文件div
    function doUpload(){

        var uploader = WebUploader.create({
            auto: true,
            // swf文件路径
            swf: '${pageContext.request.contextPath}/frontstage/js/webuploader/Uploader.swf',
            // 文件接收服务端。
            server: '${pageContext.request.contextPath}/course_file/upload_file.action?courseId=0',

            // 选择文件的按钮。可选。
            // 内部根据当前运行是创建，可能是input元素，也可能是flash.
            pick: '#uploadFile',

            // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
            resize: false,
            accept: {
                title: 'MP4',
                extensions: 'mp4,txt,doc,xls,ppt,pdf,docx,pptx,xlsx',
                mimeTypes: '.mp4,.txt,.doc,.xls,.ppt,.pdf,.docx,.xlsx,.pptx,',   //修改这行
            }
        });

        // 当有文件被添加进队列的时候
        uploader.on( 'fileQueued', function( file ) {

            $("#uploadFile").append( '<div id="' + file.id + '" class="item">' +
                '<h4 class="info">' + file.name + '</h4>' +
                '</div>' );
        });

        // 文件上传过程中创建进度条实时显示。
        uploader.on( 'uploadProgress', function( file, percentage ) {
            var $li = $( '#'+file.id ),
                $percent = $li.find('.progress .blue');
            // 避免重复创建
            if ( !$percent.length ) {
                $percent = $('<div class="progress progress-striped active">' +
                    '<div class="graph"><span class="blue" style="width:0%;">0%</span></div>' +
                    '</div>').appendTo( $li ).find('.blue');
            }

            $percent.css( 'width', percentage * 100 + '%' );
            $percent.empty().append((percentage * 100).toFixed(2) + '%' );

        });

        /**
         *上传成功后
         *file:文件
         *response:服务器返回
         */
        uploader.on( 'uploadSuccess', function( file,response  ) {

            window.location.href="${pageContext.request.contextPath}/course_file/to_file_base.action?stamp=9&state=32&type=-1&ver="+Math.ceil(Math.random()*100);
        });

    }
    $(".data_look_btn").click(function () {
    var path=$(this).data("path");
    var type=$(this).data("type");
    $("#look_iframe").html("");
    if(type!=0){
     $.ajax({
            type:'get',
            url : "${pageContext.request.contextPath}/userFile/get_dcs.action?path="+path,
            dataType:'json',
            success : function(response) {
            var iframe=$ ('<iframe src="'+response.path+'" frameborder=0 width=100% height=500 style="margin-top: 20px;" allowfullscreen></iframe>');
	 		$("#look_iframe").html(iframe);	 
	 		$("#data_look").modal("show");
    		 }
    });
  
	 }else{
	var info=( '${info}');
	 			var iframe=$ ('<video id="example_video_1" class="video-js vjs-default-skin vjs-big-play-centered" controls preload="none" style="width: 100%;height: 100%;"'+
                               'poster="http://video-js.zencoder.com/oceans-clip.png" onended="end()" onplaying="playing()" autoplay="autoplay">'+
                            '<source src="'+info+path+'" type="video/mp4" /></video>');
	 $("#look_iframe").html(iframe);	
	 $("#data_look").modal("show");
	 }
		
	});
</script>
