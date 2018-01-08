<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<div class="cn-wrap">

    <div id="content-container" class="container">

        <div class="row">
            <div class="panel panel-default panel-page panel-create-course">
                <div class="panel-heading"><h2>增加用户</h2></div>
                <form id="saveLesson" action="${pageContext.request.contextPath}/lesson/save_lesson_add_user.action" class="form-horizontal" method="post">
                 	<input name="lesson_id" type="hidden" value="${lesson_id}"/>
                    <table class="table" width="100%" layoutH="138">
						<thead>
							<tr>
								<th>选择</th>
								<th width="">成${lesson_id}员</th>
								<th width="">区域</th>
								<th width="">单位</th>
								<th width="">角色</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${userList}" var="uesr" varStatus="status">
							<tr>
								<td><input type="checkbox" name="boxes" data-name="user_id" id="boxes" value="${uesr.user_id}"></td>
								<td align="center">${uesr.true_name}</td>
								<td align="center">${uesr.user_id}</td>
								<td align="center">${uesr.true_name}</td>
								<td align="center">test</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>

                    <div class="text-center">
                        <input class="btn btn-fat btn-primary" type="button" onclick="doSumbit();" value="下一步">
                    </div>
                </form>
            </div>
        </div>
    </div>
    <jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>

</div>

<script type="text/javascript">
function validate(){
	var train_name = $("#train_name").val();
	if(train_name==""){
		$(".help-block").show();
		return false;
	}else{
		$(".help-block").hide();
		return true;
	}
}
function doSumbit(){
//	var val = validate();
//	if(val){
    	document.getElementById('saveLesson').submit();
//	}
}
$(function(){
	$("input").blur(function(){
//		validate();
  	});
});
    
checkedIds="";//翻页保存选中的id

function changeIds(){
     var oneches=document.getElementsByName("checkbox");
   for(var i=0;i<oneches.length;i++){
       if(oneches[i].checked==true){
           //避免重复累计id （不含该id时进行累加）
           if(checkedIds.indexOf(oneches[i].value)==-1){
               checkedIds=checkedIds+oneches[i].value+",";
           }
       }
       if(oneches[i].checked==false){
           //取消复选框时 含有该id时将id从全局变量中去除
           if(checkedIds.indexOf(oneches[i].value)!=-1){
               checkedIds=checkedIds.replace((oneches[i].value+","),"");
           }
       }
   }
}

function getChecked(){
      var oneches=document.getElementsByName("checkbox");
   for(var i=0;i<oneches.length;i++){
           //全局变量中含有id，则该复选框选中
           if(checkedIds.indexOf(oneches[i].value)!=-1){
               oneches[i].checked=true;
           }
       }
}

</script>