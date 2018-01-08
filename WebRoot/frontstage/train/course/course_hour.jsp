<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/frontstage/base/layout/header.jsp"></jsp:include>


<link href="${pageContext.request.contextPath}/frontstage/css/course-info.css" rel="stylesheet" type="text/css">

<link href="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/webuploader/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/train/course_hour.js?v=9"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/jquery-ui.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/wangEditor/wangEditor.min.js"></script>
<%-- 暂时注释 直播课程编辑框依赖此js
<script type="text/javascript" src="${pageContext.request.contextPath}/frontstage/js/JMEditor/jmeditor/JMEditor.js"></script>
--%>
<div class="cn-wrap">

	<div id="content-container" class="container">
		<jsp:include page="course_header.jsp"></jsp:include>

		<div class="row">
			<jsp:include page="course_left.jsp"></jsp:include>
			<div class="col-md-9">

				<div class="panel panel-default panel-col lesson-manage-panel">

					<div class="panel-heading">
						<input type="hidden" id="isSon" value="1"/>

						<div class="pull-right">
							<button id="bt_add_chapter" class="add_chapter add_chapter_popup btn btn-info btn-sm" type="button"><i class="glyphicon glyphicon-plus" ></i>章节</button>

							<c:if test="${courseView.type!=2}">
								<button type="button" onclick="addHour(${courseView.id},-1);" data-toggle="modal" class="add_class_hour_button btn btn-info btn-sm" <c:if test="${empty chapterList }">title="请先建章节" disabled="disabled"</c:if>><i class="glyphicon glyphicon-plus"></i>课时</button>
							</c:if>
							<c:if test="${courseView.type==2}">
								<button type="button" data-toggle="modal" data-target="#modal1" class="add_class_hour_button btn btn-info btn-sm" <c:if test="${empty chapterList }">title="请先建章节" disabled="disabled"</c:if>><i class="glyphicon glyphicon-plus"></i>直播课时</button>
							</c:if>
							<button type="button" data-toggle="modal"  onclick="openHour('add_paper',null,null);" class="add_class_hour_button btn btn-info btn-sm" <c:if test="${empty chapterList }">title="请先建章节" disabled="disabled"</c:if>><i class="glyphicon glyphicon-plus"></i>试卷</button>
							<button type="button" data-toggle="modal"  onclick="openHour('add_discuss',null,null);"  class="add_class_hour_button btn btn-info btn-sm" <c:if test="${empty chapterList }">title="请先建章节" disabled="disabled"</c:if>><i class="glyphicon glyphicon-plus"></i>研讨</button>
							<button type="button" onclick="addTask(${courseView.id},${courseView.sign},${courseView.flag});" class=" btn btn-info btn-sm" <c:if test="${empty chapterList }">title="请先建章节" disabled="disabled"</c:if>><i class="glyphicon glyphicon-plus"></i>作业</button>
						</div>
						课时管理
					</div>

					<div class="panel-body">
						<ol  class="page_content_list" id="foo">
							<c:if test="${empty chapterList}">
								<div class="empty">暂无数据</div>
							</c:if>
							<c:forEach items="${chapterList}" var="chapter" >

								<!--章节-->
								<li class="chapter_item">
									<b class="line"></b>
									<div class="page_list page_section_01">
										<input  type="hidden" name="id" id="${chapter.id}">
										第<span>${chapter.hour_seq }</span>章&nbsp;:<span title="${chapter.hour_title}">${chapter.hour_title}</span>

										<div class="add_page_style add_page_add">
											<button type="button" title="添加"><i class="glyphicon glyphicon-plus-sign"></i></button>
										</div>
										<ul style="display: none;margin-left:400px;" class="add_more_ul">
											<li class="add_class_hour_button"><a onclick="addHour(${courseView.id},${chapter.id });"  href="javascript:void(0);"><i class="glyphicon glyphicon-plus" style="padding-left: 10px;"></i>添加&nbsp;课时</a></li>
											<li><a  data-toggle="modal"  onclick="openHour('add_paper',${courseView.id},${chapter.id });" class="add_class_hour_button "><i class="glyphicon glyphicon-plus" style="padding-left: 10px;"></i>添加&nbsp;试卷</a></li>
											<li><a  data-toggle="modal"  onclick="openHour('add_discuss',${courseView.id},${chapter.id });"  ><i class="glyphicon glyphicon-plus" style="padding-left: 10px;"></i>添加&nbsp;讨论</a></li>
											<li><a  onclick="addTask(${courseView.id},${courseView.sign},${courseView.flag},${chapter.id});" ><i class="glyphicon glyphicon-plus" style="padding-left: 10px;"></i>添加&nbsp;作业</a></li>

										</ul>

										<div class="add_page_style add_page_edit " onclick="doEdit(${chapter.id},1);"><button type="button" title="编辑"><i class="glyphicon glyphicon-edit"></i></button></div>
										<div class="add_page_style add_page_delete">
											<button type="button" onclick="doDeleteHour(${chapter.id},1,${courseView.id },${courseView.sign });" title="删除"><i class="glyphicon glyphicon-trash"></i></button>
										</div>

									</div>
									<br/>
								</li>
								<c:forEach items="${hourList}" var="hour" varStatus="status">
									<!--课时-->
									<li class="hourItem">

										<c:if test="${chapter.id==hour.parent_id}">
											<b class="line_02"></b>
											<b class="line_03"></b>
											<!--  -->
											<div class="page_list page_section_03">
												<input  type="hidden" name="id" value="${hour.id}">
												<span class="glyphicon glyphicon-resize-vertical sort-handle sort" ></span>
												<span id="hour_seq_${hour.id}">${hour.hour_seq}</span>
												<span>
											<c:if test="${hour.attribute_type==2}">课时</c:if><c:if test="${hour.attribute_type==0}">试卷</c:if>
											<c:if test="${hour.attribute_type==3}">讨论</c:if><c:if test="${hour.attribute_type==4}">作业</c:if>
												<c:if test="${hour.attribute_type==5}">直播课时</c:if>
											&nbsp;
											<c:if test="${hour.attribute_type==5}">${status.count }</c:if> </span>&nbsp;:
												<span title="${hour.hour_title}">
							            		<c:if test="${hour.is_free == 0}"><span style="background-color:#a94442;color:#fff;">免费</span></c:if>
							            		${hour.hour_title}
							            		<c:if test="${hour.attribute_type==2 && (!empty hour.second && !empty hour.second) }"> <span>${hour.minute}:${hour.second}</span></c:if>
							            	</span>
												<div class="add_page_edit_01"><a href="javascript:void(0);"  onclick="doEdit(${hour.id},${hour.attribute_type});"><span class="es-icon es-icon-edit prs"></span>编辑</a></div>
												<%--<div class="add_page_preview" ><a href="javascript:void(0);" onclick="doDeleteHour(${hour.id},${hour.attribute_type},${courseView.id },${courseView.sign });"><span class="es-icon es-icon-visibility prs"></span>删除</a></div>--%>

													<div class="add_page_preview" >
														<a href="javascript:void(0);" onclick="doPreview(${hour.id},${courseView.id });">
														<span class="es-icon es-icon-visibility prs"></span>预览
														</a>
													</div>

													<div class="add_page_read_more">
														<a class="dropdown-toggle dropdown-more"  href="javascript:void(0);">
															<i class="es-icon es-icon-keyboardarrowdown" style="margin-right:3px"></i>
															更多</a>
													</div>

													<ul class="add_more_ul" style="display: none;">

													<c:if test="${hour.attribute_type==2}">
														<li class="add_data add_data_content">
														<a href="#add_data" data-toggle="modal" onclick="addHourFile(${hour.id},${courseView.id },${courseView.sign });">添加资料</a>
													</li>
													</c:if>

                                                    <li >
                                                        <a href="javascript:void(0);" onclick="doDeleteHour(${hour.id},${hour.attribute_type},${courseView.id },${courseView.sign });">删除</a>
                                                    </li>
                                                </ul>

											</div>
										</c:if>
									</li>
								</c:forEach>

							</c:forEach>
						</ol>
					</div>
				</div>
			</div>

		</div>
	</div>
	<jsp:include page="/frontstage/base/layout/footer.jsp"></jsp:include>

