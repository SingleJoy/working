<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head lang="en">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>中国教师网</title>
    <meta name="keywords" content="IE=Edge">
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/frontstage/images/qiuzi_ico.ico" media="screen" />
    <link rel="shortcut icon" href="http://scc1a8b2s6-static.qiqiuyun.net/files/system/2015/12-08/173446635bc4259176.ico?7.5.5" type="image/x-icon" media="screen"/>
    <link href="http://scc1a8b2s6-static.qiqiuyun.net/assets/v2/bootstrap/css/bootstrap-blue-light.css?7.5.5" rel="stylesheet" />
    <link rel="stylesheet" media="screen" href="http://scc1a8b2s6-static.qiqiuyun.net/assets/css/common.css?7.5.5" />
    <link rel="stylesheet" media="screen" href="http://scc1a8b2s6-static.qiqiuyun.net/assets/css/font-awesome.min.css?7.5.5" />
    <link rel="stylesheet" media="screen" href="http://scc1a8b2s6-static.qiqiuyun.net/assets/v2/css/es-icon.css?7.5.5" />
    <link rel="stylesheet" media="screen" href="http://scc1a8b2s6-static.qiqiuyun.net/assets/v2/css/main.css?7.5.5" />
    <link href="http://scc1a8b2s6-static.qiqiuyun.net/assets/v2/css/main-blue-light.css?7.5.5" rel="stylesheet" />
    <link href="http://scc1a8b2s6-static.qiqiuyun.net/assets/v2/css/header-white.css?7.5.5" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/frontstage/css/index.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/frontstage/css/login.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/jquery.1.10.2.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/index.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/login.js"></script>
    <script type="text/javascript">
        var iTime = 59;
        var eTime = 0;
        $(function(){

            $(".search_input").keyup(function(e){
                var keycode = e.which;
                if(keycode==13){
                    var login= $(".cd-user-modal").attr("class");
                    $("#search_value").val($(".search_input").val());
                    $(".search_form").submit();

                }
            });

            $(".rank_list_1").click(function(){

                $(".propertyUsers1").css("display","block");
                $(".rank_list_1").css("color","#3ebbce");
                $(".propertyUsers2").css("display","none");
                $(".rank_list_2").css("color","#6b6bb6");

            });
            $(".rank_list_2").click(function(){
                $(".propertyUsers1").css("display","none");
                $(".rank_list_1").css("color","#6b6bb6");
                $(".propertyUsers2").css("display","block");
                $(".rank_list_2").css("color","#3ebbce");

            });

            $(".search_button").click(function(){
                $("#search_value").val($(".search_input").val());
                $(".search_form").submit();

            });

            $("#login_yzm").click(function(){
                if(eTime===1){
                    return false;}
                var reg=/^13[0-9]{9}$|14[0-9]{9}|15[0-9]{9}$|18[0-9]{9}|17[0-9]{9}$/;
                var phone=$("#signin-phone").val();
                var flag=1;
                if(!reg.test(phone)){
                    $("#checkphone").html("手机格式错误");
                    return false;
                }
                $.ajax({
                    async : false,
                    type:'post',
                    url:"/edu_yun/user/checkLoginByPhone.action",
                    data:$("#cd-form").serialize(),
                    dataType:'json',
                    success:function(response){

                        flag=response.flag;
                        if(flag==2){
                            $("#checkphone").html("用户不存在");
                        }
                    }
                });
                if(flag==2){
                    return false;
                }else{
                    $("#username_msg").html("");
                }
                //   var imgyzm=$("#imgyzm").val();

                if(!reg.test(phone)){
                    $("#checkphone").html("手机格式错误");
                    return false;
                }else{
                    $("#checkphone").html("");
                    $.ajax({
                        type:'post',
                        url:"/edu_yun/user/getPhoneYzm.action",
                        data:$("#cd-form").serialize(),
                        dataType:'json',
                        success:function(response){
                            if(response.status="y")
                                RemainTime();
                            else
                                alert("获取验证码失败!");
                        }
                    });

                }


            });


        });
        $(function(){
            var loginFlag=$("#loginFlag").val();
            if(loginFlag==1){
                $("#loginFlag").val("0");
                $(".cd-signin").click();

            }
        });
        function RemainTime(){
            var ahtml="";
            if (iTime > 0){
                ahtml = '提交成功（'+iTime+'秒）';
                Account = setTimeout("RemainTime()",1000);
                iTime=iTime-1;
                eTime=1;
            }else{
                clearTimeout(Account);
                ahtml='点击获取验证码';
                iTime = 59;
                eTime=0;
            }
            $("#login_yzm").val(ahtml);
        };




        $(function(){
            var subject_content=document.getElementsByClassName("subject_content");
            for(var i=0;i<subject_content.length;i++){
                if(i==0){
                    subject_content[i].style.marginTop=-41+"px";
                }
                else{
                    subject_content[i].style.marginTop=-39*i-40+"px";
                }
            }

        });


    </script>

