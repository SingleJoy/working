<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!--图片放大控件end-->
 <style type="text/css">
 .tableForm td{
 font-size: 14px;
 color:black;
 
 }
  .tableForm{
  
  margin-left: 100px;
  
  }
 </style>
 	
 
  <table  class="tableForm" >
  <tr><td>&nbsp;</td></tr>
			<tr>
			
				<th>姓名:</th>
				<td >${userInfo.true_name }
				</td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr>
				<th>性别:</th>
				<td>
				<c:if test="${userInfo.sex==0 }">女</c:if>
				<c:if test="${userInfo.sex==1 }">男</c:if>
				
				</td>
				
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
			<th colspan="1">身份证号码:</th>
				<td>${userInfo.ID_number }
				</td>
			</tr>
				<tr><td>&nbsp;</td></tr>
			<tr>
			<c:if test="${userInfo.type==0 }">
			<th colspan="1">认证类型:</th>
				<td>
				<c:if test="${userInfo.certificate_type==1 }">
				老师
			</c:if>	
			<c:if test="${userInfo.certificate_type==2 }">
				教研员
			</c:if>	
			<c:if test="${userInfo.certificate_type==3 }">
				其他
			</c:if>	
				</td></c:if>
			<c:if test="${userInfo.type==1 }">
			<th colspan="1">管理员类型:</th>
				<td>学校管理员
				</td></c:if>
				<c:if test="${userInfo.type==2 }">
			<th colspan="1">管理员类型:</th>
				<td>县级管理员
				</td></c:if>
				<c:if test="${userInfo.type==3 }">
			<th colspan="1">管理员类型:</th>
				<td>市级管理员
				</td></c:if>
				<c:if test="${userInfo.type==4 }">
			<th colspan="1">管理员类型:</th>
				<td>省级管理员
				</td></c:if>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<th>学段科目:</th>
				<td>${userInfo.course }
				</td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr>
				<th>年级:</th>
				<td>${grade }
				</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
			<th>版本:</th>
				<td>${pubver }
				</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
			<th>职称:</th>
				<td>${titles }
				</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
			<th>职位:</th>
				<td>${position }
				</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<th>邮箱:</th>
				<td>${user.email }
				</td>
			
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>	<th>手机号码:</th>
				<td>${user.phone }
				</td>
				</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<th>省,市,县:</th>
				<td>${province }
				<c:if test="${city!='' }">
				/${city }
				</c:if>
				<c:if test="${county!='' }">
				/${county }
				</c:if>
				
				</td>
			
			<tr><td>&nbsp;</td></tr>
			<tr>
				<th>学校或地区:</th>
				<td>
				${userInfo.school}
				</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
			<th>验证图片:</th>
			<td>
			<c:if test="${!empty userInfo.picture1}">	<a href="${pageContext.request.contextPath}${userInfo.picture1}" target="_blank">
			<img  id="img_cer"  src="${pageContext.request.contextPath}${userInfo.picture1}" style="border:0px;width:60px;height:60px;" />
			</a></c:if>
		    &nbsp;
			<c:if test="${!empty userInfo.picture2}">	<a href="${pageContext.request.contextPath}${userInfo.picture2}" target="_blank">
			<img  id="img_cer"  src="${pageContext.request.contextPath}${userInfo.picture2}" style="border:0px;width:60px;height:60px;" />
			</a></c:if>
			&nbsp;
			<c:if test="${!empty userInfo.picture3}">	<a href="${pageContext.request.contextPath}${userInfo.picture3}" target="_blank">
			<img  id="img_cer"  src="${pageContext.request.contextPath}${userInfo.picture3}" style="border:0px;width:60px;height:60px;" />
			</a></c:if>
			</tr>
		</table>
			
 </body>
 <script>
 function fangda(src){
 var img=$("#img_cer");
$("#show").show();

 }
 
 </script>
