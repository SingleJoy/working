<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>数据统计</title>

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
        // 统计数据展开与收起
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



    <style>
        .data_pic{float: left;width: 45%;margin-right: 20px;}
    </style>

</head>
<body>
<div class="main_content">
	<div class="main_head">
		<div class="main_head_content">
			<h3>资源排行
				<a class="download_data_btn" href="${pageContext.request.contextPath}/back_file_analyze/export_course_ranking.action?sort=${sort}&group=${group}<c:if test="${isDuration==0}">&startTime=${startTime}&endTime=${endTime}</c:if>
                       <c:if test="${isDuration==1}">&days=${days}</c:if>">
					<img src="${pageContext.request.contextPath}/frontstage/images/read_download.png">&nbsp;&nbsp;导出数据
				</a>

			</h3>
			<form id="stupid" action="${pageContext.request.contextPath}/back_file_analyze/to_file_ranking.action" method="post">
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
				</div>
				<br/>
				<br/>
				<div class="time">
					<div class="choose_date_01">
						<span>排行：</span>
						<input type="hidden" name="sort" id="sort" value="${sort}">
						<a onclick="queryBySort(this,'0');" class="<c:if test="${sort=='0' and group=='1'}">active</c:if><c:if test="${group=='0'}">inactive</c:if>" href="javascript:void(0);">上传</a>
						<a onclick="queryBySort('1');" class="<c:if test="${sort=='1'}">active</c:if>" href="javascript:void(0);">收藏</a>
						<a onclick="queryBySort('2');" class="<c:if test="${sort=='2'}">active</c:if>" href="javascript:void(0);">购买</a>
						<a onclick="queryBySort('3');" class="<c:if test="${sort=='3'}">active</c:if>" href="javascript:void(0);">下载</a>
						<a onclick="queryBySort('4');" class="<c:if test="${sort=='4'}">active</c:if>" href="javascript:void(0);">点击</a>
					</div>

				</div>
				<br/>
				<br/>
				<div class="time">
					<div class="choose_date_01">
						<span>分组：</span>
						<select name="group" id="group" onchange="queryByGroup(this.value);" >
						<option value="0" <c:if test="${group eq '0'}">selected="selected"</c:if> >资源</option>
						<option value="1" <c:if test="${group eq '1'}">selected="selected"</c:if> >用户</option>
						</select>
					</div>

				</div>
				<br/>
				<br/>

			</form>
		</div>

	</div>

	 <div class="main_body" style="min-height: 600px;">


        <div style="margin-bottom: 50px;clear: both;margin-left: -13px;margin-top: 36px;" id="data_pic">
            <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
            <div id="fileRank" style="width: 1000px; height: 350px;">

            </div>

        </div>
        <div class="time" style="clear: both;margin-top: 60px;padding-left: 20px;">
            <table class="table_sta" style="width: 85%;">
                <thead>
                <tr>
                    <th style="width: 18%;"><c:if test="${group eq '0'}">资源</c:if><c:if test="${group eq '1'}">用户</c:if></th>
                    <th style="width: 16%;">上传量</th>
                    <th style="width: 16%;">收藏量</th>
                    <th style="width: 16%;">购买量</th>
                    <th style="width: 16%;">下载量</th>
                    <th style="width: 16%;">点击量</th>
                </tr>
                </thead>
                <tbody id="databody">
                </tbody>
            </table>
        </div>




    </div>

</div>

