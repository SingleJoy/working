<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="../layout/header.jsp"></jsp:include>
<link href="${pageContext.request.contextPath}/frontstage/css/my-space.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/my-space.js"></script>
<div class="layout_top">
<jsp:include page="./personal_header.jsp"></jsp:include>


	<div  class="main_right_style">
		<p class="score_use">积分使用情况</p>

		<div class="main_right_my_score">



			<c:forEach items="${logs}" var="log" varStatus="status">

				<div class="score_use_time_date">
					<c:set var="strings" value="${fn:split(log.operation_time, ' ')}" />
					<span>${strings[0]}</span>
					<span style="padding-bottom: 10px;">${strings[1]}</span>
				</div>

				<div class="score_use_states"><span class="use_purpose">${log.operation_description}</span>
					<a href="${pageContext.request.contextPath}/my_resources/deleteScore.action" class="delete" name="${log.id}" onclick="return false"><img src="${pageContext.request.contextPath}/frontstage/images/recycle.jpg" ></a>
					<span class="score_use_num_"><c:if test="${log.value>0}">+</c:if><c:if test="${log.value<0}">-</c:if>${log.value}</span>
				</div>

			</c:forEach>
			<form id="fileForm" action="${pageContext.request.contextPath}/my_resources/goScore.action" method="post">
				<input type="hidden" name="pageNo" id="page" value="${pageNo }"/>
				<input type="hidden" name="pageSize" id="rows" value="${pageSize }"/>
				<input type="hidden" name="total" id="total" value="${total }"/>
				<input type="hidden" name="totalPage" id="totalPage" value="${totalPage}"/>

				<input type="hidden" name="state" value="6">


			</form>
			<div id="test" class="pager">
			</div>


		</div>
	</div>
</div>


<script type="text/javascript">
$(function(){

$(".use_purpose").each(function(){

var str=$(this).html();
//    alert(str);
var strs=str.split(" ");

var str1=strs[0]+"<span class='use_page_title'>\""+strs[1]+"\"</span>"+strs[2];

$(this).html(str1);

});

$(".delete").click(function(){

var id=$(this).attr("name");
var url=$(this).attr("href");
$.ajax({
	 url : url+"?id="+id,
		dataType:'json',
			success : function(json) {
			
			 location.replace(location.href);
			
			
			}
			
			});

});


 });



    //个人空全选
    $("table :checkbox:first").change(function(){
        $(this).closest("table")
                .find(":checkbox:not(:first)")
                .prop("checked", this.checked);
    });

</script>

<script type="text/javascript">
$(function(){
	var isNot = $("#isNot").val();
	if(isNot=="true"){
		$("#sortType").val("1");
		$("#fileForm").submit();
	}
});
function _searchFile(value){
	$("#type").val(value);
	$("#fileForm").submit();
}
function _searchLeft(){
	var page = $("#page").val();
	if(page!=0){
		$("#page").val(page-1);
		$('#fileForm').submit();
	}
}
function _searchRight(){
	var page =  parseInt($("#page").val())+1;
	var total = $("#total").val();
	if(page<total){
		$("#page").val(page);
		$('#fileForm').submit();
	}
}
function _searchSort(value){
	var sortType=$("#sortType").val();
	var sort=$("#sort").val();
	if(sort!=value){
		sortType = 1;
	}
	$("#sort").val(value);
	if(sortType==1){//为默认顺序时选中并倒序
		$("#jt"+value).css("color","#3ebbce");
		$("#jt"+value).find("img").attr("src","${pageContext.request.contextPath}/frontstage/images/download_03.png");
		$("#sortType").val("3");
	}else if(sortType==2){//为正序时选中并默认
		$("#jt"+value).css("color","#000000");
		$("#jt"+value).find("img").attr("src","${pageContext.request.contextPath}/frontstage/images/download_01.png");
		$("#sortType").val("1");
	}else{//为倒序时选中并正序
		$("#jt"+value).css("color","#3ebbce");
		$("#jt"+value).find("img").attr("src","${pageContext.request.contextPath}/frontstage/images/download_02.png");
		$("#sortType").val("2");
	}
	$('#fileForm').submit();
}
</script>
<script type="text/javascript">
$(function(){
	//翻页
	var total = $("#total").val();
	var page =  parseInt($("#page").val())+1;
	var rows=$("#rows").val();
	
    $("#btn5").on('click', function () {
        $("#div1").PageChanged(5);
    });

    $(".pager").pagination({
    	thisPageIndex:page,
        recordCount: total,       //总记录数
        pageSize: rows,           //一页记录数
        onPageChange: function (page) {
            document.title = page;
    		$("#page").val(page-1);
    		$('#fileForm').submit();

        }
    });
});
</script>
<jsp:include page="../layout/footer.jsp"></jsp:include>