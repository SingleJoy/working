<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/jquery-..0.min.js"></script> --%>
<link rel="stylesheet"  href="${pageContext.request.contextPath}/frontstage/css/bootstrap-select.min.css"  type="text/css"/>
<link href="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/bootstrap-select.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.js"></script>
<script>
var uploader = WebUploader.create({
	auto: true,
	// swf文件路径
	swf: '${pageContext.request.contextPath}/frontstage/js/webuploader/Uploader.swf',
	// 文件接收服务端。
	server: '${pageContext.request.contextPath}/back_community/upload_img.action',

	// 选择文件的按钮。可选。
	// 内部根据当前运行是创建，可能是input元素，也可能是flash.
	pick: "#headImg",

	// 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
	resize: false,
	accept: {
		title: 'Images',
		extensions: 'gif,jpg,jpeg,bmp,png',
		mimeTypes: 'image/jpg,image/jpeg,image/png'   //修改这行
	}
});

/**
 *上传成功后
 *file:文件
 *response:服务器返回
 */
uploader.on( 'uploadSuccess', function( file,response  ) {
	var hidden=$('<input type="text" value="'+response.fileName+'" name="head_img" class="hidden"><input type="text" value="'+response.oname+'" name="head_img_name" class="hidden">' );
	var $form=$("#communityForm");
	$form.append(hidden);
});

// 当有文件添加进来的时候
uploader.on( 'fileQueued', function( file ) {

	// <input type="hidden">
	/* var $img; */
	var $li = $(
				'<div id="' + file.id + '" class="file-item thumbnail">' +
				'<div style="margin:20 0 0 0">' +
					 '<div class="info">' + file.name + '</div>' + 
				'</div>'
		);
		/* $img = $li.find('img'); */
	var   $list=$("#headFile");

	// $list为容器jQuery实例
	$list.append( $li );
	$("#headImg").hide();
	/* $("#hedimg").hide(); */

	// 创建缩略图
	// 如果为非图片文件，可以不用调用此方法。
	// thumbnailWidth x thumbnailHeight 为 00 x 00
	/* uploader.makeThumb( file, function( error, src ) {
		if ( error ) {
			$img.replaceWith('<span>不能预览</span>');
			return;
		}

		$img.attr( 'src', src );
	}, 00, 90); */
});
function _province(value){
	$("#area_id").val(value);
	$("#city").find("option").remove();
	$("#county").find("option").remove();
	$("#city").append('<option value=- >全部</option>');
	$("#county").append('<option value=- >全部</option>');
	
	if(value==1){
	value=0;
	}
	$.ajax({
		url:"${pageContext.request.contextPath}/area/showArea.action?parentId="+value,
		dataType:'json',
		success:function(json){
			var a = JSON.stringify(json);
			var o = eval( "(" + a + ")" );
			var html = "";
			for(var j in o){
				html += '<option  value='+o[j].id+' >'+o[j].area_name+'</option>';
			}
			$("#city").append(html);
		}
	});
}

function _city(value){
	$("#area_id").val(value);
	$("#county").find("option").remove();
	$("#county").append('<option value=- >全部</option>');
	$.ajax({
		url:"${pageContext.request.contextPath}/area/showArea.action?parentId="+value,
		dataType:'json',
		success:function(json){
			var a = JSON.stringify(json);
			var o = eval( "(" + a + ")" );
			var html = "";
			for(var j in o){
				html += '<option  value='+o[j].id+' >'+o[j].area_name+'</option>';
			}
			$("#county").append(html);
		}

	});
}

function _county(value){
	$("#area_id").val(value);
}


//选择学段
function doPeriod(){
	var a = document.getElementsByName("period");
	var ids = "";
	for(var i = 0;i<a.length;i++){
		if(a[i].checked){
			ids += a[i].value + ",";
		}
	}
	if(ids != ""){
		$("#periods").val(ids);
		searchSubject(ids);
	}else{
		$("#subject").empty();
	}
}

