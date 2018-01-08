<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="../layout/header.jsp"></jsp:include>
<link href="${pageContext.request.contextPath}/frontstage/css/my-space.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/my-space.js"></script>
<div class="layout_top">
<jsp:include page="./personal_header.jsp"></jsp:include>

	<div class="main_right_style">

		<form id="form"
			  action="${pageContext.request.contextPath}/my_resources/showMyResources.action"
			  method="post">

			<div class="main_right_resources">

				<input type="hidden" name="page" id="page"
					   value="${resourcesModel.page}" /> <input type="hidden" name="rows"
																id="rows" value="${resourcesModel.rows}" /> <input type="hidden"
																												   name="total" id="total" value="${resourcesModel.total}" /> <input
					type="hidden" name="totalPage" id="totalPage"
					value="${resourcesModel.totalPage}" /> <input type="hidden"
																  name="columnId" id="columnId" value="${columnId }">
				<%--   	<input type="hidden" name="stageId" id="stageId" value="${resourceView.stageId}"/>
           <input type="hidden" name="subjectId" id="subjectId" value="${resourceView.subjectId}"/>
           <input type="hidden" name="editionId" id="editionId" value="${resourceView.editionId}"/>
           <input type="hidden" name="gradeId" id="gradeId" value="${resourceView.gradeId}"/> --%>

				<ul>
					<li <c:if test="${columnId==0 }">class="curr" </c:if>><a
							onclick="tj(0)" href="javascript:;">全部</a></li>
					<li <c:if test="${columnId==1 }">class="curr" </c:if>><a
							onclick="tj(1)" href="javascript:;">同步课件</a></li>
					<li <c:if test="${columnId==2 }">class="curr" </c:if>><a
							onclick="tj(2)" href="javascript:;">课程习题</a></li>
					<li <c:if test="${columnId==3 }">class="curr" </c:if>><a
							onclick="tj(3)" href="javascript:;">教学设计</a></li>
					<li <c:if test="${columnId==4 }">class="curr" </c:if>><a
							onclick="tj(4)" href="javascript:;">课堂实录</a></li>
				</ul>


			</div>





			<div class="main_right_resources_page">
				<select name="stage" id="stage" class="school" onclick="_stage()">
					<c:if test="${empty stageId }">
						<option value="" id="delStage">请选择</option>
					</c:if>
					<option <c:if test="${stageId=='XX'}"> selected="selected"</c:if>
							value="XX">小学</option>
					<option <c:if test="${stageId=='CZ'}"> selected="selected"</c:if>
							value="CZ">初中</option>
					<option <c:if test="${stageId=='GZ'}"> selected="selected"</c:if>
							value="GZ">高中</option>
				</select>
				<!--         <select id="stage" name="stage"  class="school" onclick="stage()"  placeholder="学段">

                <option id="xd" value=''>学段</option>


            </select> -->

				<select name="subject" class="subject" id="subject"
						onclick="_subject();" class="nav_content_sel">
					<c:if test="${empty subjectId}">
						<option value="" id="delSubject">请选择</option>
					</c:if>
					<c:forEach items="${subjectList}" var="sub">
						<c:if test="${subjectId == sub.id}">
							<option selected="selected" value="${sub.id}">${sub.subjectName}</option>
						</c:if>
						<c:if test="${subjectId != sub.id}">
							<option value="${sub.id}">${sub.subjectName}</option>
						</c:if>
					</c:forEach>
				</select> <select name="edition" class="vesion" id="edition"
								  onclick="_edition()" class="nav_content_sel content_sel_1">
				<c:if test="${empty editionId }">
					<option value="" id="delEdition">请选择</option>
				</c:if>
				<c:forEach items="${editionList}" var="edi">
					<c:if test="${editionId == edi.id}">
						<option selected="selected" value="${edi.id}">${edi.versionName}</option>
					</c:if>
					<c:if test="${editionId != edi.id}">
						<option value="${edi.id}">${edi.versionName}</option>
					</c:if>
				</c:forEach>
			</select> <select name="grade" id="grade" onclick="_grade()"
							  class="nav_content_sel">
				<c:if test="${empty gradeId }">
					<option value="" id="delGrade">请选择</option>
				</c:if>
				<c:forEach items="${gradeList}" var="gra">
					<c:if test="${gradeId == gra.id}">
						<option selected="selected" value="${gra.bookCatelogId}">${gra.bookCatelogName}</option>
					</c:if>
					<c:if test="${gradeId != gra.id}">
						<option value="${gra.bookCatelogId}">${gra.bookCatelogName}</option>
					</c:if>
				</c:forEach>
			</select> <input type="submit" value="查询" class="chaxun">

			</div>

		</form>


		<div class="resources_classify">

			<div class="resources_list_page">

				<table>
					<c:if test="${!empty resources }">
						<tr>
							<th style="width: 30px;"><input type="checkbox"></th>
							<th style="width: 250px;">名称</th>
							<th style="width: 120px;">大小</th>
							<th style="width: 120px;">分类</th>
							<th style="width: 120px;">是否公开</th>
							<th style="width:150px;">时间</th>
						</tr>
					</c:if>
					<c:if test="${empty resources }">
						<div class="no_data">暂无数据</div>
					</c:if>

					<c:forEach items="${resources }" var="r">

						<tr>
							<td style="width:30px;"><input name="checkboxBtn" type="checkbox" value="${r.id}"></td>
							<td style="width:250px;" class="resources_list_name_"><a href="${pageContext.request.contextPath}/read/toRead.action?id=${r.id}">${r.fileName}</a></td>
							<td style="width:120px;">${r.size}</td>
							<td style="width:120px;">${r.type}</td>
							<td style="width:120px;">${r.fileType}</td>
							<td style="width:150px;">${r.time}</td>
						</tr>
					</c:forEach>
				</table>
				<c:if test="${!empty resources }">
					<div class="main_content_switch_directory">
						<div id="test" class="pager"></div>
					</div>
				</c:if>

			</div>


		</div>
	</div>