</div>

<!--添加课时弹窗-->
<c:if test="${courseView.type!=2}">
	<div id="add_hour" class="modal" style="display: none;" aria-hidden="true">
		<div class="modal-dialog  modal-lg">

			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h4 class="modal-title">添加课时</h4>
				</div>

				<div class="modal-body">
					<form class="form-horizontal" id="hourAdd" action="${pageContext.request.contextPath}/course_hour/save_course_hour.action" method="post" >
						<input type="hidden" name="course_id" value="${courseView.id}"/>
						<input type="hidden" name="sign" value="${courseView.sign}"/>
						<input type="hidden" name="attribute_type" value="2"/>
						<input type="hidden" id="curr_ch" name="id" value=""/>
							<%--
                            <input type="hidden" name="file_source" id="file_source" value="0"/>
                            <input type="hidden" name="course_file_id" id="course_file_id" value=""  >
                            <input type="hidden" name="course_file_isuse" id="course_file_isuse" value=""  >
                            --%>

						<div class="form-group">
							<div class="col-md-2 control-label">
								<label>类型</label>
							</div>
							<div class="col-md-9 controls">
								<div class="radios" id="resource_type">
									<label><input type="radio" name="hour_type" value="0" checked="checked" onclick="doUpload(${courseView.id},0)"> 视频</label>
									<label><input type="radio" name="hour_type" value="1" onclick="doUpload(${courseView.id},1)"> 文档</label>
									<label><input type="radio" name="hour_type" value="2" onclick="doUpload(${courseView.id},2)"> 音频</label>
									<label><input type="radio" name="hour_type" value="3"> 图文</label>
								</div>
							</div>
						</div>

						<div class="form-group">
							<div class="col-md-2 control-label">
								<label >标题</label>
							</div>
							<div class="col-md-9 controls">
								<div class="row">
									<div class="col-md-10">
										<input  id="hour_title" name="hour_title" class="form-control" type="text" >
									</div>

									<div class="col-md-2">
										<div class="checkbox">
											<label>
													<%--
                                                    <input id="free" type="checkbox" onclick="doChecked();"> 免费课时
                                                    --%>
												<input type="hidden" id="is_free" name="is_free" value="1"/>
											</label>
										</div>
									</div>
								</div>
								<div id="check_hour_title_msg " class="help-block text-danger title_val" style="display:none;">请输入标题(标题长度不得超过18个字)</div>
							</div>

						</div>


							<%--上传视频--%>
						<div class="resource_type">
							<div class="form-group" >

								<div class="controls text-center">
									<div style="display:none;" class="file-chooser-bar show_select_resource"></div>
									<input type="hidden" name="file_source" id="file_source" value="0"/>
									<input type="hidden" name="course_file_id" id="course_file_id" value=""  >
									<input type="hidden" name="course_file_isuse" id="course_file_isuse" value=""  >
								</div>
							</div>
							<div class="form-group" >
								<div class="col-md-2 control-label for-video-type"><label>视频</label></div>
								<div class="col-md-10 controls">

									<div id="selectVideo" class="file-chooser-main" style="padding-top: 4px;">
											<%--上传视频--%>
										<ul  class="nav nav-pills nav-pills-sm mbs file-chooser-tabs">
											<li class="active">
												<a  href="javascript:void(0);" data-toggle="tab" class="file-chooser-tabs-name">上传视频</a>
											</li>
											<li>
												<a href="javascript:void(0);" data-toggle="tab">从课程文件中选择</a>
											</li>
											<li>
												<a href="javascript:void(0);" data-toggle="tab">从教学资料库中选择</a>
											</li>
										</ul>

									</div>

								</div>
							</div>

							<div id="fileList" class="form-group clearfix upload_video video_source col-md-12">
								<div class="file col-md-offset-5 webuploader-container upload_video_tab uploadFile">
									<div id="uploadFile" class="webuploader-pick">
										<div class="text-center">
											<button class="btn btn-default btn-lg" type="button">
												<i class="glyphicon glyphicon-plus"></i>上传视频
											</button>
										</div>
									</div>
								</div>
							</div>

							<div class="upload_video_tab video_source" style="display: none;" >
								<c:if test="${empty courseVedioFileList}" >
									<div class="empty">暂无视频文件，请先上传。</div>
								</c:if>
								<div class="course_file_choose col-md-10 col-md-offset-1">
									<c:if test="${!empty courseVedioFileList}">
										<ul class="course_select_ul">
											<c:forEach items="${courseVedioFileList }" var="vedioFile">
												<li onclick="doCourseFile('${vedioFile.name}',${vedioFile.id},0,0,${vedioFile.is_use},0);">
													<span class="file_name" title="${vedioFile.name}">${fn:substring(vedioFile.name,0,10)}</span>
													<span class="file_size">${vedioFile.size}</span>
													<span class="file_time"><fmt:formatDate value="${vedioFile.create_time}" type="date" pattern="yyyy-MM-dd HH:mm"/></span>
												</li>
											</c:forEach>
										</ul>
									</c:if>
								</div>
							</div>

								<%--从全部文件列表选择--%>
							<div class="import_network_video upload_video_tab " style="display: none;">
								<c:if test="${empty vedioFileList}">
									<div class="empty">暂无视频文件，请先上传。</div>
								</c:if>
								<div class="course_file_choose col-md-10 col-md-offset-1" >
									<c:if test="${!empty vedioFileList}">

										<ul class="course_select_ul" >
											<c:forEach items="${vedioFileList }" var="vedioFileBase">
												<li onclick="doCourseFile('${vedioFileBase.name}',${vedioFileBase.id},1,0,${vedioFileBase.is_use},0);">
													<span class="file_name" title="${vedioFileBase.name}">${fn:substring(vedioFileBase.name,0,10)}</span>
													<span class="file_size">${vedioFileBase.size}</span>
													<span class="file_time"><fmt:formatDate value="${vedioFileBase.create_time}" type="date" pattern="yyyy-MM-dd HH:mm"/></span>
												</li>
											</c:forEach>
										</ul>
									</c:if>
								</div>
							</div>
						</div>

							<%--上传文档--%>
						<div class="resource_type" style="display: none;">
							<div class="form-group" >

								<div class="controls text-center" >
									<div style="display:none;" class="file-chooser-bar show_select_resource"></div>
									<input type="hidden" name="file_source" id="file_source1" value="0"/>
									<input type="hidden" name="course_file_id" id="course_file_id1" value=""  >
									<input type="hidden" name="course_file_isuse" id="course_file_isuse1" value=""  >
								</div>
							</div>
							<div class="form-group" >
								<div class="col-md-2 control-label for-video-type"><label>文档</label></div>
								<div class="col-md-10 controls">
									<div  style="display:none;" class="file-chooser-bar"></div>

									<div  class="file-chooser-main" style="padding-top: 4px;">
											<%--上传文档--%>
										<ul  class="nav nav-pills nav-pills-sm mbs file-chooser-tabs">
											<li class="active">
												<a  href="javascript:void(0);" data-toggle="tab" class="file-chooser-tabs-name">上传文档</a>
											</li>
											<li>
												<a href="javascript:void(0);" data-toggle="tab">从课程文件中选择</a>
											</li>
											<li>
												<a href="javascript:void(0);" data-toggle="tab">从教学资料库中选择</a>
											</li>
										</ul>

									</div>


								</div>
							</div>

							<div id="fileList1" class="file webuploader-container upload_video_tab text-center">
								<div class="webuploader-pick" id="uploadFile1">
									<div class="text-center">
										<button class="btn btn-default btn-lg" type="button">
											<i class="glyphicon glyphicon-plus"></i>上传文档
										</button>
									</div>
								</div>
							</div>

							<div class="upload_video_tab video_source" style="display: none;" >
								<c:if test="${empty courseDocFileList}" >
									<div class="empty">暂无文档文件，请先上传。</div>
								</c:if>
								<div class="course_file_choose col-md-10 col-md-offset-1">
									<c:if test="${!empty courseDocFileList}">
										<ul class="course_select_ul">
											<c:forEach items="${courseDocFileList }" var="docFile">
												<li onclick="doCourseFile('${docFile.name}',${docFile.id},0,0,${docFile.is_use},1);">
													<span class="file_name" title="${docFile.name}">${fn:substring(docFile.name,0,10)}</span>
													<span class="file_size">${docFile.size}</span>
													<span class="file_time"><fmt:formatDate value="${docFile.create_time}" type="date" pattern="yyyy-MM-dd HH:mm"/></span>
												</li>
											</c:forEach>
										</ul>
									</c:if>
								</div>
							</div>

								<%--从全部文件列表选择--%>
							<div class="import_network_video upload_video_tab " style="display: none;">
								<c:if test="${empty docFileList}">
									<div class="empty">暂无文档文件，请先上传。</div>
								</c:if>
								<div class="course_file_choose col-md-10 col-md-offset-1" >
									<c:if test="${!empty docFileList}">

										<ul class="course_select_ul" >
											<c:forEach items="${docFileList }" var="docFileBase">
												<li onclick="doCourseFile('${docFileBase.name}',${docFileBase.id},1,0,${docFileBase.is_use},1);">
													<span class="file_name" title="${docFileBase.name}">${fn:substring(docFileBase.name,0,10)}</span>
													<span class="file_size">${docFileBase.size}</span>
													<span class="file_time"><fmt:formatDate value="${docFileBase.create_time}" type="date" pattern="yyyy-MM-dd HH:mm"/></span>
												</li>
											</c:forEach>
										</ul>
									</c:if>
								</div>
							</div>
						</div>

							<%--上传音频--%>
						<div class="resource_type" style="display: none;">
							<div class="form-group" >

								<div class="controls text-center">
									<div style="display:none;" class="file-chooser-bar show_select_resource"></div>
									<input type="hidden" name="file_source" id="file_source2" value="0"/>
									<input type="hidden" name="course_file_id" id="course_file_id2" value=""  >
									<input type="hidden" name="course_file_isuse" id="course_file_isuse2" value=""  >
								</div>
							</div>
							<div class="form-group" >
								<div class="col-md-2 control-label for-video-type"><label>音频</label></div>
								<div class="col-md-10 controls">
									<div  style="display:none;" class="file-chooser-bar"></div>

									<div  class="file-chooser-main" style="padding-top: 4px;">
											<%--上传音频--%>
										<ul  class="nav nav-pills nav-pills-sm mbs file-chooser-tabs">
											<li class="active">
												<a  href="javascript:void(0);" data-toggle="tab" class="file-chooser-tabs-name">上传音频</a>
											</li>
											<li>
												<a href="javascript:void(0);" data-toggle="tab">从课程文件中选择</a>
											</li>
											<li>
												<a href="javascript:void(0);" data-toggle="tab">从教学资料库中选择</a>
											</li>
										</ul>

									</div>


								</div>
							</div>


							<div id="fileList2" class="file webuploader-container upload_video_tab text-center">
								<div id="uploadFile2" class="webuploader-pick">
									<div class="text-center">
										<button class="btn btn-default btn-lg" type="button">
											<i class="glyphicon glyphicon-plus"></i>上传音频
										</button>
									</div>
								</div>

							</div>

							<div class="upload_video_tab video_source" style="display: none;" >
								<c:if test="${empty courseAudioFileList}" >
									<div class="empty">暂无音频文件，请先上传。</div>
								</c:if>
								<div class="course_file_choose col-md-10 col-md-offset-1">
									<c:if test="${!empty courseAudioFileList}">
										<ul class="course_select_ul">

											<c:forEach items="${courseAudioFileList }" var="audioFile">
												<li onclick="doCourseFile('${audioFile.name}',${audioFile.id},0,0,${audioFile.is_use},2);">
													<span class="file_name" title="${audioFile.name}">${fn:substring(audioFile.name,0,10)}</span>
													<span class="file_size">${audioFile.size}</span>
													<span class="file_time"><fmt:formatDate value="${audioFile.create_time}" type="date" pattern="yyyy-MM-dd HH:mm"/></span>
												</li>
											</c:forEach>

										</ul>
									</c:if>
								</div>
							</div>

								<%--从全部文件列表选择--%>
							<div class="import_network_video upload_video_tab " style="display: none;">
								<c:if test="${empty audioFileList}">
									<div class="empty">暂无音频文件，请先上传。</div>
								</c:if>
								<div class="course_file_choose col-md-10 col-md-offset-1" >
									<c:if test="${!empty audioFileList}">

										<ul class="course_select_ul" >
											<c:forEach items="${audioFileList }" var="audioFileBase">
												<li onclick="doCourseFile('${audioFileBase.name}',${audioFileBase.id},1,0,${audioFileBase.is_use},2);">
													<span class="file_name" title="${audioFileBase.name}">${fn:substring(audioFileBase.name,0,10)}</span>
													<span class="file_size">${audioFileBase.size}</span>
													<span class="file_time"><fmt:formatDate value="${audioFileBase.create_time}" type="date" pattern="yyyy-MM-dd HH:mm"/></span>
												</li>
											</c:forEach>
										</ul>
									</c:if>
								</div>
							</div>
						</div>

							<%--上传图文--%>
						<div class="resource_type" style="display: none;">
							<div class="form-group">
								<div class="col-md-2 control-label"><label>图文</label></div>
								<div class="col-md-8 controls">
									<div id="weditor" style="width:620px;">
									</div>
									<%-- 
									<input type="hidden" name="img_txt" id="img_txt"/>
									--%>
									<textarea style="display: none;" name="img_txt" id="img_txt">									
									</textarea>
									<div class="text-warning help-block" id="img_txt_vail" style="display: none;">图文内容不能为空</div>
								</div>
								<script type="text/javascript">
                                    var E = window.wangEditor;
                                    var weditor = new E("#weditor");
                                    //保存图片到服务器
                                    weditor.customConfig.uploadImgServer = "${pageContext.request.contextPath}/upload_file/upload_resource.action?source_id=${courseView.id}&source_type=0";
                                    //限制图片大小
                                    weditor.customConfig.uploadImgMaxSize = 3*1024*1024;
                                    //图片上传上限
                                    weditor.customConfig.uploadImgMaxLength = 1;
                                    //隐藏"网络图片"选项
                                    weditor.customConfig.showLinkImg = false;
                                    weditor.create();
								</script>
							</div>
						</div>

						<div class="form-group clearfix" >
							<label class="col-md-2 control-label">所属章节</label>
							<div class="col-md-4 controls">

								<select id="chapter_parent_id" name="parent_id" onchange="doSeq(this.value,${courseView.id});" class="form-control width-input width-input-large">
									<option value="0">--请选择所属章节--</option>
									<c:forEach items="${chapterList }" var="chapter">
										<option value="${chapter.id}">${chapter.hour_title }</option>
									</c:forEach>
								</select><br/>


								<div id="section_val" class="help-block" style="display:none;"><span class="text-danger">请选择所属章节</span></div>

							</div>
						</div>
						<div class="form-group">

							<div class="col-md-3 controls">
								<input  class="form-control" name="hour_seq" type="hidden" >
							</div>
						</div>

					</form>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-link" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" data-toggle="form-submit" onclick="doSubmitHour();">保存</button>
				</div>

			</div>
		</div>
	</div>
