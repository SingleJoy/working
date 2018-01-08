<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="cn-section course-manage-header clearfix" >

    <div class="student-num hidden-xs pull-right" >
        <i class="es-icon es-icon-people" style="font-size: 20px;padding-right: 5px;"></i>${communityView.studentNum}人
    </div>

    <a href="javascript:void(0)">
        <img class="picture" src="${pageContext.request.contextPath}${communityView.head_img}" >

    </a>

    <div class="teachers">
        ${communityView.name }<br/>
  	
    </div>

</div>