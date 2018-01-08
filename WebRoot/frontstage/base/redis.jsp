<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

 <div class="resource_ranks_left">
        <div class="rank_title">今日资源贡献排行榜</div>
        <ul>
        <c:forEach items="${rankViews}" var="rankView" varStatus="en">
        	${rankView.username}
            <li><span class="rank_no">${en.count}</span><span class="rank_name">
                <a href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id=${rankView.user_id}" target="_blank">${rankView.username}</a>
            </span><span class="resource_num">${rankView.uploadCount}份</span></li>
         </c:forEach>
        </ul>
    </div>
 
