<%@ page language="java" import="java.util.*,cn.bnsr.edu_yun.frontstage.base.po.User" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% User user = (User)request.getSession().getAttribute("currentUser");%>

<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>
<div class="cn-wrap">

    <div id="content-container" class="container">
        <jsp:include page="class_header.jsp"></jsp:include>
        <div class="row">
            <jsp:include page="class_left.jsp"></jsp:include>
            <div class="col-md-9">
                <div class="panel panel-default panel-col">
                    <div class="panel-heading">服务设置</div>
                    <div class="panel-body">
                        <form id="class_service" action="${pageContext.request.contextPath}/class/update_class_service_setting.action" class="form-horizontal" method="post">

                            <div class="course_save_succ alert alert-success" <c:if test="${classView.flag!=1}">style="display:none;"</c:if>>服务设置保存成功!</div>
                            <br/>
                            <div class="form-group" id="services-form-group">
                                <label class="col-md-2 control-label">
                                    提供的服务
                                </label>
                                <input type="hidden" name="id" value="${classRelation.id }" <c:if test="${classView.status ==1 }">disabled="disabled"</c:if>/>
                                <input type="hidden" name="class_id" value="${classView.id }" <c:if test="${classView.status ==1 }">disabled="disabled"</c:if>/>
                                <input type="hidden" name="source_id" value="${classView.source_id }" <c:if test="${classView.status ==1 }">disabled="disabled"</c:if>/>
                                <input type="hidden" name="source_type" value="${classView.source_type }" <c:if test="${classView.status ==1 }">disabled="disabled"</c:if>/>
                                <div class="col-md-10 controls checkboxs">
                                    <label><input type="checkbox" name="seatwork" value="1"  <c:if test="${classRelation.seatwork == 1 }">checked="checked"</c:if> <c:if test="${classView.status ==1 }">disabled="disabled"</c:if>> 24小时作业批改</label>
                                    <div class="help-block" style="padding-left: 15px;">24小时内完成作业批改，即时反馈并巩固您的学习效果。</div>
                                </div>
                                <label class="col-md-2 control-label">
                                </label>
                                <div class="col-md-10 controls checkboxs">
                                    <label><input type="checkbox" name="testpaper" value="1" <c:if test="${classRelation.testpaper == 1 }">checked="checked"</c:if> <c:if test="${classView.status ==1 }">disabled="disabled"</c:if>> 24小时阅卷点评</label>
                                    <div class="help-block" style="padding-left: 15px;">24小时内批阅您提交的试卷，给予有针对性的点评。</div>
                                </div>
                                <label class="col-md-2 control-label">
                                </label>
                                <div class="col-md-10 controls checkboxs">
                                    <label><input type="checkbox" name="question" value="1" <c:if test="${classRelation.question == 1 }">checked="checked"</c:if> <c:if test="${classView.status ==1 }">disabled="disabled"</c:if>> 提问必答</label>
                                    <div class="help-block" style="padding-left: 15px;">对于提问做到有问必答，帮您扫清学习过程中的种种障碍。</div>
                                </div>
                                <label class="col-md-2 control-label">
                                </label>
                                <div class="col-md-10 controls checkboxs">
                                    <label><input type="checkbox" name="doubt" value="1" <c:if test="${classRelation.doubt == 1 }">checked="checked"</c:if> <c:if test="${classView.status ==1 }">disabled="disabled"</c:if>> 一对一在线答疑</label>
                                    <div class="help-block" style="padding-left: 15px;">提供专属的一对一在线答疑，快速答疑解惑。</div>
                                </div>
                                <label class="col-md-2 control-label">
                                </label>
                                <div class="col-md-10 controls checkboxs">
                                    <label><input type="checkbox" name="activity" value="1" <c:if test="${classRelation.activity == 1 }">checked="checked"</c:if> <c:if test="${classView.status ==1 }">disabled="disabled"</c:if>> 班级活动</label>
                                    <div class="help-block" style="padding-left: 15px;">不定期组织各种线上或线下的班级活动，让学习更加生动有趣，同学关系更为紧密。</div>
                                </div>
                                <label class="col-md-2 control-label">
                                </label>
                                <div class="col-md-10 controls checkboxs">
                                    <label><input type="checkbox" name="job" value="1" <c:if test="${classRelation.job == 1 }">checked="checked"</c:if> <c:if test="${classView.status ==1 }">disabled="disabled"</c:if>> 就业指导</label>
                                    <div class="help-block" style="padding-left: 15px;">完成全部学习后，老师对您的学习成果和能力水平给出评估，并提供专业化的就业指导。</div>
                                </div>

                                <div class="form-group">
                                    <div class="col-md-offset-2 col-md-8 controls">
                                        <c:if test="${classView.status !=1 }">
                                            <input type="hidden" name="_csrf_token" value="20f4cc13176fd63e99d35dcd681cd9a4da0dc40c">
                                            <button type="submit" class="btn btn-fat btn-primary" onclick="doSumbit();">保存</button>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
</div>

<script type="text/javascript">
    function doSumbit(){
        document.getElementById('class_service').submit();
    }
</script>


