<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<div class="course-detail row">

	<ul class="breadcrumb">
		<li><a href="javascript:void(0);">讨论区</a></li>
		<li class="active">问答</li>
	</ul>

	<div class="thread">

		<div class="thread-header">
			<a class="pull-right js-user-card" href="javascript:void(0);" >
				<img class="avatar-sm" src="${pageContext.request.contextPath}/userImages/${topicQuestion.user.icon }">
			</a>

			<h2 class="thread-title">
				<span class="label label-info">问</span>
				${topicQuestion.title }
			</h2>

			<div class="thread-metas">
				By<a class="link-dark link-muted" href="javascript:void(0);">${topicQuestion.user.username}</a>
				<span class="bullet mhs">•</span>
				<fmt:formatDate value="${topicQuestion.question_time }" type="both" />
				<span class="bullet mhs">•</span>${topicQuestion.watch_times }次浏览
			</div>
		</div>

		<div class="thread-body">${topicQuestion.question_content }</div>

		<div class="thread-footer" >
			<c:if test="${is_self }">
				<a href="javascript:return false;"  data-role="confirm-btn" id="updateQuestion1"><span class="glyphicon glyphicon-edit" ></span> 编辑</a>&nbsp;
				<a href="${pageContext.request.contextPath}/topic_question/delete_question.action?id=${topicQuestion.id}&course_id=${topicQuestion.source_id}&user_id=${topicQuestion.user_id}"><span class="glyphicon glyphicon-remove-sign"></span>删除</a>&nbsp;
				<a id="stick" href="javascript:return false"  data-role="confirm-btn" ><span class="glyphicon glyphicon-minus-sign"></span><c:if test="${topicQuestion.stick==1}">取消</c:if>置顶</a>&nbsp;
				<a id="elite"  href="javascript:return false"  data-role="confirm-btn"><span class="glyphicon glyphicon-hand-right"></span><c:if test="${topicQuestion.elite==1}">取消</c:if>加精</a>
			</c:if>

		</div>

	</div>

	<div class="thread-posts">

		<h3 class="thread-posts-heading">
			<span class="glyphicon glyphicon-plus"></span> 添加答案</h3>
		<div id="profile_"></div>
		
		<button style="margin-top: 50px;" id="answerButton" class="btn btn-primary pull-right">添加答案</button>
		<script type="text/javascript">
            var E = window.wangEditor;
            var weditor = new E("#profile_");
            //保存图片到服务器
            weditor.customConfig.uploadImgServer = "${pageContext.request.contextPath}/upload_file/upload_resource.action?source_id=${trainView.id }&source_type=1";
            //限制图片大小
            weditor.customConfig.uploadImgMaxSize = 3*1024*1024;
            //图片上传上限
            weditor.customConfig.uploadImgMaxLength = 1;
            //隐藏"网络图片"选项
            weditor.customConfig.showLinkImg = false;
            weditor.create();
		</script>
		<h3 class="thread-posts-heading">
			<span class="glyphicon glyphicon-share-alt"></span>
			<span id="thread-post-num">${topicQuestion.reply_times }</span>所有答案
		</h3>

		<ul class="thread-post-list media-list" id="answer_list">
			<c:forEach items="${topicAnswers }" var="topicAnswer">
				<li id="post-1" class="thread-post media clearfix">
					<a class="pull-left media-object js-user-card" href="javascript:void(0);" >
						<img class="avatar-sm" src="${pageContext.request.contextPath}${topicAnswer.user.icon }">
					</a>

					<div class="thread-post-dropdown">
						<a href="javascript:" class="dropdown-toggle text-muted" data-toggle="dropdown">
							<i class="glyphicon glyphicon-collapse-down"></i>
						</a>
						<ul class="dropdown-menu pull-right">
							<li><a href="javascript:void(0);"><i class="glyphicon glyphicon-edit"></i> 编辑</a></li>
							<li><a href="javascript:" ><i class="glyphicon glyphicon-remove"></i> 删除</a></li>
						</ul>
					</div>

					<div class="thread-post-body media-body" style="word-break:break-all;">
						<div class="media-heading">
							<a href="javascript:">${topicAnswer.user.username }</a>
							<span class="bullet">•</span>
							<span class="text-muted"><fmt:formatDate value="${topicAnswer.answer_time }" type="both" /></span>
						</div>
						<div class="editor-text"><p>${topicAnswer.answer_content }</p></div>
					</div>
				</li>
			</c:forEach>
		</ul>
		<c:if test="${topicQuestion.reply_times>10}">
			<br>
			<p style="margin-left: 50%;cursor: pointer;margin-bottom: 30px;" id="pointer_more1" >加载更多</p>
			<input type="hidden" id="pointer_number1" value="2">
		</c:if>
	</div>
	<div class="discussion_area_content">
		<div id="question_click1" style="display: none">
			<input id="thread_title1" name="title" required="required"  class="form-control" placeholder="标题，用一句话说清你的问题"   type="text" value="${topicQuestion.title }"> <br>
			<div id="profile_1">${topicQuestion.question_content }</div>
			<%-- 
			<input type="hidden" name="profile_" value='${topicQuestion.question_content }'> <br>
			--%>
			<textarea style="display: none;" name="profile_">
				${topicQuestion.question_content }
			</textarea>
			<br>
			<a class="btn btn-link" id="question_quit">取消</a>
			<button class="btn btn-primary btn-fat" value="" id="question_button1">保存</button>
			<script type="text/javascript">
            var E = window.wangEditor;
            var weditor1 = new E("#profile_1");
            //保存图片到服务器
            weditor1.customConfig.uploadImgServer = "${pageContext.request.contextPath}/upload_file/upload_resource.action?source_id=${trainView.id }&source_type=1";
            //限制图片大小
            weditor1.customConfig.uploadImgMaxSize = 3*1024*1024;
            //图片上传上限
            weditor1.customConfig.uploadImgMaxLength = 1;
            //隐藏"网络图片"选项
            weditor1.customConfig.showLinkImg = false;
            weditor1.create();
		</script>
		</div>
	</div>
