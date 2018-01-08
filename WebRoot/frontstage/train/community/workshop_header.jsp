<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="cn-section course-manage-header clearfix" style="margin-top: 20px;">

    <div class="student-num hidden-xs pull-right" >
        <i class="es-icon es-icon-people" style="font-size: 20px;padding-right: 5px;"></i>${workshopView.user_count}人
    </div>

    <a href="javascript:void(0);">
        <img class="picture" src="http://edusoho-demo.b0.upaiyun.com/files/default/2015/06-10/155158e4340f775236.jpg" >

    </a>

    <div class="teachers">
        工作坊名称: ${workshopView.name }<br/>
        坊主：
        <a href="javascript:void(0);" style="line-height: 30px;">
            ${workshopView.workshop_user }
        </a>
    </div>

</div>
