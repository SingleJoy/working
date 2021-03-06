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

	<style>
        .data_pic{float: left;width: 45%;margin-right: 20px;}
    </style>
</head>
<body>
<div class="main_content">
    <div class="main_head">
        <div class="main_head_content">
            <h3>学生报名</h3>
            <form id="stupid" method="post" action="${pageContext.request.contextPath}/back_user_study/to_stu_applay.action">
                <br>
                <div class="time">
                    <div class="choose_date_01">
                        <span>时间：</span>
                        <input type="hidden" name="timeType" id="timeType" value="${timeType}">
						<a onclick="queryByTimeType(0);" class="<c:if test="${timeType=='0'}">active</c:if>" href="javascript:void(0);">最近30天</a>
						<a onclick="queryByTimeType(1);" class="<c:if test="${timeType=='1'}">active</c:if>" href="javascript:void(0);">最近2个月</a>
						<a onclick="queryByTimeType(2);" class="<c:if test="${timeType=='2'}">active</c:if>" href="javascript:void(0);">最近3个月</a>
						<a onclick="queryByTimeType(3);" class="<c:if test="${timeType=='3'}">active</c:if>" href="javascript:void(0);">最近6个月</a>
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
        <div class="data_pic">
           <!--  <h4>地理分布</h4> -->
            <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
            <div id="areaDistribution" style="width: 500px;height:400px;margin-left: 20px;">
            </div>
        </div>
        <div class="data_pic">
            <!-- <h4>年龄分布</h4> -->
            <div id="ageDistribution" style="width: 500px;height:400px;">
            </div>
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
    var province = new Array();
    var series1 = new Array();
    var ageInterval = new Array();
    var series2 = new Array();
    $(function(){
        $.ajax({
            type : 'POST',
            async :false,
            url : '${pageContext.request.contextPath}/back_user_study/query_stu_applay.action',
            data :{
                timeType : "${timeType}",
                days : "${days}",
                startTime : "${startTime}",
                endTime : "${endTime}"
            },
            dataType : 'json',
            success : function(result) {
            	 //请求成功时执行该函数内容，result即为服务器返回的json对象
                $.each(result.list1, function (index, item) {
                	province.push(item.province);    //挨个取出类别并填入类别数组 
                	series1.push({ value: item.newNum,name: item.province});
                }); 
                myChart1.hideLoading();    //隐藏加载动画
                myChart1.setOption({        //加载数据图表                
                    legend: {
                        data: province
                    },
                    series: [{
                        data: series1
                    }]
                });
                //年龄分布
                $.each(result.list2, function (index, item) {
                	ageInterval.push(item.ageInterval);    //挨个取出类别并填入类别数组 
                	series2.push({ value: item.newNum,name: item.ageInterval});
                }); 
                myChart2.hideLoading();    //隐藏加载动画
                myChart2.setOption({        //加载数据图表                
                    legend: {
                        data: ageInterval
                    },
                    series: [{
                        data: series2
                    }]
                });
                
            },
            error: function (errorMsg) {
                //请求失败时执行该函数
                alert("图表请求数据失败!");
                myChart1.hideLoading();
                myChart2.hideLoading();
            }
        });
    }); 
    //基于准备好的dom，初始化echarts实例
    var myChart1 = echarts.init(document.getElementById('areaDistribution'));
    option1 = {
   		title : {
   	        text: '报名学生地理分布',
   	        /* subtext: 'o_O', */
   	        x:'center'
   	    },
   	    tooltip : {
   	        trigger: 'item',
   	        formatter: "{a} <br/>{b} : {c} ({d}%)"
   	    },
   	    legend: {
   	        orient: 'vertical',
   	        left: 'left',
   	        data: []
   	    },
   	    series : [
   	        {
   	            name: '地区分布',
   	            type: 'pie',
   	            radius : '55%',
   	            center: ['50%', '60%'],
   	            data:[],
   	            itemStyle: {
   	                emphasis: {
   	                    shadowBlur: 10,
   	                    shadowOffsetX: 0,
   	                    shadowColor: 'rgba(0, 0, 0, 0.5)'
   	                }
   	            }
   	        }
   	    ],
      	color: ['rgb(0,90,171)','rgb(255,222,0)','rgb(107,194,53)','rgb(200,200,169)','rgb(131,175,155)','rgb(0,0,0)','rgb(248,147,29)','rgb(78,29,76)','rgb(161,23,21)','rgb(100,107,48)'] 
    };
    myChart1.setOption(option1);
    myChart1.hideLoading();
 
    //基于准备好的dom，初始化echarts实例
    var myChart2 = echarts.init(document.getElementById('ageDistribution'));
    option2 = {
   		title : {
   	        text: '年龄分布',
   	        /* subtext: 'o_O', */
   	        x:'center'
   	    },
   	    tooltip : {
   	        trigger: 'item',
   	        formatter: "{a} <br/>{b} : {c} ({d}%)"
   	    },
   	    legend: {
   	        orient: 'vertical',
   	        left: 'left',
   	        data: []
   	    },
   	    series : [
   	        {
   	            name: '年龄分布',
   	            type: 'pie',
   	            radius : '55%',
   	            center: ['50%', '60%'],
   	            data:[],
   	            normal:{
   	            	color : function(value){
   	            		return "#"+("00000"+((Math.random()*16777215+0.5)>>0).toString(16)).slice(-6); 
   	            		}
   	            },
   	            itemStyle: {
   	                emphasis: {
   	                    shadowBlur: 10,
   	                    shadowOffsetX: 0,
   	                    shadowColor: 'rgba(0, 0, 0, 0.5)'
   	                }
   	            }
   	        }
   	    ] ,
   	 color: ['rgb(0,90,171)','rgb(255,222,0)','rgb(107,194,53)','rgb(200,200,169)','rgb(131,175,155)'] 
    };
    myChart2.setOption(option2);
    myChart2.hideLoading();
 


    function queryByTimeType(value){
        $("#timeType").val(value);
        $("#days").val("");
        $("#stupid").submit();
    }
    
    function selectYearandMonth(){
    	WdatePicker({dateFmt: 'yyyy年M月', isShowToday: false, isShowClear: false,maxDate:'%y年%M月',onpicked:function(){$("#timeType").val("");$("#stupid").submit(); } });
    }

</script>

</body>

</html>