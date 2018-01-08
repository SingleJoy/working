<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>


<div class="cn-wrap">

    <div id="content-container" class="container">
        <jsp:include page="/frontstage/base/personalCenter/personal_header.jsp"></jsp:include>
        <div class="row row-3-9">
        
            <jsp:include page="/frontstage/base/personalCenter/personal_left.jsp"></jsp:include>

            <div class="col-md-9">
                <form id="tutorClassForm" action="${pageContext.request.contextPath}/class/to_tutor_class.action" method="post">
                    <input type="hidden" name="stamp" id="stamp" value="${stamp}"/>
                    <input type="hidden" name="state" id="state" value="${state}"/>
                    <input type="hidden" name="page" id="page" value="${tutorClassView.page}"/>
                    <input type="hidden" name="rows" id="rows" value="${tutorClassView.rows}"/>
                    <input type="hidden" name="total" id="total" value="${tutorClassView.total}"/>
                    <input type="hidden" name="totalPage" id="totalPage" value="${tutorClassView.totalPage}"/>
                    <input type="hidden" name="sourceType" id="sourceType" value="${tutorClassView.sourceType}"/>
                </form>

                <div class="panel panel-default panel-col lesson-manage-panel">
                    <div class="panel-body">

                        <ul class="nav nav-tabs">
                            <li class="<c:if test="${tutorClassView.sourceType==0}">active</c:if>"><a href="javascript:void(0);" onclick="searchType(0);">课程班级</a></li>
                            <li class="<c:if test="${tutorClassView.sourceType==1}">active</c:if>"><a href="javascript:void(0);" onclick="searchType(1);">培训班级</a></li>
                        </ul>


                        <table class="table table-hover table-striped " id="course-table" style="word-break:break-all;text-align: left;">
                            <thead>
                            <tr >
                                <th style="width: 50%;">班级名称</th>
                                <th>所属课程</th>
                                <th>状态</th>
                                <th>操作</th>
                            </tr>
                            </thead>

                            <tbody>
                            <c:forEach  items="${tutorClassList}" var="tutorClass">
                                <tr >
                                    <td >
                                        <a href="javascript:void(0);" class="pull-left mrm" >
                                            <img style="width: 90px;height: 60px;" class="course-picture" width="100"
                                                 src="${pageContext.request.contextPath}${tutorClass.img}"/>
                                        </a>
                                        <div class="mlm">
                                           ${fn:substring(tutorClass.name,0,16)}
                                        </div>
                                    </td>
                                    <td ><a href="javascript:void(0);" onclick="toDetail(${tutorClass.sourceId},${tutorClass.sourceType});" class="course_title_name">${tutorClass.sourceName}</a></td>
                                    <td >
                                        <c:if test="${tutorClass.status == 0}"><span class="text-error">未发布</span></c:if>
                                        <c:if test="${tutorClass.status == 1}"><span class="text-info">已发布</span></c:if>
                                        <c:if test="${tutorClass.status == 2}"><span class="text-warning">进行中</span></c:if>
                                        <c:if test="${tutorClass.status == 3}"><span class="text-success">已完成</span></c:if>
                                        <c:if test="${tutorClass.status == 4}"><span class="muted">已结业</span></c:if>
                                        <c:if test="${tutorClass.status == 5}">已删除</c:if>
                                    </td>

                                    <td >
                                        <div class="btn-group">
                                            <a href="${pageContext.request.contextPath}/class/to_class_setting.action?id=${tutorClass.id}&flag=2&sign=8&source_id=${tutorClass.sourceId}&source_type=${tutorClass.sourceType}" class="btn btn-default btn-sm show_pop" >管理</a>
                                        </div>
                                    </td>

                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>

                        <c:if test="${empty tutorClassList }">
                            <div class="empty" >暂无数据</div>
                        </c:if>
                        <c:if test="${!empty tutorClassList }">

                            <div id="test" class="pager"></div>

                        </c:if>
                    </div>
                </div>

            </div>

        </div>
    </div>

    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
</div>






<script type="text/javascript">
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
            pageSize: $("#rows").val(),           //一页记录数
            onPageChange: function (page) {
                document.title = page;
                $("#page").val(page-1);
                $("#tutorClassForm").submit();

            }
        });
    });


    function toDetail(value,type){
    	if(type==0){
	        window.location.href="${pageContext.request.contextPath}/user_study/to_course_study.action?page=1&is_direct=0&learnId="+value+"&sourceType="+type+"&tab=1";
    	}else if(type==1){
    	    window.location.href="${pageContext.request.contextPath}/train/to_train_detail.action?id="+value+"&sign=0";
    	}
    }

    //课程班级/培训班级
	function searchType(value){
		$("#page").val(0);
    	$("#sourceType").val(value);
        $("#tutorClassForm").submit();
	}


</script>

