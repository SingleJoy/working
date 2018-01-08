<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>
<link href="${pageContext.request.contextPath}/frontstage/css/upload_file.css?v.01" rel="stylesheet" type="text/css">



<script>
    $(document).ready(function(){
        $("#myNav").affix({
            offset: {
                top: 230
            }
        });
    });
    $(function () {
        $("li.list-group-item").click(function () {
            $(this).addClass("active").siblings().removeClass("active");
        })
    })

</script>


<div class="cn-wrap">

    <div class="cn-section" style="margin-top: 20px;padding: 0;">

        <div class="container">
            <input type="hidden" id="fileType" value="0"/>
            <div class="row">
                <div class="col-md-3">
                    <a class="pull-left link-dark" href="javascript:void(0);">
                        <label style="font-size: 18px;line-height: 88px;">上传资源</label>
                    </a>
                </div>

                <div class="upload_progress_all col-md-offset-3" style="margin-top: 20px;">

                    <div class="col-md-3 stage_step ">
                        <div class="circle active onePage" ><span >1</span></div>
                        <span class="active">选择文档</span>
                        <p class="stage_step_line" style="background-color: #3ebbce;"></p>
                    </div>

                    <div class="col-md-3 stage_step ">
                        <div class="circle twoPage <c:if test="${success_flag=='three'}"> active</c:if>" ><span >2</span></div>
                        <span class="<c:if test="${success_flag=='three'}"> active</c:if>">补充信息</span>
                        <p class="stage_step_line" <c:if test="${success_flag=='three'}"> style="background-color: #3ebbce;</c:if>"></p>
                    </div>

                    <div class="col-md-3 stage_step">
                        <div class="circle threePage <c:if test="${success_flag=='three'}"> active</c:if>" ><span >3</span></div>
                        <span class="">上传完成</span>

                    </div>

                </div>


            </div>
        </div>

    </div>

    <div id="content-container" class="container">

        <%--上传步骤显示--%>


        <%--一。。。选择文件资源--%>
        <div class="fistPage" style="margin-top:50px;" id="fistPage">

            <div class="panel panel-col"  <c:if test="${success_flag=='three'}"> style="display: none;"</c:if>>
                <div class="panel-body ">
                    <form class="form-horizontal" method="post" novalidate="novalidate" >
                   <div id="bootstrap-stream-container" class="form-group clearfix upload_video video_source col-md-12">
							
                  
                       	</div>
                        <h1 class="text-center choose" style="margin-top: 150px;">
                            <c:if test="${success }">上传成功,继续上传，或者<a style="color: blue;" href="${pageContext.request.contextPath}/resource_list/to_resource_list.action?stageId=XX">返回</a>主页</c:if>
                            <c:if test="${!success }"> 选择你要上传的类型</c:if>
                        </h1>

			
                        <div  style="margin-top: 60px;">
						
                            <div class="col-md-3 col-md-offset-3">
                                <a class="btn btn-info btn-block btn-lg" href="${pageContext.request.contextPath}/my_file_base/to_teaching_plan.action" style="padding: 20px 40px;font-size: 20px;">教案</a>
                            </div>

                            <div class="col-md-3">
                                <div id="i_select_files" style="cursor: pointer;" >
                                    <a class="btn btn-info btn-block btn-lg" href="javascript:void(0);" style="padding: 20px 40px;font-size: 20px;">普通文档</a>

                                </div>
                                <div id="i_stream_files_queue" ></div>

                            </div>
                        </div>


                    </form>

                </div>

                <div  class="controls  col-md-4 col-md-offset-5" style="margin-top: 50px;">



                </div>
            </div>

        </div>

        <%--二。。。填写文件资源信息--%>
        <div class="stage_tow" style="display:none;margin-top: 50px;" id="stage_tow" >
            <div class="row">
                <form class="form-horizontal" id="saveFile" action="${pageContext.request.contextPath}/my_file_base/save_file.action" method="post">
                    <input type="hidden" name="name" id="name"/>
                    <input type="hidden" name="path" id="path"/>
                    <input type="hidden" name="length" id="length">
                    <input type="hidden" name="image" id="image">
                    <div class="panel-heading" style="display: none;">填写信息</div>
                    <div class="upload_file_advice" ></div>

                    <div class="col-md-3 col-lg-3 container-fluid-content" id="myScrollspy">

                        <div class="container-fluid" >

                            <div class="container-fluid " data-spy="affix"  id="myNav" data-offset-top="20" >

                                <ul class="list-group container-fluid-list" >

                                    <li class="list-group-item active" ><a href="#section1"> 文件名称</a></li>
                                    <li class="list-group-item "><a href="#section2">资源简介</a></li>
                                    <li class="list-group-item "><a href="#section3">所属学段</a></li>
                                    <li class="list-group-item" ><a href="#section4">所属科目</a></li>
                                    <li class="list-group-item" ><a href="#section5">教材版本</a></li>
                                    <li class="list-group-item" ><a href="#section6">资源分类</a></li>
                                    <li class="list-group-item" ><a href="#section7">资源类型</a></li>
                                    <li class="list-group-item" ><a href="#section8">发布范围</a></li>
                                    <li class="list-group-item" ><a href="#section9">保存</a></li>

                                </ul>
                            </div>

                        </div>
                    </div>

                    <div class=" col-md-9 col-lg-9" >

                        <div class="panel panel-col" id="fielPages">

                        </div>

                    </div>

                </form>


            </div>
        </div>

        <%--三。。。上传成功--%>
        <div style="margin: 50px auto;" class="threePage">

            <div class="panel panel-col" id="threePage" <c:if test="${success_flag!='three'}"> style="display: none;"</c:if>>
                <div class="panel-body">
                    <form class="form-horizontal" method="post" novalidate="novalidate" >

                        <h1 class="text-center text-success" style="margin-top: 80px;">
                            恭喜你&nbsp;!&nbsp;文档上传成功!
                        </h1>
                        <h3 class="text-center ">
                            我们将会在24小时内完成文档审核，请耐心等待 ! <br/><br/>
                            上传记录请在 <a href="${pageContext.request.contextPath}/userFile/to_user_file.action?stamp=9&state=37&type=1&status=-1&flag=-1&file_type=-1" class="text-info">个人中心 —— 我的上传</a> 查看,<br/><br/>
                            你可以选择继续上传!
                        </h3>
                        <div  style="margin: 80px 0;">
                            <div class="col-md-4 col-md-offset-4">
                                <button class="btn btn-info btn-block btn-lg" type="button"
                                        onclick="javascript:document.location.href='${pageContext.request.contextPath}/my_file_base/to_upload_file.action';">继续上传</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <input id="labelList" type="hidden" value="${labelList}"/>
            <input id="success_flag" type="hidden" value="${success_flag}"/>
            <input id="file_type" type="hidden" value="${file_type}"/>

        </div>

    </div>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/stream/js/stream-v1.js"></script>