function searchSubject(ids){
	$.ajax({
		url:"${pageContext.request.contextPath}/subject/search_subject.action",
		data:{
			ids : ids
		},
		dataType:'json',
		success:function(d){
			if(d==0){//没有数据

			}else{
				var html ="";
				for(var i=0;i<d.length;i++){
					html+='<option  value="'+d[i].id+'">'+d[i].subjectName+'</option>';
				}
				$("#subject").empty().append(html);
				setSubject();
			}
		}
	});
}
function setSubject(){
	if('${communityView.subjects}'!=''){
		var str='${communityView.subjects}';
		var arr=str.split(',');
		$('#subject').selectpicker('val',arr);
	}
	$('#subject').selectpicker('refresh');
}
//选择学科
function doSubject(){
	
	$("#subjects").val($("#subject").val());
}

</script>
<div id="st" style="padding: 5px; overflow: hidden;">
	<form id="communityForm" method="post">
	    <input name="id" id="id" type="hidden" value="${communityView.id}">
		<table class="tableForm">
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th>&nbsp;社区名称：</th>
				<td><input name="name" id="name" value="${communityView.name}" style="width: 180px;"  placeholder="请输入社区名称"  class="easyui-validatebox"
					data-options="required:'true',missingMessage:'请填写社区名称'" /></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th>&nbsp;社区头像：</th>
				<td>
				    <c:if test="${!empty communityView.id}">
						<input type="hidden" name="is_default_img" value="1"/>
					</c:if>
				    <div id="headFile" class="upload_course_picture" ></div>
				    <div id="headImg">
				       <c:if test="${!empty communityView.head_img_name}"></c:if>
				       ${communityView.head_img_name}
				       <input type="button" value="+社区头像">
				    </div>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th>&nbsp;是否需要审核：</th>
				<td><label><input type="radio" name="is_examine" value="1" <c:if test="${communityView.is_examine==1 }">checked</c:if> class="" checked> 否 </label>
				    <label><input type="radio" name="is_examine" value="0" <c:if test="${communityView.is_examine==0 }">checked</c:if> class="" > 是</label></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th>&nbsp;省：</th>
				<td >
				<input type="hidden" id="area_id" name="area_id" value="${communityView.area_id }">
				<select name="province" id="province"  style="width: 180px;" onchange='_province(this.value)' class="form-control" >
					<option  <c:if test="${'1'==communityView.province}"> selected="selected"</c:if> value="1">--全国--</option>
					<c:forEach items="${provinceList}" var="pro">
						<option <c:if test="${pro.id==communityView.province}"> selected="selected"</c:if> value="${pro.id}">${pro.area_name}</option>
					</c:forEach> 
				</select>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th>&nbsp;市：</th>
				<td >
				<select name="city" id="city" style="width: 180px;" onchange="_city(this.value)" class="form-control">
					<option  <c:if test="${'-1'==communityView.city}"> selected="selected"</c:if> value="-1">全部</option>
					<c:forEach items="${cityList}" var="pro">
						<option <c:if test="${pro.id==communityView.city}"> selected="selected"</c:if>  value="${pro.id}">${pro.area_name}</option>
					</c:forEach>
				</select>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th>&nbsp;县/区：</th>
				<td >
				<select  name="county" id="county" style="width: 180px;" onchange="_county(this.value)" class="form-control">
					<option   <c:if test="${'-1'==communityView.county}"> selected="selected"</c:if>  value="-1">全部</option>
					<c:forEach items="${countyList}" var="pro">
						<option <c:if test="${pro.id==communityView.county}"> selected="selected"</c:if>  value="${pro.id}">${pro.area_name}</option>
					</c:forEach>
				</select>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th>&nbsp;社区类型：</th>
				<td>
				    <label><input type="radio" onclick="resized(0);" name="type" <c:if test="${empty communityView.id||communityView.type==0 }">checked</c:if> value="0" class="ordinary_train_community"> 普通社区</label>
				    <label><input type="radio" onclick="resized(1);" <c:if test="${communityView.type==1}">checked</c:if> name="type" value="1" class="teacher_train_community"> 教师培训社区 </label>
				    
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th>&nbsp;管理员：</th>
				<td>
			        <input id="community_user_id" name="community_user_id" value="${communityView.ids}" type="hidden">
			        <input id="community_user_name" name="community_user_name" value="${communityView.admins}" style="width:175px"  onclick="selectM();">
				</td>
			</tr>
			<tr id="t" style="<c:if test="${empty communityView.id||communityView.type==0}">display:none;</c:if>">
				<td>&nbsp;</td>
			</tr>
			<tr id="td" style="<c:if test="${empty communityView.id||communityView.type==0}">display:none;</c:if>" >
				<th>&nbsp;起止时间：</th>
				<td>
				    <label><input id="start_time" style="width:155px;" value="${communityView.start_time}" class="easyui-datebox" data-options="onSelect:onSelect,editable:false"   name="start_time" ></label>至
				    <label><input id="end_time" style="width:155px;" value="${communityView.end_time}" class="easyui-datebox" data-options="onSelect:onSelect,editable:false"   name="end_time" ></label>
				</td>
			</tr>
			<tr id="t2" style="<c:if test="${empty communityView.id||communityView.type==0}">display:none;</c:if>" >
				<td>&nbsp;</td>
			</tr>
			<tr id="td2" style="<c:if test="${empty communityView.id||communityView.type==0}">display:none;</c:if>" >
				<th>&nbsp;所属类型：</th>
				<td>
				    <select id="the_type" style="width:155px;"  name="the_type" class="form-control">
						<option <c:if test="${communityView.the_type==0 }">selected</c:if> value="0">综合素质</option>
						<option <c:if test="${communityView.the_type==1 }">selected</c:if> value="1">其他</option>
					</select>
				</td>
			</tr>
			<tr id="t3" style="<c:if test="${empty communityView.id||communityView.type==0}">display:none;</c:if>" >
				<td>&nbsp;</td>
			</tr>
			<tr id="td3" style="<c:if test="${empty communityView.id||communityView.type==0}">display:none;</c:if>" >
				<th>&nbsp;等级：</th>
				<td>
				    <select id="grade" style="width:155px;"  name="grade" class="form-control">
						<option <c:if test="${communityView.grade==0 }">selected</c:if> value="0">省级</option>
						<option <c:if test="${communityView.grade==1 }">selected</c:if> value="1">市级</option>
						<option <c:if test="${communityView.grade==2 }">selected</c:if> value="2">县级</option>
					</select>
				</td>
			</tr>
			<tr id="t4" style="<c:if test="${empty communityView.id||communityView.type==0}">display:none;</c:if>" >
				<td>&nbsp;</td>
			</tr>
			<tr id="td4" style="<c:if test="${empty communityView.id||communityView.type==0}">display:none;</c:if>" >
				<th>&nbsp;计划人数：</th>
				<td>
				    <label><input id="plan_num" onblur="valNum(this);" value="${communityView.plan_num }"  type="text" name="plan_num"  placeholder="请输入人数"></label>
				</td>
			</tr>
			<tr id="t5" style="<c:if test="${empty communityView.id||communityView.type==0}">display:none;</c:if>" >
				<td>&nbsp;</td>
			</tr>
			<tr id="td5" style="<c:if test="${empty communityView.id||communityView.type==0}">display:none;</c:if>" >
				<th>&nbsp;学分：</th>
				<td>
				    <label><input id="credit" onblur="valNum(this);" value="${communityView.credit }" type="text" name="credit" placeholder="请输入学分"></label>
				</td>
			</tr>
			<tr id="t6" style="<c:if test="${empty communityView.id||communityView.type==0}">display:none;</c:if>" >
				<td>&nbsp;</td>
			</tr>
			<tr id="td6" style="<c:if test="${empty communityView.id||communityView.type==0}">display:none;</c:if>" >
				<th>&nbsp;学时：</th>
				<td>
				    <label><input id="hour" onblur="valNum(this);" value="${communityView.hour }"  type="text" name="hour"  placeholder="请输入学时"></label>
				</td>
			</tr>
			<tr id="t6" style="<c:if test="${empty communityView.id||communityView.type==0}">display:none;</c:if>" >
				<td>&nbsp;</td>
			</tr>
			<tr id="td6" style="<c:if test="${empty communityView.id||communityView.type==0}">display:none;</c:if>" >
				<th>&nbsp;学段：</th>
				<td>
				    <input type="hidden" id="periods" name="periods" value="${communityView.periods}"/>
				    <c:forEach items="${periodList}" var="per">
						<label class="checkbox">
							<input type="checkbox" <c:if test="${fn:contains(communityView.periods,per.id)}">checked</c:if> onclick="doPeriod();" name="period" value="${per.id}" />${per.subjectName}
						</label>
					</c:forEach> 
				</td>
			</tr>
			<tr id="t7" style="<c:if test="${empty communityView.id||communityView.type==0}">display:none;</c:if>" >
				<td>&nbsp;</td>
			</tr>
			<tr id="td7" style="<c:if test="${empty communityView.id||communityView.type==0}">display:none;</c:if>" >
				<th>&nbsp;学科：</th>
				<td>
				    <input name="subjects" id="subjects" type="hidden" value="${communityView.subjects}">
				    <select id="subject"  name="subject" onChange="doSubject();" class="selectpicker show-tick form-control" multiple data-live-search="true" data-live-search-placeholder="搜索" title="未选择">
						<c:forEach items="${periodSubjectList}" var="periodSubject">
							<option value="${periodSubject.id}">${periodSubject.subjectName}</option>
						</c:forEach> 
					</select>
				</td>
			</tr>
		</table>
	</form>
