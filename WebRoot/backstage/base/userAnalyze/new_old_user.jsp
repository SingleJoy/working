<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<title>新老用户</title>

<!-- jquery库 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/backstage/js/jquery-1.8.2.min.js" charset="utf-8"></script>
<!-- easyui相关库 -->
<link id="easyuiTheme" rel="stylesheet" href="${pageContext.request.contextPath}/backstage/js/jquery-easyui-1.3.1/themes/<c:out value="${cookie.easyuiThemeName.value}" default="default"/>/easyui.css" type="text/css"></link>
<link rel="stylesheet" href="${pageContext.request.contextPath}/backstage/js/jquery-easyui-1.3.1/themes/icon.css" type="text/css"></link>
<script type="text/javascript" src="${pageContext.request.contextPath}/backstage/js/jquery-easyui-1.3.1/jquery.easyui.min.js?v0.1" charset="utf-8"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/backstage/js/jquery-easyui-1.3.1/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/backstage/css/data.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/jquery.1.10.2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/echarts.min.js"></script>
<%-- 	<script type="text/javascript" src="${pageContext.request.contextPath}/backstage/js/walden.project.json.js" charset="utf-8"></script> --%>
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/My97DatePicker/WdatePicker.js"></script>



<body>
<div class="main_content">
	<div class="main_head">
		<div class="main_head_content">
			<h3>新老用户
				<%-- <a class="download_data_btn" href="${pageContext.request.contextPath}/back_user/export_user_trend.action?<c:if test="${isDuration==0}">startTime=${startTime}&endTime=${endTime}&</c:if>
                       <c:if test="${isDuration==1}">days=${days}&</c:if>timeUnit=${timeUnit}&device=${device}&province_id=<c:if test="${empty province_id}">0</c:if>
                      <c:if test="${!empty province_id}">${province_id}</c:if>&logType=${logType}&compare=${compare}">
					<img src="${pageContext.request.contextPath}/frontstage/images/read_download.png">&nbsp;&nbsp;导出数据
				</a> --%>

			</h3>
			<form id="stupid" action="${pageContext.request.contextPath}/back_user/to_new_old_user.action">
				<br/>
				<div class="time">
					<div class="choose_date_01">
						<span>时间：</span>
						<input type="hidden" name="timeType" id="timeType" value="${timeType}">
						<a onclick="queryByTimeType(0);" class="<c:if test="${timeType=='0'}">active</c:if>" href="javascript:void(0);">今天</a>
						<a onclick="queryByTimeType(1);" class="<c:if test="${timeType=='1'}">active</c:if>" href="javascript:void(0);">昨天</a>
						<a onclick="queryByTimeType(2);" class="<c:if test="${timeType=='2'}">active</c:if>" href="javascript:void(0);">最近7天</a>
						<a onclick="queryByTimeType(3);" class="<c:if test="${timeType=='3'}">active</c:if>" href="javascript:void(0);">最近30天</a>
						&nbsp;时间段&nbsp;<input type="checkbox"  onchange="doDuration(this)" <c:if test="${isDuration!='1'&&timeType!='0'&&timeType!='1'}">checked="checked"</c:if>  value="0">
						<input id="isDuration" type="hidden" value="${isDuration}" name="isDuration">
					</div>

					<div id="single" class="select_time"  style="<c:if test="${isDuration!='1'&&timeType!='0'&&timeType!='1'}">display: none;</c:if>">
						<span><input id="days" name="days" <c:if test="${!empty days&&days!='undefined'}">value="${days}"</c:if> class="easyui-datebox" data-options="onSelect:onSelect,editable:false" style="width: 100px;" /></span>
					</div>

					<div id="duration" class="select_time" style="<c:if test="${isDuration!='0'&&timeType!='2'&&timeType!='3'}">display: none;</c:if>">
						<span>开始日期：<input id="startTime" name="startTime" <c:if test="${!empty startTime&&startTime!='undefined'}">value="${startTime}"</c:if> class="easyui-datebox" data-options="onSelect:onSelect,editable:false" style="width: 100px;" /></span>
						<span>结束日期：<input id="endTime" name="endTime" <c:if test="${!empty endTime&&endTime!='undefined'}">value="${endTime}"</c:if> class="easyui-datebox" data-options="onSelect:onSelect,editable:false"  style="width: 100px;"/></span>
					</div>
				</div>
				<br/>
				<br/>
				<div class="time">
					<div class="choose_date_01 ">
						<span title="包括省、直辖市、自治区">地域：</span>
						<span class="choose_area">
	                    <select id="province" onchange="queryByArea();" name="province" style="padding: 2px;height:25px;">
	                    </select>
	                </span>
					</div>
				</div>
				<br/>

			</form>
		</div>

	</div>

	<div class="main_body" style="min-height: 600px;">
		<br/>
		<br/>

		<div style="min-height: 250px;">
			<div class="data_pic" >

				<div style=" ">
					<div style="color:#00aeef;font-weight: bold;width: 200px;margin: 0 auto;">
						<div>新用户</div>
						<div id="new_ratio" style="margin-top: 20px;margin-left: 70px;font-size: 28px;font-weight: bold;">10%</div>
						<img src="https://tongji.baidu.com/web/image/n_visitor_logo.gif" style="margin-top: -40px;">
					</div>

					<div style="color: #616161;margin-left:30%;">
						<div id="new_loginNum">访客数：30</div>
						<div id="new_interval">平均访问时长：30</div>
					</div>
				</div>

			</div>

			<div class="data_pic" >

				<div style=" ">
					<div style="color:#00aeef;font-weight: bold;width: 200px;margin: 0 auto;">
						<div>老用户</div>
						<div id="old_ratio" style="margin-top: 20px;margin-left: 70px;font-size: 28px;font-weight: bold;">10%</div>
						<img src="https://tongji.baidu.com/web/image/o_visitor_logo.gif" style="margin-top: -40px;">
					</div>

					<div style="color: #616161;margin-left:30%;">
						<div id="old_loginNum">访客数：30</div>
						<div id="old_interval">平均访问时长：30</div>
					</div>
				</div>

			</div>
		</div>




		<div class="time" style="clear: both;padding-left: 20px;">
			<table class="table_sta" style="width: 80%;">
				<thead>
				<tr>
					<th style="width: 30%;">新老用户</th>
					<th style="width: 30%;">访客数</th>
					<th style="width: 30%;">平均访问时长</th>
				</tr>

				</thead>
				<tbody id="databody">
				</tbody>
			</table>
		</div>


	</div>

