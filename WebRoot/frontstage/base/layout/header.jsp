<%@ page language="java" import="java.util.*,cn.bnsr.edu_yun.frontstage.base.po.User" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    User user = (User)request.getSession().getAttribute("currentUser");
%>
<c:if test="<%=user!=null %>">
    <c:set value="<%=user.getUser_type() %>" var="userType"></c:set>
    <c:set value="<%=user %>" var="user"></c:set>
</c:if>

<!DOCTYPE html>

<html lang="zh_CN">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="renderer" content="webkit">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <c:if test="${empty head_title}"><title>中国教师网</title></c:if>
    <c:if test="${!empty head_title}"><title>${head_title}</title></c:if>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/frontstage/images/bnsr_ico/bnsr_ico.ico" media="screen" />
    <link href="${pageContext.request.contextPath}/frontstage/css/bootstrap/bootstrap.css" rel="stylesheet" />
    <link rel="stylesheet"  href="${pageContext.request.contextPath}/frontstage/css/community.css"  type="text/css"/>
    <link rel="stylesheet" media="screen" href="${pageContext.request.contextPath}/frontstage/css/bootstrap/font-awesome.min.css" />
    <link rel="stylesheet" media="screen" href="${pageContext.request.contextPath}/frontstage/css/bootstrap/es-icon.css" />

    <link href="${pageContext.request.contextPath}/frontstage/css/bootstrap/main.css" rel="stylesheet" />

    <script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/jquery-1.11.0.min.js"></script>
<%--     <script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/login.js?v=1"></script> --%>
    <script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/main.js?v=3"></script>
    <%--boostrap插件--%>
    <script src="${pageContext.request.contextPath}/frontstage/js/bootstrap/bootstrap.min.js"></script>

    <link rel="stylesheet"  href="${pageContext.request.contextPath}/frontstage/css/bootstrapValidator.css"  type="text/css"/>
    <script src="${pageContext.request.contextPath}/frontstage/js/bootstrapValidator.js"></script>

    <!--翻页-->
    <link href="${pageContext.request.contextPath}/frontstage/css/msdn.css" rel="stylesheet" type="text/css" />
    <script src="${pageContext.request.contextPath}/frontstage/js/jquery.pagination.js?v=2"></script>

    <script src="${pageContext.request.contextPath}/frontstage/js/bootstrap-datetimepicker.js"></script>
    <link href="${pageContext.request.contextPath}/frontstage/css/bootstrap-datetimepicker.css" rel="stylesheet" type="text/css" />
    <script src="${pageContext.request.contextPath}/frontstage/js/bootstrap-datetimepicker.zh-CN.js"></script>
    <script>
        //        百度统计
        var _hmt = _hmt || [];
        (function() {
            var hm = document.createElement("script");
            hm.src = "https://hm.baidu.com/hm.js?2c9cfcc0db2360e17023ff78631e7026";
            var s = document.getElementsByTagName("script")[0];
            s.parentNode.insertBefore(hm, s);
        })();
        // 退出
        $(function(){

            $(".sign_out").click(function(){
                var url=$(this).attr("href");
                $.ajax({
                    type:'post',
                    url:url,
                    dataType:'json',
                    success:function(response){

                        location.replace(location.href);
                    }
                });
            });

        });

    </script>

    <%--记录页面锚点，刷新当前页面后回到刷新前页面位置--%>
    <script>
        var _h = 0;
//        function SetH(o) {
//            _h = o.scrollTop
//            SetCookie("a", _h)
//        }
        window.onload = function () {
            document.getElementsByTagName("body").scrollTop = GetCookie("a");//页面加载时设置scrolltop高度
        }
        function SetCookie(sName, sValue) {
            document.cookie = sName + "=" + escape(sValue) + "; ";
        }
        function GetCookie(sName) {
            var aCookie = document.cookie.split("; ");
            for (var i = 0; i < aCookie.length; i++) {
                var aCrumb = aCookie[i].split("=");
                if (sName == aCrumb[0])
                    return unescape(aCrumb[1]);
            }
            return 0;
        }
    </script>
    <style>
        @font-face {
            font-family: 'Glyphicons Halflings';
            src: url('${pageContext.request.contextPath}/frontstage/css/bootstrap/fonts/glyphicons-halflings-regular.eot');
            src: url('${pageContext.request.contextPath}/frontstage/css/bootstrap/fonts/glyphicons-halflings-regular.eot')
            format('embedded-opentype'), url('${pageContext.request.contextPath}/frontstage/css/bootstrap/fonts/glyphicons-halflings-regular.woff')
            format('woff'), url('${pageContext.request.contextPath}/frontstage/css/bootstrap/fonts/glyphicons-halflings-regular.ttf')
            format('truetype'), url('${pageContext.request.contextPath}/frontstage/css/bootstrap/fonts/glyphicons-halflings-regular.svg#glyphicons_halflingsregular')
            format('svg');
        }

    </style>
