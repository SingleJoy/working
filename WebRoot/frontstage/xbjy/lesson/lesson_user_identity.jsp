<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<div class="cn-wrap">

    <div id="content-container" class="container">
        <c:if test="${!empty workshopView.id}">
            <jsp:include page="../../train/community/workshop_header.jsp"></jsp:include>
        </c:if>
        <c:if test="${empty workshopView.id}">
            <jsp:include page="../../train/community/community_header.jsp"></jsp:include>
        </c:if>

        <div class="row row-3-9">
            <c:if test="${!empty workshopView.id}">
                <jsp:include page="../../train/community/workshop_left.jsp"></jsp:include>
            </c:if>
            <c:if test="${empty workshopView.id}">
                <jsp:include page="../../train/community/community_left.jsp"></jsp:include>
            </c:if>

            <div class="col-lg-9 col-md-8  course-detail-main" >
                <div class="panel panel-default panel-col ">

                    <div class="panel-heading">创建课例:选择组员身份</div>
                    <div class="panel-body">
                        <form id="" action="" class="form-horizontal" method="post">
                            <!-- 新增用户未做完
                <a href='${pageContext.request.contextPath}/lesson/to_lesson_add_user.action?lesson_id=<%=request.getParameter("lesson_id") %>'>
                	<span>新增组员跳转</span>
                	</a>
                	<button id="adduser" type="button"><span>新增组<%=request.getParameter("lesson_id") %>员</span>
                	</button>
                	 -->
                            <div class="form-group pull-right">
                                <button id="setzz" type="button" class="btn btn-primary">设置组长</button>
                                <button id="setzd" type="button" class="btn btn-primary">设置指导教师</button>
                                <button id="datadel" type="button" class="btn btn-warning">批量删除</button>
                            </div>

                            <div class="form-group clearfix">
                                <div class="col-md-12">
                                    <table class="table table-striped" >
                                        <thead>
                                        <tr>
                                            <th width="6%">选择</th>
                                            <th width="20%">成员</th>
                                            <th width="20%">区域</th>
                                            <th width="20%">单位</th>
                                            <th width="20%">角色</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${userList}" var="user" varStatus="status">
                                            <tr>
                                                <td><input type="checkbox" name="boxes" data-identity="${user.identity}" data-name="user_id" id="boxes" value="${user.id}"></td>
                                                <td align="left">${user.true_name}(${user.user_name})</td>
                                                <td align="left">区域</td>
                                                <td align="left">单位</td>
                                                <c:if test="${user.identity == 0}">
                                                    <td align="left">组长
                                                        <button class="btn btn-danger btn-sm revoke" type="button" data-id="${user.id}" data-identity="${user.identity}">撤销</button>
                                                    </td>
                                                </c:if>
                                                <c:if test="${user.identity == 2}">
                                                    <td align="left">指导教师
                                                        <button class="btn btn-danger btn-sm revoke" type="button"  data-id="${user.id}" data-identity="${user.identity}">撤销</button>
                                                    </td>
                                                </c:if>
                                                <c:if test="${user.identity == 3}">
                                                    <td align="left">组员

                                                    </td>
                                                </c:if>

                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <div class="text-center">
                                <input class="btn btn-fat btn-primary" type="button" onclick="checkUser();" value="完成">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>