<script type="text/javascript">

    /**
     * 配置文件（如果没有默认字样，说明默认值就是注释下的值）
     * 但是，on*（onSelect， onMaxSizeExceed...）等函数的默认行为
     * 是在ID为i_stream_message_container的页面元素中写日志
     */

    var config = {
        enabled: true, /** 是否启用文件选择，默认是true */
        customered: true,
        multipleFiles: true, /** 是否允许同时选择多个文件，默认是false */
        autoUploading: true, /** 当选择完文件是否自动上传，默认是true */
        fileFieldName: "FileData", /** 相当于指定<input type="file" name="FileData">，默认是FileData */
        maxSize: 2147483648, /** 当_t.bStreaming = false 时（也就是Flash上传时），2G就是最大的文件上传大小！所以一般需要 */
        simLimit: 1, /** 允许同时选择文件上传的个数（包含已经上传过的） */
        extFilters: [".txt",".doc",".docx",".ppt",".pptx",".xls",".xlsx",".pdf",".wps",".jpg",".png",".gif",".flv",".swf",".mp4",".mp3"], /** 默认是全部允许，即 [] */
        dragAndDropArea: "i_select_files",
        browseFileId : "i_select_files", /** 选择文件的ID, 默认: i_select_files */
        browseFileBtn : "<div></div>", /** 显示选择文件的样式, 默认: `<div>请选择文件</div>` */
        filesQueueId : "i_stream_files_queue", /** 文件上传容器的ID, 默认: i_stream_files_queue */
        filesQueueHeight : 200, /** 文件上传容器的高度（px）, 默认: 450 */
        tokenURL : "/edu_yun/tk", /** 根据文件名、大小等信息获取Token的URI（用于生成断点续传、跨域的令牌） */
        uploadURL : "/edu_yun/upload", /** HTML5上传的URI */
        onSelect: function(files) {
            for(var i=0; i<files.length; i++) {
                if(files[i].size>0){
                    var tmpl = $("#UploadFileModule").text().trim();
                    var instance = tmpl.replace(/#FILE_ID#/g, files[i].id)
                        .replace(/#FILE_NAME#/g, files[i].name)
                        .replace(/#FILE_SIZE#/g, _t.formatBytes(files[i].size));

                    $("#i_select_files").append(instance);

                    $("#"+ files[i].id).click(function(e) {
                        e.stopPropagation();
                        if ($(this).hasClass('dz-processing')) {
                            $(this).remove();
                        }
                    });
                }else{
                    alert("文件大小为0请重新选择！");
                    windows.location="${pageContext.request.contextPath}/my_file_base/to_upload_file.action";
                }
            }
        },
        onMaxSizeExceed: function(file) {//文件大小超过限制
            var $module = $("#"+ file.id);
            $module.addClass("dz-error dz-complete");
            //console && console.log("-------------onMaxSizeExceed-------------------");
            //console && console.log(file);
            $module.find(".dz-error-message span").text("文件[name="+file.name+", size="+file.formatSize+"]超过文件大小限制‵"+file.formatLimitSize+"‵，将不会被上传！");
            //console && console.log("-------------onMaxSizeExceed-------------------End");
        },
        onFileCountExceed : function(selected, limit) {//文件数量超出的响应事件
            if(selected > limit){
                alert("一次最多上传"+limit+"个文件，但是已选择"+selected+"个");
            }
        },
        onExtNameMismatch: function(info) {//文件的扩展名不匹配的响应事件
            $module.find(".dz-error-message span").text("<strong>"+info.name+"</strong>文件类型不匹配[<strong>"+info.filters.toString() + "</strong>]");
        },
        onComplete: function(file) {//单个文件上传完成
            /** 100% percent */
            var $bar = $("#"+file.id).find("div.progress-bar");
            $bar.css("width", file.percent + "%");

            var module = $("#"+file.id);
            module.addClass("dz-complete dz-success");
            module.removeClass('dz-processing dz-error');
        },
        onAddTask: function(file, dat) {
            // 图片回显
            if (dat && dat.file && dat.file.type && dat.file.type.indexOf('image') == 0) {
                var $module = $("#"+ file.id);
                $module.addClass('dz-image-preview');
                $module.removeClass('dz-file-preview');

                var reader = new FileReader();
                reader.readAsDataURL(dat.file);
                reader.onload = function(evt) {
                    var img = $('#' + file.id).find('.dz-image img');
                    img.attr('src', reader.result);
                    img.attr('alt', file.name);
                    img.attr('width', '120px');
                };
            }
			$("#bootstrap-stream-container").append( '<div id="' + file.id + '" class="item">' +
	        '<h4 class="info" style="text-align: center;">' + file.name + '</h4>' +
	        '<div class="state col-md-offset-2">等待上传...</div>' +
	    '</div>' );
			},
        onQueueComplete: function(msg) {
            //data为返回的json字符串，这里转对象
            var json = eval("(" + msg + ")");
            if(json.success){//上传成功
                //清空之前上传的
                document.getElementById("fielPages").innerHTML = "";

                $("#fistPage").hide();
                $("#twoPage").show();
                $("#threePage").hide();
                $(".twoPage").addClass("active").siblings().addClass("active");


                var filepaths = json.filePaths;//文件地址
                var filenames = json.fileNames;//文件原始名
                var filelengths = json.fileLengths;//文件长度
                var fileimages = json.fileImages;//文件缩略图
                $("#name").val(filenames);
                $("#path").val(filepaths);
                $("#length").val(filelengths);
                $("#image").val(fileimages);
                reformPage(0);
            }else{//上传失败

            }
        },
        onUploadError: function(status, msg) {//上传异常
            alert(msg + ", 状态码:" + status);
        },
        onUploadProgress: function(file) {
			//console && console.log("-------------onUploadProgress-------------------");
			//console && console.log(file);
			
			 var $li = $( '#'+file.id ),
	        $percent = $li.find('.progress .progress-bar');

	    // 避免重复创建
	    if ( !$percent.length ) {
	        $percent = $('<div class="progress progress-striped active col-md-8 col-md-offset-2" style="padding: 0;">' +
	          '<div class="progress-bar" role="progressbar" style="width: 0%;margin:0;padding: 0;">' +
	          '</div>' +
	        '</div>').appendTo( $li ).find('.progress-bar');
	        $(_uploadFile).hide();
	    }
	    
	    $li.find('div.state').text('上传中');

	    $percent.css( 'width',file.totalPercent + '%' );

         $(".choose").html("");
			
			
			//console && console.log("-------------onUploadProgress-------------------End");
		},
    };
    var _t = new Stream(config);
    /** 不支持拖拽，隐藏拖拽框 */
    if (!_t.bDraggable) {
        $("#i_stream_dropzone").hide();
    }
    /** Flash最大支持2G */
    if (!_t.bStreaming) {
        _t.config.maxSize = 2147483648;
    }

    if (!_t.bDraggable) {
        alert('你的浏览器不支持文件上传，换个现代浏览器试试！');
    }

    function reformPage(value){

        //var file_type = $("#file_type").val();

        var old_filepaths = $("#path").val();//文件地址
        var old_filenames = $("#name").val();//文件原始名
        var old_filelengths = $("#length").val();//文件长度
        var old_fileimages = $("#image").val();//文件缩略图
        var types = "";
        var filepages = "";
        var flag = true;
        var filepaths = "";
        var filenames = "";
        var filelengths = "";
        var fileimages = "";
        if(value!=0){//删除，重组页面
            if(old_filepaths.indexOf(",")>0){//多文件
                var arrays = old_filepaths.split(",");
                for(var i=0;i<arrays.length;i++){
                    if(arrays[i]!=value){
                        filepaths += arrays[i] + ",";
                        filenames += old_filenames.split(",")[i] + ",";
                        filelengths += old_filelengths.split(",")[i] + ",";
                        fileimages += old_fileimages.split(",")[i] + ",";
                    }else{
                        //清空之前上传的
                        document.getElementById("fielPages").innerHTML = "";
                        //清空session
                        <%	request.getSession().setAttribute("userFile", null);%>
                    }
                }
            }else{
                if(value==old_filepaths){//唯一一个文件被删除
                    $("#path").val("");
                    $("#name").val("");
                    $("#length").val("");
                    $("#image").val("");
                    $(".upload_file_advice").text("您还没有上传文档，请上传文档!");
                    //清空之前上传的
                    document.getElementById("fielPages").innerHTML = "";
                    //清空session
                    <%	request.getSession().setAttribute("userFile", null);%>
                    flag = false;
                }else{
                    filepaths = old_filepaths + ",";
                    filenames = old_filenames + ",";
                    filelengths = old_filelengths + ",";
                    fileimages = old_fileimages + ",";
                }
            }
            if(flag){
                filepaths = filepaths.substring(0,filepaths.length-1);
                filenames = filenames.substring(0,filenames.length-1);
                filelengths = filelengths.substring(0,filelengths.length-1)
                fileimages = fileimages.substring(0,fileimages.length-1)
                $("#path").val(filepaths);
                $("#name").val(filenames);
                $("#length").val(filelengths);
                $("#image").val(fileimages);
            }
            $.ajax({
                url : '${pageContext.request.contextPath}/my_file_base/reform_ession.action',
                data : {
                    path : $("#path").val(),
                    name : $("#name").val(),
                    length : $("#length").val(),
                    image : $("#image").val()
                },
                dataType : 'json',
                success : function(d) {

                }
            });
        }else{
            filepaths = old_filepaths;
            filenames = old_filenames;
            filelengths = old_filelengths;
            fileimages = old_fileimages;
        }

        if(flag){
            var foothtml = "<div>"+
                "<span>保存至:</span>"+
                "<select name=\"folderId\">";
            <c:forEach items="${userFolderList}" var="folder">
            foothtml += "<option value=\"${folder.id}\">${folder.folder_name}</option>";
            </c:forEach>
            foothtml += "</select>"+
                "</div></div>";
            if(filepaths.indexOf(",")>0){//多文件

            }else{//单文件
                //$(".upload_file_advice").text("1篇文档上传完毕!请填写文档后点击“确认上传”");
                var index=filenames.lastIndexOf(".");
                
                filepages +=

                    "<div class=\"panel-body\">"+"<br/>"+
                    "<input type=\"hidden\" id=\"file_type_0\" name=\"file_type\" value=\"0\">"+
                    "<div class=\"form-group file_name\"  id=\"section1\">"+
                    "<label class=\"col-md-2 control-label\"><span class=\"text-danger\">*</span>文件名称</label>"+
                     "<div class=\"col-md-8 controls\" style=\'margin-top:7px;\'>"+
                    "<input class=\"form-control\"  type=\"text\" id=\"title_0\" name=\"title\" value=\""+filenames.substring(0,index)+"\">"+
                  	"</div>"+
                    "</div>"+
                    "<div class=\"form-group\" id=\"section2\" >"+
                    "<label class=\"col-md-2 control-label\">简介</label>"+
                    "<div class=\"col-md-8 controls\">"+
                    "<textarea required=\"required\" name=\"profile\" class=\"form-control\" ></textarea>"+
                    "<div class=\"help-block\" style=\"display:none;\"></div>"+
                    "</div>"+
                    "</div>"+
                    "<input name=\"classficationId\" id=\"classficationId0\" type=\"hidden\">"+
                    "<div class=\"form-group\" id=\"section3\" >"+
                    "<label class=\"col-md-2 control-label\"><span class=\"text-danger\">*</span>学段</label>"+
                    "<div class=\"col-md-2 controls\">"+
                     "<select name=\"subject0\"  class=\"form-control\"  onchange=\"_stage(0,this.value);\">";
                    <c:forEach items="${subject0List}" var="subject">//onchange
                filepages += "<option value=\"${subject.id}\">${subject.subjectName}</option>";
                </c:forEach>
                     filepages += "</select></div>"+
                   
                    "<div class=\"help-block\" style=\"display: none;\"><span class=\"text-danger\">请选择学段</span></div>"+
                    "</div>"+
                    "<div class=\"form-group\" id=\"section4\">"+
                    "<label class=\"col-md-2 control-label\"><span class=\"text-danger\">*</span>科目</label>"+
                    "<div class=\"col-md-8 controls\">"+
                    "<select id=\"subject0\" onchange=\"_subject(0);\" class=\"form-control width-input width-input-large\">"+
                    "</select><i class=\"changeTest\" id=\"file_subject0\"></i>"+
                    "</div>"+
                    "<div class=\"help-block\" style=\"display: none;\"><span class=\"text-danger\">请选择科目</span></div>"+
                    "</div>"+
                    "<div class=\"form-group\" id=\"section5\">"+
                    "<label class=\"col-md-2 control-label\"><span class=\"text-danger\">*</span>教材版本</label>"+
                    "<div class=\"col-md-8 controls\">"+
                    "<select  id=\"edition0\" onchange=\"_edition(0);\" class=\"form-control\">"+
                    "</select><i class=\"changeTest\" id=\"file_edition0\"></i><br/>"+
                    "</div>"+
                     "<div>"+
                    "<br/>"+
                    "<br/>"+
                    "<br/>"+
                    "<div class=\"col-md-4 controls col-md-offset-2\">"+
                    "<select id=\"grade0\" onchange=\"_grade(0);\" class=\"form-control\">"+
                    "</select>"+
                    "</div>"+
                     "</div>"+
                    "<div class=\"col-md-4 controls\">"+
                    "<select id=\"chapter0\" onchange=\"_chapter(0);\"  class=\"form-control\">"+
                    "</select>"+
                    "</div>"+
                       "<div style=\"display:none;\" >"+
                    "<br/>"+
                    "<br/>"+
                    "<br/>"+
                    "<div class=\"col-md-4 controls col-md-offset-2\"  >"+
                    "<select id=\"section0\"onchange=\"_classValue(0,this.value);\" class=\"form-control\">"+
                    "</select><i class=\"changeTest\" id=\"file_section0\"></i><br/>"+
                    "</div>"+
                     "</div>"+
                    "<div class=\"help-block\" style=\"display: none;\"><span class=\"text-danger\">请选择教材版本</span></div>"+
                    "</div>"+
                    "<div class=\"form-group\" id=\"section6\">"+
                    "<label class=\"col-md-2 control-label\"><span class=\"text-danger\">*</span>资源分类</label>"+
                    "<div class=\"col-md-8 controls\">"+
                    "<select name=\"columnId\"  class=\"form-control\">";
                <c:forEach items="${columnList}" var="column">
                filepages += "<option value=\"${column.id}\">${column.classify_name}</option>";
                </c:forEach>
                filepages +="</select>"+
                    "</div>"+
                    "<div class=\"help-block\" style=\"display: none;\"><span class=\"text-danger\">请选择分类</span></div>"+
                    "</div>"+
                    "<div class=\"form-group\" style=\"display:none;\">"+
                    "<label  class=\"col-md-2 control-label\">标签</label>"+

                    "<div class=\"col-md-8 controls\">"+
                    "<select  id=\"label0\" name=\"label\" multiple onChange=\"doLabel(0);\">"
                <c:forEach items="${labelList}" var="label">
                filepages += "<option value=\"${label.id}\">${label.label_name}</option>";
                </c:forEach>
                filepages +="</select>"+
                    "<input name=\"labelId\" id=\"labelId0\" value=\"0\" type=\"hidden\">"+
                    "</div></div>"+
                    "<div class=\"form-group\" id=\"section7\" >"+
                    "<label class=\"col-md-2 control-label\"><span class=\"text-danger\">*</span>资源类型</label>"+
                    "<div class=\"col-md-6 controls\">"+
                    "<select class=\"form-control\" name=\"type\" id=\"type0\" onchange=\"changeType(0);\" >";
                <c:forEach items="${fileTypeList}" var="type" varStatus="status">
                filepages +="<option value=\"${type.id}\" >${type.type_name}</option>";
                </c:forEach>
                filepages += "</select>"+
                    "<input type=\"hidden\" id=\"value0\" name=\"value\" value=\"0\"/>"+

                    "</div>"+
                    "<div class=\"col-md-2 controls\">"+
                    "<select class=\"form-control\" id=\"payValue0\" onchange=\"changeValue(this.value,0);\" >";
                <c:forEach items="${amountList}" var="amount">
                filepages += "<option value=\"${amount.amount}\">${amount.amount}元</option>";
                </c:forEach>
                filepages +="</select>"+
                    "</div>"+
                    "<div class=\"help-block\" style=\"display: none;\"><span class=\"text-danger\">请选择资源价格</span></div>"+

                    "</div>"+

                    "<div class=\"form-group\" id=\"section8\" >"+
                    "<div class=\"col-md-2 control-label\">"+
                    "<label><span class=\"text-danger\">* </span>发布范围</label>"+
                    "</div>"+

                    "<div class=\"col-md-8 controls radios\">"+
                    "<label><input type=\"radio\" name=\"rangeType\" onclick=\"doRange(0,0);\"  checked=\"checked\" value=\"0\" class=\"open\">公开 </label>"+
                    "<label><input type=\"radio\" name=\"rangeType\" onclick=\"doRange(1,0);\" value=\"1\" class=\"community\" >社区 </label>"+
                    "<label><input type=\"radio\" name=\"rangeType\" onclick=\"doRange(2,0);\" value=\"2\" class=\"workshop\" >工作坊 </label>"+
                    "<div class=\"text-warning\" style=\"display:none\">请选择发布范围</div>"+
                    "</div>"+

                    "</div>"+

                    "<div class=\"form-group community_content\" style=\"display: none;\">"+"<br/>"+

                    "<div class=\"col-md-2 control-label\"> <label>社区</label></div>"+
                    "<div class=\"col-md-8 controls\">"+
                    "<select id=\"communitySelect0\" name=\"rangeId\" class=\"form-control width-input width-input-large\">"+
                    "</select>"+
                    "<div class=\"text-warning\" style=\"display: none;\">请选择社区</div>"+
                    "</div>"+
                    "</div>"+
                    "<div class=\"form-group workshop_content\" style=\"display: none;\">"+"<br/>"+
                    "<div class=\"col-md-2 control-label\"> <label>工作坊</label></div>"+
                    "<div class=\"col-md-8 controls\">"+
                    "<select id=\"workshopSelect0\" name=\"rangeId\" class=\"form-control width-input width-input-large\">"+
                    "</select>"+
                    "<div class=\"text-warning\" style=\"display: none;\">请选择工作坊</div>"+
                    "</div>"+
                    "</div>"+
                    "<div class=\"form-group savefolder\" id=\"section9\">"+
                    "<div class=\"col-md-2 control-label\"> <label>保存至</label></div>"+
                    "<div class=\"col-md-8 controls\">"+
                    "<select   class=\"form-control width-input width-input-large\" class=\"page\" name=\"folderId\">";
                <c:forEach items="${userFolderList}" var="folder">
                filepages += "<option value=\"${folder.id}\">${folder.folder_name}</option>";
                </c:forEach>
                filepages += "</select>"+
                    "</div>" +
                    "</div>"+
                    "<div class=\"form-group\" style=\"margin-top: 80px;\">"+
                    " <div class=\"col-md-offset-2 col-md-2 controls \">"+
                    "<button type=\"button\" onclick=\"confirmSubmit();\" class=\"btn btn-fat btn-primary\">保存</button>"+
                    "</div>"+
                    "<div class=\"col-md-offset-1 col-md-2 controls \">"+
                    "<button class=\"btn btn-fat btn-warning\" onclick=\"btn_publish();\" type=\"button\">发布</button>"+
                    "</div>"+
                    "</div>"+
                    "</div>";

                _stage(0,"XX");
            }
            $("#type").val(types.substring(0,types.lastIndexOf(",")));
            var type = $("#fileType").val();
            $("#file_type_0").val(type);
            $("#fielPages").append(filepages);
            $("#stage_tow").show();
        }
    }

    function searchImg(value){
        if(value=='ppt'){
            return "PPT_03";
        }else if(value=='pdf'){
            return "pdf_03";
        }else if(value=='word'){
            return "word_03";
        }else if(value=='txt'){
            return "txt_03";
        }else if(value=='excel'){
            return "excel_03";
        }else{//其他
            return "vidio_03";
        }

    }
    function openBrowse(){
        var ie=navigator.appName=="Microsoft Internet Explorer" ? true : false;
        if(ie){
            document.getElementById("i_select_files").click();
        }else{
            var a=document.createEvent("MouseEvents");//FF的处理
            a.initEvent("click", true, true);
            document.getElementById("i_select_files").dispatchEvent(a);
        }



    }

    function openClose(value){
        if($("#file_info"+value).css("display")!="none"){
            $("#file_info"+value).hide();
            $("#pick_up"+value).text("展开");

            var width = document.body.clientWidth;
            var myWidth=(width-1000)/2;

        }else{
            $("#file_info"+value).show();
            $("#pick_up"+value).text("收起")

        }
    }

    function confirmSubmit(){
        //验证是否必输项
        var names = $("#name").val();
        if(names.indexOf(",")>0){//多文件
            var arrays = names.split(",");
            for(var i=0;i<arrays.length;i++){
                validate(i);
            }
        }else{//单文件
            validate(0);
        }
    }

    function validate(index){
        var title = $("#title_"+index).val();
        if(title==""){
            $("#file_title"+index).html("标题不能为空!");
            return false;
        }else{
            $("#file_title"+index).html("");
        }
        var subject = $("#subject"+index).val();
        if(subject=="-1"){
            $("#file_subject"+index).html("科目不能为空!");
            return false;
        }else{
            $("#file_subject"+index).html("");
        }
        var edition = $("#edition"+index).val();
        if(edition=="-1"){
            $("#file_edition"+index).html("教材版本不能为空!");
            return false;
        }else{
            $("#file_edition"+index).html("");
        }
        var section = $("#section"+index).val();
        if(section=="-1"){
            $("#file_section"+index).html("年级分类不能为空!");
            return false;
        }else{
            $("#file_section"+index).html("");
        }
        var classficationId = $("#classficationId"+index).val();
        
        if(classficationId==""){
            $("#file_section"+index).html("文档科目、版本选择错误，请重新选择!");
            return false;
        }else{
            $("#file_section"+index).html("");
        }
        document.getElementById('saveFile').submit();
    }

    //类型
    function changeType(index){
        var value = $("#type"+index).find("option:selected").text();
        if(value=='付费文档'){
            $("#payValue"+index).show();
        }else{
            $("#payValue"+index).hide();
            $("#value"+index).val(0);
        }
    }
    function doFileType(value){
        $("#fileType").val(value);
    }
    //价格
    function changeValue(value,index){
        $("#value"+index).val(value);
    }
    //标签
    function doLabel(index){
        $("#labelId"+index).val($("#label"+index).val());
    }
    function doRange(type,index){
        if(type==0){
            $(".community_content").hide();
            $(".workshop_content").hide();
        }else if(type==1){//社区
            $(".community_content").show();
            $(".workshop_content").hide();
            $.ajax({
                url:"${pageContext.request.contextPath}/class/query_communitys.action",
                data:{"communityType":0},
                dataType:"json",
                success:function(data){
                    var html = "<option value=\"-1\">--请选择社区--</option>";
                    for(var i=0;i<data.length;i++){
                        html += "<option value=\""+data[i].id+"\">"+data[i].name+"</option>";
                    }
                    $("#communitySelect"+index).append(html);
                    $("#workshopSelect"+index).html("");
                }
            });
        }else if(type==2){//工作坊
            $(".community_content").hide();
            $(".workshop_content").show();
            $.ajax({
                url:"${pageContext.request.contextPath}/class/query_communitys.action",
                data:{"communityType":0},
                dataType:"json",
                success:function(data){
                    var html = "<option value=\"-1\">--请选择工作坊--</option>";
                    for(var i=0;i<data.length;i++){
                        html += "<option value=\""+data[i].id+"\">"+data[i].name+"</option>";
                    }
                    $("#workshopSelect"+index).append(html);
                    $("#communitySelect"+index).html("");
                }
            });
        }
    }

   function _stage(index,type){
        if(type=='XX'){
            $("#stage"+index+"_"+type).addClass("btn-info");
            $("#stage"+index+"_GZ").removeClass("btn-info");
            $("#stage"+index+"_CZ").removeClass("btn-info");
        }else if(type=='GZ'){
            $("#stage"+index+"_"+type).addClass("btn-info");
            $("#stage"+index+"_XX").removeClass("btn-info");
            $("#stage"+index+"_CZ").removeClass("btn-info");
        }else{
            $("#stage"+index+"_"+type).addClass("btn-info");
            $("#stage"+index+"_GZ").removeClass("btn-info");
            $("#stage"+index+"_XX").removeClass("btn-info");
        }

        $("#subject"+index).find("option").remove();
        $("#edition"+index).find("option").remove();
        $("#grade"+index).find("option").remove();
        $("#chapter"+index).find("option").remove();
        $("#section"+index).find("option").remove();

        //查询科目
        $.ajax({
            url : "${pageContext.request.contextPath}/subject/query_subject.action?subId="+type+"&typeFlag=six",
            dataType:'json',
            success : function(json) {
                var a = JSON.stringify(json);
                var o = eval( "(" + a + ")" );
                var sub = o[0].subjectList;
                var edi = o[0].editionList;
                var gra = o[0].gradeList;
                var cha = o[0].chapterList;
                var sec = o[0].sectionList;
                var flag=1;
                if(flag==1){
                if(sub.length>0){
                    $("#subject"+index).parent().parent().show();
                    $("#classficationId"+index).val(sub[0].id);
                    for(var i in sub){
                    $("#subject"+index).append('<option value='+sub[i].id+' >'+sub[i].subjectName+'</option>');
                }
                }else{
              		$("#subject"+index).parent().parent().css("display","none");
                     $("#edition"+index).parent().parent().css("display","none");
                     $("#grade"+index).parent().parent().css("display","none");
                     $("#chapter"+index).parent().css("display","none");
                     $("#section"+index).parent().parent().css("display","none");
                    $("#classficationId"+index).val(type);
                    flag=0;
                }
                }
                 //新增规则edi
                 if(flag==1){
                if(edi.length>0){
                  $("#edition"+index).parent().parent().show();
                    $("#classficationId"+index).val(edi[0].id);
                     for(var i in edi){
                    $("#edition"+index).append('<option value='+edi[i].id+' >'+edi[i].versionName+'</option>');
                }
                }else{
                     $("#edition"+index).parent().parent().css("display","none");
                     $("#grade"+index).parent().parent().css("display","none");
                     $("#chapter"+index).parent().css("display","none");
                     $("#section"+index).parent().parent().css("display","none");
                    $("#classficationId"+index).val(sub[0].id);
                    flag=0;
                }
                }
                //新增规则gra
                if(flag==1){
                if(gra.length>0){
                    $("#grade"+index).parent().parent().css("display","inline");
                    $("#classficationId"+index).val(gra[0].id);
                    for(var i in gra){
                    $("#grade"+index).append('<option value='+gra[i].id+' >'+gra[i].bookCatelogName+'</option>');
                }
                }else{
                   $("#grade"+index).parent().parent().css("display","none");
                     $("#chapter"+index).parent().css("display","none");
                     $("#section"+index).parent().parent().css("display","none");
                    $("#classficationId"+index).val(edi[0].id);
                     flag=0;
                }
                }
                //新增规则cha
                if(flag==1){
                  if(cha.length>0){
                    $("#chapter"+index).parent().css("display","inline");
                    $("#classficationId"+index).val(cha[0].id);
                   for(var i in cha){
                    $("#chapter"+index).append('<option value='+cha[i].id+' >'+cha[i].bookCatelogName+'</option>');
                }
                }else{
                   $("#chapter"+index).parent().css("display","none");
                     $("#section"+index).parent().parent().css("display","none");
                    $("#classficationId"+index).val(gra[0].id);
                     flag=0;
                }
                }
                //
                if(flag==1){
                if(sec.length>0){
                    $("#section"+index).parent().parent().css("display","inline");
                    $("#classficationId"+index).val(sec[0].id);
                    for(var i in sec){
                        $("#section"+index).append('<option value='+sec[i].id+' >'+sec[i].bookCatelogName+'</option>');
                    }
                }else{
                    $("#section"+index).parent().parent().css("display","none");
                    $("#classficationId"+index).val(cha[0].id);
                     flag=0;
                }
               } 
            }
        });
       
    }

    function _subject(index){
        $("#edition"+index).find("option").remove();
        $("#grade"+index).find("option").remove();
        $("#chapter"+index).find("option").remove();
        $("#section"+index).find("option").remove();
        //查询版本
        if($("#subject"+index).val()!=-1){
            $.ajax({
                url : "${pageContext.request.contextPath}/pubver/query_pubver.action?pubId="+$("#subject"+index).val()+"&typeFlag=six",
                dataType:'json',
                success : function(json){
                    var a = JSON.stringify(json);
                    var o = eval( "(" + a + ")" );
                    var edi = o[0].editionList;
                    var gra = o[0].gradeList;
                    var cha = o[0].chapterList;
                    var sec = o[0].sectionList;
                     var flag=1;
                     if(flag==1){
                     if(edi.length>0){
                    $("#edition"+index).parent().parent().show();
                    $("#classficationId"+index).val(edi[0].id);
                     for(var i in edi){
                    $("#edition"+index).append('<option value='+edi[i].id+' >'+edi[i].versionName+'</option>');
                }
                }else{
                    $("#edition"+index).parent().parent().css("display","none");
                     $("#grade"+index).parent().parent().css("display","none");
                     $("#chapter"+index).parent().css("display","none");
                     $("#section"+index).parent().parent().css("display","none");
                    $("#classficationId"+index).val($("#subject"+index).val());
                     flag=0;
                }
                }
                //新增规则gra
                if(flag==1){
                if(gra.length>0){
                    $("#grade"+index).parent().parent().css("display","inline");
                    $("#classficationId"+index).val(gra[0].id);
                    for(var i in gra){
                    $("#grade"+index).append('<option value='+gra[i].id+' >'+gra[i].bookCatelogName+'</option>');
                }
                }else{
                    $("#grade"+index).parent().parent().css("display","none");
                     $("#chapter"+index).parent().css("display","none");
                     $("#section"+index).parent().parent().css("display","none");
                    $("#classficationId"+index).val(edi[0].id);
                     flag=0;
                }
                }
                //新增规则cha
                if(flag==1){
                  if(cha.length>0){
                    $("#chapter"+index).parent().css("display","inline");
                    $("#classficationId"+index).val(cha[0].id);
                   for(var i in cha){
                    $("#chapter"+index).append('<option value='+cha[i].id+' >'+cha[i].bookCatelogName+'</option>');
                }
                }else{
                     $("#chapter"+index).parent().css("display","none");
                     $("#section"+index).parent().parent().css("display","none");
                    $("#classficationId"+index).val(gra[0].id);
                     flag=0;
                }
                }
                //
                if(flag==1){
                if(sec.length>0){
                    $("#section"+index).parent().parent().css("display","inline");
                    $("#classficationId"+index).val(sec[0].id);
                    for(var i in sec){
                        $("#section"+index).append('<option value='+sec[i].id+' >'+sec[i].bookCatelogName+'</option>');
                    }
                }else{
                    $("#section"+index).parent().parent().css("display","none");
                    $("#classficationId"+index).val(cha[0].id);
                     flag=0;
                }
}
                }
            });
        }
    }

    function _edition(index){
        $("#grade"+index).find("option").remove();
        $("#chapter"+index).find("option").remove();
        $("#section"+index).find("option").remove();
        //查询年级
        if($("#edition"+index).val()!=-1){
            $.ajax({
                url : "${pageContext.request.contextPath}/book_cat/query_book_cat.action?bookId="+$("#edition"+index).val()+"&parentId=-1&typeFlag=six",
                dataType:'json',
                success : function(json){
                    var a = JSON.stringify(json);
                    var o = eval( "(" + a + ")" );
                    var gra = o[0].gradeList;
                    var cha = o[0].chapterList;
                    var sec = o[0].sectionList;
                   var flag=1;
                //新增规则gra
                if(flag==1){
                if(gra.length>0){
                    $("#grade"+index).parent().parent().css("display","inline");
                    $("#classficationId"+index).val(gra[0].id);
                    for(var i in gra){
                    $("#grade"+index).append('<option value='+gra[i].id+' >'+gra[i].bookCatelogName+'</option>');
                }
                }else{
                    $("#grade"+index).parent().parent().css("display","none");
                    $("#chapter"+index).parent().css("display","none");
                     $("#section"+index).parent().parent().css("display","none");
                    $("#classficationId"+index).val($("#edition"+index).val());
                     flag=0;
                }
                }
                //新增规则cha
                if(flag==1){
                  if(cha.length>0){
                    $("#chapter"+index).parent().css("display","inline");
                    $("#classficationId"+index).val(cha[0].id);
                   for(var i in cha){
                    $("#chapter"+index).append('<option value='+cha[i].id+' >'+cha[i].bookCatelogName+'</option>');
                }
                }else{
                    $("#chapter"+index).parent().css("display","none");
                     $("#section"+index).parent().parent().css("display","none");
                    $("#classficationId"+index).val(gra[0].id);
                     flag=0;
                }
                }
                //
                if(flag==1){
                if(sec.length>0){
                    $("#section"+index).parent().parent().css("display","inline");
                    $("#classficationId"+index).val(sec[0].id);
                    for(var i in sec){
                        $("#section"+index).append('<option value='+sec[i].id+' >'+sec[i].bookCatelogName+'</option>');
                    }
                }else{
                    $("#section"+index).parent().parent().css("display","none");
                    $("#classficationId"+index).val(cha[0].id);
                     flag=0;
                } 
                }
                }
            });
        }
    }

    function _grade(index){
        $("#chapter"+index).find("option").remove();
        $("#section"+index).find("option").remove();
        //查询章节
        if($("#grade"+index).val()!=-1){
            $.ajax({
                url : "${pageContext.request.contextPath}/book_cat/query_book_cat.action?bookId="+$("#grade"+index).val()+"&parentId=0&typeFlag=six",
                dataType:'json',
                success : function(json){
                    var a = JSON.stringify(json);
                    var o = eval( "(" + a + ")" );
                    var cha = o[0].chapterList;
                    var sec = o[0].sectionList;
                     var flag=1;
                  //新增规则cha
                  if(flag==1){
                  if(cha.length>0){
                    $("#chapter"+index).parent().css("display","inline");
                    $("#classficationId"+index).val(cha[0].id);
                   for(var i in cha){
                    $("#chapter"+index).append('<option value='+cha[i].id+' >'+cha[i].bookCatelogName+'</option>');
                }
                }else{
                    $("#chapter"+index).parent().css("display","none");
                     $("#section"+index).parent().parent().css("display","none");
                     $("#classficationId"+index).val($("#grade"+index).val());
                      flag=0;
                }
                }
                //
                if(flag==1){
                if(sec.length>0){
                    $("#section"+index).parent().parent().css("display","inline");
                    $("#classficationId"+index).val(sec[0].id);
                    for(var i in sec){
                        $("#section"+index).append('<option value='+sec[i].id+' >'+sec[i].bookCatelogName+'</option>');
                    }
                }else{
                    $("#section"+index).parent().parent().css("display","none");
                    $("#classficationId"+index).val(cha[0].id);
                     flag=0;
                }
                }
                }
            });
        }
    }

    function _chapter(index){
        $("#section"+index).find("option").remove();
        //查询小节
        if($("#chapter"+index).val()!=-1){
            $.ajax({
                url : "${pageContext.request.contextPath}/book_cat/query_book_cat.action?bookId="+$("#chapter"+index).val()+"&parentId=1&typeFlag=six",
                dataType:'json',
                success : function(json){
                    var a = JSON.stringify(json);
                    var o = eval( "(" + a + ")" );
                    var sec = o[0].sectionList;
                     var flag=1;
                     if(flag==1){
                    if(sec.length>0){
                         $("#section"+index).parent().parent().css("display","inline");
                        $("#classficationId"+index).val(sec[0].id);
                        for(var i in sec){
                            $("#section"+index).append('<option value='+sec[i].id+' >'+sec[i].bookCatelogName+'</option>');
                        }
                    }else{
                        $("#section"+index).parent().parent().css("display","none");
                        $("#classficationId"+index).val($("#chapter"+index).val());
                         flag=0;
                    }
                     }
                }
            });
        }
    }
    function _classValue(index,value){
        $("#classficationId"+index).val(value);
    }
    function btn_publish() {
        var i=($("#status").length);
        var form =$('#saveFile');
        if(i<1){
            var input=$('<input type="hidden" value="1" id="status" name="status">');
            form.append(input);
        }
        validate(0);
    };

</script>

<jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
