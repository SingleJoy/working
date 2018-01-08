<%@ page language="java" import="java.util.*,cn.bnsr.edu_yun.frontstage.base.po.User" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<% User user = (User)request.getSession().getAttribute("currentUser");%>

<link href="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.js"></script>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>
<div class="cn-wrap" >

    <div id="content-container" class="container">
		<jsp:include page="class_header.jsp"></jsp:include>
        <div class="row">
			<jsp:include page="class_left.jsp"></jsp:include>
            <div class="col-md-9">

                <div class="panel panel-default panel-col">


                    <div class="panel-heading">
                        <div class="pull-right">
                            <a href="${pageContext.request.contextPath}/class/to_class_notice_manager.action?classId=${classView.id}&flag=2&sign=10&source_id=${classView.source_id}&source_type=${classView.source_type}" class="btn btn-default btn-lg">
                                返回</a>
                        </div>
                        班级通知
                    </div>
                    <div class="panel-body ">

                        <form  class="form-horizontal" method="post" action="${pageContext.request.contextPath}/class/save_class_notice.action?classId=${classView.id}&flag=2&sign=10&source_id=${classView.source_id}&source_type=${classView.source_type}" id="messageForm" novalidate="novalidate" >
							<input type="hidden" name="id" value="${messageView.id }"/>
							<input type="hidden" name="type" value="5"/>
							<input type="hidden" name="status" value="1"/>
                            <div class="form-group">
                                <div class="col-md-2 control-label">
                                    <label ><span class="text-danger">*</span>公告标题</label>
                                </div>
                                <div class="col-md-8 controls" >
                                    <input type="text"  class="form-control" name="title" placeholder="不超过15字" maxlength="15" value="${messageView.title }">
                                </div>
                            </div>


                            <div class="form-group">
                                <div class="col-md-2 control-label">
                                    <label ><span class="text-danger">*</span>公告内容</label>
                                </div>
                                <div class="col-md-8 controls">
                                    <textarea class="form-control"  placeholder="不超过500字" maxlength="500" name="content">${messageView.content }</textarea>
                                </div>
                            </div>
							<%-- 给学员发送系统通知
                            <div class="form-group">
                                <div class="col-md-2 control-label">
                                </div>
                                <div class="col-md-6 controls">
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="notify" value="notify"> 给学员发送系统通知
                                        </label>
                                    </div>
                                </div>
                            </div>
							--%>
                            <div class="form-group">
                                <div class="col-md-offset-2 col-md-8 controls">
                                    <button type="submit" class="btn btn-fat btn-primary">保存</button>
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
$(document).ready(function(){
	$("#messageForm").bootstrapValidator({
		message:'此值无效',
		feedbackIcons:{
			valid: 'glyphicon glyphicon-ok',
			invalid:'glyphicon glyphicon-remove',
			validating:'glyphicon glyphicon-refresh'
		},
		fields:{
			title:{
				message:"班级公告标题验证失败",
				validators:{
					notEmpty:{
						message:"班级公告标题不能为空"
					},
					stringLength:{
						min:2,
						max:15,
						message:"计划名称长度为2-15"
					}
				}
			},
			content:{
				message:"班级公告内容验证失败",
				validators:{
					notEmpty:{
						message:"班级公告内容不能为空"
					},
					stringLength:{
						min:2,
						max:500,
						message:"计划名称长度为2-500"
					}
				}
			}
		}
	}).on("success.form.bv",function(e){
		if(e.type){//验证通过
			document.getElementById('messageForm').submit();
		}else{
			e.preventDefault();
		}
	});
});
</script>