<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/jquery.1.10.2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/echarts.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/My97DatePicker/WdatePicker.js"></script>

<body class="easyui-layout" data-options="fit:true">
<div>
	<div style="margin:30px 100px;">
		<select name="statiType" id="statiType" style="height: 21px;">
			<option value="0" <c:if test="${contentStatiView.statiType==0 }">selected="selected"</c:if>>评价</option>
			<option value="1" <c:if test="${contentStatiView.statiType==1 }">selected="selected"</c:if>>报名(普通课程)</option>
			<option value="2" <c:if test="${contentStatiView.statiType==2 }">selected="selected"</c:if>>报名(专业培训)</option>
			<option value="3" <c:if test="${contentStatiView.statiType==3 }">selected="selected"</c:if>>报名(进阶培训)</option>
			<option value="4" <c:if test="${contentStatiView.statiType==4 }">selected="selected"</c:if>>学习(普通课程)</option>
			<option value="5" <c:if test="${contentStatiView.statiType==5 }">selected="selected"</c:if>>学习(专业培训)</option>
			<option value="6" <c:if test="${contentStatiView.statiType==6 }">selected="selected"</c:if>>学习(进阶培训)</option>
		</select>

		<button onclick="doSearch(0)">本月</button>
		<button onclick="doSearch(1)">上月</button>
		<button onclick="doSearch(2)">近三月</button>
		<input type="hidden" name="monthType" id="monthType" value="${contentStatiView.monthType }"/>
		<input id="startTime" name="startTime" value="${contentStatiView.startTime }" class="Wdate" style="width: 155px;" onFocus="WdatePicker({lang:'zh-cn',readOnly:true,dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endTime\')||\'new Date()\'}'})"/>至
		<input id="endTime" name="endTime" value="${contentStatiView.endTime }" class="Wdate" style="width: 155px;" onFocus="WdatePicker({lang:'zh-cn',readOnly:true,dateFmt:'yyyy-MM-dd',maxDate:new Date(),minDate:'#F{$dp.$D(\'startTime\')}'})"/>

		<input type="button" onclick="doSearch(3)" value="查询"/>
	</div>
</div>
<div id="content_stati" style="width:780px;height:500px;margin-top:5px;"></div>
<script type="text/javascript">
    var newNum = new Array();
    var countNum = new Array();
    var days = new Array();
    $(document).ready(function(){
        $.ajax({
            type:"POST",
            url:"${pageContext.request.contextPath }/back_content/query_content_stati.action",
            dataType : 'json',
            data:{
                statiType:$("#statiType").val(),
                monthType:$("#monthType").val(),
                startTime:$("#startTime").val(),
                endTime:$("#endTime").val()
            },
            success:function(data){
                var dataList = data.obj;
                for(var i=0;i<dataList.length;i++){
                    days[i] = dataList[i].days;
                    newNum[i] = dataList[i].newNum;
                    countNum[i] = dataList[i].countNum;
                }
            }
        });
    });

    var mycharts = echarts.init(document.getElementById("content_stati"));
    option = {
        title:{

        },
        tooltip:{
            trigger: 'axis'
        },
        legend:{
            data:["新增数","总数"]
        },
        toolbox:{
            show:true,
            feature:{
                mark:{show:true},
                dataView:{show:true,readOnly:false},
                magicType:{show:true,type:["line","bar","stack","tiled"]},
                restore:{show:true},
                saveAsImage:{show:true}
            }
        },
        calculable:true,
        xAxis:[
            {
                type:"category",
                boundaryGap:false,
                data:[]
            }
        ],
        yAxis:[
            {
                type:"value"
            }
        ],
        series:[
            {
                name:"新增数",
                type:"line",
                smooth:true,
                itemStyle:{normal:{areaStyle:{type:"default"}}},
                data:[]
            },
            {
                name:"总数",
                type:"line",
                smooth:true,
                itemStyle:{normal:{areaStyle:{type:"default"}}},
                data:[]
            }
        ]
    };
    mycharts.showLoading();
    fetchData(function(data){
        mycharts.hideLoading();
        mycharts.setOption({
            xAxis : {
                data : data.days
            },
            series:[
                {
                    name:"新增数",
                    data:data.newNum
                },
                {
                    name:"总数",
                    data:data.countNum
                }
            ]
        });
    });
    mycharts.setOption(option);

    function fetchData(cb) {
        setTimeout(
            function(){
                cb(
                    {
                        days:days,
                        newNum:newNum,
                        countNum:countNum
                    });},1000);
    }

    function doSearch(value){
        if(!validate(value)){
            return;
        }
        window.location.href = "${pageContext.request.contextPath}/back_content/to_content_stati.action?statiType="+$("#statiType").val()+"&monthType="+value+"&startTime="+$("#startTime").val()+"&endTime="+$("#endTime").val();
    }

    function validate(value){
        if($("#statiType").val()==null){
            parent.sy.messagerAlert('提示', '请选择内容分类！', 'error');
            return false;
        }
        if(value!=null){
            $("#monthType").val(value);
        }
        if($("#monthType").val()==='3'){
            if(($("#startTime").val()==null||$("#startTime").val()==="")
                ||($("#endTime").val()==null||$("#endTime").val()==="")){
                parent.sy.messagerAlert('提示', '时间不能为空！', 'error');
                return false;
            }else if($("#startTime").val()>=$("#endTime").val()){
                parent.sy.messagerAlert('提示', '开始时间必须小于结束时间！', 'error');
                return false;
            }else{
                return true
            }
        }else if($("#monthType").val()==='0'||($("#monthType").val()==='1'||$("#monthType").val()==='2')){
            return true;
        }else{
            parent.sy.messagerAlert('提示', '信息提交异常！', 'error');
            return false;
        }
    }


</script>
</body>