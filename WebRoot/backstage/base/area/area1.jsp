<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- jquery库 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/backstage/js/jquery-1.8.2.min.js" charset="utf-8"></script>
<!-- easyui相关库 -->
<link id="easyuiTheme" rel="stylesheet" href="${pageContext.request.contextPath}/backstage/js/jquery-easyui-1.3.1/themes/<c:out value="${cookie.easyuiThemeName.value}" default="default"/>/easyui.css" type="text/css"></link>
<link rel="stylesheet" href="${pageContext.request.contextPath}/backstage/js/jquery-easyui-1.3.1/themes/icon.css" type="text/css"></link>
<script type="text/javascript" src="${pageContext.request.contextPath}/backstage/js/jquery-easyui-1.3.1/jquery.easyui.min.js?v0.1" charset="utf-8"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/backstage/js/jquery-easyui-1.3.1/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
<script type="text/javascript">
  function open_area(){
	  parent.sy.messagerConfirm('请确认', '您要开放所选省份？', function(r) {
			if (r) {
				$("#areas").submit();
			}
		});
  }
</script>

<body class="easyui-layout" data-options="fit:true">

	<div data-options="region:'center',border:false" style="overflow: hidden;">
	<form id="areas" action="${pageContext.request.contextPath}/back_area/open_area.action" method="post">
		<input name="parentId" value="${parentId}" type="hidden">
		<table > 
		<tr>
		 <c:forEach items="${areaList}" var="area"  varStatus="status">
		    <td>
		    <span style="padding-right:15px;font-size:16px;">
				<input <c:if test="${area.is_open==0}">checked="checked"</c:if> name="id" value="${area.id }" type="checkbox"/>
					${area.area_name }
			</span>
		    </td>
			<c:if test="${status.count%8==0}">
			</tr>
			<tr>
			</c:if>
		 </c:forEach>
		</tr> 
		</table>
	</form>
		<div id="submit"  style="margin-left: 923px;margin-top: 127px;">
			    <a  href="JavaScript:void(0);" class="easyui-linkbutton" onclick="open_area();" data-options="iconCls:'icon-edit'">开放</a> 
		</div>
	</div>
</body>



