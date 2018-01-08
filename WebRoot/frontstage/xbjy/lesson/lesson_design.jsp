<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>




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

			<c:if test="${lessonLeft.plan101==1}">
            <div class="col-lg-9 col-md-8  course-detail-main">

                <div class="panel panel-default panel-col course-data">
                    <div class="panel-heading">教学设计与参考</div>
                    <div class="panel-body">
                        <h4 class="text-center" style="font-weight: bold;margin:10px 0;">教学设计及参考</h4>
                        <form  action="" method="post" class="form-horizontal" id="form">
                            <input type="hidden" value="${lessonView.id}" name="lesson_id">
                            <input type="hidden" value="" name="fileUrl" id="fileUrl">
                            <input type="hidden" name="stamp" id="stamp" value="${stamp}"/>
							<input type="hidden" name="state" id="state" value="${state}"/>
                            <c:if test="${!empty lessonDesign.id}">
                                <input type="hidden" value="${lessonDesign.id }" name="id">
                            </c:if>
                            <div class="form-group " style="margin-top: 30px;">
                                <div class="col-md-3 control-label"><label>教学课程 / 教材版本</label></div>
                                <div class="col-md-7 controls">
                                    <input type="text"  name="" value="《${lessonView.name }》/ ${lessonView.versionName }" class="form-control" disabled>
                                </div>

                            </div>

                            <div class="form-group">
                                <div class="col-md-3 control-label"><label>学段 / 学科 / 年级</label></div>
                                <div class="col-md-7 controls">
                                    <input type="text"  name="" value="${lessonView.stageName } / ${lessonView.subjectName } / ${lessonView.grade_name }" class="form-control" disabled>
                                </div>

                            </div>

                            <div class="form-group">
                                <div class="col-md-3 control-label"><label>授课教师 / 工作单位</label></div>
                                <div class="col-md-7 controls">
                                    <input type="text"  name="" value="${lessonView.user_sk_name } / ${lessonView.school }" class="form-control" disabled>
                                </div>
                            </div>


                            <div class="form-group" >
                                <label class="col-md-3 control-label"><span class="text-danger">*</span>教育目标</label>
                                <div class="col-md-7 controls">
                                    <!--编辑器-->
                                    <textarea  class="form-control textarea"  rows="5" placeholder="教学活动实施的方向和预期达成的结果" name="edu_goal">${lessonDesign.edu_goal }</textarea>
                                    <div class="help-block" style="display:none;"></div>
                                </div>
                            </div>


                            <div class="form-group" >
                                <div class="col-md-3 control-label"><label>课时划分</label></div>
                                <div class="col-md-7 controls">
                                    <input type="text"   value="${lessonDesign.lesson_divide }" class="form-control" placeholder="课时的安排" name="lesson_divide">
                                </div>

                            </div>

                            <div class="form-group" >
                                <label class="col-md-3 control-label"><span class="text-danger">*</span>教材及内容分析</label>
                                <div class="col-md-7 controls">
                                    <!--编辑器-->
                                    <textarea  class="form-control textarea" rows="5" placeholder="结合教育教学理念、新课标、教材、教参、教学资料等，基于给定的教材，教师通过对教材内容的分进行分析理解" name="materials_analysis">${lessonDesign.materials_analysis }</textarea>
                                    <div class="text-warning" style="display:none;">教材及内容分析</div>
                                </div>
                            </div>

                            <div class="form-group" >
                                <label class="col-md-3 control-label"><span class="text-danger">*</span>学生学情分析</label>
                                <div class="col-md-7 controls">
                                    <!--编辑器-->
                                    <textarea  class="form-control textarea" rows="5" placeholder="学生在学习方面有何特点、学习方法怎样、习惯怎样、兴趣如何,成绩如何等。设计理念包括教学方法和学法指导,以及教学设想" name="student_analysis">${lessonDesign.student_analysis }</textarea>
                                    <div class="text-warning" style="display:none;">学生学情分析</div>
                                </div>
                            </div>

                            <div class="form-group" >
                                <label class="col-md-3 control-label"><span class="text-danger">*</span>教学策略选择与设计</label>
                                <div class="col-md-7 controls">
                                    <!--编辑器-->
                                    <textarea  class="form-control textarea" rows="5" placeholder="在教学过程中，为完成特定的目标，依据教学的主客观条件，特别是学生的实际，对所选用的教学顺序、教学活动程序、教学组织形式、教学方法和教学媒体等的总体考虑" name="strategy_design">${lessonDesign.strategy_design }</textarea>
                                    <div class="text-warning" style="display:none;">教学策略选择与设计</div>
                                </div>
                            </div>


                            <div class="form-group" >
                                <label class="col-md-3 control-label"><span class="text-danger">*</span>教学重点与难点</label>
                                <div class="col-md-7 controls">
                                    <!--编辑器-->
                                    <textarea  class="form-control textarea" rows="5" placeholder="描述出什么是教学重点与难点、制定重点与难点的依据和方法有哪些" name="focus_difficulty" >${lessonDesign.focus_difficulty }</textarea>
                                    <div class="text-warning" style="display:none;">教学重点与难点</div>
                                </div>
                            </div>

                            <div class="form-group" >
                                <label class="col-md-3 control-label">教学媒体（资源）选择</label>
                                <div class="col-md-7 controls">
                                    <!--编辑器-->
                                    <textarea  class="form-control textarea" rows="5" placeholder="为了完成既定的教学任务，在丰富多采、功能各异的教学媒体中选择哪一种或哪几种的组合最为合适、最为有效呢？其选择的依据是什么？" name="media_selection">${lessonDesign.media_selection }</textarea>
                                </div>
                            </div>

                            <div class="form-group" >
                                <label class="col-md-3 control-label"><span class="text-danger">*</span>教学过程</label>
                                <div class="col-md-7 controls">
                                    <!--编辑器-->
                                    <textarea  class="form-control textarea" rows="5" placeholder="教学实施过程中的描述" name="teaching_process" id="teaching_process">${lessonDesign.teaching_process }</textarea>
                                    <div class="text-warning" style="display:none;">教学过程</div>
                                </div>
                            </div>

                            <div class="form-group" >
                                <label class="col-md-3 control-label">板书设计</label>
                                <div class="col-md-7 controls">
                                    <!--编辑器-->
                                    <textarea  class="form-control textarea" rows="5" placeholder="板书设计" name="typography_design">${lessonDesign.typography_design }</textarea>
                                </div>
                            </div>
                            <c:if test="${tab!=1 }">
                                <div class="form-group" >
                                    <label class="col-md-3 control-label">上传附件</label>
                                    <div class="col-md-7 controls">
                                      <c:forEach items="${lessonAttachmentViews}" var="view">
                                                        <a href="javascript:void (0);" class="text-info old_file" data-id="${view.id }">${view.name }</a>
                                                        <br class="old_file">
                                                    </c:forEach>
                                        <a class="btn btn-fat btn-info pull-right" id="file"><c:if test="${tab!=0 }">重新</c:if>添加附件</a>
                                        <!--上传成功之后显示-->
                                    </div>
                                </div>
                            </c:if>

                            <div class="form-group" style="margin-top: 60px;">

                                <div class="col-md-offset-2 col-md-2 controls ">
                                    <button type="button"  class="btn btn-fat btn-primary" id="saveAndSubmit">保存并提交</button>
                                </div>
                                <c:if test="${tab==0||tab==1 }">
                                    <div class="col-md-2 controls" style="margin-left: 30px;">
                                        <button type="button"  class="btn btn-fat btn-primary" id="onlySave">仅保存</button>
                                    </div>
                                </c:if>

                            </div>

                        </form>
                    </div>


                </div>
            </div>
		</c:if>
		<c:if test="${lessonLeft.plan101==0}">
		<div class="panel panel-default panel-col ">
                        <div class="panel-heading">未制定计划</div>
                        <div class="panel-body" style="text-align: center;">
                            <img src="${pageContext.request.contextPath}/frontstage/images/lesson_task_unfinshed.png" style="margin-top: 20px auto;">
                            <div>未制定计划</div>
                        </div>
                    </div>
		</c:if>
        </div>
    </div>


    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
