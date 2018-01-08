package cn.bnsr.edu_yun.frontstage.resource.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.backstage.base.service.SubjectService;
import cn.bnsr.edu_yun.backstage.base.view.Json;
import cn.bnsr.edu_yun.backstage.resource.service.BackFileService;
import cn.bnsr.edu_yun.backstage.resource.service.FileAmountService;
import cn.bnsr.edu_yun.backstage.resource.view.BackFileView;
import cn.bnsr.edu_yun.frontstage.base.po.BookCat;
import cn.bnsr.edu_yun.frontstage.base.po.Classify;
import cn.bnsr.edu_yun.frontstage.base.po.Label;
import cn.bnsr.edu_yun.frontstage.base.po.PubverList;
import cn.bnsr.edu_yun.frontstage.base.po.SubjectList;
import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.base.po.UserInfo;
import cn.bnsr.edu_yun.frontstage.base.po.UserProperty;
import cn.bnsr.edu_yun.frontstage.base.po.User_folder;
import cn.bnsr.edu_yun.frontstage.base.service.BookCatService;
import cn.bnsr.edu_yun.frontstage.base.service.ClassifyService;
import cn.bnsr.edu_yun.frontstage.base.service.LabelService;
import cn.bnsr.edu_yun.frontstage.base.service.PubverListService;
import cn.bnsr.edu_yun.frontstage.base.service.SubjectListService;
import cn.bnsr.edu_yun.frontstage.base.service.UserFileService;
import cn.bnsr.edu_yun.frontstage.base.service.UserFolderService;
import cn.bnsr.edu_yun.frontstage.base.service.UserService;
import cn.bnsr.edu_yun.frontstage.base.view.TextBookView;
import cn.bnsr.edu_yun.frontstage.base.view.UserFile;
import cn.bnsr.edu_yun.frontstage.resource.po.FileAmount;
import cn.bnsr.edu_yun.frontstage.resource.po.File_base;
import cn.bnsr.edu_yun.frontstage.resource.po.File_catalog;
import cn.bnsr.edu_yun.frontstage.resource.po.File_label;
import cn.bnsr.edu_yun.frontstage.resource.po.File_property;
import cn.bnsr.edu_yun.frontstage.resource.po.File_type;
import cn.bnsr.edu_yun.frontstage.resource.po.TeachingPlan;
import cn.bnsr.edu_yun.frontstage.resource.po.TeachingPlanFile;
import cn.bnsr.edu_yun.frontstage.resource.po.User_file;
import cn.bnsr.edu_yun.frontstage.resource.po.User_file_log;
import cn.bnsr.edu_yun.frontstage.resource.service.FileLabelService;
import cn.bnsr.edu_yun.frontstage.resource.service.FilePropertyService;
import cn.bnsr.edu_yun.frontstage.resource.service.FileTypeService;
import cn.bnsr.edu_yun.frontstage.resource.service.File_baseService;
import cn.bnsr.edu_yun.frontstage.resource.service.File_catalogService;
import cn.bnsr.edu_yun.frontstage.resource.service.LogService;
import cn.bnsr.edu_yun.frontstage.resource.service.TeachingPlanService;
import cn.bnsr.edu_yun.frontstage.resource.view.FileBaseView;
import cn.bnsr.edu_yun.frontstage.resource.view.TeachingPlanView;
import cn.bnsr.edu_yun.frontstage.train.po.Community;
import cn.bnsr.edu_yun.frontstage.train.po.Workshop;
import cn.bnsr.edu_yun.frontstage.train.service.CommunityService;
import cn.bnsr.edu_yun.frontstage.train.service.WorkshopService;
import cn.bnsr.edu_yun.frontstage.xbjy.po.LessonAttachment;
import cn.bnsr.edu_yun.frontstage.xbjy.view.LessonAttachmentView;
import cn.bnsr.edu_yun.frontstage.xbjy.view.LessonUserTaskView;
import cn.bnsr.edu_yun.util.ConfigInfo;
import cn.bnsr.edu_yun.util.ConverPdf;
import cn.bnsr.edu_yun.util.ConvertSwf;
import cn.bnsr.edu_yun.util.ExceptionUtil;
import cn.bnsr.edu_yun.util.NumUtil;
import cn.bnsr.edu_yun.util.ResponseUtil;

