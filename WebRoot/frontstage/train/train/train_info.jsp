<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>
<%-- 
<link href="${pageContext.request.contextPath}/frontstage/js/JMEditor/style/default.css" rel="stylesheet" media="screen" type="text/css" />
<script type="text/javascript"src="${pageContext.request.contextPath}/frontstage/js/JMEditor/jmeditor/JMEditor.js"></script>
--%>
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/wangEditor/wangEditor.min.js"></script>
<div class="cn-wrap">

    <div id="content-container" class="container">

        <jsp:include page="train_header.jsp"></jsp:include>

        <div class="row">

            <jsp:include page="train_left.jsp"></jsp:include>

            <div class="col-md-9">

                <div class="panel panel-default panel-col">
                    <div class="panel-heading">基本信息</div>
                    <form class="form-horizontal" method="post" id="trainInfo" action="${pageContext.request.contextPath}/train/save_train.action">
                        <input type="hidden" name="id" value="${trainView.id }" <c:if test="${trainView.status ==1}">disabled="disabled"</c:if>/>
                        <input type="hidden" name="sign" value="${trainView.sign }" <c:if test="${trainView.status ==1}">disabled="disabled"</c:if>/>
                        <input type="hidden" name="type" value="${trainView.type }" <c:if test="${trainView.status ==1}">disabled="disabled"</c:if>/>
                        <input type="hidden" name="flag" value="1" <c:if test="${trainView.status ==1}">disabled="disabled"</c:if>/>
                        <div class="panel-body">
                            <div class="course_save_succ alert alert-success" <c:if test="${trainView.flag!=1}">style="display:none;"</c:if>>基本信息设置成功!</div>
                            <div class="row form-group">
                                <div class="col-md-2 control-label"><span class="text-danger">*</span>
                                    <label>名称</label>
                                </div>
                                <div class="controls col-md-8">
                                    <input name="name" type="text"  id="train_name" class="form-control" value="${trainView.name}" <c:if test="${trainView.status ==1}">disabled="disabled"</c:if>/>
                                    <div class="help-block" id="name_block" style="display:none;">
                                        <span class="text-danger">请输入名称</span>
                                    </div>
                                </div>
                            </div>

                            <div class="row form-group">

                                <div class="col-md-2 control-label"><span class="text-danger">*</span>
                                    <label >简介</label>
                                </div>
								<%-- 
                                <div class="controls col-md-8">
                                --%>
                                    <div id="profile" style="width:620px;margin-left:150px;" class="editDemo" <c:if test="${trainView.status ==1}">disabled="disabled"</c:if>>
                                    	${trainView.profile }
                                    </div>
                                    <%-- 
                                    <input <c:if test="${trainView.status ==1}">disabled="disabled"</c:if> type="hidden" name="profile" value='${trainView.profile }' />
                                    --%>
                                    <textarea style="display: none;" <c:if test="${trainView.status ==1}">disabled="disabled"</c:if> name="profile">
                                    	${trainView.profile }
                                    </textarea>
                                    <div class="help-block" id="profile_block" style="display:none;">
                                        <span class="text-danger">简介不能为空</span>
                                    </div>
                                    <script type="text/javascript">
	                                    var E = window.wangEditor;
	                                    var weditor = new E("#profile");
	                                    //保存图片到服务器
	                                    weditor.customConfig.uploadImgServer = "${pageContext.request.contextPath}/upload_file/upload_resource.action?source_id=${trainView.id}&source_type=1";
	                                    //限制图片大小
	                                    weditor.customConfig.uploadImgMaxSize = 3*1024*1024;
	                                    //图片上传上限
	                                    weditor.customConfig.uploadImgMaxLength = 1;
	                                    //隐藏"网络图片"选项
	                                    weditor.customConfig.showLinkImg = false;
	                                    weditor.create();
									</script>
                                </div>
                            <%-- 
                            </div>
							--%>
                            <div class="row form-group">
                                <div class="col-md-2 control-label"><span class="text-danger">*</span>
                                    <label >主办方</label>
                                </div>
                                <div class="controls col-md-8">
                                    <input name="sponsor" type="text"  id="train_sponsor" class="form-control" value="${trainView.sponsor}" <c:if test="${trainView.status ==1}">disabled="disabled"</c:if>/>
                                </div>
                            </div>
							<c:if test="${trainView.type==1}">
                            <div class="row form-group">
                                <div class="col-md-2 control-label">
                                    <label >是否按顺序学</label>
                                </div>
                                <div class="controls col-md-8 radios">
                                    <label> <input type="radio" value="0" name="is_sort" <c:if test="${trainView.is_sort==0}" >checked="checked"</c:if> <c:if test="${trainView.status ==1}">disabled="disabled"</c:if>> 是</label>
                                    <label> <input type="radio" value="1"  name="is_sort" <c:if test="${trainView.is_sort==1}" >checked="checked"</c:if> <c:if test="${trainView.status ==1}">disabled="disabled"</c:if>> 否</label>
                                </div>
                            </div>
							</c:if>
                            <div class="form-group">
                                <label class="col-md-2 control-label">分类</label>
                                <div class="col-md-8 controls radios">
                                    <select name="classify_id" id="classify_id" class="form-control width-input width-input-large" <c:if test="${trainView.status ==1}">disabled="disabled"</c:if>>
                                        <option value="-1">---请选择---</option>
                                        <c:forEach items="${classifyList}" var="pc">
                                            <option <c:if test="${trainView.classify_id==pc.id}">selected = "selected"</c:if>value="${pc.id}">${pc.classify_name}</option>";
                                        </c:forEach>
                                    </select>
                                    <div class="help-block" id="classify_block" style="display:none;">
                                        <span class="text-danger">请选择分类</span>
                                    </div>
                                </div>
                            </div>
                            
							<div class="form-group">
								<div class="col-md-2 control-label"><label>是否设置考核标准 </label></div>
								<div class="col-md-8 controls radios">
                                    <label> <input type="radio" <c:if test="${trainView.is_check==0}">checked="checked"</c:if> name="is_check" value="0" <c:if test="${trainView.status ==1}">disabled="disabled"</c:if>/>是</label>
                                    <label> <input type="radio" <c:if test="${trainView.is_check==1}">checked="checked"</c:if> name="is_check" value="1" <c:if test="${trainView.status ==1}">disabled="disabled"</c:if>/>否</label>
								</div>

							</div>

                            <div class="row form-group">
                                <div class="col-md-2 control-label"></div>
                                <div class="controls col-md-8  radios">
                                	<c:if test="${trainView.status !=1}">
                                    	<button type="button" class="btn btn-primary" onclick="doSave();">保存</button>
                               		</c:if>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

        </div>
    </div>
    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
