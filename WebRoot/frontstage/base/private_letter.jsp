<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<jsp:include page="./layout/header.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/frontstage/css/private-letter.css">
<%--<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/my-space.js"></script>--%>

<script type="text/javascript">
	$(function(){
		$("#write-letter").click(function(){
			$("#private_letter_main").hide();
			$("#see_private_letter_list").hide();
			$("#private_letter_write_main").show();
			$("#private_message_user1_alert").html("");
			$("#private_message_content1_alert").html("");
			$("#private_message_user1").val("");
			$("#private_message_content1").val("");
//			$("#private_message_user1").css("border-color","#ddd");
//			$("#private_message_content1").css("border-color","#ddd");
		});

		$("#back_myletter").click(function(){
			$("#private_letter_main").show();
			$("#see_private_letter_list").hide();
			$("#private_letter_write_main").hide();
		});


		$(".private_letter_look").click(function(){
			var to_user_id=$(this).attr("id");
			location.replace("${pageContext.request.contextPath}/private_letter/to_letter_detail.action?to_user_id="+to_user_id);
		})

	});
	$(function(){
		$(".private_letter_main_content>ul>li").mouseover(function(){
			$(this).find("label").find("a").show();
		}).mouseout(function(){
			$(this).find("label").find("a").hide();

		})
	});

</script>
<style>
	label{font-weight: normal;}
</style>

<div id="content-container" class="container" style="margin-top: 20px;margin-bottom: 100px;">

	<div class="row row-8" >
		<div class="col-md-8 col-md-offset-2">
			<!--私信-->
			<div class="panel panel-default panel-page"  id="private_letter_main" >
				<div class="panel-heading">
					<a class="btn btn-primary pull-right" href="javascript:void(0);" id="write-letter">写私信</a>
					<h2>私信</h2>
				</div>
				<div class="private_letter_main_content">
					<ul >
						<c:forEach items="${privateLetterViews }" var="letter">
							<li>
								<label><a href="${pageContext.request.contextPath}/private_letter/delete_all.action?to_user_id=${letter.to_user_id }" class="delete text-muted" onclick="return false">删除<span>|</span></a>共${letter.num }条</label>
								<a href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id=${letter.to_user_id }" target="_blank" ><img src="${pageContext.request.contextPath}${letter.to_user_icon }"></a>
								<p>
									<a href="${pageContext.request.contextPath}/teacher_center/to_teacher_center.action?user_id=${letter.to_user_id }"  target="_blank"><c:if test="${letter.type==1 }">发给&nbsp;</c:if>${letter.to_user_name }</a><label class="private_letter_look" id="${letter.to_user_id }">&nbsp;:&nbsp;${letter.content }</label>
									<c:if test="${letter.no_read!=0 }">
										<span>(${letter.no_read }条未读)</span>
									</c:if>
								</p>
								<span><fmt:formatDate value="${letter.send_time}" type="both" /></span>
							</li>
						</c:forEach>
					</ul>
					<form id="studyCenterForm" action="${pageContext.request.contextPath}/private_letter/to_letter.action" method="post">
						<input type="hidden" name="page" id="page" value="${privateLetterView.page}"/>
						<input type="hidden" name="rows" id="rows" value="${privateLetterView.rows}"/>
						<input type="hidden" name="total" id="total" value="${privateLetterView.total}"/>
						<input type="hidden" name="totalPage" id="totalPage" value="${privateLetterView.totalPage}"/>
					</form>
					<div id="test" class="pager" style="padding-top: 0;margin-bottom: 20px;"></div>
				</div>
			</div>


			<!--写私信-->
			<div class="panel panel-default panel-page" id="private_letter_write_main" style="display: none;">

				<div class="panel-heading">
					<a href="javascript:void (0);" class="btn btn-default pull-right" id="back_myletter">返回我的私信</a>
					<h2>写私信</h2>
				</div>


				<form id="message-create-form" class="form-horizontal" method="post">
					<div class="form-group">
						<div class="col-md-12 controls">
							<input type="text" id="private_message_user1" value=""  class="form-control" placeholder="收信人用户名"  />
						</div>
						<div class="text-warning"  id="private_message_user1_alert"></div>
					</div>


					<input type="hidden" id="private_message_id">


					<div class="form-group">
						<div class="col-md-12 controls">
							<textarea id="private_message_content1"  class="form-control" rows="5" placeholder="想要说的话" ></textarea>
						</div>
						<div class="text-warning"  id="private_message_content1_alert"></div>
					</div>


					<div class="form-group">
						<div class="col-md-12 controls">
							<button  class="btn btn-primary pull-right" type="button"  id="send_private_message1">发送</button>
						</div>
					</div>
				</form>
			</div>

		</div>
	</div>
</div>




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
			pageSize: $("#rows").val(),           //一页记录数
			onPageChange: function (page) {
				document.title = page;
				$("#page").val(page-1);
				$('#studyCenterForm').submit();

			}
		});
		$(".delete").click(function(){
			var msg=confirm("是否删除");
			if(msg){
				var url=$(this).attr("href");
				$.ajax({
					type:'post',
					url:url,
					dataType:'json',
					success:function(response){
						location.replace(location.href);
					}
				});
			}
		});

		$("#private_message_user1").blur(function(){

			private_message_user1_blur(1);
		});

		$("#private_message_content1").blur(function(){
			var _this=$(this);
			if(_this.val()==""){
				$("#private_message_content1_alert").html("请输入内容");

				return false;
			}else{
				$("#private_message_content1_alert").html("");
			}

		});

		$("#send_private_message1").click(function(){
			private_message_user1_blur(2);

		});

	});
	function private_message_user1_blur(id){
		var _this=$("#private_message_user1");
		
		if(_this.val()==""){
		
			$("#private_message_user1_alert").html("请输入收件人");

			return false;
		}else if( _this.val()=="${currentUser.username}"){
			$("#private_message_user1_alert").html("收件人不能为自己");

			return false;
		}
		else{
			$("#private_message_user1_alert").html("");
		}
		$.ajax({
			type:'post',
			url:"${pageContext.request.contextPath}/user/checkRegister.action",
			data:{
				username:	_this.val()
			},
			dataType:'json',
			success:function(response){
				flag=response.flag;
				if(flag==1){
					$("#private_message_id").val(response.user.id);
					$("#private_message_user1_alert").html("");
					if(id==2){
						var _this1=$("#private_message_content1");

						if(_this1.val()==""){
							$("#private_message_content1_alert").html("请输入内容");

							return false;
						}else{
							$("#private_message_content1_alert").html("");
							var to_user_id=$("#private_message_id").val();

							$.ajax({
								type:'post',
								url:"${pageContext.request.contextPath}/private_letter/send.action",
								data:{
									letter_content:_this1.val(),
									to_user_id:to_user_id
								},
								dataType:'json',
								success:function(response){
									$("#private_message_user1_alert").html("");
									$("#private_message_content1_alert").html("");
									$("#private_message_user1").val("");
									$("#private_message_content1").val("");


									location.replace(location.href);

								},
								error:function(response){
									alert("发送失败");
								}
							});
						}
					}
					return true;
				}
				if(flag==2){
					$("#private_message_user1_alert").html("收件人不存在");

					return false;
				}
			}
		});
		return true;
	}

</script>


<jsp:include page="./layout/footer.jsp"></jsp:include>