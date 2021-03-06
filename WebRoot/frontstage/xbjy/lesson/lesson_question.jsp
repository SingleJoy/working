<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>



<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/JMEditor/jmeditor/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/JMEditor/jmeditor/JMEditor.js"></script>

<script type="text/javascript"
        src="${pageContext.request.contextPath}/frontstage/js/My97DatePicker/WdatePicker.js"></script>
<link href="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.js"></script>

<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<div class="cn-wrap" >


    <div id="content-container" class="container">

        <jsp:include page="/frontstage/xbjy/lesson/lesson_header.jsp"></jsp:include>

        <div class="course-detail row" style="margin-top: 20px;">

            <jsp:include page="/frontstage/xbjy/lesson/lesson_left.jsp"></jsp:include>


            <div class="col-lg-9 col-md-8  course-detail-main">

                <c:if test="${(problemStudyView.purview==103&&lessonLeft.plan102==1)||(problemStudyView.purview==203&&lessonLeft.prepare201==1)||(problemStudyView.purview==303&&lessonLeft.class302==1)||(problemStudyView.purview==403&&lessonLeft.assessment401==1) }">
                    <div class="panel panel-default panel-col course-data">
                        <div class="panel-heading">
                            <c:if test="${problemStudyView.purview==103 }">计划:</c:if>
                            <c:if test="${problemStudyView.purview==203 }">备课:</c:if>
                            <c:if test="${problemStudyView.purview==303 }">上课:</c:if>
                            <c:if test="${problemStudyView.purview==403 }">评课:</c:if>
                            问题研讨</div>
                        <div class="panel-body">
                            <h4 style="margin-left: 30px;">研讨问题:
                                <c:if test="${problemStudyView.purview==103 }">${lessonProblemView.plan_que }</c:if>
                                <c:if test="${problemStudyView.purview==203 }">${lessonProblemView.prepare_que }</c:if>
                                <c:if test="${problemStudyView.purview==303 }">${lessonProblemView.class_que }</c:if>
                                <c:if test="${problemStudyView.purview==403 }">${lessonProblemView.assessment_que }</c:if>
                            </h4>
                            <h5 style="margin-left: 30px;margin-top: 20px;opacity: 0.8;">请您在本环节中对本课例确定的研究问题进行讨论：</h5>
                        </div>
                        <form id="" method="post" action="" novalidate="novalidate" >
                            <c:if test="${flag }">
                                <div class="form-group controls">
                                    <textarea class="form-control" rows="8"  placeholder="[请发表您的看法：]" id="comment"></textarea>
                                    <div class="help-block" style="display:none;"></div>
                                </div>

                                <div class="form-group clearfix">
                                    <a href="javascript:;" class="btn btn-warning pull-right js-btn-save" id="comment_btn">发布</a>
                                </div>
                            </c:if>
                            <c:if test="${empty  problemStudyViews}">
                                <div class="js-reviews" >
                                    <div class="media media-evaluate">
                                        <div class="media-left">
                                            <!--
                                            <h5 style="margin-left: 130px;margin-top: 30px;">暂无研讨</h5>
                                            -->
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <c:forEach items="${problemStudyViews }" var="view">
                                <div class="js-reviews" >
                                    <div class="media media-evaluate">
                                        <div class="media-left">
                                            <a class=" js-user-card" href="javascript:void(0);" >
                                                <img class="avatar-sm" src="${pageContext.request.contextPath}${view.icon }">

                                            </a>

                                        </div>
                                        <div class="media-body thread-post">
                                            <div class="title">
                                                <a class="link-dark " href="javascript:;">${view.username }</a>
                                                &nbsp;&nbsp;
                                                    ${fn:replace(view.update_time,'.0','')}
                                            </div>

                                            <div class="content">
                                                <!--注意:删除功能只有问题研讨管理员权限才显示,其他人员不在页面显示-->
                                                <c:if test="${flag }">
                                                    <c:if test="${currentUser.id==view.user_id }">
                                                        <a href="javascript:void(0);" class="text-warning pull-right delete_message" style="" data-id="${view.id }">删除</a>
                                                    </c:if>
                                                    <a href="javascript:void(0);" class="pull-right call_back" style="padding-right: 30px;" data-id="${view.id }" data-root_id="${view.id }" data-name="${view.username }" >回复</a>
                                                </c:if>
                                                <div class="full-content" >${view.comment }</div>

                                            </div>
                                            <c:forEach items="${view.sonView}" var="son">
                                                <div class="js-reviews" style="margin-top: 10px;">
                                                    <div class="media media-evaluate">
                                                        <div class="media-left">
                                                            <a class=" js-user-card" href="javascript:void(0);" >
                                                                <img class="avatar-sm" src="${pageContext.request.contextPath}${son.icon }">
                                                            </a>

                                                        </div>
                                                        <div class="media-body thread-post">
                                                            <div class="title">
                                                                <c:if test="${son.root_id==son.parent_id}">
                                                                    <a class="link-dark " href="javascript:;">${son.username }</a>
                                                                </c:if>
                                                                <c:if test="${son.root_id!=son.parent_id}">
                                                                    <a class="link-dark " href="javascript:;">${son.username } 回复 ${son.other_username }</a>
                                                                </c:if>
                                                                &nbsp;&nbsp;
                                                                    ${fn:replace(son.update_time,'.0','')}
                                                            </div>

                                                            <div class="content">
                                                                <!--注意:删除功能只有问题研讨管理员权限才显示,其他人员不在页面显示-->
                                                                
                                                                    <c:if test="${currentUser.id==son.user_id }">
                                                                        <a href="javascript:void(0);" class="text-warning pull-right delete_message" style="" data-id="${son.id }">删除</a>
                                                                    </c:if>
                                                                    <c:if test="${flag }">
                                                                    <a href="javascript:void(0);" class="pull-right call_back"  style="padding-right: 30px;"  data-id="${son.id }" data-root_id="${view.id }" data-name="${son.username }" >回复</a>
                                                                </c:if>
                                                                <div class="full-content" >${son.comment }</div>

                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>

                        </form>
                        <div id="test" class="pager" style="padding-top: 0;margin-bottom: 20px;"></div>
                        <form id="lessonForm" action="${pageContext.request.contextPath}/problem_study/to_problem.action" method="post">
                            <input type="hidden" name="page" id="page" value="${problemStudyView.page}"/>
                            <input type="hidden" name="rows" id="rows" value="${problemStudyView.rows}"/>
                            <input type="hidden" name="total" id="total" value="${problemStudyView.total}"/>
                            <input type="hidden" name="totalPage" id="totalPage" value="${problemStudyView.totalPage}"/>
                            <input type="hidden" name="lesson_id" id="lesson_id" value="${problemStudyView.lesson_id}"/>
                            <input type="hidden" name="purview" id="purview" value="${problemStudyView.purview}"/>
                            <input type="hidden" name="stamp" id="stamp" value="${stamp}"/>
                            <input type="hidden" name="state" id="state" value="${state}"/>
                        </form>
                    </div>
                </c:if>

                 <c:if test="${(problemStudyView.purview==103&&lessonLeft.plan102!=1)}">
                    <div class="panel panel-default panel-col">
                        <div class="panel-heading">计划:问题研讨</div>
                        <div class="panel-body" style="text-align: center;">
                            <img src="${pageContext.request.contextPath}/frontstage/images/lesson_task_unfinshed.png" >
                            <div>未提交教学设计与课件</div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${(problemStudyView.purview==203&&lessonLeft.prepare201!=1)}">
                    <div class="panel panel-default panel-col">
                        <div class="panel-heading">
                            备课:问题研讨
                        </div>
                        <div class="panel-body" style="text-align: center;">
                            <img src="${pageContext.request.contextPath}/frontstage/images/lesson_task_unfinshed.png" >
                            <div>未完成教学设计协同修改</div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${(problemStudyView.purview==303&&lessonLeft.class302!=1)}">
                    <div class="panel panel-default panel-col">
                        <div class="panel-heading">
                           上课:问题研讨
                        </div>
                        <div class="panel-body" style="text-align: center;">
                            <img src="${pageContext.request.contextPath}/frontstage/images/lesson_task_unfinshed.png" >
                            <div>未提交观课量表</div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${(problemStudyView.purview==403&&lessonLeft.assessment401!=1)}">
                    <div class="panel panel-default panel-col">
                        <div class="panel-heading">评课:问题研讨</div>
                        <div class="panel-body" style="text-align: center;">
                            <img src="${pageContext.request.contextPath}/frontstage/images/lesson_task_unfinshed.png" >
                            <div>未提交评课报告</div>
                        </div>
                    </div>
                </c:if>
            </div>

        </div>
    </div>

    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>

