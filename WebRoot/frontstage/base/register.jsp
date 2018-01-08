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
    <title>百年树人远程教育有限公司</title>
    <meta name="keywords" content="IE=Edge">
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/frontstage/images/logo.ico" media="screen" />
    <link href="${pageContext.request.contextPath}/frontstage/css/register.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/frontstage/css/login.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/jquery.1.10.2.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/register.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/login.js"></script>
     <script type="text/javascript">
     $(function(){
 
     var email_reg=/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
      var phone_reg=/^13[0-9]{9}$|14[0-9]{9}|15[0-9]{9}$|18[0-9]{9}|17[0-9]{9}$/;
    $("#my_form").submit(function(){ 
    
    var username=$("#username").val();
    var phone=$("#phone").val();
    var email=$("#email").val();
    var password=$("#password").val();
    var password_again=$("#password_again").val();
    //用户名
    if(username==""){
    $("#username_msg").html("用户名不能为空");
    return false;
    }else{
    $("#username_msg").html("");
    }
    var flag=2;
     $.ajax({
                        async : false,
						type:'post',
		    			url:"/edu_yun/user/checkRegister.action",
		    			data:$("#my_form").serialize(),
		    			dataType:'json',
		    			success:function(response){
		    			
		    			flag=response.flag;
                          if(flag==1){
                           $("#username_msg").html("用户名存在");
                        }
                        }
					});
					if(flag==1){
					return false;
					}else{
					 $("#username_msg").html("");
					}
   //手机
     if(phone==""){
      $("#phone_msg").html("手机号不能为空");
    return false;
    }else{
     $("#phone_msg").html("");
    }
    if(!phone_reg.test(phone)){
     $("#phone_msg").html("手机格式不正确");
        return false;
    }else{
       $("#phone_msg").html("");
}
var flag1=2;
     $.ajax({
                        async : false,
						type:'post',
		    			url:"/edu_yun/user/checkPhone.action",
		    			data:$("#my_form").serialize(),
		    			dataType:'json',
		    			success:function(response){
		    			
		    			flag1=response.flag;
                          if(flag1==1){
                           $("#phone_msg").html("手机号码存在");
                        }
                        }
					});
					if(flag1==1){
					return false;
					}else{
					 $("#username_msg").html("");
					}

   //邮箱
   if(email==""){
      $("#email_msg").html("邮箱不能为空");
    return false;
    }else{
     $("#email_msg").html("");
    }
   if(!email_reg.test(email)){
     $("#email_msg").html("邮箱格式不正确");
    return false;
   } else{
    $("#email_msg").html("");
   }
    
   //密码
   
    if(password==""){
      $("#password_msg").html("密码不能为空");
       return false;
    }else{
     $("#password_msg").html("");
    }
    if(password==password_again){
     $("#password_msg").html("");
    }else{
   $("#password_msg").html("两次输入的密码不一致");
     
        return false;
}
    
    
    });

  /*
  
  */
       $("#phone").blur(function(){
        var phone=$("#phone").val();
        if(phone==""){
      $("#phone_msg").html("手机号不能为空");
    return false;
    }else{
     $("#phone_msg").html("");
    }
    if(!phone_reg.test(phone)){
     $("#phone_msg").html("手机格式不正确");
        return false;
    }else{
       $("#phone_msg").html("");
}
var flag1=2;
     $.ajax({
                        async : false,
						type:'post',
		    			url:"/edu_yun/user/checkPhone.action",
		    			data:$("#my_form").serialize(),
		    			dataType:'json',
		    			success:function(response){
		    			
		    			flag1=response.flag;
                          if(flag1==1){
                           $("#phone_msg").html("手机号码存在");
                        }
                        }
					});
					if(flag1==1){
					return false;
					}else{
					 $("#username_msg").html("");
					}

        /*
  
        */
       });
        $("#email").blur(function(){
        var email=$("#email").val();
        if(email==""){
      $("#email_msg").html("邮箱不能为空");
    return false;
    }else{
     $("#email_msg").html("");
    }
   if(!email_reg.test(email)){
     $("#email_msg").html("邮箱格式不正确");
    return false;
   } else{
    $("#email_msg").html("");
   }
       });
        /*
  
          */
        $("#password").blur(function(){
        var password=$("#password").val();
      
        if(password==""){
      $("#password_msg").html("密码不能为空");
       return false;
    }else{
     $("#password_msg").html("");
    }
  
       });
        /*
  
      */
       $("#password_again").blur(function(){
        var password=$("#password").val();
        var password_again=$("#password_again").val();
        if(password==""){
      $("#password_msg").html("密码不能为空");
       return false;
    }else{
     $("#password_msg").html("");
    }
    if(password==password_again){
     $("#password_msg").html("");
    }else{
   $("#password_msg").html("两次输入的密码不一致");
     
        return false;
}
       });
       /*
  
      */
     $("#username").blur(function(){
      var username=$("#username").val();
      if(username==""){
    $("#username_msg").html("用户名不能为空");
    return false;
    }else{
    $("#username_msg").html("");
    }
    var flag=2;
     $.ajax({
                        async : false,
						type:'post',
		    			url:"/edu_yun/user/checkRegister.action",
		    			data:$("#my_form").serialize(),
		    			dataType:'json',
		    			success:function(response){
		    			
		    			flag=response.flag;
                          if(flag==1){
                           $("#username_msg").html("用户名存在");
                        }
                        }
					});
					if(flag==1){
					return false;
					}else{
					 $("#username_msg").html("");
					}
     });
     
     
     });
     
     
     
     
     </script>