</head>
<body>




<div class="navbar_page">

    <div class="navbar">
        <div class="nav_title"><img src="${pageContext.request.contextPath}/frontstage/images/index_01.png">全部科目资源</div>

        <ul>
            <li><a href="/edu_yun">首页</a></li>
            <c:if test="${!empty user }">
                <li class="personal_space">

                    <a href="${pageContext.request.contextPath}/community/to_community_center.action?stamp=0&state=0"  target="_blank">个人中心</a>
                </li>
            </c:if>

            <li><a href="${pageContext.request.contextPath}/resource_list/to_resource_list.action?stageId=XX"  target="_blank">资源列表</a></li>
            <li><a href="${pageContext.request.contextPath}/train/to_train_home.action"  target="_blank">培训首页</a></li>
            <li><a href="${pageContext.request.contextPath}/lesson_main/to_lesson_main.action"  target="_blank">教研主页</a></li>
        </ul>
    </div>

</div>


<div class="notice_box">
    <span class="triangle"></span>

    <ul>
        <li onclick="tj(1)" class="curr teaching_plan"><a href="javascript:return false;" style="color: #ffffff;">教案消息</a></li>
        <li onclick="tj(2)" class="concern_news"><a href="javascript:return false;">谁关注我</a></li>
        <li onclick="tj(3)" class="system_news"><a href="javascript:return false;">系统消息</a></li>
    </ul>
    <div id="tongzhi" class="teaching_plan_content"></div>

    <p><a href="${pageContext.request.contextPath}/notice/queryNotice.action?page=0&type=0">查看全部</a></p>

</div>


<div id="flash">
    <ul id="pic">
        <li style="display:block"><img src="${pageContext.request.contextPath}/frontstage/images/flash_01.png" ></li>
        <li><img src="${pageContext.request.contextPath}/frontstage/images/flash_02.png" alt=""></li>
        <li><img src="${pageContext.request.contextPath}/frontstage/images/flash_03.png" alt=""></li>
        <li><img src="${pageContext.request.contextPath}/frontstage/images/flash_04.png" alt=""></li>
    </ul>

    <p class="flash_arrow"><a href="javascript:;" class="arrow" id="left"><</a></p>
    <p class="flash_arrow"><a href="javascript:;" class="arrow" id="right">></a></p>
</div>

<div>
    <ol id="num">
        <li class="active"></li>
        <li></li>
        <li></li>
        <li></li>
    </ol>
</div>

