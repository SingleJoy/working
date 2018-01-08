<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<link  href="${pageContext.request.contextPath}/frontstage/css/teaching-center.css" rel="stylesheet">

<div class="cn-wrap" >

    <!--全部-->
    <section class="course-list-section " >

        <div class="container">

            <div class="course_page" >

                <div class="media" style="margin: 50px 0;">
                    <a class="pull-left" href="javascript:void(0);">
                        <img class="media-object  avatar-lg" src="${pageContext.request.contextPath}${user.icon }"  >
                    </a>
                    <div class="media-body" style="padding-left:30px;">

                        <div class="teacher_intro text-muted pull-right" >
                            <span>
                                <span class="mlm mrm"></span>
                                <span class="mlm mrm"></span>
                                ${userInfo.profile }
                            </span>
                        </div>

                        <div class="media-heading">
                            <span class="teacher_name">${user.username }</span>
                            <div style="margin-top: 10px;color: #fff;"> ${userInfo.signature }</div>
                            <div style="margin-top: 10px;color: #fff;">
                                <button type="button" class="btn btn-default  follow-btn" data-user="${user.id }">关注</button>

                                <span class="mlm mrm"></span>

                                <%--<button type="button" class="btn btn-default btn-sm unfollow-btn" >已关注</button>--%>

                                <a class="btn btn-success" href="#private-modal" data-toggle="modal" onclick="send_private_messages(${user.id },'${user.username }')">私信</a>

                            </div>

                        </div>


                    </div>

                </div>


            </div>

        </div>

    </section>


    <div class="container" style="margin-top: 20px;padding: 0;">

        <div class="panel">
            <div class="teacher_index_banner pull-right"></div>
            <div class="panel-body" style="padding-bottom: 0;">

                <div class="nav-btn-tab teachers_info_tabs" style="margin-top: 20px;border: none;margin-bottom: 0;">

                    <ul class="nav nav-tabs" style="margin-top: 20px;">
                        <li <c:if test="${teacherCenterView.stamp==0 }">class="active"</c:if>><a href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?stamp=0&user_id=${teacherCenterView.user_id}">课程</a></li>
                        <li <c:if test="${teacherCenterView.stamp==1 }">class="active"</c:if>><a href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?stamp=1&user_id=${teacherCenterView.user_id}">培训</a></li>
                        <li <c:if test="${teacherCenterView.stamp==2 }">class="active"</c:if>><a href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?stamp=2&user_id=${teacherCenterView.user_id}">课例</a></li>
                        <%--<li <c:if test="${teacherCenterView.stamp==3 }">class="active"</c:if>><a href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?stamp=3&user_id=${teacherCenterView.user_id}">话题</a></li>--%>
                        <li <c:if test="${teacherCenterView.stamp==4 }">class="active"</c:if>><a href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?stamp=4&user_id=${teacherCenterView.user_id}">关注的人</a></li>
                    </ul>

                </div>
            </div>

        </div>


    </div>


    <div class="container container_background" style="min-height: 450px;">


        <div class="course-list clearfix " style="margin-top:20px;">

            <!-- 课程 -->
            <div class="teachers-course-tabs " style=<c:if test="${teacherCenterView.stamp!=0 }">"display: none;"</c:if>>

                <div class="teacher_index_info_tabs">
                    <ul>
                        <li <c:if test="${teacherCenterView.type==0 }">class="active"</c:if>>
                            <a href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?stamp=0&type=0&user_id=${teacherCenterView.user_id}">
                                <br/>创<br/>建<br/>的<br/>课<br/>程<br/><br/><br/>
                                <c:if test="${teacherCenterView.type==0 }"><span class="triangle-topright"></span></c:if>
                            </a>
                        </li>
                        <li <c:if test="${teacherCenterView.type==1 }">class="active"</c:if>>
                            <a href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?stamp=0&type=1&user_id=${teacherCenterView.user_id}">

                                <c:if test="${teacherCenterView.type==1 }"><span class="triangle-topleft"></span><br/></c:if>
                                参<br/>与<br/>的<br/>课<br/>程<br/><br/>

                            </a>

                        </li>
                    </ul>
                </div>

                <%--课程列表--%>
                <div class="teacher_content_page">


                    <c:forEach items="${courseList}" var="course">

                        <div class="teacher_content_page_list">

                            <div class="teacher_index_line_info">

                                <div class="teacher_index_line"></div>
                                <span class="pull-left">${course.create_time }</span>

                            </div>

                            <div class="course_info">
                                <div class="media media_content" >
                                    <a class="media-left" href="${pageContext.request.contextPath}/user_study/to_course_study.action?page=1&learnId=${course.id }&sourceType=0&tab=-1&is_direct=0">
                                        <img class="media-object" src="${pageContext.request.contextPath}${course.img }" style="width: 200px;height: 150px;">
                                        <c:if test="${!empty course.classifyName }">
                                            <span class="content_tag">${course.classifyName }</span>
                                        </c:if>

                                    </a>
                                    <div class="media-body" style="margin-left: 20px;">
                                        <h2 class="media-heading">${course.title }</h2>
                                        <div style="margin-top:10px;">
                                            <span class="course-price-widget">
                                                <c:choose>
                                                    <c:when test="${course.price>0 }">
                                                        <%--收费--%>
                                                        <span class="price"> ￥${course.price }</span>
                                                    </c:when>
                                                    <c:when test="${course.price==0 }">
                                                        <%--免费--%>
                                                        <span class="text-success">免费</span>
                                                    </c:when>
                                                </c:choose>
                                            </span>

                                        </div>
                                        <div style="margin-top: 10px;">
                                           <span class="text-muted">
                                                <c:forEach begin="1" end="${course.score }">
                                                    <i class="es-icon es-icon-star color-warning"></i>
                                                </c:forEach>
                                                <c:forEach begin="1" end="${5-course.score }">
                                                    <i class="es-icon es-icon-star"></i>
                                                </c:forEach>
                                                &nbsp;&nbsp;
                                                <span class="text-danger">${course.appraiseNum }&nbsp;</span>条评价
                                            </span>
                                        </div>

                                        <div style="margin-top: 10px;">
                                            <span  class="text-muted">学习&nbsp;&nbsp;
                                                <span class="text-danger">
                                                    <c:if test="${empty  course.studentNum}">0</c:if>
                                                    <c:if test="${!empty  course.studentNum}">${course.studentNum }</c:if>
                                                </span>
                                                人
                                            </span>
                                            <span class="mlm mrm text-muted"></span>
                                            <span class="text-muted">收藏 &nbsp;&nbsp;
                                                <span class="text-danger">${course.collectNum }</span>
                                                人
                                            </span>
                                            <span class="mlm mrm text-muted"></span>

                                        </div>

                                    </div>
                                </div>

                            </div>
                        </div>

                    </c:forEach>
                </div>

            </div>

            <!-- 培训 -->
            <div class="teachers-course-tabs" style=<c:if test="${teacherCenterView.stamp!=1 }">"display: none;"</c:if>>

                <div class="teacher_index_info_tabs">
                    <ul>
                        <li <c:if test="${teacherCenterView.type==0 }">class="active"</c:if>>
                            <a href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?stamp=1&type=0&user_id=${teacherCenterView.user_id}">
                                <br/>创<br/>建<br/>的<br/>培<br/>训<br/><br/><br/>
                                <c:if test="${teacherCenterView.type==0 }"><span class="triangle-topright"></span></c:if>
                            </a>
                        </li>
                        <li <c:if test="${teacherCenterView.type==1 }">class="active"</c:if>>
                            <a href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?stamp=1&type=1&user_id=${teacherCenterView.user_id}">

                                <c:if test="${teacherCenterView.type==1 }"><span class="triangle-topleft"></span><br/></c:if>
                                参<br/>与<br/>的<br/>培<br/>训<br/><br/>

                            </a>

                        </li>
                    </ul>
                </div>

                <%--培训列表--%>
                <div class="teacher_content_page">

                    <c:forEach items="${trainList }" var="t">

                        <div class="teacher_content_page_list">

                            <div class="teacher_index_line_info">

                                <div class="teacher_index_line"></div>
                                <span class="pull-left">${t.create_time }</span>

                            </div>

                            <div class="course_info">
                                <div class="media media_content" >
                                    <a class="media-left" href="${pageContext.request.contextPath}/train/to_train_detail.action?id=${t.id }&sign=0">
                                        <img class="media-object" src="${pageContext.request.contextPath}${t.img }" style="width: 200px;height: 150px;">
                                        <c:if test="${!empty t.classifyName }">
                                            <span class="content_tag">${t.classifyName }</span>
                                        </c:if>
                                    </a>
                                    <div class="media-body" style="margin-left: 20px;">
                                        <h2 class="media-heading"> ${t.name }</h2>

                                        <div style="margin: 15px 0;">
                                            <span class="course-price-widget">
                                            <c:choose>
                                                <c:when test="${t.price>0 }">
                                                    <%--收费--%>
                                                    <span class="price"> ￥${t.price }</span>
                                                </c:when>
                                                <c:when test="${t.price==0 }">
                                                    <%--免费--%>
                                                    <span class="text-success">免费</span>
                                                </c:when>
                                            </c:choose>
                                            </span>
                                        </div>

                                        <div style="margin-top: 20px;">
                                            <span class="text-muted">

                                                 <c:forEach begin="1" end="${t.score }">
                                                    <i class="es-icon es-icon-star color-warning"></i>
                                                </c:forEach>
                                                <c:forEach begin="1" end="${5-t.score }">
                                                    <i class="es-icon es-icon-star"></i>
                                                </c:forEach>

                                                &nbsp;&nbsp;
                                                <span class="text-danger">${t.trainTotalAppraise}&nbsp;</span>条评价
                                            </span>
                                        </div>


                                        <div style="margin-top: 10px;">
                                             <span  class="text-muted">主办方&nbsp;&nbsp;
                                                <span class="text-danger">百年树人
                                                </span>
                                            </span>
                                            <span class="mlm mrm text-muted"></span>

                                            <span  class="text-muted">学习&nbsp;&nbsp;
                                                <span class="text-danger"><c:if test="${empty  t.studentNum}">0</c:if>
                                                    <c:if test="${!empty  t.studentNum}">${t.studentNum }</c:if>
                                                </span>人
                                            </span>
                                            <span class="mlm mrm text-muted"></span>
                                            <span class="text-muted">
                                                收藏 &nbsp;&nbsp; <span class="text-danger">${t.collectNum }</span>人
                                            </span>
                                            <span class="mlm mrm text-muted"></span>

                                        </div>


                                    </div>
                                </div>

                            </div>
                        </div>

                    </c:forEach>
                </div>


            </div>

            <!-- 课例 -->
            <div class="teachers-course-tabs" style=<c:if test="${teacherCenterView.stamp!=2 }">"display: none;"</c:if>>

                <div class="teacher_index_info_tabs">
                    <ul>
                        <li <c:if test="${teacherCenterView.type==0 }">class="active"</c:if>>
                            <a href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?stamp=2&type=0&user_id=${teacherCenterView.user_id}">
                                <br/>创<br/>建<br/>的<br/>课<br/>例<br/><br/><br/>
                                <c:if test="${teacherCenterView.type==0 }"><span class="triangle-topright"></span></c:if>
                            </a>
                        </li>
                        <li <c:if test="${teacherCenterView.type==1 }">class="active"</c:if>>
                            <a href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?stamp=2&type=1&user_id=${teacherCenterView.user_id}">

                                <c:if test="${teacherCenterView.type==1 }"><span class="triangle-topleft"></span><br/></c:if>
                                参<br/>与<br/>的<br/>课<br/>例<br/><br/>

                            </a>

                        </li>
                    </ul>
                </div>


                <%--课例列表--%>
                <div class="teacher_content_page">

                    <c:forEach items="${lessonList }" var="l">

                        <div class="teacher_content_page_list">

                            <div class="teacher_index_line_info">
                                <div class="teacher_index_line"></div>
                                <span class="pull-left">${l.create_time }</span>
                            </div>

                            <div class="course_info">
                                <div class="media media_content" >
                                    <a class="media-left" href="${pageContext.request.contextPath}/lesson_main/to_lesson.action?id=${l.id}">

                                        <img class="media-object " src="${pageContext.request.contextPath}/${l.lesson_pic}"  style="width: 200px;height: 150px;">

                                        <span class="content_tag">${l.grade}${l.subject}</span>

                                        <c:if test="${l.excellent==1}">
                                        <span class="lesson_lever text-center">
                                             &nbsp;&nbsp;优

                                        </span>
                                        </c:if>
                                    </a>
                                    <div class="media-body" style="margin-left: 20px;">
                                        <h2 class="media-heading"> ${l.name }</h2>


                                        <div style="margin-top: 20px;">
                                            <span class="text-muted">

                                               <c:forEach begin="1" end="${l.score }">
                                                    <i class="es-icon es-icon-star color-warning"></i>
                                                </c:forEach>
                                                <c:forEach begin="1" end="${5-l.score }">
                                                    <i class="es-icon es-icon-star"></i>
                                                </c:forEach>

                                                &nbsp;&nbsp;
                                                <span class="text-danger">${l.lessonTotalAppraise}&nbsp;</span>条评价
                                            </span>
                                        </div>
                                        <div class="progress" style="height: 18px;background-color: #eaeaea;padding: 0;margin-top: 15px;width: 280px;">
                                            <c:if test="${l.finish_count/l.all_count>=0.21 }">
                                                <c:set var="width" value="${s.finish_count/s.all_count }"></c:set>
                                            </c:if>
                                            <c:if test="${l.all_count==0||l.finish_count/l.all_count<0.21 }">
                                                <c:set var="width" value="0.30"></c:set>
                                            </c:if>
                                            <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="20" aria-valuemin="30" aria-valuemax="100" style="width:<fmt:formatNumber value="${width*100}" pattern="##.#"/>%">
                                                <span class="text-center">完成：${l.finish_count}/${l.all_count}</span>
                                            </div>

                                        </div>

                                        <div style="margin-top:10px;">
                                             <span class="text-muted">
                                                收藏&nbsp;&nbsp; <span class="text-danger">${l.collectNum }</span>人
                                            </span>
                                            <span class="mlm mrm text-muted"></span>

                                            <span class="text-muted">
                                                工作坊&nbsp;&nbsp;${l.workshop_name }
                                            </span>
                                            <span class="mlm mrm text-muted"></span>
                                            <span class="text-muted">
                                                组长&nbsp;&nbsp;${l.lesson_username }
                                            </span>
                                        </div>


                                    </div>
                                </div>

                            </div>
                        </div>

                    </c:forEach>
                </div>


            </div>

            <!-- 话题 -->
            <div class="teachers-course-tabs" style="<c:if test="${teacherCenterView.stamp!=3 }">display: none;</c:if> padding-top: 30px;">
                <c:forEach items="${topicQuestionViews }" var="question">
                    <div class="topic_list_page" style="margin-left: 50px;">
                        <div style="font-size: 20px;">
                            <a href="${pageContext.request.contextPath}/community/to_community_index.action?sourceType=${question.source_type-2}&classifyId=-1&stamp=6&id=${question.source_id}&questionId=${question.questionId }">${question.querstionName }</a>
                        </div>
                        <div style="font-size: 14px;margin: 10px;">发起时间: <fmt:formatDate type="date"  value="${question.question_time }" /></div>
                        <div style="margin-left: 20px;">

                            <div class="js-reviews">
                                <div class="media media-evaluate">

                                    <div class="media-body thread-post">
                                        <c:forEach items="${question.topicAnswers }" var="answer">
                                            <div class="content topic_content">
                                                <div class="full-content">
                                                    <span class="text-danger">${answer.user.username }:&nbsp;&nbsp;</span>
                                                        ${answer.answer_content }
                                                </div>
                                                <div class="topic_reply_time">回复时间:&nbsp;&nbsp;<fmt:formatDate type="date"  value="${answer.answer_time }" /></div>
                                            </div>
                                        </c:forEach>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- 关注和粉丝 -->
            <div class="teachers-course-tabs" style="<c:if test="${teacherCenterView.stamp!=4 }">display: none;</c:if> padding-top: 30px;">

                <div class="teacher_index_info_tabs">
                    <ul>
                        <li <c:if test="${teacherCenterView.type==0 }">class="active"</c:if>>
                            <a href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?stamp=4&type=0&user_id=${teacherCenterView.user_id}">
                                <br/> <br/>关<br/>注<br/><br/><br/><br/>
                                <c:if test="${teacherCenterView.type==0 }"><span class="triangle-topright"></span></c:if>
                            </a>
                        </li>
                        <li <c:if test="${teacherCenterView.type==1 }">class="active"</c:if>>
                            <a href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?stamp=4&type=1&user_id=${teacherCenterView.user_id}">

                                <c:if test="${teacherCenterView.type==1 }"><span class="triangle-topleft"></span><br/></c:if>
                                <br/> 粉<br/>丝<br/><br/><br/><br/>
                            </a>

                        </li>
                    </ul>
                </div>


                <div class="row" style="margin-left: 50px;">
                    <c:forEach items="${myAttention }" var="attent">
                        <div class="col-lg-3 col-md-4 col-xs-6 attent"  data-user="${attent.userId }">
                            <div class="teacher-item">
                                <div class="teacher-top">
                                    <a class="teacher-img" href="javascript:void(0);" style="height: 60px;display: inline-block;">
                                        <img class="avatar-md" src="${pageContext.request.contextPath}${attent.img}" style="height: 60px;">
                                    </a>
                                    <h3 class="title">
                                        <a class="link-dark" href="javascript:void(0);"> ${attent.realName }</a>
                                    </h3>
                                    <div class="position" >

                                        &nbsp; &nbsp;${attent.titles }

                                    </div>
                                </div>

                                <div class="teacher-bottom">
                                    <div class="about">

                                        <c:if test="${!empty attent.school }">${attent.school }</c:if>
                                        <c:if test="${empty attent.school }">
                                            <span class="empty">暂无头衔</span>
                                        </c:if>
                                    </div>
                                    <div class="metas" style="left: 0;right:0;">
                                        <a class="btn btn-primary btn-sm follow-btn" href="javascript:;"  style="display:none;"  data-user="${attent.userId }">关注</a>
                                        <a class="btn btn-default btn-sm unfollow-btn" href="javascript:;"  >已关注</a>
                                        <a class="btn btn-default btn-sm"  href="#private-modal" data-toggle="modal" onclick="send_private_messages(${attent.userId },'${attent.realName }')">私信</a>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

            </div>
            <div id="test" class="pager" ></div>
        </div>

    </div>




