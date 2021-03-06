<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>
<link rel="stylesheet" media="screen" href="http://scc1a8b2s6-static.qiqiuyun.net/assets/css/common.css?7.5.5" />
<style>
    li{list-style: none;}
</style>
<script>
    $(function(){
        $(".unfold").click(function(){
            if($(this).find("i").hasClass("glyphicon-chevron-down")){
                $(this).find("i").removeClass("glyphicon-chevron-down").addClass("glyphicon-chevron-right");

                $(this).parent().parent().nextUntil("li.list_index").slideUp();
            }else if($(this).find("i").hasClass("glyphicon-chevron-right")){
                $(this).find("i").removeClass("glyphicon-chevron-right").addClass("glyphicon-chevron-down");
                $(this).parent().parent().nextUntil("li.list_index").slideDown();
            }

        })
    })
</script>
<div class="cn-wrap">

    <div id="content-container" class="container">
        <c:if test="${source_type==0}"><jsp:include page="community_header.jsp"></jsp:include></c:if>
        <c:if test="${source_type==1}"><jsp:include page="workshop_header.jsp"></jsp:include></c:if>

        <div class="row">

            <c:if test="${source_type==0}"><jsp:include page="community_left.jsp"></jsp:include></c:if>
            <c:if test="${source_type==1}"><jsp:include page="workshop_left.jsp"></jsp:include></c:if>

            <div class="col-md-9">

                <div class="panel panel-default panel-col">
                    <div class="panel-heading">课程分类管理
                        <a href="javascript:void(0)" onclick="addClassify(0,0,0);" data-toggle="modal" class="btn btn-info pull-right">添加分类</a>
                    </div>
                    <c:if test="${!empty classifyList }">
                        <div class="panel-body">
                            <form id="searchInfo" method="post" action="${pageContext.request.contextPath}/classify_relation/to_classif_manager.action" class="form-horizontal form-inline well well-sm" >
                                <input type="hidden" name="id"  <c:if test="${source_type==0}">value="${communityView.id}"</c:if><c:if test="${source_type==1}">value="${workshopView.id}"</c:if>/>
                                <input type="hidden" name="source_id"  <c:if test="${source_type==0}">value="${communityView.id}"</c:if><c:if test="${source_type==1}">value="${workshopView.id}"</c:if>/>
                                <input type="hidden" name="source_type"  value="${source_type}"/>
                                <input type="hidden" name="type"  value="${type}"/>
                                <input type="hidden" name="stamp" <c:if test="${source_type==0}">value="${communityView.stamp}"</c:if><c:if test="${source_type==1}">value="${workshopView.stamp}"</c:if>/>
                                <input type="hidden" name="page" id="page" value="${classifyRelation.page}"/>
                                <input type="hidden" name="rows" id="rows" value="${classifyRelation.rows}"/>
                                <input type="hidden" name="total" id="total" value="${classifyRelation.total}"/>
                                <input type="hidden" name="totalPage" id="totalPage" value="${classifyRelation.totalPage}"/>
                                    <%-- <div class="form-group">
                                        <input type="text"   class="form-control" name="title" value="${messageView.title}" placeholder="标题">
                                        <button type="submit" class="btn btn-primary btn-sm" >搜索</button>
                                    </div> --%>
                            </form>
                            <div class="row">
                                <div class="td col-md-7">名称</div>
                                <div class="td col-md-2">编号</div>
                                <div class="td col-md-3">操作</div>
                            </div>

                            <ul class="list-table sortable-list">
                                <c:forEach items="${classifyList}" var="classify">
                                    <li  class="tr list_index"  style="display: block">
                                        <div class="row row-expand">
                                            <div class="td col-md-7 name unfold" >
                                                <c:if test="${!empty classify.sonClassifys}">
                                                    <i class="list-table-tree-icon glyphicon glyphicon-chevron-down"></i>
                                                </c:if>
                                                    ${classify.name}
                                            </div>
                                            <div class="td col-md-2 code">${classify.code}</div>
                                            <div class="td col-md-3 operation pull-right" >
                                                <a href="javascript:;" onclick="addClassify(<c:if test="${empty classify.sonClassifys}">0</c:if><c:if test="${!empty classify.sonClassifys}">1</c:if>,1,${classify.id});" class="btn btn-default btn-sm " data-toggle="modal" >
                                                    <i class="glyphicon glyphicon-edit"></i> 编辑
                                                </a>
                                                    <%--  <c:if test="${empty classify.sonClassifys}"> --%>
                                                <a href="javascript:;" onclick="addClassify(0,2,${classify.id});" class="btn btn-default btn-sm"  data-toggle="modal" >
                                                    <i class="glyphicon glyphicon-plus"></i> 添加子分类</a>
                                            </div>
                                        </div>
                                    </li>
                                    <%-- <c:if test="${!empty classify.sonClassifys}" > --%>
                                    <c:forEach items="${classify.sonClassifys}" var="sonClassify">
                                        <li class="tr list_son "  style="border: none;">
                                            <div class="row row-expand">
                                                <div class="td col-md-7 name" style="padding-left: 40px;">
                                                        ${sonClassify.name}
                                                </div>
                                                <div class="td col-md-2 code">${sonClassify.code}</div>
                                                <div class="td col-md-3 operation pull-right" >
                                                    <a href="javascript:;" onclick="addClassify(0,3,${sonClassify.id});" class="btn btn-default btn-sm "  data-toggle="modal" data-target="#modal">
                                                        <i class="glyphicon glyphicon-edit"></i> 编辑
                                                    </a>
                                                </div>
                                            </div>
                                        </li>
                                    </c:forEach>
                                </c:forEach>
                            </ul>


                            <div id="test" class="pager" style="padding-top: 10px;"></div>

                        </div>
                    </c:if>

                    <c:if test="${empty classifyList }">
                        <div class="empty">怎么还没有任何分类，快去添加分类吧！</div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>



