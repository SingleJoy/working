<%@ page language="java" import="java.util.*,cn.bnsr.edu_yun.frontstage.base.po.User" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% User user = (User)request.getSession().getAttribute("currentUser");%>

<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<link href="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.js"></script>
<div class="cn-wrap">

    <div id="content-container" class="container" >

        <jsp:include page="class_header.jsp"></jsp:include>

        <div class="row">

            <jsp:include page="class_left.jsp"></jsp:include>

            <div class="col-md-9">
                <div class="panel panel-default panel-col">
                    <div class="panel-heading">学员管理
                        <div class="panel-bar">
                            <a class="btn btn-info btn-sm mhs " data-toggle="modal" href="#add-students" >
                                <i class="glyphicon glyphicon-plus"></i> 添加学员
                            </a>
                            <a id="batch_import"  href="#import-students" data-toggle="modal" class="btn btn-info btn-sm mhs " onclick="doUpload();"><i class="glyphicon glyphicon-import"></i> 批量导入</a>
                            <a href="${pageContext.request.contextPath}/user_study/export_student.action?sourceId=${userStudyView.sourceId}&sourceType=${userStudyView.sourceType}&learnId=${userStudyView.learnId}" data-toggle="modal"  class="btn btn-info btn-sm mhs"><i class="glyphicon glyphicon-export"></i> 导出学员</a>
                        </div>
                    </div>

                    <div class="panel-body">
                        <ul class="nav nav-tabs mbl">
                            <li class="active">
                                <a href="javascript:void(0);">正式学员</a>
                            </li>

                        </ul>
                        <form id="studentForm" class="form-inline well well-sm " action="${pageContext.request.contextPath}/user_study/to_class_student_manage.action" method="post" novalidate="">
                            <div class="form-group col-md-7">
                                <input class="form-control " style="width:45%" type="text" placeholder="请输入用户名" name="studentName" value="${stu_name }">
                                <input type="hidden" id="classId" name="id" value="${userStudyView.sourceId}" />
                                <input type="hidden" id="type" name="sourceType"  value="${userStudyView.sourceType}" />
                                <input type="hidden" name="sign" value="${classView.sign}" />
                                <input type="hidden" name="tab" value="1" />
                                <input type="hidden" name="page" id="page" value="${userStudyView.page}" />
                                <input type="hidden" name="rows" id="rows" value="${userStudyView.rows}" />
                                <input type="hidden" name="total" id="total" value="${userStudyView.total}" />
                                <input type="hidden" name="totalPage" id="totalPage" value="${userStudyView.totalPage}" />
                                <button class="btn btn-primary">搜索</button>

                            </div>
                            <div class="clearfix"></div>
                        </form>
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th width="40%">学员</th>
                                <th width="30%">学习进度</th>
                                <th width="30%">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${studentList }" var="student">
                                <tr>
                                    <td class="media" style="vertical-align: middle;">
                                        <a class="pull-left js-user-card" href="javascript:void(0);" title="">
                                            <img src="${pageContext.request.contextPath}${student.icon}" class="avatar-sm"/>
                                        </a>
                                        <a  href="javascript:void(0);" class="students_title">
                                                ${student.studentName}
                                            <c:if test="${!empty student.remarks }">
                                                <span class="remark">(${student.remarks})</span>
                                            </c:if>
                                        </a>
                                        <div class="text-muted text-sm">加入时间：${fn:substring(student.addTime,0,16)}</div>
                                        <div class="text-muted text-sm">有效日期:${fn:substring(student.validityTime,0,16)}<c:if test="${!empty student.overTime }">(${student.overTime}小时)</c:if></div>
                                    </td>
                                    <td style="vertical-align: middle;">
                                        <div class="progress mvm" title="">
                                            <div class="progress-bar" style="width: ${student.study_progress}%"></div>
                                        </div>
                                    </td>
                                    <td style="vertical-align: middle;">
                                        <div class="btn-group">
                                                <%-- <a href="${pageContext.request.contextPath}/private_letter/to_letter.action" class="btn btn-default btn-sm" data-toggle="modal" data-target="#modal" >私信</a> --%>
                                            <button class="btn btn-default btn-sm" data-toggle="modal" data-target="#private-modal"  onclick="send_private_messages(${student.userId },'${student.studentName }')"><a href="javascript:void(0);">发私信</a></button>
                                            <button class="btn btn-default btn-sm" data-toggle="modal" data-target="#look-info" onclick="searchInfo(${student.userId});">查看资料</button>
                                            <a href="javascript:void(0);" type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" onclick="doManage(${student.id});">管理
                                                <span class="caret"></span>
                                            </a>
                                            <ul class="dropdown-menu pull-right" id="manage_${student.id}">
                                                <li><a class="" href="javascript:void(0);" onclick="doReamrks('${student.id}','${student.remarks}');" data-toggle="modal" data-target="#remark-students" >备注</a></li>
                                                <li><a href="javascript:void(0);" class="student-remove" onclick="deleteStudent(${student.id});">移除</a></li>
                                            </ul>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <c:if test="${empty studentList && userStudyView.tab==0}"><div  class="empty">还没有学生加入该班级</div></c:if>
                        <c:if test="${!empty studentList }"><div id="test" class="pager" ></div></c:if>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
