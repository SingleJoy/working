<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>
<link href="${pageContext.request.contextPath}/frontstage/css/my-space.css" rel="stylesheet" type="text/css">

<link href="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.js"></script>

<div class="cn-wrap">

	<div id="content-container" class="container">

		<jsp:include page="./personal_header.jsp"></jsp:include>

		<div class="row row-3-9">

			<jsp:include page="./personal_left.jsp"></jsp:include>

			<div class="col-md-9">

				<div class="">

					<div class="panel panel-default panel-col setting-tabs">
						<div class="panel-heading">设置</div>

						<ul class="nav nav-tabs mbl" style="border: none;" >
							<li class="active"><a href="javascript:void (0);">个人信息</a></li>

							<li><a href="javascript:void (0);">学校信息</a></li>

							<li><a href="javascript:void (0);">学科信息</a></li>
						</ul>

						<div class="panel-body">

							<form id="form" action="${pageContext.request.contextPath}/my_setting/upload.action" method="post" enctype="multipart/form-data" class="form-horizontal">

								<div id="fileList" class="form-group" style="">
									<div class="col-md-offset-2 col-md-4 controls">
										<img id="myimg" class="img-responsive" style="width: 150px;height: 90px;"
									    <c:if test="${empty fileName}">src="${pageContext.request.contextPath}/frontstage/images/default.png"</c:if>
									    <c:if test="${!empty fileName}">src="${pageContext.request.contextPath}${fileName}"</c:if>>
									</div>

									<div id="upload_picture" class="col-md-8 col-md-offset-2 controls" style="margin-top: 10px;">
										<a class="btn btn-primary" href="javascript:void (0);" data-toggle="modal"  style="margin-left: 20px;">更换头像</a>
									</div>
									
									<div id="backupload" class="col-md-8 col-md-offset-2 controls" style="margin-top: 10px;display: none;">
										<a class="btn btn-primary" href="javascript:void (0);" onclick="backUpload();" style="margin-left: 20px;">重新选择图片</a>
									</div>
									
								</div>

							</form>

							<form class="form-horizontal"  action="${pageContext.request.contextPath}/my_setting/updateMySetting.action" method="post" id="my_form">
							<input type="hidden" name="userId" value="${currentUser.id}">
							<input type="hidden" name="oldName" value="${mySetting.userName }" id="oldName">
							<input type="hidden" name="oldPhone" value="${mySetting.phone }" id="oldPhone">
							<input type="hidden" name="icon" class="hidden" id="icon"
                            <c:if test="${empty mySetting.picture}">value="/frontstage/images/default.png"</c:if>
                            <c:if test="${!empty mySetting.picture}">value="${mySetting.picture }"</c:if>>
								<div class="row form-group">
									<label class="col-md-2 control-label">用户名</label>
									<div class="controls col-md-6">
										<input id="username" name="title" type="text" value="${mySetting.userName }" class="form-control"/>
										<span class="text-danger" id="username_msg"></span>
									</div>
								</div>

								<div class="row form-group">
									<label class="col-md-2 control-label">手机号</label>

									<div class="controls col-md-6">
										<input id="phone" name="phone" type="text" value="${mySetting.phone }" class="form-control"/>
										<span class="text-danger" id="phone_msg"></span>
									</div>
								</div>

								<div class="row form-group">
									<label class="col-md-2 control-label">邮箱</label>

									<div class="controls col-md-6">
										<input id="email" name="email" class="form-control" type="text" value="${mySetting.email }" class="form-control"/>
										<span class="text-danger" id="email_msg"></span>
									</div>

								</div>

								<div class="row form-group">
									<div class="col-md-2 control-label">
										<span>个人简介</span>
									</div>

									<div class="controls col-md-6">
										<input type="hidden" name="id" value="${mySetting.id }">
										<input type="text" name="synopsis" value="${mySetting.synopsis }" class="form-control"/>
									</div>

								</div>

							</form>


							<div class="controls col-md-8" style="margin-left: 130px;">
								<button type="submit" class="btn btn-primary btn-fat" id="setting_submit">提交</button>
							</div>

						</div >

						<div class="panel-body" style="display: none;">

							<form id="schoolForm" action="${pageContext.request.contextPath}/my_setting/updateSchool.action" method="post" class="form-horizontal pull-left">

								<div class="form-group">

									<div class="col-md-3 control-label">省</div>
									<div class="col-md-9 controls">
										<select class="form-control" name="province" id="province" onchange='_province(this.value)' >
											<option value="-1">--请选择！--</option>
											<c:forEach items="${provinceList}" var="pro">
												<c:if test="${pro.id == province}">
													<option selected="selected" value="${pro.id}">${pro.area_name}</option>
												</c:if>
												<c:if test="${pro.id != province}">
													<option value="${pro.id}">${pro.area_name}</option>
												</c:if>
											</c:forEach>
										</select>
									</div>
								</div>

								<div class="form-group">
									<div class="col-md-3 control-label">市</div>
									<div class="col-md-9 controls">
										<select class="form-control" name="city" id="city" onchange="_city(this.value)">
											<option value="-1">--请选择！--</option>
											<c:forEach items="${provinceList}" var="pro">
												<c:if test="${pro.id == province}">
													<option selected="selected" value="${pro.id}">${pro.area_name}</option>
												</c:if>
												<c:if test="${pro.id != province}">
													<option value="${pro.id}">${pro.area_name}</option>
												</c:if>
											</c:forEach>
										</select>
									</div>
								</div>

								<div class="form-group">
									<div class="col-md-3 control-label">县</div>
									<div class="col-md-9 controls">
										<select class="form-control" name="county" id="county" onchange="_county(this.value)">
											<option   value="-1">--请选择！--</option>
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

								<div class="form-group">

									<div class="col-md-3 control-label">学校</div>
									<div class="col-md-9 controls">
										<select name="school_id" id="school" onchange="_school(this.value)" class="form-control">
											<option   value="-1">--请选择！--</option>
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

								<div class="form-group" style="position: absolute;margin-left: 320px;margin-top: -65px;">
									<div class="control-label no-school" style="display: inline-block;"> 无法找到学校?</div>
									<div class="control-label click-write " style="display: inline-block;padding-left: 10px;color: #3ebbce;cursor: pointer;"> 击手动输入</div>

								</div>

								<div class="form-group new-school" style="display: none;" >
									<div class="col-md-3 control-label"></div>
									<div class="col-md-9 controls ">
										<input type="text" id="newSchool" name="newSchool"  class="form-control width-input width-input-large" placeholder="请输入学校...">
									</div>
								</div>

								<div class="form-group">
									<div class="col-md-offset-2 col-md-8 controls">
										<button class="btn btn-fat btn-primary" onclick="baocun()" value="保存" type="submit">保存</button>
									</div>
								</div>


							</form>
						</div>

						<div class="panel-body"  style="display: none;">

							<form id="subjectForm" action="${pageContext.request.contextPath}/my_setting/updateSubject.action"
								  method="post" class="form-horizontal pull-left">

								<div class="form-group">

									<div class="col-md-4 control-label">学段</div>
									<div class="col-md-8 controls">
										<select id="studySection" name="studySection" onclick="delStudySection()" class="form-control">
											<option id="nullStudySection"
													<c:if test="${empty studySection }">selected="selected"</c:if>
													onclick="_stage('-1')">--请选择！--</option>
											<option <c:if test="${studySection=='XX' }">selected="selected"</c:if>
													onclick="_stage('XX')">小学</option>
											<option <c:if test="${studySection=='CZ' }">selected="selected"</c:if>
													onclick="_stage('CZ')">初中</option>
											<option <c:if test="${studySection=='GZ' }">selected="selected"</c:if>
													onclick="_stage('GZ')">高中</option>
										</select>
									</div>
								</div>

								<div class="form-group">
									<div class="col-md-4 control-label">科目</div>
									<div class="col-md-8 controls">
										<select id="subject" onchange="_subject(this.value);" class="form-control">
											<c:if test="${empty subjectList}">
												<option   value="-1">--请选择！--</option>
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
								</div>

								<div class="form-group">
									<div class="col-md-4 control-label">版本</div>
									<div class="col-md-8 controls">
										<select id="edition" name="edition" class="form-control">
											<c:if test="${empty editionList}">
												<option value="-1">--请选择！--</option>
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
									</div>
								</div>

								<div class="form-group">

									<div class="col-md-4 control-label">年级</div>
									<div class="col-md-8 controls">
										<select id="grade" name="grade" onclick="_grade()" class="form-control">
											<c:if test="${empty gradeList}">
												<option id="nullGrade" value="-1">--请选择！--</option>
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


								<div class="form-group">
									<div class="col-md-offset-2 col-md-8 controls">
										<button class="btn btn-fat btn-primary" onclick="tj()"  type="button">保存</button>
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
	function delStudySection(){
		$("#nullStudySection").remove();
	}

	function tj(){
		if($("#edition").val()!=null){

			if($("#grade").val()!=null){
				$("#subjectForm").submit();
			}else{
				alert("请输入年级");
			}

		}else{
			alert("请输入版本");
		}

	}

	function _province(value){
		$("#city").find("option").remove();
		$("#county").find("option").remove();
		$("#school").find("option").remove();
		$("#city").append('<option value=-1 >--请选择！--</option>');
		$("#county").append('<option value=-1 >--请选择！--</option>');

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
			url:"${pageContext.request.contextPath}/area/showProvinceSchool.action?provinceId="+$("#province").val(),
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
			url:"${pageContext.request.contextPath}/area/showCitySchool.action?cityId="+$("#city").val(),
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

	function _stage(value){
//		alert(value);

		$("#subject").find("option").remove();
		$("#edition").find("option").remove();
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
				$("#subjectId").val(sub[0].subjectId);
				$("#subject").val();
				for(var i in edi){
					$("#edition").append('<option  value='+edi[i].id+' >'+edi[i].versionName+'</option>');
				}
				$("#editionId").val(edi[0].id);

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
		if($("#grade").val()==null||$("#grade").val()=="-1"){
			$("#nullGrade").remove();
			$.ajax({
				url : "${pageContext.request.contextPath}/my_setting/selectGrade.action",
				dataType:'json',
				success : function(json){
					var a = JSON.stringify(json);
					var o = eval( "(" + a + ")" );
					for(var i in o){
						$("#grade").append('<option  value='+o[i].id+' >'+o[i].grade_name+'</option>');
					}
				}
			});
		}
	}
	function baocun(){
		if($("#newSchool").text()!=null){
			if($("#province").val()!=null||$("#city").val()!=null||$("#county").val()!=null){
				schoolForm.submit();
			}
			else{
				alert("请选择省市县");
			}
		}
		else{
			if($("#school").val()!=null){
				schoolForm.submit();
			}else{
				alert("请选择学校")
			}
		}
	}

	function test(){
		alert($("#file").val());
	}

	//邮箱输入格式验证
	$(function(){
		var email_reg=/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
		var phone_reg=/^13[0-9]{9}$|14[0-9]{9}|15[0-9]{9}$|18[0-9]{9}|17[0-9]{9}$/;
		$("#setting_submit").click(function(){
			var username=$("#username").val();
			var phone=$("#phone").val();
			var email=$("#email").val();
			var oldName=$("#oldName").val();
			var oldPhone=$("#oldPhone").val();
			//用户名
			if(username==""){
				$("#username_msg").html("用户名不能为空");
				return false;
			}else{
				$("#username_msg").html("");
			}
			var flag=2;
			if(oldName!=username){
				$.ajax({
					async : false,
					type:'post',
					url:"/edu_yun/user/checkRegister.action",
					data:$("#my_form").serialize(),
					dataType:'json',
					success:function(response){

						flag=response.flag;
						if(flag==1){
							$("#username_msg").html("用户名存在");
						}
					}
				});
			}
			if(flag==1){
				return false;
			}else{
				$("#username_msg").html("");
			}
			//手机
			if(phone==""){
				$("#phone_msg").html("手机号不能为空");
				return false;
			}else{
				$("#phone_msg").html("");
			}
			if(!phone_reg.test(phone)){
				$("#phone_msg").html("手机格式不正确");
				return false;
			}else{
				$("#phone_msg").html("");
			}
			var flag1=2;
			if(oldPhone!=phone){
				$.ajax({
					async : false,
					type:'post',
					url:"/edu_yun/user/checkPhone.action",
					data:$("#my_form").serialize(),
					dataType:'json',
					success:function(response){

						flag1=response.flag;
						if(flag1==1){
							$("#phone_msg").html("手机号码存在");
						}
					}
				});
			}
			if(flag1==1){
				return false;
			}else{
				$("#username_msg").html("");
			}

			//邮箱
			if(email==""){
				$("#email_msg").html("邮箱不能为空");
				return false;
			}else{
				$("#email_msg").html("");
			}
			if(!email_reg.test(email)){
				$("#email_msg").html("邮箱格式不正确");
				return false;
			} else{
				$("#email_msg").html("");
			}
			$("#my_form").submit();
		});
	});

	$(function(){
		$(".click-write").click(function(){
			if ($(".new-school").css("display")=="none"){
				$(".new-school").show();
				$(".no-school").hide();
				$(this).html("点击收起");
			}else{
				$(".new-school").hide();
				$(this).html("点击手动输入");
				$(".no-school").show();
			}
		})
	});

	$(function(){

		$(".setting-tabs>ul>li").click(function(){
			$(".setting-tabs>ul>li").removeClass("active");
			$(this).addClass("active");
			var index=$(this).index();
			$(".panel-body").hide().eq(index).show();
		});

	});

	
	function backUpload(){
		window.location.href="${pageContext.request.contextPath}/my_setting/showMySetting.action?state=10&stamp=7";
	}
	
    $(function(){
    	var uploader = WebUploader.create({

			auto: true,
			// swf文件路径
			swf: '${pageContext.request.contextPath}/frontstage/js/webuploader/Uploader.swf',
			// 文件接收服务端。
			server: '${pageContext.request.contextPath}/cert_model/upload_img.action?realpath=userImages',

			// 选择文件的按钮。可选。
			// 内部根据当前运行是创建，可能是input元素，也可能是flash.
			pick: '#upload_picture',

			// 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
			resize: false,
			accept: {
				title: 'Images',
				extensions: 'gif,jpg,jpeg,bmp,png',
				mimeTypes: 'image/jpg,image/jpeg,image/png'   //修改这行
			}
		});
		/**
		 *上传成功后
		 *file:文件
		 *response:服务器返回
		 */
		uploader.on( 'uploadSuccess', function( file,response  ) {
			$("#icon").val(response.filepath);

		});
		// 当有文件添加进来的时候
		uploader.on( 'fileQueued', function( file ) {

			var $img;
			var $li =  $(
					'<div id="' + file.id + '" class="col-md-offset-2 col-md-4 controls">'+
					    '<img  class="img-responsive" style="width: 150px;height: 90px;">'+
					'</div>'
					);
		
		    $img = $li.find('img');
			var $list=$("#fileList");
			

			$list.prepend( $li );
			$("#myimg").css("display","none");
			$("#upload_picture").css("display","none");
			$("#backupload").css("display","");
			// 创建缩略图
			// 如果为非图片文件，可以不用调用此方法。
			// thumbnailWidth x thumbnailHeight 为 100 x 100
			uploader.makeThumb( file, function( error, src ) {
				if ( error ) {
					$img.replaceWith('<span>不能预览</span>');
					return;
				}
				$img.attr( 'src', src );
			}, 480, 270 );
		});

    })

</script>








