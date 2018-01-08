<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script>

		$(function(){
            var stamp = 0;
            stamp = $("#stamp").val();
            if(stamp==1){
                $(".my-task").show();
                $(".all-task").hide();
                $("#my-task").addClass("task2");
                $("#all-task").removeClass("task1");
                $(".my-task").show();
                $(".all-task").hide();
            }else{
                $(".all-task").show();
                $(".my-task").hide();
                $("#all-task").addClass("task1");
                $("#my-task").removeClass("task2");
                $(".all-task").show();
                $(".my-task").hide();
            }
             $("li.task-list").click(function () {
            $(".all-task>li").not(".task-list").hide();
            $(".my-task>li").not(".task-list").hide();
            $(this).nextUntil("li.task-list").css("display","block");
        });
           //my_plan_lesson
            //my_prepare_lesson
           // my_having_lesson
            //my_evaluation_lesson
           // my_rethink
           $(".all-task>li").not(".task-list").hide();
            $(".my-task>li").not(".task-list").hide();
           var state='${state}';
         
           if(state.indexOf("10")!=-1){
          $(".plan_lesson").show();
           }
            if(state.indexOf("20")!=-1){
          $(".prepare_lesson").show();
           }
             if(state.indexOf("30")!=-1){
          $(".having_lesson").show();
           }
             if(state.indexOf("40")!=-1){
          $(".evaluation_lesson").show();
           }
             if(state.indexOf("50")!=-1){
          $(".rethink").show();
           }
        });


       


 


</script>

<input type="hidden" name="stamp" id="stamp" value="${stamp}"/>
<input type="hidden" name="state" id="state" value="${state}"/>

