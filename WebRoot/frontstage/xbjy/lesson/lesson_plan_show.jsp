<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/JMEditor/jmeditor/jquery-1.8.3.min.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/frontstage/js/My97DatePicker/WdatePicker.js"></script>
<link href="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.js"></script>

<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<div class="cn-wrap" >


    <div id="content-container" class="container">

        <jsp:include page="/frontstage/xbjy/lesson/lesson_header.jsp"></jsp:include>

        <div class="course-detail row" style="margin-top: 20px;">

            <jsp:include page="/frontstage/xbjy/lesson/lesson_left.jsp"></jsp:include>

            <div class="col-lg-9 col-md-8  course-detail-main">
                <c:if test="${lessonLeft.plan101!=1}">
                    <div class="panel panel-default panel-col ">
                        <div class="panel-heading">计划展示</div>
                        <div class="panel-body" style="text-align: center;">
                            <img src="${pageContext.request.contextPath}/frontstage/images/lesson_task_unfinshed.png" style="margin-top: 20px auto;">
                            <div>未制定计划</div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${lessonLeft.plan101==1}">
                    <div class="panel panel-default">
                        <div class="panel-heading">计划展示</div>
                        <div class="panel-body">

                            <form id="saveLessonPlan" action="${pageContext.request.contextPath}/lesson/save_lesson_plan.action" method="post" class="form-horizontal">
                                <input id="lesson_id" name="lesson_id" value="${lesson.id}" type="hidden">
                                <input type="hidden" name="period" id="period" value="${lesson.period}">
                                <input type="hidden" name="credit" id="credit" value="${lesson.credit}">
                                <input id="user_id" name="lesson_id" value="${lesson.user_id}" type="hidden">


                                <table class="table table-striped learning-data-table">
                                    <tbody>
                                    <tr>
                                        <td class="active">课例名称</td>
                                        <td colspan="3">${lesson.name }</td>
                                    </tr>

                                    <tr>
                                        <td class="active">学段 / 学科 / 年级</td>
                                        <td style="width: 25%;">
                                            <c:if test="${lesson.stage_id=='XX' }">小学 /</c:if>
                                            <c:if test="${lesson.stage_id=='CZ' }">初中 /</c:if>
                                            <c:if test="${lesson.stage_id=='GZ' }">高中 /</c:if>

                                            <c:forEach items="${subjectList}" var="sub">
                                                <c:if test="${lesson.subject_id == sub.id}">
                                                    ${sub.subjectName}
                                                </c:if>
                                            </c:forEach>
                                            <c:forEach items="${gradeList}" var="gra">
                                            <c:if test="${lesson.grade_id == gra.id}">
                                               / ${gra.grade_name}
                                            </c:if>
                                        </c:forEach>
                                        </td>
                                        <td class="active" style="text-align: center;">上课老师</td>
                                        <td >${lesson.user_sk_name }</td>
                                    </tr>

                                    <tr>
                                        <td class="active">版本</td>
                                        <td colspan="3">
                                            <c:forEach items="${editionList}" var="edi">
                                                <c:if test="${lesson.press_id == edi.id}">
                                                    ${edi.versionName}
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="active">研究目标</td>
                                        <td colspan="3">${lesson.research}</td>
                                    </tr>
                                    <tr>
                                        <td class="active">研究措施</td>
                                        <td colspan="3">${lesson.measures}</td>
                                    </tr>
                                    <tr>
                                        <td class="active">关键词</td>
                                        <td colspan="3">${lesson.research_key}</td>
                                    </tr>
                                    <tr>
                                        <td class="active" rowspan="4">研究问题</td>
                                        <td colspan="3">计划环节:&nbsp;${lessonProblemView.plan_que}</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: left;" colspan="3">备课环节:&nbsp;${lessonProblemView.prepare_que}</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: left;" colspan="3">上课环节:&nbsp;${lessonProblemView.class_que}</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: left;" colspan="3">评课环节:&nbsp; ${lessonProblemView.assessment_que}</td>
                                    </tr>

                                    </tbody>
                                </table>

                                <table class="table table-striped member-statistics">
                                    <tbody>
                                    <!--计划环节-->
                                    <tr>
                                        <td rowspan="3" style="width: 27%;vertical-align: middle;text-align: center;" class="active">计划环节<br/>
                                            <fmt:formatDate value="${lessonTimeView.plan_sta}" type="date"/>至
                                            <fmt:formatDate value="${lessonTimeView.plan_end}" type="date"/>
                                        </td>
                                        <td style="width: 29%;"><span class="text-danger">*</span>1.制定计划</td>
                                        <td >
                                            <c:forEach items="${lessonUserTaskList }" var="lessonUser">
                                                <c:if test="${lessonUser.purview ==101}">
                                                    <c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>(${lessonUser.user_name })&nbsp;&nbsp;
                                                    <input name="user_id101" value="${lessonUser.user_id }" type="hidden" data-name="save101">
                                                    <input name="mark" value="101" type="hidden" data-name="mark">
                                                </c:if>
                                            </c:forEach>
                                        </td>

                                    </tr>

                                    <tr>
                                        <td ><span class="text-danger">*</span>2.提交教学设计及课件</td>
                                        <td >
                                            <c:forEach items="${lessonUserTaskList }" var="lessonUser">
                                                <c:if test="${lessonUser.purview ==102}">
                                                    <c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>(${lessonUser.user_name })&nbsp;&nbsp;
                                                    <input name="user_id102" value="${lessonUser.user_id }" type="hidden" data-name="save102">
                                                    <input name="mark" value="102" type="hidden" data-name="mark">
                                                </c:if>
                                            </c:forEach>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td >3.问题研讨</td>
                                        <td>
                                            <c:forEach items="${lessonUserTaskList }" var="lessonUser">
                                                <c:if test="${lessonUser.purview ==103}">
                                                    <c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>(${lessonUser.user_name })&nbsp;&nbsp;
                                                    <input name="user_id103" value="${lessonUser.user_id }" type="hidden" data-name="save103">
                                                    <input name="mark" value="103" type="hidden" data-name="mark">
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                    </tr>

                                    <!--备课环节-->
                                    <tr>
                                        <td rowspan="4"  class="active" style="vertical-align: middle;text-align: center;">备课环节<br/>
                                            <fmt:formatDate value="${lessonTimeView.prepare_sta}" type="date"/>至
                                            <fmt:formatDate value="${lessonTimeView.prepare_end}" type="date"/>
                                        </td>
                                        <td ><span class="text-danger">*</span>1.初始教学设计协同修改</td>
                                        <td>
                                            <c:forEach items="${lessonUserTaskList }" var="lessonUser">
                                                <c:if test="${lessonUser.purview ==201}">
                                                    <c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>(${lessonUser.user_name })&nbsp;&nbsp;
                                                    <input name="user_id201" value="${lessonUser.user_id }" type="hidden" data-name="save201">
                                                    <input name="mark" value="201" type="hidden" data-name="mark">
                                                </c:if>
                                            </c:forEach>
                                        </td>

                                    </tr>

                                    <tr>
                                        <td >2.备课研讨会会议纪要</td>
                                        <td >
                                            <c:forEach items="${lessonUserTaskList }" var="lessonUser">
                                                <c:if test="${lessonUser.purview ==202}">
                                                    <c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>(${lessonUser.user_name })&nbsp;&nbsp;
                                                    <input name="user_id202" value="${lessonUser.user_id }" type="hidden" data-name="save202">
                                                    <input name="mark" value="202" type="hidden" data-name="mark">
                                                </c:if>
                                            </c:forEach>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td >3.备课:问题研讨</td>
                                        <td >
                                            <c:forEach items="${lessonUserTaskList }" var="lessonUser">
                                                <c:if test="${lessonUser.purview ==203}">
                                                    <c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>(${lessonUser.user_name })&nbsp;&nbsp;
                                                    <input name="user_id203" value="${lessonUser.user_id }" type="hidden" data-name="save203">
                                                    <input name="mark" value="203" type="hidden" data-name="mark">
                                                </c:if>
                                            </c:forEach></td>
                                    </tr>

                                    <tr>
                                        <td ><span class="text-danger">*</span>4.提交修改后的教学设计</td>
                                        <td >
                                            <c:forEach items="${lessonUserTaskList }" var="lessonUser">
                                                <c:if test="${lessonUser.purview ==204}">
                                                    <c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>(${lessonUser.user_name })&nbsp;&nbsp;
                                                    <input name="user_id204" value="${lessonUser.user_id }" type="hidden" data-name="save204">
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                    </tr>
                                    <!--上课环节-->
                                    <tr>
                                        <td rowspan="4"  class="active" style="vertical-align: middle;text-align: center;">上课环节<br/>
                                            <fmt:formatDate value="${lessonTimeView.class_sta}" type="date"/>至
                                            <fmt:formatDate value="${lessonTimeView.class_end}" type="date"/>
                                        </td>
                                        <td>1.观课准备会会议纪要</td>
                                        <td>
                                            <c:forEach items="${lessonUserTaskList }" var="lessonUser">
                                                <c:if test="${lessonUser.purview ==301}">
                                                    <c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>(${lessonUser.user_name })&nbsp;&nbsp;
                                                    <input name="user_id301" value="${lessonUser.user_id }" type="hidden" data-name="save301">
                                                    <input name="mark" value="301" type="hidden" data-name="mark">
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td ><span class="text-danger">*</span>2.观课量表</td>
                                        <td >
                                            <c:forEach items="${lessonUserTaskList }" var="lessonUser">
                                                <c:if test="${lessonUser.purview ==302}">
                                                    <c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>(${lessonUser.user_name })&nbsp;&nbsp;
                                                    <input name="user_id302" value="${lessonUser.user_id }" type="hidden" data-name="save302">
                                                    <input name="mark" value="302" type="hidden" data-name="mark">
                                                </c:if>
                                            </c:forEach>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td >3.观课:问题研讨</td>
                                        <td>
                                            <c:forEach items="${lessonUserTaskList }" var="lessonUser">
                                                <c:if test="${lessonUser.purview ==303}">
                                                    <c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>(${lessonUser.user_name })&nbsp;&nbsp;
                                                    <input name="user_id303" value="${lessonUser.user_id }" type="hidden" data-name="save303">
                                                    <input name="mark" value="303" type="hidden" data-name="mark">
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td ><span class="text-danger">*</span>4.提交上课实录</td>
                                        <td>
                                            <c:forEach items="${lessonUserTaskList }" var="lessonUser">
                                                <c:if test="${lessonUser.purview ==304}">
                                                    <c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>(${lessonUser.user_name })&nbsp;&nbsp;
                                                    <input name="user_id304" value="${lessonUser.user_id }" type="hidden" data-name="save304">
                                                    <input name="mark" value="304" type="hidden" data-name="mark">

                                                </c:if>
                                            </c:forEach>
                                        </td>
                                    </tr>

                                    <!--评课环节-->
                                    <tr>
                                        <td rowspan="3"  class="active" style="vertical-align: middle;text-align: center;">评课环节<br/>
                                            <fmt:formatDate value="${lessonTimeView.assessment_sta}" type="date"/>至
                                            <fmt:formatDate value="${lessonTimeView.assessment_end}" type="date"/>
                                        </td>
                                        <td ><span class="text-danger">*</span>1.观课报告</td>
                                        <td >
                                            <c:forEach items="${lessonUserTaskList }" var="lessonUser">
                                                <c:if test="${lessonUser.purview ==401}">
                                                    <c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>(${lessonUser.user_name })&nbsp;&nbsp;
                                                    <input name="user_id401" value="${lessonUser.user_id }" type="hidden" data-name="save401">
                                                    <input name="mark" value="401" type="hidden" data-name="mark">
                                                </c:if>
                                            </c:forEach>
                                        </td>

                                    </tr>

                                    <tr>
                                        <td >2.课后评议会议纪要</td>
                                        <td>
                                            <c:forEach items="${lessonUserTaskList }" var="lessonUser">
                                                <c:if test="${lessonUser.purview ==402}">
                                                    <c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>(${lessonUser.user_name })&nbsp;&nbsp;
                                                    <input name="user_id402" value="${lessonUser.user_id }" type="hidden" data-name="save402">
                                                    <input name="mark" value="402" type="hidden" data-name="mark">
                                                </c:if>
                                            </c:forEach>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td>3.评课:问题研讨</td>
                                        <td>
                                            <c:forEach items="${lessonUserTaskList }" var="lessonUser">
                                                <c:if test="${lessonUser.purview ==403}">
                                                    <c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>(${lessonUser.user_name })&nbsp;&nbsp;
                                                    <input name="user_id403" value="${lessonUser.user_id }" type="hidden" data-name="save403">
                                                    <input name="mark" value="403" type="hidden" data-name="mark">
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                    </tr>

                                    <!--反思环节-->
                                    <tr>
                                        <td rowspan="3"  class="active" style="vertical-align: middle;text-align: center;">反思环节<br/>
                                            <fmt:formatDate value="${lessonTimeView.introspection_sta}" type="date"/>至
                                            <fmt:formatDate value="${lessonTimeView.introspection_end}" type="date"/>
                                        </td>
                                        <td >1.反思心得</td>
                                        <td>
                                            <c:forEach items="${lessonUserTaskList }" var="lessonUser">
                                                <c:if test="${lessonUser.purview ==501}">
                                                    <c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>(${lessonUser.user_name })&nbsp;&nbsp;
                                                    <input name="user_id501" value="${lessonUser.user_id }" type="hidden" data-name="save501">
                                                    <input name="mark" value="501" type="hidden" data-name="mark">

                                                </c:if>
                                            </c:forEach>
                                        </td>

                                    </tr>

                                    <tr>
                                        <td ><span class="text-danger">*</span>2.提交实践反思后教学设计及课件</td>
                                        <td>
                                            <c:forEach items="${lessonUserTaskList }" var="lessonUser">
                                                <c:if test="${lessonUser.purview ==502}">
                                                    <c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>(${lessonUser.user_name })&nbsp;&nbsp;
                                                    <input name="user_id502" value="${lessonUser.user_id }" type="hidden" data-name="save502">
                                                    <input name="mark" value="502" type="hidden" data-name="mark">

                                                </c:if>
                                            </c:forEach>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td ><span class="text-danger">*</span>3.自我总结</td>
                                        <td>
                                            <c:forEach items="${lessonUserTaskList }" var="lessonUser">
                                                <c:if test="${lessonUser.purview ==503}">
                                                    <c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if>(${lessonUser.user_name })&nbsp;&nbsp;
                                                    <input name="user_id503" value="${lessonUser.user_id }" type="hidden" data-name="save503">
                                                    <input name="mark" value="503" type="hidden" data-name="mark">
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                    </tr>

                                    </tbody>
                                </table>

                            </form>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>

    </div>

    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
