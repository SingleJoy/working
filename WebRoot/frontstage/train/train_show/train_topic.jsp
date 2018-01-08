<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<div class="nav-filter clearfix">
	<div class="btn-group">
		<button type="button" id="release_topic_question" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" aria-expanded="false">提问题</button>
	</div>

	<ul class="nav nav-pills nav-pills-sm" >
		<form id="topicForm" action="${pageContext.request.contextPath}/train/to_train_detail.action" method="post">
			<input type="hidden" name="id" value="${trainView.id}"/>
			<input type="hidden" name="sign" value="${trainView.sign}"/>
			<input type="hidden" name="elite" id="elite" value="${trainView.elite}"/>
			<input type="hidden" name="sort_name" id="sort_name" value="${trainView.sort_name}"/>
			<input type="hidden" name="viewType" value="${trainDetailView.viewType }"/>
		</form>
		<li  <c:if test="${trainView.elite==0 }">class="active"</c:if>>
			<a href="javascript:void(0);" onclick="doEliteForm(0);" <c:if test="${trainView.elite==0 }">class="curr"</c:if>>全部</a>
		</li>
		<!--  	<li  id="all_question"<c:if test="${elite==0 }">class="active"</c:if>><a href="javascript:return false;"
																					   <c:if test="${elite==0 }">class="curr"</c:if>>问答</a>
				</li>
-->
		<li <c:if test="${trainView.elite==1 }">class="active"</c:if>>
			<a  href="javascript:void(0);" onclick="doEliteForm(1);"<c:if test="${trainView.elite==1 }">class="curr"</c:if> >精华</a>
		</li>

		<li class="dropdown">
			<a class="dropdown-toggle" data-toggle="dropdown" href="javascript:return false;">
				<span  id="last_reply1">排序：</span>
				${q_sort_name}
				<span class="caret"></span>
			</a>
			<ul class="dropdown-menu hidden-xs" id="reply1">
				<li <c:if test="${trainView.sort_name == 'last_reply_time' }">class="active"</c:if> id="last_reply_time"><a class="js-nav" onclick="doSortForm('last_reply_time');" href="javascript:void(0);">最后回复</a></li>
				<li <c:if test="${trainView.sort_name == 'question_time' }">class="active"</c:if> id="question_time"><a onclick="doSortForm('question_time');" href="javascript:void(0);">最新发帖</a></li>
			</ul>
		</li>
	</ul>

</div>



<div id="question_click" style="display: none">
	<input id="thread_title" name="title" required="required" class="form-control" placeholder="标题，用一句话说清你的问题"  type="text"> <br/>
	<%-- 
	<div id="profile"
		 style="width:400px;height:200px;margin-left:120px;margin-top: 100px"
		 contentEditable="true" class="editDemo"></div>
	--%>
	<div id="profile"
		style="width:100%;height:10%;margin-left:0px;margin-top: 0px"
		 class="editDemo">
		${trainView.profile}
	</div>
	<%-- 
	<input type="hidden" name="profile" value="">
	--%>
	<textarea style="display: none;" name="profile">
		${trainView.profile}
	</textarea>
	<br>
	<a class="btn btn-link" id="question_quit">取消</a>
	<button class="btn btn-primary" value="" id="question_button" type="button" <c:if test="${isTeacher&&(trainDetailView.viewType==1||trainDetailView.viewType==2) }">disabled="disabled"</c:if>>发表</button>
	<script type="text/javascript">
	    var E = window.wangEditor;
	    var weditor = new E("#profile");
	    //保存图片到服务器
	    weditor.customConfig.uploadImgServer = "${pageContext.request.contextPath}/upload_file/upload_resource.action?source_id=${trainView.id}&source_type=1";
	    //限制图片大小
	    weditor.customConfig.uploadImgMaxSize = 3*1024*1024;
	    //图片上传上限
	    weditor.customConfig.uploadImgMaxLength = 1;
	    //隐藏"网络图片"选项
	    weditor.customConfig.showLinkImg = false;
	    weditor.create();
	</script>
