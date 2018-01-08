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
<link href="${pageContext.request.contextPath}/frontstage/css/upload_file.css?v.01" rel="stylesheet" type="text/css">



<script>
    $(document).ready(function(){
        $("#myNav").affix({
            offset: {
                top: 20
            }
        });
    });
    $(function () {
        $("li.list-group-item").click(function () {
            $(this).addClass("active").siblings().removeClass("active");
        })
    })
</script>


<div class="cn-wrap">

    <div  class="container" id="content-container" style="margin-top: 20px;">

        <div class="row" >

            <div class="col-md-3 col-lg-3 container-fluid-content" id="myScrollspy">

                <div class="container-fluid" >
                    <div class="container-fluid " data-spy="affix"  id="myNav" data-offset-top="60" >

                        <ul class="list-group container-fluid-list" >

                            <li class="list-group-item active"><a href="#section1">学科 / 学科</a></li>
                            <li class="list-group-item "><a href="#section2">教材版本</a></li>
                            <li class="list-group-item" ><a href="#section3" >资源名称</a></li>
                            <li class="list-group-item" ><a href="#section4" >资源简介</a></li>
                            <li class="list-group-item" ><a href="#section5" >教学目标</a></li>
                            <li class="list-group-item" ><a href="#section6" >教学重难点</a></li>
                            <li class="list-group-item" ><a href="#section7" >教学用具</a></li>
                            <li class="list-group-item" ><a href="#section8" >教学过程</a></li>
                            <li class="list-group-item" ><a href="#section9" >板书</a></li>
                            <li class="list-group-item" ><a href="#section10">课堂小结</a></li>
                            <li class="list-group-item" ><a href="#section11" >课堂习题</a></li>
                            <li class="list-group-item" ><a href="#section12" >附件列表</a></li>

                        </ul>
                    </div>
                </div>
            </div>

            <div class="col-md-9">
                <div class="panel panel-col">

                    <div class="panel-heading">填写信息</div>

                    <div class="panel-body">

                        <form class="form-horizontal"  id="teaching_plan_form" action="${pageContext.request.contextPath}/my_file_base/upload_teaching_plan.action" method="post">

                            <input type="hidden" name="id" value="${file_base.id }">
                            <%--<c:if test="${!empty file_base.id }">--%>
                            <%--<a href="${pageContext.request.contextPath}/userFile/to_file.action?id=${file_base.id }" target="_blank" >预览</a>--%>
                            <%--</c:if>--%>

                            <!--学段-->
                            <div class="form-group" id="section1">
                                <label class="col-md-2 control-label"><span class="text-danger">*</span>学段</label>
                                <div class="col-md-1 controls">
                                    <button type="button"  class="btn <c:if test="${empty stage }">btn-info</c:if><c:if test="${stage=='XX' }">btn-info</c:if>  btn-lg btn-default" onclick="_stage(this.value);" value="XX">小学</button>
                                </div>
                                <div class="col-md-1 controls col-md-offset-1">
                                    <button type="button"  class="btn  <c:if test="${stage=='CZ' }">btn-info</c:if> btn-default btn-lg" onclick="_stage(this.value);" value="CZ">初中</button>
                                </div>

                                <div class="col-md-1 controls col-md-offset-1">
                                    <button type="button"  class="btn <c:if test="${stage=='GZ' }">btn-info</c:if> btn-default btn-lg" onclick="_stage(this.value);" value="GZ">高中</button>
                                </div>
                                <div class="help-block" style="display: none;"><span class="text-danger">请选择学段</span></div>
                            </div>

                            <!--学科-->
                            <div class="form-group" id="section2">
                                <label class="col-md-2 control-label"><span class="text-danger">*</span>学科</label>
                                <div class="col-md-8 controls">
                                    <select class="form-control" id="subject" onchange="_subject(this.value);"  name="subject">
                                        <c:if test="${empty textBook}">
                                            <option value="">--请选择学科--</option>
                                            <c:forEach items="${subjectList}" var="sub">

                                                <option value="${sub.id}">${sub.subjectName}</option>

                                            </c:forEach>
                                        </c:if>
                                        <c:forEach items="${textBook.subjectList }" var="subject0">

                                            <option value="${subject0.id }"  <c:if test="${subject==subject0.id}">selected="selected"</c:if>>${subject0.subjectName }</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="help-block" style="display: none;"><span class="text-danger">请选择科目</span></div>
                            </div>

                            <!--教材版本-->
                            <div class="form-group" id="section3">
                                <label class="col-md-2 control-label"><span class="text-danger">*</span>教材版本</label>
                                <div class="col-md-4 controls">
                                    <select class="form-control" id="edition"  onchange="_edition(this.value,0);"  name="edition">
                                        <c:if test="${empty textBook}">
                                            <option value="">--请选择教材版本--</option>
                                        </c:if>
                                        <c:forEach items="${textBook.editionList }" var="edition0">

                                            <option value="${edition0.id }"  <c:if test="${edition==edition0.id}">selected="selected"</c:if>>${edition0.versionName }</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="col-md-4 controls ">
                                    <select class="form-control" id="grade" onchange="_edition(this.value,1);" name="grade">
                                        <c:if test="${empty textBook}">
                                            <option value="">--请选择册数--</option>
                                        </c:if>
                                        <c:forEach items="${textBook.gradeList }" var="grade0">

                                            <option value="${grade0.id }"  <c:if test="${grade==grade0.id}">selected="selected"</c:if>>${grade0.bookCatelogName }</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <br/>
                                <br/>
                                <br/>
                                <div class="col-md-4 controls col-md-offset-2">
                                    <select class="form-control" id="unit" onchange="_edition(this.value,2);" name="unit">
                                        <c:if test="${empty textBook}">
                                            <option value="">--请选择单元--</option>
                                        </c:if>
                                        <c:forEach items="${textBook.chapterList }" var="chapter0">

                                            <option value="${chapter0.id }"  <c:if test="${chapter==chapter0.id}">selected="selected"</c:if>>${chapter0.bookCatelogName }</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-4 controls ">
                                    <select class="form-control" id="lesson" name="lesson">
                                        <c:if test="${empty textBook}">
                                            <option value="">--请选择课文--</option>
                                        </c:if>
                                        <c:forEach items="${textBook.sectionList }" var="section0">

                                            <option value="${section0.id }"  <c:if test="${section==section0.id}">selected="selected"</c:if>>${section0.bookCatelogName }</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="help-block" style="display: none;"><span class="text-danger">请选择教材版本</span></div>
                            </div>

                            <!--资源名称-->
                            <div class="form-group" id="section4">
                                <label class="col-md-2 control-label"><span class="text-danger">*</span>资源名称</label>
                                <div class="col-md-8 controls">
                                    <input type="text"  required="required" class="form-control" value="${teachingPlan.resource_name }" placeholder="点击此处编辑资源名称" name="resource_name">
                                    <div class="help-block" style="display: none;"><span class="text-danger">请输入资源名称</span></div>
                                </div>
                            </div>

                            <!--资源简介-->
                            <div class="form-group" id="section5">
                                <label class="col-md-2 control-label">资源简介</label>
                                <div class="col-md-8 controls">
                                    <textarea  class="form-control textarea" placeholder="请介绍下您的教学设计，例如适合中等学情的班级、编写于2016年以及其他教案特色" name="data_content">${teachingPlan.data_content }</textarea>
                                </div>
                            </div>

                            <!--教学目标-->
                            <div class="form-group" id="section6">
                                <label class="col-md-2 control-label"><span class="text-danger">*</span>教学目标</label>
                                <div class="col-md-8 controls">
                                    <textarea  class="form-control textarea" placeholder="此课时的教学目标" name="edu_goal">${teachingPlan.edu_goal }</textarea>
                                    <div class="help-block" style="display: none;"><span class="text-danger">请输入教学目标</span></div>
                                </div>
                            </div>

                            <!--教学重点/难点-->
                            <div class="form-group" id="section7">
                                <label class="col-md-2 control-label"><span class="text-danger">*</span>教学重点/难点</label>
                                <div class="col-md-8 controls">
                                    <textarea  class="form-control textarea"  placeholder="此课时的教学重点/难点" name="focus_difficulty" >${teachingPlan.focus_difficulty }</textarea>
                                    <div class="help-block" style="display: none;"><span class="text-danger">请输入教学重点/难点</span></div>
                                </div>
                            </div>

                            <!--教学用具-->
                            <div class="form-group" id="section8">
                                <label class="col-md-2 control-label">教学用具</label>
                                <div class="col-md-8 controls">
                                    <input type="text"   class="form-control" value="${teachingPlan.teaching_tool }" placeholder="此课时的教学用具有?" name="teaching_tool">
                                </div>
                            </div>

                            <!--教学过程-->
                            <div class="form-group" id="section9">
                                <label class="col-md-2 control-label"><span class="text-danger">*</span>教学过程</label>
                                <div class="col-md-8 controls">
                                    <!--此处是文本编辑插件-->
                                    <textarea  class="form-control textarea"  name="teaching_process">${teachingPlan.teaching_process }</textarea>
                                    <div class="help-block" style="display: none;"><span class="text-danger">请输入教学过程</span></div>
                                </div>
                            </div>

                            <!--板书-->
                            <div class="form-group" id="section10">
                                <label class="col-md-2 control-label">板书</label>
                                <div class="col-md-8 controls">
                                    <!--此处是文本编辑插件-->
                                    <textarea  class="form-control textarea" name="typography_design">${teachingPlan.typography_design }</textarea>

                                </div>
                            </div>

                            <!--课堂小结-->
                            <div class="form-group" id="section11">
                                <label class="col-md-2 control-label">课堂小结</label>
                                <div class="col-md-8 controls">
                                    <!--此处是文本编辑插件-->
                                    <textarea  class="form-control textarea" name="summary">${teachingPlan.summary }</textarea>

                                </div>
                            </div>

                            <!--课后习题-->
                            <div class="form-group" id="section12">
                                <label class="col-md-2 control-label">课后习题</label>
                                <div class="col-md-8 controls">
                                    <!--此处是文本编辑插件-->
                                    <textarea  class="form-control textarea" name="homework">${teachingPlan.homework }</textarea>

                                </div>
                            </div>

                            <div class="form-group" id="section13">
                                <div class="col-md-2 control-label">
                                    <label>附件列表</label>
                                </div>
                                <div class="col-md-4 controls" id="tutor_list">

                                    <ul class="nav nav-pills clearfix tutor_list" id="fileList">
                                        <c:forEach items="${teachingPlanFile }" var="file">
                                            <li class="active" ><a href="javascript:;">${file.filename }&nbsp;<span class="tutor_del" id="-1">X</span></a><br><input type="hidden" name="fileUrl" value="${file.url }"><input type="hidden" name="fileName" value="'${file.filename }"></li>

                                        </c:forEach>
                                    </ul>
                                </div>

                                <span>
                         <a class="tutor_add btn btn-info" id="file">
                                <span class="glyphicon glyphicon-plus"></span>添加
                            </a>
                        </span>

                            </div>

                            <!--资源类型-->
                            <div class="form-group" id="section14">
                                <label class="col-md-2 control-label"><span class="text-danger">*</span>资源类型</label>
                                <div class="col-md-5 controls">
                                    <select class="form-control" onclick="change(this.value)" name="type" id="type">
                                        <c:if test="${empty teachingPlan}">
                                            <option value="">--请选择类型--</option>
                                        </c:if>
                                        <option value="1" <c:if test="${teachingPlan.type==1}">selected="selected"</c:if>>付费资源</option>
                                        <option value="2" <c:if test="${teachingPlan.type==2}">selected="selected"</c:if>>公费资源</option>
                                        <option value="3" <c:if test="${teachingPlan.type==3}">selected="selected"</c:if>>私有资源</option>
                                    </select>
                                </div>
                                <div class="col-md-3 controls">
                                    <input class="form-control resource_price"  placeholder="请输入资源价格" <c:if test="${teachingPlan.type!=1}">style="display: none;"</c:if>>
                                </div>
                                <div class="help-block" style="display: none;"><span class="text-danger">请选择资源类型</span></div>

                            </div>

                            <!--发布范围-->
                            <div class="form-group" id="section15">
                                <div class="col-md-2 control-label">
                                    <label><span class="text-danger">* </span>发布范围</label>
                                </div>

                                <div class="col-md-8 controls radios">
                                    <label><input type="radio" name="publish_type" class="open" <c:if test="${teachingPlan.publish_type==0 }">checked="checked"</c:if><c:if test="${empty teachingPlan}">checked="checked"</c:if> onchange="queryCommunitys()" value="0">公开 </label>
                                    <label><input type="radio" name="publish_type" class="community" <c:if test="${teachingPlan.publish_type==1 }">checked="checked"</c:if> onchange="queryCommunitys()" value="1">社区 </label>
                                    <label><input type="radio" name="publish_type" class="workshop" <c:if test="${teachingPlan.publish_type==2 }">checked="checked"</c:if> onchange="queryCommunitys()" value="2">工作坊 </label>
                                    <div class=" text-warning" style="display:none">请选择发布范围</div>
                                </div>

                            </div>

                            <!--选择社区 -->
                            <div class="form-group community_content" <c:if test="${teachingPlan.publish_type!=1 }">style="display: none"</c:if>>

                                <div class="col-md-2 control-label"> <label><span class="text-danger">* </span>社区</label></div>
                                <div class="col-md-8 controls">
                                    <select class="form-control width-input width-input-large" name="publish_id"  <c:if test="${teachingPlan.publish_type!=1 }">disabled="disabled"</c:if>>
                                        <c:if test="${empty communitys }">
                                            <option value="">--请选择社区--</option>
                                        </c:if>
                                        <c:forEach items="${communitys }" var="community">

                                            <option value="${community.id }"  <c:if test="${teachingPlan.publish_id==community.id}">selected="selected"</c:if>>${community.name }</option>
                                        </c:forEach>


                                    </select>
                                    <div class="text-warning" style="display: none;">请选择社区</div>
                                </div>

                            </div>


                            <!--选择工作坊 -->
                            <div class="form-group workshop_content" <c:if test="${teachingPlan.publish_type!=2 }">style="display: none"</c:if>>
                                <div class="col-md-2 control-label"> <label><span class="text-danger">* </span>工作坊</label></div>
                                <div class="col-md-8 controls">
                                    <select class="form-control width-input width-input-large" name="publish_id"  onchange="queryClassifys()"  <c:if test="${teachingPlan.publish_type!=2 }">disabled="disabled"</c:if>>
                                        <c:if test="${empty communitys }">
                                            <option value="">--请选择工作坊--</option>
                                        </c:if>
                                        <c:forEach items="${workshops }" var="workshop">

                                            <option value="${workshop.id }"  <c:if test="${teachingPlan.publish_id==workshop.id}">selected="selected"</c:if>>${workshop.name }</option>
                                        </c:forEach>

                                    </select>
                                    <div class="text-warning" style="display: none;">请选择工作坊</div>
                                </div>
                            </div>



                            <div class="form-group" style="margin-top: 80px;">
                                <div class="col-md-offset-3 col-md-2 controls ">
                                    <button type="submit"  class="btn btn-fat btn-primary" id="btn_save">保存</button>
                                </div>
                                <div class="col-md-2 controls ">
                                    <button class="btn btn-fat btn-warning" id="btn_publish" type="submit">发布</button>
                                </div>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
        </div>

    </div>

