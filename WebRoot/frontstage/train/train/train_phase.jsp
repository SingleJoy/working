<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<style>
    .stage_NO{font-size: 16px;margin-top: 20px;}
    .phase_info{margin-top: 10px;float: left;}
    .phase_info>p{font-size: 14px;float: left;}
    .phase_info>div{font-size: 14px;float: left;padding-right: 20px;}
    .phase_logo{background: url("${pageContext.request.contextPath}/frontstage/images/train_phase.png")  no-repeat;width: 65px;height: 33px;float: left;margin:15px;}
    .course-stage{clear: both;display: none;margin-bottom:20px;}
    .course-stage-abbreviation{clear: both;width: 100%;border: 1px solid #ddd;border-radius: 4px;margin-bottom: 20px;}
    .spread_out{margin-right: 30px;margin-top: 20px;}
</style>

<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<div class="cn-wrap">

    <div id="content-container" class="container">

        <jsp:include page="train_header.jsp"></jsp:include>

        <div class="row">

            <jsp:include page="train_left.jsp"></jsp:include>

            <div class="col-md-9">

                <div class="panel panel-default panel-col">
                    <div class="panel-heading clearfix">
                        培训课程内容设置
                        <c:if test="${trainView.status==0 }">
                            <button class="btn btn-success btn-sm pull-right" type="button" onclick="doAdd();" id="add-train-stage">
                                <i class="glyphicon glyphicon-plus"></i>新增阶段</button>
                        </c:if>
                    </div>
                    <div class="panel-body">
                        <c:forEach items="${trainPhaseList}" var="trainPhase" varStatus="phaseStatus">

                            <div class="course-stage-abbreviation" id="phaseShow${trainPhase.id}" style="min-height: 100px;">

                                <div class="form-group">
                                    <div class="phase_logo"></div>
                                    <div  class="stage_NO">
                                        第${phaseStatus.index+1}阶段:${trainPhase.name}
                                        <a class="pull-right spread_out" href="javascript:void(0)" onclick="doPhaseShow(${trainPhase.id});" >
                                            展开<span class="glyphicon glyphicon-chevron-right"></span></a>
                                    </div>
                                    <div class="phase_info">
                                        <div >学习周期：<span class="text-danger">${trainPhase.cycle}</span>&nbsp;天 </div>
                                        <div>学习要求：<span class="text-danger">${trainPhase.hour_require}</span>&nbsp;学时</div>
                                        <div>包含课程：<span class="text-danger">${trainPhase.totleNum}</span>&nbsp;门</div>
                                    </div>
                                </div>

                                <div class="course-stage" id="course-stage${trainPhase.id}" >
                                    <form id="trainPhaseForm${trainPhase.id}" class="form-horizontal stage-form" method="post" action="${pageContext.request.contextPath}/train_phase/save_train_phase.action" >
                                        <input type="hidden" name="sign" value="${trainView.sign}"/>
                                        <input type="hidden" name="flag" value="${trainView.flag}"/>
                                        <input type="hidden" name="train_id"  value="${trainView.id}"/>
                                        <input type="hidden" name="id"  value="${trainPhase.id}"/>
                                        <input type="hidden" name="requiredIds" id="requiredIds${trainPhase.id}"  value="${trainPhase.requiredIds}"/>
                                        <input type="hidden" name="optionIds"  id="optionIds${trainPhase.id}" value="${trainPhase.optionIds}"/>
                                        <br/>
                                        <div class="form-group" >
                                            <label class="col-md-2 control-label"><span class="text-danger">*</span>第${phaseStatus.index+1}阶段</label>
                                            <div class="col-md-8 controls">
                                                <input type="text"  name="name" id="name${trainPhase.id}" class="form-control" value="${trainPhase.name}" <c:if test="${trainView.status!=0 }">readonly="readonly"</c:if>>
                                                <div class="help-block" id="name_block${trainPhase.id}" style="display:none;">
                                                    <span class="text-danger">请输入阶段名称</span>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-md-2 control-label"><span class="text-danger">*</span>学习周期</label>
                                            <div class="col-md-8 controls">
                                                <input type="number" name="cycle" id="cycle${trainPhase.id}" class="form-control width-input width-input-large" value="${trainPhase.cycle}" <c:if test="${trainView.status!=0 }">readonly="readonly"</c:if>> 天
                                                <div class="help-block">设置该值后，学员只能在有效期内进行课程的相关操作，系统默认会在到期前10天提醒学员。该值为0，则不做此限制。</div>
                                            	<div class="help-block text-danger" style="display:none;" id="cycle_block${trainPhase.id}">学习周期必须大于等于0！</div>
                                            </div>
                                        </div>

                                        <div class="form-group">

                                            <label class="col-md-2 control-label"><span class="text-danger">*</span>阶段目标</label>
                                            <div class="col-md-8 controls">
                                                <textarea id="course_subtitle${trainPhase.id}" name="target" class="form-control" <c:if test="${trainView.status!=0 }">readonly="readonly"</c:if>>${trainPhase.target}</textarea>
                                                <div id="course_subtitle_block${trainPhase.id}" class="help-block text-danger" style="display:none;">不可为空</div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-md-2 control-label"><span class="text-danger">*</span>学习要求</label>
                                            <div class="col-md-4 controls">
                                                <input type="number" name="hour_require" class="form-control width-input width-input-large" value="${trainPhase.hour_require}" <c:if test="${trainView.status!=0 }">readonly="readonly"</c:if>> 课时
                                            </div>
                                            <div id="ck_hour_require${trainPhase.id}" style="display:none" class="text-danger">*学时要求必须大于0且学时要求不能小于必修课总学时且不能超出必修课与选修课的总学时</div>
                                        </div>


                                        <!--必修课程-->
                                        <div class="form-group">

                                            <div class="col-md-2 control-label">
                                                <label>必修课程</label>
                                            </div>
                                            <div class="col-md-10 controls ">
                                                <table class="table table-striped " style="font-size: 12px;">
                                                    <thead>
                                                    <tr>
                                                        <th style="width: 6%;"><input type="checkbox" onclick="selectAll(0,${trainPhase.id });" <c:if test="${trainView.status!=0 }">disabled="disabled"</c:if>></th>
                                                        <th style="width: 70%;">课程名称</th>
                                                        <th style="width: 10%;">学时</th>
                                                        <th style="width: 14%;">
                                                            <c:if test="${trainView.status==0 }">
                                                                <a href="javascript:void(0)" onclick="chooseCourse(0,0,${trainPhase.id});" class="btn btn-default btn-xs"  data-toggle="modal">
                                                                    <i class="glyphicon glyphicon-plus"></i>
                                                                </a>
                                                                <a href="javascript:void(0)" onclick="deleteCourse(0,${trainPhase.id});" class="btn btn-default  btn-xs" style="margin-left: 10px;">
                                                                    <i class="glyphicon glyphicon-remove"></i>
                                                                </a>
                                                            </c:if>
                                                        </th>
                                                    </tr>
                                                    </thead>
                                                    <tbody id="requiredTbody${trainPhase.id }">

                                                    <c:forEach items="${trainPhase.requiredCourse}" var="course">
                                                        <c:if test="${trainPhase.id==course.phaseId}">
                                                            <tr >
                                                                <td><input type="checkbox" name="requiredCheckbox${trainPhase.id }" value="${course.id}" <c:if test="${trainView.status!=0 }">disabled="disabled"</c:if>></td>
                                                                <td>${course.title}</td>
                                                                <td class="r_c_hour">	
                                                                	<c:choose>
                                                                		<c:when test="${!empty course.hours}">
                                                                			${course.hours}
                                                                		</c:when>
                                                                		<c:otherwise>
                                                                			0
                                                                		</c:otherwise>
                                                                	</c:choose>
																</td>
                                                                <td></td>
                                                            </tr>
                                                        </c:if>
                                                    </c:forEach>
                                                    </tbody>
                                                    <tr><td></td><th>总学时</th><th id="requiredTh${trainPhase.id }"><span id="tp_require_hour${trainPhase.id}">${trainPhase.requiredHours}</span></th><td></td></tr>
                                                </table>
                                            </div>
                                        </div>

                                        <!--选修课程-->
                                        <div class="form-group">

                                            <div class="col-md-2 control-label">
                                                <label>选修课程</label>
                                            </div>

                                            <div class="col-md-10 controls ">
                                                <table class="table table-striped " style="font-size: 12px;">
                                                    <thead>
                                                    <tr>
                                                        <th style="width: 6%;"><input type="checkbox" onclick="selectAll(1,${trainPhase.id });" <c:if test="${trainView.status!=0 }">disabled="disabled"</c:if>></th>
                                                        <th style="width:70%;">课程名称</th>
                                                        <th style="width: 10%;">学时</th>
                                                        <th style="width: 14%;">
                                                            <c:if test="${trainView.status==0 }">
                                                                <a href="javascript:void(0)" onclick="chooseCourse(0,1,${trainPhase.id});"  class="btn btn-default btn-xs"  data-toggle="modal">
                                                                    <i class="glyphicon glyphicon-plus"></i>
                                                                </a>
                                                                <a href="javascript:void(0)" onclick="deleteCourse(1,${trainPhase.id});" class="btn btn-default btn-xs" style="margin-left: 10px;">
                                                                    <i class="glyphicon glyphicon-remove"></i>
                                                                </a>
                                                            </c:if>
                                                        </th>
                                                    </tr>
                                                    </thead>
                                                    <tbody id="optionTbody${trainPhase.id }">
                                                    <c:forEach items="${trainPhase.optionCourse}" var="course">
                                                        <c:if test="${trainPhase.id==course.phaseId}">
                                                            <tr>
                                                                <td><input type="checkbox" name="optionCheckbox${trainPhase.id }" value="${course.id}" <c:if test="${trainView.status!=0 }">disabled="disabled"</c:if>></td>
                                                                <td>${course.title}</td>
                                                                <td class="r_c_hour">
                                                                	<c:choose>
                                                                		<c:when test="${!empty course.hours}">
                                                                			${course.hours}
                                                                		</c:when>
                                                                		<c:otherwise>
                                                                			0
                                                                		</c:otherwise>
                                                                	</c:choose>
                                                                </td>
                                                                <td></td>
                                                            </tr>
                                                        </c:if>
                                                    </c:forEach>
                                                    </tbody>
                                                    <tr><td></td><th>总学时</th><th id="optionTh${trainPhase.id }"><span id="tp_option_hour${trainPhase.id}">${trainPhase.optionHours}</span></th><td></td></tr>
                                                </table>
                                            </div>
                                        </div>

                                        <c:if test="${trainView.status==0 }">

                                            <div class="form-group">

                                                <div class="col-md-2 col-md-offset-2 controls">
                                                    <button type="button" onclick="doSave(${trainPhase.id});" class="btn btn-primary">保存</button>
                                                </div>

                                                <div class="col-md-2 controls">
                                                    <button class="btn btn-warning btn-sm delete-choice mlm" onclick="doDelete(${trainPhase.id});return false;" >
                                                        删除
                                                    </button>
                                                </div>
                                            </div>
                                        </c:if>
                                    </form>
                                </div>

                            </div>


                        </c:forEach>
                        <div class="course-stage" id="course-stage0" style="display:none;margin: 30px 0;clear: both;border: 1px solid #ddd;">

                            <form id="trainPhaseForm0" class="form-horizontal stage-form" method="post" action="${pageContext.request.contextPath}/train_phase/save_train_phase.action" >
                                <input type="hidden" name="sign" value="${trainView.sign}"/>
                                <input type="hidden" name="flag" value="${trainView.flag}"/>
                                <input type="hidden" name="train_id"  value="${trainView.id}"/>
                                <input type="hidden" name="requiredIds" id="requiredIds0" value=""/>
                                <input type="hidden" name="optionIds" id="optionIds0" value=""/>
                                <input type="hidden" name="seq" id="seq" value="${trainPhaseList.size()+1}"/>
                                <br/>
                                <div class="form-group">
                                    <label class="col-md-2 control-label"><span class="text-danger">*</span>第${trainPhaseList.size()+1}阶段</label>
                                    <div class="col-md-8 controls">
                                        <input type="text"  name="name" id="name0" class="form-control" value="" >
                                        <div class="help-block" id="name_block0"  style="display:none;">
                                            <span class="text-danger">请输入阶段名称</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-2 control-label"><span class="text-danger">*</span>学习周期</label>
                                    <div class="col-md-8 controls">
                                        <input type="number" id="cycle0" name="cycle"  class="form-control width-input width-input-large" value="0"> 天
                                        <div class="help-block">设置该值后，学员只能在有效期内进行课程的相关操作，系统默认会在到期前10天提醒学员。该值为0，则不做此限制。</div>
                                        <div class="help-block text-danger" style="display:none;" id="cycle_block0">学习周期天数必须大于等于0！</div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-2 control-label"><span class="text-danger">*</span>阶段目标</label>
                                    <div class="col-md-8 controls">
                                        <textarea id="course_subtitle0" name="target" class="form-control"></textarea>
                                        <div class="help-block text-danger" style="display:none;" id="course_subtitle_block0">不可为空</div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-2 control-label"><span class="text-danger">*</span>学习要求</label>
                                    <div class="col-md-4 controls">
                                        <input type="number" name="hour_require" class="form-control width-input width-input-large" value="0"> 课时
                                    </div>
                                    <div id="ck_hour_require0" style="display:none" class="text-danger">*学时要求必须大于0且学时要求不能小于必修课总学时且不能超出必修课与选修课的总学时</div>
                                </div>
                                <!--必修课程-->
                                <div class="form-group">

                                    <div class="col-md-2 control-label" >
                                        <label>必修课程</label>
                                    </div>
                                    <div class="col-md-10 controls">
                                        <table class="table table-striped " style="font-size: 12px;">
                                            <thead>
                                            <tr>
                                                <th style="width: 6%;"><input type="checkbox" onclick="selectAll(0,0);"></th>
                                                <th style="width: 70%;">课程名称</th>
                                                <th style="width: 10%;">学时</th>
                                                <th style="width: 14%;">
                                                    <a href="javascript:void(0)" onclick="chooseCourse(0,0,0);" class="btn btn-default btn-xs"  data-toggle="modal">
                                                        <i class="glyphicon glyphicon-plus"></i>
                                                    </a>
                                                    <a href="javascript:void(0)" onclick="deleteCourse(0,0);" class="btn btn-default btn-xs" style="margin-left: 10px;">
                                                        <i class="glyphicon glyphicon-remove"></i>
                                                    </a>
                                                </th>
                                            </tr>
                                            </thead>
                                            <tbody id="requiredTbody0">
                                            </tbody>
                                            <tr id="requiredTotal0" style="display:none;"><td></td><th>总学时</th><th id="requiredTh0"><span id="tp_require_hour0">0</span></th><td></td></tr>
                                        </table>
                                    </div>
                                </div>
                                <!--选修课程-->
                                <div class="form-group">

                                    <div class="col-md-2 control-label">
                                        <label>选修课程</label>
                                    </div>
                                    <div class="col-md-10 controls" >
                                        <table class="table table-striped " style="font-size: 12px;">
                                            <thead>
                                            <tr>
                                                <th style="width:6%;"><input type="checkbox" onclick="selectAll(1,0);"></th>
                                                <th  style="width:70%;">课程名称</th>
                                                <th  style="width:10%;">学时</th>
                                                <th  style="width:14%;">
                                                    <a href="javascript:void(0)" onclick="chooseCourse(0,1,0);" class="btn btn-default btn-xs"  data-toggle="modal">
                                                        <i class="glyphicon glyphicon-plus"></i>
                                                    </a>
                                                    <a href="javascript:void(0)" onclick="deleteCourse(1,0);" class="btn btn-default btn-xs" style="margin-left: 10px;">
                                                        <i class="glyphicon glyphicon-remove"></i>
                                                    </a>
                                                </th>
                                            </tr>
                                            </thead>
                                            <tbody id="optionTbody0">
                                            </tbody>
                                            <tr id="optionTotal0" style="display:none;"><td></td><th>总学时</th><th id="optionTh0"><span id="tp_option_hour0">0</span></th><td></td></tr>
                                        </table>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-8 col-md-offset-2 controls">
                                        <button type="button" onclick="doSave(0);" class="btn btn-primary">保存</button>
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

<!--添加课程-->
<div id="add-course" class="modal"  data-toggle="modal" style="display: none;">
    <input type="hidden" id="chooseType" vlaue="" />
    <input type="hidden" id="chooseTab" vlaue="" />
    <div class="modal-dialog  modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">选择课程</h4>
            </div>
            <div class="modal-body">
                <div class="alert alert-info" role="alert">
                    加入班级的课程为选中的原课程复制生成，并与原课程实时同步更新。如需解除同步，请对该课程进行编辑。
                </div>

                <form class="form-inline form-search" role="search-form">
                    <div class="form-group ">
                        <input type="text" class="form-control" name="courseTitle" id="courseTitle" value="" placeholder="课程名称" >
                    </div>
                    <button type="button" class="btn btn-primary" onclick="chooseCourse(1,0,0);">搜索</button>
                    <a class="btn btn-primary" href="javascript:void(0)" onclick="chooseAll();">全部课程</a>
                </form>

                <div class="row mtl">
                    <div class="col-md-12">
                        <div class="courses-list">
                            <input type="hidden" id="chooseId" value=""/>
                            <input type="hidden" name="page" id="page" value="0"/>
                            <ul class="course-wide-list" id="courseContent">

                            </ul>
                            <!--翻页-->
                            <nav class="text-center">
                                <div id="test" class="pager">
                                </div>
                            </nav>
                        </div>
                    </div>
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" onclick="addCourse();" class="btn btn-primary pull-right" >添加</button>
                <button type="button" class="btn btn-link pull-right" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
    function doAdd(){
        $(".course-stage").slideUp();
        $("#course-stage0").show();
    }


    //保存
    function doSave(value){
    	if(validate(value)){
            $("#trainPhaseForm"+value).submit();
        }else{
            return false;
        }
    }

    function validate(value){
    	$("#ck_hour_require"+value).hide();
    	$("#ck_hour_require"+value).hide();
    	$("#name_block"+value).hide();
    	$("#cycle_block"+value).hide();
    	$("#course_subtitle_block"+value).hide()
        var name = $("#name"+value).val();
        var tp_r_h = $("#tp_require_hour"+value)==null?0:parseInt($("#tp_require_hour"+value).text());
        var tp_o_h = $("#tp_option_hour"+value)==null?0:parseInt($("#tp_option_hour"+value).text());
        var tp_hour_requir = parseInt($("#trainPhaseForm"+value+" input[name='hour_require']").val());
        var cycle = parseInt($("#cycle"+value).val());
        var course_subtitle = $("#course_subtitle"+value).val();
        if(isNaN(cycle)||cycle<0){
        	$("#cycle_block"+value).show();
        	return false;
        }
        if(course_subtitle==""){
        	$("#course_subtitle_block"+value).show();
        	return false;
        }
        if(isNaN(tp_hour_requir)||tp_hour_requir<=0){
        	$("#ck_hour_require"+value).show();
        	return false;
        }
        if(tp_r_h>tp_hour_requir||(tp_r_h+tp_o_h)<tp_hour_requir){
        	$("#ck_hour_require"+value).show();
        	return false;
        }
        if(name==""){
            $("#name_block"+value).show();
            return false;
        }
        return true;
    }

    //阶段显示与隐藏
    function doPhaseShow(value){
        if($("#course-stage"+value).css("display")=="none"){
            $(".course-stage").slideUp();
            $("#course-stage"+value).slideDown();
            $(".course-stage-abbreviation").find("div").find("div").find(".spread_out").html("展开&nbsp;"+"<span class=\'glyphicon glyphicon-chevron-right\'>"+"</span>")
            $("#phaseShow"+value).find("div").find("div").find(".spread_out").html("收起&nbsp;"+"<span class=\'glyphicon glyphicon-chevron-left\'>"+"</span>")

        }else{
            $(".course-stage").slideUp();
            $("#course-stage"+value).slideUp();
            $(".course-stage-abbreviation").find("div").find("div").find(".spread_out").html("展开&nbsp;"+"<span class=\'glyphicon glyphicon-chevron-right\'>"+"</span>")

        }
    }

    //选择课程  value：0-添加；1-搜索；type：0-必修；1-选修；tab(哪个阶段)：0-新增；其他修改
    function chooseCourse(value,type,tab){
        $("#chooseId").val("");
        var page = $("#page").val();
        if(value==0){
            page=0;
            $("#chooseType").val(type);
            $("#chooseTab").val(tab);
            $("#add-course").modal();
        }else{
            type = $("#chooseType").val();
            tab = $("#chooseTab").val();
        }

        var courseIds =$("#requiredIds"+tab).val()+$("#optionIds"+tab).val();

        //搜索
        var  courseTitle = $("#courseTitle").val();
        if(courseTitle!=""){
            page = 0;
        }

        $.ajax({
            url:"${pageContext.request.contextPath}/course/query_all_course.action?ver="+Math.ceil(Math.random()*100),
            data:{
                ids : courseIds,
                title : courseTitle,
                status : 1,
                page : page
            },
            dataType:'json',
            success:function(d){
                if(d==0){//没有课程

                }else{
                    var courseView = d[0].courseView;
                    var courses = d[0].courseList;
                    if(courses.length==0){
                        $(".text-center").hide();
                    }else{
                        $(".text-center").show();
                    }
                    var html="";
                    for(var i=0;i<courses.length;i++){
                        html +='<li class="course-item clearfix" >'+
                        '<a class="course-picture-link" href="javascript:void(0)" target="_blank">'+
                        '<img class="course-picture" style="height:150px;" src="${pageContext.request.contextPath}'+courses[i].img+'">'+
                        '</a>'+
                        '<div class="course-body" onclick="doChoose('+courses[i].id+');">'+
                        '<div style="float:right;" class="text-muted mrm mls">'+
                        '<span class="course-price">';
                        if(courses[i].price==0){
                            html += '免费';
                        }else{
                            html += courses[i].price+'元';
                        }
                        html +='</span>'+

                        '<span class="divider"></span>'+
                        '<span class="text-muted mrm mls"><strong>'+courses[i].studentNum+'</strong>学员</span>'+

                        '</div>'+

                        '<h4 class="course-title">'+
                        '<a href="#" target="_blank">'+courses[i].title+'</a>'+
                        '</h4>'+

                        '<div class="course-about ellipsis"></div>'+

                        '<div class="course-footer clearfix">'+
                            /* 	' <div class="teacher">'+
                             '  <a href="/user/1" target="_blank"><img src="http://edusoho.com/files/user/2016/08-04/114116cd800d941381.gif?7.0.0" class="teacher-avatar"></a>'+
                             '<a class="teacher-nickname ellipsis" target="_blank" href="/user/1">一键试用用户</a>'+
                             '<span class="teacher-title ellipsis">aa</span>'+
                             ' </div>'+ */
                        '<div class="course-meta" id="courseMeta'+courses[i].id+'" style="display:none;">'+
                        '<span class="glyphicon glyphicon-ok pull-right" style="z-index:100;color:#02b980;font-size:30px;"></span>'+
                        '</div>'+

                        '</div>'+
                        '</div>'+
                        '</li>';
                    }
                    $("#courseContent").empty().append(html);
                    $("#page").val(courseView.page);
                    $("#courseTitle").val(courseView.title);
                    if(value==0){
                        doPages(courseView.rows,courseView.total);
                    }
                }
            }
        });

    }

    function doPages(rows,total){
        //翻页
        var page =  parseInt($("#page").val())+1;
        $("#btn5").on('click', function () {
            $("#div1").PageChanged(5);
        });

        $(".pager").pagination({
            thisPageIndex:page,
            recordCount: total,       //总记录数
            pageSize: rows,           //一页记录数
            onPageChange: function (page) {
                $("#page").val(page-1);
                chooseCourse(1,0,0);
            }
        });
    }

    //搜索全部
    function chooseAll(){
        $("#courseTitle").val("");
        chooseCourse(1,0,0);
    }
    //选中
    function doChoose(value){
        if($("#courseMeta"+value).css("display")=="none"){
            $("#courseMeta"+value).show();
        } else{
            $("#courseMeta"+value).hide();
        }
        var chooseId = $("#chooseId").val();
        if(chooseId.indexOf(value)==-1){//不包含
            $("#chooseId").val(value+","+chooseId);
        }else{//包含
            $("#chooseId").val(chooseId.replace(value+",","").trim());
        }
    }

    //添加选中课程
    function addCourse(){
        var chooseId = $("#chooseId").val();
        var type = $("#chooseType").val();
        var tab = $("#chooseTab").val();
        var courseIds = "";
        if(chooseId!=""){
            if(type==0){//必修
                $("#requiredTotal0").show();
                courseIds = chooseId + $("#requiredIds"+tab).val();
                $("#requiredIds"+tab).val(courseIds);
            }else{
                $("#optionTotal0").show();
                courseIds = chooseId + $("#optionIds"+tab).val();
                $("#optionIds"+tab).val(courseIds);
            }

            $.ajax({
                url:"${pageContext.request.contextPath}/course/get_by_course_ids.action?ver="+Math.ceil(Math.random()*100),
                data:{
                    ids : chooseId
                },
                dataType:'json',
                success:function(d){
                    if(d==0){//没有课程

                    }else{
                        var courses = d[0].courseList;
                        var html="";
                        var hours = 0;
                        for(var i=0;i<courses.length;i++){
                            if(courses[i].hours==null||courses[i].hours===""){
                            	courses[i].hours=0;
                            }
                            html +='<tr>'+
                            '<td><input type="checkbox" name="quetsionId" value="'+courses[i].id+'" ></td>'+
                            '<td>'+courses[i].title+'</td>'+
                            '<td class="r_c_hour">'+courses[i].hours+'</td>'+
                            '<td>'+'</td>'+
                            '</tr>';
                            hours += parseInt(courses[i].hours);
                        }
                        if(type==0){//必修
                            $("#requiredTbody"+tab).append(html);
                            var oldhours = document.getElementById('tp_require_hour'+tab).innerHTML;
                            $("#tp_require_hour"+tab).empty().append(parseInt(oldhours)+parseInt(hours));
                        }else{
                            $("#optionTbody"+tab).append(html);
                            var oldhours = document.getElementById('tp_option_hour'+tab).innerHTML;
                            $("#tp_option_hour"+tab).empty().append(parseInt(oldhours)+parseInt(hours));
                        }
                        $('#add-course').modal('hide');
                    }
                }
            });
        }else{
            alert("请选择课程！");
        }
    }

    //删除阶段课程
    function deleteCourse(type,value){
            var name = "";
            var course_id="";
            var hide_c_id="";
            if(type==0){//必修
            	course_id = "#requiredTbody"+value
                name = "requiredCheckbox"+value;
            	hide_c_id="#requiredIds"+value;
            	tp_h_total="#tp_require_hour"+value;
            }else{//选修
            	course_id = "#optionTbody"+value
                name = "optionCheckbox"+value;
            	hide_c_id="#optionIds"+value;
            	tp_h_total="#tp_option_hour"+value;
            }
            var courses = $(course_id+" input[name = '"+name+"' ]:checked");
            var tmp_courses = $(course_id+" input[name = 'quetsionId']:checked");//临时课程
            var ids = "";
            var tmp_ids="";
            for(var i = 0;i<courses.length;i++){
                ids +=$(courses[i]).val() +",";
            }
            if(ids!=''||tmp_courses.length>0){
                var result = confirm('您真的要删除选中课程吗？');
                if(result){
                    $.post("${pageContext.request.contextPath}/train_course/delete_phase_course.action",{
                    			source_id:"${trainView.id}",
                    			phaseId:value,
                    			courseIds:ids,
                    			sign:"${trainView.sign}",
                    			flag:"${trainView.flag}"
                    		},
                    		function(data,status){
                    			if(status==="success"){
                    				var del_hour1=0;
                    				var h_cids=$(hide_c_id).val();
                    				for(var n=0;n<courses.length;n++){
                    					h_cids=h_cids.replace($(courses[n]).val()+",","");
                    					var tmp_p = $(courses[n]).parent().parent();
                    					var tmp_p_h = $(tmp_p).find(".r_c_hour");
                    					if(tmp_p_h.length>0){
                    						del_hour1+=parseInt($(tmp_p_h[0]).text().trim());
                    					}
                    					$(tmp_p).remove();
                                    }
                    				if(del_hour1>0){
                                    	var h_total = parseInt($(tp_h_total).text());
                                    	$(tp_h_total).text(h_total-del_hour1);
                                    }
                    				$(hide_c_id).val(h_cids);
                    			}
                    		}
                   );                  
                	//window.location.href = "?source_id="+${trainView.id}+"&phaseId="+value+"&courseIds="+ids+"&sign="+${trainView.sign}+"&flag="+${trainView.flag};
                }
                if(result){
                	var del_hour2=0;
                	var h_cids=$(hide_c_id).val();
                	for(var j=0;j<tmp_courses.length;j++){
                		h_cids=h_cids.replace($(tmp_courses[j]).val()+",","");
                		var tmp_p = $(tmp_courses[j]).parent().parent();
    					var tmp_p_h = $(tmp_p).find(".r_c_hour");
    					if(tmp_p_h.length>0){
    						del_hour2+=parseInt($(tmp_p_h[0]).text().trim());
    					}
    					$(tmp_p).remove();
                    }
                	if(del_hour2>0){
                   		var h_total = parseInt($(tp_h_total).text());
                     	$(tp_h_total).text(h_total-del_hour2);
                    }
                	$(hide_c_id).val(h_cids);
                }
            }else{
            	alert("请选择要删除的课程");
            }
    }

    //选中全部
    function selectAll(type,value){
        var name = "";
        if(type==0){//必修
            name = "requiredCheckbox"+value;
        }else{//选修
            name = "optionCheckbox"+value;
        }
        var	a = document.getElementsByName(name);
        if(a[0].checked){
            for(var i = 0;i<a.length;i++){
                if(a[i].type == "checkbox") a[i].checked = false;
            }
        }else{
            for(var i = 0;i<a.length;i++){
                if(a[i].type == "checkbox") a[i].checked = true;
            }
        }
    }

    function doDelete(value){
        var result = confirm('您真的要删除该阶段吗？');
        if(result){
        	top.location.href = "${pageContext.request.contextPath}/train_phase/delete_train_phase.action?train_id="+${trainView.id}+"&id="+value+"&sign="+${trainView.sign}+"&flag="+${trainView.flag}+"&ver="+Math.ceil(Math.random()*100);
        	
        }
        return ;
    }
</script>

