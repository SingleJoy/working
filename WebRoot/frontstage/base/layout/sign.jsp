<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="org.apache.commons.lang.StringUtils"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<jsp:include page="header.jsp"></jsp:include>
<script type="text/javascript">

    $(function(){
        $(".logon-tab>a").click(function(){
            $(".logon-tab>a").removeClass("active");
            $(".login-main").hide();
            var index=$(this).index();
            if(index==0){
            	$(".logon-tab>a").eq(1).show();
            	$(".logon-tab>a").eq(2).hide();
            }
            $(this).addClass("active");
            $(".login-main").eq(index).show();
        })
        
        $(".forget_password").click(function(){
            $(".logon-tab>a").hide();
            $("#change_password").show();
            $(".login-main").hide();
            $(".reset_password").show();
        })
    });
    var email_reg=/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
    var phone_reg=/^13[0-9]{9}$|14[0-9]{9}|15[0-9]{9}$|18[0-9]{9}|17[0-9]{9}$/;
    var username_reg = /[^\a-\z\A-\Z0-9\u4E00-\u9FA5\@\.\_]/g;
    var password_reg = new RegExp('(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).{8,30}');
    var sql_str="and,delete,or,exec,insert,select,union,update,count,*,',join,>,<,alert,�,=,+,;";  
    $(function(){
        $("#regiter").click(function(){

            if(!$("#register_checkbox").is(":checked")){
                $("#agree_msg").html("需要同意协议");
                return false;
            }else{
                $("#agree_msg").html("");
            }
            var username=$("#username").val();
            var phone=$("#sign_phone").val();
            var email=$("#email").val();
            var password=$("#password").val();
            var password_again=$("#password_again").val();
            var yzm=$("#sign_yzm").val();
            //密码
            if(password==""){
                $("#password_msg").html("密码不能为空");
                return false;
            }else{
            	if(password.length>30||password.length<6){
            		$("#password_msg").html("密码至少6个字符，最多30个字符");
            	}else{
            		$("#password_msg").html("");
            	}
                
            }
            //用户名
            if(username==""){
                $("#username_msg").html("用户名不能为空");
                return false;
            }else{
            	if(username.length>3){
                    $("#username_msg").html("用户名不要超过30个字符！");
            	}else{
                    $("#username_msg").html("");
            	}
            }
           
            if(password==password_again){
                $("#password_msg").html("");
            }else{
                $("#password_msg").html("两次输入的密码不一致");

                return false;
            }
            
            var sqlStr=sql_str.split(','); 
            for(var i=0;i<sqlStr.length;i++){  
                if(username.toLowerCase().indexOf(sqlStr[i])!=-1){  
                    alert("用户名字符中包含了敏感字符请重新输入！"); 
                    return;  
                } 
                if(password.toLowerCase().indexOf(sqlStr[i])!=-1){  
                    alert("密码字符中包含了敏感字符请重新输入！"); 
                    return;  
                } 
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

//            //邮箱
//            if(email==""){
//                $("#email_msg").html("邮箱不能为空");
//                return false;
//            }else{
//                $("#email_msg").html("");
//            }
//            if(!email_reg.test(email)){
//                $("#email_msg").html("邮箱格式不正确");
//                return false;
//            } else{
//                $("#email_msg").html("");
//            }

            
            
            if(yzm==""){
                $("#sign_yzm_msg").html("验证码不能为空");
                return false;
            }else{
                $("#sign_yzm_msg").html("");
            }
            var flag2=2;
            $.ajax({
            	type:'post',
            	url:"/edu_yun/user/checkYzm.action",
                data:{
                   yzm : yzm
                },
                async:false,
                dataType:'json',
                success:function(response){
                    flag2=response.flag;
                    if(flag2==1){
                        $("#sign_yzm_msg").html("验证码错误");
                    }
                }
            });
            if(flag2==1){
                return false;
            }else{
                $("#sign_yzm_msg").html("");
            }
           $("#my_form").submit(); 
        });

        /*

         */
        
        $("#sign_phone").blur(function(){
            var phone=$(this).val();
            if(phone==""){
                $("#sign_phone_msg").html("手机号不能为空");
                return false;
            }else{
                $("#sign_phone_msg").html("");
            }
            if(!phone_reg.test(phone)){
                $("#sign_phone_msg").html("手机格式不正确");
                return false;
            }else{
                $("#sign_phone_msg").html("");
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
                        $("#sign_phone_msg").html("手机号码存在");
                    }
                }
            });
            if(flag1==1){
                return false;
            }else{
                $("#sign_phone_msg").html("");
            }
        });
       
