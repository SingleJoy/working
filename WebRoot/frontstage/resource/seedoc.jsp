<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    String fastdfsPath = request.getScheme()+"://"+request.getServerName()+":8080/";
%>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<link  href="${pageContext.request.contextPath}/frontstage/js/sharejs/dist/css/share.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/frontstage/js/sharejs/dist/js/jquery.share.min.js"></script>


<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/swfobject/swfobject.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/flexpaper_flash_debug.js"></script>

<div class="position">
    <span class="position_1"><a href="${pageContext.request.contextPath}/user/home.action">首页</a></span>
    <c:forEach items="${classifications}" var="cl" varStatus="status">&gt;
        <span class="position_${status.count+1}">${cl}</span>
    </c:forEach>
</div>

<div class="main_read" >

    <div class="main_read_top">
        <img src="${pageContext.request.contextPath}${fileBase.user.icon }" class="author_img">
        <div class="title_name">${fileBase.file_catalog.title }</div>
        <ul>
            <li>
                <c:forEach begin="1" end="${fileBase.file_property.score }" varStatus="status1"><img src="${pageContext.request.contextPath}/frontstage/images/icon_star.png"></c:forEach>
                <span class="author_score_num">&nbsp;<fmt:formatNumber type="number"
                                                                       maxFractionDigits="1" value="${fileBase.file_property.score }" />分</span>
                <span class="author_file_formate">格式:${fileBase.format }</span>
                <span class="author_file_size">大小:${fileBase.size }</span>
                <span class="author_file_price">
                <c:if test="${fileBase.file_catalog.type==1 }">
                    价格:<span class="author_file_price_num">${fileBase.value }元</span>
                </c:if>
                      <c:if test="${fileBase.file_catalog.type==2 }">
                          价格:<span class="author_file_price_num">免费</span>
                      </c:if>
                </span>

            </li>
            <li class="author_info_txt"><span class="author_name">${fileBase.user.realname }</span><span class="author_title">${fileBase.userInfo.titles }</span></li>
        </ul>

        <c:if test="${user==null }">
            <button class="author_follow_button" name="${fileBase.upload_user}">+关注</button>
        </c:if>
        <c:if test="${attented==false }">
            <button  class="author_follow_button" name="${fileBase.upload_user}">+关注</button>
        </c:if>
        <c:if test="${attented==true }">
            <button class="author_follow_button" name="${fileBase.upload_user}">已关注</button>
        </c:if>

        <input type="hidden" id="fileBase_id" value="${fileBase.id}">
        <c:if test="${user==null }"><div class="keep" >收藏</div></c:if>
        <c:if test="${userfile==false }"><div class="keep" >收藏</div></c:if>
        <c:if test="${userfile==true }"><div class="keep" >已收藏</div></c:if>
        <c:if test="${fileBase.file_catalog.type==2 }"> <div class="free_download_course">免费下载教程</div>
        </c:if>
        <c:if test="${fileBase.file_catalog.type==1 }">  <a class="download_button" href="javascript:return false;">下载</a>
        </c:if>


        <div class="reader_num"><img src="${pageContext.request.contextPath}/frontstage/images/read_download_02.png"><span>${fileBase.file_property.click_times }</span>次浏览</div>
        <div class="download_num"><img src="${pageContext.request.contextPath}/frontstage/images/read_see.png"><span>${fileBase.file_property.download_times}</span>次下载</div>
    </div>



    <div class="main_read_content">


        <div id="flashContent">
            <%--文件未完全加载完前显示加载状态--%>
            <p style="margin-top: 30px;margin-left: 100px;">
                <img src="${pageContext.request.contextPath}/frontstage/images/loading.gif">
            </p>


        </div>
    </div>
    <div class="main_read_right">
        <p>相关资源</p>

        <ul>
            <c:forEach items="${file_baseList}" var="fb" varStatus="status">
                <li>${status.count}<a  href="/edu_yun/read/toRead.action?id=${fb.id}" title="${fb.file_catalog.title}">
                    <c:if test="${fn:length(fb.file_catalog.title) >= 10}">
                        ${fn:substring(fb.file_catalog.title,0,10)}...
                    </c:if>
                    <c:if test="${fn:length(fb.file_catalog.title) < 10}">
                        ${fb.file_catalog.title}
                    </c:if>
                </a><br/>
                    <span class="resources_download_num">${fb.file_property.download_times}</span>人次已下载
                </li>
            </c:forEach>
        </ul>

    </div>


    <div class="my_comment">
        <p>你的评论</p>

        <img class="score_star" src="${pageContext.request.contextPath}/frontstage/images/score_star_icon_black.png" name="${pageContext.request.contextPath}/frontstage/images/">
        <img class="score_star" src="${pageContext.request.contextPath}/frontstage/images/score_star_icon_black.png" name="${pageContext.request.contextPath}/frontstage/images/">
        <img class="score_star" src="${pageContext.request.contextPath}/frontstage/images/score_star_icon_black.png" name="${pageContext.request.contextPath}/frontstage/images/">
        <img class="score_star" src="${pageContext.request.contextPath}/frontstage/images/score_star_icon_black.png" name="${pageContext.request.contextPath}/frontstage/images/">
        <img class="score_star" src="${pageContext.request.contextPath}/frontstage/images/score_star_icon_black.png" name="${pageContext.request.contextPath}/frontstage/images/">
        <div id="share-2" style="position: relative;padding-top: 10px;margin-left: 630px;"></div>
        <textarea id="comment"></textarea>
        <input type="button" value="你的评论" id="comment_btn">
        <input type="hidden" id="score_value" value="">
    </div>



    <div class="other_comment">
        <p>评论</p>
        <c:forEach items="${commentList}" var="comment" varStatus="status">
            <div class="reader_comment">
                <img src="${pageContext.request.contextPath}${comment.user.icon }" >
                <p>${comment.user.username}<span><fmt:formatDate value="${comment.comment_time}" type="both"/></span><span class="score">教材评分</span></p>
                <div>${comment.content}<span class="score">${comment.score}分</span></div>
            </div>
        </c:forEach>

    </div>