</c:if>

<!--添加章节-->
<div id="add_chapter" class="modal" style="display: none;" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title" id="add_or_edit_chapter">编辑章节</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" id="chapterAdd" action="${pageContext.request.contextPath}/course_hour/save_course_hour.action" method="post" >
					<input type="hidden" name="course_id" value="${courseView.id}"/>
					<input type="hidden" name="sign" value="${courseView.sign}"/>
					<input type="hidden" name="attribute_type" value="1"/>
					<input type="hidden" name="parent_id" value="0"/>
					<input type="hidden" name="id" value="" id="chapter_id"/>

					<div class="form-group">
						<div class="col-md-2 control-label"><label>章节序号</label></div>
						<div class="col-md-6 controls">
							<input class="form-control" name="hour_seq" type="text" >
							<%--
							<div class="help-block" style="display: none;">
								<span class="text-danger">请输入章节序号</span>
							</div>
							--%>
							<div class="help-block" style="display: none;" id="chapter_sque">
								<span class="text-danger">请输入合法章节序号(由数字组成)</span>
							</div>
						</div>

					</div>

					<div class="form-group">
						<div class="col-md-2 control-label"><label>章节标题</label></div>
						<div class="col-md-6 controls">
							<input class="form-control"  id="chapter_title" name="hour_title"  type="text" >
							<div class="help-block title_val" style="display: none;">
								<span class="text-danger">请输入章节标题(章节标题长度不得超过18个字)</span>
							</div>
						</div>

					</div>

				</form>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-link" data-dismiss="modal">取消</button>
				<button type="button" onclick="doSubmitCha();" class="btn btn-primary" data-toggle="form-submit" >保存</button>

			</div>

		</div>
	</div>
