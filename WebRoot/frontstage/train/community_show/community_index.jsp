<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<div class="cn-wrap" style="background-color: #fff;">

	<header style="height: 360px;">
		<%--背景图--%>
		<div class="community_index_header"></div>
		<%--蒙层--%>
		<div class="community_mask"></div>

		<div class="container community_container" >
			<div class="text-center" style="margin-top: 50px;">
				<img  src="${pageContext.request.contextPath}${communityView.head_img}"  class="avatar-lg">
				<div class="community_name" style="font-family: Hannotate SC;" >${communityView.name}</div>
				<div style="margin-top: 20px;">
					<c:if test="${communityCenterView.isJoin==0}">
						<a href="javascript:void(0);" onclick="doJoin();" class="btn btn-info btn-lg">加入社区</a>
					</c:if>
				</div>
			</div>
		</div>
	</header>

	<nav  style="width: 100%;height:50px;margin-top: -50px;z-index: 9;position: relative;">

		<div class="container" >

			<ul class="community_index_nav" style="border: none;">

				<li <c:if test="${communityCenterView.stamp==5}">class="active"</c:if>><a onclick="doSearchIndex(5);" href="javascript:void(0);">主页</a></li>
				<li <c:if test="${communityCenterView.stamp==8}">class="active"</c:if>><a onclick="doSearchIndex(8);" href="javascript:void(0);">资讯</a></li>
				<li <c:if test="${communityCenterView.stamp==0}">class="active"</c:if>><a onclick="doSearchIndex(0);" href="javascript:void(0);">课程</a></li>
				<li <c:if test="${communityCenterView.stamp==1}">class="active"</c:if>><a onclick="doSearchIndex(1);" href="javascript:void(0);">培训</a></li>
				<li <c:if test="${communityCenterView.stamp==2}">class="active"</c:if>><a onclick="doSearchIndex(2);" href="javascript:void(0);">课例</a></li>
				<li <c:if test="${communityCenterView.stamp==3}">class="active"</c:if>><a onclick="doSearchIndex(3);" href="javascript:void(0);">工作坊</a></li>
				<li <c:if test="${communityCenterView.stamp==4 || communityCenterView.stamp==6}">class="active"</c:if>><a onclick="doSearchIndex(4);" href="javascript:void(0);">主题</a></li>
				<li <c:if test="${communityCenterView.stamp==7}">class="active"</c:if>><a onclick="doSearchIndex(7);" href="javascript:void(0);">教师</a></li>
				<li <c:if test="${communityCenterView.stamp==9}">class="active"</c:if>><a onclick="doSearchIndex(9);" href="javascript:void(0);">资源</a></li>
			</ul>

		</div>
	</nav>

	<div class="container">

		<form id="communityForm" action="${pageContext.request.contextPath}/community/to_community_index.action" method="post">
			<input type="hidden" name="id" id="id" value="${communityCenterView.id}"/>
			<input type="hidden" name="rows" id="rows" value="${communityCenterView.rows}"/>
			<input type="hidden" name="page" id="page" value="${communityCenterView.page}"/>
			<input type="hidden" name="total" id="total" value="${communityCenterView.total}" />
			<input type="hidden" name="stamp" id="stamp" value="${communityCenterView.stamp}"/>
			<input type="hidden" name="classifyId" id="classifyId" value="${communityCenterView.classifyId}"/>
			<input type="hidden" name="classifyName" id="classifyName" value="${communityCenterView.classifyName}"/>
			<input type="hidden" name="sonClassifyId" id="sonClassifyId" value="${communityCenterView.sonClassifyId}"/>
			<input type="hidden" name="sonClassifyName" id="sonClassifyName" value="${communityCenterView.sonClassifyName}"/>
			<input type="hidden" name="sortType" id="sortType" value="${communityCenterView.sortType}"/>
			<input type="hidden" name="type" id="type" value="${communityCenterView.type}"/>
			<input type="hidden" name="sourceType" id="sourceType" value="${communityCenterView.sourceType}"/>
			<input type="hidden" name="grade_id" id="grade_id" value="${communityCenterView.grade_id}"/>
			<input type="hidden" name="subject_id" id="subject_id" value="${communityCenterView.subject_id}"/>
			<input type="hidden" name="stage_id" id="stage_id" value="${communityCenterView.stage_id}"/>
			<input type="hidden" name="status" id="status" value="${communityCenterView.status}"/>
		</form>
		<div class="panel-body">
			<c:if test="${communityCenterView.stamp==5}">
				<jsp:include page="community_home.jsp" ></jsp:include>
			</c:if>
			<c:if test="${communityCenterView.stamp==0}">
				<jsp:include page="community_course_show.jsp" ></jsp:include>
			</c:if>
			<c:if test="${communityCenterView.stamp==1}">
				<jsp:include page="community_train_show.jsp" ></jsp:include>
			</c:if>
			<c:if test="${communityCenterView.stamp==2}">
				<jsp:include page="community_lesson_show.jsp" ></jsp:include>
			</c:if>
			<c:if test="${communityCenterView.stamp==3}">
				<jsp:include page="community_workshop_show.jsp" ></jsp:include>
			</c:if>
			<c:if test="${communityCenterView.stamp==4}">
				<jsp:include page="community_topic_show.jsp" ></jsp:include>
			</c:if>
			<c:if test="${communityCenterView.stamp==6}">
				<jsp:include page="community_topic_detail.jsp" ></jsp:include>
			</c:if>
			<c:if test="${communityCenterView.stamp==7}">
				<jsp:include page="community_teacher.jsp" ></jsp:include>
			</c:if>
			<c:if test="${communityCenterView.stamp==8}">
				<jsp:include page="community_news.jsp" ></jsp:include>
			</c:if>
			<c:if test="${communityCenterView.stamp==9}">
				<jsp:include page="community_resource_show.jsp" ></jsp:include>
			</c:if>
		</div>

	</div>