</div>





<script type="text/javascript">
    $(function(){
//编辑器
      var flag='${update}';
      if(flag){
     $(".textarea").each(function() {
		 var name=$(this).attr("name");
		 CKEDITOR.replace(name, {
                skin : "moono-lisa",
                resize_enabled : false,
                toolbar :
                        'Minimal'
            });
	});
      }

        $("textarea").click(function() {
            var name=$(this).attr("name");
            CKEDITOR.replace(name, {
                skin : "moono-lisa",
                resize_enabled : false,
                toolbar :
                        'Minimal'
            });
        });


//上传
        var uploader = WebUploader.create({
            auto: true,
            // swf文件路径
            swf: '${pageContext.request.contextPath}/frontstage/js/webuploader/Uploader.swf',
            // 文件接收服务端。
            server: '${pageContext.request.contextPath}/lesson_attachment/upload.action?purview=102&lesson_id=${lessonView.id}',

            // 选择文件的按钮。可选。
            // 内部根据当前运行是创建，可能是input元素，也可能是flash.
            pick: '#file',

            // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
            resize: false,
            accept: {
                extensions: 'pdf,txt,doc,docx',
                mimeTypes: '.pdf,.txt,.doc,.docx'   //修改这行
            }
        });
        /**
         *上传成功后
         *file:文件
         *response:服务器返回
         */
        uploader.on( 'uploadSuccess', function( file,response  ) {
//		var hidden=$('<input type="hidden" value="'+response.fileName+'" name="lesson_pic" class="hidden">' );
//		var $form=$("#saveLessonPlan");
//		$form.append(hidden);
//
            $(".old_file").remove();  
            $("#fileUrl").val('${pageContext.request.contextPath}'+response.url);
            $("#file").after('<a class="text-info enclosure_list" href="${pageContext.request.contextPath}'+response.url+'">'+response.fileName+'</a><br>');
            //document.getElementById("lesson_pic").value = response.fileName;
        });

        // 当有文件添加进来的时候
        uploader.on( 'fileQueued', function( file ) {

            // <input type="hidden">
            var $img;
            var $li = $(
                            '<div id="' + file.id + '" class="file-item thumbnail">' +
                            '<img style="">' +
                                /*  '<div class="info">' + file.name + '</div>' + */
                            '</div>'
                    ),
                    $img = $li.find('img');
            var   $list=$("#fileList");

            // $list为容器jQuery实例
//		$list.append( $li );

            $("#save_course_picture_content").css("display","");


        });
        $("#onlySave").click(function(){

            var form=$("#form");
            form.attr("action","${pageContext.request.contextPath}/lesson_design/saveOrUpdate.action?status=0&tab=${tab}");
           for ( instance in CKEDITOR.instances )
            CKEDITOR.instances[instance].updateElement();
            
     	 var edu_goal= $("textarea[name=edu_goal]").val();
     	 var materials_analysis=$("textarea[name=materials_analysis]").val();
      	 var student_analysis=$("textarea[name=student_analysis]").val();
       	 var strategy_design=$("textarea[name=strategy_design]").val();
         var focus_difficulty=$("textarea[name=focus_difficulty]").val();
         var teaching_process=$("textarea[name=teaching_process]").val();
         if(edu_goal==""){
         alert("教育目标不能为空");
         return false;
         }
          if(materials_analysis==""){
         alert("教材及内容分析不能为空");
         return false;
         }
          if(student_analysis==""){
         alert("学生学情分析不能为空");
         return false;
         }
          if(strategy_design==""){
         alert("教学策略选择与设计不能为空");
         return false;
         }
          if(focus_difficulty==""){
         alert("教学重点与难点不能为空");
         return false;
         }
          if(teaching_process==""){
         alert("教学过程不能为空");
         return false;
         }
           
            form.submit();

        });
        $("#saveAndSubmit").click(function(){

            var form=$("#form");
            form.attr("action","${pageContext.request.contextPath}/lesson_design/saveOrUpdate.action?status=1&tab=${tab}");
       for ( instance in CKEDITOR.instances )
            CKEDITOR.instances[instance].updateElement();
            
     	 var edu_goal= $("textarea[name=edu_goal]").val();
     	 var materials_analysis=$("textarea[name=materials_analysis]").val();
      	 var student_analysis=$("textarea[name=student_analysis]").val();
       	 var strategy_design=$("textarea[name=strategy_design]").val();
         var focus_difficulty=$("textarea[name=focus_difficulty]").val();
         var teaching_process=$("textarea[name=teaching_process]").val();
         if(edu_goal==""){
         alert("教育目标不能为空");
         return false;
         }
          if(materials_analysis==""){
         alert("教材及内容分析不能为空");
         return false;
         }
          if(student_analysis==""){
         alert("学生学情分析不能为空");
         return false;
         }
          if(strategy_design==""){
         alert("教学策略选择与设计不能为空");
         return false;
         }
          if(focus_difficulty==""){
         alert("教学重点与难点不能为空");
         return false;
         }
          if(teaching_process==""){
         alert("教学过程不能为空");
         return false;
         }
            form.submit();

        });



    });
</script>

