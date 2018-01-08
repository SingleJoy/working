<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<div class="cn-wrap">

    <div id="content-container" class="container">
        <jsp:include page="/frontstage/base/personalCenter/personal_header.jsp"></jsp:include>

        <div class="row row-3-9">

            <jsp:include page="/frontstage/base/personalCenter/personal_left.jsp"></jsp:include>

            <div class="col-md-9">
                <form id="studyCenterForm" action="${pageContext.request.contextPath}/course_note/to_my_notes.action" method="post">
                    <input type="hidden" name="page" id="page" value="${view.page}"/>
                    <input type="hidden" name="rows" id="rows" value="${view.rows}"/>
                    <input type="hidden" name="total" id="total" value="${view.total}"/>
                    <input type="hidden" name="totalPage" id="totalPage" value="${view.totalPage}"/>
                    <input type="hidden" name="tab" id="tab" value="${tab}"/>
                    <input type="hidden" name="state" id="state" value="${state}"/>
                    <input type="hidden" name="stamp" id="stamp" value="${stamp}"/>
                </form>

                <div class="panel panel-default panel-col">

                    <div class="panel-heading">我的笔记</div>


                    <div class="panel-body">

                        <ul class="media-list notebook-list" id="notebook-list">
                            <c:forEach items="${noteViews }" var="n">
                                <div class="media" style="padding-bottom: 0;">
                                    <img class="pull-left media-object" style="width: 150px;height: 78px;"
                                         <c:if test="${empty n.course_picture}">src="${pageContext.request.contextPath}/frontstage/images/course.png"</c:if>
                                         <c:if test="${!empty n.course_picture}">src="${pageContext.request.contextPath}${n.course_picture }"</c:if>>
                                    <div class="media-body">

                                        <h4 class="media-heading">${n.course_title }</h4>

                                        <div class="notebook-metas">
                                            <span class="notebook-number">共 ${n.noteNum } 篇笔记</span>
                                        </div>

                                        <div class="notebook-metas">
                                            <span class="notebook-time">最后更新<fmt:formatDate value="${n.noteTime }" type="both" /> </span>
                                            <a class="pull-right notebook-go" href="${pageContext.request.contextPath}/course_note/to_my_notes_detail.action?stamp=2&state=26&course_id=${n.course_id }">查看笔记</a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </ul>

                    </div>

                </div>
                <div id="test" class="pager" style="padding-top: 0;"></div>
            </div>

        </div>

    </div>

    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>


</div>

<script type="text/javascript">
    //    课程类型切换
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
                $('#studyCenterForm').submit();

            }
        });
    });
</script>

