<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>


<div class="cn-wrap">

    <div id="content-container" class="container">
      <jsp:include page="course_header.jsp"></jsp:include>
        <div class="row">
          <jsp:include page="course_left.jsp"></jsp:include>
            <div class="col-md-9">

                <div class="panel panel-default panel-col course-data">
                    <div class="panel-heading">课程学习数据</div>
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table class="table table-striped" id="learning-data-table" style="word-break:break-all;text-align:center;">
                                <tbody>
                                <tr class="active">
                                    <td>班级名</td>
                                    <td>学习人数</td>
                                    <td>完成人数</td>
                                    <td>考试人数</td>
                                    <td>作业人数</td>
                                    <td>研讨人数</td>
                                </tr>
                                <c:forEach items="${classDatas}" var="data">
                                <tr>
                                    <td><a data-toggle="modal" data-target="#modal"  href="javascript:">${data.name}</a></td>
                                    <td>${data.studentCount}</td>
                                    <td>${data.finishCount}</td>
                                    <td>${data.examCount}</td>
                                    <td>${data.homeworkCount}</td>
                                    <td>${data.discussCount}</td>
                                </tr>
                                </c:forEach>
                               
                              
                                </tbody>
                            </table>
                            
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>



</div>


