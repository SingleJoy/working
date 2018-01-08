<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<jsp:include page="../layout/header.jsp"></jsp:include>


<link rel="icon" type="image/x-icon" href="../images/logo.ico" media="screen" />
<link href="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.js"></script>
<link href="${pageContext.request.contextPath}/frontstage/css/certification.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/jq/jq.js"></script>
<script>
	//       教师与管理员验证表单切换
	$(function(){
		var isclick=false;
		$(".certification_content_tabs>ul>li").click(function(){
			$(".certification_content_tabs>ul>li").removeClass("curr");
			$(this).addClass("curr");
			var index=$(this).index();
			$(".form_tabs").hide().eq(index).show();

			isclick=true;
		}).mouseover(function(){

			$(this).addClass("curr_01");
		}).mouseout(function(){

		});

	});
</script>



<div class="certification_content">
	<div class="certification_content_top">
		<h2>申请认证用户</h2>
		<div class="application_progress">

			<div class="application_progress_ ">
				<div>1</div>
				<p>注册账户</p>
				<span></span>
			</div>

			<div class="application_progress_ application_progress_style">
				<div>2</div>
				<p>填写认证信息</p>
				<span></span>
			</div>


			<div class="application_progress_ application_progress_style_01">
				<div>3</div>
				<p>申请提交成功</p>
			</div>

		</div>
	</div>

	<div class="certification_content_tabs">

		<ul>
			<li class="curr">教师认证&nbsp;?</li>
			<%--<li >or</li>--%>
			<li>管理员认证&nbsp;?</li>

		</ul>

	</div>

	<div class="add_certification_info">填写实名认证信息</div>

	<div class="certification_content_main">

		<div class="form_tabs">
			<form id="form1" action="${pageContext.request.contextPath}/certification/certificate.action?" method="post">
				<div class="true_name"><span>* </span>真实姓名:<input type="text"  name="name" id="username1"><i style="font-size: 14px;color: red" id="username_msg1"></i></div>

				<div class="select_province select_area ">
					<span>* </span><td>省:</td> <select name="province" id="province"
													   onchange='_province(this.value)' onmousedown="province_click()">
					<option   value="-1">--请选择！--</option>
					<c:forEach items="${provinceList}" var="pro">

						<option value="${pro.id}">${pro.area_name}</option>

					</c:forEach>
				</select>
				</div>
				<div class="select_city select_area ">
					<span>* </span><td>市:</td> <select name="city" id="city" onmousedown="city_click()"
													   onchange="_city(this.value)">
					<option   value="-1">--请选择！--</option>
					<c:forEach items="${cityList}" var="pro">

						<option value="${pro.id}">${pro.area_name}</option>

					</c:forEach>

				</select>
				</div>
				<div class="select_county select_area ">

					<span>* </span><td>县:</td> <select name="county" id="county"
													   onchange="_county(this.value)">
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
				<br/>
				<br/>
				<br/>
				<div class="select_school">
					<span>* </span><td>类型:</td><select  name="certificate_type"  id="certificate_type">

					<option  value="1">教师</option>
					<option  value="2">教研员</option>
					<option  value="3">其他</option>


				</select>

				</div>
				<div class="select_school" style="clear: both" id="select_school1">
					<span>* </span><td>学校:</td> <select name="school" id="school"
														onchange="school(this.value)">
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
					<i style="font-size: 14px;color: red" id="school_msg1"></i>
					<!-- <span>不属于学校？<span style="color: blue" id="not_school1">点击</span></span>
                      -->
				</div>
				<div class="select_school" style="clear: both;display: none" id="danwei1">
					<span id="danwei_1">* </span><span style="color: rgb(109, 109, 109)" id="danwei_span1" >单位: </span><input placeholder="非学校请手动输入单位" type="text" name="schoolName" id="schoolName1" value="" >
					<i style="font-size: 14px;color: red" id="danwei_msg1"></i>
				</div>


				<div class="select_section" id="select_stage">
					<span>* </span><td>学段:</td><select id="stage" name="stage" onclick="delStage()">
					<option id="nullStage"
							onclick="_stage('-1')" value="-1">--请选择！--</option>
					<option <c:if test="${stage=='XX' }">selected="selected"</c:if>
							onclick="_stage('XX')">小学</option>
					<option <c:if test="${stage=='CZ' }">selected="selected"</c:if>
							onclick="_stage('CZ')">初中</option>
					<option <c:if test="${stage=='GZ' }">selected="selected"</c:if>
							onclick="_stage('GZ')">高中</option>
				</select>

				</div>
				<div class="select_subject" id="select_subject">
					<span>* </span><td>科目:</td><select id="subject"
													   onchange="_subject(this.value);" class="nav_content_sel" name="subject">
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

				<div class="select_grade" id="select_grade">
					<span>* </span><td>年级:</td><select id="grade" name="grade" onclick="_grade()"
													   class="nav_content_sel content_sel_1">
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
					<i style="font-size: 14px;color: red" id="stage_msg"></i>
					<i style="font-size: 14px;color: red" id="subject_msg"></i>
					<i style="font-size: 14px;color: red" id="grade_msg"></i>
				</div>
				<div class="select_section" id="select_position">
					<td>职位:</td><select id="position" name="position" >
					<option id="nullStage"
							value="-1">--请选择！--</option>

				</select>

				</div>
				<div class="select_subject" id="select_titles">
					<td>职称:</td><select id="titles" name="titles" >
					<option id="nullStage"
							value="-1">--请选择！--</option>

				</select>

				</div>
				<div class="select_version" id="select_version">
					<span>* </span><td>版本:</td><select id="edition" name="edition"
													   class="nav_content_sel content_sel_1">
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
					<i style="font-size: 14px;color: red" id="edition_msg"></i>
				</div>
				<br/>

				<div class="ID_number"><span>* </span>身份证号:<input type="text" name="ID_number" id="ID_number1">
					<i style="font-size: 14px;color: red" id="ID_number1_msg"></i>
				</div>
				<div class="sex"><span>* </span>性别:
					<p>
						<input type="radio" name="sex" class="sex_input" checked="checked" value="1">&nbsp;男
						<input type="radio" name="sex" class="sex_input" value="0">&nbsp;女
					</p>
				</div>
				<div class="email"><span>* </span>邮箱:<input type="email" name="email" id="email1"><i style="font-size: 14px;color: red" id="email_msg1"></i></div>
				<c:if test="${!empty currentUser.phone}">
					<div class="cellphone_number"><span>* </span>手机号码:<input type="text" name="phone" id="phone1" value="${currentUser.phone}" readonly="readonly"></div>
				</c:if>
				<c:if test="${empty currentUser.phone}">
					<div class="cellphone_number"><span>* </span>手机号码:<input type="text" name="phone" id="phone1"><i style="font-size: 14px;color: red" id="phone_msg1"></i></div>
				</c:if>
				<div class="cellphone_number_resister"><span>* </span>验证码:<input type="text" name="yzm" id="yzm1" style="width: 230px;"><button class="verification_code">获取验证码</button></div>
				<label>上传证明教师身份的照片：
					（如教师证内页，工作证，聘用书，不能使用教师证封面，自拍，身份证）<span>* </span></label>
				<p>
				</p>
				<div id="fileList" class="uploader-list"></div>
				<span class="plus_number" id="file">+</span>
				<li onclick="form1()">提交</li>
				<input type="hidden" name="type" value="0">
			</form>
		</div>

		<div class="form_tabs"  style="display: none;">
			<form id="form2" action="${pageContext.request.contextPath}/certification/certificate.action?type=2" method="post">
				<div class="true_name"><span>* </span>真实姓名:<input type="text" name="name" id="username2"><i style="font-size: 14px;color: red" id="username_msg2"></i></div>

				<div class="select_province select_area ">
					<span>* </span><td>省:</td> <select name="province" id="province1"
													   onchange='_province1(this.value)' onmousedown="province_click()">
					<option   value="-1">--请选择！--</option>
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
				<div class="select_city select_area ">
					<span>* </span><td>市:</td> <select name="city" id="city1" onmousedown="city_click()"
													   onchange="_city1(this.value)">
					<option   value="-1">--请选择！--</option>
					<c:forEach items="${cityList}" var="pro">
						<c:if test="${pro.id == city}">
							<option selected="selected" value="${pro.id}">${pro.area_name}</option>
						</c:if>
						<c:if test="${pro.id != city}">
							<option value="${pro.id}">${pro.area_name}</option>
						</c:if>
					</c:forEach>

				</select>
				</div>
				<div class="select_county select_area ">

					<span>* </span><td>县:</td> <select name="county" id="county1"
													   onchange="_county1(this.value)">
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
				<br/>
				<br/>
				<br/>
				<div class="select_section">
					<span>* </span><td>管理级别:</td><select  name="type"  style="width:100px" id="certificate_type1">
					<option id="" value="1">学校管理员</option>
					<option id="" value="2">县级管理员</option>
					<option id="" value="3">市级管理员</option>
					<option id="" value="4">省级管理员</option>
				</select>
					<br/>
					<br/>
				</div>
				<div class="select_school" style="clear: both" id="select_school2">
					<span>* </span><td>学校:</td> <select name="school" id="school1"
														onchange="school(this.value)">
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
					<!--   <span>不属于学校？<span style="color: blue" id="not_school2">点击</span></span>
                    -->
					<i style="font-size: 14px;color: red" id="school_msg2"></i>
				</div>
				<div class="select_school" style="clear: both;display: none" id="danwei2">
					<span id="danwei_2">* </span>单位: <input placeholder="非学校请手动输入单位" type="text" name="schoolName" id="schoolName2" value="" >
					<i style="font-size: 14px;color: red" id="danwei_msg2"></i>
				</div>

				<div class="ID_number"><span>* </span>身份证号:<input type="text" name="ID_number" id="ID_number2">
					<i style="font-size: 14px;color: red" id="ID_number2_msg"></i>
				</div>
				<div class="sex"><span>* </span>性别:
					<p>
						<input type="radio" name="sex" class="sex_input" value="1" checked="checked">&nbsp;男
						<input type="radio" name="sex" class="sex_input" value="0">&nbsp;女
					</p>
				</div>
				<div class="email"><span>* </span>邮箱:<input type="email" name="email" id="email2"> <i style="font-size: 14px;color: red" id="email_msg2"></i></div>
				<c:if test="${!empty currentUser.phone}">
					<div class="cellphone_number"><span>* </span>手机号码:<input type="text" name="phone" id="phone2" value="${currentUser.phone}" readonly="readonly"></div>
				</c:if>
				<c:if test="${empty currentUser.phone}">
					<div class="cellphone_number"><span>* </span>手机号码:<input type="text" name="phone" id="phone2"><i style="font-size: 14px;color: red" id="phone_msg2"></i></div>
				</c:if>
				<div class="cellphone_number_resister"><span>* </span>验证码:<input type="text" name="yzm" id="yzm2" style="width: 230px;"><button class="verification_code">获取验证码</button></div>
				<li onclick="form2()">提交</li>
			</form>
		</div>
	</div>

