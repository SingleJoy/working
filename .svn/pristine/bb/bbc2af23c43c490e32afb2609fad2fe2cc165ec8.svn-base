<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%		String user_type = request.getParameter("user_type");
 %>
<jsp:include page="/backstage/base/inc.jsp"></jsp:include>
<link href="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.js"></script>
<script type="text/javascript" charset="utf-8">
	var datagrid;
	$(function(){
		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/back_app/datagrid.action',
			title : '用户列表',
			iconCls : 'icon-save',
			pagination : true,
			pagePosition : 'bottom',
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			fitColumns : false,
			nowrap : false,
			border : false,
			idField : 'id',
			sortName : 'create_time',
			sortOrder : 'asc',
			checkOnSelect : true,
			selectOnCheck : true,
			frozenColumns : [ [  {
				title : '编号',
				field : 'id',
				width : 150,
				sortable : true,
				checkbox : true
			}, {
				title : '版本名', 
				field : 'version_name',
				width : 230,
				sortable : true
			} ] ],
			columns : [ [ {
				title : '主版本号',
				field : 'major',
				width : 100,
			}, {
				title : '次版本号',
				field : 'minor',
				width : 100,
			},{
				title : '维护版本号',
				field : 'maintenance',
				width : 100,
				
			}, {
				title : '描述',
				field : 'describe',
				
				width : 330,
				
			}, {
				title : '上传时间',
				field : 'version_time',
				width : 150,
			
			}, ] ],
		
		
		});
		

	});
	
	
</script>

<body class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north',border:false,title:'app上传'" style="height: 130px;overflow: hidden;" align="left">
		<form id="searchForm" style="width: 100%;height: 100%;">
			<div style="height:100%;background-color: #efefef;padding-top: 20px;padding-left: 20px;">
				
					<div>
						<span>版本号类型：</span>
						<select id="type"   style="width:90px;margin-left: 20px;" name="type">
							<option value="1">主版本号</option>
							<option value="2">次版本号</option>
							<option value="3" selected="selected">维护版本号</option>
						</select>
						<span>描述：</span>
                    <input name="describe" id="describe">
                    <span id="app_btn" >
                    <a class="btn btn-primary " href="javascript:void (0);"   style="margin-left: 20px;">上传</a>
					</span>
					</div>
 <div id="uploadFile" class="text-center">
</div>


				
			</div>
		</form>
	</div>
	<div data-options="region:'center',border:false" style="overflow: hidden;">
		<table id="datagrid"></table>
	</div>

</body>

<script>
 $(function(){
   	var uploader = WebUploader.create({
formData: {  
        describe: ""  
    }  ,
			auto: true,
			// swf文件路径
			swf: '${pageContext.request.contextPath}/frontstage/js/webuploader/Uploader.swf',
			// 文件接收服务端。
			server: '${pageContext.request.contextPath}/back_app/upload_app.action',

			// 选择文件的按钮。可选。
			// 内部根据当前运行是创建，可能是input元素，也可能是flash.
			pick: '#app_btn',

			// 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
			resize: false,
			accept: {
				title: 'apk',
				extensions: 'apk',
				mimeTypes: '.apk'   //修改这行
			}
		});
		/**
		 *上传成功后
		 *file:文件
		 *response:服务器返回
		 */
		uploader.on( 'uploadSuccess', function( file,response  ) {
			datagrid.datagrid('reload');
			
		});
		// 当有文件添加进来的时候
	 uploader.on( 'fileQueued', function( file ) {
           
            $("#uploadFile").append( '<div id="' + file.id + '" class="item">' +
            '<br>'  +
            '</div>' );
        });
   // 文件上传过程中创建进度条实时显示。
        uploader.on( 'uploadProgress', function( file, percentage ) {
            var $li = $( '#'+file.id ),
                    $percent = $li.find('.progress .blue');
            // 避免重复创建
            if ( !$percent.length ) {
                $percent = $('<div class="progress progress-striped active">' +
                '<div class="graph"><span class="blue" style="width:0%;">0%</span></div>' +
                '</div>').appendTo( $li ).find('.blue');
            }

            $percent.css( 'width', percentage * 100 + '%' );
            $percent.empty().append((percentage * 100).toFixed(2) + '%' );

        });
         uploader.on('uploadBeforeSend',function (object ,data ,headers){
       
       
       data.describe = $("#describe").val();  
       data.type=$("#type").val();
     
    });
   });
</script>


