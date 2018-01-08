<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<style>
    .course_score_lever>div{font-size: 16px;line-height: 40px;}
    .course_score_lever>div>p{padding: 0 16px;display: inline-block;}
    .class-about img{max-width: 100%;}
    .course_score_lever{margin-bottom: 15px;border-radius: 4px;
        background: -webkit-linear-gradient(left,#d57338, #d3cf54,#d57338); /* Safari 5.1 - 6.0 */
        background: -o-linear-gradient(left,#d57338, #d3cf54,#d57338);/* Opera 11.1 - 12.0 */
        background: -moz-linear-gradient(left,#d57338, #d3cf54,#d57338); /* Firefox 3.6 - 15 */
        background: linear-gradient(left,#d57338, #d3cf54,#d57338); /* 标准的语法 */
    }

</style>

<div class="cn-piece">
    <div class="piece-body p-lg clearfix">
        <div  class="class-about">${courseInfo.profile}</div>
    </div>
</div>

<c:if test="${!empty courseInfo.target}">
<div class="cn-piece">
    <div class="piece-header">
        课程目标
    </div>
    <div class="piece-body">
        <ul class="piece-body-list">
            <li>
                <i class="es-icon es-icon-chevronright"></i><c:if test="${empty courseInfo.target}">暂无</c:if> ${courseInfo.target}
            </li>
        </ul>
    </div>
</div>
</c:if>

<c:if test="${!empty courseInfo.crowd}">
<div class="cn-piece">
    <div class="piece-header">
        适合人群
    </div>
    <div class="piece-body">
        <ul class="piece-body-list">
            <li>
                <i class="es-icon es-icon-chevronright"></i><c:if test="${empty courseInfo.crowd}">暂无</c:if> ${courseInfo.crowd}
            </li>
        </ul>
    </div>
</div>
</c:if>

<c:if test="${courseInfo.is_check==0}">

    <div class="cn-piece" >
        <div class="piece-header">
            考核标准
        </div>
        <div class="piece-body">
            <h2 class="text-center text-info" >考核项占比</h2><br/>
            <table class="table table-striped" style="text-align: center;font-size: 14px;">
                <thead>
                <tr>
                    <th style="width: 15%;font-weight: normal;text-align: center;">考核项</th>
                    <th  style="width: 55%;font-weight: normal;text-align: center;">考核内容</th>
                    <th  style="width: 30%;font-weight: normal;text-align: center;">考核占比( % )</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${jobStandard}" var="job">
                    <tr>
                        <td>作业 </td>
                        <td>${job.source_name } </td>
                        <td>${job.ratio }</td>
                    </tr>
                </c:forEach>
                <c:forEach items="${discussionStandard}" var="discussion">
                    <tr>
                        <td>主题讨论 </td>
                        <td >${discussion.source_name } </td>
                        <td>${discussion.ratio}</td>
                    </tr>
                </c:forEach>
                <c:forEach items="${examStandard}" var="exam">
                    <tr>
                        <td>考试 </td>
                        <td>${exam.source_name } </td>
                        <td>${exam.ratio }</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <br/>
        <c:if test="${!empty certificatesViews}">

            <div class="piece-body certificate_img" style="margin-top: 30px;">
                <h2 class="text-center text-info" >证书获取要求</h2>
                <div class="row " style="margin-top: 50px;">
                    <c:forEach items="${certificatesViews}" var="certificate" varStatus="i" >
                        <div class="course_score_lever col-md-8 col-md-offset-2" >
                            <div ><p></p>证书：${certificate.cert_model_title}<br/>
                                证书成绩：&nbsp;&nbsp;${certificate.down_score }&nbsp;——&nbsp;${certificate.up_score }
                            </div>
                        </div>

                    </c:forEach>

                </div>

            </div>
        </c:if>
    </div>

</c:if>
