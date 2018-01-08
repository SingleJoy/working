<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%		String user_type = request.getParameter("user_type");
 %>
<jsp:include page="/backstage/base/inc.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
	var datagrid;
	var currLevel = "${sessionInfo.level}";
	var adminName = "${sessionInfo.userName}";
	$(function(){
		datagrid = $('#datagrid').datagrid({
			url : '${pageContext.request.contextPath}/back_user/datagrid.action?user_type='+<%=user_type%>,
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
				title : '登录名',
				field : 'username',
				width : 130,
				sortable : true
			} ] ],
			columns : [ [ {
				title : '手机号',
				field : 'phone',
				width : 100,
			}, {
				title : '姓名',
				field : 'realname',
				width : 130,
			},{
				title : '性别',
				field : 'sex',
				width : 40,
				formatter:function(value, rowData, rowIndex){
					if(value=="0"){
						return "女";
					}else{
						return "男";
					}
				}
			}, {
				title : '注册时间（IP）',
				field : 'create_time',
				sortable : true,
				width : 230,
				formatter:function(value, rowData, rowIndex){
					var rows = datagrid.datagrid('getRows');
					var row = rows[rowIndex];
					if(row.sign_ip!=null){
						return row.create_time+"（"+row.sign_ip+"）";
					}else{
						return row.create_time;
					}
					
				}
			}, {
				title : '所属角色ID',
				field : 'roleIds',
				width : 150,
				hidden : true
			}, {
				title : '所属角色',
				field : 'roleNames',
				width : 150
		    }, {
				title : '角色等级',
				field : 'level',
				width : 80,
				sortable : true
			}, {
				title : '最近登录时间（IP）',
				field : 'last_login_time',
				sortable : true,
				width : 250,
				formatter:function(value, rowData, rowIndex){
					var rows = datagrid.datagrid('getRows');
					var row = rows[rowIndex];
					if(row.last_login_ip!=null){
						if(row.last_login_time!=null){
							return row.last_login_time+"（"+row.last_login_ip+"）";
						}else{
							return "（"+row.last_login_ip+"）";
						}
					}else{
						return row.last_login_time;
					}
					
				}
			},{
				title : '状态',
				field : 'status',
				width : 50,
				sortable : true,
				formatter:function(v){
					if(v=="1"){
						return '正常';
					}else if(v=="3"){
						return "删除";	
					}else{
						return "禁用";
					}
				} 
			},{
				title : '操作',
				field : 'statusType',
				width : 180,
				sortable : true,
				formatter:function(value, rowData, rowIndex){
					var rows = datagrid.datagrid('getRows');
					var row = rows[rowIndex];
					var $row = JSON.stringify(row).replace(/\"/g,"'");
					var edit = '<a href="javascript:void(0);" onclick="edit1('+ $row +');">编辑</a>';
					var editPassword = '<a href="javascript:void(0);" onclick="editPassword('+ $row +');">修改密码</a>';
					var see = '<a href="javascript:void(0);" onclick="see('+ $row +');">查看</a>';
					var functions = '&nbsp;&nbsp;'+editPassword+'&nbsp;&nbsp;'+see+'&nbsp;&nbsp;'+edit;
					if(value=="1"){
						return '<a href="javascript:void(0);" onclick="doChangeStatus(\'' + row.id + '\',2,'+row.level+',\''+row.username+'\');">禁用</a>'+functions;
					}else{
						return '<a href="javascript:void(0);" onclick="doChangeStatus(\'' + row.id + '\',1,'+row.level+',\''+row.username+'\');">启用</a>'+functions;
					}
				}
				
			} ] ],
			toolbar : [ {
				text : '增加',
				iconCls : 'icon-add',
				handler : function() {
					append();
				}
			}, '-', {
				text : '删除',
				iconCls : 'icon-remove',
				handler : function() {
					remove();
				}
			}, '-', {
				text : '修改',
				iconCls : 'icon-edit',
				handler : function() {
					edit();
				}
			}, '-', {
				text : '取消选中',
				iconCls : 'icon-undo',
				handler : function() {
					datagrid.datagrid('clearSelections');
					datagrid.datagrid('unselectAll');
				}
			}, '-', {
				text : '批量修改用户角色',
				iconCls : 'icon-edit',
				handler : function() {
					editRole();
				}
			}, '-' ],
			onLoadSuccess:function(){    
				if(<%=user_type%>!="0"){
					$('#datagrid').datagrid('hideColumn', 'roleNames');
					$('#datagrid').datagrid('hideColumn', 'level');
					$('div.datagrid div.datagrid-toolbar a').eq(4).hide();
				}else{
					$('#datagrid').datagrid('hideColumn', 'phone');
					$('#datagrid').datagrid('hideColumn', 'realname');
					$('#datagrid').datagrid('hideColumn', 'sex');
				}
		    },
			onRowContextMenu : function(e, rowIndex, rowData) {
				e.preventDefault();
				$(this).datagrid('unselectAll');
				$(this).datagrid('selectRow', rowIndex);
				$('#menu').menu('show', {
					left : e.pageX,
					top : e.pageY
				});
			}
		});
		

	});
	
	 
	
	//修改密码
	function editPassword(obj){
		if(("${user_type}"=="0"&&obj.level<currLevel&&adminName!='admin')||(obj.username=='admin'&&adminName!='admin')){
			parent.sy.messagerAlert('提示', '您没有权限修改该用户密码，请联系admin用户解决！', 'error');
			return;
		}
		var p = parent.sy.dialog({
			title : '修改密码',
			href : '${pageContext.request.contextPath}/back_user/to_user_password_edit.action?user_type='+<%=user_type%>,
			width : 420,
			height : 250,
			buttons : [ {
				id : "reset_password",
				text : '编辑',
				handler : function() {
					var f = p.find('form');
				    f.form('submit', {
						url : '${pageContext.request.contextPath}/back_user/edit_user.action?user_type='+<%=user_type%>,
						success : function(d) {
							var json = $.parseJSON(d);
							if (json.success) {
								datagrid.datagrid('reload');
								p.dialog('close');
							}
							parent.sy.messagerShow({
								msg : json.msg,
								title : '提示'
							});
						} 
					});   
				}
			} ], 
			onLoad : function() {
				var f = p.find('form');
				f.form('load', {
					id : obj.id,
					username : obj.username,
					phone : obj.phone
				});
			}
		});
	}
	//禁用、启用用户
	function doChangeStatus(id,value,level,uuname){
		var str = "";
		if(value==1){
			str = "启用";
		}else if(value==2){
			str = "禁用";
		}
		if(("${user_type}"=="0"&&level<=currLevel&&adminName!='admin')||(uuname=='admin'&&adminName!='admin')){
			parent.sy.messagerAlert('提示', '您没有权限'+str+'该用户，请联系admin用户解决！', 'error');
			return;
		}
		parent.sy.messagerConfirm('请确认', '您要'+str+'该用户？', function(r) {
			if (r) {
				$.ajax({
					url : '${pageContext.request.contextPath}/back_user/doNotNeedSession_doChangeStatus.action',
					data:{
						id : id,
						status : value
					},
					success : function(d) {
						var json = $.parseJSON(d);
						if (json.success) {
							datagrid.datagrid('reload');
						}
						parent.sy.messagerShow({
							msg : json.msg,
							title : '提示'
						});
					}
				});
			}
		});
		
	}
	function editRole() {
		var rows = datagrid.datagrid('getSelections');
		var ids = [];
		if (rows.length > 0) {
			for ( var i = 0; i < rows.length; i++) {
				if((rows[i].level<=currLevel&&adminName!='admin')||(rows[i].username=='admin'&&adminName!='admin')){
					parent.sy.messagerAlert('提示', '您没有权限修改该用户角色，请联系admin用户解决！', 'error');
					return;
				}
			}
			for ( var i = 0; i < rows.length; i++) {
				ids.push(rows[i].id);
			}
			var p = parent.sy.dialog({
				title : '批量编辑用户角色',
				href : '${pageContext.request.contextPath}/back_user/to_role_edit.action',
				width : 250,
				height : 130,
				buttons : [ {
					text : '编辑',
					handler : function() {
						var f = p.find('form');
						f.form('submit', {
							url : '${pageContext.request.contextPath}/back_user/save_role_edit.action',
							success : function(d) {
								var json = $.parseJSON(d);
								if (json.success) {
									datagrid.datagrid('reload');
									p.dialog('close');
								}
								parent.sy.messagerShow({
									msg : json.msg,
									title : '提示'
								});
							}
						});
					}
				} ],
				onLoad : function() {
					var f = p.find('form');
					var idsInput = f.find('input[name=ids]');
					var roleIds = f.find('input[name=roleIds]');
					var level;
					if(adminName!="admin"){
						level = currLevel;
					}else{
						level = "";
					}
					var roleIdsCombobox = roleIds.combobox({
						url : '${pageContext.request.contextPath}/back_role/doNotNeedSession_combobox.action?level='+level,
						valueField : 'id',
						textField : 'name',
						multiple : true,
						editable : false,
						panelHeight : 'auto',
						onLoadSuccess : function() {
							f.form('load', {
								ids : ids.join(',')
							});
						}
					});
				}
			});
		} else {
			parent.sy.messagerAlert('提示', '请选择要编辑的记录！', 'error');
		}
	}

	function edit1(obj) {
		if(("${user_type}"=="0"&&obj.level<=currLevel&&adminName!='admin')||(obj.username=='admin'&&adminName!='admin')){
			parent.sy.messagerAlert('提示', '您没有权限编辑该用户，请联系admin用户解决！', 'error');
			return;
		}
		var p = parent.sy.dialog({
			title : '编辑用户',
			href : '${pageContext.request.contextPath}/back_user/to_user_edit.action?user_type='+<%=user_type%>,
			width : 500,
			height : 280,
			buttons : [ {
				text : '编辑',
				handler : function() {
					var f = p.find('form');
					f.form('submit', {
						url : '${pageContext.request.contextPath}/back_user/edit_user.action?user_type='+<%=user_type%>,
						success : function(d) {
							var json = $.parseJSON(d);
							if (json.success) {
								datagrid.datagrid('reload');
								p.dialog('close');
							}
							parent.sy.messagerShow({
								msg : json.msg,
								title : '提示'
							});
						}
					});
				}
			} ],
			onLoad : function() {
				var f = p.find('form');
				if("${user_type}"=="0"){
					var roleIds = f.find('input[name=roleIds]');
					var level;
					if(adminName!="admin"){
						level = currLevel;
					}else{
						level = "";
					}
					var roleIdsCombobox = roleIds.combobox({
						url : '${pageContext.request.contextPath}/back_role/doNotNeedSession_combobox.action?level='+level,
						valueField : 'id',
						textField : 'name',
						multiple : true,
						editable : false,
						panelHeight : 'auto',
						onLoadSuccess : function() {
							parent.$.messager.progress('close');
						}
					});
					f.form('load',{
						roleIds : sy.getList(obj.roleIds)
					})
				}else{
					f.form('load', {
						realname : obj.realname,
						sex : obj.sex,
						sign_type : obj.sign_type
					});
				}
				
				f.form('load', {
					id : obj.id,
					username : obj.username,
					remarks : obj.remarks,
					phone_old : obj.phone,
					phone : obj.phone,
					name_old : obj.username,
					email_old : obj.email,
					email : obj.email,
				});
				
			}
		});
	}
	
	function see(obj) {
		if(("${user_type}"=="0"&&obj.level<=currLevel&&adminName!='admin')||(obj.username=='admin'&&adminName!='admin')){
			parent.sy.messagerAlert('提示', '您没有权限查看该用户，请联系admin用户解决！', 'error');
			return;
		}
		var p = parent.sy.dialog({
			title : '查看用户',
			href : '${pageContext.request.contextPath}/back_user/to_user_see.action?user_type='+<%=user_type%>,
			width : 510,
			height : 400,
			onLoad : function() {
				var f = p.find('form');
				if("${user_type}"=="0"){
					var roleIds = f.find('input[name=roleIds]');
					var level;
					if(adminName!="admin"){
						level = currLevel;
					}else{
						level = "";
					}
					var roleIdsCombobox = roleIds.combobox({
						url : '${pageContext.request.contextPath}/back_role/doNotNeedSession_combobox.action?level='+level,
						valueField : 'id',
						textField : 'name',
						multiple : true,
						editable : false,
						panelHeight : 'auto',
						onLoadSuccess : function() {
							parent.$.messager.progress('close');
						}
					});
				}
				f.form('load', {
					id : obj.id,
					username : obj.username,
					realname : obj.realname,
					wealth : obj.wealth,
					login_count : obj.login_count,
					user_type : function(){
						var user_type = obj.user_type;
						if(user_type==0){
							return "系统用户";
						}else if(user_type==1){
							return "网站用户";
						}else if(user_type==2){
							return "网站管理用户";
						}else if(user_type==3){
							return "网站老师";
						}
					},
					status : function(){
						var status = obj.status;
						if(status==1){
							return "正常";
						}else if(status==2){
							return "禁用";
						}else if(status==3){
							return "删除";
						}else if(status==4){
							return "未通过";
						}
					},
					sign_type : function(){
						var sign_type = obj.sign_type;
						if(sign_type==0){
							return "账号注册";
						}else if(sign_type==1){
							return "手机验证";
						}else if(sign_type==2){
							return "手动（后台）注册";
						}
					},
					create_time : obj.create_time,
					sign_ip : obj.sign_ip,
					last_login_time : obj.last_login_time,
					last_login_ip : obj.last_login_ip,
					remarks : obj.remarks,
					phone : obj.phone,
					email : obj.email,
					sex : function(){
						var s = obj.sex;
						if(s==0){
							return "女";
						}else{
							return "男";
						}
					}
				});
				if("${user_type}"=="0"){
					f.form('load', {roleIds : sy.getList(obj.roleIds)});
				}
				
			}
		});
	}
	function edit() {
		var rows = datagrid.datagrid('getSelections');
		if (rows.length == 1) {
			if("${user_type}"!="0"||rows[0].level>currLevel||adminName=='admin'){
				var p = parent.sy.dialog({
					title : '编辑用户',
					href : '${pageContext.request.contextPath}/back_user/to_user_edit.action?user_type='+<%=user_type%>,
					width : 500,
					height : 280,
					buttons : [ {
						text : '编辑',
						handler : function() {
							var f = p.find('form');
							f.form('submit', {
								url : '${pageContext.request.contextPath}/back_user/edit_user.action?user_type='+<%=user_type%>,
								success : function(d) {
									var json = $.parseJSON(d);
									if (json.success) {
										datagrid.datagrid('reload');
										p.dialog('close');
									}
									parent.sy.messagerShow({
										msg : json.msg,
										title : '提示'
									});
								}
							});
						}
					} ],
					onLoad : function() {
						var f = p.find('form');
						var roleIds = f.find('input[name=roleIds]');
						var level;
						if(adminName!="admin"){
							level = currLevel;
						}else{
							level = "";
						}
						var roleIdsCombobox = roleIds.combobox({
							url : '${pageContext.request.contextPath}/back_role/doNotNeedSession_combobox.action?level='+level,
							valueField : 'id',
							textField : 'name',
							multiple : true,
							editable : false,
							panelHeight : 'auto',
							onLoadSuccess : function() {
								parent.$.messager.progress('close');
							}
						});
						f.form('load', {
							id : rows[0].id,
							username : rows[0].username,
							remarks : rows[0].remarks,
							roleIds : sy.getList(rows[0].roleIds),
							phone_old : rows[0].phone,
							name_old : rows[0].username,
							email_old : rows[0].email,
							email : rows[0].email,
						});
					}
				});
			}else{
				parent.sy.messagerAlert('提示', '您没有权限编辑该用户，请联系admin用户解决！', 'error');
			}
		} else if (rows.length > 1) {
			parent.sy.messagerAlert('提示', '同一时间只能编辑一条记录！', 'error');
		} else {
			parent.sy.messagerAlert('提示', '请选择要编辑的记录！', 'error');
		}
	}
	function append() {
		var p = parent.sy.dialog({
			title : '添加用户',
			href : '${pageContext.request.contextPath}/back_user/to_user_add.action?user_type='+<%=user_type%>,
			width : 500,
			height : 280,
			buttons : [ {
				text : '添加',
				handler : function() {
					var f = p.find('form');
					f.form('submit', {
						url : '${pageContext.request.contextPath}/back_user/save_user.action?user_type='+<%=user_type%>,
						success : function(d) {
							var json = $.parseJSON(d);
							if (json.success) {
								datagrid.datagrid('reload');
								p.dialog('close');
							}
							parent.sy.messagerShow({
								msg : json.msg,
								title : '提示'
							});
						}
					});
				}
			} ],
			onLoad : function() {
				var f = p.find('form');
				var roleIds = f.find('input[name=roleIds]');
				var level;
				if(adminName!="admin"){
					level = currLevel;
				}else{
					level = "";
				}
				var roleIdsCombobox = roleIds.combobox({
					url : '${pageContext.request.contextPath}/back_role/doNotNeedSession_combobox.action?level='+level,
					valueField : 'id',
					textField : 'name',
					multiple : true,
					editable : false,
					panelHeight : 'auto'
				});
			}
		});
	}
	function remove() {
		var rows = datagrid.datagrid('getChecked');
		var ids = [];
		if (rows.length > 0) {
			if("${user_type}"=="0"){
				for ( var i = 0; i < rows.length; i++) {
					if((rows[i].level<=currLevel&&adminName!='admin')||(rows[i].username=='admin'&&adminName!='admin')){
						parent.sy.messagerAlert('提示', '您没有权限删除该用户，请联系admin用户解决！', 'error');
						return;
					}
				}
			}
			parent.sy.messagerConfirm('请确认', '您要删除当前所选记录？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						ids.push(rows[i].id);
						if(rows[i].status!='2'){
							parent.sy.messagerShow({
								msg : "只能删除禁用的记录！",
								title : '提示'
							});
							return false;
						}
					}
					$.ajax({
						url : '${pageContext.request.contextPath}/back_user/delete_user.action',
						data : {
							ids : ids.join(',')
						},
						dataType : 'json',
						success : function(d) {
							datagrid.datagrid('load');
							datagrid.datagrid('unselectAll');
							parent.sy.messagerShow({
								title : '提示',
								msg : d.msg
							});
						}
					});
				}
			});
		} else {
			parent.sy.messagerAlert('提示', '请勾选要删除的记录！', 'error');
		}
	}
	function _search() {
		var timeStart = $("#timeStart").datebox("getValue");
		var timeEnd = $("#timeEnd").datebox("getValue");
		if(timeStart!=""||timeEnd!=""){
			if($("#bb").val()=="-1"){
				parent.sy.messagerShow({
   					msg : "请选择时间类型",
   					title : '提示'
   				});
				return false;
			}
		}
		if($("#keyname").val()!=""){
			if($("#aa").val()=="-1"){
				parent.sy.messagerShow({
   					msg : "请选择关键词类型",
   					title : '提示'
   				});
				return false;
			}
		}
		datagrid.datagrid('load', sy.serializeObject($('#searchForm')));  
	}
	function cleanSearch() {
		datagrid.datagrid('load', {});
		$('#searchForm input').val('');
		$('#searchForm select').val('-1'); 
		
	}
