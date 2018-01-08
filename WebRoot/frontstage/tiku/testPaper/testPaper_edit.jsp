<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>


<link href="${pageContext.request.contextPath}/frontstage/css/nouislider.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/nouislider.js"></script>
<link href="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/wangEditor/wangEditor.min.js"></script>


<div class="cn-wrap">

	<div id="content-container" class="container">
		 <jsp:include page="/frontstage/train/course/course_header.jsp"></jsp:include>

		<div class="row">
			<jsp:include page="/frontstage/train/course/course_left.jsp"></jsp:include>
		<div class="col-md-9">
              <div class="panel panel-default panel-col test-creator">
                <div class="panel-heading clearfix">创建试卷</div>
                <div class="panel-body">

                  <ol class="breadcrumb">
                    <li><a href="javascript:void(0);">试卷管理</a></li>
                    <li class="active">编辑试卷信息</li>
                  </ol>

                  <form class="form-horizontal" method="post" action="${pageContext.request.contextPath}/testPaper/testPaper_edit.action?courseId=${courseView.id}&flag=0&sign=11" id="form-horizontal">
                      <input type="hidden" name="id" value="${testPaper.id }">      
                    <div class="form-group">
                      <div class="col-md-2 control-label"><label for="testpaper-name-field">试卷名称</label></div>
                      <div class="col-md-8 controls">
                          <input class="form-control" value="${testPaper.name }" name="name" id="testpaper-name-field" >
                      </div>
                    </div>

                    <div class="form-group">
                      <div class="col-md-2 control-label"><label >试卷说明</label></div>
                      <div class="col-md-8 controls">
                        <%-- 
                        <textarea class="form-control" style="height: 180px;" id="explain" name="remarks">${testPaper.remarks }</textarea>
                      	--%>
                      	<div  id="explain">
                      		${testPaper.remarks }
                      	</div>
                      	<%-- 
                      	<input type="hidden" name="remarks" value="${testPaper.remarks }"/>
                      	--%>
                      	<textarea style="display: none;" name="remarks">
                      		${testPaper.remarks }
                      	</textarea>
                      	<script type="text/javascript">
	                        var E = window.wangEditor;
	                        var explain_weditor = new E("#explain");
	                        explain_weditor.customConfig.menus = [
                                                                  'bold',  // 粗体
                                                                  'italic',  // 斜体
                                                                  'underline',  // 下划线
                                                                  'foreColor',  // 文字颜色
                                                                  'backColor',  // 背景颜色
                                                                  'link',  // 插入链接
                                                                  'list',  // 列表
                                                                  'justify',  // 对齐方式
                                                                  'image',  // 插入图片
                                                                  'table',  // 表格
                                                                  'undo',  // 撤销
                                                                  'redo'  // 重复
                                                              ];
	                        //保存图片到服务器
	                        explain_weditor.customConfig.uploadImgServer = "${pageContext.request.contextPath}/upload_file/upload_resource.action?source_id=${courseView.id}&source_type=0";
	                        //限制图片大小
	                        explain_weditor.customConfig.uploadImgMaxSize = 3*1024*1024;
	                        //图片上传上限
	                        explain_weditor.customConfig.uploadImgMaxLength = 1;
	                        //隐藏"网络图片"选项
	                        explain_weditor.customConfig.showLinkImg = false;
	                        explain_weditor.create();
						</script>
                      </div>
                    </div>

                    <div class="form-group">
                      <div class="col-md-2 control-label"><label >时间限制</label></div>
                      <div class="col-md-8 controls">
                          <input class="form-control width-input width-input-large" name="timeless" value="${testPaper.timeless }" > 分钟
                          <div class="help-block">0分钟，表示无限制</div>
                      </div>
                    </div> 
				<div class="form-group mbm">
                      <div class="col-md-8 col-md-offset-2 controls">
                        <button type="button" class="btn btn-primary">保存</button>
                        <a href="javascript:void(0);" class="btn btn-link  ">返回</a>
                      </div>
                    </div>
                      	<input type="hidden" value="0" name="simple_percentage"  id="simple-percentage">
 						 <input type="hidden" value="0" name="normal_percentage"  id="normal-percentage">
  						<input type="hidden" value="0" name="difficulty_percentage"  id="difficulty-percentage">
                  </form>

                </div>
              </div>
          </div>
		</div>
	</div>
    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
	
</div>
<!-- 弹窗 -->
<div id="modal" class="modal in" style="display: none;" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog  modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">题目预览</h4>
            </div>
            
            <div class="modal-footer">
                <button type="button" class="btn btn-link" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
$(document).ready(function(e){
     
     /*编辑窗口
     var height = $('#explain').height();
  	 CKEDITOR.replace("explain", {
            skin : "moono-lisa",
            height : height,
            margin : "0,0,0,0",
            resize_enabled : false,
            toolbar :
                    'Minimal'
        });
  	 */
    $(".btn-primary").click(function(){
      var name=$("#testpaper-name-field").val();
      if(name==null||name==""){
      alert("试卷名称不能为空");
      return false;
      }
      //for ( instance in CKEDITOR.instances )
	//CKEDITOR.instances[instance].updateElement();
     $("textarea[ name = 'remarks' ]").val(explain_weditor.txt.html());
	 var explain = $("textarea[ name = 'remarks' ]").val();
     //var explain=$("#explain").val();
	 if(explain==null||explain=="<p><br></p>"){
      alert("试卷说明不能为空");
      return false;
      }
    $("#form-horizontal").submit();
      });
      
      
  });
 
</script>

<%--<jsp:include page="../layout/footer.jsp"></jsp:include>--%>