</head>
<body>



<div class="login">
    <div class="cd-user-modal">
        <div class="cd-user-modal-container">
            <div class="login_top_title">教育信息公共服务云平台</div>
            <img src="${pageContext.request.contextPath}/images/login.jpg" class="login_img">
            <div id="cd-login">

                <form class="cd-form" id="cd-form" action="${pageContext.request.contextPath}/user/frontLogin.action" method="post">
                    <a class="cd-form_login" href="#">账号登录</a>
                    <a class="cd-form_phone" href="#">手机动态登录</a>

                    <p class="fieldset">
                        <label class="image-replace cd-username" for="signin-username">用户名</label>
                        <input class="full-width has-padding has-border" id="signin-username" name="username" type="text" placeholder="手机/邮箱/用户名">
                        <i style="font-size: 6pt;color: red" id="checklogin"></i>
                    </p>

                    <p class="fieldset">
                        <label class="image-replace cd-password" for="signin-password">密码</label>
                        <input class="full-width has-padding has-border" id="signin-password" name="password"  type="password"  placeholder="输入密码">

                    </p>

                    <p class="fieldset phone-admin" style="display: none;">
                        <input class="full-width has-padding has-border" name="phone" id="signin-phone" type="text" placeholder="请输入手机号">
                        <i style="font-size: 6pt;color: red" id="checkphone"></i>
                    </p>

                    <p class="fieldset var-password" style="display: none;">
                        <input class="full-width has-padding has-border" id="signin-var-password" name="yzm" type="text"  placeholder="请输入验证码">
                        <input type="button" class="login_button" value="点击获取验证码" id="login_yzm">
                    </p>



                    <p class="fieldset remember-state">

                        <input type="checkbox" id="remember-me" checked>
                        <label for="remember-me" class="remember_state">记住登录状态</label>
                        <a href="#" class="login_problem">登录遇到问题</a>
                    </p>

                    <p class="fieldset admin">
                        <input class="full-width2" type="submit" value="登 录" id="login_button" onclick="return false"><br/>
                        <a class="register_now" href="#">立即注册</a>
                    </p>
                </form>

                <div class="login_border"></div>

                <div class="other_login">
                    <p>可以使用以下方式登录</p>
                    <a href="#"><img src="${pageContext.request.contextPath}/images/wechat.jpg" class="wechat_login"></a>
                    <a href="#"><img src="${pageContext.request.contextPath}/images/qq.jpg" class="qq_login"></a>
                </div>

            </div>
            <a href="#" class="cd-close-form" style="display: none">关闭</a>
        </div>
    </div>
</div>


<div class="main">
    <div class="main_content">
       <div class="main_title">教育信息公共服务云平台</div>
          <form id="my_form" action="${pageContext.request.contextPath}/user/register.action" method="post">

              <div><label class="username">用户名:</label><input id="username" name="username" type="text"/><i style="font-size: 12pt;color: red">* </i><i style="font-size: 6pt;color: red" id="username_msg"></i></div>
              <div><label class="username">手机号:</label><input id="phone" name="phone" type="text"/><i style="font-size: 12pt;color: red">* </i><i style="font-size: 6pt;color: red" id="phone_msg"></i></div>
              <div><label class="email">邮箱:</label><input id="email" name="email" data-ideal="required email" type="text"/><i style="font-size: 12pt;color: red">* </i><i style="font-size: 6pt;color: red" id="email_msg"></i></div>
              <div><label class="password">设置密码:</label><input id="password" name="password" type="password"/><i style="font-size: 12pt;color: red">* </i><i style="font-size: 6pt;color: red" id="password_msg"></i></div>
              <div><label class="password_again">确认密码:</label><input id="password_again"  type="password"/><i style="font-size: 12pt;color: red">* </i></div>
              <div><label class="real_name">真实姓名:</label><input id="real_name" name="real_name" type="text"/></div>
              <div><label class="vary_code">验证码:</label><input  name="" type="text"/></div>
              <div><input type="submit" value="注册" class="user_register"></div>
          </form>
        
        <div class="check_agreement"><input type="checkbox" value="" class="register_checkbox">&nbsp;&nbsp;<span class="main_style_span">你同意</span><span class="register_agreement">教育资源公共云平台协议</span></div>
         <br/>
        <ul>
             <li class="about_us"><a href="#">关于平台</a></li>
             <li class="help_inf"><a href="#">帮助中心</a></li>
         </ul>
    </div>
</div>


<jsp:include page="layout/footer.jsp"></jsp:include>
