<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<link  href="${pageContext.request.contextPath}/frontstage/js/sharejs/dist/css/share.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/frontstage/js/sharejs/dist/js/jquery.share.min.js"></script>
<script>
    $(function () {
        $("[data-toggle='tooltip']").popover();
    });
</script>


<style>
	.class_no_btn{background-color: #fff;border:2px solid #ddd;border-radius: 4px;padding: 5px 8px;}
	.course-select{margin-right: 5%;border: 1px solid #ddd;border-radius: 4px;cursor: pointer;}
	.course-select.active{background-color: #46c37b;color: #fff;}
	.class_message{margin-left: 10%;}
	.teacher_name{padding-top: 20px;}
</style>

<%--报名选择班级--%>
<div class="modal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="join_learning" >
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button class="close" type="button" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title">请选择报名班级</h4>
			</div>
			<div class="modal-body">

				<form class="form-horizontal form-inline" id="assistant">

					<div class="row mtl">
						<div class="col-md-12">

							<div class="class_message" id="class_message_container">

							</div>
						</div>
					</div>


				</form>

			</div>


			<div class="modal-footer">
				<button class="btn btn-danger refund-btn" type="button" <c:if test="${!isTeacher||(trainDetailView.viewType!=1&&trainDetailView.viewType!=2) }">onclick="joinStudy(0)"</c:if> id="bt_join" >确定报名</button>
			</div>

		</div>
	</div>


</div>
<section class="class-header after ">

	<div class="container">

		<ol class="breadcrumb breadcrumb-o">
			<li><a href="${pageContext.request.contextPath }/user/home.action">首页</a></li>
			<li><a href="${pageContext.request.contextPath }/train/to_train_center.action?type=0&classify_id=-1">培训列表</a></li>
			<li><a href="${pageContext.request.contextPath }/train/to_train_detail.action?id=${trainView.id }&sign=0">${trainView.name}</a></li>
		</ol>

		<div class="class-header-main">

			<div class="class-header-bg clearfix">

				<div class="class-img" >
					<a href="javascript:void(0);">
						<img src="${pageContext.request.contextPath}${trainView.img}" alt="${trainView.name}" style="height:270px;">
					</a>
				</div>
				<div class="class-info" >

					<h2 class="title">${trainView.name }</h2>

					<div class="metas">
						<div class="">
							<c:forEach begin="1" end="${trainView.trainTotalScore}">
								<i class="es-icon es-icon-star color-warning"></i>
							</c:forEach>
							<span>${trainView.trainTotalAppraise}&nbsp;评价</span>
							<span class="mlm mrm text-muted"></span>
							<span>累计报名人数&nbsp;&nbsp;<span id="students" class="text-danger"></span></span>
							<span class="mlm mrm text-muted"></span>
							<c:if test="${!empty classList}">
								<span id="isUserCollect" style="display:none;">
									<a href="javascript:void(0);" class="text-success" <c:if test="${!isTeacher||(trainDetailView.viewType!=1&&trainDetailView.viewType!=2) }">onclick="doCollect();"</c:if>>
										<i class="es-icon es-icon-bookmark"></i>已收藏
									</a>
								</span>

								<span id="unUserCollect" style="display:none;">
									<a href="javascript:void(0);" <c:if test="${!isTeacher||(trainDetailView.viewType!=1&&trainDetailView.viewType!=2) }">onclick="doCollect();"</c:if> class="text-muted">
										<i class="es-icon es-icon-bookmarkoutline"></i>
										收藏
									</a>
								</span>
								<span class="mlm mrm text-muted"></span>
								<c:if test="${!isTeacher||(trainDetailView.viewType!=1&&trainDetailView.viewType!=2) }">
									<div id="share-2" class="social-share " data-sites="weibo,qq,qzone,wechat" style="display: inline-block;"></div>
								</c:if>
							</c:if>
						</div>

						<div class="class-list" style="margin: 6px 0;">
							<div class="course-price-widget">
								<span >价格:</span>
								<div class="price" id="trainPrice" style="display: inline-block;">
									<c:if test="${trainView.price==0 }">
										<span class="free">免费</span>
									</c:if>
									<c:if test="${trainView.price!=0 }">
										<span >${trainView.price }元</span>
									</c:if>
								</div>

							</div>

						</div>

						<div class="class-list" style="display: inline-block;margin-top: 5px;">
							<span >班次:</span>
							<c:choose>
								<c:when test="${!empty classList}">
									<c:forEach items="${classList}" var="cla">
										<button type="button" onclick="doChangeClass(${cla.id});" rel="drevil" data-trigger="hover" data-content="报名截止时间：<fmt:formatDate value='${cla.end_time}' pattern='yyyy-MM-dd'/>" data-container="body" data-toggle="tooltip" data-placement="top" class='class_no_btn btn btn-default <c:if test="${trainView.classId == cla.id}">disabled</c:if> '>
											<span <c:if test="${trainView.classId == cla.id}">class="text-info"</c:if>>${cla.name }</span>
										</button>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<span>暂无班级信息</span>
								</c:otherwise>
							</c:choose>
							<input type="hidden" id="classId" value="${trainView.classId}"/>
							<input type="hidden" id="learnId" value="${trainView.id}">
							<input type="hidden" id="endTime" >
							<input type="hidden" id="openTime" >
							<input type="hidden" id="closeTime" >
							<input type="hidden" id="sourceType" value="1">
						</div>

						<div class="class-list" style="margin-top: 5px;">
							<span >时间:</span>
							<c:choose>
								<c:when test="${!empty classList}">
									<span id="open_time" style="color:#e83d2c;"></span>
								</c:when>
								<c:otherwise>
									<span>时间未定</span>
								</c:otherwise>
							</c:choose>
						</div>

					</div>

					<div class="class-serve hidden-sm hidden-xs" >
						<div class="serve-frame" style="width: 60px;padding-left: 0;text-align: left;background-color: #fff;">承诺服务</div>

						<ul class="list-unstyled " style="


						margin-top: -23px;margin-left: 15px;">
							<li id="seatwork" >
								<a rel="drevil" data-toggle="tooltip" data-container="body" data-trigger="hover"  data-placement="top"  data-content="24小时内完成作业批改，即时反馈并巩固您的学习效果">练</a>
							</li>

							<li id="testpaper" ><a rel="drevil" data-toggle="tooltip" data-container="body" data-trigger="hover"  data-placement="top" data-content="24小时内批阅您提交的试卷，给予有针对性的点评">试</a></li>
							<li id="question" ><a rel="drevil" data-toggle="tooltip" data-container="body" data-trigger="hover"  data-placement="top" data-content="对于提问做到有问必答，帮您扫清学习过程中的种种障碍">问</a></li>
							<li id="activity"><a rel="drevil" data-toggle="tooltip" data-container="body" data-trigger="hover"  data-placement="top" data-content="不定期组织各种线上或线下的班级活动，让学习更加生动有趣，同学关系更为紧密">动</a></li>
							<li id="doubt" ><a rel="drevil" data-toggle="tooltip" data-container="body" data-trigger="hover"  data-placement="top" data-content="提供专属的一对一在线答疑，快速答疑解惑">疑</a></li>
							<li id="job" ><a rel="drevil" data-toggle="tooltip" data-container="body"  data-trigger="hover" data-placement="top" data-content="完成全部学习后，老师对您的学习成果和能力水平给出评估，并提供专业化的就业指导">业</a></li>
						</ul>
					</div>
					<c:if test="${!empty classList}">

						<div class="btn-buy pull-right" style="margin-right:20px;margin-bottom: 20px;">
							<c:if test="${empty currentUser }">
								<a class="btn btn-primary btn-lg" href="javascript:void(0);" onclick="check_login();">报名学习</a>
							</c:if>
							<c:if test="${!empty currentUser }">
								<c:if test="${userStudyStatus == 3}">
									<a class="btn btn-primary btn-lg" href="javascript:void(0);">开始学习</a>
								</c:if>
								<c:if test="${userStudyStatus == -1}">
									<input type="hidden" id="selectCla" value="${trainView.classId}"/>
									<a data-toggle="modal" class="btn btn-lg btn-primary join_learning" href="javascript:void(0);">报名学习</a>

								</c:if>

							</c:if>
						</div>
					</c:if>
				</div>

			</div>
		</div>

	</div>

</section>


<script type="text/javascript">
    $(function(){
        $(".join_learning").click(function(){
            $("#join_learning").modal();
            //当前班级是否过期
            if(compareTime($("#endTime").val(),1)){
                selectOtherClassOfCourse($("#sourceType").val(),$("#learnId").val(),'${trainView.type }');
            }else{
                findClassesOfCourse($("#sourceType").val(),$("#learnId").val(),'${trainView.type }');
            }
        })
    });

    //当前选中的班级过期，另选所属培训班级列表
    function selectOtherClassOfCourse(c_type,c_id,cla_type){
        //初始化班级列表
        $("#class_message_container").text("");
        var p_container=$("<p>").attr("text-align","center")
            .html("您当前选中的班级已过报名截止时间,<a href='javascript:void(0);' onclick='findClassesOfCourse("
                +c_type+","+c_id+","+cla_type+")'>点击此处可选择本培训的其他班级</a>");
        $("#class_message_container").append(p_container);
        $("#bt_join").attr("disabled","disabled");
    }

    //查询课程班级列表
    function findClassesOfCourse(c_type,c_id,cla_type){
        cla_type+="";
        if(cla_type==='0'){
            cla_type=1;
        }else if(cla_type==='1'){
            cla_type=2;
        }else{
            return;
        }
        $.ajax({
            url:"${pageContext.request.contextPath}/class/query_course_classes.action",
            data:{
                source_id:c_id,
                source_type:c_type,
                type:cla_type,
                jumpId:"${trainView.jumpId}",
                jumpType:"${trainView.jumpType}"
            },
            dataType:"json",
            success:function(data){
                loadClassMessage(data);
            }
        });
    }

    function loadClassMessage(data){
        //初始化班级列表
        $("#class_message_container").text("");
        if(data.length<=0){
            var p_container=$("<p>").attr("text-align","center").text("暂无开班信息");
            $("#class_message_container").append(p_container);
            $("#bt_join").attr("disabled","disabled");
        }else{
            var selectCla = $("#selectCla").val();
            for(var i=0;i<data.length;i++){
                //div container
                var div_container=$("<div>");
                var div_class="course-select col-md-3";
                if(selectCla===(data[i].id+"")){
                    div_class+=" active";
                }
                $(div_container).attr("class",div_class);
                $(div_container).attr("onclick","selectSingleClass(this)");
                //header
                var div_header_container=$("<div>");
                $(div_header_container).attr("style","margin-top: 20px;");
                //classid
                var classid_input = $("<input>").attr("type","hidden").attr("name","ckClass").attr("value",data[i].id);
                //classname
                var header_classname_container=$("<span>");
                $(header_classname_container).text(data[i].name);
                //price
                var header_price_container=$("<div>");
                $(header_price_container).attr("class","pull-right text-danger");
                var price = data[i].price;
                if(!data[i].price){
                    $(header_price_container).text("免费");
                }else{
                    $(header_price_container).text(price+"元");
                }
                //teachername
                var medium_teacher_container = $("<div>");
                $(medium_teacher_container).attr("class","text-center teacher_name");
                $(medium_teacher_container).text(data[i].teacherName);
                //foot
                var start_str = formatDateOfClass(data[i].open_time);
                var end_str = formatDateOfClass(data[i].close_time);
                var foot_container = $("<div>");
                $(foot_container).attr("style","margin:30px 0;");
                $(foot_container).html("开班日期:"+start_str+"<br/>"+"结束日期:"+end_str);
                //add
                div_header_container.append(header_classname_container);
                div_header_container.append(header_price_container);
                div_container.append(classid_input);
                div_container.append(div_header_container);
                div_container.append(medium_teacher_container);
                div_container.append(foot_container);
                $("#bt_join").removeAttr("disabled");
                $("#class_message_container").append(div_container);
            }
        }
    }
    function doChangeClass(classId){
    	var tag_href="${pageContext.request.contextPath}/train/to_train_detail.action?id=${trainView.id}&jumpId=${trainView.jumpId}&jumpType=${trainView.jumpType}&sign=${trainView.sign}&classId="+classId;
    	if("${isTeacher}"==="true"&&("${trainDetailView.viewType}"=='1'||"${trainDetailView.viewType}"=='2')){
    		tag_href+="&viewType=${trainDetailView.viewType}";
    	}
    	window.location.href=tag_href;
    }

    $(function () {
        $("[data-toggle='tooltip']").popover();
    })



    var classId = "${trainView.classId}";

    window.onload = function() {
        checkLocation("onload");
    };

    function checkLocation(location){
        if(classId!=""&&classId!=="0"){
            showTimeAndStu(classId);
        }
    }

    var format = function(time, format) {
        var t = new Date(time);
        var tf = function(i) {
            return (i < 10 ? '0': '') + i
        };
        return format.replace(/yyyy|MM|dd|HH|mm|ss/g,
            function(a) {
                switch (a) {
                    case 'yyyy':
                        return tf(t.getFullYear());
                        break;
                    case 'MM':
                        return tf(t.getMonth() + 1);
                        break;
                    case 'mm':
                        return tf(t.getMinutes());
                        break;
                    case 'dd':
                        return tf(t.getDate());
                        break;
                    case 'HH':
                        return tf(t.getHours());
                        break;
                    case 'ss':
                        return tf(t.getSeconds());
                        break;
                }
            });
    }

    function showTimeAndStu(classId){
        $.ajax({
            dataType : 'json',
            url : '${pageContext.request.contextPath}/class/selectOne.action',
            data:{
                id : classId,
                source_type : 1
            },
            success:function(data){
                var classView = data.classView;
                var open_time = classView.open_time;
                var close_time = classView.close_time;
                var end_time = classView.end_time;
                var formatEnd = format(end_time.time, 'yyyy-MM-dd');
                var formatOpen= format(open_time.time, 'yyyy-MM-dd');
                var formatClose= format(close_time.time, 'yyyy-MM-dd');
                $("#endTime").val(formatEnd);
                $("#open_time").html(formatOpen+"至"+formatClose);
                $("#openTime").val(formatOpen);
                $("#closeTime").val(formatClose);
                $('#classId').val(classView.id);
                if(classView.seatwork==1){
                    $('#seatwork').css("backgroundColor","#008080");
                }else{
                    $('#seatwork').css("backgroundColor","#e1e1e1");
                }
                if(classView.testpaper==1){
                    $('#testpaper').css("backgroundColor","#008080");
                }else{
                    $('#testpaper').css("backgroundColor","#e1e1e1");
                }
                if(classView.question==1){
                    $('#question').css("backgroundColor","#008080");
                }else{
                    $('#question').css("backgroundColor","#e1e1e1");
                }
                if(classView.activity==1){
                    $('#activity').css("backgroundColor","#008080");
                }else{
                    $('#activity').css("backgroundColor","#e1e1e1");
                }
                if(classView.doubt==1){
                    $('#doubt').css("backgroundColor","#008080");
                }else{
                    $('#doubt').css("backgroundColor","#e1e1e1");
                }
                if(classView.job==1){
                    $('#job').css("backgroundColor","#008080");
                }else{
                    $('#job').css("backgroundColor","#e1e1e1");
                }

                var students = data.studentList;
                var html = "";
                for(var i=0;i<students.length;i++){
                    html += '<li><a id="userCard_0'+students[i].userId+'" onmouseover="mouseOver(0,'+students[i].userId+');" onmouseout="mouseOut(0,'+students[i].userId+');"  href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id='+students[i].userId+'"  data-user-id="'+students[i].userId+'"><img class="avatar-sm" src="${pageContext.request.contextPath}'+students[i].icon+'"></a></li>';
                }
                if(html == ""){
                    html = "暂无学员";
                }
                $("#studentList").html(html);
                $("#students").empty().html(students.length);

                var userStudyRecords = data.userStudyRecords;
                var html = "";
                for(var i=0;i<userStudyRecords.length;i++){
                    html +='<div class="media media-number-o color-gray text-overflow">'+
                        '<a class="link-dark " href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id='+userStudyRecords[i].user_id+'">'+
                        userStudyRecords[i].username +
                        '</a>'+userStudyRecords[i].msg +
                        '<a class="link-dark" href="javascript:void(0);" >';
                    if(userStudyRecords[i].source_name.length >=10 ){
                        html += userStudyRecords[i].source_name.substring(0,10);
                    }else{
                        html += userStudyRecords[i].source_name;
                    }
                    html +='</a></div>';
                }
                if(html==""){
                    html ="暂无学员动态";
                }
                $('#userStudyRecords').html(html);

                var price = classView.discount/100*'${trainView.price}';
                if(price==0){
                    $("#trainPrice").html('<span style="font-size: 24px;color:#70d445 !important;">免费</span>');
                }else{
                    $("#trainPrice").html(toDecimal(price)+"元");
                }

                var user ='${currentUser}';
                if(user!=''){//用户登录
                    var userCollect = data.userCollect;
                    if(userCollect != undefined){//收藏
                        $("#isUserCollect").show();
                        $("#unUserCollect").hide();
                    }else{//未收藏
                        $("#unUserCollect").show();
                        $("#isUserCollect").hide();
                    }
                }else{//未登录
                    $("#unUserCollect").show();
                    $("#isUserCollect").hide();
                }
            }
        });
    }
    //	选班
    function selectSingleClass(currentDiv){
        $(".course-select").removeClass("active");
        $(currentDiv).addClass("active");
    }

</script>