</div>



<script type="text/javascript">
    $(function(){
        $.ajax({
            type : 'POST',
            async :false,
            url : '${pageContext.request.contextPath}/back_user/query_new_old_user.action',
            data :{
                timeType : "${timeType}",
                days : "${days}",
                startTime : "${startTime}",
                endTime : "${endTime}",
                province_id : "${province}"
            },
            dataType : 'json',
            success : function(d) {
                var newUser = d.newUser;
                var oldUser = d.oldUser;
                var totalUser = d.totalUser;
                var new_ratio = "";
                var old_ratio = "";
                var total_loginNum = newUser.loginNum*1+oldUser.loginNum*1;
                var new_loginNum = newUser.loginNum;
                var new_interval = newUser.interval1;
                var old_loginNum = oldUser.loginNum;
                var old_interval = oldUser.interval1;
                if(total_loginNum!=0){
                    new_ratio = ((new_loginNum/total_loginNum)*100).toFixed(2)+"%";
                    old_ratio = ((old_loginNum/total_loginNum)*100).toFixed(2)+"%";
                }else{
                    new_ratio = "0%";
                    old_ratio = "0%";
                }
                $("#new_ratio").html(new_ratio);
                $("#old_ratio").html(old_ratio);
                $("#new_loginNum").html("访客数："+new_loginNum);
                $("#new_interval").html("平均访问时长："+new_interval);
                $("#old_loginNum").html("访客数："+old_loginNum);
                $("#old_interval").html("平均访问时长："+old_interval);
                var tbody = '<tr><td style="background-color: #eaeaea;">1.老用户</td><td>'+old_loginNum+'</td><td>'+old_interval+'</td></tr>';
                tbody += '<tr><td style="background-color: #eaeaea;">2.新用户</td><td>'+new_loginNum+'</td><td>'+new_interval+'</td></tr>';
                tbody += '<tr><td style="background-color: #eaeaea;">当前汇总</td><td>'+total_loginNum+'</td><td>'+totalUser.interval1+'</td></tr>';
                $("#databody").html(tbody);
            }
        });
    });

    function queryByTimeType(value){
        $("#timeType").val(value);
        $('input[name="days"]').val("");
        $('input[name="startTime"]').val("");
        $('input[name="endTime"]').val("");
        if(value=="0"||value=="1"){
            $("#isDuration").val("1");
        }else if(value=="2"||value=="3"){
            $("#isDuration").val("0");
        }
        $("#stupid").submit();
    }
    function doDuration(obj){
        isDuration = obj.checked;
        if(isDuration){//是时间段
            $("#duration").show();
            $("#single").hide();
            $("input[name='isDuration']").val(0);
        }else if(!isDuration){//是单一时间
            $("#startTime").val("");//没用
            $("#endTime").val("");//没用
            $("#duration").hide();
            $("#single").show();
            $("input[name='isDuration']").val(1);
        }
    }
    function onSelect(date){
        var isDuration = $("#isDuration").val();
        if(isDuration=="1"){//single
            //直接清空timeType，若是今天或昨天给timeType赋值
            $("#timeType").val("");
            var days = $('input[name="days"]').val();
            var today = new Date();
            var yesterday = new Date(today - 1000 * 60 * 60 * 24);
            var chooseday = new Date(days);
            if(chooseday.toDateString() === today.toDateString()){//今天
                $("#timeType").val(0);
            }
            if (yesterday.getYear() === chooseday.getYear() && yesterday.getMonth() === chooseday.getMonth() && yesterday.getDate() === chooseday.getDate()) {
                $("#timeType").val(1);
            }
            $("#stupid").submit();
        }else if(isDuration=="0"){
            var startTime = $('input[name="startTime"]').val();
            var endTime = $('input[name="endTime"]').val();
            if(startTime!=""&&endTime!=""){
                if(startTime<endTime){
                    //直接清空timeType，若是最近7天或最近30天给timeType赋值
                    $("#timeType").val("");
                    var start = new Date(startTime).getTime();
                    var end = new Date(endTime).getTime();
                    var now = new Date().getTime();
                    var days1 = parseInt((now-end)/(1000 * 60 * 60 * 24));
                    var days2 = parseInt((end-start)/(1000 * 60 * 60 * 24));
                    if(days2==6){//最近7天
                        if(days1==0){
                            $("#timeType").val("2");
                        }

                    }else if(days2==29){//最近30天
                        if(days1==0){
                            $("#timeType").val("3");
                        }
                    }
                    $("#stupid").submit();
                }else{
                    parent.sy.messagerShow({
                        msg : "开始时间必须小于结束时间！！",
                        title : '提示'
                    });
                }
            }
        }

    }
    function queryByArea(){
        $("#stupid").submit();
    }

</script>

</body>

