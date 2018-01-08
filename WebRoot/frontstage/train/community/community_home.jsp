<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<c:if test="${empty head_title}"><title>求资网</title></c:if>
<c:if test="${!empty head_title}"><title>${head_title}</title></c:if>

<script src="${pageContext.request.contextPath}/frontstage/js/echarts.min.js"></script>
<script src="${pageContext.request.contextPath}/frontstage/js/china.js"></script>
<style>

    #china-map {height: 700px;text-align: center;}
    .popover-content>a{padding: 10px;line-height: 30px;}
    .popover{min-width: 300px;}

</style>



<div class="cn-wrap" style="background-color: #fff;">

    <!--绘制地图区域-->
    <div id="china-map" ></div>

    <c:if test="${!empty communityView.city }">
        <div class="container">

            <div class="tabs-wrapper " style="margin: 0;">

                <div class="tabs-group">
                    <ul class="content clearfix county" style="margin-left: 0;">


                        <li  <c:if test="${empty communityView.county }">class="active"</c:if>>
                              <a class="items nav-link tag area_county" href="javascript:;" data-city="${city.area_id }">
                                  <span class="glyphicon glyphicon-map-marker"></span>&nbsp;&nbsp;${city.area_name }:
                              </a>
                          </li>

                        <c:forEach items="${areaList }" var="a">
                            <li <c:if test="${communityView.county==a.area_id  }">class="active"</c:if>>
                                <a class="items nav-link tag area_county" href="javascript:;" data-county="${a.area_id }" data-city="${a.area_parentid }">${a.area_name }</a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>

            </div>
        </div>

    </c:if>

    <c:if test="${empty communityView.city }">
        <div class="container" >
            <div class="text-line">
                <h5 >
                    <span >热门社区</span>
                    <div class="line"></div>
                </h5>
                <div class="subtitle">精选热门社区，满足你的学习兴趣。</div>
            </div>
            <div class="course-list">
                <div class="row">
                    <c:forEach items="${hot}" var="community">
                        <div class="col-lg-3 col-md-4 col-xs-6">
                            <div class="course-item">
                                <div class="course-img">
                                    <a href="${pageContext.request.contextPath}/community/to_community_index.action?sourceType=0&stamp=5&id=${community.id}" target="_blank">
                                        <img src="${pageContext.request.contextPath}${community.head_img}" alt="" class="img-responsive" style=" height: 160px;">
                                    </a>
                                </div>
                                <div class="course-info">
                                    <div class="title">
                                        <a class="link-dark" href="${pageContext.request.contextPath}/community/to_community_index.action?sourceType=0&stamp=5&id=${community.id}" target="_blank">
                                                ${community.name}
                                        </a>
                                    </div>
                                    <div class="metas clearfix">
                                        <span class="num"><i class="es-icon es-icon-people"></i>${community.studentNum}</span>
                                        <span class="comment"><i class="es-icon es-icon-textsms"></i>${community.topicNum}</span>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </c:if>
    <!--社区列表-->
    <section class="community_list container" style="margin-top: 20px;">

        <div class="course-list">
            <div class="row" id="community-row">
                <c:forEach items="${communityViews}" var="community">
                    <div class="col-lg-3 col-md-4 col-xs-6">
                        <div class="course-item">
                            <div class="course-img">
                                <a href="${pageContext.request.contextPath}/community/to_community_index.action?sourceType=0&stamp=5&id=${community.id}" target="_blank">
                                    <img src="${pageContext.request.contextPath}${community.head_img}" alt="" class="img-responsive" style="height: 160px;">
                                </a>
                            </div>
                            <div class="course-info">
                                <div class="title">
                                    <a class="link-dark" href="${pageContext.request.contextPath}/community/to_community_index.action?sourceType=0&stamp=5&id=${community.id}" target="_blank">
                                            ${community.name}
                                    </a>
                                </div>
                                <div class="metas clearfix">
                                    <span class="num"><i class="es-icon es-icon-people"></i>${community.studentNum}</span>
                                    <span class="comment"><i class="es-icon es-icon-textsms"></i>${community.topicNum}</span>

                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>

            </div>
        </div>
        <c:if test="${total>16 }">
            <div class="section-more-btn">
                <a href="javascript:void(0);" class="btn btn-default btn-lg" id="more_">
                    加载更多 <i class="mrs-o es-icon es-icon-chevronright"></i>
                </a>
            </div>
        </c:if>
    </section>

</div>

<!--鼠标点击弹窗事件-->
<div id="popover"  class="modal" style="display: none;">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"> <span id="p_name"></span>各行政市名单</h4>
            </div>
            <div class="modal-body">
                <form action="" method="post" class="form-horizontal">
                    <div class="popover-content">

                    </div>

                </form>
            </div>


            <div class="modal-footer">
                <a href="javascript:void(0);" class="btn btn-link" data-dismiss="modal">取消</a>
            </div>
        </div>
    </div>
</div>

<form id="communityForm" action="${pageContext.request.contextPath}/community/to_community_home.action" method="post">

    <input type="hidden" name="city" id="city" value="${communityView.city }"/>
    <input type="hidden" name="county" id="county" value="${communityView.county }"/>
