<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<link href="${pageContext.request.contextPath}/frontstage/css/nouislider.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/nouislider.js"></script>
<link href="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.js"></script>

<div class="cn-wrap">

    <div id="content-container" class="container" style="margin-top:20px;">
        <div class="cn-section testpaper-heading">
            <div class="testpaper-titlebar clearfix">
                <h1 class="testpaper-title">${testPaper.name } <br><small class="text-sm"></small></h1>
                <div class="testpaper-status">
                    <c:if test="${tab==1 }">
                        <div class="label label-success">试卷预览中</div>
                    </c:if>
                    <c:if test="${tab==2 }">
                        <div class="label label-success">答题中</div>
                    </c:if>
                </div>
            </div>

            <div class="testpaper-description"><p>${testPaper.remarks }</p></div>

            <div class="testpaper-metas">
                共 ${testPaper.total_number } 题，总分 ${testPaper.total_score } 分，请在 ${testPaper.timeless } 分钟内作答。
            </div>

            <div id="testpaper-navbar" class="testpaper-navbar affix-top" data-spy="affix" data-offset-top="200">
                <ul class="nav nav-pills clearfix">
                    <c:if test="${testPaperQuestionViews5.size()>0 }"><li class=""><a href="#testpaper-questions-choice1">单选题</a></li></c:if>
                    <c:if test="${testPaperQuestionViews0.size()>0 }"><li class=""><a href="#testpaper-questions-choice2">多择题</a></li></c:if>
                    <c:if test="${testPaperQuestionViews1.size()>0 }"><li class=""><a href="#testpaper-questions-fill">填空题</a></li></c:if>
                    <c:if test="${testPaperQuestionViews2.size()>0 }"><li class=""><a href="#testpaper-questions-determine">判断题</a></li></c:if>
                    <c:if test="${testPaperQuestionViews3.size()>0 }"><li class=""><a href="#testpaper-questions-essay">问答题</a></li></c:if>
                    <c:if test="${testPaperQuestionViews6.size()>0 }"><li class=""><a href="#testpaper-questions-material">材料题</a></li></c:if>
                </ul>
            </div>

        </div>

        <div class="row">
            <div class="col-md-9 prevent-copy">
                <div class="testpaper-body">
                    <form id="teacherCheckForm" autocomplete="off" novalidate="novalidate" >
                        <c:if test="${testPaperQuestionViews5.size()>0 }">
                            <div class="panel panel-default testpaper-question-block" id="testpaper-questions-choice1">
                                <div class="panel-heading"><strong class="">单选题</strong>
                                    <small class="text-muted">共${testPaperQuestionViews5.size() }题，共${total_score5 }分</small>
                                </div>
                                <div class="panel-body">
                                    <c:forEach items="${testPaperQuestionViews5 }" var="question">
                                        <div class="testpaper-question testpaper-question-choice " id="question${question.question_id }" data-question-id="${question.id }">
                                            <div class="testpaper-question-body">
                                                <div class="testpaper-question-stem-wrap clearfix">
                                                    <div class="testpaper-question-seq-wrap">
                                                        <div class="testpaper-question-seq">${question.questions_number }</div>
                                                        <div class="testpaper-question-score">${question.questions_score }分</div>
                                                    </div>
                                                    <div class="testpaper-question-stem"><p>${question.stem }</p><br></div>
                                                </div>
                                                <ul class="testpaper-question-choices">
                                                    <li class=""><span class="testpaper-question-choice-index">A.</span> <p>${question.option_a }</p>
                                                    </li>
                                                    <li class=""><span class="testpaper-question-choice-index">B.</span> <p>${question.option_b }</p>
                                                    </li>
                                                    <c:if test="${!empty question.option_c }">
                                                        <li class=""><span class="testpaper-question-choice-index">C.</span> <p>${question.option_c }</p>
                                                        </li>
                                                    </c:if>
                                                    <c:if test="${!empty question.option_d }">
                                                        <li class=""><span class="testpaper-question-choice-index">D.</span> <p>${question.option_d }</p>
                                                        </li>
                                                    </c:if>
                                                    <c:if test="${!empty question.option_e }">
                                                        <li class=""><span class="testpaper-question-choice-index">E.</span> <p>${question.option_e }</p>
                                                        </li>
                                                    </c:if>
                                                </ul>
                                            </div>
                                            <div class="testpaper-question-footer clearfix">
                                                <div class="testpaper-question-choice-inputs">
                                                    <label class="radio-inline ">
                                                        <input type="radio" name="question${question.question_id }" <c:if test="${fn:contains(question.answer, 'A')}"> checked="checked"</c:if> value="A" >
                                                        A
                                                    </label>
                                                    <label class="radio-inline ">
                                                        <input type="radio" name="question${question.question_id }" <c:if test="${fn:contains(question.answer, 'B')}"> checked="checked"</c:if> value="B">
                                                        B
                                                    </label>
                                                    <c:if test="${!empty question.option_c }">
                                                        <label class="radio-inline ">
                                                            <input type="radio" name="question${question.question_id }" <c:if test="${fn:contains(question.answer, 'C')}"> checked="checked"</c:if> value="C">
                                                            C
                                                        </label>
                                                    </c:if>
                                                    <c:if test="${!empty question.option_d }">
                                                        <label class="radio-inline ">
                                                            <input type="radio" name="question${question.question_id }" <c:if test="${fn:contains(question.answer, 'D')}"> checked="checked"</c:if> value="D">
                                                            D
                                                        </label>
                                                    </c:if>
                                                    <c:if test="${!empty question.option_e }">
                                                        <label class="radio-inline ">
                                                            <input type="radio" name="question${question.question_id }" <c:if test="${fn:contains(question.answer, 'E')}"> checked="checked"</c:if> value="E">
                                                            E
                                                        </label>
                                                    </c:if>
                                                </div>
                                                <div class="testpaper-question-actions pull-right"></div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${testPaperQuestionViews0.size()>0 }">
                            <div class="panel panel-default testpaper-question-block" id="testpaper-questions-choice2">
                                <div  class="panel-heading"><strong class="">多选题</strong>
                                    <small class="text-muted">共${testPaperQuestionViews0.size() }题，共${total_score0 }分</small>
                                </div>
                                <div class="panel-body">
                                    <c:forEach items="${testPaperQuestionViews0 }" var="question">
                                        <div class="testpaper-question testpaper-question-choice " id="question${question.question_id }" data-question-id="${question.id }">
                                            <div class="testpaper-question-body">
                                                <div class="testpaper-question-stem-wrap clearfix">
                                                    <div class="testpaper-question-seq-wrap">
                                                        <div class="testpaper-question-seq">${question.questions_number }</div>
                                                        <div class="testpaper-question-score">${question.questions_score }分</div>
                                                    </div>
                                                    <div class="testpaper-question-stem"><p>${question.stem }</p><br></div>
                                                </div>
                                                <ul class="testpaper-question-choices">
                                                    <li class=""><span class="testpaper-question-choice-index">A.</span> <p>${question.option_a }</p>
                                                    </li>
                                                    <li class=""><span class="testpaper-question-choice-index">B.</span> <p>${question.option_b }</p>
                                                    </li>
                                                    <c:if test="${!empty question.option_c }">
                                                        <li class=""><span class="testpaper-question-choice-index">C.</span> <p>${question.option_c }</p>
                                                        </li>
                                                    </c:if>
                                                    <c:if test="${!empty question.option_d }">
                                                        <li class=""><span class="testpaper-question-choice-index">D.</span> <p>${question.option_d }</p>
                                                        </li>
                                                    </c:if>
                                                    <c:if test="${!empty question.option_e }">
                                                        <li class=""><span class="testpaper-question-choice-index">E.</span> <p>${question.option_e }</p>
                                                        </li>
                                                    </c:if>
                                                </ul>
                                            </div>
                                            <div class="testpaper-question-footer clearfix">
                                                <div class="testpaper-question-choice-inputs">
                                                    <label class="radio-inline ">
                                                        <input type="checkbox" name="question${question.question_id }" <c:if test="${fn:contains(question.answer, 'A')}"> checked="checked"</c:if> value="A" >
                                                        A
                                                    </label>
                                                    <label class="radio-inline ">
                                                        <input type="checkbox" name="question${question.question_id }" <c:if test="${fn:contains(question.answer, 'B')}"> checked="checked"</c:if> value="B">
                                                        B
                                                    </label>
                                                    <c:if test="${!empty question.option_c }">
                                                        <label class="radio-inline ">
                                                            <input type="checkbox" name="question${question.question_id }" <c:if test="${fn:contains(question.answer, 'C')}"> checked="checked"</c:if> value="C">
                                                            C
                                                        </label>
                                                    </c:if>
                                                    <c:if test="${!empty question.option_d }">
                                                        <label class="radio-inline ">
                                                            <input type="checkbox" name="question${question.question_id }" <c:if test="${fn:contains(question.answer, 'D')}"> checked="checked"</c:if> value="D">
                                                            D
                                                        </label>
                                                    </c:if>
                                                    <c:if test="${!empty question.option_e }">
                                                        <label class="radio-inline ">
                                                            <input type="checkbox" name="question${question.question_id }" <c:if test="${fn:contains(question.answer, 'E')}"> checked="checked"</c:if> value="E">
                                                            E
                                                        </label>
                                                    </c:if>
                                                </div>
                                                <div class="testpaper-question-actions pull-right"></div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${testPaperQuestionViews1.size()>0 }">
                            <div class="panel panel-default testpaper-question-block" id="testpaper-questions-fill">
                                <div  class="panel-heading"><strong class="">填空题</strong>
                                    <small class="text-muted">共${testPaperQuestionViews1.size() }题，共${total_score1 }分</small>
                                </div>
                                <div class="panel-body">
                                    <c:forEach items="${testPaperQuestionViews1 }" var="question">
                                        <div class="testpaper-question testpaper-question-fill " id="question${question.question_id }" data-question-id="${question.id }">
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
                                                    <c:forEach items="${fn:split(question.stem, '______')}" var="s" varStatus="status" >
                                                        <c:if test="${!status.last}">
                                                            <c:set var="answer" value="${fn:split(question.answer, ',')}" />
                                                            <input class="form-control " type="text" name="question${question.question_id }" placeholder="填空(${status.count })答案，请填在这里" value="${answer[status.index]}">
                                                        </c:if>
                                                    </c:forEach>
                                                </div>
                                                <div class="testpaper-question-actions pull-right"></div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${testPaperQuestionViews2.size()>0 }">
                            <div class="panel panel-default testpaper-question-block" id="testpaper-questions-determine">
                                <div  class="panel-heading"><strong class="">判断题</strong>
                                    <small class="text-muted">共${testPaperQuestionViews2.size() }题，共${total_score2 }分</small>
                                </div>
                                <div class="panel-body">
                                    <c:forEach items="${testPaperQuestionViews2 }" var="question">
                                        <div class="testpaper-question testpaper-question-fill " id="question${question.question_id }" data-question-id="${question.id }">
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
                                                <div class="testpaper-question-choice-inputs">
                                                    <label class="radio-inline "><input type="radio" name="question${question.question_id }" value="1" <c:if test="${question.answer==1}"> checked="checked"</c:if>> 正确</label>
                                                    <label class="radio-inline "><input type="radio" name="question${question.question_id }" value="0"<c:if test="${question.answer==0}"> checked="checked"</c:if>>错误</label>
                                                </div>
                                                <div class="testpaper-question-actions pull-right"></div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${testPaperQuestionViews3.size()>0 }">
                            <div class="panel panel-default testpaper-question-block" id="testpaper-questions-essay">
                                <div  class="panel-heading"><strong class="">问答题</strong>
                                    <small class="text-muted">共${testPaperQuestionViews3.size() }题，共${total_score3 }分</small>
                                </div>
                                <div class="panel-body">
                                    <c:forEach items="${testPaperQuestionViews3 }" var="question">
                                        <div class="testpaper-question testpaper-question-essay " id="question${question.question_id }" data-question-id="${question.id }">
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
                                                    <textarea class="form-control testpaper-question-essay-input-short essay-textarea"  id="essay-textarea${question.id }" rows="1" data-id="${question.id }">${question.answer}</textarea>
                                                    <a class="btn btn-link btn-muted btn-sm essay-textarea-pack-up" style="display: none" data-id="${question.id }" id="essay-textarea-pack-up${question.id }"><span class="glyphicon glyphicon-chevron-up text-muted"></span> 收起</a>
                                                </div>
                                                <div class="testpaper-question-actions pull-right"></div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${testPaperQuestionViews6.size()>0 }">
                            <div class="panel panel-default testpaper-question-block" id="testpaper-questions-material">
                                <div class="panel-heading"><strong class="">材料题</strong>
                                    <small class="text-muted">共${testPaperQuestionViews6.size() }题，共${total_score6 }分</small>
                                </div>
                                <div class="panel-body">
                                    <div class="material">
                                        <c:forEach items="${testPaperQuestionViews4 }" var="q">
                                            <div class="well testpaper-question-stem-material"><p>${q.stem }</p> </div>
                                            <c:forEach items="${testPaperQuestionViews6 }" var="question">
                                                <c:if test="${question.parent_question_id==q.question_id }">
                                                    <c:if test="${question.type==5}">
                                                        <div class="testpaper-question testpaper-question-choice " id="question${question.question_id }" data-question-id="${question.id }">
                                                            <div class="testpaper-question-body">
                                                                <div class="testpaper-question-stem-wrap clearfix">
                                                                    <div class="testpaper-question-seq-wrap">
                                                                        <div class="testpaper-question-seq">${question.questions_number }</div>
                                                                        <div class="testpaper-question-score">${question.questions_score }分</div>
                                                                    </div>
                                                                    <div class="testpaper-question-stem"><p>${question.stem }</p><br></div>
                                                                </div>
                                                                <ul class="testpaper-question-choices">
                                                                    <li class="">
                                                                        <span class="testpaper-question-choice-index">A.</span>
                                                                        <p>${question.option_a }</p>
                                                                    </li>
                                                                    <li class="">
                                                                        <span class="testpaper-question-choice-index">B.</span>
                                                                        <p>${question.option_b }</p>
                                                                    </li>
                                                                    <c:if test="${!empty question.option_c }">
                                                                        <li class="">
                                                                            <span class="testpaper-question-choice-index">C.</span>
                                                                            <p>${question.option_c }</p>
                                                                        </li>
                                                                    </c:if>
                                                                    <c:if test="${!empty question.option_d }">
                                                                        <li class="">
                                                                            <span class="testpaper-question-choice-index">D.</span>
                                                                            <p>${question.option_d }</p>
                                                                        </li>
                                                                    </c:if>
                                                                    <c:if test="${!empty question.option_e }">
                                                                        <li class="">
                                                                            <span class="testpaper-question-choice-index">E.</span>
                                                                            <p>${question.option_e }</p>
                                                                        </li>
                                                                    </c:if>
                                                                </ul>
                                                            </div>
                                                            <div class="testpaper-question-footer clearfix">
                                                                <div class="testpaper-question-choice-inputs">
                                                                    <label class="radio-inline ">
                                                                        <input type="radio" name="question${question.id }" <c:if test="${fn:contains(question.answer, 'A')}"> checked="checked"</c:if>value="A">
                                                                        A
                                                                    </label>
                                                                    <label class="radio-inline ">
                                                                        <input type="radio" name="question${question.id }" <c:if test="${fn:contains(question.answer, 'B')}"> checked="checked"</c:if>value="B">
                                                                        B
                                                                    </label>
                                                                    <c:if test="${!empty question.option_c }">
                                                                        <label class="radio-inline ">
                                                                            <input type="radio" name="question${question.id }" <c:if test="${fn:contains(question.answer, 'C')}"> checked="checked"</c:if>value="C">
                                                                            C
                                                                        </label>
                                                                    </c:if>
                                                                    <c:if test="${!empty question.option_d }">
                                                                        <label class="radio-inline ">
                                                                            <input type="radio" name="question${question.id }" <c:if test="${fn:contains(question.answer, 'D')}"> checked="checked"</c:if>value="D">
                                                                            D
                                                                        </label>
                                                                    </c:if>
                                                                    <c:if test="${!empty question.option_e }">
                                                                        <label class="radio-inline ">
                                                                            <input type="radio" name="question${question.id }" <c:if test="${fn:contains(question.answer, 'E')}"> checked="checked"</c:if>value="E">
                                                                            E
                                                                        </label>
                                                                    </c:if>
                                                                </div>
                                                                <div class="testpaper-question-actions pull-right"></div>
                                                            </div>
                                                        </div>
                                                    </c:if>
                                                    <c:if test="${question.type==0}">
                                                        <div class="testpaper-question testpaper-question-choice " id="question${question.question_id }" data-question-id="${question.id }">
                                                            <div class="testpaper-question-body">
                                                                <div class="testpaper-question-stem-wrap clearfix">
                                                                    <div class="testpaper-question-seq-wrap">
                                                                        <div class="testpaper-question-seq">${question.questions_number }</div>
                                                                        <div class="testpaper-question-score">${question.questions_score }分</div>
                                                                    </div>
                                                                    <div class="testpaper-question-stem"><p>${question.stem }</p><br></div>
                                                                </div>
                                                                <ul class="testpaper-question-choices">
                                                                    <li class="">
                                                                        <span class="testpaper-question-choice-index">A.</span>
                                                                        <p>${question.option_a }</p>
                                                                    </li>
                                                                    <li class="">
                                                                        <span class="testpaper-question-choice-index">B.</span>
                                                                        <p>${question.option_b }</p>
                                                                    </li>
                                                                    <c:if test="${!empty question.option_c }">
                                                                        <li class="">
                                                                            <span class="testpaper-question-choice-index">C.</span>
                                                                            <p>${question.option_c }</p>
                                                                        </li>
                                                                    </c:if>
                                                                    <c:if test="${!empty question.option_d }">
                                                                        <li class="">
                                                                            <span class="testpaper-question-choice-index">D.</span>
                                                                            <p>${question.option_d }</p>
                                                                        </li>
                                                                    </c:if>
                                                                    <c:if test="${!empty question.option_e }">
                                                                        <li class="">
                                                                            <span class="testpaper-question-choice-index">E.</span>
                                                                            <p>${question.option_e }</p>
                                                                        </li>
                                                                    </c:if>
                                                                </ul>
                                                            </div>
                                                            <div class="testpaper-question-footer clearfix">
                                                                <div class="testpaper-question-choice-inputs">
                                                                    <label class="radio-inline ">
                                                                        <input type="checkbox" name="question${question.id }" <c:if test="${fn:contains(question.answer, 'A')}"> checked="checked"</c:if>value="A">
                                                                        A
                                                                    </label>
                                                                    <label class="radio-inline ">
                                                                        <input type="checkbox" name="question${question.id }" <c:if test="${fn:contains(question.answer, 'B')}"> checked="checked"</c:if>value="B">
                                                                        B
                                                                    </label>
                                                                    <c:if test="${!empty question.option_c }">
                                                                        <label class="radio-inline ">
                                                                            <input type="checkbox" name="question${question.id }" <c:if test="${fn:contains(question.answer, 'C')}"> checked="checked"</c:if>value="C">
                                                                            C
                                                                        </label>
                                                                    </c:if>
                                                                    <c:if test="${!empty question.option_d }">
                                                                        <label class="radio-inline ">
                                                                            <input type="checkbox" name="question${question.id }" <c:if test="${fn:contains(question.answer, 'D')}"> checked="checked"</c:if>value="D">
                                                                            D
                                                                        </label>
                                                                    </c:if>
                                                                    <c:if test="${!empty question.option_e }">
                                                                        <label class="radio-inline ">
                                                                            <input type="checkbox" name="question${question.id }" <c:if test="${fn:contains(question.answer, 'E')}"> checked="checked"</c:if>value="E">
                                                                            E
                                                                        </label>
                                                                    </c:if>
                                                                </div>
                                                                <div class="testpaper-question-actions pull-right"></div>
                                                            </div>
                                                        </div>
                                                    </c:if>
                                                    <c:if test="${question.type==1}">
                                                        <div class="testpaper-question testpaper-question-fill " id="question${question.question_id }" data-question-id="${question.id }">
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
                                                                    <c:forEach items="${fn:split(question.stem, '______')}" var="s" varStatus="status" >
                                                                        <c:if test="${!status.last}">
                                                                            <c:set var="answer" value="${fn:split(question.answer, ',')}" />
                                                                            <input class="form-control " type="text" name="question${question.question_id }" placeholder="填空(${status.count })答案，请填在这里" value="${answer[status.index]}">
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </div>
                                                                <div class="testpaper-question-actions pull-right"></div>
                                                            </div>
                                                        </div>
                                                    </c:if>
                                                    <c:if test="${question.type==2}">
                                                        <div class="testpaper-question testpaper-question-fill " id="question${question.question_id }" data-question-id="${question.id }">
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
                                                                <div class="testpaper-question-choice-inputs">
                                                                    <label class="radio-inline "><input type="radio" name="question${question.question_id }" value="1" <c:if test="${question.answer==1}"> checked="checked"</c:if>> 正确</label>
                                                                    <label class="radio-inline "><input type="radio" name="question${question.question_id }" value="0" <c:if test="${question.answer==0}"> checked="checked"</c:if>>错误</label>
                                                                </div>
                                                                <div class="testpaper-question-actions pull-right"></div>
                                                            </div>
                                                        </div>
                                                    </c:if>
                                                    <c:if test="${question.type==3}">
                                                        <div class="testpaper-question testpaper-question-essay " id="question${question.question_id }" data-question-id="${question.id }">
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
                                                                    <textarea class="form-control testpaper-question-essay-input-short essay-textarea"  id="essay-textarea${question.id }" rows="1" data-id="${question.id }">${question.answer}</textarea>
                                                                    <a class="btn btn-link btn-muted btn-sm essay-textarea-pack-up" style="display: none" data-id="${question.id }" id="essay-textarea-pack-up${question.id }"><span class="glyphicon glyphicon-chevron-up text-muted"></span> 收起</a>
                                                                </div>
                                                                <div class="testpaper-question-actions pull-right"></div>
                                                            </div>
                                                        </div>
                                                    </c:if>
                                                </c:if>
                                            </c:forEach>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </form>
                </div>
            </div>

            <div class="col-md-3">
                <div class="testpaper-card affix-top" data-spy="affix" data-offset-top="200" data-offset-bottom="200">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <c:if test="${tab==2 }">
                                <span class="preview testpaper-card-timer" id="time_show"></span>
                                <button class="btn btn-sm btn-default pull-right" id="do_late" <c:if test="${isTeacher==1&&isPreview==1 }">disabled="disabled"</c:if>>下次再做</button>
                                <button id="pause" class="btn btn-sm btn-default pull-right" <c:if test="${isTeacher==1&&isPreview==1 }">disabled="disabled"</c:if>>暂停</button>
                            </c:if>
                        </div>
                        <div class="panel-body">
                            <c:forEach items="${testPaperQuestionViews5 }" var="question">
                                <a href="javascript:;" class="btn btn-default btn-index pull-left " data-anchor="#question${question.question_id }">${question.questions_number }</a>
                            </c:forEach>
                            <div class="clearfix mtm mbm"></div>
                            <c:forEach items="${testPaperQuestionViews0 }" var="question">
                                <a href="javascript:;" class="btn btn-default btn-index pull-left " data-anchor="#question${question.question_id }">${question.questions_number }</a>
                            </c:forEach>
                            <div class="clearfix mtm mbm"></div>
                            <c:forEach items="${testPaperQuestionViews1 }" var="question">
                                <a href="javascript:;" class="btn btn-default btn-index pull-left " data-anchor="#question${question.question_id }">${question.questions_number }</a>
                            </c:forEach>
                            <div class="clearfix mtm mbm"></div>
                            <c:forEach items="${testPaperQuestionViews2 }" var="question">
                                <a href="javascript:;" class="btn btn-default btn-index pull-left " data-anchor="#question${question.question_id }">${question.questions_number }</a>
                            </c:forEach>
                            <div class="clearfix mtm mbm"></div>
                            <c:forEach items="${testPaperQuestionViews3 }" var="question">
                                <a href="javascript:;" class="btn btn-default btn-index pull-left " data-anchor="#question${question.question_id }">${question.questions_number }</a>
                            </c:forEach>
                            <div class="clearfix mtm mbm"></div>
                            <c:forEach items="${testPaperQuestionViews6 }" var="question">
                                <a href="javascript:;" class="btn btn-default btn-index pull-left " data-anchor="#question${question.question_id }">${question.questions_number }</a>
                            </c:forEach>
                            <div class="clearfix mtm mbm"></div>

                        </div>
                        <div class="panel-footer">
                            <c:if test="${tab==1 }">
                                <button class="btn btn-success btn-block" disabled="disabled">我要交卷</button>
                            </c:if>
                            <c:if test="${tab==2 }">
                                <button class="btn btn-success btn-block" id="test-finish-btn" <c:if test="${isTeacher==1&&isPreview==1 }">disabled="disabled"</c:if>>我要交卷</button>
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
                    <div class="empty">考试已暂停，请尽快回来哦~
                    </div>
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

        /*
        data-spy="scroll"是Bootstrap 滚动监听（Scrollspy）插件,自动更新导航插件,
        也可以在<body>上添加data-spy="scroll"
        data-spy="affix" 是Bootstrap 附加导航（Affix）插件,
        附加导航（Affix）插件允许某个 <div> 固定在页面的某个位置。
       */
        $("#testpaper-navbar>ul>li:first").addClass("active");

        $("#test-finish-btn").click(function(){
            $("#testpaper-finished-dialog").modal('show');
            clearInterval(times);    //清除对函数的调用
        });
        $('#testpaper-finished-dialog').on('hidden.bs.modal', function () {
            clearInterval(times);
            times = setInterval(setTime, 1000);    //每隔1秒执行函数
        });
