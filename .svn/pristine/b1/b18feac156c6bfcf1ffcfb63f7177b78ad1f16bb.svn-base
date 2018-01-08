<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/jquery.1.10.2.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/echarts.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/My97DatePicker/WdatePicker.js"></script>
</head>
<body class="easyui-layout" data-options="fit:true">
	<p/>
	<div style="font:13.3333px Arial;z-index:9999; position: absolute;margin-left:63px;margin-top:2px;">
		年：<input id="year" value="${year}" type="text" style="width: 30px;" onfocus="selectYear();" />
		月：<input id="month" value="${month}" type="text" style="width: 30px;" onfocus="selectMonth();" />
		<input type="button" onclick="doSearchMonth();" value="查询" />  
	</div>

    <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
   <div id="filestats" style="width: 780px;height:500px;margin-top: 10px;"></div>
<script type="text/javascript">
	var days = new Array();
	var uploadNum = new Array();
	var downLoadNum = new Array();
	var collectionNum = new Array();
	var clickNum = new Array();
	$(function(){
		$.ajax({
			type : 'POST',
			url : '${pageContext.request.contextPath}/back_file_stats/query_file_stats.action?year='+$("#year").val()+'&month='+$("#month").val(),
			dataType : 'json',
			success : function(d) {
				var list = d.obj;
				for(var i=0;i<list.length;i++){
					days[i] = list[i].days;
					uploadNum[i] = list[i].uploadNum;
					downLoadNum[i] = list[i].downLoadNum;
					collectionNum[i] = list[i].collectionNum;
					clickNum[i] = list[i].clickNum;
				}  
			}
		});
	});
	 //基于准备好的dom，初始化echarts实例
	var myChart = echarts.init(document.getElementById('filestats'));
	option = {
	    title : {
	       // text: '系统资源统计',
	    },
	    tooltip : {
	        trigger: 'axis'
	    },
	    legend: {
	        data:['上传量','下载量','收藏量','点击量']
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
	            name:'上传量',
	            type:'line',
	            smooth:true,
	            itemStyle: {normal: {areaStyle: {type: 'default'}}},
	            data:[]
	        },
	        {
	            name:'下载量',
	            type:'line',
	            stack: '总量',
	            itemStyle: {normal: {areaStyle: {type: 'default'}}},
	            data:[]
	        },
	        {
	            name:'收藏量',
	            type:'line',
	            smooth:true,
	            itemStyle: {normal: {areaStyle: {type: 'default'}}},
	            data:[]
	        },
	        {
	            name:'点击量',
	            type:'line',
	            smooth:true,
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
   				name : '上传量',
   				data : data.uploadNum
   			},
	        {
	            name:'下载量',
	            data:data.downLoadNum
	        },
	        {
	            name:'收藏量',
	            data:data.collectionNum
	        },
	        {
	            name:'点击量',
	            data:data.clickNum
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
				uploadNum : uploadNum,
				downLoadNum : downLoadNum,
				collectionNum : collectionNum,
				clickNum : clickNum
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
    		window.location.href = "${pageContext.request.contextPath}/back_file_stats/to_file_stats.action?year="+year+"&month="+$("#month").val();
    	}else{
    		parent.sy.messagerShow({
				msg : "请选择时间",
				title : '提示'
			});
    	}
    }
</script>  
</body>
</html>