<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1">
    <meta name="renderer" content="webkit">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <title>课程展示-课程简介</title>

    <link href="../../../css/bootstrap/main.css" rel="stylesheet">

    <style>
        .course_score_lever>div{font-size: 16px;line-height: 40px;}
        .course_score_lever>div>p{padding: 0 16px;display: inline-block;}
        .class-about img{max-width: 100%;}
        .course_score_lever{margin-bottom: 15px;border-radius: 4px;
            background: -webkit-linear-gradient(left,#d57338, #d3cf54,#d57338); /* Safari 5.1 - 6.0 */
            background: -o-linear-gradient(left,#d57338, #d3cf54,#d57338);/* Opera 11.1 - 12.0 */
            background: -moz-linear-gradient(left,#d57338, #d3cf54,#d57338); /* Firefox 3.6 - 15 */
            background: linear-gradient(left,#d57338, #d3cf54,#d57338); /* 标准的语法 */
        }

    </style>

</head>
<body >

<div class="col-lg-9 col-md-8  course-detail-main">

    <section class="cn-section">

        <div class="course-detail-content">

            <div class="cn-piece">
                <div class="piece-body p-lg clearfix">
                    <div class="class-about">
                      ${courseInfo.profile}
                        
                    </div>
                </div>
            </div>

          







        </div>
    </section>



</div>





</body>
</html>