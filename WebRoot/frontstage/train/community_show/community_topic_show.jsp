<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>



<div class="community-container">

    <div class="panel panel-default panel-col">
        <div class="panel-body">

            <div class="nav-filter clearfix mbl">

                <ul class="nav nav-pills nav-pills-sm">

                    <li <c:if test="${communityCenterView.status==0}">class="active"</c:if>><a class="js-nav"  href="javascript:void(0);" onclick="searchStatus(0);">全部</a></li>

                    <li <c:if test="${communityCenterView.status==1}">class="active"</c:if>><a class="js-nav"  href="javascript:void(0);" onclick="searchStatus(1);">精华</a></li>


                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);">
                            <span class="color-gray">排序：</span>
                            <c:if test="${communityCenterView.sortType==0}">最新发帖</c:if>
                            <c:if test="${communityCenterView.sortType==1}">最后回复</c:if>
                            <c:if test="${communityCenterView.sortType==2}">回复数</c:if>
                            <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu">
                            <li <c:if test="${communityCenterView.sortType==0}">class="active"</c:if>><a class="js-nav" href="javascript:void(0);" onclick="searchSortType(0)">最新发帖</a></li>
                            <li <c:if test="${communityCenterView.sortType==1}">class="active"</c:if>><a class="js-nav" href="javascript:void(0);" onclick="searchSortType(1)">最后回复</a></li>
                            <li <c:if test="${communityCenterView.sortType==2}">class="active"</c:if>><a class="js-nav" href="javascript:void(0);" onclick="searchSortType(2)">回复数</a></li>
                        </ul>
                    </li>
                </ul>

                <div class="mbm pull-right">
                    <a href="#add_topic" class="btn btn-success btn-xlg btn-block" role="button" data-toggle="modal">
                        <i class="es-icon es-icon-comment mrs text-xlg"></i>
                        发表话题
                    </a>
                </div>


            </div>

            <ul class="media-list thread-list">
                <c:forEach items="${topicQuestionViews}" var="q">
                    <li class="media">
                        <div class="media-left">
                            <span class="reply-num">
                                <strong>${q.answerNum }</strong> 回复
                            </span>
                        </div>
                        <div class="media-body pts">

                            <div class="media-heading">
                                <a class="title gray-darker" href="${pageContext.request.contextPath}/community/to_community_index.action?sourceType=0&classifyId=-1&stamp=6&id=${communityCenterView.id}&questionId=${q.questionId }">${q.querstionName }</a>
                                <c:if test="${q.stick==1}"><span class="label label-primary">置顶</span></c:if>
                                <c:if test="${q.elite==1}"><span class="label label-danger">精华</span></c:if>

                            </div>

                            <div class="metas">
                                <a class="userImg js-user-card" href="javascript:void(0);" >
                                    <img class="avatar-xxs" src="${pageContext.request.contextPath}${q.icon }">
                                </a>

                                <a class="link-dark pls" href="javascript:void(0);">${q.teacherName }</a>
                                发起了话题
                                <span class="divider">•</span>
                                <fmt:formatDate type="date"  value="${q.question_time }" />
                                <span class="divider">•</span>
                                最后回复
                                <a class="link-dark link-primary" href="javascript:void(0);">${q.last_answer_name }</a>

                                <span class="divider">•</span>
                                <fmt:formatDate type="date"  value="${q.last_reply_time }" />
                            </div>
                        </div>
                    </li>
                </c:forEach>
				<c:if test="${communityCenterView.total>8}">
			<br>
		<p style="margin-left: 50%;cursor: pointer;margin-bottom: 30px;" id="pointer_more" >加载更多</p>
		<input type="hidden" id="pointer_number" value="2">
		</c:if>
            </ul>

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
<script>
    $(document).ready(function() {
        var user='${currentUser}';
        var source_id='${communityCenterView.id}';
        var sourceType='${communityCenterView.sourceType}';
        var source_type=0;
        if(sourceType==0){
            source_type=2;
        }
        if(sourceType==1){
            source_type=3;
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
            if(user==""){
                alert("请登录！");
                return false;
            }
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
//加载更多
		$("#pointer_number").val(2);
		$("#pointer_more").click(function(){
			
			var _this=$(this);
			var number=$("#pointer_number").val();
			var q_sort="";
			var page_size="${communityCenterView.rows}";
		if("${communityCenterView.sortType}"==0){
		q_sort="question_time";
		}
	if("${communityCenterView.sortType}"==1){
			q_sort="cq.last_reply_time";
		}
	if("${communityCenterView.sortType}"==2){
		q_sort="reply_times";
		}
	
			$.ajax({
				type:'get',
				url : "${pageContext.request.contextPath}/user_study/ajax_more.action?q_sort="+q_sort+"&page_size="+page_size+"&type=${communityCenterView.sourceType+2}&id=${communityCenterView.id}&elite=${communityCenterView.status}&page="+number,
				dataType:'json',
				success : function(response) {
				
					if(!response.flag){
						_this.remove();
					}
					for(var i=0;i<response.question.length;i++){
                              var q=response.question[i];
                              var html="";
                              var last_reply_time="";
                              var question_time="";
                        if(response.question[i].last_answer_name!=null&&response.question[i].last_answer_name!=""){
							var myDate=new Date();
							myDate.setTime(response.question[i].last_reply_time.time);
							var year=myDate.getFullYear();
							var month=myDate.getMonth()+1;
							var date=myDate.getDate();
							var hour=myDate.getHours();
							var minute=myDate.getMinutes();
							var second=myDate.getSeconds();
							 last_reply_time=year+"-"+month+"-"+date+" ";//+hour+":"+minute+":"+second;
						}
							var myDate=new Date();
							myDate.setTime(response.question[i].question_time.time);
							var year=myDate.getFullYear();
							var month=myDate.getMonth()+1;
							var date=myDate.getDate();
							var hour=myDate.getHours();
							var minute=myDate.getMinutes();
							var second=myDate.getSeconds();
							 question_time=year+"-"+month+"-"+date+" ";//+hour+":"+minute+":"+second;
							
					html+='<li class="media"><div class="media-left"><span class="reply-num">';
                                html+='<strong>'+q.reply_times+'</strong> 回复</span></div>';
                        html+='<div class="media-body pts">';
								html+='<div class="media-heading">';
                                html+='<a class="title gray-darker" href="${pageContext.request.contextPath}/community/to_community_index.action?sourceType=0&classifyId=-1&stamp=6&id=${communityCenterView.id}&questionId='+q.id+'">'+q.title+'</a>';
                                       if(response.question[i].stick==1){
							//置顶
							html+='<span class="label label-primary">置顶</span>';
						
						}
						
						if(response.question[i].elite==1){
							//精华
							html+='<span class="label label-danger">精华</span>';
							
						}
                             

                            html+='</div><div class="metas">';
                                html+='<a class="userImg js-user-card" href="javascript:void(0);" >';
                                    html+='<img class="avatar-xxs" src="${pageContext.request.contextPath}'+q.user.icon+'"></a>';

                                html+='<a class="link-dark pls" href="javascript:void(0);">'+q.user.username+'</a>';
                                html+='发起了话题<span class="divider">•</span>'+question_time+'';
                                
                                html+='<span class="divider">•</span>最后回复';
                                html+='<a class="link-dark link-primary" href="javascript:void(0);">'+q.last_answer_name+'</a>';

                                html+='<span class="divider">•</span>'+last_reply_time+'';
                              
                            html+='</div></div></li>';
					$(".media:last").after(html);
						$("#pointer_number").val(parseInt(number)+1);
					}
					
				},
				error :function(response) {

				}
			});

		});

	
</script>
