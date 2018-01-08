<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/jquery.1.10.2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/echarts.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/My97DatePicker/WdatePicker.js"></script>

<div class="cn-wrap">

	<div id="content-container" class="container">
		<jsp:include page="class_header.jsp"></jsp:include>

		<div class="row row-3-9">

			<jsp:include page="class_left.jsp"></jsp:include>

			<div class="col-lg-9 col-md-9">

				<div class="panel  panel-col">
					<div class="panel-heading">
						<a class="btn btn-success pull-right"  href="${pageContext.request.contextPath}/course_chart/export.action" style="float:right;" id="export" onclick="return false">
							导出数据
						</a>
						课程学习统计
					</div>

					<div  class="panel-body">


						<div class="my-group material-search-list material-tabs" >
							<input type="hidden" name="timeType" id="timeType" value="${timeType}">
							<span class="all">时间：</span>
							<ul class="js-material-tabs right-content  clearfix" >
								<li class=" js-type-btn active" >
									<a href="javascript:;" onclick="queryTrendByTimeType(0);" >今天</a>
								</li>
								<li class=" js-type-btn" >
									<a href="javascript:;" onclick="queryTrendByTimeType(1);" >昨天</a>
								</li>
								<li class=" js-type-btn" >
									<a href="javascript:;" onclick="queryTrendByTimeType(2);" >最近三天</a>
								</li>
								<li class="js-type-btn" >
									<a href="javascript:;" onclick="queryTrendByTimeType(3);" >最近7天</a>
								</li>
								<li class="js-type-btn" >
									<a href="javascript:;" onclick="queryTrendByTimeType(4);" >最近30天</a>
								</li>
							</ul>
							<ul class="js-material-tabs right-content  clearfix" >

								<li class="js-type-btn active" >
									<a onclick="queryTrendByTimeUnit(this,1);" href="javascript:void(0);" title="根据小时统计">按时</a>
								</li>
								<li class="js-type-btn" >
									<a onclick="queryTrendByTimeUnit(this,2);" href="javascript:void(0);"  title="根据天统计">按天</a>
								</li>
								<li class="js-type-btn" >
									<a  onclick="queryTrendByTimeUnit(this,3);" href="javascript:void(0);" id="week" class="inactive" title="根据周统计">按周</a>
								</li>
							</ul>
						</div>
						<div class="my-group material-search-list material-tabs">
							<span class="all">时间段：</span>
							<ul class="js-material-tabs right-content  clearfix" >
								<li>

									<input id="start_time" readonly="readonly" type="text" name="open_time"
										   class="" onClick="WdatePicker()"
										   onfocus="WdatePicker()" />
									<input id="end_time" readonly="readonly" type="text" name="open_time"
										   class="" onClick="WdatePicker()"
										   onfocus="WdatePicker()" />
									<button onclick="queryTrendByTimeType(5);" class="">查询</button>
								</li>
							</ul>
						</div>

						<div class="my-group material-search-list material-tabs">
							<span class="all">指标：</span>
							<ul class="js-material-tabs right-content  clearfix" id="js-material-tabs-log">
								<li class="active js-type-btn" >
									<a href="javascript:;" onclick="queryTrendBylogType('0');" >观看次数</a>
								</li>

								<li class="js-type-btn" >
									<a href="javascript:;" onclick="queryTrendBylogType('1');" >观看人数</a>
								</li>
							</ul>


						</div>


						<div class="time user_info col-md-offset-1" style="margin-top:20px;">
							<div>
								观看次数&nbsp;&nbsp;<span class="number" id="totalCount"></span>
							</div>
							<div>
								观看人数&nbsp;&nbsp;<span class="number" id="totalUserCount"></span>
							</div>
							<div>
								平均观看时长(次)&nbsp;&nbsp;<span class="number" id="avg"></span>
							</div>
							<div>
								平均观看时长(人) &nbsp;&nbsp;<span class="number" id="userAvg"></span>
							</div>
						</div>
						<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
						<div id="resourceStats" style="width: 760px;height:270px;margin-top: 45px;"></div>


						<div id="compares" class="choose_date_01 clearfix">
							<div class="compare_info" >
								<span>对比:</span>
								<div><input type="radio"  onclick="compare0(0);" value="0" class="compare0">&nbsp;&nbsp;前一日</div>
								<div><input type="radio"  onclick="compare0(1);" value="1" class="compare1">&nbsp;&nbsp;上一周期</div>
							</div>
						</div>


						<div class="my-group clearfix col-md-12" style="margin-top: 30px;">
							<table class="table table-hover table-bordered">
								<thead>
								<tr>
									<th>时间</th>
									<th >观看次数</th>
									<th >观看人数</th>
									<th> 平均观看时长</th>

								</tr>

								</thead>
								<tbody id="databody">
								</tbody>
							</table>
						</div>


					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
