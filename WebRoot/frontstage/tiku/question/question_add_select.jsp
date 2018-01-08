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
                            <form id="question-create-form" class="form-horizontal quiz-question" method="post" action="${pageContext.request.contextPath}/question/question_add.action?courseId=${courseView.id}" novalidate="novalidate" >
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
                                        <div class="col-md-2 control-label"><label>类型</label></div>
                                        <div class="col-md-8 controls radios">
                                            <label><input type="radio" name="type" value="0" <c:if test="${!empty question&&question.type==0}">checked="checked"</c:if> <c:if test="${empty question}">checked="checked"</c:if>>多选题</label>
                                            <label><input type="radio" name="type" value="5" <c:if test="${!empty question&&question.type==5}">checked="checked"</c:if>>单选题</label>
                                         </div>
                                    </div>
                                <div class="form-group">
                                    <div class="col-md-2 control-label"><label for="question-stem-field">题干</label></div>
                                    <div class="col-md-8 controls">
                                        <%-- 
                                        <textarea class="form-control" id="question-stem-field"  name="stem" style="height: 180px;">
                                            ${question.stem }
                                        </textarea>
                                        --%>
                                        <div   id="question-stem-field" >
                                        	${question.stem }
                                        </div>
                                        <%-- 
                                        <input type="hidden" name="stem" value="${question.stem }">
                                        --%>
                                        <textarea style="display: none;" name="stem">
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
                                <div id="choices">
                                    <div class="form-group">
                                        <div class="col-sm-2 control-label">
                                            <label class="choice-label" for="item-input-1">选项A</label>
                                        </div>
                                        <div class="col-sm-8 controls">

                                            <div class="item-input" id="item-input-1" style="width:100%;height:100%;">
                                            	${question.option_a}
                                            </div>
                                            <%-- 
                                            <input type="hidden" name="option_a" value="${question.option_a}"/>
                                            --%>
                                            <textarea style="display: none;" name="option_a">
                                            	${question.option_a}
                                            </textarea>
                                            <script type="text/javascript">
			                                    var E = window.wangEditor;
			                                    var option_a_weditor = new E("#item-input-1");
			                                    option_a_weditor.customConfig.menus = [
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
			                                    option_a_weditor.customConfig.uploadImgServer = "${pageContext.request.contextPath}/upload_file/upload_resource.action?source_id=${courseView.id}&source_type=0";
			                                    //限制图片大小
			                                    option_a_weditor.customConfig.uploadImgMaxSize = 3*1024*1024;
			                                    //图片上传上限
			                                    option_a_weditor.customConfig.uploadImgMaxLength = 1;
			                                    //隐藏"网络图片"选项
			                                    option_a_weditor.customConfig.showLinkImg = false;
			                                    option_a_weditor.create();
											</script>
                                            <p class="mtm">
                                                <label><input type="checkbox" class="answer-checkbox" name="right_key" value="A" <c:if test="${fn:contains(question.right_key, 'A')}">checked="checked"</c:if>> 正确答案</label>
                                            </p>
                                            
                                        </div>
                                        <div class="col-sm-2" style="padding-left:0;">
                                            <a class="btn btn-default btn-sm delete-choice mlm" href="javascript:void(null)"><i class="glyphicon glyphicon-trash"></i></a>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-2 control-label"><label class="choice-label" for="item-input-2">选项B</label></div>
                                        <div class="col-sm-8 controls">

                                            <div class="item-input " id="item-input-2" style="height:100%;">
                                            	${question.option_b}
                                            </div>
                                            <%-- 
                                            <input type="hidden" name="option_b" value="${question.option_b}"/>
                                            --%>
                                            <textarea style="display: none;" name="option_b">
                                            	${question.option_b}
                                            </textarea>
                                            <script type="text/javascript">
			                                    var E = window.wangEditor;
			                                    var option_b_weditor = new E("#item-input-2");
			                                    option_b_weditor.customConfig.menus = [
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
			                                    option_b_weditor.customConfig.uploadImgServer = "${pageContext.request.contextPath}/upload_file/upload_resource.action?source_id=${courseView.id}&source_type=0";
			                                    //限制图片大小
			                                    option_b_weditor.customConfig.uploadImgMaxSize = 3*1024*1024;
			                                    //图片上传上限
			                                    option_b_weditor.customConfig.uploadImgMaxLength = 1;
			                                    //隐藏"网络图片"选项
			                                    option_b_weditor.customConfig.showLinkImg = false;
			                                    option_b_weditor.create();
											</script>
                                            <p class="mtm">
                                                <label><input type="checkbox" class="answer-checkbox" name="right_key" value="B" <c:if test="${fn:contains(question.right_key, 'B')}">checked="checked"</c:if>> 正确答案</label>
                                            </p>
                                        </div>
                                        <div class="col-sm-2" style="padding-left:0;">
                                            <a class="btn btn-default btn-sm delete-choice mlm" href="javascript:void(null)"><i class="glyphicon glyphicon-trash"></i></a>
                                        </div>
                                    </div>
                                    <c:if test="${empty question||!empty question.option_c}">
                                        <div class="form-group">
                                            <div class="col-sm-2 control-label"><label class="choice-label" for="item-input-3">选项C</label></div>
                                            <div class="col-sm-8 controls">

                                                <div class="item-input" id="item-input-3" style="width: 100%;height:100%;"></div>
                                                <%-- 
                                                <input type="hidden" name="option_c" value="${question.option_c}"/>
                                                --%>
                                                <textarea style="display: none;" name="option_c">
                                                	${question.option_c}
                                                </textarea>
                                                <p class="mtm">
                                                    <label><input type="checkbox" class="answer-checkbox" name="right_key" value="C" <c:if test="${fn:contains(question.right_key, 'C')}">checked="checked"</c:if>> 正确答案</label>
                                                </p>
                                            </div>
                                            <div class="col-sm-2" style="padding-left:0;">
                                                <a class="btn btn-default btn-sm delete-choice mlm" href="javascript:void(null)"><i class="glyphicon glyphicon-trash"></i></a>
                                            </div>

                                        </div>
                                    </c:if>
                                    <c:if test="${empty question||!empty question.option_d}">
                                        <div class="form-group">
                                            <div class="col-sm-2 control-label"><label class="choice-label" for="item-input-4">选项D</label></div>
                                            <div class="col-sm-8 controls">

                                                <div class="item-input " id="item-input-4" style="width: 100%;height:100%;"></div>
                                                <%-- 
                                                <input type="hidden" name="option_d" value="${question.option_d}"/>
                                                --%>
                                                <textarea style="display: none;" name="option_d">
                                                	${question.option_d}
                                                </textarea>
                                                <p class="mtm">
                                                    <label><input type="checkbox" class="answer-checkbox" name="right_key" value="D" <c:if test="${fn:contains(question.right_key, 'D')}">checked="checked"</c:if>> 正确答案</label>
                                                </p>
                                            </div>
                                            <div class="col-sm-2" style="padding-left:0;">
                                                <a class="btn btn-default btn-sm delete-choice mlm" href="javascript:void(null)"><i class="glyphicon glyphicon-trash"></i></a>
                                            </div>
                                        </div>
                                    </c:if>
                                    <c:if test="${!empty question.option_e}">
                                        <div class="form-group">
                                            <div class="col-sm-2 control-label"><label class="choice-label" for="item-input-5">选项E</label></div>
                                            <div class="col-sm-8 controls">

                                                <div class="item-input " id="item-input-5" style="width: 100%;height: 100%;"></div>
                                                <%-- 
                                                <input type="hidden" name="option_e" value="${question.option_e}"/>
                                                --%>
                                                <textarea style="display: none;" name="option_e">
                                                	${question.option_e}
                                                </textarea>
                                                <p class="mtm">
                                                    <label><input type="checkbox" class="answer-checkbox" name="right_key" value="E" <c:if test="${fn:contains(question.right_key, 'E')}">checked="checked"</c:if>> 正确答案</label>
                                                </p>
                                            </div>
                                            <div class="col-sm-2" style="padding-left:0;">
                                                <a class="btn btn-default btn-sm delete-choice mlm" href="javascript:void(null)"><i class="glyphicon glyphicon-trash"></i></a>
                                            </div>
                                        </div>
                                    </c:if>
                                </div>

                                <div class="form-group">
                                    <div class="col-md-2 control-label"></div>
                                    <div class="col-md-8 controls">
                                        <button class="btn btn-success btn-sm pull-right add-choice" type="button">新增选项</button>
                                    </div>
                                </div>




                                <div class="form-group">
                                    <div class="col-md-8 col-md-offset-2 controls ">
                                        <a href="javascript:;" class="text-success dis_hide_analysis">» 显示/隐藏 高级选项 ...</a>
                                    </div>
                                </div>
                                <div id="advanced-collapse" class="advanced-collapse collapse" style="height: auto;">
                                    <div class="form-group">
                                        <div class="col-md-2 control-label"><label for="question-analysis-field">解析</label></div>
                                        <div class="col-md-8 controls">

                                            <div class="" id="question-analysis-field" style="width: 100%;height:100%;">
                                            	${question.analysis }
                                            </div>
                                            <%-- 
                                            <input type="hidden" name="analysis" value="${question.analysis }"/>
                                        	--%>
                                        	<textarea style="display: none;" name="analysis">
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
    if($("input[name=type][value=5]").prop('checked')){
    $(".answer-checkbox").each(function () {
    	$(this).attr("type","radio");
    		});
    }
       $("input[name=type]").change(function () {
		    var index=$(this).val();
	
		$(".answer-checkbox").each(function () {
		if(index==5){
			$(this).attr("type","radio");
		
			}
		if(index==0){
			$(this).attr("type","checkbox");
		
			}
		});
		//初始化选项编辑框对象
		var option_c_weditor;
		var option_d_weditor;
		var option_e_weditor;
	});
    
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
        var stemVal = $("textarea[name='stem']").val();
        if(stemVal!=''){
        	stem_weditor.txt.html(stemVal);
		}
		--%>
        <%--
        var item_height=120;
        CKEDITOR.replace("item-input-1", {
            skin : "moono-lisa",
            height : item_height,
            margin : "0,0,0,0",
            resize_enabled : false,
            toolbar :
                    'Minimal'
        });
        --%>
        <%--
        var option_a_Val = $("textarea[name='option_a']").val();
        if(option_a_Val!=''){
        	option_a_weditor.txt.html(option_a_Val);
		}
		--%>
        <%--
        CKEDITOR.replace("item-input-2", {
            skin : "moono-lisa",
            height : item_height,
            margin : "0,0,0,0",
            resize_enabled : false,
            toolbar :
                    'Minimal'
        });
        --%>
        <%--
        var option_b_Val = $("textarea[name='option_b']").val();
        if(option_b_Val!=''){
        	option_b_weditor.txt.html(option_b_Val);
		}
        --%>
        if($("#item-input-3").length>0){
        	<%--
        	CKEDITOR.replace("item-input-3", {
                skin : "moono-lisa",
                height : item_height,
                margin : "0,0,0,0",
                resize_enabled : false,
                toolbar :
                        'Minimal'
            });
            --%>
            var E = window.wangEditor;
            option_c_weditor = new E("#item-input-3");
            option_c_weditor.customConfig.menus = [
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
            option_c_weditor.customConfig.uploadImgServer = "${pageContext.request.contextPath}/upload_file/upload_resource.action?source_id=${courseView.id}&source_type=0";
            //限制图片大小
            option_c_weditor.customConfig.uploadImgMaxSize = 3*1024*1024;
            //图片上传上限
            option_c_weditor.customConfig.uploadImgMaxLength = 1;
            //隐藏"网络图片"选项
            option_c_weditor.customConfig.showLinkImg = false;
            option_c_weditor.create();
            var option_c_Val = $("textarea[name='option_c']").val();
            if(option_c_Val!=''){
            	option_c_weditor.txt.html(option_c_Val);
    		}
        }
        
        if($("#item-input-4").length>0){
        	<%--
            CKEDITOR.replace("item-input-4", {
                skin : "moono-lisa",
                height : item_height,
                margin : "0,0,0,0",
                resize_enabled : false,
                toolbar :
                        'Minimal'
            });
            --%>
            var E = window.wangEditor;
            option_d_weditor = new E("#item-input-4");
            option_d_weditor.customConfig.menus = [
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
            option_d_weditor.customConfig.uploadImgServer = "${pageContext.request.contextPath}/upload_file/upload_resource.action?source_id=${courseView.id}&source_type=0";
            //限制图片大小
            option_d_weditor.customConfig.uploadImgMaxSize = 3*1024*1024;
            //图片上传上限
            option_d_weditor.customConfig.uploadImgMaxLength = 1;
            //隐藏"网络图片"选项
            option_d_weditor.customConfig.showLinkImg = false;
            option_d_weditor.create();
            var option_d_Val = $("textarea[name='option_d']").val();
            if(option_d_Val!=''){
            	option_d_weditor.txt.html(option_d_Val);
    		}
        }
        
        if($("#item-input-5").length>0){
            <%--
        	CKEDITOR.replace("item-input-5", {
                skin : "moono-lisa",
                height : item_height,
                margin : "0,0,0,0",
                resize_enabled : false,
                toolbar :
                        'Minimal'
            });
			--%>
			var E = window.wangEditor;
            option_e_weditor = new E("#item-input-5");
            option_e_weditor.customConfig.menus = [
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
            option_e_weditor.customConfig.uploadImgServer = "${pageContext.request.contextPath}/upload_file/upload_resource.action?source_id=${courseView.id}&source_type=0";
            //限制图片大小
            option_e_weditor.customConfig.uploadImgMaxSize = 3*1024*1024;
            //图片上传上限
            option_e_weditor.customConfig.uploadImgMaxLength = 1;
            //隐藏"网络图片"选项
            option_e_weditor.customConfig.showLinkImg = false;
            option_e_weditor.create();
            var option_e_Val = $("textarea[name='option_e']").val();
            if(option_e_Val!=''){
            	option_e_weditor.txt.html(option_e_Val);
    		}
        }
		
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
        <%--
        var analysisVal = $("textarea[name='analysis']").val();
        if(analysisVal!=''){
        	analysis_weditor.txt.html(analysisVal);
		}
		--%>
        // 点击显示隐藏
        var type = 1;
        $('.dis_hide_analysis').click(function(){
            if (type == 1) {
                $('#advanced-collapse').slideDown();
                type = 2;
            }else if (type == 2) {
                $('#advanced-collapse').slideUp();
                type = 1;
            }
        });
        // 添加选项选项--动态添加
        $(".add-choice").on("click",function(){
            var choiceCount = $(".choice-label").length;
            if (choiceCount >= 5) {
                alert("选项最多五个!");
                return false;
            }
            var code = String.fromCharCode(choiceCount + 65);
            var code1=String.fromCharCode(choiceCount + 97);
            choiceCount++;
            var type="";
          if($("input[name=type][value=5]").prop('checked')){
           type="radio";
           }else{
           type="checkbox"; 
           }
            var str = '<div class="form-group"><div class="col-sm-2 control-label"><label class="choice-label" for="item-input-'+choiceCount+'">选项'+code+'</label></div><div class="col-sm-8 controls"><div class="item-input" id="item-input-'+choiceCount+'" style="width: 100%;height:100%;"></div><textarea style="display:none;" name="option_'+code1+'"></textarea><p class="mtm"><label><input type="'+type+'" class="answer-checkbox" name="right_key" value="'+code+'">正确答案</label></p></div><div class="col-sm-2" style="padding-left:0;"><a class="btn btn-default btn-sm delete-choice mlm" href="javascript:void(null)"><i class="glyphicon glyphicon-trash"></i></a></div></div>';
            $('#choices').append(str);
            /*
            CKEDITOR.replace("item-input-"+choiceCount, {
                skin : "moono-lisa",
                height : item_height,
                margin : "0,0,0,0",
                resize_enabled : false,
                toolbar :
                        'Minimal'
            });
            */
            var E = window.wangEditor;
            if(code==="A"){
            	option_a_weditor = new E("#item-input-"+choiceCount);
            	option_a_weditor.customConfig.menus = [
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
                option_a_weditor.customConfig.uploadImgServer = "${pageContext.request.contextPath}/upload_file/upload_resource.action?source_id=${courseView.id}&source_type=0";
                //限制图片大小
                option_a_weditor.customConfig.uploadImgMaxSize = 3*1024*1024;
                //图片上传上限
                option_a_weditor.customConfig.uploadImgMaxLength = 1;
                //隐藏"网络图片"选项
                option_a_weditor.customConfig.showLinkImg = false;
                option_a_weditor.create();
            }else if(code==="B"){
            	option_b_weditor = new E("#item-input-"+choiceCount);
            	option_b_weditor.customConfig.menus = [
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
                option_b_weditor.customConfig.uploadImgServer = "${pageContext.request.contextPath}/upload_file/upload_resource.action?source_id=${courseView.id}&source_type=0";
                //限制图片大小
                option_b_weditor.customConfig.uploadImgMaxSize = 3*1024*1024;
                //图片上传上限
                option_b_weditor.customConfig.uploadImgMaxLength = 1;
                //隐藏"网络图片"选项
                option_b_weditor.customConfig.showLinkImg = false;
                option_b_weditor.create();
            }else if(code==="C"){
            	option_c_weditor = new E("#item-input-"+choiceCount);
            	option_c_weditor.customConfig.menus = [
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
                option_c_weditor.customConfig.uploadImgServer = "${pageContext.request.contextPath}/upload_file/upload_resource.action?source_id=${courseView.id}&source_type=0";
                //限制图片大小
                option_c_weditor.customConfig.uploadImgMaxSize = 3*1024*1024;
                //图片上传上限
                option_c_weditor.customConfig.uploadImgMaxLength = 1;
                //隐藏"网络图片"选项
                option_c_weditor.customConfig.showLinkImg = false;
                option_c_weditor.create();
            }else if(code==="D"){
            	option_d_weditor = new E("#item-input-"+choiceCount);
            	option_d_weditor.customConfig.menus = [
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
                option_d_weditor.customConfig.uploadImgServer = "${pageContext.request.contextPath}/upload_file/upload_resource.action?source_id=${courseView.id}&source_type=0";
                //限制图片大小
                option_d_weditor.customConfig.uploadImgMaxSize = 3*1024*1024;
                //图片上传上限
                option_d_weditor.customConfig.uploadImgMaxLength = 1;
                //隐藏"网络图片"选项
                option_d_weditor.customConfig.showLinkImg = false;
                option_d_weditor.create();
            }else if(code==="E"){
            	option_e_weditor = new E("#item-input-"+choiceCount);
            	option_e_weditor.customConfig.menus = [
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
                option_e_weditor.customConfig.uploadImgServer = "${pageContext.request.contextPath}/upload_file/upload_resource.action?source_id=${courseView.id}&source_type=0";
                //限制图片大小
                option_e_weditor.customConfig.uploadImgMaxSize = 3*1024*1024;
                //图片上传上限
                option_e_weditor.customConfig.uploadImgMaxLength = 1;
                //隐藏"网络图片"选项
                option_e_weditor.customConfig.showLinkImg = false;
                option_e_weditor.create();
            }else{
            	return;
            }
        });
        
        /* 删除选项 */
        $("#choices").on("click",".delete-choice",function(){
            var choiceCount = $(".choice-label").length;
            if (choiceCount <= 2 ) {
                alert("选项至少二个!");
                return false;
            }
            var div_id = $(this).parent().parent().find(".item-input").attr("id");
            var div_index = parseInt(div_id.substring(div_id.length-1));
            $(this).parent().parent().remove();
            $("#choices>.form-group").each(function(index, item){
                var i=index;
                i++;
                $(this).find(".choice-label").html('选项' + String.fromCharCode(index + 65));
                $(this).find(".choice-label").attr("for","item-input-"+i);
                $(this).find(".item-input").attr("id","item-input-"+i);
                $(this).find("textarea").css("display","none").attr("name","option_"+String.fromCharCode(index + 97));
                $(this).find(".answer-checkbox").val(String.fromCharCode(index + 65));
            });
            if(div_index===1){
            	option_a_weditor=option_b_weditor;
	    		div_index++;
            }
            if(div_index===2){
            	option_b_weditor=option_c_weditor;
	    		div_index++;
            }
            if(div_index===3){
            	option_c_weditor=option_d_weditor;
	    		div_index++;
            }
            if(div_index<4){
            	option_d_weditor=option_e_weditor;
	    		div_index++;
            }
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
    //这里需要先将编辑框中的数据设置到hidden的表单元素中
    $("textarea[name = 'stem']").val(stem_weditor.txt.html());
    if(analysis_weditor.txt.html()==='<p><br></p>'){
    	$("textarea[name = 'analysis']").val('<p>无解析</p>');
    }else{
    	$("textarea[name = 'analysis']").val(analysis_weditor.txt.html());	
    }
   	var item_vail=true;
    //遍历选项并检验
    $(".item-input").each(function(){
    	var item_val="";
    	if(($(this).is($("#item-input-1")))){
    		$("textarea[name='option_a']").val(option_a_weditor.txt.html());
    		item_val = $("textarea[name='option_a']").val();
    	}else if(($(this).is($("#item-input-2")))){
    		$("textarea[name='option_b']").val(option_b_weditor.txt.html());
    		item_val = $("textarea[name='option_b']").val();
    	}else if(($(this).is($("#item-input-3")))){
    		$("textarea[name='option_c']").val(option_c_weditor.txt.html());
    		item_val = $("textarea[name='option_c']").val();
    	}else if(($(this).is($("#item-input-4")))){
    		$("textarea[name='option_d']").val(option_d_weditor.txt.html());
    		item_val = $("textarea[name='option_d']").val();
    	}else if(($(this).is($("#item-input-5")))){
    		$("textarea[name='option_e']").val(option_e_weditor.txt.html());
    		item_val = $("textarea[name='option_e']").val();
    	}
    	if(item_val==="<p><br></p>"){
            item_vail = false;
            return;
        }
    });
    if(!item_vail){
    	alert("请输入选项内容");
    	return false;
    }
    var type=$("input[name='type']:radio:checked").val();
    if(type==5){
 
	if($(".answer-checkbox:checked").length>1){
	 alert("单选题只有一个正确答案");
	 return false;
	};
	
    }
    	
        /* 手动同步编辑框最新内容到textarea中
   		for ( instance in CKEDITOR.instances )
            CKEDITOR.instances[instance].updateElement();
        */
   		var flag=false;
        <%--
        if($("input[name = 'stem']").val()==""){
            alert("请输入题干");
            return false;
        }
        --%>
        /*
        for(var i=1;i<6;i++){
            if($("#item-input-"+i).length>0&&$("#item-input-"+i).val()==""){
                alert("请输入选项内容");
                return false;
            }

        }
        */
        $(".answer-checkbox").each(function(){
            if(!flag){
                flag= $(this).prop("checked");
            }
        });
        if(!flag){
            alert("请选择正确答案");
            return false;
        }else{
            return true;
        }


    }
</script>


<%--<jsp:include page="../layout/footer.jsp"></jsp:include>--%>