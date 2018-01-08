<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>


<link href="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.js"></script>
<%-- 
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/JMEditor/jmeditor/JMEditor.js"></script>
--%>
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/wangEditor/wangEditor.min.js"></script>
<style>
	#defaultImg{
		width:540px;height:270px;}
	.file:hover{color: #fff;}
	.webuploader-pick>div>label:hover{color: #fff;}
</style>
<div class="cn-wrap">

	<div id="content-container" class="container">
		<jsp:include page="/frontstage/train/course/course_header.jsp"></jsp:include>

		<div class="row">
			<jsp:include page="/frontstage/train/course/course_left.jsp"></jsp:include>

			<div class="col-md-9">
				<div class="panel panel-default panel-col">
					<div class="panel-heading clearfix">
						题目管理
					</div>
					<div class="panel-body">
						<ol class="breadcrumb">
							<li><a href="#">题目管理</a></li>
							<li class="active">添加题目</li>
						</ol>
						<div id="question-creator-widget">
							<form id="question-create-form" class="form-horizontal quiz-question" method="post" action="${pageContext.request.contextPath}/question/question_add.action?type=2&courseId=${courseView.id}">
								<c:if test="${questionView.is_son==0 }">
									<input type="hidden" name="pid" value="${questionView.pid}">
								</c:if>
								<c:if test="${questionView.is_son==1 }">
									<div class="form-group">
										<div class="col-md-2 control-label"><label>从属</label></div>
										<div class="col-md-8 controls">
											<select class="form-control width-input width-input-large" name="belong_to">
												<option value="-1">本课程</option>
												<c:forEach items="${chapterList}" var="chapter" varStatus="status1">
													<option value="${chapter.id}"  <c:if test="${chapter.id==question.belong_to&&question.belong_type==1}">selected="selected"</c:if>>第${status1.index+1}章：${chapter.hour_title}</option>

												</c:forEach>
											</select>
											<div class="help-block">可以针对本课程或者某个课时出题</div>
										</div>
									</div>

									<div class="form-group">
										<div class="col-md-2 control-label"><label>难度</label></div>
										<div class="col-md-8 controls radios">
											<label><input type="radio" name="difficulty" value="0" <c:if test="${!empty question&&question.difficulty==0}">checked="checked"</c:if>> 简单</label>
											<label><input type="radio" name="difficulty" value="1"<c:if test="${!empty question&&question.difficulty==1}">checked="checked"</c:if> <c:if test="${empty question}">checked="checked"</c:if>> 一般</label>
											<label><input type="radio" name="difficulty" value="2" <c:if test="${!empty question&&question.difficulty==2}">checked="checked"</c:if>> 困难</label>

										</div>
									</div>
								</c:if>

								<div class="form-group">
									<div class="col-md-2 control-label"><label for="question-stem-field">题干</label></div>
									<div class="col-md-8 controls">

										<div  id="question-stem-field" >${question.stem }</div>
										<%-- 
										<input type="hidden" name="stem" value="${question.stem }"/>
										--%>
										<textarea style="display:none" name="stem">
											${question.stem }
										</textarea>
										<script type="text/javascript">
		                                    var E = window.wangEditor;
		                                    var stem_weditor = new E("#question-stem-field");
		                                    stem_weditor.customConfig.menus = [
		                                        'head',  // 标题
			                       				'bold',  // 粗体
			                       				'italic',  // 斜体
			                       				'underline',  // 下划线
			                       				'foreColor',  // 文字颜色
			                       				'backColor',  // 背景颜色
			                       				'undo',  // 撤销
			                       				'redo'  // 重复
		                                    ];
		                                    //保存图片到服务器
		                                    stem_weditor.customConfig.uploadImgServer = "${pageContext.request.contextPath}/upload_file/upload_resource.action?source_id=${courseView.id}&source_type=0";
		                                    //限制图片大小
		                                    stem_weditor.customConfig.uploadImgMaxSize = 3*1024*1024;
		                                    //图片上传上限
		                                    stem_weditor.customConfig.uploadImgMaxLength = 1;
		                                    //隐藏"网络图片"选项
		                                    stem_weditor.customConfig.showLinkImg = false;
		                                    stem_weditor.create();
										</script>
									</div>
								</div>

								<div class="form-group">
									<div class="col-md-2 control-label"><label>答案</label></div>
									<div class="col-md-8 controls radios ">
										<label><input type="radio" name="right_key" value="1" <c:if test="${empty question||question.right_key==1}">checked="checked"</c:if>> 正确</label>
										<label><input type="radio" name="right_key" value="0" <c:if test="${question.right_key==0}">checked="checked"</c:if>> 错误</label>
									</div>
								</div>

								<div class="form-group">
									<div class="col-md-8 col-md-offset-2 controls ">
										<a href="javascript:;" class="text-success collapsed dis_hide_analysis">» 显示/隐藏 高级选项 ...</a>
									</div>
								</div>
								<div id="advanced-collapse" class="advanced-collapse collapse">
									<div class="form-group">
										<div class="col-md-2 control-label"><label for="question-analysis-field">解析</label></div>
										<div class="col-md-8 controls">

											 <div  id="question-analysis-field">${question.analysis }</div>
											 <%-- 
											 <input type="hidden" name="analysis" value="${question.analysis }"/>
											 --%>
											 <textarea style="display: none" name="analysis">
											 	${question.analysis }
											 </textarea>
											 <script type="text/javascript">
			                                    var E = window.wangEditor;
			                                    var analysis_weditor = new E("#question-analysis-field");
			                                    analysis_weditor.customConfig.menus = [
			                       		             'head',  // 标题
			                       			         'bold',  // 粗体
			                       			         'italic',  // 斜体
			                       			         'underline',  // 下划线
			                       			         'foreColor',  // 文字颜色
			                       			         'backColor',  // 背景颜色
			                       			         'undo',  // 撤销
			                       			         'redo'  // 重复
			                       		        ];
			                                    //保存图片到服务器
			                                    analysis_weditor.customConfig.uploadImgServer = "${pageContext.request.contextPath}/upload_file/upload_resource.action?source_id=${courseView.id}&source_type=0";
			                                    //限制图片大小
			                                    analysis_weditor.customConfig.uploadImgMaxSize = 3*1024*1024;
			                                    //图片上传上限
			                                    analysis_weditor.customConfig.uploadImgMaxLength = 1;
			                                    //隐藏"网络图片"选项
			                                    analysis_weditor.customConfig.showLinkImg = false;
			                                    analysis_weditor.create();
											</script>
										</div>
									</div>

									<div class="form-group">
										<div class="col-md-2 control-label"><label for="question-score-field">分值</label></div>
										<div class="col-md-4 controls">
											<input class="form-control"
												   <c:if test="${!empty question}">value="${question.score }" </c:if>
												   <c:if test="${empty question}">value="2"</c:if> type="text" name="score">
										</div>
									</div>
								</div>
								<div class="form-group">
									<div class="col-md-8 col-md-offset-2 controls">
										<button type="button" class="btn btn-primary submit-btn" id="continue_btn">保存并继续添加</button>
										<button type="button" class="btn btn-primary submit-btn" id="redirect_btn">保存</button>
										<a href="javascript:history.go(-1)" class="btn btn-link">返回</a>
										<input type="hidden"  name="is_son" value="${questionView.is_son }">
										<c:if test="${!empty question}">
											<input type="hidden"  name="id" value="${question.id }">
										</c:if>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>

</div>

<script type="text/javascript">
	$(function(){
		if('${courseView.flag}'==0){
			var div='<div class="alert alert-success">题目添加成功，请继续添加。</div>';
			$("#question-create-form").prepend(div);
		}

		<%--
		var height = $('#question-stem-field').height();
		CKEDITOR.replace("question-stem-field", {
			skin : "moono-lisa",
			height : height,
			margin : "0,0,0,0",
			resize_enabled : false,
			toolbar :
					'Minimal'
		});
		--%>
		<%--
		var height_analysis = $('#question-analysis-field').height();
		CKEDITOR.replace("question-analysis-field", {
			skin : "moono-lisa",
			height : height_analysis,
			margin : "0,0,0,0",
			resize_enabled : false,
			toolbar :
					'Minimal'
		});
		--%>
		// 点击显示隐藏

		$('.dis_hide_analysis').click(function(){

			$('#advanced-collapse').toggle();

		});

		//提交事件
		$("#continue_btn").click(function(){
			var form=$("#question-create-form");
			var action=form.attr("action");
			action=action+"&submit=1";
			form.attr("action",action);
			if(verification(form)){
				form.submit();
			}
		});
		$("#redirect_btn").click(function(){
			var form=$("#question-create-form");
			var action=form.attr("action");
			action=action+"&submit=2";
			form.attr("action",action);
			if(verification(form)){
				form.submit();
			}
		});
	});
	function verification(form){
		$("textarea[name = 'stem']").val(stem_weditor.txt.html());
		$("textarea[name = 'analysis']").val(analysis_weditor.txt.html());
		/*
		for ( instance in CKEDITOR.instances )
			CKEDITOR.instances[instance].updateElement();
		*/
		if($("textarea[name = 'analysis']").val()==="<p><br></p>"){
			$("textarea[name = 'analysis']").val("");
		}
		if($("textarea[name = 'stem']").val()==="<p><br></p>"){
			alert("请输入题干");
			return false;
		}else{
			return true;
		}


	}
</script>


<%--<jsp:include page="../layout/footer.jsp"></jsp:include>--%>