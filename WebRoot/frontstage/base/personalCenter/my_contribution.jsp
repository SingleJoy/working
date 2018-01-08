<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../layout/header.jsp"></jsp:include>
<link href="${pageContext.request.contextPath}/frontstage/css/my-space.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/my-space.js"></script>
<div class="layout_top">
<jsp:include page="./personal_header.jsp"></jsp:include>

    <div  class="main_right_style">
        <div class="main_right_my_contribution">
            <form action="${pageContext.request.contextPath}/my_contribution/showMyContribution.action" id="form" method="post">

                <!--  <input id="hidden" type="hidden" value="1"> -->
                <input type="hidden" name="page" id="page" value="${myContributionView.page}"/>
                <input type="hidden" name="rows" id="rows" value="${myContributionView.rows}"/>
                <input type="hidden" name="total" id="total" value="${myContributionView.total}"/>
                <input type="hidden" name="totalPage" id="totalPage" value="${myContributionView.totalPage}"/>
                <input type="hidden" name="fileType" id="fileType" value="${myContributionView.fileType}">
            </form>
                <ul>
                    <li <c:if test="${fileType==0 }"> style="border-bottom: 2px solid #3ebbce;"</c:if>><a onclick="tj(0)" href="javascript:void(0);">所有资源</a></li>
                    <li <c:if test="${fileType==1 }"> style="border-bottom: 2px solid #3ebbce;"</c:if>><a onclick="tj(1)" href="javascript:void(0);">付费资源</a></li>
                    <li <c:if test="${fileType==2 }"> style="border-bottom: 2px solid #3ebbce;"</c:if>><a onclick="tj(2)" href="javascript:void(0);">公开资源</a></li>
                    <li <c:if test="${fileType==3 }"> style="border-bottom: 2px solid #3ebbce;"</c:if>><a onclick="tj(3)" href="javascript:void(0);">私有资源</a></li>
                    <li <c:if test="${fileType==4 }"> style="border-bottom: 2px solid #3ebbce;"</c:if>><a onclick="tj(4)" href="javascript:void(0);">审核中</a></li>
                    <li <c:if test="${fileType==5 }"> style="border-bottom: 2px solid #3ebbce;"</c:if>><a onclick="tj(5)" href="javascript:void(0);">审核未通过</a></li>
                    <li <c:if test="${fileType==6 }"> style="border-bottom: 2px solid #3ebbce;"</c:if>><a onclick="tj(6)" href="javascript:void(0);">已删除</a></li>
                    <!--  <li><a href="javascript:;">评审中</a></li> -->
                    <p><a href="javascript:;"><c:if test="${fileType!=6 }"> <img src="${pageContext.request.contextPath}/frontstage/images/recycle.jpg" onclick="del()" class="delete_img"></c:if></a></p>
                </ul>


            <br/>

            <div class="main_right_my_contribution_table" >

                <table id="table">
                    <c:if test="${!empty Contribution }">
                        <tr>
                            <th style="width: 30px;"><input type="checkbox" class="selectAll"></th>
                            <th class="resources_name" style="width: 250px;">名称</th>
                            <th class="resources_size" style="width: 100px;">大小</th>
                            <th class="resources_formate" style="width: 100px;">分类</th>
                            <th class="resources_upload_time" style="width: 120px;">上传时间</th>
                            <c:if test="${fileType==5 }">
                                <th class="check_time">审核时间</th>
                                <th class="fail_check_reason">审核不通过原因</th>
                            </c:if>
                            <c:if test="${fileType==6 }">
                                <th class="delete_time">删除时间</th>

                            </c:if>

                        </tr>
                    </c:if>



                    <c:if test="${empty Contribution }">

                        <div class="no_data">暂无数据</div>

                    </c:if>

                    <c:forEach items="${Contribution}" var="c">

                        <tr>
                            <td style="width: 30px;"><input name="checkboxBtn" type="checkbox" value="${c.id}" ></td>

                            <td class="resources_name_" title="${c.fileName }" style="width: 250px;"><a href="${pageContext.request.contextPath}/read/toRead.action?id=${c.id}">
                                <c:if test="${fn:length(c.fileName) >= 10}">
                                    ${fn:substring(c.fileName,0,10)}...
                                </c:if>
                                <c:if test="${fn:length(c.fileName) < 10}">
                                    ${c.fileName }
                                </c:if>
                            </a></td>
                            <td class="resources_size_" style="width: 100px;">${c.size}</td>
                            <td class="resources_formate_" style="width: 100px;">${c.type}</td>

                            <td class="resources_upload_time_" style="width: 120px;">${c.time}</td>
                            <c:if test="${fileType==5}">
                                <td class="check_time_">${c.check }</td>
                                <td class="fail_check_reason_">${c.reason }</td>
                            </c:if>
                            <c:if test="${fileType==6}">
                                <td class="delete_time">${c.delete }</td>

                            </c:if>
                        </tr>


                    </c:forEach>


                </table>
            </div>
            <c:if test="${!empty Contribution }">
                <div class="main_content_switch_directory">
                    <div id="test" class="pager">
                    </div>
                </div>
            </c:if>

        </div>
    </div>

</div>

<script>
function del(){
	
	 var ids="";
	$("input[name='checkboxBtn']").each(function(){
		 if(this.checked == true){
		ids+=$(this).val();
		ids+=",";
		} 
	}); 
	if(ids!=""){
		window.location.href="${pageContext.request.contextPath}/my_contribution/deteles.action?ids="+ids+"&fileType="+$("#fileType").val()+"&page="+$("#page").val();
	}
	
	/*  var url="${pageContext.request.contextPath}/MyContribution/deteles.action?ids="+ids+"&fileType="+$("#fileType").val();
	 alert(url);
	$("#delete_form").attr("action",url);
	$("#delete_form").submit();   */

}
function tj(value){
	$("#fileType").val(value);
	$("#page").val("0");
	/*  var url="";
	$("#form").attr("action",url); */
	$("#form").submit();
}
    //个人中心全选
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
