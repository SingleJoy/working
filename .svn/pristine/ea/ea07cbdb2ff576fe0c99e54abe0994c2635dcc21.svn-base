<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>
<link href="${pageContext.request.contextPath}/frontstage/css/upload_file.css?v.01" rel="stylesheet" type="text/css">

<div class="main">

    <div class="upload_progress">

       <div class="choose_file">1
         <p>选择文档</p>
         <div class="upload_progress_1"></div>
       </div>

        <div class="add_inf">2
            <p>补充信息</p>
            <div class="upload_progress_2"></div>
        </div>

        <div class="success_upload">3
            <p>上传完成</p>
        </div>

    </div>

	<div class="select_file_upload_file_pro_1" style="padding-top: 200px;margin-left:200px;"  >
		<div class="select_file_content" >
			<div id="i_select_files" align="center" ><img src="${pageContext.request.contextPath}/frontstage/images/upload.png"></div>
			<div id="i_stream_files_queue" align="center" ></div>
		</div>
	</div>

	<div class="select_file_upload_file_pro_1 file3" style="display: none;" >
		<div class="select_file_content" >
			<div class="upload_file_success">
				<p>恭喜文档上传成功</p>
				<div><button class="add_more_btn_success" onclick="javascript:document.location.href='${pageContext.request.contextPath}/my_file_base/to_upload_file.action';">继续添加</button></div>
			</div>
		</div>
	</div>

	<input id="labelList" type="hidden" value="${labelList}"/>
	<input id="success_flag" type="hidden" value="${success_flag}"/>

	<div class="add_some_info"  style="display: none;" >
		<div class="upload_file_pro_2">
			<p class="upload_file_advice"></p>
			<button class="add_more_btn" onclick="openBrowse();" type="button">继续添加</button>
			<button class="sure_for_upload" onclick="confirmSubmit();" type="button">确认上传</button>
		</div>
		<form id="saveFile" action="${pageContext.request.contextPath}/my_file_base/save_file.action" method="post">
			<input type="hidden" name="name" id="name"/>
			<input type="hidden" name="path" id="path"/>
			<input type="hidden" name="length" id="length">
			<input type="hidden" name="image" id="image">
			<div id="fielPages"></div>
		</form>
	</div>

</div>






<script type="text/javascript" src="${pageContext.request.contextPath}/stream/js/stream-v1.js"></script>