<script type="text/javascript">
    var newNum = new Array();
    var title = new Array();
    $(function(){
        $.ajax({
            type : 'POST',
            async :false,
            url : '${pageContext.request.contextPath}/back_file_analyze/query_file_ranking.action',
            data :{
            	sort : "${sort}",
            	group : "${group}",
            	days : "${days}",
                startTime : "${startTime}",
                endTime : "${endTime}"
            },
            dataType : 'json',
            success : function(d) {
                var list = d!=null?d.list:"";
                var tbody = '';
                if(list.length>0){
                    for(var i=0;i<list.length;i++){
                    	if("${group}"=="0"){//按资源分组
                    		title[i] = list[i].filename;
                    		tbody += '<tr><td>'+title[i]+'</td><td>--</td><td>'+list[i].collectionNum+'</td><td>'+list[i].buyNum+'</td><td>'+list[i].downLoadNum+'</td><td>'+list[i].clickNum+'</td></tr>';
                    	}else if("${group}"=="1"){//按人分组
                    		title[i] = list[i].username;
                    		tbody += '<tr><td>'+title[i]+'</td><td>'+list[i].uploadNum+'</td><td>'+list[i].collectionNum+'</td><td>'+list[i].buyNum+'</td><td>'+list[i].downLoadNum+'</td><td>'+list[i].clickNum+'</td></tr>';
                    	}
                    	if("${sort}"=="0"){
                    		newNum[i] = list[i].uploadNum;
                    	}else if("${sort}"=="1"){
                    		newNum[i] = list[i].collectionNum;
                    	}else if("${sort}"=="2"){
                    		newNum[i] = list[i].buyNum;
                    	}else if("${sort}"=="3"){
                    		newNum[i] = list[i].downLoadNum;
                    	}else if("${sort}"=="4"){
                    		newNum[i] = list[i].clickNum;
                    	}
                    }
                }
                $("#databody").html(tbody); 
            }
        });
    });
    var legend0 = "上传";
    if("${sort}"=="1"){
    	legend0 = "收藏";
    }else if("${sort}"=="2"){
    	legend0 = "购买";
    }else if("${sort}"=="3"){
    	legend0 = "下载";
    }else if("${sort}"=="4"){
    	legend0 = "点击";
    }
  //基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('fileRank'));
    option = {
    	color: ['#3398DB'], 
    	/* color : function(params){
    		var colorList = ['#ff7e50', '#97d3f9', '#dd70d9', '#34cf34','#6497ef'];
    		return colorList[params.dataIndex];
    	}, */
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'cross',
                crossStyle: {
                    color: '#999'
                }
            },
            formatter:  '{b}<br/><span style="display:inline-block;margin-right:5px;border-radius:10px;width:9px;height:9px;background-color:#3398DB"></span>{a}:{c}'
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        toolbox: {
        	show : true,
        	left :'900',
            right: '50',
            feature: {
                magicType: {show: true, type: ['line', 'bar']}
            }
        }, 
        legend: {
            data:[legend0]
        }, 
        xAxis: [
            {
                type: 'category',
                data: [],
                axisPointer: {
                    type: 'shadow'
                },
                silent: false,
                splitLine: {
                    show: false
                },
                axisLabel: {
                	interval: 0,  
                    formatter:function(value)  
                    {  
                        var ret = "";//拼接加\n返回的类目项  
                        var maxLength = 15;//每项显示文字个数  
                        var valLength = value.length;//X轴类目项的文字个数  
                        var rowN = Math.ceil(valLength / maxLength); //类目项需要换行的行数  
                        if (rowN > 1)//如果类目项的文字大于15,  
                        {  
                            for (var i = 0; i < rowN; i++) {  
                                var temp = "";//每次截取的字符串  
                                var start = i * maxLength;//开始截取的位置  
                                var end = start + maxLength;//结束截取的位置  
                                //这里也可以加一个是否是最后一行的判断，但是不加也没有影响，那就不加吧  
                                temp = value.substring(start, end) + "\n";  
                                ret += temp; //凭借最终的字符串  
                            }  
                            return ret;  
                        }  
                        else {  
                            return value;  
                        }  
                    }  
                }
            }
        ],
        yAxis: [
            {
                type: 'value',
                show: true,
                interval: 'auto',
                axisLabel: {
                    formatter: '{value}'
                }
            }
        ],
        series: [
            {
                name:legend0,
                type:'bar',
                data:[],
                animationDelay: function (idx) {
                    return idx * 10;
                }
            }
        ],
        animationEasing: 'elasticOut',
        animationDelayUpdate: function (idx) {
            return idx * 5;
        }
    };
    myChart.showLoading();
    fetchData(function(data) {
        myChart.hideLoading();
        var seriesFetchData = [{
            // 根据名字对应到相应的系列
            name : legend0,
            data : data.newNum
        } ];
        myChart.setOption({
            xAxis : {
                data : data.title
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
				title : title,
				newNum : newNum,
			});
		}, 1000);
	}
    
    function queryBySort(value){
    	if(arguments.length==2){
    		if(arguments[0].tagName=="A"){
    			var className = arguments[0].className;
        		if(className.indexOf("inactive")>-1){
        			return;
        		}else{
        			value = arguments[1];
        		}
    		}
    	}
    	if(value!=null&&value!=""){
    		$("#sort").val(value);
    		$("#stupid").submit();
    	}
    }
    
    function queryByGroup(value){
    	if(value!=null&&value!=""){
    		if(value=="0"&&$("#sort").val()=="0"){
    			$("#sort").val("1")
    		}
    		$("#stupid").submit();
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
        var value = document.getElementById("group").selectedIndex;
        if(value=="1"&&$("#sort").val()=="0"){
			$("#sort").val("1")
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
                    var value = document.getElementById("group").selectedIndex;
                    if(value=="1"&&$("#sort").val()=="0"){
            			$("#sort").val("1")
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
</script>

</body>

</html>