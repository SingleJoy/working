<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>


<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/JMEditor/jmeditor/jquery-1.8.3.min.js"></script>

<script type="text/javascript"
        src="${pageContext.request.contextPath}/frontstage/js/My97DatePicker/WdatePicker.js"></script>
<link href="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.js"></script>


<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<div class="cn-wrap" >


    <div id="content-container" class="container">

        <jsp:include page="/frontstage/xbjy/lesson/lesson_header.jsp"></jsp:include>

        <div class="course-detail row" style="margin-top: 20px;">

            <jsp:include page="/frontstage/xbjy/lesson/lesson_left.jsp"></jsp:include>

            <div class="col-lg-9 col-md-8  course-detail-main">
                <c:if test="${(lessonAttachmentView.purview==202&&lessonLeft.prepare201==1)||(lessonAttachmentView.purview==301&&lessonLeft.prepare204==1)||(lessonAttachmentView.purview==302&&lessonLeft.prepare204==1)||(lessonAttachmentView.purview==304&&lessonLeft.class302==1)||(lessonAttachmentView.purview==401&&lessonLeft.class304==1)||(lessonAttachmentView.purview==402&&lessonLeft.assessment401==1)||(lessonAttachmentView.purview==501&&lessonLeft.assessment401==1) }">
                    <div class="panel panel-default panel-col course-data">
                        <div class="panel-heading" >
                            <c:if test="${lessonAttachmentView.purview==202}">备课研讨会（提交纪要）</c:if>
                            <c:if test="${lessonAttachmentView.purview==301}">观课研讨会（提交记录）</c:if>
                            <c:if test="${lessonAttachmentView.purview==302}">观课量表</c:if>
                            <c:if test="${lessonAttachmentView.purview==304}">提交上课实录</c:if>
                            <c:if test="${lessonAttachmentView.purview==401}">观课报告</c:if>
                            <c:if test="${lessonAttachmentView.purview==402}">课后评议会（提交记录）</c:if>
                            <c:if test="${lessonAttachmentView.purview==501}">课后反思心得</c:if>
                            <c:if test="${flag }">
                            <a class="btn btn-info pull-right" id="file">
                                <c:if test="${lessonAttachmentView.purview==202}">上传会议纪要</c:if>
                                <c:if test="${lessonAttachmentView.purview==301}">上传会议纪要</c:if>
                                <c:if test="${lessonAttachmentView.purview==302}">上传观课量表</c:if>
                                <c:if test="${lessonAttachmentView.purview==304}">上传课堂实录</c:if>
                                <c:if test="${lessonAttachmentView.purview==401}">提交观课报告</c:if>
                                <c:if test="${lessonAttachmentView.purview==402}">上传会议记录</c:if>
                                <c:if test="${lessonAttachmentView.purview==501}">提交反思心得</c:if>
                            </a>
                            </c:if>
                        </div>

                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped member-statistics" style="text-align: center;" id="file_table">
                                    <tbody>
                                    <tr>
                                        <td class="active" style="width: 30%;">名称</td>
                                        <td class="active" style="width: 10%;">上传人</td>
                                        <td class="active" style="width: 20%;">更新时间</td>
                                        <td class="active" style="width: 10%;">浏览数</td>
                                        <td class="active" style="width: 25%;">操作</td>
                                    </tr>
                                    <c:forEach items="${lessonAttachmentViews }" var="view">
                                        <tr>
                                            <td >${view.name }</td>
                                            <td ><c:if test="${empty view.true_name }">${view.username }</c:if><c:if test="${!empty view.true_name }">${view.true_name }</c:if></td>
                                            <td >${fn:replace(view.update_time,'.0','')}</td>
                                            <td >${view.scan_count }</td>
                                            <td style="text-align: center;">
                                                <a href="${pageContext.request.contextPath}/lesson_attachment/see.action?id=${view.id }" class="text-muted" target="_blank">查看</a>
                                                <c:if test="${!empty join_user}">
                                                <span class="mlm mrm">|</span>
                                                <a href="javascript:void (0);" class="text-info" data-id="${view.id }">下载</a>
                                              </c:if>
                                               <c:if test="${currentUser.id==view.user_id }">
                                              <span class="mlm mrm">|</span>
                                                <a href="javascript:void (0);" class="text-warning" data-id="${view.id }">删除</a>
                                            	</c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                                <div id="test" class="pager" style="padding-top: 0;margin-bottom: 20px;"></div>
                                <form id="lessonForm" action="${pageContext.request.contextPath}/lesson_attachment/to_lesson_attachment.action" method="post">
                                    <input type="hidden" name="page" id="page" value="${lessonAttachmentView.page}"/>
                                    <input type="hidden" name="rows" id="rows" value="${lessonAttachmentView.rows}"/>
                                    <input type="hidden" name="total" id="total" value="${lessonAttachmentView.total}"/>
                                    <input type="hidden" name="totalPage" id="totalPage" value="${lessonAttachmentView.totalPage}"/>
                                    <input type="hidden" name="lesson_id" id="lesson_id" value="${lessonAttachmentView.lesson_id}"/>
                                    <input type="hidden" name="purview" id="purview" value="${lessonAttachmentView.purview}"/>
                                    <input type="hidden" name="stamp" id="stamp" value="${stamp}"/>
                                    <input type="hidden" name="state" id="state" value="${state}"/>
                                </form>
                                <div class="help-block">说明：支持格式.txt；.doc;.docx;.xls;.xlsx;.pdf;.ppt;.pptx; .gif;.jpg;.jpeg；.7z;.flv;.mp4;*.mp3;文件大小：500MB</div>
                            </div>
                        </div>


                    </div>
                </c:if>

              <c:if test="${(lessonAttachmentView.purview==202&&lessonLeft.prepare201!=1)}">

                    <div class="panel panel-default panel-col">
                        <div class="panel-heading">备课:研讨会会议纪要</div>
                        <div class="panel-body" style="text-align: center;">
                            <img src="${pageContext.request.contextPath}/frontstage/images/lesson_task_unfinshed.png" style="margin-top: 20px auto;">
                            <div>未完成教学设计协同修改</div>
                        </div>

                    </div>

                </c:if>

                <c:if test="${(lessonAttachmentView.purview==301&&lessonLeft.prepare204!=1)}">
                    <div class="panel panel-default panel-col ">
                        <div class="panel-heading">上课准备会议纪要</div>
                        <div class="panel-body" style="text-align: center;">
                            <img src="${pageContext.request.contextPath}/frontstage/images/lesson_task_unfinshed.png" style="margin-top: 20px auto;">
                            <div>未提交修改后的教学设计</div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${(lessonAttachmentView.purview==302&&lessonLeft.prepare204!=1)}">
                    <div class="panel panel-default panel-col">
                        <div class="panel-heading">
                            观课量表
                        </div>
                        <div class="panel-body" style="text-align: center;">
                            <img src="${pageContext.request.contextPath}/frontstage/images/lesson_task_unfinshed.png" style="margin-top: 20px auto;">
                            <div>未提交修改后的教学设计</div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${(lessonAttachmentView.purview==304&&lessonLeft.class302!=1)}">
                    <div class="panel panel-default panel-col">
                        <div class="panel-heading">
                            上课实录
                        </div>
                        <div class="panel-body" style="text-align: center;">
                            <img src="${pageContext.request.contextPath}/frontstage/images/lesson_task_unfinshed.png" style="margin-top: 20px auto;">
                            <div>未提交观课量表</div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${(lessonAttachmentView.purview==401&&lessonLeft.class304!=1)}">
                    <div class="panel panel-default panel-col">
                        <div class="panel-heading">
                           评课报告
                        </div>
                        <div class="panel-body" style="text-align: center;">
                            <img src="${pageContext.request.contextPath}/frontstage/images/lesson_task_unfinshed.png" style="margin-top: 20px auto;">
                            <div>未提交上课实录</div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${(lessonAttachmentView.purview==402&&lessonLeft.assessment401!=1)}">
                    <div class="panel panel-default panel-col ">
                        <div class="panel-heading">
                           评课会议纪要
                        </div>
                        <div class="panel-body" style="text-align: center;">
                            <img src="${pageContext.request.contextPath}/frontstage/images/lesson_task_unfinshed.png" style="margin-top: 20px auto;">
                            <div>未提交评课报告</div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${(lessonAttachmentView.purview==501&&lessonLeft.assessment401!=1)}">
                    <div class="panel panel-default panel-col ">
                        <div class="panel-heading">
                            反思心得
                        </div>
                        <div class="panel-body" style="text-align: center;">
                            <img src="${pageContext.request.contextPath}/frontstage/images/lesson_task_unfinshed.png" style="margin-top: 20px auto;">
                            <div>未提交评课报告</div>
                        </div>
                    </div>
                </c:if>
            </div>

        </div>
    </div>

    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>