<div class="subject_main_content">
    <div class="subject_list">
        <ul>

            <c:forEach items="${strs}" var="str" varStatus="status">
                <li>
                    <a href="#" class="subject_list_name">${str}<img src="${pageContext.request.contextPath}/frontstage/images/index_jiantou.png" class="jiantou"></a>
                    <c:set var="count" value="${status.count-1}"></c:set>


                    <div class="subject_content">

                        <div class="phase">
                            <h4 class="name">小学</h4>
                            <div class="item">
                                <em class="tag">教材版本</em>
                                <span class="links">
                                    <c:forEach items="${entryList.get(count*3)}" var="entry" varStatus="en">
                                        <a  class="item_a" target="_blank" href="${pageContext.request.contextPath}/user/to_resource_list.action?editionId=${entry.id }" >${entry.versionName }</a>
                                    </c:forEach>
                                </span>
                            </div>
                        </div>

                        <div class="phase">
                            <h4 class="name">初中</h4>
                            <div class="item">
                                <em class="tag">教材版本</em>
                                <span class="links">
                                    <c:forEach items="${entryList.get(count*3+1)}" var="entry" varStatus="en">
                                        <a  class="item_a" target="_blank" href="${pageContext.request.contextPath}/user/to_resource_list.action?editionId=${entry.id }" >${entry.versionName }</a>
                                    </c:forEach>
                                </span>
                            </div>
                        </div>

                        <div class="phase">
                            <h4 class="name">高中</h4>
                            <div class="item">
                                <em class="tag">教材版本</em>
                                <span class="links">
                                    <c:forEach items="${entryList.get(count*3+2)}" var="entry" varStatus="en">
                                        <a  class="item_a" target="_blank" href="${pageContext.request.contextPath}/user/to_resource_list.action?editionId=${entry.id }" >${entry.versionName }</a>
                                    </c:forEach>
                                </span>
                            </div>
                        </div>
                    </div>
                </li>
            </c:forEach>
            <li>
                <a href="javascript:void(0);" class="subject_list_name" style="border-bottom: none;">
                    其他<img src="${pageContext.request.contextPath}/frontstage/images/index_jiantou.png" class="jiantou"></a>

                <div class="subject_content">
                    <div class="phase">
                        <h4 class="name">小学</h4>
                        <div class="item">
                            <em class="tag">教材版本</em>
                            <span class="links">
                                <c:forEach items="${subjectListXX}" var="entry" varStatus="en">
                                    <a  class="item_a"target="_blank" href="${pageContext.request.contextPath}/user/to_resource_list.action?editionId=${entry.id }"  >${entry.subjectName }</a>
                                </c:forEach>
                            </span>

                        </div>
                    </div>
                    <div class="phase">
                        <h4 class="name">初中</h4>
                        <div class="item">
                            <em class="tag">教材版本</em>
                            <span class="links">
                                <c:forEach items="${subjectListCZ}" var="entry" varStatus="en">
                                    <a  class="item_a"target="_blank" href="${pageContext.request.contextPath}/user/to_resource_list.action?editionId=${entry.id }" >${entry.subjectName }</a>
                                </c:forEach>

                            </span>
                        </div>
                    </div>
                    <div class="phase">
                        <h4 class="name">高中</h4>
                        <div class="item">
                            <em class="tag">教材版本</em>
                            <span class="links">
                                <c:forEach items="${subjectListGZ}" var="entry" varStatus="en">
                                    <a  class="item_a"target="_blank" href="${pageContext.request.contextPath}/user/to_resource_list.action?editionId=${entry.id }"  >${entry.subjectName }</a>
                                </c:forEach>


                            </span>
                        </div>
                    </div>

                </div>
            </li>
        </ul>
    </div>
</div>

<c:if test="${empty user }">
<div class="login_information">
    <div class="login_top">
        <img src="${pageContext.request.contextPath}/frontstage/images/laoshi.jpg" >
        <div>Hi</div>
        <p>欢迎来到求资网</p>
        <a class="login_info_button" href="${pageContext.request.contextPath}/user/to_login.action">登录</a>
        <a class="login_info_register" href="${pageContext.request.contextPath}/user/to_register1.action">注册</a>
        <div class="upload_file_page_01">
            <a  class="cd-signin" href="#">上传文档</a>
        </div>
    </div>