//提交试卷
        $("#testpaper-finish-btn").click(function(){
            var html=$(this).data('savingText');
            $(this).html(html);
            clearInterval(times);
            var time=parseInt('${testPaper.timeless }')*60-timeIndex;
            var str= saveQuestion();
            var url='${pageContext.request.contextPath}/exam/finish_homework.action?exam_id=${exam.id}&time='+time;
            var href=location.href;
            href=href.replace(location.hash,"");
            finish(str,url,href);
        });
        //做过的题直接显示编辑器
        $(".essay-textarea").each(function(){
            var id=$(this).data('id');
            if(!$(this).html()==""){
                var ck= CKEDITOR.replace("essay-textarea"+id, {
                    skin : "moono-lisa",
                    height : '200px',
                    margin : "0,0,0,0",
                    resize_enabled : false,
                    toolbar :
                        'Question'
                });
                ck.setData($(this).text());
                $(this).html("");
                $("#essay-textarea-pack-up"+id).show();
            }
        });
        //问答题点击出现输入框
        $(".essay-textarea").click(function(){
            var id=$(this).data('id');
            if($("#cke_essay-textarea"+id).size()>0){
                $("#essay-textarea"+id).css("visibility","hidden");
                $("#essay-textarea"+id).hide();
                $("#cke_essay-textarea"+id).show();
                $("#essay-textarea-pack-up"+id).show();
            }else{
                CKEDITOR.replace("essay-textarea"+id, {
                    skin : "moono-lisa",
                    height : '200px',
                    margin : "0,0,0,0",
                    resize_enabled : false,
                    toolbar :
                        'Question'
                });
                $("#essay-textarea-pack-up"+id).show();
            }

        });
        //问答题点击收起
        $(".essay-textarea-pack-up").click(function(){
            var id=$(this).data('id');
            $("#essay-textarea"+id).css("visibility","visible");
            $("#essay-textarea"+id).show();
            $("#cke_essay-textarea"+id).hide();
            $("#essay-textarea-pack-up"+id).hide();

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
    var timeIndex1=('${time}')*60;
    var timeIndex =timeIndex1;


    $("#pause").click(function(){
        clearInterval(times);    //清除对函数的调用
        $('#modal').modal('show');
    });
    $('#modal').on('hidden.bs.modal', function () {
        clearInterval(times);
        times = setInterval(setTime, 1000);    //每隔1秒执行函数
    });
    function setTime(){
        var tab='${tab}';
        if(tab==1){
            $("#time_show").html("");
            return false;
        }
        if(timeIndex==0){
            return false;
        }
        if(timeIndex==0){
            $("#time_show").html("");
            clearInterval(times);
            $("#testpaper-finished-dialog").modal('show');
            $("#testpaper-finish-btn").click();

        }

        var hour = parseInt(timeIndex / 3600);    // 计算时
        var minutes = parseInt((timeIndex % 3600) / 60);    // 计算分
        var seconds = parseInt(timeIndex % 60);    // 计算秒
        hour = hour < 10 ? "0" + hour : hour;
        minutes = minutes < 10 ? "0" + minutes : minutes;
        seconds = seconds < 10 ? "0" + seconds : seconds;
        $("#time_show").html(hour + ":" + minutes + ":" + seconds);
        timeIndex--;

    }
    $("#do_late").click(function(){
        clearInterval(times);
        var str= saveQuestion();
        var time=parseInt('${testPaper.timeless }')*60-timeIndex;
        var url='${pageContext.request.contextPath}/exam/do_late.action?exam_id=${exam.id}&time='+time;
        var back="to_my_exam.action?stamp=2&state=27";
        finish(str, url,back);
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
            for ( instance in CKEDITOR.instances )
                CKEDITOR.instances[instance].updateElement();
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
    function finish(str,url,back){
        $.ajax({
            type: 'POST',
            url : url,
            dataType: "json",
            contentType:'application/json;charset=UTF-8',
            data:str,
            success : function(response) {

                location.replace(back);
            }
        });

    }
</script>

