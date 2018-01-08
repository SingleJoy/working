<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/jquery.1.10.2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/echarts.min.js"></script>

<style>


    @media  (max-width: 1025px){
        .echarts>div{width:760px;}
    }
    @media  (min-width: 992px) and (max-width: 1024px) {
        .echarts>div{width:680px;}
    }
    @media  (min-width: 900px) and (max-width: 991px) {
        .echarts>div{width:515px;}
    }
</style>

<div class="cn-wrap">

    <div id="content-container" class="container">
        <jsp:include page="/frontstage/base/personalCenter/personal_header.jsp"></jsp:include>

        <div class="row row-3-9">

            <jsp:include page="/frontstage/base/personalCenter/personal_left.jsp"></jsp:include>

            <div class="col-lg-9 col-md-9 col-sm-9">

                <div class="panel  panel-col">
                    <div class="panel-heading">
                        我的首页
                    </div>

                    <div  class="panel-body">
                        <form class="form-horizontal">

                            <div class="pull-right">

                                <a href="javascript:void(0);" id="month" class="btn btn-default btn-success">本月</a>

                                <a href="javascript:void(0);"  id="week" class="btn btn-default">本周</a>

                            </div>
                            <br/>

                            <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
                            <div class="my-group clearfix echarts" >
                                <div id="resourceStats" style="height:270px;"></div>
                                <hr/>

                                <div id="resourceStats1" style="height:270px;"></div>
                                <hr/>

                                <div id="resourceStats2" style="height:270px;"></div>
                            </div>
                        </form>


                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
    <script type="text/javascript">
        var days = new Array();
        var newNum = new Array();
        var resourceType = "${resourceType}";
        $("#week").click(function () {
            $.ajax({
                type : 'POST',
                async : false,
                url : '${pageContext.request.contextPath}/my_chart/query_my_stats_week.action',

                dataType : 'json',
                success : function(d) {
                    days = new Array();
                    newNum = new Array();
                    $("#week").addClass("btn-success").siblings().removeClass("btn-success");
                    var list = d.studyTimeViews;
                    for(var i=0;i<list.length;i++){
                        days[i] = list[i].days;
                        newNum[i] = list[i].study_time;

                    }

                    myChart.showLoading();
                    fetchData(function(data) {
                        myChart.hideLoading();
                        var seriesFetchData = [{
                       // 根据名字对应到相应的系列
                        name : legendData1,
                        data : data.newNum

                        }];
                        myChart.setOption({
                         
                            xAxis : {
                                data : data.days

                            },
                            series : seriesFetchData
                        });
                    });
                }
            });
        });
        $("#month").click(function () {
            $.ajax({
                type : 'POST',
                async : false,
                url : '${pageContext.request.contextPath}/my_chart/query_my_stats.action',

                dataType : 'json',
                success : function(d) {
                    days = new Array();
                    newNum = new Array();
                    $("#month").addClass("btn-success").siblings().removeClass("btn-success");
                    var list = d.studyTimeViews;
                    for(var i=0;i<list.length;i++){
                        days[i] = list[i].days;
                        newNum[i] = list[i].study_time;

                    }

                    myChart.showLoading();
                    fetchData(function(data) {
                        myChart.hideLoading();
                        var seriesFetchData = [{
                            // 根据名字对应到相应的系列
                            name : legendData1,
                            data : data.newNum
                        }];
                        myChart.setOption({
                            xAxis : {
                                data : data.days

                            },
                            series : seriesFetchData
                        });
                    });
                }
            });
        });
        $(function(){
            $.ajax({
                type : 'POST',
                async : false,
                url : '${pageContext.request.contextPath}/my_chart/query_my_stats.action',

                dataType : 'json',
                success : function(d) {
                    var list = d.studyTimeViews;
                    for(var i=0;i<list.length;i++){
                        days[i] = list[i].days;
                        newNum[i] = list[i].study_time;
                    }
                }
            });
        });
        //基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('resourceStats'));
        var myChart1 = echarts.init(document.getElementById('resourceStats1'));
        var myChart2 = echarts.init(document.getElementById('resourceStats2'));
        option = {
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b}: {c} ({d}%)"
            },
            legend: {
                orient: 'vertical',
                x: 'right',
                data:['未完成课程','已完成课程']
            },
            series: [
                {
                    name:'课程完成情况',
                    type:'pie',
                    radius: ['50%', '70%'],
                    avoidLabelOverlap: false,
                    label: {
                        normal: {
                            show: false,
                            position: 'center'
                        },
                        emphasis: {
                            show: true,
                            textStyle: {
                                fontSize: '20',
                                fontWeight: 'bold'
                            }
                        }
                    },
                    labelLine: {
                        normal: {
                            show: false
                        }
                    },
                    data:[
                        {value:'${userCenter.studyCourse }', name:'未完成课程'},
                        {value:'${userCenter.studyedCourse }', name:'已完成课程'},

                    ]
                }
            ]
        };
        myChart1.setOption(option);

        option = {
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b}: {c} ({d}%)"
            },
            legend: {
                orient: 'vertical',
                x: 'right',
                data:['未完成培训','已完成培训']
            },
            series: [
                {
                    name:'培训完成情况',
                    type:'pie',
                    radius: ['50%', '70%'],
                    avoidLabelOverlap: false,
                    label: {
                        normal: {
                            show: false,
                            position: 'center'
                        },
                        emphasis: {
                            show: true,
                            textStyle: {
                                fontSize: '20',
                                fontWeight: 'bold'
                            }
                        }
                    },
                    labelLine: {
                        normal: {
                            show: false
                        }
                    },
                    data:[
                        {value:'${userCenter.studyedTrain }', name:'未完成培训'},
                        {value:'${userCenter.studyTrain }', name:'已完成培训'},

                    ]
                }
            ]
        };
        myChart2.setOption(option);

        var legendData1 = '学习时长';

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
                    type : 'category',
                    boundaryGap : false,
                    data : []//横坐标
                }
            ],
            yAxis : [
                {
                    type : 'value',
                    name:'(分钟)'
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
                data : data.newNum
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
                    newNum : newNum
                });
            }, 1000);
        }




    </script>