</div>






<form id="teacherForm" action="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action" method="post">

    <input type="hidden" name="rows" id="rows" value="${teacherCenterView.rows}"/>
    <input type="hidden" name="page" id="page" value="${teacherCenterView.page}"/>
    <input type="hidden" name="total" id="total" value="${teacherCenterView.total}" />
    <input type="hidden" name="stamp" id="stamp" value="${teacherCenterView.stamp}"/>
    <input type="hidden" name="type" id="type" value="${teacherCenterView.type}"/>
    <input type="hidden" name="user_id" id="user_id" value="${teacherCenterView.user_id}"/>
</form>
<script type="text/javascript">
    //翻页
    var total = $("#total").val();
    var page =  parseInt($("#page").val())+1;

    $("#btn5").on('click', function () {
        $("#div1").PageChanged(5);
    });

    $(".pager").pagination({
        thisPageIndex:page,
        recordCount: total,       //总记录数
        pageSize:  $("#rows").val(),            //一页记录数
        onPageChange: function (page) {
            document.title = page;
            $("#page").val(page-1);
            $('#teacherForm').submit();

        }
    });
    $(".attent").mouseover(function(){

        var id=$(this).data("user");
        var _this=$(this);

        $.ajax({
            url : '${pageContext.request.contextPath}/teacher_center/attent.action',
            data : {
                id : id,
            },
            dataType : 'json',
            success : function(response) {

                if (response.userAttent == 0) {
                    $(".follow-btn").show();
                    $(".unfollow-btn").hide();
                }
                if (response.userAttent == 1) {
                    _this.find(".unfollow-btn").show();
                    _this.find(".follow-btn").hide();
                }
            }
        });
    });
    $(".follow-btn").click(function () {
        var id=$(this).data("user");
        send_attent(id);
    });
</script>

<jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>