</div>
<!-- 添加学员弹窗 -->
<div id="add-students" class="modal"  data-toggle="modal" style="display: none;">
    <div class="modal-dialog  modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">添加学员</h4>
            </div>
            <div class="modal-body">
                <form  id="save_student" class="form-horizontal" method="post" action="${pageContext.request.contextPath}/user_study/save_student.action" novalidate="novalidate">
                    <input type="hidden" name="source_id" value="${classView.id }"/>
                    <input type="hidden" name="source_type" value="${classView.source_type }"/>
                    <input type="hidden" name="sign" value="${classView.sign }"/>
                    <input type="hidden" id="userId" name="user_id" value="${classView.userId }"/>
                    <input type="hidden" id="learn_id" name="learn_id" value="${classView.source_id }"/>
                    <div class="row form-group">
                        <div class="col-md-2 control-label">
                            <label >学员</label>
                        </div>
                        <div class="col-md-7 controls">
                            <input type="text" class="form-control" onblur="validateStudent();" id="student_" placeholder="邮箱/手机/用户名"><i style="font-size: 14px;color: red" id="verify_msg"></i>
                            <div class="help-block">只能添加系统中已注册的用户</div>
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class="col-md-2 control-label">
                            <label for="buy-price">购买价格</label>
                        </div>
                        <div class="col-md-7 controls">
                            <div class="input-group">
                                <input type="text" id="buy-price"  value="0.00" class="form-control">
                                <div class="input-group-addon">元</div>
                            </div>
                            <div class="help-block">本班级的价格为0.00元</div>
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class="col-md-2 control-label">
                            <label for="student-remark">备注</label>
                        </div>
                        <div class="col-md-7 controls">
                            <input type="text" id="student-remark" name="remarks" class="form-control">
                            <div class="help-block">选填</div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-primary pull-right"  onclick="doSubmit();">保存</button>
                <button type="button" class="btn btn-link pull-right" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<!-- 导入学员弹窗  步骤一-->
<div id="import-students" class="modal"  data-toggle="modal" style="display: none;">
    <div class="modal-dialog ">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">导入学员</h4>
            </div>
            <div class="modal-body">

                <h1 class="pull-left">步骤1</h1>
                <div style="clear: both;margin-top: 30px;">
                    <a href="${pageContext.request.contextPath}/frontstage/train/class/example/student_demo.xls">点击下载示例说明文件</a>
                </div>
                <div id="fileList" style="clear: both;">
                    <div id="uploadFile"  style="margin-left: 250px;">
                        <p class="plus_number">
                            <button class="btn btn-info btn-lg" type="button">
                                <i class="glyphicon glyphicon-plus"></i>添加
                            </button>
                        </p>
                    </div>
                </div>

                <form id="import_student_form" style="display: none" method="post" class="form-horizontal"  novalidate="novalidate">
                    <div class="form-group">
                        <div class="col-md-4 controls col-md-offset-5">
                            <input type="hidden" id="filepath" name="filepath">
                            <input type="hidden" id="filename" name="filename">
                            <div id="nofilepath" style="display: none" class="help-block">请导入Excel类型文件</div>
                            <button type="button" class="btn btn-primary" id="start-import-btn" style="margin-top: 30px;">开始校验数据</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- 导入学员弹窗  步骤二-->
<div id="import-students-second" class="modal " aria-hidden="false" style="display: none;">
    <div class="modal-dialog ">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">导入学员</h4>
            </div>
            <div class="modal-body">
                <h1 class="pull-left">步骤2</h1>
                <%--导入信息--%>
                <div id="" class="form-group" style="margin-top: 50px;clear: both;">
                    <div id="import_msg"></div>
                    <div id="import_failure" class="col-md-2 controls col-md-offset-5" style="margin-top: 20px;">
                        <button type="submit" class="btn btn-primary" id="reUpload">重新导入</button>
                    </div>
                </div>

            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-link pull-right" data-dismiss="modal">取消</button>
                <form  action="${pageContext.request.contextPath}/user_study/batch_save_student.action?id=${classView.id}&source_type=${classView.source_type}&source_id=${classView.source_id}&sign=${classView.sign}" method="post" novalidate="novalidate">
                    <div class="form-group" id="batch_save" style="display: none;">
                        <div class="col-md-2 controls col-md-offset-6">
                            <input type="hidden" id="userIds" name="userIds">
                            <input type="submit" class="btn btn-fat btn-primary" value="保存">
                            <!-- <button  type="submit" class="btn btn-link pull-right" data-dismiss="modal">保存</button> -->
                        </div>
                    </div>
                </form>

            </div>

        </div>
    </div>
