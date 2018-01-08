<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>
<link href="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.js"></script>


<div class="cn-wrap">
    <div id="content-container" class="container" >
        <c:if test="${!empty workshopView}">
            <jsp:include page="workshop_header.jsp"></jsp:include>
        </c:if>
        <c:if test="${empty workshopView}">
            <jsp:include page="community_header.jsp"></jsp:include>
        </c:if>

        <div class="row row-3-9">
            <c:if test="${!empty workshopView}">
                <jsp:include page="workshop_left.jsp"></jsp:include>
            </c:if>
            <c:if test="${empty workshopView}">
                <jsp:include page="community_left.jsp"></jsp:include>
            </c:if>

            <div class="col-md-9">

                <div class="panel panel-default panel-col">
                    <div class="panel-heading">社区话题
                        <a href="#add_topic" class="btn btn-info pull-right" data-toggle="modal">添加话题</a>
                    </div>
                    <c:if test="${!empty topicQuestionViews }">
                        <div class="panel-body">
                            <form method="post"  class="form-horizontal form-inline well well-sm" action="${pageContext.request.contextPath}/topic_question/to_topic.action">
                                <input type="hidden" name="source_type" value="${topicQuestionView.source_type }">
                                <input type="hidden" name="source_id" value="${topicQuestionView.source_id }">
                                <div class="form-group">
                                    <input type="text"   class="form-control" value="" placeholder="关键词"  id="search" name="search">
                                    <button  class="btn btn-primary btn-sm" id="search_btn">搜索</button>
                                </div>

                                <ul class="course-wide-list">
                                    <c:forEach items="${topicQuestionViews }" var="question">
                                        <li class="course-item clearfix">
                                            <a class="course-picture-link" href="javascript:void(0);" target="_blank">
                                                <img class="course-picture" src="http://edusoho-demo.b0.upaiyun.com/files/default/2015/06-10/155158e4340f775236.jpg" style="width: 80px;height:80px;margin: 10px;">
                                            </a>
                                            <div class="course-body" style="margin-left: 110px;">
                                                <div style="float:right;" class="text-muted mrm mls">
                                                    <div>
                                                        <i class="es-icon es-icon-people"></i>
                                                        <span style="margin-left: 10px;">参与人数:${question.answerNum }</span>
                                                    </div>
                                                </div>
                                                <h4 class="mbl"><a href="${pageContext.request.contextPath}/community/to_community_index.action?sourceType=${question.source_type-2}&classifyId=-1&stamp=6&id=${question.source_id}&questionId=${question.questionId }" target="_blank">${question.querstionName }</a></h4>

                                                <div class="course-footer clearfix mtl">
                                                    发起人: ${question.teacherName } &nbsp;&nbsp;
                                                    发起时间 <fmt:formatDate type="date"
                                                                         value="${question.question_time }" /> &nbsp;&nbsp;
                                                </div>
                                                <div class="pull-right topic_operation" style="margin-top: -50px;margin-right: 20px;" >
                                                    <c:if test="${question.is_delete==0}">
                                                        <a href="javascript:void(0);" class="btn btn-danger btn-sm" onclick="openOrClose(${question.questionId})">关闭话题</a>
                                                       
                                                    </c:if>
                                                    <c:if test="${question.is_delete==1}">
                                                    <img src="${pageContext.request.contextPath}/frontstage/images/close.png" >
                                                     <a href="javascript:void(0);" class="btn btn-success btn-sm" onclick="openOrClose(${question.questionId})">开启话题</a>
                                                     </c:if>

                                                </div>

                                            </div>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </form>
                            <div id="test" class="pager" "></div>
                        </div>
                    </c:if>
                    <c:if test="${empty topicQuestionViews }">
                        <div class="empty">竟然还没有话题，快去添加话题吧！</div>
                    </c:if>
                </div>
            </div>

        </div>
    </div>
</div>

<div class="modal" data-toggle="modal" style="display: none;" id="add_topic">
    <div class="modal-dialog modal-lg">
        <div class="panel panel-default panel-col " >
            <div class="panel-heading">添加话题
                <button class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <div class="panel-body">
                    <form class="form-horizontal" action="" method="post"  id="topicForm">

                        <div class="form-group">
                            <div class="col-md-2 control-label"><label><span class="text-danger">*</span>题目:</label></div>
                            <div class="col-md-6 controls">
                                <input type="text"  class="form-control" name="title">
                                <div class="help-block" style="display: none;">
                                    <span class="text-danger">请输入题目</span>
                                </div>
                            </div>
                        </div>


                        <div class="form-group">
                            <div class="col-md-2 control-label"><label><span class="text-danger">*</span>内容:</label></div>
                            <div class="col-md-6 controls">
                                <textarea   class="form-control" rows="4" name="question_content"></textarea>
                                <div class="help-block" style="display: none;">
                                    <span class="text-danger">请输入内容</span>
                                </div>
                            </div>
                        </div>


                        <div class="form-group clearfix">

                            <div class="col-md-2 controls col-md-offset-2" >
                                <button class="btn btn-fat btn-info" type="submit">保存</button>
                            </div>

                            <div class="col-md-2 controls">
                                <button class="btn btn-fat btn-danger " type="button"  data-dismiss="modal" aria-hidden="true">取消</button>
                            </div>

                        </div>



                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<form id="communityForm" action="${pageContext.request.contextPath}/topic_question/to_topic.action" method="post">
    <input type="hidden" name="rows" id="rows" value="${topicQuestionView.rows}"/>
    <input type="hidden" name="source_id" id="source_id" value="${topicQuestionView.source_id}"/>
    <input type="hidden" name="source_type" id="source_type" value="${topicQuestionView.source_type}"/>
    <input type="hidden" name="page" id="page" value="${topicQuestionView.page}"/>
    <input type="hidden" name="total" id="total" value="${topicQuestionView.total}" />
</form>
<script>

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
            pageSize:  $("#rows").val(),            //一页记录数
            onPageChange: function (page) {
                document.title = page;
                $("#page").val(page-1);
                $('#communityForm').submit();

            }
        });
    });
    $(document).ready(function() {
        var source_id;
        var source_type;
        if("${workshopView}"!=""){
            source_id='${workshopView.id}';
            source_type=3;
        }
        if("${communityView}"!=""){
            source_id='${communityView.id}';
            source_type=2;
        }
        $('#topicForm').bootstrapValidator({
            message: '此值无效',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                title: {
                    message: '标题',
                    validators: {
                        notEmpty: {
                            message: '标题不能为空'
                        },
                        stringLength: {
                            min: 4,
                            max: 20,
                            message: '标题长度4-20'
                        }
                    }
                },
                question_content:{
                    message: '内容',
                    validators: {
                        notEmpty: {
                            message: '内容不能为空'
                        },
                    }
                },

            }
        }).on('success.form.bv', function(e) {
            if(e.type){//验证成功
                //document.getElementById('workshopForm').submit();
                e.preventDefault();

                $.ajax({
                    url : '${pageContext.request.contextPath}/topic_question/put_question.action?source_id='+source_id+'&source_type='+source_type,
                    data :$(this).serialize() ,
                    dataType : 'json',
                    success : function(response) {
                        location.replace(location.href);
                    }
                });
            }else{
                // 防止表单提交
                e.preventDefault();
            }
        });
    });
    function openOrClose(id){

//改变开启状态
        $.ajax({
            type: 'POST',
            url : '${pageContext.request.contextPath}/topic_question/openOrClose.action',
            dataType: "json",
            data:{
                id:id,
              
            },
            success : function(response) {
                var href=location.href;
                location.replace(href);
            }
        });
    };

</script>