/**
 * 文件基础
 * 
 * @author fangxiongwei
 * @date 2016年8月10日
 */
@Controller
@RequestMapping("/my_file_base")
public class FileBaseController {
	@Autowired
	private File_baseService fileBaseService;
	@Autowired
	private UserService userService;
	@Autowired
	private File_catalogService fileCatalogService;
	@Autowired
	private ClassifyService classifyService;
	@Autowired
	private FileTypeService fileTypeService;
	@Autowired
	private UserFolderService userFolderService;
	@Autowired
	private LabelService labelService;
	@Autowired
	private FileLabelService fileLbaelService;
	@Autowired
	private FilePropertyService filePropertyService;
	@Autowired
	private LogService logService;
	@Autowired
	private UserFileService userFileService;
	@Autowired
	private FileAmountService fileAmountService;
	@Autowired
	private SubjectService subjectService;
	@Autowired
	private TeachingPlanService teachingPlanService;
	@Autowired
	private SubjectListService subjectListService;
	@Autowired
	private PubverListService pubverListService;
	@Autowired
	private BookCatService bookCatService;
	@Autowired
	private CommunityService communityService;
	@Autowired
	private WorkshopService workshopService;
	@Autowired
	private BackFileService backFileService;

	/**
	 * 跳转文件上传页面
	 */
	@RequestMapping("/to_upload_file")
	public ModelAndView toUploadFile(HttpServletRequest request) throws Exception {

		List<Classify> columnList = classifyService.queryByParentId(57l);// 资源栏目分类
		List<File_type> fileTypeList = fileTypeService.findAllFileType();// 文件类型
		List<User_folder> userFolderList = userFolderService.findAllUserFolder();// 用户文件夹
		List<Label> labelList = labelService.findAllLabel(0);// 资源标签
		List<FileAmount> amountList = fileAmountService.findAllAmount();// 金额
		//科目
		List<SubjectList> subject0List = subjectListService.querySubject("0");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("columnList", columnList);
		modelAndView.addObject("subject0List", subject0List);
		modelAndView.addObject("fileTypeList", fileTypeList);
		modelAndView.addObject("userFolderList", userFolderList);
		modelAndView.addObject("labelList", labelList);
		modelAndView.addObject("amountList", amountList);
		modelAndView.setViewName("frontstage/resource/upload_file");
		modelAndView.addObject("head_title", "上传文档");
		return modelAndView;
	}

