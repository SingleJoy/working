<%@ page language="java"
		 import="java.util.*,cn.bnsr.edu_yun.frontstage.train.view.ClassView"
		 pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>
<c:if test="${classView.source_type==0 }">
	<script type="text/javascript"
			src="${pageContext.request.contextPath}/frontstage/js/course-info.js"></script>
</c:if>
<script type="text/javascript"
		src="${pageContext.request.contextPath}/frontstage/js/My97DatePicker/WdatePicker.js"></script>


<div class="cn-wrap">

	<div id="content-container" class="container">
		<jsp:include page="class_header.jsp"></jsp:include>
		<div class="row">
			<jsp:include page="class_left.jsp"></jsp:include>
			<div class="col-md-9">
				<div class="panel panel-default panel-col test-creator">
					<div class="panel-heading clearfix" >
						班级设置
					</div>
					<div class="panel-body">
						<div class="course_save_succ alert alert-success" <c:if test="${classView.flag!=1}">style="display:none;"</c:if>>班级设置成功!</div>
						<div class="panel-heading" >
							开班信息
						</div>
						<form id="sub" class="form-horizontal" method="post" action="${pageContext.request.contextPath}/class/save_or_update.action">
							<input name="source_id" value="${classView.source_id}" type="hidden" <c:if test="${classView.status ==1}">disabled="disabled"</c:if>>
							<input name="source_type" value="${classView.source_type}" type="hidden" <c:if test="${classView.status ==1}">disabled="disabled"</c:if>>
							<input name="id" value="${classView.id}" type="hidden" <c:if test="${classView.status ==1}">disabled="disabled"</c:if>>
							<input name="classBelongsId" value="${classView.classBelongsId}" type="hidden" <c:if test="${classView.status ==1}">disabled="disabled"</c:if>>
							
							<%--<div class="form-group">--%>
							<%--<div class="col-md-2 control-label">--%>
							<%--<label>班次</label>--%>
							<%--</div>--%>
							<%--<div class="col-md-6 controls">--%>
							<%--<input name="classes" type="text" class="form-control" value="${classView.classes }" onfocus="classes.blur()" <c:if test="${classView.status ==1}">disabled="disabled"</c:if>>--%>
							<%--</div>--%>
							<%--</div>--%>

							<div class="form-group">
								<div class="col-md-2 control-label">
									<label><span class="text-danger">* </span>班级名称</label>
								</div>
								<div class="col-md-6 controls">
									<input class="form-control" name="name" id="name" value="${classView.name}" <c:if test="${classView.status ==1 }">disabled="disabled"</c:if>/>
									<div  id="name_msg" class="help-block"></div>
								</div>
							</div>

							<div class="form-group">
								<div class="col-md-2 control-label">
									<label><span class="text-danger">* </span>开班时间</label>
								</div>
								<div class="col-md-6 controls">
									<input id="open_time" readonly="readonly" type="text" name="open_time"
										   <c:if test="${!empty classView.open_time }">value="<fmt:formatDate value="${classView.open_time}" type="date"/>"</c:if>
										   class="form-control" onClick="WdatePicker()"
										   onfocus="WdatePicker()"
										   <c:if test="${classView.status ==1}">disabled="disabled"</c:if>/>
									<div  id="open_time_msg" class="help-block"></div>
								</div>
							</div>

							<div class="form-group">
								<div class="col-md-2 control-label">
									<label><span class="text-danger">* </span>结束时间</label>
								</div>
								<div class="col-md-6 controls">
									<input id="close_time" readonly="readonly" type="text" name="close_time"
										   <c:if test="${!empty classView.close_time }">value="<fmt:formatDate value="${classView.close_time}" type="date"/>"</c:if>
										   class="form-control" onClick="WdatePicker()"
										   onfocus="WdatePicker()"
										   <c:if test="${classView.status ==1}">disabled="disabled"</c:if> >
									<div id="close_time_msg" class="help-block"></div>
								</div>
							</div>

							<div class="form-group">
								<div class="col-md-2 control-label">
									<label>助教</label>
								</div>
								<div class="col-md-8 controls" id="tutor_list">
								    <ul id="tutors" class="nav nav-pills clearfix tutor_list">
								    <c:forEach items="${assiantList }" var="assiant">
								       <li class="active" id="teacher${assiant.id }">
											<a href="javascript:return false;">${assiant.true_name }&nbsp;&nbsp;
												<c:if test="${classView.status !=1}">
													<input name="user_id" value="${assiant.user_id }" type="hidden" data-name="save">
													<span class="tutor_del" onclick="delAssiant(${assiant.id });">X</span>
												</c:if>
											</a>
										</li>
								    </c:forEach>
								    </ul>
									<%-- <c:forEach items="${assiantList }" var="assiant" varStatus="p">
										<c:if test="${p.count%3 eq 1}">
											<c:if test="${p.count != 1 }"></br></c:if>
											<ul class="nav nav-pills clearfix tutor_list">
										</c:if>
										<li class="active" id="teacher${assiant.id }">
											<a href="javascript:return false;">${assiant.true_name }&nbsp;&nbsp;
												<c:if test="${classView.status !=1}">
													<input name="user_id" value="${assiant.user_id }" type="hidden" data-name="save">
													<span class="tutor_del" onclick="delAssiant(${assiant.id });">X</span>
												</c:if>
											</a>
										</li>
										<c:if test="${p.count%3 eq 0}">
											</ul>
										</c:if>
									</c:forEach> --%>
								</div>
								<span>
									<c:if test="${classView.status !=1}">
										<a href="javascript:void(0);"  class="tutor_add btn btn-info" data-toggle="model" onclick="showTeacher(0)">
											<span class="glyphicon glyphicon-plus"></span>添加
										</a>
									</c:if>
								</span>

							</div>

							<div class="form-group">
								<div class="col-md-2 control-label">
									<label><span class="text-danger">* </span>学分</label>
								</div>
								<div class="col-md-6 controls">
									<input class="form-control width-input width-input-large" id="inpt_credit" name="credit" value="${classView.credit }" type="number" min="0" step="1" <c:if test="${classView.status ==1}">disabled="disabled"</c:if>> 分
									<div class="credit_val text-warning" style=" display: none;">请输入大于等于0的数字</div>
								</div>
							</div>

							<div id="no_edit" class="form-group">
								<%-- <input name="sign_up" hidden="true">

								<div class="col-md-2 control-label">
									<label>报名方式</label>
								</div>

								<div class="col-md-4 controls radios">
									<label><input type="radio" name="sign" id="self_sign"
												<c:if test="${classView.sign_up==0 }">checked="checked"</c:if>
												<c:if test="${empty classView.sign_up}">checked="checked" onclick="chooseRadio(0);"</c:if>
												value="0">自主报名</label>
									<label><input type="radio" name="sign" id="password_learning"
													  <c:if test="${empty classView.sign_up}">onclick="chooseRadio(1);"</c:if> value="1"
													  <c:if test="${classView.sign_up==1}">checked="checked"</c:if>>
											密码学习</label>
								</div>
								<div class="help-block"> 报名方式保存后将无法更改</div> --%>

								<div id="up" style="margin-left: 8px;margin-top: 20px;">

									<div class="form-group" >
										<div class="col-md-2 control-label">
											<label>学员上限</label>
										</div>
										<div class="col-md-8 controls">
											<input class="form-control width-input" name="maximum"	value="${classView.maximum}" type="number" min="1" step="1">&nbsp;&nbsp;人&nbsp;&nbsp;
											<div class="help-block" style="display: inline-block;" > 不设置学员上限则默认为无人数限制</div>

										</div>
									</div>

									<div class="form-group" >
										<div class="col-md-2 control-label">
											<label>截止日期</label>
										</div>
										<div class="col-md-8 controls">
											<input class="form-control width-input " name="end_time" type="text"
												   <c:if test="${!empty classView.end_time }">value="<fmt:formatDate value="${classView.end_time}" type="date"/>"</c:if> onClick="WdatePicker()" onfocus="WdatePicker()">
											<div style="display: inline-block;" class="help-block">不设置报名截止日期则默认为开班结束时间内均可报名</div>
											<div id="end_time0_msg" class="help-block" style="display: none;"> 截止日期要小于等于开班日期</div>
										</div>
									</div>

									<%-- <div class="form-group">
										<div class="col-md-2 control-label">
												<label><span class="text-danger">* </span>退款条件</label>
										</div>
										<div id="is_refund" class="col-md-8 controls radios">
											<label><input type="radio" name="is_refund" value="0"
													<c:if test="${empty classView.is_refund&&empty classView.sign_up }">checked="checked"</c:if>
													<c:if test="${classView.sign_up==0&&classView.is_refund==0}">checked="checked"</c:if>>
													课程开始前全额退 </label><br />
											<label><input type="radio" name="is_refund" value="1"
													<c:if test="${classView.sign_up==0&&classView.is_refund==1}">checked="checked"</c:if>>
													课程开始后按课时比例扣除 </label><br />
											<label><input type="radio" name="is_refund" value="2"
													<c:if test="${classView.sign_up==0&&classView.is_refund==2}">checked="checked"</c:if>>
													不允许退款 </label>
										</div>
									</div>
 --%>
								</div>



								<div id="down" style="display: none;margin-left: 8px;">

									<div class="form-group" >
										<div class="col-md-2 control-label">
											<span class="text-danger">* </span><label>密码数量：</label>
										</div>
										<div class="col-md-8 controls radios">
											<input id="maximum" class="form-control width-input " name="maximum" type="number" min="1" step="1" <c:if test="${classView.sign_up==1&&!empty classView.maximum}">value="${classView.maximum}" onfocus="maximum.blur()" readonly="readonly"</c:if>>&nbsp;&nbsp;个&nbsp;&nbsp;
											<div style="display: none" class="help-block" id="maximum_msg"></div>
										</div>
									</div>

									<div class="form-group">
										<div class="col-md-2 control-label">
											<label>密码有效期：</label>
										</div>
										<div class="col-md-8 controls">
											<input class="form-control width-input" name="end_time" <c:if test="${classView.sign_up==1&&!empty classView.end_time }">value="<fmt:formatDate value="${classView.end_time}" type="date"/>"</c:if>
												   type="text" onClick="WdatePicker()" onfocus="WdatePicker()">&nbsp;&nbsp;
											<div style="display: inline-block;" class="help-block">不设置密码有效期则默认为开班结束时间内密码均有效</div>
											<div id="end_time1_msg" style="display:none;" class="help-block"> 截止日期要小于等于开班日期</div>
										</div>
									</div>

								</div>
							</div>


								<%-- <div class="form-group">
								<div class="col-md-2 control-label">
									<span class="text-danger">* </span><label>开班范围</label>
								</div>
								<div id="classify" class="col-md-8 controls class_range radios">
									<c:forEach items="${classifys }" var="classify">
										<label><input type="radio" name="classify_id" value="${classify.id }" <c:if test="${classView.classify_id eq classify.id}">checked="checked"</c:if>>
											${classify.classify_name }</label>
                                       </c:forEach>
								</div>
							</div> --%>



							<div class="form-group" style="margin-top: -40px;">
								<div class="col-md-2 control-label">
									<label><span class="text-danger">* </span>发布范围</label>
								</div>

								<div class="col-md-10 controls radios" >
									<label><input type="radio"  name="communityType" value="-1" onchange="queryCommunitys()" <c:if test="${classView.communityType!=0&&classView.communityType!=1 }" >checked="checked"</c:if> <c:if test="${classView.status ==1 }">disabled="disabled"</c:if>>公开 </label>
									<label><input type="radio"  name="communityType" class="community" value="0" onchange="queryCommunitys()" <c:if test="${classView.communityType==0 }">checked="checked"</c:if> <c:if test="${classView.status ==1 }">disabled="disabled"</c:if>>社区 </label>
									<label><input type="radio"  name="communityType" class="workshop" value="1" onchange="queryCommunitys()" <c:if test="${classView.communityType==1 }">checked="checked"</c:if> <c:if test="${classView.status ==1 }">disabled="disabled"</c:if>>工作坊 </label>
								</div>
								<div class="community_type_val_msg text-warning" style="display:none">请选择发布范围</div>
							</div>

							<div class="community_content" <c:if test="${empty classView.communityType||classView.communityType!=0 }">style="display: none;"</c:if> <c:if test="${classView.status ==1 }">disabled="disabled"</c:if>>

								<div class="form-group">
									<div class="col-md-2 control-label"> <label>社区</label></div>
									<div class="col-md-10 controls">
										<select  class="form-control width-input width-input-large " name="communityId" onchange="queryClassifys()" <c:if test="${classView.status ==1 }">disabled="disabled"</c:if>>
											<option value="">--请选择社区--</option>
											<c:if test="${classView.communityType==0&&!empty communitys }">
												<c:forEach var="c" items="${communitys }">
													<option value="${c.id }" <c:if test="${c.id==classView.communityId }">selected="selected"</c:if>>${c.name }</option>
												</c:forEach>
											</c:if>
										</select>
										<div class="community_val_msg text-warning" style="display:none">请选择社区</div>
									</div>

								</div>


								<div class="form-group">
									<div class="col-md-2 control-label"> <label>请选择分类</label></div>
									<div class="col-md-10 controls">
										<select  class="form-control width-input width-input-large " name="classifyId" <c:if test="${classView.status ==1 }">disabled="disabled"</c:if>>
											<c:if test="${classView.communityType==0&&!empty classifyRealtionViews }">
												<c:forEach var="cr" items="${classifyRealtionViews }">
													<option value="${cr.id }" <c:if test="${classView.classifyId==cr.id }">selected="selected"</c:if>>${cr.name }</option>
													<c:if test="${!empty cr.sonClassifys }">
														<c:forEach items="${cr.sonClassifys }" var="scr">
															<option value="${scr.id }" <c:if test="${classView.classifyId==scr.id }">selected="selected"</c:if>>——${scr.name }</option>
														</c:forEach>
													</c:if>
												</c:forEach>
											</c:if>
										</select>
										<div class="classify_val_msg text-warning" style="display:none">请选择分类</div>
									</div>

								</div>
							</div>

							<div class="workshop_content" <c:if test="${empty classView.communityType||classView.communityType!=1 }">style="display: none;"</c:if> <c:if test="${classView.status ==1 }">disabled="disabled"</c:if>>

								<div class="form-group">
									<div class="col-md-2 control-label"> <label>工作坊</label></div>
									<div class="col-md-10 controls">
										<select  class="form-control width-input width-input-large " name="communityId"  onchange="queryClassifys()" <c:if test="${classView.status ==1 }">disabled="disabled"</c:if>>
											<option value="">--请选择工作坊--</option>
											<c:if test="${classView.communityType==1&&!empty workshops }">
												<c:forEach var="ws" items="${workshops }">
													<option value="${ws.id }" <c:if test="${classView.communityId==ws.id }">selected="selected"</c:if>>${ws.name }</option>
												</c:forEach>
											</c:if>
										</select>
										<div class="community_val_msg text-warning" style="display:none">请选择工作坊</div>
									</div>

								</div>


								<div class="form-group">
									<div class="col-md-2 control-label"> <label>请选择分类</label></div>
									<div class="col-md-10 controls">
										<select  class="form-control width-input width-input-large " name="classifyId" <c:if test="${classView.status ==1 }">disabled="disabled"</c:if>>
											<c:if test="${classView.communityType==1&&!empty classifyRealtionViews }">
												<c:forEach var="cr" items="${classifyRealtionViews }">
													<option value="${cr.id }" <c:if test="${classView.classifyId==cr.id }">selected="selected"</c:if>>${cr.name }</option>
													<c:if test="${!empty cr.sonClassifys }">
														<c:forEach items="${cr.sonClassifys }" var="scr">
															<option value="${scr.id }" <c:if test="${classView.classifyId==scr.id }">selected="selected"</c:if>>——${scr.name }</option>
														</c:forEach>
													</c:if>
												</c:forEach>
											</c:if>
										</select>
									</div>
									<div class="classify_val_msg text-warning" style="display:none">请选择分类</div>
								</div>

							</div>

							<div class="form-group" s>
								<div class="col-md-2 control-label">
									<label>课程价格折扣：</label>
								</div>

								<div class="col-md-8 controls">
									<input class="form-control width-input " id="discount" name="discount" value="${classView.discount}" type="text" min="0" max="100" step="1" <c:if test="${classView.status ==1}">disabled="disabled"</c:if>>%
									<div class="help-block " style="display: inline-block;">不设置价格折扣则默认为全额</div>
									<div class="price_val text-warning" style=" display: none;">请输入0到100以内的数字</div>
								</div>
							</div>

							<div class="form-group">
								<div class="col-md-offset-2 controls" >
									<c:if test="${classView.status !=1}">
										<button type="button" class="btn btn-primary btn-fat" onclick="check();">编辑 </button>
									</c:if>
								</div>
							</div>
						</form>
					</div>
				</div>

			</div>
		</div>

	</div>
	<jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
