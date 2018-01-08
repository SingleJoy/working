<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<title>用户在线统计</title>

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
<script type="text/javascript">
    var options = '<option value="0">全部</option>';
    $.ajax({
        type : 'POST',
        url : '${pageContext.request.contextPath}/back_area/queryProvince.action',
        data :{
            parentId : 1
        },
        dataType : 'json',
        success : function(d) {
            for(var i=0;i<d.length;i++){
                if(d[i].id=="${province}"){
                    options += '<option selected="selected" value="'+d[i].id+'">'+d[i].area_name+'</option>';
                }else{
                    options += '<option value="'+d[i].id+'">'+d[i].area_name+'</option>';
                }

            }
            $("#province").html(options);
        }
    });
    //        统计数据展开与收起
    $(function () {
        $(".fold_open").click(function () {
            $(this).hide();
            $("#data_pic").show();
            $(".fold_close").show();
            $("#data_title").hide();

        });
        $(".fold_close").click(function () {
            $(this).hide();
            $("#data_pic").hide();
            $(".fold_open").show();
            $("#data_title").show();
        });
    })

</script>



<body onload="timer0();">
<div class="main_content">

    <div class="main_head">
        <div class="main_head_content">
            <h3>用户在线统计</h3>

            <form id="stupid" action="/edu_yun/back_user/to_user_online.action">
                <input name="current0" id="current0" type="hidden"><br/>
                <div class="time" style="margin-top:20px;">
                    <div class="choose_date_01">
                        <span>设备：</span>
                        <input type="hidden" name="device" id="device" value="${device}">
                        <a onclick="queryOnlineByDevice('-1');" class="<c:if test="${device==-1}">active</c:if>" href="javascript:void(0);">全部</a>
                        <a onclick="queryOnlineByDevice('0');" class="<c:if test="${device==0}">active</c:if>" href="javascript:void(0);">PC端</a>
                        <a onclick="queryOnlineByDevice('1');" class="<c:if test="${device==1}">active</c:if>" href="javascript:void(0);">移动端</a>
                    </div>
                    <div class="choose_date_01 ">
                        <span title="包括省、直辖市、自治区">地域：</span>
                        <span class="choose_area">
	                    <select id="province" onchange="queryOnlineByArea();" name="province" style="height:25px;padding: 2px;">
                        </select>
	                </span>
                    </div>
                    <div class="choose_date_01">
                        <input type="hidden" name="sex" id="sex" value="${sex}">
                        <span>性别：</span>
                        <a class="<c:if test="${sex==0}">active</c:if>" onclick="queryOnlineBySex('0');" href="javascript:void(0);">全部</a>
                        <a class="<c:if test="${sex==1}">active</c:if>" onclick="queryOnlineBySex('1');" href="javascript:void(0);">男</a>
                        <a class="<c:if test="${sex==2}">active</c:if>" onclick="queryOnlineBySex('2');" href="javascript:void(0);">女</a>
                    </div>
                    <br/>
                    <br/>

                    <div class="choose_date_01" style="clear: both;">
                        <span>用户：</span>
                        <input type="hidden" name="status" id="status" value="${status}">
                        <a onclick="queryOnlineByStatus('0');" class="<c:if test="${status=='0'}">active</c:if>" href="javascript:void(0);">全部</a>
                        <a onclick="queryOnlineByStatus('1');" class="<c:if test="${status=='1'}">active</c:if>" href="javascript:void(0);" title="新注册用户">新用户</a>
                        <a onclick="queryOnlineByStatus('2');" class="<c:if test="${status=='2'}">active</c:if>" href="javascript:void(0);">老用户</a>
                    </div>
                </div>
                <br/>


            </form>

        </div>
    </div>

    <div class="main_body">
        <div style="clear: both;padding-top: 30px;padding-left: 20px;">
            <div class="online_title" style="clear: both;">
                当前在线
                <span id="countdown" style="color: red;padding:0 10px;"></span> 秒之后更新数据
            </div>
            <div class="calendar_time" >
                <div id="nowtime"></div><br/>
                <div style="font-size: 42px;color:orange;text-align: center;"><label id="nownum"></label></div><br/>
                <div style="text-align: center;">在线访客人数</div>
            </div>
            <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
            <div class="usertrend" >
                <div id="onlineNum" style=" width:700px;height:350px;margin-top: 30px; "></div>
            </div>

        </div>


        <div class="time" style="clear: both;">
            <table class="table_sta">
                <thead>
                <tr>
                    <th style="width:100px">用户</th>
                    <th style="width:150px">访问时间</th>
                    <th style="width:100px">地域</th>
                    <th style="width:100px"> 访问IP</th>
                    <th style="width:150px"> 退出时间</th>
                    <th style="width:150px"> 访问时长</th>
                </tr>
                </thead>
                <tbody id="databody"></tbody>
            </table>
        </div>
    </div>



