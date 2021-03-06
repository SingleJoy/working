<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>


<link href="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.css" rel="stylesheet" type="text/css">
 <link rel="icon" type="image/x-icon" href="../images/logo.ico" media="screen" />
    <link href="${pageContext.request.contextPath}/frontstage/css/certification.css" rel="stylesheet" type="text/css">
     <script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.js"></script>
   <script>
//       教师与管理员验证表单切换
       $(function(){
           var isclick=false;
           $(".certification_content_tabs ul li").click(function(){
               $(".certification_content_tabs ul li").removeClass("curr");
               $(this).addClass("curr");
               var index=$(this).index();
               $(".form_tabs").hide().eq(index).show();

               isclick=true;
           }).mouseover(function(){
               $(".certification_content_tabs ul li").removeClass("curr_01");
               $(this).addClass("curr_01");
           }).mouseout(function(){
               $(".certification_content_tabs ul li").removeClass("curr_01");
           });

       });
   </script>



</head>
<body>
<div class="certification_content">
    <div class="certification_content_top">
    <h2>申请认证用户</h2>
         <div class="application_progress">

        <div class="application_progress_ ">
            <div>1</div>
            <p>注册账户</p>
            <span></span>
        </div>

        <div class="application_progress_ application_progress_style">
            <div>2</div>
            <p>填写认证信息</p>
            <span></span>
        </div>


        <div class="application_progress_ application_progress_style_01">
            <div>3</div>
            <p>申请提交成功</p>
        </div>

    </div>
    </div>

    <div class="certification_content_tabs">

        <ul>
            <li class="curr">教师认证&nbsp;?</li>

            <li>管理员认证&nbsp;?</li>
                 <div>or</div>
        </ul>

    </div>

     <div class="add_certification_info">填写实名认证信息</div>

    <div class="certification_content_main">

        <div class="form_tabs">
     
          <form id="form_file" method="post" target="iframe" enctype="multipart/form-data">
          <label>上传证明教师身份的照片：
                  （如教师证内页，工作证，聘用书，不能使用教师证封面，自拍，身份证）<span>* </span></label>
             <div id="fileList" class="uploader-list"></div>
              <span class="plus_number" id="file">+</span>
              
              <li>提交</li>
          </form>
        </div>
        <iframe style="display: none" name="iframe"> </iframe>
        <div class="form_tabs"  style="display: none;">
              
        </div>
    </div>

</div>
<script type="text/javascript">
$(function(){
         
         var uploader = WebUploader.create({
      auto: true,
    // swf文件路径
    swf: '${pageContext.request.contextPath}/frontstage/js/webuploader/Uploader.swf',

    // 文件接收服务端。
    server: '${pageContext.request.contextPath}/certification/upload_img.action',

    // 选择文件的按钮。可选。
    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
    pick: '#file',

    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
    resize: false,
     accept: {
        title: 'Images',
        extensions: 'gif,jpg,jpeg,bmp,png',
        mimeTypes: 'image/*'
    }
});
         // 当有文件添加进来的时候
uploader.on( 'fileQueued', function( file ) {
var $img;
    var $li = $(
            '<div id="' + file.id + '" class="file-item thumbnail">' +
                '<img>' +
                '<div class="info">' + file.name + '</div>' +
            '</div>'
            ),
        $img = $li.find('img');
   var   $list=$("#fileList");

    // $list为容器jQuery实例
    $list.append( $li );

    // 创建缩略图
    // 如果为非图片文件，可以不用调用此方法。
    // thumbnailWidth x thumbnailHeight 为 100 x 100
    uploader.makeThumb( file, function( error, src ) {
        if ( error ) {
            $img.replaceWith('<span>不能预览</span>');
            return;
        }

        $img.attr( 'src', src );
    }, 100, 100 );
});
         




});
</script>

<jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>