	/**
	 * 文件保存
	 */
	@RequestMapping(value = "/save_file", method = RequestMethod.POST)
	public ModelAndView saveFile(HttpServletRequest request, FileBaseView fileBaseView) throws Exception {
		if(null==fileBaseView){
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.setViewName("frontstage/resource/teaching_plan_show");
			modelAndView.addObject("head_title", "参数错误");
			modelAndView.addObject("error_title", "参数错误无法上传或编辑!");
			modelAndView.addObject("flag", false);
			return modelAndView;
		}
			User user = (User) request.getSession().getAttribute("currentUser");
			if (user == null) {
				ModelAndView modelAndView = new ModelAndView();
				modelAndView.setViewName("frontstage/resource/teaching_plan_show");
				modelAndView.addObject("head_title", "需要登录");
				modelAndView.addObject("error_title", "需要登录才能上传或编辑!");
				modelAndView.addObject("flag", false);
				return modelAndView;
			}
			String title = fileBaseView.getTitle();
			int fileType = fileBaseView.getFileType();
			String profile = fileBaseView.getProfile();
			String legnth = fileBaseView.getLength();
			String path = fileBaseView.getPath();
			String fileName = fileBaseView.getName();
			String image = fileBaseView.getImage();
			String type = fileBaseView.getType();// 类型
			String value = fileBaseView.getValue();// 类型
			String folderId = fileBaseView.getFolderId();// 我的文档
			String columnId = fileBaseView.getColumnId();// 分类
			String labelId = fileBaseView.getLabelId();// 标签id
			String classficationId = fileBaseView.getClassficationId();// 分栏
			String rangeId = fileBaseView.getRangeId();
			int rangeType = fileBaseView.getRangeType();
			File_base file_base = null;
			if (fileBaseView.getId() != null) {
				file_base = fileBaseService.selectById(fileBaseView.getId());
				if (user.getId() != file_base.getUpload_user()) {
					ModelAndView modelAndView = new ModelAndView();
					modelAndView.setViewName("frontstage/resource/teaching_plan_show");
					modelAndView.addObject("head_title", "此用户没有权限操作");
					modelAndView.addObject("error_title", "此用户没有权限编辑此文件!");
					modelAndView.addObject("flag", false);
					return modelAndView;
				} else if (file_base.getStatus() != 4&&file_base.getStatus() != 2) {
					ModelAndView modelAndView = new ModelAndView();
					modelAndView.setViewName("frontstage/resource/teaching_plan_show");
					modelAndView.addObject("head_title", "资源已经发布");
					modelAndView.addObject("error_title", "资源已经发布，无法编辑!");
					modelAndView.addObject("flag", false);
					return modelAndView;
				}
			}
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("success_flag", "three");
			ModelAndView modelAndView = new ModelAndView("frontstage/resource/upload_file", map);
			modelAndView.addObject("head_title", "上传文档");
			if (fileName.contains(",")) {// 多文件
				int lengths = fileName.split(",").length;
				for (int i = 0; i < lengths; i++) {
					File_catalog catalog = new File_catalog();
					catalog.setTitle(NumUtil.isNotEmpty(title, i));
					if (profile.replaceAll(",", "").equals("")) {
						catalog.setProfile("");
					} else {
						catalog.setProfile(NumUtil.isNotEmpty(profile, i));
					}
					catalog.setIcon(NumUtil.isNotEmpty(image, i));
					catalog.setColumn_id(Integer.parseInt(NumUtil.isNotEmpty(columnId, i)));
					catalog.setType(Byte.parseByte(NumUtil.isNotEmpty(type, i)));
					catalog.setFolder_id(Long.parseLong(NumUtil.isNotEmpty(folderId, i)));
					catalog.setClassfication_id(NumUtil.isNotEmpty(classficationId, i));
					catalog.setRange_id(Long.parseLong(NumUtil.isNotEmpty(rangeId, i)));
					catalog.setRange_type(rangeType);
					if (file_base == null)
						fileCatalogService.insert(catalog);
					else {
						catalog.setId(file_base.getCatalog_id());
						fileCatalogService.update(catalog);
					}
					File_base base = new File_base();
					if (file_base == null) {
						File_property property = new File_property();
						property.setClick_times(0);
						property.setCollection_times(0);
						property.setDownload_times(0);
						property.setScore(0.0);
						filePropertyService.insert(property);
						base.setProperty_id(property.getId());
					}
					if (legnth != null) {
						long fileLength = Long.parseLong(!legnth.split(",")[i].equals("") ? legnth.split(",")[i] : "0");
						base.setLength(fileLength);
						base.setSize(NumUtil.toSize(fileLength));
					}
					base.setFilename(NumUtil.isNotEmpty(title, i));
					base.setPath(NumUtil.isNotEmpty(path, i));
					base.setUpload_time(new Date());
					base.setUpload_user(user.getId());
					base.setFormat(fileName.substring(fileName.lastIndexOf(".") + 1));
					base.setCatalog_id(catalog.getId());
					if (fileBaseView.getStatus() == null || fileBaseView.getStatus() != 1) {
						base.setStatus((byte) 4);// 上传状态-未审核 最新改为未发布4
					} else {
						base.setStatus((byte) 1);
					}
					base.setFile_type(fileType);
					base.setValue(Double.parseDouble(NumUtil.isNotEmpty(value, i)));
					if (file_base == null)
						fileBaseService.insert(base);
					else {
						base.setId(file_base.getId());
						fileBaseService.update(base);
						modelAndView=new ModelAndView("redirect:/userFile/to_user_file.action?stamp=9&state=37&type=1&status=-1&flag=-1&file_type=-1");
					}
					if (file_base == null) {
						// user_file
						User_file userFile = new User_file();
						userFile.setFile_id(base.getId());
						Date date = new Date();
						userFile.setTime(date);
						Byte type1 = 1;
						userFile.setType(type1);
						userFile.setUser_id(user.getId());
						userFile.setFile_type(0);

						userService.insertUserFile(userFile);
						// 上传日志
						UserProperty userProperty = userService.selectProperty(user.getProperty_id());
						userProperty.setUpload_count(userProperty.getUpload_count() + 1);
						if (type.equals("2")) {
							userProperty.setPublic_file_count(userProperty.getPublic_file_count() + 1);
						}
						if (type.equals("3")) {
							userProperty.setPrivate_file_count(userProperty.getPrivate_file_count() + 1);
						}
						userService.updateProperty(userProperty);
						User_file_log log = new User_file_log();
						log.setFile_id(base.getId());
						log.setUser_id(user.getId());
						log.setOperation_time(date);
						log.setOperation_description("上传了文件 " + base.getFilename());
						log.setOperation_type(type1);
						logService.insertUserFileLog(log);
					}
					if (!labelId.equals("")) {
						String labelIds = NumUtil.isNotEmpty(labelId, i);
						if (!labelIds.equals("0")) {
							labelIds = labelIds.substring(0, labelIds.length() - 1);
							if (labelIds.contains(",")) {
								String[] labelStr = labelIds.split(",");
								for (int j = 0; j < labelStr.length; j++) {
									File_label label = new File_label();
									label.setFile_id(base.getId());
									label.setLabel_id(Integer.parseInt(labelStr[j]));
									if (file_base == null)
										fileLbaelService.insert(label);
								}
							} else {
								File_label label = new File_label();
								label.setFile_id(base.getId());
								label.setLabel_id(Integer.parseInt(labelIds));
								if (file_base == null)
									fileLbaelService.insert(label);
							}
						}
					}
				}
			} else {// 单文件
				File_catalog catalog = new File_catalog();
				catalog.setTitle(title);
				catalog.setProfile(profile);
				catalog.setColumn_id(Integer.parseInt(columnId));
				catalog.setType(Byte.parseByte(type));
				catalog.setFolder_id(Long.parseLong(folderId));
				catalog.setClassfication_id(classficationId);
				catalog.setIcon(image);
				if (rangeId != null) {
					catalog.setRange_id(Long.parseLong(rangeId));
				}
				catalog.setRange_type(rangeType);
				if (file_base == null)
					fileCatalogService.insert(catalog);
				else {
					catalog.setId(file_base.getCatalog_id());
					fileCatalogService.update(catalog);
				}
				File_base base = new File_base();
				if (file_base == null) {
					File_property property = new File_property();
					property.setClick_times(0);
					property.setCollection_times(0);
					property.setDownload_times(0);
					property.setScore(0.0);
					filePropertyService.insert(property);
					base.setProperty_id(property.getId());
				}
				if (legnth != null) {
					long fileLength = Long.parseLong(legnth);
					base.setLength(fileLength);
					base.setSize(NumUtil.toSize(fileLength));
				}
				base.setFilename(title);
				base.setPath(path);
				base.setUpload_time(new Date());
				base.setUpload_user(user.getId());
				base.setFormat(fileName.substring(fileName.lastIndexOf(".") + 1));

				base.setCatalog_id(catalog.getId());
				if (fileBaseView.getStatus() == null || fileBaseView.getStatus() != 1) {
					base.setStatus((byte) 4);// 上传状态-未审核 最新改为未发布4
				} else {
					base.setStatus((byte) 1);
				}
				base.setFile_type(fileType);
				base.setValue(Double.parseDouble(value));
				if (file_base == null)
					fileBaseService.insert(base);
				else {
					base.setId(file_base.getId());
					fileBaseService.update(base);
					modelAndView=new ModelAndView("redirect:/userFile/to_user_file.action?stamp=9&state=37&type=1&status=-1&flag=-1&file_type=-1");
				}
				if (file_base == null) {
					// user_file
					User_file userFile = new User_file();
					userFile.setFile_id(base.getId());
					Date date = new Date();
					userFile.setTime(date);
					Byte type1 = 1;
					userFile.setType(type1);
					userFile.setUser_id(user.getId());
					userFile.setFile_type(0);
					userService.insertUserFile(userFile);
					// 上传日志
					UserProperty userProperty = userService.selectProperty(user.getProperty_id());
					userProperty.setUpload_count(userProperty.getUpload_count() + 1);
					if (type.equals("2")) {
						userProperty.setPublic_file_count(userProperty.getPublic_file_count() + 1);
					}
					if (type.equals("3")) {
						userProperty.setPrivate_file_count(userProperty.getPrivate_file_count() + 1);
					}
					userService.updateProperty(userProperty);

					User_file_log log = new User_file_log();
					log.setFile_id(base.getId());
					log.setUser_id(user.getId());
					log.setOperation_time(date);
					log.setOperation_description("上传了文件 " + base.getFilename());
					log.setOperation_type(type1);
					logService.insertUserFileLog(log);
					if (!labelId.equals("") && !labelId.equals("0")) {
						String labelIds = labelId.substring(0, labelId.length() - 1);
						if (labelIds.contains(",")) {// 多个标签
							String[] labelStr = labelIds.split(",");
							for (int j = 0; j < labelStr.length; j++) {
								File_label label = new File_label();
								label.setFile_id(base.getId());
								label.setLabel_id(Integer.parseInt(labelStr[j]));
								fileLbaelService.insert(label);
							}
						} else {// 单个标签
							File_label label = new File_label();
							label.setFile_id(base.getId());
							label.setLabel_id(Integer.parseInt(labelIds));
							fileLbaelService.insert(label);
						}
					}
				}
			}
	
		// 保存后清空session
		request.getSession().setAttribute("userFile", null);
	
		return modelAndView;
	}

