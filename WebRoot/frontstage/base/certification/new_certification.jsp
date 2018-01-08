<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<link href="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.js"></script>
<style>
    .tutor_del{z-index: 9999;position: relative;top: -40px;right:10px;}
    .certification_img{margin-right: 20px;}
</style>
<div class="cn-wrap">

    <div id="content-container" class="container">

        <jsp:include page="/frontstage/base/personalCenter/personal_header.jsp"></jsp:include>

        <div class="row">

            <jsp:include page="/frontstage/base/personalCenter/personal_left.jsp"></jsp:include>

            <div class="col-md-9">

                <div class="panel panel-default" >

                    <div class="panel-heading">
                        实名认证
                    </div>

                    <div class="panel-body">

                        <h2 class="text-center text-warning" style="margin-bottom: 30px;">请填写实名认证信息</h2>

                        <form class="form-horizontal clearfix"  id="form1" action="${pageContext.request.contextPath}/certification/certificate.action" method="post"  style="clear: both;">

                            <div class="form-group">
                                <div class="col-md-2 control-label"><span class="text-danger">*</span>真实姓名</div>
                                <div class="col-md-8 controls">
                                    <input type="text"  name="name"   value="" class="form-control" id="username">
                                    <div class="text-warning" style="display: none;">请输入真实姓名</div>
                                </div>

                            </div>

                            <div class="form-group ">
                                <div class="col-md-2 control-label"><span class="text-danger">*</span>身份证号</div>
                                <div class="col-md-8 controls">
                                    <input type="text"   value="" class="form-control" placeholder="请输入身份证号" name="ID_number" id="ID_number1">
                                    <div class="text-warning" style="display: none;">请输入身份证号</div>
                                </div>

                            </div>

                            <div class="form-group">
                                <div class="col-md-2 control-label"><span class="text-danger">*</span>性别</div>
                                <div class="col-md-10 controls radios">
                                    <label><input type="radio" name="sex" class="sex_input" checked="checked" value="1"> 男</label>
                                    <label><input type="radio" name="sex" class="sex_input" value="0"> 女</label>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-md-2 control-label"><span class="text-danger">*</span>邮箱</div>
                                <div class="col-md-8 controls">
                                    <input type="email"   value="" class="form-control" placeholder="请输入邮箱" name="email" id="email1">
                                    <div class="text-warning" style="display: none;">请输入邮箱</div>
                                </div>
                            </div>

                            <div class="form-group" >

                                <div class="col-md-2 control-label"> <span class="text-danger">*</span>省</div>
                                <div class="col-md-2 controls ">
                                    <select class="form-control" name="province" id="province" onchange='_province(this.value)' >
                                        <option   value="">--请选择省--</option>

                                        <c:forEach items="${provinceList}" var="pro">

                                            <option value="${pro.id}">${pro.area_name}</option>
                                        </c:forEach>
                                    </select>


                                </div>
                                <div class="col-md-1 control-label"> <span class="text-danger">*</span>市</div>
                                <div class="col-md-2 controls" >
                                    <select class="form-control  "  name="city" id="city" 
                                            onchange="_city(this.value)">

                                        <option   value="">--请选择市--</option>

                                        <c:forEach items="${cityList}" var="pro">

                                            <option value="${pro.id}">${pro.area_name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-1 control-label"><span class="text-danger">*</span> 县</div>
                                <div class="col-md-2 controls " >
                                    <select  class="form-control " name="county" id="county"
                                             onchange="_county(this.value)">

                                        <option   value="">--请选择县--</option>

                                        <c:forEach items="${countyList}" var="pro">
                                            <c:if test="${pro.id == county}">
                                                <option selected="selected" value="${pro.id}">${pro.area_name}</option>
                                            </c:if>
                                            <c:if test="${pro.id != county}">
                                                <option value="${pro.id}">${pro.area_name}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>


                           <!--  <div class="form-group">
                                <div class="col-md-2 control-label"><span class="text-danger">*</span>类型</div>
                                <div class="col-md-8 controls">

                                    <select class="form-control" name="certificate_type"  id="certificate_type">

                                        <option value="1">教师</option>
                                        <option value="2">教研员</option>
                                        <option value="3">其他</option>
                                    </select>

                                </div>
                            </div> -->


                            <div class="form-group">
                                <div class="col-md-2 control-label"><span class="text-danger">*</span>学校</div>
                                <div class="col-md-8 controls">

                                    <select class="form-control" name="school" id="school"
                                            onchange="school(this.value)">

                                        <option   value="">--请选择！--</option>

                                        <c:forEach items="${schoolList}" var="pro">
											<c:if test="${pro.id == school}">
                                                <option selected="selected" value="${pro.id}">${pro.schoolName}</option>
                                            </c:if>
                                            <c:if test="${pro.id != school}">
                                                <option value="${pro.id}">${pro.schoolName}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>

                                </div>
                            </div>

                            <div class="form-group" >
                                <div class="col-md-2 control-label"> <span class="text-danger">*</span>学段</div>
                                <div class="col-md-2 controls">
                                    <select class="form-control " id="stage" name="stage"  onchange="_stage(this.value);">

                                        <option id="nullStage"
                                                onclick="_stage('-1')" value="">--请选择学段--</option>

                                        <option value="XX" <c:if test="${stage=='XX' }">selected="selected"</c:if>
                                                >小学</option>
                                        <option value="CZ" <c:if test="${stage=='CZ' }">selected="selected"</c:if>
                                                >初中</option>
                                        <option value="GZ" <c:if test="${stage=='GZ' }">selected="selected"</c:if>
                                               >高中</option>
                                    </select>
                                </div>
                                <div class="col-md-1 control-label"> <span class="text-danger">*</span>科目</div>
                                <div class="col-md-2 controls" >
                                    <select class="form-control"  id="subject" onchange="_subject(this.value);"  name="subject">
                                        <c:if test="${empty subjectList}">

                                            <option   value="">--请选择科目--</option>

                                        </c:if>
                                        <c:forEach items="${subjectList}" var="sub">
                                            <c:if test="${subjectId == sub.id}">
                                                <option selected="selected" value="${sub.id}">${sub.subjectName}</option>
                                            </c:if>
                                            <c:if test="${subjectId != sub.id}">
                                                <option value="${sub.id}">${sub.subjectName}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-1 control-label"><span class="text-danger">*</span>年级</div>
                                <div class="col-md-2 controls">
                                    <select  class="form-control"   id="grade" name="grade" onclick="_grade()" >
                                        <c:if test="${empty gradeList}">

                                            <option class="nullGrade" value="">--请选择年级--</option>
											<option class="nullGrade" value=""></option>
											<option class="nullGrade" value=""></option>
											<option class="nullGrade" value=""></option>
											<option class="nullGrade" value=""></option>
											<option class="nullGrade" value=""></option>
											<option class="nullGrade" value=""></option>
											<option class="nullGrade" value=""></option>
											<option class="nullGrade" value=""></option>
											<option class="nullGrade" value=""></option>
											<option class="nullGrade" value=""></option>
											<option class="nullGrade" value=""></option>
											<option class="nullGrade" value=""></option>
											<option class="nullGrade" value=""></option>
                                        </c:if>
                                        <c:forEach items="${gradeList}" var="gra">
                                            <c:if test="${gradeId == gra.id}">
                                                <option selected="selected" value="${gra.id}">${gra.grade_name}</option>
                                            </c:if>
                                            <c:if test="${gradeId != gra.id}">
                                                <option value="${gra.id}">${gra.grade_name}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>

                            </div>


                            <div class="form-group" >

                                <div class="col-md-2 control-label"> <span class="text-danger">*</span>职位</div>

                                <div class="col-md-3 controls">
                                    <select class="form-control width-input" id="position" name="position" >
                                        <option id="nullStage"
                                                value="">--请选择职位--</option>

                                    </select>
                                </div>

                                <div class="col-md-2 control-label col-md-offset-1"> <span class="text-danger">*</span>职称</div>
                                <div class="col-md-3 controls">
                                    <select class="form-control width-input"  id="titles" name="titles" >
                                        <option id="nullStage"
                                                value="">--请选择职称--</option>

                                    </select>
                                </div>


                            </div>


                            <div class="form-group">
                                <div class="col-md-2 control-label"><span class="text-danger">*</span>教材版本</div>
                                <div class="col-md-4 controls">

                                    <select class="form-control"  id="edition" name="edition">
                                        <c:if test="${empty editionList}">
                                            <option value="">--请选择！--</option>
                                        </c:if>
                                        <c:forEach items="${editionList}" var="edi">
                                            <c:if test="${editionId == edi.id}">
                                                <option selected="selected" value="${edi.id}">${edi.versionName}</option>
                                            </c:if>
                                            <c:if test="${editionId != edi.id}">
                                                <option value="${edi.id}">${edi.versionName}</option>
                                            </c:if>
                                        </c:forEach>

                                    </select>


                                    <span class="text-danger warning" style="display: none;">教材版本不可为空</span>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-md-2 control-label"><span class="text-danger">*</span>上传照片</div>
                                <div id="fileList" class="uploader-list tutor_list col-md-8">

                                </div>

                                <!--上传照片按钮-->

                                <br/>
                                <br/>

                                <div class="col-md-3 controls col-md-offset-2 clearfix" style="margin-top: 20px;">
                                    <a type="button" class="btn btn-info btn-sm" id="file">上传照片</a>
                                </div>


                                <div class="help-block col-md-offset-2 clearfix" >
                                    包括身份证正反照片各一张,以及一张个人证件照.
                                </div>


                            </div>

                            <div class="form-group" style="margin-top: 100px;">
                                <div class="col-md-offset-2 col-md-8 controls">
                                    <button class="btn btn-fat btn-primary"  type="submit">保存</button>

                                </div>
                            </div>

                        </form>


                    </div>
                </div>


            </div>
        </div>

    </div>


    <script>

        function _province(value){

            $("#city").find("option").remove();
            $("#county").find("option").remove();
            $("#school").find("option").remove();
            $("#city").append('<option value=-1 >--请选择！--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </option>');
            $("#county").append('<option value=-1 >--请选择！--</option>');
            $("#school").append('<option value=-1 >--请选择！--</option>');
            $.ajax({
                url:"${pageContext.request.contextPath}/area/showArea.action?parentId="+value,
                dataType:'json',
                success:function(json){
                    var a = JSON.stringify(json);
                    var o = eval( "(" + a + ")" );
                    for(var j in o){

                        $("#city").append('<option  value='+o[j].id+' >'+o[j].area_name+'</option>');
                    }

                }

            });


            $.ajax({
                url:"${pageContext.request.contextPath}/area/showProvinceSchool.action?provinceId="+value,
                dataType:'json',
                success:function(json){
                    var a = JSON.stringify(json);
                    var o = eval( "(" + a + ")" );
                    for(var j in o){
                        $("#school").append('<option  value='+o[j].id+' >'+o[j].schoolName+'</option>');
                    }

                }

            });
        }
        function _city(value){

            $("#county").find("option").remove();

            $("#school").find("option").remove();
            $("#county").append('<option value=-1 >--请选择！--</option>');
            $("#school").append('<option value=-1 >--请选择！--</option>');
            $.ajax({
                url:"${pageContext.request.contextPath}/area/showArea.action?parentId="+value,
                dataType:'json',
                success:function(json){
                    var a = JSON.stringify(json);
                    var o = eval( "(" + a + ")" );
                    for(var j in o){
                        $("#county").append('<option  value='+o[j].id+' >'+o[j].area_name+'</option>');
                    }

                }

            });


            $.ajax({
                url:"${pageContext.request.contextPath}/area/showCitySchool.action?cityId="+value,
                dataType:'json',
                success:function(json){
                    var a = JSON.stringify(json);
                    var o = eval( "(" + a + ")" );
                    for(var j in o){
                        $("#school").append('<option  value='+o[j].id+' >'+o[j].schoolName+'</option>');
                    }

                }

            });

        }
        function _county(value){

            $("#school").find("option").remove();
            $("#school").append('<option value=-1 >--请选择！--</option>');
            $.ajax({
                url:"${pageContext.request.contextPath}/area/showSchool.action?countyId="+value,
                dataType:'json',
                success:function(json){
                    var a = JSON.stringify(json);
                    var o = eval( "(" + a + ")" );
                    for(var j in o){
                        $("#school").append('<option  value='+o[j].id+' >'+o[j].schoolName+'</option>');
                    }

                }

            });



        }
        //*****************
 
        function _stage(value){
            //alert(value);
            $("#subject").find("option").remove();
            $("#edition").find("option").remove();
            $("#position").find("option").remove();
            $("#titles").find("option").remove();
            //$("#grade").find("option").remove();
            $.ajax({
                url : "${pageContext.request.contextPath}/subject/query_subject.action?subId="+value,
                dataType:'json',
                success : function(json) {
                    var a = JSON.stringify(json);
                    var o = eval( "(" + a + ")" );
                    var sub = o[0].subjectList;
                    var edi = o[0].editionList;
                    var gra = o[0].gradeList;
                    for(var i in sub){
                        $("#subject").append('<option   value='+sub[i].id+' >'+sub[i].subjectName+'</option>');
                    }


                    for(var i in edi){
                        $("#edition").append('<option  value='+edi[i].id+' >'+edi[i].versionName+'</option>');
                    }

                    /* for(var i in gra){
                     $("#grade").append('<option value='+gra[i].bookCatelogId+' >'+gra[i].bookCatelogName+'</option>');
                     }
                     $("#gradeId").val(gra[0].bookCatelogId); */
                }
            });
            $.ajax({
                url : "${pageContext.request.contextPath}/certification/query_titles.action?subId="+value,
                dataType:'json',
                success : function(json) {

                    var position=json.position;
                    var titles=json.titles;
                    $("#position").append('<option   value=-1 >无</option>');
                    $("#titles").append('<option   value=-1 >无</option>');
                    for(var i in position){
                        $("#position").append('<option   value='+position[i].id+' >'+position[i].classify_name+'</option>');
                    }


                    for(var i in titles){
                        $("#titles").append('<option  value='+titles[i].id+' >'+titles[i].classify_name+'</option>');
                    }



                }
            });
        }
        function _subject(value){

            $("#edition").find("option").remove();
            $.ajax({
                url : "${pageContext.request.contextPath}/pubver/query_pubver.action?pubId="+value,
                dataType:'json',
                success : function(json){
                    var a = JSON.stringify(json);
                    var o = eval( "(" + a + ")" );
                    var edi = o[0].editionList;
                    var gra = o[0].gradeList;
                    for(var i in edi){
                        $("#edition").append('<option  value='+edi[i].id+' >'+edi[i].versionName+'</option>');
                    }
                    $("#editionId").val(edi[0].id);

                }
            });
        }

        function _grade(){
		if($("#grade").val()==null||$("#grade").val()==""){
				
			$.ajax({
				url : "${pageContext.request.contextPath}/my_setting/selectGrade.action",
				dataType:'json',
				success : function(json){
				$(".nullGrade").remove();
					var a = JSON.stringify(json);
					var o = eval( "(" + a + ")" );
					for(var i in o){
						$("#grade").append('<option  value='+o[i].id+' >'+o[i].grade_name+'</option>');
					}
				
				}
			});
		}

        }
        $(function(){
            var i=1;
            var uploader = WebUploader.create({
                auto: true,
                // swf文件路径
                swf: '${pageContext.request.contextPath}/frontstage/js/webuploader/Uploader.swf',
				// 文件接收服务端。
                server: '${pageContext.request.contextPath}/certification/upload_img.action',

                // 选择文件的按钮。可选。
                // 内部根据当前运行是创建，可能是input元素，也可能是flash.
                pick: '#file',

                // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
                resize: false,
                accept: {
                    title: 'Images',
                    extensions: 'gif,jpg,jpeg,bmp,png',
                    mimeTypes: 'image/*'
                }
            });
            /**
             *上传成功后
             *file:文件
             *response:服务器返回
             */
            uploader.on( 'uploadSuccess', function( file,response  ) {
                var hidden=$(
                    '<input type="hidden" value="'+response.fileName+'" name="picture'+i+'" class="hidden" data-id="'+file.id+'">' );
                var $form=$("#form1");
                $form.append(hidden);
                i++;
            });
            $(document).on('click',".tutor_del",function(){
                var id=$(this).attr("id");
                //name picture+i移除 data-id =id
                $("input[data-id='"+id+"']").remove();
                uploader.removeFile(id);
                $(this).parent().remove();
                i--;
            });
            // 当有文件添加进来的时候
            uploader.on( 'fileQueued', function( file ) {

                // <input type="hidden">

                var $img;
                var $li = $(
                    '<a href="javascript:void(0);" class="certification_img" data-toggle="modal">'+

                    '<img>' +
                    '<span class="tutor_del text-danger" id="'+file.id+'">X</span>'+

                    '</a>'

                    ),

                    $img = $li.find('img');

                if (3 ==$('#fileList').find('.certification_img').length)
                    return void alert('上传图片最多不能超过3张');
                var   $list=$("#fileList");

                // $list为容器jQuery实例
                $list.append( $li );



                // 创建缩略图
                // 如果为非图片文件，可以不用调用此方法。
                // thumbnailWidth x thumbnailHeight 为 100 x 100
                uploader.makeThumb( file, function( error, src ) {
                    if ( error ) {
                        $img.replaceWith('<span>不能预览</span>');
                        return;
                    }

                    $img.attr( 'src', src );
                }, 100, 100 );
            });

            $("#save_btn").click(function(){


                var email_reg=/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
                var phone_reg=/^13[0-9]{9}$|14[0-9]{9}|15[0-9]{9}$|18[0-9]{9}|17[0-9]{9}$/;
                var isIDCard=/^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$|^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/;
                var username=$("#username").val();
                var email=$("#email1").val();
                var school=$("#school").val();
                var stage=$("#stage").val();
                var subject =$("#subject").val();
                var edition =$("#edition").val();
                var grade =$("#grade").val();
                var ID_number1=$("#ID_number1").val();
                var certificate_type=  $("#certificate_type").val();
                //用户名
                if(username==""){
                    $("#username").next().show();
                    return false;
                }else{
                    $("#username").next().hide();
                }
                //学校
                if(school=="-1"){
                    $("#school").next().show();
                    return false;

                }else{
                    $("#school").next().hide();
                }
                //学段
                if(stage=="-1"){

                    $("#stage").next().show();

                    return false;
                }else{
                    $("#stage").next().hide();
                }
                //学科
                if(subject==-1){
                    $("#subject").next().show();
                    return false;
                }else{
                    $("#subject").next().hide();
                }
                //版本
                if(edition=="-1"){
                    $("#edition").next().show();
                    return false;
                }else{
                    $("#edition").next().hide();
                }
                //年级
                if(grade=="-1"){
                    $("#grade").next().show();
                    return false;
                }else{
                    $("#grade").next().hide();
                }
                //身份证号码
                if(ID_number1==""){
                    $("#ID_number1").next().show();
                    return false;
                }else{
                    $("#ID_number1").next().hide();
                }
                if(!isIDCard.test(ID_number1)){
                    alert("身份证格式不正确");
                    return false;
                }
                //邮箱
                if(email==""){
                    $("#email1").next().show();
                    return false;
                }else{
                    $("#email1").next().hide();
                }
                if(!email_reg.test(email)){
                    alert("邮箱格式不正确");
                    return false;
                }

                var i=$('#form1').find('.hidden').length;
                if(i<1){
                    alert("请上传图片");
                    return false;
                }



	});
		
	});
	
	 $(document).ready(function() {
        $('#form1').bootstrapValidator({
            message: '此值无效',
            
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                name: {
                    message: '真实姓名',
                    validators: { 
                        notEmpty: {
                            message: '真实姓名不能为空'
                        },
                         stringLength: {
                            min: 2,
                            max: 10,
                            message: '真实姓名长度2-10'
                        },
                      
                    }
                },
                 email: {
                    message: '邮箱',
                    validators: { 
                        notEmpty: {
                            message: '邮箱不能为空'
                        },
                      emailAddress:{
                            message: '邮箱格式不正确'
                        },
                    }
                },
                school: {
                    message: '学校',
                    validators: { 
                        notEmpty: {
                            message: '学校不能为空'
                        },
                    }
                },
                stage: {
                    message: '学段',
                    validators: { 
                        notEmpty: {
                            message: '学段不能为空'
                        },
                    }
                },
                subject: {
                    message: '科目',
                    validators: { 
                        notEmpty: {
                            message: '科目不能为空'
                        },
                    }
                },
                edition: {
                    message: '版本',
                    validators: { 
                        notEmpty: {
                            message: '版本不能为空'
                        },
                    }
                },
                grade: {
                    message: '年级',
                    validators: { 
                        notEmpty: {
                            message: '年级不能为空'
                        },
                    }
                },
                ID_number: {
                    message: '身份证号',
                    validators: { 
                        notEmpty: {
                            message: '身份证号不能为空'
                        },
                         regexp: {/* 只需加此键值对，包含正则表达式，和提示 */
                            regexp: /^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$|^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/,
                            message: '身份证格式不正确'
                        },
                    }
                },
                    certificate_type: {
                    message: '类型',
                    validators: { 
                        notEmpty: {
                            message: '类型不能为空'
                        },
                    }
                },
            
             
            }
        }).on('success.form.bv', function(e) {
        	
			 if(e.type){//验证成功
                //document.getElementById('workshopForm').submit();
   var i=$('#form1').find('.hidden').length;
		if(i<3){
			alert("请上传3张图片");
			return false;
		}
            }else{
                // 防止表单提交
                e.preventDefault();
            }
        });

});
// 	   $(document).on('click',".certification_img",function(){
// 	   var src=$(this).find("img").attr("src");
// 	  $("#certification_img_modal").find("img").attr("src",src);
// 	  $("#certification_img_modal").modal("show");
// 	  });
</script>



    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
</div>