<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>


<link href="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.js"></script>


<div class="cn-wrap">

    <div id="content-container" class="container">
        <jsp:include page="course_header.jsp"></jsp:include>

        <div class="row">
            <jsp:include page="course_left.jsp"></jsp:include>
            <div class="col-md-9">

                <div class="panel panel-default panel-col">
                    <div class="panel-heading">
                        <a class="btn btn-info btn-sm pull-right" data-toggle="modal" data-target="#course-file-modal" onclick="doUpload();">
                            <i class="glyphicon glyphicon-cloud-upload"></i>添加课程文件
                        </a>
                        课程文件
                    </div>
					<form action="${pageContext.request.contextPath }/course_file/to_course_file.action" method="post" id="courseFileForm">
					<input type="hidden" name="id" value="${courseView.id}" /> 
					<input type="hidden" name="flag" value="${courseView.flag}" /> 
					<input type="hidden" name="sign" value="${courseView.sign}" /> 
					<input type="hidden" name="page" id="page" value="${courseFileView.page}" /> 
					<input type="hidden" name="rows" id="rows" value="${courseFileView.rows}" />
					<input type="hidden" name="total" id="total" value="${courseFileView.total}" />
                    <!--课时文件-->
                    <div class="panel-body">
                        <table class="table  table-hover">
                            <thead>
                            <tr>
                                <th width="5%;"><input type="checkbox" onclick="selectAll();"></th>
                                <th >文件名</th>
                                <th >类型</th>
                                <th >大小</th>
                                <th >最后更新</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${fileList}" var="file">
                                <tr>
                                    <td ><input type="checkbox" name="fileId" value="${file.id}"/></td>
                                    <td title="${file.file_name}">${fn:substring(file.file_name,0,10)}<br/>
                                        <c:if test="${file.is_use == 1}">
                                            <span class="text-warning text-sm">未使用</span>
                                        </c:if>
                                    </td>
                                    <td>${file.file_extname}</td>
                                    <td >${file.size }</td>
                                    <td >${file.userName }<br/>
                                        <span class="text-muted text-sm"><fmt:formatDate value="${file.create_time}" type="date" pattern="yyyy-MM-dd HH:mm"/></span>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>

                        <label class="checkbox-inline mrm mbm"><input type="checkbox"  onclick="selectAll();"> 全选</label>
                        <div class="btn-group mbm">
                            <button class="btn btn-danger btn-sm"  onclick="deleteAll();" >
                                <i class="glyphicon glyphicon-trash"></i>移除
                            </button>

                        </div>
                        <div id="test" class="pager" ></div>
                        <div class="alert alert-info">
                            上传备用资料文件成功后，在添加课时资料时可直接选取。<br/>
                            课程资料区显示的是所有课时下的资料文件。
                        </div>
                    </div>
					</form>
                </div>

            </div>
        </div>
    </div>
    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>

</div>


<%--上传文件弹窗--%>
<div id="course-file-modal" class="modal in" aria-hidden="false" style="display: none;">
    <div class="modal-dialog  modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">上传课时文件</h4>
            </div>

            <div class="modal-body" style="min-height: 200px;">

                <div id="fileList" class="col-md-8 col-md-offset-2" style="margin-top: 40px;">
                    <div id="uploadFile" class="text-center">
                        <button class="btn btn-default btn-lg "><i class="glyphicon glyphicon-plus"></i>添加课时文件</button>
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


<div id="mask" class="mask"></div>
<script type="text/javascript">

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
            var result = confirm('是否要删除文件？');
            if(result){
                window.location.href="${pageContext.request.contextPath}/course_file/delete_course_file.action?id="+${courseView.id }+"&flag=2&sign=5&fileId="+check_val.trim()+"&ver="+Math.ceil(Math.random()*100);
            }
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
    //打开上传文件div
    function doUpload(){

        var uploader = WebUploader.create({
            auto: true,
            // swf文件路径
            swf: '${pageContext.request.contextPath}/frontstage/js/webuploader/Uploader.swf',
            // 文件接收服务端。
            server: '${pageContext.request.contextPath}/course_file/upload_file.action?courseId=${courseView.id}',

            // 选择文件的按钮。可选。
            // 内部根据当前运行是创建，可能是input元素，也可能是flash.
            pick: '#uploadFile',

            // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
            resize: false,
            accept: {
                title: 'file',
                extensions: 'mp3,mp4,doc,docx,ppt,pptx.xls,pdf,txt',
                mimeTypes: '.mp3,.mp4,.doc,.docx,.ppt,.pptx,.xls,.pdf,.txt'   //修改这行
            }
        });

        // 当有文件被添加进队列的时候
        uploader.on( 'fileQueued', function( file ) {
            $(".plus_number").css("display","none");
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
            $(".file_management_main_right_popup").css("display","none");
            window.location.href="${pageContext.request.contextPath}/course_file/to_course_file.action?id="+${courseView.id }+"&flag=2&sign=5&ver="+Math.ceil(Math.random()*100);
        });

    }
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
	            $('#courseFileForm').submit();

	        }
	    });
	});
</script>
