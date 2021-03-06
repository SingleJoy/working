<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<style>
    .index_banner{background: url("${pageContext.request.contextPath}/frontstage/images/index_banner.jpg") top center no-repeat;}
    .index_train_entrance{background: url("${pageContext.request.contextPath}/frontstage/images/index_train_entrance.jpg") top center no-repeat;}
    .index_course_entrance{background: url("${pageContext.request.contextPath}/frontstage/images/index_course_entrance.jpg") top center no-repeat;}
    .index_community_entrance{background: url("${pageContext.request.contextPath}/frontstage/images/index_community_entrance.jpg") top center no-repeat;}
    .admin>a{color: #fff;line-height: 50px;font-size: 16px;}
    .admin>span{color: #fff;line-height: 50px;font-size: 16px;}
</style>



<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<section style="height:400px;width: 100%">

    <div class="index_banner" style="height: 400px;"></div>

</section>

<div class="cn-wrap" style="background-color: #fff;">


    <div class="container">
        <div class="text-line">
            <h5>
                <span>丰富多彩的课程,让学习不再枯燥</span>
                <div class="line"></div>
            </h5>
            <div class="subtitle" style="opacity: 0.6;">A variety of course make teaching more interesting</div>
            <div class="text-center" >
                <a href="javascript:void(0);" class="index_course_entrance" style="height: 586px;display: block;"></a>
            </div>

        </div>
    </div>

    <div class="container">
        <div class="text-line">
            <h5>
                <span>专业培训, 名师解惑</span>
                <div class="line"></div>
            </h5>
            <div class="subtitle" style="opacity: 0.6;">Professional teachers to answer questions</div>
            <div class="text-center" >
                <a href="javascript:void(0);" class="index_train_entrance" style="height: 586px;display: block;"></a>
            </div>

        </div>
    </div>

    <div class="container">
        <div class="text-line">
            <h5>
                <span>线上线下打通, 多形式高效率社区学习</span>
                <div class="line"></div>
            </h5>
            <div class="subtitle" style="opacity: 0.6;">Online and offline to get through, multi-form and efficient community learning.</div>
            <div class="text-center " style="margin-top: 50px;">
                <a href="javascript:void(0);" class="index_community_entrance" style="height: 506px;display: block;"></a>
            </div>

        </div>
    </div>


</div>
<jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
<input type="hidden" id="loginFlag" value="${loginFlag}">


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
        })

    })
    /* window.onbeforeunload=function (){
	alert("===onbeforeunload===");
	if(event.clientX>document.body.clientWidth && event.clientY < 0 || event.altKey){
	alert("你关闭了浏览器");
	}else{
	alert("你正在刷新页面");
	}
	} */






</script>