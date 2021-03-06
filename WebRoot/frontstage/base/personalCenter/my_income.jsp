<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>

<jsp:include page="../layout/header.jsp"></jsp:include>
<link href="${pageContext.request.contextPath}/frontstage/css/my-space.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/my-space.js"></script>
<div class="layout_top">
<jsp:include page="./personal_header.jsp"></jsp:include>

	<div  class="main_right_style">
		<div class="income_record">财富记录</div>


		<div class="main_right_content my_income_record_content">
			<div class="account_balance">账户余额:<span>${user.wealth}</span>元<input type="button" value="充值" ></div>
			<div class="account">
				<div class="account_record"><a href="javascript:;">账户记录</a></div>
				<div class="account_withdraw"><a href="javascript:;">提现记录</a></div>
			</div>

			<ul style="margin-top: 20px;">
				<li class="recharge_time">时间</li>
				<li class="recharge_method">方式</li>
				<li class="recharge_num">充值金额</li>
				<li class="recharge_balance">账户余额</li>
			</ul>
			<c:forEach items="${logs}" var="log" varStatus="status">
				<ul >
					<li class="recharge_time_">${log.operation_time}</li>
					<li class="recharge_method_">${log.operation_description}</li>
					<li class="recharge_num_"><c:if test="${log.value>0}">+${log.value}</c:if>
						<c:if test="${log.value<0}">-${0-log.value}</c:if></li>
					<li class="recharge_balance_">${log.total_value}</li>
				</ul>
			</c:forEach>
			<form id="fileForm" action="${pageContext.request.contextPath}/my_resources/goIncome.action" method="post">
				<input type="hidden" name="pageNo" id="page" value="${pageNo }"/>
				<input type="hidden" name="pageSize" id="rows" value="${pageSize }"/>
				<input type="hidden" name="total" id="total" value="${total }"/>
				<input type="hidden" name="totalPage" id="totalPage" value="${totalPage}"/>

				<input type="hidden" name="state" value="7">


			</form>
			<div id="test" class="pager">
			</div>

		</div>

	</div>
</div>





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