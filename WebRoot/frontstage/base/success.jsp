<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/jquery.1.10.2.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		
		alert("密码已修改");
		$("#body").load("${pageContext.request.contextPath}/user/resetPassword.action");
	});
</script>
</head>
<body id="body" >


</body>
</html>