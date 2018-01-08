<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" charset="utf-8">
    function logout(b) {
        $('#sessionInfoDiv').html('');
        $.post('${pageContext.request.contextPath}/back_user/doNotNeedSession_logout.action', function() {
            if (b) {
                if (sy.isLessThanIe8()) {
                    loginDialog.dialog('open');
                } else {
                    location.replace('${pageContext.request.contextPath}/backstage');
                }
            } else {
                loginDialog.dialog('open');
            }
        });
    }
    function showUserInfo() {
        var p = parent.sy.dialog({
            title : '个人信息',
            href : '${pageContext.request.contextPath}/back_user/doNotNeedSession_to_see_me.action?user_type=0',
            width : 490,
            height : 285,
            buttons : [ {
                text : '关闭',
                handler : function() {
                	p.dialog('close');
                }
            } ]/* ,
            onLoad : function() {
            	var roleIds = f.find('input[name=roleIds]');
				var roleIdsCombobox = roleIds.combobox({
					url : '${pageContext.request.contextPath}/back_role/doNotNeedSession_combobox.action',
					valueField : 'id',
					textField : 'name',
					multiple : true,
					editable : false,
					panelHeight : 'auto',
					onLoadSuccess : function() {
						parent.$.messager.progress('close');
					}
				});
            } */
        });
    }

</script>
<style>
	 .header_title{background-color:#4e809e;width: 100%;height:58px;line-height: 58px;padding-left: 20px;font-size: 16px;color: #fff;}
</style>

<div style="width:100%; height:100%;">
	<div class="header_title" >中国教师网后台管理系统</div>
	<div id="sessionInfoDiv" style="position: absolute;right: 5px;top:10px;">
		<c:if test="${!empty sessionInfo.userId}">[<strong>${sessionInfo.userName}</strong>]，
			欢迎你！您使用[<strong>${sessionInfo.remote_ip}</strong>]IP登录！</c:if>
	</div>
	<div style="position: absolute; right: 0px; bottom: 0px; ">
		<a href="javascript:void(0);" class="easyui-menubutton" data-options="menu:'#layout_north_pfMenu',iconCls:'icon-ok'">更换皮肤</a>
		<a href="javascript:void(0);" class="easyui-menubutton" data-options="menu:'#layout_north_kzmbMenu',iconCls:'icon-help'">控制面板</a>
		<a href="javascript:void(0);" class="easyui-menubutton" data-options="menu:'#layout_north_zxMenu',iconCls:'icon-back'">注销</a>
	</div>
	<div id="layout_north_pfMenu" style="width: 120px; display: none;">
		<div onclick="sy.changeTheme('default');">default</div>
		<div onclick="sy.changeTheme('gray');">gray</div>
		<div onclick="sy.changeTheme('metro');">metro</div>
		<div onclick="sy.changeTheme('cupertino');">cupertino</div>
		<div onclick="sy.changeTheme('dark-hive');">dark-hive</div>
		<div onclick="sy.changeTheme('pepper-grinder');">pepper-grinder</div>
		<div onclick="sy.changeTheme('sunny');">sunny</div>
	</div>
	<div id="layout_north_kzmbMenu" style="width: 100px; display: none;">
		<div onclick="showUserInfo();">个人信息</div>
		<div class="menu-sep"></div>
		<div>
			<span>更换主题</span>
			<div style="width: 120px;">
				<div onclick="sy.changeTheme('default');">default</div>
				<div onclick="sy.changeTheme('gray');">gray</div>
				<div onclick="sy.changeTheme('metro');">metro</div>
				<div onclick="sy.changeTheme('cupertino');">cupertino</div>
				<div onclick="sy.changeTheme('dark-hive');">dark-hive</div>
				<div onclick="sy.changeTheme('pepper-grinder');">pepper-grinder</div>
				<div onclick="sy.changeTheme('sunny');">sunny</div>
			</div>
		</div>
	</div>

	<input type="hidden" id="loginName" value="${sessionInfo.userName}"/>

	<div id="layout_north_zxMenu" style="width: 100px; display: none;">
		<div onclick="loginDialog.dialog('open');">锁定窗口</div>
		<div class="menu-sep"></div>
		<div onclick="logout();">重新登录</div>
		<div onclick="logout(true);">退出系统</div>
	</div>
</div>