</div>

<c:if test="${empty question }">
	<div class="empty" >暂无讨论</div>
</c:if>
<div class="topic-list" id="question_content">
	<c:if test="${!empty question }">
		<c:forEach items="${question}" var="q">
			<div class="media topic-item ">
				<div class="media-left">
					<a class="pull-left js-user-card" href="${pageContext.request.contextPath}/train/to_train_detail.action?id=${trainView.id}&sign=6&questionId=${q.id}" >
						<img class="avatar-sm" src="${pageContext.request.contextPath}${q.user.icon }">
					</a>

				</div>
				<div class="media-body">

					<div class="title">

						<i class="es-icon es-icon-chatcircle color-info" title="话题"></i>
						<a  href="${pageContext.request.contextPath}/train/to_train_detail.action?id=${trainView.id}&sign=6&questionId=${q.id}">${q.title}</a>
						<c:if test="${q.stick==1 }">
							<span class="label label-primary" title="置顶帖">置顶</span>
						</c:if>
						<c:if test="${q.elite==1 }">
							<span class="label label-danger" title="精华帖">精华</span>
						</c:if>
					</div>
					<div class="metas text-sm">

						<a href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id=${q.user_id}" class="color-gray">${q.user.username }</a>
						<span>发起了话题</span>
						<c:if test="${!empty q.last_answer_name }">•
                            <span>最后回复
                               <a class="link-dark link-muted" href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id=${q.last_answer_id }">${q.last_answer_name }</a>
                            </span>
							<span><fmt:formatDate value="${q.last_reply_time }" type="date" /> </span>
						</c:if>
					</div>


				</div>

				<div class="media-data hidden-xs">
					<span>${q.reply_times }<br>回复</span>
					<span>${q.watch_times }<br>浏览</span>
				</div>
			</div>
		</c:forEach>
		<c:if test="${totalQuestion>10}">
			<br>
			<div style="margin-left: 50%;cursor: pointer;margin-bottom: 30px;" id="pointer_more" >加载更多</div>
			<input type="hidden" id="pointer_number" value="2">
		</c:if>

	</c:if>
</div>



