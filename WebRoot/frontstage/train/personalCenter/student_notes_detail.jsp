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
               <form id="studyCenterForm" action="${pageContext.request.contextPath}/course_note/to_my_notes_detail.action?course_id=${view.course_id }" method="post">
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

                        <div class="notebook" >
                            <div class="notebook-heading">
                                <a class="btn btn-default btn-sm pull-right notebook-back-btn" href="${pageContext.request.contextPath}/course_note/to_my_notes.action?stamp=2&state=26" >返回</a>
                                <img class="notebook-icon" <c:if test="${empty view.course_picture}">src="${pageContext.request.contextPath}/frontstage/images/course.png"</c:if>
                                     <c:if test="${!empty view.course_picture}">src="${pageContext.request.contextPath}${view.course_picture }"</c:if> />
                                《${view.course_title }》的笔记
                            </div>

                            <div class="notebook-body">
                                <c:forEach items="${noteViews }" var="n">
                                    <div class="notebook-note notebook-note-collapsed">
                                        <div class="notebook-note-heading">
                                            <a href="javascript:void (0);" >${n.course_hour_title }</a>
                                        </div>

                                        <div class="notebook-note-summary">${n.noteContent }</div>
                                        <div class="notebook-note-body">

                                            <div class="notebook-note-actions clearfix">
                                                <a href="${pageContext.request.contextPath}/course_note/delete_note.action?id=${n.note_id }"  class="pull-right notebook-note-delete" title="删除笔记">
                                                    <span class="glyphicon glyphicon-trash"></span>
                                                </a>
                                            </div>

                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>

                    <div id="test" class="pager " style="margin-top: 50px;padding-top: 0;"></div>
                </div>

            </div>
        </div>
    </div>
    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>



</div>
<script type="text/javascript">

    $(function(){
        $(".notebook-note").mouseover(function(){
            $(this).find(".notebook-note-body").show();
        }).mouseout(function(){
            $(this).find(".notebook-note-body").hide();
        });
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

        $(".my_notes_delete").click(function(){

            var url=$(this).attr("href");
            $.ajax({
                type:'get',
                url : url,
                dataType:'json',
                success : function(response) {
                    alert(response.msg);
                    location.replace(location.href);
                },
                error :function(response) {

                }

            });
        });
    });

</script>

