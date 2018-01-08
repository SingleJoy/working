<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<title>用户属性</title>

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
            <h3>用户属性</h3>
            <form id="stupid" method="post" action="${pageContext.request.contextPath}/back_user/to_user_property.action">
                <br>
                <div class="time">
                    <div class="choose_date_01">
                        <span>时间：</span>
                        <input type="hidden" name="timeType" id="timeType" value="${timeType}">
                        <a onclick="queryPopertyByTimeType(0);" class="<c:if test="${timeType=='0'}">active</c:if>" href="javascript:void(0);">最近30天</a>
                        <a onclick="queryPopertyByTimeType(1);" class="<c:if test="${timeType=='1'}">active</c:if>" href="javascript:void(0);">最近2个月</a>
                        <a onclick="queryPopertyByTimeType(2);" class="<c:if test="${timeType=='2'}">active</c:if>" href="javascript:void(0);">最近3个月</a>
                        <a onclick="queryPopertyByTimeType(3);" class="<c:if test="${timeType=='3'}">active</c:if>" href="javascript:void(0);">最近6个月</a>
                        <input id="days" name="days" value="<c:if test="${empty days}">选择月份</c:if><c:if test="${!empty days}">${days}</c:if>" type="text" style="height: 25px;width: 84px;font-size:16px;" onfocus="selectYearandMonth();" />
                    </div>
                </div>
                <br/>
                <br/>
            </form>
        </div>
    </div>
    <div class="main_body" style="min-height: 600px;">
        <br/>
        <br/>
        <br/>
        <div class="data_pic" style="margin-left: 20px;">
            <h4>性别比例</h4>
            <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
            <div id="sexRatio" style="width: 500px;height:428px;margin-top: 30px;">
            </div>
        </div>
        <div class="data_pic" >
            <h4>年龄分布</h4>
            <div id="ageDistribution" style="width: 500px;height:400px;margin-top: 30px;">
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
    Date.prototype.Format = function (fmt) {
        //author: meizz
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
    var newNum = new Array();
    var ageInterval = new Array();
    var menNum = 0;
    var womenNum = 0;
    $(function(){
        $.ajax({
            type : 'POST',
            async :false,
            url : '${pageContext.request.contextPath}/back_user/query_user_property.action',
            data :{
                timeType : "${timeType}",
                days : "${days}",
                startTime : "${startTime}",
                endTime : "${endTime}"
            },
            dataType : 'json',
            success : function(d) {
                var list = d.userStatsList;
                var Num = d.menNum*1+d.womenNum*1;
                menNum = ((d.menNum/Num)*100).toFixed(2);
                womenNum = ((d.womenNum/Num)*100).toFixed(2);
                var total = 0;
                for(var i=0;i<list.length;i++){
                    total += list[i].newNum;
                    newNum[i] = list[i].newNum;
                    ageInterval[i] = list[i].ageInterval;
                }
                for(var i=0;i<newNum.length;i++){
                    newNum[i] = ((newNum[i]/total)*100).toFixed(2);
                }

            }
        });
    });

    //基于准备好的dom，初始化echarts实例
    var myChart1 = echarts.init(document.getElementById('sexRatio'));
    option1 = {
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'cross',
                crossStyle: {
                    color: '#999'
                }
            },
            formatter:'{b}<br/><span style="display:inline-block;margin-right:5px;border-radius:10px;width:9px;height:9px;background-color:#CD0000"></span>{a}:{c}%'
        },
        toolbox: {
            show : true,
            left :'400',
            right: '50',/* toolbox的右边被拉长，使本来被遮住的字体显示出来了 */
            feature: {
                magicType: {show: true, type: ['line', 'bar']}
            }
        },
        legend: {
            data:['男女比例']
        },
        xAxis: [
            {
                type: 'category',
                data: ['男','女'],
                axisPointer: {
                    type: 'shadow'
                },
                silent: false,
                splitLine: {
                    show: false
                }
            }
        ],
        yAxis: [
            {
                type: 'value',
                show: true,
                interval: 'auto',
                axisLabel: {
                    formatter: '{value}%'
                }
            }
        ],
        series: [
            {
                name:'男女比例',
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
    myChart1.showLoading();

    fetchData1(function(data) {
        myChart1.hideLoading();
        var seriesFetchData = [{
            // 根据名字对应到相应的系列
            name : '男女比例',
            data : [menNum, womenNum]
        }  ];
        myChart1.setOption({

            series : seriesFetchData
        });
    });
    // 使用刚指定的配置项和数据显示图表。
    myChart1.setOption(option1);

    function fetchData1(cb) {
        // 通过 setTimeout 模拟异步加载
        setTimeout(function() {
            cb({

            });
        }, 1000);
    }
    //基于准备好的dom，初始化echarts实例
    var myChart2 = echarts.init(document.getElementById('ageDistribution'));
    option2 = {
        color: ['#3398DB'],
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'cross',
                crossStyle: {
                    color: '#999'
                }
            },
            formatter:'{b}<br/><span style="display:inline-block;margin-right:5px;border-radius:10px;width:9px;height:9px;background-color:#3398DB"></span>{a}:{c}%'
        },
        toolbox: {
            show : true,
            left :'400',
            right: '50',/* toolbox的右边被拉长，使本来被遮住的字体显示出来了 */
            feature: {
                magicType: {show: true, type: ['line', 'bar']}
            }
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        legend: {
            data:['年龄分布']
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
                }
            }
        ],
        yAxis: [
            {
                type: 'value',
                show: true,
                interval: 'auto',
                axisLabel: {
                    formatter: '{value}%'
                }
            }
        ],
        series: [
            {
                name:'年龄分布',
                type:'bar',
                data:[],
                animationDelay: function (idx) {
                    return idx * 10 + 100;
                }
            }
        ],
        animationEasing: 'elasticOut',
        animationDelayUpdate: function (idx) {
            return idx * 5;
        }
    };
    myChart2.showLoading();
    fetchData2(function(data) {
        myChart2.hideLoading();
        var seriesFetchData = [{
            // 根据名字对应到相应的系列
            name : '年龄分布',
            data : data.newNum
        }  ];
        myChart2.setOption({
            xAxis : {
                data : data.ageInterval
            },
            series : seriesFetchData
        });
    });
    // 使用刚指定的配置项和数据显示图表。
    myChart2.setOption(option2);

    function fetchData2(cb) {
        // 通过 setTimeout 模拟异步加载
        setTimeout(function() {
            cb({
                ageInterval : ageInterval,
                newNum : newNum
            });
        }, 1000);
    }



    function queryPopertyByTimeType(value){
        $("#timeType").val(value);
        $("#days").val("");
        $("#stupid").submit();
    }

    function selectYearandMonth(){
        WdatePicker({dateFmt: 'yyyy年M月', isShowToday: false, isShowClear: false,maxDate:'%y年%M月',onpicked:function(){$("#timeType").val("");$("#stupid").submit(); } });
    }

</script>

</body>