</div>
</c:if>
<c:if test="${!empty user }">
<div class="personal_information" >
    <div class="personal_top">
        <a href="${pageContext.request.contextPath}/my_contribution/showMyContribution.action?fileType=1&state=1&page=0" target="_blank">
            <img src="${pageContext.request.contextPath}${user.icon }">
        </a>
        <div>${user.username}</div>
        <p>欢迎来到求资网</p>
        <a class="sign_out" href="${pageContext.request.contextPath}/user/frontAjaxLogout.action" onclick="return false">退出</a>
    </div>
    <div class="personal_mid">
        <div class="per_mid_left">
            <div class="wealth_num"><a href="#" class="per_wealth">${user.wealth}</a></div>
            <div><a href="#" class="per_wealth_txt">财富值</a></div>
        </div>

        <div class="per_mid_mid">
            <div class="public_file_num"><a href="#"  class="per_public_file_num">${userProperty.public_file_count}</a></div>
            <div ><a href="#" class="per_public_file_txt" >公共文档</a></div>
        </div>
        <div class="per_mid_right">
            <div class="file_num" ><a href="#" class="per_file">${user.score}</a></div>
            <div ><a href="#" class="per_file_txt">&nbsp;积分</a></div>
        </div>
    </div>

    <div class="upload_file_page_02">
        <a href="${pageContext.request.contextPath}/my_file_base/to_upload_file.action" target="_blank">上传文档</a>
    </div>
</div>


</c:if>

<div class="open_class_main">

    <div class="open_class">
        <p class="open_class_title">免费公开课</p>

        <div class="open_class_page">
            <a href="${pageContext.request.contextPath}/user_study/to_course_study.action?page=1&learnId=39&sourceType=0&tab=1&is_direct=0"><img src="${pageContext.request.contextPath}/picture/default/course_default.png" class="open_class_img"></a>
            <span class="open_class_classify">高中语文</span>
            <div class="open_class_time">9月27日 20:00准时开课</div>
            <div class="open_class_theme"><span>最新</span><a href="${pageContext.request.contextPath}/user_study/to_course_study.action?page=1&learnId=39&sourceType=0&tab=1&is_direct=0">语文系列专题课(一)</a></div>
        </div>

        <div class="open_class_page">
            <a href="${pageContext.request.contextPath}/user_study/to_course_study.action?page=1&learnId=42&sourceType=0&tab=1&is_direct=0"><img src="${pageContext.request.contextPath}/picture/default/course_default.png" class="open_class_img"></a>
            <span class="open_class_classify">高中语文</span>
            <div class="open_class_time">9月27日 20:00准时开课</div>
            <div class="open_class_theme"><span>最新</span><a href="${pageContext.request.contextPath}/user_study/to_course_study.action?page=1&learnId=42&sourceType=0&tab=1&is_direct=0">语文系列专题课(一)</a></div>
        </div>

        <div class="open_class_page">
            <a href="${pageContext.request.contextPath}/user_study/to_course_study.action?page=1&learnId=40&sourceType=0&tab=1&is_direct=0"><img src="${pageContext.request.contextPath}/picture/default/course_default.png" class="open_class_img"></a>
            <span class="open_class_classify">高中语文</span>
            <div class="open_class_time">9月27日 20:00准时开课</div>
            <div class="open_class_theme"><span>最新</span><a href="${pageContext.request.contextPath}/user_study/to_course_study.action?page=1&learnId=40&sourceType=0&tab=1&is_direct=0">语文系列专题课(一)</a></div>
        </div>

        <div class="open_class_page">
            <a href="${pageContext.request.contextPath}/user_study/to_course_study.action?page=1&learnId=41&sourceType=0&tab=1&is_direct=0"><img src="${pageContext.request.contextPath}/picture/default/course_default.png" class="open_class_img"></a>
            <span class="open_class_classify">高中语文</span>
            <div class="open_class_time">9月27日 20:00准时开课</div>
            <div class="open_class_theme"><span>最新</span><a href="${pageContext.request.contextPath}/user_study/to_course_study.action?page=1&learnId=41&sourceType=0&tab=1&is_direct=0">语文系列专题课(一)</a></div>
        </div>

    </div>
</div>

