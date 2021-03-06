<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/html2canvas.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/canvas2image.js"></script>


<div class="cn-wrap" >

    <div id="content-container"  class="container" style="margin: 20px auto;background-color: #fff;">

        <div class="row row-8" >
            <div class="col-md-8 col-md-offset-2">
                <div class="panel-default" >
                    <div class="panel-body">
                        <c:if test="${picture.type==0}">
                            <div id="generImg" class="certificate_info" style="width: 700px;height:600px;margin-left: auto;">
                                <img src="${pageContext.request.contextPath}${picture.path}" style="width:700px;height: 600px;">
                            </div>
                        </c:if>
                        <c:if test="${picture.type==1}">
                            <div class="certificate_ seal" style="z-index:99;position: absolute;margin-left: 289px;margin-top:153px;">
                                <img src="${pageContext.request.contextPath}${picture.path}" style="width: 100px;height: 100px;">
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
</div>


<script>
    window.onload = function(){

        document.getElementById("content").innerHTML = document.getElementById("content").innerHTML
            .replace(/\[姓名]/g,"李明明")
            .replace(/\[起始时间]/g,"二零一六年三月")
            .replace(/\[截止时间]/g,"二零一六七月")
            .replace(/\[项目名称]/g,'"北京市中小学教师培训"')
            .replace(/\[学时]/g,"20")
            .replace(/\[状态]/g,"合格")
            .replace(/\[颁发部门]/g,"北京市百年树人远程教育有限公司")
            .replace(/\[颁发时间]/g,"二零一六年七月");
    }
    function cutDiv(){
        var dom = document.querySelector("#generImg");
        html2canvas(dom).then(function(canvas) {
            var image = canvas.toDataURL("image/png");
            image = image.replace("image/png",'image/octet-stream');
            /**
             * 在本地进行文件保存
             * @param  {String} data     要保存到本地的图片数据
             * @param  {String} filename 文件名
             */
            var saveFile = function(data, filename){
                var save_link = document.createElementNS('http://www.w3.org/1999/xhtml', 'a');
                save_link.href = data;
                save_link.download = filename;

                var event = document.createEvent('MouseEvents');
                event.initMouseEvent('click', true, false, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);
                save_link.dispatchEvent(event);
            };

            // 下载后的问题名
            var filename = '证书模板.png';
            // download
            saveFile(image,filename);
        });
    }

</script>
