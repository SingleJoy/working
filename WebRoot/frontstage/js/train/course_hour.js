
//预览
function doPreview(value,course_id){
	//window.location.href="../course_study/to_study.action?id="+value;
	window.location.href="../course_study/to_study_preview.action?id="+value+"&source_type=0&learn_id="+course_id;
}

//	添加课时类型
$(function () {
    $("#resource_type").find("label").click(function () {

        var index=$(this).index();
		$(".resource_type").hide().eq(index).show();
		$(".resource_type input[name='file_source']").attr("disabled","disabled").eq(index).removeAttr("disabled");
		$(".resource_type input[name='course_file_id']").attr("disabled","disabled").eq(index).removeAttr("disabled");
		$(".resource_type input[name='course_file_isuse']").attr("disabled","disabled").eq(index).removeAttr("disabled");
    })
});

// 添加视频切换资源
$(function () {
	$(".resource_type").find("div").find("div").find("div").find("ul").find("li").click(function () {

		var index=$(this).index();
		
		$(this).addClass("active").siblings().removeClass("active");
		$(this).parent().parent().parent().parent().parent().find(".upload_video_tab").hide().eq(index).show();
		//初始化上传按钮显示
		$("#uploadFile").show();
		$("#uploadFile1").show();
		$("#uploadFile2").show();
		$(".up_file_message").remove();
    })
})



//删除章节、课时
function doDeleteHour(value,type,courseId,sign){
	var str = "";
	if(type==1){//章节
		str = '删除节的同时会删除章节下所有课时。\r您真的要删除节吗？';
	}else if(type==2){//课时
		str = '删除课时的同时会删除课时的资料、测验。\r您真的要删除课时吗？';
	}else if(type==0){
		str = '您确定要删除考试吗？'
	}else if(type==3){
		str = '您确定要删除研讨吗？'
	}else if(type==4){
		str = '您确定要删除作业吗？'
	}
	var result = confirm(str);
	if(result){
		window.location.href="../course_hour/delete_hour.action?id="+value+"&AttributeType="+type+"&courseId="+courseId+"&sign="+sign+"&ver="+Math.ceil(Math.random()*100);
	}
}
//选择课时文件
function doCourseFile(nameVal,idVal,sourceVal,dataVal,isUse,currNo){
	if(dataVal==0){
		//$("#file_source").val(sourceVal);
		//$("#course_file_id").val(idVal);
		//$("#course_file_isuse").val(isUse);
        // $(".up_file_message").remove();
        // $("#uploadFile").show();
        // $("#uploadFile1").show();
        // $("#uploadFile2").show();
		$(".resource_type input[name='file_source']").eq(currNo).val(sourceVal)
		$(".resource_type input[name='course_file_id']").eq(currNo).val(idVal)
		$(".resource_type input[name='course_file_isuse']").eq(currNo).val(isUse)
		
		if($("#hour_title").val()==null||$("#hour_title").val().trim()===""){
			$("#hour_title").val(nameVal.substring(0,nameVal.lastIndexOf(".")));
		}
		//$("#selectVideo").css("display","none");
		$(".resource_type .show_select_resource").eq(currNo).css("display","");
		$(".resource_type .show_select_resource").eq(currNo).empty().append("<div style=\"display:inline-block;font-size: 14px;padding-top: 8px;color:red;\">"+nameVal+"</div> &nbsp;&nbsp;<a href=\"javascript:void(0);\" onclick=\"doEditCourseFile();\" class='edit_class'><i class=\'glyphicon glyphicon-edit\'></i>编辑</a>");
	}else if(dataVal==1){
		$("#courseFileId").val(idVal);
		$("#courseFileName").val(nameVal);
		$("#empty_ziliao").hide();
		$("#content").empty().append('<li class="list-group-item clearfix"><button onclick="re_select(1);" class="close delete-btn" type="button" title="删除" >×</button><a href="javascript:void(0);">'+nameVal+'</a></li>');
	}

}
//编辑选择的课时文件
function doEditCourseFile(){
	$(".resource_type .show_select_resource").not(":hidden").hide();
	//$("#selectVideo").css("display","");
	//$(".resource_type .show_select_resource").css("display","none");
	
	$(".resource_type input[name='course_file_id']").not(":disabled").val("");
	$(".resource_type input[name='file_source']").not(":disabled").val("");
	$(".resource_type input[name='course_file_isuse']").not(":disabled").val("");
	$("[name='img_txt']").val("");
	//初始化上传按钮显示
	$("#uploadFile").show();
	$("#uploadFile1").show();
	$("#uploadFile2").show();
	$(".up_file_message").remove();
}
//添加课时子资料
function doAddFile(){
	$("#isSon").val("0");
	var fileId = $("#courseFileId").val();
	if(fileId!=''){
		document.getElementById('hourFileAdd').submit();
	}else{
		alert("请选择文件，需要修改提示样式");
	}
}
//打开添加课时div
$(function(){
	$(".close").click(function(){
		$("#mask").remove();
	})
})
function addHour(courseId,chapter_id){
	//初始化容器
	initHourContainer(courseId);
	$("#add_hour").modal();
	//modal和UEditor层冲突 调整modal层
	//$(".modal-backdrop").css("z-index","800");
	//$("#add_hour").css("z-index","850");
	$("#isSon").val("1");
	if(chapter_id>0){
		loadingChapter(courseId,chapter_id);
	}else{
		$("#chapter_parent_id option").removeAttr("selected");
		$("[name='hour_seq']").val("");
	}
}

