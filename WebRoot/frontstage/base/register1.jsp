<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<jsp:include page="layout/header.jsp"></jsp:include>
<link href="${pageContext.request.contextPath}/frontstage/css/register.css" rel="stylesheet" type="text/css">

<script type="text/javascript">

    $(function(){

        var email_reg=/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
        var phone_reg=/^13[0-9]{9}$|14[0-9]{9}|15[0-9]{9}$|18[0-9]{9}|17[0-9]{9}$/;
        $(".user_register").click(function(){

            if(!$(".register_checkbox").is(":checked")){
                $("#agree_msg").html("需要同意协议");
                return false;
            }else{
                $("#agree_msg").html("");
            }
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
            $("#my_form").submit();

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


<div class="main_top_content">

    <a href="javascript:return false;" class="has_admin">已有账号?</a>
    <a href="${pageContext.request.contextPath}/user/registerToLogin.action" class="admin_login">登&nbsp;录</a>
</div>

<div class="main">
    <div class="main_content">

        <form id="my_form" action="${pageContext.request.contextPath}/user/register.action" method="post">

            <div><label class="username">用户名:</label><input id="username" name="username" type="text"/>
                <i style="font-size: 14px;color: red">* </i>
                <i style="font-size: 14px;color: red" id="username_msg"></i>
            </div>
            <div>
                <label class="email">邮箱:</label>
                <input id="email" name="email" data-ideal="required email" type="text"/>
                <i style="font-size: 14px;color: red">* </i>
                <i style="font-size: 14px;color: red" id="email_msg"></i>
            </div>
            <div>
                <label class="username">手机号:</label>
                <input id="phone" name="phone" type="text"/>
                <i style="font-size: 14px;color: red">* </i>
                <i style="font-size: 14px;color: red" id="phone_msg"></i>
            </div>
            <div>
                <label class="password">设置密码:</label>
                <input id="password" name="password" type="password"/>
                <i style="font-size: 14px;color: red">* </i>
                <i style="font-size: 14px;color: red" id="password_msg"></i></div>
            <div>
                <label class="password_again">确认密码:</label>
                <input id="password_again"  type="password"/>
                <i style="font-size: 14px;color: red">* </i></div>
            <div>
                <label class="vary_code">验证码:</label>
                <input  name="" type="text"/>
            </div>
        </form>

        <div>
            <input type="submit" value="注册" class="user_register">
        </div>

        <div class="check_agreement">
            <input type="checkbox" value="" class="register_checkbox">&nbsp;&nbsp;
            <span class="main_style_span">你同意</span>
            <span class="register_agreement">求资网协议</span>
            <i style="font-size: 14px;color: red">* </i>
            <i style="font-size: 14px;color: red" id="agree_msg"></i>
        </div>


    </div>
</div>

</body>

<jsp:include page="layout/footer.jsp"></jsp:include>
