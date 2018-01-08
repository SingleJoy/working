<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/canvas_picture/canvas_picture.js"></script>
<style>
    .certificate_info{width: 700px;height:600px;margin-left: auto;margin-top: 20px;}
    .content{position:absolute;margin-top:-500px;width:500px;margin-left:100px;}
</style>
<div class="cn-wrap" >

    <div id="content-container"  class="container">

            <div class="row row-8" style="margin: 20px auto;">
                <div class="col-md-8 col-md-offset-2" style="background-color: #fff;">
                    <div class="panel-default certificate_img" >
                        <div class="panel-body">

                            <div id="generImg" class="certificate_info" >
                                <img src="${pageContext.request.contextPath}${certModel.negative_path}" style="width:700px;height: 600px;">

                                <div class="content" id="content" >
                                       ${certModel.content }
                                </div>
                                <div class="certificate_ seal" style="z-index:99;position: absolute;margin-left: 490px;margin-top:-175px;">
                                    <img src="${pageContext.request.contextPath}${certModel.stamp_path}" style="width: 100px;height: 100px;">
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

    </div>

    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
</div>
<script>
    $(document).ready( function(){
        $(".certificate_img").on("click", function(event) {
            event.preventDefault();
            html2canvas(this, {
                allowTaint: true,
                taintTest: false,
                onrendered: function(canvas) {
                    canvas.id = "mycanvas";
                    //document.body.appendChild(canvas);
                    //生成base64图片数据
                    var dataUrl = canvas.toDataURL();
                    var newImg = document.createElement("img");
                    newImg.src =  dataUrl;

                    $(".certificate_img").before(newImg).remove();

                }
            });


        });
        $(".certificate_img").trigger("click");

    });
</script>