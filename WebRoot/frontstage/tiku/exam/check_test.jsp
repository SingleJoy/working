<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>
<%--<link href="${pageContext.request.contextPath}/frontstage/css/course-info.css" rel="stylesheet" type="text/css">--%>

<link href="${pageContext.request.contextPath}/frontstage/css/nouislider.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/nouislider.js"></script>
<link href="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/wangEditor/wangEditor.min.js"></script>

<div class="cn-wrap">

    <div id="content-container" class="container" style="margin-top:20px;">
        <div class="cn-section testpaper-heading">
            <div class="testpaper-titlebar clearfix">
                <h1 class="testpaper-title">${testPaper.name }
                    <br><small class="text-sm">答题人：${user.username } 交卷时间：
                        <fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${exam.submit_time }" /> 用时：
                        <span id="time_show"></span>
                    </small>
                </h1>
                <div class="testpaper-status">
                    <c:if test="${tab==3||tab==4 }">
                        <div class="label label-info">批阅中</div>
                    </c:if>
                    <c:if test="${tab==5 }">
                        <div class="label label-success">批阅完成</div>
                    </c:if>
                </div>
            </div>
            <div class="media testpaper-result">
                <div class="testpaper-result-total">
                    <div class="well">
                        <div class="testpaper-result-total-score">  <c:if test="${tab==3||tab==4 }">?</c:if>  <c:if test="${tab==5 }">${exam.exam_score}</c:if> <small>分</small></div>
                        <small class="text-muted">总分 ${total_score0+total_score1+total_score2+total_score3+total_score5 } 分</small>
                    </div>
                </div>
                <div class="media-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-condensed testpaper-result-table">

                            <tr>
                                <th></th>
                                <th>单选题 <small class="text-muted">(${testPaperQuestionViews5.size() }道)</small></th>
                                <th>多选题 <small class="text-muted">(${testPaperQuestionViews0.size() }道)</small></th>
                                <th>填空题 <small class="text-muted">(${testPaperQuestionViews1.size() }道)</small></th>
                                <th>判断题 <small class="text-muted">(${testPaperQuestionViews2.size() }道)</small></th>
                                <th>问答题 <small class="text-muted">(${testPaperQuestionViews3.size() }道)</small></th>
                                <th>材料题 <small class="text-muted">(${testPaperQuestionViews6.size() }道)</small></th>
                            </tr>
                            <tr>
                                <th>答对</th>
                                <td><span class="text-success">${right5 } <small>道</small></span></td>
                                <td><span class="text-success">${right0 } <small>道</small></span></td>
                                <td><span class="text-success">${right1 } <small>道</small></span></td>
                                <td><span class="text-success">${right2 } <small>道</small></span></td>
                                <c:if test="${tab==3||tab==4 }">
                                    <td rowspan="4" style="vertical-align:middle"><span class="text-success" style="font-size:40px">?</span></td>
                                    <td rowspan="4" style="vertical-align:middle"><span class="text-success" style="font-size:40px">?</span></td>
                                </c:if>
                                <c:if test="${tab==5 }">
                                    <td><span class="text-success">${right3 } <small>道</small></span></td>
                                    <td><span class="text-success">${right6 } <small>道</small></span></td>
                                </c:if>
                            </tr>
                            <tr>
                                <th>答错</th>
                                <td><span class="text-danger">${wrong5 } <small>道</small></span></td>
                                <td><span class="text-danger">${wrong0 } <small>道</small></span></td>
                                <td><span class="text-danger">${wrong1 } <small>道</small></span></td>
                                <td><span class="text-danger">${wrong2 } <small>道</small></span></td>
                                <c:if test="${tab==5 }">
                                    <td><span class="text-danger">${wrong3 } <small>道</small></span></td>
                                    <td><span class="text-danger">${wrong6} <small>道</small></span></td>
                                </c:if>
                            </tr>
                            <tr>
                                <th>未答</th>
                                <td><span class="text-muted">${not_do5 } <small>道</small></span></td>
                                <td><span class="text-muted">${not_do0 } <small>道</small></span></td>
                                <td><span class="text-muted">${not_do1 }  <small>道</small></span></td>
                                <td><span class="text-muted">${not_do2 }  <small>道</small></span></td>
                                <c:if test="${tab==5 }">
                                    <td><span class="text-muted">${not_do3 } <small>道</small></span></td>
                                    <td><span class="text-muted">${not_do6 } <small>道</small></span></td>
                                </c:if>
                            </tr>
                            <tr>
                                <th>得分</th>
                                <td><span class="text-score">${right_score5 } <small>分</small></span></td>
                                <td><span class="text-score">${right_score0 }  <small>分</small></span></td>
                                <td><span class="text-score">${right_score1 } <small>分</small></span></td>
                                <td><span class="text-score">${right_score2 } <small>分</small></span></td>
                                <c:if test="${tab==5 }">
                                    <td><span class="text-score">${right_score3 } <small>分</small></span></td>
                                    <td><span class="text-score">${right_score6 } <small>分</small></span></td>
                                </c:if>
                            </tr>

                        </table>
                    </div>
                </div>
                <c:if test="${tab==3 }">
                    <div class="alert alert-warning">老师正在批阅试卷，批阅完成后会以站内私信通知您批阅结果，请稍等。</div>
                </c:if>
                <c:if test="${tab==5 }">
                    <c:if test="${try_again }">
                        <c:if test="${exam.grade!=3 }">
                            <div class="alert alert-success">恭喜您成功通过考试!</div>
                        </c:if>
                        <c:if test="${exam.grade==3 }">
                            <div class="alert alert-danger">
                                您未通过考试，请<a href="${pageContext.request.contextPath}/exam/do_again.action?id=${testPaper.id }&courseId=${courseView.id}&exam_type=0&class_id=${class_id}" class="text-success">重新参加考试</a>，或者重新学习课程。
                            </div>
                        </c:if>
                    </c:if>
                    <c:if test="${!try_again }">
                        <c:if test="${exam.grade!=3 }">
                            <div class="alert alert-success">成功通过考试!</div>
                        </c:if>
                        <c:if test="${exam.grade==3 }">
                            <div class="alert alert-danger">
                                未通过考试
                            </div>
                        </c:if>
                    </c:if>
                </c:if>
            </div>
            <c:if test="${tab==4 }">
                <div class="text-info mbl">请完成以下题目的批阅：</div>
            </c:if>
            <div id="testpaper-navbar" class="testpaper-navbar affix-top" data-spy="affix" data-offset-top="200">
                <ul class="nav nav-pills clearfix">
                    <c:if test="${tab!=4 }"><c:if test="${testPaperQuestionViews5.size()>0 }"><li class=""><a href="#testpaper-questions-choice1">单选题</a></li></c:if></c:if>
                    <c:if test="${tab!=4 }"><c:if test="${testPaperQuestionViews0.size()>0 }"><li class=""><a href="#testpaper-questions-choice2">多选题</a></li></c:if></c:if>
                    <c:if test="${tab!=4 }"><c:if test="${testPaperQuestionViews1.size()>0 }"><li class=""><a href="#testpaper-questions-fill">填空题</a></li></c:if></c:if>
                    <c:if test="${tab!=4 }"> <c:if test="${testPaperQuestionViews2.size()>0 }"><li class=""><a href="#testpaper-questions-determine">判断题</a></li></c:if></c:if>
                    <c:if test="${testPaperQuestionViews3.size()>0 }"><li class=""><a href="#testpaper-questions-essay">问答题</a></li></c:if>
                    <c:if test="${tab!=4||status==1 }"><c:if test="${testPaperQuestionViews6.size()>0 }"><li class=""><a href="#testpaper-questions-material">材料题</a></li></c:if></c:if>
                </ul>
            </div>
        </div>
        <div class="row">
            <div class="col-md-9 prevent-copy">
                <div class="testpaper-body">
                    <form id="teacherCheckForm" autocomplete="off" novalidate="novalidate" >
                        <c:if test="${testPaperQuestionViews5.size()>0&&tab!=4 }">

                            <div class="panel panel-default testpaper-question-block" id="testpaper-questions-choice1">
                                <div  class="panel-heading"><strong class="">单选题</strong>
                                    <small class="text-muted">共${testPaperQuestionViews5.size() }题，共${total_score5 }分</small>
                                </div>
                                <div class="panel-body">
                                    <c:forEach items="${testPaperQuestionViews5 }" var="question">
                                        <c:choose>
                                            <c:when test="${question.question_status==2 }">


                                                <div class="testpaper-question testpaper-question-choice "  >
                                                    <div class="testpaper-question-body">
                                                        <div class="testpaper-question-stem-wrap clearfix">
                                                            <div class="testpaper-question-seq-wrap">
                                                                <div class="testpaper-question-seq">${question.questions_number }</div>
                                                                <div class="testpaper-question-score">${question.questions_score }分</div>
                                                            </div>
                                                            <div class="testpaper-question-stem"><p>此题已删除</p><br></div>
                                                        </div>

                                                    </div>
                                                </div>

                                            </c:when>
                                            <c:otherwise>

                                                <div class="testpaper-question testpaper-question-choice " id="question${question.question_id }" data-question-id="${question.id }" data-right="${question.is_right }" >
                                                    <div class="testpaper-question-body">
                                                        <div class="testpaper-question-stem-wrap clearfix">
                                                            <div class="testpaper-question-seq-wrap">
                                                                <div class="testpaper-question-seq">${question.questions_number }</div>
                                                                <div class="testpaper-question-score">${question.questions_score }分</div>
                                                            </div>
                                                            <div class="testpaper-question-stem"><p>${question.stem }</p><br></div>
                                                        </div>
                                                        <ul class="testpaper-question-choices">
                                                            <li class=""><span class="testpaper-question-choice-index <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'A')}">question-text-success</c:if></c:if>">A.</span>
                                                                <div class="choice-body <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'A')}">question-text-success</c:if></c:if>">
                                                                    <p>${question.option_a }</p>
                                                                </div>
                                                            </li>
                                                            <li class=""><span class="testpaper-question-choice-index <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'B')}">question-text-success</c:if></c:if>">B.</span>
                                                                <div class="choice-body <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'B')}">question-text-success</c:if></c:if>">
                                                                    <p>${question.option_b }</p>
                                                                </div>
                                                            </li>
                                                            <c:if test="${!empty question.option_c }">
                                                                <li class=""><span class="testpaper-question-choice-index <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'C')}">question-text-success</c:if></c:if>">C.</span>
                                                                    <div class="choice-body <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'C')}">question-text-success</c:if></c:if>">
                                                                        <p>${question.option_c }</p>
                                                                    </div>
                                                                </li>
                                                            </c:if>
                                                            <c:if test="${!empty question.option_d }">
                                                                <li class=""><span class="testpaper-question-choice-index <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'D')}">question-text-success</c:if></c:if>">D.</span>
                                                                    <div class="choice-body <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'D')}">question-text-success</c:if></c:if>">
                                                                        <p>${question.option_d }</p>
                                                                    </div>
                                                                </li>
                                                            </c:if>
                                                            <c:if test="${!empty question.option_e }">
                                                                <li class=""><span class="testpaper-question-choice-index <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'E')}">question-text-success</c:if></c:if>">E.</span>
                                                                    <div class="choice-body <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'E')}">question-text-success</c:if></c:if>">
                                                                        <p>${question.option_e }</p>
                                                                    </div>
                                                                </li>
                                                            </c:if>
                                                        </ul>
                                                    </div>
                                                    <c:if test="${tab==1||tab==2 }">
                                                        <div class="testpaper-question-footer clearfix">
                                                            <div class="testpaper-question-choice-inputs">
                                                                <label class="radio-inline ">
                                                                    <input type="radio" name="questions[1][]" <c:if test="${fn:contains(question.answer, 'A')}"> checked="checked"</c:if> value="A" >
                                                                    A
                                                                </label>
                                                                <label class="radio-inline ">
                                                                    <input type="radio" name="questions[1][]" <c:if test="${fn:contains(question.answer, 'B')}"> checked="checked"</c:if> value="B">
                                                                    B
                                                                </label>
                                                                <c:if test="${!empty question.option_c }">
                                                                    <label class="radio-inline ">
                                                                        <input type="radio" name="questions[1][]" <c:if test="${fn:contains(question.answer, 'C')}"> checked="checked"</c:if> value="C">
                                                                        C
                                                                    </label>
                                                                </c:if>
                                                                <c:if test="${!empty question.option_d }">
                                                                    <label class="radio-inline ">
                                                                        <input type="radio" name="questions[1][]" <c:if test="${fn:contains(question.answer, 'D')}"> checked="checked"</c:if> value="D">
                                                                        D
                                                                    </label>
                                                                </c:if>
                                                                <c:if test="${!empty question.option_e }">
                                                                    <label class="radio-inline ">
                                                                        <input type="radio" name="questions[1][]" <c:if test="${fn:contains(question.answer, 'E')}"> checked="checked"</c:if> value="E">
                                                                        E
                                                                    </label>
                                                                </c:if>
                                                            </div>
                                                            <div class="testpaper-question-actions pull-right"></div>
                                                        </div>
                                                    </c:if>
                                                    <c:if test="${tab==3||tab==4||tab==5 }">
                                                        <div class="homework-question-result" style="margin-left: 50px">
                                                            <c:if test="${question.is_right==0 }">
                                                                <span class="glyphicon glyphicon-ok question-text-success"></span>
                                                                <c:if test="${tab==5||tab==3 }">
                                                                    你答对了!
                                                                </c:if>
                                                            </c:if>
                                                            <c:if test="${question.is_right!=0 }">
                                                                <span class="glyphicon glyphicon-remove question-text-danger"></span>
                                                                <c:if test="${tab==5||tab==3 }">
                                                                    <c:if test="${!empty question.answer }">
                                                                        你答错了,你选择了
                                                                        <strong class="question-text-danger">
                                                                                ${fn:replace(question.answer, ',', ' ')}
                                                                        </strong>
                                                                    </c:if>
                                                                </c:if>
                                                                <c:if test="${empty question.answer }">
                                                                    <strong class="question-text-danger">未答题</strong>
                                                                </c:if>
                                                            </c:if>
                                                        </div>
                                                    </c:if>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${testPaperQuestionViews0.size()>0&&tab!=4 }">
                            <div class="panel panel-default testpaper-question-block" id="testpaper-questions-choice2">
                                <div class="panel-heading"><strong class="">多选题</strong>
                                    <small class="text-muted">共${testPaperQuestionViews0.size() }题，共${total_score0 }分</small>
                                </div>
                                <div class="panel-body">
                                    <c:forEach items="${testPaperQuestionViews0 }" var="question">
                                        <c:choose>
                                            <c:when test="${question.question_status==2 }">


                                                <div class="testpaper-question testpaper-question-choice " >
                                                    <div class="testpaper-question-body">
                                                        <div class="testpaper-question-stem-wrap clearfix">
                                                            <div class="testpaper-question-seq-wrap">
                                                                <div class="testpaper-question-seq">${question.questions_number }</div>
                                                                <div class="testpaper-question-score">${question.questions_score }分</div>
                                                            </div>
                                                            <div class="testpaper-question-stem"><p> 此题已删除</p><br></div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </c:when>
                                            <c:otherwise>
                                                <div class="testpaper-question testpaper-question-choice " id="question${question.question_id }" data-question-id="${question.id }" data-right="${question.is_right }" >
                                                    <div class="testpaper-question-body">
                                                        <div class="testpaper-question-stem-wrap clearfix">
                                                            <div class="testpaper-question-seq-wrap">
                                                                <div class="testpaper-question-seq">${question.questions_number }</div>
                                                                <div class="testpaper-question-score">${question.questions_score }分</div>
                                                            </div>
                                                            <div class="testpaper-question-stem"><p>${question.stem }</p><br></div>
                                                        </div>
                                                        <ul class="testpaper-question-choices">
                                                            <li class=""><span class="testpaper-question-choice-index <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'A')}">question-text-success</c:if></c:if>">A.</span>
                                                                <div class="choice-body <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'A')}">question-text-success</c:if></c:if>">
                                                                    <p>${question.option_a }</p>
                                                                </div>
                                                            </li>
                                                            <li class=""><span class="testpaper-question-choice-index <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'B')}">question-text-success</c:if></c:if>">B.</span>
                                                                <div class="choice-body <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'B')}">question-text-success</c:if></c:if>">
                                                                    <p>${question.option_b }</p>
                                                                </div>
                                                            </li>
                                                            <c:if test="${!empty question.option_c }">
                                                                <li class=""><span class="testpaper-question-choice-index <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'C')}">question-text-success</c:if></c:if>">C.</span>
                                                                    <div class="choice-body <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'C')}">question-text-success</c:if></c:if>">
                                                                        <p>${question.option_c }</p>
                                                                    </div>
                                                                </li>
                                                            </c:if>
                                                            <c:if test="${!empty question.option_d }">
                                                                <li class=""><span class="testpaper-question-choice-index <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'D')}">question-text-success</c:if></c:if>">D.</span>
                                                                    <div class="choice-body <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'D')}">question-text-success</c:if></c:if>">
                                                                        <p>${question.option_d }</p>
                                                                    </div>
                                                                </li>
                                                            </c:if>
                                                            <c:if test="${!empty question.option_e }">
                                                                <li class=""><span class="testpaper-question-choice-index <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'E')}">question-text-success</c:if></c:if>">E.</span>
                                                                    <div class="choice-body <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'E')}">question-text-success</c:if></c:if>">
                                                                        <p>${question.option_e }</p>
                                                                    </div>
                                                                </li>
                                                            </c:if>
                                                        </ul>
                                                    </div>
                                                    <c:if test="${tab==1||tab==2 }">
                                                        <div class="testpaper-question-footer clearfix">
                                                            <div class="testpaper-question-choice-inputs">
                                                                <label class="radio-inline ">
                                                                    <input type="checkbox" name="questions[1][]" <c:if test="${fn:contains(question.answer, 'A')}"> checked="checked"</c:if> value="A" >
                                                                    A
                                                                </label>
                                                                <label class="radio-inline ">
                                                                    <input type="checkbox" name="questions[1][]" <c:if test="${fn:contains(question.answer, 'B')}"> checked="checked"</c:if> value="B">
                                                                    B
                                                                </label>
                                                                <c:if test="${!empty question.option_c }">
                                                                    <label class="radio-inline ">
                                                                        <input type="checkbox" name="questions[1][]" <c:if test="${fn:contains(question.answer, 'C')}"> checked="checked"</c:if> value="C">
                                                                        C
                                                                    </label>
                                                                </c:if>
                                                                <c:if test="${!empty question.option_d }">
                                                                    <label class="radio-inline ">
                                                                        <input type="checkbox" name="questions[1][]" <c:if test="${fn:contains(question.answer, 'D')}"> checked="checked"</c:if> value="D">
                                                                        D
                                                                    </label>
                                                                </c:if>
                                                                <c:if test="${!empty question.option_e }">
                                                                    <label class="radio-inline ">
                                                                        <input type="checkbox" name="questions[1][]" <c:if test="${fn:contains(question.answer, 'E')}"> checked="checked"</c:if> value="E">
                                                                        E
                                                                    </label>
                                                                </c:if>
                                                            </div>
                                                            <div class="testpaper-question-actions pull-right"></div>
                                                        </div>
                                                    </c:if>
                                                    <c:if test="${tab==3||tab==4||tab==5 }">
                                                        <div class="homework-question-result" style="margin-left: 50px">
                                                            <c:if test="${question.is_right==0 }">
                                                                <span class="glyphicon glyphicon-ok question-text-success"></span>
                                                                <c:if test="${tab==5||tab==3 }">
                                                                    你答对了!
                                                                </c:if>
                                                            </c:if>
                                                            <c:if test="${question.is_right!=0 }">
                                                                <span class="glyphicon glyphicon-remove question-text-danger"></span>
                                                                <c:if test="${tab==5||tab==3 }">
                                                                    <c:if test="${!empty question.answer }">
                                                                        你答错了,你选择了
                                                                        <strong class="question-text-danger">
                                                                                ${fn:replace(question.answer, ',', ' ')}
                                                                        </strong>
                                                                    </c:if>
                                                                </c:if>
                                                                <c:if test="${empty question.answer }">
                                                                    <strong class="question-text-danger">未答题</strong>
                                                                </c:if>
                                                            </c:if>
                                                        </div>
                                                    </c:if>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${testPaperQuestionViews1.size()>0&&tab!=4 }">
                            <div class="panel panel-default testpaper-question-block" id="testpaper-questions-fill">
                                <div  class="panel-heading"><strong class="">填空题</strong>
                                    <small class="text-muted">共${testPaperQuestionViews1.size() }题，共${total_score1 }分</small>
                                </div>
                                <div class="panel-body">
                                    <c:forEach items="${testPaperQuestionViews1 }" var="question">
                                        <c:choose>
                                            <c:when test="${question.question_status==2 }">


                                                <div class="testpaper-question testpaper-question-fill " >
                                                    <div class="testpaper-question-body">
                                                        <div class="testpaper-question-stem-wrap clearfix">
                                                            <div class="testpaper-question-seq-wrap">
                                                                <div class="testpaper-question-seq">${question.questions_number }</div>
                                                                <div class="testpaper-question-score">${question.questions_score }分</div>
                                                            </div>
                                                        </div>
                                                        <div class="testpaper-question-stem">
                                                            <p>
                                                                此题已删除
                                                            </p>
                                                        </div>
                                                    </div>
                                                </div>

                                            </c:when>
                                            <c:otherwise>
                                                <div class="testpaper-question testpaper-question-fill " id="question${question.question_id }" data-question-id="${question.id }" data-right="${question.is_right }" >
                                                    <div class="testpaper-question-body">
                                                        <div class="testpaper-question-stem-wrap clearfix">
                                                            <div class="testpaper-question-seq-wrap">
                                                                <div class="testpaper-question-seq">${question.questions_number }</div>
                                                                <div class="testpaper-question-score">${question.questions_score }分</div>
                                                            </div>
                                                            <div class="testpaper-question-stem">
                                                                <c:set var="stem" value=""/>
                                                                <c:forEach items="${fn:split(question.stem, '______')}" var="s" varStatus="status" >
                                                                    <c:if test="${!status.last}">
                                                                        <c:set var="stem" value="${stem}${s}<span class='question-stem-fill-blank'>(${status.count })</span>"/>
                                                                    </c:if>
                                                                    <c:if test="${status.last}">
                                                                        <c:set var="stem" value="${stem}${s}"/>
                                                                    </c:if>
                                                                </c:forEach>
                                                                <p><span style="color:rgb(232,61,44);">${stem }</span></p><br>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="testpaper-question-footer clearfix">
                                                        <div class="testpaper-question-fill-inputs">
                                                            <c:if test="${tab==1||tab==2 }">
                                                                <c:forEach items="${fn:split(question.stem, '______')}" var="s" varStatus="status" >
                                                                    <c:if test="${!status.last}">
                                                                        <c:set var="answer" value="${fn:split(question.answer, ',')}" />
                                                                        <input class="form-control " type="text" name="40" placeholder="填空(${status.count })答案，请填在这里" value="${answer[status.index]}">
                                                                    </c:if>
                                                                </c:forEach>
                                                            </c:if>
                                                        </div>
                                                        <c:if test="${tab==3||tab==4||tab==5 }">
                                                            <c:forEach items="${fn:split(question.right_key, ',')}" var="q" varStatus="status" >
                                                                <c:set var="answer" value="${fn:split(question.answer, ',')}" />
                                                                <c:set var="flag" value="0" />
                                                                <div class="homework-question-result" style="margin-left: 50px">
                                                                    填空(${status.count})： 正确答案
                                                                    <strong class="question-text-success">
                                                                            ${fn:replace(q, '|', ' 或 ')}
                                                                    </strong>
                                                                    回答是 <strong class="question-text-danger">
                                                                        ${answer[status.index]}。

                                                                </strong>
                                                                    <c:forEach items="${fn:split(q, '|')}" var="a"  >
                                                                        <c:if test="${answer[status.index].trim() eq a }">
                                                                            <c:set var="flag" value="1" />
                                                                        </c:if>
                                                                    </c:forEach>
                                                                    <c:if test="${flag eq '1' }">
                                                                        <span class="glyphicon glyphicon-ok question-text-success"></span>
                                                                    </c:if>
                                                                    <c:if test="${flag eq '0' }">
                                                                        <span class="glyphicon glyphicon-remove question-text-danger"></span>
                                                                    </c:if>
                                                                </div>
                                                                <br>
                                                            </c:forEach>
                                                        </c:if>
                                                        <div class="testpaper-question-actions pull-right"></div>
                                                    </div>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${testPaperQuestionViews2.size()>0&&tab!=4 }">
                            <div class="panel panel-default testpaper-question-block" id="testpaper-questions-determine">
                                <div  class="panel-heading"><strong class="">判断题</strong>
                                    <small class="text-muted">共${testPaperQuestionViews2.size() }题，共${total_score2 }分</small>
                                </div>
                                <div class="panel-body">
                                    <c:forEach items="${testPaperQuestionViews2 }" var="question">
                                        <c:choose>
                                            <c:when test="${question.question_status==2 }">


                                                <div class="testpaper-question testpaper-question-fill " id="question${question.question_id }" data-question-id="${question.id }" data-right="${question.is_right }" >
                                                    <div class="testpaper-question-body">
                                                        <div class="testpaper-question-stem-wrap clearfix">
                                                            <div class="testpaper-question-seq-wrap">
                                                                <div class="testpaper-question-seq">${question.questions_number }</div>
                                                                <div class="testpaper-question-score">${question.questions_score }分</div>
                                                            </div>
                                                            <div class="testpaper-question-stem"><p>此题已删除</p><br></div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </c:when>
                                            <c:otherwise>
                                                <div class="testpaper-question testpaper-question-fill " id="question${question.question_id }" data-question-id="${question.id }" data-right="${question.is_right }" >
                                                    <div class="testpaper-question-body">
                                                        <div class="testpaper-question-stem-wrap clearfix">
                                                            <div class="testpaper-question-seq-wrap">
                                                                <div class="testpaper-question-seq">${question.questions_number }</div>
                                                                <div class="testpaper-question-score">${question.questions_score }分</div>
                                                            </div>
                                                            <div class="testpaper-question-stem"><p>${question.stem }</p><br></div>
                                                        </div>
                                                    </div>
                                                    <div class="testpaper-question-footer clearfix">
                                                        <c:if test="${tab==1||tab==2 }">
                                                            <div class="testpaper-question-choice-inputs">
                                                                <label class="radio-inline "><input type="radio" name="41" value="1" <c:if test="${question.answer==1}"> checked="checked"</c:if>> 正确</label>
                                                                <label class="radio-inline "><input type="radio" name="41" value="0"<c:if test="${question.answer==0}"> checked="checked"</c:if>>错误</label>
                                                            </div>
                                                        </c:if>
                                                        <c:if test="${tab==3||tab==4||tab==5 }">
                                                            <div class="homework-question-result" style="margin-left: 50px">
                                                                正确答案是
                                                                <strong class="question-text-danger">
                                                                    <c:if test="${question.right_key==0 }">
                                                                        错误
                                                                    </c:if>
                                                                    <c:if test="${question.right_key==1 }">
                                                                        正确
                                                                    </c:if>
                                                                </strong>
                                                                <c:if test="${question.is_right==0 }">
                                                                    <span class="glyphicon glyphicon-ok question-text-success"></span>
                                                                    <c:if test="${tab==5 }">
                                                                        你答对了!
                                                                    </c:if>
                                                                </c:if>
                                                                <c:if test="${question.is_right==1 }">
                                                                    <span class="glyphicon glyphicon-remove question-text-danger"></span>
                                                                    <c:if test="${tab==5 }">
                                                                        你答错了
                                                                    </c:if>
                                                                </c:if>
                                                            </div>
                                                        </c:if>
                                                        <div class="testpaper-question-actions pull-right"></div>
                                                    </div>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${testPaperQuestionViews3.size()>0 }">
                            <div class="panel panel-default testpaper-question-block" id="testpaper-questions-essay">
                                <div class="panel-heading"><strong class="">问答题</strong>
                                    <small class="text-muted">共${testPaperQuestionViews3.size() }题，共${total_score3 }分</small>
                                </div>
                                <div class="panel-body">
                                    <c:forEach items="${testPaperQuestionViews3 }" var="question">
                                        <c:choose>
                                            <c:when test="${question.question_status==2 }">


                                                <div class="testpaper-question testpaper-question-essay " >
                                                    <div class="testpaper-question-body">
                                                        <div class="testpaper-question-stem-wrap clearfix">
                                                            <div class="testpaper-question-seq-wrap">
                                                                <div class="testpaper-question-seq">${question.questions_number }</div>
                                                                <div class="testpaper-question-score">${question.questions_score }分</div>
                                                            </div>
                                                            <div class="testpaper-question-stem"><p> 此题已删除</p><br></div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </c:when>
                                            <c:otherwise>
                                                <div class="testpaper-question testpaper-question-essay " id="question${question.question_id }" data-question-id="${question.id }" data-right="${question.is_right }" >
                                                    <div class="testpaper-question-body">
                                                        <div class="testpaper-question-stem-wrap clearfix">
                                                            <div class="testpaper-question-seq-wrap">
                                                                <div class="testpaper-question-seq">${question.questions_number }</div>
                                                                <div class="testpaper-question-score">${question.questions_score }分</div>
                                                            </div>
                                                            <div class="testpaper-question-stem"><p>${question.stem }</p><br></div>
                                                        </div>
                                                    </div>
                                                    <div class="testpaper-question-footer clearfix">
                                                        <div class="testpaper-question-essay-inputs">
                                                            <c:if test="${tab==1||tab==2 }">
                                                                <%--
                                                                <textarea class="form-control testpaper-question-essay-input-short essay-textarea"  id="essay-textarea${question.id }" rows="1" data-id="${question.id }">${question.answer}</textarea>
                                                                --%>
                                                                <div id="essay-textarea${question.id }" style="display:none;">
                                                                        ${question.answer}
                                                                </div>
                                                                <%-- 
                                                                <input class="form-control testpaper-question-essay-input-short essay-textarea" type="text" data-id="${question.id }" value="${question.answer}" readonly="readonly"/>
                                                                --%>
                                                                <textarea class="form-control testpaper-question-essay-input-short essay-textarea" data-id="${question.id }" readonly="readonly">
                                                                	${question.answer}
                                                                </textarea>
                                                                <a class="btn btn-link btn-muted btn-sm essay-textarea-pack-up" style="display: none" data-id="${question.id }" id="essay-textarea-pack-up${question.id }"><span class="glyphicon glyphicon-chevron-up text-muted"></span> 收起</a>
                                                            </c:if>
                                                            <c:if test="${tab==3||tab==5 }">
                                                                <strong>学员回答:</strong>
                                                                <c:if test="${empty question.answer}">
                                                                    <p class="question-text-danger">未答题</p>
                                                                </c:if>
                                                                <c:if test="${!empty question.answer}">
                                                                    ${question.answer}
                                                                </c:if>
                                                                <strong>参考答案</strong>
                                                                ${question.right_key}
                                                                <c:if test="${tab==5 }">
                                                                    <div class="testpaper-question-result-title">得分：<strong>${question.answer_score }  分</strong></div>

                                                                </c:if>
                                                            </c:if>
                                                            <c:if test="${tab==4 }">
                                                                <div class="testpaper-question-result">
                                                                    <ul class="nav nav-pills nav-mini mbm">
                                                                        <li class="active"><a href="javascript:;" data="#studentAnswer${question.id }">学员回答</a></li>
                                                                        <li class=""><a href="javascript:;" data="#teacherAnswer${question.id }">参考答案</a></li>
                                                                    </ul>
                                                                    <div class="tab-content mbl">
                                                                        <div class="tab-pane active" id="studentAnswer${question.id }">
                                                                            <c:if test="${empty question.answer}">
                                                                                <p class="question-text-danger">未答题</p>
                                                                            </c:if>
                                                                            <c:if test="${!empty question.answer}">
                                                                                ${question.answer}
                                                                            </c:if>
                                                                        </div>
                                                                        <div class="tab-pane " id="teacherAnswer${question.id }"><p>${question.right_key}</p></div>
                                                                    </div>
                                                                    <div class="form-horizontal">
                                                                        <div class="form-group">
                                                                            <label class="col-sm-2 control-label">得分</label>
                                                                            <div class="col-sm-3 controls">
                                                                                <input class="form-control defen" placeholder="得分" name="score_3" type="text" value="" data-score="${question.questions_score }">
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label class="col-sm-2 control-label">评语</label>
                                                                            <div class="col-sm-9">
                                                                                <div class="testpaper-result-essay-teacherSay">
                                                                                    <textarea class="form-control  teacher-say" name="answer[${question.id }]" data-type="essay" data-exam_answer_id="${question.exam_answer_id }" ></textarea>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </c:if>
                                                        </div>

                                                        <div class="testpaper-question-actions pull-right"></div>
                                                    </div>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${testPaperQuestionViews6.size()>0&&tab!=4||status==1 }">
                            <div class="panel panel-default testpaper-question-block" id="testpaper-questions-material">
                                <div class="panel-heading"><strong class="">材料题</strong>
                                    <small class="text-muted">共${testPaperQuestionViews6.size() }题，共${total_score5 }分</small>
                                </div>
                                <div class="panel-body">
                                    <div class="material">
                                        <c:forEach items="${testPaperQuestionViews4 }" var="q_id">
                                            <c:choose>
                                                <c:when test="${q_id.question_status==2 }">
                                                    <div class="well testpaper-question-stem-material"><p>材料题以及子题已被删除</p> </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="well testpaper-question-stem-material"><p>${q_id.stem }</p> </div>
                                                    <c:forEach items="${testPaperQuestionViews6 }" var="question">
                                                        <c:if test="${question.parent_question_id==q_id.question_id }">
                                                            <c:choose>
                                                                <c:when test="${question.question_status==2 }">

                                                                    <%--材料题只有子题被删除--%>
                                                                    <div class="testpaper-question testpaper-question-choice " >
                                                                        <div class="testpaper-question-body">
                                                                            <div class="testpaper-question-stem-wrap clearfix">
                                                                                <div class="testpaper-question-seq-wrap">
                                                                                    <div class="testpaper-question-seq">${question.questions_number }</div>
                                                                                    <div class="testpaper-question-score">${question.questions_score }分</div>
                                                                                </div>
                                                                                <div class="testpaper-question-stem"><p>材料题子题被删除</p><br></div>
                                                                            </div>

                                                                        </div>
                                                                    </div>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <c:if test="${question.type==5&&tab!=4}">
                                                                        <div class="testpaper-question testpaper-question-choice " id="question${question.question_id }" data-question-id="${question.id }" data-right="${question.is_right }" >
                                                                            <div class="testpaper-question-body">
                                                                                <div class="testpaper-question-stem-wrap clearfix">
                                                                                    <div class="testpaper-question-seq-wrap">
                                                                                        <div class="testpaper-question-seq">${question.questions_number }</div>
                                                                                        <div class="testpaper-question-score">${question.questions_score }分</div>
                                                                                    </div>
                                                                                    <div class="testpaper-question-stem"><p>${question.stem }</p><br></div>
                                                                                </div>
                                                                                <ul class="testpaper-question-choices">
                                                                                    <li class=""><span class="testpaper-question-choice-index <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'A')}">question-text-success</c:if></c:if>">A.</span>
                                                                                        <div class="choice-body <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'A')}">question-text-success</c:if></c:if>">
                                                                                            <p>${question.option_a }</p>
                                                                                        </div>
                                                                                    </li>
                                                                                    <li class=""><span class="testpaper-question-choice-index <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'B')}">question-text-success</c:if></c:if>">B.</span>
                                                                                        <div class="choice-body <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'B')}">question-text-success</c:if></c:if>">
                                                                                            <p>${question.option_b }</p>
                                                                                        </div>
                                                                                    </li>
                                                                                    <c:if test="${!empty question.option_c }">
                                                                                        <li class=""><span class="testpaper-question-choice-index <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'C')}">question-text-success</c:if></c:if>">C.</span>
                                                                                            <div class="choice-body <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'C')}">question-text-success</c:if></c:if>">
                                                                                                <p>${question.option_c }</p>
                                                                                            </div>
                                                                                        </li>
                                                                                    </c:if>
                                                                                    <c:if test="${!empty question.option_d }">
                                                                                        <li class=""><span class="testpaper-question-choice-index <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'D')}">question-text-success</c:if></c:if>">D.</span>
                                                                                            <div class="choice-body <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'D')}">question-text-success</c:if></c:if>">
                                                                                                <p>${question.option_d }</p>
                                                                                            </div>
                                                                                        </li>
                                                                                    </c:if>
                                                                                    <c:if test="${!empty question.option_e }">
                                                                                        <li class=""><span class="testpaper-question-choice-index <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'E')}">question-text-success</c:if></c:if>">E.</span>
                                                                                            <div class="choice-body <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'E')}">question-text-success</c:if></c:if>">
                                                                                                <p>${question.option_e }</p>
                                                                                            </div>
                                                                                        </li>
                                                                                    </c:if>
                                                                                </ul>
                                                                            </div>
                                                                            <c:if test="${tab==1||tab==2 }">
                                                                                <div class="testpaper-question-footer clearfix">
                                                                                    <div class="testpaper-question-choice-inputs">
                                                                                        <label class="radio-inline "><input type="checkbox" name="question${question.id }" value="A">A</label>
                                                                                        <label class="radio-inline "><input type="checkbox" name="question${question.id }" value="B">B</label>
                                                                                        <c:if test="${!empty question.option_c }">
                                                                                            <label class="radio-inline ">
                                                                                                <input type="checkbox" name="question${question.id }" value="C">C
                                                                                            </label>
                                                                                        </c:if>
                                                                                        <c:if test="${!empty question.option_d }">
                                                                                            <label class="radio-inline ">
                                                                                                <input type="checkbox" name="question${question.id }" value="D">D
                                                                                            </label>
                                                                                        </c:if>
                                                                                        <c:if test="${!empty question.option_e }">
                                                                                            <label class="radio-inline ">
                                                                                                <input type="checkbox" name="question${question.id }" value="E">E
                                                                                            </label>
                                                                                        </c:if>
                                                                                    </div>
                                                                                    <div class="testpaper-question-actions pull-right"></div>
                                                                                </div>
                                                                            </c:if>
                                                                            <c:if test="${tab==3||tab==4||tab==5 }">
                                                                                <div class="homework-question-result" style="margin-left: 50px">
                                                                                    <c:if test="${question.is_right==0 }">
                                                                                        <span class="glyphicon glyphicon-ok question-text-success"></span>
                                                                                        <c:if test="${tab==5||tab==3 }">你答对了!
                                                                                        </c:if>
                                                                                    </c:if>
                                                                                    <c:if test="${question.is_right!=0 }">
                                                                                        <span class="glyphicon glyphicon-remove question-text-danger"></span>
                                                                                        <c:if test="${tab==5||tab==3 }">
                                                                                            <c:if test="${!empty question.answer }">
                                                                                                你答错了,你选择了
                                                                                                <strong class="question-text-danger">
                                                                                                        ${fn:replace(question.answer, ',', ' ')}
                                                                                                </strong>
                                                                                            </c:if>
                                                                                        </c:if>
                                                                                        <c:if test="${empty question.answer }">
                                                                                            <strong class="question-text-danger">未答题</strong>
                                                                                        </c:if>
                                                                                    </c:if>
                                                                                </div>
                                                                            </c:if>
                                                                        </div>
                                                                    </c:if>
                                                                    <c:if test="${question.type==0&&tab!=4}">
                                                                        <div class="testpaper-question testpaper-question-choice " id="question${question.question_id }" data-question-id="${question.id }" data-right="${question.is_right }" >
                                                                            <div class="testpaper-question-body">
                                                                                <div class="testpaper-question-stem-wrap clearfix">
                                                                                    <div class="testpaper-question-seq-wrap">
                                                                                        <div class="testpaper-question-seq">${question.questions_number }</div>
                                                                                        <div class="testpaper-question-score">${question.questions_score }分</div>
                                                                                    </div>
                                                                                    <div class="testpaper-question-stem"><p>${question.stem }</p><br></div>
                                                                                </div>
                                                                                <ul class="testpaper-question-choices">
                                                                                    <li class=""><span class="testpaper-question-choice-index <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'A')}">question-text-success</c:if></c:if>">A.</span>
                                                                                        <div class="choice-body <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'A')}">question-text-success</c:if></c:if>">
                                                                                            <p>${question.option_a }</p>
                                                                                        </div>
                                                                                    </li>
                                                                                    <li class=""><span class="testpaper-question-choice-index <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'B')}">question-text-success</c:if></c:if>">B.</span>
                                                                                        <div class="choice-body <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'B')}">question-text-success</c:if></c:if>">
                                                                                            <p>${question.option_b }</p>
                                                                                        </div>
                                                                                    </li>
                                                                                    <c:if test="${!empty question.option_c }">
                                                                                        <li class=""><span class="testpaper-question-choice-index <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'C')}">question-text-success</c:if></c:if>">C.</span>
                                                                                            <div class="choice-body <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'C')}">question-text-success</c:if></c:if>">
                                                                                                <p>${question.option_c }</p>
                                                                                            </div>
                                                                                        </li>
                                                                                    </c:if>
                                                                                    <c:if test="${!empty question.option_d }">
                                                                                        <li class=""><span class="testpaper-question-choice-index <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'D')}">question-text-success</c:if></c:if>">D.</span>
                                                                                            <div class="choice-body <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'D')}">question-text-success</c:if></c:if>">
                                                                                                <p>${question.option_d }</p>
                                                                                            </div>
                                                                                        </li>
                                                                                    </c:if>
                                                                                    <c:if test="${!empty question.option_e }">
                                                                                        <li class=""><span class="testpaper-question-choice-index <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'E')}">question-text-success</c:if></c:if>">E.</span>
                                                                                            <div class="choice-body <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'E')}">question-text-success</c:if></c:if>">
                                                                                                <p>${question.option_e }</p>
                                                                                            </div>
                                                                                        </li>
                                                                                    </c:if>
                                                                                </ul>
                                                                            </div>
                                                                            <c:if test="${tab==1||tab==2 }">
                                                                                <div class="testpaper-question-footer clearfix">
                                                                                    <div class="testpaper-question-choice-inputs">
                                                                                        <label class="radio-inline "><input type="checkbox" name="question${question.id }" value="A">A</label>
                                                                                        <label class="radio-inline "><input type="checkbox" name="question${question.id }" value="B">B</label>
                                                                                        <c:if test="${!empty question.option_c }">
                                                                                            <label class="radio-inline ">
                                                                                                <input type="checkbox" name="question${question.id }" value="C">C
                                                                                            </label>
                                                                                        </c:if>
                                                                                        <c:if test="${!empty question.option_d }">
                                                                                            <label class="radio-inline ">
                                                                                                <input type="checkbox" name="question${question.id }" value="D">D
                                                                                            </label>
                                                                                        </c:if>
                                                                                        <c:if test="${!empty question.option_e }">
                                                                                            <label class="radio-inline ">
                                                                                                <input type="checkbox" name="question${question.id }" value="E">E
                                                                                            </label>
                                                                                        </c:if>
                                                                                    </div>
                                                                                    <div class="testpaper-question-actions pull-right"></div>
                                                                                </div>
                                                                            </c:if>
                                                                            <c:if test="${tab==3||tab==4||tab==5 }">
                                                                                <div class="homework-question-result" style="margin-left: 50px">
                                                                                    <c:if test="${question.is_right==0 }">
                                                                                        <span class="glyphicon glyphicon-ok question-text-success"></span>
                                                                                        <c:if test="${tab==5||tab==3 }">你答对了!
                                                                                        </c:if>
                                                                                    </c:if>
                                                                                    <c:if test="${question.is_right!=0 }">
                                                                                        <span class="glyphicon glyphicon-remove question-text-danger"></span>
                                                                                        <c:if test="${tab==5||tab==3 }">
                                                                                            <c:if test="${!empty question.answer }">
                                                                                                你答错了,你选择了
                                                                                                <strong class="question-text-danger">
                                                                                                        ${fn:replace(question.answer, ',', ' ')}
                                                                                                </strong>
                                                                                            </c:if>
                                                                                        </c:if>
                                                                                        <c:if test="${empty question.answer }">
                                                                                            <strong class="question-text-danger">未答题</strong>
                                                                                        </c:if>
                                                                                    </c:if>
                                                                                </div>
                                                                            </c:if>
                                                                        </div>
                                                                    </c:if>
                                                                    <c:if test="${question.type==1&&tab!=4}">
                                                                        <div class="testpaper-question testpaper-question-fill " id="question${question.question_id }" data-question-id="${question.id }" data-right="${question.is_right }" >
                                                                            <div class="testpaper-question-body">
                                                                                <div class="testpaper-question-stem-wrap clearfix">
                                                                                    <div class="testpaper-question-seq-wrap">
                                                                                        <div class="testpaper-question-seq">${question.questions_number }</div>
                                                                                        <div class="testpaper-question-score">${question.questions_score }分</div>
                                                                                    </div>
                                                                                    <div class="testpaper-question-stem">
                                                                                        <c:set var="stem" value=""/>
                                                                                        <c:forEach items="${fn:split(question.stem, '______')}" var="s" varStatus="status" >
                                                                                            <c:if test="${!status.last}">
                                                                                                <c:set var="stem" value="${stem}${s}<span class='question-stem-fill-blank'>(${status.count })</span>"/>
                                                                                            </c:if>
                                                                                            <c:if test="${status.last}">
                                                                                                <c:set var="stem" value="${stem}${s}"/>
                                                                                            </c:if>
                                                                                        </c:forEach>
                                                                                        <p><span style="color:rgb(232,61,44);">${stem }</span></p><br>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="testpaper-question-footer clearfix">
                                                                                <div class="testpaper-question-fill-inputs">
                                                                                    <c:if test="${tab==1||tab==2 }">
                                                                                        <c:forEach items="${fn:split(question.stem, '______')}" var="s" varStatus="status" >
                                                                                            <c:if test="${!status.last}">
                                                                                                <input class="form-control " type="text" name="40" placeholder="填空(${status.count })答案，请填在这里">
                                                                                            </c:if>
                                                                                        </c:forEach>
                                                                                    </c:if>
                                                                                </div>
                                                                                <c:if test="${tab==3||tab==4||tab==5 }">
                                                                                    <c:forEach items="${fn:split(question.right_key, ',')}" var="q" varStatus="status" >
                                                                                        <c:set var="answer" value="${fn:split(question.answer, ',')}" />
                                                                                        <c:set var="flag" value="0" />
                                                                                        <div class="homework-question-result" style="margin-left: 50px">
                                                                                            填空(${status.count})： 正确答案
                                                                                            <strong class="question-text-success">
                                                                                                    ${fn:replace(q, '|', ' 或 ')}
                                                                                            </strong>
                                                                                            回答是 <strong class="question-text-danger">
                                                                                                ${answer[status.index]}。

                                                                                        </strong>
                                                                                            <c:forEach items="${fn:split(q, '|')}" var="a"  >
                                                                                                <c:if test="${answer[status.index] eq a }">
                                                                                                    <c:set var="flag" value="1" />
                                                                                                </c:if>
                                                                                            </c:forEach>
                                                                                            <c:if test="${flag eq '1' }">
                                                                                                <span class="glyphicon glyphicon-ok question-text-success"></span>
                                                                                            </c:if>
                                                                                            <c:if test="${flag eq '0' }">
                                                                                                <span class="glyphicon glyphicon-remove question-text-danger"></span>
                                                                                            </c:if>
                                                                                        </div>
                                                                                        <br>
                                                                                    </c:forEach>
                                                                                </c:if>
                                                                                <div class="testpaper-question-actions pull-right"></div>
                                                                            </div>
                                                                        </div>
                                                                    </c:if>
                                                                    <c:if test="${question.type==2&&tab!=4}">
                                                                        <div class="testpaper-question testpaper-question-fill " id="question${question.question_id }" data-question-id="${question.id }" data-right="${question.is_right }" >
                                                                            <div class="testpaper-question-body">
                                                                                <div class="testpaper-question-stem-wrap clearfix">
                                                                                    <div class="testpaper-question-seq-wrap">
                                                                                        <div class="testpaper-question-seq">${question.questions_number }</div>
                                                                                        <div class="testpaper-question-score">${question.questions_score }分</div>
                                                                                    </div>
                                                                                    <div class="testpaper-question-stem"><p>${question.stem }</p><br></div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="testpaper-question-footer clearfix">
                                                                                <c:if test="${tab==1||tab==2 }">
                                                                                    <div class="testpaper-question-choice-inputs">
                                                                                        <label class="radio-inline "><input type="radio" name="question${question.question_id }" value="1"> 正确</label>
                                                                                        <label class="radio-inline "><input type="radio" name="question${question.question_id }" value="0">错误</label>
                                                                                    </div>
                                                                                </c:if>
                                                                                <c:if test="${tab==3||tab==4||tab==5 }">
                                                                                    <div class="homework-question-result" style="margin-left: 50px">
                                                                                        正确答案是
                                                                                        <strong class="question-text-danger">
                                                                                            <c:if test="${question.right_key==0 }">
                                                                                                错误
                                                                                            </c:if>
                                                                                            <c:if test="${question.right_key==1 }">
                                                                                                正确
                                                                                            </c:if>
                                                                                        </strong>
                                                                                        <c:if test="${question.is_right==0 }">
                                                                                            <span class="glyphicon glyphicon-ok question-text-success"></span>
                                                                                            <c:if test="${tab==5 }">
                                                                                                你答对了!
                                                                                            </c:if>
                                                                                        </c:if>
                                                                                        <c:if test="${question.is_right==1 }">
                                                                                            <span class="glyphicon glyphicon-remove question-text-danger"></span>
                                                                                            <c:if test="${tab==5 }">
                                                                                                你答错了
                                                                                            </c:if>
                                                                                        </c:if>
                                                                                    </div>
                                                                                </c:if>
                                                                                <div class="testpaper-question-actions pull-right"></div>
                                                                            </div>
                                                                        </div>
                                                                    </c:if>
                                                                    <c:if test="${question.type==3}">
                                                                        <div class="testpaper-question testpaper-question-essay " id="question${question.question_id }" data-question-id="${question.id }" data-right="${question.is_right }" >
                                                                            <div class="testpaper-question-body">
                                                                                <div class="testpaper-question-stem-wrap clearfix">
                                                                                    <div class="testpaper-question-seq-wrap">
                                                                                        <div class="testpaper-question-seq">${question.questions_number }</div>
                                                                                        <div class="testpaper-question-score">${question.questions_score }分</div>
                                                                                    </div>
                                                                                    <div class="testpaper-question-stem"><p>${question.stem }</p><br></div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="testpaper-question-footer clearfix">
                                                                                <div class="testpaper-question-essay-inputs">
                                                                                    <c:if test="${tab==1||tab==2 }">
                                                                                        <%-- 
                                                                                        <textarea class="form-control testpaper-question-essay-input-short essay-textarea" id="essay-textarea${question.id }" rows="1" data-id="${question.id }"></textarea>
                                                                                        --%>
                                                                                        <div id="essay-textarea${question.id }" style="display:none;">
                                                        									${question.answer}
                                                        								</div>
                                                        								<textarea class="form-control testpaper-question-essay-input-short essay-textarea" data-id="${question.id }" readonly="readonly" rows="1">
                                                        									${question.answer}
                                                        								</textarea>
                                                                                        <a class="btn btn-link btn-muted btn-sm essay-textarea-pack-up" style="display: none" data-id="${question.id }" id="essay-textarea-pack-up${question.id }"><span class="glyphicon glyphicon-chevron-up text-muted"></span> 收起</a>
                                                                                    </c:if>
                                                                                    <c:if test="${tab==3||tab==5 }">
                                                                                        <strong>学员回答:</strong>
                                                                                        <c:if test="${empty question.answer}">
                                                                                            <p class="question-text-danger">未答题</p>
                                                                                        </c:if>
                                                                                        <c:if test="${!empty question.answer}">
                                                                                            ${question.answer}
                                                                                        </c:if>
                                                                                        <strong>正确答案</strong>
                                                                                        ${question.right_key}
                                                                                        <c:if test="${tab==5 }">
                                                                                            <div class="testpaper-question-result-title">得分：<strong>${question.answer_score } 分</strong></div>
                                                                                        </c:if>
                                                                                    </c:if>
                                                                                    <c:if test="${tab==4 }">
                                                                                        <div class="testpaper-question-result">
                                                                                            <ul class="nav nav-pills nav-mini mbm">
                                                                                                <li class="active"><a href="javascript:;" data="#studentAnswer${question.id }">学员回答</a></li>
                                                                                                <li class=""><a href="javascript:;" data="#teacherAnswer${question.id }">参考答案</a></li>
                                                                                            </ul>
                                                                                            <div class="tab-content mbl">
                                                                                                <div class="tab-pane active" id="studentAnswer${question.id }">
                                                                                                    <c:if test="${empty question.answer}">
                                                                                                        <p class="question-text-danger">未答题</p>
                                                                                                    </c:if>
                                                                                                    <c:if test="${!empty question.answer}">
                                                                                                        ${question.answer}
                                                                                                    </c:if>
                                                                                                </div>
                                                                                                <div class="tab-pane " id="teacherAnswer${question.id }"><p>${question.right_key}</p></div>
                                                                                            </div>
                                                                                            <div class="form-horizontal">
                                                                                                <div class="form-group">
                                                                                                    <label class="col-sm-2 control-label">得分</label>
                                                                                                    <div class="col-sm-3 controls">
                                                                                                        <input class="form-control defen" placeholder="得分" name="score_3" type="text" value="" data-score="${question.questions_score }">
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div class="form-group">
                                                                                                    <label class="col-sm-2 control-label">评语</label>
                                                                                                    <div class="col-sm-9">
                                                                                                        <div class="testpaper-result-essay-teacherSay">
                                                                                                            <textarea class="form-control  teacher-say" name="answer[${question.id }]" data-type="essay" data-exam_answer_id="${question.exam_answer_id }" ></textarea>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </c:if>
                                                                                </div>


                                                                                <div class="testpaper-question-actions pull-right"></div>
                                                                            </div>
                                                                        </div>
                                                                    </c:if>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:if>
                                                    </c:forEach>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </form>
                </div>
            </div>
            <div class="col-md-3">
                <div class="testpaper-card affix-top" data-spy="affix" data-offset-top="360" data-offset-bottom="360">
                    <div class="panel panel-default">

                        <div class="panel-body">
                            <c:if test="${tab!=4 }">
                                <c:forEach items="${testPaperQuestionViews5 }" var="question">

                                    <a href="javascript:;" class="btn btn-default btn-index pull-left
                         <c:if test="${question.is_right==0 }">right btn-success</c:if>
                        <c:if test="${question.is_right==1 }">wrong btn-danger </c:if>
                        <c:if test="${question.is_right==2 }">btn-warning </c:if>
                        <c:if test="${question.is_right==3 }">noAnswer  </c:if>
                        " data-anchor="#question${question.question_id }">${question.questions_number }</a>
                                </c:forEach>
                                <div class="clearfix mtm mbm"></div>
                                <c:forEach items="${testPaperQuestionViews0 }" var="question">

                                    <a href="javascript:;" class="btn btn-default btn-index pull-left
                         <c:if test="${question.is_right==0 }">right btn-success</c:if>
                        <c:if test="${question.is_right==1 }">wrong btn-danger </c:if>
                        <c:if test="${question.is_right==2 }">btn-warning </c:if>
                        <c:if test="${question.is_right==3 }">noAnswer  </c:if>
                        " data-anchor="#question${question.question_id }">${question.questions_number }</a>
                                </c:forEach>
                                <div class="clearfix mtm mbm"></div>
                                <c:forEach items="${testPaperQuestionViews1 }" var="question">
                                    <a href="javascript:;" class="btn btn-default btn-index pull-left
                              <c:if test="${question.is_right==0 }">right btn-success</c:if>
                        <c:if test="${question.is_right==1 }">wrong btn-danger </c:if>
                        <c:if test="${question.is_right==2 }">btn-warning </c:if>
                        <c:if test="${question.is_right==3 }">noAnswer  </c:if>
                             " data-anchor="#question${question.question_id }">${question.questions_number }</a>
                                </c:forEach>
                                <div class="clearfix mtm mbm"></div>
                                <c:forEach items="${testPaperQuestionViews2 }" var="question">
                                    <a href="javascript:;" class="btn btn-default btn-index pull-left
                              <c:if test="${question.is_right==0 }">right btn-success</c:if>
                        <c:if test="${question.is_right==1 }">wrong btn-danger </c:if>
                        <c:if test="${question.is_right==2 }">btn-warning </c:if>
                        <c:if test="${question.is_right==3 }">noAnswer  </c:if>
                            " data-anchor="#question${question.question_id }">${question.questions_number }</a>
                                </c:forEach>
                                <div class="clearfix mtm mbm"></div>
                            </c:if>
                            <c:forEach items="${testPaperQuestionViews3 }" var="question">
                                <a href="javascript:;" class="btn btn-default btn-index pull-left
                             <c:if test="${tab!=4 }">
                              <c:if test="${question.is_right==0 }">right btn-success</c:if>
                        <c:if test="${question.is_right==1 }">wrong btn-danger </c:if>
                        <c:if test="${question.is_right==2 }">btn-warning </c:if>
                        <c:if test="${question.is_right==3 }">noAnswer  </c:if>
                       </c:if>
                            " data-anchor="#question${question.question_id }">${question.questions_number }</a>
                            </c:forEach>
                            <div class="clearfix mtm mbm"></div>
                            <c:if test="${tab!=4||status==1 }">
                                <c:forEach items="${testPaperQuestionViews6 }" var="question">
                                    <c:if test="${tab!=4||question.type==3 }">
                                        <a href="javascript:;" class="btn btn-default btn-index pull-left
                             <c:if test="${tab!=4 }">
                              <c:if test="${question.is_right==0 }">right btn-success</c:if>
                        <c:if test="${question.is_right==1 }">wrong btn-danger </c:if>
                        <c:if test="${question.is_right==2 }">btn-warning </c:if>
                        <c:if test="${question.is_right==3 }">noAnswer  </c:if>
                        </c:if>
                            " data-anchor="#question${question.question_id }">${question.questions_number }</a>
                                    </c:if>
                                </c:forEach>
                                <div class="clearfix mtm mbm"></div>
                            </c:if>
                            <c:if test="${tab==3||tab==5 }">
                                <div class="testpaper-card-explain clearfix">
                                    <a href="javascript:;" class="btn btn-success btn-index"></a><small class="text-muted">正确</small>
                                    <a href="javascript:;" class="btn btn-danger btn-index"></a><small class="text-muted">错误</small>
                                    <a href="javascript:;" class="btn btn-warning btn-index"></a><small class="text-muted">待批阅</small>
                                    <a href="javascript:;" class="btn btn-default btn-index"></a><small class="text-muted">未做</small>
                                </div>
                            </c:if>
                        </div>
                        <div class="panel-footer">
                            <c:if test="${tab==1 }">
                                <button class="btn btn-success btn-block" disabled="disabled">我要交卷</button>
                            </c:if>
                            <c:if test="${tab==2 }">
                                <button class="btn btn-success btn-block" id="test-finish-btn">我要交卷</button>
                            </c:if>
                            <c:if test="${tab==4 }">
                                <button class="btn btn-success btn-block" id="finishCheck">完成批阅</button>
                            </c:if>
                            <c:if test="${tab==3||tab==5 }">
                                <div class="checkbox">
                                    <label>
                                        <input id="showWrong" type="checkbox">
                                        <span class="text-info">只看错题</span>
                                    </label>
                                </div>

                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
