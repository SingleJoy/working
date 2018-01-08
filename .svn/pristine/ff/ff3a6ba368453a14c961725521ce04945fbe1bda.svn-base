<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>


<link href="${pageContext.request.contextPath}/frontstage/css/nouislider.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/nouislider.js"></script>
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
    .testpaper-question-option-item{margin-left:-12px;margin-bottom:5px;}
</style>
<div class="cn-wrap">

    <div id="content-container" class="container">
        <jsp:include page="/frontstage/train/course/course_header.jsp"></jsp:include>

        <div class="row">
            <jsp:include page="/frontstage/train/course/course_left.jsp"></jsp:include>
            <div class="col-md-9">
                <div class="panel panel-default panel-col test-creator">
                    <div class="panel-heading clearfix">创建试卷</div>
                    <div class="panel-body">
                        <ol class="breadcrumb">
                            <li><a href="javascript:void(0);">试卷管理</a></li>
                            <li class="active">创建试卷</li>
                        </ol>

                        <form class="form-horizontal" method="post" action="${pageContext.request.contextPath}/testPaper/testPaper_add.action?courseId=${courseView.id}&flag=0&sign=11" id="form-horizontal">

                            <div class="form-group">
                                <div class="col-md-2 control-label"><label for="testpaper-name-field">试卷名称</label></div>
                                <div class="col-md-8 controls">
                                    <input class="form-control" value="" name="name" id="testpaper-name-field" >
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-md-2 control-label"><label >试卷说明</label></div>
                                <div class="col-md-8 controls">

                                	<div  id="explain"></div>
                                	<%-- 
                                	<input type="hidden" name="remarks" value=""/>
                                	--%>
                                	<textarea style="display: none;" name="remarks">
                                	</textarea>
                                	<script type="text/javascript">
	                                    var E = window.wangEditor;
	                                    var explain_weditor = new E("#explain");
	                                    explain_weditor.customConfig.menus = [
	                                                                          'bold',  // 粗体
	                                                                          'italic',  // 斜体
	                                                                          'underline',  // 下划线
	                                                                          'foreColor',  // 文字颜色
	                                                                          'backColor',  // 背景颜色
	                                                                          'link',  // 插入链接
	                                                                          'list',  // 列表
	                                                                          'justify',  // 对齐方式
	                                                                          'image',  // 插入图片
	                                                                          'table',  // 表格
	                                                                          'undo',  // 撤销
	                                                                          'redo'  // 重复
	                                                                      ];
	                                    //保存图片到服务器
	                                    explain_weditor.customConfig.uploadImgServer = "${pageContext.request.contextPath}/upload_file/upload_resource.action?source_id=${courseView.id}&source_type=0";
	                                    //限制图片大小
	                                    explain_weditor.customConfig.uploadImgMaxSize = 3*1024*1024;
	                                    //图片上传上限
	                                    explain_weditor.customConfig.uploadImgMaxLength = 1;
	                                    //隐藏"网络图片"选项
	                                    explain_weditor.customConfig.showLinkImg = false;
	                                    explain_weditor.create();
									</script>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-md-2 control-label"><label >时间限制</label></div>
                                <div class="col-md-8 controls">
                                    <input class="form-control width-input width-input-large" name="timeless" value="0" > 分钟
                                    <div class="help-block">0分钟，表示无限制</div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-md-2 control-label"><label >生成方式</label></div>
                                <div class="col-md-8 controls radios">
                                    <label><input type="radio" name="mode" value="0"  checked="checked"> 随机生成</label>
                                    <label><input type="radio" name="mode" value="1"> 按难易程度</label>
                                </div>
                            </div>

                            <div class="form-group difficulty-form-group slider-div" style="display: none">
                                <div class="col-md-2 control-label">
                                    <label>试卷难度</label>
                                </div>
                                <div class="col-md-8 controls form-control-static">
                                    <div  id="slider">

                                    </div>
                                    <div class="help-block">
                                        <span class="simple-percentage-text">简单30%</span>
                                        <span class="normal-percentage-text">一般40%</span>
                                        <span class="difficulty-percentage-text">困难30%</span>
                                        <br>
                                        <span class="text-info">如果某个难度的题目数不够，将会随机选择题目来补充。</span>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-md-2 control-label">
                                    <label >出题范围</label>
                                </div>
                                <div class="col-md-8 controls radios">
                                    <label><input type="radio" name="range" value="0" checked="checked" class="range"> 整个课程</label>
                                    <label><input type="radio" name="range" value="1" class="range"> 按课时范围</label>

                                    <div class="select-range" style="margin-top: 8px;display: none">
                                        <select id="testpaper-range-start" class="form-control width-input width-input-large" name="chapterListStart">
                                            <c:forEach items="${chapterList}" var="chapter" varStatus="status1">
                                                <option value="${chapter.id}"  <c:if test="${chapter.id==question.belong_to&&question.belong_type==1}">selected="selected"</c:if>>第${status1.index+1}章：${chapter.hour_title}</option>
                                            </c:forEach>
                                        </select>
                                        <span class="text-muted mrs">到</span>
                                        <select id="testpaper-range-end" class="form-control width-input width-input-large" name="chapterListEnd">
                                            <c:forEach items="${chapterList}" var="chapter" varStatus="status1">
                                                <option value="${chapter.id}"  <c:if test="${chapter.id==question.belong_to&&question.belong_type==1}">selected="selected"</c:if>>第${status1.index+1}章：${chapter.hour_title}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">

                                <div class="col-md-2 control-label"><label>题目设置</label></div>
                                <div class="col-md-10 controls" id="testpaper-question-options">

 									<div class="testpaper-question-option-item">
                                        <button type="button" class="btn btn-link testpaper-question-option-item-sort-handler"><span class="glyphicon glyphicon-move"></span></button>
                                        <span style="min-width:85px;display:inline-block;">单选题</span>
                                        <span class="mlm">题目数量:</span>
                                        <input type="text" class="form-control width-input width-input-mini input-sm item-number" name="countsOneChoice" value="0" id="countsOneChoice">/
                                        <span class="text-info question-num" role="questionNum" type="choice" id="selectOneQuestion">
                                        	<c:choose>
                                        		<c:when test="${questionView.oneSelectQuestion>0 }">
                                        			${questionView.oneSelectQuestion }
                                        		</c:when>
                                        		<c:otherwise>
                                        			0
                                        		</c:otherwise>
                                        	</c:choose>
                                        </span>

                                        <span class="mlm">题目分值:</span>
                                        <input type="text" class="form-control width-input width-input-mini input-sm item-score" name="scoresOneChoice" value="2">


                                    </div>
                                    <div class="testpaper-question-option-item">
                                        <button type="button" class="btn btn-link testpaper-question-option-item-sort-handler"><span class="glyphicon glyphicon-move"></span></button>
                                        <span style="min-width:85px;display:inline-block;">多选题</span>
                                        <span class="mlm">题目数量:</span>
                                        <input type="text" class="form-control width-input width-input-mini input-sm item-number" name="countsChoice" value="0" id="countsChoice">/
                                        <span class="text-info question-num" role="questionNum" type="choice" id="selectQuestion">
                                        	<c:choose>
                                        		<c:when test="${questionView.selectQuestion>0 }">
                                        			${questionView.selectQuestion }
                                        		</c:when>
                                        		<c:otherwise>
                                        			0
                                        		</c:otherwise>
                                        	</c:choose>
                                        </span>

                                        <span class="mlm">题目分值:</span>
                                        <input type="text" class="form-control width-input width-input-mini input-sm item-score" name="scoresChoice" value="2">


                                    </div>

                                    <div class="testpaper-question-option-item">
                                        <button type="button" class="btn btn-link testpaper-question-option-item-sort-handler"><span class="glyphicon glyphicon-move"></span></button>
                                        <span style="min-width:85px;display:inline-block;_display:inline;">填空题</span>
                                        <span class="mlm">题目数量:</span>
                                        <input type="text" class="form-control width-input width-input-mini input-sm item-number" name="countsFill" value="0" id="countsFill">/
                                        <span class="text-info question-num" role="questionNum" type="fill" id="fillQuestion">
                                        	<c:choose>
                                        		<c:when test="${questionView.fillQuestion>0 }">
                                        			${questionView.fillQuestion }
                                        		</c:when>
                                        		<c:otherwise>
                                        			0
                                        		</c:otherwise>
                                        	</c:choose>
                                        </span>
                                        <span class="mlm">题目分值:</span>
                                        <input type="text" class="form-control width-input width-input-mini input-sm item-score" name="scoresFill" value="2">
                                    </div>

                                    <div class="testpaper-question-option-item">
                                        <button type="button" class="btn btn-link testpaper-question-option-item-sort-handler"><span class="glyphicon glyphicon-move"></span></button>
                                        <span style="min-width:85px;display:inline-block;">判断题</span>
                                        <span class="mlm">题目数量:</span>
                                        <input type="text" class="form-control width-input width-input-mini input-sm item-number" name="countsJudge" value="0" id="countsJudge">/
                                        <span class="text-info question-num" role="questionNum" type="determine" id="judgeQuestion">
                                        	<c:choose>
                                        		<c:when test="${questionView.judgeQuestion>0 }">
                                        			${questionView.judgeQuestion }
                                        		</c:when>
                                        		<c:otherwise>
                                        			0
                                        		</c:otherwise>
                                        	</c:choose>
                                        </span>
                                        <span class="mlm">题目分值:</span>
                                        <input type="text" class="form-control width-input width-input-mini input-sm item-score" name="scoresJudge" value="2">
                                    </div>

                                    <div class="testpaper-question-option-item">
                                        <button type="button" class="btn btn-link testpaper-question-option-item-sort-handler"><span class="glyphicon glyphicon-move"></span></button>
                                        <span style="min-width:85px;display:inline-block;">问答题</span>
                                        <span class="mlm">题目数量:</span>
                                        <input type="text" class="form-control width-input width-input-mini input-sm item-number" name="countsQa" value="0" id="countsQa">/
                                        <span class="text-info question-num" role="questionNum" type="essay" id="qaQuestion">
                                        	<c:choose>
                                        		<c:when test="${questionView.qaQuestion>0 }">
                                        			${questionView.qaQuestion }
                                        		</c:when>
                                        		<c:otherwise>
                                        			0
                                        		</c:otherwise>
                                        	</c:choose>
                                        </span>
                                        <span class="mlm">题目分值:</span>
                                        <input type="text" class="form-control width-input width-input-mini input-sm item-score" name="scoresQa" value="2">
                                    </div>

                                    <div class="testpaper-question-option-item">
                                        <button type="button" class="btn btn-link testpaper-question-option-item-sort-handler"><span class="glyphicon glyphicon-move"></span></button>
                                        <span style="min-width:85px;display:inline-block;_display:inline;">材料题</span>
                                        <span class="mlm">题目数量:</span>
                                        <input type="text" class="form-control width-input width-input-mini input-sm item-number" name="countsScience" value="0" id="countsScience">/
                                        <span class="text-info question-num" role="questionNum" type="material" id="scienceQuestion">
                                        	<c:choose>
                                        		<c:when test="${questionView.scienceQuestion>0 }">
                                        			${questionView.scienceQuestion }
                                        		</c:when>
                                        		<c:otherwise>
                                        			0
                                        		</c:otherwise>
                                        	</c:choose>
                                        </span>
                                        <span class="mlm">题目分值:</span>
                                        <input type="text" class="form-control width-input width-input-mini input-sm item-score" name="scoresScience" value="2">
                                    </div>
                                </div>
                            </div>

                            <div class="form-group mbm">
                                <div class="col-md-8 col-md-offset-2 controls">
                                    <button type="button" class="btn btn-primary">保存，下一步</button>
                                    <a href="${pageContext.request.contextPath }/testPaper/to_testPaper.action?courseId=${courseView.id}&flag=2&sign=11" class="btn btn-link  ">返回</a>
                                </div>
                            </div>
                            <input type="hidden" value="0" name="simple_percentage"  id="simple-percentage">
                            <input type="hidden" value="0" name="normal_percentage"  id="normal-percentage">
                            <input type="hidden" value="0" name="difficulty_percentage"  id="difficulty-percentage">
                        </form>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>

