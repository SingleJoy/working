<%@ page language="java" pageEncoding="UTF-8"%>



<div class="modal" id="private-modal" tabindex="-1" role="dialog"  aria-hidden="true">
	<div class="modal-dialog ">

		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true" id="private-close">×</button>
				<h4 class="modal-title">发送私信</h4>
			</div>
			<div class="modal-body">
				<form id="message-create-form" class="form-horizontal" method="post" action="" >

					<div class="form-group">
						<div class="col-md-2 control-label"><label  class="required">收件人</label></div>
						<input type="hidden" id="private_message_id">
						<div class="col-md-8 controls">
							<input type="text"  required="required" class="form-control"  id="private_message_user">
							<i id="private_message_user_alert"></i>
							<div class="help-block" style="display:none;"></div></div>
					</div>

					<div class="form-group">
						<div class="col-md-2 control-label"><label  class="required">内容</label></div>
						<div class="col-md-8 controls">
							<textarea   required="required" class="form-control" rows="5"  id="private_message_content"></textarea>
							<i id="private_message_content_alert"></i>
							<div class="help-block" style="display:none;"></div>
						</div>
					</div>

					<div class="form-group">
						<div class="col-md-offset-2 col-md-8 controls">
							<input type="hidden"   value="">
							<button class="btn btn-primary" type="button"  id="send_private_message">发送</button>
						</div>
					</div>
				</form>

			</div>
		</div>
	</div>
</div>