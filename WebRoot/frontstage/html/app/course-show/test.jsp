<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>视频播放</title>
</head>
<body>

<video controls preload="none" style="width: 100%;height: 100%;background-color: #000;" autoplay
        >
    <source id="video_source" src="http://192.168.10.253:8090/edu_yun/xbjy/test.mp4" type='video/mp4' />

</video>


<!--<video id="video1"   playsinline  width="100%" height="100%"-->
<!--src="https://st-up.meiyaapp.com/2016/11/28/o_1b2kqd7en5pu6h5o2b1qba1a3m3g99080.mp4">-->
<!---->
<!--</video>-->

</body>
</html>