</div>



<script type="text/javascript">
  /*   var i=0;
    $(document).ready(function(){
    	if(i==0){
    		_stage('XX');
    	}
        i=1;
    });  */
    var i =0;
    var j = 0;
    var x=0;
    function _stage(){

	$("#delStage").remove();

		$("#subject").find("option").remove();
		$("#edition").find("option").remove();
		$("#grade").find("option").remove();
		 i = 0;
		 j = 0;
		 x = 0;
	}

	function _subject() {
		

		var value = $("#stage").val();
		$("#delSubject").remove();

		$("#edition").find("option").remove();
		$("#grade").find("option").remove();
		if (i == 0) {
			$("#subject").find("option").remove();
			$
					.ajax({
						url : "${pageContext.request.contextPath}/subject/only_query_subject.action?subId="
								+ value,
						dataType : 'json',
						success : function(json) {
							var a = JSON.stringify(json);

							var o = eval("(" + a + ")");

							for ( var i in o) {
								$("#subject").append(
										'<option  value='+o[i].id+' >'
												+ o[i].subjectName
												+ '</option>');

							}

						}
					});

		}
		i = 1;
		j = 0;
		x = 0;

	}

	function _edition() {
		var value = $("#subject").val();
		$("#delEdition").remove();

		$("#grade").find("option").remove();
		if (j == 0) {
			$("#edition").find("option").remove();
			$
					.ajax({
						url : "${pageContext.request.contextPath}/pubver/only_query_pubver.action?pubId="
								+ value,
						dataType : 'json',
						success : function(json) {
							var a = JSON.stringify(json);
							var edi = eval("(" + a + ")");
							for ( var i in edi) {
								$("#edition").append(
										'<option value='+edi[i].id+' >'
												+ edi[i].versionName
												+ '</option>');
							}
						}
					});
		}
		j = 1;
		x = 0;
	}

	function _grade() {
		var value = $("#edition").val();
		$("#delGrade").remove();

		if (x == 0) {
			$("#grade").find("option").remove();
			$
					.ajax({
						url : "${pageContext.request.contextPath}/book_cat/only_query_book_cat.action?bookId="
								+ value,
						dataType : 'json',
						success : function(json) {
							var a = JSON.stringify(json);
							var gra = eval("(" + a + ")");

							for ( var i in gra) {
								$("#grade").append(
										'<option value='+gra[i].id+' >'
												+ gra[i].bookCatelogName
												+ '</option>');
							}

						}
					});
		}
		x = 1;
	}

	function tj(value) {

		window.location.href = "${pageContext.request.contextPath}/my_resources/showMyResources.action?state=4&page=0&columnId="
				+ value;

	}

	/*  function del(){

	     var ids="";
	     $("input[name='checkboxBtn']").each(function(){
	         if(this.checked == true){
	             ids+=$(this).val();
	             ids+=",";
	         }
	     });


	     var url="${pageContext.request.contextPath}/my_resources/deletes.action?ids="+ids+"&userId="+$("#user").val();
	     $("#form").attr("action",url);
	     $("#form").submit();
	 } */

	$(function() {
		$(".navbar_my_name img")
				.mouseover(
						function() {
							$(".navbar_my_name img")
									.attr("src",
											"${pageContext.request.contextPath}/frontstage/images/menu_top.png");
							$(".admin_states").show();
						})
		$(".admin_states")
				.mouseover(
						function() {
							$(".navbar_my_name img")
									.attr("src",
											"${pageContext.request.contextPath}/frontstage/images/menu_top.png");
							$(".admin_states").show();
						})

		$(".admin_states")
				.mouseout(
						function() {
							$(".navbar_my_name img")
									.attr("src",
											"${pageContext.request.contextPath}/frontstage/images/menu_down.png");
							$(".admin_states").hide();
						})

		$(".navbar_my_name img")
				.mouseout(
						function() {
							$(this)
									.attr("src",
											"${pageContext.request.contextPath}/frontstage/images/menu_down.png");
							$(".admin_states").hide();
						})

	});
</script>

<script>
        //个人空全选
        $("table :checkbox:first").change(function(){
            $(this).closest("table")
                    .find(":checkbox:not(:first)")
                    .prop("checked", this.checked);
        });
        function _searchLeft(){
         	var page = $("#page").val();
         	if(page!=0){
         		$("#page").val(page-1);
         		$('#form').submit();
         	}
         }
         function _searchRight(){
         	var page =  parseInt($("#page").val())+1;
         	var total = $("#total").val();
         	if(page<total){
         		$("#page").val(page);
         		$('#form').submit();
         	}
         }

    </script>
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
        pageSize: 8,           //一页记录数
        onPageChange: function (page) {
            document.title = page;
    		$("#page").val(page-1);
    		$('#form').submit();

        }
    });
});
</script>
<jsp:include page="../layout/footer.jsp"></jsp:include>