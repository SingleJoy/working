<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="../layout/header.jsp"></jsp:include>
<link href="${pageContext.request.contextPath}/frontstage/css/my-space.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/my-space.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/echarts.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/My97DatePicker/WdatePicker.js"></script>
<div class="layout_top">
<jsp:include page="./personal_header.jsp"></jsp:include>

    <div  class="main_right_style">
        <div class="main_right_resources_rank">
            <input type="hidden" id="secondary" value="${ secondary}">
            <ul>

                <li onclick="dj()"  <c:if test="${ secondary==0}">style="border-bottom: 2px solid #3ebbce;"</c:if> ><a href="javascript:;">点击率</a></li>
                <li onclick="xz()" <c:if test="${ secondary==1}">style="border-bottom: 2px solid #3ebbce;"</c:if>><a href="javascript:;">下载量</a></li>
                <li onclick="hp()" <c:if test="${ secondary==2}">style="border-bottom: 2px solid #3ebbce;"</c:if>><a href="javascript:;">好评度</a></li>
            </ul>
        </div><br/><br/>

        <div class="main_right_resources_rank_page" style="">
            <form id="form" action="" method="post"></form>

            <input type="hidden" id="columnId" value="${ columnId}"  >
            <input type="hidden" id="userId" value="${currentUser.id }">
            <p>时间:</p>
            <input type="hidden" id="hidden" value="${section }">
            <select id="section" placeholder="过去一周">
                <option value = '0'>请选择</option>
                <option value = '7'>过去一周</option>
                <option value ='30'>一个月</option>
                <option value = '90'>三个月</option>
            </select>
            <input  id = "start" type="text" class="scinput" onClick="WdatePicker()" placeholder="开始时间"  onfocus="WdatePicker()"/>
            <input  id="end" type="text"  class="scinput" onClick="WdatePicker()"   placeholder="结束时间"  onfocus="WdatePicker()" />


            <input type="button" value="搜索" onclick='tj()' class="search_button" style="width: 80px;height:30px;border-radius: 5px;background-color: #3ebbce;margin-left: 50px;">

            <div id="resources_rank_show" style="width: 780px;height:500px;position: absolute;margin-top: 10px;"></div>

            <%-- <div class="rank_list_page">
                     <table>
                         <tr>
                         <th><input type="checkbox"></th>
                         <th class="list_name">名称</th>
                         <th class="list_click_num">
                         <c:choose>
                         <c:when test="${ secondary==0}">点击数</c:when>
                         <c:when test="${ secondary==1}">下载量</c:when>
                         <c:otherwise>好评度</c:otherwise>

                         </c:choose>
                         </th>
                         <th class="list_type">类型</th>
                         <th class="list_time">创建时间</th>
                         <th class="list_operation">操作</th>
                         </tr>

                 <c:choose>
                     <c:when test="${ secondary==2}">
                 <c:forEach items="${ResourceArrange}" var="r">
                       <tr>
                         <td ><input type="checkbox"></td>
                         <td class="list_name_"><img src="../images/word_03.png"><span class="list_name_txt">${r.fileName }</span></td>
                         <td class="list_click_num_">${r.score }</td>
                         <td class="list_type_">${r.columnName }</td>
                         <td class="list_time_">${r.time }</td>
                         <td class="list_operation_"><span>发布</span><a href="#"><img src="../images/download.png"></a><a href="#"><img src="../images/delete.jpg"></a></td>
                       </tr>
                     </c:forEach>
                     </c:when>
                     <c:otherwise>
                     <c:forEach items="${ResourceArrange}" var="r">
                         <tr>
                         <td ><input type="checkbox"></td>
                         <td class="list_name_"><img src="../images/word_03.png"><span class="list_name_txt">${r.fileName }</span></td>
                         <td class="list_click_num_">${r.clickOrDown }</td>
                         <td class="list_type_">${r.columnName }</td>
                         <td class="list_time_">${r.time }</td>
                         <td class="list_operation_"><span>发布</span><a href="#"><img src="../images/download.png"></a><a href="#"><img src="../images/delete.jpg" onclick="shanchu(${r.id})"></a></td>
                         </tr>
                     </c:forEach>
                     </c:otherwise>
                     </c:choose>
                         </table>
                 </div> --%>

        </div>

    </div>

