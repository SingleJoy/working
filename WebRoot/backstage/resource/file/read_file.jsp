<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String fastdfsPath = request.getScheme()+"://"+request.getServerName()+":8080/";
%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/backstage/base/inc.jsp"></jsp:include>
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/swfobject/swfobject.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/flexpaper_flash_debug.js"></script>
</head>
<body>
<div id="dd" align="center" class="main_read"  style="padding: 5px;overflow: hidden;">
	<form id="fileForm" name="fileForm" method="post" action="" >
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="back_onclik();" id="undo">返回文档列表</a>
		<br/>
		<input type="hidden" id="swfName" name="swfName" value="${swfName}">
	    <div style="margin-top: 10px;" class="main_read_content">
		     <div id="flashContent">
	                <%--文件未完全加载完前显示加载状态--%>
		        <p> <img src="${pageContext.request.contextPath}/frontstage/images/loading.gif"></p> 
	        </div> 
	    </div>
	</form>
</div>
<script type="text/javascript"> 
//返回列表
function back_onclik(){
    var swfName=$("#swfName").val();
	if(swfName!=''){
		$.ajax({
	        url : "${pageContext.request.contextPath}/read/fileDelete.action?fileName="+swfName, 
	       	dataType:'json',
			success : function(response) {
			}
	    }); 
	}
	document.fileForm.action = '${pageContext.request.contextPath}/back_file/to_file.action';
	document.fileForm.target="_self";
	document.fileForm.submit();
}

$(function(){
   var swfName=$("#swfName").val();
		   //     <!-- For version detection, set to min. required Flash Player version, or 0 (or 0.0.0), for no version detection. --> 
   var swfVersionStr = "10.0.0";
		   //   <!-- To use express install, set to playerProductInstall.swf, otherwise the empty string. -->
    var xiSwfUrlStr = "playerProductInstall.swf";
	var swfFile = "../read/Paper.swf";
	if(swfName!=''){
		swfFile = "../read/"+swfName;
	}
    var flashvars = { 
      SwfFile : escape(swfFile),
	  Scale : 0.6, 
      StartAtPage:1,
	  ZoomTransition : "easeOut",
	  ZoomTime : 0.5,
	  ZoomInterval : 0.2,
	  FitPageOnLoad : false,
	  FitWidthOnLoad : true,
	  PrintEnabled : true,
	  FullScreenAsMaxWindow : false,
	  ProgressiveLoading : true,
	  localeChain: "zh_CN"
	};
     var params = {};
	 params.quality = "high";
	 params.bgcolor = "#ffffff";
	 params.allowscriptaccess = "sameDomain";
	 params.allowfullscreen = "true";
	 var attributes = {};
	 attributes.id = "FlexPaperViewer";
	 attributes.name = "FlexPaperViewer";
	 swfobject.embedSWF(
	       "../read/FlexPaperViewer.swf", "flashContent", 
	       "800", "600",
	       swfVersionStr, xiSwfUrlStr, 
	       flashvars, params, attributes);
		swfobject.createCSS("#flashContent", "display:block;text-align:left;");

});
</script> 
</body>
</html>