</div>

<script type="text/javascript">
    $(function(){
        $(".textarea").click(function() {
            var name=$(this).attr("name");
            CKEDITOR.replace(name, {
                skin : "moono-lisa",
                resize_enabled : false,
                toolbar :
                    'Minimal'
            });
        });
        if('${file_base.id }'!=""){
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
    });


    $(function(){

        $('#teaching_plan_form').bootstrapValidator({
            message: '此值无效',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                resource_name: {
                    message: '资源名称',
                    validators: {
                        notEmpty: {
                            message: '资源名称不能为空'
                        },
                        stringLength: {
                            min: 4,
                            max: 20,
                            message: '资源名称长度4-20'
                        }
                    }
                },
                subject:{
                    message: '学科',
                    validators: {
                        notEmpty: {
                            message: '学科不能为空'
                        },
                    }
                },
                edition:{
                    message: '版本',
                    validators: {
                        notEmpty: {
                            message: '版本不能为空'
                        },
                    }
                },
                grade:{
                    message: '年级',
                    validators: {
                        notEmpty: {
                            message: '年级不能为空'
                        },
                    }
                },
                unit:{
                    message: '单元',
                    validators: {
                        notEmpty: {
                            message: '单元不能为空'
                        },
                    }
                },

            }
        }).on('success.form.bv', function(e) {

            for ( instance in CKEDITOR.instances )
                CKEDITOR.instances[instance].updateElement();
            var edu_goal= $("textarea[name=edu_goal]").val();
            var focus_difficulty=$("textarea[name=focus_difficulty]").val();
            var teaching_process=$("textarea[name=teaching_process]").val();
            var type=$("#type").val();
            if(edu_goal==""){
                $("#btn_save").removeAttr("disabled");
                $("#btn_publish").removeAttr("disabled");
                alert("教育目标不能为空");
                return false;
            }
            if(focus_difficulty==""){
                $("#btn_save").removeAttr("disabled");
                $("#btn_publish").removeAttr("disabled");
                alert("教学重点与难点不能为空");
                return false;
            }
            if(teaching_process==""){
                $("#btn_save").removeAttr("disabled");
                $("#btn_publish").removeAttr("disabled");
                alert("教学过程不能为空");
                return false;
            }
            if(type==""){
                $("#btn_save").removeAttr("disabled");
                $("#btn_publish").removeAttr("disabled");
                alert("类型不能为空");
                return false;
            }
            var publish_type=$("input[name=publish_type]:checked").val();
            var i=publish_type-1;
            var publish_id=$("select[name=publish_id]:eq("+i+")").find('option:selected').val();
            if(publish_type!=0&&publish_id==""){
                $("#btn_save").removeAttr("disabled");
                $("#btn_publish").removeAttr("disabled");
                if(publish_type==1)
                    alert("社区不能为空");
                if(publish_type==2)
                    alert("工作坊不能为空");
                return false;
            }
            if(e.type){//验证成功
                //document.getElementById('workshopForm').submit();

            }else{
                // 防止表单提交
                e.preventDefault();
            }
        });
        $(".open").click(function(){
            $(".community_content").hide();
            $(".workshop_content").hide();

        });

        $(".community").click(function(){
            $(".community_content").show(1200);
            $(".workshop_content").hide();

        });

        $(".workshop").click(function(){
            $(".community_content").hide();
            $(".workshop_content").show(1200);

        });
        $(".btn-default").click(function() {
            $(".btn-info").addClass("btn-default").removeClass("btn-info");
            $(this).removeClass("btn-default");
            $(this).addClass("btn-info");
        });

        //上传
        var uploader = WebUploader.create({
            auto: true,
            // swf文件路径
            swf: '${pageContext.request.contextPath}/frontstage/js/webuploader/Uploader.swf',
            // 文件接收服务端。
            server: '${pageContext.request.contextPath}/my_file_base/upload.action',
            fileNumLimit:3,
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
        $(document).on('click',".tutor_del",function(){

            var id=$(this).attr("id");
            if(id!=-1){
                uploader.removeFile(id);
            }
            $(this).parent().parent().remove();
        });
        uploader.on('error', function (type) {

            if(type=="Q_EXCEED_NUM_LIMIT")
                alert("附件最多上传3个");
        });
        var index_num=0;
        uploader.on( 'beforeFileQueued', function( file  ) {
            var a=    $(".tutor_del").length+index_num;
            index_num++;
            if(a==3){
                alert("附件最多上传3个");
                return false;
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
//加个隐藏的input到里面
            $("#fileList").append('<li class="active" ><a href="javascript:;">'+response.fileName+'&nbsp;<span class="tutor_del" id="'+file.id+'">X</span></a><br><input type="hidden" name="fileUrl" value="'+response.url+'"><input type="hidden" name="fileName" value="'+response.fileName+'"></li>');
            //document.getElementById("lesson_pic").value = response.fileName;
        });
    });

    function change(value) {
        var value_01 = value;
        if (value_01 == '1') {
            $(".resource_price").show();
        }else {
            $(".resource_price").val("");
            $(".resource_price").hide();

        }
    }

    $(function () {
        var flag ="${empty file_base.id }";

        if(flag=="true"){
            $("#subject").val("");
            $("#edition").find("option").remove();
            $("#grade").find("option").remove();
            $("#unit").find("option").remove();
            $("#lesson").find("option").remove();

            $("#edition").append('<option value="">--请选择教材版本--</option>');
            $("#grade").append('<option value="">--请选择册数--</option>');
            $("#unit").append('<option value="">--请选择单元--</option>');
            $("#lesson").append('<option value="">--请选择课文--</option>');
        }
    });
    function _stage(value){
        //       alert(value);
        $("#subject").find("option").remove();
        $("#edition").find("option").remove();
        $("#grade").find("option").remove();
        $("#unit").find("option").remove();
        $("#lesson").find("option").remove();
        $.ajax({
            url : "${pageContext.request.contextPath}/subject/query_subject.action?subId="+value,
            dataType:'json',
            success : function(json) {
                var a = JSON.stringify(json);
                var o = eval( "(" + a + ")" );
                var sub = o[0].subjectList;
                $("#subject").append('<option value="">--请选择学科--</option>');
                $("#edition").append('<option value="">--请选择教材版本--</option>');
                $("#grade").append('<option value="">--请选择册数--</option>');
                $("#unit").append('<option value="">--请选择单元--</option>');
                $("#lesson").append('<option value="">--请选择课文--</option>');
                for(var i in sub){
                    $("#subject").append('<option   value='+sub[i].id+' >'+sub[i].subjectName+'</option>');
                }



            }
        });

    }
    function _subject(value){
//    	alert(value);
        $("#edition").find("option").remove();
        $("#grade").find("option").remove();
        $("#unit").find("option").remove();
        $("#lesson").find("option").remove();
        $.ajax({
            url : "${pageContext.request.contextPath}/pubver/query_pubver.action?pubId="+value,
            dataType:'json',
            success : function(json){
                var a = JSON.stringify(json);
                var o = eval( "(" + a + ")" );
                var edi = o[0].editionList;
                var gra = o[0].gradeList;
                $("#subject").find("option[value='']").remove();
                $("#edition").append('<option value="">--请选择教材版本--</option>');
                $("#grade").append('<option value="">--请选择册数--</option>');
                $("#unit").append('<option value="">--请选择单元--</option>');
                $("#lesson").append('<option value="">--请选择课文--</option>');
                for(var i in edi){
                    $("#edition").append('<option  value='+edi[i].id+' >'+edi[i].versionName+'</option>');
                }


            }
        });
    }
    function _edition(value,index){
//    	alert(value);
        var _this;
        $.ajax({
            url : "${pageContext.request.contextPath}/book_cat/only_query_book_cat.action?bookId="+value,
            dataType:'json',
            success : function(json){
                var a = JSON.stringify(json);
                var gra  = eval( "(" + a + ")" );
                if(index==0){
                    _this=$("#grade");
                    _this.find("option").remove();
                    $("#unit").find("option").remove();
                    $("#lesson").find("option").remove();
                    _this.append('<option value="">--请选择册数--</option>');
                    $("#unit").append('<option value="">--请选择单元--</option>');
                    $("#lesson").append('<option value="">--请选择课文--</option>');
                    $("#edition").find("option[value='']").remove();
                }
                if(index==1){
                    _this=$("#unit");
                    _this.find("option").remove();
                    $("#lesson").find("option").remove();
                    _this.append('<option value="">--请选择单元--</option>');
                    $("#lesson").append('<option value="">--请选择课文--</option>');
                    $("#grade").find("option[value='']").remove();
                }
                if(index==2){
                    _this=$("#lesson");
                    _this.find("option").remove();
                    _this.append('<option value="">--请选择课文--</option>');
                    $("#unit").find("option[value='']").remove();
                }
                for(var i in gra){

                    _this.append('<option  value='+gra[i].id+' >'+gra[i].bookCatelogName+'</option>');
                }


            }
        });
    }
    $("#save").click(function () {
        //当选择社区或工作坊时，不能为空
        $("#teaching_plan_form").submit();
    });

    /* 查询社区/工作坊 */
    function queryCommunitys(){
        var publish_type = $("[ name = 'publish_type']:checked").attr("value");
        if(publish_type!=="1"&&publish_type!=="2"){
            $(".workshop_content [name='publish_id']").attr("disabled","disabled");
            $(".community_content [name='publish_id']").attr("disabled","disabled");
            initFirstClassify();
            return ;
        }else if(publish_type==="1"){
            $(".community_content [name='publish_id']").removeAttr("disabled");
            $(".workshop_content [name='publish_id']").attr("disabled","disabled");
        }else if(publish_type==="2"){
            $(".workshop_content [name='publish_id']").removeAttr("disabled");
            $(".community_content [name='publish_id']").attr("disabled","disabled");
        }
        $.ajax({
            url:"${pageContext.request.contextPath}/class/query_communitys.action",
            data:{"communityType":publish_type-1},
            dataType:"json",
            success:function(data){
                loadCommunitys(data,publish_type);
            }
        });
    }
    function initFirstClassify(){
        $(".community_content [ name = 'publish_id'] option:gt(0)").remove();
        $(".workshop_content [ name = 'publish_id'] option:gt(0)").remove();
        $("[ name = 'classifyId'] option").remove();
        $(".community_content").hide();
        $(".workshop_content").hide();

    }
    /* 加载社区 */
    function loadCommunitys(data,communityType){
        initFirstClassify();
        var communityContainer ;
        if(communityType==1){
            $(".community_content").css("display","");
            communityContainer = $(".community_content [ name = 'publish_id']");
        }else if(communityType==2){
            $(".workshop_content").css("display","");
            communityContainer = $(".workshop_content [ name = 'publish_id']");
        }
        for(var i=0;i<data.length;i++){
            var option_container = $("<option>").val(data[i].id).text(data[i].name);
            $(communityContainer).append(option_container);
        }
    }
    $("#btn_publish").click(function () {
        var i=($("#status").length);
        var form =$('#teaching_plan_form');
        if(i<1){
            var input=$('<input type="hidden" value="1" id="status" name="status">');
            form.append(input);
        }

    });
    $("#btn_save").click(function () {
        $("#status").remove();

    });
</script>


<jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>

