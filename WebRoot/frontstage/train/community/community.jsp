<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<link rel="stylesheet"  href="${pageContext.request.contextPath}/frontstage/css/community.css"  type="text/css"/>
<link rel="stylesheet"  href="${pageContext.request.contextPath}/frontstage/css/bootstrap-select.min.css"  type="text/css"/>

<link href="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/bootstrap-select.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/My97DatePicker/WdatePicker.js"></script>
<style>
	#defaultImg{
		width:540px;height:270px;}
	.file:hover{color: #fff;}
	.webuploader-pick>div>label:hover{color: #fff;}
</style>

<div class="cn-wrap" >

	<div id="content-container" class="container" style="margin-top: 20px;">
		<c:if test="${!empty communityView.id}">
			<jsp:include page="community_header.jsp"></jsp:include>
		</c:if>
		<c:if test="${empty communityView.id}">
			<jsp:include page="/frontstage/base/personalCenter/personal_header.jsp"></jsp:include>
		</c:if>

		<div class="row row-3-9">
			<c:if test="${!empty communityView.id}">
				<jsp:include page="community_left.jsp"></jsp:include>
			</c:if>
			<c:if test="${empty communityView.id}">
				<jsp:include page="/frontstage/base/personalCenter/personal_left.jsp"></jsp:include>
			</c:if>
			<div class="col-lg-9 col-md-8  course-detail-main" >

				<div class="panel panel-default panel-col course-data">
					<div class="panel-heading">创建社区

					</div>
					<div class="panel-body">
						<form class="form-horizontal" method="post" id="communityForm" action="${pageContext.request.contextPath}/community/save_community.action">
							<input type="hidden" id="periods" name="periods" value="${communityView.periods}"/>
							<input type="hidden" id="subjects" name="subjects" value="${communityView.subjects}"/>
							<input type="hidden" name="flag" value="1"/>
							<input type="hidden" id="id" name="id" value="${communityView.id}"/>
							<c:if test="${!empty communityView.id}">
							<input type="hidden" name="is_default_img" value="1"/>
							</c:if>
							<div class="form-group">

								<div class="col-md-2 control-label">
									<label><span class="text-danger">*</span>社区名称</label>
								</div>
								<div class="col-md-4 controls">
									<input type="text"  name="name" value="${communityView.name}" class="form-control" placeholder="请输入社区名称">
								</div>
							</div>

							<div class="form-group">
								<div class="col-md-2 control-label"><label>社区头像</label></div>
								<div class="col-md-4 controls">
									<div id="headFile" class="upload_course_picture" ></div>
									<c:if test="${!empty communityView.head_img }">
										<img id="hedimg" style="width:250px;height:140px;" src="${pageContext.request.contextPath}${communityView.head_img}" >
									</c:if>
								</div>

								<div class="col-md-2 control-label">
									<a href="javascript:void(0)" id="headImg" class="btn btn-info btn-sm ">
										<i class="glyphicon glyphicon-plus"></i>社区头像
									</a>
								</div>

							</div>

							<%--<div class="form-group">--%>
							<%--<div class="col-md-2 control-label"><label>社区背景</label></div>--%>
							<%--<div class="col-md-4 controls">--%>
							<%--<div id="backFile" class="upload_course_picture" ></div>--%>
							<%--<c:if test="${!empty communityView.back_img }">--%>
							<%--<img id="backimg" style="width:250px;height:140px;" src="${pageContext.request.contextPath}${communityView.back_img}" >--%>
							<%--</c:if>--%>

							<%--</div>--%>
							<%--<div class="col-md-2 control-label">--%>
							<%--<a href="javascript:void(0)"  id="backImg" class="btn btn-info  btn-sm " >--%>
							<%--<i class="glyphicon glyphicon-plus"></i>社区背景--%>
							<%--</a>--%>
							<%--</div>--%>

							<%--</div>--%>
							<div class="form-group">
								<label class="col-md-2 control-label">是否需要审核</label>
								<div class="col-md-8 controls radios community_type">
									<label><input type="radio" name="is_examine" value="1" <c:if test="${communityView.is_examine==1 }">checked</c:if> class="" checked> 否 </label>
									<label><input type="radio" name="is_examine" value="0" <c:if test="${communityView.is_examine==0 }">checked</c:if> class="" > 是</label>
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-2 control-label"><label>地区</label></div>
								<div class="col-md-2 controls">
									<input type="hidden" id="area_id" name="area_id" value="${communityView.area_id }">
									<select name="province" id="province"onchange='_province(this.value)' class="form-control" >
										<option  <c:if test="${'1'==communityView.province}"> selected="selected"</c:if> value="1">--全国--</option>
										<c:forEach items="${provinceList}" var="pro">
											<option <c:if test="${pro.id==communityView.province}"> selected="selected"</c:if> value="${pro.id}">${pro.area_name}</option>
										</c:forEach>
									</select>
								</div>
								<div class="col-md-2 controls">
									<select name="city" id="city"  onchange="_city(this.value)" class="form-control">
										<option  <c:if test="${'-1'==communityView.city}"> selected="selected"</c:if> value="-1">全部</option>
										<c:forEach items="${cityList}" var="pro">
											<option <c:if test="${pro.id==communityView.city}"> selected="selected"</c:if>  value="${pro.id}">${pro.area_name}</option>
										</c:forEach>
									</select>
								</div>
								<div class="col-md-2 controls">
									<select  name="county" id="county" onchange="_county(this.value)" class="form-control">
										<option   <c:if test="${'-1'==communityView.county}"> selected="selected"</c:if>  value="-1">全部</option>
										<c:forEach items="${countyList}" var="pro">
											<option <c:if test="${pro.id==communityView.county}"> selected="selected"</c:if>  value="${pro.id}">${pro.area_name}</option>
										</c:forEach>
									</select>
								</div>
							</div>

							<div class="form-group">
								<label class="col-md-2 control-label">社区类型</label>
								<div class="col-md-8 controls radios community_type">
									<label><input type="radio" name="type" value="0" <c:if test="${communityView.type==0 }">checked</c:if> class="ordinary_train_community" checked> 普通社区</label>
									<label><input type="radio" name="type" value="1" <c:if test="${communityView.type==1 }">checked</c:if> class="teacher_train_community"> 教师培训社区 </label>
								</div>
							</div>

							<div class="teacher_train_community_content" style="display: none;">
								<div class="form-group clearfix" >
									<div class="col-md-2 control-label">
										<label>起止时间</label>
									</div>

									<div class="col-md-2 controls">
										<input type="text" class="form-control" value="${communityView.start_time}" name="start_time" onClick="WdatePicker()">
										<div class="help-block" style="display: none;"><span class="text-danger">请输入开始时间</span></div>
									</div>
									<div class="col-md-1 control-label" style="margin-left: -30px;">
										<div>至</div>
									</div>
									<div class="col-md-2 controls">
										<input type="text" class="form-control" value="${communityView.end_time}" name="end_time" onClick="WdatePicker()">
										<div class="help-block" style="display: none;"><span class="text-danger">请输入结束时间</span></div>
									</div>
								</div>
								<div class="form-group">
									<div class="col-md-2 control-label"><label>所属类型</label></div>
									<div class="col-md-3 controls">
										<select  name="the_type" class="form-control">
											<option value="">--请选择--</option>
											<option <c:if test="${communityView.the_type==0 }">selected</c:if> value="0">综合素质</option>
											<option <c:if test="${communityView.the_type==1 }">selected</c:if> value="1">其他</option>
										</select>
									</div>
								</div>
								<div class="form-group">
									<div class="col-md-2 control-label"><label>等级</label></div>
									<div class="col-md-3 controls">
										<select name="grade" class="form-control">
											<option  value="-1">--请选择--</option>
											<option <c:if test="${communityView.grade==0 }">selected</c:if> value="0">省级</option>
											<option <c:if test="${communityView.grade==1 }">selected</c:if> value="1">市级</option>
											<option <c:if test="${communityView.grade==2 }">selected</c:if> value="2">县级</option>
										</select>
									</div>
								</div>
								<div class="form-group">
									<div class="col-md-2 control-label"><label>计划人数</label></div>
									<div class="col-md-3 controls">
										<input type="text" name="plan_num" value="${communityView.plan_num }" class="form-control" placeholder="请输入人数">
									</div>
								</div>

								<div class="form-group">
									<div class="col-md-2 control-label"><label>学分</label></div>
									<div class="col-md-3 controls">
										<input type="text" name="credit" value="${communityView.credit }" class="form-control" placeholder="请输入学分">
									</div>
								</div>

								<div class="form-group">
									<div class="col-md-2 control-label"><label>学时</label></div>
									<div class="col-md-3 controls">
										<input type="text" name="hour" value="${communityView.hour }" class="form-control" placeholder="请输入学时">
									</div>
								</div>


								<div class="form-group">
									<div class="col-md-2 control-label"><label>学段</label></div>
									<div class="col-md-3 controls">
										<c:forEach items="${periodList}" var="per">
											<div class="checkbox">
												<label>
													<input type="checkbox" <c:if test="${fn:contains(communityView.periods,per.id)}">checked</c:if> onclick="doPeriod();" name="period" value="${per.id}" />${per.subjectName}
												</label>
											</div>
										</c:forEach>
									</div>
								</div>

								<div class="form-group">
									<div class="col-md-2 control-label"><label>学科</label></div>
									<div class="col-md-3 controls">
										<select  id="subject" name="subject" onChange="doSubject();" class="selectpicker" multiple data-live-search="true" data-live-search-placeholder="搜索" title="未选择">
											<c:forEach items="${periodSubjectList}" var="periodSubject">
												<option value="${periodSubject.id}">${periodSubject.subjectName}</option>
											</c:forEach>
										</select>
									</div>
								</div>


							</div>


							<div class="form-group clearfix" style="margin-top: 80px;">
								<div class="col-md-offset-5 col-md-2 controls">
									<button class="btn btn-fat btn-primary" type="submit" >保存</button>
								</div>

							</div>
						</form>

					</div>
				</div>
			</div>
		</div>

	</div>
</div>

<script>

	function _province(value){
		$("#area_id").val(value);
		$("#city").find("option").remove();
		$("#county").find("option").remove();
		$("#city").append('<option value=-1 >全部</option>');
		$("#county").append('<option value=-1 >全部</option>');
		
		if(value==1){
		value=0;
		}
		$.ajax({
			url:"${pageContext.request.contextPath}/area/showArea.action?parentId="+value,
			dataType:'json',
			success:function(json){
				var a = JSON.stringify(json);
				var o = eval( "(" + a + ")" );
				var html = "";
				for(var j in o){
					html += '<option  value='+o[j].id+' >'+o[j].area_name+'</option>';
				}
				$("#city").append(html);
			}
		});
	}

	function _city(value){
		$("#area_id").val(value);
		$("#county").find("option").remove();
		$("#county").append('<option value=-1 >全部</option>');
		$.ajax({
			url:"${pageContext.request.contextPath}/area/showArea.action?parentId="+value,
			dataType:'json',
			success:function(json){
				var a = JSON.stringify(json);
				var o = eval( "(" + a + ")" );
				var html = "";
				for(var j in o){
					html += '<option  value='+o[j].id+' >'+o[j].area_name+'</option>';
				}
				$("#county").append(html);
			}

		});
	}

	function _county(value){
		$("#area_id").val(value);
	}

	//选择学段
	function doPeriod(){
		var a = document.getElementsByName("period");
		var ids = "";
		for(var i = 0;i<a.length;i++){
			if(a[i].checked){
				ids += a[i].value + ",";
			}
		}
		if(ids != ""){
			$("#periods").val(ids);
			searchSubject(ids);
		}else{
			$("#subject").empty();
		}
	}
	//选择学科
	function doSubject(){
		$("#subjects").val($("#subject").val());
	}
	function searchSubject(ids){
		$.ajax({
			url:"${pageContext.request.contextPath}/subject/search_subject.action",
			data:{
				ids : ids
			},
			dataType:'json',
			success:function(d){
				if(d==0){//没有数据

				}else{
					var html ="";
					for(var i=0;i<d.length;i++){
						html+='<option  value="'+d[i].id+'">'+d[i].subjectName+'</option>';
					}
					$("#subject").empty().append(html);
					setSubject();
				}
			}
		});
	}

	$(document).ready(function() {

		$('#communityForm').bootstrapValidator({
			message: '此值无效',
			feedbackIcons: {
				valid: 'glyphicon glyphicon-ok',
				invalid: 'glyphicon glyphicon-remove',
				validating: 'glyphicon glyphicon-refresh'
			},
			fields: {
				name:{
					message: '社区名称验证失败',
					validators: {
						notEmpty: {
							message: '社区名称不能为空'
						},
						stringLength: {
							min: 4,
							max: 15,
							message: '社区名称长度4-15'
						}
					}
				},
				the_type:{
					validators: {
						notEmpty: {
							message: '请选择所属类型'
						}
					}
				},
				the_type:{
					validators: {
						notEmpty: {
							message: '请选择所属类型'
						}
					}
				},
				city:{
					validators: {
						notEmpty: {
							message: '请选择市级'
						}
					}
				},
				county:{
					validators: {
						notEmpty: {
							message: '请选择县级'
						}
					}
				},
				hour:{
					validators: {
						notEmpty: {
							message: '请输入学时'
						},
						digits: {
							message: '只能是数字'
						}
					}
				},
				credit:{
					validators: {
						notEmpty: {
							message: '请输入学分'
						},
						digits: {
							message: '只能是数字'
						}
					}
				},
				plan_num:{
					validators: {
						notEmpty: {
							message: '请输入计划人数'
						},
						digits: {
							message: '只能是数字'
						}
					}
				},
				period:{
					validators: {
						choice: {
							min: 1,
							message: '请最少选择一种学段'
						}
					}
				},
				subject:{
					validators: {
						choice: {
							min: 1,
							message: '请最少选择一种学科'
						}
					}
				}

			}
		}).on('success.form.bv', function(e) {
			if(e.type){//验证成功
				document.getElementById('communityForm').submit();
			}else{
				// 防止表单提交
				e.preventDefault();
			}
		});

		var uploader = WebUploader.create({
			auto: true,
			// swf文件路径
			swf: '${pageContext.request.contextPath}/frontstage/js/webuploader/Uploader.swf',
			// 文件接收服务端。
			server: '${pageContext.request.contextPath}/community/upload_img.action',

			// 选择文件的按钮。可选。
			// 内部根据当前运行是创建，可能是input元素，也可能是flash.
			pick: "#headImg",

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
			var hidden=$('<input type="hidden" value="'+response.fileName+'" name="head_img" class="hidden">' );
			var $form=$("#communityForm");
			$form.append(hidden);
		});

		// 当有文件添加进来的时候
		uploader.on( 'fileQueued', function( file ) {

			// <input type="hidden">
			var $img;
			var $li = $(
							'<div id="' + file.id + '" class="file-item thumbnail">' +
							'<img style="margin:20 0 0 110">' +
								/*  '<div class="info">' + file.name + '</div>' + */
							'</div>'
					),
					$img = $li.find('img');
			var   $list=$("#headFile");

			// $list为容器jQuery实例
			$list.append( $li );
			$("#headImg").hide();
			$("#hedimg").hide();

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
		var uploader1 = WebUploader.create({
			auto: true,
			// swf文件路径
			swf: '${pageContext.request.contextPath}/frontstage/js/webuploader/Uploader.swf',
			// 文件接收服务端。
			server: '${pageContext.request.contextPath}/community/upload_img.action',

			// 选择文件的按钮。可选。
			// 内部根据当前运行是创建，可能是input元素，也可能是flash.
			pick: "#backImg",

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
		uploader1.on( 'uploadSuccess', function( file,response  ) {
			var hidden=$('<input type="hidden" value="'+response.fileName+'" name="back_img" class="hidden">' );
			var $form=$("#communityForm");
			$form.append(hidden);
		});

		// 当有文件添加进来的时候
		uploader1.on( 'fileQueued', function( file ) {

			// <input type="hidden">
			var $img;
			var $li = $(
							'<div id="' + file.id + '" class="file-item thumbnail">' +
							'<img style="margin:20 0 0 110">' +
								/*  '<div class="info">' + file.name + '</div>' + */
							'</div>'
					),
					$img = $li.find('img');
			var   $list=$("#backFile");

			// $list为容器jQuery实例
			$list.append( $li );
			$("#backImg").hide();
			$("#backimg").hide();



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


	});
	$(function(){
		if('${communityView.type}'== 1){
			setSubject();
			$(".teacher_train_community_content").slideDown();
		}
		$(".teacher_train_community").click(function(){
			$(".teacher_train_community_content").slideDown();
		});
		$(".ordinary_train_community").click(function(){
			$(".teacher_train_community_content").slideUp();
		});
	})
	function setSubject(){
		if('${communityView.subjects}'!=''){
			var str='${communityView.subjects}';
			var arr=str.split(',');
			$('#subject').selectpicker('val',arr);
		}
		$('#subject').selectpicker('refresh');
	}
</script>

<jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>