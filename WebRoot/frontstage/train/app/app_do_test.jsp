<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<head>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
    <link href="${pageContext.request.contextPath}/frontstage/css/bootstrap/bootstrap.css" rel="stylesheet" />

    <link rel="stylesheet" media="screen" href="${pageContext.request.contextPath}/frontstage/css/bootstrap/font-awesome.min.css" />
    <link rel="stylesheet" media="screen" href="${pageContext.request.contextPath}/frontstage/css/bootstrap/es-icon.css" />

    <link href="${pageContext.request.contextPath}/frontstage/css/bootstrap/main.css" rel="stylesheet" />

    <script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/jquery-1.11.0.min.js"></script>

    <%--boostrap插件--%>
    <script src="${pageContext.request.contextPath}/frontstage/js/bootstrap/bootstrap.min.js"></script>

    <link rel="stylesheet"  href="${pageContext.request.contextPath}/frontstage/css/bootstrapValidator.css"  type="text/css"/>
    <script src="${pageContext.request.contextPath}/frontstage/js/bootstrapValidator.js"></script>

    <link href="${pageContext.request.contextPath}/frontstage/css/nouislider.css" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/nouislider.js"></script>

    <script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/wangEditor/wangEditor.min.js"></script>
</head>

<body style="background-color: #fff;">

