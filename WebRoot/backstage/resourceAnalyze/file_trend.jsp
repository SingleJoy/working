<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<title>资源统计</title>

<!-- jquery库 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/backstage/js/jquery-1.8.2.min.js" charset="utf-8"></script>
<!-- easyui相关库 -->
<link id="easyuiTheme" rel="stylesheet" href="${pageContext.request.contextPath}/backstage/js/jquery-easyui-1.3.1/themes/<c:out value="${cookie.easyuiThemeName.value}" default="default"/>/easyui.css" type="text/css"></link>
<link rel="stylesheet" href="${pageContext.request.contextPath}/backstage/js/jquery-easyui-1.3.1/themes/icon.css" type="text/css"></link>
<script type="text/javascript" src="${pageContext.request.contextPath}/backstage/js/jquery-easyui-1.3.1/jquery.easyui.min.js?v0.1" charset="utf-8"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/backstage/js/jquery-easyui-1.3.1/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/backstage/css/data.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/echarts.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
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


<body>
<div class="main_content">
	<div class="main_head">
		<div class="main_head_content">
			<h3>资源统计
				<a class="download_data_btn" href="${pageContext.request.contextPath}/back_file_analyze/export_file_trend.action?<c:if test="${isDuration==0}">startTime=${startTime}&endTime=${endTime}&</c:if>
                       <c:if test="${isDuration==1}">days=${days}&</c:if>timeUnit=${timeUnit}&logType=${logType}&compare=${compare}">
					<img src="${pageContext.request.contextPath}/frontstage/images/read_download.png">&nbsp;&nbsp;导出数据
				</a> 

			</h3>
			<form id="stupid" action="${pageContext.request.contextPath}/back_file_analyze/to_file_trend.action">
				<input type="hidden" name="compare" id="compare" value="${compare}">
				<br/>
				<div class="time">
					<div class="choose_date_01">
						<span>时间：</span>
						<input type="hidden" name="timeType" id="timeType" value="${timeType}">
						<a onclick="queryTrendByTimeType('0');" class="<c:if test="${timeType=='0'}">active</c:if>" href="javascript:void(0);">今天</a>
						<a onclick="queryTrendByTimeType('1');" class="<c:if test="${timeType=='1'}">active</c:if>" href="javascript:void(0);">昨天</a>
						<a onclick="queryTrendByTimeType('2');" class="<c:if test="${timeType=='2'}">active</c:if>" href="javascript:void(0);">最近7天</a>
						<a onclick="queryTrendByTimeType('3');" class="<c:if test="${timeType=='3'}">active</c:if>" href="javascript:void(0);" title="截止到今天">最近30天</a>
						时间段<input type="checkbox"  onchange="doDuration(this)" <c:if test="${isDuration!='1'&&timeType!='0'&&timeType!='1'}">checked="checked"</c:if>  value="0">
						<input id="isDuration" type="hidden" value="${isDuration}" name="isDuration">
					</div>

					<div id="single" class="select_time"  style="<c:if test="${isDuration!='1'&&timeType!='0'&&timeType!='1'}">display: none;</c:if>">
						<span><input id="days" name="days" <c:if test="${!empty days&&days!='undefined'}">value="${days}"</c:if> class="easyui-datebox" data-options="onSelect:onSelect,editable:false" style="width: 100px;" /></span>
					</div>

					<div id="duration" class="select_time" style="<c:if test="${isDuration!='0'&&timeType!='2'&&timeType!='3'}">display: none;</c:if>">
						<span>开始日期：<input id="startTime" name="startTime" <c:if test="${!empty startTime&&startTime!='undefined'}">value="${startTime}"</c:if> class="easyui-datebox" data-options="onSelect:onSelect,editable:false" style="width: 100px;" /></span>
						<span>结束日期：<input id="endTime" name="endTime" <c:if test="${!empty endTime&&endTime!='undefined'}">value="${endTime}"</c:if> class="easyui-datebox" data-options="onSelect:onSelect,editable:false"  style="width: 100px;"/></span>
					</div>

					<div class="choose_date_01">
						<input type="hidden" name="timeUnit" id="timeUnit" value="${timeUnit}">
						<input type="hidden" name="inactive" id="inactive" value="${inactive}">
						<a class="<c:if test="${timeUnit=='0'}">active</c:if>" onclick="queryTrendByTimeUnit(this,'0');" href="javascript:void(0);" title="根据小时统计">按时</a>
						<a class="<c:if test="${timeUnit=='1'}">active</c:if>" onclick="queryTrendByTimeUnit(this,'1');" href="javascript:void(0);" title="根据天统计">按天</a>
						<a class="<c:if test="${timeType!='3'&&inactive=='0'}">inactive</c:if><c:if test="${timeUnit=='2'}">active</c:if>" onclick="queryTrendByTimeUnit(this,'2');" href="javascript:void(0);" title="根据周统计">按周</a>
						<a class="<c:if test="${timeType!=''||isDuration=='1'||inactive=='0'||inactive=='1'}">inactive</c:if><c:if test="${timeUnit=='3'}">active</c:if>"
						   onclick="queryTrendByTimeUnit(this,'3');" href="javascript:void(0);" title="根据月统计">按月
						</a>
					</div>


				</div>
				<br/>
				<br/>
				<div class="time">
					<div class="choose_date_01">
						<span>指标：</span>
						<input type="hidden" name="logType" id="logType" value="${logType}">
						<a onclick="queryTrendBylogType('0');" class="<c:if test="${fn:contains(logType,'0')==true}">active</c:if>" href="javascript:void(0);">下载量</a>
						<a onclick="queryTrendBylogType('1');" class="<c:if test="${fn:contains(logType,'1')==true}">active</c:if>" href="javascript:void(0);">收藏量</a>
					    <a onclick="queryTrendBylogType('2');" class="<c:if test="${fn:contains(logType,'2')==true}">active</c:if>" href="javascript:void(0);">点击浏览量</a>
						<a onclick="queryTrendBylogType('3');" class="<c:if test="${fn:contains(logType,'3')==true}">active</c:if>" href="javascript:void(0);">购买量</a>
						<a onclick="queryTrendBylogType('4');" class="<c:if test="${fn:contains(logType,'4')==true}">active</c:if>" href="javascript:void(0);">上传数量</a>
					</div>
				</div>
				<br/>

			</form>
		</div>

	</div>

	<div class="main_body">

		<div class="time user_info">
			<div>

				<span  title="资源下载次数">下载次数</span><br/>

				<label class="number" id="downLoadNum"></label>
			</div>
			<div>
				<span  title="资源收藏次数">收藏次数</span><br/>
				<label class="number" id="collectionNum"></label>
			</div>
			<div>

				<span title="用户点击次数">点击次数</span><br/>

				<label class="number" id="clickNum"></label>
			</div>
			<div >

				<span title="资源购买次数">购买次数</span> <br/>

				<label class="number" id="buyNum"></label>
			</div>
			<div >

				<span title="资源上传次数">上传次数</span> <br/>

				<label class="number" id="uploadNum"></label>
			</div>
		</div><br/><br/>

		<div class="fold_open"></div>

		<div id="data_title">趋势图</div>

		<div  style="margin-bottom: 50px;clear: both;margin-left: 20px;" id="data_pic">
			<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
			<div id="usertrend" style="width: 1080px;height:350px;margin-top: 30px;margin-left:-84px;clear: both;"></div>


			<div id="compares" class="choose_date_01 " style="clear: both;<c:if test="${timeType=='2'||timeType=='3'||isDuration=='0'}">display:none</c:if>" >
				<div class="compare_info">
					<span>对比:</span>
					<div><input type="checkbox" <c:if test="${compare=='0'}">checked="checked"</c:if> onclick="compare0(this);" value="0">&nbsp;&nbsp;前一日</div>
					<div><input type="checkbox" <c:if test="${compare=='1'}">checked="checked"</c:if> onclick="compare0(this);" value="1">&nbsp;&nbsp;上一周期</div>
				</div>
			</div>


		</div>

		<div class="fold_close"></div>

		<div class="time" style="clear: both;margin-top: 50px;">
			<table class="table_sta">
				<thead>
				<tr>
					<th>日期</th>
					<th title="资源下载次数">下载量</th>
					<th title="资源收藏次数">收藏量</th>
					<th title="用户点击次数">点击浏览量</th>
					<th title="资源购买次数">购买量</th>
					<th title="资源上传次数">上传数量</th>
				</tr>

				</thead>
				<tbody id="databody">
				</tbody>
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
    var days = new Array();
    var newNum1 = new Array();
    var newNum2 = new Array();
    var newNum3 = new Array();
    var newNum4 = new Array();
    var newNum5 = new Array();
    var downLoadNum = new Array();
    var collectionNum = new Array();
    var clickNum = new Array();
    var buyNum = new Array();
    var uploadNum = new Array();
    $(function(){
        $.ajax({
            type : 'POST',
            async :false,
            url : '${pageContext.request.contextPath}/back_file_analyze/query_file_trend.action',
            data :{
                timeType : "${timeType}",
                isDuration : "${isDuration}",
                days : "${days}",
                startTime : "${startTime}",
                endTime : "${endTime}",
                timeUnit : "${timeUnit}",
                logType : "${logType}",
                compare : "${compare}"
            },
            dataType : 'json',
            success : function(d) {
                var list = d.fileStatsList;
                var tbody = "";
                var sumdownLoadNum = 0;
                var sumcollectionNum = 0;
                var sumclickNum = 0;
                var sumbuyNum = 0;
                var sumuploadNum = 0;
                var logType = "${logType}";
                for(var i=0;i<list.length;i++){
                    days[i] = list[i].days;
                    downLoadNum[i] = list[i].downLoadNum;
                    collectionNum[i] = list[i].collectionNum;
                    clickNum[i] = list[i].clickNum;
                    buyNum[i] = list[i].buyNum;
                    uploadNum[i] = list[i].uploadNum;
                    newNum2[i] = list[i].newNum2;
                    sumdownLoadNum += list[i].downLoadNum;
                    sumcollectionNum += list[i].collectionNum;
                    sumclickNum += list[i].clickNum;
                    sumbuyNum += list[i].buyNum;
                    sumuploadNum += list[i].uploadNum;
                    if("${timeUnit}"==0){
                        tbody += '<tr><td>'+list[i].days+':00-'+list[i].days+':59</td><td>'+list[i].downLoadNum+'</td><td>'+list[i].collectionNum+'</td><td>'+list[i].clickNum+'</td><td>'+list[i].buyNum+'</td><td>'+list[i].uploadNum+'</td></tr>';
                    }else if("${timeUnit}"==2){
                        if(i<list.length-1){
                            var monday = new Date(list[i+1].days);
                            monday.setDate(monday.getDate()-1);//设置天数 -1 天
                            var sunday = monday.Format("yyyy-MM-dd");
                            tbody += '<tr><td>'+list[i].days+'～'+sunday+'</td><td>'+list[i].downLoadNum+'</td><td>'+list[i].collectionNum+'</td><td>'+list[i].clickNum+'</td><td>'+list[i].buyNum+'</td><td>'+list[i].uploadNum+'</td></tr>';
                        }else if(i==list.length-1){
                            tbody += '<tr><td>'+list[i].days+'～${endTime}</td><td>'+list[i].downLoadNum+'</td><td>'+list[i].collectionNum+'</td><td>'+list[i].clickNum+'</td><td>'+list[i].buyNum+'</td><td>'+list[i].uploadNum+'</td></tr>';
                        }
                    }else if("${timeUnit}"==3){
                        if(i<list.length-1){
                            var day = new Date(list[i].days);
                            var lastday = getLastDay(day.getFullYear(),day.getMonth()).Format("yyyy-MM-dd");
                            tbody += '<tr><td>'+list[i].days+'～'+lastday+'</td><td>'+list[i].downLoadNum+'</td><td>'+list[i].collectionNum+'</td><td>'+list[i].clickNum+'</td><td>'+list[i].buyNum+'</td><td>'+list[i].uploadNum+'</td></tr>';
                        }else if(i==list.length-1){
                            tbody += '<tr><td>'+list[i].days+'～${endTime}</td><td>'+list[i].downLoadNum+'</td><td>'+list[i].collectionNum+'</td><td>'+list[i].clickNum+'</td><td>'+list[i].buyNum+'</td><td>'+list[i].uploadNum+'</td></tr>';
                        }
                    }else{
                        tbody += '<tr><td>'+list[i].days+'</td><td>'+list[i].downLoadNum+'</td><td>'+list[i].collectionNum+'</td><td>'+list[i].clickNum+'</td><td>'+list[i].buyNum+'</td><td>'+list[i].uploadNum+'</td></tr>';
                    }

                }
                if(logType.length>0){
                	if(logType.charAt(0)=="0"){
                		newNum1 = downLoadNum;
                	}else if(logType.charAt(0)=="1"){
                		newNum1 = collectionNum;
                	}else if(logType.charAt(0)=="2"){
                		newNum1 = clickNum;
                	}else if(logType.charAt(0)=="3"){
                		newNum1 = buyNum;
                	}else if(logType.charAt(0)=="4"){
                		newNum1 = uploadNum;
                	}
                }
                if(logType.length>2){
                    if(logType.charAt(2)=="1"){
                    	newNum2 = collectionNum;
                	}else if(logType.charAt(2)=="2"){
                		newNum2 = clickNum;
                	}else if(logType.charAt(2)=="3"){
                		newNum2 = buyNum;
                	}else if(logType.charAt(2)=="4"){
                		newNum2 = uploadNum;
                	}
                }
                if(logType.length>4){
                	if(logType.charAt(4)=="2"){
                		newNum3 = clickNum;
                	}else if(logType.charAt(4)=="3"){
                		newNum3 = buyNum;
                	}else if(logType.charAt(4)=="4"){
                		newNum3 = uploadNum;
                	}
                }
                if(logType.length>6){
                	if(logType.charAt(6)=="3"){
                		newNum4 = buyNum;
                	}else if(logType.charAt(6)=="4"){
                		newNum4 = uploadNum;
                	}
                }
                if(logType.length>8){
                	if(logType.charAt(8)=="4"){
                		newNum5 = uploadNum;
                	}
                }
                tbody += '<tr><td>汇总</td><td>'+sumdownLoadNum+'</td><td>'+sumcollectionNum+'</td><td>'+sumclickNum+'</td><td>'+sumbuyNum+'</td><td>'+sumuploadNum+'</td></tr>';
                $("#downLoadNum").html(sumdownLoadNum);
                $("#collectionNum").html(sumcollectionNum);
                $("#clickNum").html(sumclickNum);
                $("#buyNum").html(sumbuyNum);
                $("#uploadNum").html(sumuploadNum);
                $("#databody").html(tbody);
            }
        });
    });
    function getLastDay(year,month) {
        var new_year = year;    //取当前的年份
        var new_month = month++;//取下一个月的第一天，方便计算（最后一天不固定）
        if(month>12) {
            new_month -=12;        //月份减
            new_year++;            //年份增
        }
        var new_date = new Date(new_year,new_month,1);                //取当年当月中的第一天
        return (new Date(new_date.getTime()-1000*60*60*24));//获取当月最后一天日期
    }
    //基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('usertrend'));
    if("${logType}".length==9){//有五条线
    	var trend1 = "下载量";
        var trend2 = "收藏量";
        var trend3 = "点击浏览量";
        var trend4 = "购买量";
        var trend5 = "上传量";
        var legendData = [trend1,trend2,trend3,trend4,trend5];
        var seriesData = [{
            name:trend1,
            type:'line',
            smooth:true,
            itemStyle: {normal: {color:'#EE0000',lineStyle:{color:'#EE0000'},areaStyle: {color:'#EE0000'}}},
            data:[]
        },{
            name:trend2,
            type:'line',
            itemStyle: {normal: {color:'#4da7fd',lineStyle:{color:'#4da7fd'},areaStyle: {type: 'default'} }},
            data:[]
        },{
            name:trend3,
            type:'line',
            itemStyle: {normal: {color:'#EEEE00',lineStyle:{color:'#EEEE00'},areaStyle: {type: 'default'} }},
            data:[]
        },{
            name:trend4,
            type:'line',
            itemStyle: {normal: {color:'#191970',lineStyle:{color:'#191970'},areaStyle: {type: 'default'} }},
            data:[]
        },{
            name:trend5,
            type:'line',
            itemStyle: {normal: {color:'#dd70d9',lineStyle:{color:'#dd70d9'},areaStyle: {type: 'default'} }},
            data:[]
        }  ];
        option = {
            tooltip : {
                trigger: 'axis'
            },
            legend: {
                data:legendData
            },
            toolbox: {
                show : true,
                left :'950',
                right: '50',/* toolbox的右边被拉长，使本来被遮住的字体显示出来了 */
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
                    type : 'value'
                }
            ],
            series : seriesData
        };

        myChart.showLoading();
        fetchData(function(data) {
            myChart.hideLoading();
            var seriesFetchData = [{
                // 根据名字对应到相应的系列
                name : trend1,
                data : data.newNum1
            } ,{
                name : trend2,
                data : data.newNum2
            },{
                name : trend3,
                data : data.newNum3
            },{
                name : trend4,
                data : data.newNum4
            } ,{
                name : trend5,
                data : data.newNum5
            }  ];
            myChart.setOption({
                xAxis : {
                    data : data.days
                },
                series : seriesFetchData
            });
        });
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
        function fetchData(cb) {
            // 通过 setTimeout 模拟异步加载
            setTimeout(function() {
                cb({
                    days : days,
                    newNum1 : newNum1,
                    newNum2 : newNum2,
                    newNum3 : newNum3,
                    newNum4 : newNum4,
                    newNum5 : newNum5
                });
            }, 1000);
        }
    }else if("${logType}".length==7){//有四条线
    	var trend1 = "";
        var trend2 = "";
        var trend3 = "";
        var trend4 = "";
        //取第一个trend
        var log1 = "${logType}".charAt(0);
        if(log1=="0"){//下载量
            trend1 = "下载量";
        }else if(log1=="1"){//收藏量
            trend1 = "收藏量";
        }
        //取第二个trend
        var log2 = "${logType}".charAt(2);
        if(log2=="1"){//收藏量
            trend2 = "收藏量";
        }else if(log2=="2"){//点击浏览量
            trend2 = "点击浏览量";
        }
       //取第三个trend
        var log3 = "${logType}".charAt(4);
        if(log3=="2"){//点击浏览量
            trend3 = "点击浏览量";
        }else if(log3=="3"){//购买量
            trend3 = "购买量";
        }
        //取第四个trend
        var log4 = "${logType}".charAt(6);
       if(log4=="3"){//购买量
            trend4 = "购买量";
        }else if(log4=="4"){//上传量
            trend4 = "上传量";
        }
        var legendData = [trend1,trend2,trend3,trend4];
        var seriesData = [{
            name:trend1,
            type:'line',
            smooth:true,
            itemStyle: {normal: {color:'#EE0000',lineStyle:{color:'#EE0000'},areaStyle: {color:'#EE0000'}}},
            data:[]
        },{
            name:trend2,
            type:'line',
            itemStyle: {normal: {color:'#4da7fd',lineStyle:{color:'#4da7fd'},areaStyle: {type: 'default'} }},
            data:[]
        },{
            name:trend3,
            type:'line',
            itemStyle: {normal: {color:'#EEEE00',lineStyle:{color:'#EEEE00'},areaStyle: {type: 'default'} }},
            data:[]
        },{
            name:trend4,
            type:'line',
            itemStyle: {normal: {color:'#191970',lineStyle:{color:'#191970'},areaStyle: {type: 'default'} }},
            data:[]
        }  ];
        option = {
            tooltip : {
                trigger: 'axis'
            },
            legend: {
                data:legendData
            },
            toolbox: {
                show : true,
                left :'950',
                right: '50',/* toolbox的右边被拉长，使本来被遮住的字体显示出来了 */
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
                    type : 'value'
                }
            ],
            series : seriesData
        };

        myChart.showLoading();
        fetchData(function(data) {
            myChart.hideLoading();
            var seriesFetchData = [{
                // 根据名字对应到相应的系列
                name : trend1,
                data : data.newNum1
            } ,{
                name : trend2,
                data : data.newNum2
            },{
                name : trend3,
                data : data.newNum3
            },{
                name : trend4,
                data : data.newNum4
            }  ];
            myChart.setOption({
                xAxis : {
                    data : data.days
                },
                series : seriesFetchData
            });
        });
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
        function fetchData(cb) {
            // 通过 setTimeout 模拟异步加载
            setTimeout(function() {
                cb({
                    days : days,
                    newNum1 : newNum1,
                    newNum2 : newNum2,
                    newNum3 : newNum3,
                    newNum4 : newNum4
                });
            }, 1000);
        }
    }else if("${logType}".length==5){//有三条线
    	var trend1 = "";
        var trend2 = "";
        var trend3 = "";
        //取第一个trend
        var log1 = "${logType}".charAt(0);
        if(log1=="0"){//下载量
            trend1 = "下载量";
        }else if(log1=="1"){//收藏量
            trend1 = "收藏量";
        }else if(log1=="2"){//点击浏览量
            trend1 = "点击浏览量";
        }
        //取第二个trend
        var log2 = "${logType}".charAt(2);
        if(log2=="1"){//收藏量
            trend2 = "收藏量";
        }else if(log2=="2"){//点击浏览量
            trend2 = "点击浏览量";
        }else if(log2=="3"){//购买量
            trend2 = "购买量";
        }
       //取第三个trend
        var log3 = "${logType}".charAt(4);
        if(log3=="2"){//点击浏览量
            trend3 = "点击浏览量";
        }else if(log3=="3"){//购买量
            trend3 = "购买量";
        }else if(log3=="4"){//上传量
            trend3 = "上传量";
        }
        if(trend1!=""&&trend2!=""&&trend3!=""){
        	var legendData = [trend1,trend2,trend3];
            var seriesData = [{
                name:trend1,
                type:'line',
                smooth:true,
                itemStyle: {normal: {color:'#EE0000',lineStyle:{color:'#EE0000'},areaStyle: {color:'#EE0000'}}},
                data:[]
            },{
                name:trend2,
                type:'line',
                itemStyle: {normal: {color:'#4da7fd',lineStyle:{color:'#4da7fd'},areaStyle: {type: 'default'} }},
                data:[]
            },{
                name:trend3,
                type:'line',
                itemStyle: {normal: {color:'#EEEE00',lineStyle:{color:'#EEEE00'},areaStyle: {type: 'default'} }},
                data:[]
            } ];
            option = {
                tooltip : {
                    trigger: 'axis'
                },
                legend: {
                    data:legendData
                },
                toolbox: {
                    show : true,
                    left :'950',
                    right: '50',/* toolbox的右边被拉长，使本来被遮住的字体显示出来了 */
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
                        type : 'value'
                    }
                ],
                series : seriesData
            };

            myChart.showLoading();
            fetchData(function(data) {
                myChart.hideLoading();
                var seriesFetchData = [{
                    // 根据名字对应到相应的系列
                    name : trend1,
                    data : data.newNum1
                } ,{
                    name : trend2,
                    data : data.newNum2
                },{
                    name : trend3,
                    data : data.newNum3
                } ];
                myChart.setOption({
                    xAxis : {
                        data : data.days
                    },
                    series : seriesFetchData
                });
            });
            // 使用刚指定的配置项和数据显示图表。
            myChart.setOption(option);
            function fetchData(cb) {
                // 通过 setTimeout 模拟异步加载
                setTimeout(function() {
                    cb({
                        days : days,
                        newNum1 : newNum1 ,
                        newNum2 : newNum2,
                        newNum3 : newNum3
                    });
                }, 1000);
            }

        }
    }else if("${compare}".length>0||"${logType}".length==3){//有两条线
        var trend1 = "";
        var trend2 = "";
        //取第一个trend
        var log1 = "${logType}".charAt(0);
        if("${compare}".length>0){//比较
            var d = new Date("${days}");
            var compare = "";
            if("${compare}"=="0"){//前一天
                compare = new Date(d.getFullYear(),d.getMonth(),d.getDate()-1).Format("yyyy-MM-dd");
            }else if("${compare}"=="1"){//上一周同期
                compare = new Date(d.getFullYear(),d.getMonth(),d.getDate()-7).Format("yyyy-MM-dd");
            }
            if(log1=="0"){//下载量
                trend1 = "${days}下载量";
                trend2 = compare+"下载量";
            }else if(log1=="1"){//收藏量
                trend1 = "${days}收藏量";
                trend2 = compare+"收藏量";
            }else if(log1=="2"){//点击浏览量
                trend1 = "${days}点击浏览量";
                trend2 = compare+"点击浏览量";
            }else if(log1=="3"){//购买量
                trend1 = "${days}购买量";
                trend2 = compare+"购买量";
            }else if(log1=="4"){//购买量
                trend1 = "${days}上传量";
                trend2 = compare+"上传量";
            }
        }
        if("${logType}".length==3){//两个指标
            if(log1=="0"){//下载量
                trend1 = "下载量";
            }else if(log1=="1"){//收藏量
                trend1 = "收藏量";
            }else if(log1=="2"){//点击浏览量
                trend1 = "点击浏览量";
            }else if(log1=="3"){//点击浏览量
                trend1 = "购买量";
            }
            //取第二个trend
            var log2 = "${logType}".charAt(2);
            if(log2=="1"){//收藏量
                trend2 = "收藏量";
            }else if(log2=="2"){//点击浏览量
                trend2 = "点击浏览量";
            }else if(log2=="3"){//购买量
                trend2 = "购买量";
            }else if(log2=="4"){//上传量
                trend2 = "上传量";
            }
        }
        if(trend1!=""&&trend2!=""){
            var legendData = [trend1,trend2];
            var seriesData = [{
                name:trend1,
                type:'line',
                smooth:true,
                itemStyle: {normal: {color:'#EE0000',lineStyle:{color:'#EE0000'},areaStyle: {color:'#EE0000'}}},
                data:[]
            },{
                name:trend2,
                type:'line',
                itemStyle: {normal: {color:'#4da7fd',lineStyle:{color:'#4da7fd'},areaStyle: {type: 'default'} }},
                data:[]
            } ];
            option = {
                tooltip : {
                    trigger: 'axis'
                },
                legend: {
                    data:legendData
                },
                toolbox: {
                    show : true,
                    left :'950',
                    right: '50',/* toolbox的右边被拉长，使本来被遮住的字体显示出来了 */
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
                        type : 'value'
                    }
                ],
                series : seriesData
            };

            myChart.showLoading();
            fetchData(function(data) {
                myChart.hideLoading();
                var seriesFetchData = [{
                    // 根据名字对应到相应的系列
                    name : trend1,
                    data : data.newNum1
                } ,{
                    name : trend2,
                    data : data.newNum2
                } ];
                myChart.setOption({
                    xAxis : {
                        data : data.days
                    },
                    series : seriesFetchData
                });
            });
            // 使用刚指定的配置项和数据显示图表。
            myChart.setOption(option);
            function fetchData(cb) {
                // 通过 setTimeout 模拟异步加载
                setTimeout(function() {
                    cb({
                        days : days,
                        newNum1 : newNum1 ,
                        newNum2 : newNum2
                    });
                }, 1000);
            }

        }
    }else{
        /* ------------------------------------------------ */
        var trend = "";
        if("${logType}"=="0"){//下载量
            trend = "下载量";
        }else if("${logType}"=="1"){//收藏量
            trend = "收藏量";
        }else if("${logType}"=="2"){//点击浏览量
            trend = "点击浏览量";
        }else if("${logType}"=="3"){//购买量
            trend = "购买量";
        }
        var legendData = [trend];
        var seriesData = [{
            name:trend,
            type:'line',
            smooth:true,
            itemStyle: {normal: {color:'#4da7fd',lineStyle:{color:'#4da7fd'},areaStyle: {type: 'default'}}},
            data:[]
        }];
        option = {
            tooltip : {
                trigger: 'axis'
            },
            legend: {
                data:legendData
            },
            toolbox: {
                show : true,
                left :'950',
                right: '50',/* toolbox的右边被拉长，使本来被遮住的字体显示出来了 */
                feature : {
                    mark : {show: true},
                    /* dataView : {show: true, readOnly: false},  */
                    magicType : {show: true, type: ['line', 'bar'/* , 'stack', 'tiled' */]},
                    /* restore : {show: true}, */
                    /* saveAsImage : {show: true} */
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
            series : seriesData
        };
        myChart.showLoading();
        fetchData(function(data) {
            myChart.hideLoading();
            var seriesFetchData = [{
                // 根据名字对应到相应的系列
                name : trend,
                data : data.newNum1
            }];
            myChart.setOption({
                xAxis : {
                    data : data.days

                },
                series : seriesFetchData
            });
        });
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
        function fetchData(cb) {
            // 通过 setTimeout 模拟异步加载
            setTimeout(function() {
                cb({
                    days : days,
                    newNum1 : newNum1
                });
            }, 1000);
        }

    }

    function queryTrendByTimeType(value){
        $("#timeType").val(value);
        $('input[name="days"]').val("");
        $('input[name="startTime"]').val("");
        $('input[name="endTime"]').val("");
        if(value=="0"||value=="1"){
            $("#isDuration").val("1");
        }else if(value=="2"||value=="3"){
            $("#compare").val("");
            $("#isDuration").val("0");
        }
        if(value!="3"){//不能按周
            var timeUnit = $("#timeUnit").val();
            if(timeUnit=="2"||timeUnit=="3"){//本来按周，默认按时
                $("#timeUnit").val("0");
            }
            $("#inactive").val("0");
        }else{//按月时 inactive和active可能冲突
            var timeUnit = $("#timeUnit").val();
            if(timeUnit=="3"){//按月，默认按时
                $("#timeUnit").val("0");
            }
        }
        $("#stupid").submit();
    }
    function doDuration(obj){
        isDuration = obj.checked;
        if(isDuration){//是时间段
            $("#compare").val("");
            $("#compares").hide();
            $("#duration").show();
            $("#single").hide();
            $("input[name='isDuration']").val(0);
        }else if(!isDuration){//是单一时间
            $("#startTime").val("");//没用
            $("#endTime").val("");//没用
            /* $("#compares").show(); */
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
            $("#inactive").val("0");
            $("#timeUnit").val("0");
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
                    if(days2<32){//月变灰
                        $("#inactive").val("1");
                        if(days2<8){//周变灰
                            $("#inactive").val("0");
                        }
                    }else{//月不灰
                        $("#inactive").val("");
                    }
                    $("#stupid").submit();
                }else{
                    $("#startTime").datebox('setValue','');
                    $("#endTime").datebox('setValue','');
                    parent.sy.messagerShow({
                        msg : "开始时间必须小于结束时间！！",
                        title : '提示'
                    });
                }
            }
        }

    }
    function queryTrendByTimeUnit(obj,value){
        if(value!=null&&value!=""){
            var aclass  =  obj.className;
            if(aclass!="inactive"){//可以点击
                $("#timeUnit").val(value);
                var timeType = $("#timeType").val();
                if(timeType!=""){
                    if(timeType!="3"){//不是最近30天
                        $("#inactive").val("0");
                    }
                }
                $("#stupid").submit();
            }
        }
    }
    function queryTrendBylogType(value){
        if(value!=null&&value!=""){
            var logTypes = "${logType}".split(",");
            if(logTypes.indexOf(value) >= 0){//存在-->删除
                logTypes.splice(logTypes.indexOf(value),1);
            }else{//不存在-->添加
                logTypes.push(value);
            }
            if(logTypes.length==0){//不能都删掉，至少留一个
                logTypes.push(value);
            }
            if("${compare}"!=""){//compare存在时，只能选一个，
                if(logTypes.length>1){//有两个指标，选择最后选择的指标
                    logTypes.splice(0,logTypes.length);
                    logTypes.push(value);
                }
            }
            var logType = logTypes.sort().join(",");
            $("#logType").val(logType);
            var timeType = $("#timeType").val();
            if(timeType!=""){
                if(timeType!="3"){//不是最近30天
                    $("#inactive").val("0");
                }
            }
            $("#stupid").submit();
        }
    }
    function compare0(obj){
        if(obj.checked==true){
            $("#compare").val(obj.value);
            var log = $("#logType").val();
            $("#logType").val(log.substr(0,1));
        }else{
            $("#compare").val("");
        }
        var timeType = $("#timeType").val();
        if(timeType!=""){
            if(timeType!="3"){//不是最近30天
                $("#inactive").val("0");
            }
        }
        $("#stupid").submit();
    }

</script>

</body>

