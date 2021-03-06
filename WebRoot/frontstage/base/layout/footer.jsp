<%@ page language="java" pageEncoding="UTF-8"%>




<footer class="cn-footer" >
	<div class="copyright">
		<div class="container">
			<a href="#" target="_blank">北京百年树人远程教育有限公司</a>
			©1998-2017
			<span class="mlm mrm">｜</span>
			<a class="mlm" href="#" target="_blank">服务教育，追求卓越</a>

			<div class="mts"></div>
		</div>
	</div>
</footer>

<div class="modal" id="recommended_modal"  role="dialog" aria-hidden="true">
	<div class="modal-dialog  modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title"> 课例推荐</h4>
			</div>
			<div class="modal-body">
				<form id="recommendedForm" class="form-horizontal lesson-form lesson-form-video" action="${pageContext.request.contextPath}/workshop/recommended.action" method="post">
					<input type="hidden"  class="form-control" name="source_id" value="" id="recommended_source_id">
					<input type="hidden"  class="form-control" name="source_type" value="" id="recommended_source_type">

					<div class="form-group">
						<div class="col-md-2 control-label">
							<label class="style1">有效日期</label>
						</div>
						<div class="col-md-9 controls">
							<div class="row">
								<div class="col-md-4">
									<input name="valid_time" class="form-control width-input width-input-large" value="" data-widget-cid="widget-12"  type="text" >
								</div>
							</div>
						</div>
					</div>




					<div class="form-group">
						<div class="col-md-2 control-label">
							<label class="style1">序号</label>
						</div>
						<div class="col-md-9 controls">
							<div class="row">
								<div class="col-md-4">
									<input class="form-control" id="examSeq" type="text" name="seq" />
								</div>
							</div>
						</div>
					</div>
				</form>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-link" data-dismiss="modal">取消</button>
				<button type="button" class="btn btn-primary" id="submit_btn">保存</button>

			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
    var now = new Date();
    $("[name=valid_time]").datetimepicker({
        autoclose: true,
        language:'zh-CN',
        format: 'yyyy-mm-dd',
        minView: "month",//设置只显示到月份
        forceParse:false,

    });
    $('[name=valid_time]').datetimepicker('setStartDate', now);
    $('[name=valid_time]').datetimepicker().on('hide', function(ev){
        $("#recommendedForm").data('bootstrapValidator').resetForm(); //重置验证
    });

    $(document).ready(function() {
        $('#recommendedForm').bootstrapValidator({
            message: '此值无效',

            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                valid_time: {
                    message: '有效日期',
                    validators: {
                        notEmpty: {
                            message: '有效日期不能为空'
                        },
                        regexp: {/* 只需加此键值对，包含正则表达式，和提示 */
                            regexp: /^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$/,
                            message: '时间格式错误'
                        },
                    }
                },
                seq:{
                    message: '序号',
                    validators: {
                        notEmpty: {
                            message: '序号不能为空'
                        },
                        regexp: {/* 只需加此键值对，包含正则表达式，和提示 */
                            regexp: /^[0-9]*[1-9][0-9]*$/,
                            message: '序号只能是正整数'
                        },
                    },

                },

            }
        }).on('success.form.bv', function(e) {


            if(e.type){//验证成功
                //document.getElementById('workshopForm').submit();

                e.preventDefault();
                $.ajax({
                    url : $('#recommendedForm').attr("action"),
                    data:$('#recommendedForm').serialize() ,
                    success : function(json) {

                        location.replace(location.href);

                    }
                });
            }else{
                // 防止表单提交
                e.preventDefault();
            }
        });

    });
    $("#submit_btn").click(function () {
        $('#recommendedForm').submit();
    });

    function unrecommended(source_id,source_type){

        $.ajax({
            url : "${pageContext.request.contextPath}/workshop/unrecommended.action",
            data:{
                source_id:source_id,
                source_type:source_type,
            } ,
            success : function(json) {

                location.replace(location.href);

            }
        });
    }

</script>
