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
	<jsp:include page="/backstage/base/inc.jsp"></jsp:include>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/backstage/css/data.css" type="text/css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/jquery.1.10.2.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/echarts.min.js"></script>
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
			<h3>课程排行
				<a class="download_data_btn" href="${pageContext.request.contextPath}/back_course/export_course_ranking.action?sort=${sort}">
					<img src="${pageContext.request.contextPath}/frontstage/images/read_download.png">&nbsp;&nbsp;导出数据
				</a>

			</h3>
			<form id="stupid" action="${pageContext.request.contextPath}/back_course/to_course_ranking.action" method="post">
				<br/>
				<div class="time">
					<div class="choose_date_01">
						<span>排行：</span>
						<input type="hidden" name="sort" id="sort" value="${sort}">
						<a onclick="queryBySort('0');" class="<c:if test="${sort=='0'}">active</c:if>" href="javascript:void(0);">报名人数</a>
						<a onclick="queryBySort('1');" class="<c:if test="${sort=='1'}">active</c:if>" href="javascript:void(0);">视频观看人数</a>
						<a onclick="queryBySort('2');" class="<c:if test="${sort=='2'}">active</c:if>" href="javascript:void(0);">好评度</a>
						<a onclick="queryBySort('3');" class="<c:if test="${sort=='3'}">active</c:if>" href="javascript:void(0);" title="问题数+笔记数">活跃度</a>
					</div>

				</div>
				<br/>
				<br/>
				<br/>

			</form>
		</div>

	</div>

	 <div class="main_body" style="min-height: 600px;">


        <div style="margin-bottom: 50px;clear: both;margin-left: -13px;margin-top: 36px;" id="data_pic">
            <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
            <div id="courseRank" style="width: 1000px; height: 350px;">

            </div>

        </div>
        <div class="time" style="clear: both;margin-top: 60px;padding-left: 20px;">
            <table class="table_sta" style="width: 85%;">
                <thead>
                <tr>
                    <th style="width: 28%;">课程</th>
                    <th style="width: 18%;">报名人数</th>
                    <th style="width: 18%;">视频观看人数</th>
                    <th style="width: 18%;">好评度</th>
                    <th style="width: 18%;">活跃度</th>
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
            url : '${pageContext.request.contextPath}/back_course/query_course_ranking.action',
            data :{
            	sort : "${sort}"
            },
            dataType : 'json',
            success : function(d) {
                var list = d.list;
                var tbody = '';
                for(var i=0;i<list.length;i++){
                	title[i] = list[i].title;
                	if("${sort}"=="0"){
                		newNum[i] = list[i].studentNum;
                	}else if("${sort}"=="1"){
                		newNum[i] = list[i].vediowatchNum;
                	}else if("${sort}"=="2"){
                		newNum[i] = list[i].score;
                	}else if("${sort}"=="3"){
                		newNum[i] = list[i].activeNum;
                	}
                	tbody += '<tr><td>'+list[i].title+'</td><td>'+list[i].studentNum+'</td><td>'+list[i].vediowatchNum+'</td><td>'+list[i].score+'</td><td>'+list[i].activeNum+'</td></tr>';
                }
                $("#databody").html(tbody); 
            }
        });
    });
    var legend0 = "报名人数";
    if("${sort}"=="1"){
    	legend0 = "视频观看人数";
    }else if("${sort}"=="2"){
    	legend0 = "好评度";
    }else if("${sort}"=="3"){
    	legend0 = "活跃度";
    }
  //基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('courseRank'));
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
    	console.log(value)
    	if(value!=null&&value!=""){
    		$("#sort").val(value);
    		$("#stupid").submit();
    	}
    }
</script>

</body>

</html>