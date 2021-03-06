<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/backstage/base/inc.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var datagrid;
	$(function() {

		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/back_user_track/datagrid.action',
			title : '',
			iconCls : 'icon-save',
			pagination : true,
			pageSize : 10,
			pageList : [ 10, 20, 30, 40 ],
			fit : true,
			fitColumns : true,
			nowrap : false,
			border : false,
			idField : 'id',
			sortName : 'user_id',
			sortOrder : 'asc',
			checkOnSelect : true,
			selectOnCheck : true,
			frozenColumns : [ [ {
				title : 'ID ',
				field : 'user_id',
				width : 50,
				sortable : true,
				
			}
			 ] ],
			columns : [ [ 	  {
				title : '名称',
				field : 'username',
				width : 250,
				sortable : true,
			}, {
				title : '登录时间(分)',
				field : 'loginTime',
				width : 200,
				sortable : true,
					formatter:function(value, rowData, rowIndex){
					var rows = datagrid.datagrid('getRows');
					var row = rows[rowIndex];
					var val=value/1000/60;
					return '<a href="javascript:void(0);" onclick="see(\''+row.username+'\',\''+ row.user_id +'\',0);">'+val.toFixed(2)+'</a>';
			
					},
			},
			{
				title : '学习时间(分)',
				field : 'studyTime',
				width : 200,
				sortable : true,
				formatter:function(value, rowData, rowIndex){
					var rows = datagrid.datagrid('getRows');
					var row = rows[rowIndex];
					var val=value/1000/60;
					return '<a href="javascript:void(0);" onclick="see(\''+row.username+'\',\''+ row.user_id +'\',1);">'+val.toFixed(2)+'</a>';
			
					},
			} ,
			{
				title : '学习天数',
				field : 'studyDays',
				sortable : true,
				width : 150,
			formatter:function(value, rowData, rowIndex){
					var rows = datagrid.datagrid('getRows');
					var row = rows[rowIndex];
					return '<a href="javascript:void(0);" onclick="see(\''+row.username+'\',\''+ row.user_id +'\',1);">'+value+'</a>';
			
					},
			} ,
			{
				title : '连续学习天数',
				field : 'continuityDays',
				sortable : true,
				width : 150,
			formatter:function(value, rowData, rowIndex){
					var rows = datagrid.datagrid('getRows');
					var row = rows[rowIndex];
					return '<a href="javascript:void(0);" onclick="see(\''+row.username+'\',\''+ row.user_id +'\',1);">'+value+'</a>';
			
					},
			} ,
			{
				title : '学习课程',
				field : 'studyCourse',
				sortable : true,
				width : 150,
				formatter:function(value, rowData, rowIndex){
					var rows = datagrid.datagrid('getRows');
					var row = rows[rowIndex];
					return '<a href="javascript:void(0);" onclick="see(\''+row.username+'\',\''+ row.user_id +'\',2);">'+value+'</a>';
			
					},
			
			} ,
			{
				title : '学习培训',
				field : 'studyTrain',
				sortable : true,
				width : 150,
				formatter:function(value, rowData, rowIndex){
					var rows = datagrid.datagrid('getRows');
					var row = rows[rowIndex];
					return '<a href="javascript:void(0);" onclick="see(\''+row.username+'\',\''+ row.user_id +'\',3);">'+value+'</a>';
			
					},
			
			} ,
			{
				title : '下载次数',
				field : 'downloadCount',
				sortable : true,
				width : 150,
				formatter:function(value, rowData, rowIndex){
					var rows = datagrid.datagrid('getRows');
					var row = rows[rowIndex];
					return '<a href="javascript:void(0);" onclick="see(\''+row.username+'\',\''+ row.user_id +'\',4);">'+value+'</a>';
			
					},
			
			} ,
			{
				title : '上传次数',
				field : 'uploadCount',
				sortable : true,
				width : 150,
				formatter:function(value, rowData, rowIndex){
					var rows = datagrid.datagrid('getRows');
					var row = rows[rowIndex];
					return '<a href="javascript:void(0);" onclick="see(\''+row.username+'\',\''+ row.user_id +'\',5);">'+value+'</a>';
			
					},
			
			} ,
			{
				title : '评价次数',
				field : 'appraiseCount',
				sortable : true,
				width : 150,
				formatter:function(value, rowData, rowIndex){
					var rows = datagrid.datagrid('getRows');
					var row = rows[rowIndex];
					return '<a href="javascript:void(0);" onclick="see(\''+row.username+'\',\''+ row.user_id +'\',6);">'+value+'</a>';
			
					},
			
			} ,
			{
				title : '粉丝',
				field : 'fans',
				sortable : true,
				width : 150,
				formatter:function(value, rowData, rowIndex){
					var rows = datagrid.datagrid('getRows');
					var row = rows[rowIndex];
					return '<a href="javascript:void(0);" onclick="see(\''+row.username+'\',\''+ row.user_id +'\',7);">'+value+'</a>';
			
					},
			
			} ,
			{
				title : '关注',
				field : 'concern',
				sortable : true,
				width : 150,
				formatter:function(value, rowData, rowIndex){
					var rows = datagrid.datagrid('getRows');
					var row = rows[rowIndex];
					return '<a href="javascript:void(0);" onclick="see(\''+row.username+'\',\''+ row.user_id +'\',8);">'+value+'</a>';
			
					},
			
			} ,
			{
				title : '提问数',
				field : 'questionCount',
				sortable : true,
				width : 150,
				formatter:function(value, rowData, rowIndex){
					var rows = datagrid.datagrid('getRows');
					var row = rows[rowIndex];
					return '<a href="javascript:void(0);" onclick="see(\''+row.username+'\',\''+ row.user_id +'\',9);">'+value+'</a>';
			
					},
			
			} ,
			{
				title : '回答数',
				field : 'answerCount',
				sortable : true,
				width : 150,
				formatter:function(value, rowData, rowIndex){
					var rows = datagrid.datagrid('getRows');
					var row = rows[rowIndex];
					return '<a href="javascript:void(0);" onclick="see(\''+row.username+'\',\''+ row.user_id +'\',10);">'+value+'</a>';
			
					},
			
			} ,
			{
				title : '笔记数',
				field : 'noteCount',
				sortable : true,
				width : 150,
				formatter:function(value, rowData, rowIndex){
					var rows = datagrid.datagrid('getRows');
					var row = rows[rowIndex];
					return '<a href="javascript:void(0);" onclick="see(\''+row.username+'\',\''+ row.user_id +'\',11);">'+value+'</a>';
			
					},
			
			}
			 ] ], 
			toolbar : [  {
				text : '列显示隐藏',
				iconCls : 'icon-add',
				handler : function(e) {
					menu(e);
				}
			}, '-' ],
			
		});

	});
	function see(username,user_id,index) {
		if(username=="undefined"){
			username="";
		}
		if(user_id=="undefined"){
			user_id="";
		}
		
		var p = parent.sy.dialog({
			title : username+'记录详情',
			href : '${pageContext.request.contextPath}/back_user_track/to_user_log_see.action?username='+username+'&user_id='+user_id+'&index='+index,
			width : 600,
			height : 430,
			buttons : [ {
				text : '确定',
				handler : function() {
				    p.dialog('close');
				}
			}]
		});
	}
   function menu(e) {
   var headerContextMenu = this.headerContextMenu;/* 得到grid的列头菜单对象 */
if (!headerContextMenu) {
   var tmenu = $('<div style="width:100px;"></div>').appendTo('body');
   var grid=$('#datagrid');
var fields = $('#datagrid').datagrid('getColumnFields');
for ( var i = 0; i < fields.length; i++) {
var fildOption = grid.datagrid('getColumnOption', fields[i]);
if (!fildOption.hidden) {
$('<div iconCls="icon-ok" field="' + fields[i] + '"/>').html(fildOption.title).appendTo(tmenu);
} else {
$('<div iconCls="icon-empty" field="' + fields[i] + '"/>').html(fildOption.title).appendTo(tmenu);
}
}

headerContextMenu = this.headerContextMenu = tmenu.menu({
onClick : function(item) {
var field = $(item.target).attr('field');
if (item.iconCls == 'icon-ok') {
grid.datagrid('hideColumn', field);
$(this).menu('setIcon', {
target : item.target,
iconCls : 'icon-empty'
});
} else {
grid.datagrid('showColumn', field);
$(this).menu('setIcon', {
target : item.target,
iconCls : 'icon-ok'
});
}
}
});
}
headerContextMenu.menu('show', {
left : e.pageX,
top : e.pageY
});
};
$.fn.datagrid.defaults.onHeaderContextMenu = createGridHeaderContextMenu;
$.fn.treegrid.defaults.onHeaderContextMenu = createGridHeaderContextMenu; 

</script>

<body class="easyui-layout" data-options="fit:true">

	<div data-options="region:'center',border:false" style="overflow: hidden;">
		<table id="datagrid"></table>
	</div>

</body>
