<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<script type="text/javascript" charset="utf-8">
        var datagrid1;
        $(function(){
            datagrid1 = $('#datagrid2').datagrid({
                url : '${pageContext.request.contextPath}/back_certification/certificating.action?type=0&certificated=1',
                title : '社区管理员列表',
                iconCls : 'icon-save',
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
                    hidden: true
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
                    }
                    ] ],
                    onClickRow : function(rowIndex, rowData) {
            			var rows = $('#datagrid2').datagrid('getSelections');
            			if(rows.length>3){
            				$('#datagrid2').datagrid('unselectRow',rowIndex); 
            			}
            		}
            });

        });


        function _search() {
            datagrid1.datagrid('load', sy.serializeObject($('#searchForm')));
        }
        function certificated(id) {
            datagrid1.datagrid('load', {certificated:id});
        }
        function cleanSearch() {
            datagrid1.datagrid('load', {});
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

<div data-options="region:'center',border:false" style="height: 450px;">
	<table id="datagrid2"></table>
</div>
s