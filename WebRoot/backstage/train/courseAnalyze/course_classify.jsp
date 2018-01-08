<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<title>访问分析</title>

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
			<h3>课程分类统计
				<%-- <a class="download_data_btn" href="${pageContext.request.contextPath}/back_user/export_user_trend.action">
					<img src="${pageContext.request.contextPath}/frontstage/images/read_download.png">&nbsp;&nbsp;导出数据
				</a> --%>

			</h3>
			<form id="stupid" action="#">
				<input type="hidden" name="compare" id="compare" value="${compare}">
				<br/>
				<div class="time">
					<div id="timeTypea" class="choose_date_01">
						<span>时间：</span>
						<input type="hidden" name="timeType" id="timeType" value="${timeType}">
						<a href="javascript:;" onclick="queryTrendByTimeTypea(0);" class="active">今天</a>
						<a href="javascript:;" onclick="queryTrendByTimeTypea(1);" class="">昨天</a>
						<a href="javascript:;" onclick="queryTrendByTimeTypea(2);" class="">最近三天</a>
						<a href="javascript:;" onclick="queryTrendByTimeTypea(3);" class="">最近7天</a>
						<a href="javascript:;" onclick="queryTrendByTimeTypea(4);" class="">最近30天</a>
					</div>


					<div  class="select_time" >
						<span>开始日期：<input id="start_timea" name="startTime"  class="easyui-datebox" data-options="onSelect:onSelect,editable:false" style="width: 100px;" /></span>
						<span>结束日期：<input id="end_timea" name="endTime"  class="easyui-datebox" data-options="onSelect:onSelect,editable:false"  style="width: 100px;"/></span>
					</div> 

					<div id="timeUnita" class="choose_date_01">
						<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
						<a onclick="queryTrendByTimeUnita(this,1);" href="javascript:void(0);" title="根据小时统计" class="active">按时</a>
						<a onclick="queryTrendByTimeUnita(this,2);" href="javascript:void(0);" title="根据天统计" class="">按天</a>
						<a onclick="queryTrendByTimeUnita(this,3);" href="javascript:void(0);" id="week" class="inactive" title="根据周统计" class="">按周</a>
					</div>


				</div>
				<br/>
				<br/>

				<div class="time">
					<div class="choose_date_01 ">
						<span>分类：</span>
						<span class="choose_area">
		                    <select id="classifys" onchange="queryTrendByClassify(this.value);"  style="padding: 2px;height:25px;">
		                      <c:forEach items="${pcList}" var="pc">
									<option value="${pc.id}">${pc.classify_name}</option>";
									<c:forEach items="${classifyList}" var="classify">
										<c:if test="${pc.id == classify.parent_id }">
											<option value="${classify.id}">&nbsp;&nbsp;&nbsp;&nbsp;${classify.classify_name}</option>";
										</c:if>
									</c:forEach>
								</c:forEach>
		                    </select>
		                </span>
					</div>
				</div>
				<br/>
				<br/>
				<div class="time">
					<div id="logTypea" class="choose_date_01">
						<span >指标：</span>
						<a href="javascript:;" onclick="queryTrendBylogTypea('0');" class="active">观看次数</a>
						<a href="javascript:;" onclick="queryTrendBylogTypea('1');" class="">观看人数</a>
					</div>
				</div>
				<br/>

			</form>
		</div>

	</div>

	<div class="main_body">

		<div class="time user_info">
			<div>

				<span  title="课程视频观看次数">观看次数</span><br/>

				<label class="number" id="totalCounta"></label>
			</div>
			<div>
				<span  title="课程视频观看人数">观看人数</span><br/>
				<label class="number" id="totalUserCounta"></label>
			</div>
			<div>

				<span title="平均观看时长(次)">平均观看时长(次)</span><br/>

				<label class="number" id="avga"></label>
			</div>
			<div >

				<span title="平均观看时长(人)">平均观看时长(人)</span> <br/>

				<label class="number" id="userAvga"></label>
			</div>
		</div><br/><br/>

		<div class="fold_open"></div>

		<div id="data_title">趋势图</div>

		<div  style="margin-bottom: 50px;clear: both;margin-left: 20px;" id="data_pic">
			<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
			<div id="resourceStatsa" style="width: 1080px;height:350px;margin-top: 30px;margin-left:-84px;clear: both;"></div>


			<div id="compares" class="choose_date_01 " style="clear: both;<c:if test="${timeType=='2'||timeType=='3'||isDuration=='0'}">display:none</c:if>" >
				<div class="compare_info">
					<span>对比:</span>
					<div><input type="radio" onclick="compare0a(0);" value="0" class="compare0">&nbsp;前一日</div>
					<div><input type="radio" onclick="compare0a(1);" value="1" class="compare1">&nbsp;上一周期</div>
				</div>
			</div>


		</div>

		<div class="fold_close"></div>

		<div class="time" style="clear: both;margin-top: 50px;">
			<table class="table_sta">
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
    var hoursa = new Array();
    var daysa = new Array();
    var weeksa = new Array();
    var newNuma = new Array();
    var newNum1a = new Array();
    var select_classify_index = document.getElementById("classifys").selectedIndex;
    var classify_id = document.getElementById("classifys").options[select_classify_index].value;
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
    
    function queryTrendByClassify(value){
    	if(value!=""){
    		classify_id = value;
    	}
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
        $.ajax({
            type: 'POST',
            async: false,
            url: '${pageContext.request.contextPath}/back_course/get_chart.action',
            data: {
            	classify_id : classify_id,
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
            url: '${pageContext.request.contextPath}/back_course/get_chart.action',
            data: {
            	classify_id : classify_id,
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
                return false;
            }
            if(endTime == "") {
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
            url: '${pageContext.request.contextPath}/back_course/get_chart.action',
            data: {
            	classify_id : classify_id,
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
    
    function onSelect(date){
    	queryTrendByTimeTypea(5);
    }
   
    $(function() {
        $.ajax({
            type: 'POST',
            async: false,
            url: '${pageContext.request.contextPath}/back_course/get_chart.action',
            data: {
            	classify_id : classify_id
            },
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
                url: '${pageContext.request.contextPath}/back_course/get_chart_compare.action?index=' + index,
                data: {
                	classify_id : classify_id,
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
            
            var input5 = $("<input>");
            input5.attr("type", "hidden");
            input5.attr("name", "classify_id");
            input5.attr("value", classify_id);

            $("body").append(form); //将表单放置在web中

            form.append(input3);
            form.append(input4);
            form.append(input5);
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

    

</script>

</body>

