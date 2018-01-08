<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css" href="../backstage/css/style.css" />
<script type="text/javascript" charset="utf-8">
	var loginDialog;
	var loginTabs;
	var loginInputForm;
	var loginDatagridForm;
	var loginComboboxForm;
	var loginDatagridName;
	var loginComboboxName;
	var sessionInfo;
	$(function() {
		var formParam = {
			url : '${pageContext.request.contextPath}/back_user/doNotNeedSession_login.action',
			success : function(data) {
				var d = $.parseJSON(data);
				if (d.success) {
					loginDialog.dialog('close');

					$('#sessionInfoDiv').html(sy.fs('[<strong>{0}</strong>]，欢迎你！您使用[<strong>{1}</strong>]IP登录！', d.obj.usernamer, d.obj.ip));

					//flashOnlineDatagrid();
				}
				$.messager.show({
					msg : d.msg,
					title : '提示'
				});
				//重新登录后刷新页面
				window.location.reload();
			}
		};

		loginInputForm = $('#loginInputForm').form(formParam);
		loginDatagridForm = $('#loginDatagridForm').form(formParam);
		loginComboboxForm = $('#loginComboboxForm').form(formParam);
		
		loginDialog = $('#loginDialog').show().dialog({
			closable : true,
			title : '登录',
			modal : true,
			buttons : [{
				text : '登录',
				handler : function() {
					var username = $("input[name=username]").val();
					var password = $("input[name=password]").val();
					if($.trim(username)==''){
						 $.messager.show({
								msg : "请输入用户名！",
								title : '提示'
						 });
						return false;
					}
					if($.trim(password)==''){
						 $.messager.show({
								msg : "请输入密码！",
								title : '提示'
						 });
						return false;
					}
					$.ajax({
						url : '${pageContext.request.contextPath}/back_user/doNotNeedSession_login.action',
						data:{"username":username,"password":password},
						success : function(data) {
							var d = $.parseJSON(data);
							if (d.success) {
								loginDialog.dialog('close');

								$('#sessionInfoDiv').html(sy.fs('[<strong>{0}</strong>]，欢迎你！您使用[<strong>{1}</strong>]IP登录！', d.obj.username, d.obj.ip));

								//在线插件
								//flashOnlineDatagrid();
								
								//重新登录后刷新页面
								window.location.reload();
							}
							$.messager.show({
								msg : d.msg,
								title : '提示'
							});
						}
					});
				}
		//后台注册注释
		/*  	},{
				text : '注册',
				handler : function() {
					regDialog.dialog('open');
				}  */
			} ],
			onOpen : function() {
				var t = $(this);
				window.setTimeout(function() {
					t.find('input[name=username]').focus();
				}, 0);
			}
		});

		loginTabs = $('#loginTabs').tabs({
			onSelect : function(title) {
					window.setTimeout(function() {
						$('div.validatebox-tip').remove();
						loginInputForm.find('input[name=username]').focus();
					}, 0);
			}
		});

		loginDatagridName = $('#loginDatagridName').combogrid({
			required : true,
			loadMsg : '数据加载中....',
			panelWidth : 440,
			panelHeight : 180,
			required : true,
			fitColumns : true,
			value : '',
			idField : 'username',
			textField : 'username',
			mode : 'remote',
			url : '',
			pagination : true,
			pageSize : 5,
			pageList : [ 5, 10 ],
			columns : [ [ {
				field : 'id',
				title : '编号',
				width : 60,
				hidden : true
			}, {
				field : 'username',
				title : '登录名',
				width : 100,
				sortable : true
			}, {
				field : 'ccreatedatetime',
				title : '创建时间',
				width : 150,
				sortable : true
			}, {
				field : 'cmodifydatetime',
				title : '最后修改时间',
				width : 150,
				sortable : true
			} ] ],
			delay : 500
		});

		loginComboboxName = $('#loginComboboxName').combobox({
			required : true,
			url : '',
			textField : 'username',
			valueField : 'username',
			mode : 'remote',
			panelHeight : 'auto',
			delay : 500,
			value : ''
		});

		$('form input').bind('keyup', function(event) {/* 增加回车提交功能 */
			var username = $("input[name=username]").val();
			var password = $("input[name=password]").val();
			if (event.keyCode == '13') {
				if($.trim(username)==''){
					 $.messager.show({
							msg : "请输入用户名！",
							title : '提示'
					 });
					return false;
				}
				if($.trim(password)==''){
					 $.messager.show({
							msg : "请输入密码！",
							title : '提示'
					 });
					return false;
				}
				$.ajax({
					url : '${pageContext.request.contextPath}/back_user/doNotNeedSession_login.action',
					data:{"username":username,"password":password},
					success : function(data) {
						var d = $.parseJSON(data);
						if (d.success) {
							loginDialog.dialog('close');
							$('#sessionInfoDiv').html(sy.fs('[<strong>{0}</strong>]，欢迎你！您使用[<strong>{1}</strong>]IP登录！', d.obj.username, d.obj.ip));
							//flashOnlineDatagrid();
							//重新登录后刷新页面
							window.location.reload();
						}
						$.messager.show({
							msg : d.msg,
							title : '提示'
						});
					}
				});
			}
		});
		
		sessionInfo = {
			id : '${sessionInfo.userId}',
			usewrname : '${sessionInfo.userName}',
			ip : '${sessionInfo.userId}'
		};
		if (sessionInfo.id) {/*如果有userId说明已经登陆过了*/
			window.setTimeout(function() {
				$('div.validatebox-tip').remove();
			}, 500);
			loginDialog.dialog('close');
			//flashOnlineDatagrid();
		}
		//调整页面登录按钮居中，以此做记录。
		$("div .dialog-button").children(".l-btn").eq(0).css("margin-right","765px");
		//调整页面登录登录用户和密码居中，以此做记录。
		$("div .yhmTxt").css("margin-right","600px");
		$("div .mmTxt").css("margin-right","600px");
		$("div .demTxt").css("margin-right","600px");
		$(".panel-tool-close").hide();
	});
	
	function flashOnlineDatagrid() {/*刷新在线列表*/
		window.setTimeout(function() {
			if ($('#onlineDatagrid').length > 0) {
				onlineDatagrid.datagrid({
					pagination : true,
					url : '${pageContext.request.contextPath}/admin/onlineAction!doNotNeedSession_onlineDatagrid.action'
				});
				var p = onlineDatagrid.datagrid('getPager');
				p.pagination({
					showPageList : false,
					showRefresh : false,
					beforePageText : '',
					afterPageText : '/{pages}',
					displayMsg : ''
				});
			}
		}, 3000);
	}

