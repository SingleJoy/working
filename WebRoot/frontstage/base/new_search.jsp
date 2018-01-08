<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>
<link  href="${pageContext.request.contextPath}/frontstage/css/teaching-center.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/frontstage/css/resource-list.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
    $(function(){

        $(".search_input").keyup(function(e){
            var keycode = e.which;
            if(keycode==13){

                $(".search_form").submit();

            }
        });

        $(".search_button").click(function(){


            $(".search_form").submit();

        });


        var s='${searchView.str}';

        $(".title").each(function(){
            var str=$(this).attr("title");
            var strs=str.split(s);
            var newStr="";

            for(var i=0;i<strs.length;i++){

                if(i==0){
                    newStr+=strs[i];
                }else{
                    newStr+= "<span style='color: red'>"+s+"</span>"+strs[i];
                }

            }
            $(this).html(newStr);
        });
    });


</script>
<style>
    .media-left{padding-top: 10px;}
</style>

<div class="cn-wrap">


    <section class="search-banner es-live-poster swiper-container ">
        <div class="swiper-slide swiper-hidden" style="background:url(${pageContext.request.contextPath}/frontstage/images/search_banner.jpg) no-repeat; background-size: cover;">
        </div>
        <div class="cloud-search-box container">
            <form class="input-group search-input-group search_form"  action="${pageContext.request.contextPath}/search/search.action" method="post">
                <div class="input-wrap" style="margin-left: 10%;">
                    <input type="text" name="str" class="form-control search_input pull-right" placeholder="可搜索课程、培训、教研、资源、社区、工作坊" value="${searchView.str }"  >
                    <a href="javascript:void(0);" class="search_button">
                        <i class="glyphicon glyphicon-search" ></i>

                    </a>
                </div>
                <input type="hidden" name="source_type" value="${searchView.source_type}" />

            </form>
            <form  action="${pageContext.request.contextPath}/search/search.action" method="post" id="search_form">
                <input type="hidden" name="str" value="${searchView.str }" >
                <input type="hidden" name="rows" id="rows" value="${searchView.rows}"/>
                <input type="hidden" name="page" id="page" value="${searchView.page}"/>
                <input type="hidden" name="total" id="total" value="${searchView.total}" />
                <input type="hidden" name="source_type" value="${searchView.source_type}" />
            </form>
        </div>
    </section>

    <div id="content-container" class="container" style="margin-top: 20px;">
        <div class="row">
            <div class="col-md-12 ">
                <div class="cn-section" style="border: none;">

                    <ul class="nav nav-tabs" id="search-nav-tabs">
                        <li <c:if test="${searchView.source_type==0}">class="active"</c:if>><a href="${pageContext.request.contextPath}/search/search.action?source_type=0&str=${searchView.str }" >课程</a></li>
                        <li <c:if test="${searchView.source_type==1}">class="active"</c:if>><a href="${pageContext.request.contextPath}/search/search.action?source_type=1&str=${searchView.str }" >培训</a></li>
                        <li <c:if test="${searchView.source_type==2}">class="active"</c:if>><a href="${pageContext.request.contextPath}/search/search.action?source_type=2&str=${searchView.str }" >教研</a></li>
                        <li <c:if test="${searchView.source_type==3}">class="active"</c:if>><a href="${pageContext.request.contextPath}/search/search.action?source_type=3&str=${searchView.str }" >资源</a></li>
                        <li <c:if test="${searchView.source_type==4}">class="active"</c:if>><a href="${pageContext.request.contextPath}/search/search.action?source_type=4&str=${searchView.str }" >社区</a></li>
                        <li <c:if test="${searchView.source_type==5}">class="active"</c:if>><a href="${pageContext.request.contextPath}/search/search.action?source_type=5&str=${searchView.str }" >工作坊</a></li>

                    </ul>

                    <div class="search-result" id="search-result">
                        <div class="alert alert-blank alert-sm">
                            为您找到
                            <c:if test="${searchView.source_type==0}">课程</c:if>
                            <c:if test="${searchView.source_type==1}">培训</c:if>
                            <c:if test="${searchView.source_type==2}">教研</c:if>
                            <c:if test="${searchView.source_type==3}">资源</c:if>
                            <c:if test="${searchView.source_type==4}">社区</c:if>
                            <c:if test="${searchView.source_type==5}">工作坊</c:if>
                            结果约
                            <span class="color-danger">${searchView.total }</span>个
                        </div>

                        <div class="search-s-list" id="search-s" >

                            <c:forEach items="${searchViews}" var="s">

                                <%--课程--%>
                                <c:if test="${searchView.source_type==0}">

                                    <div class="search_info_list">
                                        <div class="media media_content">
                                            <a class="media-left" href="${pageContext.request.contextPath}/user_study/to_course_study.action?page=1&learnId=${s.source_id}&sourceType=0&tab=-1&is_direct=0" target="_blank">
                                                <img class="media-object" src="${pageContext.request.contextPath}${s.img}" style="width: 200px;height: 150px;">

                                                <c:if test="${!empty s.classifyName }">
                                                    <span class="content_tag">${s.classifyName }</span>
                                                </c:if>
                                            </a>
                                            <div class="media-body" style="margin-left: 20px;">
                                                <h2 class="media-heading title search-title" title="${s.title}">${s.title}</h2>

                                                <div style="margin:15px 0;">
                                                    <span class="s-price-widget">
                                                        <c:choose>
                                                            <c:when test="${s.price>0 }">
                                                                <%--收费--%>
                                                                <span class="text-danger"> ￥${s.price }</span>
                                                            </c:when>
                                                            <c:when test="${s.price==0 }">
                                                                <%--免费--%>
                                                                <span class="text-success">免费</span>
                                                            </c:when>
                                                        </c:choose>
                                                    </span>
                                                </div>

                                                <div style="margin-top: 20px;">
                                                    <span class="text-muted">

                                                        <c:forEach begin="1" end="${s.score }">
                                                            <i class="es-icon es-icon-star color-warning"></i>
                                                        </c:forEach>

                                                        <c:forEach begin="1" end="${5-s.score }">
                                                            <i class="es-icon es-icon-star"></i>
                                                        </c:forEach>
                                                            &nbsp;&nbsp;
                                                        <span class="text-danger">${s.appraise_num}&nbsp;</span>条评价
                                                    </span>
                                                </div>

                                                <div style="margin-top: 20px;">
                                                    <span class="text-muted ">作者&nbsp;&nbsp;
                                                        <span class="title" title="${s.username}">${s.username}</span>
                                                    </span>
                                                    <span class="mlm mrm text-muted"></span>
                                                    <span class="text-muted">学习人数 &nbsp;&nbsp;
                                                        <span class="text-danger">${s.studentNum }</span>
                                                    </span>
                                                    <span class="mlm mrm text-muted"></span>
                                                    <span class="text-muted">收藏 &nbsp;&nbsp;
                                                        <span class="text-danger">${s.collect_num}</span>
                                                    </span>

                                                </div>

                                            </div>
                                        </div>

                                    </div>


                                </c:if>

                                <%--培训--%>
                                <c:if test="${searchView.source_type==1}">

                                    <div class="search_info_list">
                                        <div class="media media_content">
                                            <a class="media-left"  href="${pageContext.request.contextPath}/train/to_train_detail.action?id=${s.source_id}&sign=0" target="_blank">
                                                <img class="media-object" src="${pageContext.request.contextPath}${s.img}" style="width: 200px;height: 150px;">

                                                <c:if test="${!empty s.classifyName }">
                                                    <span class="content_tag">${s.classifyName }</span>
                                                </c:if>
                                            </a>
                                            <div class="media-body" style="margin-left: 20px;">
                                                <h2 class="media-heading title search-title" title="${s.title}">${s.title}</h2>

                                                <div style="margin:15px 0;">
                                                        <span class="s-price-widget">
                                                           <c:choose>
                                                               <c:when test="${s.price>0 }">
                                                                   <%--收费--%>
                                                                   <span class="text-danger"> ￥${s.price }</span>
                                                               </c:when>
                                                               <c:when test="${s.price==0 }">
                                                                   <%--免费--%>
                                                                   <span class="text-success">免费</span>
                                                               </c:when>
                                                           </c:choose>   </span>
                                                </div>
                                                <div style="margin-top: 20px;">
                                                    <span class="text-muted">

                                                         
                                                          <c:forEach begin="1" end="${s.score }">
                                                              <i class="es-icon es-icon-star color-warning"></i>
                                                          </c:forEach>
                                                <c:forEach begin="1" end="${5-s.score }">
                                                    <i class="es-icon es-icon-star"></i>
                                                </c:forEach>

                                                            &nbsp;&nbsp;
                                                            <span class="text-danger">${s.appraise_num}&nbsp;</span>条评价
                                                        </span>
                                                </div>

                                                <div style="margin-top: 20px;">
                                                        <span class="text-muted">主办方&nbsp;&nbsp;
                                                            <span class="text-danger">${s.sponsor }</span>
                                                        </span>
                                                    <span class="mlm mrm text-muted"></span>
                                                    <span class="text-muted">学习人数 &nbsp;&nbsp;
                                                            <span class="text-danger">${s.studentNum }</span>
                                                        </span>
                                                    <span class="mlm mrm text-muted"></span>
                                                    <span class="text-muted">收藏 &nbsp;&nbsp;
                                                            <span class="text-danger">${s.collect_num}</span>
                                                        </span>

                                                </div>

                                            </div>
                                        </div>

                                    </div>


                                </c:if>

                                <%--教研--%>
                                <c:if test="${searchView.source_type==2}">


                                    <div class="search_info_list">
                                        <div class="media media_content">
                                            <a class="media-left"  href="${pageContext.request.contextPath}/lesson_main/to_lesson.action?id=${s.source_id}" target="_blank">
                                                <img class="media-object" src="${pageContext.request.contextPath}${s.img}" style="width: 200px;height: 150px;">

                                                <span class="content_tag">${s.grade}${s.subject}</span>

                                            </a>
                                            <div class="media-body" style="margin-left: 20px;">
                                                <h2 class="media-heading title search-title" title="${s.title}">${s.title}</h2>


                                                <div style="margin-top: 20px;">
                                                         <span class="text-muted">
  
                                                          <c:forEach begin="1" end="${s.score }">
                                                              <i class="es-icon es-icon-star color-warning"></i>
                                                          </c:forEach>
                                                <c:forEach begin="1" end="${5-s.score }">
                                                    <i class="es-icon es-icon-star"></i>
                                                </c:forEach>

                                                            &nbsp;&nbsp;
                                                            <span class="text-danger">${s.appraise_num}&nbsp;</span>条评价
                                                        </span>
                                                </div>
                                                <div class="progress" style="height: 18px;background-color: #eaeaea;padding: 0;margin-top: 15px;width: 280px;">
                                                    <c:if test="${s.finish_count/s.all_count>=0.26 }">
                                                        <c:set var="width" value="${s.finish_count/s.all_count }"></c:set>
                                                    </c:if>
                                                    <c:if test="${s.all_count==0||s.finish_count/s.all_count<0.26 }">
                                                        <c:set var="width" value="0.26"></c:set>
                                                    </c:if>
                                                    <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width:<fmt:formatNumber value="${width*100}" pattern="##.#"/>%">
                                                        <span class="text-center">完成：${s.finish_count}/${s.all_count}</span>
                                                    </div>

                                                </div>

                                                <div>
                                                        <span class="text-muted">收藏&nbsp;&nbsp;
                                                            <span class="text-danger">${s.collect_num}</span>
                                                        </span>
                                                    <span class="mlm mrm text-muted"></span>
                                                    <span class="text-muted">工作坊 &nbsp;&nbsp;
                                                            <span class="text-danger">${s.workshop_name}</span>
                                                        </span>
                                                    <span class="mlm mrm text-muted"></span>
                                                    <span class="text-muted">组长 &nbsp;&nbsp;
                                                            <span class="text-danger">${s.username}</span>
                                                        </span>

                                                </div>

                                            </div>
                                        </div>

                                    </div>


                                </c:if>

                                <%--资源--%>
                                <c:if test="${searchView.source_type==3}">
                                    <div class="s-item clearfix panel" style="margin-bottom: 0;padding: 10px 0;">
                                        <a class="s-picture-link pull-left"  href="${pageContext.request.contextPath}/userFile/to_file.action?id=${s.source_id}" target="_blank" >
                                            <img class="avatar-lg-md" src="${pageContext.request.contextPath}${s.img}" style="margin: 15px 0 0 15px;"><br>
                                            <span class="text-muted author_info clearfix" title="${s.username}">${s.username}</span>

                                        </a>
                                        <div class="resource_info pull-left" >

                                            <h4 class="mbl">

                                                <a class="title" href="${pageContext.request.contextPath}/userFile/to_file.action?id=${s.source_id}" target="_blank" title="${s.title}">${s.title}</a>
                                                <c:if test="${s.file_type==0 }"> <span class="lesson_plan">文档</span></c:if>

                                                <c:if test="${s.file_type==1 }"> <span class="teaching_plan">教案</span></c:if>
                                            </h4>

                                            <div class="s-footer ">
                                                <span title="下载数量" class="text-muted"><i class="glyphicon glyphicon-download-alt"></i>&nbsp;${s.download_times}次下载 </span>
                                                <span class="mlm mrm text-muted"></span>
                                                <span title="收藏" class="text-muted"><i class="es-icon es-icon-bookmarkoutline"></i>&nbsp;${s.collect_num}位收藏 </span>

                                            </div>
                                            <br>
                                            <div class="s-footer">
                                                <span class="text-muted">格式&nbsp;:&nbsp;${s.format}</span>
                                                <span class="mlm mrm text-muted"></span>
                                                <span class="text-muted">评价数&nbsp;:&nbsp;
                                                    ${s.appraise_num}
                                                </span>
                                                <span class="mlm mrm text-muted"></span>
                                                <span class= "text-muted">&nbsp;<fmt:formatDate type="date"  value="${s.create_time}" />贡献</span>
                                            </div>

                                        </div>

                                    </div>

                                </c:if>

                                <%--社区--%>
                                <c:if test="${searchView.source_type==4}">

                                    <div class="search_info_list">
                                        <div class="media media_content">
                                            <a class="media-left"   href="${pageContext.request.contextPath}/community/to_community_index.action?sourceType=1&stamp=5&id=${s.source_id}" target="_blank">
                                                <img class="media-object" src="${pageContext.request.contextPath}${s.img}" style="width: 200px;height: 150px;">
                                                <c:if test="${!empty s.grade }">
                                                    <span class="content_tag">${s.grade}${s.subject}</span>
                                                </c:if>

                                            </a>
                                            <div class="media-body" style="margin-left: 20px;">
                                                <h2 class="media-heading title search-title" title="${s.title}">${s.title}</h2>


                                                <div style="margin-top: 20px;">
                                                    <span class="text-muted">创建人 &nbsp;&nbsp;
                                                        <span class="text-danger">${s.username}</span>
                                                    </span>
                                                </div>

                                                <div style="margin-top: 20px;">
                                                    <span class="text-muted">社区人数 &nbsp;&nbsp;
                                                        <span class="text-danger">${s.user_count }</span>
                                                    </span>

                                                    <span class="mlm mrm text-muted"></span>
                                                    <span class="text-muted">话题数 &nbsp;&nbsp;
                                                        <span class="text-danger">${s.topic_count }</span>
                                                    </span>

                                                </div>

                                            </div>
                                        </div>

                                    </div>

                                </c:if>

                                <%--工作坊--%>
                                <c:if test="${searchView.source_type==5}">

                                    <div class="search_info_list">
                                        <div class="media media_content">
                                            <a class="media-left"  href="${pageContext.request.contextPath}/community/to_community_index.action?sourceType=0&stamp=5&id=${s.source_id}" target="_blank">
                                                <img class="media-object" src="${pageContext.request.contextPath}${s.img}" style="width: 200px;height: 150px;">
                                                <c:if test="${!empty s.grade }">
                                                    <span class="content_tag">${s.grade}${s.subject}</span>
                                                </c:if>
                                            </a>

                                            <div class="media-body" style="margin-left: 20px;">
                                                <h2 class="media-heading title search-title" title="${s.title}">${s.title}</h2>

                                                <div style="margin-top: 20px;">
                                                    <span class="text-muted">坊主 &nbsp;&nbsp;
                                                        <span class="text-danger">${s.workshop_user }</span>
                                                    </span>
                                                </div>
                                                <div style="margin-top: 20px;">
                                                    <span class="text-muted">坊员人数 &nbsp;&nbsp;
                                                        <span class="text-danger">${s.user_count }</span>
                                                    </span>

                                                    <span class="mlm mrm text-muted"></span>
                                                    <span class="text-muted">话题数 &nbsp;&nbsp;
                                                        <span class="text-danger">${s.topic_count }</span>
                                                    </span>

                                                </div>

                                            </div>

                                        </div>

                                    </div>


                                </c:if>


                            </c:forEach>
                            <c:if test="${!empty searchViews}">
                                <div id="test" class="pager" ></div>
                            </c:if>

                        </div>
                    </div>

                </div>
            </div>

        </div>

    </div>


    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>

</div>
<script>
    $(function(){
        //翻页
        var total = $("#total").val();
        var page =  parseInt($("#page").val())+1;

        $("#btn5").on('click', function () {
            $("#div1").PageChanged(5);
        });

        $(".pager").pagination({
            thisPageIndex:page,
            recordCount: total,       //总记录数
            pageSize:  $("#rows").val(),            //一页记录数
            onPageChange: function (page) {
                document.title = page;
                $("#page").val(page-1);
                $('#search_form').submit();

            }
        });
    });

</script>