</div>

<!--课时编辑-->
<div  id="course_hour_edit"  aria-hidden="true" class="modal" style="display: none;">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>

				<h4 class="modal-title">编辑课时</h4>
			</div>

			<div class="modal-body">

				<form id="hourEdit" action="${pageContext.request.contextPath}/course_hour/save_course_hour.action" method="post" class="form-horizontal">
					<input type="hidden" name="course_id" value="${courseView.id}"/>
					<input type="hidden" name="sign" value="${courseView.sign}"/>
					<input type="hidden" name="attribute_type" value="2"/>
					<input type="hidden" name="id" value=""/>

					<div class="form-group ">
						<div class="col-md-2 control-label">标题</div>
						<div class="col-md-9 controls">
							<div class="row">
								<div class="col-md-10">
									<input type="text" id="hour_title_" onblur="validate_();" name="hour_title" value="" class="form-control">
								</div>
								<div class="col-md-2">
									<div class="checkbox">
										<label>
											<%--
											<input type="checkbox" id="free_" onclick="doChecked();" >
											免费课时
											--%>
											<input type="hidden" id="is_free_" name="is_free" value="1"/>
										</label>
									</div>
								</div>
							</div>
							<div class="title_val text-danger help-block" style="display:none" >请输入标题(标题长度不得超过18个字)</div>

						</div>
					</div>


					<%--<div class="form-group ">--%>
					<%--<div class="col-md-2 control-label">摘要</div>--%>
					<%--<div class="col-md-9 ">--%>
					<%--<textarea id="remarks_" name="remarks" class="form-control"></textarea>--%>
					<%--</div>--%>
					<%--</div>--%>


					<div class="form-group" style="margin-top: 30px;">
						<div class="col-md-2 control-label "><label>所属章节</label></div>
						<div class="col-md-4 ">
							<select id="chapter_parent_id_" name="parent_id" onchange="doSeq(this.value,${courseView.id});" class="form-control width-input width-input-large">
								<option value="0">请选择所属章节</option>
								<c:forEach items="${chapterList}" var="chapter">
									<option value="${chapter.id}">${chapter.hour_title }</option>
								</c:forEach>
							</select>
							<div class="section_val text-danger"  style="display:none">请选择所属节</div>
						</div>
					</div>


					<div class="form-group" >
						<%--
						<div class="col-md-2 control-label "><label>序号</label></div>
						--%>
						<div class="col-md-4 ">
							<input type="hidden" name="hour_seq" value="" class="form-control">
						</div>
					</div>
				</form>
			</div>


			<div class="modal-footer">
				<a href="javascript:void(0);" class="btn btn-link" data-dismiss="modal">取消</a>
				<button type="button" onclick="doEditHour();" class="btn btn-info">保存</button>

			</div>

		</div>
	</div>
