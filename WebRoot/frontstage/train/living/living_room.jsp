<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>


<link href="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.js"></script>
<style>
    #defaultImg{  width:540px;height:270px;}
    .file:hover{color: #fff;}
    .webuploader-pick>div>label:hover{color: #fff;}
</style>
<div class="cn-wrap" >

    <div id="content-container" >


        <div class="course-detail row" style="margin-top: 20px;margin-left: 0;">


            <div class="col-lg-12 col-md-12  course-sidebar" style="text-align: center;">

              <h1 style="margin-top: 150px;">老师,你好</h1>

                <h4 style="opacity: 0.6;margin-top: 50px;">你需要在客户端发起直播课程,如未安装请先下载</h4>

                <div style="margin-top: 50px;">
                    <a href="http://live.buka.tv/?room_id=${room_id }&client=1&token=ok&nickname=${currentUser.username}&role=1" class="btn btn-fat btn-info">启动客户端</a>

                    <a href="http://common.buka.tv/file/download/3/Buka_Windows_32_2.1.5.exe" class="btn btn-fat btn-info">下载客户端</a>
                </div>


            </div >



        </div>
    </div>



</div>


