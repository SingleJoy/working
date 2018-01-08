<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
  String path = request.getContextPath();
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <base href="<%=basePath%>">

  <title>My JSP 'index.jsp' starting page</title>
  <meta http-equiv="pragma" content="no-cache">
  <meta http-equiv="cache-control" content="no-cache">
  <meta http-equiv="expires" content="0">
  <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
  <meta http-equiv="description" content="This is my page">
  <!--
  <link rel="stylesheet" type="text/css" href="styles.css">
  -->
</head>

<body>
<form action="user/register.action" method="post">
  注册
  <input type="text" name="username">
  <input type="password" name="password">
  <input type="submit" value="aaaa">
</form>
<br>
<form action="user/frontLogin.action" method="post">
  登录
  <input type="text" name="username">
  <input type="password" name="password">
  <input type="submit" value="aaaa">
</form>
<br>
<form action="user/ceshi.action" method="post">
  <input type="text" name="username">
  <input type="submit" value="aaaa">
</form>
<br>
<form action="user/ceshi1.action" method="post">
  <input type="text" name="username">
  <input type="password" name="password">
  <input type="submit" value="aaaa">
</form>
</body>
</html>