</div>


<script type="text/javascript">
	$(function() {
		var user='${currentUser}';
		var flag=false;
		if(user==""){
			flag=true;
		}
		<%--
		var profile_Val = $("input[name='profile_']").val();
		--%>
		//给JMEditor赋值
		<%--
		var editor = CKEDITOR.replace("profile_", {
			skin : "moono-lisa",
			height : 200,
			margin : "0,0,0,120"
		});
		
		<%--
		var editor1 = CKEDITOR.replace("profile_1", {
			skin : "moono-lisa",
			height : 200,
			margin : "0,0,0,120"
		});
		--%>
		<%--
		if (profile_Val != '') {
			//editor1.setData(profile_Val);
			weditor1.txt.html(profile_Val);
		}
		--%>
		//编辑
		$("#updateQuestion1").click(function() {
			$(".thread").hide();
			$(".thread-posts").hide();
			$("#question_click1").show();
		});
		//取消
		$("#question_quit").click(function() {
			$(".thread").show();
			$(".thread-posts").show();
			$("#question_click1").hide();

		});
		//回答
		$("#answerButton").click(function() {

			//var answer_content = editor.getData();
			var answer_content = weditor.txt.html();
			if (answer_content == ""||answer_content==="<p><br></p>") {
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
		//编辑
		$("#question_button1").click(
				function() {

					var title = $("#thread_title1").val();
					//var question_content = editor1.getData();
					var question_content = weditor1.txt.html();
					if (title == "") {
						alert("请输入标题!");
						return false;
					} else if (question_content == ""||question_content==="<p><br></p>") {
						alert("请输入内容!");
						return false;
					} else {
						$.ajax({
							url : '${pageContext.request.contextPath}/topic_question/update_question.action',
							data : {
								id:'${topicQuestion.id}',
								title : title,
								question_content : question_content
							},
							dataType : 'json',
							success : function(response) {

								if (response.flag == 1) {

									var path = location.pathname;

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
		$("#pointer_number1").val(2);
		$("#pointer_more1").click(function(){
			if(flag){
				check_login();
				return false;
			}
			var _this=$(this);
			var number=$("#pointer_number1").val();
			$.ajax({
				type:'get',
				url : "${pageContext.request.contextPath}/topic_question/ajax_answer.action?id=${topicQuestion.id}&page="+number,
				dataType:'json',
				success : function(response) {
					if(!response.flag){
						_this.remove();
					}
					$("#answer_list").append(response.html);
					$("#pointer_number1").val(parseInt(number)+1);

				},
				error :function(response) {

				}
			});
		});
	});

</script>