//        $("#email").blur(function(){
//            var email=$("#email").val();
//            if(email==""){
//                $("#email_msg").html("邮箱不能为空");
//                return false;
//            }else{
//                $("#email_msg").html("");
//            }
//            if(!email_reg.test(email)){
//                $("#email_msg").html("邮箱格式不正确");
//                return false;
//            } else{
//                $("#email_msg").html("");
//            }
//        });
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
    function check_sign_yzm(){
        var yzm=$("#sign_yzm").val();
        if(yzm==""){
            $("#sign_yzm_msg").html("验证码不能为空");
            return false;
        }else{
            $("#sign_yzm_msg").html("");
        }
        var flag1=2;
        $.ajax({
        	type:'post',
        	url:"/edu_yun/user/checkYzm.action",
            data:{
               yzm : yzm
            },
            dataType:'json',
            success:function(response){
                flag1=response.flag;
                if(flag1==1){
                    $("#sign_yzm_msg").html("验证码错误");
                }
            }
        });
        if(flag1==1){
            return false;
        }else{
            $("#sign_yzm_msg").html("");
            return true;
        }
    } 
    
</script>


<div class="cn-wrap" style="min-height: 650px;">

    <div class="cn-section login-section" >

        <div class="logon-tab clearfix">
            <a  <c:if test="${index == 0}">class="active"</c:if> href="javascript:void(0);" >帐号登录</a>
            <a  class="" href="javascript:void(0);" <c:if test="${index == 2}">style="display: none;"</c:if> >手机验证登录</a>
            <a  class="active" href="javascript:void(0);" <c:if test="${index != 2}">style="display: none;"</c:if> >注册账号</a>
            <a  class="text-center active" href="javascript:void(0);"  style="display: none;width: 100%;clear: both;" id="change_password">修改密码</a>

        </div>
        <%--账号登录--%>
         <%-- 读取cookie --%>  
	   
        <div  class="login-main" <c:if test="${index!=0}">style="display: none;"</c:if>>
            <form id="login_form0" class="form-vertical" method="post" action="${pageContext.request.contextPath}/user/frontLogin.action" novalidate="novalidate" >
                <input name="refererUrl" value="${refererUrl}" type="hidden" >
                <input id="username1" name="username" type="hidden" >
                <input id="phone1" name="phone" type="hidden" >
                <input id="email1" name="email" type="hidden" >
                <div class="form-group mbl">
                    <label class="control-label">帐号</label>
                    <div class="controls">
                        <input id="account" class="form-control input-lg" type="text"  value="${name}" onblur="new_account();" placeholder="手机/用户名/邮箱" >
                        <span class="text-danger" id="account_msg"></span>
                    </div>
                </div>

                <div class="form-group mbl">
                    <label class="control-label" >密码</label>
                    <div class="controls">
                        <input id="password1" name="password" class="form-control input-lg"  type="password"  placeholder="密码" value="${password }">
                        <span class="text-danger" id="password_msg1"></span>
                    </div>
                </div>
               

                <div class="form-group mbl">
                    <div class="controls col-md-4">
                        <input id="rbr_pwd" name="rpwd" value="1" type="checkbox"> 记住密码
                    </div>
                </div>
                 <br/>
                 <br/>
                <div class="form-group mbl" >
                    <input type="button" id="login_button" onclick="checkLogin0();" value="登 录" class="btn btn-primary btn-lg btn-block">
                </div>



            <div class="form-group mbl">
                <a class="forget_password text-danger" href="javascript:void(0);">忘记密码</a>
                <span class="text-muted mhs">|</span>
                <span class="text-muted">还没有注册帐号？</span>
                <a href="javascript:void(0);" onclick="sign();">立即注册</a>
            </div>
            </form>

        </div>
        <%--手机验证登录--%>
        <div  class="login-main" <c:if test="${index!=1 }">style="display: none;"</c:if>>
            <form id="login_form1" method="post"  novalidate="novalidate" >
                <input name="refererUrl" value="${refererUrl}" type="hidden" >
                <input name="sign_type" id="sign_type" type="hidden" >
                <div class="form-group mbl">
                    <label class="control-label required"><span class="text-danger">*</span>手机号码</label>
                    <div class="controls">
                        <input id="login_phone" onblur="ckeckphone();" name="phone" type="text" class="form-control input-lg"  placeholder="请输入注册手机号码" >
                        <span class="text-danger" id="login_phone_msg"></span>
                    </div>
                </div>

                <div class="form-group mbl  email_mobile_msg">
                    <label class="control-label required"><span class="text-danger">*</span>短信验证码</label>
                    <div class="controls row">
                        <div class="col-xs-7">
                            <input id="login_yzm" onblur="ckeckyzm();" name="yzm" type="text" class="form-control input-lg"  placeholder="" required="required" >
                            <span class="text-danger" id="login_yzm_msg"></span>
                        </div>
                        <div id="login_yzm_cl" class="col-xs-5" onclick='getPhoneYzm("login_phone","login_phone_msg",0);'>
                            <a href="javascript:void(0);"  class="btn btn-lg js-sms-send disabled btn-default" >
                                <span id="js-time-left"></span>
                                <span id="get_login_yzm" >获取短信验证码</span>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="form-group mbl">
                    <input type="button" id="phone_login_button" onclick="checkLogin1();" value="登 录" class="btn btn-primary btn-lg btn-block">
                </div>
            </form>
            <div class="mbl">
                <span class="text-muted">还没有注册帐号？</span>
                <a href="javascript:void(0);" onclick="sign();">立即注册</a>
            </div>

            <%--<div class="social-login">--%>
                <%--<span>--%>
                    <%--<a href="#" class="social-icon social-weibo">--%>
                        <%--<i class="es-icon es-icon-weibo"></i>--%>
                    <%--</a>--%>

                    <%--<a href="#" class="social-icon social-qq">--%>
                        <%--<i class="es-icon es-icon-qq"></i>--%>
                    <%--</a>--%>

                    <%--<a href="#" class="social-icon social-weixin">--%>
                        <%--<i class="es-icon es-icon-weixin"></i>--%>
                    <%--</a>--%>

                <%--</span>--%>

                <%--<div class="line"></div>--%>

            <%--</div>--%>
        </div>

        <div  class="login-main" <c:if test="${index!=2 }">style="display: none;"</c:if>>
            <form id="my_form" method="post" action="${pageContext.request.contextPath}/user/frontRegister1.action" novalidate="novalidate" >
                <input name="refererUrl" value="${refererUrl}" type="hidden" >
                <input name="sign_type" value="0" type="hidden" >
                <div class="form-group mbl">
                    <label class="control-label required"><span class="text-danger">*</span>手机号码</label>
                    <div class="controls">
                        <input id="sign_phone" name="phone" type="text" class="form-control input-lg"  placeholder="用于登录或找回密码" >
                        <span class="text-danger" id="sign_phone_msg"></span>
                    </div>
                </div>

                <div class="form-group mbl">
                    <label class="control-label required" ><span class="text-danger">*</span>用户名</label>
                    <div class="controls">
                        <input type="text" id="username" maxlength="30"  name="username"  required="required" class="form-control input-lg"  placeholder="不超过30个字符长度">
                        <span class="text-danger" id="username_msg"></span>
                    </div>
                </div>

                <div class="form-group mbl">
                    <label class="control-label required" ><span class="text-danger">*</span>密码</label>
                    <div class="controls">
                        <input id="password" type="password" maxlength="30"  name="password" required="required" class="form-control input-lg" placeholder="6-30位英文、数字、符号，区分大小写">
                        <span class="text-danger" id="password_msg"></span>
                    </div>
                </div>

                <div class="form-group mbl">
                    <label class="control-label" ><span class="text-danger">*</span>确认密码</label>
                    <div class="controls">
                        <input class="form-control input-lg" id="password_again"  type="password"  placeholder="再次输入密码" >
                    </div>
                </div>

                <div class="form-group mbl  email_mobile_msg">
                    <label class="control-label required"><span class="text-danger">*</span>短信验证码</label>
                    <div class="controls row">
                        <div class="col-xs-7">
                            <input id="sign_yzm" name="yzm" onblur="check_sign_yzm();" type="text" class="form-control input-lg"  placeholder="" required="required" >
                            <span class="text-danger" id="sign_yzm_msg"></span>
                        </div>
                        <div id="sign_yzm_cl" class="col-xs-5" onclick='getPhoneYzm("sign_phone","sign_phone_msg",1);'>
                            <a href="javascript:void(0);"  class="btn btn-default btn-lg js-sms-send disabled" >
                                <span id="js-time-left"></span>
                                <span id="get_sign_yzm" >获取短信验证码</span>
                            </a>
                        </div>
                    </div>
                </div>



                <div class="form-group mbl">
                    <div class="controls">
                        <label>
                            <input id="register_checkbox" type="checkbox" checked="checked" > 我已阅读并同意<a href="#" target="_blank">《服务协议》</a>
                        </label>
                        <span class="text-danger" id="agree_msg"></span>
                    </div>
                </div>

                <div class="form-group mbl">
                    <div class="controls">
                        <button type="button" id="regiter" class="btn btn-primary btn-lg btn-block">注册</button>
                    </div>
                </div>


            </form>

        </div>
        <%--忘记登录密码,手机重置密码--%>
        <div  class="login-main reset_password" style="display: none;">
            <form id="phone_form" method="post" action="" novalidate="novalidate" >

                <div class="form-group mbl">
                    <label class="control-label required"><span class="text-danger">*</span>手机号码</label>
                    <div class="controls">
                        <input id="signed_phone" onblur="check_signed_phone();" name="phone" type="text" class="form-control input-lg"  placeholder="请输入你的注册手机号码" >
                        <span class="text-danger"  id="signed_phone_msg"></span>
                    </div>
                </div>

                <div class="form-group mbl ">
                    <label class="control-label required"><span class="text-danger">*</span>短信验证码</label>
                    <div class="controls row">
                        <div class="col-xs-7">
                            <input type="text" id="signed_yzm" onblur="check_signed_yzm();" class="form-control input-lg"  placeholder="短信验证码" required="required" >
                            <span id="signed_yzm_msg" class="text-danger" ></span>
                        </div>
                        <div id="signed_yzm_cl" class="col-xs-5" onclick='getPhoneYzm("signed_phone","signed_phone_msg",2);'>
                            <a href="javascript:void(0);"  class="btn btn-default btn-lg js-sms-send disabled" >
                                <span id="js-time-left"></span>
                                <span id="get_signed_yzm">获取短信验证码</span>
                            </a>
                        </div>
                    </div>
                </div>

                <div class="form-group mbl">
                    <input type="button" value="确定" class="btn btn-warning btn-lg btn-block change_password_sure" onclick="change_password_sure();">
                </div>

            </form>

            <div class="mbl">
                <span class="text-muted">还没有注册帐号？</span>
                <a href="javascript:void(0);" onclick="sign();">立即注册</a>
            </div>


        </div>

        <div  class="login-main reset_password_input" style="display: none;">
            <form  id="reset_password" method="post" action="${pageContext.request.contextPath}/user/reset_password.action" novalidate="novalidate" >
                <input name="id" id="user_id" type="hidden">
                <div class="form-group mbl">
                    <label class="control-label required"><span class="text-danger">*</span>新密码</label>
                    <div class="controls">
                        <input  id="password2" name="password" onblur="check_new_password();" type="password" class="form-control input-lg"  placeholder="6-30位英文、数字、符号，区分大小写" >
                        <span id="password2_msg" class="text-danger" style="display: none;">请输入新密码</span>
                    </div>
                </div>

                <div class="form-group mbl">
                    <label class="control-label required"><span class="text-danger">*</span>确认密码</label>
                    <div class="controls">
                        <input id="password2_again" onblur="check_new_password_again();" type="password" class="form-control input-lg"  placeholder="确认密码" >
                        <span id="password2_again_msg"  class="text-danger" style="display: none;"></span>
                    </div>
                </div>

                <div class="form-group mbl">
                    <input type="button"  value="保存新密码" onclick="save_new_password();" class="btn btn-info btn-lg btn-block change_password_succ">
                </div>

            </form>

            <div class="mbl">
                <span class="text-muted">还没有注册帐号？</span>
                <a href="javascript:void(0);" onclick="sign();">立即注册</a>
            </div>


        </div>
    </div>
