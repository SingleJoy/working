<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>


<link href="${pageContext.request.contextPath}/frontstage/css/nouislider.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/nouislider.js"></script>
<link href="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.js"></script>
<%-- 
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/JMEditor/jmeditor/JMEditor.js"></script>
--%>
<style>
    #defaultImg{
        width:540px;height:270px;}
    .file:hover{color: #fff;}
    .webuploader-pick>div>label:hover{color: #fff;}
</style>
<div class="cn-wrap">

    <div id="content-container" class="container">
        <jsp:include page="/frontstage/train/course/course_header.jsp"></jsp:include>

        <div class="row">
            <jsp:include page="/frontstage/train/course/course_left.jsp"></jsp:include>

            <div class="col-md-9">
                <div class="panel panel-default panel-col">
                    <div class="panel-heading">
                        ${testPaperView.name }
                    </div>
                    <div class="panel-body clearfix">
                        <ol class="breadcrumb">
                            <li><a href="javascript:void(0);">试卷管理</a></li>
                            <li class="active">试卷题目管理</li>
                        </ol>
                        <div class="clearfix mbm">
                            <button class="btn btn-info btn-sm pull-right exam-add-question" value="5"><span class="glyphicon glyphicon-plus"></span> 新增试题</button>
                            <ul class="nav nav-pills nav-mini">
                                <li value="5" class="active"><a href="javascript:" class="testpaper-nav-link">单选题</a></li>
                                <li value="0" ><a href="javascript:" class="testpaper-nav-link">多选题</a></li>
                                <li value="1"><a href="javascript:" class="testpaper-nav-link">填空题</a></li>
                                <li value="2"><a href="javascript:" class="testpaper-nav-link">判断题</a></li>
                                <li value="3"><a href="javascript:" class="testpaper-nav-link">问答题</a></li>
                                <li value="4"><a href="javascript:" class="testpaper-nav-link">材料题</a></li>
                            </ul>
                        </div>
                        <form method="post" class="form-horizontal" action="${pageContext.request.contextPath}/testPaper/testPaper_save.action?id=${testPaperView.id }&courseId=${courseView.id}&flag=2&sign=11">
                            <div class="text-success">
                                试卷总分
                                <strong>${testPaperView.total_score }</strong>分
                                <span class="stats-part">
                                    单选题<strong>${testPaperQuestionViews5.size() }</strong>题/<strong>${total_score5}</strong>分
                                </span>
                            </div>
                            <table class="table table-hover tab-content" id="testpaper-table">
                                <thead class="testpaper-thead">
                                <tr>
                                    <th></th>
                                    <th><input type="checkbox" class="subCheckbox checkAll"></th>
                                    <th>题号</th>
                                    <th width="40%">题干</th>
                                    <th>类型</th>
                                    <th>难度</th>
                                    <th width="8%">分值</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody class="testpaper-table-tbody ">
                                <c:forEach items="${testPaperQuestionViews5 }" var="testPaperQuestionView">
                                    <tr class=" is-question" data-question="${testPaperQuestionView.question_id}">
                                        <td><span class="glyphicon glyphicon-resize-vertical sort-handle"></span></td>
                                        <td>
                                            <input class="notMoveHandle subCheckbox" type="checkbox">
                                            <input type="hidden" value="${testPaperQuestionView.questions_number}" name="seq">
                                        </td>
                                        <td class="seq">${testPaperQuestionView.questions_number}</td>
                                        <td>
                                                ${testPaperQuestionView.stem}
                                            <div class="text-muted text-sm">
                                                <c:if test="${testPaperQuestionView.belong_type==0}">
                                                    从属于 本课程
                                                </c:if>
                                                <c:if test="${testPaperQuestionView.belong_type==1}">
                                                    从属于 ${testPaperQuestionView.hour_title}
                                                </c:if>
                                            </div>
                                        </td>
                                        <td>单选题</td>
                                        <td>
                                            <c:if test="${testPaperQuestionView.difficulty==0}">简单</c:if>
                                            <c:if test="${testPaperQuestionView.difficulty==1}">一般</c:if>
                                            <c:if test="${testPaperQuestionView.difficulty==2}">困难</c:if>
                                        </td>
                                        <td>
                                            <input name="scores" class="notMoveHandle form-control " type="text" value="${testPaperQuestionView.questions_score}" style="height: 30px;">
                                            <input name="list" value="${testPaperQuestionView.question_id}" type="hidden">
                                        </td>

                                        <td>
                                            <div class="btn-group">
                                                <a href="javascript:;" class="notMoveHandle btn btn-default btn-sm show_pop" data-target="${testPaperQuestionView.question_id}">预览</a>
                                                <a href="javascript:" class="notMoveHandle btn btn-default btn-sm item-delete-btn del-question">删除</a>
                                                <a href="javascript:" class="notMoveHandle btn btn-default btn-sm exam-replace-question" data-id="${testPaperQuestionView.question_id}" data-type="${testPaperQuestionView.type}">替换</a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                                <tbody class="hide testpaper-table-tbody ">
                                <c:forEach items="${testPaperQuestionViews0 }" var="testPaperQuestionView">
                                    <tr class=" is-question" data-question="${testPaperQuestionView.question_id}">
                                        <td><span class="glyphicon glyphicon-resize-vertical sort-handle"></span></td>
                                        <td>
                                            <input class="notMoveHandle subCheckbox" type="checkbox">
                                            <input type="hidden" value="${testPaperQuestionView.questions_number}" name="seq">
                                        </td>
                                        <td class="seq">${testPaperQuestionView.questions_number}</td>
                                        <td>
                                                ${testPaperQuestionView.stem}
                                            <div class="text-muted text-sm">
                                                <c:if test="${testPaperQuestionView.belong_type==0}">
                                                    从属于 本课程
                                                </c:if>
                                                <c:if test="${testPaperQuestionView.belong_type==1}">
                                                    从属于 ${testPaperQuestionView.hour_title}
                                                </c:if>
                                            </div>
                                        </td>
                                        <td>多选题</td>
                                        <td>
                                            <c:if test="${testPaperQuestionView.difficulty==0}">简单</c:if>
                                            <c:if test="${testPaperQuestionView.difficulty==1}">一般</c:if>
                                            <c:if test="${testPaperQuestionView.difficulty==2}">困难</c:if>
                                        </td>
                                        <td>
                                            <input name="scores" class="notMoveHandle form-control " type="text" value="${testPaperQuestionView.questions_score}" style="height: 30px;">
                                            <input name="list" value="${testPaperQuestionView.question_id}" type="hidden">
                                        </td>

                                        <td>
                                            <div class="btn-group">
                                                <a href="javascript:;" class="notMoveHandle btn btn-default btn-sm show_pop" data-target="${testPaperQuestionView.question_id}">预览</a>
                                                <a href="javascript:" class="notMoveHandle btn btn-default btn-sm item-delete-btn del-question">删除</a>
                                                <a href="javascript:" class="notMoveHandle btn btn-default btn-sm exam-replace-question" data-id="${testPaperQuestionView.question_id}" data-type="${testPaperQuestionView.type}">替换</a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                                <tbody class="hide testpaper-table-tbody">
                                <c:forEach items="${testPaperQuestionViews1 }" var="testPaperQuestionView">
                                    <tr class=" is-question" data-question="${testPaperQuestionView.question_id}">
                                        <td><span class="glyphicon glyphicon-resize-vertical sort-handle"></span></td>
                                        <td>
                                            <input class="notMoveHandle subCheckbox" type="checkbox" >
                                            <input type="hidden" value="${testPaperQuestionView.questions_number}" name="seq">
                                        </td>
                                        <td class="seq">${testPaperQuestionView.questions_number}</td>
                                        <td>
                                                ${testPaperQuestionView.stem}
                                            <div class="text-muted text-sm">
                                                <c:if test="${testPaperQuestionView.belong_type==0}">
                                                    从属于 本课程
                                                </c:if>
                                                <c:if test="${testPaperQuestionView.belong_type==1}">
                                                    从属于 ${testPaperQuestionView.hour_title}
                                                </c:if>
                                            </div>
                                        </td>
                                        <td>填空题</td>
                                        <td>
                                            <c:if test="${testPaperQuestionView.difficulty==0}">简单</c:if>
                                            <c:if test="${testPaperQuestionView.difficulty==1}">一般</c:if>
                                            <c:if test="${testPaperQuestionView.difficulty==2}">困难</c:if>
                                        </td>
                                        <td>
                                            <input name="scores" class="notMoveHandle form-control input-sm" type="text" value="${testPaperQuestionView.questions_score}" style="height: 30px;">
                                            <input name="list" value="${testPaperQuestionView.question_id}" type="hidden">
                                        </td>
                                        <td>
                                            <div class="btn-group">
                                                <a href="javascript:;" class="notMoveHandle btn btn-default btn-sm show_pop"  data-target="${testPaperQuestionView.question_id}">预览</a>
                                                <a href="javascript:" class="notMoveHandle btn btn-default btn-sm item-delete-btn del-question">删除</a>
                                                <a href="javascript:" class="notMoveHandle btn btn-default btn-sm exam-replace-question" data-id="${testPaperQuestionView.question_id}">替换</a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                                <tbody class="hide testpaper-table-tbody">
                                <c:forEach items="${testPaperQuestionViews2 }" var="testPaperQuestionView">
                                    <tr class=" is-question" data-question="${testPaperQuestionView.question_id}">
                                        <td><span class="glyphicon glyphicon-resize-vertical sort-handle"></span></td>
                                        <td>
                                            <input class="notMoveHandle subCheckbox" type="checkbox" >
                                            <input type="hidden" value="${testPaperQuestionView.questions_number}" name="seq">
                                        </td>
                                        <td class="seq">${testPaperQuestionView.questions_number}</td>
                                        <td>
                                                ${testPaperQuestionView.stem}
                                            <div class="text-muted text-sm">
                                                <c:if test="${testPaperQuestionView.belong_type==0}">
                                                    从属于 本课程
                                                </c:if>
                                                <c:if test="${testPaperQuestionView.belong_type==1}">
                                                    从属于 ${testPaperQuestionView.hour_title}
                                                </c:if>
                                            </div>
                                        </td>
                                        <td>判断题</td>
                                        <td>
                                            <c:if test="${testPaperQuestionView.difficulty==0}">简单</c:if>
                                            <c:if test="${testPaperQuestionView.difficulty==1}">一般</c:if>
                                            <c:if test="${testPaperQuestionView.difficulty==2}">困难</c:if>
                                        </td>
                                        <td>
                                            <input name="scores" class="notMoveHandle form-control input-sm" type="text" value="${testPaperQuestionView.questions_score}" style="height: 30px;">
                                            <input name="list" value="${testPaperQuestionView.question_id}" type="hidden">
                                        </td>
                                        <td>
                                            <div class="btn-group">
                                                <a href="javascript:;" class="notMoveHandle btn btn-default btn-sm show_pop"  data-target="${testPaperQuestionView.question_id}">预览</a>
                                                <a href="javascript:" class="notMoveHandle btn btn-default btn-sm item-delete-btn del-question">删除</a>
                                                <a href="javascript:" class="notMoveHandle btn btn-default btn-sm exam-replace-question" data-id="${testPaperQuestionView.question_id}">替换</a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                                <tbody class="hide testpaper-table-tbody">
                                <c:forEach items="${testPaperQuestionViews3 }" var="testPaperQuestionView">
                                    <tr class=" is-question" data-question="${testPaperQuestionView.question_id}">
                                        <td><span class="glyphicon glyphicon-resize-vertical sort-handle"></span></td>
                                        <td>
                                            <input class="notMoveHandle subCheckbox" type="checkbox" >
                                            <input type="hidden" value="${testPaperQuestionView.questions_number}" name="seq">
                                        </td>
                                        <td class="seq">${testPaperQuestionView.questions_number}</td>
                                        <td>
                                                ${testPaperQuestionView.stem}
                                            <div class="text-muted text-sm">
                                                <c:if test="${testPaperQuestionView.belong_type==0}">
                                                    从属于 本课程
                                                </c:if>
                                                <c:if test="${testPaperQuestionView.belong_type==1}">
                                                    从属于 ${testPaperQuestionView.hour_title}
                                                </c:if>
                                            </div>
                                        </td>
                                        <td>问答题</td>
                                        <td>
                                            <c:if test="${testPaperQuestionView.difficulty==0}">简单</c:if>
                                            <c:if test="${testPaperQuestionView.difficulty==1}">一般</c:if>
                                            <c:if test="${testPaperQuestionView.difficulty==2}">困难</c:if>
                                        </td>
                                        <td>
                                            <input name="scores" class="notMoveHandle form-control input-sm" type="text" value="${testPaperQuestionView.questions_score}" style="height: 30px;">
                                            <input name="list" value="${testPaperQuestionView.question_id}" type="hidden">
                                        </td>
                                        <td>
                                            <div class="btn-group">
                                                <a href="javascript:;" class="notMoveHandle btn btn-default btn-sm show_pop"  data-target="${testPaperQuestionView.question_id}">预览</a>
                                                <a href="javascript:" class="notMoveHandle btn btn-default btn-sm item-delete-btn del-question">删除</a>
                                                <a href="javascript:" class="notMoveHandle btn btn-default btn-sm exam-replace-question" data-id="${testPaperQuestionView.question_id}">替换</a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                                <tbody class="testpaper-table-tbody hide">
                                <c:forEach items="${testPaperQuestionViews4 }" var="testPaperQuestionView">
                                    <tr class=" have-sub-questions is-question" data-question="${testPaperQuestionView.question_id}">
                                        <td><span class="glyphicon glyphicon-resize-vertical sort-handle"></span></td>
                                        <td>
                                            <input name="list" value="${testPaperQuestionView.question_id}" type="hidden">
                                            <input class="notMoveHandle subCheckbox" type="checkbox" >
                                            <input type="hidden" value="${testPaperQuestionView.questions_number}" name="seq">
                                            <input name="scores" class="notMoveHandle form-control input-sm" type="hidden" value="${testPaperQuestionView.questions_score}">
                                        </td>
                                        <td class="seq1">~</td>
                                        <td>
                                                ${testPaperQuestionView.stem}
                                            <div class="text-muted text-sm">
                                                <c:if test="${testPaperQuestionView.belong_type==0}">
                                                    从属于 本课程
                                                </c:if>
                                                <c:if test="${testPaperQuestionView.belong_type==1}">
                                                    从属于 ${testPaperQuestionView.hour_title}
                                                </c:if>
                                            </div>
                                        </td>
                                        <td>材料题</td>
                                        <td>
                                            <c:if test="${testPaperQuestionView.difficulty==0}">简单</c:if>
                                            <c:if test="${testPaperQuestionView.difficulty==1}">一般</c:if>
                                            <c:if test="${testPaperQuestionView.difficulty==2}">困难</c:if>
                                        </td>
                                        <td>

                                        </td>
                                        <td>
                                            <div class="btn-group">
                                                <a href="javascript:;" class="notMoveHandle btn btn-default btn-sm show_pop"  data-target="${testPaperQuestionView.question_id}">预览</a>
                                                <a href="javascript:;" class="notMoveHandle btn btn-default btn-sm item-delete-btn del-question">删除</a>
                                                <a href="javascript:;" class="notMoveHandle btn btn-default btn-sm exam-replace-question" data-id="${testPaperQuestionView.question_id}">替换</a>
                                            </div>
                                        </td>
                                    </tr>
                                    <c:forEach items="${testPaperQuestionViews6 }" var="testPaperQuestionView1">
                                        <c:if test="${testPaperQuestionView1.parent_question_id==testPaperQuestionView.question_id }">
                                            <tr class=" is-sub-question" data-question="${testPaperQuestionView1.question_id}">
                                                <td><span class="glyphicon glyphicon-resize-vertical sort-handle"></span></td>
                                                <td></td>
                                                <td class="seq">${testPaperQuestionView1.questions_number}</td>
                                                <td>
                                                        ${testPaperQuestionView1.stem}
                                                    <div class="text-muted text-sm">
                                                        <c:if test="${testPaperQuestionView.belong_type==0}">
                                                            从属于 本课程
                                                        </c:if>
                                                        <c:if test="${testPaperQuestionView.belong_type==1}">
                                                            从属于 ${testPaperQuestionView.hour_title}
                                                        </c:if>
                                                    </div>
                                                </td>
                                                <td>
                                                    <c:if test="${testPaperQuestionView1.type==5}">单选题</c:if>
                                                    <c:if test="${testPaperQuestionView1.type==0}">多选题</c:if>
                                                    <c:if test="${testPaperQuestionView1.type==1}">填空题</c:if>
                                                    <c:if test="${testPaperQuestionView1.type==2}">判断题</c:if>
                                                    <c:if test="${testPaperQuestionView1.type==3}">问答题</c:if>
                                                </td>
                                                <td>
                                                    <c:if test="${testPaperQuestionView1.difficulty==0}">简单</c:if>
                                                    <c:if test="${testPaperQuestionView1.difficulty==1}">一般</c:if>
                                                    <c:if test="${testPaperQuestionView1.difficulty==2}">困难</c:if>
                                                </td>
                                                <td>
                                                    <input name="scores" class="notMoveHandle form-control input-sm" type="text" value="${testPaperQuestionView1.questions_score}" style="height: 30px;">
                                                    <input name="list" value="${testPaperQuestionView1.question_id}" type="hidden">
                                                    <input type="hidden" value="${testPaperQuestionView1.questions_number}" name="seq">
                                                </td>
                                                <td>
                                                    <div class="btn-group"> </div>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                </c:forEach>
                                </tbody>

                            </table>

                            <div class="form-group">
                                <label class="checkbox-inline"><input type="checkbox" class="checkAll subCheckbox"> 全选</label>
                                <button type="button" class="btn btn-default mlm del-sel">删除</button>
                            </div>

                            <div class="form-group" style="margin-top: 30px;">
                                <div class="col-md-8 controls">
                                    <div class="passedScoreDiv">
                                        达到 <input name="accord_score" id="accord_score" class="form-control width-input width-input-small" value="${testPaperView.total_score*0.6 }"  type="text">分（含）可以自动审阅通过考试。</div>
                                    <div class="help-block" style="display:none;"></div>
                                </div>
                                <div class="col-md-4 controls">
                                    <button type="button" class="btn btn-primary pull-right mlm request-save">保存</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>


</div>
<!-- 弹窗 -->
<div id="modal" class="modal in" style="display: none;" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog  modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">题目预览</h4>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-link" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
<!-- 添加试题弹窗 -->
<div id="modal1" class="modal in" style="display: none;"></div>
<script type="text/javascript">
    $(document).ready(function(e){
        var questionViews;
        // 预览

        $(document).on("click",".newWindowPreview",function(){
            var id=$(this).attr("data-target");
            var body=  $('#modal').find(".modal-body");
            if(body.length>0){
                body.remove();
            }
            var url='${pageContext.request.contextPath}/question/html_question.action?id='+id;


            // $('#modal').modal('show');
            // window.open($('#modal').html());
            window.open(url, '_blank',
                "directories=0,height=580,width=820,scrollbars=1,toolbar=0,status=0,menubar=0,location=0");

        });
        $(document).on("click",".show_pop",function(){
            var id=$(this).attr("data-target");
            var body=  $('#modal').find(".modal-body");
            if(body.length>0){
                body.remove();
            }
            var url='${pageContext.request.contextPath}/question/modal_question.action?id='+id;
            $.ajax({
                url : url,
                dataType:'json',
                success : function(response) {
                    $('#modal').find(".modal-header").after(response.modal);
                    $('#modal').modal('show');
                }
            });
        });

        // 全选
        $(".checkAll").click(function () {
            var isChecked = $(this).prop("checked");
            $(".subCheckbox").each(function(){
                if(!$(this).is(":hidden")){
                    $(this).prop("checked", isChecked);
                }
            });

        })
        //删除选中
        $(document).on("click",".del-sel",function(){
            // var num = $('.nav-pills .active').attr('value');
            $('.testpaper-table-tbody input:checked').each(function(i,ck){
                if(!$(this).is(":hidden")){
                    $(ck).parent().parent().nextAll().each(function(){
                        //is-sub-question
                        var son=$.trim($(this).attr('class'));
                        if(son=="is-sub-question"){
                            var seq= parseInt($(this).find($(".seq")).html());
                            $(".seq").each(function(){
                                if(parseInt($(this).html())>seq){
                                    var html=parseInt($(this).html());
                                    var seqv=$("input[value="+html+"][name=seq]");
                                    html-=1;
                                    seqv.val(html);
                                    $(this).html(html);
                                }

                            });
                            $(this).remove();
                        }else{
                            return false;
                        }
                    });
                    var seq=parseInt($(ck).parent().parent().find($(".seq")).html());
                    $(".seq").each(function(){
                        if(parseInt($(this).html())>seq){
                            var html=parseInt($(this).html());
                            var seqv=$("input[value="+html+"][name=seq]");
                            html-=1;
                            seqv.val(html);
                            $(this).html(html);
                        }

                    });
                    $(ck).parent().parent().remove();
                }
                // if (num == 6) {}
            })
            $(".checkAll").prop("checked", false);
        })
        $(document).on("click",".del-question",function(){
            $(this).parent().parent().parent().nextAll().each(function(){
                //is-sub-question
                var son=$.trim($(this).attr('class'));
                if(son=="is-sub-question"){
                    var seq= parseInt($(this).find($(".seq")).html());
                    $(".seq").each(function(){
                        if(parseInt($(this).html())>seq){
                            var html=parseInt($(this).html());
                            var seqv=$("input[value="+html+"][name=seq]");
                            html-=1;
                            seqv.val(html);
                            $(this).html(html);
                        }
                    });
                    $(this).remove();
                }else{
                    return false;
                }
            });
            var seq=parseInt($(this).parent().parent().parent().find($(".seq")).html());
            $(".seq").each(function(){
                if(parseInt($(this).html())>seq){
                    var html=parseInt($(this).html());
                    var seqv=$("input[value="+html+"][name=seq]");
                    html-=1;
                    seqv.val(html);
                    $(this).html(html);
                }

            });
            $(this).parent().parent().parent().remove();
        })
        // 选择题型
        $(document).on("click",".nav-pills li",function(){
            $(this).siblings().removeClass('active');
            $(this).addClass('active');
            var num = $(this).attr('value');
            if(num==5){
                var html="单选题<strong>${testPaperQuestionViews5.size()}</strong>题/<strong>${total_score5}</strong>分";
                $(".stats-part").html(html);
                $('.exam-add-question').val(5);
            }
            if(num==0){
                var html="多选题<strong>${testPaperQuestionViews0.size()}</strong>题/<strong>${total_score0}</strong>分";
                $(".stats-part").html(html);
                $('.exam-add-question').val(0);
            }
            if(num==1){
                var html="填空题<strong>${testPaperQuestionViews1.size()}</strong>题/<strong>${total_score1}</strong>分";
                $(".stats-part").html(html);
                $('.exam-add-question').val(1);
            }
            if(num==2){
                var html="判断题<strong>${testPaperQuestionViews2.size()}</strong>题/<strong>${total_score2}</strong>分";
                $(".stats-part").html(html);
                $('.exam-add-question').val(2);
            }
            if(num==3){
                var html="问答题<strong>${testPaperQuestionViews3.size()}</strong>题/<strong>${total_score3}</strong>分";
                $(".stats-part").html(html);
                $('.exam-add-question').val(3);
            }
            if(num==4){
                var html="材料题<strong>${testPaperQuestionViews6.size()}</strong>子题/<strong>${total_score5}</strong>分";
                $(".stats-part").html(html);
                $('.exam-add-question').val(4);
            }
            var i;
            if(num==0){
                i=1;
            }  if(num==1){
                i=2;
            }  if(num==2){
                i=3;
            }  if(num==3){
                i=4;
            }  if(num==4){
                i=5;
            }  if(num==5){
                i=0;
            }
            $('#testpaper-table tbody').eq(i).removeClass('hide');
            $('#testpaper-table tbody').eq(i).addClass('sel-div');
            $('#testpaper-table tbody').eq(i).siblings().addClass('hide');
            $('#testpaper-table tbody').eq(i).siblings().removeClass('sel-div');
            $('.testpaper-thead').removeClass('hide');
        })
        // 添加试题
        $(document).on("click",".exam-add-question",function(){
            var type=$(this).val();
            var form=$(".form-horizontal");
            var form1=$("#modalForm");
            var url='${pageContext.request.contextPath}/testPaper/ajax_question.action?courseId=${courseView.id}&type='+type;
            if(form1.length>0){
                url+='&';
                url+=form1.serialize();
                $('#modal1').html('');
            }
            $.ajax({
                url : url,
                dataType:'json',
                data:form.serialize(),
                success : function(response) {

                    var html=('<div class="modal-dialog  modal-lg"><div class="modal-content"><div class="modal-header">');
                    html+=('<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button><h4 class="modal-title">试卷添加题目</h4></div><div class="modal-body">');
                    html+=('<form class="form-inline well well-sm" action="" id="modalForm"><div class="form-group"><select class="form-control" name="belong_to"  style="width:200px;height:32px;"><option value="">--按从属--</option>');
                    html+=('<option value="-1">本课程</option>');
                    $(response.chapterList).each(function(i,val) {
                        html+=('<option value="'+val.id+'">第'+(i+1)+'章:'+val.hour_title+'</option>');
                    });
                    html+=('</select></div><div class="form-group"><input type="text" id="keyword" name="stem" class="form-control" value="" placeholder="关键词"></div>');
                    html+=('<button class="btn btn-primary btn-sm exam-add-question" type="button" value="'+type+'">搜索</button></form><table class="table table-condensed">');
                    html+=('<thead><tr><th width="45%">题干</th><th>类型</th><th>分值</th><th>操作</th></tr></thead><tbody>');
                    questionViews=response.questionViews;
                    $(response.questionViews).each(function(i,val) {
                        var belong="";
                        if(val.belong_type==0){
                            belong="本课程";
                        }
                        if(val.belong_type==1){
                            belong=val.hour_title;
                        }
                        var  typeValue;
                        if(type==0){
                            typeValue="多选题";
                        }
                        if(type==1){
                            typeValue="填空题";
                        }
                        if(type==2){
                            typeValue="判断题";
                        }
                        if(type==3){
                            typeValue="问答题";
                        }
                        if(type==4){
                            typeValue="材料题";
                        }
                        if(type==5){
                            typeValue="单选题";
                        }
                        html+=('<tr><td>'+val.stem+'<small class="text-muted">从属：'+belong+'</small></td><td>'+typeValue+'</td><td>'+val.score+'</td><td><button class="btn btn-default btn-sm newWindowPreview" data-target='+val.id+'>预览</button>&nbsp;<button type="button" class="btn btn-primary btn-sm choose_question" value="'+type+'" data-target='+i+'>选择</button></td></tr>');
                    });
                    html+= ('</tbody></table></div><div class="modal-footer"><button type="button" class="btn btn-link" data-dismiss="modal">关闭</button></div></div></div>');
                    $('#modal1').append(html);
                    $('#modal1').modal('show');

                }
            });

        })
        // 替换试题
        $(document).on("click",".exam-replace-question",function(){
            var index=  $(this).parent().parent().parent().parent().index();
            var type;
            if(index==1){
                type=5;
            }if(index==2){
                type=0;
            }if(index==3){
                type=1;
            }if(index==4){
                type=2;
            }if(index==5){
                type=3;
            }if(index==6){
                type=4;
            }

            var form=$(".form-horizontal");
            var form1=$("#modalForm");
            var replace=$(this).attr("data-id");
            var url='${pageContext.request.contextPath}/testPaper/ajax_question.action?courseId=${courseView.id}&type='+type;
            if(form1.length>0){
                url+='&';
                url+=form1.serialize();
                $('#modal1').html('');
            }
            $.ajax({
                url : url,
                dataType:'json',
                data:form.serialize(),
                success : function(response) {
                    var html=('<div class="modal-dialog  modal-lg"><div class="modal-content"><div class="modal-header">');
                    html+=('<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button><h4 class="modal-title">试卷添加题目</h4></div><div class="modal-body">');
                    html+=('<form class="form-inline well well-sm" action="" id="modalForm"><div class="form-group"><select class="form-control" name="belong_to"  style="width:200px;height:32px;"><option value="">--按从属--</option>');
                    html+=('<option value="-1">本课程</option>');
                    $(response.chapterList).each(function(i,val) {
                        html+=('<option value="'+val.id+'">第'+(i+1)+'章:'+val.hour_title+'</option>');
                    });
                    html+=('</select></div><div class="form-group"><input type="text" id="keyword" name="stem" class="form-control" value="" placeholder="关键词"></div>');
                    html+=('<button class="btn btn-primary btn-sm exam-add-question" type="button" value="'+type+'">搜索</button></form><table class="table table-condensed">');
                    html+=('<thead><tr><th width="45%">题干</th><th>类型</th><th>分值</th><th>操作</th></tr></thead><tbody>');
                    questionViews=response.questionViews;
                    $(response.questionViews).each(function(i,val) {
                        var belong="";
                        if(val.belong_type==0){
                            belong="本课程";
                        }
                        if(val.belong_type==1){
                            belong=val.hour_title;
                        }
                        var  typeValue;
                        if(type==0){
                            typeValue="多选题";
                        }
                        if(type==1){
                            typeValue="填空题";
                        }
                        if(type==2){
                            typeValue="判断题";
                        }
                        if(type==3){
                            typeValue="问答题";
                        }
                        if(type==4){
                            typeValue="材料题";
                        }
                        if(type==5){
                            typeValue="单选题";
                        }
                        html+=('<tr><td>'+val.stem+'<small class="text-muted">从属：'+belong+'</small></td><td>'+typeValue+'</td><td>'+val.score+'</td><td><button class="btn btn-default btn-sm newWindowPreview" data-target='+val.id+'>预览</button>&nbsp;<button type="button" class="btn btn-primary btn-sm choose_question" value="'+type+'" data-target='+i+' data-replace='+replace+'>替换</button></td></tr>');
                    });
                    html+= ('</tbody></table></div><div class="modal-footer"><button type="button" class="btn btn-link" data-dismiss="modal">关闭</button></div></div></div>');
                    $('#modal1').append(html);
                    $('#modal1').modal('show');

                }
            });

        })
        // 保存试卷
        $(document).on("click",".request-save",function(){
            var accord_score= parseInt($("#accord_score").val());
            var totalscore=parseInt('${testPaperView.total_score}');
            if(accord_score<0||accord_score>totalscore){
                $(".help-block").html("分数只能是<=试卷总分、且>0");
                $(".help-block").css("color","red");
                $(".help-block").show();
                return false;
            }
            $('#modal1').html('');
            var score_reg = /^[0-9]+\.?[0-9]*$/;
            //选择题 
            var num0=$(".testpaper-table-tbody:eq(0)").find(".is-question").length;
            var score0=0;
            var flag = 3;
            $(".testpaper-table-tbody:eq(0)").find($("input[name=scores]")).each(function(){
				var selectOneVal = $(this).val();
				if(!score_reg.test(selectOneVal)){
					flag = 1;
					return;
				}
				var selectOneNum = parseFloat(selectOneVal);
				if(selectOneNum<=0){
					flag = 2;
					return;
				}
                score0+=selectOneNum;
            });
			if(flag===1){
				alert("单选题题目分值只能输入数字");
				return false;
			}else if(flag===2){
				alert("单选题题目分值必须大于0");
				return false;
			}
			//多选题
            var num1=$(".testpaper-table-tbody:eq(1)").find(".is-question").length;
            var score1=0;
            $(".testpaper-table-tbody:eq(1)").find($("input[name=scores]")).each(function(){
            	var checkVal = $(this).val();
				if(!score_reg.test(checkVal)){
					flag = 1;
					return;
				}
				var checkNum = parseFloat(checkVal);
				if(checkNum<=0){
					flag = 2;
					return;
				}
                score1+=checkNum;
            });
            if(flag===1){
				alert("多选题题目分值只能输入数字");
				return false;
			}else if(flag===2){
				alert("多选题题目分值必须大于0");
				return false;
			}
            //填空题
            var num2=$(".testpaper-table-tbody:eq(2)").find(".is-question").length;
            var score2=0;
            $(".testpaper-table-tbody:eq(2)").find($("input[name=scores]")).each(function(){
            	var fillVal = $(this).val();
				if(!score_reg.test(fillVal)){
					flag = 1;
					return;
				}
				var fillNum = parseFloat(fillVal);
				if(fillNum<=0){
					flag = 2;
					return;
				}
                score2+=fillNum;
            });
            if(flag===1){
				alert("填空题题目分值只能输入数字");
				return false;
			}else if(flag===2){
				alert("填空题题目分值必须大于0");
				return false;
			}
            //判断题
            var num3=$(".testpaper-table-tbody:eq(3)").find(".is-question").length;
            var score3=0;
            $(".testpaper-table-tbody:eq(3)").find($("input[name=scores]")).each(function(){
            	var judgeVal = $(this).val();
				if(!score_reg.test(judgeVal)){
					flag = 1;
					return;
				}
				var judgeNum = parseFloat(judgeVal);
				if(judgeNum<=0){
					flag = 2;
					return;
				}
                score3+=judgeNum;
            });
            if(flag===1){
				alert("判断题题目分值只能输入数字");
				return false;
			}else if(flag===2){
				alert("判断题题目分值必须大于0");
				return false;
			}
            //问答题
            var num4=$(".testpaper-table-tbody:eq(4)").find(".is-question").length;
            var score4=0;
            $(".testpaper-table-tbody:eq(4)").find($("input[name=scores]")).each(function(){
            	var qaVal = $(this).val();
				if(!score_reg.test(qaVal)){
					flag = 1;
					return;
				}
				var qaNum = parseFloat(qaVal);
				if(qaNum<=0){
					flag = 2;
					return;
				}
                score4+=qaNum;
            });
            if(flag===1){
				alert("问答题题目分值只能输入数字");
				return false;
			}else if(flag===2){
				alert("问答题题目分值必须大于0");
				return false;
			}
            //材料题
            var num5=$(".testpaper-table-tbody:eq(5)").find(".is-sub-question").length;
            var score5=0;
            $(".testpaper-table-tbody:eq(5)").find(".is-sub-question").find($("input[name=scores]")).each(function(){
            	var scienceVal = $(this).val();
				if(!score_reg.test(scienceVal)){
					flag = 1;
					return;
				}
				var scienceNum = parseFloat(scienceVal);
				if(scienceNum<=0){
					flag = 2;
					return;
				}
                score5+=scienceNum;
            });
            if(flag===1){
				alert("材料题题目分值只能输入数字");
				return false;
			}else if(flag===2){
				alert("材料题题目分值必须大于0");
				return false;
			}
            var num=num0+num1+num2+num3+num4+num5;
            var score=score0+score1+score2+score3+score4+score5;
            var   html=('<div class="modal-dialog"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button><h4 class="modal-title">确认试卷题目信息</h4></div><div class="modal-body"><table class="table table-bordered"><thead><tr><th>题目类型</th><th>题目数量</th><th>总分值</th></tr></thead><tbody class="detail-tbody">');
            html+=('<tr><td>单选题</td><td>'+num0+'</td><td>'+score0+'</td></tr>');
            html+=('<tr><td>多选题</td><td>'+num1+'</td><td>'+score1+'</td></tr>');
            html+=('<tr><td>填空题</td><td>'+num2+'</td><td>'+score2+'</td></tr>');
            html+=('<tr><td>判断题</td><td>'+num3+'</td><td>'+score3+'</td></tr>');
            html+=('<tr><td>问答题</td><td>'+num4+'</td><td>'+score4+'</td></tr>');
            html+=('<tr><td>材料题</td><td>'+num5+'</td><td>'+score5+'</td></tr>');
            html+=('<tr><td>总计</td><td>'+num+'</td><td>'+score+'</td></tr></tbody></table></div><div class="modal-footer"><button type="button" class="btn btn-link" data-dismiss="modal">关闭</button><button type="button" class="btn btn-primary confirm-submit">确定</button></div></div></div>');
            $('#modal1').append(html);
            $('#modal1').modal('show');
        });
        //选择题目，替换题目
        $(document).on('click',".choose_question",function(){
            var type= $(this).val();
            var  typeValue;
            var i=$(this).attr("data-target");
            var replace=$(this).attr("data-replace");
            var questionView=questionViews[i];
            if(type==0){
                typeValue="多选题";
            }
            if(type==1){
                typeValue="填空题";
            }
            if(type==2){
                typeValue="判断题";
            }
            if(type==3){
                typeValue="问答题";
            }
            if(type==4){
                typeValue="材料题";
            }
            if(type==5){
                typeValue="单选题";
            }
            var difficulty="";
            if(questionView.difficulty==0){
                difficulty="简单";
            }
            if(questionView.difficulty==1){
                difficulty="一般";
            }
            if(questionView.difficulty==2){
                difficulty="困难";
            }
            var belong="";
            if(questionView.belong_type==0){
                belong="本课程";
            }
            if(questionView.belong_type==1){
                belong=questionView.hour_title;
            }
            var i;
            if(type==0){
                i=1;
            }  if(type==1){
                i=2;
            }  if(type==2){
                i=3;
            }  if(type==3){
                i=4;
            }  if(type==4){
                i=5;
            }  if(type==5){
                i=0;
            }
            var seq_html=$(".testpaper-table-tbody:eq("+i+")");
            var seq;

            if(replace){
                seq= $("[data-question="+replace+"]").find($(".seq")).html();
                if(type==4){
                    $("[data-question="+replace+"]").nextAll().each(function(){
                        //is-sub-question
                        var son=$.trim($(this).attr('class'));
                        if(son=="is-sub-question"){
                            seq= parseInt($(this).find($(".seq")).html());
                            return false;
                        }
                    });
                    if(!seq){
                        for(var i=type;i>=0;i--){
                            var seq_num= $(".testpaper-table-tbody:eq("+i+")").find(".seq:last");
                            if(seq_num.length>0){
                                seq=parseInt(seq_num.html());
                                break;
                            }else{
                                seq=0;
                            }
                        }
                        seq+=1;
                    }
                }

            }
            else{
                for(;i>=0;i--){
                    var seq_num= $(".testpaper-table-tbody:eq("+i+")").find(".seq:last");
                    if(seq_num.length>0){
                        seq=seq_num.html();
                        break;
                    }else{
                        seq=0;
                    }
                }
                seq=parseInt(seq);
                $(".seq").each(function(){
                    if($(this).html()>seq){
                        var html=parseInt($(this).html());
                        html+=1;
                        $(this).html(html);

                    }

                });
                $("[name=seq]").each(function(){
                    if($(this).val()>seq){
                        var val=parseInt($(this).val());
                        val+=1;
                        $(this).val(val);
                    }

                });
                seq+=1;
            }

            var input="";
            input+=('<tr class=" is-question" data-question="'+questionView.id+'"><td><span class="glyphicon glyphicon-resize-vertical sort-handle"></span></td>');
            input+=('<td><input class="notMoveHandle subCheckbox" type="checkbox" >');
            input+=('<input type="hidden" value="'+seq+'" name="seq"></td>');
            if(type==4){
                input+=('<td class="seq1">~</td>');
            }else{
                input+=('<td class="seq">'+seq+'</td>');
            }
            input+=('<td>'+questionView.stem+'<div class="text-muted text-sm">');
            input+=('从属于  '+belong+'</div></td>');
            input+=('<td>'+typeValue+'</td> <td>');
            input+=(difficulty+'</td> <td>');
            if(type!=4){
                input+=('<input style="height: 30px;" name="scores" class="notMoveHandle form-control input-sm" type="text" value="'+questionView.score+'">');
            }else{
                input+=('<input name="scores" class="notMoveHandle form-control input-sm" type="hidden" value="">');
            }
            input+=('<input name="list" value="'+questionView.id+'" type="hidden"> </td><td>');
            input+=('<div class="btn-group"> <a href="javascript:;" class="notMoveHandle btn btn-default btn-sm show_pop"  data-target="'+questionView.id+'">预览</a>');
            input+=('<a href="javascript:" class="notMoveHandle btn btn-default btn-sm item-delete-btn del-question">删除</a><a href="javascript:" class="notMoveHandle btn btn-default btn-sm exam-replace-question" data-id="'+questionView.id+'">替换</a></div></td></tr>');
            if(type!=4){
                if(replace){
                    $("[data-question="+replace+"]").replaceWith(input);
                }else{
                    seq_html.append(input);
                }
                $('#modal1').modal('hide');
            }else{
                var url='${pageContext.request.contextPath}/testPaper/ajax_add_son_question.action?courseId=${courseView.id}';
                $.ajax({
                    url : url,
                    dataType:'json',
                    data:{
                        seq:seq,
                        pid:questionView.id,
                        hour_title:belong
                    },
                    success : function(response) {
                        input+=response.html;
                        var seq1=response.seq;
                        if(replace){
                            $("[data-question="+replace+"]").nextAll().each(function(){
                                var son=$.trim($(this).attr('class'));
                                if(son=="is-sub-question"){
                                    var seq= parseInt($(this).find($(".seq")).html());
                                    $(".seq").each(function(){
                                        if(parseInt($(this).html())>seq){
                                            var html=parseInt($(this).html());
                                            var seqv=$("input[value="+html+"][name=seq]");
                                            html-=1;
                                            seqv.val(html);
                                            $(this).html(html);
                                        }
                                    });
                                    $(this).remove();
                                }else{
                                    return false;
                                }
                            });
                            $(".seq").each(function(){
                                if(parseInt($(this).html())>(seq-1)){
                                    var html=parseInt($(this).html());
                                    var seqv=$("input[value="+html+"][name=seq]");
                                    html+=(seq1-seq);
                                    seqv.val(html);
                                    $(this).html(html);
                                }
                            });
                            $("[data-question="+replace+"]").replaceWith(input);
                        }else{
                            seq_html.append(input);
                        }
                        $('#modal1').modal('hide');

                    }
                });

            }
        });
        //提交
        $(document).on("click",".confirm-submit",function(){
            $(".form-horizontal").submit();
        });
    })

</script>

<%--<jsp:include page="../layout/footer.jsp"></jsp:include>--%>