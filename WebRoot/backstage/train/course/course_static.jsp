<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/backstage/css/data.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/echarts.min.js"></script>
<style>
	*{margin: 0;padding: 0;list-style: none;text-decoration: none;color: rgb(102, 102, 102);}
	.class_main{margin-left: 20px;}
	.class_content_tabs{}
	.class_content_tabs>ul{margin: 20px;}
	.class_content_tabs>ul>li{display: inline-block;margin-right: 20px;padding-bottom: 15px;}
	.class_content_tabs>ul>li.active>a{color: #3ebbce;}
	.class_content_tabs>ul>li.active{border-bottom: 2px solid #3ebbce;}
	.class_content_tabs>ul>li>a{font-size: 14px;}
	.js-material-tabs>li.active{display: inline-block;background-color: #4da7fd;color: #fff;}
	ul.js-material-tabs>li{display: inline-block;}


</style>
<script>
    $(function () {
        $(".class_content_tabs>ul>li").click(function () {

            $(this).addClass("active").siblings().removeClass("active");
            var index=$(this).index();
            $(".course_content_tabs").hide().eq(index).show()


        })
    })
</script>
<div class="class_main">

	<div class="class_content_tabs">
		<ul>
			<li class="active"><a href="javascript:void(0);">课程学习统计</a></li>
			<li><a href="javascript:void(0);">课程讨论统计</a></li>
		</ul>
	</div>

	<div class="main_head course_content_tabs">
		<div class="main_head_content">

			<input type="hidden" name="timeType" id="timeType" value="${timeType}">
			<div class="time" >
				<div class="choose_date_01">

					<div id="timeTypea" class="choose_date_01">
						<span>时间：</span>
						<a href="javascript:;" onclick="queryTrendByTimeTypea(0);" class="active">今天</a>

						<a href="javascript:;" onclick="queryTrendByTimeTypea(1);" class="">昨天</a>

						<a href="javascript:;" onclick="queryTrendByTimeTypea(2);" class="">最近三天</a>

						<a href="javascript:;" onclick="queryTrendByTimeTypea(3);" class="">最近7天</a>

						<a href="javascript:;" onclick="queryTrendByTimeTypea(4);" class="">最近30天</a>


					</div>
					<br/>

					<div id="timeUnita" class="choose_date_01">
						<span>按时：</span>
						<a onclick="queryTrendByTimeUnita(this,1);" href="javascript:void(0);" title="根据小时统计" class="active">按时</a>
						<a onclick="queryTrendByTimeUnita(this,2);" href="javascript:void(0);" title="根据天统计" class="">按天</a>
						<a onclick="queryTrendByTimeUnita(this,3);" href="javascript:void(0);" id="week" class="inactive" title="根据周统计" class="">按周</a>

					</div>
					<br/>
					<div class="choose_date_01">
						<span>时间段：</span>

						<input id="start_timea" readonly="readonly" type="text" name="open_time"  class="easyui-datebox" data-options="editable:false"  />
						<input id="end_timea" readonly="readonly" type="text" name="open_time"  class="easyui-datebox" data-options="editable:false"  />
						<button onclick="queryTrendByTimeTypea(5);" class="">查询</button>
					</div>
					<br/>

					<div id="logTypea" class="choose_date_01">
						<span >指标：</span>

						<a href="javascript:;" onclick="queryTrendBylogTypea('0');" class="active">观看次数</a>

						<a href="javascript:;" onclick="queryTrendBylogTypea('1');" class="">观看人数</a>

					</div>
					<br/>

					<div class="time user_info" style="margin-top:20px;">
						<div>
							观看次数&nbsp;&nbsp;<span class="number" id="totalCounta"></span>
						</div>
						<div>
							观看人数&nbsp;&nbsp;<span class="number" id="totalUserCounta"></span>
						</div>
						<br/>
						<br/>
						<div>
							平均观看时长(次)&nbsp;&nbsp;<span class="number" id="avga"></span>
						</div>
						<div>
							平均观看时长(人) &nbsp;&nbsp;<span class="number" id="userAvga"></span>
						</div>
					</div>
					<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
					<div id="resourceStatsa" style="width: 700px;height:270px;margin-top: 45px;"></div>

					<div  class="choose_date_01 clearfix compares">
						<div class="compare_info">
							<span>对比:</span>
							<div><input type="radio" onclick="compare0a(0);" value="0" class="compare0">&nbsp;前一日</div>
							<div><input type="radio" onclick="compare0a(1);" value="1" class="compare1">&nbsp;上一周期</div>
						</div>
					</div>

					<div class="time" style="clear: both;margin-top: 40px;">
						<table class="table_sta" >
							<thead>
							<tr>
								<th>时间</th>
								<th>观看次数</th>
								<th>观看人数</th>
								<th> 平均观看时长</th>

							</tr>

							</thead>
							<tbody id="databodya">
							</tbody>
						</table>
					</div>

				</div>

			</div>

		</div>
	</div>

	<div class="main_head course_content_tabs" style="display: none;">
		<div class="main_head_content">
			<div class="time" >
				<div id="timeTypeb" class="choose_date_01">
					<span >时间：</span>
					<a href="javascript:;" onclick="queryTrendByTimeType(1);" class="active">昨天</a>

					<a href="javascript:;" onclick="queryTrendByTimeType(2);" class="">最近三天</a>

					<a href="javascript:;" onclick="queryTrendByTimeType(3);" class="">最近7天</a>

					<a href="javascript:;" onclick="queryTrendByTimeType(4);" class="">最近30天</a>

				</div>
				<br/>
				<br/>

				<div class="choose_date_01">
					<span >时间段：</span>

					<input id="start_time" readonly="readonly" type="text" name="open_time" class="easyui-datebox" data-options="editable:false" />
					<input id="end_time" readonly="readonly" type="text" name="open_time" class="easyui-datebox" data-options="editable:false" />
					<button onclick="queryTrendByTimeType(5);" class="">查询</button>

				</div>
				<br/>
				<br/>

				<div id="logTypeb" class="choose_date_01">
					<span >指标：</span>
					<a href="javascript:;" onclick="queryTrendBylogType('0');" class="active">提问数</a>
					<a href="javascript:;" onclick="queryTrendBylogType('1');" class="">回复数</a>
				</div>
				<br/>

				<div class="time user_info" style="margin-top:20px;">
					<div>
						提问数&nbsp;&nbsp;<span class="number" id="totalCount"></span>
					</div>
					<div>
						回复数&nbsp;&nbsp;<span class="number" id="totalUserCount"></span>
					</div>

				</div>
				<br/>
				<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
				<div id="resourceStats" style="width: 700px;height:270px;margin-top: 45px;"></div>

				<div  class="choose_date_01 clearfix compares">
					<div class="compare_info">
						<span>对比:</span>
						<div><input type="radio" onclick="compare0(0);" value="0" class="compare0">&nbsp;前一日</div>
						<div><input type="radio" onclick="compare0(1);" value="1" class="compare1">&nbsp;上一周期</div>
					</div>
				</div>

				<div class="time" style="clear: both;margin-top: 40px;">
					<table class="table_sta" >
						<thead>
						<tr>
							<th>时间</th>
							<th>提问数</th>
							<th>回复数</th>

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
<script type="text/javascript">

    var hoursa = new Array();
    var daysa = new Array();
    var weeksa = new Array();
    var newNuma = new Array();
    var newNum1a = new Array();
    var timeType = 0;
    var group = 1;
    var type0 = true;
    var type1 = false;
    var totalCounta = 0;
    var totalUserCounta = 0;
    var avga = 0.0;
    var userAvga = 0.0;
    var study_timea = 0.0;
    var newNumComparea = new Array();
    var newNumCompare1a = new Array();
    var studyTimeViewsa;

    function queryTrendBylogTypea(type) {
        if(!$("#logTypea>a").eq(type).is(".active")) {
            $("#logTypea>a").eq(type).addClass("active");
        } else {
            $("#logTypea>a").eq(type).removeClass("active");
        }
        if(type == 0) {
            type0 = !type0;
        }
        if(type == 1) {
            type1 = !type1;
        }
        myCharta.showLoading();
        option = myCharta.getOption();

        myCharta.setOption(option);
        fetchDataa(function(data) {
            myCharta.hideLoading();
            var seriesFetchData;
            if(type0 && type1) {
                seriesFetchData = [{
                    name: legendData2a,
                    type: 'line',
                    smooth: true,
                    itemStyle: {
                        normal: {
                            areaStyle: {
                                type: 'default'
                            }
                        }
                    },
                    data: data.newNum1a,
                    showSymbol: true
                }, {
                    name: legendData1a,
                    type: 'line',
                    smooth: true,
                    itemStyle: {
                        normal: {
                            areaStyle: {
                                type: 'default'
                            }
                        }
                    },
                    data: data.newNuma,
                    showSymbol: true
                }];
                legendDataa = [legendData2a, legendData1a];
            } else if(type0) {

                seriesFetchData = [{

                    name: legendData1a,
                    type: 'line',
                    smooth: true,
                    itemStyle: {
                        normal: {
                            areaStyle: {
                                type: 'default'
                            }
                        }
                    },
                    data: data.newNuma,
                    showSymbol: true
                }, {
                    name: legendData2a,
                    type: 'line',
                    data: [],
                    showSymbol: false
                }];
                legendDataa = [legendData1a];
            } else if(type1) {
                seriesFetchData = [{
                    name: legendData2a,
                    type: 'line',
                    smooth: true,
                    itemStyle: {
                        normal: {
                            areaStyle: {
                                type: 'default'
                            }
                        }
                    },
                    data: data.newNum1a,
                    showSymbol: true
                }, {
                    name: legendData1a,
                    type: 'line',
                    data: [],
                    showSymbol: false
                }];
                legendDataa = [legendData2a];
            } else {
                return;
            }
            if(group == 1) {
                var o = {

                    legend: {
                        data: legendDataa
                    },
                    xAxis: {
                        data: data.hoursa

                    },
                    series: seriesFetchData
                };
                myCharta.setOption(o);
            }
            if(group == 2) {

                myCharta.setOption({

                    legend: {
                        data: legendDataa
                    },
                    xAxis: {
                        data: data.daysa

                    },
                    series: seriesFetchData
                });
            }
            if(group == 3) {

                myCharta.setOption({

                    legend: {
                        data: legendDataa
                    },
                    xAxis: {
                        data: data.weeksa

                    },
                    series: seriesFetchData
                });
            }
        });
    }


    function queryTrendByTimeUnita(obj, index) {
        if(obj.className == "inactive") {
            return false;
        }
        $("#timeUnita>a").eq(index - 1).addClass("active").siblings().removeClass("active");
        var startTime;
        var endTime;
        if(timeType == 5) {
            startTime = $("#start_timea").datebox('getValue');
            endTime = $("#end_timea").datebox('getValue');
            var checkTime1 = getTime(startTime);
            var checkTime2 = getTime(endTime);
            if(startTime == "") {
                alert("请输入开始时间");
                return false;
            }
            if(endTime == "") {
                alert("请输入结束时间");
                return false;
            }
            if(checkTime2 - checkTime1 <= 0) {
                alert("结束时间要大于开始时间");
                return false;
            }
        }

        group = index;
        $.ajax({
            type: 'POST',
            async: false,
            url: '${pageContext.request.contextPath}/back_course/get_chart.action?course_id=${course_id}',
            data: {
                timeType: timeType,
                group: group,
                endTime: endTime,
                startTime: startTime
            },
            dataType: 'json',
            success: function(d) {
                daysa = new Array();
                hoursa = new Array();
                weeksa = new Array();
                newNuma = new Array();
                newNum1a = new Array();
                totalCounta = 0;
                totalUserCounta = 0;
                var avgCount = 0.0;
                study_timea = 0.0;
                var list = d.studyTimeViews;
                studyTimeViews = list;
                var html = "";
                for(var i = 0; i < list.length; i++) {
                    daysa[i] = list[i].days;
                    hoursa[i] = list[i].hours;
                    weeksa[i] = "第" + (i + 1) + "周";
                    study_timea += list[i].study_time;
                    newNuma[i] = list[i].count;
                    newNum1a[i] = list[i].user_count;
                    totalCounta += list[i].count;
                    totalUserCounta += list[i].user_count;
                    var _avg = list[i].avg * 1.0 / 1000 / 60;
                    avgCount += _avg;
                    html += "<tr>";
                    if(group == 1) {
                        html += "<td>" + list[i].hours + "</td>";
                    } else if(group == 2) {
                        html += "<td>" + list[i].days + "</td>";
                    } else {
                        html += "<td>第" + (i + 1) + "周</td>";
                    }
                    html += "<td>" + list[i].count + "</td>";
                    html += "<td>" + list[i].user_count + "</td>";
                    html += "<td>" + _avg.toFixed(2) + "分钟</td>";
                    html += "</tr>";
                }
                html += "<tr>";
                html += "<td>汇总</td>";
                html += "<td>" + totalCounta + "</td>";
                html += "<td>" + totalUserCounta + "</td>";
                html += "<td>" + avgCount.toFixed(2) + "分钟</td>";
                html += "</tr>";
                $("#databodya").html("");
                $("#databodya").append(html);
                if(totalCounta != 0) {
                    avga = study_timea / 1000 / 60 / totalCounta;
                    userAvga = study_timea / 1000 / 60 / totalUserCounta;
                }else{
                    avga = 0.0;
                    userAvga = 0.0;
                }
                $("#totalCounta").html(totalCounta);
                $("#totalUserCounta").html(totalUserCounta);
                $("#avga").html(avga.toFixed(2) + "分钟");
                $("#userAvga").html(userAvga.toFixed(2) + "分钟");
                myCharta.showLoading();
                fetchDataa(function(data) {
                    myCharta.hideLoading();
                    var seriesFetchData;
                    if(type0 && type1) {
                        seriesFetchData = [{
                            name: legendData2a,
                            type: 'line',
                            smooth: true,
                            itemStyle: {
                                normal: {
                                    areaStyle: {
                                        type: 'default'
                                    }
                                }
                            },
                            data: data.newNum1a,
                            showSymbol: true
                        }, {
                            name: legendData1a,
                            type: 'line',
                            smooth: true,
                            itemStyle: {
                                normal: {
                                    areaStyle: {
                                        type: 'default'
                                    }
                                }
                            },
                            data: data.newNuma,
                            showSymbol: true
                        }];
                        legendDataa = [legendData2a, legendData1a];
                    } else if(type0) {

                        seriesFetchData = [{

                            name: legendData1a,
                            type: 'line',
                            smooth: true,
                            itemStyle: {
                                normal: {
                                    areaStyle: {
                                        type: 'default'
                                    }
                                }
                            },
                            data: data.newNuma,
                            showSymbol: true
                        }, {

                            name: legendData2a,
                            type: 'line',
                            data: [],
                            showSymbol: false
                        }];
                        legendDataa = [legendData1a];
                    } else if(type1) {
                        seriesFetchData = [{
                            name: legendData2a,
                            type: 'line',
                            smooth: true,
                            itemStyle: {
                                normal: {
                                    areaStyle: {
                                        type: 'default'
                                    }
                                }
                            },
                            data: data.newNum1a,
                            showSymbol: true
                        }, {
                            name: legendData1a,
                            type: 'line',
                            data: [],
                            showSymbol: false
                        }];
                        legendDataa = [legendData2a];
                    } else {
                        return;
                    }
                    if(group == 1) {
                        myCharta.setOption({
                            xAxis: {
                                data: data.hoursa

                            },
                            series: seriesFetchData
                        });
                    }
                    if(group == 2) {
                        myCharta.setOption({
                            xAxis: {
                                data: data.daysa

                            },
                            series: seriesFetchData
                        });
                    }
                    if(group == 3) {

                        myCharta.setOption({

                            legend: {
                                data: legendDataa
                            },
                            xAxis: {
                                data: data.weeksa

                            },
                            series: seriesFetchData
                        });
                    }
                });
            }
        });
    }

    function queryTrendByTimeTypea(index) {
        timeType = index;
        $("#timeTypea>a").eq(index).addClass("active").siblings().removeClass("active");
        if(group == 3 && index != 5) {
            $("#timeTypea>a").eq(0).addClass("active").siblings().removeClass("active");
            group = 1;
        }
        if(index == 4) {
            $("#week").removeClass("inactive");
        } else {

            $("#week").addClass("inactive");
        }
        if(index > 1) {
            $(".compare_info").hide();
        } else {
            $(".compare_info").show();
        }
        var startTime;
        var endTime;
        if(index == 5) {
            $("#timeTypea>a").removeClass("active");
            startTime = $("#start_timea").datebox('getValue');
            endTime = $("#end_timea").datebox('getValue');
            var checkTime1 = getTime(startTime);
            var checkTime2 = getTime(endTime);
            if(startTime == "") {
                alert("请输入开始时间");
                return false;
            }
            if(endTime == "") {
                alert("请输入结束时间");
                return false;
            }
            if(checkTime2 - checkTime1 <= 0) {
                alert("结束时间要大于开始时间");
                return false;
            } else {
                if((checkTime2 - checkTime1) / 1000 / 60 / 60 / 24 > 7) {
                    $("#week").removeClass("inactive");
                } else if(group == 3) {
                    $("#week").addClass("inactive");
                    $("#timeTypea>a").eq(0).addClass("active").siblings().removeClass("active");
                    group = 1;
                }
            }
        }
        $.ajax({
            type: 'POST',
            async: false,
            url: '${pageContext.request.contextPath}/back_course/get_chart.action?course_id=${course_id}',
            data: {
                timeType: timeType,
                group: group,
                endTime: endTime,
                startTime: startTime
            },
            dataType: 'json',
            success: function(d) {
                daysa = new Array();
                hoursa = new Array();
                weeksa = new Array();
                newNuma = new Array();
                newNum1a = new Array();
                totalCounta = 0;
                totalUserCounta = 0;
                study_timea = 0.0;
                var avgCount = 0.0;
                var html = "";
                var list = d.studyTimeViews;
                studyTimeViewsa = list;
                for(var i = 0; i < list.length; i++) {
                    hoursa[i] = list[i].hours;
                    newNuma[i] = list[i].count;
                    newNum1a[i] = list[i].user_count;
                    daysa[i] = list[i].days;
                    weeksa[i] = "第" + (i + 1) + "周";

                    study_timea += list[i].study_time;
                    totalCounta += list[i].count;
                    totalUserCounta += list[i].user_count;
                    var _avg = list[i].avg * 1.0 / 1000 / 60;
                    avgCount += _avg;
                    html += "<tr>";
                    if(group == 1) {
                        html += "<td>" + list[i].hours + "</td>";
                    } else if(group == 2) {
                        html += "<td>" + list[i].days + "</td>";
                    } else {
                        html += "<td>第" + (i + 1) + "周</td>";
                    }
                    html += "<td>" + list[i].count + "</td>";
                    html += "<td>" + list[i].user_count + "</td>";
                    html += "<td>" + _avg.toFixed(2) + "分钟</td>";
                    html += "</tr>";
                }
                html += "<tr>";
                html += "<td>汇总</td>";
                html += "<td>" + totalCounta + "</td>";
                html += "<td>" + totalUserCounta + "</td>";
                html += "<td>" + avgCount.toFixed(2) + "分钟</td>";
                html += "</tr>";
                $("#databodya").html("");
                $("#databodya").append(html);
                if(totalCounta != 0) {
                    avga = study_timea / 1000 / 60 / totalCounta;
                    userAvga = study_timea / 1000 / 60 / totalUserCounta;
                }else{
                    avga = 0.0;
                    userAvga = 0.0;
                }
                $("#totalCounta").html(totalCounta);
                $("#totalUserCounta").html(totalUserCounta);
                $("#avga").html(avga.toFixed(2) + "分钟");
                $("#userAvga").html(userAvga.toFixed(2) + "分钟");
                myCharta.showLoading();
                fetchDataa(function(data) {
                    myCharta.hideLoading();
                    var seriesFetchData;
                    if(type0 && type1) {
                        seriesFetchData = [{
                            name: legendData2a,
                            type: 'line',
                            smooth: true,
                            itemStyle: {
                                normal: {
                                    areaStyle: {
                                        type: 'default'
                                    }
                                }
                            },
                            data: data.newNum1a,
                            showSymbol: true
                        }, {
                            name: legendData1a,
                            type: 'line',
                            smooth: true,
                            itemStyle: {
                                normal: {
                                    areaStyle: {
                                        type: 'default'
                                    }
                                }
                            },
                            data: data.newNuma,
                            showSymbol: true
                        }];
                        legendDataa = [legendData2a, legendData1a];
                    } else if(type0) {

                        seriesFetchData = [{

                            name: legendData1a,
                            type: 'line',
                            smooth: true,
                            itemStyle: {
                                normal: {
                                    areaStyle: {
                                        type: 'default'
                                    }
                                }
                            },
                            data: data.newNuma,
                            showSymbol: true
                        }, {
                            name: legendData2a,
                            type: 'line',
                            data: [],
                            showSymbol: false
                        }];
                        legendDataa = [legendData1a];
                    } else if(type1) {
                        seriesFetchData = [{
                            name: legendData2a,
                            type: 'line',
                            smooth: true,
                            itemStyle: {
                                normal: {
                                    areaStyle: {
                                        type: 'default'
                                    }
                                }
                            },
                            data: data.newNum1a,
                            showSymbol: true
                        }, {
                            name: legendData1a,
                            type: 'line',
                            data: [],
                            showSymbol: false
                        }];
                        legendDataa = [legendData2a];
                    } else {
                        return;
                    }
                    if(group == 1) {
                        myCharta.setOption({
                            xAxis: {
                                data: data.hoursa

                            },
                            series: seriesFetchData
                        });
                    }
                    if(group == 2) {
                        myCharta.setOption({
                            xAxis: {
                                data: data.daysa

                            },
                            series: seriesFetchData
                        });
                    }
                    if(group == 3) {

                        myCharta.setOption({

                            legend: {
                                data: legendDataa
                            },
                            xAxis: {
                                data: data.weeksa

                            },
                            series: seriesFetchData
                        });
                    }
                });
            }
        });
    }

    $(function() {
        $.ajax({
            type: 'POST',
            async: false,
            url: '${pageContext.request.contextPath}/back_course/get_chart.action?course_id=${course_id}',

            dataType: 'json',
            success: function(d) {
                var list = d.studyTimeViews;
                studyTimeViewsa = list;
                study_timea = 0.0;
                var avgCount = 0.0;
                var html = "";
                for(var i = 0; i < list.length; i++) {
                    hoursa[i] = list[i].hours;
                    newNuma[i] = list[i].count;
                    newNum1a[i] = list[i].user_count;
                    totalCounta += list[i].count;
                    totalUserCounta += list[i].user_count;
                    study_timea += list[i].study_time;
                    var _avg = list[i].avg * 1.0 / 1000 / 60;
                    avgCount += _avg;
                    html += "<tr>";
                    html += "<td>" + list[i].hours + "</td>";
                    html += "<td>" + list[i].count + "</td>";
                    html += "<td>" + list[i].user_count + "</td>";
                    html += "<td>" + _avg.toFixed(2) + "分钟</td>";
                    html += "</tr>";
                }
                html += "<tr>";
                html += "<td>汇总</td>";
                html += "<td>" + totalCounta + "</td>";
                html += "<td>" + totalUserCounta + "</td>";
                html += "<td>" + avgCount.toFixed(2) + "分钟</td>";
                html += "</tr>";
                $("#databodya").html("");
                $("#databodya").append(html);

                if(totalCounta != 0) {
                    avga = study_timea / 1000 / 60 / totalCounta;
                    userAvga = study_timea / 1000 / 60 / totalUserCounta;
                }else{
                    avga = 0.0;
                    userAvga = 0.0;
                }
                $("#totalCounta").html(totalCounta);
                $("#totalUserCounta").html(totalUserCounta);
                $("#avga").html(avga.toFixed(2) + "分钟");
                $("#userAvga").html(userAvga.toFixed(2) + "分钟");
            }
        });
    });
    //基于准备好的dom，初始化echarts实例
    var myCharta = echarts.init(document.getElementById('resourceStatsa'));

    var legendData1a = '观看次数';
    var legendData2a = '观看人数';
    var legendDataa = [legendData1a];
    var seriesDataa = [{
        name: legendData1a,
        type: 'line',
        smooth: true,
        itemStyle: {
            normal: {
                areaStyle: {
                    type: 'default'
                }
            }
        },
        data: [],

    }];
    option = {
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            data: legendDataa
        },

        calculable: true,
        xAxis: [{
            name: '(时间)',
            type: 'category',
            boundaryGap: false,
            data: [] //横坐标

        }],
        yAxis: [{
            type: 'value',
            name: '(次)'
        }],
        series: seriesDataa
    };

    myCharta.showLoading();
    fetchDataa(function(data) {
        myCharta.hideLoading();
        var seriesFetchData = [{
            // 根据名字对应到相应的系列
            name: legendData1a,
            data: data.newNuma,

        }];
        myCharta.setOption({
            xAxis: {
                data: data.hoursa

            },
            series: seriesFetchData
        });
    });
    // 使用刚指定的配置项和数据显示图表。
    myCharta.setOption(option);

    function fetchDataa(cb) {
        // 通过 setTimeout 模拟异步加载
        setTimeout(function() {
            cb({
                hoursa: hoursa,
                newNuma: newNuma,
                newNum1a: newNum1a,
                newNumComparea: newNumComparea,
                newNumCompare1a: newNumCompare1a,
                daysa: daysa,
                weeksa: weeksa
            });
        }, 1000);
    }

    function compare0a(index) {
        var isChecked = $(".compare" + index).prop("checked");
        var index2 = (index + 1) % 2;
        var name;
        if(timeType > 1) {
            return false;
        }
        if(index == 0) {
            name = "前一日";
        } else {
            name = "上一周期";
        }
        if(isChecked) {
            $(".compare" + index2).prop("checked", false);
            //显示
            $.ajax({
                type: 'POST',
                async: false,
                url: '${pageContext.request.contextPath}/back_course/get_chart_compare.action?course_id=${course_id}&index=' + index,
                data: {
                    timeType: timeType,
                    group: group
                },
                dataType: 'json',
                success: function(d) {
                    var list = d.studyTimeViews;
                    studyTimeViewsa = list;
                    newNumComparea = new Array();
                    newNumCompare1a = new Array();
                    for(var i = 0; i < list.length; i++) {

                        newNumComparea[i] = list[i].count;
                        newNumCompare1a[i] = list[i].user_count;

                    }

                    myCharta.showLoading();
                    option = myCharta.getOption();

                    myCharta.setOption(option);
                    fetchDataa(function(data) {
                        myCharta.hideLoading();
                        var seriesFetchData;
                        if(type0) {

                            seriesFetchData = [{

                                name: legendData1a,
                                type: 'line',
                                smooth: true,
                                itemStyle: {
                                    normal: {
                                        areaStyle: {
                                            type: 'default'
                                        }
                                    }
                                },
                                data: data.newNuma,
                                showSymbol: true
                            }, {
                                name: name,
                                type: 'line',
                                smooth: true,
                                itemStyle: {
                                    normal: {
                                        areaStyle: {
                                            type: 'default'
                                        }
                                    }
                                },
                                data: data.newNumComparea,
                                showSymbol: true
                            }];
                            legendDataa = [legendData1a, name];
                        } else if(type1) {
                            seriesFetchData = [{
                                name: legendData2a,
                                type: 'line',
                                smooth: true,
                                itemStyle: {
                                    normal: {
                                        areaStyle: {
                                            type: 'default'
                                        }
                                    }
                                },
                                data: data.newNum1a,
                                showSymbol: true
                            }, {
                                name: name,
                                type: 'line',
                                smooth: true,
                                itemStyle: {
                                    normal: {
                                        areaStyle: {
                                            type: 'default'
                                        }
                                    }
                                },
                                data: data.newNumCompare1a,
                                showSymbol: true
                            }];
                            legendDataa = [legendData2a, name];
                        } else {
                            return;
                        }
                        if(group == 1) {
                            var o = {

                                legend: {
                                    data: legendDataa
                                },
                                xAxis: {
                                    data: data.hoursa

                                },
                                series: seriesFetchData
                            };
                            myCharta.setOption(o);
                        }
                        if(group == 2) {

                            myCharta.setOption({

                                legend: {
                                    data: legendDataa
                                },
                                xAxis: {
                                    data: data.daysa

                                },
                                series: seriesFetchData
                            });
                        }
                        if(group == 3) {

                            myCharta.setOption({

                                legend: {
                                    data: legendDataa
                                },
                                xAxis: {
                                    data: data.weeksa

                                },
                                series: seriesFetchData
                            });
                        }
                    });

                }
            });

        } else {
            myCharta.showLoading();
            option = myCharta.getOption();

            myCharta.setOption(option);
            fetchDataa(function(data) {
                myCharta.hideLoading();
                var seriesFetchData;
                if(type0) {

                    seriesFetchData = [{

                        name: legendData1a,
                        type: 'line',
                        smooth: true,
                        itemStyle: {
                            normal: {
                                areaStyle: {
                                    type: 'default'
                                }
                            }
                        },
                        data: data.newNuma,
                        showSymbol: true
                    }, {
                        name: name,
                        type: 'line',
                        data: [],
                        showSymbol: false
                    }];
                    legendDataa = [legendData1a];
                } else if(type1) {
                    seriesFetchData = [{
                        name: legendData2a,
                        type: 'line',
                        smooth: true,
                        itemStyle: {
                            normal: {
                                areaStyle: {
                                    type: 'default'
                                }
                            }
                        },
                        data: data.newNum1a,
                        showSymbol: true
                    }, {
                        name: name,
                        type: 'line',
                        data: [],
                        showSymbol: false
                    }];
                    legendDataa = [legendData2a];
                } else {
                    return;
                }
                if(group == 1) {
                    var o = {

                        legend: {
                            data: legendDataa
                        },
                        xAxis: {
                            data: data.hoursa

                        },
                        series: seriesFetchData
                    };
                    myCharta.setOption(o);
                }
                if(group == 2) {

                    myCharta.setOption({

                        legend: {
                            data: legendDataa
                        },
                        xAxis: {
                            data: data.daysa

                        },
                        series: seriesFetchData
                    });
                }
                if(group == 3) {

                    myCharta.setOption({

                        legend: {
                            data: legendDataa
                        },
                        xAxis: {
                            data: data.weeksa

                        },
                        series: seriesFetchData
                    });
                }
            });

        }

    }
    $("#export").click(function() {

        var form = $("<form>"); //定义一个form表单
        form.attr("style", "display:none");
        form.attr("target", "");
        form.attr("method", "post");
        form.attr("action", $(this).attr("href"));

        var input3 = $("<input>");
        input3.attr("type", "hidden");
        input3.attr("name", "studyTimeViews");
        input3.attr("value", (JSON.stringify(studyTimeViewsa)));
        var input4 = $("<input>");
        input4.attr("type", "hidden");
        input4.attr("name", "group");
        input4.attr("value", group);

        $("body").append(form); //将表单放置在web中

        form.append(input3);
        form.append(input4);
        form.submit(); //表单提交 });
    });

    function getTime(date) {
        var checkTime = "";
        if(date != "") {
            var dateArr = date.split("-");
            var checkDate = new Date();
            checkDate.setFullYear(dateArr[0], dateArr[1] - 1, dateArr[2]);
            checkTime = checkDate.getTime();
        }
        return checkTime;
    }
    /**********************************讨论********************************/
    var hours = new Array();
    var days = new Array();
    var weeks = new Array();
    var newNum = new Array();
    var newNum1 = new Array();
    var timeType = 0;
    var group = 1;
    var type0 = true;
    var type1 = false;
    var totalCount = 0;
    var totalUserCount = 0;
    var avg = 0.0;
    var userAvg = 0.0;
    var study_time = 0.0;
    var newNumCompare = new Array();
    var newNumCompare1 = new Array();
    var studyTimeViews;
    function queryTrendBylogType(type) {

        if(!$("#logTypeb>a").eq(type).is(".active")) {
            $("#logTypeb>a").eq(type).addClass("active");
        } else {
            $("#logTypeb>a").eq(type).removeClass("active");
        }

        if(type == 0) {
            type0 = !type0;
        }

        if(type == 1) {
            type1 = !type1;
        }

        myChart.showLoading();
        option = myChart.getOption();

        myChart.setOption(option);
        fetchData(function(data) {
            myChart.hideLoading();
            var seriesFetchData;
            if(type0 && type1) {
                seriesFetchData = [{
                    name: legendData2,
                    type: 'line',
                    smooth: true,
                    itemStyle: {
                        normal: {
                            areaStyle: {
                                type: 'default'
                            }
                        }
                    },
                    data: data.newNum1,
                    showSymbol: true
                }, {
                    name: legendData1,
                    type: 'line',
                    smooth: true,
                    itemStyle: {
                        normal: {
                            areaStyle: {
                                type: 'default'
                            }
                        }
                    },
                    data: data.newNum,
                    showSymbol: true
                }];
                legendData = [legendData2, legendData1];
            } else if(type0) {

                seriesFetchData = [{

                    name: legendData1,
                    type: 'line',
                    smooth: true,
                    itemStyle: {
                        normal: {
                            areaStyle: {
                                type: 'default'
                            }
                        }
                    },
                    data: data.newNum,
                    showSymbol: true
                }, {
                    name: legendData2,
                    type: 'line',
                    data: [],
                    showSymbol: false
                }];
                legendData = [legendData1];
            } else if(type1) {
                seriesFetchData = [{
                    name: legendData2,
                    type: 'line',
                    smooth: true,
                    itemStyle: {
                        normal: {
                            areaStyle: {
                                type: 'default'
                            }
                        }
                    },
                    data: data.newNum1,
                    showSymbol: true
                }, {
                    name: legendData1,
                    type: 'line',
                    data: [],
                    showSymbol: false
                }];
                legendData = [legendData2];
            } else {
                return;
            }
            if(group == 1) {
                var o = {

                    legend: {
                        data: legendData
                    },
                    xAxis: {
                        data: data.hours

                    },
                    series: seriesFetchData
                };
                myChart.setOption(o);
            }
            if(group == 2) {

                myChart.setOption({

                    legend: {
                        data: legendData
                    },
                    xAxis: {
                        data: data.days

                    },
                    series: seriesFetchData
                });
            }
            if(group == 3) {

                myChart.setOption({

                    legend: {
                        data: legendData
                    },
                    xAxis: {
                        data: data.weeks
                        
					},
					series: seriesFetchData
					});
				}
			});
		}

    function queryTrendByTimeType(index) {
        timeType = index;
        $("#timeTypeb>a").eq(index-1).addClass("active").siblings().removeClass("active");
        if(index > 1) {
            $(".compare_info").hide();
        } else {
            $(".compare_info").show();
        }
        var startTime;
        var endTime;
        if(index == 5) {
            $("#timeTypeb>a").removeClass("active");
            startTime = $("#start_time").datebox("getValue");
            endTime = $("#end_time").datebox("getValue");
            var checkTime1 = getTime(startTime);
            var checkTime2 = getTime(endTime);
            if(startTime == "") {
                alert("请输入开始时间");
                return false;
            }
            if(endTime == "") {
                alert("请输入结束时间");
                return false;
            }
            if(checkTime2 - checkTime1 <= 0) {
                alert("结束时间要大于开始时间");
                return false;
            } else {
                if((checkTime2 - checkTime1) / 1000 / 60 / 60 / 24 > 7) {
                    $("#week").removeClass("inactive");
                } else if(group == 3) {
                    $("#week").addClass("inactive");
                    $("#timeTypeb>a").eq(0).addClass("active").siblings().removeClass("active");
                    group = 1;
                }
            }
        }
        $.ajax({
            type: 'POST',
            async: false,
            url: '${pageContext.request.contextPath}/back_course/get_chart1.action?course_id=${course_id}',
            data: {
                timeType: timeType,
               /*  group: group, */
                endTime: endTime,
                startTime: startTime
            },
            dataType: 'json',
            success: function(d) {
                days = new Array();
                hours = new Array();
                weeks = new Array();
                newNum = new Array();
                newNum1 = new Array();
                totalCount = 0;
                totalUserCount = 0;
                study_time = 0.0;
                var html = "";
                var list = d.studyTimeViews;
                studyTimeViews = list;
                for(var i = 0; i < list.length; i++) {
                    hours[i] = list[i].hours;
                    newNum[i] = list[i].question_count;
                    newNum1[i] = list[i].answer_count;
                    days[i] = list[i].days;
                    weeks[i] = "第" + (i + 1) + "周";

                    totalCount += list[i].question_count;
                    totalUserCount += list[i].answer_count;

                    html += "<tr>";
                    if(group == 1) {
                        html += "<td>" + list[i].hours + "</td>";
                    } else if(group == 2) {
                        html += "<td>" + list[i].days + "</td>";
                    } else {
                        html += "<td>第" + (i + 1) + "周</td>";
                    }
                    html += "<td>" + list[i].question_count + "</td>";
                    html += "<td>" + list[i].answer_count + "</td>";

                    html += "</tr>";
                }
                html += "<tr>";
                html += "<td>汇总</td>";
                html += "<td>" + totalCount + "</td>";
                html += "<td>" + totalUserCount + "</td>";

                html += "</tr>";
                $("#databody").html("");
                $("#databody").append(html);
                if(totalCount != 0) {

                    avg = study_time / 1000 / 60 / totalCount;
                    userAvg = study_time / 1000 / 60 / totalUserCount;
                }
                $("#totalCount").html(totalCount);
                $("#totalUserCount").html(totalUserCount);
                $("#avg").html(avg.toFixed(2) + "分钟");
                $("#userAvg").html(userAvg.toFixed(2) + "分钟");
                myChart.showLoading();
                fetchData(function(data) {
                    myChart.hideLoading();
                    var seriesFetchData;
                    if(type0 && type1) {
                        seriesFetchData = [{
                            name: legendData2,
                            type: 'line',
                            smooth: true,
                            itemStyle: {
                                normal: {
                                    areaStyle: {
                                        type: 'default'
                                    }
                                }
                            },
                            data: data.newNum1,
                            showSymbol: true
                        }, {
                            name: legendData1,
                            type: 'line',
                            smooth: true,
                            itemStyle: {
                                normal: {
                                    areaStyle: {
                                        type: 'default'
                                    }
                                }
                            },
                            data: data.newNum,
                            showSymbol: true
                        }];
                        legendData = [legendData2, legendData1];
                    } else if(type0) {

                        seriesFetchData = [{

                            name: legendData1,
                            type: 'line',
                            smooth: true,
                            itemStyle: {
                                normal: {
                                    areaStyle: {
                                        type: 'default'
                                    }
                                }
                            },
                            data: data.newNum,
                            showSymbol: true
                        }, {
                            name: legendData2,
                            type: 'line',
                            data: [],
                            showSymbol: false
                        }];
                        legendData = [legendData1];
                    } else if(type1) {
                        seriesFetchData = [{
                            name: legendData2,
                            type: 'line',
                            smooth: true,
                            itemStyle: {
                                normal: {
                                    areaStyle: {
                                        type: 'default'
                                    }
                                }
                            },
                            data: data.newNum1,
                            showSymbol: true
                        }, {
                            name: legendData1,
                            type: 'line',
                            data: [],
                            showSymbol: false
                        }];
                        legendData = [legendData2];
                    } else {
                        return;
                    }
                    if(group == 1) {
                        myChart.setOption({
                            xAxis: {
                                data: data.hours

                            },
                            series: seriesFetchData
                        });
                    }
                    if(group == 2) {
                        myChart.setOption({
                            xAxis: {
                                data: data.days

                            },
                            series: seriesFetchData
                        });
                    }
                    if(group == 3) {

                        myChart.setOption({

                            legend: {
                                data: legendData
                            },
                            xAxis: {
                                data: data.weeks

                            },
                            series: seriesFetchData
                        });
                    }
                });
            }
        });
    }
    $(function() {
        $.ajax({
            type: 'POST',
            async: false,
            url: '${pageContext.request.contextPath}/back_course/get_chart1.action?course_id=${course_id}',

            dataType: 'json',
            success: function(d) {
                var list = d.studyTimeViews;
                studyTimeViews = list;
                study_time = 0.0;
                var html = "";
                for(var i = 0; i < list.length; i++) {
                    hours[i] = list[i].hours;
                    newNum[i] = list[i].question_count;
                    newNum1[i] = list[i].answer_count;
                    totalCount += list[i].question_count;
                    totalUserCount += list[i].answer_count;

                    html += "<tr>";
                    if(group == 1) {
                        html += "<td>" + list[i].hours + "</td>";
                    } else if(group == 2) {
                        html += "<td>" + list[i].days + "</td>";
                    } else {
                        html += "<td>第" + (i + 1) + "周</td>";
                    }
                    html += "<td>" + list[i].question_count + "</td>";
                    html += "<td>" + list[i].answer_count + "</td>";

                    html += "</tr>";
                }
                html += "<tr>";
                html += "<td>汇总</td>";
                html += "<td>" + totalCount + "</td>";
                html += "<td>" + totalUserCount + "</td>";

                html += "</tr>";
                $("#databody").html("");
                $("#databody").append(html);

                if(totalCount != 0) {

                    avg = study_time / 1000 / 60 / totalCount;
                    userAvg = study_time / 1000 / 60 / totalUserCount;
                }
                $("#totalCount").html(totalCount);
                $("#totalUserCount").html(totalUserCount);
                $("#avg").html(avg.toFixed(2) + "分钟");
                $("#userAvg").html(userAvg.toFixed(2) + "分钟");
            }
        });
    });
    //基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('resourceStats'));

    var legendData1 = '提问数';
    var legendData2 = '回复数';
    var legendData = [legendData1];
    var seriesData = [{
        name: legendData1,
        type: 'line',
        smooth: true,
        itemStyle: {
            normal: {
                areaStyle: {
                    type: 'default'
                }
            }
        },
        data: [],

    }];
    option = {
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            data: legendData
        },

        calculable: true,
        xAxis: [{
            name: '(时间)',
            type: 'category',
            boundaryGap: false,
            data: [] //横坐标

        }],
        yAxis: [{
            type: 'value',
            name: '(次)'
        }],
        series: seriesData
    };

    myChart.showLoading();
    fetchData(function(data) {
        myChart.hideLoading();
        var seriesFetchData = [{
            // 根据名字对应到相应的系列
            name: legendData1,
            data: data.newNum,

        }];
        myChart.setOption({
            xAxis: {
                data: data.hours

            },
            series: seriesFetchData
        });
    });
    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);

    function fetchData(cb) {
        // 通过 setTimeout 模拟异步加载
        setTimeout(function() {
            cb({
                hours: hours,
                newNum: newNum,
                newNum1: newNum1,
                newNumCompare: newNumCompare,
                newNumCompare1: newNumCompare1,
                days: days,
                weeks: weeks
            });
        }, 1000);
    }

    function compare0(index) {
        var isChecked = $(".compare" + index).prop("checked");
        var index2 = (index + 1) % 2;
        var name;
        if(timeType > 1) {
            return false;
        }
        if(index == 0) {
            name = "前一日";
        } else {
            name = "上一周期";
        }
        if(isChecked) {
            $(".compare" + index2).prop("checked", false);
            //显示
            $.ajax({
                type: 'POST',
                async: false,
                url: '${pageContext.request.contextPath}/back_course/get_chart_compare1.action?class_id=${classView.id}&course_id=${classView.source_id}&index=' + index,
                data: {
                    timeType: timeType,
                    group: group
                },
                dataType: 'json',
                success: function(d) {
                    var list = d.studyTimeViews;
                    studyTimeViews = list;
                    newNumCompare = new Array();
                    newNumCompare1 = new Array();
                    for(var i = 0; i < list.length; i++) {

                        newNumCompare[i] = list[i].question_count;
                        newNumCompare1[i] = list[i].answer_count;

                    }

                    myChart.showLoading();
                    option = myChart.getOption();

                    myChart.setOption(option);
                    fetchData(function(data) {
                        myChart.hideLoading();
                        var seriesFetchData;
                        if(type0) {

                            seriesFetchData = [{

                                name: legendData1,
                                type: 'line',
                                smooth: true,
                                itemStyle: {
                                    normal: {
                                        areaStyle: {
                                            type: 'default'
                                        }
                                    }
                                },
                                data: data.newNum,
                                showSymbol: true
                            }, {
                                name: name,
                                type: 'line',
                                smooth: true,
                                itemStyle: {
                                    normal: {
                                        areaStyle: {
                                            type: 'default'
                                        }
                                    }
                                },
                                data: data.newNumCompare,
                                showSymbol: true
                            }];
                            legendData = [legendData1, name];
                        } else if(type1) {
                            seriesFetchData = [{
                                name: legendData2,
                                type: 'line',
                                smooth: true,
                                itemStyle: {
                                    normal: {
                                        areaStyle: {
                                            type: 'default'
                                        }
                                    }
                                },
                                data: data.newNum1,
                                showSymbol: true
                            }, {
                                name: name,
                                type: 'line',
                                smooth: true,
                                itemStyle: {
                                    normal: {
                                        areaStyle: {
                                            type: 'default'
                                        }
                                    }
                                },
                                data: data.newNumCompare1,
                                showSymbol: true
                            }];
                            legendData = [legendData2, name];
                        } else {
                            return;
                        }
                        if(group == 1) {
                            var o = {

                                legend: {
                                    data: legendData
                                },
                                xAxis: {
                                    data: data.hours

                                },
                                series: seriesFetchData
                            };
                            myChart.setOption(o);
                        }
                        if(group == 2) {

                            myChart.setOption({

                                legend: {
                                    data: legendData
                                },
                                xAxis: {
                                    data: data.days

                                },
                                series: seriesFetchData
                            });
                        }
                        if(group == 3) {

                            myChart.setOption({

                                legend: {
                                    data: legendData
                                },
                                xAxis: {
                                    data: data.weeks

                                },
                                series: seriesFetchData
                            });
                        }
                    });

                }
            });

        } else {
            myChart.showLoading();
            option = myChart.getOption();

            myChart.setOption(option);
            fetchData(function(data) {
                myChart.hideLoading();
                var seriesFetchData;
                if(type0) {

                    seriesFetchData = [{

                        name: legendData1,
                        type: 'line',
                        smooth: true,
                        itemStyle: {
                            normal: {
                                areaStyle: {
                                    type: 'default'
                                }
                            }
                        },
                        data: data.newNum,
                        showSymbol: true
                    }, {
                        name: name,
                        type: 'line',
                        data: [],
                        showSymbol: false
                    }];
                    legendData = [legendData1];
                } else if(type1) {
                    seriesFetchData = [{
                        name: legendData2,
                        type: 'line',
                        smooth: true,
                        itemStyle: {
                            normal: {
                                areaStyle: {
                                    type: 'default'
                                }
                            }
                        },
                        data: data.newNum1,
                        showSymbol: true
                    }, {
                        name: name,
                        type: 'line',
                        data: [],
                        showSymbol: false
                    }];
                    legendData = [legendData2];
                } else {
                    return;
                }
                if(group == 1) {
                    var o = {

                        legend: {
                            data: legendData
                        },
                        xAxis: {
                            data: data.hours

                        },
                        series: seriesFetchData
                    };
                    myChart.setOption(o);
                }
                if(group == 2) {

                    myChart.setOption({

                        legend: {
                            data: legendData
                        },
                        xAxis: {
                            data: data.days

                        },
                        series: seriesFetchData
                    });
                }
                if(group == 3) {

                    myChart.setOption({

                        legend: {
                            data: legendData
                        },
                        xAxis: {
                            data: data.weeks

                        },
                        series: seriesFetchData
                    });
                }
            });

        }

    }

</script>