</div>
<script>
$(function(){
	setSubject();
})
  function resized(value){
	  if(value==0){//forbid
		  $("#periods").val("");
	      $("#subjects").val("");
		  $("input[name='period']:checked").removeAttr("checked");
		  
		  $('#subject').selectpicker('refresh');
		  $("table tr:gt(20)").hide();
		  $("#start_time,#end_time").datebox('setValue','');
		  $("#the_type option:first").prop("selected", 'selected'); 
		  $("#grade option:first").prop("selected", 'selected'); 
		  $("#plan_num,#credit,#hour,input[name='period'],#subject").val("");
	  }else{//start
		  $("table tr:gt(20)").show();
	  }
	    
  }
  function onSelect(date){
	  var startTime = $('input[name="start_time"]').val();
      var endTime = $('input[name="end_time"]').val();
      if(startTime!=""&&endTime!=""){
          if(startTime>=endTime){
        	  $('#start_time').datebox('setValue', '');	
        	  $('#end_time').datebox('setValue', '');	
        	  parent.sy.messagerShow({
                  msg : "开始时间必须小于结束时间！！",
                  title : '提示'
              });
          }
      }
  }
  function valNum(obj){
	  var num = obj.value;
	  if(!(/(^[0-9]\d*$)/.test(num))){
		  obj.value = "";
		  parent.sy.messagerShow({
              msg : "请输入自然数！",
              title : '提示'
          });
	  }
	  
  }
  function selectM(){
	  var p = parent.sy.dialog({
			title : '选择管理员',
			href : '${pageContext.request.contextPath}/back_community/to_select_master.action',
			width : 570,
			height : 350, 
			resizable : true, 
			buttons : [ {
				text : '添加',
				handler : function() {
					 var rows = $('#datagrid2').datagrid('getSelections');
					 var user_ids = [];
     				 var username = [];
     				 for(var i = 0; i < rows.length; i++) {
     					 user_ids.push(rows[i].user_id);
     					 username.push(rows[i].username);
     				 }
     				 $("#community_user_id").val(user_ids.join(','));
     				 $("#community_user_name").val(username.join(','));
					 p.dialog('close');
				}
			} ]
		});
	}

</script>