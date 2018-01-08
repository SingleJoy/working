<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>

<link href="${pageContext.request.contextPath}/frontstage/css/resource-list.css" rel="stylesheet" type="text/css">

<div class="cn-wrap">

	<div id="content-container" class="container">

		<form  id="searchbox" action="${pageContext.request.contextPath}/search/search.action" class="search_form" method="get"  target="_blank">
			<input type="hidden" name="pageSize" value="5" >
			<input type="hidden" name="pageNo" value="0" >
			<input type="hidden" name="type" value="zh" >
			<input type="hidden" name="file_attr" checked="checked" value="">

		</form>
		<div class="row">

			<ol class="breadcrumb breadcrumb-o">
				<li><a href="javascript:void(0);" >&nbsp;&nbsp;&nbsp;首页</a></li>
				<li><a href="javascript:void(0);">资源</a></li>
				<li><a href="javascript:void(0);" id="subject0">小学语文</a></li>
				<li><a href="javascript:void(0);" id="edition0">人教2011课标板</a></li>
			</ol>

			<div class="col-md-3" style="padding-left: 0;">

				<div class="content_page">
					<a href="javascript:void(0);" style="padding-left: 10px;">${resourceView.stage}${resourceView.subject}</a>
					<span class="">●</span>
					<a href="javascript:void(0);" title="${resourceView.subject}">${fn:substring(resourceView.edition,0,8)}</a>
					<a id="nav_content_img" href="javascript:void(0);" >
						<i class="es-icon es-icon-mail"></i>
					</a>
				</div>

				<div class="panel-body"  id="content_sel" style="width: 290px;">

					<form class="form-horizontal" >

						<div class="" id="nav_content_classify" style="display: none;">

							<h3 class="pull-left" style="margin:15px 5px;">教材选择</h3>

							<div class="form-group" style="clear: both;margin-top: 20px;">
								<div class="col-md-4 controls">&nbsp;&nbsp;学段</div>
								<div class="col-md-8 controls">

									<select id="stage" onchange="_stage(this.value);" class="form-control" style="min-width: 140px;">
										<c:forEach items="${stageList}" var="sub">
											<c:if test="${resourceView.stageId == sub.id}">
												<option selected="selected" value="${sub.id}">${sub.subjectName}</option>
											</c:if>
											<c:if test="${resourceView.stageId != sub.id}">
												<option value="${sub.id}">${sub.subjectName}</option>
											</c:if>
										</c:forEach>
									</select>
								</div>

							</div>

							<div class="form-group" style="margin-top: -15px;">
								<div class="col-md-4 controls">&nbsp;&nbsp;科目</div>
								<div class="col-md-8 controls">
									<select id="subject" onchange="_subject(this.options[this.options.selectedIndex].text);" class="form-control">
										<c:forEach items="${resourceView.subjectList}" var="sub">
											<c:if test="${resourceView.subjectId == sub.id}">
												<option selected="selected" value="${sub.id}">${sub.subjectName}</option>
											</c:if>
											<c:if test="${resourceView.subjectId != sub.id}">
												<option value="${sub.id}">${sub.subjectName}</option>
											</c:if>
										</c:forEach>
									</select>
								</div>
							</div>

							<div class="form-group" style="margin-top: -15px;">
								<div class="col-md-4 controls">教材版本</div>
								<div class="col-md-8 controls">
									<select id="edition" onchange="_edition(this.options[this.options.selectedIndex].text);" class="form-control">
										<c:forEach items="${resourceView.editionList}" var="edi">
											<c:if test="${resourceView.editionId == edi.id}">
												<option selected="selected"  value="${edi.id}">${edi.versionName}</option>
											</c:if>
											<c:if test="${resourceView.editionId != edi.id}">
												<option  value="${edi.id}">${edi.versionName}</option>
											</c:if>
										</c:forEach>
									</select>
								</div>
							</div>

							<div class="form-group" style="margin-top: -15px;">
								<div class="col-md-4 controls">&nbsp;&nbsp;年级</div>
								<div class="col-md-8 controls">
									<select id="grade" onchange="_grade();" class="form-control">
										<c:forEach items="${resourceView.gradeList}" var="gra">
											<c:if test="${resourceView.gradeId == gra.id}">
												<option  selected="selected" value="${gra.id}">${gra.bookCatelogName}</option>
											</c:if>
											<c:if test="${resourceView.gradeId != gra.id}">
												<option  value="${gra.id}">${gra.bookCatelogName}</option>
											</c:if>
										</c:forEach>
									</select>
								</div>
							</div>

							<div class="text-center">
								<button type="button" onclick="_confirm();" class="btn btn-info btn-sm">确定</button>
							</div>

						</div>

					</form>
				</div>

			</div>
		</div>

		<div class="row" style="clear: both;">

			<div class="col-md-3" style="min-height: 550px;">

				<div class="sidenav locked">

					<input type="hidden" value="${resourceView.chapterList.size()}" id="chaCount">

					<c:forEach items="${resourceView.chapterList}" var="cha" varStatus="status">

						<div class="list-group-item " id="all_pinyin${status.index}" style="border: none;">
							<a href="javascript:void(0);"  class="link-dark" <c:if test="${cha.id!=resourceView.chapterId}"> onclick="_section('${cha.id}',1);"</c:if><c:if test="${cha.id==resourceView.chapterId}"> onclick="_ulShow();" </c:if> >
								<span ></span>${fn:substring(cha.bookCatelogName,0,12)}
								<i class="glyphicon glyphicon-chevron-down text-muted pull-right"></i>
							</a>
						</div>
						<c:if test="${cha.id==resourceView.chapterId}">
							<ul class="list-group all_pinyin_content" style="margin-bottom: 0;"
								id="all_pinyin_content${status.index}">
								<c:forEach items="${resourceView.sectionList}" var="sec">
									<li class="list-group-item <c:if test="${sec.id==resourceView.sectionId}">active </c:if>" >
										<a class="second-title" title="${sec.bookCatelogName}" onclick="_section('${sec.id}');" href="javascript:void(0);">${fn:substring(sec.bookCatelogName,0,12)}</a>
									</li>
								</c:forEach>
							</ul>
						</c:if>
					</c:forEach>

				</div>

			</div>

			<div class="col-md-9" style="margin-top: -40px;">

				<div class="panel" >
					<div class="panel-body">

						<form id="resourceForm" action="${pageContext.request.contextPath}/resource_list/to_resource_list.action" method="post">

							<input type="hidden" name="type" id="type"  value="${resourceView.type}"/>
							<input type="hidden" name="page" id="page" value="${resourceView.page}"/>
							<input type="hidden" name="rows" id="rows" value="${resourceView.rows}"/>
							<input type="hidden" name="total" id="total" value="${resourceView.total}"/>
							<input type="hidden" name="totalPage" id="totalPage" value="${resourceView.totalPage}"/>
							<input type="hidden" name="sort" id="sort" value="${resourceView.sort}"/>
							<input type="hidden" name="stageId" id="stageId" value="${resourceView.stageId}"/>
							<input type="hidden" name="subjectId" id="subjectId" value="${resourceView.subjectId}"/>
							<input type="hidden" name="subject" id="subjectName" value="${resourceView.subject}"/>
							<input type="hidden" name="edition" id="editionName" value="${resourceView.edition}"/>
							<input type="hidden" name="editionId" id="editionId" value="${resourceView.editionId}"/>
							<input type="hidden" name="gradeId" id="gradeId" value="${resourceView.gradeId}"/>
							<input type="hidden" name="chapterId" id="chapterId" value="${resourceView.chapterId}"/>
							<input type="hidden" name="sectionId" id="sectionId" value="${resourceView.sectionId}"/>
							<input type="hidden" name="file_type" id="file_type" value="${resourceView.file_type}"/>
						</form>

						<div class="cn-filter">

							<ul class="nav nav-sort clearfix">

								<li ><a<c:if test="${resourceView.sort==3}"> class="active"</c:if> onclick="_searchSort('3');" href="javascript:void(0);">最新发布</a></li>
								<li ><a<c:if test="${resourceView.sort==4}"> class="active"</c:if>  onclick="_searchSort('4');" href="javascript:void(0);">好评最多</a></li>
								<li ><a <c:if test="${resourceView.sort==2}"> class="active"</c:if> onclick="_searchSort('2');" href="javascript:void(0);">下载最多</a></li>
								<li ><a onclick="_searchSort('1');" href="javascript:void(0);" <c:if test="${resourceView.sort==1}"> class="active"</c:if>>收藏最多</a></li>

							</ul>
							<div class="filter hidden-xs pull-right" >
								<label class="checkbox-inline">
									<input type="checkbox" class="statusType"  name="resource" <c:if test="${resourceView.file_type==0}">checked="checked"</c:if>>
									文件
								</label>
								<label class="checkbox-inline">
									<input type="checkbox" class="statusType" name="resource" <c:if test="${resourceView.file_type==1}">checked="checked"</c:if>>
									教案
								</label>
							</div>

						</div>

					</div>
				</div>

				<div class="course-wide-list" style="clear: both;">
					<input type="hidden" value="${resourceList.size()}" id="num">

					<c:forEach items="${resourceList}" var="resource" varStatus="res">

						<div class="course-item clearfix panel" style="border: none;">
							<a class="course-picture-link pull-left" href="${pageContext.request.contextPath}/userFile/to_file.action?id=${resource.fileId}" target="_blank" title="${resource.uploadName}贡献">
								<img class="avatar-lg-md" src="${pageContext.request.contextPath}${resource.icon}" style="margin: 15px 0 0 15px;"><br>
								<span class="text-muted author_info" title="${resource.uploadName}贡献">${resource.uploadName}</span>
							</a>
							<div class="resource_info pull-left" >

								<h4 class="mbl" >

									<a href="${pageContext.request.contextPath}/userFile/to_file.action?id=${resource.fileId}" target="_blank" >${resource.fileName}</a>
									<c:if test="${resource.file_type==0}"><span class="lesson_plan">文档</span></c:if>
									<c:if test="${resource.file_type==1}"><span class="teaching_plan">教案</span></c:if>
								</h4>

								<div class="course-footer ">
									<span title="下载数量" class="text-muted"><i class="glyphicon glyphicon-download-alt"></i>&nbsp;${resource.downloadNum}次下载 </span>
									<span class="mlm mrm text-muted"></span>
									<span title="收藏" class="text-muted"><i class="es-icon es-icon-bookmarkoutline"></i>&nbsp;${resource.collectionNum}位收藏 </span>

									<span class="pull-right text-muted">&nbsp;${fn:substring(resource.uploadTime,0,10)}贡献</span>
								</div>

								<div class="course-footer" style="margin-top: 17px;">
									<span class="text-muted">格式&nbsp;:&nbsp;${resource.format}</span>
									<span class="mlm mrm text-muted"></span>
									<span class="text-muted">评分&nbsp;:&nbsp;${resource.score}</span>
									<span class="mlm mrm text-muted"></span>
										<%--<c:if test="${resource.value==0}"><span class="text-success">免费</span></c:if>--%>
										<%--<c:if test="${resource.value!=0}"><span class="price">${resource.value}</span>元</c:if>--%>
								</div>

							</div>

						</div>

					</c:forEach>

					<c:if test="${empty resourceList }">
						<div class="empty">暂无数据</div>
					</c:if>

					<c:if test="${!empty resourceList }">

						<div id="test" class="pager" style="margin:50px auto;"></div>

					</c:if>

				</div>

			</div>

		</div>

	</div>

	<jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>