</script>

<body class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north',border:false,title:'过滤条件'" style="height: <c:if test="${user_type==0}">100</c:if><c:if test="${user_type!=0}">131</c:if>px;overflow: hidden;" align="left">
		<form id="searchForm" style="width: 100%;height: 100%;">
			<div style="height:100%;background-color: #efefef;padding-top: 20px;padding-left: 20px;">
				<c:if test="${user_type!=0}">
					<div>
						<span>关键词：</span>
						<select id="aa"   style="width:90px;margin-left: 20px;" onchange="changeKey(this)">
							<option value="-1" selected="selected">请选择</option>
							<option value="username">用户名</option>
							<option value="phone">手机号</option>
							<option value="last_login_ip">最近登录IP</option>
						</select>
						<span style="margin-left: 20px;">
						<input id="keyname" style="width:150px;" />
					</span>
						<span style="margin-left: 20px;">注&nbsp;册：&nbsp;&nbsp;</span>

						<select id="dd"  name="sign_type"  style="width:100px;margin-left: 20px;">
							<option value="-1" selected="selected">请选择</option>
							<option value="0">普通注册</option>
							<option value="1">快捷注册</option>
							<option value="2">后台注册</option>
						</select>
					</div>

					<div style="margin-top: 20px;">

						<c:if test="${user_type==0}">
							<select id="cc" name="roleIds" class="easyui-combobox" style="width:70px;margin-left: 20px;">

							</select>
						</c:if>

						<span >时&nbsp;&nbsp;&nbsp;间：</span>
						<select id="bb" name="serach_time"  style="width:90px;margin-left: 20px;">
							<option value="-1" selected="selected">请选择</option>
							<option value="0">注册时间</option>
							<option value="1">登录时间</option>
						</select>


						<span style="margin-left: 20px;">
					    <input id="timeStart" name="timeStart" class="easyui-datebox" data-options="editable:false" style="width: 150px;" />
							&nbsp;至&nbsp;
						<input id="timeEnd" name="timeEnd" class="easyui-datebox" data-options="editable:false" style="width: 150px;" />
					    <c:if test="${user_type==0}">

						</c:if>
						<a href="javascript:void(0);" class="easyui-linkbutton" onclick="_search();" style="margin-left: 20px;">查询</a>
						<a href="javascript:void(0);" class="easyui-linkbutton" onclick="cleanSearch();" style="margin-left: 20px;">清空</a>
					</span>
					</div>




				</c:if>
				<c:if test="${user_type==0}">

					<span>用户名：</span>
					<span style="margin-left: 20px;">
						<input name="username" style="width: 125px;">
					</span>
					<a href="javascript:void(0);" class="easyui-linkbutton" onclick="_search();" style="margin-left: 20px;">查询</a>
					<a href="javascript:void(0);" class="easyui-linkbutton" onclick="cleanSearch();" style="margin-left: 20px;">清空</a></span>

				</c:if>
			</div>
		</form>
	</div>
	<div data-options="region:'center',border:false" style="overflow: hidden;">
		<table id="datagrid"></table>
	</div>

	<div id="menu" class="easyui-menu" style="width:120px;display: none;">
		<div onclick="append();" data-options="iconCls:'icon-add'">增加</div>
		<div onclick="remove();" data-options="iconCls:'icon-remove'">删除</div>
		<div onclick="edit();" data-options="iconCls:'icon-edit'">编辑</div>
	</div>
</body>

<script>
function changeKey(obj){
	if(obj.value!="-1"){
		$("#keyname").attr("name",obj.value);
	}
}
/* $('#aa').combobox({
	onSelect: function(record){
		if(record.value!=-1){
			$("#keyname").attr("name",record.value); 
		}
	}
}); 
$('#bb').combobox({
	onSelect: function(record){
		$("#serach_time").val(record.value); 
	}
}); */
var level;
if(adminName!="admin"){
	level = currLevel;
}else{
	level = "";
}
var roleIdsCombobox = $("#cc").combobox({
	url : '${pageContext.request.contextPath}/back_role/doNotNeedSession_combobox.action?level='+level,
	valueField : 'id',
	textField : 'name',
	multiple : false,
	editable : false,
	panelHeight : 'auto',
	onLoadSuccess : function() {
		parent.$.messager.progress('close');
	}
});

</script>