<div class="col-lg-3 col-md-4  course-sidebar">

    <div class="sidenav locked">

        <div class="controls" style="margin: 10px;">
            <div class="task_pic">
                <div><img src="${pageContext.request.contextPath}/frontstage/images/pending_completion.png" alt="待完成"> 待完成</div>
                <div><img src="${pageContext.request.contextPath}/frontstage/images/already_completed.png" alt="已完成"> 已完成</div>
                <div><img src="${pageContext.request.contextPath}/frontstage/images/to_be_assigned.png" alt="待分配"> 待分配</div>
            </div>

            <div style="padding-top: 35px;">

                <div id="all-task" >全部任务</div>

                <c:if test="${lessonLeft.userInLesson ==1}">

                    <div  id="my-task">我的任务</div>
                </c:if>
            </div>

        </div>

        <!--全部任务-->
        <ul class="list-group all-task task" >

            <!--环节一-->
            <li class="list-group-item task-list"><a href="javascript:void(0);" id="plan_lesson"><span ></span>计划</a></li>

            <li class="list-group-item plan_lesson <c:if test="${state==101&&stamp==0}">active</c:if>">
                <a href="${pageContext.request.contextPath}/lesson/to_lesson_plan.action?lesson_id=${lesson.id}&show=1&stamp=0&state=101">
                    <span class="text-danger">*</span>任务1:制定计划
                    <c:if test="${lessonLeft.plan101==0}">
                        <img class="pending_completion" src="${pageContext.request.contextPath}/frontstage/images/pending_completion.png">
                    </c:if>
                    <c:if test="${lessonLeft.plan101==1}">
                        <img class="already_completed" src="${pageContext.request.contextPath}/frontstage/images/already_completed.png">
                    </c:if>
                    <c:if test="${lessonLeft.plan101==2}">
                        <img class="to_be_assigned" src="${pageContext.request.contextPath}/frontstage/images/to_be_assigned.png">
                    </c:if>
                </a>
            </li>

            <li class="list-group-item plan_lesson <c:if test="${state==102&&stamp==0}">active</c:if>">
                <a href="${pageContext.request.contextPath}/lesson_design/to_lesson_design.action?lesson_id=${lesson.id}&tab=0&stamp=0&state=102">
                    <span class="text-danger">*</span>任务2:提交教学设计与课件
                    <c:if test="${lessonLeft.plan102==0}">
                        <img class="pending_completion" src="${pageContext.request.contextPath}/frontstage/images/pending_completion.png">
                    </c:if>
                    <c:if test="${lessonLeft.plan102==1}">
                        <img class="already_completed" src="${pageContext.request.contextPath}/frontstage/images/already_completed.png">
                    </c:if>
                    <c:if test="${lessonLeft.plan102==2}">
                        <img class="to_be_assigned" src="${pageContext.request.contextPath}/frontstage/images/to_be_assigned.png">
                    </c:if>
                </a>
            </li>

            <li class="list-group-item plan_lesson <c:if test="${state==103&&stamp==0}">active</c:if>">
                <a href="${pageContext.request.contextPath}/problem_study/to_problem.action?lesson_id=${lesson.id}&purview=103&stamp=0&state=103">
                    <span></span>任务3:问题研讨
                    <c:if test="${lessonLeft.plan103==0}">
                        <img class="pending_completion" src="${pageContext.request.contextPath}/frontstage/images/pending_completion.png">
                    </c:if>
                    <c:if test="${lessonLeft.plan103==1}">
                        <img class="already_completed" src="${pageContext.request.contextPath}/frontstage/images/already_completed.png">
                    </c:if>
                    <c:if test="${lessonLeft.plan103==2}">
                        <img class="to_be_assigned" src="${pageContext.request.contextPath}/frontstage/images/to_be_assigned.png">
                    </c:if>
                </a>
            </li>



            <!--环节二-->
            <li class="list-group-item task-list " ><a href="javascript:void(0); " id="prepare_lesson"><span ></span>备课</a></li>

            <li class="list-group-item prepare_lesson <c:if test="${state==201&&stamp==0}">active</c:if>">
                <a href="${pageContext.request.contextPath}/lesson_design/to_lesson_design.action?lesson_id=${lesson.id}&tab=1&stamp=0&state=201">
                    <span class="text-danger">*</span>任务1:初始教学设计协同修改
                    <c:if test="${lessonLeft.prepare201==0}">
                        <img class="pending_completion" src="${pageContext.request.contextPath}/frontstage/images/pending_completion.png">
                    </c:if>
                    <c:if test="${lessonLeft.prepare201==1}">
                        <img class="already_completed" src="${pageContext.request.contextPath}/frontstage/images/already_completed.png">
                    </c:if>
                    <c:if test="${lessonLeft.prepare201==2}">
                        <img class="to_be_assigned" src="${pageContext.request.contextPath}/frontstage/images/to_be_assigned.png">
                    </c:if>
                </a>
            </li>
            <li class="list-group-item prepare_lesson <c:if test="${state==202&&stamp==0}">active</c:if>">
                <a href="${pageContext.request.contextPath}/lesson_attachment/to_lesson_attachment.action?lesson_id=${lesson.id}&purview=202&stamp=0&state=202">
                    <span ></span>任务2:备课研讨会会议纪要
                    <c:if test="${lessonLeft.prepare202==0}">
                        <img class="pending_completion" src="${pageContext.request.contextPath}/frontstage/images/pending_completion.png">
                    </c:if>
                    <c:if test="${lessonLeft.prepare202==1}">
                        <img class="already_completed" src="${pageContext.request.contextPath}/frontstage/images/already_completed.png">
                    </c:if>
                    <c:if test="${lessonLeft.prepare202==2}">
                        <img class="to_be_assigned" src="${pageContext.request.contextPath}/frontstage/images/to_be_assigned.png">
                    </c:if>
                </a>
            </li>

            <li class="list-group-item prepare_lesson <c:if test="${state==203&&stamp==0}">active</c:if>">
                <a href="${pageContext.request.contextPath}/problem_study/to_problem.action?lesson_id=${lesson.id}&purview=203&stamp=0&state=203">
                    <span ></span>任务3:问题研讨
                    <c:if test="${lessonLeft.prepare203==0}">
                        <img class="pending_completion" src="${pageContext.request.contextPath}/frontstage/images/pending_completion.png">
                    </c:if>
                    <c:if test="${lessonLeft.prepare203==1}">
                        <img class="already_completed" src="${pageContext.request.contextPath}/frontstage/images/already_completed.png">
                    </c:if>
                    <c:if test="${lessonLeft.prepare203==2}">
                        <img class="to_be_assigned" src="${pageContext.request.contextPath}/frontstage/images/to_be_assigned.png">
                    </c:if>
                </a>
            </li>
            <li class="list-group-item prepare_lesson <c:if test="${state==204&&stamp==0}">active</c:if>">
                <a href="${pageContext.request.contextPath}/lesson_design/to_lesson_design.action?lesson_id=${lesson.id}&tab=3&stamp=0&state=204">
                    <span class="text-danger">*</span>任务4:提交修改后的教学设计
                    <c:if test="${lessonLeft.prepare204==0}">
                        <img class="pending_completion" src="${pageContext.request.contextPath}/frontstage/images/pending_completion.png">
                    </c:if>
                    <c:if test="${lessonLeft.prepare204==1}">
                        <img class="already_completed" src="${pageContext.request.contextPath}/frontstage/images/already_completed.png">
                    </c:if>
                    <c:if test="${lessonLeft.prepare204==2}">
                        <img class="to_be_assigned" src="${pageContext.request.contextPath}/frontstage/images/to_be_assigned.png">
                    </c:if>
                </a>
            </li>



            <!--环节三-->
            <li class="list-group-item task-list"><a href="javascript:void(0);" id="having_lesson"><span ></span>上课</a></li>
            <li class="list-group-item having_lesson <c:if test="${state==301&&stamp==0}">active</c:if>">
                <a href="${pageContext.request.contextPath}/lesson_attachment/to_lesson_attachment.action?lesson_id=${lesson.id}&purview=301&stamp=0&state=301">
                    <span></span>任务1:观课准备会会议纪要
                    <c:if test="${lessonLeft.class301==0}">
                        <img class="pending_completion" src="${pageContext.request.contextPath}/frontstage/images/pending_completion.png">
                    </c:if>
                    <c:if test="${lessonLeft.class301==1}">
                        <img class="already_completed" src="${pageContext.request.contextPath}/frontstage/images/already_completed.png">
                    </c:if>
                    <c:if test="${lessonLeft.class301==2}">
                        <img class="to_be_assigned" src="${pageContext.request.contextPath}/frontstage/images/to_be_assigned.png">
                    </c:if>
                </a>
            </li>
            <li class="list-group-item having_lesson <c:if test="${state==302&&stamp==0}">active</c:if>">
                <a href="${pageContext.request.contextPath}/lesson_attachment/to_lesson_attachment.action?lesson_id=${lesson.id}&purview=302&stamp=0&state=302">
                    <span class="text-danger">*</span>任务2:观课量表
                    <c:if test="${lessonLeft.class302==0}">
                        <img class="pending_completion" src="${pageContext.request.contextPath}/frontstage/images/pending_completion.png">
                    </c:if>
                    <c:if test="${lessonLeft.class302==1}">
                        <img class="already_completed" src="${pageContext.request.contextPath}/frontstage/images/already_completed.png">
                    </c:if>
                    <c:if test="${lessonLeft.class302==2}">
                        <img class="to_be_assigned" src="${pageContext.request.contextPath}/frontstage/images/to_be_assigned.png">
                    </c:if>
                </a>
            </li>
            <li class="list-group-item having_lesson <c:if test="${state==303&&stamp==0}">active</c:if>">
                <a href="${pageContext.request.contextPath}/problem_study/to_problem.action?lesson_id=${lesson.id}&purview=303&stamp=0&state=303">
                    <span  ></span>任务3:问题研讨
                    <c:if test="${lessonLeft.class303==0}">
                        <img class="pending_completion" src="${pageContext.request.contextPath}/frontstage/images/pending_completion.png">
                    </c:if>
                    <c:if test="${lessonLeft.class303==1}">
                        <img class="already_completed" src="${pageContext.request.contextPath}/frontstage/images/already_completed.png">
                    </c:if>
                    <c:if test="${lessonLeft.class303==2}">
                        <img class="to_be_assigned" src="${pageContext.request.contextPath}/frontstage/images/to_be_assigned.png">
                    </c:if>
                </a>
            </li>
            <li class="list-group-item having_lesson <c:if test="${state==304&&stamp==0}">active</c:if>">
                <a href="${pageContext.request.contextPath}/lesson_attachment/to_lesson_attachment.action?lesson_id=${lesson.id}&purview=304&stamp=0&state=304">
                    <span class="text-danger">*</span>任务4:提交上课实录
                    <c:if test="${lessonLeft.class304==0}">
                        <img class="pending_completion" src="${pageContext.request.contextPath}/frontstage/images/pending_completion.png">
                    </c:if>
                    <c:if test="${lessonLeft.class304==1}">
                        <img class="already_completed" src="${pageContext.request.contextPath}/frontstage/images/already_completed.png">
                    </c:if>
                    <c:if test="${lessonLeft.class304==2}">
                        <img class="to_be_assigned" src="${pageContext.request.contextPath}/frontstage/images/to_be_assigned.png">
                    </c:if>
                </a>
            </li>


            <!--环节四-->
            <li class="list-group-item task-list "><a href="javascript:void(0);" id="evaluation_lesson"><span ></span>评课</a></li>

            <li class="list-group-item evaluation_lesson <c:if test="${state==401&&stamp==0}">active</c:if>">
                <a href="${pageContext.request.contextPath}/lesson_attachment/to_lesson_attachment.action?lesson_id=${lesson.id}&purview=401&stamp=0&state=401">
                    <span class="text-danger">*</span>任务1:观课报告
                    <c:if test="${lessonLeft.assessment401==0}">
                        <img class="pending_completion" src="${pageContext.request.contextPath}/frontstage/images/pending_completion.png">
                    </c:if>
                    <c:if test="${lessonLeft.assessment401==1}">
                        <img class="already_completed" src="${pageContext.request.contextPath}/frontstage/images/already_completed.png">
                    </c:if>
                    <c:if test="${lessonLeft.assessment401==2}">
                        <img class="to_be_assigned" src="${pageContext.request.contextPath}/frontstage/images/to_be_assigned.png">
                    </c:if>
                </a>
            </li>
            <li class="list-group-item evaluation_lesson <c:if test="${state==402&&stamp==0}">active</c:if>">
                <a href="${pageContext.request.contextPath}/lesson_attachment/to_lesson_attachment.action?lesson_id=${lesson.id}&purview=402&stamp=0&state=402">
                    <span ></span>任务2:课后评议会议纪要
                    <c:if test="${lessonLeft.assessment402==0}">
                        <img class="pending_completion" src="${pageContext.request.contextPath}/frontstage/images/pending_completion.png">
                    </c:if>
                    <c:if test="${lessonLeft.assessment402==1}">
                        <img class="already_completed" src="${pageContext.request.contextPath}/frontstage/images/already_completed.png">
                    </c:if>
                    <c:if test="${lessonLeft.assessment402==2}">
                        <img class="to_be_assigned" src="${pageContext.request.contextPath}/frontstage/images/to_be_assigned.png">
                    </c:if>
                </a>
            </li>
            <li class="list-group-item evaluation_lesson <c:if test="${state==403&&stamp==0}">active</c:if>">
                <a href="${pageContext.request.contextPath}/problem_study/to_problem.action?lesson_id=${lesson.id}&purview=403&stamp=0&state=403">
                    <span  ></span>任务3:问题研讨
                    <c:if test="${lessonLeft.assessment403==0}">
                        <img class="pending_completion" src="${pageContext.request.contextPath}/frontstage/images/pending_completion.png">
                    </c:if>
                    <c:if test="${lessonLeft.assessment403==1}">
                        <img class="already_completed" src="${pageContext.request.contextPath}/frontstage/images/already_completed.png">
                    </c:if>
                    <c:if test="${lessonLeft.assessment403==2}">
                        <img class="to_be_assigned" src="${pageContext.request.contextPath}/frontstage/images/to_be_assigned.png">
                    </c:if>
                </a>
            </li>


            <!--环节五-->
            <li class="list-group-item task-list" ><a href="javascript:void(0);" id="rethink"><span></span>反思</a></li>
            <li class="list-group-item rethink <c:if test="${state==501&&stamp==0}">active</c:if>">
                <a href="${pageContext.request.contextPath}/lesson_attachment/to_lesson_attachment.action?lesson_id=${lesson.id}&purview=501&stamp=0&state=501">
                    <span ></span>任务1:反思心得
                    <c:if test="${lessonLeft.introspection501==0}">
                        <img class="pending_completion" src="${pageContext.request.contextPath}/frontstage/images/pending_completion.png">
                    </c:if>
                    <c:if test="${lessonLeft.introspection501==1}">
                        <img class="already_completed" src="${pageContext.request.contextPath}/frontstage/images/already_completed.png">
                    </c:if>
                    <c:if test="${lessonLeft.introspection501==2}">
                        <img class="to_be_assigned" src="${pageContext.request.contextPath}/frontstage/images/to_be_assigned.png">
                    </c:if>
                </a>
            </li>
            <li class="list-group-item rethink <c:if test="${state==502&&stamp==0}">active</c:if>">
                <a href="${pageContext.request.contextPath}/lesson_design/to_lesson_design.action?lesson_id=${lesson.id}&tab=4&stamp=0&state=502">
                    <span class="text-danger">*</span>任务2:提交反思后教学设计
                    <c:if test="${lessonLeft.introspection502==0}">
                        <img class="pending_completion" src="${pageContext.request.contextPath}/frontstage/images/pending_completion.png">
                    </c:if>
                    <c:if test="${lessonLeft.introspection502==1}">
                        <img class="already_completed" src="${pageContext.request.contextPath}/frontstage/images/already_completed.png">
                    </c:if>
                    <c:if test="${lessonLeft.introspection502==2}">
                        <img class="to_be_assigned" src="${pageContext.request.contextPath}/frontstage/images/to_be_assigned.png">
                    </c:if>
                </a>
            </li>
            <li class="list-group-item rethink <c:if test="${state==503&&stamp==0}">active</c:if>">
                <a href="${pageContext.request.contextPath}/lesson/to_lesson_self.action?lesson_id=${lesson.id}&show=1&stamp=0&state=503">
                    <span class="text-danger">*</span>任务3:小组总结
                    <c:if test="${lessonLeft.introspection503==0}">
                        <img class="pending_completion" src="${pageContext.request.contextPath}/frontstage/images/pending_completion.png">
                    </c:if>
                    <c:if test="${lessonLeft.introspection503==1}">
                        <img class="already_completed" src="${pageContext.request.contextPath}/frontstage/images/already_completed.png">
                    </c:if>
                    <c:if test="${lessonLeft.introspection503==2}">
                        <img class="to_be_assigned" src="${pageContext.request.contextPath}/frontstage/images/to_be_assigned.png">
                    </c:if>
                </a>
            </li>



        </ul>

        <!--我的任务-->
        <ul class="list-group my-task " style="display: none;">

            <!--环节一-->
            <c:if test="${lessonLeft.userPlan==1 }">
                <li class="list-group-item task-list">
                    <a href="javascript:void(0);" id="my_plan_lesson">
                        <span ></span>计划
                    </a>
                </li>

                <c:forEach items="${lessonLeft.lessonUserList }" var="lessonUser">
                    <c:if test="${lessonUser.identity ==0}">
                        <c:if test="${lessonUser.user_id ==lessonLeft.user.id}">
                            <li class="list-group-item plan_lesson <c:if test="${state==101&&stamp==1}">active</c:if>">
                                <a href="${pageContext.request.contextPath}/lesson/to_lesson_plan.action?lesson_id=${lesson.id}&stamp=1&state=101">
                                    <span class="text-danger">*</span>任务1:制定计划
                                    <c:if test="${lesson.status == 0}">
                                        <img class="pending_completion" src="${pageContext.request.contextPath}/frontstage/images/pending_completion.png">
                                    </c:if>
                                    <c:if test="${lesson.status != 0}">
                                        <img class="already_completed" src="${pageContext.request.contextPath}/frontstage/images/already_completed.png">
                                    </c:if>
                                </a>
                            </li>
                        </c:if>
                    </c:if>
                </c:forEach>
                <!--
                <c:forEach items="${lessonLeft.lessonUserPurviewList }" var="UserPurview">
                    <c:if test="${UserPurview.purview ==101}">
                        <li class="list-group-item plan_lesson <c:if test="${state==101&&stamp==1}">active</c:if>">
                        <a href="${pageContext.request.contextPath}/lesson/to_lesson_plan.action?lesson_id=${lesson.id}&stamp=1&state=101">
                        <span class="text-danger">*</span>任务1:制定计划
                        </a>
                        </li>
                    </c:if>
                </c:forEach>
                -->
                <c:forEach items="${lessonLeft.lessonUserPurviewList }" var="UserPurview">
                    <c:if test="${UserPurview.purview ==102}">
                        <li class="list-group-item plan_lesson <c:if test="${state==102&&stamp==1}">active</c:if>">
                            <a href="${pageContext.request.contextPath}/lesson_design/to_lesson_design.action?lesson_id=${lesson.id}&tab=0&stamp=1&state=102">
                                <span class="text-danger">*</span>任务2:提交教学设计与课件
                                <c:if test="${UserPurview.status ==0}">
                                    <img class="pending_completion" src="${pageContext.request.contextPath}/frontstage/images/pending_completion.png">
                                </c:if>
                                <c:if test="${UserPurview.status ==2}">
                                    <img class="already_completed" src="${pageContext.request.contextPath}/frontstage/images/already_completed.png">
                                </c:if>
                            </a>

                        </li>
                    </c:if>
                </c:forEach>
                <c:forEach items="${lessonLeft.lessonUserPurviewList }" var="UserPurview">
                    <c:if test="${UserPurview.purview ==103}">
                        <li class="list-group-item plan_lesson <c:if test="${state==103&&stamp==1}">active</c:if>">
                            <a href="${pageContext.request.contextPath}/problem_study/to_problem.action?lesson_id=${lesson.id}&purview=103&stamp=1&state=103">
                                <span></span>任务3:问题研讨
                                <c:if test="${UserPurview.status ==0}">
                                    <img class="pending_completion" src="${pageContext.request.contextPath}/frontstage/images/pending_completion.png">
                                </c:if>
                                <c:if test="${UserPurview.status ==2}">
                                    <img class="already_completed" src="${pageContext.request.contextPath}/frontstage/images/already_completed.png">
                                </c:if>
                            </a>
                        </li>
                    </c:if>
                </c:forEach>

            </c:if>

            <!--环节二-->
            <c:if test="${lessonLeft.userPrepare==1 }">
                <li class="list-group-item task-list" >
                    <a href="javascript:void(0);" id="my_prepare_lesson">
                        <span ></span>备课
                    </a>
                </li>

                <c:forEach items="${lessonLeft.lessonUserPurviewList }" var="UserPurview">
                    <c:if test="${UserPurview.purview ==201}">
                        <li class="list-group-item prepare_lesson <c:if test="${state==201&&stamp==1}">active</c:if>">
                            <a href="${pageContext.request.contextPath}/lesson_design/to_lesson_design.action?lesson_id=${lesson.id}&tab=1&stamp=1&state=201">
                                <span class="text-danger">*</span>任务1:初始教学设计协同修改
                                <c:if test="${UserPurview.status ==0}">
                                    <img class="pending_completion" src="${pageContext.request.contextPath}/frontstage/images/pending_completion.png">
                                </c:if>
                                <c:if test="${UserPurview.status ==2}">
                                    <img class="already_completed" src="${pageContext.request.contextPath}/frontstage/images/already_completed.png">
                                </c:if>
                            </a>
                        </li>
                    </c:if>
                </c:forEach>

                <c:forEach items="${lessonLeft.lessonUserPurviewList }" var="UserPurview">
                    <c:if test="${UserPurview.purview ==202}">
                        <li class="list-group-item prepare_lesson <c:if test="${state==202&&stamp==1}">active</c:if>">
                            <a href="${pageContext.request.contextPath}/lesson_attachment/to_lesson_attachment.action?lesson_id=${lesson.id}&purview=202&stamp=1&state=202">
                                <span ></span>任务2:备课研讨会会议纪要
                                <c:if test="${UserPurview.status ==0}">
                                    <img class="pending_completion" src="${pageContext.request.contextPath}/frontstage/images/pending_completion.png">
                                </c:if>
                                <c:if test="${UserPurview.status ==2}">
                                    <img class="already_completed" src="${pageContext.request.contextPath}/frontstage/images/already_completed.png">
                                </c:if>
                            </a>
                        </li>
                    </c:if>
                </c:forEach>
                <c:forEach items="${lessonLeft.lessonUserPurviewList }" var="UserPurview">
                    <c:if test="${UserPurview.purview ==203}">
                        <li class="list-group-item prepare_lesson <c:if test="${state==203&&stamp==1}">active</c:if>">
                            <a href="${pageContext.request.contextPath}/problem_study/to_problem.action?lesson_id=${lesson.id}&purview=203&stamp=1&state=203">
                                <span ></span>任务3:问题研讨
                                <c:if test="${UserPurview.status ==0}">
                                    <img class="pending_completion" src="${pageContext.request.contextPath}/frontstage/images/pending_completion.png">
                                </c:if>
                                <c:if test="${UserPurview.status ==2}">
                                    <img class="already_completed" src="${pageContext.request.contextPath}/frontstage/images/already_completed.png">
                                </c:if>
                            </a>
                        </li>
                    </c:if>
                </c:forEach>
                <c:forEach items="${lessonLeft.lessonUserPurviewList }" var="UserPurview">
                    <c:if test="${UserPurview.purview ==204}">
                        <li class="list-group-item prepare_lesson <c:if test="${state==204&&stamp==1}">active</c:if>">
                            <a href="${pageContext.request.contextPath}/lesson_design/to_lesson_design.action?lesson_id=${lesson.id}&tab=3&stamp=1&state=204">
                                <span class="text-danger">*</span>任务4:提交修改后的教学设计
                                <c:if test="${UserPurview.status ==0}">
                                    <img class="pending_completion" src="${pageContext.request.contextPath}/frontstage/images/pending_completion.png">
                                </c:if>
                                <c:if test="${UserPurview.status ==2}">
                                    <img class="already_completed" src="${pageContext.request.contextPath}/frontstage/images/already_completed.png">
                                </c:if>
                            </a>
                        </li>
                    </c:if>
                </c:forEach>

            </c:if>

            <!--环节三-->
            <c:if test="${lessonLeft.userClass==1 }">
                <li class="list-group-item task-list">
                    <a href="javascript:void(0);" id="my_having_lesson">
                        <span ></span>上课
                    </a></li>


                <c:forEach items="${lessonLeft.lessonUserPurviewList }" var="UserPurview">
                    <c:if test="${UserPurview.purview ==301}">
                        <li class="list-group-item having_lesson <c:if test="${state==301&&stamp==1}">active</c:if>">
                            <a href="${pageContext.request.contextPath}/lesson_attachment/to_lesson_attachment.action?lesson_id=${lesson.id}&purview=301&stamp=1&state=301">
                                <span></span>任务1:观课准备会会议纪要
                                <c:if test="${UserPurview.status ==0}">
                                    <img class="pending_completion" src="${pageContext.request.contextPath}/frontstage/images/pending_completion.png">
                                </c:if>
                                <c:if test="${UserPurview.status ==2}">
                                    <img class="already_completed" src="${pageContext.request.contextPath}/frontstage/images/already_completed.png">
                                </c:if>
                            </a>
                        </li>
                    </c:if>
                </c:forEach>
                <c:forEach items="${lessonLeft.lessonUserPurviewList }" var="UserPurview">
                    <c:if test="${UserPurview.purview ==302}">
                        <li class="list-group-item having_lesson <c:if test="${state==302&&stamp==1}">active</c:if>">
                            <a href="${pageContext.request.contextPath}/lesson_attachment/to_lesson_attachment.action?lesson_id=${lesson.id}&purview=302&stamp=1&state=302">
                                <span class="text-danger">*</span>任务2:观课量表
                                <c:if test="${UserPurview.status ==0}">
                                    <img class="pending_completion" src="${pageContext.request.contextPath}/frontstage/images/pending_completion.png">
                                </c:if>
                                <c:if test="${UserPurview.status ==2}">
                                    <img class="already_completed" src="${pageContext.request.contextPath}/frontstage/images/already_completed.png">
                                </c:if>
                            </a>
                        </li>
                    </c:if>
                </c:forEach>
                <c:forEach items="${lessonLeft.lessonUserPurviewList }" var="UserPurview">
                    <c:if test="${UserPurview.purview ==303}">
                        <li class="list-group-item having_lesson <c:if test="${state==303&&stamp==1}">active</c:if>">
                            <a href="${pageContext.request.contextPath}/problem_study/to_problem.action?lesson_id=${lesson.id}&purview=303&stamp=1&state=303">
                                <span  ></span>任务3:问题研讨
                                <c:if test="${UserPurview.status ==0}">
                                    <img class="pending_completion" src="${pageContext.request.contextPath}/frontstage/images/pending_completion.png">
                                </c:if>
                                <c:if test="${UserPurview.status ==2}">
                                    <img class="already_completed" src="${pageContext.request.contextPath}/frontstage/images/already_completed.png">
                                </c:if>
                            </a>
                        </li>
                    </c:if>
                </c:forEach>
                <c:forEach items="${lessonLeft.lessonUserPurviewList }" var="UserPurview">
                    <c:if test="${UserPurview.purview ==304}">
                        <li class="list-group-item having_lesson <c:if test="${state==304&&stamp==1}">active</c:if>">
                            <a href="${pageContext.request.contextPath}/lesson_attachment/to_lesson_attachment.action?lesson_id=${lesson.id}&purview=304&stamp=1&state=304">
                                <span class="text-danger">*</span>任务4:提交上课实录
                                <c:if test="${UserPurview.status ==0}">
                                    <img class="pending_completion" src="${pageContext.request.contextPath}/frontstage/images/pending_completion.png">
                                </c:if>
                                <c:if test="${UserPurview.status ==2}">
                                    <img class="already_completed" src="${pageContext.request.contextPath}/frontstage/images/already_completed.png">
                                </c:if>
                            </a>
                        </li>
                    </c:if>
                </c:forEach>

            </c:if>

            <!--环节四-->
            <c:if test="${lessonLeft.userAssessment==1 }">
                <li class="list-group-item task-list ">
                    <a href="javascript:void(0);" id="my_evaluation_lesson">
                        <span ></span>评课
                    </a>
                </li>


                <c:forEach items="${lessonLeft.lessonUserPurviewList }" var="UserPurview">
                    <c:if test="${UserPurview.purview ==401}">
                        <li class="list-group-item evaluation_lesson <c:if test="${state==401&&stamp==1}">active</c:if>">
                            <a href="${pageContext.request.contextPath}/lesson_attachment/to_lesson_attachment.action?lesson_id=${lesson.id}&purview=401&stamp=1&state=401">
                                <span class="text-danger">*</span>任务1:观课报告
                                <c:if test="${UserPurview.status ==0}">
                                    <img class="pending_completion" src="${pageContext.request.contextPath}/frontstage/images/pending_completion.png">
                                </c:if>
                                <c:if test="${UserPurview.status ==2}">
                                    <img class="already_completed" src="${pageContext.request.contextPath}/frontstage/images/already_completed.png">
                                </c:if>
                            </a>
                        </li>
                    </c:if>
                </c:forEach>
                <c:forEach items="${lessonLeft.lessonUserPurviewList }" var="UserPurview">
                    <c:if test="${UserPurview.purview ==402}">
                        <li class="list-group-item evaluation_lesson <c:if test="${state==402&&stamp==1}">active</c:if>">
                            <a href="${pageContext.request.contextPath}/lesson_attachment/to_lesson_attachment.action?lesson_id=${lesson.id}&purview=402&stamp=1&state=402">
                                <span ></span>任务2:课后评议会议纪要
                                <c:if test="${UserPurview.status ==0}">
                                    <img class="pending_completion" src="${pageContext.request.contextPath}/frontstage/images/pending_completion.png">
                                </c:if>
                                <c:if test="${UserPurview.status ==2}">
                                    <img class="already_completed" src="${pageContext.request.contextPath}/frontstage/images/already_completed.png">
                                </c:if>
                            </a>
                        </li>
                    </c:if>
                </c:forEach>
                <c:forEach items="${lessonLeft.lessonUserPurviewList }" var="UserPurview">
                    <c:if test="${UserPurview.purview ==403}">
                        <li class="list-group-item evaluation_lesson <c:if test="${state==403&&stamp==1}">active</c:if>">
                            <a href="${pageContext.request.contextPath}/problem_study/to_problem.action?lesson_id=${lesson.id}&purview=403&stamp=1&state=403">
                                <span  ></span>任务3:问题研讨
                                <c:if test="${UserPurview.status ==0}">
                                    <img class="pending_completion" src="${pageContext.request.contextPath}/frontstage/images/pending_completion.png">
                                </c:if>
                                <c:if test="${UserPurview.status ==2}">
                                    <img class="already_completed" src="${pageContext.request.contextPath}/frontstage/images/already_completed.png">
                                </c:if>
                            </a>
                        </li>
                    </c:if>
                </c:forEach>

            </c:if>

            <!--环节五-->
            <c:if test="${lessonLeft.userIntrospection==1 }">
                <li class="list-group-item task-list" >
                    <a href="javascript:void(0);" id="my_rethink">
                        <span></span>反思
                    </a>
                </li>
                <c:forEach items="${lessonLeft.lessonUserPurviewList }" var="UserPurview">
                    <c:if test="${UserPurview.purview ==501}">
                        <li class="list-group-item rethink <c:if test="${state==501&&stamp==1}">active</c:if>">
                            <a href="${pageContext.request.contextPath}/lesson_attachment/to_lesson_attachment.action?lesson_id=${lesson.id}&purview=501&stamp=1&state=501">
                                <span ></span>任务1:反思心得
                                <c:if test="${UserPurview.status ==0}">
                                    <img class="pending_completion" src="${pageContext.request.contextPath}/frontstage/images/pending_completion.png">
                                </c:if>
                                <c:if test="${UserPurview.status ==2}">
                                    <img class="already_completed" src="${pageContext.request.contextPath}/frontstage/images/already_completed.png">
                                </c:if>
                            </a>
                        </li>
                    </c:if>
                </c:forEach>
                <c:forEach items="${lessonLeft.lessonUserPurviewList }" var="UserPurview">
                    <c:if test="${UserPurview.purview ==502}">
                        <li class="list-group-item rethink <c:if test="${state==502&&stamp==1}">active</c:if>">
                            <a href="${pageContext.request.contextPath}/lesson_design/to_lesson_design.action?lesson_id=${lesson.id}&tab=4&stamp=1&state=502">
                                <span class="text-danger">*</span>任务2:提交教学设计
                                <c:if test="${UserPurview.status ==0}">
                                    <img class="pending_completion" src="${pageContext.request.contextPath}/frontstage/images/pending_completion.png">
                                </c:if>
                                <c:if test="${UserPurview.status ==2}">
                                    <img class="already_completed" src="${pageContext.request.contextPath}/frontstage/images/already_completed.png">
                                </c:if>
                            </a>
                        </li>
                    </c:if>
                </c:forEach>
                <c:forEach items="${lessonLeft.lessonUserPurviewList }" var="UserPurview">
                    <c:if test="${UserPurview.purview ==503}">
                        <li class="list-group-item rethink <c:if test="${state==503&&stamp==1}">active</c:if>">
                            <a href="${pageContext.request.contextPath}/lesson/to_lesson_self.action?lesson_id=${lesson.id}&purview=503&stamp=1&state=503">
                                <span class="text-danger">*</span>任务3:小组总结
                                <c:if test="${UserPurview.status ==0}">
                                    <img class="pending_completion" src="${pageContext.request.contextPath}/frontstage/images/pending_completion.png">
                                </c:if>
                                <c:if test="${UserPurview.status ==2}">
                                    <img class="already_completed" src="${pageContext.request.contextPath}/frontstage/images/already_completed.png">
                                </c:if>
                            </a>
                        </li>
                    </c:if>
                </c:forEach>



            </c:if>


        </ul>

        <ul class="list-group">
            <li class="list-group-heading">
                课例组情况
            </li>
            <li class="list-group-item <c:if test="${state==0}">active</c:if>">
                <a href="${pageContext.request.contextPath}/lesson/to_all_statistics.action?lesson_id=${lesson.id}&stamp=0&state=0">
                    <span  ></span>全组完成情况
                </a>
            </li>
            <li class="list-group-item <c:if test="${state==1}">active</c:if>">
                <a href="${pageContext.request.contextPath}/lesson/to_member_statistics.action?lesson_id=${lesson.id}&stamp=0&state=1">
                    <span  ></span>成员统计
                </a>
            </li>
            <%--<li class="list-group-item <c:if test="${state==2}">active</c:if>">--%>
            <%--<a href="${pageContext.request.contextPath}/lesson/to_lesson_evaluation.action?lesson_id=${lesson.id}&stamp=0&state=2">--%>
            <%--<span  ></span>课例评价--%>
            <%--</a>--%>
            <%--</li>--%>
            <li class="list-group-item <c:if test="${state==3}">active</c:if>">
                <c:if test="${lessonLeft.userIdentity==2}">
                    <a href="${pageContext.request.contextPath}/lesson/to_lesson_evaluation_manage.action?lesson_id=${lesson.id}&stamp=0&state=3">
                        <span  ></span>管理课例评价
                    </a>
                </c:if>
                <c:if test="${lessonLeft.userIdentity!=2}">
                    <a href="${pageContext.request.contextPath}/lesson/to_lesson_evaluation_manage.action?lesson_id=${lesson.id}&show=1&stamp=0&state=3">
                        <span  ></span>专家指导
                    </a>
                </c:if>
            </li>
            <li class="list-group-item <c:if test="${state==4}">active</c:if>">
                <a href="${pageContext.request.contextPath}/lesson/to_lesson_commentary.action?lesson_id=${lesson.id}&stamp=0&state=4">
                    <span  ></span>课例评论
                </a>
            </li>

        </ul>


    </div>


    <!--授课教师-->
    <div class="panel panel-default">


        <div class="panel-heading">
            <h3 class="panel-title">
                <i class="es-icon es-icon-personadd"></i>
                授课教师
            </h3>
        </div>
        <!--指导教师-->
 <div class="panel-body">
            <c:forEach items="${lessonLeft.lessonUserList }" var="lessonUser">
                <c:if test="${lessonUser.user_id==lesson.user_sk}">
                    <div class="media media-default">
                        <div class="media-left">
                            <a  id="userCard_1${lessonUser.user_id }" onmouseover="mouseOver(1,${lessonUser.user_id });" onmouseout="mouseOut(1,${lessonUser.user_id});"  class=" js-user-card" href="javascript:void(0);"  >
                                <img class="avatar-md" src="${pageContext.request.contextPath}${lessonUser.icon }">
                            </a>

                        </div>
                        <div class="media-body">
                            <div class="title">
                                <a class="link-dark link-light" href="javascript:void(0);"> <c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></a>

                            </div>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>

		<div class="panel-heading">
            <h3 class="panel-title">
                <i class="es-icon es-icon-personadd"></i>
                教研组
            </h3>
        </div>
        <!--教研组-->
        <c:forEach items="${lessonLeft.lessonUserList }" var="lessonUser">
            <c:if test="${lessonUser.identity ==2}">
                <div class="panel-body ">
                    <div class="media media-default" >
                        <div class="media-left ">
                            <a id="userCard_1${lessonUser.user_id }" onmouseover="mouseOver(1,${lessonUser.user_id });" onmouseout="mouseOut(1,${lessonUser.user_id});" class=" js-user-card" href="javascript:void(0);" >
                                <img class="avatar-md" src="${pageContext.request.contextPath}${lessonUser.icon }">
                            </a>

                        </div>
                        <div class="media-body">

                            <div class="title" >
                                <a class="link-dark link-light" href="javascript:void(0);">指导教师:<c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></a>
                            </div>

                        </div>
                    </div>
                </div>
            </c:if>
            <c:if test="${lessonUser.identity ==0}">
                <div class="panel-body">
                    <div class="media media-default" >
                        <div class="media-left">
                            <a id="userCard_1${lessonUser.user_id }" onmouseover="mouseOver(1,${lessonUser.user_id });" onmouseout="mouseOut(1,${lessonUser.user_id});"  class=" js-user-card" href="javascript:void(0);" >
                                <img class="avatar-md" src="${pageContext.request.contextPath}${lessonUser.icon }">
                            </a>

                        </div>
                        <div class="media-body ">
                            <div class="title" >
                                <a class="link-dark link-light" href="javascript:void(0);">组长:<c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if>
                                    <c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></a>

                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </c:forEach>
<div class="panel-heading">
            <h3 class="panel-title">
                <i class="es-icon es-icon-personadd"></i>
                组员
            </h3>
        </div>

        <div class="panel-body">
            <c:forEach items="${lessonLeft.lessonUserList }" var="lessonUser">
                <c:if test="${lessonUser.identity ==3&&lessonUser.user_id!=lesson.user_sk}">
                    <div class="media media-default">
                        <div class="media-left">
                            <a  id="userCard_1${lessonUser.user_id }" onmouseover="mouseOver(1,${lessonUser.user_id });" onmouseout="mouseOut(1,${lessonUser.user_id});"  class=" js-user-card" href="javascript:void(0);"  >
                                <img class="avatar-md" src="${pageContext.request.contextPath}${lessonUser.icon }">
                            </a>

                        </div>
                        <div class="media-body">
                            <div class="title">
                                <a class="link-dark link-light" href="javascript:void(0);"> <c:if test="${empty lessonUser.true_name }">${lessonUser.user_name }</c:if><c:if test="${!empty lessonUser.true_name }">${lessonUser.true_name }</c:if></a>

                            </div>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>


    </div>

</div >