<div class="latest_upload">

    <p class="latest_upload_title">最新上传</p>
    <c:forEach items="${newUpload}" var="nu" varStatus="status">
        <ul class="latest_upload_ul">
            <li class="latest_upload_li"><a class="latest_upload_title_text" title="${nu.file_catalog.title }" href="/edu_yun/read/toRead.action?id=${nu.id}"  target="_blank">${nu.file_catalog.title }</a>
                <p class="upload_formate">大小:<span class="upload_formate_type">${nu.size }</span>
                    <c:if test="${nu.file_catalog.type==1 }"> <span class="latest_upload_page_score">价格:</span><span class="score_num">${nu.value}元</span>
                    </c:if>
                    <c:if test="${nu.file_catalog.type==2 }"> <span class="latest_upload_page_score"></span><span class="score_num">免费</span>
                    </c:if>
                    <c:if test="${nu.file_catalog.type==3 }"> <span class="latest_upload_page_score"></span><span class="score_num">私有</span>
                    </c:if>
                </p>
            </li>
            <li class="upload_author">&nbsp;上传人:<a href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id=${nu.upload_user}" target="_blank" class="upload_author_name">${nu.user.username }</a></li>
        </ul>
    </c:forEach>

</div>


<div class="resource_contribution_main">
    <div class="resource_contribution">
        <p>资源贡献</p>
        <div class="resource_ranks_left">
            <div class="rank_title">今日资源贡献排行榜</div>
            <ul>
                <c:forEach items="${rankViews}" var="rankView" varStatus="en">
                    <li><span class="rank_no">${en.count}</span><span class="rank_name"><a href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id=${rankView.user_id}" target="_blank">${rankView.username}</a></span><span class="resource_num">${rankView.uploadCount}份</span></li>
                </c:forEach>
            </ul>
        </div>

        <div class="resource_ranks_right">
            <div class="rank_name_list">资源贡献总排行榜<a href="#" class="rank_list_1" onclick="return false">1-5</a>&nbsp;&nbsp;<a href="#" class="rank_list_2" onclick="return false">6-10</a></div>

            <ul>
                <c:forEach end="4" items="${propertyUsers}" var="propertyUser" varStatus="en">
                    <li class="propertyUsers1" ><span class="rank_no_01">${en.count}</span><span class="rank_name"><a href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id=${propertyUser.id}" target="_blank">${propertyUser.username}</a></span><span class="resource_num">${propertyUser.user_property.upload_count}份</span></li>
                </c:forEach>
                <c:forEach begin="5" end="10" items="${propertyUsers}" var="propertyUser" varStatus="en">
                    <li class="propertyUsers2" style="display: none"><span class="rank_no_01">${en.count+5}</span><span class="rank_name"><a href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id=${propertyUser.id}">${propertyUser.username}</a></span><span class="resource_num">${propertyUser.user_property.upload_count}份</span></li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>

<div class="about_us">
    <div>关于我们</div><br/><br/>
    <p>求资网是专门为教师设计的服务平台,我们希望让每一位老师的教学更有成效,不再受地域、教学资源和教学水平的限制,让全中国的每位老师都</p>
    <p style="text-align: center;">可以得到有效的教学帮助,让每一堂课都上演精彩.</p>
</div>



<input type="hidden" id="loginFlag" value="${loginFlag}">

<%--<jsp:include page="layout/footer.jsp"></jsp:include>--%>
<script type="text/javascript">
    function tj(value){
        $.ajax({
            type : 'post',
            url : '${pageContext.request.contextPath}/notice/queryNoticeJson.action?type='+value,
            dataType : 'json',
            success : function(json) {
                $("#ttt").remove();
                var a = JSON.stringify(json);

                var o = eval( "(" + a + ")" );
                for(var i in o){

                    $("#tongzhi").append('<div id="ttt" class="notice_page page_01"><span class="dot"></span><a target="_blank" href="javascript:return false;">'+o[i].message+'</a></div>');

                }
            },
            error:function(){
                alert('请求超时')
            }
        });
    }

    $(function(){
        $("#sign_out").click(function(){

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
    })

</script>