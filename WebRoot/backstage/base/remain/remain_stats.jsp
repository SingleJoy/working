<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	<!-- jquery库 -->
	<script type="text/javascript" src="${pageContext.request.contextPath}/backstage/js/jquery-1.8.2.min.js" charset="utf-8"></script>
	<!-- easyui相关库 -->
	<link id="easyuiTheme" rel="stylesheet" href="${pageContext.request.contextPath}/backstage/js/jquery-easyui-1.3.1/themes/<c:out value="${cookie.easyuiThemeName.value}" default="default"/>/easyui.css" type="text/css"></link>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/backstage/js/jquery-easyui-1.3.1/themes/icon.css" type="text/css"></link>
	<script type="text/javascript" src="${pageContext.request.contextPath}/backstage/js/jquery-easyui-1.3.1/jquery.easyui.min.js?v0.1" charset="utf-8"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/backstage/js/jquery-easyui-1.3.1/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
    
    <script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/jquery.1.10.2.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/echarts.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/My97DatePicker/WdatePicker.js"></script>

<body class="easyui-layout" data-options="fit:true">
	<p/>
	<div style="font:13.3333px Arial;z-index:9999; position: absolute;margin-left:228px;margin-top:-48px;">
       <select  onchange="changeSun(this.value);">
			<option value="0" <c:if test="${timeType!=3}">selected="selected"</c:if>>日活跃度</option>
			<option value="3" <c:if test="${timeType==3}">selected="selected"</c:if>>月活跃度</option>
	</select>
		&nbsp;
       <div id="sun" style="float:right;<c:if test="${timeType==3}">display:none;</c:if>">
        <input type="hidden" id="timeType" value="${timeType}">
        <input id="days" name="days" <c:if test="${!empty days&&days!='undefined'}">value="${days}"</c:if> class="easyui-datebox" data-options="editable:false" style="width: 155px;" />
        <input type="button" onclick="doSearchDay(0);" value="次日" <c:if test="${timeType==0}">style="background:#87cefa;"</c:if>/> 
        <input type="button" onclick="doSearchDay(1);" value="三日" <c:if test="${timeType==1}">style="background:#87cefa;"</c:if>/> 
        <input type="button" onclick="doSearchDay(2);" value="七日" <c:if test="${timeType==2}">style="background:#87cefa;"</c:if>/> 
       </div>
       <div id="moon" style="float:right;<c:if test="${timeType!=3}">display:none;</c:if>">
		    年：<input id="year" value="${year}" type="text" style="width: 30px;" onfocus="selectYear();" />
         <input type="button" onclick="doSearchYear();" value="查询" />
       </div>
	</div>

    <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
   <div id="userstats" style="width: 780px;height:470px;margin-top: 63px;"></div>
