<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>
<link href="${pageContext.request.contextPath}/frontstage/css/my-space.css" rel="stylesheet" type="text/css">


<div class="cn-wrap">

	<div id="content-container" class="container">

		<jsp:include page="./personal_header.jsp"></jsp:include>

		<div class="row row-3-9">

			<jsp:include page="./personal_left.jsp"></jsp:include>

            <div class="col-md-9">

                <div class="panel panel-default panel-col">
                    <div class="panel-heading">基础信息</div>
                    <div class="panel-body">

                        <form id="my_form" class="form-horizontal" method="post" action="${pageContext.request.contextPath}/my_setting/updateMySetting.action?state=${state}&stamp=${stamp}" novalidate="novalidate" >
                            <input type="hidden" name="id" value="${mySetting.id }">
                            <input type="hidden" name="userId" value="${currentUser.id}">
							<input type="hidden" name="oldName" value="${mySetting.userName }" id="oldName">
							<input type="hidden" name="oldPhone" value="${mySetting.phone }" id="oldPhone">
							<input type="hidden" name="default_profile" value="${mySetting.default_profile }" id="default_profile">
							<input type="hidden" name="default_signature" value="${mySetting.default_signature }" id="default_signature">
                            <div class="course_save_succ alert alert-success" <c:if test="${updateOk!=1}">style="display:none;"</c:if>>个人基础信息已保存!</div>
                            <div class="form-group">
                                <label class="col-md-2 control-label">用户名</label>
                                <div class="col-md-8 controls">
                                    <div class="control-text">
                                    <input id="username" name="userName" type="hidden" class="form-control" value="${mySetting.userName }"/>
                                        <div id="vir_username" style="display: inline-block;">${mySetting.userName }</div>
										<a href="javascript:void(0);" onclick="c_modal();" data-toggle="modal">修改</a>
                                    </div>
                                </div>
                            </div>

							<div class="form-group" style="margin-top: -20px;">
								<label  class="col-md-2 control-label">手机号码</label>
								<div class="col-md-8 controls">
									<div id="edit_phone" class="control-text">
										<input id="phone" name="phone"  value="${mySetting.phone }" type="hidden"/>
										<c:if test="${!empty mySetting.phone }">
										<div id="show_phone" style="display: inline-block;">${mySetting.phone }<small class="text-success" style="padding-left: 20px;">(已绑定)</small></div>
                                        <a href="#change_cell_number" onclick="show_old_phone();" data-toggle="modal" class="text-warning">修改</a>
                                        </c:if>
										<c:if test="${empty mySetting.phone }"><a id="add_phone" href="#change_cell_number" onclick="add_phone();" data-toggle="modal" class="text-warning">添加</a></c:if>
										<div id="phone_msg" class="help-block"></div>
									</div>
								</div>
							</div>

                            <div class="form-group" style="margin-top: -20px;">
                                <label class="col-md-2 control-label" >姓名</label>
                                <div class="control-text">
                                <input name="realname" id="realname" onblur="check_realname();" type="text" value="${mySetting.realname }" class="form-control"/>
                                <div id="realname_msg" class="help-block" style="display: none;">请输入真实姓名，只能是2-4个汉字！</div>
                                </div>
                            </div>

                            <div class="form-group" style="margin-top: -20px;">
                                <label class="col-md-2 control-label">性别</label>
                                <div class="col-md-8 controls radios">
                                    <div id="profile_gender">
                                        <input type="radio"  name="sex" required="required" value="1" <c:if test="${mySetting.sex eq 1}">checked="checked"</c:if>>
                                        <label  class="required">男</label>
                                        <input type="radio"  name="sex" required="required" value="0" <c:if test="${mySetting.sex eq 0}">checked="checked"</c:if>>
                                        <label  class="required">女</label>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group" style="margin-top: -20px;">
                                <label class="col-md-2 control-label" >身份证号</label>
                                <div class="col-md-8 controls">
                                    <div class="control-text">
                                    <input name="ID_number" id="ID_number" onblur="check_ID_number();" type="text" value="${mySetting.ID_number}" class="form-control"/>
                                    <div id="ID_number_msg" style="color:red" class="help-block"></div>
                                    </div>
                                </div>
                            </div>


                            
                            <div class="form-group" style="margin-top: -20px;">
								<label class="col-md-2 control-label">邮箱</label>

								<div class="controls col-md-8">
								   <div class="control-text">
										<input id="email" name="email" class="form-control" type="text" value="${mySetting.email }"/>
										<span class="text-danger" id="email_msg"></span>
								   </div>
								</div>

							</div>

                            <div class="form-group" style="margin-top: -20px;display: none;">
                                <label class="col-md-2 control-label">头衔</label>
                                <div class="col-md-8 controls">
                                    <input name="rank" type="text" value="${mySetting.rank }" class="form-control"/>

                                </div>
                            </div>

                            <div class="form-group" style="margin-top: -20px;">
                                <label class="col-md-2 control-label">个人签名</label>
                                <div class="col-md-8 controls">
                                    <input id="signature" name="signature" type="text" value="${mySetting.signature }" class="form-control"/>

                                </div>
                            </div> 
                            <div class="form-group" style="margin-top: -10px;">

                                <label class="col-md-2 control-label">学校信息</label>
                                <div class="col-md-2 controls">
                                    <select class="form-control" name="province" id="province" onchange='_province(this.value)'>
                                        <option value="-1">--请选择省！--</option>
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
                                <div class="col-md-2 controls" >
                                    <select class="form-control" name="city" id="city" onchange="_city(this.value)">
                                        <option value="-1">--请选择市！--</option>
                                        <c:forEach items="${cityList}" var="cityl">
											<c:if test="${cityl.id == city}">
												<option selected="selected" value="${cityl.id}">${cityl.area_name}</option>
											</c:if>
											<c:if test="${cityl.id != city}">
												<option value="${cityl.id}">${cityl.area_name}</option>
											</c:if>
										</c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-2 controls">
                                    <select class="form-control" name="county" id="county" onchange="_county(this.value)" >
                                        <option value="-1">--请选择县！--</option>
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
                                <div class="col-md-2 controls">
                                    <select class="form-control" name="school_id" id="school" onchange="_school(this.value)">
                                        <option value="-1">--请选择学校！--</option>
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

                                <label class="col-md-2 control-label">学科信息</label>
                                <div class="col-md-2 controls">
                                    <select class="form-control" id="studySection" name="studySection" onclick="delStudySection()">
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
                                <div class="col-md-2 controls">
                                    <select id="subject" onchange="_subject(this.value);" class="form-control" >
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
                                <div class="col-md-2 controls">
                                    <select class="form-control" id="edition" name="edition">
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
                                <div class="col-md-2 controls">
                                    <select class="form-control" id="grade" name="grade" onclick="_grade()">
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

                            <div class="form-group" >
                                <label class="col-md-2 control-label">个人主页</label>
                                <div class="col-md-7 controls">
                                    <a class="form-control" target="_blank" href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id=${user.id}">
                                    ${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id=${user.id}
                                    </a>

                                </div>
                            </div>

                            <div class="form-group" style="margin-top: -20px;display: none;">
                                <div class="col-md-2 control-label">
                                    <label>微博</label>
                                </div>
                                <div class="col-md-7 controls">
                                    <input type="text" name="microblog" class="form-control"  value="${mySetting.microblog }">
                                </div>
                                <div class="col-md-2 controls mts">
                                    <input name="blog_open" type="checkbox" value="1" <c:if test="${mySetting.blog_open eq 1}">checked="checked"</c:if>>公开</div>
                            </div>

                            <div class="form-group" style="margin-top: -20px;display: none;">
                                <label class="col-md-2 control-label">微信</label>
                                <div class="col-md-7 controls">
                                    <input type="text" name="wechat" class="form-control" value="${mySetting.wechat }">

                                </div>
                                <div class="col-md-2 controls mts">
                                    <input type="checkbox" name="chat_open" value="1" <c:if test="${mySetting.chat_open eq 1}">checked="checked"</c:if>>公开</div>
                            </div>

                            <div class="form-group" style="margin-top: -20px;display: none;">
                                <label  class="col-md-2 control-label">QQ</label>
                                <div class="col-md-7 controls">
                                    <input type="text" class="form-control" name="qq" value="${mySetting.qq }">

                                </div>
                                <div class="col-md-2 controls mts">
                                    <input type="checkbox" name="qq_open" value="1" <c:if test="${mySetting.qq_open eq 1}">checked="checked"</c:if>>公开
                                </div>
                            </div>
                            <div class="form-group" style="margin-top: -20px;">
                                <label class="col-md-2 control-label">自我介绍</label>
                                <div class="col-md-8 controls">
                                    <textarea id="synopsis" rows="6" name="synopsis"  onKeyUp="LimitTextArea(this);" onblur="minnum();" class="form-control">${mySetting.synopsis }</textarea>
                                    <div class="help-block">字数请保持在15-200</div>
                                    <div class="help-block" style="color:#F00" id="synopsis_msg" ></div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-7 col-md-offset-2">
                                    <button  type="button" class="btn btn-primary" onclick="setting_submit();">保存</button>
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

<!--修改用户名-->
<div id="change_user_name" class="modal in" aria-hidden="false" style="display: none;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title"><span class="text-muted">用户名修改</span></h4>
			</div>
			<div class="modal-body">

				<form class="form-horizontal">
					<div class="form-group">
						<div class="col-md-2 control-label">
							<label >用户名</label>
						</div>
						<div class="col-md-8 controls">
							<input id="edit_username" type="text" onblur="check_usernam();" class="form-control" value="${mySetting.userName }" >
							<div id="username_msg" class="help-block" ></div>
						</div>
					</div>
				</form>

			</div>
			<div class="modal-footer">
				<button type="button" id="o_name" onclick="edit_username();" class="btn btn-primary">保存</button>
				<button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>

<!--修改手机号码-->
<div id="change_cell_number" class="modal in" aria-hidden="false" style="display: none;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title"><span class="text-muted">修改手机号码</span></h4>
			</div>
			<div class="modal-body">

				<div class="login-main reset_password col-md-8 col-md-offset-2" style="">

					<form id="phone_form" method="post" action="" novalidate="novalidate" class="form-horizontal">
						<input type="hidden" name="id" value="${currentUser.id}">
						<div class="form-group mbl">
							<label class="control-label required"><span class="text-danger">*</span>旧手机号码</label>
							<div class="controls">
								<input id="old_phone" type="hidden"  value="${mySetting.phone}">
								<input id="show_old_phone" disabled="disabled" type="text" class="form-control input-lg">
							</div>
						</div>

						<div class="form-group mbl ">
							<label class="control-label required"><span class="text-danger">*</span>短信验证码</label>
							<div class="controls row">
								<div class="col-xs-7">
									<input type="text" id="old_yzm" onblur="check_yzm(this.value,'old_yzm_msg');" class="form-control input-lg" placeholder="短信验证码" required="required">
									<span id="old_yzm_msg" class="text-danger"></span>
								</div>
								<div id="old_yzm_cl" class="col-xs-5" onclick="getPhoneYzm('old_phone',0,0);">
									<a href="javascript:void(0);" class="btn btn-default btn-lg js-sms-send disabled">
										<span id="js-time-left"></span>
										<span id="get_old_yzm">获取短信验证码</span>
									</a>
								</div>
							</div>
						</div>

						<div class="form-group mbl">
							<input type="button" value="确定" class="btn btn-warning btn-lg btn-block change_password_sure" onclick="confirm_old_phone();">
						</div>

					</form>


					<form id="new_phone_form" method="post" action="" novalidate="novalidate" class="form-horizontal" style="display: none;">

						<div class="form-group mbl">
						<label class="control-label required"><span class="text-danger">*</span>请输入<c:if test="${!empty mySetting.phone }">新的</c:if>手机号码</label>
							<div class="controls">
								<input id="new_phone" onblur="check_phone(this.value);" name="phone" type="text" class="form-control input-lg" placeholder="请输入你的注册手机号码">
								<div class="text-danger" id="new_phone_msg" >手机号不能为空</div>
							</div>
						</div>

						<div class="form-group mbl ">
							<label class="control-label required"><span class="text-danger">*</span>短信验证码</label>
							<div class="controls row">
								<div class="col-xs-7">
									<input type="text" id="new_yzm" onblur="check_yzm(this.value,'new_yzm_msg');" class="form-control input-lg" placeholder="短信验证码" required="required">
									<span id="new_yzm_msg" class="text-danger"></span>
								</div>
								<div id="new_yzm_cl" class="col-xs-5" onclick="getPhoneYzm('new_phone','new_phone_msg',1);">
									<a href="javascript:void(0);" class="btn btn-default btn-lg js-sms-send disabled">
										<span ></span>
										<span id="get_new_yzm">获取短信验证码</span>
									</a>
								</div>
							</div>
						</div>

						<div class="form-group mbl">
							<input type="button" value="确定" class="btn btn-warning btn-lg btn-block change_password_sure" onclick="confirm_new_phone();">
						</div>

					</form>

				</div>

			</div>
			<div class="modal-footer">

				<button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
    var old_phone0 = "${mySetting.phone }";
    function show_old_phone(){
    	if(old_phone0!=""){
    		var show_old_phone = old_phone0.substring(0,3)+"******"+old_phone0.substring(9);
        	$("#show_old_phone").val(show_old_phone);
    	}
    }
    
    function check_phone(phone){
        if(phone==""){
            $("#new_phone_msg").html("手机号不能为空");
            return false;
        }else{
            $("#new_phone_msg").html("");
        }
        if(!phone_reg.test(phone)){
            $("#new_phone_msg").html("手机格式不正确");
            return false;
        }else{
            $("#new_phone_msg").html("");
        }
        var flag1=2;
        $.ajax({
            async : false,
            type:'post',
            url:"/edu_yun/user/checkPhone.action",
            data:$("#new_phone_form").serialize(),
            dataType:'json',
            success:function(response){
                flag1=response.flag;
                if(flag1==1){
                    $("#new_phone_msg").html("该号码已被注册了!");
                }
            }
        });
       if(flag1==1){
            return false;
        }else{
            $("#new_phone_msg").html("");
            return true;
        } 
    }
    var iTime = 59;
    var eTime = 0;
    function getPhoneYzm(phone0,msg,value){ 	
    	if(eTime===1){return false;}
    	var reg=/^13[0-9]{9}$|14[0-9]{9}|15[0-9]{9}$|18[0-9]{9}|17[0-9]{9}$/;
        var phone=$("#"+phone0).val();
        if(msg!="0"){//输入新手机号
        	if(phone==""){
            	$("#"+msg).html("手机号不能为空");
            	return false;
            }
        	if(!reg.test(phone)){
            	$("#"+msg).html("手机格式错误");
            	return false;
            }else{
            	$("#"+msg).html("");
            }
        }
        $.ajax({
            type:'post',
            url:"/edu_yun/user/getPhoneYzm.action",
            data:{
            	phone : phone
            },
            dataType:'json',
            success:function(response){
                if(response.status=="y"){
                	if(value==0){
                		RemainTime0();
                	}else if(value==1){
                		RemainTime1();
                	}
                }else{
                	alert("获取验证码失败!");	
                }
            }
        });
    }
    
    function RemainTime0(){
    	var ahtml="";
    	if (iTime > 0){
    		ahtml = '提交成功（'+iTime+'秒）';
      		Account = setTimeout("RemainTime0()",1000);
      		iTime=iTime-1;
      		eTime=1;	  
  	    }else{
  	    	$("#old_yzm_cl").css('background-color','');
  	    	clearTimeout(Account);
  	  		ahtml='点击获取验证码';
  	  		iTime = 59;
  	  		eTime=0;
  	    }
    	$("#get_old_yzm").html(ahtml);
    	$("#get_old_yzm").css("color","#fff");
    	$("#old_yzm_cl>a").addClass("btn-danger");
    }
    function RemainTime1(){
    	var ahtml="";
    	if (iTime > 0){
    		ahtml = '提交成功（'+iTime+'秒）';
      		Account = setTimeout("RemainTime1()",1000);
      		iTime=iTime-1;
      		eTime=1;	  
  	    }else{
  	    	$("#new_yzm_cl").css('background-color','');
  	    	clearTimeout(Account);
  	  		ahtml='点击获取验证码';
  	  		iTime = 59;
  	  		eTime=0;
  	    }
    	$("#get_new_yzm").html(ahtml);
    	$("#get_new_yzm").css("color","#fff");
    	$("#new_yzm_cl>a").addClass("btn-danger");
    } 
    
    function check_yzm(yzm,msg){
        if(yzm==""){
            $("#"+msg).html("验证码不能为空");
            return false;
        }else{
            $("#"+msg).html("");
        }
        var flag1=2;
        $.ajax({
        	async : false,
        	type:'post',
        	url:"/edu_yun/user/checkYzm.action",
            data:{
               yzm : yzm
            },
            dataType:'json',
            success:function(response){
                flag1=response.flag;
            }
        });
        if(flag1==1){
        	$("#"+msg).html("验证码错误");
            return false;
        }else{
            $("#"+msg).html("");
            return true;
        }
    } 
    function confirm_old_phone(){
    	var old_yzm = $("#old_yzm").val();
    	var old_yzm_ok = check_yzm(old_yzm,"old_yzm_msg");
    	if(old_yzm_ok){
    		var flag1 = 1;
    		$.ajax({
                async : false,
                type:'post',
                url:"/edu_yun/user/unlock_phone.action",
                data:$("#phone_form").serialize(),
                dataType:'json',
                success:function(response){
                    flag1=response.flag;
                    if(flag1==2){
                        alert("解绑失败！");
                    }
                }
            });
    		if(flag1==2){
    			return false;
    		}
    		$("#phone_form").hide();
            $("#new_phone_form").show();
    	}
    }
    function confirm_new_phone(){
    	var new_phone = $("#new_phone").val();
    	var new_phone_ok = check_phone(new_phone);
    	var new_yzm = $("#new_yzm").val();
    	var new_yzm_ok = check_yzm(new_yzm,"new_yzm_msg");
    	if(new_phone_ok&&new_yzm_ok){
    		$("#phone").val(new_phone);
    		if(old_phone0!=""){
    			$("#show_phone").html(new_phone);
    		}else{
    			$("#edit_phone").prepend('<div id="show_phone" style="display: inline-block;">'+new_phone+'<small class="text-success" style="padding-left: 20px;">(已绑定)</small></div>');
    			$("#add_phone").hide();
    		}
    		$("#change_cell_number").modal('hide');
    	}
    	
    }
    function add_phone(){
    	$('#phone_form').hide();
    	$('#new_phone_form').show();
    	
    }
    
	var email_reg=/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
	var phone_reg=/^13[0-9]{9}$|14[0-9]{9}|15[0-9]{9}$|18[0-9]{9}|17[0-9]{9}$/;
	var vcity={ 11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",
            21:"辽宁",22:"吉林",23:"黑龙江",31:"上海",32:"江苏",
            33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",
            42:"湖北",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",
            51:"四川",52:"贵州",53:"云南",54:"西藏",61:"陕西",62:"甘肃",
            63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外"
           };

    function setting_submit(){
    	//验证个人信息
		var phone=$("#phone").val();
		var email=$("#email").val();
		var oldPhone=$("#oldPhone").val();
		if(!(check_realname()&&check_ID_number())){//&&minnum()
			return false;
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
		/*  if(email==""){
			$("#email_msg").html("邮箱不能为空");
			return false;
		}else{
			$("#email_msg").html("");
		}  */
		if(email!=""){
			if(!email_reg.test(email)){
				$("#email_msg").html("邮箱格式不正确");
				$("#email").val("");
				return false; 
			} else{
				$("#email_msg").html("");
			}
		}
		
    	//验证学校信息
    	if($("#newSchool").text()!=null){
			if(!($("#province").val()!=null||$("#city").val()!=null||$("#county").val()!=null)){
				alert("请选择省市县");
				return false;
			}
		}else{
			if($("#school").val()==null){
				alert("请选择学校");
				return false;
			}
		}
    	//验证学科信息
    	if($("#edition").val()!=null){
			if($("#grade").val()==null){
				alert("请输入年级");
				return false;
			}
		}else{
			alert("请输入版本");
		}
    	if($("#default_profile").val()==1){//之前是默认的
    		var newprofile = $("#synopsis").val().replace(/\s+/g,"");
    		var oldprofile = "${mySetting.synopsis}".replace(/\s+/g,"");
    	    if(oldprofile!=newprofile){
    	    	$("#default_profile").val("0");
    	    }
    	}
    	if($("#default_signature").val()==1){//之前是默认的
    		var newsignature = $("#signature").val().replace(/\s+/g,"");
    	    var oldsignature = "${mySetting.signature}".replace(/\s+/g,"");
    	    if(oldsignature!=newsignature){
    	    	$("#default_signature").val("0");
    	    }
    	}
    	
    	$("#my_form").submit(); 
    }
	function delStudySection(){
		$("#nullStudySection").remove();
	}
    function c_modal(){
    	$("#change_user_name").modal();
    	$("#o_name").removeAttr("data-dismiss");
    }
    
    function LimitTextArea(field){
        maxlimit=200;
        if (field.value.length > maxlimit)
         field.value = field.value.substring(0, maxlimit);
    }
    
    function minnum(){
    	var len = $("#synopsis").val().length;
    	if(len<15){
    		$("#synopsis_msg").html("至少15字！");
    		return false;
    	}else{
    		$("#synopsis_msg").html("");
    		return true;
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

	function check_usernam(){
		var username=$("#edit_username").val();
		var oldName=$("#oldName").val();
		//用户名
		if(username==""){
			$("#username_msg").html("用户名不能为空");
			return null;
		}else{
			$("#username_msg").html("");
		}
		var flag=2;
		if(oldName!=username){
			$.ajax({
				async : false,
				type:'post',
				url:"/edu_yun/user/checkRegister.action",
				data:{
					username : username
				},
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
			return null;
		}else{
			$("#username_msg").html("");
			return username;
		}
	}
	
	function edit_username(){
		var check_username = check_usernam();
		if(check_username!=null&&check_username!=""){
			$("#username").val(check_username);
			$("#vir_username").html(check_username);
			$("#o_name").attr("data-dismiss","modal");
		}
	}
	
	function check_realname(){
		var truename=document.getElementById("realname").value; 
		if(truename==""){
			return true;
		}
	    var reg = /^[\u4e00-\u9fa5]{2,4}$/i; 
	    if(!reg.test(truename)) {
	    	/* $("#realname_msg").html("请输入真实姓名，只能是2-4个汉字！"); */
	    	$("#realname_msg").show().css('color','red');
	    	$("#realname").val("");
	    	return false;
	    }else{
	    	$("#realname_msg").hide().css('color','');
	    	return true;
	    } 
	    
	}
	
	function check_ID_number(){
		var card = document.getElementById('ID_number').value;
        //是否为空
        if(card != '')
        {
          //校验长度，类型
            if(isCardNo(card) === false)
            {
            	$("#ID_number_msg").html("您输入的身份证号码不正确，请重新输入");
                return false;
            }
            //检查省份
            if(checkProvince(card) === false)
            {
            	$("#ID_number_msg").html("您输入的身份证号码不正确,请重新输入");
                return false;
            }
            //校验生日
            if(checkBirthday(card) === false)
            {
            	$("#ID_number_msg").html("您输入的身份证号码生日不正确,请重新输入");
                return false;
            }
           /*  //检验位的检测
            if(checkParity(card) === false)
            {
            	$("#ID_number_msg").html("您的身份证校验位不正确,请重新输入");
                return false;
            } */
        }
        
        $("#ID_number_msg").html("");
        return true;
	}
	
	//检查号码是否符合规范，包括长度，类型
	function isCardNo(card){
		//身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X
	    var reg = /(^\d{15}$)|(^\d{17}(\d|X)$)/;
	    if(reg.test(card) === false)
	    {
	        return false;
	    }
	    return true;
	}
	
	//取身份证前两位,校验省份
	function checkProvince(card){
		var province = card.substr(0,2);
	    if(vcity[province] == undefined)
	    {
	        return false;
	    }
	    return true;
	}
	
	//检查生日是否正确
	function checkBirthday(card){
		var len = card.length;
	    //身份证15位时，次序为省（3位）市（3位）年（2位）月（2位）日（2位）校验位（3位），皆为数字
	    if(len == '15')
	    {
	        var re_fifteen = /^(\d{6})(\d{2})(\d{2})(\d{2})(\d{3})$/; 
	        var arr_data = card.match(re_fifteen);
	        var year = arr_data[2];
	        var month = arr_data[3];
	        var day = arr_data[4];
	        var birthday = new Date('19'+year+'/'+month+'/'+day);
	        return verifyBirthday('19'+year,month,day,birthday);
	    }

	    //身份证18位时，次序为省（3位）市（3位）年（4位）月（2位）日（2位）校验位（4位），校验位末尾可能为X
	    if(len == '18')
	    {
	        var re_eighteen = /^(\d{6})(\d{4})(\d{2})(\d{2})(\d{3})([0-9]|X)$/;
	        var arr_data = card.match(re_eighteen);
	        var year = arr_data[2];
	        var month = arr_data[3];
	        var day = arr_data[4];
	        var birthday = new Date(year+'/'+month+'/'+day);
	        return verifyBirthday(year,month,day,birthday);
	    }
	    return false;
	}
	
	//校验日期
	function verifyBirthday(year,month,day,birthday){
		var now = new Date();
	    var now_year = now.getFullYear();
	    //年月日是否合理
	    if(birthday.getFullYear() == year && (birthday.getMonth() + 1) == month && birthday.getDate() == day)
	    {
	        //判断年份的范围（3岁到100岁之间)
	        var time = now_year - year;
	        if(time >= 3 && time <= 100)
	        {
	            return true;
	        }
	        return false;
	    }
	    return false;
	}

	//校验位的检测
	function checkParity(card){
		 //15位转18位
	    card = changeFivteenToEighteen(card);
	    var len = card.length;
	    if(len == '18')
	    {
	        var arrInt = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2); 
	        var arrCh = new Array('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2'); 
	        var cardTemp = 0, i, valnum; 
	        for(i = 0; i < 17; i ++) 
	        { 
	            cardTemp += card.substr(i, 1) * arrInt[i]; 
	        } 
	        valnum = arrCh[cardTemp % 11]; 
	        if (valnum == card.substr(17, 1)) 
	        {
	            return true;
	        }
	        return false;
	    }
	    return false;
	}
	
	//15位转18位身份证号
	function changeFivteenToEighteen(card){
		 if(card.length == '15')
		    {
		        var arrInt = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2); 
		        var arrCh = new Array('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2'); 
		        var cardTemp = 0, i;   
		        card = card.substr(0, 6) + '19' + card.substr(6, card.length - 6);
		        for(i = 0; i < 17; i ++) 
		        { 
		            cardTemp += card.substr(i, 1) * arrInt[i]; 
		        } 
		        card += arrCh[cardTemp % 11]; 
		        return card;
		    }
		    return card;
	}
	
	
	function test(){
		alert($("#file").val());
	}
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
	
	
</script>