	/**
	 * 重置文件session
	 */
	@RequestMapping("/reform_ession")
	@ResponseBody
	public String reformSession(HttpServletRequest request) {
		String path = request.getParameter("path");
		String name = request.getParameter("name");
		String length = request.getParameter("length");
		String image = request.getParameter("image");

		if (!path.equals("")) {
			UserFile ufile = new UserFile();
			ufile.setFileNames(name);
			ufile.setFilePaths(path);
			ufile.setFileLengths(length);
			ufile.setFileImages(image);
			request.getSession().setAttribute("userFile", ufile);
		} else {// 清空session
			request.getSession().setAttribute("userFile", null);
		}

		return "ok";
	}

	/**
	 * 跳转文件上传选择页面
	 */
	@RequestMapping("/to_upload_choose")
	public ModelAndView toUploadFileChoose(HttpServletRequest request, boolean success) throws Exception {

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("frontstage/resource/upload_file_choose");
		modelAndView.addObject("success", success);
		modelAndView.addObject("head_title", "上传类型选择");
		return modelAndView;
	}

	/**
	 * 跳转教案上传页面
	 */
	@RequestMapping("/to_teaching_plan")
	public ModelAndView toTeachingPlan(HttpServletRequest request) throws Exception {
		List<SubjectList> subjectList = subjectService.selectByPid("XX");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("subjectList", subjectList);
		modelAndView.setViewName("frontstage/resource/upload_teaching_plan");
		modelAndView.addObject("head_title", "上传教案");
		return modelAndView;
	}