</div>

<script type="text/javascript">
    Date.prototype.Format = function (fmt) { //author: meizz
        var o = {
            "M+": this.getMonth() + 1, //月份
            "d+": this.getDate(), //日
            "h+": this.getHours(), //小时
            "m+": this.getMinutes(), //分
            "s+": this.getSeconds(), //秒
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度
            "S": this.getMilliseconds() //毫秒
        };
        if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    }
    var iTime = 60;
    var eTime = 0;
    var onlinecheck = {
        type : 'POST',
        async :false,
        url : '${pageContext.request.contextPath}/back_user/query_user_online.action',
        data :{
            sex : $("#sex").val(),
            device : $("#device").val(),
            status : $("#status").val(),
            province_id : "${province}"
        },
        dataType : 'json',
        success : function(d) {
            var list1 = d.userStatsList;
            var list2 = d.onlineUser;
            var tbody = "";
            for(var i=0;i<list1.length;i++){
                days[i] = list1[i].days;
                newNum[i] = list1[i].newNum;
            }
            for(var i=0;i<list2.length;i++){
                var endtime = "";
                if(list2[i].end!=""&&list2[i].end!=null){
                    endtime = list2[i].end.substr(0,19);
                }else{
                    endtime = "未知";
                }
                var duration = "";
                if(list2[i].duration==""){
                    duration = "未知";
                }else{
                    duration = list2[i].duration;
                }
                tbody += '<tr><td>'+list2[i].username+'</td><td>'+list2[i].start.substr(0,19)+'</td><td>'+list2[i].address+'</td><td>'+list2[i].remote_ip+'</td><td>'+endtime+'</td><td>'+duration+'</td>';
            }
            $("#nowtime").html(d.nowtime);
            $("#nownum").html(d.nownum);
            $("#databody").html(tbody);
        }
    };
    function timer0(){
        /* if(eTime===1){return false;} */
        var ahtml="";
        if (iTime > 0){
            ahtml = iTime;
            Account = setTimeout("timer0()",1000);
            iTime=iTime-1;
            eTime=1;
        }else{
            ajaxrush();
            iTime = 60;
            return timer0();
            /* $("#stupid").submit(); */

        }
        $("#countdown").html(ahtml);
    }
    var days = new Array();
    var newNum = new Array();

    $(function(){
        ajaxrush();
    })
    function ajaxrush(){
        $.ajax(onlinecheck);
        cavning();
    }

    //基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('onlineNum'));
    option = {
        tooltip : {
            trigger: 'axis'
        },
        legend: {
            data:['最近30分钟访问情况']
        },
        toolbox: {
            show : true,
            left :'700',
            right: '50',// toolbox的右边被拉长，使本来被遮住的字体显示出来了 
            feature : {
                mark : {show: true},
                magicType : {show: true, type: ['line', 'bar']},
            }
        },

        calculable : true,
        xAxis : [
            {
                type : 'category',
                boundaryGap : false,
                data : []//横坐标
            }
        ],
        yAxis : [
            {
                type : 'value',
                axisLine: {show: false}
            },

        ],
        series : [{
            name:"最近30分钟访问情况",
            type:'line',
            smooth:true,
            itemStyle: {normal: {color:'#4da7fd',lineStyle:{color:'#4da7fd'},areaStyle: {type: 'default'}}},
            data:[]
        }]
    };
    function cavning(){

        myChart.showLoading();
        fetchData(function(data) {
            myChart.hideLoading();
            myChart.setOption({
                xAxis : {
                    data : data.days
                },
                series : [{
                    // 根据名字对应到相应的系列
                    name : "最近30分钟访问情况",
                    data : data.newNum
                }]
            });
        });
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    }

    function fetchData(cb) {
        // 通过 setTimeout 模拟异步加载
        setTimeout(function() {
            cb({
                days : days,
                newNum : newNum,
            });
        }, 1000);
    }
    function queryOnlineByStatus(value){
        if(value!=null&&value!=""){
            $("#status").val(value);
            $("#stupid").submit();

        }
    }
    function queryOnlineByDevice(value){
        if(value!=null&&value!=""){
            $("#device").val(value);
            $("#stupid").submit();
        }
    }
    function queryOnlineBySex(value){
        if(value!=null&&value!=""){
            $("#sex").val(value);
            $("#stupid").submit();
        }

    }
    function queryOnlineByArea(){

        $("#stupid").submit();
    }




</script>

</body>