</head>

<jsp:include page="/frontstage/base/layout/send_message.jsp"></jsp:include>

<header class="cn-header navbar navbar-bg" >
    <div class="container">

        <div class="navbar-header">
            <a href="${pageContext.request.contextPath}" class="navbar-brand">
                <img src="${pageContext.request.contextPath}/frontstage/images/home_images/bnsr_logo.png" style="margin-top: 17px;height: 30px;">
            </a>
        </div>
        <nav class="collapse navbar-collapse">

            <ul class="nav navbar-nav hidden-xs " id="nav">

                <li class="nav-hover">
                    <a href="${pageContext.request.contextPath}/train/to_train_home.action" >培训
                        <b class="caret"></b>
                    </a>

                    <ul class="dropdown-menu" role="menu">
                        <li ><a  href="${pageContext.request.contextPath }/course/to_course_center.action?type=0&sortType=1&classifyId=-1&isParent=0&parentId=-1">课程</a></li>
                        <li ><a  href="${pageContext.request.contextPath }/train/to_train_center.action?type=0&classify_id=-1">培训</a></li>
                    </ul>
                </li>

                <li><a href="${pageContext.request.contextPath}/lesson_main/to_lesson_home.action" >教研</a></li>
                <li><a href="${pageContext.request.contextPath}/resource_list/to_resource_list.action?stageId=XX">资源 </a></li>
                <li><a href="${pageContext.request.contextPath}/workshop/to_workshop_home.action?status=0">工作坊</a></li>
                <li><a href="${pageContext.request.contextPath}/community/to_community_home.action"  >社区</a></li>

                <c:if test="<%=user!=null%>">
                    <li>
                        <a href="${pageContext.request.contextPath}/my_chart/to_my_chart.action?stamp=2&state=39">个人中心</a>
                    </li>
                </c:if>
            </ul>

            <div class="navbar-user " style="margin-top: 10px;">
                <c:if test="<%=user!=null%>">
                    <ul class="nav user-nav">
                        <li class="user-avatar-li nav-hover">
                            <a href="javascript:void (0);" class="dropdown-toggle" id="my_pic">
                                <img class="avatar-xs" <c:if test="${empty user.icon}">src="${pageContext.request.contextPath}/frontstage/images/default.png"</c:if>
                                     <c:if test="${!empty user.icon}">src="${pageContext.request.contextPath}${user.icon }"</c:if>/>

                            </a>
                            <ul class="dropdown-menu" role="menu" id=header_mine>
                                <li role="presentation" class="dropdown-header">${user.username}</li>
                                <li><a href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id=${user.id}" target="_blank"><i class="es-icon es-icon-person"></i>个人主页</a></li>
                                <li><a href="${pageContext.request.contextPath}/private_letter/to_letter.action"  target="_blank"><i class="es-icon es-icon-setting"></i>私信</a></li>
                                <li class="hidden-lg">
                                    <a href="${pageContext.request.contextPath}/notice/queryNotice.action?page=0&type=0">
                                        <span class="pull-right num"><c:if test="${notification_num>0}">${notification_num}</c:if></span>
                                        <i class="es-icon es-icon-notificationson"></i>
                                        通知</a>
                                </li>
                                <li class="hidden-lg">
                                    <a href="${pageContext.request.contextPath}/private_letter/to_letter.action">
                                        <span class="pull-right num">${privateLetter_num}</span><i class="es-icon es-icon-mail"></i>私信
                                    </a>
                                </li>
                                <li><a href="${pageContext.request.contextPath}/user/frontAjaxLogout.action" class="sign_out" onclick="return false"><i class="es-icon es-icon-power" ></i>退出登录</a></li>
                            </ul>
                        </li>

                        <li class="visible-lg nav-hover">

                            <a href="javascript:return false;" id="header_icon_mail">
                                <c:if test="${notification_num>0||privateLetter_num>0}">
                                    <span class="dot" style="position: absolute;margin-left: 15px;"></span>
                                </c:if>
                                <i class="es-icon es-icon-mail"></i>
                            </a>

                            <ul class="dropdown-menu" role="menu" id="header_notes">
                                <li>
                                    <a href="${pageContext.request.contextPath}/notice/queryNotice.action?page=0&type=0">
                                        <span class="pull-right num"><c:if test="${notification_num>0}">${notification_num}</c:if></span>
                                        <i class="es-icon es-icon-notificationson"></i>通知
                                    </a>
                                </li>
                                <li>
                                    <a href="${pageContext.request.contextPath}/private_letter/to_letter.action">
                                        <span class="pull-right num"><c:if test="${privateLetter_num>0}">${privateLetter_num}</c:if></span>
                                        <i class="es-icon es-icon-mail"></i>私信
                                    </a>
                                </li>
                            </ul>

                        </li>

                    </ul>
                    <form class="navbar-form navbar-right hidden-xs hidden-sm" action="${pageContext.request.contextPath}/search/search.action" method="post">
                        <div class="form-group">
                            <input class="form-control js-search" name="str" placeholder="搜索">

                            <button class="button es-icon es-icon-search"></button>
                        </div>
                    </form>
                </c:if>
            </div>

            <c:if test="<%=user==null%>">
                <%--<div style="bor"></div>--%>

                <div class="navbar-user" style="margin-top: 5px;">
                    <ul class="nav user-nav">
                        <li class="user-avatar-li nav-hover visible-xs">
                            <a href="javascript:;" class="dropdown-toggle">
                                <img class="avatar-xs" src="">
                            </a>
                            <ul class="dropdown-menu" role="menu">
                                <li><a href="${pageContext.request.contextPath}/user/to_login.action">登录</a></li>
                                <li><a href="${pageContext.request.contextPath}/user/to_register1.action">注册</a></li>
                            </ul>
                        </li>
                        <li class="hidden-xs"><a href="${pageContext.request.contextPath}/user/to_login.action" >登录</a></li>
                        <li class="hidden-xs"><a href="${pageContext.request.contextPath}/user/to_register1.action">注册</a></li>

                    </ul>
                    <form class="navbar-form navbar-right hidden-xs hidden-sm" action="${pageContext.request.contextPath}/search/search.action" method="post">
                        <div class="form-group">
                            <input class="form-control js-search" name="str" placeholder="搜索">

                            <button class="button es-icon es-icon-search"></button>
                        </div>
                    </form>
                </div>

            </c:if>

        </nav>
    </div>

