<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="../layout/header.jsp"></jsp:include>
<link href="${pageContext.request.contextPath}/frontstage/css/my-space.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/my-space.js"></script>

<div class="layout_top">
<jsp:include page="./personal_header.jsp"></jsp:include>

    <div  class="main_right_style">
        <div class="main_right_my_collection">
            <form action="${pageContext.request.contextPath}/my_collect/showCollect.action" id="form" method="post">
                <input type="hidden" name="page" id="page" value="${myCollectView.page}"/>
                <input type="hidden" name="rows" id="rows" value="${myCollectView.rows}"/>
                <input type="hidden" name="total" id="total" value="${myCollectView.total}"/>
                <input type="hidden" name="totalPage" id="totalPage" value="${myCollectView.totalPage}"/>
            </form>
            <ul>
                <li>收藏列表</li>

                <li class="main_right_tab_img"><a href="javascript:;"><img src="${pageContext.request.contextPath}/frontstage/images/recycle.jpg" onclick="del()"></a></li>
            </ul>
        </div>

        <!-- <form id="form" action="" method="post"></form> -->

        <div class="main_right_my_collection_table">

            <table id="table">
                <c:if test="${!empty collect }">
                    <tr>
                        <th style="width: 30px;"><input type="checkbox"></th>
                        <th style="width:200px; ">名称</th>

                        <th style="width: 120px;">大小</th>
                        <th style="width: 120px;">分类</th>
                        <th style="width: 150px;">上传用户</th>
                        <th style="width: 120px;" class="collection_time">收藏日期</th>
                        <th style="width: 100px;" class="collection_score">评分</th>
                    </tr>
                </c:if>
                <c:if test="${empty collect }">

                    <div class="no_data">暂无数据</div>

                </c:if>
                <c:forEach items="${collect}" var="c">
                <input id = 'hidden' type="hidden" value="${c.id}">
                <tr class="tr_content">

                    <td style="width: 30px;"><input name="checkboxBtn" class='checkbox' value='${c.id }' type="checkbox"></td>
                    <td style="width: 200px;" class="collection_name_" title="${c.fileName}"><a href="${pageContext.request.contextPath}/read/toRead.action?id=${c.id}">${c.fileName}</a></td>
                    <td style="width: 120px;"  class="collection_formate_">${c.size}</td>
                    <td style="width: 120px;" class="collection_size_">${c.type}</td>
                    <td style="width: 150px;" class="collection_upload_name_">${c.uploaderName}</td>
                    <td style="width: 120px;" class="collection_time_">${c.time}</td>
                    <td style="width: 100px;" class="collection_score_"><span class="score_num">${c.score}</span><a href="javascript"><img src="${pageContext.request.contextPath}/frontstage/images/download.png"></a><a href="javascript:return false;"><img src="${pageContext.request.contextPath}/frontstage/images/delete.jpg" onclick="shanchu(${c.id})"></a></td>
                <tr>
                    </c:forEach>

            </table>
            <c:if test="${!empty collect }">

                    <div id="test" class="pager">

                    </div>


            </c:if>

        </div>
    </div>

</div>



<script>

$(document).ready(function(){
	/* $.ajax({
		url : '${pageContext.request.contextPath}/myCollect/showCollect.action',
	    dataType:'json',
	    success: function(json){
	    	var a = JSON.stringify(json);
	    	
			var o = eval( "(" + a + ")" );
			for(var i in o){

//				$("#table").append('<tr class="tr_content"><td><input type="checkbox"></td><td class="collection_name_"><img src="${pageContext.request.contextPath}/frontstage/images/word_03.png"><span>'+o[i].fileName+'</span></td><td class="collection_grade_">'+o[i].grade+'</td><td class="collection_upload_name_">'+o[i].uploaderName+'</td><td class="collection_time_">'+o[i].time+'</td><td class="collection_score_"><span class="score_num">'+o[i].score+'</span><a href="#"><img src="${pageContext.request.contextPath}/frontstage/images/download.png"></a><a href="#"><img src="${pageContext.request.contextPath}/frontstage/images/delete.jpg"></a></td><tr>');

            }
	    }
	}); */
	
});
function shanchu( id){
	
	
	
	var url="${pageContext.request.contextPath}/my_collect/delete.action?id="+id+"&userId="+$("#userId").val();
	$("#form").attr("action",url);
	$("#form").submit(); 
}
function del(){
	var ids="";
	$("input[name='checkboxBtn']").each(function(){
		 if(this.checked == true){
		ids+=$(this).val();
		ids+=",";
		} 
	});
	if(ids!=""){
		window.location.href="${pageContext.request.contextPath}/my_collect/deletes.action?ids="+ids+"&page="+$("#page").val();
	}
	
	//alert(ids);
	/* var url="${pageContext.request.contextPath}/myCollect/deletes.action?ids="+ids+"&userId="+$("#userId").val();
	$("#form").attr("action",url);
	$("#form").submit();  */
}
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