<script type="text/javascript">
	var days = new Array();
	var newNum = new Array();
	var remainRatio = new Array(); 
	var activeNum = new Array();
	var returnNum = new Array();
	$(function(){
		$.ajax({
			type : 'POST',
			async :false,
			url : '${pageContext.request.contextPath}/back_user/query_remain_stats.action',
			data :{
				timeType : "${timeType}",
				year : "${year}",
				days : "${days}"
			},
			dataType : 'json',
			success : function(d) {
				var list = d.obj;
				for(var i=0;i<list.length;i++){
					days[i] = list[i].days;
					newNum[i] = list[i].newNum;
					remainRatio[i] = list[i].remainRatio; 
					activeNum[i] = list[i].activeNum;
					returnNum[i] = list[i].returnNum;
				}  
			}
		});
	});
	 //基于准备好的dom，初始化echarts实例
	var myChart = echarts.init(document.getElementById('userstats'));
	if("${timeType}"!=3){
		var legendData = ['新增用户留存量','新增用户留存率'];
		var seriesData = [{
		                    name:'新增用户留存量',
		                    type:'line',
		                    smooth:true,
		                    areaStyle: {
		                        normal: {}
		                    },
		                    lineStyle: {
		                        normal: {
		                            width: 1
		                        }
		                    },
		                    itemStyle: {normal: {areaStyle: {type: 'default'}}},
		                    data:[]
			             } ,{
			      	        name:'新增用户留存率',
			      	        type:'line',
			      	        yAxisIndex:1,
		                    lineStyle: {
		                        normal: {
		                            width: 1
		                        }
		                    }, 
			      	        /* stack: '总量', */
			      	        itemStyle: {normal: {areaStyle: {type: 'default',formatter:'{c}%'}}},/* 这里的formatter似乎没有影响 */
			      	        data:[]
			      	    } ];
		option = {
		    tooltip : {
		        trigger: 'axis',
		        axisPointer: {
		            type: 'cross',
		            animation: false,
		            label: {
		                backgroundColor: '#505765'
		            }
		        },
		        formatter:'{b}<br/><span style="display:inline-block;margin-right:5px;border-radius:10px;width:9px;height:9px;background-color:#EE4000"></span>{a0}:{c0}<br/><span style="display:inline-block;margin-right:5px;border-radius:10px;width:9px;height:9px;background-color:#7b68ee"></span>{a1}:{c1}%'
		    },
		    legend: {
		        data:legendData
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
				    name: '留存量',
				    type: 'value'
				},
				{
				    name: '留存率',
				    type: 'value',
				    axisLabel: {
		                  show: true,
		                  interval: 'auto',
		                  formatter: '{value}%'
		          		}
				    
				}
		        
		    ],
		    series : seriesData
		};
		
	 	myChart.showLoading(); 
	 	fetchData(function(data) {
	  		myChart.hideLoading();
	  		var seriesFetchData = [{
				// 根据名字对应到相应的系列
				name : '新增用户留存量',
				data : data.newNum
			},{
				name : '新增用户留存率',
				data : data.remainRatio
			} ];
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
					newNum : newNum ,
					remainRatio : remainRatio 
				});
			}, 1000);
		}
	}else{
		var legendData = ['注册用户数','上月活跃用户数','回归流失用户数'];
		var seriesData = [{
		                    name:'注册用户数',
		                    type:'line',
		                    smooth:true,
		                    itemStyle: {normal: {areaStyle: {type: 'default'}}},
		                    data:[]
			             } ,{
			      	        name:'上月活跃用户数',
			      	        type:'line',
			      	        smooth:true,
			      	        itemStyle: {normal: {areaStyle: {type: 'default'}}},
			      	        data:[]
			      	    }  ,{
			      	        name:'回归流失用户数',
			      	        type:'line',
			      	        smooth:true,
			      	        itemStyle: {normal: {color:'#00FF00',lineStyle:{color:'#00FF00'},areaStyle: {type: 'default'} }},
			      	        data:[]
			      	    } ];
		option = {
		    tooltip : {
		        trigger: 'axis'
		    },
		    legend: {
		        data:legendData
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
		    series : seriesData
		};
		
	 	myChart.showLoading(); 
	 	fetchData(function(data) {
	  		myChart.hideLoading();
	  		var seriesFetchData = [{
				// 根据名字对应到相应的系列
				name : '注册用户数',
				data : data.newNum
			} ,{
				name : '上月活跃用户数',
				data : data.activeNum
			} ,{
				name : '回归流失用户数',
				data : data.returnNum
			} ];
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
					newNum : newNum ,
					activeNum : activeNum ,
					returnNum : returnNum 
				});
			}, 1000);
		}
	}
	
    function changeSun(value){
    	if(value==3){
    		$("#moon").show();
    		$("#sun").hide();
    	}else if(value==0){
    		$("#moon").hide();
    		$("#sun").show();
    	}
    }
    function selectYear(){
        WdatePicker({dateFmt: 'yyyy', isShowToday: false, isShowClear: false,maxDate:'%y' });  
    }
    
    function doSearchYear(){
    	var year = $("#year").val();
    	if(year!=''){
    		window.location.href = "${pageContext.request.contextPath}/back_user/to_remain_stats.action?timeType=3&year="+year;
    	}else{
    		parent.sy.messagerShow({
				msg : "请选择时间",
				title : '提示'
			});
    	}
    }
    function doSearchDay(value){
    	var days = $("input[name='days']").val();
    	if(days==""){
    		parent.sy.messagerShow({
					msg : "请选择时间",
					title : '提示'
			});
			return false;
    	}
    	var oDate1 = new Date(days);
	    var oDate2 = new Date();
	    var time = oDate2.getTime() - oDate1.getTime() ; //日期的long型值之差
	    var dayb = Math.floor(time/(24*60*60*1000));
    	if(value==0){//次日
    	    if(dayb<=0){
    	    	parent.sy.messagerShow({
					msg : "请选择小于次日的时间",
					title : '提示'
				});
				return false;
    	    } 
    	}else if(value==1){//三日
    		if(dayb<3){
    	    	parent.sy.messagerShow({
					msg : "请选择小于三日的时间",
					title : '提示'
				});
				return false;
    	    }
    	}else if(value==2){//七日
    		if(dayb<7){
    	    	parent.sy.messagerShow({
					msg : "请选择小于七日的时间",
					title : '提示'
				});
				return false;
    	    }
    	} 
   		window.location.href = "${pageContext.request.contextPath}/back_user/to_remain_stats.action?timeType="+value+"&days="+days+"&year="+$("#year").val();
    }
     
     
</script>  
</body>