//初始化添加课时容器
function initHourContainer(courseId){
	weditor.txt.clear();
	$(".title_val").hide();
	$("#img_txt").val("");
	$("#add_hour #hour_title").val("");
	$(".resource_type .show_select_resource").empty();
	$("#uploadFile").show();
	$("#uploadFile1").show();
	$("#uploadFile2").show();
	$(".up_file_message").remove();
	doEditCourseFile();
	$(".video_source").hide();
	$("#fileList").show();
	$("#resource_type input").first().prop("checked","checked");
	$(".resource_type").hide().eq(0).show();
	//默认选中第一个上传视频且显示上传视频按钮
	$(".resource_type ul li").first().addClass("active").siblings().removeClass("active");
	//$(".resource_type").find(".upload_video_tab").hide().eq(0).show();
	$(".resource_type #fileList").find(".upload_video_tab").hide().eq(0).show();
	doUpload(courseId,0);
}

//添加课程-加载当前课程所在章节
function loadingChapter(courseId,chapter_id){
	var curr_chapter = $("#chapter_parent_id option[value='"+chapter_id+"']");
	$(curr_chapter).prop("selected","selected");
	doSeq(chapter_id,courseId);
}
var hour_id;
var course_id;
var course_sign;
//添加课时资料
function addHourFile(value,courseId,sign){
	hour_id = value;
	course_id = courseId;
	course_sign = sign;
	$("#isSon").val("0");
	$("#hourId").val(value);
	$.ajax({
		url:"../course_hour_file/get_hour_file.action",
		data:{
			hourId:value
		},
		dataType:'json',
		success:function(json){
			var a = JSON.stringify(json);
			var o = eval( "(" + a + ")" );
			var html= "";
			if(o.length==0){
				html="<div id=\"empty_ziliao\" class=\"empty\">暂无资料，请上传。</div>";
			}else{
				for(var i=0;i<o.length;i++){
					html +="<li class='list-group-item clearfix'><button type='button' title='删除' onclick=\"doDeleteHourFile("+o[i].id+","+courseId+","+sign+");\" class=\"close delete-btn\">×</button><a href=\"javascript:void(0);\">"+o[i].fileName+"</a></li>";
				}
			}
			$("#content").empty().append(html);
		}
	});
	doUpload(courseId,0);
}

//删除课时子文件
function doDeleteHourFile(value,courseId,sign){
	var result = confirm('真的要移除该文件吗？');
	if(result){
		window.location.href="../course_hour_file/delete_hour_file.action?id="+value+"&courseId="+courseId+"&sign="+sign+"&ver="+Math.ceil(Math.random()*100);
	}
}

