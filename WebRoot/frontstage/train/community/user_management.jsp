<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>


<link href="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.js"></script>
<style>
    .course-meta>span{z-index:100;color:#02b980;font-size:30px;}
    .compulsory-course-list{width: 150px;float: left;margin-right: 20px;min-height: 155px;}
    .compulsory-course-list>li{cursor: pointer;}
</style>
<div class="cn-wrap">

    <div id="content-container" class="container">

        <c:if test="${source_type==0}"><jsp:include page="community_header.jsp"></jsp:include></c:if>
        <c:if test="${source_type==1}"><jsp:include page="workshop_header.jsp"></jsp:include></c:if>

        <div class="row">

            <c:if test="${source_type==0}"><jsp:include page="community_left.jsp"></jsp:include></c:if>
            <c:if test="${source_type==1}"><jsp:include page="workshop_left.jsp"></jsp:include></c:if>
            <div class="col-md-9">

                <div class="panel panel-default panel-col">
                    <div class="panel-heading">用户管理
                        <div class="panel-bar">
                            <a class="btn btn-info btn-sm mhs" data-toggle="modal" href="#add-users" >
                                <i class="glyphicon glyphicon-plus"></i> 添加用户
                            </a>
                            <a href="#import-users" data-toggle="modal" onclick="doUpload();" class="btn btn-info btn-sm">
                                <i class="glyphicon glyphicon-import"></i>
                                批量导入
                            </a>
                            <a onclick="batch_export();" href="javascript:void(0);" data-toggle="modal"  class="btn btn-info btn-sm ">
                                <i class="glyphicon glyphicon-export"></i> 批量导出用户
                            </a>
                        </div>
                    </div>

                    <c:if test="${!empty studentList }">
                        <div class="panel-body">
                            <form id="studentForm" method="post" action="${pageContext.request.contextPath}/student_relation/to_student_relation_manager.action"  class="form-horizontal" >
                                <div class="form-group">
                                    <div class="col-md-4 controls">
                                        <input type="text" id="keyword"  name="username" class="form-control" value="${studentRelationView.username}" placeholder="请输用户名称">
                                    </div>
                                    <div class="col-md-2 controls">
                                        <button type="submit" class="btn btn-primary">搜索</button>
                                    </div>

                                </div>
                                <input type="hidden" name="id"  <c:if test="${source_type==0}">value="${communityView.id}"</c:if><c:if test="${source_type==1}">value="${workshopView.id}"</c:if>/>
                                <input type="hidden" name="source_id"  <c:if test="${source_type==0}">value="${communityView.id}"</c:if><c:if test="${source_type==1}">value="${workshopView.id}"</c:if>/>
                                <input type="hidden" name="source_type"  value="${source_type}"/>
                                <input type="hidden" name="stamp" <c:if test="${source_type==0}">value="${communityView.stamp}"</c:if><c:if test="${source_type==1}">value="${workshopView.stamp}"</c:if>/>
                                <input type="hidden" name="page" id="page" value="${studentRelationView.page}"/>
                                <input type="hidden" name="rows" id="rows" value="${studentRelationView.rows}"/>
                                <input type="hidden" name="total" id="total" value="${studentRelationView.total}"/>
                                <input type="hidden" name="totalPage" id="totalPage" value="${studentRelationView.totalPage}"/>
                            </form>
                            <table class="table">

                                <tbody>
                                <tr class="border">
                                    <th  width="4%"><input class="checkAll subCheckbox" type="checkbox"></th>
                                    <th  width="30%">用户名称</th>
                                    <th  width="30%">身份</th>
                                    <th>
                                        操作
                                    </th>
                                </tr>
                                </tbody>
                                <c:forEach items="${studentList}" var="student">
                                    <tr>
                                        <td><input class="subCheckbox"  value="${student.id}" type="checkbox"></td>
                                        <td>${student.username}</td>
                                        <td><c:choose>
                                            <c:when test="${student.role_type==0}">管理员</c:when>
                                            <c:when test="${student.role_type==1}">专家<c:if test="${student.level != null&&student.level !=0}">(${student.level}级)</c:if></c:when>
                                            <c:when test="${student.role_type==2}">普通学员</c:when>
                                            <c:when test="${student.role_type==3}">坊主</c:when>
                                        </c:choose></td>
                                        <td>
                                            <div class="btn-group">

                                                <a class="btn btn-default btn-sm" data-toggle="modal" data-target="#private-modal" href="javascript:void(0);" onclick="send_private_messages(${student.user_id },'${student.username }')">
                                                    发私信
                                                </a>
                                                <button class="btn btn-default btn-sm" data-toggle="modal" data-target="#personal-info" onclick="searchInfo(${student.user_id});" type="button">查看资料</button>
                                                <a href="javascript:void(0);" type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" >管理
                                                    <span class="caret"></span>
                                                </a>
                                                <ul class="dropdown-menu pull-right" role="menu">
                                                    <c:if test="${student.role_type==1 }">
                                                        <li><a data-toggle="modal" href="javascript:void(0);" onclick="setExpertStar(${student.id},${student.level});">设置专家星级</a></li>
                                                    </c:if>
                                                    <c:if test="${source_type==0&&student.role_type!=0}">
                                                        <li><a class="" href="${pageContext.request.contextPath}/student_relation/save_student.action?source_id=${communityView.id}&stamp=${communityView.stamp}&source_type=${source_type}&id=${student.id}&role_type=0" >设置为管理员</a></li>
                                                    </c:if>
                                                    <c:if test="${student.role_type!=1}">
                                                        <li><a data-toggle="modal" href="javascript:void(0);" onclick="setExpertStar(${student.id},${student.level});">设置为专家</a></li>
                                                    </c:if>
                                                    <c:if test="${student.role_type!=2}">
                                                        <li><a class="" href="${pageContext.request.contextPath}/student_relation/save_student.action?<c:if test="${source_type==0}">source_id=${communityView.id}&stamp=${communityView.stamp}</c:if><c:if test="${source_type==1}">source_id=${workshopView.id}&stamp=${workshopView.stamp}</c:if>&source_type=${source_type}&id=${student.id}&role_type=2" >设置为普通学员</a></li>
                                                    </c:if>
                                                    <c:if test="${source_type==1&&student.role_type!=3}">
                                                        <li><a class="" href="${pageContext.request.contextPath}/student_relation/save_student.action?source_id=${workshopView.id}&stamp=${workshopView.stamp}&source_type=${source_type}&id=${student.id}&role_type=3" >设置为坊主</a></li>
                                                    </c:if>
                                                    <li><a href="${pageContext.request.contextPath}/student_relation/del_student.action?<c:if test="${source_type==0}">source_id=${communityView.id}&stamp=${communityView.stamp}</c:if><c:if test="${source_type==1}">source_id=${workshopView.id}&stamp=${workshopView.stamp}</c:if>&source_type=${source_type}&id=${student.id}" >移除</a></li>
                                                </ul>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <c:if test="${empty studentList }">
                                <div class="empty">暂无数据</div>
                            </c:if>


                            <div id="test" class="pager" style="padding-top: 10px;"></div>


                        </div>
                    </c:if>
                    <c:if test="${empty studentList }">
                        <div class="empty">怎么会还没有用户，快去添加用户，增加用户活跃度吧！</div>
                    </c:if>
                </div>
            </div>

        </div>
    </div>
</div>

<!--查看个人信息-->
<div id="personal-info" class="modal" aria-hidden="false" style="display: none;" role="dialog">
    <div class="modal-dialog ">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">个人详细信息</h4>
            </div>
            <div class="modal-body">
                <table class="table table-striped table-condenseda table-striped">
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


<!--添加用户-->
<div id="add-users" class="modal in" data-toggle="modal" style="display: none" aria-hidden="false">
    <div class="modal-dialog  modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">添加学员</h4>
            </div>
            <div class="modal-body">
                <form  class="form-horizontal" id="studentAddForm" method="post" action="${pageContext.request.contextPath}/student_relation/save_student.action" novalidate="novalidate">
                    <input type="hidden" name="user_id" id="user_id">
                    <input type="hidden" name="source_id" id="source_id" <c:if test="${source_type==0}">value="${communityView.id}"</c:if><c:if test="${source_type==1}">value="${workshopView.id}"</c:if>>
                    <input type="hidden" name="source_type" id="source_type"  value="${source_type}">
                    <input type="hidden" name="stamp" <c:if test="${source_type==0}">value="${communityView.stamp}"</c:if><c:if test="${source_type==1}">value="${workshopView.stamp}"</c:if>>
                    <input type="hidden" name="role_type" value="2">
                    <div class="form-group">
                        <div class="col-md-2 control-label">
                            <label>学员</label>
                        </div>
                        <div class="col-md-7 controls">
                            <input name="student" type="text" class="form-control" onblur="validateStudent();" id="student_" placeholder="邮箱/手机/用户名"><i style="font-size: 14px;color: red" id="verify_msg"></i>
                            <div class="help-block">只能添加系统中已注册的用户</div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-md-2 control-label">
                            <label >备注</label>
                        </div>
                        <div class="col-md-7 controls">
                            <input type="text"  class="form-control">
                            <div class="help-block">选填</div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary pull-right" onclick="doSubmit();" data-dismiss="modal" >保存</button>
                        <button type="button" class="btn btn-link pull-right" data-dismiss="modal">取消</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


<!--导入用户-->
<div id="import-users" class="modal " data-toggle="modal" style="display: none;" aria-hidden="false">
    <div class="modal-dialog ">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">导入用户</h4>
            </div>
            <!--步骤1-->
            <div class="modal-body" id="step1">

                <h1 class="pull-left">步骤1</h1>
                <div style="clear: both;margin-top: 30px;">
                    <a href="${pageContext.request.contextPath}/frontstage/train/community/student_relation_demo.xls">点击下载示例说明文件</a>
                </div>

                <div id="fileList" style="clear: both;">
                    <div id="uploadFile" class="text-center" >

                        <button class="btn btn-info btn-lg" type="button">
                            <i class="glyphicon glyphicon-plus"></i>添加
                        </button>

                    </div>
                </div>
                <form id="import_student_form" style="display: none"  method="post" class="form-horizontal"  novalidate="novalidate">
                    <div class="form-group">
                        <div class="col-md-4 controls col-md-offset-5" style="margin-left: 222px;">
                            <input type="hidden" id="filepath" name="filepath">
                            <input type="hidden" id="filename" name="filename">
                            <input type="hidden" name="source_id" <c:if test="${source_type==0}">value="${communityView.id}"</c:if><c:if test="${source_type==1}">value="${workshopView.id}"</c:if>>
                            <input type="hidden" name="source_type" value="${source_type}">
                            <div id="nofilepath" style="display: none" class="help-block">请导入Excel类型文件</div>
                            <button type="button" class="btn btn-primary" id="start-import-btn" style="margin-top: 30px;">开始校验数据</button>
                        </div>
                    </div>
                </form>
            </div>

            <!--步骤2-->
            <div class="modal-body" id="step2" style="display: none;">
                <h1 class="pull-left">步骤2</h1>
                <div class="text-center" id="verify_info">
                    <!--数据正确时 h4标签class为 text-info,数据有误时 class为 text-danger -->
                    <!-- <h4 class="text-center text-danger" style="margin-top: 60px;">数据错误</h4> -->

                </div>
                <div id="import_failure" class="col-md-2 controls col-md-offset-5" style="margin-top: 60px;">
                    <button type="submit" class="btn btn-primary" id="reUpload">重新导入</button>
                </div>
            </div>

            <div class="modal-footer">
                <form  action="${pageContext.request.contextPath}/student_relation/batch_save_student.action?source_type=${source_type}&<c:if test="${source_type==0}">source_id=${communityView.id}&stamp=${communityView.stamp}</c:if><c:if test="${source_type==1}">source_id=${workshopView.id}&stamp=${workshopView.stamp}</c:if>" method="post" novalidate="novalidate">
                    <!--导入用户数据正确  保存按钮才出现-->
                    <input type="hidden" id="userIds" name="userIds">
                    <input type="hidden" id="roletypes" name="roletypes">
                    <input type="hidden" id="remarks" name="remarks">
                    <button type="submit" id="batch_save" class="btn btn-primary pull-right" style="display: none;">保存</button>
                    <button type="button" class="btn btn-link pull-right" data-dismiss="modal">取消</button>
                </form>
            </div>

        </div>
    </div>
</div>

<!--设置专家星级-->
<div id="set_expert_star" class="modal" aria-hidden="false" style="display: none;" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">设置专家星级</h4>
            </div>

            <div class="modal-body">
                <form id="set_star_level" class="form-horizontal form-inline" action="${pageContext.request.contextPath}/student_relation/save_student.action" method="post">
                    <input name="source_id" type="hidden" <c:if test="${source_type==0}">value="${communityView.id}"</c:if><c:if test="${source_type==1}">value="${workshopView.id}"</c:if>>
                    <input name="stamp" type="hidden" <c:if test="${source_type==0}">value="${communityView.stamp}"</c:if><c:if test="${source_type==1}">value="${workshopView.stamp}"</c:if>/>
                    <input name="source_type" type="hidden" value="${source_type}">
                    <input name="id" type="hidden" id="expert_id" value="">
                    <input name="level" type="hidden" id="star_level" value="1">
                    <input name="role_type" type="hidden" id="expert_type" value="1">
                    <ul class="course-wide-list">
                        <li class="course-item  compulsory-course-list " value="1">
                            <h4 class="text-center" style="margin-top: 20px;">一星级</h4>
                            <div  style="margin-left: 15px;margin-top: 20px;">
                                <div class="metas text-center">
                                    <div class="score">
                                        <i class="es-icon es-icon-star color-warning"></i>
                                    </div>
                                </div>
                            </div>

                            <div class="course-footer clearfix text-center">
                                <div class="course-meta" >
                                    <span class="glyphicon glyphicon-ok" ></span>
                                </div>
                            </div>
                        </li>

                        <li class="course-item  compulsory-course-list " value="2">
                            <h4 class="text-center" style="margin-top: 20px;">二星级</h4>
                            <div  style="margin-left: 15px;margin-top: 20px;">
                                <div class="metas text-center">
                                    <div class="score">
                                        <i class="es-icon es-icon-star color-warning"></i>
                                        <i class="es-icon es-icon-star color-warning"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="course-footer clearfix text-center">
                                <div class="course-meta" style="display: none;">
                                    <span class="glyphicon glyphicon-ok" ></span>
                                </div>
                            </div>
                        </li>

                        <li class="course-item  compulsory-course-list " value="3">
                            <h4 class="text-center" style="margin-top: 20px;">三星级</h4>
                            <div  style="margin-left: 15px;margin-top: 20px;">
                                <div class="metas text-center">
                                    <div class="score">
                                        <i class="es-icon es-icon-star color-warning"></i>
                                        <i class="es-icon es-icon-star color-warning"></i>
                                        <i class="es-icon es-icon-star color-warning"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="course-footer clearfix text-center">
                                <div class="course-meta" style="display: none;">
                                    <span class="glyphicon glyphicon-ok" ></span>
                                </div>
                            </div>
                        </li>

                        <li class="course-item  compulsory-course-list " value="4">
                            <h4 class="text-center" style="margin-top: 20px;">四星级</h4>
                            <div  style="margin-left: 15px;margin-top: 20px;">
                                <div class="metas text-center">
                                    <div class="score">
                                        <i class="es-icon es-icon-star color-warning"></i>
                                        <i class="es-icon es-icon-star color-warning"></i>
                                        <i class="es-icon es-icon-star color-warning"></i>
                                        <i class="es-icon es-icon-star color-warning"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="course-footer clearfix text-center">
                                <div class="course-meta" style="display: none;">
                                    <span class="glyphicon glyphicon-ok" ></span>
                                </div>
                            </div>
                        </li>

                        <li class="course-item  compulsory-course-list " value="5">

                            <h4 class="text-center" style="margin-top: 20px;">五星级</h4>
                            <div  style="margin-left: 15px;margin-top: 20px;">
                                <div class="metas text-center">
                                    <div class="score">
                                        <i class="es-icon es-icon-star color-warning"></i>
                                        <i class="es-icon es-icon-star color-warning"></i>
                                        <i class="es-icon es-icon-star color-warning"></i>
                                        <i class="es-icon es-icon-star color-warning"></i>
                                        <i class="es-icon es-icon-star color-warning"></i>
                                    </div>
                                </div>

                            </div>

                            <div class="course-footer clearfix text-center">

                                <div class="course-meta" style="display: none;">
                                    <span class="glyphicon glyphicon-ok" ></span>
                                </div>

                            </div>
                        </li>


                    </ul>
                    <div class="modal-footer" style="border: none;">
                        <button type="button" class="btn btn-fat btn-info" onclick="set_expert_level();">保存</button>
                        <button type="button" class="btn btn-link" data-dismiss="modal">取消</button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>
<script>
    var studentIds = [];
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
        var student = $("#student_").val();
        if(student !=""){
        	$.ajax({
        		async : false,
                url:"${pageContext.request.contextPath}/student_relation/verify_student.action",
                data:{
                	username : student,
                    usertype : "all",
                    source_id : $("#source_id").val(),
                    source_type : $("#source_type").val()
                },
                dataType:"json",
                success:function(data){
                	if(data.d!=0){//
                        $("#verify_msg").html("");
                        if(data.num>0){
                            if(data.source_type==0){
                                $("#verify_msg").html("该用户已加入该社区");
                            }else if(data.source_type==1){
                                $("#verify_msg").html("该用户已加入该工作坊");
                            }
                        }else{
                            $("#user_id").val(data.user_id);
                            studentVal = true;
                            return true;
                        }
                	}else{
                		$("#verify_msg").html("").html("该用户不存在!");
                        return false;
                	}
                }
            }); 
        }
    }
    function doSubmit(){
        var student = $("#student_").val();
        if(student==""){
            $("#verify_msg").html("").html("请输入学员!");
            return false;
        }else{
            if(studentVal){
                document.getElementById('studentAddForm').submit();
            }
        }
    }
    function searchInfo(value){
        $.ajax({
            url:"${pageContext.request.contextPath}/user/select_user.action",
            data:{
                id : value
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
    //上传文件
    function doUpload(){
        var uploader = WebUploader.create({
            auto: true,
            // swf文件路径
            swf: '${pageContext.request.contextPath}/frontstage/js/webuploader/Uploader.swf',
            // 文件接收服务端。
            server: '${pageContext.request.contextPath}/cert_model/upload_img.action?realpath=studentExcel',
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
        $('#step1').hide();
        $('#step2').show();
        $.ajax({
            url : "${pageContext.request.contextPath}/student_relation/verify_data.action?sourceId=${classView.id}&sourceType=${classView.source_type}&learnId=${classView.source_id}&sign=${classView.sign}",
            data : $("#import_student_form").serialize(),//将表单数据序列化
            type : "POST",
            dataType : "json",
            /* async: false,  */
            success:function(result){
                /* window.location.reload(true);  */
                var nothing = result.nothing;
                var existing = result.existing;
                var userIds = result.userIds;
                var roletypes = result.roletypes;
                var remarks = result.remarks;
                var msg = result.msg;
                $('#verify_info').empty();
                if(!nothing&&!existing&&!msg){
                    var html = '<h4 class="text-center text-info" style="margin-top: 60px;">数据验证正确!</h4>';
                    $('#verify_info').append(html);
                    $('#import_failure').hide();
                    $('#batch_save').show();
                    $('#userIds').val(userIds);
                    $('#roletypes').val(roletypes);
                    $('#remarks').val(remarks);
                }
                if(nothing){
                    var html = '<div class="text-center text-danger">信息有误,第'+nothing+'行用户数据不存在,请检查</div>';
                    $('#verify_info').append(html);
                }
                if(existing){
                    var html = '<div class="text-center text-warning">信息有误,第'+existing+'行用户数据已存在,请检查</div>';
                    $('#verify_info').append(html);
                }
                if(msg){
                    var html = '<div class="text-center text-danger">信息有误,'+msg+'</div>';
                    $('#verify_info').append(html);
                }
            }
        });
    });
    $('#reUpload').click(function(){
        if("${source_type}"==0){
            window.location.href = "${pageContext.request.contextPath}/student_relation/to_student_relation_manager.action?id=${communityView.id}&source_id=${communityView.id}&source_type=${source_type}&stamp=6";
        }else if("${source_type}"==1){
            window.location.href = "${pageContext.request.contextPath}/student_relation/to_student_relation_manager.action?id=${workshopView.id}&source_id=${workshopView.id}&source_type=${source_type}&stamp=6";
        }
    })

    $(function(){
        // 全选
        $(".checkAll").click(function () {
            var isChecked = $(this).prop("checked");
            $(".subCheckbox").prop("checked", isChecked);
            studentIds = [];
            if(isChecked){
                $(".subCheckbox").each(function(){
                    var student_id = $(this).val();
                    if(student_id!="on"){
                        studentIds.push(student_id);
                    }
                })
            }
        })
        //单选
        $(".subCheckbox").click(function(){
            var isChecked = $(this).prop("checked");
            var student_id = $(this).val();
            if(student_id!="on"){
                if(isChecked){
                    studentIds.push(student_id);
                }else{
                    studentIds.splice($.inArray(student_id, studentIds), 1);
                    //$.inArray(student_id, studentIds)返回student_id在studentIds中的下标
                    //studentIds.splice(index,len,[item])index:数组开始下标        len: 替换/删除的长度       item:替换的值，删除操作的话 item为空
                }
            }

        })

    });
    function batch_export(){
        if(studentIds.length==0){
            window.location.href = "${pageContext.request.contextPath}/student_relation/export_student.action?<c:if test="${source_type==0}">source_id=${communityView.id}</c:if><c:if test="${source_type==1}">source_id=${workshopView.id}</c:if>&source_type=${source_type}";
        }else{
            var ids = "";
            for(var i=0;i<studentIds.length;i++){
                ids += studentIds[i]+",";
            }
            ids=ids.substring(0,ids.length-1);
            window.location.href = "${pageContext.request.contextPath}/student_relation/export_student.action?ids="+ids+"&<c:if test="${source_type==0}">source_id=${communityView.id}</c:if><c:if test="${source_type==1}">source_id=${workshopView.id}</c:if>&source_type=${source_type}";
        }
    }
    function setExpertStar(value,level){
        $("#set_expert_star").modal();
        $("#expert_id").val(value);
        $(".course-wide-list>li").each(function(){
            if($(this).index()==(level*1-1)){
                if($(this).find(".course-footer").find(".course-meta").css("display")=="none"){
                    $(this).click();
                }
            }
        })
    }

    //	给专家设置星级
    $(function(){
        $(".course-wide-list>li").click(function(){
            if($(this).find(".course-footer").find(".course-meta").css("display")=="none"){
                $(".course-wide-list>li").find(".course-footer").find(".course-meta").hide();
                $(this).find(".course-footer").find(".course-meta").show();
                $("#star_level").val($(this).val());
            } else{
                $(".course-wide-list>li").find(".course-footer").find(".course-meta").hide();
                $("#star_level").val("");
            }
        })
    });

    function set_expert_level(){
        var star_level = $("#star_level").val();
        if(star_level==""){
            alert("请设置专家等级！");
        }else{
            document.getElementById("set_star_level").submit();
        }
    }

</script>
