<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


	<title>新用户留存分析</title>

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
        var options = '<option  value="0">全部</option>';
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
        /* $("#days").datebox().datebox('calendar').calendar({
          	 validator:function(date){
          		 if(data>new Date()){
          			 return false;
          		 }else{
          			 return true;
          		 }
          	 }
      	        
      }); */


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
		<h3>新用户留存分析
			<a class="download_data_btn" href="${pageContext.request.contextPath}/back_user/export_user_remain.action?timeType=${timeType}&days=${days}&startTime=${startTime}&endTime=${endTime}&timeUnit=${timeUnit}&device=${device}&province_id=<c:if test="${empty province_id}">0</c:if>
               <c:if test="${!empty province_id}">${province_id}</c:if>&logType=${logType}&compare=${compare}" >
				<img src="${pageContext.request.contextPath}/frontstage/images/read_download.png">&nbsp;&nbsp;导出数据
			</a>
		</h3>

			<form id="stupid" action="${pageContext.request.contextPath}/back_user/to_user_remain.action">
				<input type="hidden" name="compare" id="compare" value="${compare}">
				<br/>
				<div class="time">
					<div class="choose_date_01">
						<span>时间：</span>
						<input type="hidden" name="timeType" id="timeType" value="${timeType}">
						<a onclick="queryTrendByTimeType(0);" class="<c:if test="${timeType=='0'}">active</c:if>" href="javascript:void(0);">次日</a>
						<a onclick="queryTrendByTimeType(1);" class="<c:if test="${timeType=='1'}">active</c:if>" href="javascript:void(0);">三日</a>
						<a onclick="queryTrendByTimeType(2);" class="<c:if test="${timeType=='2'}">active</c:if>" href="javascript:void(0);">七日</a>
						<a onclick="queryTrendByTimeType(3);" class="<c:if test="${timeType=='3'}">active</c:if>" href="javascript:void(0);">30天</a>
					</div>

					<div id="single" class="select_time" >
						<span><input id="days" name="days" <c:if test="${!empty days&&days!='undefined'}">value="${days}"</c:if> class="easyui-datebox" data-options="onSelect:onSelect,editable:false" style="width: 100px;" /></span>
						<input type="hidden" name="startTime" id="startTime" value="${startTime}">
						<input type="hidden" name="endTime" id="endTime" value="${endTime}">
					</div>
					<div class="choose_date_01">
						<input type="hidden" name="sex" id="sex" value="${sex}">
						<span>性别：</span>
						<a class="<c:if test="${sex=='0'}">active</c:if>" onclick="queryTrendBySex('0');" href="javascript:void(0);">全部</a>
						<a class="<c:if test="${sex=='1'}">active</c:if>" onclick="queryTrendBySex('1');" href="javascript:void(0);">男</a>
						<a class="<c:if test="${sex=='2'}">active</c:if>" onclick="queryTrendBySex('2');" href="javascript:void(0);">女</a>
					</div>
					<div class="choose_date_01">
						<input type="hidden" name="timeUnit" id="timeUnit" value="${timeUnit}">
						<span>类别：</span>
						<a class="<c:if test="${timeUnit=='0'}">active</c:if>" onclick="queryTrendByTimeUnit('0');" href="javascript:void(0);">区间</a>
						<a class="<c:if test="${timeUnit=='1'}">active</c:if>" onclick="queryTrendByTimeUnit('1');" href="javascript:void(0);">点日</a>

					</div>



				</div>
				<br/>
				<br/>

				<div class="time">

					<c:if test=""></c:if>
					<div class="choose_date_01">
						<span>设备：</span>
						<input type="hidden" name="device" id="device" value="${device}">
						<a onclick="queryTrendByDevice('-1');" class="<c:if test="${device=='-1'}">active</c:if>" href="javascript:void(0);">全部</a>
						<a onclick="queryTrendByDevice('0');" class="<c:if test="${device=='0'}">active</c:if>" href="javascript:void(0);">PC端</a>
						<a onclick="queryTrendByDevice('1');" class="<c:if test="${device=='1'}">active</c:if>" href="javascript:void(0);">移动端</a>
					</div>
					<div class="choose_date_01 ">
						<span  title="包括省、直辖市、自治区">地域：</span>
						<span class="choose_area">
	                    <select id="province" onchange="queryTrendByArea();" name="province" style="height:25px;padding: 2px;">
	                    </select>
	                </span>
					</div>
				</div>
				<br/>
				<br/>
				<div class="time">
					<div class="choose_date_01">
						<span>指标：</span>
						<input type="hidden" name="logType" id="logType" value="${logType}">
						<a onclick="queryTrendBylogType('0');" class="<c:if test="${fn:contains(logType,'0')==true}">active</c:if>" href="javascript:void(0);" title="注册用户登录数量">留存数</a>
						<a onclick="queryTrendBylogType('1');" class="<c:if test="${fn:contains(logType,'1')==true}">active</c:if>" href="javascript:void(0);" title="登录数/注册总数">留存率</a>
						<a onclick="queryTrendBylogType('2');" class="<c:if test="${fn:contains(logType,'2')==true}">active</c:if>" href="javascript:void(0);" title="未登录用户数">流失数</a>
						<a onclick="queryTrendBylogType('3');" class="<c:if test="${fn:contains(logType,'3')==true}">active</c:if>" href="javascript:void(0);" title="未登录用户数/注册总数">流失率</a>
					</div>
				</div>
				<br/>

			</form>
		</div>
	</div>
	<div class="main_body">


		<div class="time user_info">
			<div>
				<span>留存数</span><br/>
				<label class="number" id="addUserNum"></label>
			</div>
			<div>
				<span>留存率</span><br/>
					<label class="number" id="loginUserNum"></label>
			</div>
			<div>
				<span>流失数</span><br/>
					<label class="number" id="collectmeanVisit"></label>
			</div>
			<div>
				<span>流失率 </span><br/>
				<label class="number" id="collectmeanNewVisit"></label>
			</div>
		</div><br/><br/>
		
		<div class="fold_open"></div>

		<div id="data_title">趋势图</div>

		<div  style="margin-bottom: 50px;clear: both;margin-left: 20px;" id="data_pic">
			<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
			<div id="usertrend" style="width: 1080px;height:350px;margin-top: 30px;margin-left:-84px;clear: both;"></div>



			<div id="compares" class="choose_date_01 " style="clear: both;<c:if test="${timeType=='2'||timeType=='3'}">display:none</c:if>" >
				<div class="compare_info">
					<span>对比:</span>
					<div><input type="checkbox" <c:if test="${compare=='0'}">checked="checked"</c:if> onclick="compare0(this);" value="0">&nbsp;&nbsp;前一日</div>
					<div><input type="checkbox" <c:if test="${compare=='1'}">checked="checked"</c:if> onclick="compare0(this);" value="1">&nbsp;&nbsp;上一周期</div>
				</div>
			</div>


		</div>
		<div class="fold_close"></div>


		<br>
		<br>
		<br>


		<div class="time" style="clear: both;">
			<table class="table_sta" >
				<thead>
				<tr>
					<th>日期</th>
					<th >留存数</th>
					<th >留存率</th>
					<th> 流失数</th>
					<th> 流失率</th>
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
    $(function(){
        $.ajax({
            type : 'POST',
            async :false,
            url : '${pageContext.request.contextPath}/back_user/query_user_remain.action',
            data :{
                timeType : "${timeType}",
                days : "${days}",
                startTime : "${startTime}",
                endTime : "${endTime}",
                sex : "${sex}",
                timeUnit : "${timeUnit}",
                device : "${device}",
                province_id : "${province}",
                logType : "${logType}",
                compare : "${compare}"
            },
            dataType : 'json',
            success : function(d) {
                var list = d.userStatsList;
                var tbody = "";
                for(var i=0;i<list.length;i++){
                    days[i] = list[i].days;
                    if("${logType}".length==1||"${logType}".length==3){
                    	newNum1[i] = list[i].newNum1;
                        newNum2[i] = list[i].newNum2;
                    }else if("${logType}".length==5){
                    	var log1 = "${logType}".charAt(0);
                    	var log2 = "${logType}".charAt(2);
                    	var log3 = "${logType}".charAt(4);
                    	if(log1=='0'){
                    		newNum1[i] = list[i].newNum;
                    		newNum2[i] = list[i].remainRatio;
                    		if(log3=='2'){
                    			newNum3[i] = list[i].lossNum;
                    		}else{
                    			newNum3[i] = list[i].lossRatio;
                    		}
                    	}else if(log1=='1'){
                    		newNum1[i] = list[i].remainRatio;
                    		newNum2[i] = list[i].lossNum;
                    		newNum3[i] = list[i].lossRatio;
                    	}
                    }else if("${logType}".length==7){
                    	newNum1[i] = list[i].newNum;
                		newNum2[i] = list[i].remainRatio;
                		newNum3[i] = list[i].lossNum;
                		newNum4[i] = list[i].lossRatio;
                    }
                    
                    
                    if(list.length>1&&i>0&&("${timeType}"==0||i<list.length-1)){
                    	tbody += '<tr><td>'+list[i].days+'</td><td>'+list[i].newNum+'</td><td>'+list[i].remainRatio+'%</td><td>'+list[i].lossNum+'</td><td>'+list[i].lossRatio+'%</td></tr>';
                    }else if(list.length==1){
                    	tbody += '<tr><td>'+list[0].days+'</td><td>'+list[0].newNum+'</td><td>'+list[0].remainRatio+'%</td><td>'+list[0].lossNum+'</td><td>'+list[0].lossRatio+'%</td></tr>';
                    }
                    
                }
                tbody += '<tr><td>汇总</td><td>'+list[list.length-1].newNum+'</td><td>'+list[list.length-1].remainRatio+'%</td><td>'+list[list.length-1].lossNum+'</td><td>'+list[list.length-1].lossRatio+'%</td></tr>';
                $("#addUserNum").html(list[list.length-1].newNum);
                $("#loginUserNum").html(list[list.length-1].remainRatio+"%");
                $("#collectmeanVisit").html(list[list.length-1].lossNum);
                $("#collectmeanNewVisit").html(list[list.length-1].lossRatio+"%");
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
    if("${logType}".length==7){
    	var trend1 = "留存数";
    	var trend2 = "留存率";
    	var trend3 = "流失数";
    	var trend4 = "流失率";
    	var seriesData1 = {name:trend1,type:'line',itemStyle: {normal: {color:'#4da7fd',lineStyle:{color:'#4da7fd'},areaStyle: {type: 'default'}}},data:[]};
        var seriesData2 = {name:trend2,type:'line',smooth:true,yAxisIndex:1,itemStyle: {normal: {color:'#EE0000',lineStyle:{color:'#EE0000'},areaStyle: {type: '#EE0000',formatter:'{c1}%'} }},data:[]};
        var seriesData3 = {name:trend3,type:'line',itemStyle: {normal: {color:'#EEEE00',lineStyle:{color:'#EEEE00'},areaStyle: {type: 'default'}}},data:[]};
        var seriesData4 = {name:trend4,type:'line',smooth:true,yAxisIndex:1,itemStyle: {normal: {color:'#191970',lineStyle:{color:'#191970'},areaStyle: {type: '#191970',formatter:'{c3}%'} }},data:[]};
        var formatters = '{b}<br/><span style="display:inline-block;margin-right:5px;border-radius:10px;width:9px;height:9px;background-color:#4da7fd"></span>{a0}:{c0}<br/><span style="display:inline-block;margin-right:5px;border-radius:10px;width:9px;height:9px;background-color:#EE0000"></span>{a1}:{c1}%<br/><span style="display:inline-block;margin-right:5px;border-radius:10px;width:9px;height:9px;background-color:#EEEE00"></span>{a2}:{c2}<br/><span style="display:inline-block;margin-right:5px;border-radius:10px;width:9px;height:9px;background-color:#191970"></span>{a3}:{c3}%';
        var yAxis0 =  [{type: 'value'},{type: 'value',axisLabel: {show: true,interval: 'auto',formatter: '{value}%'}},{type: 'value'},{type: 'value',axisLabel: {show: true,interval: 'auto',formatter: '{value}%'}}];
        var legendData = [trend1,trend2,trend3,trend4];
    	var seriesData = [seriesData1,seriesData2,seriesData3,seriesData4];
        option = {
            tooltip : {
                trigger: 'axis',
                axisPointer: {
		            type: 'cross',
		            animation: false,
		            label: {
		                backgroundColor: '#505765'
		            }
		        },
		        formatter : formatters
            },
            legend: {
                data:legendData
            },
            toolbox: {
                show : true,
                left :'950',
                right: '50',// toolbox的右边被拉长，使本来被遮住的字体显示出来了 
                feature : {
                    mark : {show: true},
                    magicType : {show: true, type: ['line', 'bar']}
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
            yAxis : yAxis0,
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
            } ,{
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
    }else if("${logType}".length==5){
    	var trend1 = "留存数";
    	var trend2 = "留存率";
    	var trend3 = "流失数";
    	var seriesData1 = {name:trend1,type:'line',itemStyle: {normal: {color:'#4da7fd',lineStyle:{color:'#4da7fd'},areaStyle: {type: 'default'}}},data:[]};
        var seriesData2 = {name:trend2,type:'line',smooth:true,yAxisIndex:1,itemStyle: {normal: {color:'#EE0000',lineStyle:{color:'#EE0000'},areaStyle: {type: '#EE0000',formatter:'{c}%'} }},data:[]};
        var seriesData3 = {name:trend3,type:'line',itemStyle: {normal: {color:'#EEEE00',lineStyle:{color:'#EEEE00'},areaStyle: {type: 'default'}}},data:[]};
        var formatters = '{b}<br/><span style="display:inline-block;margin-right:5px;border-radius:10px;width:9px;height:9px;background-color:#4da7fd"></span>{a0}:{c0}<br/><span style="display:inline-block;margin-right:5px;border-radius:10px;width:9px;height:9px;background-color:#EE0000"></span>{a1}:{c1}%<br/><span style="display:inline-block;margin-right:5px;border-radius:10px;width:9px;height:9px;background-color:#EEEE00"></span>{a2}:{c2}';
        var yAxis0 =  [{type: 'value'},{type: 'value',axisLabel: {show: true,interval: 'auto',formatter: '{value}%'}},{type: 'value'}];
        if("${logType}"=="0,1,3"){
    		trend1 = "留存数";
        	trend2 = "留存率";
        	trend3 = "流失率";
        	seriesData1 = {name:trend1,type:'line',itemStyle: {normal: {color:'#4da7fd',lineStyle:{color:'#4da7fd'},areaStyle: {type: 'default'}}},data:[]};
            seriesData2 = {name:trend2,type:'line',smooth:true,yAxisIndex:1,itemStyle: {normal: {color:'#EE0000',lineStyle:{color:'#EE0000'},areaStyle: {type: '#EE0000',formatter:'{c}%'} }},data:[]};
            seriesData3 = {name:trend3,type:'line',smooth:true,yAxisIndex:1,itemStyle: {normal: {color:'#EEEE00',lineStyle:{color:'#EEEE00'},areaStyle: {type: '#EEEE00',formatter:'{c}%'} }},data:[]};
            formatters = '{b}<br/><span style="display:inline-block;margin-right:5px;border-radius:10px;width:9px;height:9px;background-color:#4da7fd"></span>{a0}:{c0}<br/><span style="display:inline-block;margin-right:5px;border-radius:10px;width:9px;height:9px;background-color:#EE0000"></span>{a1}:{c1}%<br/><span style="display:inline-block;margin-right:5px;border-radius:10px;width:9px;height:9px;background-color:#EEEE00"></span>{a2}:{c2}%';
            yAxis0 =  [{type: 'value'},{type: 'value',axisLabel: {show: true,interval: 'auto',formatter: '{value}%'}},{type: 'value',axisLabel: {show: true,interval: 'auto',formatter: '{value}%'}}];
    	}else if("${logType}"=="1,2,3"){
    		trend1 = "留存率";
        	trend2 = "流失数";
        	trend3 = "流失率";
            seriesData1 = {name:trend1,type:'line',smooth:true,yAxisIndex:1,itemStyle: {normal: {color:'#4da7fd',lineStyle:{color:'#4da7fd'},areaStyle: {type: '#4da7fd',formatter:'{c}%'} }},data:[]};
            seriesData2 = {name:trend2,type:'line',itemStyle: {normal: {color:'#EE0000',lineStyle:{color:'#EE0000'},areaStyle: {color:'#EE0000'}}},data:[]};
            seriesData3 = {name:trend3,type:'line',smooth:true,yAxisIndex:1,itemStyle: {normal: {color:'#EEEE00',lineStyle:{color:'#EEEE00'},areaStyle: {type: '#EEEE00',formatter:'{c}%'} }},data:[]};
            formatters = '{b}<br/><span style="display:inline-block;margin-right:5px;border-radius:10px;width:9px;height:9px;background-color:#4da7fd"></span>{a0}:{c0}%<br/><span style="display:inline-block;margin-right:5px;border-radius:10px;width:9px;height:9px;background-color:#EE0000"></span>{a1}:{c1}<br/><span style="display:inline-block;margin-right:5px;border-radius:10px;width:9px;height:9px;background-color:#EEEE00"></span>{a2}:{c2}%';
            yAxis0 =  [{type: 'value',axisLabel: {show: true,interval: 'auto',formatter: '{value}%'}},{type: 'value'},{type: 'value',axisLabel: {show: true,interval: 'auto',formatter: '{value}%'}}];
    	}
    	var legendData = [trend1,trend2,trend3];
    	var seriesData = [seriesData1,seriesData2,seriesData3];
        option = {
            tooltip : {
                trigger: 'axis',
                axisPointer: {
		            type: 'cross',
		            animation: false,
		            label: {
		                backgroundColor: '#505765'
		            }
		        },
		        formatter : formatters
            },
            legend: {
                data:legendData
            },
            toolbox: {
                show : true,
                left :'950',
                right: '50',// toolbox的右边被拉长，使本来被遮住的字体显示出来了 
                feature : {
                    mark : {show: true},
                    magicType : {show: true, type: ['line', 'bar']}
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
            yAxis : yAxis0,
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
            } ,{
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
                    newNum1 : newNum1,
                    newNum2 : newNum2,
                    newNum3 : newNum3
                });
            }, 1000);
        }

    }else if("${compare}".length>0||"${logType}".length==3){//有两条线 两个指标 或一个指标和比较
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
            if(log1=="0"){//留存数
                trend1 = "${days}新增用户留存数";
                trend2 = compare+"新增用户留存数";
            }else if(log1=="1"){//留存率
                trend1 = "${days}新增用户留存率";
                trend2 = compare+"新增用户留存率";
            }else if(log1=="2"){//流失数
                trend1 = "${days}新增用户流失数";
                trend2 = compare+"新增用户流失数";
            }else if(log1=="3"){//流失率
                trend1 = "${days}新增用户流失率";
                trend2 = compare+"新增用户流失率";
            }
        }
        if("${logType}".length==3){//两个指标
            if(log1=="0"){//留存数
                trend1 = "留存数";
            }else if(log1=="1"){//留存率
                trend1 = "留存率";
            }else if(log1=="2"){//流失数
                trend1 = "流失数";
            }
            //取第二个trend
            var log2 = "${logType}".charAt(2);
            if(log2=="1"){//留存率
                trend2 = "留存率";
            }else if(log2=="2"){//流失数
                trend2 = "流失数";
            }else if(log2=="3"){//流失率
                trend2 = "流失率";
            }
        }
        if(trend1!=""&&trend2!=""){
            var legendData = [trend1,trend2];
            var seriesData1 = {name:trend1,type:'line',itemStyle: {normal: {color:'#4da7fd',lineStyle:{color:'#4da7fd'},areaStyle: {color:'#4da7fd'}}},data:[]};
            var seriesData2 = {name:trend2,type:'line',smooth:true,yAxisIndex:1,itemStyle: {normal: {color:'#EE0000',lineStyle:{color:'#EE0000'},areaStyle: {type: '#EE0000',formatter:'{c}%'} }},data:[]};
            var formatters = "";
            var yAxis0 = [{type : 'value'}];
            if("${logType}"=="0,1"||"${logType}"=="0,3"||"${logType}"=="2,3"){//数 率
            	formatters = '{b}<br/><span style="display:inline-block;margin-right:5px;border-radius:10px;width:9px;height:9px;background-color:#4da7fd"></span>{a0}:{c0}<br/><span style="display:inline-block;margin-right:5px;border-radius:10px;width:9px;height:9px;background-color:#EE0000"></span>{a1}:{c1}%';
            	yAxis0 =  [{type: 'value'},{type: 'value',axisLabel: {show: true,interval: 'auto',formatter: '{value}%'}}];
            }else if("${logType}"=="1,2"){//率 数
            	/* eval("seriesData1.smooth=true"); */
            	/* seriesData1.areaStyle.formatter = '{c}%'; 有错*/
            	seriesData1 = {name:trend1,type:'line',smooth:true,itemStyle: {normal: {color:'#4da7fd',lineStyle:{color:'#4da7fd'},areaStyle: {color:'#4da7fd',formatter:'{c}%'}}},data:[]}; 
            	seriesData2 = {name:trend2,yAxisIndex:1,type:'line',itemStyle: {normal: {color:'#EE0000',lineStyle:{color:'#EE0000'},areaStyle: {type: '#EE0000'} }},data:[]};
            	formatters = '{b}<br/><span style="display:inline-block;margin-right:5px;border-radius:10px;width:9px;height:9px;background-color:#4da7fd"></span>{a0}:{c0}<br/><span style="display:inline-block;margin-right:5px;border-radius:10px;width:9px;height:9px;background-color:#EE0000"></span>{a1}:{c1}%';
            	yAxis0 =  [{name: trend1,type: 'value',axisLabel: {show: true,interval: 'auto',formatter: '{value}%'}},{name: trend2,type: 'value'}];
            }else if("${logType}"=="0,2"||("${logType}"=="0"&&"${compare}".length>0)||("${logType}"=="2"&&"${compare}".length>0)){//数
            	seriesData1 = {name:trend1,type:'line',itemStyle: {normal: {color:'#4da7fd',lineStyle:{color:'#4da7fd'},areaStyle: {color:'#4da7fd'}}},data:[]};
            	seriesData2 = {name:trend2,type:'line',itemStyle: {normal: {color:'#EE0000',lineStyle:{color:'#EE0000'},areaStyle: {type: '#EE0000'} }},data:[]};
            }else if("${logType}"=="1,3"||("${logType}"=="1"&&"${compare}".length>0)||("${logType}"=="3"&&"${compare}".length>0)){//率
            	seriesData1 = {name:trend1,type:'line',smooth:true,itemStyle: {normal: {color:'#4da7fd',lineStyle:{color:'#4da7fd'},areaStyle: {color:'#4da7fd',formatter:'{c}%'}}},data:[]};
            	seriesData2 = {name:trend2,type:'line',smooth:true,itemStyle: {normal: {color:'#EE0000',lineStyle:{color:'#EE0000'},areaStyle: {type: 'default',formatter:'{c}%'} }},data:[]};
            	formatters = '{b}<br/><span style="display:inline-block;margin-right:5px;border-radius:10px;width:9px;height:9px;background-color:#4da7fd"></span>{a0}:{c0}%<br/><span style="display:inline-block;margin-right:5px;border-radius:10px;width:9px;height:9px;background-color:#EE0000"></span>{a1}:{c1}%';
            	yAxis0 = [{type : 'value',axisLabel: {show: true,interval: 'auto',formatter: '{value}%'}}];
            }
            var seriesData = [seriesData1,seriesData2];
            option = {
                tooltip : {
                    trigger: 'axis',
                    axisPointer: {
    		            type: 'cross',
    		            animation: false,
    		            label: {
    		                backgroundColor: '#505765'
    		            }
    		        },
    		        formatter : formatters
                },
                legend: {
                    data:legendData
                },
                toolbox: {
                    show : true,
                    left :'950',
                    right: '50',// toolbox的右边被拉长，使本来被遮住的字体显示出来了 
                    feature : {
                        mark : {show: true},
                        magicType : {show: true, type: ['line', 'bar']}
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
                yAxis : yAxis0,
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
    }else if("${logType}".length==1&&"${compare}".length==0){
        var trend = "";
        var formatters = "";
        var axisLabels = {};
        if("${logType}"=="0"){//留存数
            trend = "留存数";
        }else if("${logType}"=="1"){//留存率
            trend = "留存率";
        }else if("${logType}"=="2"){//留失数
            trend = "留失数";
        }else if("${logType}"=="3"){//留失率
            trend = "留失率";
        }
        if("${logType}"=="1"||"${logType}"=="3"){
        	formatters = '{b}<br/><span style="display:inline-block;margin-right:5px;border-radius:10px;width:9px;height:9px;background-color:#4da7fd"></span>{a}:{c}%';
        	axisLabels = {show: true,interval: 'auto',formatter: '{value}%'};
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
                trigger: 'axis',
                formatter : formatters
            },
            legend: {
                data:legendData
            },
            toolbox: {
                show : true,
                left :'950',
                right: '50',// toolbox的右边被拉长，使本来被遮住的字体显示出来了 
                feature : {
                    mark : {show: true},
                    magicType : {show: true, type: ['line', 'bar']}
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
                    axisLine: {show: false},
                    axisLabel: axisLabels
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
        var days = $("input[name='days']").val();
    	if(days==""){
    		parent.sy.messagerShow({
					msg : "请选择时间",
					title : '提示'
			});
			return false;
    	}
    	var oDate1 = new Date(days);
	    var oDate2 = new Date();
	    var time = oDate2.getTime() - oDate1.getTime() ; //日期的long型值之差
	    var dayb = Math.floor(time/(24*60*60*1000));
    	if(value==0){//次日
    	    if(dayb<=0){
    	    	parent.sy.messagerShow({
					msg : "请选择小于次日的时间",
					title : '提示'
				});
				return false;
    	    }else{
    	    	
    	    } 
    	}else if(value==1){//三日
    		if(dayb<3){
    	    	parent.sy.messagerShow({
					msg : "请选择小于三日的时间",
					title : '提示'
				});
				return false;
    	    }
    	}else if(value==2){//七日
    		if(dayb<7){
    	    	parent.sy.messagerShow({
					msg : "请选择小于七日的时间",
					title : '提示'
				});
				return false;
    	    }
    	}else if(value==3){//30日
    		if(dayb<30){
    	    	parent.sy.messagerShow({
					msg : "请选择小于30日的时间",
					title : '提示'
				});
				return false;
    	    }
    	}
        $("#timeType").val(value);
        
        $("#stupid").submit();
    }
    
    function onSelect(date){
    	 var start = date.getTime();
         var now = new Date().getTime();
         var dayb = parseInt((now-start)/(1000 * 60 * 60 * 24));
         var timeType = "${timeType}";
         if(timeType==0){//次日
     	    if(dayb<=0){
     	    	parent.sy.messagerShow({
 					msg : "请选择小于次日的时间",
 					title : '提示'
 				});
 				return false;
     	    } 
     	}else if(timeType==1){//三日
     		if(dayb<3){
     	    	parent.sy.messagerShow({
 					msg : "请选择小于三日的时间",
 					title : '提示'
 				});
 				return false;
     	    }
     	}else if(timeType==2){//七日
     		if(dayb<7){
     	    	parent.sy.messagerShow({
 					msg : "请选择小于七日的时间",
 					title : '提示'
 				});
 				return false;
     	    }
     	}else if(timeType==3){//30日
     		if(dayb<30){
     	    	parent.sy.messagerShow({
 					msg : "请选择小于30日的时间",
 					title : '提示'
 				});
 				return false;
     	    }
     	}
        $("#stupid").submit();
    }
    function queryTrendBySex(value){
    	if(value!=null&&value!=""){
    		$("#sex").val(value);
    		$("#stupid").submit();
    	}
    }
    function queryTrendByTimeUnit(value){
        if(value!=null&&value!=""){
        	$("#timeUnit").val(value);
    		$("#stupid").submit();
        }
    }
    function queryTrendByDevice(value){
        if(value!=null&&value!=""){
            $("#device").val(value);
            $("#stupid").submit();
        }
    }
    function queryTrendByArea(){
        $("#stupid").submit();
    }
    function queryTrendBylogType(value){
        if(value!=null&&value!=""){
            var logTypes = "${logType}".split(",");
            if(logTypes.indexOf(value) >= 0){//存在-->删除
                logTypes.splice(logTypes.indexOf(value),1);
            }else{//不存在-->添加
                logTypes.push(value);
            }
            /* if(logTypes.length==3){//超过两个指标，无法继续选择添加指标
            	parent.sy.messagerShow({
 					msg : "最多选择两个指标！",
 					title : '提示'
 				});
 				return false;
            } */
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
        $("#stupid").submit(); 
    }

</script>

</body>