//编辑章节、课时
function doEdit(value,type){
	$(".title_val").hide();
	var chname;
	if(type==2){//课时
		chname="#course_hour_edit [name='id']";
	}else if(type==1){//章节
		chname="#add_chapter [name='id']";
	}else if(type==3){//讨论
		chname="#add_discuss [name='id']";
	}else if(type==0){//考试
		chname="#add_paper [name='id']";
	}else if(type==4){//作业
		chname="#editTask [name='id']";
	}
	$.ajax({
		url:"../course_hour/get_hour.action",
		data:{
			id:value
		},
		dataType:'json',
		success:function(d){
			$(chname).val(value);
			//$("[id='"+d[0].parent_id+"']").val(d[0].parent_id);
			if(type==2){//课时
				$("#course_hour_edit").modal();
				//showMask();
				$("[name='hour_seq']").val(d[0].hour_seq);
				$("#hour_title_").val(d[0].hour_title);
				$("#remarks_").val(d[0].remarks);
				$("#chapter_parent_id_ option[value='"+d[0].parent_id+"']").attr("selected","selected");
			}else if(type==1){//章节
				$("#add_or_edit_chapter").text("编辑章节");
				$("[name='hour_seq']").val(d[0].hour_seq);
				$("#chapter_title").val(d[0].hour_title);
				$("#add_chapter").modal();
			}else if(type==3){//讨论
				openDiv('add_discuss');
				$("[name='hour_seq']").val(d[0].hour_seq);
				$("#discussTitle").val(d[0].hour_title);
				$("#discussRemarks").val(d[0].remarks);
				$("#discussFre").val(d[0].frequency);
				$("#discussParentId option[value='"+d[0].parent_id+"']").attr("selected","selected");
				
			}else if(type==0){//考试
				$("#isEdit").val(1);
				document.getElementById("test_paper_select").style.display="none";
				openDiv('add_paper');
				$("[name='hour_seq']").val(d[0].hour_seq);
				$("#examTitle").val(d[0].hour_title);
				$("#examParentId option[value='"+d[0].parent_id+"']").attr("selected","selected");
			}else if(type==4){//作业
				openDiv('editTask');
				$("[name='hour_seq']").val(d[0].hour_seq);
				$("[name='remarks']").val(d[0].remarks);
				$("#taskTitle").val(d[0].hour_title);
				$("#taskParentId option[value='"+d[0].parent_id+"']").attr("selected","selected");
			}
		}
	});

}
//是否免费课时
function doChecked(){
	var checked =document.getElementById("free").checked;
	if(checked){//选中
		$("#is_free").val(0);
	}else{
		$("#is_free").val(1);
	}
}
//验证课时
function validate(){
	var hour_title = $("#hour_title").val();
	var parent = $('#chapter_parent_id option:selected').val();
	
	var title_val = false;
	var parent_val = false;
	var imgtxt_val = true;
	if(hour_title==""||hour_title.length>18){
		$(".title_val").show();
	}else{
		$(".title_val").hide();
		title_val = true;
	}
	if(parent==0){
		$(".edit_section").children().addClass("curr");
		$("#section_val").show();
	}else{
		$(".edit_section").children().removeClass("curr");
		$("#section_val").hide();
		parent_val =  true;
	}
	var ch_type = $("input[name='hour_type']:checked").val();
	if(ch_type==='3'){
		var _img_txt = $("[name='img_txt']").val();
		if(_img_txt==""||_img_txt==="<p><br></p>"){
			$("#img_txt_vail").show();
			imgtxt_val=false;
		}else{
			$("#img_txt_vail").hide();
		}
	}
	if((title_val==true&&parent_val==true)&&imgtxt_val){
		return true;
	}else{
		return false;
	}
}
//提交课时
function doSubmitHour(){
	var ch_type = $("input[name='hour_type']:checked").val();
	var fileId ;
	if(ch_type==='0'){
		fileId = $("#course_file_id").val();
	}else{
		fileId = $("#course_file_id"+ch_type).val();
	}
	if(ch_type==='3'){
		$("[name='img_txt']").val(weditor.txt.html());
	}
	var val = validate();
	if(val){
		if(ch_type==='3'){
			document.getElementById('hourAdd').submit();
		}else{
			if(fileId!=''){
				document.getElementById('hourAdd').submit();
			}else{
				$(".file_val").addClass("curr");
				$(".file_val").show();
				return false;
			}
		}
	}else{
		return false;
	}
}
$(function(){
	$("#hour_title").blur(function(){
		validate();
	});
	$("#chapter_parent_id").blur(function(){
		validate();
	});
	
	$("[name='img_txt']").blur(function(){
		validate();
	});

	$("#chapter_title").blur(function(){
		validate_chapter();
	});
	
	$("#discussTitle").blur(function(){
		vilidateDiscuss();
	});	
	$("#discussFre").blur(function(){
		vilidateDiscuss();
	});	
	$("#discussParentId").blur(function(){
		vilidateDiscuss();
	});	
	
	$("#testPaperId").blur(function(){
		vilidateExam();
	});	
	$("#examTitle").blur(function(){
		vilidateExam();
	});	
	$("#examParentId").blur(function(){
		vilidateExam();
	});
	
	$("#taskTitle").blur(function(){
		vilidateTask();
	});	
	$("#taskParentId").blur(function(){
		vilidateTask();
	});	
	$("#live-title-field").blur(function(){
		validateLiving();
	});	
	
	$("#live-length-field").blur(function(){
		validateLiving();
	});
});
//验证章
function validate_chapter(){
	var _title = $("#chapter_title").val();
	var _sque = $("#chapterAdd input[name='hour_seq']").val();
	var reg=/^\d+$/;
	if(reg.test(_sque)){
		$("#chapter_sque").hide();
	}else{
		$("#chapter_sque").show();
		return false;
	}
	if(_title==''||_title.length>18){
		$(".edit_content_main").children().addClass("curr");
		$(".title_val").show();
		return false;
	}else{
		$(".edit_content_main").children().removeClass("curr");
		$(".title_val").hide();
	}
	return true;
}
//提交章节
function doSubmitCha(){
	if(validate_chapter()){
		document.getElementById('chapterAdd').submit();
	}else{
		return false;
	}
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

//上传文件
function doUpload(courseId,uf_type){
	var isSon = $("#isSon").val();
	var mime_type;
	var extension;
	var _fileList = "#fileList";
	var _uploadFile = "#uploadFile";
	var _single_file_size = 2*1024*1024*1024;
	if(isSon==1){//课时
		if(uf_type===0){
			mime_type = ".mp4";
			extension = "mp4";
		}else if(uf_type===1){
			mime_type = ".doc,.docx,.ppt,.pptx,.xls,.pdf,.txt";
			extension = "doc,docx,ppt,pptx,xls,pdf,txt";
			_fileList +="1";
			_uploadFile +="1";
		}else if(uf_type==2){
			mime_type = ".mp3";
			extension = "mp3";
			_fileList +="2";
			_uploadFile +="2";
		}else{
			return false;
		}
	}else if(isSon==0){//子文件
		mime_type = ".gif,.jpg,.jpeg,.bmp,.png,.doc,.docx,.ppt,.pptx,.xls,.pdf,.txt";
		extension = "gif,jpg,jpeg,bmp,png,doc,docx,ppt,pptx,xls,pdf,txt";
		_single_file_size = 50*1024*1024;
	}
	$(".resource_type .webuploader-pick").children().removeClass("webuploader-pick");
	var uploader = WebUploader.create({
		auto: true,
		// swf文件路径
		swf: '../frontstage/js/webuploader/Uploader.swf',
		// 文件接收服务端。
		server: '../course_file/upload_file.action?is_use=0&is_son='+isSon+'&courseId='+courseId,

		// 选择文件的按钮。可选。
		// 内部根据当前运行是创建，可能是input元素，也可能是flash.
		pick: '.file',

		// 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
		resize: false,
		accept: {
			extensions: extension,
			mimeTypes: mime_type   //修改这行
		},
		fileSingleSizeLimit: _single_file_size
	});
	//当有文件被添加进队列的时候 监听
	uploader.on( 'fileQueued', function( file ) {
		$(_fileList).append( '<div id="' + file.id + '" class="item">' +
	        '<h4 class="info">' + file.name + '</h4>' +
	        '<div class="state col-md-offset-2">等待上传...</div>' +
	    '</div>' );
	})
	// 文件上传过程中创建进度条实时显示。
	uploader.on( 'uploadProgress', function( file, percentage ) {
	    var $li = $( '#'+file.id ),
	        $percent = $li.find('.progress .progress-bar');

	    // 避免重复创建
	    if ( !$percent.length ) {
	        $percent = $('<div class="progress progress-striped active col-md-8 col-md-offset-2" style="padding: 0;">' +
	          '<div class="progress-bar" role="progressbar" style="width: 0%;margin:0;padding: 0;">' +
	          '</div>' +
	        '</div>').appendTo( $li ).find('.progress-bar');
	        $(_uploadFile).hide();
	    }
	    
	    $li.find('div.state').text('上传中');

	    $percent.css( 'width', percentage * 100 + '%' );
	});
	//上传失败后
	uploader.on( 'uploadError', function( file,response) {
		$(_uploadFile).hide();
		$( '#'+file.id ).hide();
		$(_fileList).append('<div class="up_file_message col-md-offset-3">'+file.name+'上传出错</div>');

	});

	/**
	 *上传成功后
	 *file:文件
	 *response:服务器返回
	 */
	uploader.on( 'uploadSuccess', function( file,response  ) {
		var isSon = $("#isSon").val();
		if(isSon==1){//课时
			/*
			if(uf_type===0){
				$("#course_file_id").val(response.courseFileId);
			}else{
				$("#course_file_id"+uf_type).val(response.courseFileId);
			}
			*/
			$(_uploadFile).hide();
			$( '#'+file.id ).hide();
			$(_fileList).append('<div class="up_file_message col-md-offset-3">'+response.courseFileName+'文件上传成功</p>');
			
			doCourseFile(response.courseFileName,response.courseFileId,0,0,0,uf_type);
		}else if(isSon==0){//子文件
			$("#courseFileId").val(response.courseFileId);
			$("#courseFileName").val(response.courseFileName);
			$("#uploadHourFile").hide();
			$("#file_msg").show();
			$("#file_msg").append('<span data-role="placeholder">'+response.courseFileName+'文件上传成功</span>');
			$("#file_msg").append('<button onclick="re_select(0);" class="btn btn-link btn-sm re_select" type="button" data-role="trigger" style="margin-left: 20px;"><i class="glyphicon glyphicon-edit"></i> 重新选择</button><button type="button" onclick="makesure0();" class="btn btn-info btn-sm pull-right" style="margin-right: 20px;">确定添加</button>');
		}
	});
	
	
}
function re_select(value){
	if(value==1){
		$("#content").children("li:last-child").hide();
	}
	$("#file_msg").empty().hide();
	$("#uploadHourFile").show();
	addHourFile(hour_id,course_id,course_sign);
}

function makesure0(){
	var filename = $("#courseFileName").val();
	if(filename!=""){
		$("#empty_ziliao").hide();
		$("#file_msg").hide();
		$("#content").append('<li class="list-group-item clearfix"><button onclick="re_select(1);" class="close delete-btn" type="button" title="删除" >×</button><a href="javascript:void(0);">'+filename+'</a></li>');
	}
}
//编辑课时验证
function validate_(){
	var hour_title = $("#hour_title_").val();
	var parent = $('#chapter_parent_id_ option:selected').val();
	var title_val = false;
	var parent_val = false;
	if(hour_title==""||hour_title.length>18){

		$(".title_val").show();
	}else{

		$(".title_val").hide();
		title_val = true;
	}
	if(parent==0){

		$(".section_val").show();
	}else{

		$(".section_val").hide();
		parent_val =  true;
	}
	if(title_val==true&&parent_val==true){
		return true;
	}else{
		return false;
	}
};
//编辑课时是否免费
function doChecke_d(){
	var checked =document.getElementById("free_").checked;
	if(checked){//选中
		$("#is_free_").val(0);
	}else{
		$("#is_free_").val(1);
	}
}

//编辑课时
function doEditHour(){
	$("#isSon").val("1");
    var val = validate_();
	if(val){
        document.getElementById('hourEdit').submit();
	}else{

		$(".title_val").show();
		return false;
	} 
}

//添加讨论
function doDiscussAdd(){
	var val = vilidateDiscuss();
	if(val){
        document.getElementById('courseDiscuss').submit();
	}else{
		return false;
	}
}

//验证讨论
function vilidateDiscuss(){
	var title = $("#discussTitle").val();
	var fre = $("#discussFre").val();
	var parent = $('#discussParentId option:selected').val();
	var title_val = false;
	var fre_val = false;
	var parent_val = false;
	if(title==""||title.length>18){
		$("#discuss_input").addClass("has-error");
		$("#discuss_input").find(".help-block").show();
	}else{
		$("#discuss_input").removeClass("has-error");
		$("#discuss_input").find(".help-block").hide();
		title_val = true;
	}
	if(!isNaN(fre)&&fre>=0&&(fre.indexOf(".")<0&&fre!='')){
		$("#fre_input").removeClass("has-error");
		$("#fre_input").find(".help-block").hide();
		fre_val = true;
	}else{
		$("#fre_input").addClass("has-error");
		$("#fre_input").find(".help-block").show();
	};

	if(parent==0){
		$("#parent_select").addClass("has-error");
		$("#parent_select").find(".help-block").show();
	}else{
		$("#parent_select").removeClass("has-error");
		$("#parent_select").find(".help-block").hide();
		parent_val =  true;
	};
	if(title_val==true&&fre_val==true&&parent_val==true){
		return true;
	}else{
		return false;
	}
	
}

//添加作业
function addTask(id,sign,flag,course_hour_id){
	if(course_hour_id==null){
		window.location.href="../course_hour/to_course_hour_task.action?id="+id+"&sign="+sign+"&flag="+flag+"&ver="+Math.ceil(Math.random()*100);
	}else{
		window.location.href="../course_hour/to_course_hour_task.action?id="+id+"&sign="+sign+"&flag="+flag+"&course_hour_id="+course_hour_id+"&ver="+Math.ceil(Math.random()*100);
	}
	}

//选中试卷
function doChangeTestPaper(id){
	$("#test_paper_id").val(id);
}

//添加考试
function doExamAdd(){
	var val = vilidateExam();
	if(val){
        document.getElementById('courseExam').submit();
	}else{
		return false;
	}
}
//验证考试
function vilidateExam(){
	var isEdit = $("#isEdit").val();
	var title = $("#examTitle").val();
	var testPaperId = $('#testPaperId option:selected').val();
	var parent = $('#examParentId option:selected').val();
	var parent_val = false;
	var title_val = false;
	var testPaperId_val = false;
	if(title==""||title.length>18){
		$("#exam_input").addClass("has-error");
		$("#exam_input").find(".help-block").show();
	}else{
		$("#exam_input").removeClass("has-error");
		$("#exam_input").find(".help-block").hide();
		title_val = true;
	}

	if(isEdit==0){
		if(testPaperId==0){
			$("#test_paper_select").addClass("has-error");
			$("#test_paper_select").find(".help-block").show();
		}else{
			$("#test_paper_select").removeClass("has-error");
			$("#test_paper_select").find(".help-block").hide();
			testPaperId_val =  true;
		}
	}else{
		testPaperId_val =  true;
	}
	
	if(parent==0){
		$("#exam_parent_select").addClass("has-error");
		$("#exam_parent_select").find(".help-block").show();
	}else{
		$("#exam_parent_select").removeClass("has-error");
		$("#exam_parent_select").find(".help-block").hide();
		parent_val =  true;
	};
	if(title_val==true&&parent_val==true&&testPaperId_val==true){
		return true;
	}else{
		return false;
	}
}
//编辑作业
function doTaskAdd(){
	var val = vilidateTask();
	if(val){
        document.getElementById('courseTask').submit();
	}else{
		return false;
	}
}
//验证作业
function vilidateTask(){
	var title = $("#taskTitle").val();
	var parent = $('#taskParentId option:selected').val();
	var parent_val = false;
	var title_val = false;
	if(title==""||title.length>18){
		$("#task_input").addClass("has-error");
		$("#task_input").find(".help-block").show();
	}else{
		$("#task_input").removeClass("has-error");
		$("#task_input").find(".help-block").hide();
		title_val = true;
	}

	if(parent==0){
		$("#task_parent_select").addClass("has-error");
		$("#task_parent_select").find(".help-block").show();
	}else{
		$("#task_parent_select").removeClass("has-error");
		$("#task_parent_select").find(".help-block").hide();
		parent_val =  true;
	}
	
	if(title_val==true&&parent_val==true){
		return true;
	}else{
		return false;
	}
}
//直播课时验证
function validateLiving(){
	 var title=$("#live-title-field").val();
	 var thisTime = $('[name=start_time]').val();
     thisTime = thisTime.replace(/-/g, "/");
     thisTime = Date.parse(thisTime) / 1000;
     var nowTime = Date.parse(new Date()) / 1000;
     var parent = $('#chapter_parent_id option:selected').val();
     var myreg=/^[1-9]\d*$/;
     var length=$("#live-length-field").val();
     if(title==""){
    	 $("#live-title-block").html('<span class="text-danger">请输入标题</span>');
    	 return false;
     }else{
    	 $("#live-title-block").html(''); 
     }
     
     if (nowTime <= thisTime) {
    	 $("#starttime-help-block").html("");
       
     } else {
    	$("#starttime-help-block").html('<span class="text-danger">请输入一个晚于现在的时间</span>');
    	return false;
     }
     if(!myreg.test(length)){
    	 $("#timelength-help-block").html('<span class="text-danger">直播时长必须为正整数</span>');
      		return false;
      	}else{
        $("#timelength-help-block").html("");
       }
     if(parent==0){
    	 $(".section_val").show();
    	 return false;
     }
     return true;
}
$(function(){
	//输入框
	 /* 暂时注释   直播课 编辑框初始化
	 var height = $('#live_lesson-content-field').height();
     CKEDITOR.replace("live_lesson-content-field", {
         skin : "moono-lisa",
         height : height,
         margin : "0,0,0,0",
         resize_enabled : false,
         toolbar :
                 'Question'
     });
     */
	//直播课时时间的获取
	  var now = new Date();
	  $("[name=start_time]").datetimepicker({
	            autoclose: true,
	            language:'zh-CN'
	         });
	  		$('[name=start_time]').datetimepicker('setStartDate', now);
	        $('[name=start_time]').datetimepicker().on('hide', function(ev){
	        	validateLiving();
	        });

	//直播课时保存
	    $("#live-course-create-btn").click(function() {
	 if(validateLiving()){
		 for ( instance in CKEDITOR.instances )

		 	CKEDITOR.instances[instance].updateElement();
		 var a=	 $("#live-lesson-form").serialize();
	
	$.ajax({
		url:'save_live_course.action',
		data: $("#live-lesson-form").serialize(),
		dataType:'json',
		success:function(json){
			 $("#modal1").modal("hide"); 
			 location.replace(location.href);
		}
	});
		
		
	 }
	    	
		});    
	$(".line:first").hide();
	
	$(".page_section_01,.page_section_03").mouseover(function(){
		$(".page_section_01").find("div").find("button").hide();
		$(".page_section_03").find("div").find("a").hide();
		$(".page_section_01,.page_section_03").find("div").eq(0).removeClass("border_left");
		$(this).find("div").find("button").show();
		$(this).find("div").find("button").show();
		$(this).find("div").find("a").show();
		$(this).find("div").eq(0).addClass("border_left");
	}).mouseout(function(){
		$(".page_section_01").find("div").find("button").hide();
		$(".page_section_03").find("div").find("a").hide();
//			$(".page_section_03").find("ul").hide();
		$(".page_section_01,.page_section_03").find("div").removeClass("border_left");

	});
	
	$(".add_page_read_more>a,.add_page_add>button").click(function(){
		if($(this).parent().siblings("ul").css("display")=="none"){
			$(".add_page_read_more>a").parent().siblings("ul").hide();
			$(".add_page_add>button").parent().siblings("ul").hide();
			$(this).parent().siblings("ul").show();
		}else{
			$(this).parent().siblings("ul").hide();
		}
	});

	$(".add_more_ul").mouseover(function(){
		$(this).show();
	}).mouseout(function(){
		$(this).hide();
	})
	
});
function openHour(str,course_id,chapter_id){
	$(".title_val").hide();
	if(str=="add_discuss"){
		initDiscuss(str);
		if(chapter_id!==null){
			var curr_chapter = $("#discussParentId option[value='"+chapter_id+"']");
			$(curr_chapter).attr("selected","true");
			doSeq(chapter_id,course_id);
		}
	}else if(str=="add_paper"){
		initPaper(str);
		if(chapter_id!==null){
			var curr_chapter = $("#examParentId option[value='"+chapter_id+"']");
			$(curr_chapter).attr("selected","true");
			doSeq(chapter_id,course_id);
		}
	}
	$("#"+str).modal();
}

function initDiscuss(id){
	var fid="#"+id;
	$(fid+" #discussTitle").val("");
	$(fid+" #discussRemarks").val("");
	$(fid+" #discussFre").val("");
	var curr_chapter = $(fid+" #discussParentId option");
	$(curr_chapter).removeAttr("selected");
	$(fid+" #discussSeq").val("");
}

function initPaper(id){
	var fid="#"+id;
	var curr_paper = $(fid+" #testPaperId option");
	$(curr_paper).removeAttr("selected");
	$(fid+" #examTitle").val("");
	var curr_chapter = $(fid+" #examParentId option");
	$(curr_chapter).removeAttr("selected");
	$(fid+" #examSeq").val("");
}

