<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/jquery.1.10.2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/echarts.min.js"></script>
<style>
    .main_head{font-size: 16px;  }
    .main_body{margin-top: 20px;}
    .time>div{float: left;margin-right:20px;}
    /*.time{margin-bottom: 20px;}*/
    .select_time{}
    .select_time>span>input{width: 100px;}
    .select_time>span{margin-left: 10px;}
    .choose_date_01>a,.choose_date_02>a{color:#616161;text-decoration: none;margin-right: 5px;}
    .choose_date_01>a.active{display: inline-block;background-color: #4da7fd;color: #fff;padding:2px;}
    .choose_date_01>a.inactive{display: inline-block;background-color: #d9d2f0;color: #fff;padding:2px;}
    .choose_area{margin-right: 15px;}
    .choose_area>select,#isDuration{min-width: 100px;height: 30px;}
    .number{font-size: 20px;font-weight: bold;color: #e83d2c}
    .user_info{}
    .user_info>div{margin-right: 20px;display: inline-block;}
    .table_sta{border:1px solid #ddd;border-left: none;border-bottom: none;}
    .table_sta>thead>tr>th,.table_sta>tbody>tr>td{width: 150px;text-align: center;border-bottom: 1px solid #ddd;
        border-left: 1px solid #ddd;font-size: 14px;line-height: 30px;}
    .compare_info{text-align: center;}
    .compare_info>span{}
    .compare_info>div{display: inline-block;}
    #databody>tr>td{font-size: 14px;line-height: 25px;}

</style>
<div class="cn-wrap">

    <div id="content-container" class="container">
        <jsp:include page="class_header.jsp"></jsp:include>

        <div class="row row-3-9">

            <jsp:include page="class_left.jsp"></jsp:include>

            <div class="col-lg-9 col-md-9">

                <div class="panel  panel-col">
                    <div class="panel-heading">
                        <%--<a class="btn btn-success pull-right"  href="${pageContext.request.contextPath}/back_user/export_user_trend.action?&logType=${logType}&compare=${compare}">--%>
                        <%--导出数据--%>
                        <%--</a>--%>
                        课时学习统计

                    </div>

                    <div  class="panel-body">
                        <form class="form-horizontal">


                            <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
                            <div class="my-group">
                                <div id="resourceStats" style="width: 700px;height:270px;margin-top: 5px;"></div>
                            </div>

                            <div class="my-group">
                                <div class="col-md-10 col-md-offset-1">
                                    <table class="table table-striped">
                                        <thead>
                                        <tr>
                                            <th style="width: 10%;">排名</th>
                                            <th style="width: 50%">课时名称</th>
                                            <th style="width:40%;">观看次数</th>


                                        </tr>

                                        </thead>
                                        <tbody id="databody">
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                        </form>
                    </div>


                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
<script type="text/javascript">
    var days = new Array();
    var newNum = new Array();



    $(function(){

        $.ajax({
            type : 'POST',
            async : false,
            url : '${pageContext.request.contextPath}/course_chart/get_course_hour_chart.action?course_id=${classView.source_id}',

            dataType : 'json',
            success : function(d) {
                var list = d.studyTimeViews;
                var index=5;
                if(list.length<5){
                    index=list.length;
                }
                days[0]="";
                newNum[0]="";
                var html="";
                for(var i=0;i<index;i++){

                    days[i+1] = list[i].course_hour_title;
                    newNum[i+1] = list[i].count;
                    html+= "<tr>";
                    html+="<td>"+(i+1)+"</td>";
                    html+="<td>"+list[i].course_hour_title+"</td>";
                    html+="<td>"+list[i].count+"</td>";
                    html+= "</tr>";
                }
                $("#databody").html("");
                $("#databody").append(html);
                days[index+1]="";
                newNum[index+1]="";
            }
        });
    });
    //基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('resourceStats'));

    var legendData1='时长';

    var seriesData = [{
        name:'时长',
        type:'bar',

        itemStyle: {normal: {areaStyle: {type: 'default'}}},
        data:[],

    }];
    option = {title: {
        text: '课时观看排名',

        left: 'center',
        top: 10
    },
        tooltip : {
            trigger: 'axis'
        },
        legend: {

        },

        calculable : true,
        xAxis : [
            {
                type : 'category',
                boundaryGap : false,
                name:'(课时)',
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