</div>
<script type="text/javascript">
    $(function(){
        //翻页
        var total = $("#total").val();
        var page =  parseInt($("#page").val())+1;

        $("#btn5").on('click', function () {
            $("#div1").PageChanged(5);
        });

        $(".pager").pagination({
            thisPageIndex:page,
            recordCount: total,       //总记录数
            pageSize: $("#rows").val(),           //一页记录数
            onPageChange: function (page) {
                document.title = page;
                $("#page").val(page-1);
                $('#lessonForm').submit();

            }
        });
    });
</script>
<c:if test="${flag }">
    <script type="text/javascript">
        $(function(){
            //删除
            $(document).on("click",".text-warning",function() {
                var id=$(this).data("id");
                $.ajax({
                    url : '${pageContext.request.contextPath}/lesson_attachment/delete.action?id='+id,
                    dataType : 'json',
                    success : function(response) {
                        location.replace(location.href);
                    }
                });
            });

            //上传
            var uploader = WebUploader.create({
                auto: true,
                // swf文件路径
                swf: '${pageContext.request.contextPath}/frontstage/js/webuploader/Uploader.swf',
                // 文件接收服务端。
                server: '${pageContext.request.contextPath}/lesson_attachment/upload.action?purview=${lessonAttachmentView.purview}&lesson_id=${lessonAttachmentView.lesson_id}',

                // 选择文件的按钮。可选。
                // 内部根据当前运行是创建，可能是input元素，也可能是flash.
                pick: '#file',

                // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
                resize: false,
                accept: {
                    extensions: 'doc,docx,xls,xlsx,pdf,ppt,pptx,gif,jpg,jpeg,rar,zip,7z,flv,mp4,mp3',
                    mimeTypes: '.doc,.docx,.xls,.xlsx,.pdf,.ppt,.pptx ,.gif,.jpg,.jpeg,.rar,.zip,.7z,.flv,.mp4,.mp3'   //修改这行
                }
            });
            /**
             *上传成功后
             *file:文件
             *response:服务器返回
             */
            uploader.on( 'uploadSuccess', function( file,response  ) {
//		var hidden=$('<input type="hidden" value="'+response.fileName+'" name="lesson_pic" class="hidden">' );
//		var $form=$("#saveLessonPlan");
//		$form.append(hidden);
//
//table-bordered
                var view=response.lessonAttachmentView;
                $("#file_table>tbody").append("<tr><td >"+view.name+"</td><td >"+view.true_name+"</td>"+
                "<td >"+view.update_time+"</td>"+
                "<td >"+view.scan_count+"</td>"+
                "<td style='text-align: center;'><a href='${pageContext.request.contextPath}/lesson_attachment/see.action?id="+view.id+"' class='text-muted' data-id='"+view.id+"' target='_blank'>查看</a>&nbsp;<span class='mlm mrm'>|</span>&nbsp;"+
                "<a href='javascript:void (0);' class='text-info' data-id='"+view.id+"'>下载</a>&nbsp;<span class='mlm mrm'>|</span>&nbsp;"+
                "<a href='javascript:void (0);' class='text-warning' data-id='"+view.id+"'>删除</a></td></tr>")
                //document.getElementById("lesson_pic").value = response.fileName;
            });

            $(document).on("click",".text-info",function(){
                var id=$(this).data("id");
                var explorer=getExplorer();
                var form=$("<form>");//定义一个form表单
                form.attr("style","display:none");
                form.attr("target","");
                form.attr("method","post");
                form.attr("action","${pageContext.request.contextPath}/lesson_attachment/download.action");
                var input2=$("<input>");
                input2.attr("type","hidden");
                input2.attr("name","id");
                input2.attr("value",id);
                var input3=$("<input>");
                input3.attr("type","hidden");
                input3.attr("name","explorer");
                input3.attr("value",explorer);

                $("body").append(form);//将表单放置在web中
                form.append(input2);
                form.append(input3);

                form.submit();//表单提交 });
            });

        });
        function getExplorer() {
            var explorer = window.navigator.userAgent ;
            //ie
            if (explorer.indexOf("MSIE") >= 0) {

                return "IE";
            }
            //firefox
            else if (explorer.indexOf("Firefox") >= 0) {

                return "Firefox";
            }
            //Chrome
            else if(explorer.indexOf("Chrome") >= 0){

                return "Chrome";
            }
            //Opera
            else if(explorer.indexOf("Opera") >= 0){
                return"Opera";
            }
            //Safari
            else if(explorer.indexOf("Safari") >= 0){
                return "Safari";
            }
        }
    </script>
</c:if>
<c:if test="${!flag }">
    <script type="text/javascript">
    $("#file").click(function() {
		alert("您没有被分配该项任务");
	})
    </script>
    </c:if>