</div>
<div id="modal" class="modal" style="display: none;" aria-hidden="true" >
    <div class="modal-dialog  modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">暂停</h4>
            </div>
            <div class="modal-body">
                <div class="well well-lg">
                    <div class="empty">考试已暂停，请尽快回来哦~</div>
                </div>


            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-info" data-dismiss="modal">继续</button>
            </div>
        </div>
    </div>
</div>

<div id="testpaper-finished-dialog" class="modal in" aria-hidden="false" style="display: none;">
    <div class="modal-dialog modal-dialog-small">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">确认交卷</h4>
            </div>
            <div class="modal-body">
                <h4 class="text-primary">您真的要交卷吗？</h4>
            </div>
            <div class="modal-footer">
                <a href="javascript:;" class="btn btn-link" data-dismiss="modal">取消</a>
                <button class="btn btn-primary" id="testpaper-finish-btn" data-saving-text="正在交卷, 请稍等...">确认交卷</button>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function(e){
        var weditors=[];
        /*
         data-spy="scroll"是Bootstrap 滚动监听（Scrollspy）插件,自动更新导航插件,
         也可以在<body>上添加data-spy="scroll"
         data-spy="affix" 是Bootstrap 附加导航（Affix）插件,
         附加导航（Affix）插件允许某个 <div> 固定在页面的某个位置。
         */
        $('.testpaper-question-result .nav-pills li').on("click",function(){
            $(this).siblings().removeClass('active');
            $(this).addClass('active');
            var mid = $(this).find('a').attr('data');
            // console.log(mid);
            $(mid).siblings().removeClass('active');
            $(mid).addClass('active');
        });
        //完成批改
        $("#finishCheck").click(function(){
            saveAnswers = [];
            var _this= $(this);
            var flag=false;
            $('.prevent-copy').find('.form-horizontal').each(function(index,item){
                var teacher_say=$(item).find('.teacher-say');
                var defen=$(item).find('.defen');
                var score=parseInt(defen.val());
                var total=defen.data("score");
                var is_right=1;
                if(isNaN(score)){
                    alert("分数只能输入数字!");
                    flag=false;
                    return false;
                }else if(score<0){
                    alert("分数不能小于0!");
                    flag=false;
                    return false;
                }else if(score>total){
                    alert("分数不能大于题目的分数!");
                    flag=false;
                    return false;
                }
                flag=true;
                if(score==total){
                    is_right=0;
                }
                var exam_comment="";
                $questionId = $(teacher_say).data('exam_answer_id');
                if ($(teacher_say).val() != '') {
                    exam_comment+=($(teacher_say).val().replace(/[\r\n]/g,""));
                    //saveAnswers.push("questions="+$questionId+ '|' +answer);
                    saveAnswers.push('"' +$questionId+'|'+is_right+'|'+score+'"'+ ':'+'"' +exam_comment+'"');
                }else{
                    // saveAnswers.push("questions="+$questionId+ '|' +answer);
                    saveAnswers.push('"' +$questionId+'|'+is_right+'|'+score+'"'+ ':'+'"' +exam_comment+'"');
                }

            });
            var str="{";
            str+=saveAnswers;
            str+="}";
            if(flag){
                $.ajax({
                    type: 'POST',
                    url : '${pageContext.request.contextPath}/exam/check_homework.action?exam_id=${exam.id}',
                    dataType: "json",
                    contentType:'application/json;charset=UTF-8',
                    data:str,
                    success : function(response) {
                        var	right=response.right;
                        var 	grade=response.grade;
                        var	score=response.score;
                        var form=$("<form>");//定义一个form表单
                        form.attr("style","display:none");
                        form.attr("target","");
                        form.attr("method","post");
                        form.attr("action",'${pageContext.request.contextPath}/exam/check_finish.action');
                        var input1=$("<input>");
                        input1.attr("type","hidden");
                        input1.attr("name","class_id");
                        input1.attr("value",'${class_id}');
                        var input2=$("<input>");
                        input2.attr("type","hidden");
                        input2.attr("name","id");
                        input2.attr("value",'${exam.id}');
                        var input3=$("<input>");
                        input3.attr("type","hidden");
                        input3.attr("name","grade");
                        input3.attr("value",grade);
                        var input4=$("<input>");
                        input4.attr("type","hidden");
                        input4.attr("name","score");
                        input4.attr("value",right);
                        var input5=$("<input>");
                        input5.attr("type","hidden");
                        input5.attr("name","courseId");
                        input5.attr("value",'${courseView.id}');
                        var input6=$("<input>");
                        input6.attr("type","hidden");
                        input6.attr("name","source_type");
                        input6.attr("value",'${source_type}');
                        var input7=$("<input>");
                        input7.attr("type","hidden");
                        input7.attr("name","course_id");
                        input7.attr("value",'${course_id}');
                        $("body").append(form);//将表单放置在web中
                        form.append(input1);
                        form.append(input2);
                        form.append(input3);
                        form.append(input4);
                        form.append(input5);
                        form.append(input6);
                        form.append(input7);
                        form.submit();//表单提交 });


                    }
                });

            }
        });

        $("#testpaper-navbar>ul>li:first").addClass("active");
        $("tr").removeAttr("style");
        $("#test-finish-btn").click(function(){
            $("#testpaper-finished-dialog").modal('show');
            clearInterval(times);    //清除对函数的调用
        });
        $('#testpaper-finished-dialog').on('hidden.bs.modal', function () {
            clearInterval(times);
            times = setInterval(setTime, 1000);    //每隔1秒执行函数
        });

        $('.testpaper-card').on('click', '#showWrong', function(){
            $(".testpaper-question").each(function(index, val){
                var right=$(val).data('right');
                if (right != 1) {
                    $(val).toggle();
                }
            });

            $('.testpaper-question-block').each(function(){
                var isHidden = true;
                $(this).find('div.testpaper-question').each(function(){
                    var right=$(this).data('right');
                    if (right== 1) {
                        isHidden = false;
                    }
                });

                if (isHidden){
                    $(this).toggle();
                }
            });

            var testpaperBodyHeight = $('.testpaper-body').height();
            var testpaperCardHeight = $('.testpaper-card').height();
            if (testpaperCardHeight > testpaperBodyHeight) {
                $('.testpaper-body').css('min-height', testpaperCardHeight);
            }
        });

//提交试卷
        $("#testpaper-finish-btn").click(function(){
            var str= saveQuestion();
            var url='${pageContext.request.contextPath}/exam/finish_homework.action?exam_id=${exam.id}';
            finish(str,url);
        });
        //问答题点击出现输入框
        $(".essay-textarea").click(function(){
            var id=$(this).data('id');
            if($("#essay-textarea"+id).children("div").length>=2){
                //if($("#cke_essay-textarea"+id).size()>0){
                //$("#essay-textarea"+id).css("visibility","hidden");
                //$("#essay-textarea"+id).hide();
                $("#essay-textarea"+id).show();
                //$("#cke_essay-textarea"+id).show();
                $("#essay-textarea-pack-up"+id).show();
                $("#input_answer"+id).hide();
            }else{
                /*
                CKEDITOR.replace("essay-textarea"+id, {
                    skin : "moono-lisa",
                    height : '200px',
                    margin : "0,0,0,0",
                    resize_enabled : false,
                    toolbar :
                            'Question'
                });
                */
                var weditors_len = weditors.length;
                var E = window.wangEditor;
                weditors[weditors_len] = new E("#essay-textarea"+id);
                weditors[weditors_len].customConfig.menus = [
                    'head',  // 标题
                    'bold',  // 粗体
                    'italic',  // 斜体
                    'underline',  // 下划线
                    'foreColor',  // 文字颜色
                    'backColor',  // 背景颜色
                    'undo',  // 撤销
                    'redo'  // 重复
                ];
                weditors[weditors_len].customConfig.pasteFilterStyle = false;
                //保存图片到服务器
                weditors[weditors_len].customConfig.uploadImgServer = "${pageContext.request.contextPath}/upload_file/upload_resource.action?source_id=${courseView.id}&source_type=0";
                //限制图片大小
                weditors[weditors_len].customConfig.uploadImgMaxSize = 3*1024*1024;
                //图片上传上限
                weditors[weditors_len].customConfig.uploadImgMaxLength = 1;
                //隐藏"网络图片"选项
                weditors[weditors_len].customConfig.showLinkImg = false;
                weditors[weditors_len].customConfig.onchange=function(html){
                    $("#input_answer"+id).val(html);
                }
                weditors[weditors_len].create();
                $("#essay-textarea-pack-up"+id).show();
                $("#essay-textarea"+id).show();
                $("#input_answer"+id).hide();
            }

        });
        //问答题点击收起
        $(".essay-textarea-pack-up").click(function(){
            var id=$(this).data('id');
            $("#essay-textarea"+id).css("visibility","visible");
            //$("#essay-textarea"+id).show();
            $("#essay-textarea"+id).hide();
            //$("#cke_essay-textarea"+id).hide();
            $("#essay-textarea-pack-up"+id).hide();
            $("#input_answer"+id).show();
        });

        //计时器
        setTime();
        times = setInterval(setTime, 1000);
        var $body = $(document.body);
        $body.scrollspy({
            target: '#testpaper-navbar',
            offset: 120
        });
        $(window).on('load', function () {
            $body.scrollspy('refresh');
        });
        $('.testpaper-card').on('click', '.btn-index', function() {
            var position = $($(this).data('anchor')).offset();
            $(document).scrollTop(position.top - 55);
        });
    });
    var timeIndex =parseInt('${exam.exam_hour }');
    function setTime(){

        var hour = parseInt(timeIndex / 3600);    // 计算时
        var minutes = parseInt((timeIndex % 3600) / 60);    // 计算分
        var seconds = parseInt(timeIndex % 60);    // 计算秒
        hour = hour < 10 ? "0" + hour : hour;
        minutes = minutes < 10 ? "0" + minutes : minutes;
        seconds = seconds < 10 ? "0" + seconds : seconds;
        $("#time_show").html(hour + ":" + minutes + ":" + seconds);

    }
    $("#do_late").click(function(){
        var str= saveQuestion();
        var time=parseInt('${testPaper.timeless }')*60-timeIndex;
        var url='${pageContext.request.contextPath}/exam/do_late.action?exam_id=${exam.id}&time='+time;
        finish(str, url);
    });
    function saveQuestion(){
        saveAnswers = [];
        $('.prevent-copy').find('.testpaper-question').each(function(index,item){
            $question = $(item);
            $choicesInputs = $question.find('.testpaper-question-choice-inputs');
            $choicesInputs.each(function(index1,item1){
                var answer="";
                $(item1).find('label > input').each(function(index2,item2){
                    if ($(item2).prop('checked')) {
                        $questionId = $question.data('questionId');
                        if(answer!=""){
                            answer+=",";
                        }
                        answer+=($(item2).val());

                    } else {

                        $questionId = $question.data('questionId');

                    }
                });
                // saveAnswers.push("questions="+$questionId+ '|' +answer);
                saveAnswers.push('"' +$questionId+'"'+ ':'+'"' +answer+'"');
            });
            $essayInputs = $question.find('.testpaper-question-essay-input-short');
            var answer="";
            //for ( instance in CKEDITOR.instances )
            //    CKEDITOR.instances[instance].updateElement();
            $essayInputs.each(function(index1,item1){
                $questionId = $question.data('questionId');
                if ($(item1).val() != '') {
                    answer+=($(item1).val().replace(/[\r\n]/g,""));
                    //saveAnswers.push("questions="+$questionId+ '|' +answer);
                    saveAnswers.push('"' +$questionId+'"'+ ':'+'"' +answer+'"');
                }else{
                    // saveAnswers.push("questions="+$questionId+ '|' +answer);
                    saveAnswers.push('"' +$questionId+'"'+ ':'+'"' +answer+'"');
                }
            });

            $fillInputs = $question.find('.testpaper-question-fill-inputs');
            $fillInputs.each(function(index1,item1){
                var answer="";
                $(item1).find('input').each(function(index2,item2){
                    if(answer!=""){
                        answer+=",";
                    }
                    if ($(item2).val() != '') {
                        answer+=($(item2).val());
                    }else{
                        answer+=" ";
                    }
                    $questionId = $question.data('questionId');

                });
                // saveAnswers.push("questions="+$questionId+ '|' +answer);
                saveAnswers.push('"' +$questionId+'"'+ ':'+'"' +answer+'"');
            });

        });

        var str="{";
        str+=saveAnswers;
        str+="}";
        return str;
    }
    function finish(str,url){
        $.ajax({
            type: 'POST',
            url : url,
            dataType: "json",
            contentType:'application/json;charset=UTF-8',
            data:str,
            success : function(response) {
                location.replace('${pageContext.request.contextPath}/user/home.action');
            }
        });

    }
</script>