<script type="text/javascript">
	function doEliteForm(elite){
		$("#elite").val(elite);
		document.getElementById("topicForm").submit();
	}
	function doSortForm(sortName){
		$("#sort_name").val(sortName);
		document.getElementById("topicForm").submit();
	}
	$(function() {
		<%--
		var profileVal = $("input[name='profile']").val();
		--%>
		<%--
		//给JMEditor赋值
		var editor = CKEDITOR.replace("profile", {
			skin : "moono-lisa",
			height : 200,
			width:770,
			margin : "15px"
		});
		--%>
		<%--
		if (profileVal != '') {
			//editor.setData(profileVal);
			weditor.txt.html(profileVal);
		}
		--%>
		//  讨论区域
		$(function() {
			//按下取消
			$("#question_quit").click(function() {
				$("#question_click").hide();
				$("#question_content").show();
				$("#discussion_area_ul").show();
				$("#discussion_area_sort_reply1").show();
				$("#release_topic_question").show();
			});
			//按下提问按钮
			$(".release_topic").click(function() {
				$("#question_content").hide();
				$("#discussion_area_ul").hide();
				$("#discussion_area_sort_reply1").hide();
				$("#release_topic_question").hide();
				$("#question_click").show();

			});

		});
//提问
		$("#question_button").click(function() {
			if(flag){
				check_login();
				return false;
			}
			var title = $("#thread_title").val();
			//var question_content = editor.getData();
			var question_content = weditor.txt.html();
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
						source_id : '${trainView.id}',
						source_type : 1,
						class_id : '${class_id}'
					},
					dataType : 'json',
					success : function(response) {
						if (response.flag == 1) {
							window.location.reload();
						}
					}
				});
			}
		});
		//加载更多
		$("#pointer_number").val(2);
		$("#pointer_more").click(function(){
			if(flag){
				check_login();
				return false;
			}
			var _this=$(this);
			var number=$("#pointer_number").val();
			$.ajax({
				type:'get',
				url : "${pageContext.request.contextPath}/user_study/ajax_more.action?sort=${trainView.sort}&id=${trainView.id}&elite=${trainView.elite}&page="+number,
				dataType:'json',
				success : function(response) {
					if(!response.flag){
						_this.remove();
					}
					for(var i=0;i<response.question.length;i++){

						var div_topic=$('<div class="media topic-item">');
						var div_left=$('<div class="media-left media-middle">');
						var a_pull_left=$('<a class="pull-left js-user-card" href="${pageContext.request.contextPath}/train/to_train_detail.action?id=${trainView.id}&sign=6&questionId='+response.question[i].id+'">');
						var img_avatar=$('<img class="avatar-sm" src="${pageContext.request.contextPath}'+response.question[i].user.icon+'" style="width:40px;height: 40px;border-radius: 50%;">' );//
						a_pull_left.append(img_avatar);
						div_left.append(a_pull_left);
						var div_body=$('<div class="media-body">');
						var div_title=$('<div class="title">');
						var i_es=$('<i class="es-icon es-icon-chatcircle color-info" title="话题">');
						var a_=$('<a  href="${pageContext.request.contextPath}/train/to_train_detail.action?id=${trainView.id}&sign=6&questionId="'+response.question[i].id+'>');
						a_.html(response.question[i].title);
						var span1=$("<span>");
						if(response.question[i].stick==1){
							//置顶
							span1.attr("class","label label-primary");
							span1.attr("title","置顶帖");
							span1.html("置顶");

						}
						var span2=$("<span>");
						if(response.question[i].elite==1){
							//精华
							span2.attr("class","label label-danger");
							span2.attr("title","精华帖");
							span2.html("精华");

						}
						div_title.append(i_es);
						div_title.append(a_);
						div_title.append(span1);
						div_title.append(span2);
						var div_metas=$('<div class="metas text-sm">');
						var a1_=$('<a href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id='+response.question[i].user_id+'"class="color-gray">');
						a1_.html(response.question[i].user.username);
						var span3=$("<span>");
						span3.html("发起了话题");
						var span4=$("<span>");
						var a3=$('<a class="link-dark link-muted">');
						var span5=$("<span>");
						if(response.question[i].last_answer_name!=null&&response.question[i].last_answer_name!=""){
							a3.attr("href","${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id="+response.question[i].last_answer_id);
							a3.html(response.question[i].last_answer_name);
							span4.append("最后回复");
							span4.append("&nbsp;");
							span4.append(a3);

							var myDate=new Date();
							myDate.setTime(response.question[i].last_reply_time.time);
							var year=myDate.getFullYear();
							var month=myDate.getMonth()+1;
							var date=myDate.getDate();
							var hour=myDate.getHours();
							var minute=myDate.getMinutes();
							var second=myDate.getSeconds();
							var time=year+"-"+month+"-"+date+" ";//+hour+":"+minute+":"+second;
							span5.html(time);

						}
						div_metas.append(a1_);
						div_metas.append(span3);
						div_metas.append("&nbsp;");
						div_metas.append("•");
						div_metas.append("&nbsp;");
						div_metas.append(span4);
						div_metas.append(span5);
						div_body.append(div_title);
						div_body.append(div_metas);
						var div_media_data=$('<div class="media-data hidden-xs">');
						div_media_data.append("<span>"+response.question[i].reply_times+"<br>回复</span>");
						div_media_data.append("<span>"+response.question[i].watch_times+"<br>浏览</span>");
						div_topic.append(div_left);
						div_topic.append(div_body);
						div_topic.append(div_media_data);

						$(".topic-item:last").after(div_topic);
						$("#pointer_number").val(parseInt(number)+1);
					}
				},
				error :function(response) {

				}
			});

		});

	});


	$(function(){
		$("#release_topic_question").click(function(){
			$("#question_click").show();
		})
	})
</script>