<div class="cn-wrap" >

    <div id="content-container" class="container" >

        <div class="cn-section testpaper-heading row" style="position: fixed;z-index: 999;width: 100%;padding: 10px;">
            <div class="testpaper-titlebar clearfix no-border col-md-12" style="width: 100%;padding-bottom: 10px;">
                <div style="font-size: 18px;">
                    <div  class="pull-left">${testPaper.name } </div>

                    <c:if test="${tab==2 }">
                        <div class="preview testpaper-card-timer pull-right" id="time_show"></div>

                    </c:if>

                </div>
                <br/>

                <div class="clearfix pull-left">
                    <c:if test="${tab==1 }">
                        <label class="label label-success">试卷预览中</label>
                    </c:if>
                    <%--<c:if test="${tab==2 }">--%>
                    <%--<label class="label label-success">答题中</label>--%>
                    <%--</c:if>--%>
                    <c:if test="${tab==1 }">
                        <button class="btn btn-success btn-block" disabled="disabled">我要交卷</button>
                    </c:if>
                    <c:if test="${tab==2 }">
                        <button class="btn btn-success btn-block test-finish-btn"  <c:if test="${isTeacher==1&&isPreview==1 }">disabled="disabled"</c:if>>我要交卷</button>
                    </c:if>
                </div>

                <div class="pull-right">
                    <c:if test="${tab==2 }">

                        <span class="mlm mrm "></span>
                        <button id="pause" class="btn btn-sm btn-default " <c:if test="${isTeacher==1&&isPreview==1 }">disabled="disabled"</c:if>>暂停</button>


                    </c:if>
                </div>

            </div>

            <div class="testpaper-metas" style="margin-bottom: 10px;">
                共 ${testPaper.total_number } 题，总分 ${testPaper.total_score } 分，请在 ${testPaper.timeless } 分钟内作答。
            </div>
            <div id="testpaper-navbar" class="testpaper-navbar affix-top" data-spy="affix"  data-offset-top="100">
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
        <div class="row" style="margin-top: 180px;">
            <div class="col-md-9 prevent-copy">
                <div class="testpaper-body">
                    <form id="teacherCheckForm" autocomplete="off" novalidate="novalidate" >

                        <%--单选题--%>
                        <c:if test="${testPaperQuestionViews5.size()>0 }">
                            <div class="panel panel-default testpaper-question-block" id="testpaper-questions-choice1">
                                <div  class="panel-heading"><strong class="">单选题</strong>
                                    <small class="text-muted">共${testPaperQuestionViews5.size() }题，共${total_score5 }分</small>
                                </div>
                                <div class="panel-body">
                                    <c:forEach items="${testPaperQuestionViews5 }" var="question">
                                        <c:choose>
                                            <c:when test="${question.question_status==2 }">

                                                <div class="testpaper-question testpaper-question-choice " id="question${question.question_id }" data-question-id="${question.id }">
                                                    <div class="testpaper-question-body">
                                                        <div class="testpaper-question-stem-wrap clearfix">
                                                            <div class="testpaper-question-seq-wrap">
                                                                <div class="testpaper-question-seq">${question.questions_number }</div>
                                                                <div class="testpaper-question-score">${question.questions_score }分</div>
                                                            </div>
                                                            <div class="testpaper-question-stem"><p>此题已删除</p></div>
                                                        </div>

                                                    </div>

                                                </div>



                                            </c:when>
                                            <c:otherwise>
                                                <div class="testpaper-question testpaper-question-choice " id="question${question.question_id }" data-question-id="${question.id }">
                                                    <div class="testpaper-question-body">
                                                        <div class="testpaper-question-stem-wrap clearfix">
                                                            <div class="testpaper-question-seq-wrap">
                                                                <div class="testpaper-question-seq">${question.questions_number }</div>
                                                                <div class="testpaper-question-score">${question.questions_score }分</div>
                                                            </div>
                                                            <div class="testpaper-question-stem"><p>${question.stem }</p></div>
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
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:if>

                        <%--多选题--%>
                        <c:if test="${testPaperQuestionViews0.size()>0 }">
                            <div class="panel panel-default testpaper-question-block" id="testpaper-questions-choice2">
                                <div  class="panel-heading"><strong class="">多选题</strong>
                                    <small class="text-muted">共${testPaperQuestionViews0.size() }题，共${total_score0 }分</small>
                                </div>
                                <div class="panel-body">
                                    <c:forEach items="${testPaperQuestionViews0 }" var="question">
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
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:if>

                        <%--填空题--%>
                        <c:if test="${testPaperQuestionViews1.size()>0 }">
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
                                                            <div class="testpaper-question-stem"><p>此题已删除</p><br></div>
                                                        </div>
                                                    </div>

                                                </div>


                                            </c:when>
                                            <c:otherwise>
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
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:if>

                        <%--判断题--%>
                        <c:if test="${testPaperQuestionViews2.size()>0 }">
                            <div class="panel panel-default testpaper-question-block" id="testpaper-questions-determine">
                                <div  class="panel-heading"><strong class="">判断题</strong>
                                    <small class="text-muted">共${testPaperQuestionViews2.size() }题，共${total_score2 }分</small>
                                </div>
                                <div class="panel-body">
                                    <c:forEach items="${testPaperQuestionViews2 }" var="question">
                                        <c:choose>
                                            <c:when test="${question.question_status==2 }">

                                                <div class="testpaper-question testpaper-question-fill " >
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
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:if>

                         <%--问答题 --%>
                        <c:if test="${testPaperQuestionViews3.size()>0 }">
                            <div class="panel panel-default testpaper-question-block" id="testpaper-questions-essay">
                                <div  class="panel-heading"><strong class="">问答题</strong>
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

                                                            <div id="essay-textarea${question.id }" style="display:none;">
                                                                    ${question.answer}
                                                            </div>

                                                            <input type="text" id="input_face_answer${question.id }" data-id="${question.id }" class="form-control essay-textarea"/>
                                                            <%-- content 
                                                            <input type="hidden" id="input_answer${question.id }" value="${question.answer}" class="testpaper-question-essay-input-short"/>
                                                            --%>
                                                            <textarea style="display:none;" id="input_answer${question.id }" class="testpaper-question-essay-input-short">
                                                            	${question.answer}
                                                            </textarea>
                                                            <a class="btn btn-link btn-muted btn-sm essay-textarea-pack-up" style="display: none" data-id="${question.id }" id="essay-textarea-pack-up${question.id }"><span class="glyphicon glyphicon-chevron-up text-muted"></span> 收起</a>
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

                        <%--材料题--%>
                        <c:if test="${testPaperQuestionViews6.size()>0 }">
                            <div class="panel panel-default testpaper-question-block" id="testpaper-questions-material">
                                <div  class="panel-heading"><strong class="">材料题</strong>
                                    <small class="text-muted">共${testPaperQuestionViews6.size() }题，共${total_score6 }分</small>
                                </div>
                                <div class="panel-body">
                                    <div class="material">
                                        <c:forEach items="${testPaperQuestionViews4 }" var="q">
                                            <c:choose>
                                                <c:when test="${q.question_status ==2 }">
                                                    <div class="well testpaper-question-stem-material"><p>材料题以及子题已被删除</p> </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="well testpaper-question-stem-material"><p>${q.stem }</p> </div>
                                                    <c:forEach items="${testPaperQuestionViews6 }" var="question">
                                                        <c:if test="${question.parent_question_id==q.question_id }">
                                                            <c:choose>
                                                                <c:when test="${question.question_status ==2 }">
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
                                                                                        <%--
                                                                                        <textarea class="form-control testpaper-question-essay-input-short essay-textarea"  id="essay-textarea${question.id }" rows="1" data-id="${question.id }">${question.answer}</textarea>
                                                                                        --%>
                                                                                    <div id="essay-textarea${question.id }" style="display:none;">
                                                                                            ${question.answer}
                                                                                    </div>
                                                                                        <%-- face --%>
                                                                                    <input type="text" id="input_face_answer${question.id }" data-id="${question.id }" class="form-control essay-textarea"/>
                                                                                        <%-- content 
                                                                                    <input type="hidden" id="input_answer${question.id }" value="${question.answer}" class="testpaper-question-essay-input-short"/>
                                                                                    --%>
                                                                                    <textarea style="display: none;" id="input_answer${question.id }" class="testpaper-question-essay-input-short">
                                                                                    	${question.answer}
                                                                                    </textarea>
                                                                                    <a class="btn btn-link btn-muted btn-sm essay-textarea-pack-up" style="display: none" data-id="${question.id }" id="essay-textarea-pack-up${question.id }"><span class="glyphicon glyphicon-chevron-up text-muted"></span> 收起</a>
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
                <div class="testpaper-card affix-top" data-spy="affix" data-offset-top="200" data-offset-bottom="200">
                    <div class="panel panel-default no-border" >


                        <div class="panel-footer" style="border-top: none;">
                            <c:if test="${tab==1 }">
                                <button class="btn btn-success btn-block" disabled="disabled">我要交卷</button>
                            </c:if>
                            <c:if test="${tab==2 }">
                                <button class="btn btn-success btn-block test-finish-btn" id="test-finish-btn" <c:if test="${isTeacher==1&&isPreview==1 }">disabled="disabled"</c:if>>我要交卷</button>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

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
            <div class="modal-footer">  <button type="button" class="btn btn-info" data-dismiss="modal">继续</button>

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
</body>


