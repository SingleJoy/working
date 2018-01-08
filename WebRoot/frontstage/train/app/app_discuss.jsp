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
    <link href="${pageContext.request.contextPath}/frontstage/css/bootstrap/bootstrap.css" rel="stylesheet" />
    <link rel="stylesheet" media="screen" href="${pageContext.request.contextPath}/frontstage/css/bootstrap/font-awesome.min.css" />
    <link rel="stylesheet" media="screen" href="${pageContext.request.contextPath}/frontstage/css/bootstrap/es-icon.css" />
    <link href="${pageContext.request.contextPath}/frontstage/css/bootstrap/main.css" rel="stylesheet" />

    <script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/jquery-1.11.0.min.js"></script>
</head>


<body style="background-color: #ebebeb;">

<div class="cn-wrap">

    <div class="course-detail-content">

        <div class="course-detail" style="margin-top: 0;min-height: 100%;overflow: auto;padding-bottom: 50px;">

            <div class="panel panel-default no-border" style="margin-bottom: 5px;">
                <div class="panel-body">

                    <label style="font-size: 16px;font-weight: bold;" >
                        ${courseHour.hour_title } <span style="font-style: italic;">(需要参加&nbsp;
                                <span class="text-danger" style="padding: 0 5px;">
                                    ${courseHour.frequency }
                                </span>次,您已参加
                                <span class="text-info" style="padding: 0 5px;">
                                    <c:choose>
                                        <c:when test="${empty userDiscussCount }">
                                            0
                                        </c:when>
                                        <c:otherwise>
                                            ${userDiscussCount }
                                        </c:otherwise>
                                    </c:choose>
                                </span>次)
                            </span>
                    </label>

                </div>

            </div>

            <div class="panel panel-default" style="margin-bottom:5px;">
                <div class="panel-body">

                    <div class="thread-body" style="font-size: 14px;text-indent: 2rem;">
                        ${courseHour.remarks }
                    </div>

                </div>

            </div>

            <c:if test="${!empty userDiscussViews }">
            <div class="panel panel-default" style="padding-bottom: 10px;margin-bottom: 5px;">
                <div class="panel-body">
                    <div class="thread-posts" style="margin: 20px 10px 0;">
                        <c:forEach items="${userDiscussViews }"  var="view">
                            <div class="js-reviews">
                                <div class="media media-evaluate">
                                    <div class="media-left">
                                        <a class="avatar-link-small js-user-card" href="javascript:void(0);"  title="">
                                            <img class="avatar-sm" src="${pageContext.request.contextPath}${view.icon}" >
                                        </a>
                                    </div>

                                    <div class="media-body thread-post">
                                        <div class="title">
                                            <a class="link-dark ">${view.username}</a>
                                            &nbsp;&nbsp;
                                                ${view.discuss_time}
                                        </div>

                                        <div class="content">
                                            <div class="full-content" >
                                                    ${view.discuss_content}
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
            <div class="panel panel-default" >
                <div class="panel-body">
                    <div class="my-reply">

                        <form class="bs-example bs-example-form">

                            <div class="input-group">
                                <input type="text" class="form-control" id="discuss_content">
                                <span class="input-group-btn">
                                    <button class="btn btn-default js-btn-save"  type="button">回复</button>
                                </span>
                            </div>

                        </form>

                    </div>
                </div>
            </div>

        </div>
    </div>
</div>



<script type="text/javascript">

    $(".js-btn-save").on("click",function(){
        var discuss_content=$("#discuss_content").val();
        if(discuss_content.length<15||discuss_content.length>500){
            alert("研讨内容的字数在15到500字之间");
            return false;
        }
        $.ajax({
            url : '${pageContext.request.contextPath}/course_study/save_discuss.action',
            data : {
                course_hour_id : '${courseHour.id}',
                discuss_content:discuss_content,
                class_id:'${class_id}',
                user_study_id:'${user_study_id}',
                user_id:'${user_id}',
            },
            dataType : 'json',
            success : function(response) {
                location.replace(location.href);
            }
        });

    });

</script>