</div>
<!-- 回复消息楼中楼回复 -->
<div id="reply_message" class="modal" data-toggle="modal" style="display: none;">
    <div class="modal-dialog  modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"></h4>
            </div>
            <div class="modal-body">
                <form  method="post" action="" novalidate="novalidate" >

                    <div class="form-group controls">
                        <textarea class="form-control" rows="8"  placeholder="最多输入500字" id="comment_back"></textarea>
                        <div class="help-block" style="display:none;"></div>
                    </div>

                    <div class="form-group clearfix">
                        <a href="javascript:;" class="btn btn-warning pull-right js-btn-save" id="callback_btn">发布</a>
                    </div>

                </form>
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
                $('#lessonForm').submit();

            }
        });
    });
</script>
<c:if test="${flag }">
    <script type="text/javascript">
        $(function(){

            var root_id=0;
            var parent_id=0;

            $(".delete_message").on("click",function(){

                var id=$(this).data("id");
                $.ajax({
                    url : '${pageContext.request.contextPath}/problem_study/delete.action?id='+id,
                    dataType : 'json',
                    success : function(response) {
                        location.replace(location.href);
                    }
                });

            });
            $("#comment_btn").click(function(){
                var comment=$("#comment").val();
                if(comment==""){
                    alert("请输入评论");
                }else{
                    $.ajax({
                        async : false,
                        url : "${pageContext.request.contextPath}/problem_study/comment.action?comment="+comment+"&purview=${problemStudyView.purview}&lesson_id=${problemStudyView.lesson_id}",
                        dataType:'json',
                        success : function(response) {

                            location.replace(location.href);
                            $("#comment").val("");
                        }
                    });


                }

            });

            $(".call_back").click(function(){

                $("#reply_message").modal("show");
                root_id=$(this).data("root_id");
                parent_id=$(this).data("id");
                $(".modal-title").html($(this).data("name"));
            });
            $("#callback_btn").click(function(){
                var comment=$("#comment_back").val();
                if(comment==""){
                    alert("请输入评论");
                }else{
                    $.ajax({
                        async : false,
                        url : "${pageContext.request.contextPath}/problem_study/comment.action?comment="+comment+"&purview=${problemStudyView.purview}&lesson_id=${problemStudyView.lesson_id}",
                        dataType:'json',
                        data:{
                            root_id:root_id,
                            parent_id:parent_id,
                        },
                        success : function(response) {

                            location.replace(location.href);
                            $("#comment").val("");
                        }
                    });


                }

            });
        });

    </script>
</c:if>