<script type="text/javascript">
    $(document).ready(function(e){
        var weditors = [];
        /*
        data-spy="scroll"是Bootstrap 滚动监听（Scrollspy）插件,自动更新导航插件,
        也可以在<body>上添加data-spy="scroll"
        data-spy="affix" 是Bootstrap 附加导航（Affix）插件,
        附加导航（Affix）插件允许某个 <div> 固定在页面的某个位置。
       */
        $("#testpaper-navbar>ul>li:first").addClass("active");

        $(".test-finish-btn").click(function(){
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
            if($("#input_answer"+id).val()!==""&&$("#input_answer"+id).val()!=="<p><br></p>"){
                /*
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
                $("#input_face_answer"+id).hide();
            }
        });
        //问答题点击出现输入框
        $(".essay-textarea").click(function(){
            var id=$(this).data('id');
            //if($("#cke_essay-textarea"+id).size()>0){
            if($("#essay-textarea"+id).children("div").length>=2){
                //$("#essay-textarea"+id).css("visibility","hidden");
                $("#essay-textarea"+id).show();
                //$("#cke_essay-textarea"+id).show();
                $("#essay-textarea-pack-up"+id).show();
                $("#input_face_answer"+id).hide();
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
                $("#input_face_answer"+id).hide();
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
            $("#input_face_answer"+id).show();
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