</div>


<jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>

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
            pageSize:  $("#rows").val(),            //一页记录数
            onPageChange: function (page) {
                document.title = page;
                $("#page").val(page-1);
                $('#communityForm').submit();

            }
        });
        $(".more_categories").click(function(){
            if($(this).next().css("display")=='none'){
                $(".more_categories_list").slideUp(1200);
                $(this).next().slideDown(1200);
                $(".more_categories").find("a").find("span").removeClass("glyphicon-chevron-down").addClass("glyphicon-chevron-right");
                $(this).find("a").find("span").removeClass("glyphicon-chevron-right").addClass("glyphicon-chevron-down");
            }else{
                $(".more_categories_list").slideUp(1200);
                $(".more_categories").find("a").find("span").removeClass("glyphicon-chevron-down").addClass("glyphicon-chevron-right");
            }

        });
       

    });
    //加入社区
    function doJoin(){
        window.location.href="${pageContext.request.contextPath}/student_relation/join_student.action?source_type=0&stamp=${communityCenterView.stamp}&source_id=${communityCenterView.id}";
    }
    <%--//退出社区--%>
    <%--function doQuit(){--%>
    <%--window.location.href="${pageContext.request.contextPath}/student_relation/quit_student.action?source_type=0&stamp=${communityCenterView.stamp}&source_id=${communityCenterView.id}";--%>
    <%--}--%>
    //一级分类搜索
    function doClassify(id,name){
        $("#page").val(0);
        $("#classifyId").val(id);
        $("#classifyName").val(name);
        $("#sonClassifyId").val(-1);
        $("#communityForm").submit();
    }
    //二级分类搜索
    function doSonClassify(id,name){
        $("#page").val(0);
        $("#sonClassifyId").val(id);
        $("#sonClassifyName").val(name);
        $("#communityForm").submit();
    }
    //排序过滤
    function searchSortType(value){
        $("#page").val(0);
        $("#sortType").val(value);
        $('#communityForm').submit();
    }
    function searchStatus(value) {
        $("#page").val(0);
        $("#status").val(value);
        $('#communityForm').submit();
    }
    function doSearchIndex(type){
        window.location.href="${pageContext.request.contextPath}/community/to_community_index.action?classifyId=-1&sourceType=0&stamp="+type+"&id=${communityCenterView.id}";
    }

    function toDetail(value,type){
        if(type==1){//课程
            window.open("${pageContext.request.contextPath}/user_study/to_course_study.action?page=1&learnId="+value+"&sourceType=0&tab=1&is_direct=0&jumpId=${communityCenterView.id}&jumpType=1",'_blank');
        }else{//培训
            window.open("${pageContext.request.contextPath}/train/to_train_detail.action?id="+value+"&sign=0&jumpId=${communityCenterView.id}&jumpType=1",'_blank');
        }
    }
    $(".attent").mouseover(function(){

        var id=$(this).data("user");
        var _this=$(this);

        $.ajax({
            url : '${pageContext.request.contextPath}/teacher_center/attent.action',
            data : {
                id : id,
            },
            dataType : 'json',
            success : function(response) {

                if (response.userAttent == 0) {
                    $(".follow-btn").show();
                    $(".unfollow-btn").hide();
                }
                if (response.userAttent == 1) {
                    _this.find(".unfollow-btn").show();
                    _this.find(".follow-btn").hide();
                }
            }
        });
    });
    $(".follow-btn").click(function () {
        var id=$(this).data("user");
        send_attent(id);
    });
    $(".items").click(function () {
			var flag=false;
			var press=$(this).data("press");
			var subject=$(this).data("subject");
			var grade=$(this).data("grade");
			var stage=$(this).data("stage");
			var list=$(this).data("list");
			var sort=$(this).data("sort");
			if(press!=null){
				flag=true;
				$("#press_id").val(press);
			}
			if(subject!=null){
				$("#subject_id").val(subject);
				flag=true;
			}
			if(grade!=null){
				$("#grade_id").val(grade);
				flag=true;
			}
			if(stage!=null){
				$("#stage_id").val(stage);
				flag=true;
			}
			if(list!=null){
				$("#list").val(list);
				flag=true;
			}
			if(sort!=null){
				$("#sort").val(sort);
				flag=true;
			}
			if(flag){
				$('#communityForm').submit();
			}else{
				return flag;

			}

		});
</script>
