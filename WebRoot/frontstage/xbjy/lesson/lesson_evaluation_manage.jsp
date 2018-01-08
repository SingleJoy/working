<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<div class="cn-wrap" >

    <div id="content-container" class="container">

        <jsp:include page="/frontstage/xbjy/lesson/lesson_header.jsp"></jsp:include>

        <div class="course-detail row" style="margin-top: 20px;">

            <jsp:include page="/frontstage/xbjy/lesson/lesson_left.jsp"></jsp:include>

            <div class="col-lg-9 col-md-8  course-detail-main">
            	<c:if test="${lesson.status!=2}">
                    <div class="panel panel-default panel-col ">
                        <div class="panel-heading">
                           课例评价
                        </div>
                        <div class="panel-body">
                            <div class="empty">课例未完成不可评价</div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${lesson.status==2}">

                <div class="panel panel-default panel-col course-data">
                    <div class="panel-heading">课例评价
                    	<c:if test="${mark==0}" >
                        <button type="button" class="btn btn-info pull-right"  data-target="#new-lesson-evaluation" data-toggle="modal">新增</button>
                    	</c:if>
                    </div>
                    
                    <c:if test="${empty lessonAssessList}">
                        <div class="panel-body">
                            <div class="empty">暂无数据</div>
                        </div>
                </c:if>
                <c:if test="${!empty lessonAssessList}">

                    <div class="panel-body">
                        <div class="table-responsive">
                            <table class="table table-striped member-statistics" style="text-align: center;">
                                <tbody>
                                <tr>
                                    <td class="active" width="10%">姓名</td>
                                    <td class="active" width="10%">专家</td>
                                    <td class="active" width="21%">评价时间</td>
                                    <td class="active" width="44%">评价意见</td>
                                    <td class="active" width="7%">推优</td>
                                    <td class="active" width="8%">操作</td>
                                </tr>
                                <c:forEach items="${lessonAssessList }" var="lessonAssess">
                                    <tr>
                                        <td >${lessonAssess.true_name}</td>
                                        <td >指导老师</td>
                                        <td>${lessonAssess.update_time}</td>
                                        <td style="text-align: left;">${lessonAssess.opinion}</td>
                                        <c:if test="${lessonAssess.excellent==1}">
                                            <td><span class="text-danger">是</span></td>
                                        </c:if>
                                        <c:if test="${lessonAssess.excellent==0}">
                                            <td>否</td>
                                        </c:if>
                                        <c:if test="${lessonAssess.user_id==user.id}">
                                            <td>
                                                <a href="javascript:void(0);" class="text-warning" data-target="#update-lesson-evaluation" data-toggle="modal" onclick="updateAssess(${lessonAssess.id});">修改</a>
                                            </td>
                                        </c:if>
                                        <c:if test="${lessonAssess.user_id!=user.id}">
                                            <td>

                                            </td>
                                        </c:if>

                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>

                        </div>
                    </div>
                    </c:if>
                </div>
                </c:if>
            </div>

        </div>
    </div>

</div>

<jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
<!-- 新增课例评价弹窗 -->
<div id="new-lesson-evaluation" class="modal" data-toggle="modal" style="display: none;">
    <div class="modal-dialog  modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">课例评价</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="saveLessonAssess" action="${pageContext.request.contextPath}/lesson_assess/save_lesson_assess.action" method="post">
                    <input id="lesson_id" name="lesson_id" value="${lesson.id}" type="hidden">

                    <div class="form-group" >
                        <label class="col-md-2 control-label"><span class="text-danger">*</span>点评意见:</label>
                        <div class="col-md-8 controls">
                            <textarea name="opinion"  class="form-control" placeholder="请输入评价(不超过500字)" cols="8" rows="6">${lessonAssess.opinion}</textarea>
                            <div class="text-warning" style="display:none;"></div>
                        </div>
                    </div>

                    <div class="row form-group">
                        <div class="col-md-2 control-label">
                            <label><span class="text-danger">*</span>优秀课例</label>
                        </div>
                        <div class="col-md-8 controls radios">
                            <label>
                                <input  type="radio" name="excellent"  value="1" <c:if test="${lessonAssess.excellent==1}" >checked="checked"</c:if>> 是
                            </label>
                            <label>
                                <input  type="radio" name="excellent" value="0" <c:if test="${lessonAssess.excellent==0}" >checked="checked"</c:if>> 否
                            </label>

                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button"  class="btn btn-fat btn-primary" onclick="doSumbit();">保存</button>
                    </div>

                </form>
            </div>



        </div>
    </div>
