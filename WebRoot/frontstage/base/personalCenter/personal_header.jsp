<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>

    h5.media-heading>span{display: inline-block;}
    h5.teaching-info>button{color:#3ebbce;border: 1px solid #3ebbce;background-color: #fff;border-radius: 4px;font-size: 12px;padding: 5px 6px;}
    .latest-notes>div{list-style: none;height:110px;display: inline-block;border-right:1px solid #ddd;text-align: center;padding-top: 20px;}
    .latest-notes>div>span{font-size: 14px;display: inline-block;text-align: center;font-weight:bold;  }
    .latest-notes>div>span>span{line-height: 30px;}

    .border_bottom{border-bottom: 1px solid #ddd;}
</style>


<div class="section course-manage-header clearfix" style="background-color: #fff;margin:  20px auto;">
    <div class="row">

        <div class="col-md-3 col-lg-3 text-center">

            <div class="avatar-wrap" style="margin-top: 25px;">
                <img class="avatar-lg" src="${pageContext.request.contextPath}${user.icon}" >
            </div>

            <div style="clear: both;padding-top: 10px;display: block;">

                <c:if test="${user_info.certificated==1 }">

                    <img src="${pageContext.request.contextPath}/frontstage/images/certificated.png" title="已认证">

                </c:if>
                <c:if test="${user_info.certificated==0 }">

                    <img src="${pageContext.request.contextPath}/frontstage/images/certificating.png" title="认证中">

                </c:if>
                <c:if test="${(user_info.certificated!=1)&&user_info.certificated!=0 }">

                    <a href="${pageContext.request.contextPath}/certification/to_certification.action?state=36&stamp=7" target="_blank" title="未认证" >
                        <img src="${pageContext.request.contextPath}/frontstage/images/certificate.png" >
                    </a>

                </c:if>

                <a href="javascript:void(0);" class="link-dark" style="padding: 0 10px;">${user.username}</a>

                <c:if test="${empty userInfo||(userInfo.certificated!=1&&userInfo.certificated!=0) }">
                    <a href="${pageContext.request.contextPath}/certification/to_certification.action?state=36&stamp=7" class="text-info">申请认证</a>
                </c:if>
                <c:if test="${userInfo.certificated==1 }">
                    <a href="javascript:void(0);" class="text-muted">已认证</a>
                </c:if>
                <c:if test="${userInfo.certificated==0 }">
                    <a href="javascript:void(0);" class="text-info">认证中</a>
                </c:if>
                <div style="margin-top: 15px">
                    <a class=" btn btn-info btn-sm" href="${pageContext.request.contextPath}/my_setting/showMySetting.action?state=35&stamp=7" >个人设置</a>
                </div>


            </div>

        </div>
        <div class="col-md-9 col-lg-9">
            <div class="latest-notes" style="margin-top: 20px;margin-right:50px;">

                    <div class="col-lg-4 col-md-4 border_bottom">
                        <span>
                            坚持学习<br/>
                            <span class="text-danger" style="font-size: 20px;">${userCenter.continueDay }</span>
                            <span class="tex-muted">天</span>
                        </span>
                        <%--<img src="${pageContext.request.contextPath}/frontstage/images/per_learning_course.png"><br/>--%>

                    </div>
                    <div class="col-lg-4 col-md-4 border_bottom">
                        <span>
                            <%--<img src="${pageContext.request.contextPath}/frontstage/images/per_teaching_course.png"><br/>--%>
                            完成课程<br/>
                            <span class="text-danger" style="font-size: 20px;">${userCenter.studyedCourse }</span>
                                <span class="tex-muted">个</span>
                        </span>
                    </div>
                    <div class="col-lg-4 col-md-4 border_bottom" style="border-right:none;">
                        <%--<img src="${pageContext.request.contextPath}/frontstage/images/per_join_discuss.png"><br/>--%>
                        <span>
                            累计学习<br/>
                            <span class="text-danger" style="font-size: 20px;">${userCenter.studytime }</span>
                            <span class="tex-muted">时</span>
                            <span class="text-danger" style="font-size: 20px;">${userCenter.studytimeM }</span>
                            <span class="tex-muted">分</span>
                        </span>
                    </div>

                    <div class="col-lg-4 col-md-4 no_border">
                        <%--<img src="${pageContext.request.contextPath}/frontstage/images/per_join_community.png"><br/>--%>

                        <span>
                            在学课程<br/>
                            <span class="text-danger" style="font-size: 20px;">${userCenter.studyCourse }</span>
                            <span class="tex-muted">个</span>
                        </span>
                    </div>
                    <div class="col-lg-4 col-md-4 no_border">
                        <%--<img src="${pageContext.request.contextPath}/frontstage/images/per_workshop.png"><br/>--%>
                        <span>
                            在教培训<br/>
                            <span class="text-danger" style="font-size: 20px;">${userCenter.teachingTrain }</span>
                            <span class="tex-muted">个</span>
                        </span>
                    </div>
                    <div class="col-lg-4 col-md-4 no_border" style="border-right:none;">
                        <%--<img src="${pageContext.request.contextPath}/frontstage/images/per_resource.png"><br/>--%>
                        <span>
                            贡献资源<br/>
                            <span class="text-danger" style="font-size: 20px;">${userCenter.resourceNum }</span>
                            <span class="tex-muted">个</span>
                        </span>
                    </div>

            </div>

        </div>


    </div>
    <br/>
</div>