</div>

 

    <script type="text/javascript">
    var arr=new Array();
    var arr2=new Array();
    $(document).ready(function(){
    	
    	$.ajax({
			type : 'post',
			url : '${pageContext.request.contextPath}/my_resource_arrange/showResourceArrangeJson.action?columnId='+$("#columnId").val()+"&secondary="+$("#secondary").val()+"&section="+$("#hidden").val()+"&userId="+$("#userId").val(),
			dataType : 'json',
			success : function(json) {
			
			var a = JSON.stringify(json);
			
					var list = eval("("+ a +")");

				for ( var i in a) {

					 arr[i]=list[i].fileName ;
					 if(list[i].score==0){
						 arr2[i]=list[i].clickOrDown;
					 }
					 else{
						 arr2[i]=list[i].score;
					 }
					
					
					
				}
				

			}
				

	});
    	

		});
    function fetchData(cb) {
		// 通过 setTimeout 模拟异步加载
		setTimeout(function() {
			cb({
				categories : arr,
				data : arr2
			});
		}, 1000);
	}

	
    function dj(){
		$(("#secondary")).val("0");
		tj();
	}
	function xz(){
		$(("#secondary")).val("1");
		tj();
	}
	function hp(){
		$(("#secondary")).val("2");
		tj();
	}
    function quanbu(){
		$(("#columnId")).val("0");
		
	}
	function tongbu(){
		$(("#columnId")).val("1");
		
	}
	function kecheng(){
		$(("#columnId")).val("2");
		
	}
	function jiaoxue(){
		$(("#columnId")).val("3");
		
	}
	function ketang(){
		$(("#columnId")).val("4");
		
	}
function shanchu(id){
    	
    	
    	
    	 var url="${pageContext.request.contextPath}/my_resource_arrange/delete.action?columnId="+$("#columnId").val()+"&secondary="+$("#secondary").val()+"&section="+$("#section").find("option:selected").val()
    	+"&start="+$("#start").val()+"&end="+$("#end").val()+"&userId="+$("#userId").val()+"&id="+id;
    	$("#form").attr("action",url);
    	$("#form").submit();  
    }
    function tj(){
    	
    	var url="${pageContext.request.contextPath}/my_resource_arrange/showResourceArrange.action?columnId="+$("#columnId").val()+"&secondary="+$("#secondary").val()+"&section="+$("#section").find("option:selected").val()
    	+"&start="+$("#start").val()+"&end="+$("#end").val()+"&userId="+$("#userId").val();
        $("#form").attr("action",url);
        $("#form").submit();
    }
    $(function(){
        $(".navbar_my_name img").mouseover(function(){
            $(".navbar_my_name img").attr("src","${pageContext.request.contextPath}/frontstage/images/menu_top.png");
            $(".admin_states").show();
        })
        $(".admin_states").mouseover(function(){
            $(".navbar_my_name img").attr("src","${pageContext.request.contextPath}/frontstage/images/menu_top.png");
            $(".admin_states").show();
        })

        $(".admin_states").mouseout(function(){
            $(".navbar_my_name img").attr("src","${pageContext.request.contextPath}/frontstage/images/menu_down.png");
            $(".admin_states").hide();
        })

        $(".navbar_my_name img").mouseout(function(){
            $(this).attr("src","${pageContext.request.contextPath}/frontstage/images/menu_down.png");
            $(".admin_states").hide();
        })

    });
    </script>

<script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('resources_rank_show'));

        // 指定图表的配置项和数据
       option = {
    color:['#2faec5'],
    title: {
        
    },
    tooltip : {
        trigger: 'axis'
    },
    legend: {
        data:['点击率']
    },
    toolbox: {
        feature: {
            saveAsImage: {}
        }
    },
    grid: {
    	x: '1000',
        left: '3%',
        right: '4%',
        bottom: '100',
        containLabel: true
    },
    xAxis : [
        {
            type : 'category',
            boundaryGap : false,
           
            data : [],
            axisLabel:{
            	interval:0,
                rotate:90, //刻度旋转45度角
               
                textStyle:{
                   //color:"#66ffff",
                   fontSize:10
              }
            }
        
        }
    ],
    yAxis : [
        {
            type : 'value'
        }
    ],
    series : [
        {
            
            type:'line',
            stack: '总量',
            label: {
                normal: {
                    show: true,
                    position: 'top'
                }
            },
            areaStyle: {normal: {}},
            data:[]
        }
    ]
};
       myChart.showLoading();
   	fetchData(function(data) {
   		myChart.hideLoading();
   		myChart.setOption({
   			xAxis : {
   				data : data.categories

   			},
   			series : [ {
   				// 根据名字对应到相应的系列
   				name : '点击率',
   				data : data.data
   			}

   			]

   		});
   	});


        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    </script>


<jsp:include page="../layout/footer.jsp"></jsp:include>