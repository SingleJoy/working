<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/jquery.1.10.2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/echarts.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/My97DatePicker/WdatePicker.js"></script>

<body class="easyui-layout" data-options="fit:true">

<div style="font:13.3333px Arial;z-index:9999; position: absolute;margin-left:63px;margin-top:2px;">
	年：<input id="year" value="${year}" type="text" style="width: 30px;" onfocus="selectYear();" />
	月：<input id="month" value="${month}" type="text" style="width: 30px;" onfocus="selectMonth();" />
	<input type="button" onclick="doSearchMonth();" value="查询" />
</div>

<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
<div id="orderstats" style="width: 780px;height:500px;margin-top: 10px;"></div>
<script type="text/javascript">
    var days = new Array();
    var orderNum = new Array();
    var amountNum = new Array();
    $(function(){
        $.ajax({
            type : 'POST',
            url : '${pageContext.request.contextPath}/back_order_stats/query_order_stats.action?year='+$("#year").val()+'&month='+$("#month").val(),
            dataType : 'json',
            success : function(d) {
                var list = d.obj;
                for(var i=0;i<list.length;i++){
                    days[i] = list[i].days;
                    orderNum[i] = list[i].orderNum;
                    amountNum[i] = list[i].amountNum;
                }
            }
        });
    });
    //基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('orderstats'));
    option = {
        title : {
            // text: '系统资源统计',
        },
        tooltip : {
            trigger: 'axis'
        },
        legend: {
            data:['订单数量','交易金额']
        },
        toolbox: {
            show : true,
            feature : {
                mark : {show: true},
                dataView : {show: true, readOnly: false},
                magicType : {show: true, type: ['line', 'bar', 'stack', 'tiled']},
                restore : {show: true},
                saveAsImage : {show: true}
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
        series : [
            {
                name:'订单数量',
                type:'line',
                smooth:true,
                itemStyle: {normal: {areaStyle: {type: 'default'}}},
                data:[]
            },
            {
                name:'交易金额',
                type:'line',
                stack: '总量',
                itemStyle: {normal: {areaStyle: {type: 'default'}}},
                data:[]
            }
        ]
    };

    myChart.showLoading();
    fetchData(function(data) {
        myChart.hideLoading();
        myChart.setOption({
            xAxis : {
                data : data.days

            },
            series : [{
                // 根据名字对应到相应的系列
                name : '订单数量',
                data : data.orderNum
            },
                {
                    name:'交易金额',
                    data:data.amountNum
                }]
        });
    });
    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);


    function fetchData(cb) {
        // 通过 setTimeout 模拟异步加载
        setTimeout(function() {
            cb({
                days : days,
                orderNum : orderNum,
                amountNum : amountNum
            });
        }, 1000);
    }

    function selectYear(){
        WdatePicker({dateFmt: 'yyyy', isShowToday: false, isShowClear: false });
    }
    function selectMonth() {
        WdatePicker({dateFmt: 'MM', isShowToday: false, isShowClear: false });
    }

    function doSearchMonth(){
        var year = $("#year").val();
        if(year!=''){
            window.location.href = "${pageContext.request.contextPath}/back_order_stats/to_order_stats.action?year="+year+"&month="+$("#month").val();
        }else{
            parent.sy.messagerShow({
                msg : "请选择时间",
                title : '提示'
            });
        }
    }
</script>
</body>
