<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	
<!DOCTYPE html>
<html>
<head>
<title>中国教师网</title>
<jsp:include page="/backstage/base/inc.jsp"></jsp:include>
</head>
<body class="easyui-layout">
	<div data-options="region:'north',href:'${pageContext.request.contextPath}/backstage/base/layout/north.jsp'" style="height: 60px;overflow: hidden;" class="logo"></div>
	<div data-options="region:'west',title:'功能导航',href:'${pageContext.request.contextPath}/backstage/base/layout/west.jsp'" style="width: 200px;overflow: hidden;"></div>
	<%-- <div data-options="region:'east',title:'日历',split:true,href:'${pageContext.request.contextPath}/admin/layout/east.jsp'" style="width: 200px;overflow: hidden;"></div> --%>
	<div data-options="region:'center',title:'中国教师网',href:'${pageContext.request.contextPath}/backstage/base/layout/center.jsp'" style="overflow: hidden;"></div>
	<div data-options="region:'south',href:'${pageContext.request.contextPath}/backstage/base/layout/south.jsp'" style="height: 20px;overflow: hidden;"></div>
	<jsp:include page="/backstage/base/user/login.jsp"></jsp:include>
	<jsp:include page="/backstage/base/user/reg.jsp"></jsp:include>
	<jsp:include page="/backstage/base/isIe.jsp"></jsp:include>
</body>
</html>