</div>

<script type="text/javascript">
    $(function(){
        <%-- 
    	var profileVal = $("input[name='profile']").val();
        --%>
        <%--
        //给JMEditor赋值
        var editor = CKEDITOR.replace("profile",{
            skin: "moono-lisa",width:520, height:200,margin:"0,0,0,120"
        });
        --%>
        <%--
        if(profileVal!=''){
            //editor.setData(profileVal);
        	weditor.txt.html(profileVal);
        }
        --%>
        <%--
        $("#cke_profile").blur(function(){
            $("input[name='profile']").val(JMEditor.html('profile'));
        });
		--%>
        $("#train_name").blur(function(){
            validate();
        });
        $("#classify_id").blur(function(){
            validate();
        });
    });

    function validate(){
        var name = $("#name").val();
        var classify = $('#classify_id option:selected').val();
        var profile = $("textarea[name='profile']").val();
        var name_val = false;
        var classify_val = false;
        if(name==""){
            $("#name_block").show();
        }else{
            $("#name_block").hide();
            name_val =  true;
        }
        if(profile==""||profile==="<p><br></p>"){
        	$("#profile_block").show();
        	return false;
        }else{
        	$("#profile_block").hide();
        }
        if(classify==-1){
            $("#classify_block").show();
        }else{
            $("#classify_block").hide();
            classify_val = true;
        }
        if(name_val==true&&classify_val==true){
            return true;
        }else{
            return false;
        }
    }

    function doSave(){
        $("textarea[name='profile']").val(weditor.txt.html());
        var val = validate();
        if(val){
            document.getElementById('trainInfo').submit();
        }else{
            return false;
        }
    }
</script>



