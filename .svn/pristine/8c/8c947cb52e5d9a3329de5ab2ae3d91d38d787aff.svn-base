<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>


<div class="cn-wrap">

	<div  id="content-container" class="container">

		<div class="row" style="margin: 20px auto;">
			<div class="panel panel-default panel-page panel-create-course">
				<div class="panel-heading"><h2>创建课程</h2></div>
	                <form id="saveCourse" action="${pageContext.request.contextPath}/course/create_course.action" method="post" class="form-horizontal">
		                 <input type="hidden" name="type" value="${type}" id="type">
						<div class="course-piece">
                        选择类型
                    	</div>
						<div class="row">

							<div class="col-md-3">
								<div class="course-select active" data-type="normal">
									<i class="es-icon es-icon-putongkecheng "></i>
									<div class="course-type">普通课程</div>
									<div class="course-intro">支持视频、图文、PPT等各种形式，支持作业、笔记等多个学习工具的课程</div>
								</div>
							</div>
								<div class="col-md-3">
                                                          <div class="course-select" data-type="live">
                                                                        <i class="es-icon es-icon-zhibokecheng "></i>
                                    <div class="course-type">直播课程</div>
                                    <div class="course-intro">以直播为教学形式的，支持多个学习工具的课程</div>
                                </div>
                            </div>
						</div>

						<div class="course-title row">
							<div class="col-md-2 controls-label text-lg">
								<div class="course-piece title">
									课程标题
								</div>
							</div>
							<div class="col-md-6 controls">
								<input type="text" id="title" name="title" required="required" class="form-control">
								<div class="title_val" style="display:none;"></div>
							</div>
						</div>

						<div class="text-center">

                          <span class="mrm">
                             <a href="javascript:void(0);" class="text-muted" target="_blank">如何创建课程？</a>
                          </span>

					    	<input class="btn btn-fat btn-primary" type="submit" value="创建"  onclick="doSumbit();">
						</div>
				</form>
			</div>
		</div>
	</div>
	<jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>

</div>



<script type="text/javascript">
	function validate(){
		var title = $("#title").val();
		if(title==""){

			$(".title_val").show();
			return false;
		}else{

			$(".title_val").hide();
			return true;
		}
	}
    function doSumbit(){
    	var val = validate();
    	if(val){
	        document.getElementById('saveCourse').submit();
    	}
    }
    $(function(){
    	$("input").blur(function(){
    		validate();
      	});
      	  $("#saveCourse .course-select").click(function () {
                $this = $(this);
                var courseType = $this.data('type');
               
                if($this.data("type")=="normal"){
                $("#type").val("0");
                }
                if($this.data("type")=="live"){
                $("#type").val("2");
                }
                $this.not('.disabled').addClass('active').parent().siblings().find('.course-select').removeClass('active');
             
            });
      	
    });
    
</script>