</div>
<!-- 弹窗 -->
<div id="add-assistant" class="modal"  data-toggle="modal" style="display: none;" >
	<div class="modal-dialog  modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title">课程班级添加助教</h4>
			</div>
			<div class="modal-body">
				<form class="form-inline well well-sm" id="assistant">
					<input type="hidden" id="pageFlag" value="0"/>
					<input type="hidden" name="page" id="page" value="0"/>
					<div class="form-group">
						<input type="text" id="true_name" name="true_name" class="form-control" placeholder="姓名关键词">
					</div>

					<div class="form-group">
						<select id="titles" class="form-control" name="showTitles" style="width: 200px; height: 32px;">
							<option value="">--按职称查询--</option>
						</select>
					</div>
					<input class="btn btn-primary btn-sm" onclick="showTeacher(1)" type="button" value="搜索">
					<!-- <button class="btn btn-primary btn-sm" id="searchTeacher">搜索</button> -->
				</form>
				<table class="table table-condensed">
					<thead>
					<tr>
						<th></th>
						<th width="25%">姓名</th>
						<th>用户名</th>
						<th>学校</th>
						<th>任教课程</th>
						<th>职称</th>
					</tr>
					</thead>
					<tbody id="showAssistant"></tbody>
				</table>
				<nav class="text-center">
					<div id="test" class="pager"></div>
				</nav>
				<div class="modal-footer">
					<button type="button" class="btn btn-info pull-right tutor_confirm" data-dismiss="modal">确定</button>
				</div>

			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
    $("#pageFlag").val(0);
    var classId = "${classView.id}";
    window.onload = function() {
        if(classId==""){
            checkLocation("onload");
        }else{
            var inputs = document.getElementById("no_edit").getElementsByTagName("input");
            for(var i=0;i<inputs.length;i++){
                inputs[i].disabled = true;
            }
        }
    };
    function checkLocation(location){
        $("#down :input").each(function(){
            $(this).val("");
            $(this).attr("disabled",true);
        });
        $('#classify input :first').attr('checked',true);
    }
    function chooseRadio(value){
        if(value==0){
            $("#up").slideDown();
            $("#down").slideUp();
            $("#down :input").each(function(){
                $(this).val("");
                $(this).attr("disabled",true);
            });
            $("#up :input").each(function(){
                $(this).removeAttr("disabled");
            });
            $("#is_refund input:first").attr("checked",true);
        }else{
            $("#up").slideUp();
            $("#down").slideDown();
            $("#up :input").each(function(){
                $(this).val("").attr("checked",false).attr("disabled",true);
            });
            $("#down :input").each(function(){
                $(this).removeAttr("disabled");
            });
        }
        var close_time = $("#close_time").val();
        if(close_time!=""){
            $('input[name="end_time"]').each(function(){
                if($(this).val()==""){
                    $(this).val(close_time);
                }
            })
        }
    }

    function validate(){
        var discount = $("#discount").val();
        if(!isNaN(discount)&&discount>=0&&discount!=''&&discount<=100){

            $(".price_val").hide();
            return true;
        }else{
            $(".price_val").show();
            /* $("#discount").val("0"); */
            return false;
        }
    }
    function getTime(date){
        var checkTime = "";
        if(date!=""){
            var dateArr = date.split("-");
            var checkDate = new Date();
            checkDate.setFullYear(dateArr[0], dateArr[1]-1, dateArr[2]);
            checkTime = checkDate.getTime();
        }
        return checkTime;
    }
    $(function(){
        $("#discount").blur(function(){
            validate();
        });
        $("[name = communityType]").blur(function(){
            var community_type=$("[name = 'communityType']:checked").attr("value");
            if(community_type!=null){
                $(".community_type_val_msg").css("display","none");
            }
        });
        $("[name = communityId]").blur(function(){
            var community_id;
            var community_type = $("[name = 'communityType']:checked").attr("value");
            if(community_type==="0"){
                community_id=$(".community_content [name = 'communityId'] option:selected").attr("value");
            }else if(community_type==="1"){
                community_id=$(".workshop_content [name = 'communityId'] option:selected").attr("value");
            }else{
                return ;
            }
            if(community_id!=null&&community_id!==""){
                $(".community_val_msg").css("display","none");
            }
        });
        $("[name = classifyId]").blur(function(){
            var classify_id;
            var community_type = $("[name = 'communityType']:checked").attr("value");
            if(community_type==="0"){
                classify_id=$(".community_content [name = 'classifyId'] option:selected").attr("value");
            }else if(community_type==="1"){
                classify_id=$(".workshop_content [name = 'classifyId'] option:selected").attr("value");
            }else{
                return ;
            }
            if(classify_id!=null){
                $(".classify_val_msg").css("display","none");
            }
        });
        //当前时间
        var nowDate = new Date();
        var nowTime = nowDate.getTime();
        $('#open_time').blur(function(){
            var open_time = $("#open_time").val();
            var close_time = $("#close_time").val();
            var checkTime1 = getTime(open_time);
            var checkTime2 = getTime(close_time);
            if(checkTime1!=""){
                if(checkTime1 - nowTime<=0){
                    $('#open_time_msg').html("开班时间要晚于当前时间");
                    $("#open_time").val("");
                    return;
                }else{
                    $('#open_time_msg').html("");
                }
                if(checkTime2!=""){
                    if(checkTime2 - checkTime1<=0){
                        $('#open_time_msg').html("开班时间要早于结束时间");
                        $("#open_time").val("");
                        return;
                    }else{
                        $('#open_time_msg').html("");
                    }
                }
            }
        })
        $('#close_time').blur(function(){
            var open_time = $("#open_time").val();
            var close_time = $("#close_time").val();
            var sign = $('input[name="sign"]:checked').val();
            var end_time = "";
            $('input[name="end_time"]').each(function(){
                if($(this).val()!=""){
                    end_time = $(this).val();
                }
            })
            var checkTime1 = getTime(open_time);
            var checkTime2 = getTime(close_time);
            var checkTime3 = getTime(end_time);
            if(checkTime2!=""){
                if(checkTime2 - nowTime<=0){
                    $('#close_time_msg').html("结束时间要晚于当前时间");
                    $("#close_time").val("");
                    return;
                }else{
                    $('#close_time_msg').html("");
                }
                if(checkTime1!=""){
                    if(checkTime2 - checkTime1<=0){
                        $('#close_time_msg').html("结束时间要晚于开班时间");
                        $("#close_time").val("");
                        return;
                    }else{
                        $('#close_time_msg').html("");
                    }
                }
                if(checkTime3!=""){
                    if(checkTime2 - checkTime3<0){
                        if(sign==0){
                            $('#close_time_msg').html("结束时间要晚于报名截止时间");
                        }else if(sign==1){
                            $('#close_time_msg').html("结束时间要晚于密码有效期");
                        }
                        $("#close_time").val("");
                        return;
                    }else{
                        $('#close_time_msg').html("");
                    }
                }
            }
        })

    });

    function check(){
    	var name = $('#name').val();
        if(name==""){
            $('#name_msg').html("班级名称不能为空");
            return false;
        }else{
            $('#name_msg').html("");
        }
        if(name.length>30){
			$('#name_msg').html("班级名称最多可输入30个字符");
			return false;
		}else{
			$('#name_msg').html("");
		}
        var community_type=$("[name = 'communityType']:checked").attr("value");
        if(community_type==null){
            $(".community_type_val_msg").css("display","");
            return;
        }

        if(community_type==="0"||community_type==="1"){
            var community_id;
            var classify_id;
            if(community_type==="0"){
                community_id = $(".community_content [name = 'communityId'] option:selected").attr("value");
                classify_id = $(".community_content [name = 'classifyId'] option:selected").attr("value");
            }else{
                community_id = $(".workshop_content [name = 'communityId'] option:selected").attr("value");
                classify_id = $(".workshop_content [name = 'classifyId'] option:selected").attr("value");
            }
            if(community_id==null||community_id===""){
                $(".community_val_msg").css("display","");
                return;
            }else{
                $(".community_val_msg").css("display","none");
            }
            if(classify_id==null){
                $(".classify_val_msg").css("display","");
                return;
            }else{
                $(".classify_val_msg").css("display","none");
            }
        }

        var open_time = $('#open_time').val();
        if(open_time==""){
            $('#open_time_msg').html("请选择开班时间");
            return false;
        }else{
            $('#open_time_msg').html("");
        }

        var close_time = $('#close_time').val();
        if(close_time==""){
            $('#close_time_msg').html("请选择结束时间");
            return false;
        }else{
            $('#close_time_msg').html("");
        }
        var credit = parseInt($("#inpt_credit").val());
		if(isNaN(credit)||credit<0){
			$(".credit_val").show();
			return false;
		}
        var sign = $('input[name="sign"]:checked').val();
        var maximum = $('#maximum').val();
        if(sign=="1"&&maximum==""){
            $('#maximum_msg').html("密码数量不能为空");
            return false;
        }else{
            $('#maximum_msg').html("");
        }
        $('input[name="sign_up"]').val(sign);
        if(validate()){
        	$('#sub').submit();
        }
    }
    //事物删除助教
    function delAssiant(value){
        $.ajax({
            url : '${pageContext.request.contextPath}/class/delAssaint.action',
            dataType : 'json',
            data:{
                id : value
            },
            success:function(data){
                $("#teacher"+value).remove();
            }
        });
    }
    //nosession移除助教
    function delTeacher(value){
        $("#teacher"+value).remove();
    }
    function doPages(value,row,total){
        //翻页
        var page =  parseInt($("#page").val())+1;
        $("#btn5").on('click', function () {
            $("#div1").PageChanged(5);
        });

        $(".pager").pagination({
            thisPageIndex:page,
            recordCount: total,       //总记录数
            pageSize:  row,            //一页记录数
            onPageChange: function (page) {
                $("#page").val(page-1);
                showTeacher(value);
            }
        });
    }

    function showTeacher(value){
        var page = $("#page").val();
        if(value==0){
            page = 0;
            $(".disabled").find("a").each(function(index,element){
                if(index==0){
                    $(element).click();
                }
            });
            $("#add-assistant").modal();
        }
        //搜索
        var title = $('#titles option:selected').val();
        var name = $('#true_name').val();
        if(title!=""||name!=""){
            page = 0;
        }
        $.ajax({
            url : '${pageContext.request.contextPath}/class/show_teacher.action',
            dataType : 'json',
            data:{
                true_name : name,
                titles : title,
                page : page
            },
            success : function(data){
                var titlelist = data.titlelist;
                var titlelen = titlelist.length;
                var titles = $('#titles option:selected').val();
                if(titlelen>0){
                    var html ='';
                    if(titles!=null&&titles!=""){
                        html += '<option name="titles" value="'+titles+'">'+titles+'</option>';
                    }
                    html += '<option value="">--按职称查询--</option>';
                    for(var i=0;i<titlelen;i++){
                        if(titles!=titlelist[i]){
                            html +='<option name="titles" value="'+titlelist[i]+'">'+titlelist[i]+'</option>';
                        }

                    }
                    $("#titles").empty().append(html);
                }

                var list = data.teacherViews;
                var view = data.teacherView;
                var html = "";
                for(var i=0; i<list.length; i++) {
                    html +=  ' <tr>'+
                        '<td><input type="checkbox" name="'+list[i].true_name+'" data-name="user_id" value="'+list[i].user_id+'"></td>'+
                        '<td>'+list[i].true_name+'</td>'+
                        '<td>'+list[i].user_name+'</td>'+
                        '<td>'+list[i].school+'</td>'+
                        '<td>'+list[i].course+'</td>'+
                        '<td>'+list[i].titles+'</td>'+
                        '</tr>';
                }
                $("#showAssistant").empty().append(html);
                $("#page").val(view.page);
                if(value==0){
                    if($("#pageFlag").val()==0){
                        doPages(1,view.rows,view.total);
                        $("#pageFlag").val(1);
                    }
                }

            }
        });
    }

    $(document).ready(function(e){


        //确定助教
        $('.tutor_confirm').on('click',function(){
            var len = $('input[data-name="user_id"]:checked').length;
            if(len==0){
                alert('请选择老师');
            }
            $('input[data-name="user_id"]:checked').each(function(){//嵌入的文件里有type="checkbox",故区分
                var tutor_name = $(this).attr('name');
                var user_id = $(this).val();
                $('input[data-name="save"]').each(function(){
                    var user = $(this).val();
                    if(user==user_id){
                        alert("您已选过该老师！");
                        return flase;
                    }
                });
                var str = '<li class="active" id="teacher'+user_id+'" ><a href="javascript:;">'+tutor_name+'&nbsp;&nbsp;<input name="user_id" value="'+user_id+'" type="hidden" data-name="save"><span class="tutor_del" onclick="delTeacher('+user_id+');">X</span></a></li>';
                $("#tutors").append(str);
            });
            $('#modal').hide();
            $('.modal-backdrop').remove();
        });
        $('.class_range .nav-pills li').on("click",function(){
            $(this).siblings().removeClass('active');
            $(this).addClass('active');
        })
    })

	/* 查询社区/工作坊 */
    function queryCommunitys(){
        var communityType = $("[ name = 'communityType']:checked").attr("value");
        if(communityType!=="0"&&communityType!=="1"){
            initFirstClassify();
            return ;
        }else if(communityType==="0"){
            $(".community_content [name='communityId']").removeAttr("disabled");
            $(".workshop_content [name='communityId']").attr("disabled","disabled");
        }else if(communityType==="1"){
            $(".workshop_content [name='communityId']").removeAttr("disabled");
            $(".community_content [name='communityId']").attr("disabled","disabled");
        }
        $.ajax({
            url:"${pageContext.request.contextPath}/class/query_communitys.action",
            data:{"communityType":communityType},
            dataType:"json",
            success:function(data){
                loadCommunitys(data,communityType);
            }
        });
    }

	/* 查询社区[工作坊]班级分类 */
    function queryClassifys(){
        var communityType = $("[ name = 'communityType']:checked").attr("value");
        var communityOption;
        if(communityType==="0"){
            communityOption = $(".community_content [ name = 'communityId'] option:selected");
        }else if(communityType==="1"){
            communityOption = $(".workshop_content [ name = 'communityId'] option:selected");
        }else{
            return ;
        }
        var communityId = $(communityOption).attr("value");
        var type = $("[ name = source_type]").attr("value");
        if(type!=="0"&&type!=="1"){
            return ;
        }
        $.ajax({
            url:"${pageContext.request.contextPath}/class/query_classifys.action",
            data:{"community_type":communityType,"type":type,"community_id":communityId},
            dataType:"json",
            success:function(data){
                loadClassifys(data,communityType);
            }
        });
    }

	/* 加载社区 */
    function loadCommunitys(data,communityType){
        initFirstClassify();
        var communityContainer ;
        if(communityType==0){
            $(".community_content").css("display","");
            communityContainer = $(".community_content [ name = 'communityId']");
        }else if(communityType==1){
            $(".workshop_content").css("display","");
            communityContainer = $(".workshop_content [ name = 'communityId']");
        }
        for(var i=0;i<data.length;i++){
            var option_container = $("<option>").val(data[i].id).text(data[i].name);
            $(communityContainer).append(option_container);
        }
    }

	/* 加载班级分类 */
    function loadClassifys(data,communityType){
        initSecondClassify();
        var classifyContainer ;
        if(communityType==0){
            $(".community_content").css("display","");
            classifyContainer = $(".community_content [ name = 'classifyId']");
        }else if(communityType==1){
            $(".workshop_content").css("display","");
            classifyContainer = $(".workshop_content [ name = 'classifyId']");
        }
        for(var i=0;i<data.length;i++){
            var option_container = $("<option>").val(data[i].id).text(data[i].name);
            $(classifyContainer).append(option_container);
            for(var j=0;j<data[i].sonClassifys.length;j++){
                var son_option_container = $("<option>").val(data[i].sonClassifys[j].id).text("——"+data[i].sonClassifys[j].name);
                $(classifyContainer).append(son_option_container);
            }
        }
    }

	/* 初始化一级分类模块 */
    function initFirstClassify(){
        $(".community_content [ name = 'communityId'] option:gt(0)").remove();
        $(".workshop_content [ name = 'communityId'] option:gt(0)").remove();
        $("[ name = 'classifyId'] option").remove();
        $(".community_content").css("display","none");
        $(".workshop_content").css("display","none");

    }

	/* 初始化二级分类模块 */
    function initSecondClassify(){
        $(".community_content [ name = 'classifyId'] option").remove();
        $(".workshop_content [ name = 'classifyId'] option").remove();
        $(".community_content").css("display","none");
        $(".workshop_content").css("display","none");
    }
</script>