	/**
	 * 上传附件方法
	 * 
	 * @param file
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/upload")
	public void upload(@RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		User user = (User) request.getSession().getAttribute("currentUser");
		String path = request.getSession().getServletContext().getRealPath(ConfigInfo.getString("attachmentFile"));
		Date date = new Date();
		long time = date.getTime();
		Random ra = new Random();
		String fastName = "file" + time + ra.nextInt(10);
		String format = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
		String fileName = fastName + format;
		File targetFile = new File(path, fileName);
		if (!targetFile.exists()) {
			targetFile.mkdirs();
		}

		// 保存
		try {
			file.transferTo(targetFile);
		} catch (Exception e) {
			e.printStackTrace();
		}

		JSONObject result = new JSONObject();
		result.put("url", path + "/" + fileName);
		result.put("fileName", file.getOriginalFilename());
		ResponseUtil.write(response, result);

	}

	/**
	 * 教案上传
	 */
	@RequestMapping("/upload_teaching_plan")
	public ModelAndView uploadTeachingPlan(HttpServletRequest request, TeachingPlanView teachingPlanView) throws Exception {
		TeachingPlan teachingPlan = new TeachingPlan();
		User user = (User) request.getSession().getAttribute("currentUser");
		if (user == null) {
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.setViewName("frontstage/resource/teaching_plan_show");
			modelAndView.addObject("head_title", "需要登录");
			modelAndView.addObject("error_title", "需要登录才能上传或编辑!");
			modelAndView.addObject("flag", false);
			return modelAndView;
		}
		File_base file_base = null;
		if (teachingPlanView.getId() != null) {
			file_base = fileBaseService.selectById(teachingPlanView.getId());
			if (user.getId() != file_base.getUpload_user()) {
				ModelAndView modelAndView = new ModelAndView();
				modelAndView.setViewName("frontstage/resource/teaching_plan_show");
				modelAndView.addObject("head_title", "此用户没有权限操作");
				modelAndView.addObject("error_title", "此用户没有权限编辑此教案!");
				modelAndView.addObject("flag", false);
				return modelAndView;
			} else if (file_base.getStatus() != 4) {
				ModelAndView modelAndView = new ModelAndView();
				modelAndView.setViewName("frontstage/resource/teaching_plan_show");
				modelAndView.addObject("head_title", "教案已经发布");
				modelAndView.addObject("error_title", "教案已经发布，无法编辑!");
				modelAndView.addObject("flag", false);
				return modelAndView;
			}
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("success_flag", "three");
		ModelAndView modelAndView = new ModelAndView("frontstage/resource/upload_file", map);
		BeanUtils.copyProperties(teachingPlanView, teachingPlan);
		teachingPlan.setUser_id(user.getId());
		if (file_base == null) {
			teachingPlanService.insert(teachingPlan);
		} else {
			teachingPlan.setId(file_base.getTeaching_plan_id());
			teachingPlanService.update(teachingPlan);
			List<TeachingPlanFile> teachingPlanFile = teachingPlanService.selectByPlanId(file_base.getTeaching_plan_id());
			for (TeachingPlanFile t : teachingPlanFile) {
				teachingPlanService.deletePlanFile(t.getId());
			}
		}
		int i = 0;
		if (teachingPlanView.getFileName() != null)
			for (String fileName : teachingPlanView.getFileName()) {
				TeachingPlanFile teachingPlanFile = new TeachingPlanFile();
				teachingPlanFile.setTeaching_plan_id(teachingPlan.getId());
				teachingPlanFile.setFilename(fileName);
				teachingPlanFile.setUrl(teachingPlanView.getFileUrl().get(i));
				teachingPlanService.insertFile(teachingPlanFile);
				i++;
			}
		if (file_base == null) {
			File_property property = new File_property();
			property.setClick_times(0);
			property.setCollection_times(0);
			property.setDownload_times(0);
			property.setScore(0.0);
			filePropertyService.insert(property);

			File_base base = new File_base();
			base.setFilename(teachingPlan.getResource_name());
			base.setUpload_time(new Date());
			base.setUpload_user(user.getId());
			base.setProperty_id(property.getId());
			if (teachingPlanView.getStatus() == null || teachingPlanView.getStatus() != 1) {
				base.setStatus((byte) 4);// 上传状态-未审核 最新改为未发布4
			} else {
				base.setStatus((byte) 1);
			}
			base.setFile_type(1);
			base.setTeaching_plan_id(teachingPlan.getId());
			fileBaseService.insert(base);
			// user_file
			User_file userFile = new User_file();
			userFile.setFile_id(base.getId());
			Date date = new Date();
			userFile.setTime(date);
			Byte type = 1;
			userFile.setType(type);
			userFile.setUser_id(user.getId());
			userFile.setFile_type(2);
			userService.insertUserFile(userFile);
		} else {
			file_base.setFilename(teachingPlan.getResource_name());
			if (teachingPlanView.getStatus() == null || teachingPlanView.getStatus() != 1) {
				file_base.setStatus((byte) 4);// 上传状态-未审核 最新改为未发布4
			} else {
				file_base.setStatus((byte) 1);
			}
			fileBaseService.update(file_base);
			modelAndView=new ModelAndView("redirect:/userFile/to_user_file.action?stamp=9&state=37&type=1&status=-1&flag=-1&file_type=-1");
			
		}
		modelAndView.addObject("head_title", "上传教案");
		return modelAndView;
	}

	@RequestMapping("delete_file")
	@ResponseBody
	public void deleteFile(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		JSONObject result = new JSONObject();
		try {
			fileBaseService.deleteFile(id);
			result.put("flag", true);
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 编辑
	 */
	@RequestMapping("/update_file")
	public ModelAndView updateFile(HttpServletRequest request, File_base file_base) throws Exception {
		User user = (User) request.getSession().getAttribute("currentUser");
		ModelAndView modelAndView = new ModelAndView("frontstage/resource/upload_file_update");
		TextBookView textBook = new TextBookView();
		file_base = fileBaseService.selectById(file_base.getId());
		modelAndView.addObject("file_base", file_base);

		// 科目
		String classfication = "";
		int type = 0;
		if (file_base.getFile_type() == 0) {
			classfication = file_base.getFile_catalog().getClassfication_id();
			type = file_base.getFile_catalog().getRange_type();
		} else {
			TeachingPlan teachingPlan = teachingPlanService.selectById(file_base.getTeaching_plan_id());
			classfication = teachingPlan.getLesson();
			modelAndView.addObject("teachingPlan", teachingPlan);
			List<TeachingPlanFile> teachingPlanFile = teachingPlanService.selectByPlanId(file_base.getTeaching_plan_id());
			modelAndView.addObject("teachingPlanFile", teachingPlanFile);
			type = teachingPlan.getPublish_type();
		}
		String stage = classfication.substring(0, 2);
		List<SubjectList> subjectList = subjectListService.querySubject(stage);
		// 教材版本
		List<PubverList> editionList = null;
		if (subjectList.size() > 0) {
			String subject = classfication.substring(0, 5);
			editionList = pubverListService.queryPubver(subject);
			modelAndView.addObject("subject", subject);
		}
		// 年级
		List<BookCat> gradeList = null;
		if (editionList != null && editionList.size() > 0) {
			String pubver = classfication.substring(0, 8);
			gradeList = bookCatService.queryBookCat(pubver);
			modelAndView.addObject("pubver", pubver);
			
		}

		// 章节
		List<BookCat> chapterList = null;
		if (gradeList.size() > 0) {
			String grade = classfication.substring(0, 11);
			chapterList = bookCatService.queryBookCat(grade);
			modelAndView.addObject("grade", grade);
		}
		// 小节
		List<BookCat> sectionList = null;
		if (chapterList != null && chapterList.size() > 0) {
			String chapter = classfication.substring(0, 14);
			sectionList = bookCatService.queryBookCat(chapter);
			modelAndView.addObject("chapter", chapter);
		}
		if(sectionList!=null&&sectionList.size()>0){
			String section = classfication.substring(0, 17);
			modelAndView.addObject("section", section);
		}
		textBook.setChapterList(chapterList);
		textBook.setSectionList(sectionList);

		textBook.setSubjectList(subjectList);
		textBook.setEditionList(editionList);
		textBook.setGradeList(gradeList);
		List<SubjectList> subject0List = subjectListService.querySubject("0");
		modelAndView.addObject("subject0List", subject0List);
		modelAndView.addObject("textBook", textBook);
		modelAndView.addObject("stage", stage);
		
		if (type == 1) {
			List<Community> communitys = communityService.queryCommunitys();
			modelAndView.addObject("communitys", communitys);
		} else if (type == 2) {
			List<Workshop> workshops = workshopService.queryWorkshops();
			modelAndView.addObject("workshops", workshops);
		}

		if (file_base.getFile_type() == 0) {
			List<Classify> columnList = classifyService.queryByParentId(57l);// 资源栏目分类
			List<File_type> fileTypeList = fileTypeService.findAllFileType();// 文件类型
			List<User_folder> userFolderList = userFolderService.findAllUserFolder();// 用户文件夹
			List<Label> labelList = labelService.findAllLabel(0);// 资源标签
			List<FileAmount> amountList = fileAmountService.findAllAmount();// 金额
			modelAndView.addObject("columnList", columnList);
			modelAndView.addObject("fileTypeList", fileTypeList);
			modelAndView.addObject("userFolderList", userFolderList);
			modelAndView.addObject("labelList", labelList);
			modelAndView.addObject("amountList", amountList);
			modelAndView.addObject("head_title", "编辑文档");
		} else {
			modelAndView.addObject("head_title", "编辑教案");
			modelAndView.setViewName("frontstage/resource/upload_teaching_plan");
		}
		return modelAndView;
	}

	/**
	 * 前台审核资源
	 * 
	 * @throws Exception
	 */
	@RequestMapping("/save_review_file")
	public void saveReviewFile(HttpServletResponse response, BackFileView backFileView) throws Exception {
		JSONObject result = new JSONObject();
		try {
			backFileService.saveReviewFile(backFileView);
			result.put("success", true);

			result.put("msg", "审核成功！");
		} catch (Exception e) {

			result.put("msg", "审核失败！");
		}
		ResponseUtil.write(response, result);
	}
}
