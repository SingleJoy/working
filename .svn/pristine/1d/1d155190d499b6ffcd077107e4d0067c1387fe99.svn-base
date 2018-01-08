<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<link rel="stylesheet"  href="${pageContext.request.contextPath}/frontstage/css/community.css"  type="text/css"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/echarts.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/My97DatePicker/WdatePicker.js"></script>
<div class="cn-wrap" >
            
	<div id="content-container" class="container">
		<c:if test="${dataStatsView.dataType == 0 }">
	       	<jsp:include page="community_header.jsp"></jsp:include>
		</c:if>
		<c:if test="${dataStatsView.dataType == 1 }">
	       	<jsp:include page="workshop_header.jsp"></jsp:include>
		</c:if>
		<div class="row row-3-9">
			<c:if test="${dataStatsView.dataType == 0 }">
				<jsp:include page="community_left.jsp"></jsp:include>
			</c:if>
			<c:if test="${dataStatsView.dataType == 1 }">
				<jsp:include page="workshop_left.jsp"></jsp:include>
			</c:if>
		    <div class="col-lg-9 col-md-8  course-detail-main" >
		    <div class="panel panel-default panel-col">

                    <div class="panel-heading">数据统计</div>

                    <div class="panel-body">

                        <div class="row">

                            <div class="col-md-12">

                                <form id="dataStatsForm" class="well well-sm form-inline" action="${pageContext.request.contextPath}/community/to_data_stats.action" method="post"  >
                                	<input type="hidden" name="monthType" id="monthType" value="${dataStatsView.monthType }" />
                                	<input type="hidden" name="statsType" id="statsType" value="${dataStatsView.statsType }" />
                                	<input type="hidden" name="dataType" id="dataType" value="${dataStatsView.dataType }" />
									<input type="hidden" id="id" name="id" value="${dataStatsView.id}"/>
									<input type="hidden" id="stamp" name="stamp" value="${dataStatsView.stamp}"/>
                                <div class="form-group">
                                    <div class="col-md-2">
                                        <select class="form-control" onchange="doStatsType(this.value);" style="width: 80px;">
                                            <option value="0" <c:if test="${dataStatsView.statsType==0}">selected</c:if>>用户</option>
                                            <option value="1" <c:if test="${dataStatsView.statsType==1}">selected</c:if>>课程班级</option>
                                            <option value="2" <c:if test="${dataStatsView.statsType==2}">selected</c:if>>培训班级</option>
                                            <option value="3" <c:if test="${dataStatsView.statsType==3}">selected</c:if>>课例</option>
                                            <c:if test="${dataStatsView.dataType != 1 }">
                                            	<option value="4" <c:if test="${dataStatsView.statsType==4}">selected</c:if>>工作坊</option>
                                            </c:if>
                                            <option value="5" <c:if test="${dataStatsView.statsType==5}">selected</c:if>>活跃度</option>
                                        </select>
                                    </div>

                                </div>
                                <div class="form-group">
                                    <a type="button" onclick="doMonthType(0);" class="btn btn-default <c:if test="${dataStatsView.monthType==0}">active</c:if>" >本月</a>
	
                                    <a type="button" onclick="doMonthType(1);" class="btn btn-default <c:if test="${dataStatsView.monthType==1}">active</c:if>" >上月</a>

                                    <a type="button" onclick="doMonthType(2);" class="btn btn-default <c:if test="${dataStatsView.monthType==2}">active</c:if>">近三月</a>
                                </div>
                                <div class="form-group mll" >
                                    <label class="ptm">起始日期</label>
                                   <input type="text" class="form-control" style="width:100px;"  value="${dataStatsView.startTime}" id="startTime" name="startTime" onClick="WdatePicker()">
                                </div>

                                <div class="form-group mll" >
                                    <label class="ptm">截止日期</label>
                                   <input type="text" class="form-control" style="width:100px;"  value="${dataStatsView.endTime}" id="endTime" name="endTime" onClick="WdatePicker()">
                                </div>

                                <div class="form-group mll">
                                    <button class="btn btn-primary pull-right" onclick="doMonthType(4);">清空</button>
                                    <button class="btn btn-primary pull-right" onclick="doMonthType(3);">查询</button>
                                </div>

                                <ul class="nav nav-tabs"  style="margin-top: 20px;">
                                    <li  class="active">
                                        <a href="javascript:void(0);">趋势</a>
                                    </li>
                                </ul>
                            <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
 							<div id="statistics" style="width: 780px;height:500px;margin-top: 10px;"></div>
                            </form>
                        </div>

                    </div>

                </div>
            </div>

        </div>
    </div>
</div>
</div>
<script type="text/javascript">
var statsType = $("#statsType").val();
//选择类型
function doStatsType(value){
	$("#statsType").val(value);
	$("#dataStatsForm").submit();
}
//选择月份
function doMonthType(value){
	if(value==4){
		$("#monthType").val(0);
		$("#startTime").val('');
		$("#endTime").val('');
	}else if(value==3){
		if($("#startTime").val()==''){
			alert("请选择起始时间");
			return false;
		}
		if($("#endTime").val()==''){
			alert("请选择截止时间");
			return false;
		}
		$("#monthType").val(value);
	}else{
		$("#monthType").val(value);
	}
	$("#dataStatsForm").submit();
}

var days = new Array();
var newNum = new Array();//新增
var countNum = new Array();//总数
var completeNum = new Array();//完成数
$(function(){
	$.ajax({
		type : 'POST',
		url : '${pageContext.request.contextPath}/community/query_data_stats.action',
		data :{
			id : $("#id").val(),
			startTime : $("#startTime").val(),
			endTime : $("#endTime").val(),
			monthType : $("#monthType").val(),
			statsType : $("#statsType").val(),
			dataType : $("#dataType").val()
		},
		dataType : 'json',
		success : function(d) {
			var list = d.dataStatsList;
			for(var i=0;i<list.length;i++){
				days[i] = list[i].days;
				newNum[i] = list[i].newNum;
				countNum[i] = list[i].countNum;
				if(statsType==1||statsType==2||statsType==3){
					completeNum[i] = list[i].completeNum;
				}
			}  
		}
	});
});
 //基于准备好的dom，初始化echarts实例
var myChart = echarts.init(document.getElementById('statistics'));
 
var legendData = ['新增数','总数'];
var seriesData = [{
                    name:'新增数',
                    type:'line',
                    smooth:true,
                    itemStyle: {normal: {areaStyle: {type: 'default'}}},
                    data:[]
	             },{
	      	        name:'总数',
	      	        type:'line',
	      	        stack: '总量',
	      	        itemStyle: {normal: {areaStyle: {type: 'default'}}},
	      	        data:[]
	      	    }];
			
if(statsType==1||statsType==2||statsType==3){
	legendData.push('完成数');
	seriesData.push({
	        name:'完成数',
  	        type:'line',
  	        stack: '总量',
  	        itemStyle: {normal: {areaStyle: {type: 'default'}}},
  	        data:[]
  	    });
}
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
			name : '新增数',
			data : data.newNum
		},{
			name : '总数',
			data : data.countNum
		}];
 		if(statsType==1||statsType==2||statsType==3){
 			seriesFetchData.push({
 				// 根据名字对应到相应的系列
 				name : '完成数数',
 				data : data.completeNum
 			});
 		}
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
			newNum : newNum,
			countNum : countNum,
			completeNum : completeNum
		});
	}, 1000);
}
   
</script>  

<jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
