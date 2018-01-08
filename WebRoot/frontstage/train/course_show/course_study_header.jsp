<%@ page language="java" import="java.util.*,cn.bnsr.edu_yun.frontstage.base.po.User" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/My97DatePicker/WdatePicker.js"></script>


<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/wangEditor/wangEditor.min.js"></script>
<link  href="${pageContext.request.contextPath}/frontstage/js/sharejs/dist/css/share.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/frontstage/js/sharejs/dist/js/jquery.share.min.js"></script>
<script>

    $(function () {
        $("[data-toggle='tooltip']").popover();
    });

</script>
<style>
	.class-list>button{margin:2px;}
	.class-list{margin-top: 10px;}
	.class_no_btn{background-color: #fff;border:2px solid #ddd;border-radius: 4px;padding: 5px 8px;}
	.course-select{margin-right: 5%;border: 1px solid #ddd;border-radius: 4px;cursor: pointer;}
	.course-select.active{background-color: #46c37b;color: #fff;}
	.class_message{margin-left: 10%;}
	.teacher_name{padding-top: 20px;}
	.progress_content{background-color: rgba(0, 0, 0, 0.53);padding: 0;width:95%;margin-top: -20px;position: relative;height: 20px;}
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
				<button class="btn btn-danger refund-btn" type="button" <c:if test="${!is_teacher||(userStudyView.viewType!=1&&userStudyView.viewType!=2) }">onclick="joinStudy(0)"</c:if> id="bt_join" <c:if test="${is_teacher&&(userStudyView.viewType==1||userStudyView.viewType==2) }">disabled="disabled"</c:if>>确定报名</button>
			</div>

		</div>
	</div>

</div>

<section class="class-header after ">
	<div class="container">

		<ol class="breadcrumb breadcrumb-o">
			<li><a href="${pageContext.request.contextPath }/user/home.action">首页</a></li>
			<c:choose>
				<c:when test="${classifyView.parent_id==-1}">
					<li><a href="${pageContext.request.contextPath }/course/to_course_center.action?type=0&classifyId=${classifyView.id}&classifyName=${classifyView.classify_name}&sonClassifyId=${classifyView.parent_id}&sonClassifyName=${classifyView.parent_classify_name}&sortType=1">${classifyView.classify_name} </a></li>
				</c:when>
				<c:otherwise>
					<li><a href="${pageContext.request.contextPath }/course/to_course_center.action?type=0&classifyId=${classifyView.parent_id}&classifyName=${classifyView.parent_classify_name}&sonClassifyId=${classifyView.id}&sonClassifyName=${classifyView.classify_name}&sortType=1">${classifyView.classify_name}</a></li>
				</c:otherwise>
			</c:choose>
		</ol>

		<div class="class-header-main">

			<div class="class-header-bg clearfix">

				<div class="class-img" >
					<a href="javascript:void(0);">
						<img <c:if test="${empty courseInfo.img}">src="${pageContext.request.contextPath}/frontstage/images/course_detail.png" </c:if>
							 <c:if test="${!empty courseInfo.img}">src="${pageContext.request.contextPath}${courseInfo.img }"</c:if> style="height: 300px;">
						<c:if test="${userStudyStatus==0 || userStudyStatus==3}">
							<div class="progress progress_content" >
								<div class="progress-bar" role="progressbar" <c:if test="${!empty allNum }">style="width: ${studyNum/allNum*100}%"  title="${studyNum/allNum*100 }%"</c:if>></div>
								<div style="color: #fff;z-index: 9999;position:relative;" class="text-center">
									完成课时：
									<c:if test="${!empty studyNum }">
										${studyNum }/${allNum }
									</c:if>
								</div>
							</div>
						</c:if>
					</a>

				</div>

				<div class="course-info" >
					<h2 class="title" title="${courseView.title }">${courseView.title}</h2>

					<div class="metas">

						<div >
							<c:if test="${average == -1}">
								<c:forEach begin="1" end="5">
									<i class="es-icon es-icon-star"></i>
								</c:forEach>
							</c:if>
							<c:if test="${average != -1 }">
								<c:forEach begin="1" end="${average }">
									<i class="es-icon es-icon-star color-warning"></i>
								</c:forEach>
							</c:if>
							<span>(${totalAppraise } 评论)</span>

							<span class="mlm mrm text-muted"></span>
							<span>累计报名人数&nbsp;&nbsp;<span class="test-danger" id="students">
							<c:choose>
								<c:when test="${empty student_total}">
									0
								</c:when>
								<c:otherwise>
									${student_total}
								</c:otherwise>
							</c:choose>
							人</span></span>

							<span class="mlm mrm text-muted"></span>
							<c:if test="${userStudyView.is_direct==0}">
								<c:if test="${!empty classList}">
									<span id="isUserCollect" style="display:none">
										<a href="javascript:void(0);" class="color-primary" <c:if test="${!is_teacher||(userStudyView.viewType!=1&&userStudyView.viewType!=2) }">onclick="doCollect();"</c:if>>
											<i class="es-icon es-icon-bookmark"></i>已收藏
										</a>
									</span>
	
									<span id="unUserCollect" style="display:none">
										<a href="javascript:void(0);" <c:if test="${!is_teacher||(userStudyView.viewType!=1&&userStudyView.viewType!=2) }">onclick="doCollect();"</c:if>>
											<i class="es-icon es-icon-bookmarkoutline"></i>收藏
										</a>
									</span>
	
									<span class="mlm mrm text-muted"></span>
									<c:if test="${!is_teacher||(userStudyView.viewType!=1&&userStudyView.viewType!=2) }">
										<div id="share-2" class="social-share " data-sites="weibo,qq,qzone,wechat" style="display: inline-block"></div>
									</c:if>
								</c:if>
							</c:if>
						</div>
						<c:if test="${userStudyView.is_direct == 0}">
							<div class="course-price-widget" style="margin-top: 10px;">
								   <span >价格</span>&nbsp;
								     <c:if test="${courseInfo.price==0 }">
								     	<span class="free">免费</span>
								     </c:if>
								     <c:if test="${courseInfo.price!=0 }">
									    <span  id="coursePrice" class="price">${courseInfo.price }元</span>
								    </c:if>
							</div>
						</c:if>
					</div>

					<c:if test="${userStudyView.is_direct == 0}">
						<div class="class-list" >
							<span >班次</span>
							<c:choose>
								<c:when test="${!empty classList}">
									<c:forEach items="${classList}" var="cla">
										<c:if test="${cla.type != 2}">
											<button type="button" onclick="doChangeClass(${cla.id});" data-trigger="hover" rel="tooltip" data-content="报名截止时间：<fmt:formatDate value='${cla.end_time}' pattern='yyyy-MM-dd'/>" data-container="body" data-toggle="popover" data-placement="top" class='class_no_btn btn <c:if test="${userStudyView.sourceId == cla.id}">disabled</c:if>'>
												<span class="<c:if test="${userStudyView.sourceId == cla.id}">text-info</c:if>">${cla.name }</span>
											</button>
										</c:if>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<span class="text-danger">暂未开班</span>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="class-list" >

							<span>开班时间</span>

							<div class="text-danger" style="display: inline-block;">
								<c:choose>
									<c:when test="${!empty classList}">
										<i id="open_time" title="ok"></i>
										<i id="close_time" title="ok"></i>
									</c:when>
									<c:otherwise>
										<span>时间未定</span>
									</c:otherwise>
								</c:choose>
							</div>

						</div>

						<div class="class-serve hidden-sm hidden-xs" style="margin-top: 20px;">
							<div class="serve-frame" rel="drevil" style="width: 60px;padding-left: 0;text-align: left;background-color: #fff;">承诺服务</div>

							<ul class="list-unstyled clearfix" style="margin-left: 15px;margin-top: -23px;">
								<li id="seatwork" ><a rel="drevil" data-trigger="hover"  data-toggle="tooltip" data-container="body"  data-placement="bottom"  data-content="24小时内完成作业批改，即时反馈并巩固您的学习效果">练</a></li>
								<li id="testpaper" ><a rel="drevil" data-trigger="hover"  data-toggle="tooltip" data-container="body"  data-placement="bottom" data-content="24小时内批阅您提交的试卷，给予有针对性的点评">试</a></li>
								<li id="question" ><a rel="drevil" data-trigger="hover"  data-toggle="tooltip" data-container="body"  data-placement="bottom" data-content="对于提问做到有问必答，帮您扫清学习过程中的种种障碍">问</a></li>
								<li id="activity"><a rel="drevil" data-trigger="hover"  data-toggle="tooltip" data-container="body"  data-placement="bottom" data-content="不定期组织各种线上或线下的班级活动，让学习更加生动有趣，同学关系更为紧密">动</a></li>
								<li id="doubt" ><a rel="drevil" data-trigger="hover" data-toggle="tooltip" data-container="body"  data-placement="bottom" data-content="提供专属的一对一在线答疑，快速答疑解惑">疑</a></li>
								<li id="job" ><a rel="drevil" data-trigger="hover"  data-toggle="tooltip" data-container="body"  data-placement="bottom" data-content="完成全部学习后，老师对您的学习成果和能力水平给出评估，并提供专业化的就业指导">业</a></li>
							</ul>

						</div>
					</c:if>

                     <div style="margin: 0 0 20px 0;">
						 <c:if test="${empty currentUser }">
							 <div class="buy pull-right" style="margin-right: 20px;">
								 <a class="btn btn-lg btn-primary" href="javascript:void(0);" onclick="check_login();">报名学习</a>
							 </div>
						 </c:if>
						 <c:if test="${!empty currentUser && !empty classList}">
							 <c:if test="${userStudyStatus == 0 }">


								 <c:if test="${studyNum==allNum}">
									 <a class="btn btn-lg btn-primary" href="javascript:void(0);">已完成</a>
								 </c:if>

								 <c:if test="${!empty nextCourseHour.id}">
									 <span class="next-class hidden-xs">下一课时：
										 <a 
										 <c:if test="${!is_teacher||(userStudyView.viewType!=1&&userStudyView.viewType!=2) }">
										 	<c:choose>
												<c:when test="${userStudyView.is_direct==0 }">
													href="${pageContext.request.contextPath}/course_study/to_study.action?id=${nextCourseHour.id }&source_id=${userStudyView.sourceId}&source_type=${userStudyView.sourceType}&learn_id=${userStudyView.learnId}&user_study_id=${userStudyView.id}&is_direct=0"
												</c:when>
												<c:when test="${userStudyView.is_direct==1 }">
													href="${pageContext.request.contextPath}/course_study/to_study.action?id=${nextCourseHour.id }&source_id=${userStudyView.sourceId}&source_type=${userStudyView.sourceType}&learn_id=${userStudyView.learnId}&user_study_id=${userStudyView.id}&trainType=${userStudyView.trainType}&is_direct=1"
												</c:when>
											</c:choose>
										 </c:if>
										 >${nextCourseHour.hour_title }</a>
									 </span>
									 <a class="btn btn-lg btn-primary pull-right" style="margin-right:20px;"
											 <c:if test="${!is_teacher||(userStudyView.viewType!=1&&userStudyView.viewType!=2) }">
												 <c:choose>
													 <c:when test="${userStudyView.is_direct==0 }">
														 href="${pageContext.request.contextPath}/course_study/to_study.action?id=${nextCourseHour.id }&source_id=${userStudyView.sourceId}&source_type=${userStudyView.sourceType}&learn_id=${userStudyView.learnId}&user_study_id=${userStudyView.id}&is_direct=0"
													 </c:when>
													 <c:when test="${userStudyView.is_direct==1 }">
														 href="${pageContext.request.contextPath}/course_study/to_study.action?id=${nextCourseHour.id }&source_id=${userStudyView.sourceId}&source_type=${userStudyView.sourceType}&learn_id=${userStudyView.learnId}&user_study_id=${userStudyView.id}&trainType=${userStudyView.trainType}&is_direct=1"
													 </c:when>
												 </c:choose>
											 </c:if>>
										 继续学习
									 </a>

								 </c:if>


							 </c:if>

							 <%--登录报班还没开始学习--%>
							 <c:if test="${userStudyStatus == 3}">

								 <a class="btn btn-lg btn-primary" href="javascript:void(0);" <c:if test="${userStudyView.viewType==0}"> onclick="joinStudy(1);"</c:if> >开始学习</a>

							 </c:if>

							 <%--登录后还没有报班--%>
							 <c:if test="${userStudyStatus == -1}">
								 <div class="pull-right" style="margin-right: 20px;">

									 <input type="hidden" id="selectCla" value="${userStudyView.sourceId}"/>
									 <a class="btn btn-lg btn-primary join_learning " href="javascript:void(0);" data-toggle="modal"<c:if test="${courseView.status!=1}">disabled="disabled" title="请先发布本课程"</c:if>>报名学习</a>
								 </div>

							 </c:if>

						 </c:if>
					 </div>

				</div>

				<c:if test="${!empty classList}">
					<input type="hidden" id="classId" >
					<input type="hidden" id="endTime" >
					<input type="hidden" id="openTime" >
					<input type="hidden" id="closeTime" >
					<input type="hidden" id="learnId" value="${courseView.id}">
					<input type="hidden" id="sourceType" value="0">
				</c:if>
			</div>
		</div>

	</div>


</section>
<script type="text/javascript" >
    $(function(){
        $(".join_learning").click(function(){
            $("#join_learning").modal();
            //当前班级是否过期
            if(compareTime($("#endTime").val(),1)){
                selectOtherClassOfCourse($("#sourceType").val(),$("#learnId").val(),0);
            }else{
                findClassesOfCourse($("#sourceType").val(),$("#learnId").val(),0);
            }
        })
    });

    //当前选中的班级过期，另选所属课程班级列表
    function selectOtherClassOfCourse(c_type,c_id,cla_type){
        //初始化班级列表
        $("#class_message_container").text("");
        var p_container=$("<p>").attr("text-align","center")
            .html("您当前选中的班级已过报名截止时间,<a href='javascript:void(0);' onclick='findClassesOfCourse("
                +c_type+","+c_id+","+cla_type+")'>点击此处可选择本课程的其他班级</a>");
        $("#class_message_container").append(p_container);
        $("#bt_join").attr("disabled","disabled");
    }

    //查询课程班级列表
    function findClassesOfCourse(c_type,c_id,cla_type){
        $.ajax({
            url:"${pageContext.request.contextPath}/class/query_course_classes.action",
            data:{
                source_id:c_id,
                source_type:c_type,
                type:cla_type,
                jumpId:"${userStudyView.jumpId}",
                jumpType:"${userStudyView.jumpType}"
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
                var div_class="course-select col-md-3"
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
    	var tag_href="${pageContext.request.contextPath}/user_study/to_course_study.action?page=1&learnId=${courseView.id}&sourceType=0&jumpId=${userStudyView.jumpId}&jumpType=${userStudyView.jumpType}&tab=1&sourceId="+classId+"&is_direct=0";
    	if("${is_teacher}"==="true"&&("${userStudyView.viewType }"==='1'||"${userStudyView.viewType }"==='2')){
    		tag_href+="&viewType=${userStudyView.viewType }";
		}
        window.location.href=tag_href;
    }


    /*  var classes = $('#class-list button :first').val();
     var abled =  $('#class-list button :disabled').val(); */
    var classId = "${userStudyView.sourceId}";
    var sourceType = "${userStudyView.sourceType}";

    window.onload = function() {
        checkLocation("onload");
    };

    function checkLocation(location){
        if(classId!=""&&sourceType!=""){
            showTimeAndStu(classId,sourceType);
        }
        /* if(abled!="undefined"&&classes!=""){
         showTimeAndStu(classes,0);
         } */
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
    }  ;

    function showTimeAndStu(classId,sourceType){
        $.ajax({
            url : '${pageContext.request.contextPath}/class/selectOne.action',
            dataType : 'json',
            data:{
                id : classId,
                source_type : sourceType,
                trainType : "${userStudyView.trainType}"
            },
            success:function(data){
                var classView = data.classView;
                if(classView.type!=2){//不是课程培训班
                    var open_time = classView.open_time;
                    var close_time = classView.close_time;
                    var end_time = classView.end_time;
                    var formatEnd = format(end_time.time, 'yyyy-MM-dd');
                    var formatOpen = format(open_time.time, 'yyyy-MM-dd');
                    var formatClose = format(close_time.time, 'yyyy-MM-dd');
                    $("#endTime").val(formatEnd);
                    $("#open_time").html(formatOpen+"至");
                    $("#openTime").val(formatOpen);
                    $("#close_time").html(formatClose);
                    $("#closeTime").val(formatClose);
                }
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
                var len = "";
                for(var i=0;i<students.length;i++){
                    len += '<li><a id="userCard_0'+students[i].userId+'" onmouseover="mouseOver(0,'+students[i].userId+');" onmouseout="mouseOut(0,'+students[i].userId+');" href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id='+students[i].userId+'"  data-user-id="'
                        +students[i].userId+'"><img class="avatar-sm" src="${pageContext.request.contextPath}'+students[i].icon+'"></a></li>';
                }
                if(len == ""){
                    len = "<div class='empty'>暂无学员</div>";
                }
                $('#studentList').html(len);
                $("#students").empty().html(students.length+"人");

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
                    html ="<div class='empty'>暂无学员动态</div>";
                }
                $('#userStudyRecords').html(html);

                var price = classView.discount/100*'${courseInfo.price}';
                if(price==0){
                    $("#coursePrice").html('<span style="font-size: 24px;color:#70d445 !important;">免费</span>');
                }else{
                    $("#coursePrice").html(toDecimal(price)+"元");
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

                /* 	 var classList = data.classList;
                 var classHtml = "";
                 for(var i=0;i<classList.length;i++){
                 var time = format(classList[i].end_time.time, 'yyyy-MM-dd');
                 if('${userStudyStatus}' != 0){//没购买
				 if(classList[i].id==classId){
				 classHtml +='<button type="button" rel="drevil" data-content="报名截止时间：'+time+'" data-container="body" data-toggle="popover" data-placement="bottom"  id="class_'+classList[i].id+'" value="'+classList[i].id+'" class="btn btn-primary disabled">'+classList[i].name+'</button>';
				 }else{
				 classHtml +='<button type="button" rel="drevil" data-content="报名截止时间：'+time+'"   data-container="body" data-toggle="popover" data-placement="bottom"  id="class_'+classList[i].id+'" value="'+classList[i].id+'" class="btn btn-primary"  onclick="showTimeAndStu('+classList[i].id+','+classList[i].source_type+')" >'+classList[i].name+'</button>';
				 }
				 }else{//购买
				 if(classList[i].id==classId){
				 classHtml +='<button type="button" rel="drevil" data-content="报名截止时间：'+time+'" data-container="body" data-toggle="popover" data-placement="bottom" id="class_'+classList[i].id+'" value="'+classList[i].id+'" class="btn btn-primary  disabled">'+classList[i].name+'</button>';
				 }
				 }
				 }
				 $("#class-list").html(classHtml); */

            }

        });
    }

    //	选班
    function selectSingleClass(currentDiv){
        $(".course-select").removeClass("active");
        $(currentDiv).addClass("active");
    }

</script>