</div>


<script type="text/javascript">

    function delStage(){
        $("#nullStage").remove();
    }
    function _stage(value){
        alert(value);
        $("#subject").find("option").remove();
        $("#edition").find("option").remove();
        $("#position").find("option").remove();
        $("#titles").find("option").remove();
        //$("#grade").find("option").remove();
        $.ajax({
            url : "${pageContext.request.contextPath}/subject/query_subject.action?subId="+value,
            dataType:'json',
            success : function(json) {
                var a = JSON.stringify(json);
                var o = eval( "(" + a + ")" );
                var sub = o[0].subjectList;
                var edi = o[0].editionList;
                var gra = o[0].gradeList;
                for(var i in sub){
                    $("#subject").append('<option   value='+sub[i].id+' >'+sub[i].subjectName+'</option>');
                }


                for(var i in edi){
                    $("#edition").append('<option  value='+edi[i].id+' >'+edi[i].versionName+'</option>');
                }

                /* for(var i in gra){
                 $("#grade").append('<option value='+gra[i].bookCatelogId+' >'+gra[i].bookCatelogName+'</option>');
                 }
                 $("#gradeId").val(gra[0].bookCatelogId); */
            }
        });
        $.ajax({
            url : "${pageContext.request.contextPath}/certification/query_titles.action?subId="+value,
            dataType:'json',
            success : function(json) {

                var position=json.position;
                var titles=json.titles;
                $("#position").append('<option   value=-1 >无</option>');
                $("#titles").append('<option   value=-1 >无</option>');
                for(var i in position){
                    $("#position").append('<option   value='+position[i].id+' >'+position[i].classify_name+'</option>');
                }


                for(var i in titles){
                    $("#titles").append('<option  value='+titles[i].id+' >'+titles[i].classify_name+'</option>');
                }



            }
        });
    }
    function _subject(value){

        $("#edition").find("option").remove();
        $.ajax({
            url : "${pageContext.request.contextPath}/pubver/query_pubver.action?pubId="+value,
            dataType:'json',
            success : function(json){
                var a = JSON.stringify(json);
                var o = eval( "(" + a + ")" );
                var edi = o[0].editionList;
                var gra = o[0].gradeList;
                for(var i in edi){
                    $("#edition").append('<option  value='+edi[i].id+' >'+edi[i].versionName+'</option>');
                }
                $("#editionId").val(edi[0].id);

            }
        });
    }

    function _grade(){


        if($("#grade").val()==null||$("#grade").val()=="-1"){
            $("#nullGrade").remove();
            $.ajax({
                url : "${pageContext.request.contextPath}/my_setting/selectGrade.action",
                dataType:'json',
                success : function(json){
                    var a = JSON.stringify(json);
                    var o = eval( "(" + a + ")" );
                    for(var i in o){
                        $("#grade").append('<option  value='+o[i].id+' >'+o[i].grade_name+'</option>');
                    }
                }
            });
        }


    }

</script>

