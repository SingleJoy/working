<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<link href="${pageContext.request.contextPath}/frontstage/js/JMEditor/style/default.css" rel="stylesheet" media="screen" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/JMEditor/jmeditor/jquery-1.8.3.min.js"></script>
<script type="text/javascript"src="${pageContext.request.contextPath}/frontstage/js/JMEditor/jmeditor/JMEditor.js"></script>

 <style>
#cke_profile{margin-left:60px;}
</style> 
<div align="center" style="padding: 5px;overflow: hidden;">
	<form id="courseDetail" >
		<input type="hidden" name="id" value="${courseNoteView.id }"/>
		<input type="hidden" name="course_id" value="${courseNoteView.course_id }"/>
		<input type="hidden" name="course_hour_id" value="${courseNoteView.course_hour_id }"/>
		<input type="hidden" name="user_id" value="${courseNoteView.user_id }"/>
	        <h3>详细信息&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="button" value="返回" onclick="location.href='javascript:history.go(-1);'"/> </h3>
	        <div >
	            <p>
	               <label>课程名称</label>
	               <input type="text" name="course_name" disabled="disabled" value="${courseNoteView.course_name }">
	               &nbsp;    
	               <label>课时名称</label>
	               <input type="text" name="course_hour_name" disabled="disabled" style="width: 20%;" value="${courseNoteView.course_hour_name }">
	            </p>
	        </div>
	        <div >
	            <label>笔记内容</label>
	           	<div id="note_content" style="width:500px;height:150px;margin-left:120px;"
	           		contentEditable="true" class="editDemo" disabled="disabled"></div> 
	           	<input type="hidden" name="note_content" disabled="disabled"  value="${courseNoteView.note_content }">
	        </div>
	        &nbsp;
	        <div >
	         <p>
	            <label>作者</label>
	            <input type="text" name="author_name" disabled="disabled" value="${courseNoteView.author_name }">
	            &nbsp;
	            <label>点赞数</label>
	            <input type="text" name="agree" disabled="disabled"  value="${courseNoteView.agree }">
	            &nbsp;
	            <label>记录时间</label>
	            <input type="text" name="note_time" disabled="disabled" value="${courseNoteView.note_time }">
	         </p>
	        </div>
	</form>
</div>
<script type="text/javascript">
	$(function(){
	    var profileVal = $("input[name='note_content']").val();
	    //给JMEditor赋值
	    var editor = CKEDITOR.replace("note_content",{
	 		skin: "moono-lisa",width:540, height:150,margin:"0,0,0,120"
	    });
		if(profileVal!=''){
			editor.setData(profileVal);
		}
	       
	     $("#cke_profile").blur(function(){
	 		$("input[name='note_content']").val(JMEditor.html('note_content'));
	   	});
	})
   
</script>