</div>


<!-- 查看资料弹窗 -->
<div id="look-info" class="modal " aria-hidden="false" style="display: none;">
    <div class="modal-dialog ">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">个人详细信息</h4>
            </div>
            <div class="modal-body">
                <table class="table table-striped table-condenseda ">
                    <tbody id="userInfo">

                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<!-- 学员备注弹窗 -->
<div id="remark-students" class="modal" aria-hidden="false" style="display: none;">
    <div class="modal-dialog ">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">学员备注</h4>
            </div>
            <div class="modal-body">
                <form id="updateStudent" method="post" action="${pageContext.request.contextPath}/user_study/update_remarks.action" novalidate="novalidate">
                    <input type="hidden" name="source_id" value="${classView.id }"/>
                    <input type="hidden" name="source_type" value="${classView.source_type }"/>
                    <input type="hidden" name="sign" value="${classView.sign }"/>
                    <input type="hidden" name="id" id="sutdentId" value=""/>
                    <div class="form-group">
                        <div class="controls">
                            <input class="form-control" id="remarks" name="remarks">
                            <div class="help-block">请填写学员的备注信息</div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary pull-right">保存</button>
                        <button type="button" class="btn btn-link pull-right" data-dismiss="modal">取消</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function(){
        var upload = "${upload}";
        if(upload==1){
            $('#import-students').modal();
            document.getElementById("batch_import").onclick();
        }
    });
    function searchInfo(value){
        $.ajax({
            url:"${pageContext.request.contextPath}/user_study/select_user.action",
            data:{
                user_id : value,
                source_id : "${classView.id }",
                source_type : "${classView.source_type }"
            },
            dataType:"json",
            success:function(d){
                var userHtml;
                if(d!=0){
                    userHtml="<tr>"+
                    "<th width=\"25%;\">用户名</th>"+
                    "<td width=\"75%;\"><a class=\"pull-right\" target=\"blank\" href=\"javascript:void(0);\">个人主页</a>"+d[0].userName+"</td>"+
                    "</tr><tr>"+
                    "<th width=\"25%;\">Email</th><td width=\"75%;\">"+d[0].email+"</td>"+
                    "</tr><tr>"+
                    "<th width=\"25%;\">姓名</th><td width=\"75%;\">"+d[0].realName+"</td>"+
                    "</tr><tr>"+
                    "<th width=\"25%;\">性别</th><td width=\"75%;\">"+d[0].sex+"</td>"+
                    "</tr><tr>"+
                    "<th width=\"25%;\">财富</th><td width=\"75%;\">"+d[0].wealth+"</td>"+
                    "</tr><tr>"+
                    "<th width=\"25%;\">积分</th><td width=\"75%;\">"+d[0].score+"</td>"+
                    "</tr><tr>"+
                    "<th width=\"25%;\">备注</th><td width=\"75%;\">"+d[0].remarks+"</td>"+
                    "</tr><tr>"+
                    "<th width=\"25%;\">职业</th><td width=\"75%;\">"+d[0].userType+"</td>"+
                    "</tr><tr>"+
                    "<th width=\"25%;\">电话</th><td width=\"75%;\">"+d[0].phone+"</td>"+
                    "</tr>";
                }else{
                    userHtml="<tr class='empty'>暂无数据！</tr>";
                }
                $("#userInfo").empty().append(userHtml);
            }
        });
    }

    function deleteStudent(value){
        var result = confirm('真的要移除该学员吗？');
        if(result){
            $.ajax({
                url : '${pageContext.request.contextPath}/user_study/out_study.action',
                data : {
                    id : value,
                    reson : "4"
                },
                dataType : 'json',
                success : function(response) {
                    location.replace(location.href);
                }
            });
            /*  window.location.href="${pageContext.request.contextPath}/user_study/delete_student.action?id="+value+"&sourceId="+${classView.id }+"&sign="+${classView.sign }+"&sourceType="+${classView.source_type }; */
        }
    }

    function doReamrks(idVal,remVal){
        $("#remarks-model").modal();
        $("#sutdentId").val(idVal);
        $("#remarks").val(remVal);
    }

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
            pageSize:  $("#rows").val(),            //一页记录数
            onPageChange: function (page) {
                document.title = page;
                $("#page").val(page-1);
                $('#studentForm').submit();

            }
        });
    });
    var studentVal = false;
    function validateStudent(){
    	$("#verify_msg").html("")
        var student = $("#student_").val();
        if(student==""){
            $("#verify_msg").html("请输入学员!");
            $(".help-block").hide();
            return;
        }else if(student=="<%=user.getUsername()%>"){
            $("#verify_msg").html("该用户是本课程的教师，不能添加!");
            $(".help-block").hide();
            return;
        }else{
            $.ajax({
                url:"${pageContext.request.contextPath}/user/search_user.action",
                data:{
                    username : student,
                    usertype : "all"
                },
                dataType:"json",
                success:function(d){
                    if(d!=0){
                        $.ajax({
                            url:"${pageContext.request.contextPath}/user_study/verify_student.action",
                            data:{
                                userId : d[0].id,
                                learnId : $("#learn_id").val(),
                                sourceType : "0"
                            },
                            dataType:"json",
                            success:function(data){
                                if(data.num>0){
                                    $("#verify_msg").html("该用户已加入该课的班级了");
                                    $(".help-block").hide();
                                    return;
                                }
                            }
                        });
                        $("#userId").val(d[0].id);
                        $(".help-block").hide();
                        studentVal = true;
                    }else{
                        $("#verify_msg").html("该用户不存在!");
                        $("#userId").val("");
                        studentVal = false;
                        $(".help-block").hide();
                        return;
                    }
                }
            });
        }
    }
    function validate(){
        var student = $("#student_").val();
        var student_val = false;
        if(student==""){
            $(".student_val").empty().append("请输入学员!").css("display","");

            $(".s_val").css("display","none");
        }else{
            if(studentVal){
                $(".student_val").css("display","none");
                $(".s_val").css("display","");
                student_val =  true;
            }
        }
        return student_val;
    }

    function doSubmit(){
        var val = validate();
        if(val){
            document.getElementById('save_student').submit(); 
        }else{
            return false;
        }
    }

    //上传文件
    function doUpload(){
        var uploader = WebUploader.create({
            auto: true,
            // swf文件路径
            swf: '${pageContext.request.contextPath}/frontstage/js/webuploader/Uploader.swf',
            // 文件接收服务端。
            server: '${pageContext.request.contextPath}/cert_model/upload_img.action?realpath=userStudyExcel',
            // 选择文件的按钮。可选。
            // 内部根据当前运行是创建，可能是input元素，也可能是flash.
            pick: '#uploadFile',

            // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
            resize: false,
            accept: {
                extensions: 'xls,xlsx',
                mimeTypes: '.xls,.xlsx'   //修改这行
            }
        });
        /**
         *上传成功后
         *file:文件
         *response:服务器返回
         */
        uploader.on( 'uploadSuccess', function( file,response  ) {
            $("#filepath").val(response.filepath);
            $("#filename").val(response.filename);
            $("#uploadFile").hide();
            $("#fileList").empty().append('<div class="text-center" style="font-size: 16px;">'+response.filename+'文件上传成功</div>');
            $("#import_student_form").show();
        });
    }
    $('#start-import-btn').click(function(){
        var filepath = $("#filepath").val();
        if(!filepath){
            $('#nofilepath').show();
            return false;
        }
        $('#import-students').hide();
        $('.modal-backdrop').remove();
        $.ajax({
            url : "${pageContext.request.contextPath}/user_study/verify_data.action?sourceId=${classView.id}&sourceType=${classView.source_type}&learnId=${classView.source_id}&sign=${classView.sign}",
            data : $("#import_student_form").serialize(),//将表单数据序列化
            type : "POST",
            dataType : "json",
            /* async: false,  */
            success:function(result){
                /* window.location.reload(true);  */
                var nothing = result.nothing;
                var existing = result.existing;
                var userIds = result.userIds;
                var msg = result.msg;
                $('#import-students-second').modal();
                $('#import_msg').empty();
                if(!nothing&&!existing&&!msg){
                    var html = '<h4 class="text-center text-info" style="margin-top: 60px;">数据验证正确!</h4>';
                    $('#import_msg').append(html);
                    $('#import_failure').hide();
                    $('#batch_save').show();
                    $('#userIds').val(userIds);
                }
                if(nothing){
                    var html = '<div class="text-center text-warning">信息有误,第'+nothing+'行用户数据不存在,请检查</div>';
                    $('#import_msg').append(html);
                }
                if(existing){
                    var html = '<div class="text-center text-warning">信息有误,第'+existing+'行用户数据已存在,请检查</div>';
                    $('#import_msg').append(html);
                }
                if(msg){
                    var html = '<div class="text-center text-danger">信息有误,'+msg+'</div>';
                    $('#import_msg').append(html);
                }
            }
        });
    });
    $('#reUpload').click(function(){
        window.location.href = "${pageContext.request.contextPath}/user_study/to_class_student_manage.action?id=${classView.id}&flag=2&sign=4&sourceId=${classView.source_id}&sourceType=${classView.source_type}&upload=1";
    })

</script>


