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

    <script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/wangEditor/app/app-use.js"></script>

</head>
<body style="background-color: #fff;">
<div class="cn-wrap">

    <div id="content-container" class="container">

        <div class="question-set homework-set">

            <div class="row question-set-heading" >
                <div class="col-md-12">
                    <div class="panel panel-default no-border">
                        <div class="panel-body">

                            <div class="homework-status">

                                <c:if test="${tab!=5 }">
                                    <div class="">
                                        <button class="btn btn-success btn-block">
                                            <c:if test="${tab==1 }">预览中</c:if>
                                            <c:if test="${tab==2 }">答题中</c:if>
                                            <c:if test="${tab==3||tab==4}">批改中</c:if>
                                        </button>
                                    </div>
                                </c:if>
                                <c:if test="${tab==5 }">
                                    <c:if test="${exam.grade==0 }">
                                        <button class=" btn btn-success btn-block" type="button">
                                            优秀
                                        </button>
                                    </c:if>
                                    <c:if test="${exam.grade==1 }">
                                        <button class="btn btn-success btn-block" type="button">
                                            良好
                                        </button>
                                    </c:if>
                                    <c:if test="${exam.grade==2 }">
                                        <button class="btn btn-warning btn-block" type="button">
                                            合格
                                        </button>
                                    </c:if>
                                    <c:if test="${exam.grade==3 }">
                                        <button class="btn btn-danger btn-block" type="button">
                                            不合格
                                        </button>
                                    </c:if>
                                </c:if>
                            </div>
                            <%--<div class="question-set-description">--%>
                            <%--<p>${testPaper.remarks }</p>--%>
                            <%--<p class="text-muted">所属课程 <a href="javascript:void(0);">${courseView.title }</a></p>--%>
                            <%--</div>--%>
                            <%--<hr>--%>
                        </div>
                    </div>
                </div>
            </div>

            <div class="question-set-body">

                <div class="question-set-main" style="position:relative;min-height:100%;padding-bottom: 50px; ">
                    <div class="panel panel-default panel-col">
                        <div class="panel-heading">作业题目 <small class="text-muted">共${testPaperQuestionViews.size() }题</small></div>
                        <div class="panel-body">
                            <c:forEach items="${testPaperQuestionViews }" var="question" varStatus="status">
                                <c:choose>

                                <c:when test="${question.question_status==2 }">
                                <div class="testpaper-question testpaper-question-choice " >
                                <div class="testpaper-question-body">
                                    <div class="testpaper-question-stem-wrap clearfix">
                                        <div class="testpaper-question-seq-wrap">
                                            <div class="testpaper-question-seq">${status.count }</div>
                                            <div class="testpaper-question-score"></div>
                                        </div>
                                        <div class="testpaper-question-stem"><p>此题已删除</p><br></div>
                                    </div>
                                </div>

                                </c:when>

                                <c:otherwise>
                                    <c:if test="${question.type==5 }">
                                        <div class="testpaper-question testpaper-question-choice " id="question${question.question_id }" data-question-id="${question.id }">
                                            <div class="testpaper-question-body">
                                                <div class="testpaper-question-stem-wrap clearfix">
                                                    <div class="testpaper-question-seq-wrap">
                                                        <div class="testpaper-question-seq">${status.count }</div>
                                                        <div class="testpaper-question-score"></div>
                                                    </div>
                                                    <div class="testpaper-question-stem"><p>${question.stem }</p><br></div>
                                                </div>
                                                <ul class="testpaper-question-choices">
                                                    <li ><span class="testpaper-question-choice-index <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'A')}">question-text-success</c:if></c:if>">A.</span>
                                                        <div class="choice-body <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'A')}">question-text-success</c:if></c:if>">
                                                            <p>${question.option_a }</p>
                                                        </div>
                                                    </li>
                                                    <li ><span class="testpaper-question-choice-index <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'B')}">question-text-success</c:if></c:if>">B.</span>
                                                        <div class="choice-body <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'B')}">question-text-success</c:if></c:if>">
                                                            <p>${question.option_b }</p>
                                                        </div>
                                                    </li>
                                                    <c:if test="${!empty question.option_c }">
                                                        <li ><span class="testpaper-question-choice-index <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'C')}">question-text-success</c:if></c:if>">C.</span>
                                                            <div class="choice-body <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'C')}">question-text-success</c:if></c:if>">
                                                                <p>${question.option_c }</p>
                                                            </div>
                                                        </li>
                                                    </c:if>
                                                    <c:if test="${!empty question.option_d }">
                                                        <li ><span class="testpaper-question-choice-index <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(question.right_key, 'D')}">question-text-success</c:if></c:if>">D.</span>
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
                                                            <input type="radio" name="questions[1][]" value="A">
                                                            A
                                                        </label>
                                                        <label class="radio-inline ">
                                                            <input type="radio" name="questions[1][]" value="B">
                                                            B
                                                        </label>
                                                        <c:if test="${!empty question.option_c }">
                                                            <label class="radio-inline ">
                                                                <input type="radio" name="questions[1][]" value="C">
                                                                C
                                                            </label>
                                                        </c:if>
                                                        <c:if test="${!empty question.option_d }">
                                                            <label class="radio-inline ">
                                                                <input type="radio" name="questions[1][]" value="D">
                                                                D
                                                            </label>
                                                        </c:if>
                                                        <c:if test="${!empty question.option_e }">
                                                            <label class="radio-inline ">
                                                                <input type="radio" name="questions[1][]" value="E">
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
                                                        <c:if test="${tab==5 }">
                                                            你答对了!
                                                        </c:if>
                                                    </c:if>
                                                    <c:if test="${question.is_right!=0 }">
                                                        <span class="glyphicon glyphicon-remove question-text-danger"></span>
                                                        <c:if test="${tab==5 }">
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
                                                    <br/>
                                                </div>
                                            </c:if>

                                        </div>
                                    </c:if>
                                    <c:if test="${question.type==0 }">
                                        <div class="testpaper-question testpaper-question-choice " id="question${question.question_id }" data-question-id="${question.id }">
                                            <div class="testpaper-question-body">
                                                <div class="testpaper-question-stem-wrap clearfix">
                                                    <div class="testpaper-question-seq-wrap">
                                                        <div class="testpaper-question-seq">${status.count }</div>
                                                        <div class="testpaper-question-score"></div>
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
                                                            <input type="checkbox" name="questions[1][]" value="A">
                                                            A
                                                        </label>
                                                        <label class="radio-inline ">
                                                            <input type="checkbox" name="questions[1][]" value="B">
                                                            B
                                                        </label>
                                                        <c:if test="${!empty question.option_c }">
                                                            <label class="radio-inline ">
                                                                <input type="checkbox" name="questions[1][]" value="C">
                                                                C
                                                            </label>
                                                        </c:if>
                                                        <c:if test="${!empty question.option_d }">
                                                            <label class="radio-inline ">
                                                                <input type="checkbox" name="questions[1][]" value="D">
                                                                D
                                                            </label>
                                                        </c:if>
                                                        <c:if test="${!empty question.option_e }">
                                                            <label class="radio-inline ">
                                                                <input type="checkbox" name="questions[1][]" value="E">
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
                                                        <c:if test="${tab==5 }">
                                                            你答对了!
                                                        </c:if>
                                                    </c:if>
                                                    <c:if test="${question.is_right!=0 }">
                                                        <span class="glyphicon glyphicon-remove question-text-danger"></span>
                                                        <c:if test="${tab==5 }">
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
                                    <c:if test="${question.type==1 }">
                                        <div class="testpaper-question testpaper-question-fill " id="question${question.question_id }" data-question-id="${question.id }" style="margin-top: 30px;">
                                            <div class="testpaper-question-body">
                                                <div class="testpaper-question-stem-wrap clearfix">
                                                    <div class="testpaper-question-seq-wrap">
                                                        <div class="testpaper-question-seq">${status.count }</div>
                                                        <div class="testpaper-question-score"></div>
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
                                                        <p><span class="text-danger">${stem }</span></p><br>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="testpaper-question-footer clearfix">
                                                <div class="testpaper-question-fill-inputs">
                                                    <c:if test="${tab==1||tab==2 }">
                                                        <c:forEach items="${fn:split(question.stem, '______')}" var="s" varStatus="status" >
                                                            <c:if test="${!status.last}">

                                                                <input class="form-control " type="text" name="questions[2][]"  placeholder="填空(${status.count })答案，请填在这里">

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
                                    <c:if test="${question.type==2 }">
                                        <div class="testpaper-question testpaper-question-fill " id="question${question.question_id }" data-question-id="${question.id }">
                                            <div class="testpaper-question-body">
                                                <div class="testpaper-question-stem-wrap clearfix">
                                                    <div class="testpaper-question-seq-wrap">
                                                        <div class="testpaper-question-seq">${status.count }</div>
                                                        <div class="testpaper-question-score"></div>
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
                                    <c:if test="${question.type==3 }">
                                        <div class="testpaper-question testpaper-question-essay " id="question${question.question_id }" data-question-id="${question.id }">
                                            <div class="testpaper-question-body">
                                                <div class="testpaper-question-stem-wrap clearfix">
                                                    <div class="testpaper-question-seq-wrap">
                                                        <div class="testpaper-question-seq">${status.count }</div>
                                                        <div class="testpaper-question-score"></div>
                                                    </div>
                                                    <div class="testpaper-question-stem"><p>${question.stem }</p><br></div>
                                                </div>
                                            </div>
                                            <div class="testpaper-question-footer clearfix" style="max-height:150px;">
                                                <div class="testpaper-question-essay-inputs" >
                                                    <c:if test="${tab==1||tab==2 }">

                                                        <div  id="essay-textarea${question.id }" style="display:none;"></div>
                                                        <%--
                                                        <input type="text" id="input_answer${question.id }" data-id="${question.id }" class="form-control testpaper-question-essay-input-short essay-textarea" readonly="readonly"/>
                                                        --%>
                                                        <%-- face --%>
                                                        <input type="text" id="input_face_answer${question.id }" data-id="${question.id }" class="form-control essay-textarea"/>
                                                        <%-- content 
                                                        <input type="hidden" id="input_answer${question.id }" class="testpaper-question-essay-input-short"/>
                                                        --%>
                                                        <textarea style="display: none;" id="input_answer${question.id }" class="testpaper-question-essay-input-short">
                                                        </textarea>
                                                        <div class="help-block text-warning" >请输入答案</div>
                                                        <a class="btn btn-link btn-muted btn-sm essay-textarea-pack-up" style="display: none" data-id="${question.id }" id="essay-textarea-pack-up${question.id }"><span class="glyphicon glyphicon-chevron-up text-muted"></span> 收起</a>
                                                    </c:if>
                                                    <c:if test="${tab==3||tab==4||tab==5 }">
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
                                                            <div class="question-eassy-form-control question-teacher-say-input">
                                                                <div class="teacher-say-text">老师评语:</div>
                                                                    ${question.exam_comment}
                                                            </div>
                                                        </c:if>
                                                    </c:if>
                                                </div>
                                                <c:if test="${tab==4 }">
                                                    <div class="question-eassy-form-control question-teacher-say-input" style="margin-left: 50px">
                                                        <div class="form-horizontal">
                                                            <div class="form-group">
                                                                <label class="col-sm-2 control-label">得分</label>
                                                                <div class="col-sm-3 controls">
                                                                    <input class="form-control defen" placeholder="得分" name="score_3" type="text" value="" data-score="${question.questions_score }">
                                                                </div>
                                                            </div>
                                                            <div class="form-group" style="display: none">
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
                                                <div class="testpaper-question-actions pull-right"></div>
                                            </div>
                                        </div>
                                    </c:if>
                                    <c:if test="${question.type==4 }">
                                        <c:set var="count" value="${status.count }"></c:set>
                                        <div class="well testpaper-question-stem-material"><p>${question.stem }</p> </div>
                                        <c:forEach items="${testPaperSonQuestionViews }" var="son_question" varStatus="status1">
                                            <c:if test="${son_question.parent_question_id==question.question_id }">
                                                <c:choose>
                                                    <c:when test="${son_question.question_status==2 }">

                                                        <div class="testpaper-question testpaper-question-choice " >
                                                            <div class="testpaper-question-body">
                                                                <div class="testpaper-question-stem-wrap clearfix">
                                                                    <div class="testpaper-question-seq-wrap">
                                                                        <div class="testpaper-question-seq">${count }.${status1.count }</div>
                                                                        <div class="testpaper-question-score"></div>
                                                                    </div>
                                                                    <div class="testpaper-question-stem"><p>此题已删除</p><br></div>
                                                                </div>

                                                            </div>

                                                        </div>


                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:if test="${son_question.type==5}">
                                                            <div class="testpaper-question testpaper-question-choice " id="question${question.question_id }" data-question-id="${son_question.id }">
                                                                <div class="testpaper-question-body">
                                                                    <div class="testpaper-question-stem-wrap clearfix">
                                                                        <div class="testpaper-question-seq-wrap">
                                                                            <div class="testpaper-question-seq">${count }.${status1.count }</div>
                                                                            <div class="testpaper-question-score"></div>
                                                                        </div>
                                                                        <div class="testpaper-question-stem"><p>${son_question.stem }</p><br></div>
                                                                    </div>
                                                                    <ul class="testpaper-question-choices">
                                                                        <li class=""><span class="testpaper-question-choice-index <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(son_question.right_key, 'A')}">question-text-success</c:if></c:if>">A.</span>
                                                                            <div class="choice-body <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(son_question.right_key, 'A')}">question-text-success</c:if></c:if>">
                                                                                <p>${son_question.option_a }</p>
                                                                            </div>
                                                                        </li>
                                                                        <li class=""><span class="testpaper-question-choice-index <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(son_question.right_key, 'B')}">question-text-success</c:if></c:if>">B.</span>
                                                                            <div class="choice-body <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(son_question.right_key, 'B')}">question-text-success</c:if></c:if>">
                                                                                <p>${son_question.option_b }</p>
                                                                            </div>
                                                                        </li>
                                                                        <c:if test="${!empty son_question.option_c }">
                                                                            <li class=""><span class="testpaper-question-choice-index <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(son_question.right_key, 'C')}">question-text-success</c:if></c:if>">C.</span>
                                                                                <div class="choice-body <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(son_question.right_key, 'C')}">question-text-success</c:if></c:if>">
                                                                                    <p>${son_question.option_c }</p>
                                                                                </div>
                                                                            </li>
                                                                        </c:if>
                                                                        <c:if test="${!empty son_question.option_d }">
                                                                            <li class=""><span class="testpaper-question-choice-index <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(son_question.right_key, 'D')}">question-text-success</c:if></c:if>">D.</span>
                                                                                <div class="choice-body <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(son_question.right_key, 'D')}">question-text-success</c:if></c:if>">
                                                                                    <p>${son_question.option_d }</p>
                                                                                </div>
                                                                            </li>
                                                                        </c:if>
                                                                        <c:if test="${!empty son_question.option_e }">
                                                                            <li class=""><span class="testpaper-question-choice-index <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(son_question.right_key, 'E')}">question-text-success</c:if></c:if>">E.</span>
                                                                                <div class="choice-body <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(son_question.right_key, 'E')}">question-text-success</c:if></c:if>">
                                                                                    <p>${son_question.option_e }</p>
                                                                                </div>
                                                                            </li>
                                                                        </c:if>
                                                                    </ul>
                                                                </div>
                                                                <c:if test="${tab==1||tab==2 }">
                                                                    <div class="testpaper-question-footer clearfix">
                                                                        <div class="testpaper-question-choice-inputs">
                                                                            <label class="radio-inline "><input type="radio" name="question${son_question.id }" value="A">A</label>
                                                                            <label class="radio-inline "><input type="radio" name="question${son_question.id }" value="B">B</label>
                                                                            <c:if test="${!empty son_question.option_c }">
                                                                                <label class="radio-inline ">
                                                                                    <input type="radio" name="question${son_question.id }" value="C">C
                                                                                </label>
                                                                            </c:if>
                                                                            <c:if test="${!empty son_question.option_d }">
                                                                                <label class="radio-inline ">
                                                                                    <input type="radio" name="question${son_question.id }" value="D">D
                                                                                </label>
                                                                            </c:if>
                                                                            <c:if test="${!empty son_question.option_e }">
                                                                                <label class="radio-inline ">
                                                                                    <input type="radio" name="question${son_question.id }" value="E">E
                                                                                </label>
                                                                            </c:if>
                                                                        </div>
                                                                        <div class="testpaper-question-actions pull-right"></div>
                                                                    </div>
                                                                </c:if>
                                                                <c:if test="${tab==3||tab==4||tab==5 }">
                                                                    <div class="homework-question-result" style="margin-left: 50px">
                                                                        <c:if test="${son_question.is_right==0 }">
                                                                            <span class="glyphicon glyphicon-ok question-text-success"></span>
                                                                            <c:if test="${tab==5 }">你答对了!
                                                                            </c:if>
                                                                        </c:if>
                                                                        <c:if test="${son_question.is_right!=0 }">
                                                                            <span class="glyphicon glyphicon-remove question-text-danger"></span>
                                                                            <c:if test="${tab==5 }">
                                                                                <c:if test="${!empty son_question.answer }">
                                                                                    你答错了,你选择了
                                                                                    <strong class="question-text-danger">
                                                                                            ${fn:replace(son_question.answer, ',', ' ')}
                                                                                    </strong>
                                                                                </c:if>
                                                                            </c:if>
                                                                            <c:if test="${empty son_question.answer }">
                                                                                <strong class="question-text-danger">未答题</strong>
                                                                            </c:if>
                                                                        </c:if>
                                                                    </div>
                                                                </c:if>
                                                            </div>
                                                        </c:if>
                                                        <c:if test="${son_question.type==0}">
                                                            <div class="testpaper-question testpaper-question-choice " id="question${question.question_id }" data-question-id="${son_question.id }">
                                                                <div class="testpaper-question-body">
                                                                    <div class="testpaper-question-stem-wrap clearfix">
                                                                        <div class="testpaper-question-seq-wrap">
                                                                            <div class="testpaper-question-seq">${count }.${status1.count }</div>
                                                                            <div class="testpaper-question-score"></div>
                                                                        </div>
                                                                        <div class="testpaper-question-stem"><p>${son_question.stem }</p><br></div>
                                                                    </div>
                                                                    <ul class="testpaper-question-choices">
                                                                        <li class=""><span class="testpaper-question-choice-index <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(son_question.right_key, 'A')}">question-text-success</c:if></c:if>">A.</span>
                                                                            <div class="choice-body <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(son_question.right_key, 'A')}">question-text-success</c:if></c:if>">
                                                                                <p>${son_question.option_a }</p>
                                                                            </div>
                                                                        </li>
                                                                        <li class=""><span class="testpaper-question-choice-index <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(son_question.right_key, 'B')}">question-text-success</c:if></c:if>">B.</span>
                                                                            <div class="choice-body <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(son_question.right_key, 'B')}">question-text-success</c:if></c:if>">
                                                                                <p>${son_question.option_b }</p>
                                                                            </div>
                                                                        </li>
                                                                        <c:if test="${!empty son_question.option_c }">
                                                                            <li class=""><span class="testpaper-question-choice-index <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(son_question.right_key, 'C')}">question-text-success</c:if></c:if>">C.</span>
                                                                                <div class="choice-body <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(son_question.right_key, 'C')}">question-text-success</c:if></c:if>">
                                                                                    <p>${son_question.option_c }</p>
                                                                                </div>
                                                                            </li>
                                                                        </c:if>
                                                                        <c:if test="${!empty son_question.option_d }">
                                                                            <li class=""><span class="testpaper-question-choice-index <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(son_question.right_key, 'D')}">question-text-success</c:if></c:if>">D.</span>
                                                                                <div class="choice-body <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(son_question.right_key, 'D')}">question-text-success</c:if></c:if>">
                                                                                    <p>${son_question.option_d }</p>
                                                                                </div>
                                                                            </li>
                                                                        </c:if>
                                                                        <c:if test="${!empty son_question.option_e }">
                                                                            <li class=""><span class="testpaper-question-choice-index <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(son_question.right_key, 'E')}">question-text-success</c:if></c:if>">E.</span>
                                                                                <div class="choice-body <c:if test="${tab==3||tab==4||tab==5 }"><c:if test="${fn:contains(son_question.right_key, 'E')}">question-text-success</c:if></c:if>">
                                                                                    <p>${son_question.option_e }</p>
                                                                                </div>
                                                                            </li>
                                                                        </c:if>
                                                                    </ul>
                                                                </div>
                                                                <c:if test="${tab==1||tab==2 }">
                                                                    <div class="testpaper-question-footer clearfix">
                                                                        <div class="testpaper-question-choice-inputs">
                                                                            <label class="radio-inline "><input type="checkbox" name="question${son_question.id }" value="A">A</label>
                                                                            <label class="radio-inline "><input type="checkbox" name="question${son_question.id }" value="B">B</label>
                                                                            <c:if test="${!empty son_question.option_c }">
                                                                                <label class="radio-inline ">
                                                                                    <input type="checkbox" name="question${son_question.id }" value="C">C
                                                                                </label>
                                                                            </c:if>
                                                                            <c:if test="${!empty son_question.option_d }">
                                                                                <label class="radio-inline ">
                                                                                    <input type="checkbox" name="question${son_question.id }" value="D">D
                                                                                </label>
                                                                            </c:if>
                                                                            <c:if test="${!empty son_question.option_e }">
                                                                                <label class="radio-inline ">
                                                                                    <input type="checkbox" name="question${son_question.id }" value="E">E
                                                                                </label>
                                                                            </c:if>
                                                                        </div>
                                                                        <div class="testpaper-question-actions pull-right"></div>
                                                                    </div>
                                                                </c:if>
                                                                <c:if test="${tab==3||tab==4||tab==5 }">
                                                                    <div class="homework-question-result" style="margin-left: 50px">
                                                                        <c:if test="${son_question.is_right==0 }">
                                                                            <span class="glyphicon glyphicon-ok question-text-success"></span>
                                                                            <c:if test="${tab==5 }">你答对了!
                                                                            </c:if>
                                                                        </c:if>
                                                                        <c:if test="${son_question.is_right!=0 }">
                                                                            <span class="glyphicon glyphicon-remove question-text-danger"></span>
                                                                            <c:if test="${tab==5 }">
                                                                                <c:if test="${!empty son_question.answer }">
                                                                                    你答错了,你选择了
                                                                                    <strong class="question-text-danger">
                                                                                            ${fn:replace(son_question.answer, ',', ' ')}
                                                                                    </strong>
                                                                                </c:if>
                                                                            </c:if>
                                                                            <c:if test="${empty son_question.answer }">
                                                                                <strong class="question-text-danger">未答题</strong>
                                                                            </c:if>
                                                                        </c:if>
                                                                    </div>
                                                                </c:if>
                                                            </div>
                                                        </c:if>
                                                        <c:if test="${son_question.type==1}">
                                                            <div class="testpaper-question testpaper-question-fill " id="question${question.question_id }" data-question-id="${son_question.id }">
                                                                <div class="testpaper-question-body">
                                                                    <div class="testpaper-question-stem-wrap clearfix">
                                                                        <div class="testpaper-question-seq-wrap">
                                                                            <div class="testpaper-question-seq">${count }.${status1.count }</div>
                                                                            <div class="testpaper-question-score"></div>
                                                                        </div>
                                                                        <div class="testpaper-question-stem">
                                                                            <c:set var="stem" value=""/>
                                                                            <c:forEach items="${fn:split(son_question.stem, '______')}" var="s" varStatus="status" >
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
                                                                            <c:forEach items="${fn:split(son_question.stem, '______')}" var="s" varStatus="status" >
                                                                                <c:if test="${!status.last}">
                                                                                    <input class="form-control " type="text" name="40" placeholder="填空(${status.count })答案，请填在这里">
                                                                                </c:if>
                                                                            </c:forEach>
                                                                        </c:if>
                                                                    </div>
                                                                    <c:if test="${tab==3||tab==4||tab==5 }">
                                                                        <c:forEach items="${fn:split(son_question.right_key, ',')}" var="q" varStatus="status" >
                                                                            <c:set var="answer" value="${fn:split(son_question.answer, ',')}" />
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
                                                        <c:if test="${son_question.type==2}">
                                                            <div class="testpaper-question testpaper-question-fill " id="question${question.question_id }" data-question-id="${son_question.id }">
                                                                <div class="testpaper-question-body">
                                                                    <div class="testpaper-question-stem-wrap clearfix">
                                                                        <div class="testpaper-question-seq-wrap">
                                                                            <div class="testpaper-question-seq">${count }.${status1.count }</div>
                                                                            <div class="testpaper-question-score"></div>
                                                                        </div>
                                                                        <div class="testpaper-question-stem"><p>${son_question.stem }</p><br></div>
                                                                    </div>
                                                                </div>
                                                                <div class="testpaper-question-footer clearfix">
                                                                    <c:if test="${tab==1||tab==2 }">
                                                                        <div class="testpaper-question-choice-inputs">
                                                                            <label class="radio-inline "><input type="radio" name="question${son_question.question_id }" value="1"> 正确</label>
                                                                            <label class="radio-inline "><input type="radio" name="question${son_question.question_id }" value="0">错误</label>
                                                                        </div>
                                                                    </c:if>
                                                                    <c:if test="${tab==3||tab==4||tab==5 }">
                                                                        <div class="homework-question-result" style="margin-left: 50px">
                                                                            正确答案是
                                                                            <strong class="question-text-danger">
                                                                                <c:if test="${son_question.right_key==0 }">
                                                                                    错误
                                                                                </c:if>
                                                                                <c:if test="${son_question.right_key==1 }">
                                                                                    正确
                                                                                </c:if>
                                                                            </strong>
                                                                            <c:if test="${son_question.is_right==0 }">
                                                                                <span class="glyphicon glyphicon-ok question-text-success"></span>
                                                                                <c:if test="${tab==5 }">
                                                                                    你答对了!
                                                                                </c:if>
                                                                            </c:if>
                                                                            <c:if test="${son_question.is_right==1 }">
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

                                                        <c:if test="${son_question.type==3}">
                                                            <div class="testpaper-question testpaper-question-essay " id="question${question.question_id }" data-question-id="${son_question.id }">
                                                                <div class="testpaper-question-body">
                                                                    <div class="testpaper-question-stem-wrap clearfix">
                                                                        <div class="testpaper-question-seq-wrap">
                                                                            <div class="testpaper-question-seq">${count }.${status1.count }</div>
                                                                            <div class="testpaper-question-score"></div>
                                                                        </div>
                                                                        <div class="testpaper-question-stem"><p>${son_question.stem }</p><br></div>
                                                                    </div>
                                                                </div>

                                                                <div class="testpaper-question-footer clearfix">
                                                                    <div class="testpaper-question-essay-inputs">
                                                                        <c:if test="${tab==1||tab==2 }">
                                                                            <%--
                                                                            <textarea class="form-control testpaper-question-essay-input-short essay-textarea" id="essay-textarea${son_question.id }" rows="1" data-id="${son_question.id }"></textarea>
                                                                            --%>
                                                                            <div id="essay-textarea${son_question.id }" style="display:none;">
                                                                                    ${son_question.answer}
                                                                            </div>
                                                                            <%-- face --%>
                                                                            <input type="text" id="input_face_answer${son_question.id }" data-id="${son_question.id }" class="form-control essay-textarea"/>
                                                                            <%-- content 
                                                                            <input type="hidden" id="input_answer${son_question.id }" value="${son_question.answer}" class="testpaper-question-essay-input-short"/>
                                                                            --%>
                                                                            <textarea style="display: none;" id="input_answer${son_question.id }" class="testpaper-question-essay-input-short">
                                                                            	${son_question.answer}
                                                                            </textarea>
                                                                            <a class="btn btn-link btn-muted btn-sm essay-textarea-pack-up" style="display: none" data-id="${son_question.id }" id="essay-textarea-pack-up${son_question.id }"><span class="glyphicon glyphicon-chevron-up text-muted"></span> 收起</a>
                                                                        </c:if>
                                                                        <c:if test="${tab==3||tab==4||tab==5 }">
                                                                            <strong>学员回答:</strong>
                                                                            <c:if test="${empty son_question.answer}">
                                                                                <p class="question-text-danger">未答题</p>
                                                                            </c:if>
                                                                            <c:if test="${!empty son_question.answer}">
                                                                                ${son_question.answer}
                                                                            </c:if>
                                                                            <strong>参考答案</strong>
                                                                            ${son_question.right_key}
                                                                            <c:if test="${tab==5 }">
                                                                                <div class="question-eassy-form-control question-teacher-say-input">
                                                                                    <div class="teacher-say-text">老师评语:</div>
                                                                                        ${son_question.exam_comment}
                                                                                </div>
                                                                            </c:if>
                                                                        </c:if>
                                                                    </div>

                                                                    <c:if test="${tab==4 }">
                                                                        <div class="question-eassy-form-control question-teacher-say-input" style="margin-left: 50px">
                                                                            <div class="form-horizontal">
                                                                                <div class="form-group">
                                                                                    <label class="col-sm-2 control-label">得分</label>
                                                                                    <div class="col-sm-3 controls">
                                                                                        <input class="form-control defen" placeholder="得分" name="score_3" type="text" value="" data-score="${son_question.questions_score }">
                                                                                    </div>
                                                                                </div>
                                                                                <div class="form-group" style="display: none">
                                                                                    <label class="col-sm-2 control-label">评语</label>
                                                                                    <div class="col-sm-9">
                                                                                        <div class="testpaper-result-essay-teacherSay">
                                                                                            <textarea class="form-control  teacher-say" name="answer[${son_question.id }]" data-type="essay" data-exam_answer_id="${son_question.exam_answer_id }" ></textarea>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </c:if>

                                                                    <div class="testpaper-question-actions pull-right"></div>
                                                                </div>
                                                            </div>
                                                        </c:if>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                </c:otherwise>
                                </c:choose>
                                </c:forEach>
                            </div>
                        </div>
                    </div>

                    <c:if test="${tab!=3 }">
                        <div class="question-set-side row" style="position: fixed;display: block;width: 100%;bottom:-15px;z-index: 9999;">

                            <div class="question-set-card col-md-12" >

                                <div class="panel panel-default" style="border: none;z-index: 9999;">

                                    <div class="panel-footer text-center" style="border-top: none;padding-bottom: 0;">
                                        <c:if test="${tab==1 }">
                                            <button class="btn btn-success btn-block" id="homework-watch-btn" disabled="disabled">提交作业</button>
                                        </c:if>
                                        <c:if test="${tab==2 }">
                                            <button class="btn btn-success btn-block" id="homework-finish-btn" <c:if test="${isTeacher==1&&isPreview==1 }">disabled="disabled"</c:if>>提交作业</button>
                                        </c:if>
                                        <c:if test="${tab==4 }">
                                            <button class="btn btn-success btn-block" id="homework-check-btn" >完成批改</button>
                                        </c:if>


                                    </div>

                                </div>

                            </div>
                        </div>
                    </c:if>

                    <c:if test="${try_again }">
                        <div class="question-set-side row" style="position: fixed;display: block;width: 100%;bottom:-15px;z-index: 9999;">

                            <div class="question-set-card col-md-12" >

                                <div class="panel panel-default" style="border: none;z-index: 9999;">

                                    <div class="panel-footer text-center" style="border-top: none;padding-bottom: 0;">

                                        <a href="${pageContext.request.contextPath}/course/to_study_again_m.action?id=${course_hour_id }&class_id=${class_id }&user_id=${user_id }" class="btn btn-success btn-block">再次尝试</a>

                                    </div>

                                </div>

                            </div>
                        </div>
                    </c:if>

                </div>
            </div>
        </div>

    </div>

    <div id="modal" class="modal" style="display: none;" aria-hidden="true">
        <div class="modal-dialog ">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title" >完成批改</h4>
                </div>
                <div class="modal-body"><div id="homework-check-body" data-widget-cid="widget-4">

                    <div class="form-group">
                        <div class="controls">
                            <textarea class="form-control" rows="4" id="homework-teacherSay-input" placeholder="请输入评语"></textarea>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="controls">
                            <select class="form-control" id="homework-teacherSay-select">
                                <option value="0">---常用评语---</option>
                                <option value="1">继续努力，继续进步！</option>
                                <option value="2">不错，有进步，再努力些就会更棒！</option>
                                <option value="3">你真棒！我为你骄傲！</option>
                                <option value="4">有点松懈了吧？继续加油吧！</option>
                                <option value="5">用心、专注、坚持，你能做的更好的！</option>
                            </select>
                        </div>
                    </div>
                </div>

                </div>
                <div class="modal-footer">
                    <div class="col-md-8 controls radios">
                        <p class="" style="font-size: 12pt" id="grade_label"></p>
                    </div>
                    <div id="homework-check-foot" class="col-md-4" data-widget-cid="widget-5">
                        <a href="javascript:;" class="btn btn-default" data-dismiss="modal">取消</a>
                        <button class="btn btn-success" id="homework-check" >完成批改</button>

                    </div>

                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        $(document).ready(function(e){
            var weditors = [];
            var saveAnswers = [];
            var right=0;
            var score=0;
            var grade=0;
            /*
             data-spy="scroll"是Bootstrap 滚动监听（Scrollspy）插件,自动更新导航插件,
             也可以在<body>上添加data-spy="scroll"
             data-spy="affix" 是Bootstrap 附加导航（Affix）插件,
             附加导航（Affix）插件允许某个 <div> 固定在页面的某个位置。
             */
            $("#testpaper-navbar>ul>li:first").addClass("active");

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
            $('.question-set-card').on('click', '.question-index', function() {
                var position = $($(this).data('anchor')).offset();
                $(document).scrollTop(position.top - 55);
            });
            //完成批改
            $("#homework-check-btn").click(function(){
                saveAnswers = [];
                var _this= $(this);
                var flag=false;
                $('.question-set-main').find('.form-horizontal').each(function(index,item){
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
                    //exam_comment 不再使用
                    //  if ($(item).val() != '') {
                    //     exam_comment+=($(teacher_say).val().replace(/[\r\n]/g,""));
                    //saveAnswers.push("questions="+$questionId+ '|' +answer);
                    //    saveAnswers.push('"' +$questionId+'|'+is_right+'|'+score+'"'+ ':'+'"' +exam_comment+'"');
                    //   }else{
                    // saveAnswers.push("questions="+$questionId+ '|' +answer);
                    saveAnswers.push('"' +$questionId+'|'+is_right+'|'+score+'"'+ ':'+'"' +exam_comment+'"');
                    //     }

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
                            right=response.right;
                            grade=response.grade;
                            score=response.score;
                            $("#grade_label").removeClass();
                            $("#grade_label").addClass("pull-right");
                            $("#grade_label").addClass("label");
                            if(grade==0){
                                $("#grade_label").addClass("label-success");
                                $("#grade_label").html("优秀");
                            }else
                            if(grade==1){
                                $("#grade_label").addClass("label-success");
                                $("#grade_label").html("良好");
                            }else
                            if(grade==2){
                                $("#grade_label").addClass("label-warning");
                                $("#grade_label").html("合格");
                            }else{
                                $("#grade_label").addClass("label-danger");
                                $("#grade_label").html("不合格");
                            }
                            $('#modal').modal('show');


                        }
                    });

                }
            });
            //提交作业
            $("#homework-finish-btn").click(function(){
                saveAnswers = [];
                $(this).attr("disabled","disabled");
                $('.question-set-main').find('.testpaper-question').each(function(index,item){
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
                $.ajax({
                    type: 'POST',
                    url : '${pageContext.request.contextPath}/exam/finish_homework.action?exam_id=${exam.id}',
                    dataType: "json",
                    contentType:'application/json;charset=UTF-8',
                    data:str,
                    success : function(response) {
                        location.replace(location.href);
                    }
                });



            });
            //最终批改，给评语
            $("#homework-check").click(function(){

                var exam_comment= $("#homework-teacherSay-input").val();
                var form=$("<form>");//定义一个form表单
                form.attr("style","display:none");
                form.attr("target","");
                form.attr("method","post");
                form.attr("action",'${pageContext.request.contextPath}/exam/check_finish.action');
                var input1=$("<input>");
                input1.attr("type","hidden");
                input1.attr("name","exam_comment");
                input1.attr("value",exam_comment);
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
                input6.attr("name","class_id");
                input6.attr("value",'${class_id}');
                var input7=$("<input>");
                input7.attr("type","hidden");
                input7.attr("name","source_type");
                input7.attr("value",'${source_type}');
                var input8=$("<input>");
                input8.attr("type","hidden");
                input8.attr("name","course_id");
                input8.attr("value",'${course_id}');
                $("body").append(form);//将表单放置在web中
                form.append(input1);
                form.append(input2);
                form.append(input3);
                form.append(input4);
                form.append(input5);
                form.append(input6);
                form.append(input7);
                form.append(input8);
                form.submit();//表单提交 });

            });
            //切换常用评语
            $("#homework-teacherSay-select").change(function(){

                var checkText=$(this).find("option:selected").text();
                if($(this).val()!=0){
                    // var value=  $("#homework-teacherSay-input").val();
                    $("#homework-teacherSay-input").val(checkText);
                }
            });
            //问答题点击出现输入框
            $(".essay-textarea").click(function(){
                var id=$(this).data('id');
                //if($("#cke_essay-textarea"+id).size()>0){
                if($("#essay-textarea"+id).children("div").length>=2){
                    //$("#essay-textarea"+id).css("visibility","hidden");
                    //$("#essay-textarea"+id).hide();
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



        });
        var timeIndex =parseInt('${testPaper.timeless }')*60;
        $("#start").click(function(){    //点击btnl触发setTime()函数
            clearInterval(times);
            times = setInterval(setTime, 1000);    //每隔1秒执行函数
        });
        $("#pause").click(function(){
            clearInterval(times);    //清除对函数的调用
        });
        function setTime(){
            if(timeIndex==0){
                $("#time_show").html("");
                return false;
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
    </script>



</body>