</script>
<div id="loginDialog" style="width:400px;height:270px; display: none;overflow: hidden;">
	<div id="loginTabs" data-options="fit:true,border:false">
		<div id="center" title="用户信息" style="overflow: hidden;" align="center">
				<form id="loginInputForm" class="center" method="post">
					<table id="logintable">
						<tr >
							 <td><input  type="text" class="yhmTxt" name="username" value=""/></td>
						</tr>
						<tr>
							<td ><input type="password" class="mmTxt" name="password" value=""/></td>
						</tr>
					</table>
				</form>
		</div>
		<!-- <div title="表格方式" style="overflow: hidden;">
			<div class="info">
				<div class="tip icon-tip"></div>
				<div>可模糊检索用户名</div>
			</div>
			<div align="center">
				<form id="loginDatagridForm" method="post">
					<table>
						<tr>
							<th style="text-align: right;">登录名</th>
							<td><select id="loginDatagridName" name="username" style="display: none;width: 155px;"></select></td>
						</tr>
						<tr>
							<th style="text-align: right;">密码</th>
							<td><input name="password" type="password" class="easyui-validatebox" data-options="required:true,missingMessage:'请填写登录密码'" style="width: 150px;" /></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		<div title="补全方式" style="overflow: hidden;">
			<div class="info">
				<div class="tip icon-tip"></div>
				<div>可自动补全用户名</div>
			</div>
			<div align="center">
				<form id="loginComboboxForm" method="post">
					<table>
						<tr>
							<th style="text-align: right;">登录名</th>
							<td><select id="loginComboboxName" name="username" style="display: none;width: 155px;"></select>
							</td>
						</tr>
						<tr>
							<th style="text-align: right;">密码</th>
							<td><input name="password" type="password" class="easyui-validatebox" data-options="required:true,missingMessage:'请填写登录密码'" style="width: 150px;" />
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div> -->
	</div>
</div>