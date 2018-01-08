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
		<div class="main_right_my_order">
			<ul>
				<li <c:if test="${empty success}">class="curr"</c:if>><a href="${pageContext.request.contextPath}/order/goOrder.action?state=8&pageNo=0&pageSize=4">全部订单</a></li>
				<li <c:if test="${success==2 }">class="curr"</c:if>><a href="${pageContext.request.contextPath}/order/goOrder.action?state=8&pageNo=0&pageSize=4&is_success=2">已支付</a></li>
				<li <c:if test="${success==1 }">class="curr"</c:if>><a href="${pageContext.request.contextPath}/order/goOrder.action?state=8&pageNo=0&pageSize=4&is_success=1">未支付</a></li>
				<li class="main_right_tab_img"><a href="javascript:;"><img src="${pageContext.request.contextPath}/frontstage/images/recycle.jpg"  id="delete"></a></li>
			</ul>
		</div>

		<div class="main_right_content_order">
			<ul>
				<li style="margin-left: 18px;"><input type="checkbox" id="selectAll" ></li>
				<li class="order_name">商品名称</li>
				<li class="order_price">订单金额</li>
				<li class="order_time">下单时间</li>
				<li class="order_states">订单状态</li>
				<li class="order_operate">操作</li>
			</ul><br/>
			<c:forEach items="${orders}" var="order" varStatus="status">
				<div class="order_info">

					<p class="order_info_txt">订单号<span class="order_num">${order.order_number}</span></p>
					<ul>

						<li><input type="checkbox" name="checkboxBtn"></li>
						<li class="order_name_" title="${order.file_catalog.title }" >
							<c:if test="${fn:length(order.file_catalog.title) >= 10}">
								<span class="order_name_txt">${fn:substring(order.file_catalog.title,0,10)}...</span>
							</c:if>
							<c:if test="${fn:length(order.file_catalog.title) < 10}">
								<span class="order_name_txt">${order.file_catalog.title }</span>
							</c:if>
						</li>

						<li class="order_price_"><span class="order_price_num">${order.transaction_amount}</span>元</li>
						<li class="order_time_"><fmt:formatDate type="both"  value="${order.create_time}" /></li>
						<c:if test="${order.is_success==1}"> <li class="order_states_">未支付</li></c:if>
						<c:if test="${order.is_success==2}"> <li class="order_states_">已支付</li></c:if>
						<c:if test="${order.is_success==0}"> <li class="order_states_">交易关闭</li></c:if>
						<c:if test="${order.is_success==1}"> <li class="order_operate_"><button value="${order.id}" class="pay"  name="${pageContext.request.contextPath}/order/to_order.action" >付款</button></li>
						</c:if>
						<c:if test="${order.is_success==1}">
							<li class="order_operate_2"><a href="${pageContext.request.contextPath}/order/cancelOrder.action" class="cancel" name="${order.id}" onclick="return false">取消订单</a></li>
						</c:if>
					</ul>

				</div>
			</c:forEach>
			<form id="fileForm" action="${pageContext.request.contextPath}/order/goOrder.action" method="post">
				<input type="hidden" name="pageNo" id="page" value="${pageNo }"/>
				<input type="hidden" name="pageSize" id="rows" value="${pageSize }"/>
				<input type="hidden" name="total" id="total" value="${total }"/>
				<input type="hidden" name="totalPage" id="totalPage" value="${totalPage}"/>

				<input type="hidden" name="state" value="8">


			</form>
			<c:if test="${!empty orders}">
				<div id="test" class="pager">
				</div>
			</c:if>
		</div>

	</div>

</div>




<script type="text/javascript">
$(function(){

  /*
	*给全选添加click事件
	*/
	$("#selectAll").click(function(){
		/*
		*获取全选的状态
		*/
		var bool=$("#selectAll").prop("checked");
		
		if(bool==true){
			$(":checkbox[name=checkboxBtn]").prop("checked",this.checked);
		}else{
			$(":checkbox[name=checkboxBtn]").attr("checked", false);
		}
		});
/*
	给所有条目的复选框添加click事件
	*/
	   /*
	$(":checkbox[name=checkboxBtn]").click(function() {
		var all = $(":checkbox[name=checkboxBtn]").length;//所有条目的个数
		var select = $(":checkbox[name=checkboxBtn][checked=true]").length;//获取所有被选择条目的个数
		
		if(all == select) {//全都选中了
			$("#selectAll").attr("checked", true);//勾选全选复选框
		} else if(select == 0) {//谁都没有选中
			$("#selectAll").attr("checked", false);//取消全选
		} else {
			$("#selectAll").attr("checked", false);//取消全选
		}
	}); */


  $("#delete").click(function(){
    
  
    var url="/edu_yun/order/deleteOrder.action";
    var ids="";
			$("input[name='checkboxBtn']").each(function(){
				 if(this.checked == true){
				ids+=$(this).val();
				ids+=",";
				} 
			});
			if(ids == null || ids == ""){
				alert("请选择要删除的订单!");
			}else{
     $.ajax({
		 url : url+"?ids="+ids,
			dataType:'json',
				success : function(json) {
				
				 location.replace(location.href);
				
				
				}
				
				});
}
});

 $(".cancel").click(function(){
    
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


 $(".pay").click(function(){
    
    var id=$(this).attr("value");
    var url=$(this).attr("name");
     var form=$("<form>");//定义一个form表单
			form.attr("style","display:none");
			form.attr("target","");
			form.attr("method","post");
			form.attr("action",url);
			var input=$("<input>");
			input.attr("type","hidden");
			input.attr("name","id");
			input.attr("value", id);
		
			$("body").append(form);//将表单放置在web中
			form.append(input);
		
			form.submit();//表单提交 });
		
    

});

});

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