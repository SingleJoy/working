<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/jquery-1.11.0.min.js"></script>  --%>
<link href="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.js"></script>
<script>
var uploader = WebUploader.create({
    auto: true,
    // swf文件路径
    swf: '${pageContext.request.contextPath}/frontstage/js/webuploader/Uploader.swf',
    // 文件接收服务端。
    server: '${pageContext.request.contextPath}/back_workshop/upload_img.action',

    // 选择文件的按钮。可选。
    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
    pick: '#file',

    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
    resize: false,
    accept: {
        title: 'Images',
        extensions: 'gif,jpg,jpeg,bmp,png',
        mimeTypes: 'image/*'
    }
});
/**
 *上传成功后
 *file:文件
 *response:服务器返回
 */
uploader.on( 'uploadSuccess', function( file,response  ) {
	var hidden=$('<input type="hidden" value="1" name="is_default_img" class="hidden">' );
	var $form=$("#workshopForm");
	$form.append(hidden);
    $("#img").val(response.fileName);
    $("#img_name").val(response.oname);
});

// 当有文件添加进来的时候
uploader.on( 'fileQueued', function( file ) {

    // <input type="hidden">
    /* var $img; */
    var $li = $(
            '<div id="' + file.id + '" class="file-item thumbnail">' +
            '<img style="">' +
              '<div class="info">' + file.name + '</div>' + 
            '</div>'
        );
        /* $img = $li.find('img'); */
    var   $list=$("#fileList");
    $list.html("");
    // $list为容器jQuery实例
    $list.append( $li );
    $("#file").hide();




    // 创建缩略图
    // 如果为非图片文件，可以不用调用此方法。
    // thumbnailWidth x thumbnailHeight 为 100 x 100
    /* uploader.makeThumb( file, function( error, src ) {
        if ( error ) {
            $img.replaceWith('<span>不能预览</span>');
            return;
        }

        $img.attr( 'src', src );

    },100,90 ); */
});

