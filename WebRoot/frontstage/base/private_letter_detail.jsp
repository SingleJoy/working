<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<jsp:include page="./layout/header.jsp"></jsp:include>


<script type="text/javascript">
    $(function(){
        $("#private_letter_main>a").click(function(){
            $("#private_letter_main").hide();
            $("#see_private_letter_list").hide();
            $("#private_letter_write_main").show();
        });

        $("#private_letter_write_main>a").click(function(){
            $("#private_letter_main").show();
            $("#see_private_letter_list").hide();
            $("#private_letter_write_main").hide();
        });

    });


</script>
<style>
    #private_message_content1{border: 1px solid #ddd;width: 650px;border-radius: 5px;margin-top: 30px;padding-left: 10px;font-size:14px;resize: none;padding-top: 7px;}
    /*#send_private_message1{border: 1px solid #3ebbce;border-radius: 30px;margin-left: 600px;margin-top: 15px;padding:6px 24px;font-size:14px;background-color: #fff;color: #3ebbce;cursor: pointer;}*/
    /*#send_private_message1:hover{background-color: #3ebbce;color: #fff;}*/
    #private_message_content1_alert{color:#a94442;}
</style>

<!--查看对话列表-->
<div class="cn-wrap">


    <div id="content-container" class="container" style="margin: 20px 0 100px 0;">

        <div class="row row-8">
            <div class="col-md-8 col-md-offset-2">
                <div class="panel panel-default panel-page">

                    <div class="panel-heading">
                        <a href="${pageContext.request.contextPath}/private_letter/to_letter.action" class="btn btn-default pull-right back_my_letter">返回我的私信</a>
                        <h2>与${privateLetterView.to_user_name }的私信对话</h2>
                    </div>

                    <textarea placeholder="请输入私信内容" rows="5" id="private_message_content1"></textarea>
                    <span id="private_message_content1_alert"></span><br/>
                    <br/>
                    <button id="send_private_message1" class="btn btn-primary pull-right" type="button">发送</button>
                    <br/><br/><br/>


                    <ul class="media-list message-list">

                        <c:forEach items="${privateLetterViews }" var="letter">
                            <%--我  --%>
                            <c:if test="${letter.type==2 }">
                                <li  class="media message-she">
                                    <a class="pull-left media-object" href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id=${letter.user_id }"  target="_blank" >
                                        <img class="avatar-sm" src="${pageContext.request.contextPath}${letter.user_icon}"  style="width: 40px;height: 40px;border-radius:50%;">
                                    </a>

                                    <div class="media-body">
                                        <div class="popover right">
                                            <div class="arrow"></div>
                                            <div class="popover-content">
                                                <div class="message-content">
                                                    <strong>
                                                        <a class="link-light" href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id=${letter.to_user_id }">${letter.to_user_name}</a>：
                                                    </strong>
                                                        ${letter.content }
                                                </div>

                                                <div class="message-footer">
                                                    <span class="text-muted"><fmt:formatDate value="${letter.send_time}" type="both" /></span>
                                                    <div class="message-actions">
                                                        <a class="text-muted delete-message delete" href="${pageContext.request.contextPath}/private_letter/delete.action?id=${letter.id}"  onclick="return false">删除</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                            </c:if>

                        </c:forEach>



                        <c:forEach items="${privateLetterViews }" var="letter">
                            <c:if test="${letter.type==1 }">
                                <li  class="media message-me">
                                    <a class="pull-right media-object"  href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id=${letter.to_user_id }" target="_blank" >
                                        <img class="avatar-sm" src="${pageContext.request.contextPath}${letter.to_user_icon}" >
                                    </a>

                                    <div class="media-body">
                                        <div class="popover left">
                                            <div class="arrow"></div>
                                            <div class="popover-content">
                                                <div class="message-content">
                                                    <strong>
                                                        <a class="link-light " href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id=${letter.to_user_id }">我</a>
                                                        ：</strong>
                                                        ${letter.content }
                                                </div>
                                                <div class="message-footer">
                                                    <span class="text-muted"><fmt:formatDate value="${letter.send_time}" type="both" /></span>
                                                    <div class="message-actions">
                                                        <a class="text-muted delete-message delete" href="${pageContext.request.contextPath}/private_letter/delete.action?id=${letter.id}" onclick="return false">删除</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </li>

                            </c:if>
                        </c:forEach>
                    </ul>
                    <form id="studyCenterForm" action="${pageContext.request.contextPath}/private_letter/to_letter_detail.action" method="post">
                        <input type="hidden" name="page" id="page" value="${privateLetterView.page}"/>
                        <input type="hidden" name="rows" id="rows" value="${privateLetterView.rows}"/>
                        <input type="hidden" name="total" id="total" value="${privateLetterView.total}"/>
                        <input type="hidden" name="totalPage" id="totalPage" value="${privateLetterView.totalPage}"/>
                        <input type="hidden" name="to_user_id" id="to_user_id" value="${privateLetterView.to_user_id}"/>
                    </form>
                    <div id="test" class="pager" style="padding-top: 0;margin-bottom: 20px;"></div>
                </div>
            </div>
        </div>
    </div>

</div>

<script type="text/javascript">
    $(function(){
        //翻页
        var total = $("#total").val();
        var page =  parseInt($("#page").val())+1;

        $("#btn5").on('click', function () {
            $("#div1").PageChanged(5);
        });

        $(".pager").pagination({
            thisPageIndex:page,
            recordCount: total,       //总记录数
            pageSize: $("#rows").val(),           //一页记录数
            onPageChange: function (page) {
                document.title = page;
                $("#page").val(page-1);
                $('#studyCenterForm').submit();

            }
        });
        $(".delete").click(function(){
            var msg=confirm("是否删除");
            if(msg){
                var url=$(this).attr("href");
                $.ajax({
                    type:'post',
                    url:url,
                    dataType:'json',
                    success:function(response){

                        location.replace(location.href);
                    }
                });
            }
        });


        $("#send_private_message1").click(function(){
            var _this=$("#private_message_content1");

            if(_this.val()==""){
                $("#private_message_content1_alert").html("请输入内容");
                _this.css("border-color","#a94442");
                return false;
            }else{
                $("#private_message_content1_alert").html("");
                var to_user_id="${privateLetterView.to_user_id}";
                $.ajax({
                    type:'post',
                    url:"${pageContext.request.contextPath}/private_letter/send.action",
                    data:{
                        letter_content:_this.val(),
                        to_user_id:to_user_id
                    },
                    dataType:'json',
                    success:function(response){
                        $("#private_message_content1_alert").html("");
                        $("#private_message_content1").val("");
                        $("#private_message_content1").css("border-color","#ddd");
                        $("body").css("background-color","#eaeaea");
                        location.replace(location.href);
                    },
                    error:function(response){
                        alert("发送失败");
                    }
                });
            }

        });

    })


</script>

<jsp:include page="./layout/footer.jsp"></jsp:include>