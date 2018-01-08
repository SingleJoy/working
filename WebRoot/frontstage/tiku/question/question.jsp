<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>


<link href="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.js"></script>
<style>
    #defaultImg{  width:540px;height:270px;}
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
                        <div class="pull-right">
                            <a href="${pageContext.request.contextPath}/question/to_question_add.action?tab=0&courseId=${courseView.id}&flag=2&sign=10&is_son=1"  class="btn btn-info btn-sm"><span class="glyphicon glyphicon-plus"></span> 选择题</a>
                            <a href="${pageContext.request.contextPath}/question/to_question_add.action?tab=1&courseId=${courseView.id}&flag=2&sign=10&is_son=1"   class="btn btn-info btn-sm"><span class="glyphicon glyphicon-plus"></span> 填空题</a>
                            <a href="${pageContext.request.contextPath}/question/to_question_add.action?tab=2&courseId=${courseView.id}&flag=2&sign=10&is_son=1"   class="btn btn-info btn-sm"><span class="glyphicon glyphicon-plus"></span> 判断题</a>
                            <a href="${pageContext.request.contextPath}/question/to_question_add.action?tab=3&courseId=${courseView.id}&flag=2&sign=10&is_son=1"   class="btn btn-info btn-sm"><span class="glyphicon glyphicon-plus"></span> 问答题</a>
                            <a href="${pageContext.request.contextPath}/question/to_question_add.action?tab=4&courseId=${courseView.id}&flag=2&sign=10&is_son=1"   class="btn btn-info btn-sm"><span class="glyphicon glyphicon-plus"></span> 材料题</a>
                        </div>
                        题目管理
                    </div>
                    <div class="panel-body " id="quiz-table-container">
                        <form class="form-inline well well-sm" action="${pageContext.request.contextPath}/question/to_question.action" method="post" novalidate="">
                            <input type="hidden" name="flag" value="${courseView.flag}">
                            <input type="hidden" name="sign" value="${courseView.sign}">
                            <input type="hidden" name="courseId" value="${courseView.id}">
                            <div class="form-group">
                                <select class="form-control" name="type" style="width:100px;">
                                    <option value="-1">--按题型--</option>
                                    <option value="5">单选题</option>
                                    <option value="0">多选题</option>
                                    <option value="1">填空题</option>
                                    <option value="2">判断题</option>
                                    <option value="3">问答题</option>
                                    <option value="4">材料题</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <select class="form-control" name="belong_to" style="width:200px;">
                                    <option value="">--按从属--</option>
                                    <option value="-1">本课程</option>
                                    <c:forEach items="${chapterList}" var="chapter" varStatus="status1">

                                        <option value="${chapter.id}">第${status1.index+1}章：${chapter.hour_title}</option>

                                    </c:forEach> </select>
                            </div>
                            <div class="form-group">
                                <input type="text" id="keyword" name="stem" class="form-control" value="" placeholder="关键词">
                            </div>
                            <button class="btn btn-primary btn-sm">搜索</button>
                        </form>
                        <table class="table  table-hover" id="quiz-table">
                            <thead>
                            <tr>
                                <th><input class="checkAll subCheckbox" type="checkbox" autocomplete="off"></th>
                                <th width="50%" >题干</th>
                                <th>类型</th>
                                <th>最后更新</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody class="sel-div">
                            <c:forEach items="${questionViews }" var="questionView">

                                <%


                                %>
                                <c:if test="${questionView.type==4 }">
                                    <tr>
                                        <td><input class="subCheckbox" type="checkbox" autocomplete="off" value="${questionView.id}"></td>
                                        <td>
                                            <c:if test="${fn:length(questionView.stem.trim())>30}">

                                                <a href="javascript:;" class="show_pop" data-target="${questionView.id}"> <c:if test="${questionView.isImg==1}"><span class="glyphicon glyphicon-picture"></span></c:if>
                                                        ${questionView.stem.trim()}...</a>


                                            </c:if>
                                            <c:if test="${fn:length(questionView.stem.trim())<=30}">
                                                <a href="javascript:;" class="show_pop" data-target="${questionView.id}"> <c:if test="${questionView.isImg==1}"><span class="glyphicon glyphicon-picture"></span></c:if>
                                                        ${questionView.stem.trim()}</a>

                                            </c:if>
                                            <div>
                                                <c:if test="${questionView.belong_type==0}">
                                                    <small class="text-muted">从属于 本课程</small>
                                                </c:if>
                                                <c:if test="${questionView.belong_type==1}">
                                                    <small class="text-muted">从属于 ${questionView.hour_title}</small>
                                                </c:if>
                                            </div>
                                        </td>
                                        <td>
                                            材料题<br>
                                            <small class="text-muted">(${questionView.son}子题)</small>
                                        </td>
                                        <td>
                                            <a class="link-dark " href="javascript:void(0);">${questionView.username}</a>
                                            <br>
                                            <span class="text-muted text-sm">${questionView.update_time}</span>
                                        </td>
                                        <td>
                                            <div class="btn-group">
                                                <a href="javascript:;" class="btn btn-default btn-sm show_pop" data-toggle="modal" data-target="${questionView.id}">预览</a>
                                                <a href="javascript:;" type="button" class="btn btn-default btn-sm" data-toggle="dropdown">
                                                    <span class="caret"></span>
                                                </a>
                                                <ul class="dropdown-menu pull-right">
                                                    <li>
                                                        <a href="${pageContext.request.contextPath}/question/to_question_son.action?id=${questionView.id}&courseId=${courseView.id}&flag=2&sign=10"><span class="glyphicon glyphicon-list"></span> 管理子题</a>
                                                    </li>
                                                    <li>
                                                        <a href="${pageContext.request.contextPath}/question/to_question_add.action?id=${questionView.id}&tab=4&courseId=${courseView.id}&flag=2&sign=10&is_son=1"><span class="glyphicon glyphicon-edit"></span> 编辑</a>
                                                    </li>
                                                    <li>
                                                        <a href="${pageContext.request.contextPath}/question/delete_question.action?ids=${questionView.id}" onclick="return false" class="del-question">
                                                            <span class="glyphicon glyphicon-remove-circle"></span> 删除
                                                        </a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </td>
                                    </tr>
                                </c:if>
                                <c:if test="${questionView.type==3 }">
                                    <tr>
                                        <td>
                                            <input class="subCheckbox" type="checkbox" autocomplete="off"  value="${questionView.id}">
                                        </td>
                                        <td>
                                            <c:if test="${fn:length(questionView.stem.trim())>30}">

                                                <a href="javascript:;" class="show_pop" data-target="${questionView.id}"> <c:if test="${questionView.isImg==1}"><span class="glyphicon glyphicon-picture"></span></c:if>
                                                        ${questionView.stem.trim()}...</a>
                                            </c:if>
                                            <c:if test="${fn:length(questionView.stem.trim())<=30}">
                                                <a href="javascript:;" class="show_pop" data-target="${questionView.id}"> <c:if test="${questionView.isImg==1}"><span class="glyphicon glyphicon-picture"></span></c:if>
                                                        ${questionView.stem.trim()}</a>

                                            </c:if>
                                            <div>
                                                <c:if test="${questionView.belong_type==0}">
                                                    <small class="text-muted">从属于 本课程</small>
                                                </c:if>
                                                <c:if test="${questionView.belong_type==1}">
                                                    <small class="text-muted">从属于 ${questionView.hour_title}</small>
                                                </c:if>
                                            </div>
                                        </td>
                                        <td>
                                            问答题
                                        </td>
                                        <td>
                                            <a class="link-dark " href="javascript:void(0);">${questionView.username}</a>
                                            <br>
                                            <span class="text-muted text-sm">${questionView.update_time}</span>
                                        </td>
                                        <td>
                                            <div class="btn-group">
                                                <a href="javascript:;" class="btn btn-default btn-sm show_pop" data-toggle="modal" data-target="${questionView.id}">预览</a>
                                                <a href="javascript:;" type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></a>
                                                <ul class="dropdown-menu pull-right">
                                                    <li><a href="${pageContext.request.contextPath}/question/to_question_add.action?id=${questionView.id}&tab=3&courseId=${courseView.id}&flag=2&sign=10&is_son=1"><span class="glyphicon glyphicon-edit"></span> 编辑</a></li>
                                                    <li>
                                                        <a href="${pageContext.request.contextPath}/question/delete_question.action?ids=${questionView.id}" onclick="return false" class="del-question"><span class="glyphicon glyphicon-remove-circle"></span> 删除</a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </td>
                                    </tr>
                                </c:if>
                                <c:if test="${questionView.type==2 }">
                                    <tr>
                                        <td><input class="subCheckbox" type="checkbox" autocomplete="off" value="${questionView.id}"></td>
                                        <td>
                                            <c:if test="${fn:length(questionView.stem.trim())>30}">

                                                <a href="javascript:;" class="show_pop" data-target="${questionView.id}"> <c:if test="${questionView.isImg==1}"><span class="glyphicon glyphicon-picture"></span></c:if>
                                                        ${questionView.stem.trim()}...</a>
                                            </c:if>
                                            <c:if test="${fn:length(questionView.stem.trim())<=30}">
                                                <a href="javascript:;" class="show_pop" data-target="${questionView.id}"> <c:if test="${questionView.isImg==1}"><span class="glyphicon glyphicon-picture"></span></c:if>
                                                        ${questionView.stem.trim()}</a>

                                            </c:if>
                                            <div>
                                                <c:if test="${questionView.belong_type==0}">
                                                    <small class="text-muted">从属于 本课程</small>
                                                </c:if>
                                                <c:if test="${questionView.belong_type==1}">
                                                    <small class="text-muted">从属于 ${questionView.hour_title}</small>
                                                </c:if>
                                            </div>
                                        </td>
                                        <td>
                                            判断题
                                        </td>
                                        <td>
                                            <a class="link-dark " href=javascript:void(0);">${questionView.username}</a>
                                            <br>
                                            <span class="text-muted text-sm">${questionView.update_time}</span>
                                        </td>
                                        <td>
                                            <div class="btn-group">
                                                <a href="javascript:;" class="btn btn-default btn-sm show_pop" data-toggle="modal" data-target="${questionView.id}">预览</a>
                                                <a href="javascript:;" type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></a>
                                                <ul class="dropdown-menu pull-right">
                                                    <li><a href="${pageContext.request.contextPath}/question/to_question_add.action?id=${questionView.id}&tab=2&courseId=${courseView.id}&flag=2&sign=10&is_son=1"><span class="glyphicon glyphicon-edit"></span> 编辑</a></li>
                                                    <li>
                                                        <a href="${pageContext.request.contextPath}/question/delete_question.action?ids=${questionView.id}" onclick="return false" class="del-question" ><span class="glyphicon glyphicon-remove-circle"></span> 删除</a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </td>
                                    </tr>
                                </c:if>
                                <c:if test="${questionView.type==1 }">
                                    <tr>
                                        <td><input class="subCheckbox" type="checkbox" autocomplete="off" value="${questionView.id}"></td>
                                        <td>
                                            <c:if test="${fn:length(questionView.stem.trim())>30}">

                                                <a href="javascript:;" class="show_pop" data-target="${questionView.id}"> <c:if test="${questionView.isImg==1}"><span class="glyphicon glyphicon-picture"></span></c:if>
                                                        ${questionView.stem.trim()}...</a>
                                            </c:if>
                                            <c:if test="${fn:length(questionView.stem.trim())<=30}">
                                                <a href="javascript:;" class="show_pop" data-target="${questionView.id}"> <c:if test="${questionView.isImg==1}"><span class="glyphicon glyphicon-picture"></span></c:if>
                                                        ${questionView.stem.trim()}</a>

                                            </c:if>
                                            <div>
                                                <c:if test="${questionView.belong_type==0}">
                                                    <small class="text-muted">从属于 本课程</small>
                                                </c:if>
                                                <c:if test="${questionView.belong_type==1}">
                                                    <small class="text-muted">从属于 ${questionView.hour_title}</small>
                                                </c:if>
                                            </div>
                                        </td>
                                        <td> 填空题 </td>
                                        <td>
                                            <a class="link-dark " href="javascript:void(0);">${questionView.username}</a>
                                            <br>
                                            <span class="text-muted text-sm">${questionView.update_time}</span>
                                        </td>
                                        <td>
                                            <div class="btn-group">
                                                <a href="javascript:;" class="btn btn-default btn-sm show_pop" data-toggle="modal" data-target="${questionView.id}">预览</a>
                                                <a href="javascript:;" type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></a>
                                                <ul class="dropdown-menu pull-right">
                                                    <li><a href="${pageContext.request.contextPath}/question/to_question_add.action?id=${questionView.id}&tab=1&courseId=${courseView.id}&flag=2&sign=10&is_son=1"><span class="glyphicon glyphicon-edit"></span> 编辑</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/question/delete_question.action?ids=${questionView.id}" onclick="return false" class="del-question" ><span class="glyphicon glyphicon-remove-circle"></span> 删除</a></li>
                                                </ul>
                                            </div>
                                        </td>
                                    </tr>
                                </c:if>
                                <c:if test="${questionView.type==0||questionView.type==5 }">
                                    <tr>
                                        <td><input class="subCheckbox" type="checkbox" autocomplete="off" value="${questionView.id}"></td>
                                        <td>
                                            <c:if test="${fn:length(questionView.stem.trim())>30}">

                                                <a href="javascript:;" class="show_pop" data-target="${questionView.id}"> <c:if test="${questionView.isImg==1}"><span class="glyphicon glyphicon-picture"></span></c:if>
                                                        ${questionView.stem.trim()}...</a>
                                            </c:if>
                                            <c:if test="${fn:length(questionView.stem.trim())<=30}">
                                                <a href="javascript:;" class="show_pop" data-target="${questionView.id}"> <c:if test="${questionView.isImg==1}"><span class="glyphicon glyphicon-picture"></span></c:if>
                                                        ${questionView.stem.trim()}</a>

                                            </c:if>
                                            <div>
                                                <c:if test="${questionView.belong_type==0}">
                                                    <small class="text-muted">从属于 本课程</small>
                                                </c:if>
                                                <c:if test="${questionView.belong_type==1}">
                                                    <small class="text-muted">从属于 ${questionView.hour_title}</small>
                                                </c:if>
                                            </div>
                                        </td>
                                        <td> <c:if test="${questionView.type==0}">多</c:if><c:if test="${questionView.type==5}">单</c:if>选题 </td>
                                        <td>
                                            <a class="link-dark " href="javascript:void(0);">${questionView.username}</a><br>
                                            <span class="text-muted text-sm">${questionView.update_time}</span>
                                        </td>
                                        <td>
                                            <div class="btn-group">
                                                <a href="javascript:;" class="btn btn-default btn-sm show_pop" data-toggle="modal" data-target="${questionView.id}">预览</a>
                                                <a href="javascript:;" type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></a>
                                                <ul class="dropdown-menu pull-right">
                                                    <li><a href="${pageContext.request.contextPath}/question/to_question_add.action?id=${questionView.id}&tab=0&courseId=${courseView.id}&flag=2&sign=10&is_son=1"><span class="glyphicon glyphicon-edit"></span> 编辑</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/question/delete_question.action?ids=${questionView.id}" onclick="return false"  class="del-question" ><span class="glyphicon glyphicon-remove-circle"></span> 删除</a></li>
                                                </ul>
                                            </div>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                            </tbody>
                        </table>
                        <div>
                            <label class="checkbox-inline">
                                <input class="checkAll subCheckbox" type="checkbox" autocomplete="off"> 全选
                            </label>
                            <button class="btn btn-default btn-sm mlm del-sel" >删除</button>
                            <span class="pull-right text-muted">共<span id="questionTotal">${questionView.total }</span>题</span>
                        </div>
                        <form id="studyCenterForm" action="${pageContext.request.contextPath}/question/to_question.action" method="post">
                            <input type="hidden" name="page" id="page" value="${questionView.page}"/>
                            <input type="hidden" name="rows" id="rows" value="${questionView.rows}"/>
                            <input type="hidden" name="total" id="total" value="${questionView.total}"/>
                            <input type="hidden" name="totalPage" id="totalPage" value="${questionView.totalPage}"/>
                            <input type="hidden" name="flag" value="${courseView.flag}">
                            <input type="hidden" name="sign" value="${courseView.sign}">
                            <input type="hidden" name="courseId" value="${courseView.id}">
                            <input type="hidden"  name="belong_to" value="${questionView.belong_to}">
                            <input type="hidden"  name="type" value="${questionView.type}">
                            <input type="hidden"  name="stem" value="${questionView.stem}">
                        </form>
                        <div id="test" class="pager" style="padding-top: 0;margin-bottom: 20px;"></div>

                        <nav class="text-center"></nav>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>