</div>

<%--修改后的添加资料 --%>
<div id="add_data" class="modal in" aria-hidden="false" style="display:none;">
	<div class="modal-dialog  modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title">添加资料</h4>
			</div>
			<div class="modal-body">

				<form  class="form-horizontal" id="hourFileAdd" action="${pageContext.request.contextPath}/course_hour_file/save_hour_file.action" method="post">
					<input type="hidden" name="courseId" value="${courseView.id}"/>
					<input type="hidden" name="sign" value="${courseView.sign}"/>
					<input type="hidden" id="hourId" name="course_hour_id" value=""/>
					<input type="hidden" id="courseFileId" name="course_file_id" value=""/>
					<input type="hidden" id="courseFileName" />
					<div class="form-group">
						<div class="col-md-10 col-md-offset-1  controls">
							<ul id="content" class="list-group" >

							</ul>
						</div>
					</div>

					<div class="form-group">
						<div class="col-md-10 col-md-offset-1 controls">

							<div class="file-chooser">

								<div class="file-chooser-main">

									<ul id="ziliao_ul" class="nav nav-pills nav-pills-sm mbs file-chooser-tabs">
										<li class="active">
											<a class="file-chooser-uploader-tab" href="javascript:void(0);" data-toggle="tab">上传文件</a>
										</li>
										<li><a href="javascript:void(0);" data-toggle="tab">从教学资料库中选择</a>
										</li>

									</ul>

									<div class="tab-content">

										<div class="tab-pane active" >

											<div class="balloon-uploader"  >
												<div class="balloon-uploader-heading">上传文件</div>

												<div class="balloon-uploader-body">

													<div class="balloon-filelist">
														<div class="balloon-filelist-heading">
															<div class="file-name">文件名</div>
															<!-- <div class="file-size">大小</div>
															<div class="file-status">状态</div> -->
															<div class="file-manage">操作</div>
														</div>
														<div id="hourFileList" class="upload_data_content">
															<div id="uploadHourFile" class="file text-center" style="margin: 40px auto;">
																<button type="button" class="btn btn-default">
																	<i class="glyphicon glyphicon-plus"></i>添加文件
																</button>
															</div>
														</div>

														<div id="file_msg" class="file-chooser-bar" style="margin-left: 20px;margin-top: 10px;display: none;">

														</div>
													</div>

												</div>
											</div>
										</div>

										<div class="tab-pane" >

											<div data-role="file-browser"  class="file-browser">

												<div  class="file-browser-list-container">
													<c:if test="${empty fileList}">
														<div class="empty">暂无资料，请先上传。</div>
													</c:if>
													<ul id="ziliaoku" class="file-browser-list">
														<c:forEach items="${fileList }" var="fileBase">
															<li class="file-browser-item clearfix" onclick="doCourseFile('${fileBase.name}',${fileBase.id},1,1);">
																<span class="filename">${fileBase.name}</span>
																<span class="filesize">${fileBase.size}</span>
																<span class="filetime"><fmt:formatDate value="${fileBase.create_time}" type="date" pattern="yyyy-MM-dd HH:mm"/></span>
															</li>
														</c:forEach>
													</ul>
												</div>
											</div>
										</div>

									</div>

								</div>

							</div>

						</div>
					</div>




				</form>



			</div>
			<div class="modal-footer">

				<button type="button" class="btn btn-link" data-dismiss="modal">取消</button>
				<button class="btn btn-primary"  type="button" onclick="doAddFile();">添加</button>

			</div>
		</div>
	</div>
