<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/jquery.1.10.2.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/echarts.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/My97DatePicker/WdatePicker.js"></script>
</head>
<body class="easyui-layout" data-options="fit:true">

	<div style="font:13.3333px Arial;z-index:9999; position: absolute;margin-left:63px;margin-top:2px;">
		年：<input id="year" value="${year}" type="text" style="width: 30px;" onfocus="selectYear();" />
		月：<input id="month" value="${month}" type="text" style="width: 30px;" onfocus="selectMonth();" />
		<input type="button" onclick="doSearchMonth();" value="查询" />  
	</div>

    <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
	<div id="userstats" style="width: 780px;height:500px;margin-top: 10px;"></div>
<script type="text/javascript">
	var days = new Array();
	var frontNum = new Array();
	$(function(){
		$.ajax({
			type : 'POST',
			url : '${pageContext.request.contextPath}/back_user/query_user_stats.action?year='+$("#year").val()+'&month='+$("#month").val(),
			dataType : 'json',
			success : function(d) {
				var list = d.obj;
				for(var i=0;i<list.length;i++){
					days[i] = list[i].days;
					frontNum[i] = list[i].frontNum;
				}  
			}
		});
	});
	 //基于准备好的dom，初始化echarts实例
	var myChart = echarts.init(document.getElementById('userstats'));
	option = {
	    tooltip : {
	        trigger: 'axis'
	    },
	    legend: {
	        data:['用户注册量']
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
	            name:'用户注册量',
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
   				name : '用户注册量',
   				data : data.frontNum
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
				frontNum : frontNum,
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
    		window.location.href = "${pageContext.request.contextPath}/back_user/to_user_stats.action?year="+year+"&month="+$("#month").val();
    	}else{
    		parent.sy.messagerShow({
				msg : "请选择时间",
				title : '提示'
			});
    	}
    }
</script>  
</body>
