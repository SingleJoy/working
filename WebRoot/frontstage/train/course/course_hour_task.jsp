<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>



<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/sortable.js"></script>
<%-- 
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/JMEditor/jmeditor/JMEditor.js"></script>
--%>
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/wangEditor/wangEditor.min.js"></script>
<div class="cn-wrap">

	<div id="content-container" class="container">
		 <jsp:include page="course_header.jsp"></jsp:include>
		<div class="row">
			<jsp:include page="course_left.jsp"></jsp:include>
            <div class="col-md-9">
                <div class="panel panel-default panel-col lesson-manage-panel" id="homework-items-manager">
                    <div class="panel-heading">

                        <ol class="breadcrumb">
                            <li><a href="${pageContext.request.contextPath}/course_hour/to_course_hour.action?id=${courseView.id}&flag=2&sign=4">课时管理</a></li>
                            <li class="active">添加作业</li>
                        </ol>

                    </div>
                    <div class="panel-body">
                       <form id="hourTask" class="form-horizontal lesson-form lesson-form-video" action="${pageContext.request.contextPath}/course_hour/save_course_hour.action" method="post">
						<input type="hidden" id="courseId" name="course_id" value="${courseView.id}"/>
						<input type="hidden" name="sign" value="${courseView.sign}"/>
						<input type="hidden" name="attribute_type" value="4"/>
						<input type="hidden" id="question_ids" name="question_ids" value=""/>
						<input type="hidden" id="question_seqs" name="question_seqs" value=""/>
						<input type="hidden" name="id" value=""/>
						<div class="form-group" id="parent_select">
								<div class="col-md-2 control-label"><label class="style1">所属章节</label></div>
								<div class="col-md-4 controls">
								   <select id="taskParentId"  name="parent_id" onchange="doSeq(this.value,${courseView.id});" class="form-control">
									<option value="0" >请选择所属章节</option>
									<c:forEach items="${chapterList }" var="chapter">
									<option value="${chapter.id}"  <c:if test="${chapter.id==courseHour.id}">selected="selected"</c:if> >${chapter.hour_title }</option>
									</c:forEach>
								  </select>
								</div>
								<div class="help-block parent_select" style="display: none;">
										<span class="text-danger">请选择所属章节</span>
								</div>
							</div>
                            <div class="form-group" id="task_input">
                                <div class="col-md-2 control-label"><label>作业标题</label></div>
                                <div class="col-md-8 controls" style="margin-top:7px">
                                    <input class="form-control" id="taskTitle" type="text" name="hour_title" />

									<div class="help-block title_val" style="display: none;">
										<span class="text-danger">请输入标题(标题长度不得超过18个字)</span>
									</div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-md-2 control-label"><label>作业说明</label></div>
                                <div class="col-md-8 controls">
                                    <textarea name="description" rows="10"  class="form-control" ></textarea>
                                </div>
                            </div>

							
							<div class="form-group">
								<%-- 
								<div class="col-md-2 control-label"><label class="style1">序号</label></div>
								--%>
								<div class="col-md-4 controls">
									<div class="row">
										<div class="col-md-9">
											<input class="form-control" type="hidden" name="hour_seq" value="${seq }" />
										</div>
									</div>
								</div>
							</div>
							<div class="form-group" id="choice_select_check">
								<div class="col-md-2 control-label"><label class="style1">批阅方式</label></div>
								<div class="col-md-6 controls radios">
                                    <label><input type="radio" value="0" checked="checked" name="check_status">老师评阅</label>
                                    <label><input type="radio" value="1" name="check_status">学生互评</label>
								 </div>
							</div>
							<div class="form-group" id="frequency" style="display: none">
								<div class="col-md-2 control-label"><label class="style1">互评次数</label></div>
								<div class="col-md-4 controls">
								  <select id="frequency_select"  name="frequency"  class="form-control">
									<option value="1">1</option>
									<option value="2" >2</option>
									<option value="3"  selected="selected">3</option>
									<option value="4" >4</option>
									<option value="5" >5</option>
								  </select>
								</div>
							</div>
						<div class="form-group" id="choice_select">
								<div class="col-md-2 control-label"><label class="style1">选题方式</label></div>
								<div class="col-md-4 controls radios">
                                    <label><input type="radio" value="0" name="choose_question" checked="checked">题库选题</label>
                                    <label><input type="radio" value="1" name="choose_question">自主创题</label>
								 </div>
							</div>
                        <hr>
                        <div id="choice0">
                        <div class="clearfix mbm">
                            <button type="button" data-toggle="modal"  onclick="openChooseQue(0,0);" class="btn btn-info btn-sm pull-right">
                                <span class="glyphicon glyphicon-plus" ></span>
                              	  选择题目
                            </button>
                        </div>

                            <table class="table  table-hover tab-content" id="homework-table" style="display: none">
                                <thead>
                                <tr>
                                    <th></th>
                                    <th><input type="checkbox" onclick="selectAll('taskQuestionId');">全选</th>
                                    <th>题号</th>
                                    <th width="40%">题干</th>
                                    <th>类型</th>
                                    <th>难度</th>
                                    <th width="25%">操作</th>
                                </tr>
                                </thead>
                                <tbody id="taskQuestion" >
                                  
                                </tbody>
                            </table>
                            <div id="homework-del" style="display: none">
                                <!-- <label class="checkbox-inline"><input type="checkbox" data-role="batch-select"> 全选</label> -->
                                <button type="button" class="btn btn-default btn-sm mlm" onclick="delAll(-1);">删除</button>
                            </div>
                            <div id="homework_items_help" class="help-block" style="display:none;">请选择题目</div>

                            <div class="form-group" id="homework-type" style="display: none">
 								<div class="col-md-12 controls correctPercentDiv">正确率达到为
                                    <input type="text" name="accordScores" class="form-control width-input width-input-mini correctPercent1" value="60">％合格，
                                    <input type="text" name="accordScores" class="form-control width-input width-input-mini correctPercent2" value="80">％良好，
                                    <input type="text" name="accordScores" class="form-control width-input width-input-mini correctPercent3" value="100">％优秀
                                </div>                                <div class="help-block col-md-12 correct_percent_help"></div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-8 controls">
                                    <p class="help-block">提示：作业保存以后将会添加到课时中去，作业一旦保存将不能修改。</p>
                                </div>
                                <div class="col-md-4 controls">
                                    <div class="btn btn-primary pull-right mlm confirm-submit" onclick="doTaskAdd();" data-saving-text="正在保存..." id="homework-save" style="display: none">保存</div>
                                </div>
                            </div>
                            </div>
                            <div id="choice1" style="display: none">
                              <div class="form-group">
                                    <div class="col-md-2 control-label"><label for="question-stem-field">题干</label></div>
                                    <div class="col-md-8 controls">
                                        <%-- 
                                        <textarea class="form-control" id="question-stem-field"  name="stem" style="height: 180px;"> ${question.stem }</textarea>
                                    	--%>
                                    	<div class="" id="question-stem-field" >
                                    		${question.stem }
                                    	</div>
                                    	<%-- 
                                    	<input type="hidden" name="stem" value="${question.stem }"/>
                                    	--%>
                                    	<textarea style="display: none;" name="stem">
                                    		${question.stem }
                                    	</textarea>
                                    	<script type="text/javascript">
		                                    var E = window.wangEditor;
		                                    var stem_weditor = new E("#question-stem-field");
		                                    stem_weditor.customConfig.menus = [
												'head',
												'bold',
												'italic',
												'underline',
												'strikeThrough',
												'link',
												'list',
												'justify',
												'image',  // 插入图片
												'table',  // 表格
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
                                    <div class="col-md-2 control-label"><label for="question-answer-field">答案</label></div>
                                    <div class="col-md-8 controls">
                                        <%-- 
                                        <textarea class="form-control" name="right_key" id="right_key"> ${question.right_key }</textarea>
                                    	--%>
                                    	<div class="" id="right_key">
                                    		${question.right_key }
                                    	</div>
                                    	<%-- 
                                    	<input type="hidden" name="right_key" value="${question.right_key }"/>
                                    	--%>
                                    	<textarea style="display: none;" name="right_key">
                                    		${question.right_key }
                                    	</textarea>
                                    	<script type="text/javascript">
		                                    var E = window.wangEditor;
		                                    var right_key_weditor = new E("#right_key");
		                                    right_key_weditor.customConfig.menus = [
		                       					'head',
		                       					'bold',
		                       					'italic',
		                       					'underline',
		                       					'strikeThrough',
		                       					'link',
		                       					'list',
		                       					'justify',
		                       					'image',
		                       					'table',
		                       					'undo',
		                       					'redo'
		                       		        ];
		                                    //保存图片到服务器
		                                    right_key_weditor.customConfig.uploadImgServer = "${pageContext.request.contextPath}/upload_file/upload_resource.action?source_id=${courseView.id}&source_type=0";
		                                    //限制图片大小
		                                    right_key_weditor.customConfig.uploadImgMaxSize = 3*1024*1024;
		                                    //图片上传上限
		                                    right_key_weditor.customConfig.uploadImgMaxLength = 1;
		                                    //隐藏"网络图片"选项
		                                    right_key_weditor.customConfig.showLinkImg = false;
		                                    right_key_weditor.create();
										</script>
                                    </div>
                                </div>
                               <div class="form-group">
                                <div class="col-md-8 controls">
                                    <p class="help-block">提示：作业保存以后将会添加到课时中去，作业一旦保存将不能修改。</p>
                                </div>
                                <div class="col-md-4 controls">
                                    <div class="btn btn-primary pull-right mlm confirm-submit" onclick="doTaskAddSelf();" data-saving-text="正在保存..." >保存</div>
                                </div>
                            </div>
                            </div>
                           </form>
                    </div>

                  <!--   <div id="homework-confirm-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                    <h4 class="modal-title">作业确认信息</h4>
                                </div>
                                <div class="modal-body">
                                    <p class="help-block"><span class="text-danger">提示</span>：作业保存以后将会添加到课时中去，作业一旦保存将不能修改。</p>
                                    <p>添加课后作业的课时应酌情增加学习时长用于完成作业</p>
                                </div>
                                <div class="modal-footer">
                                    <button class="btn btn-link" data-dismiss="modal" type="button">关闭</button>
                                    <button type="button" class="btn btn-primary confirm-submit" data-saving-text="正在保存..." >确定</button>
                                </div>
                            </div>
                        </div>
                    </div> -->
                </div>
            </div>
        </div>
    </div>
	<jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
</div>

<div class="modal" id="chooseQuestion"    role="dialog" aria-hidden="true">
    <div class="modal-dialog  modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">选择题目</h4>
            </div>
            <div class="modal-body">
                <div id="homework-item-picker-body">
                <form id="homework-item-picker-form" class="form-inline well well-sm" action="">
                	<input type="hidden" name="page" id="page" value=""/>
                
                    <div class="form-group">
                        <select class="form-control" id="belongTo" name="belong_to" style="width:200px;height:32px;">
                        </select>
                    </div>

                    <div class="form-group">
                        <input type="text" name="stem" id="questionStem" class="form-control" value="" placeholder="题干关键词">
                    </div>
                    <button class="btn btn-primary btn-sm" type="button" onclick="openChooseQue(1,0);">搜索</button>
				</form>
                <table class="table table-condensed" id="homework-item-picker-table">
                    <thead>
                    <tr>
                        <th id="chooseTh"><input type="checkbox" id="queChe" onclick="selectAll('quetsionId');">全选</th>
                        <th width="45%">题干</th>
                        <th>类型</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody id="questionsBody">
                    
                    </tbody>
                </table>
                <!-- <div id="homework-item-operate">
                    <label class="checkbox-inline"><input type="checkbox" onclick="selectAll();" > 全选</label>
                </div> -->
                <nav class="text-center">
	                <div id="test" class="pager">
			    	</div>
                </nav>
            </div>
            </div>
            <div class="modal-footer">    
            	<button type="button" class="btn btn-primary"  onclick="doConfirm();" >确定</button>
                <button type="button" class="btn btn-link pull-right" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<!--题目预览-->
<div id="preview-modal" class="modal in" aria-hidden="false" style="display: none;">
    <div class="modal-dialog  modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">题目预览</h4>
            </div>
            <div class="modal-body">


                <div class="testpaper-question testpaper-question-choice "  id="question136">

                    <div class="testpaper-question-body">
                        <div class="testpaper-question-stem-wrap clearfix">
                            <div class="testpaper-question-seq-wrap">
                                <div class="testpaper-question-seq"></div>
                                <div class="testpaper-question-score">2.0分</div>
                            </div>
                            <div class="testpaper-question-stem"><p>rgeg</p><br>
                            </div>
                        </div>
                        <ul class="testpaper-question-choices">

                            <li>
                                <span class="testpaper-question-choice-index">A.</span>
                                <p>hft</p>
                            </li>

                            <li>
                                <span class="testpaper-question-choice-index">B.</span>
                                <p>fhf</p>
                            </li>

                            <li >
                                <span class="testpaper-question-choice-index">C.</span>
                                <p>fhhf</p>
                            </li>

                            <li >
                                <span class="testpaper-question-choice-index">D.</span>
                                <p>fhf</p>
                            </li>
                        </ul>
                    </div>
                    <div class="testpaper-question-footer clearfix">

                        <div class="testpaper-question-choice-inputs">

                            <label class="radio-inline ">
                                <input type="radio" data-type="choice" name="136" value="0">
                                A
                            </label>

                            <label class="radio-inline ">
                                <input type="radio" data-type="choice" name="136" value="1">
                                B
                            </label>

                            <label class="radio-inline ">
                                <input type="radio" data-type="choice" name="136" value="2">
                                C
                            </label>

                            <label class="radio-inline ">
                                <input type="radio" data-type="choice" name="136" value="3">
                                D
                            </label>
                        </div>
                        <div class="testpaper-question-actions pull-right">


                        </div>
                    </div>

                    <div class="testpaper-preview-answer clearfix mtl mbl">
                        <div class="testpaper-question-result">
                            正确答案是 <strong class="text-success">C</strong>
                        </div>
                    </div>

                    <div class="testpaper-question-analysis well">无解析</div>


                </div>


            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
$(function() {
   /*
   var height = $('#question-stem-field').height();
        CKEDITOR.replace("question-stem-field", {
            skin : "moono-lisa",
            height : height,
            margin : "0,0,0,0",
            resize_enabled : false,
            toolbar :
                    'Minimal'
        });
	*/
	/*
        CKEDITOR.replace("right_key", {
            skin : "moono-lisa",
            height : height,
            margin : "0,0,0,0",
            resize_enabled : false,
            toolbar :
                    'Minimal'
        });
	*/
$("input[name='choose_question']:first").prop('checked',true); 
$("input[name='choose_question']:last").prop('checked',false);
$("input[name='check_status']:first").prop('checked',true); 
$("input[name='check_status']:last").prop('checked',false); 	 	
	$("input[name='choose_question']").change(function() {
		if($(this).val()==1){
		$("#choice0").hide();
		$("#choice1").show();
		}else{
		$("#choice0").show();
		$("#choice1").hide();
		}
	});
	$("input[name='check_status']").change(function() {
	$("#taskQuestion").html("");
	score=0.0;
		if($(this).val()==1){
		$("#frequency").show();
		}else{
		$("#frequency").hide();
		}
	});
	
});

//打开题目弹窗
function openChooseQue(value,qId){
	var page = $("#page").val();
	if(value==0 || value==-1){
		page=0;
		$("#chooseQuestion").modal();
	}
	//已选择的题目
	var a = document.getElementsByName("taskQuestionId");
	var ids = "";
	for(var i = 0;i<a.length;i++){
		ids += a[i].value + ",";
	}
	
	//搜索
	var  questionStem = $("#questionStem").val();
	if(questionStem!=""){
		page = 0;
	}
	var  belong_to = $("#belongTo").find("option:selected").val();
	if(belong_to==0){//没有选择
		belong_to = "";
	}else{
		page = 0;
	}
	
	$.ajax({
		url:"${pageContext.request.contextPath}/question/query_all_question.action",
		data:{
			courseId : $("#courseId").val(),
			ids : ids,
			stem : questionStem,
			belong_to : belong_to,
			page : page
		},
		dataType:'json',
		success:function(d){
			if(d==0){//没有问题
				
			}else{
			
		
				var queView = d[0].questionView;
				var questions = d[0].questionList;
				var chapters = d[0].chapterList;
				if(questions.length==0){
					$(".text-center").hide();
				}else{
					$(".text-center").show();
				}
				var html="";
				for(var i=0;i<questions.length;i++){
					var question = questions[i];
						if($("#choose_check").val()==1){
							if(question.type!=3){
							continue;//暂时这样限制，
							//以后将此作为参数传入后台，就可以解决分页的问题
							};
				
				}
					if(i%2==0){
						html +='<tr>';
					}else{
						html +='<tr style=" border: none;">';
					}
					html +='<th id="chooseTh"><input type="checkbox" name="quetsionId" value="'+question.id+'"></th>'+
					    '<td>'+question.stem+'<br>'+
					        '<small class="text-muted">从属：课程 </small>'+
					    '</td>'+
					    '<td>';
					 html +=doType(question.type);
					 html +='</td>'+
					    '<td>'+
					        '<button  class="btn btn-default btn-sm newWindowPreview">预览</button>';
					        if(value==-1){//替换
					        	 html +='<button type="button" class="btn btn-primary btn-sm" onclick="doChooseQue('+question.id+','+qId+');" >替换</button>';
					        }else{//选择
					        	 html +='<button type="button" class="btn btn-primary btn-sm" onclick="doChooseQue('+question.id+',0);" >选择</button>';
					        }
					 html +='</td>'+
					'</tr>';
				}
				$("#questionsBody").empty().append(html);
				$("#queChe").attr("checked",false);  
				$("#page").val(queView.page);
				if(value==0){
					doPages(queView.rows,queView.total);
				}
				var chapterHtml = '<option value="0" selected="selected">--按从属--</option>';
					chapterHtml +='<option';
				if(queView.belong_to==-1){
					chapterHtml +=' selected="selected"';
				}
				chapterHtml += ' value="-1">本课程</option>';
                				
				for(var i=0;i<chapters.length;i++){
					chapterHtml +='<option';
					if(chapters[i].id==queView.belong_to){
						chapterHtml +=' selected="selected"';
					}
					chapterHtml += ' value="'+chapters[i].id+'">'+chapters[i].hour_title+'</option>';
				}
				$("#questionStem").val(queView.stem);
				$("#belongTo").empty().append(chapterHtml);
			}
		}
	});
}

function doType(type){
	var str="";
	if(type==0){
		str = '多选';
	}else if(type==1){
		str = '填空';
	}else if(type==2){
		str = '判断';
	}else if(type==3){
		str = '问答';
	}else if(type==4){
		str = '材料';
	}else if(type==5){
		str = '单选';
	}
	return str;
}
function doPages(rows,total){
  	//翻页
  	var page =  parseInt($("#page").val())+1;
      $("#btn5").on('click', function () {
          $("#div1").PageChanged(5);
      });

      $(".pager").pagination({
      	thisPageIndex:page,
          recordCount: total,       //总记录数
          pageSize: rows,           //一页记录数
          onPageChange: function (page) {
      		$("#page").val(page-1);
      		openChooseQue(1,0);
          }
      });
}
//选择题目
var score=0.0;
function doChooseQue(id,qId){
	$.ajax({
		url:"${pageContext.request.contextPath}/question/search_question.action",
		data:{
			questionIds : id
		},
		dataType:'json',
		success:function(d){
			if(d==0){//没有问题
				
			}else{
				var html ="";
				for(var i=0;i<d.length;i++){
					var a = document.getElementsByName("taskQuestionId");
					var maxId = "";
					if(a.length!=0){
						maxId = parseInt($("#trSeq"+a[a.length-1].value).text())+1;
					}else{
						maxId = i+1;
					}
					score+=d[i].score;
					html +='<tr id="trQue'+d[i].id+'" class="is-question">'+
				    '<td><span class="glyphicon glyphicon-resize-vertical sort-handle"></span></td>'+
				    '<td>'+
				        '<input class="notMoveHandle" type="checkbox" value="'+d[i].id+'" name="taskQuestionId">'+
				    '</td>'+
				    '<td class="seq" id="trSeq'+d[i].id+'">'+maxId+'</td>'+
				    '<td>'+d[i].stem+
				    	'<div class="text-muted text-sm">  从属：本课程</div>'+
				    '</td>'+
				    '<td>'+doType(d[i].type)+'</td>'+
				    '<td>';
				    if(d[i].difficulty==1){
				    	html +='一般';
				    }else if(d[i].difficulty==0){
				    	html +='简单';
				    }else if(d[i].difficulty==2){
				    	html +='困难';
				    }
					html +='</td>'+
					    '<td>'+
					        '<div class="btn-group">'+
					            '<a href="#preview-modal" data-toggle="modal" class="notMoveHandle btn btn-default btn-sm" >预览</a>'+
					            '<a href="javascript:void(0);" onclick="delAll('+d[i].id+');" class="notMoveHandle btn btn-default btn-sm item-delete-btn">删除</a>'+
					            '<a href="javascript:void(0);" onclick="openChooseQue(-1,'+d[i].id+');" class="notMoveHandle btn btn-default btn-sm" >替换</a>'+
					        '</div>'+
					    '</td>'+
					  '</tr>';
				}
				delAll(qId);
				$("#homework-table").show();
				$("#homework-del").show();
				$("#homework-type").show();
				$("#homework-save").show();
				$("#taskQuestion").append(html);
				$('#chooseQuestion').modal('hide');
				doDrag();
			}
		}
	}); 
}
//选中全部
function selectAll(value){
	var a = document.getElementsByName(value);
	if(a[0].checked){
		for(var i = 0;i<a.length;i++){
			if(a[i].type == "checkbox") a[i].checked = false;
		}
	}else{
		for(var i = 0;i<a.length;i++){
			if(a[i].type == "checkbox") a[i].checked = true;
		}
	}
}
//确定问题
function doConfirm(){
	var a = document.getElementsByName("quetsionId");
		var ids = "";
		for(var i = 0;i<a.length;i++){
			if(a[i].checked){
				ids +=a[i].value +",";
			}
		}
		if(ids!=''){
			doChooseQue(ids,0);
		}
}

//删除题目
function delAll(value){
	if(value==-1){
		var a = document.getElementsByName("taskQuestionId");
		for(var i = 0;i<a.length;i++){
			$("#trQue"+a[i].value).remove();
		}
		     $("#homework-table").hide();
				$("#homework-del").hide();
				$("#homework-type").hide();
				$("#homework-save").hide();
	}else{
		$("#trQue"+value).remove();
	var index=$("#taskQuestion>tr").index();
	if(index==-1){
	 $("#homework-table").hide();
				$("#homework-del").hide();
				$("#homework-type").hide();
				$("#homework-save").hide();
	}
	}
}
//自主添加作业
function doTaskAddSelf(){
	var val = vilidateTaskSelf();
	if(val){
     		var form=$("#hourTask");
	
	form.attr("action","${pageContext.request.contextPath}/course_hour/save_task_self.action");
	form.submit();
	}else{
	return false;
	}
}
//自主添加作业验证
function vilidateTaskSelf(){
	var title = $("#taskTitle").val();
	var parent = $('#taskParentId option:selected').val();
	var ids = "";
	var seqs = "";
	var title_val = false;
	var parent_val = false;
	if(title==""||title.length>18){
		$("#task_input").addClass("has-error");
		$("#task_input").find(".help-block").show();
	}else{
		$("#task_input").removeClass("has-error");
		$("#task_input").find(".help-block").hide();
		title_val = true;
	}
	
	if(parent==0){
		$("#parent_select").addClass("has-error");
		$("#parent_select").find(".help-block").show();
	}else{
		$("#parent_select").removeClass("has-error");
		$("#parent_select").find(".help-block").hide();
		parent_val =  true;
	}
	  //for ( instance in CKEDITOR.instances )
      //      CKEDITOR.instances[instance].updateElement();
	$("textarea[ name = 'stem' ]").val(stem_weditor.txt.html());
	$("textarea[ name = 'right_key' ]").val(right_key_weditor.txt.html());
	if($("textarea[ name = 'stem' ]").val()==="<p><br></p>"){
            alert("请输入题干");
            return false;
        }else if($("textarea[ name = 'right_key' ]").val()==="<p><br></p>"){
            alert("请输入答案");
            return false;
        }else{
         	if(title_val==true&&parent_val==true){
		return true;
		}else{
		return false;
		}
        }

	
	
}
//添加作业
function doTaskAdd(){

if(!checkCorrectPercent()){
return false;
}
	var val = vilidateTask();
	if(val){
	if($("#choose_check").val()==1){
	if(score!=100){
	alert("互评需要总分100分");
	return false;
	}
	}
     	document.getElementById('hourTask').submit();
	}else{
		return false;
	}
}
//验证百分比
function checkCorrectPercent() {
	  		var isEmpty = false;
            var isInteger = true;
            var $error = $('.correct_percent_help');
            var isSame = false;
            var valArr = [];
            $('input[name="accordScores"]').each(function() {
                var val = $(this).val();
                if (val == '') {
                    isEmpty = true;
                }
                var isPositive_integer = /^[0-9]*[1-9][0-9]*$/.test(val);
                if (!isPositive_integer || Number(val) > 100) {
                    isInteger = false;
                }
                
                valArr.push(Number(val));
            })

            if (isEmpty) {
                $error.html('请输入正确率').css('color', '#a94442');
                return false;
            }

            if (!isInteger) {
                $error.html('正确率只能是<=100、且>0的整数').css('color', '#a94442');
                return false;
            }

            if (valArr[0] >= valArr[1] || valArr[1] >= valArr[2] || valArr[0] >= valArr[2]) {
                $error.html('正确率不能相等且要依次递增').css('color','#a94442');
                return false;
            }

            $error.html('');
            return true;
}
//验证讨论
function vilidateTask(){
	var title = $("#taskTitle").val();
	var parent = $('#taskParentId option:selected').val();
	var que = document.getElementsByName("taskQuestionId");
	
	var ids = "";
	var seqs = "";
	var title_val = false;
	var parent_val = false;
	var que_val = false;
	if(title==""){
		$("#task_input").addClass("has-error");
		$("#task_input").find(".help-block").show();
	}else{
		$("#task_input").removeClass("has-error");
		$("#task_input").find(".help-block").hide();
		title_val = true;
	}
	
	if(parent==0){
		$("#parent_select").addClass("has-error");
		$("#parent_select").find(".help-block").show();
	}else{
		$("#parent_select").removeClass("has-error");
		$("#parent_select").find(".help-block").hide();
		parent_val =  true;
	}
		if(que.length!=0){
		
			for(var i = 0;i<que.length;i++){
				ids += que[i].value + ",";
				seqs += $("#trSeq"+que[i].value).text() + ",";
			}
			$("#question_ids").val(ids);
			$("#question_seqs").val(seqs);
		
	}else{
	return false;
	}
	que_val = true;
	if(title_val==true&&parent_val==true&&que_val==true){
		return true;
	}else{
		return false;
	}
}

function doDrag(){
//  拖拽
    (function (){

        window.x = new Sortable(taskQuestion, {
            group: "words",
            store: {
                get: function (sortable) {
                    var order = localStorage.getItem(sortable.options.group);
                    return order ? order.split('|') : [];
                },
                set: function (sortable) {
                    var order = sortable.toArray();
                    localStorage.setItem(sortable.options.group, order.join('|'));
                }
            },
            onEnd: function(evt){ 
            	var a = document.getElementsByName("taskQuestionId");
            	for(var i = 0;i<a.length;i++){
            		$("#trSeq"+a[i].value).empty().append(i+1);
            	}
            }
        });

    })();
}

//查询章节排序
function doSeq(value,courseId){
	$.ajax({
		url:"../course_hour/search_seq.action?ver="+Math.ceil(Math.random()*100),
		data:{
			courseId:courseId,
			parentId:value
		},
		dataType:'json',
		success:function(d){
			$("[name='hour_seq']").val(d);
		}
	});
}
</script>
