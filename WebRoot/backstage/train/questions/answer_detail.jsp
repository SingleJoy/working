<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt'%>

<link href="${pageContext.request.contextPath}/frontstage/js/JMEditor/style/default.css" rel="stylesheet" media="screen" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/JMEditor/jmeditor/jquery-1.8.3.min.js"></script>
<script type="text/javascript"src="${pageContext.request.contextPath}/frontstage/js/JMEditor/jmeditor/JMEditor.js"></script>

 <style>
#cke_profile{margin-left:60px;}
</style> 
<div align="center" style="padding: 5px;overflow: hidden;">
	<form id="answerDetail" method="post">
		<input type="hidden" name="id" value="${topicAnswerView.id }"/>
		<input type="hidden" name="questionId" value="${topicAnswerView.id }"/>
	        <h3>详细信息&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="button" value="返回" onclick="location.href='javascript:history.go(-1);'"/> </h3>
	        <div>
	            <label>回答内容</label> 
	           	<div id="answerContent" style="width:500px;height:150px;margin-left:120px;"
	           		contentEditable="true" class="editDemo" disabled="disabled"></div> 
	           	<input type="hidden" name="answerContent" disabled="disabled" value="${topicAnswerView.answerContent }">
	        </div>
	        &nbsp;
	        <div >
	         <p>
	            <label>解答者</label>
	            <input type="text" name="answererName" disabled="disabled" value="${topicAnswerView.answererName }">
	            &nbsp;
	            <label>解答时间</label>
	            <input type="text" name="answerTime" disabled="disabled" value="<fmt:formatDate value='${topicAnswerView.answerTime}' pattern='yyyy-MM-dd HH:mm:ss'/>">
	         </p>
	        </div>
	</form>
</div>
<script type="text/javascript">
	$(function(){
	     var profileVal = $("input[name='answerContent']").val();
	    //给JMEditor赋值
	    var editor = CKEDITOR.replace("answerContent",{
	 		skin: "moono-lisa",width:540, height:150,margin:"0,0,0,120"
	    });
		if(profileVal!=''){
			editor.setData(profileVal);
		}
	       
	     $("#cke_profile").blur(function(){
	 		$("input[name='answerContent']").val(JMEditor.html('answerContent'));
	   	}); 
	})
   
</script>