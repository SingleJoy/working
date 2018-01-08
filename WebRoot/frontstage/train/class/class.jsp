<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:useBean id="now" class="java.util.Date" scope="page"/>
<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>
<c:if test="${classView.source_type==0 }">
    <link href="${pageContext.request.contextPath}/frontstage/css/course-info.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/course-info.js"></script>
</c:if>

<div class="cn-wrap">

    <div id="content-container" class="container">
        <c:if test="${classView.source_type==0 }">
            <jsp:include page="../course/course_header.jsp"></jsp:include>
        </c:if>
        <c:if test="${classView.source_type==1 }">
            <jsp:include page="../train/train_header.jsp"></jsp:include>
        </c:if>

        <div class="row">
            <c:if test="${classView.source_type==0 }">
                <jsp:include page="../course/course_left.jsp"></jsp:include>
            </c:if>
            <c:if test="${classView.source_type==1 }">
                <jsp:include page="../train/train_left.jsp"></jsp:include>
            </c:if>
            <div class="col-md-9"> 
            
                <div class="panel panel-default panel-col">
                    <div class="panel-heading">
                        <div class="pull-right">
                            <a <c:if test="${classView.source_type==0 }">href="${pageContext.request.contextPath}/class/to_class_add_or_update.action?source_id=${courseView.id}&source_type=${classView.source_type }&sign=${courseView.sign }&flag=${courseView.flag }"</c:if>
                               <c:if test="${classView.source_type==1 }">href="${pageContext.request.contextPath}/class/to_class_add_or_update.action?source_id=${trainView.id}&source_type=${classView.source_type }&sign=${trainView.sign }&flag=${trainView.flag }"</c:if>   class="btn btn-info btn-sm"><span class="glyphicon glyphicon-plus"></span> 新建班级</a>
                        </div>
                        	班级管理
                    </div>

                    <div class="panel-body " id="quiz-table-container">
                        <form id="classForm" class="form-horizontal"
                              <c:if test="${classView.source_type==0 }">action="${pageContext.request.contextPath}/class/to_class.action?id=${courseView.id}&flag=2&source_id=${courseView.id}&source_type=0&jumpType=-1"</c:if>
                              <c:if test="${classView.source_type==1 }">action="${pageContext.request.contextPath}/class/to_class.action?id=${trainView.id}&flag=2&source_id=${trainView.id}&source_type=1&jumpType=-1"</c:if> method="post">

                            <div class="form-group">
                                <div class="col-md-4 controls">
                                    <input type="text" id="keyword"  name="name" class="form-control" value="${classView.name}" placeholder="请输入班级名称">
                                </div>
                                <div class="col-md-2 controls">
                                    <button class="btn btn-primary">搜索</button>
                                </div>

                            </div>

                            <c:if test="${classView.source_type==0 }"><input type="hidden" name="sign" value="${courseView.sign}" /></c:if>
                            <c:if test="${classView.source_type==1 }"><input type="hidden" name="sign" value="${trainView.sign}" /></c:if>
							<input type="hidden" name="page" id="page" value="${classView.page}" /> 
							<input type="hidden" name="rows" id="rows" value="${classView.rows}" />
							<input type="hidden" name="total" id="total" value="${classView.total}" />
						    <input type="hidden" name="totalPage" id="totalPage" value="${classView.totalPage}" />

                        </form>
                        <form  class="form-horizontal" id="delClass"
                               <c:if test="${classView.source_type==0 }">action="${pageContext.request.contextPath}/class/del_class.action?sourceId=${courseView.id}&sourceType=0&sign=14"</c:if>
                               <c:if test="${classView.source_type==1 }">action="${pageContext.request.contextPath}/class/del_class.action?sourceId=${trainView.id}&sourceType=1&sign=10"</c:if>  method="post">

                            <div class="form-group">
                                <div class="col-md-12 controls ">
                                    <table class="table table-hover" id="quiz-table" style="text-align: center;">
                                        <thead>
                                        <tr>
                                            <th width="4%" style="text-align: center;">
                                                <input class="checkAll subCheckbox" type="checkbox" autocomplete="off">
                                            </th>
                                            <th width="8%" style="text-align: center;">班次</th>
                                            <th style="text-align: center;">班级名称</th>
                                            <th  style="text-align: center;">开班日期</th>
                                            <th  style="text-align: center;">报名截止日期</th>
                                            <th style="text-align: center;">学员人数</th>
                                            <th  style="text-align: center;">状态</th>
                                            <th  style="text-align: center;">操作</th>
                                        </tr>
                                        </thead>

                                        <tbody class="sel-div">
                                        <c:forEach items="${classList }" var="cla">
                                            <tr>
                                                <td><input class="subCheckbox" type="checkbox" autocomplete="off" id="id${cla.id }" name="classId" value="${cla.id }"  <c:if test="${cla.status ==1}">disabled="disabled"</c:if> ></td>
                                                <td> ${cla.classes} </td>
                                                <td style="text-overflow:ellipsis;white-space: nowrap;max-width: 100px;overflow: hidden;" title="${cla.name }">${cla.name }</td>
                                                <td>
                                                    <span class="text-muted text-sm"><c:if test="${!empty cla.open_time }"><fmt:formatDate value="${cla.open_time}" type="date"/></c:if>  </span>
                                                </td>
                                                <td>
                                                    <span class="text-muted text-sm"><c:if test="${!empty cla.end_time }"><fmt:formatDate value="${cla.end_time}" type="date"/></c:if>  </span>
                                                </td>
                                                <td>${cla.stunum } </td>
                                                <td><c:choose>
                                                    <c:when test="${cla.status==0}">未发布</c:when>
                                                    <c:when test="${cla.status==1}">已发布</c:when>
                                                    <c:when test="${cla.status==2 ||(cla.status==1&&now>cla.open_time)}">进行中</c:when>
                                                    <c:when test="${cla.status==3}">已完成</c:when>
                                                    <c:when test="${cla.status==4}">已结业</c:when>
                                                    <c:otherwise>已删除</c:otherwise>
                                                </c:choose></td>
                                                <td>
                                                    <div class="btn-group">
                                                        <a href="${pageContext.request.contextPath}/class/to_class_home.action?id=${cla.id}&flag=2&sign=2&source_id=${cla.source_id}&source_type=${cla.source_type}" target="_blank" class="btn btn-default btn-sm show_pop" >管理</a>
                                                        <a href="javascript:;" type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown">
                                                            <span class="caret"></span>
                                                        </a>
                                                        <ul class="<c:if test="${cla.status ==0}">dropdown-menu</c:if> pull-right">
                                                              <c:if test="${cla.status ==0}">
                                                               <li>
                                                                   <a href="javascript:" class="del-question" onclick="delClass(${cla.id });">
                                                                       <span class="glyphicon glyphicon-remove-circle"></span> 删除
                                                                   </a>
                                                               </li>
                                                               <li>
                                                                   <a href="javascript:" class="del-question" onclick="doRelease1(${cla.id });">
                                                                       <span class="glyphicon glyphicon-ok-circle prs"></span> 发布
                                                                   </a>
                                                               </li>
                                                              </c:if>
                                                                
                                                        </ul>
                                                    </div>

                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <c:if test="${!empty classList }"><div id="test" class="pager" ></div></c:if>
                        </form>

                        <c:if test="${empty classList&&classView.source_type==0}"><div class="empty" >该课程还未开班</div> </c:if>
                        <c:if test="${empty classList&&classView.source_type==1}"><div class="empty" >该培训还未开班</div></c:if>

                        <div>
                            <label class="checkbox-inline">
                                <input class="checkAll subCheckbox" type="checkbox" autocomplete="off"> 全选
                            </label>
                            <button class="btn btn-default btn-sm mlm del-sel" onclick="delClass(null);">删除</button>
                            <span class="pull-right text-muted">共 ${classView.total}个班级</span>
                        </div>
                        <nav class="text-center"></nav>
                    </div>
                </div>
            </div>
         </div>
   </div>
    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>