<script type="text/javascript">
        var hours=new Array();
        var days = new Array();
        var weeks=new Array();
        var newNum = new Array();
        var newNum1 = new Array();
        var timeType=0;
        var group=1;
        var type0=true;
        var type1=false;
        var totalCount=0;
        var totalUserCount=0;
        var avg=0.0;
        var userAvg=0.0;
        var study_time=0.0;
        var newNumCompare = new Array();
        var newNumCompare1 = new Array();
        var	studyTimeViews;
        function queryTrendBylogType(type) {

            if(! $("#js-material-tabs-log>li").eq(type).is(".active")){
                $("#js-material-tabs-log>li").eq(type).addClass("active");
            }else{
                $("#js-material-tabs-log>li").eq(type).removeClass("active");
            }



            if(type==0){
                type0=!type0;
            }

            if(type==1){
                type1=!type1;
            }

            myChart.showLoading();
            option=myChart.getOption();

            myChart.setOption(option);
            fetchData(function(data) {
                myChart.hideLoading();
                var seriesFetchData;
                if(type0&&type1){
                    seriesFetchData = [{
                        name:legendData2,
                        type:'line',
                        smooth:true,
                        itemStyle: {normal: {areaStyle: {type: 'default'}}},
                        data:data.newNum1,
                        showSymbol:true
                    },{
                        name:legendData1,
                        type:'line',
                        smooth:true,
                        itemStyle: {normal: {areaStyle: {type: 'default'}}},
                        data:data.newNum,
                        showSymbol:true
                    }];
                    legendData=[legendData2,legendData1];
                }else if(type0){

                    seriesFetchData = [{

                        name:legendData1,
                        type:'line',
                        smooth:true,
                        itemStyle: {normal: {areaStyle: {type: 'default'}}},
                        data:data.newNum,
                        showSymbol:true
                    },{
                        name:legendData2,
                        type:'line',
                        data:[],
                        showSymbol:false
                    }];
                    legendData=[legendData1];
                }else if(type1){
                    seriesFetchData = [{
                        name:legendData2,
                        type:'line',
                        smooth:true,
                        itemStyle: {normal: {areaStyle: {type: 'default'}}},
                        data:data.newNum1,
                        showSymbol:true
                    },{
                        name:legendData1,
                        type:'line',
                        data:[],
                        showSymbol:false
                    }];
                    legendData=[legendData2];
                }else{
                    return;
                }
                if(group==1){
                    var o={

                        legend: {
                            data:legendData
                        },
                        xAxis : {
                            data : data.hours

                        },
                        series : seriesFetchData
                    };
                    myChart.setOption(o
                    );
                }
                if(group==2){

                    myChart.setOption({

                        legend: {
                            data:legendData
                        },
                        xAxis : {
                            data : data.days

                        },
                        series : seriesFetchData
                    });
                }
                if(group==3){

                    myChart.setOption({

                        legend: {
                            data:legendData
                        },
                        xAxis : {
                            data : data.weeks

                        },
                        series : seriesFetchData
                    });
                }
            });
        }

        function queryTrendByTimeUnit(obj,index) {
            if(obj.className=="inactive"){
                return false;
            }
            $("#js-material-tabs-unit>li").eq(index-1).addClass("active").siblings().removeClass("active");
            var startTime;
            var endTime;
            if(timeType==5){
                startTime=$("#start_time").val();
                endTime=$("#end_time").val();
                var checkTime1 = getTime(startTime);
                var checkTime2 = getTime(endTime);
                if(startTime==""){
                    alert("请输入开始时间");
                    return false;
                }
                if(endTime==""){
                    alert("请输入结束时间");
                    return false;
                }
                if(checkTime2 - checkTime1<=0){
                    alert("结束时间要大于开始时间");
                    return false;
                }
            }

            group=index;
            $.ajax({
                type : 'POST',
                async : false,
                url : '${pageContext.request.contextPath}/course_chart/get_chart.action?class_id=${classView.id}&course_id=${classView.source_id}',
                data:{
                    timeType:timeType,
                    group:group,
                    endTime:endTime,
                    startTime:startTime
                },
                dataType : 'json',
                success : function(d) {
                    days = new Array();
                    hours=new Array();
                    weeks=new Array();
                    newNum = new Array();
                    newNum1 = new Array();
                    totalCount=0;
                    totalUserCount=0;
                    var avgCount=0.0;
                    study_time=0.0;
                    var list = d.studyTimeViews;
                    studyTimeViews=list;
                    var html="";
                    for(var i=0;i<list.length;i++){
                        days[i] = list[i].days;
                        hours[i] = list[i].hours;
                        weeks[i]="第"+(i+1)+"周";
                        study_time+=list[i].study_time;
                        newNum[i] = list[i].count;
                        newNum1[i] = list[i].user_count;
                        totalCount+= list[i].count;
                        totalUserCount+=list[i].user_count;
                        var _avg=list[i].avg*1.0/1000/60;
                        avgCount+=_avg;
                        html+= "<tr>";
                        if(group==1){
                            html+="<td>"+list[i].hours+"</td>";
                        }else if(group==2){
                            html+="<td>"+list[i].days+"</td>";
                        }else{
                            html+="<td>第"+(i+1)+"周</td>";
                        }
                        html+="<td>"+list[i].count+"</td>";
                        html+="<td>"+list[i].user_count+"</td>";
                        html+="<td>"+_avg.toFixed(2)+"分钟</td>";
                        html+= "</tr>";
                    }
                    html+= "<tr>";
                    html+="<td>汇总</td>";
                    html+="<td>"+totalCount+"</td>";
                    html+="<td>"+totalUserCount+"</td>";
                    html+="<td>"+avgCount.toFixed(2)+"分钟</td>";
                    html+= "</tr>";
                    $("#databody").html("");
                    $("#databody").append(html);
                    if(totalCount!=0){

                        avg=study_time/1000/60/totalCount;
                        userAvg=study_time/1000/60/totalUserCount;
                    }
                    $("#totalCount").html(totalCount);
                    $("#totalUserCount").html(totalUserCount);
                    $("#avg").html(avg.toFixed(2)+"分钟");
                    $("#userAvg").html(userAvg.toFixed(2)+"分钟");
                    myChart.showLoading();
                    fetchData(function(data) {
                        myChart.hideLoading();
                        var seriesFetchData;
                        if(type0&&type1){
                            seriesFetchData = [{
                                name:legendData2,
                                type:'line',
                                smooth:true,
                                itemStyle: {normal: {areaStyle: {type: 'default'}}},
                                data:data.newNum1,
                                showSymbol:true
                            },{
                                name:legendData1,
                                type:'line',
                                smooth:true,
                                itemStyle: {normal: {areaStyle: {type: 'default'}}},
                                data:data.newNum,
                                showSymbol:true
                            }];
                            legendData=[legendData2,legendData1];
                        }else if(type0){

                            seriesFetchData = [{

                                name:legendData1,
                                type:'line',
                                smooth:true,
                                itemStyle: {normal: {areaStyle: {type: 'default'}}},
                                data:data.newNum,
                                showSymbol:true
                            },{

                                name:legendData2,
                                type:'line',
                                data:[],
                                showSymbol:false
                            }];
                            legendData=[legendData1];
                        }else if(type1){
                            seriesFetchData = [{
                                name:legendData2,
                                type:'line',
                                smooth:true,
                                itemStyle: {normal: {areaStyle: {type: 'default'}}},
                                data:data.newNum1,
                                showSymbol:true
                            },{
                                name:legendData1,
                                type:'line',
                                data:[],
                                showSymbol:false
                            }];
                            legendData=[legendData2];
                        }else{
                            return;
                        }
                        if(group==1){
                            myChart.setOption({
                                xAxis : {
                                    data : data.hours

                                },
                                series : seriesFetchData
                            });
                        }
                        if(group==2){
                            myChart.setOption({
                                xAxis : {
                                    data : data.days

                                },
                                series : seriesFetchData
                            });
                        }if(group==3){

                            myChart.setOption({

                                legend: {
                                    data:legendData
                                },
                                xAxis : {
                                    data : data.weeks

                                },
                                series : seriesFetchData
                            });
                        }
                    });
                }
            });
        }

        function queryTrendByTimeType(index) {
            timeType=index;
            $("#js-material-tabs>li").eq(index).addClass("active").siblings().removeClass("active");
            if(group==3&&index!=5){
                $("#js-material-tabs-unit>li").eq(0).addClass("active").siblings().removeClass("active");
                group=1;
            }
            if(index==4){
                $("#week").removeClass("inactive");
            }else{

                $("#week").addClass("inactive");
            }
            if(index>1){
                $(".compare_info").hide();
            }else{
                $(".compare_info").show();
            }
            var startTime;
            var endTime;
            if(index==5){
                $("#js-material-tabs>li").removeClass("active");
                startTime=$("#start_time").val();
                endTime=$("#end_time").val();
                var checkTime1 = getTime(startTime);
                var checkTime2 = getTime(endTime);
                if(startTime==""){
                    alert("请输入开始时间");
                    return false;
                }
                if(endTime==""){
                    alert("请输入结束时间");
                    return false;
                }
                if(checkTime2 - checkTime1<=0){
                    alert("结束时间要大于开始时间");
                    return false;
                }else{
                    if((checkTime2 - checkTime1)/1000/60/60/24>7){
                        $("#week").removeClass("inactive");
                    }else if(group==3){
                        $("#week").addClass("inactive");
                        $("#js-material-tabs-unit>li").eq(0).addClass("active").siblings().removeClass("active");
                        group=1;
                    }
                }
            }
            $.ajax({
                type : 'POST',
                async : false,
                url : '${pageContext.request.contextPath}/course_chart/get_chart.action?class_id=${classView.id}&course_id=${classView.source_id}',
                data:{
                    timeType:timeType,
                    group:group,
                    endTime:endTime,
                    startTime:startTime
                },
                dataType : 'json',
                success : function(d) {
                    days = new Array();
                    hours=new Array();
                    weeks=new Array();
                    newNum = new Array();
                    newNum1 = new Array();
                    totalCount=0;
                    totalUserCount=0;
                    study_time=0.0;
                    var avgCount=0.0;
                    var html="";
                    var list = d.studyTimeViews;
                    studyTimeViews=list;
                    for(var i=0;i<list.length;i++){
                        hours[i] = list[i].hours;
                        newNum[i] = list[i].count;
                        newNum1[i]=list[i].user_count;
                        days[i] = list[i].days;
                        weeks[i]="第"+(i+1)+"周";

                        study_time+=list[i].study_time;
                        totalCount+= list[i].count;
                        totalUserCount+=list[i].user_count;
                        var _avg=list[i].avg*1.0/1000/60;
                        avgCount+=_avg;
                        html+= "<tr>";
                        if(group==1){
                            html+="<td>"+list[i].hours+"</td>";
                        }else if(group==2){
                            html+="<td>"+list[i].days+"</td>";
                        }else{
                            html+="<td>第"+(i+1)+"周</td>";
                        }
                        html+="<td>"+list[i].count+"</td>";
                        html+="<td>"+list[i].user_count+"</td>";
                        html+="<td>"+_avg.toFixed(2)+"分钟</td>";
                        html+= "</tr>";
                    }
                    html+= "<tr>";
                    html+="<td>汇总</td>";
                    html+="<td>"+totalCount+"</td>";
                    html+="<td>"+totalUserCount+"</td>";
                    html+="<td>"+avgCount.toFixed(2)+"分钟</td>";
                    html+= "</tr>";
                    $("#databody").html("");
                    $("#databody").append(html);
                    if(totalCount!=0){

                        avg=study_time/1000/60/totalCount;
                        userAvg=study_time/1000/60/totalUserCount;
                    }
                    $("#totalCount").html(totalCount);
                    $("#totalUserCount").html(totalUserCount);
                    $("#avg").html(avg.toFixed(2)+"分钟");
                    $("#userAvg").html(userAvg.toFixed(2)+"分钟");
                    myChart.showLoading();
                    fetchData(function(data) {
                        myChart.hideLoading();
                        var seriesFetchData;
                        if(type0&&type1){
                            seriesFetchData = [{
                                name:legendData2,
                                type:'line',
                                smooth:true,
                                itemStyle: {normal: {areaStyle: {type: 'default'}}},
                                data:data.newNum1,
                                showSymbol:true
                            },{
                                name:legendData1,
                                type:'line',
                                smooth:true,
                                itemStyle: {normal: {areaStyle: {type: 'default'}}},
                                data:data.newNum,
                                showSymbol:true
                            }];
                            legendData=[legendData2,legendData1];
                        }else if(type0){

                            seriesFetchData = [{

                                name:legendData1,
                                type:'line',
                                smooth:true,
                                itemStyle: {normal: {areaStyle: {type: 'default'}}},
                                data:data.newNum,
                                showSymbol:true
                            },{
                                name:legendData2,
                                type:'line',
                                data:[],
                                showSymbol:false
                            }];
                            legendData=[legendData1];
                        }else if(type1){
                            seriesFetchData = [{
                                name:legendData2,
                                type:'line',
                                smooth:true,
                                itemStyle: {normal: {areaStyle: {type: 'default'}}},
                                data:data.newNum1,
                                showSymbol:true
                            },{
                                name:legendData1,
                                type:'line',
                                data:[],
                                showSymbol:false
                            }];
                            legendData=[legendData2];
                        }else{
                            return;
                        }
                        if(group==1){
                            myChart.setOption({
                                xAxis : {
                                    data : data.hours

                                },
                                series : seriesFetchData
                            });
                        }
                        if(group==2){
                            myChart.setOption({
                                xAxis : {
                                    data : data.days

                                },
                                series : seriesFetchData
                            });
                        }if(group==3){

                            myChart.setOption({

                                legend: {
                                    data:legendData
                                },
                                xAxis : {
                                    data : data.weeks

                                },
                                series : seriesFetchData
                            });
                        }
                    });
                }
            });
        }

        $(function(){
            $.ajax({
                type : 'POST',
                async : false,
                url : '${pageContext.request.contextPath}/course_chart/get_chart.action?class_id=${classView.id}&course_id=${classView.source_id}',

                dataType : 'json',
                success : function(d) {
                    var list = d.studyTimeViews;
                    studyTimeViews=list;
                    study_time=0.0;
                    var avgCount=0.0;
                    var html="";
                    for(var i=0;i<list.length;i++){
                        hours[i] = list[i].hours;
                        newNum[i] = list[i].count;
                        newNum1[i] = list[i].user_count;
                        totalCount+= list[i].count;
                        totalUserCount+=list[i].user_count;
                        study_time+=list[i].study_time;
                        var _avg=list[i].avg*1.0/1000/60;
                        avgCount+=_avg;
                        html+= "<tr>";
                        html+="<td>"+list[i].hours+"</td>";
                        html+="<td>"+list[i].count+"</td>";
                        html+="<td>"+list[i].user_count+"</td>";
                        html+="<td>"+_avg.toFixed(2)+"分钟</td>";
                        html+= "</tr>";
                    }
                    html+= "<tr>";
                    html+="<td>汇总</td>";
                    html+="<td>"+totalCount+"</td>";
                    html+="<td>"+totalUserCount+"</td>";
                    html+="<td>"+avgCount.toFixed(2)+"分钟</td>";
                    html+= "</tr>";
                    $("#databody").html("");
                    $("#databody").append(html);

                    if(totalCount!=0){

                        avg=study_time/1000/60/totalCount;
                        userAvg=study_time/1000/60/totalUserCount;
                    }
                    $("#totalCount").html(totalCount);
                    $("#totalUserCount").html(totalUserCount);
                    $("#avg").html(avg.toFixed(2)+"分钟" );
                    $("#userAvg").html(userAvg.toFixed(2)+"分钟");
                }
            });
        });
        //基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('resourceStats'));


        var legendData1 = '观看次数';
        var legendData2 = '观看人数';
        var legendData = [legendData1];
        var seriesData = [{
            name:legendData1,
            type:'line',
            smooth:true,
            itemStyle: {normal: {areaStyle: {type: 'default'}}},
            data:[],

        }];
        option = {
            tooltip : {
                trigger: 'axis'
            },
            legend: {
                data:legendData
            },

            calculable : true,
            xAxis : [
                {
                    name:'(时间)',
                    type : 'category',
                    boundaryGap : false,
                    data : []//横坐标

                }
            ],
            yAxis : [
                {
                    type : 'value',
                    name:'(次)'
                }
            ],
            series : seriesData
        };

        myChart.showLoading();
        fetchData(function(data) {
            myChart.hideLoading();
            var seriesFetchData = [{
                // 根据名字对应到相应的系列
                name : legendData1,
                data : data.newNum,

            }];
            myChart.setOption({
                xAxis : {
                    data : data.hours

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
                    hours : hours,
                    newNum : newNum,
                    newNum1 : newNum1,
                    newNumCompare:newNumCompare,
                    newNumCompare1:newNumCompare1,
                    days:days,
                    weeks:weeks
                });
            }, 1000);
        }

        function compare0(index){
            var isChecked = $(".compare"+index).prop("checked");
            var index2=(index+1)%2;
            var name;
            if(timeType>1){
                return false;
            }
            if(index==0){
                name="前一日";
            }else{
                name="上一周期";
            }
            if(isChecked){
                $(".compare"+index2).prop("checked", false);
                     //显示
                $.ajax({
                    type : 'POST',
                    async : false,
                    url : '${pageContext.request.contextPath}/course_chart/get_chart_compare.action?class_id=${classView.id}&course_id=${classView.source_id}&index='+index,
                    data:{
                        timeType:timeType,
                        group:group
                    },
                    dataType : 'json',
                    success : function(d) {
                        var list = d.studyTimeViews;
                        studyTimeViews=list;
                        newNumCompare = new Array();
                        newNumCompare1 = new Array();
                        for(var i=0;i<list.length;i++){

                            newNumCompare[i] = list[i].count;
                            newNumCompare1[i] = list[i].user_count;

                        }

                        myChart.showLoading();
                        option=myChart.getOption();

                        myChart.setOption(option);
                        fetchData(function(data) {
                            myChart.hideLoading();
                            var seriesFetchData;
                            if(type0){

                                seriesFetchData = [{

                                    name:legendData1,
                                    type:'line',
                                    smooth:true,
                                    itemStyle: {normal: {areaStyle: {type: 'default'}}},
                                    data:data.newNum,
                                    showSymbol:true
                                },{
                                    name:name,
                                    type:'line',
                                    smooth:true,
                                    itemStyle: {normal: {areaStyle: {type: 'default'}}},
                                    data:data.newNumCompare,
                                    showSymbol:true
                                }];
                                legendData=[legendData1,name];
                            }else if(type1){
                                seriesFetchData = [{
                                    name:legendData2,
                                    type:'line',
                                    smooth:true,
                                    itemStyle: {normal: {areaStyle: {type: 'default'}}},
                                    data:data.newNum1,
                                    showSymbol:true
                                },{
                                    name:name,
                                    type:'line',
                                    smooth:true,
                                    itemStyle: {normal: {areaStyle: {type: 'default'}}},
                                    data:data.newNumCompare1,
                                    showSymbol:true
                                }];
                                legendData=[legendData2,name];
                            }else{
                                return;
                            }
                            if(group==1){
                                var o={

                                    legend: {
                                        data:legendData
                                    },
                                    xAxis : {
                                        data : data.hours

                                    },
                                    series : seriesFetchData
                                };
                                myChart.setOption(o
                                );
                            }
                            if(group==2){

                                myChart.setOption({

                                    legend: {
                                        data:legendData
                                    },
                                    xAxis : {
                                        data : data.days

                                    },
                                    series : seriesFetchData
                                });
                            } if(group==3){

                                myChart.setOption({

                                    legend: {
                                        data:legendData
                                    },
                                    xAxis : {
                                        data : data.weeks

                                    },
                                    series : seriesFetchData
                                });
                            }
                        });

                    }
                });


            }else{
                myChart.showLoading();
                option=myChart.getOption();

                myChart.setOption(option);
                fetchData(function(data) {
                    myChart.hideLoading();
                    var seriesFetchData;
                    if(type0){

                        seriesFetchData = [{

                            name:legendData1,
                            type:'line',
                            smooth:true,
                            itemStyle: {normal: {areaStyle: {type: 'default'}}},
                            data:data.newNum,
                            showSymbol:true
                        },{
                            name:name,
                            type:'line',
                            data:[],
                            showSymbol:false
                        }];
                        legendData=[legendData1];
                    }else if(type1){
                        seriesFetchData = [{
                            name:legendData2,
                            type:'line',
                            smooth:true,
                            itemStyle: {normal: {areaStyle: {type: 'default'}}},
                            data:data.newNum1,
                            showSymbol:true
                        },{
                            name:name,
                            type:'line',
                            data:[],
                            showSymbol:false
                        }];
                        legendData=[legendData2];
                    }else{
                        return;
                    }
                    if(group==1){
                        var o={

                            legend: {
                                data:legendData
                            },
                            xAxis : {
                                data : data.hours

                            },
                            series : seriesFetchData
                        };
                        myChart.setOption(o
                        );
                    }
                    if(group==2){

                        myChart.setOption({

                            legend: {
                                data:legendData
                            },
                            xAxis : {
                                data : data.days

                            },
                            series : seriesFetchData
                        });
                    }      if(group==3){

                        myChart.setOption({

                            legend: {
                                data:legendData
                            },
                            xAxis : {
                                data : data.weeks

                            },
                            series : seriesFetchData
                        });
                    }
                });

            }

        }
        $("#export").click(function () {


            var form=$("<form>");//定义一个form表单
            form.attr("style","display:none");
            form.attr("target","");
            form.attr("method","post");
            form.attr("action",$(this).attr("href"));

            var input3=$("<input>");
            input3.attr("type","hidden");
            input3.attr("name","studyTimeViews");
            input3.attr("value",(JSON.stringify(studyTimeViews)));
            var input4=$("<input>");
            input4.attr("type","hidden");
            input4.attr("name","group");
            input4.attr("value",group);

            $("body").append(form);//将表单放置在web中

            form.append(input3);
            form.append(input4);
            form.submit();//表单提交 });
        });
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

	</script>