</div>
<!-- 弹窗 -->
<div id="modal" class="modal" style="display: none;" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog  modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">题目预览</h4>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-link" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function(e){
        // 滑块
        var slider = document.getElementById('slider');
        noUiSlider.create(slider, {

            start: [30, 70],
            step: 5,
            serialization: {
                resolution: 1
            },
            range: {
                'min': 0,
                'max': 100
            }

        });
        slider.noUiSlider.on('update', function( values ) {


            var simplePercentage=parseInt(values[0]);

            var normalPercentage=parseInt(values[1] - values[0]);

            var difficultyPercentage=parseInt(100 - values[1]);
            $('.simple-percentage-text').html('简单' + simplePercentage + '%');
            $('.normal-percentage-text').html('一般' + normalPercentage + '%');
            $('.difficulty-percentage-text').html('困难' + difficultyPercentage + '%');
            $("#simple-percentage").val(simplePercentage);
            $("#normal-percentage").val(normalPercentage);
            $("#difficulty-percentage").val(difficultyPercentage);

        });
        /*编辑窗口
        var height = $('#explain').height();
        CKEDITOR.replace("explain", {
            skin : "moono-lisa",
            height : height,
            margin : "0,0,0,0",
            resize_enabled : false,
            toolbar :
                    'Minimal'
        });
        */
        //难易程度
        $("input[name=mode]").click(function(){
            $(this).prop("checked");
            var num = $(this).val();
            if (num == 0) {
                $('.slider-div').hide();
            }else if (num ==1) {
                $('.slider-div').show();
            }
        })
        // 出题范围
        $("input[name=range]").click(function(){
            $(this).prop("checked");
            var num = $(this).val();
            if (num == 0) {
                $('.select-range').hide();
            }else if (num ==1) {
                $('.select-range').show();
            }
        });
        //出题范围切换
        $(".range").click(function(){

            var value=$(this).val();
            if(value==0){
                selectQuestionTypeCount();
            }else{
                var start=$("#testpaper-range-start").val();
                var end=$("#testpaper-range-end").val();
                selectQuestionTypeCount(start,end);
            }

        });
        $("#testpaper-range-start").change(function(){

            var start=$("#testpaper-range-start").val();
            var end=$("#testpaper-range-end").val();
            if(start>=end){
                $("#testpaper-range-end>option").each(function(){
                    if($(this).val()<start){
                        $(this).remove();
                    }
                });
            }else{
                $("#testpaper-range-start>option").each(function(){

                    var _this=$(this).clone();
                    if($(this).val()>=start&&$(this).val()<end){
                        $("#testpaper-range-end").prepend(_this);
                    }

                });

            }
            start=$("#testpaper-range-start").val();
            end=$("#testpaper-range-end").val();
            selectQuestionTypeCount(start,end);
        });
        $("#testpaper-range-end").change(function(){

            var start=$("#testpaper-range-start").val();
            var end=$("#testpaper-range-end").val();
            selectQuestionTypeCount(start,end);
        });
        $(".btn-primary").click(function(){
            var name=$("#testpaper-name-field").val();
            if(name==null||name==""){
                alert("试卷名称不能为空");
                return false;
            }
            $("textarea[ name = 'remarks'").val(explain_weditor.txt.html());
            //for ( instance in CKEDITOR.instances )
            //    CKEDITOR.instances[instance].updateElement();
            var explain=$("textarea[ name = 'remarks'").val();
            if(explain==null||explain==="<p><br></p>"){
                alert("试卷说明不能为空");
                return false;
            }
            var countsOneChoice=$("#countsOneChoice").val();
            var countsChoice=$("#countsChoice").val();
            var countsFill=$("#countsFill").val();
            var countsJudge=$("#countsJudge").val();
            var countsQa=$("#countsQa").val();
            var countsScience=$("#countsScience").val();
            var selectOneQuestion=parseInt($("#selectOneQuestion").html());
            var selectQuestion=parseInt($("#selectQuestion").html());
            var fillQuestion=parseInt($("#fillQuestion").html());
            var judgeQuestion=parseInt($("#judgeQuestion").html());
            var qaQuestion=parseInt($("#qaQuestion").html());
            var scienceQuestion=parseInt($("#scienceQuestion").html());
            var scoresOneChoice = $("input[name='scoresOneChoice']").val();
            var scoresChoice = $("input[name='scoresChoice']").val();
            var scoresFill = $("input[name='scoresFill']").val();
            var scoresJudge = $("input[name='scoresJudge']").val();
            var scoresQa = $("input[name='scoresQa']").val();
            var scoresScience = $("input[name='scoresScience']").val();
            var re = /^[0-9]*$/;
            var score_reg = /^[0-9]+\.?[0-9]*$/;
            if(scoresOneChoice==""||scoresChoice==""||scoresFill==""||scoresJudge==""||scoresQa==""||scoresScience==""){
                alert("题目分值不能为空");
                return false;
            }
            if (!score_reg.test(scoresOneChoice)||!score_reg.test(scoresChoice)||!score_reg.test(scoresFill)||!score_reg.test(scoresJudge)||!score_reg.test(scoresQa)||!score_reg.test(scoresScience)) {
                alert("题目分值只能输入数字");
                return false;
            }
            var scoresOneChoiceNum = scoresOneChoice*1;
            var scoresChoiceNum = scoresChoice*1;
            var scoresFillNum = scoresFill*1;
            var scoresJudgeNum = scoresJudge*1;
            var scoresQaNum = scoresQa*1;
            var scoresScienceNum = scoresScience*1;
            if(scoresOneChoiceNum<=0||scoresChoiceNum<=0||scoresFillNum<=0||scoresJudgeNum<=0||scoresQaNum<=0||scoresScienceNum<=0){
            	alert("题目分值必须大于0");
                return false;
            }
            if(countsOneChoice==""||countsChoice==""||countsFill==""||countsJudge==""||countsQa==""||countsScience==""){
                alert("题目数量不能为空");
                return false;
            }
            if (!re.test(countsOneChoice)||!re.test(countsChoice)||!re.test(countsFill)||!re.test(countsJudge)||!re.test(countsQa)||!re.test(countsScience)) {
                alert("题目数量只能输入数字");
                return false;
            }if(countsOneChoice>selectOneQuestion||countsChoice>selectQuestion||countsFill>fillQuestion||countsJudge>judgeQuestion||countsQa>qaQuestion||countsScience>scienceQuestion){
                alert("选题数超过题库总数");
                return false;
            }
            var countsOneChoiceNum = parseInt(countsOneChoice);
            var countsChoiceNum = parseInt(countsChoice);
            var countsFillNum = parseInt(countsFill);
            var countsJudgeNum = parseInt(countsJudge);
            var countsQaNum = parseInt(countsQa);
            var countsScienceNum = parseInt(countsScience);
            var question_total = countsOneChoiceNum+countsChoiceNum+countsFillNum+countsJudgeNum+countsQaNum+countsScienceNum;
            if(isNaN(question_total)||question_total<=0){
            	alert("您还未设置试卷出题数,请先设置后保存");
                return false;
            }
            $("#form-horizontal").submit();
        });


    });
    function selectQuestionTypeCount(start,end){
        var belong_type=0;
        if(start!=null){
            belong_type=1;
        }else{
            start=0;
            end=0;
        }
        $.ajax({
            url : '${pageContext.request.contextPath}/testPaper/ajax_question_count.action',
            dataType : 'json',
            data:{
                belong_type:belong_type,
                chapterListStart:start,
                chapterListEnd:end,
                courseId:'${courseView.id}'
            },
            success : function(response) {
                $("#selectQuestion").html(response.questionView.selectQuestion);
                $("#fillQuestion").html(response.questionView.fillQuestion);
                $("#judgeQuestion").html(response.questionView.judgeQuestion);
                $("#qaQuestion").html(response.questionView.qaQuestion);
                $("#scienceQuestion").html(response.questionView.scienceQuestion);
            }
        });

    }
</script>