</div>

<!-- 添加研讨 -->
<div class="modal" id="add_discuss"  role="dialog" aria-hidden="true" >
	<div class="modal-dialog  modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
				</button>
				<h4 class="modal-title">添加主题研讨</h4>
			</div>
			<div class="modal-body">
				<form id="courseDiscuss" class="form-horizontal lesson-form lesson-form-video" action="${pageContext.request.contextPath}/course_hour/save_course_hour.action" method="post">
					<input type="hidden" name="course_id" value="${courseView.id}"/>
					<input type="hidden" name="sign" value="${courseView.sign}"/>
					<input type="hidden" name="attribute_type" value="3"/>
					<input type="hidden" name="id" value=""/>
					<div class="form-group" id="discuss_input">
						<%--输入框内容为空添加,添加class位has-error--%>
						<div class="col-md-2 control-label"><label>标题</label></div>
						<div class="col-md-9 controls">
							<div class="row">
								<div class="col-md-10">
									<input class="form-control" id="discussTitle" type="text" name="hour_title" >
								</div>
							</div>
							<div class="help-block title_val" style="display: none;">
								<span class="text-danger">请输入标题(标题长度不得超过18个字)</span>
							</div>
						</div>
					</div>
					<div class="form-group">

						<div class="col-md-2 control-label"><label class="style1">内容描述</label></div>
						<div class="col-md-9 controls">
							<textarea class="form-control"  id="discussRemarks" name="remarks"></textarea>
						</div>
					</div>
					<div class="form-group" id="fre_input">
						<div class="col-md-2 control-label"><label>参与次数</label></div>
						<div class="col-md-9 controls">
							<input class="form-control width-input width-input-small" id="discussFre" name="frequency" type="text" >次
							<div class="help-block" style="display: none;">
								<span class="text-danger fre_input">请输入参与次数(大于零的正整数)</span>
							</div>
						</div>
					</div>
					<div class="form-group" id="parent_select">
						<div class="col-md-2 control-label"><label class="style1">所属章节</label></div>
						<div class="col-md-5 controls">
							<select id="discussParentId"  name="parent_id" onchange="doSeq(this.value,${courseView.id});" class="form-control">
								<option value="0">请选择所属章节</option>
								<c:forEach items="${chapterList }" var="chapter">
									<option value="${chapter.id}">${chapter.hour_title }</option>
								</c:forEach>
							</select>
						</div>
						<div class="help-block parent_select" style="display: none;">
							<span class="text-danger">请选择所属章节</span>
						</div>
					</div>
					<div class="form-group">
						<%--
						<div class="col-md-2 control-label">
							<label class="style1">序号</label>
						</div>
						--%>
						<div class="col-md-9 controls">
							<div class="row">
								<div class="col-md-4">
									<input class="form-control" id="discussSeq" type="hidden" name="hour_seq" />
								</div>
							</div>
						</div>
					</div>
				</form>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary"  onclick="doDiscussAdd();">保存</button>
			</div>
		</div>
	</div>