</div>
<script type="text/javascript">
	function delStage(){
		$("#nullStage").remove();
	}
	function _province(value){

		$("#city").find("option").remove();
		$("#county").find("option").remove();
		$("#school").find("option").remove();
		$("#city").append('<option value=-1 >--请选择！--</option>');
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
	function province_click(){

		$("#province1").val(-1);
		$("#province").val(-1);
	}
	function city_click(){

		$("#city1").val(-1);
		$("#city").val(-1);
	}

	function _province1(value){
		$("#city1").find("option").remove();
		$("#county1").find("option").remove();
		$("#school1").find("option").remove();
		$("#city1").append('<option value=-1 >--请选择！--</option>');
		$("#county1").append('<option value=-1 >--请选择！--</option>');
		$("#school1").append('<option value=-1 >--请选择！--</option>');
		$.ajax({
			url:"${pageContext.request.contextPath}/area/showArea.action?parentId="+value,
			dataType:'json',
			success:function(json){
				var a = JSON.stringify(json);
				var o = eval( "(" + a + ")" );
				for(var j in o){

					$("#city1").append('<option  value='+o[j].id+' >'+o[j].area_name+'</option>');
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
					$("#school1").append('<option  value='+o[j].id+' >'+o[j].schoolName+'</option>');
				}

			}

		});
	}

	function _city1(value){

		$("#county1").find("option").remove();

		$("#school1").find("option").remove();
		$("#county1").append('<option value=-1 >--请选择！--</option>');
		$("#school1").append('<option value=-1 >--请选择！--</option>');
		$.ajax({
			url:"${pageContext.request.contextPath}/area/showArea.action?parentId="+value,
			dataType:'json',
			success:function(json){
				var a = JSON.stringify(json);
				var o = eval( "(" + a + ")" );
				for(var j in o){
					$("#county1").append('<option  value='+o[j].id+' >'+o[j].area_name+'</option>');
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
					$("#school1").append('<option  value='+o[j].id+' >'+o[j].schoolName+'</option>');
				}

			}

		});

	}
	function _county1(value){

		$("#school1").find("option").remove();
		$("#school1").append('<option value=-1 >--请选择！--</option>');
		$.ajax({
			url:"${pageContext.request.contextPath}/area/showSchool.action?countyId="+value,
			dataType:'json',
			success:function(json){
				var a = JSON.stringify(json);
				var o = eval( "(" + a + ")" );
				for(var j in o){
					$("#school1").append('<option  value='+o[j].id+' >'+o[j].schoolName+'</option>');
				}

			}

		});



	}


	/* function _school(){
	 //alert($("#city").val())

	 $.ajax({
	 url:"${pageContext.request.contextPath}/area/showSchool.action?countyId="+$("#county").val(),
	 dataType:'json',
	 success:function(json){
	 var a = JSON.stringify(json);
	 var o = eval( "(" + a + ")" );
	 for(var j in o){
	 $("#school").append('<option  value='+o[j].id+' >'+o[j].schoolName+'</option>');
	 }

	 }

	 });
	 $("#school").find("option").remove();
	 } */
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

	//邮箱输入格式验证

	function form1(){


		var email_reg=/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
		var phone_reg=/^13[0-9]{9}$|14[0-9]{9}|15[0-9]{9}$|18[0-9]{9}|17[0-9]{9}$/;
		var isIDCard=/^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$|^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/;
		var username=$("#username1").val();
		var phone=$("#phone1").val();
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
			$("#username_msg1").html("真实姓名不能为空");
			return false;
		}else{
			$("#username_msg1").html("");
		}
		//学校
		if(school=="-1"){
			if($("#schoolName1").val()==""){

				if(certificate_type==1){
					$("#school_msg1").html("学校不能为空");
					return false;
				}
				$("#school_msg1").html("");
				$("#danwei_msg1").html("单位不能为空");
				return false;
			}
		}else{
			$("#danwei_msg1").html("");
		}
		//学段
		if(stage=="-1"&&certificate_type==1){

			$("#stage_msg").html("学段不能为空");

			return false;
		}else{
			$("#stage_msg").html("");
		}

		if(subject==-1&&certificate_type==1){
			$("#subject_msg").html("科目不能为空");
			return false;
		}else{
			$("#subject_msg").html("");
		}
		//版本
		if(edition=="-1"&&certificate_type==1){
			$("#edition_msg").html("版本不能为空");
			return false;
		}else{
			$("#edition_msg").html("");
		}
		//年级
		if(grade=="-1"&&certificate_type==1){
			$("#grade_msg").html("年级不能为空");
			return false;
		}else{
			$("#grade_msg").html("");
		}
		//身份证号码
		if(ID_number1==""){
			$("#ID_number1_msg").html("身份证号码不能为空");
			return false;
		}else{
			$("#ID_number1_msg").html("");
		}
		if(!isIDCard.test(ID_number1)){
			$("#ID_number1_msg").html("身份证格式不正确");
			return false;
		} else{
			$("#ID_number1_msg").html("");
		}
		//邮箱
		if(email==""){
			$("#email_msg1").html("邮箱不能为空");
			return false;
		}else{
			$("#email_msg1").html("");
		}
		if(!email_reg.test(email)){
			$("#email_msg1").html("邮箱格式不正确");
			return false;
		} else{
			$("#email_msg1").html("");
		}
		//手机
		if(phone==""){
			$("#phone_msg1").html("手机号不能为空");
			return false;
		}else{
			$("#phone_msg1").html("");
		}
		if(!phone_reg.test(phone)){
			$("#phone_msg1").html("手机格式不正确");
			return false;
		}else{
			$("#phone_msg1").html("");
		}
		var i=$('#form1').find('.hidden').length;
		if(i<1){
			alert("请上传图片");
			return false;
		}


		$("#form1").submit();






	}
	function form2(){
		var email_reg=/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
		var phone_reg=/^13[0-9]{9}$|14[0-9]{9}|15[0-9]{9}$|18[0-9]{9}|17[0-9]{9}$/;
		var isIDCard=/^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$|^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/;
		var username=$("#username2").val();
		var phone=$("#phone2").val();
		var email=$("#email2").val();
		var school=$("#school1").val();
		ID_number2=$("#ID_number2").val();
		var certificate_type=$("#certificate_type1").val();
		//用户名
		if(username==""){
			$("#username_msg2").html("真实姓名不能为空");
			return false;
		}else{
			$("#username_msg2").html("");
		}
		//学校
		if(school=="-1"){
			if($("#schoolName2").val()==""){

				if(certificate_type==1){
					$("#school_msg2").html("学校不能为空");
					return false;
				}
				$("#school_msg2").html("");
				$("#danwei_msg2").html("单位不能为空");
				return false;
			}
		}else{
			$("#danwei_msg2").html("");
		}
		//身份证号码
		if(ID_number2==""){
			$("#ID_number2_msg").html("身份证号码不能为空");
			return false;
		}else{
			$("#ID_number2_msg").html("");
		}
		if(!isIDCard.test(ID_number2)){
			$("#ID_number2_msg").html("身份证格式不正确");
			return false;
		} else{
			$("#ID_number2_msg").html("");
		}
		//邮箱
		if(email==""){
			$("#email_msg2").html("邮箱不能为空");
			return false;
		}else{
			$("#email_msg2").html("");
		}
		if(!email_reg.test(email)){
			$("#email_msg2").html("邮箱格式不正确");
			return false;
		} else{
			$("#email_msg2").html("");
		}
		//手机
		if(phone==""){
			$("#phone_msg2").html("手机号不能为空");
			return false;
		}else{
			$("#phone_msg2").html("");
		}
		if(!phone_reg.test(phone)){
			$("#phone_msg2").html("手机格式不正确");
			return false;
		}else{
			$("#phone_msg2").html("");
		}

		$("#form2").submit();

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
					'<input type="hidden" value="'+response.fileName+'" name="picture'+i+'" class="hidden">' );
			var $form=$("#form1");
			$form.append(hidden);
			i++;
		});

		// 当有文件添加进来的时候
		uploader.on( 'fileQueued', function( file ) {

			// <input type="hidden">
			var $img;
			var $li = $(
							'<div id="' + file.id + '" class="file-item thumbnail">' +
							'<img>' +
							'<div class="info">' + file.name + '</div>' +
							'</div>'
					),
					$img = $li.find('img');

			if (3 ==$('#fileList').find('.file-item').length)
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

		$("#not_school1").click(function(){

			$("#schoolName1").show();
		});
		$("#not_school2").click(function(){

			$("#schoolName2").show();
		});
		$("#certificate_type").change(function(){

			var i=$(this).val();
			if(i!=1){
				$("#danwei1").show();
				$("#select_school1").hide();
				$("#select_stage").hide();
				$("#select_subject").hide();
				$("#select_grade").hide();
				$("#select_position").hide();
				$("#select_titles").hide();
				$("#select_version").hide();
			}
			else{
				$("#danwei1").hide();
				$("#select_school1").show();
				$("#select_stage").show();
				$("#select_subject").show();
				$("#select_grade").show();
				$("#select_position").show();
				$("#select_titles").show();
				$("#select_version").show();
			}
		});
		$("#certificate_type1").change(function(){

			var i=$(this).val();
			if(i!=1){
				$("#danwei2").show();
				$("#select_school2").hide();
			}
			else{
				$("#danwei2").hide();
				$("#select_school2").show();
			}
		});
	});

</script>

<jsp:include page="../layout/footer.jsp"></jsp:include>