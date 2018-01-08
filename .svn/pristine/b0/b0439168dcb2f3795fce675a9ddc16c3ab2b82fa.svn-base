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
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.1.10.2.js"></script>
  <script type="text/javascript">
    $(function(){

      $("#tj").click(function(){

        var u=$("#form").attr("action");
        $.ajax({
          type:'post',
          url:u,
          data:$("#form").serialize(),
          dataType:'json',
          success:function(response){
            alert($("#form").serialize());
          },
          error:function(response){
            alert(123);
          }
        });
      });

    });


  </script>
  <!--
  <link rel="stylesheet" type="text/css" href="styles.css">
  -->
</head>

<body>

<p>模拟文件上传</p>
<form id="form1" action="http://www.buka.tv/room/select.do" method="post" >




  <input type="text" name="user_cipher" value="d93d08d53dd0aeb05a3ab03d5ee8230e">

  <button type="submit">aaa</button>
</form>
<form id="form2" action="http://live.buka.tv/50316" method="post" >
  <input type="text" name="token" value="http://localhost:8080/edu_yun/moni.jsp">
  <input type="text" name="role" value="2">
  <input type="text" name="login_id" value="liyayaya">
  <input type="text" name="room_id" value="50316">
  <button type="submit">aaa</button>
</form>
<form id="form3" action="http://www.buka.tv/room/info.do" method="post" >
  <input type="text" name="user_cipher" value="d93d08d53dd0aeb05a3ab03d5ee8230e">
  <input type="text" name="room_id" value="50322">

  <button type="submit">aaa</button>
</form>


<a href="area/getArea1.action">获取地区</a>
<iframe name="hidden_frame" id="hidden_frame" style="display: none"></iframe>

</body>
</html>