</div>

<!-- 添加试卷 -->
<div class="modal" id="add_paper"  role="dialog" aria-hidden="true">
	<div class="modal-dialog  modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title"> 添加试卷</h4>
			</div>
			<div class="modal-body">
				<form id="courseExam" class="form-horizontal lesson-form lesson-form-video" action="${pageContext.request.contextPath}/course_hour/save_course_hour.action" method="post">
					<input type="hidden" name="course_id" value="${courseView.id}"/>
					<input type="hidden" name="sign" value="${courseView.sign}"/>
					<input type="hidden" name="attribute_type" value="0"/>
					<input type="hidden" name="id" value=""/>
					<input type="hidden" id="test_paper_id" name="test_paper_id" value=""/>
					<input type="hidden" id="isEdit" value="0"/>
					<div class="form-group" id="test_paper_select">
						<div class="col-md-2 control-label"><label >试卷</label></div>
						<div class="col-md-9 controls">
							<select  id="testPaperId" class="form-control" onchange="doChangeTestPaper(this.value);">
								<option value="0">请选择试卷</option>
								<c:forEach items="${testPaperList }" var="paper">
									<option value="${paper.id }">${paper.name }</option>
								</c:forEach>
							</select>
							<div class="help-block">如果找不到试卷，请先确定该试卷已经发布</div>
							<div class="help-block parent_select" style="display: none;">
								<span class="text-danger">请选择试卷</span>
							</div>
						</div>
					</div>


					<div class="form-group " id="exam_input">
						<div class="col-md-2 control-label">
							<label >标题</label></div>
						<div class="col-md-9 controls">
							<input  class="form-control" type="text" name="hour_title" id="examTitle" value="" >
							<div class="help-block title_val" style="display:none;">
								<span class="text-danger">请输入标题(标题长度不得超过18个字)</span>
							</div>
						</div>
					</div>
					<div class="form-group" id="exam_parent_select">
						<div class="col-md-2 control-label"><label class="style1">所属章节</label></div>
						<div class="col-md-5 controls">
							<select id="examParentId"  name="parent_id" onchange="doSeq(this.value,${courseView.id});" class="form-control">
								<option value="0">请选择所属章节</option>
								<c:forEach items="${chapterList }" var="chapter">
									<option value="${chapter.id}">${chapter.hour_title }</option>
								</c:forEach>
							</select>
						</div>
						<div class="help-block parent_select" style="display: none;">
							<span class="text-danger">请选择所属章节</span>
						</div>
					</div>
					<div class="form-group">
						<%--
						<div class="col-md-2 control-label">
							<label class="style1">序号</label>
						</div>
						--%>
						<div class="col-md-9 controls">
							<div class="row">
								<div class="col-md-4">
									<input class="form-control" id="examSeq" type="hidden" name="hour_seq" />
								</div>
							</div>
						</div>
					</div>
				</form>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-link" data-dismiss="modal">取消</button>
				<button type="button" class="btn btn-primary" onclick="doExamAdd();">保存</button>
			</div>
		</div>
	</div>
</div>

