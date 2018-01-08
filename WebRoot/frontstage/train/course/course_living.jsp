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
    <c:if test="${empty head_title}"><title>求资网</title></c:if>
    <c:if test="${!empty head_title}"><title>${head_title}</title></c:if>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/frontstage/images/bnsr_ico/bnsr_ico.ico" media="screen" />

    <link href="${pageContext.request.contextPath}/frontstage/css/bootstrap/bootstrap.css" rel="stylesheet" />
    <link rel="stylesheet" media="screen" href="${pageContext.request.contextPath}/frontstage/css/bootstrap/font-awesome.min.css" />
    <link rel="stylesheet" media="screen" href="${pageContext.request.contextPath}/frontstage/css/bootstrap/es-icon.css" />

    <link href="${pageContext.request.contextPath}/frontstage/css/bootstrap/main.css" rel="stylesheet" />

    <style type="text/css">
        /*这个方式兼容所有版本的谷歌浏览器*/
        audio::-webkit-media-controls {
            overflow: hidden !important
        }
        audio::-webkit-media-controls-enclosure {
            width: calc(100% + 32px);
            margin-left: auto;
        }
        video::-webkit-media-controls-enclosure {
            overflow:hidden;
        }
        video::-webkit-media-controls-panel {
            width: calc(100% + 30px);
        }
    </style>

    <link href="${pageContext.request.contextPath}/frontstage/css/scrollBar/style.min.css"
          rel="stylesheet" media="screen" type="text/css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/jquery-1.11.0.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/frontstage/css/scrollBar/mousewheel.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/frontstage/css/scrollBar/scrollbar.min.js"></script>
    <link  href="${pageContext.request.contextPath}/frontstage/js/sharejs/dist/css/share.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/frontstage/js/sharejs/dist/js/jquery.share.min.js"></script>
    <script src="${pageContext.request.contextPath}/frontstage/js/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/wangEditor/wangEditor.min.js"></script>
    <script>

        $(function(){
            $(".period").click(function(){
                $(this).addClass("project").siblings().removeClass("project");
            });
            $("#lesson-toolbar-secondary").click(function(){
                $("#lesson-pane").hide();
                $("#lesson-dashboard").toggleClass("lesson-dashboard-open");
                $("#lesson-dashboard-toolbar").toggleClass("toolbar-open");

                var index=$(".toolbar-nav-stacked>li.active").index();
                $(".panel_index").hide().eq(index).show();


                if($("#lesson-dashboard").hasClass("lesson-dashboard-open")){
                    $(".glyphicon-chevron-right").addClass("glyphicon-chevron-left").removeClass("glyphicon-chevron-right");
                }else{
                    $(".glyphicon-chevron-left").addClass("glyphicon-chevron-right").removeClass("glyphicon-chevron-left");

                }

            })
        });
        $(function(){
            $(".toolbar-nav-stacked>li").click(function(){
                $(this).addClass("active").siblings().removeClass("active");
                var index=$(this).index();
                $("#homework_pane").hide();
                $("#homework-item-list").show();
                $("#discuss_pane").hide();
                $("#discuss-item-list").show();
                $(".homework-pane").find("h5").html("课后作业");
                $("#show-pane").hide();
                $("#list-pane").show();
                $(".panel_index").hide().eq(index).show();
            })
        });
        $(function(){
            $("#quit").on("click",function(){
                $(".form-expanded").toggle();
                $(".subject-comment").show();
            })
        });

        $(function(){
            $(".subject-comment").on("click",function(){
                $(".form-expanded").show();
                $(this).hide();
            })
        });
        /*
         */
    </script>
    <style type="text/css">
        #userDiscussBody{width: auto;  height: auto;  overflow: hidden;  position: absolute;}
        .project{background-color: #f2fae3}
        video::-internal-media-controls-download-button {
            display:none;
        }

        video::-webkit-media-controls-enclosure {
            overflow:hidden;
        }

        video::-webkit-media-controls-panel {
            width: calc(100% + 30px);
        }
        .comment_content>button{
            margin-bottom: 20px;
        }
        body{background: #eaeaea;}
        .comment_content>button{margin-bottom: 20px;}
    </style>
</head>
<body class="lesson-dashboard-page" >

<div class="cn-wrap" style="overflow-y: scroll;">

    <div class="lesson-dashboard lesson-dashboard-open" id="lesson-dashboard" style="position: absolute;" >

        <div class="dashboard-content">
            <a class="btn btn-primary nav-btn back-course-btn"
                    <c:choose>
                        <c:when test="${empty trainType&&isPreview!=1 }">
                            href="${pageContext.request.contextPath}/user_study/to_course_study.action?page=1&learnId=${courseHour.course_id }&sourceType=0&tab=1&is_direct=0"
                        </c:when>
                        <c:when test="${empty trainType&&(isTeacher==1&&isPreview==1) }">
                            href="${pageContext.request.contextPath}/user_study/to_course_study.action?page=1&learnId=${courseHour.course_id }&sourceType=0&tab=1&is_direct=0&viewType=1"
                        </c:when>
                        <c:otherwise>
                            href="${pageContext.request.contextPath}/user_study/to_course_study.action?page=1&learnId=${courseHour.course_id }&sourceType=0&tab=1&is_direct=1&trainType=${trainType }&id=${user_study_id }"
                        </c:otherwise>
                    </c:choose>style="margin-top: 5px;">
                <span class="glyphicon glyphicon-chevron-left"></span>
                返回课程
            </a>

            <div class="dashboard-header">
                <div class="pull-left title-group">
                     <span class="chapter-label">
                          第<span data-role="chapter-number">${courseHourParent.hour_seq }</span>章</span>
                    <span class="divider">»</span>
                    <span class="item-label"><c:if test="${courseHour.attribute_type==2}">课时</c:if><c:if test="${courseHour.attribute_type==0}">试卷</c:if>
                                <c:if test="${courseHour.attribute_type==3}">讨论</c:if><c:if test="${courseHour.attribute_type==4}">作业</c:if>
                                <c:if test="${courseHour.attribute_type==5}">直播课时</c:if>
                                <span >:</span></span>
                    <span class="item-title" >${courseHour.hour_title }</span>
                </div>
            </div>
            <c:if test="${courseHour.attribute_type==2}">
                <div class="dashboard-body" style="max-width: 100%;">

                    <c:choose>
                        <c:when test="${courseHour.hour_type==0 }">
                            <!--视频播放-->
                            <div class="lesson-content lesson-content-audio" id="lesson-audio-content"  style="background-color: #000;">
                                <video id="example_video_1" class="video-js vjs-default-skin vjs-big-play-centered" controls preload="none" style="width: 100%;height: 100%;"
                                       poster="http://video-js.zencoder.com/oceans-clip.png" onended="end()" onplaying="playing()" onpause="pause1()" autoplay oncontextmenu="return false">
                                    <source id="video_source" src="${file_server_path }${courseFile.path }" type='video/mp4' />

                                </video>
                            </div>
                        </c:when>
                        <c:when test="${courseHour.hour_type==1 }">
                            <!-- 文档阅读 -->
                            <div id="doc_container">

                            </div>
                        </c:when>
                        <c:when test="${courseHour.hour_type==2 }">
                            <!-- 音频播放 -->
                            <div class="lesson-content lesson-content-audio" style="background-color: #000;">
                                <audio controls="controls" style="width:100%,height:100%" class="video-js vjs-default-skin vjs-big-play-centered" autoplay="autoplay" controls="controls" controlsList="nodownload" oncontextmenu="return false">
                                    <source id="audio_player1" src="${file_server_path }${courseFile.path }" type="audio/mp3"/>
                                        <%--
                                        <embed id="audio_player2" src="${file_server_path }${courseFile.path }" autostart="true"/>
                                        --%>
                                </audio>
                            </div>
                        </c:when>
                        <c:when test="${courseHour.hour_type==3 }">
                            <!-- 图文阅读 -->
                            <div  class="lesson-content-text-body" >
                                <div class="text-activity-content" style="overflow: auto;padding: 0 10px;">
                                        ${courseHour.img_txt}
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <!-- 该课时类型不支持 -->
                            <div class="empty">
                               该课时类型尚不支持
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>


                <div class="dashboard-footer clearfix">
                    <div class="pull-right">

                        <a href="#user_comment" data-toggle="modal" class="btn btn-default" style="background-color: #eaeaea;border: none;">
                            <span class="glyphicon glyphicon-edit"></span>&nbsp;&nbsp;我想评论
                        </a>
                        <a href="javascript:void(0)" class="btn btn-default" style="background-color: #eaeaea;border: none;" onclick="doCollect();">
                            <span class="glyphicon glyphicon-heart"></span>&nbsp;&nbsp;收藏
                        </a>
                        <c:if test="${(isTeacher!=1||isPreview!=1)&&(empty trainType||is_direct!=1) }">
                            <div id="share-2" style="display: inline-block;margin-left: 20px;" class="social-share text-center" data-sites="weibo,qq,qzone,wechat"

                                    <c:choose>
                                        <c:when test="${empty trainType&&isPreview!=1 }">
                                            data-url="${proj_name}/user_study/to_course_study.action?page=1&learnId=${courseHour.course_id }&sourceType=0&tab=1&is_direct=0"
                                        </c:when>
                                        <c:when test="${empty trainType&&(isTeacher==1&&isPreview==1) }">
                                            data-url="${proj_name}/user_study/to_course_study.action?page=1&learnId=${courseHour.course_id }&sourceType=0&tab=1&is_direct=0&viewType=1"
                                        </c:when>
                                        <c:otherwise>
                                            data-url="${proj_name}/user_study/to_course_study.action?page=1&learnId=${courseHour.course_id }&sourceType=0&tab=1&is_direct=1&trainType=${trainType }&id=${user_study_id }"
                                        </c:otherwise>
                                    </c:choose>

                            ></div>
                        </c:if>
                    </div>


                    <div class="pull-left">
                        <button class="btn btn-primary finish-btn btn-success learning_states" <c:if test="${isTeacher==1&&isPreview==1 }">disabled="disabled"</c:if>>
                            <c:if test="${courseHourStudent.is_studyed!=1}">
                                <span class="glyphicon glyphicon-unchecked" id="learning_box"></span>
                            </c:if>
                            <c:if test="${courseHourStudent.is_studyed==1}">
                                <span class="glyphicon glyphicon-check" id="learning_box"></span>
                            </c:if>
                            学过了
                        </button>
                    </div>
                </div>
            </c:if>
            <c:if test="${courseHour.attribute_type==0}">
                <div class="dashboard-body" style="width: 100%;">
                    <div class="living_homework" style="min-height:600px;">
                        <div class="lesson-content-text-body" style="min-height:590px;">
                            <c:if test="${empty examStatus }">
                                欢迎参加考试，请点击「开始考试」按钮。
                                <c:choose>
                                    <c:when test="${isTeacher==1&&isPreview ==1 }">
                                        <a href="${pageContext.request.contextPath}/exam/to_preview_test.action?id=${homeworkId}&courseId=${courseHour.course_id}&tab=2" class="btn btn-primary btn-sm" target="_blank">开始考试</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/exam/to_test.action?id=${homeworkId}&class_id=${class_id}&user_study_id=${user_study_id}&courseId=${courseHour.course_id}&tab=2" class="btn btn-primary btn-sm" target="_blank">开始考试</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                            <c:if test="${examStatus==0 }">
                                试卷未完全做完。
                                <a href="${pageContext.request.contextPath}/exam/to_test.action?id=${homeworkId}&class_id=${class_id}&user_study_id=${user_study_id}&courseId=${courseHour.course_id}&tab=2" class="btn btn-primary btn-sm" target="_blank">继续考试</a>
                            </c:if>
                            <c:if test="${examStatus==1 }">
                                试卷正在批阅。
                                <a href="${pageContext.request.contextPath}/exam/to_test.action?id=${homeworkId}&class_id=${class_id}&user_study_id=${user_study_id}&courseId=${courseHour.course_id}&tab=2" class="btn btn-primary btn-sm" target="_blank">查看试卷</a>

                            </c:if>
                            <c:if test="${examStatus==2 }">
                                试卷已批阅。
                                <a href="${pageContext.request.contextPath}/exam/to_test.action?id=${homeworkId}&class_id=${class_id}&user_study_id=${user_study_id}&courseId=${courseHour.course_id}&tab=2" class="btn btn-primary btn-sm" target="_blank">查看结果</a>
                            </c:if>
                        </div>

                    </div>

                </div>
            </c:if>
            <c:if test="${courseHour.attribute_type==4}">
                <div class="dashboard-body" style="width: 100%;">
                    <div class="living_homework">
                        <div class="lesson-content-text-body" style="min-height: 598px;">
                            <div class="lesson-about" id="homework_pane1" style="">共<span id="homeworkCount">1</span>个作业题
                                <c:if test="${empty examStatus }">
                                    <c:choose>
                                        <c:when test="${isTeacher==1&&isPreview ==1}">
                                            <a href="${pageContext.request.contextPath}/exam/to_preview_homework.action?id=${homeworkId}&courseId=${courseHour.course_id}&tab=2" class="btn btn-primary btn-sm mlm" target="_blank">开始做题</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/exam/to_homework.action?id=${homeworkId}&courseId=${courseHour.course_id}&tab=2&class_id=${class_id}&user_study_id=${user_study_id}" class="btn btn-primary btn-sm mlm" target="_blank">开始做题</a>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                                <c:if test="${examStatus==0 }">
                                    <a href="${pageContext.request.contextPath}/exam/to_homework.action?id=${homeworkId}&courseId=${courseHour.course_id}&tab=2&class_id=${class_id}&user_study_id=${user_study_id}" class="btn btn-primary btn-sm mlm" target="_blank">继续做题</a>
                                </c:if>
                                <c:if test="${examStatus==2 }">
                                    <a href="${pageContext.request.contextPath}/exam/to_homework.action?id=${homeworkId}&courseId=${courseHour.course_id}&tab=2&class_id=${class_id}&user_study_id=${user_study_id}" class="btn btn-primary btn-sm mlm" target="_blank">查看结果</a>
                                </c:if>
                                <c:if test="${examStatus==1 }">
                                    作业批改中....
                                </c:if>
                            </div>
                        </div>


                    </div>
                </div>
            </c:if>
            <c:if test="${courseHour.attribute_type==3}">
                <div class="dashboard-body" id="userDiscussBody" style="width: 100%;">
                    <div class="living_homework" >
                        <div class="lesson-content-text-body" >
                            <div class="lesson-about" id="discuss_pane" >
                                <h5 class="text-muted" style="margin:10px 0 0 0;line-height: 20px;">
                                    <label style="font-size: 16px;">${courseHour.hour_title }</label>
                                    &nbsp;&nbsp;
                                    <span style="font-style: italic;">(需要参加&nbsp;
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
                                </h5>
                                <div class="thread-body" >
                                    <label  class="text-muted">摘要:</label>
                                    <span style="font-size: 14px;text-indent: 2rem;line-height: 20px;">
                                            ${courseHour.remarks }
                                    </span>

                                </div>

                                <button class="btn btn-primary btn-sm pull-right subject-comment" style="display: block;">评论</button>

                                <form method="post" action="" style=" display: none;" class="form-expanded form-horizontal">
                                    <div class="form-group controls col-md-12">
                                        <textarea class="form-control" rows="6" name="content1"  placeholder="不超过500个字" id="discuss_content"></textarea>
                                        <div class="help-block" style="display: none;">请输入评价内容</div>
                                    </div>

                                    <div class="form-group clearfix">
                                        <c:if test="${isPreview!=1 }">
                                            <a href="javascript:;" class="btn btn-primary pull-right js-btn-save">发表</a>
                                        </c:if>
                                        <a href="javascript:;" class="btn btn-link pull-right js-hide-review-form" id="quit">取消</a>
                                    </div>
                                </form>
                                <div class="help-block" style="margin-top: 50px;"></div>

                                <c:forEach items="${userDiscussViews }"  var="view">
                                    <div class="js-reviews">
                                        <div class="media media-evaluate">

                                            <div class="media-left pull-left" style="display: inline-block;">
                                                <a class="js-user-card" href="javascript:void(0);">
                                                    <img class="avatar-sm" src="${pageContext.request.contextPath}${view.icon}" >
                                                </a>
                                            </div>

                                            <div class="media-body thread-post clearfix">
                                                <div class="title">
                                                    <a class="link-dark " href="javascript:void(0);">${view.username}</a>
                                                    &nbsp;&nbsp;${view.discuss_time}
                                                </div>
                                                <div class="content1">
                                                    <div class="full-content">${view.discuss_content}</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </c:forEach>
                            </div>
                        </div>

                    </div>

                </div>
            </c:if>
            <c:if test="${courseHour.attribute_type==5}">
                <div class="dashboard-body" style="width: 100%;">

                    <div class="lesson-live-content" id="lesson-live-content" >
                        <c:if test="${start==0 }">
                            <div class="lesson-content-text-body"><p>直播将于<strong>${start_time}</strong>开始，于<strong>${end_time}</strong>结束，请在课前10分钟内提早进入。</p><br></div>
                        </c:if>
                        <c:if test="${start==1 }">
                            <div class="lesson-content-text-body"><p>直播将于<strong>${start_time}</strong>开始，于<strong>${end_time}</strong>结束，请在课前10分钟内提早进入。</p><br><div style="padding-bottom:15px; border-bottom:1px dashed #ccc;"></div><br>
                                <div>
                                    <c:if test="${is_teacher==0 }">
                                        <a class="btn btn-primary" href="${pageContext.request.contextPath}/course_living/to_living_room.action?room_id=${course.room_id }" target="_blank">进入直播教室</a>
                                    </c:if>
                                    <c:if test="${is_teacher==1 }">
                                        <a class="btn btn-primary" href="http://live.buka.tv/?room_id=${course.room_id }&token=ok&nickname=${currentUser.username}" target="_blank">进入直播教室</a>
                                    </c:if>
                                    <br><br>
                                </div></div>
                        </c:if>
                        <c:if test="${start==2 }">
                            <div class="lesson-content-text-body"><p>直播已经开始，直播将于<strong>${end_time}</strong>结束。</p><div style="padding-bottom:15px; border-bottom:1px dashed #ccc;"></div><br>
                                <p>
                                    <c:if test="${is_teacher==0 }">
                                        <a class="btn btn-primary" href="${pageContext.request.contextPath}/course_living/to_living_room.action?room_id=${course.room_id }" target="_blank">进入直播教室</a>
                                    </c:if>
                                    <c:if test="${is_teacher==1 }">
                                        <a class="btn btn-primary" href="http://live.buka.tv/${course.room_id }?token=ok&nickname=${currentUser.username}" target="_blank">进入直播教室</a>
                                    </c:if>
                                    <br><br></p></div>
                        </c:if>
                        <c:if test="${start==3 }">
                            <div class="lesson-content-text-body"><p>直播已经结束</p><br></div>
                        </c:if>
                    </div>

                </div>


                <div class="dashboard-footer clearfix" style="margin-top: 10px;">
                    <div class="pull-right">
                        <button class="btn btn-primary finish-btn btn-success learning_states" >
                            <c:if test="${courseHourStudent.is_studyed!=1}">
                                <span class="glyphicon glyphicon-unchecked" id="learning_box"></span>
                            </c:if>
                            <c:if test="${courseHourStudent.is_studyed==1}">
                                <span class="glyphicon glyphicon-check" id="learning_box"></span>
                            </c:if>
                            学过了
                        </button>
                    </div>
                </div>
            </c:if>

        </div>

        <div class="toolbar toolbar-open" id="lesson-dashboard-toolbar"  >

            <div class="toolbar-pane-container" style="overflow-y: auto;">

                <!--目录-->
                <div  class="lesson-pane panel_index" style="" id="lesson-pane">
                    <div class="course-item-list-in-toolbar-pane ps-container"  style="overflow-y: scroll;">

                        <ul class="period-list" id="course-item-list">

                            <c:forEach items="${chapterList}" var="chapter" varStatus="status1">

                                <li class="chapter clearfix" id="list${chapter.id}">
                                    <i class="es-icon es-icon-toc"></i>
                                    <span class="title" title="${chapter.hour_title}">
                                   第${chapter.hour_seq}章：${chapter.hour_title}
                               </span>
                                    <span class="period-show">
                                   <i class="es-icon es-icon-remove"></i><!-- es-icon-anonymous-iconfont -->
                               </span>
                                </li>

                                <c:forEach items="${hourList}" var="hour" varStatus="status">

                                    <c:if test="${chapter.id==hour.parent_id}">

                                        <li class="period lesson-item <c:if test="${courseHour.id==hour.id}">project</c:if>"
                                            id="hour${status.index+1}list${chapter.id}">
                                            <a<c:if test="${hour.attribute_type==0||hour.attribute_type==2||hour.attribute_type==4||hour.attribute_type==5||hour.attribute_type==3}">
                                                        <c:choose>
                                                            <c:when test="${empty trainType&&(isTeacher==1&&isPreview==1) }">
                                                                href="${pageContext.request.contextPath}/course_study/to_study_preview.action?id=${hour.id }&source_type=${classType}&learn_id=${learnId}"
                                                            </c:when>
                                                            <c:when test="${empty trainType&&isPreview!=1 }">
                                                                href="${pageContext.request.contextPath}/course_study/to_study.action?id=${hour.id }&source_id=${courseHourStudent.class_id}&source_type=${classType}&learn_id=${courseHourStudent.course_id}&user_study_id=${user_study_id}"
                                                            </c:when>
                                                            <c:otherwise>
                                                                href="${pageContext.request.contextPath}/course_study/to_study.action?id=${hour.id }&source_id=${courseHourStudent.class_id}&source_type=${classType}&learn_id=${courseHourStudent.course_id}&user_study_id=${user_study_id}&is_direct=1&trainType=${trainType }"
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:if>

                                                    title="${hour.hour_title}">

                                                <c:if test="${hour.is_studyed==0 }"><i class="es-icon es-icon-undone color-primary status-icon"></i></c:if>
                                                <c:if test="${hour.is_studyed==2 }"><i class="es-icon es-icon-doing color-primary status-icon"></i></c:if>
                                                <c:if test="${hour.is_studyed==1 }"><i class="es-icon es-icon-done1 color-primary status-icon"></i></c:if>

                                                <c:if test="${hour.attribute_type==2}">

                                                    <c:if test="${courseHour.hour_type!=1 }">

                                                    <span class="title">
                                                            ${hour.hour_seq}&nbsp;&nbsp;课时：${hour.hour_title}
                                                    </span>

                                                        <span class="course-type">
                                                        <i class="es-icon es-icon-videoclass" data-toggle="tooltip" title="视频课程"></i>
                                                    </span>

                                                    </c:if>
                                                    <c:if test="${courseHour.hour_type==1 }">

                                                    <span class="title">
                                                            ${hour.hour_seq}&nbsp;&nbsp;课时：${hour.hour_title}
                                                    </span>

                                                        <span class="course-type">
                                                        <i class="es-icon es-icon es-icon-graphicclass" data-toggle="tooltip" title="图文课程"></i>
                                                    </span>

                                                    </c:if>


                                                </c:if>

                                                <c:if test="${hour.attribute_type==0}">
                                                    <span class="title">
                                                            ${hour.hour_seq}&nbsp;&nbsp;试卷：${hour.hour_title}
                                                    </span>
                                                    <span class="course-type">
                                                        <i class="es-icon es-icon-check" data-toggle="tooltip" title="试卷"></i>
                                                    </span>

                                                </c:if>

                                                <c:if test="${hour.attribute_type==3}">
                                                    <span class="title">
                                                            ${hour.hour_seq}&nbsp;&nbsp;讨论：${hour.hour_title}
                                                    </span>
                                                    <span class="course-type">
                                                        <i class="es-icon es-icon-graphicclass" data-toggle="tooltip" title="讨论"></i>
                                                    </span>
                                                </c:if>

                                                <c:if test="${hour.attribute_type==4}">
                                                    <span class="title">
                                                            ${hour.hour_seq}&nbsp;&nbsp;作业：${hour.hour_title}
                                                    </span>
                                                    <span class="course-type">
                                                        <i class="es-icon es-icon-check" data-toggle="tooltip" title="作业"></i>
                                                    </span>
                                                </c:if>

                                                <c:if test="${hour.attribute_type==5}">
                                                    <span class="title">${hour.hour_seq}&nbsp;&nbsp;直播课时：${hour.hour_title}</span>
                                                    <span class="course-type">
                                                        <i class="es-icon es-icon-videocam" data-toggle="tooltip" title="直播课时"></i>
                                                    </span>
                                                </c:if>

                                            </a>
                                        </li>

                                    </c:if>
                                </c:forEach>

                            </c:forEach>
                        </ul>


                        <div class="ps-scrollbar-x-rail" style="left: 0px; bottom: -97px; width: 359px; display: none;">
                            <div class="ps-scrollbar-x" style="left: 0px; width: 0px;"></div>
                        </div>
                        <div class="ps-scrollbar-y-rail" style="top: 100px; right: 3px; height: 671px; display: none;">
                            <div class="ps-scrollbar-y" style="top: 77px; height: 517px;"></div>
                        </div>
                        <div class="ps-scrollbar-y" style="top: 77px; height: 517px;display: none;"></div>
                    </div>
                </div>
                <!--问答-->
                <div  class="question panel_index" style="display: none;" >
                    <div class="question-list-pane ps-container">
                        <div data-role="list-pane" id="list-pane">

                            <form  method="post" action="" id="lesson-question-plugin-form">
                                <div class="form-group">
                                    <div class="controls">
                                        <input type="text"  name=""  class="form-control expand-form-trigger" placeholder="我要提问" data-display="标题" id="question_input">
                                    </div>
                                </div>

                                <div class="form-group detail-form-group hide">
                                    <div class="controls">
                                        <%-- 
                                        <textarea  name=""class="form-control" rows="5" placeholder="详细描述你的问题" id="profile1"></textarea>
                                    	--%>
                                        <div class="form-control" id="profile1"></div>
                                    </div>
                                    <script type="text/javascript">
                                        var E = window.wangEditor;
                                        var weditor1 = new E("#profile1");
	                                    weditor1.customConfig.menus = [
	                                         'bold',  // 粗体
	                                         'italic',  // 斜体
	                                         'underline',  // 下划线
	                                         'strikeThrough',  // 删除线
	                                         'foreColor',  // 文字颜色
	                                         'undo',  // 撤销
	                                    ]
                                        //保存图片到服务器
                                        weditor1.customConfig.uploadImgServer = "${pageContext.request.contextPath}/upload_file/upload_resource.action?source_id=${courseView.id}&source_type=0";
                                        //限制图片大小
                                        weditor1.customConfig.uploadImgMaxSize = 3*1024*1024;
                                        //图片上传上限
                                        weditor1.customConfig.uploadImgMaxLength = 1;
                                        //隐藏"网络图片"选项
                                        weditor1.customConfig.showLinkImg = false;
                                        weditor1.create();
                                    </script>
                                </div>

                                <div class="form-group detail-form-group hide">
                                    <div class="controls clearfix">
                                        <button class="btn btn-primary btn-sm pull-right" type="button" id="question_button" <c:if test="${isTeacher==1&&isPreview==1 }">disabled="disabled"</c:if>>提问</button>
                                        <button class="btn btn-link btn-sm collapse-form-btn pull-right" type="button" id="question_quit">取消</button>
                                    </div>
                                </div>


                            </form>

                            <ul class="media-list thread-list-small mtl" data-role="list">
                                <!--若此课程没有问题显示-->
                                <c:if test="${empty questions }">
                                    <li class="empty-item" >此课时还没有问题</li>
                                </c:if>
                                <c:if test="${!empty questions }">
                                    <c:forEach items="${questions }" var="question">
                                        <li class="media thread-item" >
                                            <div class="media-body thread-item-body">
                                                <div class="title mbm">
                                                    <a  href="javascript:return false" onclick="questionClick(${question.id })" class="show-question-item" >${question.title }</a>
                                                </div>
                                                <div class="metas">
                                                    <a class="link-dark ">${question.user.username }</a>
                                                    发表于 <fmt:formatDate value="${question.question_time }" type="both" />
                                                    <span class="bullet">•</span>
                                                    <a href="#">${question.reply_times }回答</a>
                                                </div>
                                            </div>
                                        </li>

                                    </c:forEach>
                                </c:if>


                            </ul>
                        </div>
                        <div data-role="show-pane" style="display:none;" id="show-pane"></div>
                    </div>
                </div>

                <!--笔记-->
                <div  class="note-pane panel_index"  style="display: none;">
                    <form id="lesson-note-plugin-form" method="post" action="">
                        <div class="form-group note-content">
                            <div class="controls">
                                <div id="profile">${note.note_content }</div>
                                <%-- 
                                <input type="hidden" name="profile" value="${note.note_content }">
                            	--%>
                            	<textarea style="display: none;" name="profile">
                            		${note.note_content }
                            	</textarea>
                            </div>
                        </div>
                        <script type="text/javascript">
                            var E = window.wangEditor;
                            var weditor = new E("#profile");
                            weditor.customConfig.menus = [
              	               'bold',  // 粗体
              	               'italic',  // 斜体
              	               'underline',  // 下划线
              	               'foreColor',  // 文字颜色
              	               'backColor',  // 背景颜色
              	               'image',  // 插入图片
              	               'list',  // 列表
              	           	   'justify',  // 对齐方式
              	           	   'table',  // 表格
              	               'undo',  // 撤销
              	            ]
                            //保存图片到服务器
                            weditor.customConfig.uploadImgServer = "${pageContext.request.contextPath}/upload_file/upload_resource.action?source_id=${courseView.id}&source_type=0";
                            //限制图片大小
                            weditor.customConfig.uploadImgMaxSize = 3*1024*1024;
                            //图片上传上限
                            weditor.customConfig.uploadImgMaxLength = 1;
                            //隐藏"网络图片"选项
                            weditor.customConfig.showLinkImg = false;
                            weditor.create();
                        </script>

                        <div class="form-group note-actions">
                            <div class="controls clearfix">
                                <span class="text-muted" data-role="saved-message" style="display: none;">已保存</span>
                                <button class="btn btn-primary btn-xs pull-right save_notes" type="button" <c:if test="${isTeacher==1&&isPreview==1 }">disabled="disabled"</c:if>>保存笔记</button>

                                <label class="text-muted">
                                    <input type="checkbox" name=""  id="share" <c:if test="${isTeacher==1&&isPreview==1 }">disabled="disabled"</c:if>> 分享笔记
                                </label>
                            </div>
                        </div>

                    </form>
                </div>

                <!--资料-->
                <div  class="material-pane ps-container panel_index"  style="display: none;">
                    <h5>课时简介</h5>
                    <div class="lesson-about">
                        <c:if test="${empty courseHour.remarks }">此课时无简介。</c:if>
                        <c:if test="${!empty courseHour.remarks }">${courseHour.remarks }</c:if>
                    </div>

                    <h5>课时资料</h5>

                    <ul class="media-list toolbar-pane-list">
                        <c:if test="${empty courseHourFileList}">
                            <li class="empty-item" style="text-align:left;margin-left:10px;">此课时无资料</li>
                        </c:if>
                        <c:if test="${!empty courseHourFileList}">
                            <c:forEach items="${courseHourFileList}" var="file">

                                <li class="media list-item">
                                    <div class="media-body list-item-body">
                                        <div class="title">${file.id}
                                            <a href="${pageContext.request.contextPath }/course_hour_file/to_look_course_materials.action?id=${file.id }&class_id=${class_id}" target="_blank">${file.fileName }</a>

                                            <span class="meta"></span>
                                        </div>
                                        <div class="summary">${file.file_profile }</div>
                                    </div>
                                </li>
                            </c:forEach>
                        </c:if>
                    </ul>

                </div>

                <!--作业-->
                <div  class="homework-pane panel_index"  style="display: none;">

                    <h5>课后作业</h5>
                    <ul class="period-list" id="homework-item-list" >
                        <c:forEach items="${hourList}" var="hour" varStatus="status">
                            <c:if test="${hour.attribute_type==4}">
                                <li class="period lesson-item homeworkList" id="homeworkList${status.index+1}">
                                    <a
                                            <c:choose>
                                                <c:when test="${empty trainType&&(isTeacher==1&&isPreview==1) }">
                                                    href="${pageContext.request.contextPath}/course_study/to_study_preview.action?id=${hour.id }&source_type=${classType}&learn_id=${learnId}"
                                                </c:when>
                                                <c:when test="${empty trainType&&isPreview!=1 }">
                                                    href="${pageContext.request.contextPath}/course_study/to_study.action?id=${hour.id }&source_id=${courseHourStudent.class_id}&source_type=${classType}&learn_id=${courseHourStudent.course_id}&user_study_id=${user_study_id}"
                                                </c:when>
                                                <c:otherwise>
                                                    href="${pageContext.request.contextPath}/course_study/to_study.action?id=${hour.id }&source_id=${courseHourStudent.class_id}&source_type=${classType}&learn_id=${courseHourStudent.course_id}&user_study_id=${user_study_id}&is_direct=1&trainType=${trainType }"
                                                </c:otherwise>
                                            </c:choose>
                                            class="discussOrHomework"  data-type="${hour.attribute_type}" data-id="${hour.id }" title="${hour.hour_title}" data-title="${hour.hour_title }">
                                        <c:if test="${hour.is_studyed==0 }"><i class="es-icon es-icon-undone color-primary status-icon"></i></c:if>
                                        <c:if test="${hour.is_studyed==2 }"><i class="es-icon es-icon-doing color-primary status-icon"></i></c:if>
                                        <c:if test="${hour.is_studyed==1 }"><i class="es-icon es-icon-done1 color-primary status-icon"></i></c:if>
                                        <span class="title">作业：${hour.hour_title}</span>
                                        <span class="course-type">
                                     <i class="es-icon es-icon-check" data-toggle="tooltip" title="作业"></i>
                                 </span>
                                    </a>
                                </li>
                            </c:if>
                        </c:forEach>
                    </ul>
                    <div class="lesson-about" id="homework_pane" style="display: none;">

                    </div>

                </div>

                <!--主题研讨-->
                <div  class="subject_discuss panel_index"  style="display: none;">
                    <h5 style="margin:15px;">主题研讨&nbsp;&nbsp;共计&nbsp;&nbsp;<span class="text-danger">20</span>&nbsp;&nbsp;个人参加</h5>
                    <ul class="period-list" id="discuss-item-list" >
                        <c:forEach items="${hourList}" var="hour" varStatus="status">
                            <c:if test="${hour.attribute_type==3}">
                                <li class="period lesson-item homeworkList" id="homeworkList${status.index+1}">
                                    <a
                                            <c:choose>
                                                <c:when test="${empty trainType&&(isTeacher==1&&isPreview==1) }">
                                                    href="${pageContext.request.contextPath}/course_study/to_study_preview.action?id=${hour.id }&source_type=${classType}&learn_id=${learnId}"
                                                </c:when>
                                                <c:when test="${empty trainType&&isPreview!=1 }">
                                                    href="${pageContext.request.contextPath}/course_study/to_study.action?id=${hour.id }&source_id=${courseHourStudent.class_id}&source_type=${classType}&learn_id=${courseHourStudent.course_id}&user_study_id=${user_study_id}"
                                                </c:when>
                                                <c:otherwise>
                                                    href="${pageContext.request.contextPath}/course_study/to_study.action?id=${hour.id }&source_id=${courseHourStudent.class_id}&source_type=${classType}&learn_id=${courseHourStudent.course_id}&user_study_id=${user_study_id}&is_direct=1&trainType=${trainType }"
                                                </c:otherwise>
                                            </c:choose>
                                            class="discussOrHomework"  data-type="${hour.attribute_type}" data-id="${hour.id }" title="${hour.hour_title}">
                                        <c:if test="${hour.is_studyed==0 }"><i class="es-icon es-icon-undone color-primary status-icon"></i></c:if>
                                        <c:if test="${hour.is_studyed==2 }"><i class="es-icon es-icon-doing color-primary status-icon"></i></c:if>
                                        <c:if test="${hour.is_studyed==1 }"><i class="es-icon es-icon-done1 color-primary status-icon"></i></c:if>
                                        <span class="title">讨论：${hour.hour_title}</span>
                                        <span class="course-type">
                                     <i class="es-icon es-icon-graphicclass" data-toggle="tooltip" title="作业"></i>
                                 </span>
                                    </a>
                                </li>
                            </c:if>
                        </c:forEach>
                    </ul>
                    <div class="lesson-about" id="discuss_pane" style="display: none;">

                    </div>

                </div>
            </div>
        </div>

        <div class="toolbar-nav">

            <ul class="toolbar-nav-stacked" id="lesson-toolbar-primary">
                <li class="active list">
                    <a href="#"><span class="glyphicon glyphicon-th-list"> </span>目录</a>
                </li>
                <li class="questions">
                    <a href="#"><span class="glyphicon glyphicon-question-sign"> </span>问答</a>
                </li>
                <li class="notes">
                    <a href="#"><span class="glyphicon glyphicon-edit"> </span>笔记</a>
                </li>
                <li class="data">
                <a href="#"><span class="glyphicon glyphicon-download-alt"> </span>资料</a>
                </li>
                <li class="homework">
                    <a href="#"><span class="glyphicon glyphicon-list-alt"> </span>作业</a>
                </li>
                <li class="discuss">
                    <a href="#"><span class="glyphicon glyphicon-list-alt"> </span>主题研讨</a>
                </li>
            </ul>

            <%--<ul class="toolbar-nav-stacked" id="lesson-toolbar-secondary">--%>
            <%--<li class="hide-pane" >--%>
            <%--<a href="javascript:"><span class="glyphicon glyphicon-chevron-left"></span></a>--%>
            <%--</li>--%>
            <%--</ul>--%>

        </div>
    </div>

</div>


<!--评价-->
<div id="user_comment" class="modal in" aria-hidden="false" data-backdrop="static" style="display: none;" >
    <div class="modal-dialog ">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">评价</h4>
            </div>
            <div class="modal-body">
                <input type="hidden" name="score" value="${user_appraise.score}" id="score_value">
                <c:if test="${!empty user_appraise}">
                    <h4 class="text-info">您已经评价过了！</h4><br/>
                </c:if>
                <c:if test="${empty user_appraise}">
                    <h4 class="text-info">亲，该课程对你有帮助吗？快来评个分吧！</h4><br/>
                    <div class="evaluation_again_content">
                        <span>请打分&nbsp;:</span>
                        <img class="score_star"
                             src="${pageContext.request.contextPath}/frontstage/images/score_star_icon_black.png"
                             name="${pageContext.request.contextPath}/frontstage/images/" title="很差">
                        <img class="score_star"
                             src="${pageContext.request.contextPath}/frontstage/images/score_star_icon_black.png" title="较差"
                             name="${pageContext.request.contextPath}/frontstage/images/">
                        <img class="score_star"
                             src="${pageContext.request.contextPath}/frontstage/images/score_star_icon_black.png" title="还行"
                             name="${pageContext.request.contextPath}/frontstage/images/">
                        <img class="score_star"
                             src="${pageContext.request.contextPath}/frontstage/images/score_star_icon_black.png" title="推荐"
                             name="${pageContext.request.contextPath}/frontstage/images/">
                        <img class="score_star"
                             src="${pageContext.request.contextPath}/frontstage/images/score_star_icon_black.png" title="力荐"
                             name="${pageContext.request.contextPath}/frontstage/images/">
                        <br>
                        <div class="comment_content" style="margin-top: 20px;">
                            <c:forEach items="${appraiseReasonViews }" var="reason">
                                <button type="button" class="btn btn-default" data-reason="${reason.id }">${reason.title }(${reason.count })</button>
                                <span class="mlm mrm text-muted"></span>
                            </c:forEach>
                        </div>
                        <div class="form-group controls" style="margin-top: 20px;">
                            <textarea class="form-control" rows="8" name="appraise_content" id="appraise_content"></textarea>
                            <div class="help-block" style="display:none;"></div>
                        </div>


                        <div class="form-group clearfix pull-right">
                            <a class="btn btn-link pull-right">取消</a>
                            <button class="btn btn-primary pull-right" id="appraise_button" type="button" <c:if test="${isTeacher==1&&isPreview ==1}">disabled="disabled"</c:if>>发表</button>

                        </div>
                    </div>
                </c:if>

            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function(){
        if("${courseHour.hour_type }"==="0" || "${courseHour.hour_type }"==="2"){
            initvideo();
        }else if("${courseHour.hour_type }"==="1"){
            initdoc();
        }

        $("#userDiscussBody").perfectScrollbar();
        <%--
        var profileVal = $("input[name='profile']").val();
        //给JMEditor赋值
        var editor = CKEDITOR.replace("profile", {
            skin : "moono-lisa",
            height : 400,
            width : 350,
            margin : "0,0,0,0",
            resize_enabled : false,
            toolbar :
                [
                    ['Bold','Italic','Strike','-','RemoveFormat','PasteText','-','NumberedList','BulletedList'
                        ,'-','Link','Unlink','Image','-','Source']
                ]
        });
        if (profileVal != '') {
            //editor.setData(profileVal);
            weditor.txt.html(profileVal);
        }
        --%>
        <%--
        var editor1 = CKEDITOR.replace("profile1", {
            skin : "moono-lisa",
            height : 200,
            margin : "0,0,0,0",
            resize_enabled : false,
            toolbar :
                [
                    ['Bold','Italic','Strike','-','RemoveFormat','PasteText','-','NumberedList','BulletedList'
                        ,'-','Link','Unlink','Image','-','Source']
                ]
        });
        --%>
        /* 视频初始化 */
        function initvideo(){
            //创建XMLHttpRequest对象
            var xhr = new XMLHttpRequest();
            //配置请求方式、请求地址以及是否同步
            xhr.open('POST', '${pageContext.request.contextPath}/course_study/read_video.action?id=${courseFile.id }', true);
            //设置请求结果类型为blob
            xhr.responseType = 'blob';
            //请求成功回调函数
            xhr.onload = function(e) {
                if (this.status == 200) {//请求成功
                    //获取blob对象
                    var blob = this.response;
                    if("${courseHour.hour_type }"==="0"){
                        //获取blob对象地址，并把值赋给容器
                        $("#video_source").attr("src", URL.createObjectURL(blob));
                    }else{
                        //音频
                        $("#audio_player1").attr("src", URL.createObjectURL(blob));
                        $("#audio_player2").attr("src", URL.createObjectURL(blob));
                    }
                }
            };
            xhr.send();
        }

        /* 文档初始化 */
        function initdoc(){
            var d_path="${courseFile.path }";
            $("#doc_container").html("");
            $.ajax({
                type:'get',
                url:"${pageContext.request.contextPath}/userFile/get_dcs.action?path="+d_path,
                dataType:'json',
                success:function(response){
                    var iframe_txt='<iframe src="'+response.path+'" frameborder=0 width=100% height=500 style="margin-top: 20px;" allowfullscreen></iframe>'
                    $("#doc_container").html(iframe_txt);
                }
            });
        }

        $(".chapter").click(function() {
            var $icon=$(this).find(".period-show .es-icon");
            var list = $(this).attr("id");
            if ($icon.hasClass('es-icon-remove')) {
                $icon.removeClass('es-icon-remove').addClass('es-icon-anonymous-iconfont');
            } else {
                $icon.removeClass('es-icon-anonymous-iconfont').addClass('es-icon-remove');
            }
            $(".period").each(function() {
                var section = $(this).attr("id");
                if (section.indexOf(list) > 0) {
                    if ($(this).css("display") == "none") {
                        $(this).show();
                    } else {
                        $(this).hide();
                    }
                }
            });
        });

        $(".learning_states").click(function(){
            var status;
            var box=$("#learning_box");
            if(box.hasClass('glyphicon-check')){
                status=0;
            }else{
                status=1;
            }
            $.ajax({
                url : '${pageContext.request.contextPath}/course_study/studyed.action',
                data : {
                    id : '${courseHourStudent.id}',
                    is_studyed:status,
                    user_study_id:'${user_study_id}',
                },
                dataType : 'json',
                success : function(response) {

                    if(response.status==0){
                        box.removeClass("glyphicon-check").addClass("glyphicon-unchecked");
                    }
                    if(response.status==1){
                        box.removeClass("glyphicon-unchecked").addClass("glyphicon-check");
                    }
                    location.replace(location.href);
                }
            });

        });
        //提问
        $("#question_input").click(function(){
            var $class=$(".detail-form-group");
            $class.each(function() {
                if($(this).is(".hide")){
                    $(this).removeClass("hide");
                }
            });

        });
        $(document).on('click',".back-to-list",function(){

            $("#show-pane").hide();
            $("#list-pane").show();

        });

        $("#question_quit").click(function(){
            var $class=$(".detail-form-group");
            $class.each(function() {
                if(!$(this).is(".hide")){
                    $(this).addClass("hide");
                }
            });

        });

        $("#question_button").click(function() {
            var title = $("#question_input").val();
            //var question_content = editor1.getData();
            var question_content = weditor1.txt.html();
            var  classType='${classType}';
            if (title == "") {
                alert("请输入标题!");
                return false;
            } else if (question_content == ""||question_content==="<p><br></p>") {
                alert("请输入内容!");
                return false;
            } else {

                $.ajax({
                    url : '${pageContext.request.contextPath}/topic_question/put_question.action',
                    data : {
                        title : title,
                        question_content : question_content,
                        source_id : '${courseHour.course_id}',
                        course_hour_id:'${courseHour.id}',
                        source_type:classType,
                        class_id : '${class_id}'
                    },
                    dataType : 'json',
                    success : function(response) {
                        var $class=$(".detail-form-group");
                        $class.each(function() {
                            if(!$(this).is(".hide")){
                                $(this).addClass("hide");
                            }
                        });

                        if (response.flag == 1) {
                            $("#question_input").val("");
                            //editor1.setData("");
                            weditor1.txt.clear();
                            var myDate=new Date();
                            myDate.setTime(response.topicQuestion.question_time.time);
                            var year=myDate.getFullYear();
                            var month=myDate.getMonth()+1;
                            var date=myDate.getDate();
                            var hour=myDate.getHours();
                            var minute=myDate.getMinutes();
                            var second=myDate.getSeconds();
                            var time=year+"-"+month+"-"+date+" "+hour+":"+minute+":"+second;
                            var str='<li class="media thread-item" ><div class="media-body thread-item-body"><div class="title mbm"><a href="javascript:return false" onclick="questionClick('+response.topicQuestion.id+')" class="show-question-item">'+response.topicQuestion.title+
                                '</a></div><div class="metas"><a class="link-dark ">'+response.topicQuestion.user.username
                                +'</a> 发表于'+time+'<span class="bullet"> • </span><a href="#">0回答</a></div></div></li>';
                            if($(".mtl>.empty-item").length > 0){
                                $(".mtl").prepend(str);
                                $(".mtl>.empty-item").remove();
                            }else{

                                $(str).insertBefore(".mtl>li:first");
                            }
                        }

                    }
                });

            }

        });
        $(document).on('click',"#answer_button",function(){
            var answer_content = $("#post_content").val();
            var question_id=$("#post_content").data("id");
            if (answer_content == "") {
                alert("请输入内容!");
                return false;
            } else {

                $.ajax({
                    url : '${pageContext.request.contextPath}/topic_question/put_answer.action',
                    data : {

                        answer_content : answer_content,
                        question_id : question_id
                    },
                    dataType : 'json',
                    success : function(response) {

                        questionClick(question_id);

                    }
                });
            }

        });
        //笔记
        $(".save_notes").click(function(){
            var status;
            var box=$("#share");
            //var note_content = editor.getData();
            var note_content = weditor.txt.html();
            if(box.prop('checked')){
                status=1;
            }else{
                status=0;
            }
            if(note_content==""||note_content==="<p><br></p>"){
                alert("请输入内容");
                return false;

            }
            $.ajax({
                url : '${pageContext.request.contextPath}/course_note/getNote.action',
                data : {
                    note_content:note_content,
                    is_share : status,
                    course_id:'${courseHour.course_id}',
                    course_hour_id : '${courseHour.id}'
                },
                dataType : 'json',
                success : function(response) {
                    alert("保存成功!");

                }
            });

        });

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
                },
                dataType : 'json',
                success : function(response) {
                    location.replace(location.href);
                }
            });

        });

        $(".discussOrHomework").click(function(){
            var type=$(this).data("type");
            var id=$(this).data("id");
            var title=$(this).data("title");
            $(".homework-pane").find("h5").html(title);
            course_hour_id=id;
            if(type==4){
                $.ajax({
                    url : '${pageContext.request.contextPath}/course_study/get_homework.action',
                    data : {
                        id : id,
                        class_id:'${class_id}',
                        user_study_id:'${user_study_id}',
                    },
                    dataType : 'json',
                    success : function(response) {
                        var homeworkCount=response.homeworkCount;
                        var examStatus=response.examStatus;
                        var homeworkId=response.homeworkId;
                        var courseId=response.courseId;
                        var class_id=response.class_id;
                        $(".homework").addClass("active").siblings().removeClass("active");
                        var index=$(".homework").index();
                        $("#homework_pane").show();
                        $("#homework-item-list").hide();
                        $("#homework_pane").html("");
                        var page1=('共<span id="homeworkCount">'+homeworkCount+'</span>个作业题');
                        $("#homework_pane").append(page1);
                        var page2="";
                        if(examStatus!=1){
                            page2='<a href="${pageContext.request.contextPath}/exam/to_homework.action?id='+homeworkId+'&courseId='+courseId+'&tab=2&class_id=${class_id}&user_study_id=${user_study_id}" class="btn btn-primary btn-sm mlm" target="_blank">';
                            if(examStatus==-1){
                                page2+='开始做题</a>';
                            }
                            if(examStatus==0){
                                page2+='继续做题</a>';
                            }
                            if(examStatus==2){
                                page2+='查看结果</a>';
                            }
                        }else{
                            page2+=',作业批改中....';
                        }
                        $("#homework_pane").append(page2);

                        $(".panel_index").hide().eq(index).show();
                    }
                });

            }

        });

    });
    var startTimeFirst;//第一次开始时间
    var startTime;//每一次开始时间
    var endTime;//每一次结束时间，含暂停
    var duration=0;//视频时长
    var studyTime=0;//学习时间

    $(window).unload(function (){
        if("${isPreview }"!=='1'){
            endTime  = new Date();
            var time=endTime.getTime()-startTime.getTime();

            studyTime+=time;


            var dura=parseInt(duration+"");
            $.ajax({
                async: false,
                url : '${pageContext.request.contextPath}/user_study_time/ajax_insert.action',
                data : {
                    course_hour_id : '${courseHourStudent.course_hour_id}',
                    start:startTimeFirst,
                    class_id:'${class_id}',
                    study_time:studyTime,
                    duration:dura,
                },
                dataType : 'json',
                success : function(response) {

                }
            });
        }
    });

    function playing(){
        var status;

        var a=document.getElementById("example_video_1");
        startTime  = new Date();
        //改
        if(startTime!=null){
            startTimeFirst=startTime.getTime();
        }

        duration=a.duration*1000;

        var box=$("#learning_box");
        if('${courseHourStudent.is_studyed}'!=0){
            return false;
        }else{
            status=2;
        }
        if("${isPreview }"!=='1'){
            $.ajax({
                url : '${pageContext.request.contextPath}/course_study/studyed.action',
                data : {
                    id : '${courseHourStudent.id}',
                    is_studyed:status,
                    user_study_id:'${user_study_id}',
                },
                dataType : 'json',
                success : function(response) {

                }
            });
        }
    }
    function end(){
        if("${isPreview}"!=='1'){
            var status;
            endTime  = new Date();
            var time=endTime.getTime()-startTime.getTime();

            studyTime+=time;

            var box=$("#learning_box");
            var dura=parseInt(duration+"");
            $.ajax({
                url : '${pageContext.request.contextPath}/user_study_time/ajax_insert.action',
                data : {
                    course_hour_id : '${courseHourStudent.course_hour_id}',
                    start:startTimeFirst,
                    class_id:'${class_id}',
                    study_time:studyTime,
                    duration:dura,
                },
                dataType : 'json',
                success : function(response) {
                    if('${courseHourStudent.is_studyed}'==1){
                        return false;
                    }else{
                        status=1;

                        $.ajax({
                            url : '${pageContext.request.contextPath}/course_study/studyed.action',
                            data : {
                                id : '${courseHourStudent.id}',
                                is_studyed:status,
                                user_study_id:'${user_study_id}',
                            },
                            dataType : 'json',
                            success : function(response) {

                                if(response.status==0){
                                    box.removeClass("glyphicon-check").addClass("glyphicon-unchecked");
                                }
                                if(response.status==1){
                                    box.removeClass("glyphicon-unchecked").addClass("glyphicon-check");
                                }
                            }
                        });
                    }
                }
            });
        }
    }
    function pause1(){
        return;
        endTime  = new Date();
        var time=endTime.getTime()-startTime.getTime();
        studyTime+=time;
        var newTime=new Date(time);
    }

    function questionClick(id){
        $("#list-pane").hide();
        $("#show-pane").html("");
        $.ajax({
            url : '${pageContext.request.contextPath}/topic_question/read_question_ajax.action',
            data : {
                id:id
            },
            dataType : 'json',
            success : function(response) {
                var topicQuestion=response.topicQuestion;
                var page='<div class="lesson-plugin-pane lesson-question-plugin-pane"><div class="lesson-question-plugin-pane-header clearfix">';
                page+='<a  class="btn btn-default back-to-list">返回</a><h4>'+topicQuestion.user.username+'的问题</h4></div>';
                page+='<div class="lesson-question-plugin-pane-thread"><h5><a href="#" target="_blank">'+topicQuestion.title+'</a></h5>';
                page+='<div class="lesson-question-plugin-pane-thread-content editor-text"><p>'+topicQuestion.question_content+'</p></div></div>';
                page+='<div class="lesson-question-plugin-pane-posts"><div class="posts-header"><h5><span data-role="post-number">'+response.topicAnswers.length+'</span> 回答</h5></div></div>';
                page+='<ul data-role="post-list" class="posts">';
                for(var i=0;i<response.topicAnswers.length;i++){
                    var topicAnswer=response.topicAnswers[i];

                    var myDate=new Date();
                    myDate.setTime(topicAnswer.answer_time.time);
                    var year=myDate.getFullYear();
                    var month=myDate.getMonth()+1;
                    var date=myDate.getDate();
                    var hour=myDate.getHours();
                    var minute=myDate.getMinutes();
                    var second=myDate.getSeconds();
                    var time=year+"-"+month+"-"+date+" "+hour+":"+minute+":"+second;
                    var str='<li class="post-item"><div class="post-item-heading clearfix"><img src="${pageContext.request.contextPath}'+topicAnswer.user.icon+'" class="avatar">'+
                        '<div class="infos"><div class="nickname"><a href="javascript:return false" class="nickname">'+topicAnswer.user.username+'</a>'+
                        '</div><div class="time">'+time+'</div></div></div><div class="post-item-body">'+topicAnswer.answer_content+'</div></li>';
                    page+=(str);//
                }
                page+='</ul><form class="post-form" data-role="post-form" method="post" action="" novalidate="novalidate" data-widget-cid="widget-12">';
                page+='<div class="form-group"><div class="controls">';
                page+='<textarea id="post_content" class="form-control" name="post_content" data-id="'+topicQuestion.id+'"></textarea>';
                page+='<div class="help-block" style="display:none;"></div></div></div>';
                page+='<div class="form-group"><div class="controls clearfix">' ;
                page+='<button type="button" class="btn btn-primary pull-right" id="answer_button">添加答案</button></div></div>';
                page+='</form></div>';
                $("#show-pane").append(page);
                $("#show-pane").show();
            }
        });

    }



    $(function () {

        $(".comment_content>button").each(function () {

            if($(this).is(".btn-success")){
                return false;
            }else{
                $(this).removeClass("btn-default").addClass("btn-success");
                return false;
            }
        });

        $(".comment_content>button").click(function () {
            if($(this).is(".btn-default")){
                $(this).removeClass("btn-default").addClass("btn-success");
            }else if($(this).is(".btn-success")){
                if($(".comment_content>.btn-success").length==1){
                    alert("必须有一个评价项");
                    return false;
                }
                $(this).removeClass("btn-success").addClass("btn-default");
            }else {
                return false;
            }
        })
    })
    /**
     *评分
     */
    $(".score_star").click(function() {
        var star = "score_star_icon.png";
        var black = "score_star_icon_black.png";
        var name = $(this).attr("name");
        $(this).prevAll().attr("src", name + star);
        $(this).attr("src", name + star);
        $(this).nextAll().attr("src", name + black);
        $("#score_value").val($(this).prevAll().length);
    });
    $("#appraise_button").click(
        function() {

            var score = $("#score_value").val();
            if (score == "") {
                alert("请打分");
                return false;
            }
            var content = $("#appraise_content").val();
            if (content == "") {
                alert("请评论");
                return false;
            }
            var reason="";
            $(".comment_content>.btn-success").each(function () {

                reason+=$(this).data("reason");
                reason+=",";
            });

            $.ajax({
                url : '${pageContext.request.contextPath}/user_appraise/appraise.action',
                data : {
                    appraise_content : content,
                    score : score,
                    id : $(this).val(),
                    source_id : '${courseHour.course_id}',
                    source_type : 0,
                    reason:reason,
                },
                dataType : 'json',
                success : function(response) {


                    location.replace(location.href);
                }
            });
        });
    //收藏
    function doCollect(){

        var source_id='${courseHourStudent.class_id}';
        var source_type='${classType}';
        var learn_id='${courseHourStudent.course_id}';
        $.ajax({
            url : '${pageContext.request.contextPath}/user_collect/collect.action',
            data : {
                learn_id : learn_id,
                source_id : source_id,
                source_type : source_type,
            },
            dataType : 'json',
            success : function(response) {
                if(response.msg==1){

                }
                if(response.msg==2){

                }
                //  window.location.reload();
            }
        });

    }
</script>