</div>



<div style="clear: both;"></div>

<input type="hidden" id="filePath" value="${filePath }">
<input type="hidden" id="fileName" value="${fileName }">
<input type="hidden" id="username" value="${user.username}">


<%--微博qq,微信分享--%>
<script>

    $('#share-2').share({sites: ['qzone', 'qq', 'weibo','wechat']});

</script>
<script type="text/javascript">

    var iTime = 59;
    var eTime = 0;
    $(function()
    {
        //     <!-- For version detection, set to min. required Flash Player version, or 0 (or 0.0.0), for no version detection. -->
        var swfVersionStr = "10.0.0";
        //   <!-- To use express install, set to playerProductInstall.swf, otherwise the empty string. -->
        var xiSwfUrlStr = "playerProductInstall.swf";
        var a="";
        var fileName=$("#fileName").val();
        var flashvars = {
            SwfFile : escape(fileName),
            Scale : 0.6,
            StartAtPage:1,
            ZoomTransition : "easeOut",
            ZoomTime : 0.5,
            ZoomInterval : 0.2,
            FitPageOnLoad : false,
            FitWidthOnLoad : true,
            PrintEnabled : true,
            FullScreenAsMaxWindow : false,
            ProgressiveLoading : true,

//  				  PrintToolsVisible : true,
//  				  ViewModeToolsVisible : true,
//  				  ZoomToolsVisible : true,
//  				  FullScreenVisible : true,
//  				  NavToolsVisible : true,
//  				  CursorToolsVisible : true,
//  				  SearchToolsVisible : true,

            localeChain: "zh_CN"
        };

        var params = {}
        params.quality = "high";
        params.bgcolor = "#ffffff";
        params.allowscriptaccess = "sameDomain";
        params.allowfullscreen = "true";
        var attributes = {};
        attributes.id = "FlexPaperViewer";
        attributes.name = "FlexPaperViewer";
        swfobject.embedSWF(
                "FlexPaperViewer.swf", "flashContent",
                "825", "800",
                swfVersionStr, xiSwfUrlStr,
                flashvars, params, attributes);
        swfobject.createCSS("#flashContent","display:block;text-align:left；");
    });


    $(function () {
        var filePath=$("#filePath").val();
        var fileName=$("#fileName").val();
        $(window).unload(function(){
            $.ajax({
                async : false,
                url : "fileDelete.action?filePath="+filePath+"&fileName="+fileName,
                dataType:'json',
                success : function(response) {
                }
            });
        });
        $(".keep").click(function(){
            var username= $("#username").attr("name");
            if(username==""){
                $("#username").click();
                return false;
            }
            var fileBase_id=$("#fileBase_id").val();
            $.ajax({
                async : false,
                url : "/edu_yun/userFile/keepFile.action?type=2&fileBase_id="+fileBase_id,
                dataType:'json',
                success : function(response) {
                    alert(response.msg);
                    location.replace(location.href);
                }
            });

        });
        $(".download_button").click(function(){
            var username= $("#username").val();
            if(username==""){
                $(".cd-signin").click();
                return false;
            }else{
                var fileBase_id=$("#fileBase_id").val();
                $.ajax({
                    url : "/edu_yun/userFile/checkBuy.action?type=5&fileBase_id="+fileBase_id,
                    dataType:'json',
                    success : function(response) {

                        var status=response.status;

                        if(status==0){
                            alert(response.msg);
                        }
                        if(status==2){
                            //*****************
                            var explorer=getExplorer();
                            var form=$("<form>");//定义一个form表单
                            form.attr("style","display:none");
                            form.attr("target","");
                            form.attr("method","post");
                            form.attr("action","/edu_yun/userFile/download.action");
                            var input1=$("<input>");
                            input1.attr("type","hidden");
                            input1.attr("name","fileBase_id");
                            input1.attr("value",fileBase_id);
                            var input2=$("<input>");
                            input2.attr("type","hidden");
                            input2.attr("name","filePath");
                            input2.attr("value",filePath);
                            var input3=$("<input>");
                            input3.attr("type","hidden");
                            input3.attr("name","explorer");
                            input3.attr("value",explorer);
                            var input4=$("<input>");
                            input4.attr("type","hidden");
                            input4.attr("name","fileName");
                            input4.attr("value",fileName);
                            $("body").append(form);//将表单放置在web中
                            form.append(input1);
                            form.append(input2);
                            form.append(input3);
                            form.append(input4);
                            form.submit();//表单提交 });
                            $.ajax({

                                url : "/edu_yun/userFile/keepFile.action?type=5&fileBase_id="+fileBase_id,
                                dataType:'json',
                                success : function(response) {
                                }
                            });

                            //*****************
                        }if(status==1){
                            //*****************
                            var explorer=getExplorer();
                            var form=$("<form>");//定义一个form表单
                            form.attr("style","display:none");
                            form.attr("method","post");
                            form.attr("action","/edu_yun/order/addOrder.action");
                            var input1=$("<input>");
                            input1.attr("type","hidden");
                            input1.attr("name","fileBase_id");
                            input1.attr("value",fileBase_id);
                            $("body").append(form);//将表单放置在web中
                            form.append(input1);

                            form.submit();//表单提交 });

                        }
                    }
                });

            }
        });
        $(".free_download_course").click(function(){
            var username= $("#username").val();
            if(username==""){
                $(".cd-signin").click();
                return false;
            }
            var fileBase_id=$("#fileBase_id").val();
            //*****************
            var explorer=getExplorer();
            var form=$("<form>");//定义一个form表单
            form.attr("style","display:none");
            form.attr("target","");
            form.attr("method","post");
            form.attr("action","/edu_yun/userFile/download.action");
            var input1=$("<input>");
            input1.attr("type","hidden");
            input1.attr("name","fileBase_id");
            input1.attr("value",fileBase_id);
            var input3=$("<input>");
            input3.attr("type","hidden");
            input3.attr("name","explorer");
            input3.attr("value",explorer);
            $("body").append(form);//将表单放置在web中
            form.append(input1);

            form.append(input3);

            form.submit();//表单提交 });
            //*****************
            $.ajax({
                async : false,
                url : "/edu_yun/userFile/keepFile.action?type=5&fileBase_id="+fileBase_id,
                dataType:'json',
                success : function(response) {
                }
            });
        });

        $(".author_follow_button").click(function(){

            var user_id=$(this).attr("name");
            var username= $("#username").val();
            if(username==""){
                $(".cd-signin").click();
                return false;
            }
            $.ajax({
                async : false,
                type:'get',
                url : "/edu_yun/attent/attent.action?user_id="+user_id,
                dataType:'json',
                success : function(response) {
                    alert(response.msg);
                    location.replace(location.href);
                },
                error :function(response) {

                }
            });

        });
        $(".score_star").click(function(){
            var star="score_star_icon.png";
            var black="score_star_icon_black.png";
            var name= $(this).attr("name");
            $(this).prevAll().attr("src",name+star);
            $(this).attr("src",name+star);
            $(this).nextAll().attr("src",name+black);
            $("#score_value").val($(this).prevAll().length);
        });

        $("#comment_btn").click(function(){
            var username= $("#username").val();
            if(username==""){
                $(".cd-signin").click();
                return false;
            }
            var content=$("#comment").val();
            var score_value=$("#score_value").val();
            if(content==""){
                alert("请输入评论");
            }else if(score_value==""){
                alert("请评分");
            }else{
                var fileBase_id=$("#fileBase_id").val();
                $.ajax({
                    async : false,
                    url : "/edu_yun/comment/comment.action?content="+content+"&fileBase_id="+fileBase_id+"&score_value="+score_value,
                    dataType:'json',
                    success : function(response) {
                        alert(response.msg);
                        location.replace(location.href);
                        $("#comment").val("");
                    }
                });


            }

        });
    });
    function getExplorer() {
        var explorer = window.navigator.userAgent ;
        //ie
        if (explorer.indexOf("MSIE") >= 0) {

            return "IE";
        }
        //firefox
        else if (explorer.indexOf("Firefox") >= 0) {

            return "Firefox";
        }
        //Chrome
        else if(explorer.indexOf("Chrome") >= 0){

            return "Chrome";
        }
        //Opera
        else if(explorer.indexOf("Opera") >= 0){
            return"Opera";
        }
        //Safari
        else if(explorer.indexOf("Safari") >= 0){
            return "Safari";
        }
    }

</script>
<jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>