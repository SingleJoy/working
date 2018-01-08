<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%		String user_type = 1+"";
%>
<jsp:include page="../inc.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
        var datagrid;
        $(function(){
            datagrid = $('#datagrid').datagrid({
                url : '${pageContext.request.contextPath}/back_certification/certificating.action?type=0',
                title : '教师申请列表',
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
                sortName : 'apply_time',
                sortOrder : 'desc',
                checkOnSelect : true,
                selectOnCheck : true,
                frozenColumns : [ [  {
                    title : '编号',
                    field : 'id',
                    width : 150,
                    sortable : true,
                    checkbox : true
                }, {
                    title : '用户名',
                    field : 'username',
                    width : 100,
                    sortable : true,
                    formatter:function(value, rowData, rowIndex){

                        return rowData.username;
                    }
                } ] ],
                columns : [ [
                    {
                        title : '真实姓名',
                        field : 'true_name',
                        sortable : true,
                        width : 100,
                    },
                    {
                        title : '所属学校或单位',
                        field : 'school',
                        sortable : true,
                        width : 200,
                    },
                    {
                        title : '是否推荐',
                        field : 'is_recommended',
                        sortable : true,
                        width : 60,
                        formatter:function(value, rowData, rowIndex){
                            if(rowData.is_recommended==0){
                                return "否";

                            }
                            else{
                                return "是";

                            }


                        }
                    },
                    {
                        title : '申请类别',
                        field : 'type',
                        sortable : true,
                        width : 60,
                        formatter:function(value, rowData, rowIndex){
                            if(rowData.certificate_type==1){
                                return "老师";

                            }
                            if(rowData.certificate_type==2){
                                return "教研员";

                            }
                            if(rowData.certificate_type==3){
                                return "其他";

                            }

                        }
                    },
                    {
                        title : '状态',
                        field : 'certificated',
                        sortable : true,
                        width : 80,
                        formatter:function(value, rowData, rowIndex){
                            if(rowData.certificated==0){
                                return "未审核";
                            }
                            if(rowData.certificated==1){
                                return "审核通过";
                            }
                            if(rowData.certificated==2){
                                return "审核不通过";
                            }



                        }
                    },
                    {
                        title : '申请时间',
                        field : 'apply_time',
                        sortable : true,
                        width : 150,
                    },
                    {
                        title : '审核时间',
                        field : 'review_time',
                        sortable : true,
                        width : 150,
                    },
                    {
                        title : '详情',
                        field : 'statusType',
                        width : 150,
                        formatter:function(value, rowData, rowIndex){
                            var html="";
                            html+='<a href="javascript:void(0);" onclick="xiangqing(\'' + rowData.id+ '\');">查看详情</a>&nbsp;';
                            if(rowData.certificated==1){
                                if(rowData.is_recommended==0){
                                    html+='<a href="javascript:void(0);" onclick="recommended(\'' + rowData.id+ '\');">教师推荐</a>';
                                }else{
                                    html+='<a href="javascript:void(0);" onclick="unRecommended(\'' + rowData.id+ '\');">取消推荐</a>';
                                }
                                html+='&nbsp;<a href="javascript:void(0);" onclick="removed(\'' + rowData.id+ '\');">撤销</a>';
                            }

                            return html;


                        }

                    } ] ],
                toolbar : [ {
                    text : '审核中',
                    iconCls : 'icon-edit',
                    handler : function() {
                        certificated(0);
                    }
                }, '-',
                    {
                        text : '认证用户',
                        iconCls : 'icon-edit',
                        handler : function() {
                            certificated(1);
                        }
                    }, '-',
                    {
                        text : '全部',
                        iconCls : 'icon-edit',
                        handler : function() {
                            certificated(-1);
                        }
                    }, '-' ],
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
        function unRecommended(id){
            parent.sy.messagerConfirm('请确认', '您要处理当前所选记录？', function(r) {
                if (r) {
                    $.ajax({
                        url : "${pageContext.request.contextPath}/back_certification/unRecommended.action?source_type=1&source_id="+id,

                        dataType:'json',
                        success : function(d) {

                            if (d.success) {
                                datagrid.datagrid('reload');
                            }
                            parent.sy.messagerShow({
                                msg : d.msg,
                                title : '提示'
                            });
                        }
                    });
                }

            });
        }
        function removed(id) {
            var ids = [];
            ids.push(id);
            var p = parent.sy.dialog({
                title : '原因',
                href : '${pageContext.request.contextPath}/back_certification/to_msg1.action',
                width : 550,
                height : 320,
                buttons : [ {
                    text : '确定',
                    handler : function() {

                        var  reason=p.find("#msg").val();

                        $.ajax({
                            url : "${pageContext.request.contextPath}/back_certification/certificated.action?status=2&reason="+reason,
                            data : {
                                ids : ids.join(',')
                            },
                            dataType:'json',
                            success : function(d) {

                                if (d.success) {
                                    datagrid.datagrid('reload');
                                }
                                parent.sy.messagerShow({
                                    msg : d.msg,
                                    title : '提示'
                                });
                            }
                        });

                        p.dialog('close');
                    }
                },
                    {
                        text : '取消',
                        handler : function() {
                            p.dialog('close');
                        }
                    }
                ],
                onLoad : function() {

                }
            });

        }
        function recommended(id){
            var p = parent.sy.dialog({
                title : '推荐设置',
                href : '${pageContext.request.contextPath}/back_certification/to_recommended.action',
                width : 420,
                height : 260,
                buttons : [ {
                    text : '推荐通过',
                    handler : function() {

                        var f = p.find('form');
                        f.form('submit', {
                            url : "${pageContext.request.contextPath}/back_certification/recommended.action?source_type=1&source_id="+id,
                            dataType:'json',
                            success : function(d) {
                                var json = $.parseJSON(d);
                                p.dialog('close');
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
                },
                    {
                        text : '取消',
                        handler : function() {
                            p.dialog('close');
                        }
                    }
                ],
                onLoad : function() {

                }
            });



        }
        function xiangqing(id){

            var p = parent.sy.dialog({
                title : '详情',
                href : '${pageContext.request.contextPath}/back_certification/to_msg.action?id='+id,
                width : 550,
                height : 620,
                buttons : [ {
                    text : '审核通过',
                    handler : function() {
                        p.dialog('close');
                        edit(1,id);

                    }
                },{
                    text : '审核不通过',
                    handler : function() {
                        edit(2,id);
                        p.dialog('close');
                    }
                },
                    {
                        text : '取消',
                        handler : function() {
                            p.dialog('close');
                        }
                    }
                ],
                onLoad : function() {

                }
            });
        }

        function edit(n,t) {
            //selectRecord
            var rows;
            if(!t)
                rows = datagrid.datagrid('getSelections');
            else{
                datagrid.datagrid('unselectAll');
                datagrid.datagrid('selectRecord',t);
                rows = datagrid.datagrid('getSelections');
            }
            var ids = [];
            for ( var i = 0; i < rows.length; i++) {
                if(rows[i].certificated!=0){

                    parent.sy.messagerAlert('提示', '已经审核过了！', 'error');
                    return false;


                }

                ids.push(rows[i].id);
            }
            if (rows.length >0) {
                if(n==1){
                    parent.sy.messagerConfirm('请确认', '您要处理当前所选记录？', function(r) {
                        if (r) {
                            $.ajax({
                                url : "${pageContext.request.contextPath}/back_certification/certificated.action?status="+n,
                                data : {
                                    ids : ids.join(',')
                                },
                                dataType:'json',
                                success : function(d) {

                                    if (d.success) {
                                        datagrid.datagrid('reload');
                                    }
                                    parent.sy.messagerShow({
                                        msg : d.msg,
                                        title : '提示'
                                    });
                                }
                            });
                        }

                    });
                }
                if(n==2){
                    var p = parent.sy.dialog({
                        title : '原因',
                        href : '${pageContext.request.contextPath}/back_certification/to_msg1.action',
                        width : 550,
                        height : 320,
                        buttons : [ {
                            text : '确定',
                            handler : function() {

                                var  reason=p.find("#msg").val();

                                $.ajax({
                                    url : "${pageContext.request.contextPath}/back_certification/certificated.action?status="+n+"&reason="+reason,
                                    data : {
                                        ids : ids.join(',')
                                    },
                                    dataType:'json',
                                    success : function(d) {

                                        if (d.success) {
                                            datagrid.datagrid('reload');
                                        }
                                        parent.sy.messagerShow({
                                            msg : d.msg,
                                            title : '提示'
                                        });
                                    }
                                });

                                p.dialog('close');
                            }
                        },
                            {
                                text : '取消',
                                handler : function() {
                                    p.dialog('close');
                                }
                            }
                        ],
                        onLoad : function() {

                        }
                    });
                }
            }
            else {
                parent.sy.messagerAlert('提示', '请选择要编辑的记录！', 'error');
            }
        }
        function _search() {
            datagrid.datagrid('load', sy.serializeObject($('#searchForm')));
        }
        function certificated(id) {
            datagrid.datagrid('load', {certificated:id});
        }
        function cleanSearch() {
            datagrid.datagrid('load', {});
            $('#searchForm input').val('');
        }

        function _province(value){
            $("#area_id").val(value);
            $("#city").find("option").remove();
            $("#county").find("option").remove();
            $("#school").find("option").remove();
            $("#city").append('<option value=-1 >--请选择！--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </option>');
            $("#county").append('<option value=-1 >--请选择！--</option>');
            $("#school").append('<option value=-1 >--请选择！--</option>');
            if(value==1){
                value=0;
            }
            $.ajax({
                url:"${pageContext.request.contextPath}/area/showArea.action?parentId="+value,
                dataType:'json',
                success:function(json){
                    var a = JSON.stringify(json);
                    var o = eval( "(" + a + ")" );
                    for(var j in o){

                        $("#city").append('<option  value='+o[j].id+' >'+o[j].area_name+'</option>');
                    }

                }

            });


            $.ajax({
                url:"${pageContext.request.contextPath}/area/showProvinceSchool.action?provinceId="+value,
                dataType:'json',
                success:function(json){
                    var a = JSON.stringify(json);
                    var o = eval( "(" + a + ")" );
                    for(var j in o){
                        $("#school").append('<option  value='+o[j].id+' >'+o[j].schoolName+'</option>');
                    }

                }

            });
        }
        function _city(value){
            $("#area_id").val(value);
            $("#county").find("option").remove();

            $("#school").find("option").remove();
            $("#county").append('<option value=-1 >--请选择！--</option>');
            $("#school").append('<option value=-1 >--请选择！--</option>');
            $.ajax({
                url:"${pageContext.request.contextPath}/area/showArea.action?parentId="+value,
                dataType:'json',
                success:function(json){
                    var a = JSON.stringify(json);
                    var o = eval( "(" + a + ")" );
                    for(var j in o){
                        $("#county").append('<option  value='+o[j].id+' >'+o[j].area_name+'</option>');
                    }

                }

            });


            $.ajax({
                url:"${pageContext.request.contextPath}/area/showCitySchool.action?cityId="+value,
                dataType:'json',
                success:function(json){
                    var a = JSON.stringify(json);
                    var o = eval( "(" + a + ")" );
                    for(var j in o){
                        $("#school").append('<option  value='+o[j].id+' >'+o[j].schoolName+'</option>');
                    }

                }

            });

        }
        function _county(value){
            $("#area_id").val(value);
            $("#school").find("option").remove();
            $("#school").append('<option value=-1 >--请选择！--</option>');
            $.ajax({
                url:"${pageContext.request.contextPath}/area/showSchool.action?countyId="+value,
                dataType:'json',
                success:function(json){
                    var a = JSON.stringify(json);
                    var o = eval( "(" + a + ")" );
                    for(var j in o){
                        $("#school").append('<option  value='+o[j].id+' >'+o[j].schoolName+'</option>');
                    }
                }
            });
        }
        function school1(value){
            $("#area_id_").val(value)
        }

	</script>

<body class="easyui-layout" data-options="fit:true">
<div data-options="region:'north',border:false,title:'过滤条件'" style="height: 130px;overflow: hidden;" align="left">
	<form id="searchForm" style="width: 100%;height: 100%;">
		<div style="height:100%;background-color: #efefef;padding-top: 20px;padding-left: 20px;">
			<div>
				<span>用户名：&nbsp;&nbsp;
					<input name="s_username" style="width:150px;" />
				</span>
				<span style="margin-left: 20px;">手机号：&nbsp;&nbsp;
					<input name="s_phone" style="width:150px;" />
				</span>

			</div>

			<div style="margin-top: 20px;">

				<span>
					<input type="hidden" id="area_id" name="area_id">
					省：&nbsp;&nbsp;
					<select name="province" id="province" onchange='_province(this.value)' style="height:21px;">
						<option   value="">--请选择省--</option>
						<c:forEach items="${provinceList}" var="pro">
							<option value="${pro.id}">${pro.area_name}</option>
						</c:forEach>
					</select>

				</span>

				<span style="margin-left: 20px;">
					市：&nbsp; &nbsp;
					<select name="city" id="city" onchange="_city(this.value)" style="height:21px;">

					<option   value="">--请选择市--</option>
						<c:forEach items="${cityList}" var="pro">
							<option value="${pro.id}">${pro.area_name}</option>
						</c:forEach>
					</select>
				</span>

				<span style="margin-left: 20px;">
					县：&nbsp;&nbsp;
					<select  name="county" id="county" onchange="_county(this.value)" style="height:21px;">
						<option   value="">--请选择县--</option>
						<c:forEach items="${countyList}" var="pro">
							<option value="${pro.id}">${pro.area_name}</option>
						</c:forEach>
					</select>

				</span>
				<span style="margin-left: 20px;">
				 学校：&nbsp; &nbsp;
					<select name="school_id" id="school"  onchange="school1(this.value)" style="height:21px;">
                        <option   value="">--请选择！--</option>
                    </select>
				    <a href="javascript:void(0);" class="easyui-linkbutton" onclick="_search();" style="margin-left: 20px;">查询</a>
					<a href="javascript:void(0);" class="easyui-linkbutton" onclick="cleanSearch();" style="margin-left: 20px;">清空</a>
				
				</span>
			</div>

		</div>
	</form>
</div>
<div data-options="region:'center',border:false" style="overflow: hidden;">
	<table id="datagrid"></table>
</div>

</body>
