<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/backstage/base/inc.jsp"></jsp:include>

<body>
<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" id="aaa">版本可见编辑</a>
<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" id="redo">展开</a>
<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-undo'" id="undo">折叠</a>
<div id="tt"></div>


<script type="text/javascript">

    $(function() {

        var authIds =$("#tt");
        var old="";
        authIds.tree({
            lines : true,
            url : '${pageContext.request.contextPath}/back_subject/toList.action',
            loadFilter: function(data){
                return data;
            },
            checkbox : true,
            multiple : true,
            animate:true,
            onLoadSuccess:function(node,data){

                $(".tree-checkbox").parent().find(".tree-checkbox1").each(function(){
                    old+=$(this).parent().attr('node-id')+",";

                });

            }
        });

        $("#redo").click(function(){
            authIds.tree('expandAll');

        });
        $("#undo").click(function(){
            authIds.tree('collapseAll');

        });


        $("#aaa").click(function(){

            var c="";
            $(".tree-checkbox").parent().find(".tree-checkbox1").each(function(){
                c+=$(this).parent().attr('node-id')+",";

            });

            $.ajax({
                url : '${pageContext.request.contextPath}/back_subject/edit.action',
                data : {
                    ids : c,
                    olds:old
                },
                dataType : 'JSON',
                success : function(r) {
                    location.replace(location.href);
                    parent.sy.messagerShow({
                        msg :'修改成功',
                        title : '提示'
                    });
                }
            });

        });

    });

</script>
</body>