</div>
<!-- 弹窗 -->
<div id="modal" class="modal in" style="display: none;"  role="dialog"  aria-hidden="true">
    <div class="modal-dialog  modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
                </button>
                <h4 class="modal-title">题目预览</h4>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

    // 预览
    $('.show_pop').click(function(){

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
    if('${courseView.flag}'==0){
        var div='<div class="alert alert-success">题目添加成功。</div>';
        $("#quiz-table-container").prepend(div);
    }
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

    // 全选
    $(".checkAll").click(function () {
        var isChecked = $(this).prop("checked");
        $(".subCheckbox").prop("checked", isChecked);
    });
    //删除选中
    $('.del-sel').click(function(){
    	if(!confirm("您当前选中的试题可能正在被使用,确认删除？")){
			return;
		}
        var ids="";
        $('.sel-div input:checked').each(function(i,ck){
            ids+=$(ck).val();
            ids+=",";
        });
        var url='${pageContext.request.contextPath}/question/delete_question.action?ids='+ids;
        $.ajax({
            url : url,
            dataType : 'json',
            success : function(response) {
                var total=$("#questionTotal").html();
                $("#questionTotal").html(parseInt(total)-response.num);
                $('.sel-div input:checked').each(function(i,ck){
                    $(ck).parent().parent().remove();
                });
            }
        });
        $(".checkAll").prop("checked", false);
    });
	/* 删除试题  */
    $('.del-question').click(function(){
		if(!confirm("当前试题可能正在被使用,确认删除？")){
			return;
		}
        var url=$(this).attr("href");
        var _this=$(this);
        $.ajax({
            url : url,
            dataType : 'json',
            success : function(response) {
                var total=$("#questionTotal").html();
                $("#questionTotal").html(parseInt(total)-response.num);
                _this.parent().parent().parent().parent().parent().remove();
            }
        });
    });

</script>

