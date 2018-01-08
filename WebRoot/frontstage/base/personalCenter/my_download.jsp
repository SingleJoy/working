<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="../layout/header.jsp"></jsp:include>
<link href="${pageContext.request.contextPath}/frontstage/css/my-space.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/my-space.js"></script>
<div class="layout_top">
<jsp:include page="./personal_header.jsp"></jsp:include>


    <div  class="main_right_style">

        <div class="download_list">
            <form action="${pageContext.request.contextPath}/my_download/showDownload.action" id="form" method="post">
                <input type="hidden" name="page" id="page" value="${myCollectView.page}"/>
                <input type="hidden" name="rows" id="rows" value="${myCollectView.rows}"/>
                <input type="hidden" name="total" id="total" value="${myCollectView.total}"/>
                <input type="hidden" name="totalPage" id="totalPage" value="${myCollectView.totalPage}"/>
            </form>
            <ul>
                <li>下载列表</li>
                <li><a href="javascript:;"><img src="${pageContext.request.contextPath}/frontstage/images/recycle.jpg" onclick="del()" ></a></li>
            </ul>

        </div>



        <div  class="my_download_list_page">

            <table id="table">
                <c:if test="${!empty down }">
                    <tr>
                        <th style="width: 30px;"><input type="checkbox"></th>
                        <th style="width: 250px;">名称</th>
                        <th style="width: 120px;">大小</th>
                        <th style="width: 120px;">分类</th>
                        <th style="width: 120px;">上传用户</th>
                        <th style="width: 120px;">下载时间</th>
                        <th style="width: 80px;">评分</th>
                    </tr>
                </c:if>
                <c:if test="${empty down }">
                    <div class="no_data">暂无数据</div>

                </c:if>
                <c:forEach items="${down}" var="d">



                    <tr class="tr_content">
                        <td style="width: 30px;"><input name="checkboxBtn" type="checkbox" value="${d.id}"></td>

                        <td style="width: 250px;" class="list_name_" >
                            <span class="list_name_txt"><a href="${pageContext.request.contextPath}/read/toRead.action?id=${d.id}">${d.fileName}</a></span></td>
                        <td style="width: 120px;" class="list_formate_">${d.size}</td>
                        <td style="width: 120px;" class="list_size_">${d.type}</td>
                        <td style="width: 120px;" class="list_person_">${d.uploaderName}</td>
                        <td style="width: 120px;" class="list_time_">${d.time}</td>
                        <td style="width: 80px;"class="list_score_">${d.score}</td>
                    </tr>
                </c:forEach>

            </table>
            <c:if test="${!empty down }">
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
			window.location.href="${pageContext.request.contextPath}/my_download/deletes.action?ids="+ids+"&page="+$("#page").val()
		}
		
  
 
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