<div class="modal " id="add_son" role="dialog" aria-hidden="false" style="display: none;">
    <div class="modal-dialog ">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span><span class="sr-only">Close</span>
                </button>
                <h4 class="modal-title" id="h4_title"></h4>
            </div>
            <div class="modal-body">
                <form id="classifyForm" class="form-horizontal lesson-form lesson-form-video" action="${pageContext.request.contextPath}/classify_relation/save_classify.action" method="post">
                    <input type="hidden" name="stamp" <c:if test="${source_type==0}">value="${communityView.stamp}"</c:if><c:if test="${source_type==1}">value="${workshopView.stamp}"</c:if>>
                    <input type="hidden" name="source_id" <c:if test="${source_type==0}">value="${communityView.id}"</c:if><c:if test="${source_type==1}">value="${workshopView.id}"</c:if>>
                    <input type="hidden" name="id" id="classify_id">
                    <input type="hidden" name="source_type" value="${source_type}">
                    <input type="hidden" name="parent_id" id="parent_id">
                    <input type="hidden" name="type" value="${type}">
                    <div class="form-group" >
                        <div class="col-md-2 control-label"><label><span class="text-danger">*</span>名称:</label></div>
                        <div class="col-md-8 controls">
                            <input class="form-control"  type="text" name="name" id="name">
                            <div class="help-block" style="display: none;">
                                <span class="text-danger">请输入名称</span>
                            </div>
                        </div>
                    </div>

                    <div class="form-group" >

                        <div class="col-md-2 control-label"><label><span class="text-danger">*</span>编号:</label></div>
                        <div class="col-md-8 controls">
                            <input class="form-control"  name="code" id="code">
                            <div class="help-block" style="display: none;">
                                <span class="text-danger">请输入编码</span>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-md-2 control-label"><label><span class="text-danger">*</span>分类描述:</label></div>
                        <div class="col-md-8 controls">
                            <textarea class="form-control" rows="4" name="remarks" id="remarks"></textarea>
                        </div>
                    </div>


                    <div class="modal-footer">
                        <button id="del_classify" type="button" style="display: none;" class="btn btn-default pull-left delete-category" ><i class="glyphicon glyphicon-trash"></i> 删除</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="submit" class="btn btn-primary">保存</button>
                    </div>

                </form>

            </div>

        </div>
    </div>
</div>
<script>

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
                $('#searchInfo').submit();

            }
        });
    });
    $(document).ready(function() {
        $('#classifyForm').bootstrapValidator({
            message: '此值无效',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                name: {
                    message: '分类名称验证失败',
                    validators: {
                        notEmpty: {
                            message: '分类名称不能为空'
                        }
                    }
                },code: {
                    message: '分类编码验证失败',
                    validators: {
                    	digits: { message: '只能是自然数'},
                        notEmpty: {
                            message: '分类编码不能为空'
                        }
                    }
                }
            }
        }).on('success.form.bv', function(e) {
            if(e.type){//验证成功
                document.getElementById('classifyForm').submit();
            }else{
                // 防止表单提交
                e.preventDefault();
            }
        });
    });
    function addClassify(del,status,id){
        var modal_title = "";
        var source_id = "";
        var source_type = "${source_type}";
        $("#del_classify").attr("onclick","delClassify("+del+","+id+")");
        if(source_type==0){
        	source_id = "${communityView.id}";
        }else if(source_type==1){
        	source_id = "${workshopView.id}";
        }
        if(status==0){
            modal_title += "添加分类";
            ajaxGetSeq(source_id,source_type);
        }else if(status==1){
            modal_title += "编辑分类";
            ajaxQueryOne(id)
            $("#del_classify").show();
        }else if(status==2){
            modal_title += "添加子分类";
            $("#parent_id").val(id);
            ajaxGetSeq(source_id,source_type,id);
        }else if(status==3){
            modal_title += "编辑子分类";
            ajaxQueryOne(id)
            $("#del_classify").show();
        }
        $("#h4_title").html(modal_title);
        $("#add_son").modal();
    }
    function ajaxGetSeq(){
    	$.ajax({
            url : "${pageContext.request.contextPath}/classify_relation/get_max_seq.action",
            dataType : "json",
            async : false,
            data : {
                source_id : arguments[0],
                source_type : arguments[1],
                parent_id : arguments[2]
            },
            success : function(data){
            	if(data!=""){
            		$("#code").val(data*1+1);
            	}else{
            		$("#code").val(0);
            	}
                
            }
        })
    }
    function ajaxQueryOne(id){
        $.ajax({
            url : "${pageContext.request.contextPath}/classify_relation/query_one_classify.action",
            dataType : "json",
            data : {
                id : id
            },
            success : function(data){
                var classify = data.classify;
                $("#classify_id").val(classify.id);
                $("#name").val(classify.name);
                $("#code").val(classify.code);
                $("#remarks").val(classify.remarks);
            }
        })
    }
    function delClassify(del,id){
        var warnning = "您确定要删除吗？";
        if(del==1){
            warnning += "您将会删除子类。";
        }
        if(confirm(warnning)){
            if("${source_type}"==0){
                window.location.href="${pageContext.request.contextPath}/classify_relation/del_sort.action?id="+id+"&source_id=${communityView.id}&source_type=${source_type}&stamp=${communityView.stamp}&type=${type}";
            }else if("${source_type}"==1){
                window.location.href="${pageContext.request.contextPath}/classify_relation/del_sort.action?id="+id+"&source_id=${workshopView.id}&source_type=${source_type}&stamp=${workshopView.stamp}&type=${type}";
            }
        }
    }
</script>
