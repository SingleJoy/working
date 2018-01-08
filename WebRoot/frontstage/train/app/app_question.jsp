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
<head>

    <meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/frontstage/css/bootstrap/bootstrap.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/frontstage/css/bootstrap/main.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/jquery-1.11.0.min.js"></script>

</head>
<body style="background-color: #ebebeb;">

<div class="cn-wrap">

    <div class="course-detail-content">

        <div class="course-detail" style="margin-top: 0;min-height: 100%;overflow: auto;padding-bottom: 50px;">

            <div class="panel panel-default no-border" style="margin-bottom: 5px;">
                <div class="panel-body">

                    <label style="font-size: 16px;font-weight: bold;" >
                        ${topicQuestion.title }
                    </label>

                </div>

            </div>

            <div class="panel panel-default" style="margin-bottom:5px;">
                <div class="panel-body">
                    <div class="media topic-item" style="padding-bottom: 0;margin: 0;">
                        <div class="media-left media-middle">
                            <a class="pull-left js-user-card" href="#" >
                                <img class="avatar-sm" src="${pageContext.request.contextPath}${topicQuestion.icon }">
                            </a>

                        </div>
                        <div class="media-body">
                            <div class="title">
                                <a href="#">${topicQuestion.username }</a>
                            </div>
                            <div class="metas text-sm">
                                <span class="article-time">${topicQuestion.question_time }</span>
                                <span class="mlm"></span>
                                <span class="reply-num">回复：<span class="text-danger">${topicQuestion.reply_times }</span></span>
                                <span class="mlm"></span>
                                <span class="click-num">浏览：<span class="text-danger">${topicQuestion.watch_times }</span></span>
                            </div>
                        </div>

                    </div>
                    <hr/>

                    <div class="thread-body" style="font-size: 14px;text-indent: 2rem;">
                            ${topicQuestion.question_content }
                    </div>

                </div>


            </div>

            <c:if test="${!empty topicAnswers }">
                <div class="panel panel-default" style="padding-bottom: 10px;">
                    <div class="panel-body">

                        <div class="thread-posts" style="margin: 20px 10px 0;">

                            <c:forEach items="${topicAnswers }" var="answer">
                                <div class="js-reviews">
                                    <div class="media media-evaluate">
                                        <div class="media-left">
                                            <a class="avatar-link-small js-user-card" href=""  title="">
                                                <img class="avatar-sm" src="${pageContext.request.contextPath}${answer.icon }">
                                            </a>

                                        </div>
                                        <div class="media-body thread-post">
                                            <div class="title">
                                                <a class="link-dark ">${answer.username }</a>

                                                &nbsp;&nbsp;
                                                    ${answer.answer_time }
                                            </div>

                                            <div class="content">

                                                <div class="full-content" >
                                                        ${answer.answer_content }
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </c:forEach>


                        </div>

                    </div>
                </div>

            </c:if>


        </div>
        <div class="panel panel-default" style="margin-bottom: 10px;margin-top: -65px;">
            <div class="panel-body">

                <div class="my-reply">

                    <form class="bs-example bs-example-form" style="margin: 0;">

                        <div class="input-group" >
                            <input type="text" class="form-control" name="answer_content" id="answer_content">

                            <span class="input-group-btn">
                                <button class="btn btn-default" type="button" id="answerButton">回复</button>
                            </span>

                        </div>
                        <div id="msg" class="text-warning"></div>
                    </form>


                </div>
            </div>

        </div>
    </div>

</div>



</div>

</body>



<script type="text/javascript">


    //回答
    $("#answerButton").click(function() {

        //var answer_content = editor.getData();
        var answer_content =$("#answer_content").val();
        if (answer_content == "") {
            $("#msg").html("请输入内容!");
            return false;
        } else {

            $.ajax({
                url : '${pageContext.request.contextPath}/topic_question/put_answer_m.action',
                data : {
                    user_id:'${user_id}',
                    answer_content : answer_content,
                    question_id : '${topicQuestion.id}'
                },
                dataType : 'json',
                success : function(response) {

                    if (response.flag == 1) {

                        location.replace(location.href);
                    }

                }
            });
        }
    });

</script>