</div>

<jsp:include page="footer.jsp"></jsp:include>
<script type="text/javascript">
    /* var refererUrl = "${refererUrl}";
    refererUrl.replace();
    var change_password = false; */
    var user_id = "";
    function checkLogin0(){
        var account = $("#account").val();
        var password = $("#password1").val();
        var str="and,delete,or,exec,insert,select,union,update,count,*,',join,>,<,alert,�,=,+,;"; 
        var sqlStr=str.split(',');  
        for(var i=0;i<sqlStr.length;i++){  
            if(account.toLowerCase().indexOf(sqlStr[i])!=-1||password.toLowerCase().indexOf(sqlStr[i])!=-1){  
                alert("用户名字符中包含了敏感字符,请重新输入！");  
                return;  
            }  
        }   
        if(account!=""){
            if(email_reg.test(account)){
                $("#email1").val(account);
            }else if(phone_reg.test(account)){
                $("#phone1").val(account);
            }else{
                $("#username1").val(account);
            }
        }else{
            $("#account_msg").html("账号不能为空");
        }
        if(password==""){
            $("#password_msg1").html("密码不能为空");
        }
        if(account!=""&&password!=""){
            $.ajax({
                url:"${pageContext.request.contextPath}/user/checkLogin1.action",
                data:{
                    username : $("#username1").val(),
                    phone : $("#phone1").val(),
                    email : $("#email1").val(),
                    password : password
                },
                dataType:'json',
                success:function(result){
                    var flag = result.flag;
                    if(flag==1){
                        document.getElementById("login_form0").submit();
                    }/* else if(flag==2){
                    	$("#account_msg").html("");
                        $("#password_msg1").html("密码错误");
                    }else if(flag==3){
                        $("#account_msg").html("账号不存在");
                    } */else{
                    	$("#password_msg1").html("账号或密码错误");
                    }
                }
            });
        }
    }
    
    $("#password1,#account").bind('keypress',function(event){
    	if(event.keyCode==13){//触发windows事件,enter键的ASCII是13
    		checkLogin0();
    	}
    })
    function checkLogin1(){
        var phoneok = ckeckphone();
        var yzm = ckeckyzm();
        if(phoneok&&yzm){
        	var sign_type = $("#sign_type").val();
        	if(sign_type==""){//登录
        		document.getElementById("login_form1").action="${pageContext.request.contextPath}/user/frontLogin.action";
        	}else if(sign_type=="1"){//手机快捷注册
        		document.getElementById("login_form1").action="${pageContext.request.contextPath}/user/frontRegister1.action";
        	}
        	document.getElementById("login_form1").submit(); 
        }
    }
    $("#login_yzm,#login_phone").bind('keypress',function(event){
    	if(event.keyCode==13){
    		checkLogin1();
    	}
    })
    var iTime = 59;
    var eTime = 0;
    function getPhoneYzm(phone,msg,value){ 	
    	if(eTime===1){return false;}
    	var reg=/^13[0-9]{9}$|14[0-9]{9}|15[0-9]{9}$|18[0-9]{9}|17[0-9]{9}$/;
        var phone=$("#"+phone).val();
        if(phone==""){
        	$("#"+msg).html("手机号不能为空");
        	return false;
        }
        if(!reg.test(phone)){
        	$("#"+msg).html("手机格式错误");
        	return false;
        }else{
        	$.ajax({
                type:'post',
                url:"/edu_yun/user/getPhoneYzm.action",
                data:{
                	phone : phone
                },
                dataType:'json',
                success:function(response){
	                if(response.status=="y"){
	                	if(value==0){
	                		RemainTime0();
	                	}else if(value==1){
	                		RemainTime1();
	                	}else if(value==2){
	                		RemainTime2();
	                	}
	                	$("#"+msg).html("");
	                }else{
	                	alert("获取验证码失败!");	
	                }
                }
            });
        }
    }
    
    function RemainTime0(){
    	var ahtml="";
    	if (iTime > 0){
    		ahtml = '提交成功（'+iTime+'秒）';
      		Account = setTimeout("RemainTime0()",1000);
      		iTime=iTime-1;
      		eTime=1;	  
  	    }else{
  	    	$("#login_yzm_cl").css('background-color','');
  	    	clearTimeout(Account);
  	  		ahtml='点击获取验证码';
  	  		iTime = 59;
  	  		eTime=0;
  	    }
    	$("#get_login_yzm").html(ahtml);
    	$("#get_login_yzm").css("color","#fff");
    	$("#login_yzm_cl>a").addClass("btn-danger");
    }
    function RemainTime1(){
    	var ahtml="";
    	if (iTime > 0){
    		ahtml = '提交成功（'+iTime+'秒）';
      		Account = setTimeout("RemainTime1()",1000);
      		iTime=iTime-1;
      		eTime=1;	  
  	    }else{
  	    	$("#sign_yzm_cl").css('background-color','');
  	    	clearTimeout(Account);
  	  		ahtml='点击获取验证码';
  	  		iTime = 59;
  	  		eTime=0;
  	    }
    	$("#get_sign_yzm").html(ahtml);
    	$("#get_sign_yzm").css("color","#fff");
    	$("#sign_yzm_cl>a").addClass("btn-danger");
    } 
    function RemainTime2(){
    	var ahtml="";
    	if (iTime > 0){
    		ahtml = '提交成功（'+iTime+'秒）';
      		Account = setTimeout("RemainTime2()",1000);
      		iTime=iTime-1;
      		eTime=1;	  
  	    }else{
  	    	$("#signed_yzm_cl").css('background-color','');
  	    	clearTimeout(Account);
  	  		ahtml='点击获取验证码';
  	  		iTime = 59;
  	  		eTime=0;
  	    }
    	$("#get_signed_yzm").html(ahtml);
    	$("#get_signed_yzm").css("color","#fff");
    	$("#signed_yzm_cl>a").addClass("btn-danger");
    } 
    
    
    /*
    验证已注册的手机号
*/
    function check_signed_phone(){
    	var phone=$("#signed_phone").val();
        if(phone==""){
			$("#signed_phone_msg").html("<span class='text-danger'>手机号不能为空</span>");
			return false;
		}else{
			$("#signed_phone_msg").html("");
		}
		if(!phone_reg.test(phone)){
		    $("#signed_phone_msg").html("<span class='text-danger'>手机格式不正确</span>");
		    return false;
		}else{
		    $("#signed_phone_msg").html("");
		}
        var flag1=1;
        $.ajax({
			async : false,
			type:'post',
			url:"/edu_yun/user/checkPhone.action",
			data:$("#phone_form").serialize(),
			dataType:'json',
			success:function(response){
			    flag1=response.flag;
			    if(flag1==2){
			        $("#signed_phone_msg").html("<span class='text-danger'>手机号码不存在</span>");
			    }else{
			    	$("#user_id").val(response.user_id);
			    }
			}
        });
		if(flag1==2){
			return false;
		}else{
			$("#signed_phone_msg").html("");
		}
		return true;
    }
    
    function ckeckphone(){
    	var phone=$("#login_phone").val();
        if(phone==""){
            $("#login_phone_msg").html("<span class='text-danger'>手机号不能为空</span>");
            return false;
        }else{
            $("#login_phone_msg").html("");
        }
        if(!phone_reg.test(phone)){
            $("#login_phone_msg").html("<span class='text-danger'>手机格式不正确</span>");
            return false;
        }else{
            $("#login_phone_msg").html("");
        }
        var flag1=1;
        $.ajax({
            async : false,
            type:'post',
            url:"/edu_yun/user/checkPhone.action",
            data:$("#login_form1").serialize(),
            dataType:'json',
            success:function(response){
                flag1=response.flag;
                if(flag1==2){
                	$("#sign_type").val(1);
                    $("#login_phone_msg").html("<span class='text-danger'>号码不存在，将为您创建一个账户</span>"); 
                }
            }
        });
        /* if(flag1==2){
            return false;
        }else{
            $("#login_phone_msg").html("");
        } */
        return true;
    }
    function ckeckyzm(){
    	var yzm=$("#login_yzm").val();
        if(yzm==""){
            $("#login_yzm_msg").html("<span class='text-danger'>验证码不能为空</span>");
            return false;
        }else{
            $("#login_yzm_msg").html("");
        }
        var flag1=2;
        $.ajax({
        	async : false,
        	type:'post',
        	url:"/edu_yun/user/checkYzm.action",
            data:{
               yzm : yzm
            },
            dataType:'json',
            success:function(response){
                flag1=response.flag;
                if(flag1==1){
                    $("#login_yzm_msg").html("<span class='text-danger'>验证码错误</span>");
                }
            }
        });
        if(flag1==1){
            return false;
        }else{
            $("#login_yzm_msg").html("");
        }
        return true;
    }
    /**
	    重置密码验证手机
	*/
	function check_signed_yzm(){
		var yzm=$("#signed_yzm").val();
	    if(yzm==""){
	        $("#signed_yzm_msg").html("<span class='text-danger'>验证码不能为空</span>");
	        return false;
	    }else{
	        $("#signed_yzm_msg").html("");
	    }
	    var flag1=2;
	    $.ajax({
	        type:'post',
	        url:"/edu_yun/user/checkYzm.action",
	        data:{
			   yzm : yzm
			},
			dataType:'json',
			success:function(response){
			    flag1=response.flag;
			    if(flag1==1){
			        $("#signed_yzm_msg").html("<span class='text-danger'>验证码错误</span>");
			    }
			}
	    });
	    if(flag1==1){
		    return false;
		}else{
		    $("#signed_yzm_msg").html("");
		}
	    return true;
    }
    
    function sign(){
    	$(".logon-tab>a").each(function(){
            var index=$(this).index();
            if(index==0){
            	$(this).show().removeClass("active");
            	$(".login-main").eq(index).hide();
            }else if(index==2){
            	$(this).show().addClass("active");
            	$(".login-main").eq(index).show();
            }else{
            	$(this).hide();
            	$(".login-main").eq(index).hide();
            }
        })
    }
    function change_password_sure(){
    	var signed_phone = check_signed_phone();
    	var signed_yzm = check_signed_yzm();
        var user_id = $("#user_id").val();
        if(signed_phone&&signed_yzm&&user_id!=""){
        	$(".reset_password").hide();
            $(".reset_password_input").show();
            $("#user_id").val(user_id);
        }
    }
    
    $("#signed_yzm,#signed_phone").bind('keypress',function(event){
    	if(event.keyCode==13){
    		change_password_sure();
    	}
    })
    function check_new_password(){
    	var new_password = $("#password2").val();
    	var str="and,delete,or,exec,insert,select,union,update,count,*,',join,>,<,alert,�,=,+,;"; 
        var sqlStr=str.split(',');  
        for(var i=0;i<sqlStr.length;i++){  
            if(new_password.toLowerCase().indexOf(sqlStr[i])!=-1){  
                alert("用户名字符中包含了敏感字符,请重新输入！");  
                return;  
            }  
        }
    	if(new_password==""){
    		$("#password2_msg").show();
    		return false;
    	}else{
    		if(new_password.length<=30&&new_password.length>5){
    			$("#password2_msg").hide();
        		return true;
    		}else{
    			alert("密码为6-30位，由英文、数字、符号组成，区分大小写");
    			return false;
    		}
    		
    	}
    }
    
    function check_new_password_again(){
    	var new_password = $("#password2").val();
    	var new_password_again = $("#password2_again").val();
    	if(new_password==""){
    		$("#password2_again_msg").html("请再次输入").show();
    		return false;
    	}else{
    		if(new_password==new_password_again){
        		$("#password2_again_msg").hide();
        		return true;
    		}else{
    			$("#password2_again_msg").html("两次输入密码不一致").show();
    			return false;
    		}
    	}
    }
    function save_new_password(){
    	var new_password = check_new_password();
    	var new_password_again = check_new_password_again();
    	if(new_password&&new_password_again){
    		document.getElementById("reset_password").submit();
    	}
    }
    $("#password2_again,#password2").bind('keypress',function(event){
    	if(event.keyCode==13){
    		save_new_password();
    	}
    })
    $(function(){
   	if('${rpwd}'==1||'${name}'==""){
	$("#rbr_pwd").attr("checked","true");
   	}
    });
    function new_account(){
    	var account = $("#account").val();
    	if(account!="${name}"){
    		$("#password1").val("");
    	}
    }
 
</script>
