<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>

<jsp:include page="layout/header.jsp"></jsp:include>
<link href="${pageContext.request.contextPath}/frontstage/css/pay.css" rel="stylesheet" type="text/css">


<div class="main_pay">
    <div class="admin_NO">当前账号:<span class="admin_name">${currentUser.username }</span></div>
    <div class="pay_goods">购买商品:
         <ul>
            <li><img src="${pageContext.request.contextPath}/frontstage/images/word_03.png">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="goods_name">${fileBase.file_catalog.title }</span></li>
            <li class="goods_info">文档大小:<span class="goods_size">${fileBase.size }</span></li>
        </ul>
    </div>
    <div class="pay_price">应付金额:<span class="price_num">${order.transaction_amount}</span>&nbsp;元
        <ul>
            <li><a href="#">网上银行</a></li>
            <li><a href="#">手机支付</a></li>
            <li><a href="#">支付宝</a></li>
            <li><a href="#">微信</a></li>
        </ul>
    </div><br/><br/>
    <div class="pay_method">支付方式:<img src="${pageContext.request.contextPath}/frontstage/images/zhifubao.jpg"></div><br/>
    <button type="button" class="pay_now"  name="${pageContext.request.contextPath}/order/submitOrder.action" value="${order.id}">立即支付</button>
</div>

<script type="text/javascript">
      $(function(){
      
       $(".pay_now").click(function(){
         
         var id=$(this).attr("value");
         var url=$(this).attr("name");
       
			
          $.ajax({
			 url : url+"?id="+id,
				dataType:'json',
					success : function(json) {
					
					alert(json.msg);
				self.location=document.referrer;
				
					
					}
					
					});
     
     });
     
   });
</script>
<jsp:include page="layout/footer.jsp"></jsp:include>