</div>
<script type="text/javascript">
  $(function(){
	//翻页
		var total = $("#total").val();
		var page =  parseInt($("#page").val())+1;

		$("#btn5").on('click', function () {
			$("#div1").PageChanged(5);
		});

		$(".pager").pagination({
			thisPageIndex:page,
			recordCount: total,       //总记录数
			pageSize:  $("#rows").val(),            //一页记录数
			onPageChange: function (page) {
				document.title = page;
				$("#page").val(page-1);
				$('#classForm').submit();

			}
		});
	});
  //更改班级为删除状态
  function delClass(value){
	  var result = confirm("您真的确定要删除吗？");
	  if(result){
		  if(value!=null){
			  $('#id'+value).attr("checked",true);
		  }
		  document.getElementById("delClass").submit();
	  }else{
		  return false
	  }
	  
  }
  
  function doRelease1(id){
	  var result = confirm('您真的要发布该班级吗？');
      if(result){
      	 $.ajax({
 			  url : '${pageContext.request.contextPath}/class/change_status.action',
 			  dataType : 'json',
 			  data:{
 				  id : id,
 				status : 1
 	   		  }, 
 	   		  success:function(data){
 	   			 window.location.reload(true); 
 	   		  }
      	});
      }
	   
  }

  $(function(){

      // 全选
      $(".checkAll").click(function () {
          var isChecked = $(this).prop("checked");
          $(".subCheckbox").prop("checked", isChecked);
      })

  });
</script>