<!-- 编辑作业 -->
<div class="modal" role="dialog" aria-hidden="true" id="editTask">
	<div class="modal-dialog  modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title">编辑作业</h4>
			</div>
			<div class="modal-body">
				<form id="courseTask" class="form-horizontal lesson-form lesson-form-video" action="${pageContext.request.contextPath}/course_hour/save_course_hour.action" method="post">
					<input type="hidden" name="course_id" value="${courseView.id}"/>
					<input type="hidden" name="sign" value="${courseView.sign}"/>
					<input type="hidden" name="attribute_type" value="4"/>
					<input type="hidden" name="id" value=""/>

					<div class="form-group " id="task_input">
						<div class="col-md-2 control-label">
							<label >标题</label></div>
						<div class="col-md-9 controls">
							<input  class="form-control" type="text" name="hour_title" id="taskTitle" value="" >
							<div class="help-block title_val" style="display:none;">
								<span class="text-danger">请输入标题(标题长度不得超过18个字)</span>
							</div>
						</div>
					</div>
					<div class="form-group " >
						<div class="col-md-2 control-label"><label class="style1">说明</label></div>
						<div class="col-md-9 controls">
							<textarea class="form-control" name="remarks"></textarea>
						</div>
					</div>

					<div class="form-group" id="task_parent_select">
						<div class="col-md-2 control-label"><label class="style1">所属章节</label></div>
						<div class="col-md-5 controls">
							<select id="taskParentId"  name="parent_id" onchange="doSeq(this.value,${courseView.id});" class="form-control">
								<option value="0">请选择所属章节</option>
								<c:forEach items="${chapterList }" var="chapter">
									<option value="${chapter.id}">${chapter.hour_title }</option>
								</c:forEach>
							</select>
						</div>
						<div class="help-block parent_select" style="display: none;">
							<span class="text-danger">请选择所属章节</span>
						</div>
					</div>
					<div class="form-group">
						<%--
						<div class="col-md-2 control-label">
							<label class="style1">序号</label>
						</div>
						--%>
						<div class="col-md-9 controls">
							<div class="row">
								<div class="col-md-4">
									<input class="form-control" type="hidden" name="hour_seq" />
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-link" data-dismiss="modal">取消</button>
				<button type="button" class="btn btn-primary" onclick="doTaskAdd();">保存</button>
			</div>
		</div>
	</div>
</div>


<%--添加直播课时弹窗--%>
<div id="modal1" class="modal" style="display: none;" aria-hidden="true">
	<div class="modal-dialog  modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title">新增直播课时</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" id="live-lesson-form" method="post" >
					<input type="hidden" name="course_id" value="${courseView.id}"/>
					<div class="form-group">
						<label class="col-md-2 control-label" for="live-title-field">标题</label>
						<div class="col-md-8 controls">
							<input class="form-control" id="live-title-field" name="hour_title" value=""  type="text">
							<div class="help-block" id="live-title-block"></div></div>
					</div>

					<div class="form-group">
						<label class="col-md-2 control-label">直播开始时间</label>
						<div class="col-md-8 controls" style="z-index:2000;">
							<input name="start_time" class="form-control width-input width-input-large" value=""  data-explain="教师可在直播开始前1小时内进入直播教室，以准备相关教学资料。" type="text">
							<div class="help-block" id="starttime-help-block">教师可在直播开始前1小时内进入直播教室，以准备相关教学资料。</div>
						</div>
					</div>

					<div class="form-group">
						<label class="col-md-2 control-label">直播时长</label>
						<div class="col-md-8 controls">
							<input name="minute" id="live-length-field" class="form-control width-input width-input-large" value="60" placeholder="时长"  type="text"> 分钟
							<div class="help-block" id="timelength-help-block"></div>
						</div>

					</div>

					<div class="form-group">
						<label class="col-md-2 control-label">直播说明</label>
						<div class="col-md-8 controls">
							<textarea class="form-control" id="live_lesson-content-field" name="remarks" ></textarea>
						</div>
					</div>

					<div class="form-group edit_section">
						<label class="col-md-2 control-label">所属章节</label>
						<div class="col-md-4 controls">
							<select id="chapter_parent_id"  name="parent_id" onchange="doSeq(this.value,${courseView.id});" class="form-control width-input width-input-large">
								<option value="0">请选择所属章节</option>
								<c:forEach items="${chapterList }" var="chapter">
									<option value="${chapter.id}">${chapter.hour_title }</option>
								</c:forEach>
							</select>
							<div class="section_val help-block" style="display: none;"><span class="text-danger" >请选择所属章节</span></div>
						</div>

					</div>

				</form>
				<div class="modal-footer">
					<button type="button" class="btn btn-link" data-dismiss="modal">取消</button>
					<button type="submit" class="btn btn-primary" data-toggle="form-submit" data-submiting-text="正在保存" data-target="#live-lesson-form" id="live-course-create-btn">保存</button>
				</div>
			</div>
		</div>
	</div>
</div>

<script>

    $(function () {
        //排序
        $( "#foo" ).sortable({
            items: "li:not(.chapter_item)",
            update: function(event, ui) {
                var
                    ids="",
                    start_seq,
                    hourSeqs="",
                    parent_id="",
                    parent_ids="";
                $("#foo input[name='id']").each(function(){
                    if($(this).val()==""){
                        parent_id = $(this).attr("id");
                        start_seq = 1;
                    }else{
                        ids += $(this).val()+",";
                        parent_ids += parent_id+",";
                        hourSeqs += start_seq+",";
                        $("#hour_seq_"+$(this).val()).html(start_seq);
                        start_seq ++;
                    }
                });
                $.ajax({
                    url:"${pageContext.request.contextPath}/course_hour/sort_course_hour.action",
                    data:{
                        ids : ids,
                        hourSeqs : hourSeqs,
                        parent_ids : parent_ids
                    },
                    dataType:'json',
                    success:function(){
                    }
                });
            }
        });
        $("#foo").disableSelection();


        $("#ziliao_ul li").click(function () {
            var index=$(this).index();
            $(".tab-pane").hide().eq(index).show();
        })

        $(".upload_file").click(function () {
            $(this).hide();
            $(".file-chooser-bar").show();
        })

        $("#bt_add_chapter").click(function(){
            $(".title_val").hide();
            $("#add_or_edit_chapter").text("新建章节");
            $("#chapterAdd #chapter_id").val("");
            $("#chapterAdd #hour_seq").val("");
            $("#chapterAdd #chapter_title").val("");
            $("#add_chapter").modal();
            doSeq(0,'${courseView.id}');
        });

    })

</script>