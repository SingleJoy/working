<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>



<div class="container">
    <div class="col-md-12 group-main">
        <div class="panel panel-default">
            <div class="panel-heading">
                <a href="${pageContext.request.contextPath}/community/to_community_index.action?sourceType=${communityCenterView.sourceType}&classifyId=-1&stamp=4&id=${communityCenterView.id}" class="btn btn-default pull-right">返回社区话题</a>
                <h3 class="panel-title">
                    ${topicQuestion.title }
                    <c:if test="${topicQuestion.stick==1}"><span class="label label-primary">置顶</span></c:if>
                    <c:if test="${topicQuestion.elite==1}"><span class="label label-danger">精华</span></c:if>
                </h3>

            </div>
            <div class="panel-body clearfix" style="margin-top: 10px;">
                <div class="well well-sm text-sm color-gray clearfix" style="line-height:20px">
                    <div class="cn-share dropdown pull-right">
                        <span class="cn-share top" style="font-size:14px;">
                        <!-- 
                            <a href="javascript:;" class="gray-dark" data-toggle="dropdown">
                                <i class="es-icon es-icon-share"></i> 分享
                            </a>
                            -->
                        </span>
                    </div>
                    <div class="pull-right mrm" id="thread-list">
                        <!--  
                            <a href="javascript:;" class="uncollect-btn link-dark"  >
                                <i class="es-icon es-icon-favorite mrs"></i> 已收藏</a>
                            <a href="javascript:;" class="collect-btn link-dark" style="display: none;">
                                <i class="es-icon es-icon-favoriteoutline mrs"></i>收藏
                            </a>
                            -->
                    </div>
                    发表于<fmt:formatDate type="date"  value="${topicQuestion.question_time }" />
                    <span class="mll"> ${topicQuestion.watch_times }次查看</span>
                </div>
                <div class="editor-text">
                    ${topicQuestion.question_content }
                    <br>
                </div>


                <div class="mtl text-right">
                    <c:if test="${is_teacher }">
                        <a class="btn btn-default btn-sm mrm" href="javascript:void(0);" id="stick"><c:if test="${topicQuestion.stick==1}">取消</c:if>置顶</a>

                        <a type="button" class="btn btn-default btn-sm mrm" href="javascript:void(0);" id="elite" ><c:if test="${topicQuestion.elite==1}">取消</c:if>加精</a>
                    </c:if>
                </div>
            </div>
        </div>

        <div class="panel panel-default group-post-list">
            <div class="panel-heading">
                ${topicAnswersCount }回复
            </div>
            <div class="panel-body">
                <ul class="media-list">
                    <c:forEach items="${topicAnswers }" var="answer"  varStatus="status">
                        <li  class="media">
                            <a href="javascript:void(0);" class="pull-left"><img src="${pageContext.request.contextPath}${answer.user.icon }" class="avatar-sm"></a>
                            <div class="media-body">
                                <div class="metas ">
                                
                                    <span class="floor pull-right">
                                     ${status.count }楼
                                  </span>
                                    <strong>
                                        <a class="link-dark " href="javascript:void(0);">${answer.user.username }</a>
                                    </strong>
                                    <span class="divider mhm">•</span>
                                    <span><fmt:formatDate type="date"  value="${answer.answer_time }" /> </span>
                                </div>

                                <div class="content editor-text">
                                        ${answer.answer_content }
                                </div>
                            </div>

                        </li>
                    </c:forEach>
                </ul>


            </div>
        </div>


        <div class="panel panel-default">
            <div class="panel-heading">发表回复</div>

            <div class="panel-body">

                <form id="post-thread-form" class="post-thread-form thread-form" method="post" action="" novalidate="novalidate">

                    <div class="form-group">
                        <label class="control-label hide" >回复内容</label>
                        <div class="controls">
                            <textarea name="answer_content"  value="" rows="10"  class="form-control" id="answer_content"></textarea>
                        </div>
                    </div>




                    <div class="form-group">

                        <div class="controls">
                            <!--
                                                            <a class="btn btn-primary js-upload-file" data-toggle="modal" data-backdrop="static" data-target="#attachment-modal"  title="上传附件" data-placement="bottom" data-title="上传附件">
                                                                上传附件
                                                            </a>
                              -->
                        </div>

                    </div>
                    <!--上传附件成功后显示-->
                    <div class="form-group" style="display: none;">
                        <div class="controls">

                            <div class="js-attachment-list js-attachment-list" style="line-height:60px">
                                <div class="well well-sm">
                                    <img class="mrm" src="//scc1a8b2s6-static.qiqiuyun.net/assets/img/default/cloud_other.png?8.0.13" height="60px" width="107px">
                                    上传附件文件名
                                    <button class="btn btn-link js-attachment-delete pull-right"  type="button" style="margin-top:13px">删除
                                    </button>
                                </div>
                            </div>

                            <a class="btn btn-primary js-upload-file" data-toggle="modal" data-backdrop="static"  title="上传附件"  data-title="上传附件" style="display: none;">
                                上传附件
                            </a>
                        </div>

                    </div>


                    <div class="form-group">
                        <div class="controls">
                            <button id="post-thread-btn"  class="post-thread-btn btn btn-primary pull-right" type="button">发表</button>
                        </div>
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>
<script>
    $("#post-thread-btn").click(function() {
        var answer_content =$("#answer_content").val();
        var user='${currentUser}';
        if(user==""){
            alert("请登录！");
            return false;
        }
        if (answer_content == "") {
            alert("请输入内容!");
            return false;
        } else {

            $.ajax({
                url : '${pageContext.request.contextPath}/topic_question/put_answer.action',
                data : {

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
    $("#stick").click(function(){
        var msg=$(this).text();
        var b=confirm("是否"+msg+"?");
        if(b){
            $.ajax({
                url : '${pageContext.request.contextPath}/topic_question/stick_and_elite.action',
                data : {
                    type:"stick",
                    id : '${topicQuestion.id}'
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
    $("#elite").click(function(){
        var msg=$(this).text();
        var b=confirm("是否"+msg+"?");
        if(b){
            $.ajax({
                url : '${pageContext.request.contextPath}/topic_question/stick_and_elite.action',
                data : {
                    type:"elite",
                    id : '${topicQuestion.id}'
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