</div>

<script type="text/javascript">

    $(function(){
        var num=$("#num").val();

        for(var i=0;i<num;i++){
            score = $("#score"+i).val();
            $("#starImg"+i).append('<div class="star1" ><div class="star2" style="width:'+score*20+'%"></div></div>');
        }
        var stage=('${resourceView.stage}');
        var subject=($("#subject").find("option:selected").text());
        var edition=($("#edition").find("option:selected").text());
        $("#subject0").html(stage+subject);
        $("#edition0").html(edition);
    })

    function _doOpenClose(index,value){
        var chaCount = $("#chaCount").val();
        var sectionId = $("#sectionId").val();
        $("#chapterId").val(value);
        if($("#all_pinyin_content"+index).css("display")=="none"){

            $("#all_pinyin_content"+index).hide();
            $("#all_pinyin_content"+index).show();
            $("#all_pinyin_content"+index).find("li").remove();
            $.ajax({
                url : "${pageContext.request.contextPath}/book_cat/query_book_cat.action?bookId="+value+"&parentId=1",
                dataType:'json',
                success : function(json){
                    var a = JSON.stringify(json);
                    var o = eval( "(" + a + ")" );
                    var sec = o[0].sectionList;
                    if(sec.length>0){
                        for(var i in sec){
                            $("#all_pinyin_content"+index).append('<li <c:if test="'+sectionId+'=='+sec[i].id+'}"> class="active"</c:if> ><a onclick="_section(\''+sec[i].id+'\');" href="javascript:void(0);">'+sec[i].bookCatelogName+'</a></li>');
                        }
                    }else{
                        $("#sectionId").val(value);

                        $("#resourceForm").submit();
                    }
                }
            });
            $("#all_pinyin_content"+index).css("border-bottom","1px solid #ddd");
            for(var i=0;i<chaCount;i++){
                if(i!=index){

                    $("#all_pinyin_content"+i).hide();

                }else{
                    $("#all_pinyin"+index).css("background-color","#e2e2e2")
                }
            }
        }else{

            $("#all_pinyin_content"+index).hide();

        }
    }
    function _section(value,index){
        $("#sectionId").val(value);
        if(index==1){
            $("#chapterId").val(value);
        }
        $("#resourceForm").submit();
    }

    function _stage(value){
        if(value=='XX'){

            $("#stage_GZ").removeClass("btn-info");
            $("#stage_CZ").removeClass("btn-info");
            $("#stage_XX").addClass("btn-info");
        }else if(value=='GZ'){


            $("#stage_XX").removeClass("btn-info");
            $("#stage_CZ").removeClass("btn-info");
            $("#stage_GZ").addClass("btn-info");
        }else{

            $("#stage_XX").removeClass("btn-info");
            $("#stage_GZ").removeClass("btn-info");
            $("#stage_CZ").addClass("btn-info");
        }
        $("#stageId").val(value);
        $("#subject").find("option").remove();
        $("#edition").find("option").remove();
        $("#grade").find("option").remove();

        $.ajax({
            url : "${pageContext.request.contextPath}/subject/query_subject.action?subId="+value,
            dataType:'json',
            success : function(json) {
                var a = JSON.stringify(json);
                var o = eval( "(" + a + ")" );
                var sub = o[0].subjectList;
                var edi = o[0].editionList;
                var gra = o[0].gradeList;
                for(var i in sub){
                    $("#subject").append('<option  value='+sub[i].id+' >'+sub[i].subjectName+'</option>');
                }
                $("#subject").val();
                for(var i in edi){
                    $("#edition").append('<option  value='+edi[i].id+' >'+edi[i].versionName+'</option>');
                }
               
                for(var i in gra){
                    $("#grade").append('<option value='+gra[i].id+' >'+gra[i].bookCatelogName+'</option>');
                }
               if(sub.length==0){
                $("#subjectId").val(null);
                $("#subjectName").val(null);
                }else{
                  $("#subjectId").val(sub[0].id);
                   $("#subjectName").val(sub[0].subjectName);
                }
                
                 if(edi.length==0){
                $("#editionId").val(null);
                $("#editionName").val(null);
                }else{
                  $("#editionId").val(edi[0].id);
                   $("#editionName").val(edi[0].versionName);
                }
                if(gra.length==0){
                $("#gradeId").val(null);
                }else{
                  $("#gradeId").val(gra[0].id);
                }

            }
        });
    }

    function _subject(text){
        $("#subjectName").val(text);
        var  value = $("#subject").val();
        $("#subjectId").val(value);
        $("#edition").find("option").remove();
        $("#grade").find("option").remove();

        $.ajax({
            url : "${pageContext.request.contextPath}/pubver/query_pubver.action?pubId="+value,
            dataType:'json',
            success : function(json){
                var a = JSON.stringify(json);
                var o = eval( "(" + a + ")" );
                var edi = o[0].editionList;
                var gra = o[0].gradeList;
                for(var i in edi){
                    $("#edition").append('<option value='+edi[i].id+' >'+edi[i].versionName+'</option>');
                }
               
                 if(edi.length==0){
                $("#editionId").val(null);
                $("#editionName").val(null);
                }else{
                  $("#editionId").val(edi[0].id);
                   $("#editionName").val(edi[0].versionName);
                }
                if(gra.length==0){
                $("#gradeId").val(null);
                }else{
                  $("#gradeId").val(gra[0].id);
                }
                for(var i in gra){
                    $("#grade").append('<option value='+gra[i].id+' >'+gra[i].bookCatelogName+'</option>');
                }
              
            }
        });

    }
    function _edition(text){
        $("#editionName").val(text);
        var  value = $("#edition").val();
        $.ajax({
            url : "${pageContext.request.contextPath}/book_cat/query_book_cat.action?bookId="+value+"&parentId=-1",
            dataType:'json',
            success : function(json){
                var a = JSON.stringify(json);
                var o = eval( "(" + a + ")" );
                var gra = o[0].gradeList;
                if(gra.length==0){
                    $("#gradeId").val(null);
                }
                for(var i in gra){
                    $("#grade").append('<option value='+gra[i].id+' >'+gra[i].bookCatelogName+'</option>');}
                $("#gradeId").val(gra[0].id);}
        });
        $("#editionId").val(value);
        $("#grade").find("option").remove();
    }
    function _grade(){
        $("#gradeId").val($("#grade").val());}
    function _confirm(){
        $("#sectionId").val(null);
        $("#chapterId").val(null);
        $("#resourceForm").submit();
    }
    function _searchType(value){
        $("#type").val(value);
        $("#page").val("0");
        $("#resourceForm").submit();
    }
    function _searchSort(value){
        $("#sort").val(value);
        $("#page").val("0");
        $("#resourceForm").submit();
    }
    function _searchFile(value){
        $("#type").val(value);
        $("#resourceForm").submit();
    }
    function _searchLeft(){
        var page = $("#page").val();
        if(page!=0){
            $("#page").val(page-1);
            $('#resourceForm').submit();
        }
    }

    function _searchRight(){
        var page =  parseInt($("#page").val())+1;
        var total = $("#total").val();
        if(page<total){
            $("#page").val(page);
            $('#resourceForm').submit();
        }
    }

    $(document).ready(function(){
        //翻页
        var total = $("#total").val();
        var page =  parseInt($("#page").val())+1;

        $("#btn5").on('click', function () {
            $("#div1").PageChanged(5);
        });

        $(".pager").pagination({
            thisPageIndex:page,
            recordCount: total,       //总记录数
            pageSize: $("#rows").val(),           //一页记录数
            onPageChange: function (page) {
                document.title = page;
                $("#page").val(page-1);
                $('#resourceForm').submit();

            }
        });
    });


    //二级导航栏点击下拉显示
    $(function(){
        $("#nav_content_img").click(function(){
            if($("#nav_content_classify").css("display")=="none"){

                $("#nav_content_classify").show();
                $("#content_sel").css("border","1px solid #ddd");
                $("#content_sel").css("padding","15px");

            }else{
                $("#nav_content_classify").hide();
                $("#content_sel").css("border","none");
                $("#content_sel").css("padding","0");

            }
        })
    });
    function _ulShow() {
        $(".all_pinyin_content").slideToggle();
    }

    $(".statusType").click(function() {
        var isChecked = $(this).prop("checked");
        var status="";
        if(isChecked){
            $(".statusType").prop("checked", !isChecked);
            status=$('.statusType').index(this);
        }
        $(this).prop("checked", isChecked);
        $("#page").val(0);
        $("#file_type").val(status);
        $('#resourceForm').submit();
    });

</script>