function _stage(value){
    //       alert(value);
    $("#subject").find("option").remove();

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
                $("#subject").append('<option   value='+sub[i].id+' >'+sub[i].subjectName+'</option>');
            }

        }
    });

}
function getCid(obj){
	var v = $('#community_id').combogrid('getValue');
	alert(v)
	obj.value= v;
}
function selectC(){
	var p = parent.sy.dialog({
		title : '选择社区',
		href : '${pageContext.request.contextPath}/back_workshop/to_select_community.action',
		width : 700,
		height : 500, 
		resizable : true, 
		buttons : [ {
			text : '添加',
			handler : function() {
				var cc = $("#community_id").val();
			    if(cc!="${workshopView.community_id}"){
			    	$("#workshop_user_id").val("");
					$("#workshop_user_name").val("");
			    }
				p.dialog('close');
			}
		} ]
	});
}
function selectM(){
	var community_id = $("#community_id").val();
	var community_name = $("#community_name").val();
	if(community_id!=""&&community_name!=""){
		var p = parent.sy.dialog({
			title : '选择坊主',
			href : '${pageContext.request.contextPath}/back_workshop/to_select_master.action?source_id='+community_id,
			width : 500,
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
					$("#workshop_user_id").val(user_ids.join(','));
					$("#workshop_user_name").val(username.join(','));
					p.dialog('close');
				}
			} ]
		});
	}else{
		parent.sy.messagerShow({
			msg : "请选择社区！！",
			title : '提示'
		});
	}
}
</script>
<div style="padding: 5px; overflow: hidden;">
	<form id="workshopForm" method="post">
	    <input name="id" value="${workshopView.id}" type="hidden">
		<table class="tableForm">
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th>&nbsp;坊名称：</th>
				<td><input name="name" id="name" onblur="checkName();" value="${workshopView.name }" style="width: 180px;"  placeholder="请输入社区名称"  class="easyui-validatebox"
					data-options="required:'true',missingMessage:'请填写社区名称'" /></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th>&nbsp;坊头像：</th>
				<td >
			    <input type="hidden" id="img" name="img" value="${workshopView.img}">
			    <input type="hidden" id="img_name" name="img_name" value="${workshopView.img_name}">
				<div id="fileList"></div>
				<div id="file">
			       ${workshopView.img_name}
			       <input type="button" value="+坊头像">
			    </div>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			
			<tr>
				<th>&nbsp;学段学段：</th>
				<td >
				<select id="stage" class="form-control" name="period"  onchange="_stage(this.value);">
                     <option id="nullStage" value="">--请选择学段--</option>
                     <option value="XX" <c:if test="${workshopView.period =='XX'}">selected="selected"</c:if> >小学</option>
                     <option value="CZ" <c:if test="${workshopView.period =='CZ'}">selected="selected"</c:if> >初中</option>
                     <option value="GZ" <c:if test="${workshopView.period =='GZ'}">selected="selected"</c:if> >高中</option>
                 </select>
                 <select id="subject"  class="form-control" name="subject">
                    <c:if test="${empty subjectList}">
                        <option  value="">--请选择学科--</option>
                    </c:if>
                    <c:forEach items="${subjectList}" var="sub">
                        <c:if test="${workshopView.subject == sub.id}">
                            <option selected="selected" value="${sub.id}">${sub.subjectName}</option>
                        </c:if>
                        <c:if test="${workshopView.subject!= sub.id}">
                            <option value="${sub.id}">${sub.subjectName}</option>
                        </c:if>
                    </c:forEach>
                </select>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th>&nbsp;社区：</th>
				<td>
                    <%-- <select id="community_id" class="easyui-combogrid" name="community_id" style="width:250px;"   
				        data-options="    
				            panelWidth:350,    
				            idField:'id',    
				            textField:'name', 
				            pagination : true,
							pageSize : 10,
							pageList : [ 10, 20, 30, 40 ], 
							sortName : 'id',
			                sortOrder : 'desc',  
			                fit : true,
							fitColumns : true,
							nowrap : false,
							border : false,
							mode: 'remote', 
				            url:'${pageContext.request.contextPath}/back_community/datagrid.action',    
				            columns:[[    
				                {field:'id',title:'id',hidden:true},    
				                {field:'name',title:'社区',width:100},    
				                {field:'community_user',title:'创建者',width:50},    
				                {field:'type',title:'类型',width:30,formatter:function(value){if(value==0){return '普通';}else if(value==1){return '教师培训';}else{return '';}}},
				                {field:'grade',title:'等级',width:30,formatter:function(value){if(value==0){return '省级';}else if(value==1){return '市级';}else if(value==2){return '县级';}}}        
				            ]],
				            onChange : function(newValue, oldValue){if(newValue!=''){$('#workshop_user_id').combogrid('clear');}},
				            onSelect : function(rowIndex,rowData){if(rowData!=''){$('#workshop_user_id').combogrid('grid').datagrid('options').queryParams.source_id = rowData.id;$('#workshop_user_id').combogrid('grid').datagrid('reload');}}
				        "></select> --%>
				         <!-- 最后的语句是防止选择了坊主，又改变了社区，却不在修改坊主的情况 --><!-- $('#workshop_user_id').combogrid('clear'); -->
				        <input id="community_id" name="community_id" type="hidden" value="${workshopView.community_id}">
				        <input id="community_name" style="width:175px" value="${workshopView.community_name}" name="community_name" onclick="selectC();">
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th>&nbsp;坊主：</th>
				<td>
                    <%-- <select id="workshop_user_id" class="easyui-combogrid" name="workshop_user_id" style="width:250px;"   
				        data-options="    
				            panelWidth:500,    
				            idField:'user_id',    
				            textField:'username', 
				            pagination : true,
							pageSize : 10,
							pageList : [ 10, 20, 30, 40 ], 
							sortName : 'id',
			                sortOrder : 'desc',  
			                fit : true,
							fitColumns : true,
							nowrap : false,
							border : false,
							queryParams : {  
	                            source_id : $('#community_id').combogrid('getValue')  
	                        },
				            url:'${pageContext.request.contextPath}/back_workshop/master_datagrid.action',    
				            columns:[[    
				                {field:'user_id',title:'user_id',hidden:true},    
				                {field:'username',title:'用户名',width:50},    
				                {field:'true_name',title:'真实姓名',width:50},    
				                {field:'sex',title:'性别',width:35,formatter:function(value){if(value==0){return '女';}else if(value==1){return '男';}else{return '';}}},
				                {field:'school',title:'工作单位',width:120},
				                {field:'course',title:'学段学科',width:60},
				                {field:'phone',title:'手机号',width:70},        
				            ]]    
				        "></select> --%>
				        <input id="workshop_user_id" name="workshop_user_id" value="${workshopView.ids}" type="hidden">
				        <input id="workshop_user_name" value="${workshopView.workshop_user}" style="width:175px" name="workshop_user_name" onclick="selectM();">
				</td>
			</tr>
			
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th>&nbsp;坊简介：</th>
				<td colspan="5"><textarea name="profile" style="height: 200px;width: 200%;">${workshopView.profile}</textarea></td>
			</tr>
			
			<tr>
				<td>&nbsp;</td>
			</tr>
		</table>
	</form>
</div>