<script type="text/javascript">
	$(function(){
		var successFlag = $("#success_flag").val();
		if(successFlag=="three"){//保存成功

			$(".upload_progress_1").css("background-color","#3ebbce");
			$(".upload_progress_2").css("background-color","#3ebbce");
			$(".select_file_upload_file_pro_1").css("display","none");
			$(".add_some_info").css("display","none");
			$(".add_inf").css("background-color","#3ebbce");
			$(".add_inf").css("color","#ffffff");
			$(".add_inf").find("p").css("color","#3ebbce");

			$(".choose_file").css("background-color","#3ebbce");
			$(".choose_file").css("color","#ffffff");
			$(".choose_file").find("p").css("color","#3ebbce");


			$(".success_upload").css("background-color","#3ebbce");
			$(".success_upload").css("color","#ffffff");
			$(".success_upload").find("p").css("color","#3ebbce");
			$(".file3").css("display","block");
		}
	});
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
		simLimit: 2, /** 允许同时选择文件上传的个数（包含已经上传过的） */
		extFilters: [".txt",".doc",".docx",".ppt",".pptx",".xls",".xlsx",".pdf"], /** 默认是全部允许，即 [] */
		dragAndDropArea: "i_select_files",
		browseFileId : "i_select_files", /** 选择文件的ID, 默认: i_select_files */
		browseFileBtn : "<div>请选择文件</div>", /** 显示选择文件的样式, 默认: `<div>请选择文件</div>` */
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
				alert("同时最多上传<strong>"+limit+"</strong>个文件，但是已选择<strong>"+selected+"</strong>个");
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

		},
		onQueueComplete: function(msg) {
			//data为返回的json字符串，这里转对象
		    var json = eval("(" + msg + ")");
			if(json.success){//上传成功
				//清空之前上传的
				document.getElementById("fielPages").innerHTML = "";
				$(".add_inf").css("background-color","#3ebbce");
				$(".add_inf").css("color","#ffffff");
				$(".add_inf p").css("color","#3ebbce");

				$(".upload_progress_1").css("background-color","#3ebbce");
				$(".select_file_upload_file_pro_1").css("display","none");
				$(".add_some_info").css("display","block");
				$(".file3").css("display","none");
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
		}
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
			var foothtml = "<div class=\"upload_file_saving\">"+
	        "<span>保存至:</span>"+
	        "<select name=\"folderId\">";
		       <c:forEach items="${userFolderList}" var="folder">
		       foothtml += "<option value=\"${folder.id}\">${folder.folder_name}</option>";
				 </c:forEach>
			   foothtml += "</select>"+
		    "</div></div>";
			if(filepaths.indexOf(",")>0){//多文件
				var arrays = filepaths.split(",");
				$(".upload_file_advice").text(arrays.length+"篇文档上传完毕!请填写文档后点击“确认上传”");
			 	for(var i=0;i<arrays.length;i++){
			 		var suffix = filenames.split(",")[i].split(".")[1];
			 		if(i==0){//第一个添加样式
						filepages += "<div class=\"upload_list\" style=\"margin-top: 100px;\">";
			 		}else{
			 			filepages += "<div class=\"upload_list\" >";
			 		}
			 		filepages += "<br/>"+
			        "<div class=\"upload_list_page\">"+
			            "<div class=\"upload_list_page_num\">"+(i+1)+"</div>"+
			            "<img src=\"${pageContext.request.contextPath}/frontstage/images/"+searchImg(suffix)+".png\">"+
			            "<p class=\"page_title\">"+filenames.split(",")[i]+"</p>"+
			            "<div class=\"pick_up\"  id=\"pick_up"+i+"\" onclick=\"openClose("+i+");\">展开</div>"+
			            "<a class=\"delete\" href=\"javascript:void(0);\" onclick=\"reformPage('"+arrays[i]+"');\">删除</a>"+
			        "</div>"+
				    "</div>"+
					"<div  id=\"file_info"+i+"\" >"+
			        	"<div >"+
				        "<span>标题：</span><input type=\"text\" id=\"title_"+i+"\" name=\"title\"  value=\""+filenames.split(",")[i].split(".")[0]+"\"><i class=\"changeTest\">* </i><i class=\"changeTest\" id=\"file_title"+i+"\"></i><br/>"+
				        "<div>"+
				            "<span>简介：</span>"+
				            "<textarea name=\"profile\"></textarea>"+
				        "</div>"+
				    "</div>"+
			        "<input name=\"classficationId\" id=\"classficationId"+i+"\" type=\"hidden\">"+
				    "<div >"+
			            "<span>学段：</span>"+
			            "<a id=\"stage"+i+"_XX\" onclick=\"_stage("+i+",'XX');\" class=\"stageClass\" href=\"javascript:void(0);\" class=\"stageClass\">小学</a>"+
			            "<a id=\"stage"+i+"_CZ\" onclick=\"_stage("+i+",'CZ');\" href=\"javascript:void(0);\">初中</a>"+
			            "<a id=\"stage"+i+"_GZ\" onclick=\"_stage("+i+",'GZ');\" href=\"javascript:void(0);\">高中</a>"+
			        "</div>"+
			        "<div class=\"subject\">"+
			             "<span>科目：</span>"+
			             "<select id=\"subject"+i+"\" onchange=\"_subject("+i+");\" >"+
			             "</select><i class=\"changeTest\">* </i><i class=\"changeTest\" id=\"file_subject"+i+"\"></i>"+
			         "</div>"+
			        "<div class=\"textbook_version\">"+
			            "<span>教材版本：</span>"+
			            "<select id=\"edition"+i+"\" onchange=\"_edition("+i+");\" class=\"textbook_version_01\">"+
			            "</select><i class=\"changeTest\">* </i><i class=\"changeTest\" id=\"file_edition"+i+"\"></i><br/>"+
			            "<select id=\"grade"+i+"\" onchange=\"_grade("+i+");\" class=\"grade\" style=\"margin-left: 76px;\">"+
			            "</select>"+
			            "<select id=\"chapter"+i+"\" onchange=\"_chapter("+i+");\"  class=\"unit\">"+
			            "</select>"+
			            "<select id=\"section"+i+"\" style=\"display:none\" onchange=\"_classValue("+i+",this.value);\" class=\"page\">"+
			            "</select><i class=\"changeTest\">* </i><i class=\"changeTest\" id=\"file_section"+i+"\"></i>"+
			        "</div>"+
			    "<div class=\"upload_classify\">"+
			        "<span>分类：</span>"+
			  	    "<select name=\"columnId\" >";
					  <c:forEach items="${columnList}" var="column">
					  filepages += "<option value=\"${column.id}\">${column.classify_name}</option>";
					  </c:forEach>
					  filepages +="</select><i class=\"changeTest\">* </i>"+
			    	"</div>"+
			    	"<div class=\"upload_tags\">标签："+
				        "<input name=\"labelId\" id=\"labelId"+i+"\" value=\"0\" type=\"hidden\">"+
				        "<input name=\"labelName\" id=\"labelName"+i+"\" readonly=\"readonly\" type=\"text\" placeholder=\"请选择标签,请不要重复添加\"></br><br/>";
				        <c:forEach items="${labelList}" var="label" varStatus="status">
					        <c:if test="${status.first==true}">
					       		 filepages += "<a href=\"javascript:void(0)\" style=\"margin-left:60px;\" onClick=\"selectTag('${label.id}','${label.label_name}',"+i+")\">${label.label_name}</a>";
				       		 </c:if>
				       		 <c:if test="${status.first==false}">
				       		 	filepages += "<a href=\"javascript:void(0)\" onClick=\"selectTag('${label.id}','${label.label_name}',"+i+")\">${label.label_name}</a>";
				       		 </c:if>
				     	 </c:forEach>
				     	filepages += "</div><br/>"+
				     	"<div class=\"typeValue\">"+
				     		"<span>类型：</span>"+
				            "<select class=\"page\" name=\"type\" id=\"type"+i+"\" onclick=\"changeType("+i+");\">";
				           		 <c:forEach items="${fileTypeList}" var="type" varStatus="status">
				           			filepages += "<option value=\"${type.id}\">${type.type_name}</option>";
			                	 </c:forEach>
			                	 filepages += "</select>"+
							 "<input type=\"hidden\" id=\"value"+i+"\" name=\"value\" value=\"0\"/>"+
							 "<select class=\"pay\" id=\"payValue"+i+"\"  onclick=\"changeValue(this.value,"+i+");\">";
							 	<c:forEach items="${amountList}" var="amount">
							 		 filepages += "<option value=\"${amount.amount}\">${amount.amount}元</option>";
							 	 </c:forEach>
								  filepages +="</select><i class=\"changeTest\">* </i>"+
			        	"</div>"+
						"<div class=\"savefolder\" >"+
							"<span style=\"margin-left: -15px;\">保存至：</span>"+
					        "<select class=\"page\" name=\"folderId\">";
						       <c:forEach items="${userFolderList}" var="folder">
						       filepages += "<option value=\"${folder.id}\">${folder.folder_name}</option>";
								</c:forEach>
							 filepages += "</select><i class=\"changeTest\">* </i>"+
				    "</div></div>";
				 	_stage(i,"XX");
				}
			}else{//单文件
				$(".upload_file_advice").text("1篇文档上传完毕!请填写文档后点击“确认上传”");
				filepages += "<div class=\"upload_list\" style=\"margin-top: 100px;\">"+
			        "<br/>"+
			        "<div class=\"upload_list_page\">"+
			            "<div class=\"upload_list_page_num\">1</div>"+
			            "<img src=\"${pageContext.request.contextPath}/frontstage/images/"+searchImg(filenames.split(".")[1])+".png\">"+
			            "<p class=\"page_title\">"+filenames+"</p>"+
			            "<div class=\"pick_up\" id=\"pick_up0\" onclick=\"openClose(0);\">展开<b class='b_class'></b></div>"+
			            "<a class=\"delete\" href=\"javascript:void(0);\" onclick=\"reformPage('"+filepaths+"');\">删除</a>"+
			        "</div>"+
			    "</div>"+
				"<div  id=\"file_info0\">"+
		        	"<div >"+
			        "<span>标题：</span><input type=\"text\" id=\"title_0\" name=\"title\" value=\""+filenames.split(".")[0]+"\"><i class=\"changeTest\">* </i><i class=\"changeTest\" id=\"file_title0\"></i><br/>"+
			        "<div>"+
			            "<span>简介：</span>"+
			            "<textarea name=\"profile\"></textarea>"+
			        "</div>"+
			    "</div>"+
		        "<input name=\"classficationId\" id=\"classficationId0\" type=\"hidden\">"+
			    "<div class=\"school_classify\">"+
		            "<span>学段：</span>"+
		            "<a id=\"stage0_XX\" onclick=\"_stage(0,'XX');\" class=\"stageClass\" href=\"javascript:void(0);\">小学</a>"+
		            "<a id=\"stage0_CZ\" onclick=\"_stage(0,'CZ');\" href=\"javascript:void(0);\">初中</a>"+
		            "<a id=\"stage0_GZ\" onclick=\"_stage(0,'GZ');\" href=\"javascript:void(0);\">高中</a>"+
		        "</div>"+
		        "<div class=\"subject\">"+
		             "<span>科目：</span>"+
		             "<select id=\"subject0\" onchange=\"_subject(0);\">"+
		             "</select><i class=\"changeTest\">* </i><i class=\"changeTest\" id=\"file_subject0\"></i>"+
		         "</div>"+
		        "<div class=\"textbook_version\">"+
		            "<span>教材版本：</span>"+
		            "<select id=\"edition0\" onchange=\"_edition(0);\" class=\"textbook_version_01\">"+
		            "</select><i class=\"changeTest\">* </i><i class=\"changeTest\" id=\"file_edition0\"></i><br/>"+
		            "<select id=\"grade0\" onchange=\"_grade(0);\"  class=\"grade\" style=\"margin-left: 76px;\">"+
		            "</select>"+
		            "<select id=\"chapter0\" onchange=\"_chapter(0);\" class=\"unit\">"+
		            "</select>"+
		            "<select id=\"section0\" style=\"display:none;\" onchange=\"_classValue(0,this.value);\" class=\"page\">"+
		            "</select><i class=\"changeTest\">* </i><i class=\"changeTest\" id=\"file_section0\"></i><br/>"+
		        "</div>"+
		    "<div class=\"upload_classify\">"+
		   	 	"<span>分类：</span>"+
		  	    "<select name=\"columnId\" >";
				  <c:forEach items="${columnList}" var="column">
				  filepages += "<option value=\"${column.id}\">${column.classify_name}</option>";
				  </c:forEach>
				  filepages +="</select><i class=\"changeTest\">* </i>"+
		    "</div>"+
			"<div class=\"upload_tags\">"+
	       		"<span>标签：</span>"+
		        "<input name=\"labelId\" id=\"labelId0\" value=\"0\" type=\"hidden\">"+
		        "<input name=\"labelName\" id=\"labelName0\"  readonly=\"readonly\" type=\"text\" placeholder=\"请选择标签,请不要重复添加\"></br><br/>";
		        <c:forEach items="${labelList}" var="label" varStatus="status">
		       		 <c:if test="${status.first==true}">
		       			 filepages += "<a href=\"javascript:void(0)\"style=\"margin-left:60px;\" onClick=\"selectTag('${label.id}','${label.label_name}',0)\">${label.label_name}</a>";
		       		 </c:if>
		       		 <c:if test="${status.first==false}">
		       			 filepages += "<a href=\"javascript:void(0)\" onClick=\"selectTag('${label.id}','${label.label_name}',0)\">${label.label_name}</a>";
		       		 </c:if>
		     	 </c:forEach>
		     	filepages += "</div><br/>"+
		     	"<div class=\"typeValue\">"+
		            "<span>类型：</span>"+
		            "<select class=\"page\" name=\"type\" id=\"type0\" onchange=\"changeType(0);\" >";
				        <c:forEach items="${fileTypeList}" var="type" varStatus="status">
				       		filepages +="<option value=\"${type.id}\" >${type.type_name}</option>";
		                </c:forEach>
		                filepages += "</select>"+
			      	  "<input type=\"hidden\" id=\"value0\" name=\"value\" value=\"0\"/>"+
					  "<select class=\"pay\" id=\"payValue0\" onchange=\"changeValue(this.value,0);\" >";
		            	<c:forEach items="${amountList}" var="amount">
				 		   filepages += "<option value=\"${amount.amount}\">${amount.amount}元</option>";
				 		</c:forEach>
					  	filepages +="</select><i class=\"changeTest\">* </i>"+
	        	"</div>"+
	        
				"<div class=\"savefolder\" >"+
		       	 	"<span style=\"margin-left: -15px;\">保存至：</span>"+
			        "<select  class=\"page\" name=\"folderId\">";
				       <c:forEach items="${userFolderList}" var="folder">
				       filepages += "<option value=\"${folder.id}\">${folder.folder_name}</option>";
					 	</c:forEach>
					 filepages += "</select><i class=\"changeTest\">* </i>"+
		    "</div></div>";
		 		_stage(0,"XX");
			}
			$("#type").val(types.substring(0,types.lastIndexOf(",")));
		 	$("#fielPages").append(filepages);
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
            $(".b_class").css("background","rgba(0, 0, 0, 0) url('${pageContext.request.contextPath}/frontstage/images/upload_up.png') no-repeat scroll 0 -23px;");
			var width = document.body.clientWidth;
			var myWidth=(width-1000)/2;

        }else{
            $("#file_info"+value).show();
            $("#pick_up"+value).text("收起")
			$(".b_class").css("background","rgba(0, 0, 0, 0) url('${pageContext.request.contextPath}/frontstage/images/upload_up.png') no-repeat scroll 0 0;");
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
	//价格
	function changeValue(value,index){
		$("#value"+index).val(value);
	}
	//标签
	function selectTag(value,nameVal,index){
	    document.getElementById("labelId"+index).value += value+"-";
	    document.getElementById("labelName"+index).value += nameVal+" ";
	}
</script>
<script type="text/javascript">
function _stage(index,type){
	if(type=='XX'){
		$("#stage"+index+"_"+type).attr("class","stageClass");
		$("#stage"+index+"_GZ").removeClass("stageClass");
		$("#stage"+index+"_CZ").removeClass("stageClass");
	}else if(type=='GZ'){
		$("#stage"+index+"_"+type).attr("class","stageClass");
		$("#stage"+index+"_XX").removeClass("stageClass");
		$("#stage"+index+"_CZ").removeClass("stageClass");
	}else{
		$("#stage"+index+"_"+type).attr("class","stageClass");
		$("#stage"+index+"_GZ").removeClass("stageClass");
		$("#stage"+index+"_XX").removeClass("stageClass");
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
			for(var i in sub){
				$("#subject"+index).append('<option value='+sub[i].id+' >'+sub[i].subjectName+'</option>');
			}
			for(var i in edi){
				$("#edition"+index).append('<option value='+edi[i].id+' >'+edi[i].versionName+'</option>');
			}
			for(var i in gra){
				$("#grade"+index).append('<option value='+gra[i].id+' >'+gra[i].bookCatelogName+'</option>');
			}
			for(var i in cha){
				$("#chapter"+index).append('<option value='+cha[i].id+' >'+cha[i].bookCatelogName+'</option>');
			}
			if(sec.length>0){
				$("#section"+index).css("display","inline");
				$("#classficationId"+index).val(sec[0].id);
				for(var i in sec){
					$("#section"+index).append('<option value='+sec[i].id+' >'+sec[i].bookCatelogName+'</option>');
				}
			}else{
				$("#section"+index).css("display","none");
				$("#classficationId"+index).val(cha[0].id);
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
				for(var i in edi){
					$("#edition"+index).append('<option value='+edi[i].id+' >'+edi[i].versionName+'</option>');
				}
				for(var i in gra){
					$("#grade"+index).append('<option value='+gra[i].id+' >'+gra[i].bookCatelogName+'</option>');
				}
				for(var i in cha){
					$("#chapter"+index).append('<option value='+cha[i].id+' >'+cha[i].bookCatelogName+'</option>');
				}
				if(sec.length>0){
					$("#section"+index).css("display","inline");
					$("#classficationId"+index).val(sec[0].id);
					for(var i in sec){
						$("#section"+index).append('<option value='+sec[i].id+' >'+sec[i].bookCatelogName+'</option>');
					}
				}else{
					$("#section"+index).css("display","none");
					$("#classficationId"+index).val(cha[0].id);
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
				 for(var i in gra){
					$("#grade"+index).append('<option value='+gra[i].id+' >'+gra[i].bookCatelogName+'</option>');
				 }
				 for(var i in cha){
					$("#chapter"+index).append('<option value='+cha[i].id+' >'+cha[i].bookCatelogName+'</option>');
				 }
				 if(sec.length>0){
					 $("#section"+index).css("display","inline");
					 $("#classficationId"+index).val(sec[0].id);
					 for(var i in sec){
						$("#section"+index).append('<option value='+sec[i].id+' >'+sec[i].bookCatelogName+'</option>');
					 }
				 }else{
					 $("#section"+index).css("display","none");
					 $("#classficationId"+index).val(cha[0].id);
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
				 for(var i in cha){
					$("#chapter"+index).append('<option value='+cha[i].id+' >'+cha[i].bookCatelogName+'</option>');
				 }
				 if(sec.length>0){
					 $("#section"+index).css("display","inline");
					 $("#classficationId"+index).val(sec[0].id);
					 for(var i in sec){
						$("#section"+index).append('<option value='+sec[i].id+' >'+sec[i].bookCatelogName+'</option>');
					 }
				 }else{
					 $("#section"+index).css("display","none");
					 $("#classficationId"+index).val(cha[0].id);
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
				if(sec.length>0){
					$("#section"+index).css("display","inline");
				 	$("#classficationId"+index).val(sec[0].id);
				 	for(var i in sec){
						$("#section"+index).append('<option value='+sec[i].id+' >'+sec[i].bookCatelogName+'</option>');
				 	}
				}else{
					$("#section"+index).css("display","inline");
				 	$("#classficationId"+index).val($("#chapter"+index).val());
				}
			}
		}); 
	}
}
function _classValue(index,value){
	$("#classficationId"+index).val(value);
}


</script>

<jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>