</header>

<script type="text/javascript">
    if('${currentUser}'!=""){
        var int=self.setInterval("refresh()",30000);
    }

    function refresh(){

        $.ajax({
            url: '${pageContext.request.contextPath}/user/refresh_user.action',
            type: 'POST',
            dataType:'json' ,
            error:function(){

            },
            success:function(rs){
                if('${sessionInfo}'!=""){
                    clearInterval(int);
                }
            }
        });
    }
    function mouseOver(type,userId){

        var _this = $('#userCard_'+type+userId);

        var loadingHtml = '<div class="card-body"><div class="card-loader"><span class="loader-inner"><span></span><span></span><span></span></span> 名片加载中</div>';

        var timer = setTimeout(function(){

            if ($('#user-card-' + userId).length == 0 || !_this.data('popover')) {

                function beforeSend () {

                    _this.popover({
                        trigger: 'manual',
                        placement: 'auto top',
                        html: 'true',
                        content: function(){
                            return loadingHtml;
                        },
                        template: '<div class="popover cn-card"><div class="arrow"></div><div class="popover-content"></div></div>',
                        container: 'body',
                        animation: true
                    });

                    // _this.popover("show");

                }

                function callback(html) {

                    _this.popover('destroy');

                    if ($('#user-card-' + userId).length == 0) {
                        if ($('body').find('#user-card-store').length > 0 ) {
                            $('#user-card-store').append(html);
                        } else {
                            $('body').append('<div id="user-card-store" class="hidden"></div>');
                            $('#user-card-store').append(html);
                        }
                    }

                    _this.popover({
                        trigger: 'manual',
                        placement: 'auto top',
                        html: 'true',
                        content: function(){
                            return html;
                        },
                        template: '<div class="popover cn-card"><div class="arrow"></div><div class="popover-content"></div></div>',
                        container: 'body',
                        animation: true
                    });

                    _this.popover("show");

                    _this.data('popover', true);

                    $(".popover").on("mouseleave", function () {
                        $(_this).popover('hide');
                    });
                };

                $.ajax ({
                    type:"post",
                    url: '${pageContext.request.contextPath}/user_study/ajax_user.action?id='+userId,
                    dataType: "html",
                    beforeSend: beforeSend,
                    success: callback

                });

            } else {
                _this.popover("show");
            }

        },50);

        _this.data('timerId', timer);
    }

    function mouseOut(type,userId){

        var _this = $('#userCard_'+type+userId);
        setTimeout(function () {

            if (!$(".popover:hover").length) {
                _this.popover("hide")
            }

        },50);

        clearTimeout(_this.data('timerId'));
    }

    $(function () { $("[data-toggle='popover']").popover(); });

    $("#private_message_content").val("");

    var user='${currentUser}';
    var flag=false;
    if(user==""){
        flag=true;
    }

    $(function(){
        $(".js-search").focus(function(){
            $(this).css("width","150px");
        }).blur(function(){
            $(this).css("width","100px");
        });

        //退出
        $("#study_out1").click(function(){
            var reason = $('#reason option:selected').val();
            if(reason==0){
                $("#reason_select").addClass("has-error");
                $("#reason_select").find(".help-block").show();
            }else{
                $("#reason_select").removeClass("has-error");
                $("#reason_select").find(".help-block").hide();
                $.ajax({
                    url : '${pageContext.request.contextPath}/user_study/out_study.action',
                    data : {
                        id : '${userStudyView.id}',
                        reson : reason
                    },
                    dataType : 'json',
                    success : function(response) {
                        location.replace(location.href);
                    }
                });
            }
        });
        //私信
        $('#private-modal').on('show.bs.modal',
            function() {
            })
        $(".send_private_messages").click(function(){
            if(flag){
                check_login();
                return false;
            }
            if($(".send_private_messages_popup").css("display")=="none"){
                $("#private_message_user").val($(this).attr("name"));
                $("#private_message_id").val($(this).attr("value"));
                $(".send_private_messages_popup").show();
                $("body").css("background-color","#e1e0e0");
            }else{
            }
        });
        $("#private_message_user").blur(function(){
            private_message_user_blur(1);
        });
        $("#private_message_content").blur(function(){
            var _this=$(this);
            if(_this.val()==""){
                $("#private_message_content_alert").html("请输入内容");

                return false;
            }else{
                $("#private_message_content_alert").html("");
            }

        });


        $("#send_private_message").click(function(){
            private_message_user_blur(2);
        });

    });

    //单选班级
    function radioClass(currentClass){
        if($("#assistant input[type='checkbox']:checked").prop("checked")){
            $("#assistant input[type='checkbox']:checked").removeProp("checked");
            $(currentClass).prop("checked","true");
        }
    }

    //日期格式化
    function formatDateOfClass(custom_MS){
        if(typeof custom_MS!="number"||custom_MS<0){
            return "暂无时间";
        }
        var xtime=new Date(custom_MS);
        var xtime_str=xtime.getFullYear()+"-"+(xtime.getMonth()+1)+"-"+xtime.getDate();
        return xtime_str;
    }

    //加入学习
    function joinStudy(value){
        var phaseId = "";
        var endTime = $("#endTime").val();
        var openTime = $("#openTime").val();
        var closeTime = $("#closeTime").val();
        if(value==0){//报名学习
            var selectClass = $("#assistant .active input[name='ckClass']").val();
            if(selectClass==null){
                alert("请先选择班级");
                return;
            }
            $('#classId').attr("value",selectClass);

            /*
             if(compareTime(endTime,1)){
             alert("报名已截止");
             return false;
             }
             */
        }else{//加入学习

            if(!compareTime(openTime,0)){
                alert("开班未开始");
                return false;
            }
            if(compareTime(closeTime,1)){
                alert("开班已结束");
                return false;
            }
        }

        $.ajax({
            url : '${pageContext.request.contextPath}/user_study/join_study.action',
            data : {
                classId : $('#classId').val()
            },
            dataType : 'json',
            success : function(response) {
                if (response.msg) {
                    window.location.reload();
                }else{
                    if(value==0){
                        alert("已加入报名!");
                    }else{
                        alert("已加入学习!");
                    }
                }
            }
        });
    }

    function compareTime(value,flag){
        var now = new Date();
        var odate = now.getFullYear()+"-"+((now.getMonth()+1)<10?"0":"")+(now.getMonth()+1)+"-"+(now.getDate()<10?"0":"")+now.getDate()
        if(flag==1){
            return odate>value;
        }else{
            return odate>=value;
        }
    }

    //收藏
    function doCollect(){
        if(flag){
            check_login();
            return false;
        }
        var source_id=$('#classId').val();
        source_type= $('#sourceType').val();
        if(source_id==undefined){

            source_id='${lesson.id}';
            source_type=2;
        }
        $.ajax({
            url : '${pageContext.request.contextPath}/user_collect/collect.action',
            data : {
                learn_id : $('#learnId').val(),
                source_id : source_id,
                source_type : source_type,
            },
            dataType : 'json',
            success : function(response) {
                if(response.msg==1){
                    $("#isUserCollect").show();
                    $("#unUserCollect").hide();
                }
                if(response.msg==2){
                    $("#isUserCollect").hide();
                    $("#unUserCollect").show();
                }
                //  window.location.reload();
            }
        });

    }
    function check_login(){
        window.location.href="${pageContext.request.contextPath}/user/to_login.action"
    }

    function private_message_user_blur(id){
        var _this=$("#private_message_user");
        if(_this.val()==""){
            $("#private_message_user_alert").html("请输入收件人");
            _this.css("border-color","#a94442");
            return false;
        }else if( _this.val()=="${currentUser.username}"){
            $("#private_message_user_alert").html("收件人不能为自己");
            _this.css("border-color","#a94442");
            return false;
        }
        else{
            $("#private_message_user_alert").html("");
        }
        $.ajax({
            async : false,
            type:'post',
            url:"${pageContext.request.contextPath}/user/checkRegister.action",
            data:{
                username:	_this.val()
            },
            dataType:'json',
            success:function(response){

                flag=response.flag;
                if(flag==1){
                    $("#private_message_id").val(response.user.id);
                    $("#private_message_user_alert").html("");
                    if(id==2){
                        var _this1=$("#private_message_content");

                        if(_this1.val()==""){
                            $("#private_message_content_alert").html("请输入内容");
                            _this1.css("border-color","#a94442");
                            return false;
                        }else{
                            $("#private_message_content_alert").html("");
                            var to_user_id=$("#private_message_id").val();
                            $.ajax({
                                type:'post',
                                url:"${pageContext.request.contextPath}/private_letter/send.action",
                                data:{
                                    letter_content:_this1.val(),
                                    to_user_id:to_user_id
                                },
                                dataType:'json',
                                success:function(response){
                                    alert("发送成功");
                                    $(".send_private_messages_popup").hide();
                                    $("#private_message_user_alert").html("");
                                    $("#private_message_content_alert").html("");
                                    $("#private_message_user").val("");
                                    $("#private_message_content").val("");

                                    $("body").css("background-color","#eaeaea");
                                    $('#private-modal').modal('hide');
                                    $(".modal-backdrop").remove();

                                },
                                error:function(response){
                                    alert("发送失败");
                                    $(".send_private_messages_popup").hide();
                                    $("#private_message_user_alert").html("");
                                    $("#private_message_content_alert").html("");
                                    $("#private_message_user").val("");
                                    $("#private_message_content").val("");

                                    $("body").css("background-color","#eaeaea");
                                    $('#private-close').click();
                                    $(".modal-backdrop").remove();
                                    return false;
                                }
                            });
                        }
                    }
                    return true;
                }
                if(flag==2){
                    $("#private_message_user_alert").html("收件人不存在");
                    _this.css("border-color","#a94442");
                    return false;
                }
            }
        });

    }
    function send_private_messages(id,username){

        $("#private_message_user").val(username);
        $("#private_message_id").val(id);
    }
    function send_attent(id){
        //关注
        $.ajax({
            async : false,
            type:'get',
            url : "${pageContext.request.contextPath}/attent/attent.action?user_id="+id,
            dataType:'json',
            success : function(response) {
                alert(response.msg);
                location.replace(location.href);
            },
            error :function(response) {

            }
        });

    }


</script>