</form>
<jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
<script type="text/javascript">

    var area={
        "西藏":	"DQ001",
        "辽宁":	"DQ002",
        "宁夏":	"DQ003",
        "海南":	"DQ004",
        "四川":	"DQ005",
        "甘肃":	"DQ006",
        "河北":	"DQ007",
        "上海":	"DQ008",
        "贵州":	"DQ009",
        "山西":	"DQ010",
        "新疆":	"DQ011",
        "北京":	"DQ012",
        "天津":	"DQ013",
        "湖南":	"DQ014",
        "浙江":	"DQ015",
        "广西":	"DQ016",
        "陕西":	"DQ017",
        "江苏":	"DQ018",
        "河南":	"DQ019",
        "江西":	"DQ020",
        "福建":	"DQ021",
        "安徽":	"DQ022",
        "云南":	"DQ023",
        "青海":	"DQ024",
        "山东":	"DQ025",
        "重庆":	"DQ026",
        "吉林":	"DQ027",
        "内蒙古":	"DQ028",
        "湖北":	"DQ029",
        "广东":	"DQ030",
        "黑龙江":	"DQ031",
    };

    var myChart = echarts.init(document.getElementById('china-map'));
    var option = {
        tooltip: {
//                    show: false //不显示提示标签
            formatter: '{b}', //提示标签格式
            backgroundColor:"#000",//提示标签背景颜色
            textStyle:{color:"#e1e1e1"} //提示标签字体颜色
        },
        series: [{
            type: 'map',
            mapType: 'china',
//            roam: true,  //地图是否支持放大缩小
            label: {
                normal: {
                    show: true,//显示省份标签
                    textStyle:{color:"#000"}//省份标签字体颜色
                },
                emphasis: {//对应的鼠标悬浮效果
                    show: true,
                    textStyle:{color:"#800080"}
                }
            },
            itemStyle: {
                normal: {
                    borderWidth: .5,//区域边框宽度
                    borderColor: '#009fe8',//区域边框颜色
                    areaColor:"#4fc2f8",//区域颜色
                },
                emphasis: {
                    borderWidth: .5,
                    borderColor: '#4b0082',
                    areaColor:"#CCEBFA",

                }
            },
            data:[
                //     {name:'北京', selected:true}//北京为选中状态
            ]
        }],
    };
    myChart.setOption(option);

    // 鼠标点击事件参考一下链接
    // http://echarts.baidu.com/tutorial.html#ECharts%20%E4%B8%AD%E7%9A%84%E4%BA%8B%E4%BB%B6%E5%92%8C%E8%A1%8C%E4%B8%BA
    //    http://www.cnblogs.com/xianwen/p/6045454.html
    myChart.on('click', function (params) {    //params为省名称
        var name = params.name;
        $("#p_name").html(name);

        if(name=="台湾"){
            alert("暂无数据");
            return false;
        }
        //1、使用eval方法
        var area_id=eval('area.'+name);

        $.ajax ({
            type:"post",
            url: '${pageContext.request.contextPath}/community/ajax_city.action?area_id='+area_id,
            dataType: "html",
            success: callback

        });

        function callback(html) {
            $(".popover-content").html("");
            $(".popover-content").html(html);
            $("#popover").modal();
        }
//    myChart.on('mouseout', function (params) {    //params为省名称

        //     $(".popover").hide();

        //   });

    });
    //
    $(document).on('click',".area_city",function(){
        var  area_id=$(this).attr("id");
        $("#city").val(area_id);
        $("#communityForm").submit();



    });
    $(document).on('click',".area_county",function(){

        var  city=$(this).data("city");
        var county=$(this).data("county");
        if(county!=null){
            $("#county").val(county);
        }else{
            $("#county").val("");
        }
        $("#city").val(city);
        $("#communityForm").submit();



    });
    var num='${communityView.rows}';
    $("#more_").click(function () {
        $.ajax ({
            type:"post",
            url: '${pageContext.request.contextPath}/community/ajax_more.action?num='+num,
            dataType: "json",
            success: callback

        });
        function callback(json) {

            var html="";
            for(var i=0;i<json.communityViews.length;i++){
                var c=json.communityViews[i];
                html+='<div class="col-lg-3 col-md-4 col-xs-6"><div class="course-item"><div class="course-img">';
                html+='<a href="${pageContext.request.contextPath}/community/to_community_index.action?sourceType=0&stamp=5&id='+c.id+'" target="_blank">';
                html+='<img src="${pageContext.request.contextPath}'+c.head_img+'" alt="" class="img-responsive" style="width: 260px; height: 150px;">';
                html+='</a></div><div class="course-info"><div class="title">';
                html+='<a class="link-dark" href="${pageContext.request.contextPath}/community/to_community_index.action?sourceType=0&stamp=5&id='+c.id+'" target="_blank">'+c.name+'</a></div>';
                html+='<div class="metas clearfix">';
                html+='<span class="num"><i class="es-icon es-icon-people"></i>'+c.studentNum+'</span>';
                html+='<span class="comment"><i class="es-icon es-icon-textsms"></i>'+c.topicNum+'</span>';
                html+='</div></div></div></div>';
            }
            $("#community-row").append(html);


            num=json.num;
            if(!json.flag){
                $(".section-more-btn").remove();
            }
        }
    })





</script>