</div>
<script type="text/javascript">


    function GetQueryString(name)
    {
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
    }



    $(function(){
        $('#dle').click(function(){
            // 获取所有选中的checked框
            var option = $(":checked");
            var checkedId = "";

            var boo=true;


            //拼接除全选框外,所有选中的id,
            for (var i = 0, len = option.length; i < len; i++) {
                alert(option[i].id+"++++++++++++"+option[i].value);
                if (boo) {
                    if (option[i].id=='remember-me') {
                        boo=true;
                    }else {
                        boo=false;

                        checkedId += option[i].value;
                    }
                }else{

                    checkedId += ","+option[i].value;
                } }
            $.ajax({
                type: "post",
                url:'${pageContext.request.contextPath}/lesson_user_identity/delete_user.action',
                data : {
                    "checkedId":checkedId
                },
                dataType:"json",
                success : function(map) {
                    parent.layer.msg(map.message,{icon: 6,time:1000});
                    setTimeout("serachFromSubmit()", 1000);
                },error:function(code){
                    parent.layer.msg('操作失败!',{icon: 5,time:1000});
                }
            });
        })



        $('#datadel').click(function(){
            // 获取所有选中的checked框
            var option = $(":checked");
            var checkedId = "";
            var boo=true;


            //拼接除全选框外,所有选中的id,
            for (var i = 0, len = option.length; i < len; i++) {
                if (boo) {
                    if (option[i].id=='remember-me') {
                        boo=true;
                    }else {
                        boo=false;

                        checkedId += option[i].value;
                    }
                }else{

                    checkedId += ","+option[i].value;
                } }
            $.ajax({
                type: "post",
                url:'${pageContext.request.contextPath}/lesson_user_identity/delete_user.action',
                data : {
                    "checkedId":checkedId
                },
                dataType:"json",
                success : function(response) {
                    alert(response.msg);
                    location.replace(location.href);
                },
                error :function(response) {
                    alert("失败！！！！！！");
                    location.replace(location.href);

                }
            });
        })


        $('#setzz').click(function(){
            // 获取所有选中的checked框
            var option = $(":checked");
            var checkedId = "";
            var identity = 0;
            var lesson_id = GetQueryString("lesson_id");
            var boo=true;
            if(option.length==0){
                alert("请选择组员");
                return false;
            }
            if(option.length>2){
                alert("只能有一个组长");
                return false;
            }
            //拼接除全选框外,所有选中的id,
            for (var i = 0, len = option.length; i < len; i++) {
                if (boo) {
                    if (option[i].id=='remember-me') {
                        boo=true;
                    }else {
                        boo=false;
                        checkedId += option[i].value;
                        var user_identity=option[i].getAttribute("data-identity");
                        if(user_identity==0){
                            alert("已经是组长了");
                            return false;
                        }
                    }
                }else{

                    checkedId += ","+option[i].value;
                } }
            $.ajax({
                type: "post",
                url:'${pageContext.request.contextPath}/lesson_user_identity/set_userZz.action',
                data : {
                    "checkedId":checkedId,
                    "lesson_id":lesson_id,
                    "identity":identity
                },
                dataType:"json",
                success : function(response) {
                    alert(response.msg);
                    location.replace(location.href);
                },
                error :function(response) {
                    alert("失败！！！！！！");
                    location.replace(location.href);
                }
            });
        });


        $('#setzd').click(function(){
            // 获取所有选中的checked框
            var option = $(":checked");
            var checkedId = "";
            var identity = 2;
            var lesson_id = GetQueryString("lesson_id");
            var boo=true;
            if(option.length==0){
                alert("请选择组员");
                return false;
            }
            //拼接除全选框外,所有选中的id,
            for (var i = 0, len = option.length; i < len; i++) {
                var user_identity=option[i].getAttribute("data-identity");
                if (boo) {
                    if (option[i].id=='remember-me') {
                        boo=true;
                    }else {
                        if(user_identity!=2){
                            boo=false;
                            checkedId += option[i].value;
                        }
                    }
                }else{
                    if(user_identity!=2){
                        checkedId += ","+option[i].value;
                    }
                } }
            $.ajax({
                type: "post",
                url:'${pageContext.request.contextPath}/lesson_user_identity/set_userZd.action',
                data : {
                    "checkedId":checkedId,
                    "lesson_id":lesson_id,
                    "identity":identity
                },
                dataType:"json",
                success : function(response) {
                    alert(response.msg);
                    location.replace(location.href);
                },
                error :function(response) {
                    alert("失败！！！！！！");
                    location.replace(location.href);
                }
            });
        });


        $('#adduser').click(function(){
            var lesson_id = GetQueryString("lesson_id");
            window.location.href="${pageContext.request.contextPath}/lesson/to_lesson_add_user.action?lesson_id"+lesson_id;
        });


    });
    function checkUser(){
        var lesson_id = GetQueryString("lesson_id");
        $.ajax({
            url : '${pageContext.request.contextPath}/lesson_user_identity/search_userIdentity.action',
            data:{
                "lesson_id":lesson_id,
            },
            type:'POST',
            dataType:"json",
            success : function(response) {
//					alert(response.msg);
                if(response.msg=='1'){
                    alert("至少有一个组长和指导教师");
                    location.replace(location.href);
                }else{
                    window.location.href="${pageContext.request.contextPath}/lesson/to_lesson.action?workshop_id=${lesson.workshop_id}&source_type=1";
                }
            }
        });
    };
    $(".revoke").click(function() {
        var checkedId=$(this).data("id");
        var lesson_id = GetQueryString("lesson_id");
        var identity=$(this).data("identity");
        $.ajax({
            type: "post",
            url:'${pageContext.request.contextPath}/lesson_user_identity/set_userZd.action',
            data : {
                "checkedId":checkedId,
                "lesson_id":lesson_id,
                "identity":identity
            },
            dataType:"json",
            success : function(response) {
                alert(response.msg);
                location.replace(location.href);
            },
            error :function(response) {
                alert("失败！！！！！！");
                location.replace(location.href);
            }
        });
    });
</script>