</div>

<!-- 修改课例评价弹窗 -->
<div id="update-lesson-evaluation" class="modal" data-toggle="modal" style="display: none;">
    <div class="modal-dialog  modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">课例评价</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="updateLessonAssess" action="${pageContext.request.contextPath}/lesson_assess/save_lesson_assess.action" method="post">
                    <input id="lesson_id" name="lesson_id" value="${lesson.id}" type="hidden">
                    <div id="showAssess"></div>

                    <div class="form-group" >
                        <label class="col-md-2 control-label"><span class="text-danger">*</span>点评意见:</label>
                        <div class="col-md-8 controls" id="assess_opinion">
                        </div>
                    </div>

                    <div class="row form-group">
                        <div class="col-md-2 control-label">
                            <label><span class="text-danger">*</span>优秀课例</label>
                        </div>
                        <div class="col-md-8 controls radios" id="assess_excellent">


                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button"  class="btn btn-fat btn-primary" onclick="updateSumbit();">保存</button>
                    </div>

                </form>
            </div>

        </div>
    </div>
</div>

<script type="text/javascript">
    function updateSumbit(){
        document.getElementById('updateLessonAssess').submit();
    }
    //验证是否评价过
    function doSumbit(){
        $.ajax({
            url : '${pageContext.request.contextPath}/lesson_assess/check_lesson_assess.action',
            dataType : 'json',
            data:{
                lesson_id :$('#lesson_id').val()
            },
            success:function(data){
                var list = data.lessonAssess;
                var len = list.length;
                if(len > 0) {
                    alert("您已经评价过了！");
                }else{
                    document.getElementById('saveLessonAssess').submit();
                }
            }
        });
    }

    function updateAssess(value){
//	alert(value);
        $.ajax({
            url : '${pageContext.request.contextPath}/lesson_assess/show_assess.action',
            dataType : 'json',
            data:{
                id : value
            },
            success : function(data){
                var list = data.lessonAssess;
                //               alert(data.lessonAssess.id+"aaaaa"+data.lessonAssess.user_id);
                $("#showAssess").html('');
                var row1 = '<input type="hidden" id="id" name="id" value="'+data.lessonAssess.id+'">';
                $("#showAssess").append(row1);
                $("#assess_opinion").html('');
                var row2 = '<textarea name="opinion"  class="form-control" placeholder="请输入评价(不超过500字)" cols="8" rows="6">'+data.lessonAssess.opinion+'</textarea>';
                $("#assess_opinion").append(row2);
                $("#assess_excellent").html('');
                var row3 = '';
                if(data.lessonAssess.excellent==1){
                    row3 +='<label>'+
                    '<input  type="radio" name="excellent"  value="1" checked="checked"> 是'+
                    '</label>'+
                    '<label>'+
                    '<input  type="radio" name="excellent" value="0"> 否'+
                    '</label>';
                }else{
                    row3 +='<label>'+
                    '<input  type="radio" name="excellent"  value="1"> 是'+
                    '</label>'+
                    '<label>'+
                    '<input  type="radio" name="excellent" value="0" checked="checked"> 否'+
                    '</label>';
                }
                $("#assess_excellent").append(row3);

            }
        });
    }
</script>
