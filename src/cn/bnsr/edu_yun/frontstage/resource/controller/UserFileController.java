package cn.bnsr.edu_yun.frontstage.resource.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.net.URLEncoder;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.apache.commons.io.IOUtils;
import org.csource.fastdfs.ClientGlobal;
import org.csource.fastdfs.StorageClient1;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.backstage.base.view.SessionInfo;
import cn.bnsr.edu_yun.frontstage.base.po.BookCat;
import cn.bnsr.edu_yun.frontstage.base.po.PubverList;
import cn.bnsr.edu_yun.frontstage.base.po.SubjectList;
import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.base.po.UserInfo;
import cn.bnsr.edu_yun.frontstage.base.po.User_attent;
import cn.bnsr.edu_yun.frontstage.base.service.BookCatService;
import cn.bnsr.edu_yun.frontstage.base.service.PubverListService;
import cn.bnsr.edu_yun.frontstage.base.service.SubjectListService;
import cn.bnsr.edu_yun.frontstage.base.service.UserAttentService;
import cn.bnsr.edu_yun.frontstage.base.service.UserFileService;
import cn.bnsr.edu_yun.frontstage.base.service.UserInfoService;
import cn.bnsr.edu_yun.frontstage.base.service.UserService;
import cn.bnsr.edu_yun.frontstage.base.view.UserCenterView;
import cn.bnsr.edu_yun.frontstage.resource.po.File_base;
import cn.bnsr.edu_yun.frontstage.resource.po.File_property;
import cn.bnsr.edu_yun.frontstage.resource.po.TeachingPlan;
import cn.bnsr.edu_yun.frontstage.resource.po.TeachingPlanFile;
import cn.bnsr.edu_yun.frontstage.resource.po.User_file;
import cn.bnsr.edu_yun.frontstage.resource.service.FilePropertyService;
import cn.bnsr.edu_yun.frontstage.resource.service.File_baseService;
import cn.bnsr.edu_yun.frontstage.resource.service.TeachingPlanService;
import cn.bnsr.edu_yun.frontstage.resource.view.ResouceFileView;
import cn.bnsr.edu_yun.frontstage.resource.view.TeachingPlanView;
import cn.bnsr.edu_yun.frontstage.train.po.TopicQuestion;
import cn.bnsr.edu_yun.frontstage.train.po.UserAppraise;
import cn.bnsr.edu_yun.frontstage.train.po.UserCollect;
import cn.bnsr.edu_yun.frontstage.train.service.UserAppraiseService;
import cn.bnsr.edu_yun.frontstage.train.service.UserCollectService;
import cn.bnsr.edu_yun.frontstage.train.view.AppraiseReasonView;
import cn.bnsr.edu_yun.frontstage.train.view.UserAppraisView;
import cn.bnsr.edu_yun.frontstage.xbjy.po.LessonAttachment;
import cn.bnsr.edu_yun.util.ConfigInfo;
import cn.bnsr.edu_yun.util.DcsUtil;
import cn.bnsr.edu_yun.util.ExceptionUtil;
import cn.bnsr.edu_yun.util.NumUtil;
import cn.bnsr.edu_yun.util.ResponseUtil;

@Controller
@RequestMapping("/userFile")
public class UserFileController {
	private final Logger log = LoggerFactory.getLogger(UserFileController.class);

	@Autowired
	private File_baseService fileBaseService;
	@Autowired
	private UserService userService;
	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private UserFileService userFileService;
	@Autowired
	private FilePropertyService filePropertyService;
	@Autowired
	private TeachingPlanService teachingPlanService;
	@Autowired
	private UserAttentService userAttentService;
	@Autowired
	private UserCollectService userCollectService;
	@Autowired
	private UserAppraiseService userAppraiseService;
	@Autowired
	private BookCatService bookCatService;
	@Autowired
	private PubverListService pubverListService;
	@Autowired
	private SubjectListService subjectListService;

	@RequestMapping("/keepFile")
	public ModelAndView keepFile(HttpServletRequest request, HttpServletResponse response) throws Exception {
		JSONObject result = new JSONObject();
		String fileBase_id = request.getParameter("fileBase_id");
		String type = request.getParameter("type");
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("currentUser");
		if (user == null) {
			result.put("msg", "请登录");
		} else {
			long file_id = Long.parseLong(fileBase_id);
			long user_id = user.getId();
			User_file userFile = userFileService.selectFile(user_id, file_id);
			if (userFile != null) {
				result.put("msg", "已经收藏过了");
			} else {
				userFile = new User_file();
				userFile.setFile_id(file_id);
				userFile.setType(Byte.parseByte(type));
				userFile.setUser_id(user_id);
				userFile.setTime(new Date());
				int i = userFileService.insert(userFile);
				result.put("msg", "收藏成功");
				System.out.println(i);
			}
		}
		ResponseUtil.write(response, result);
		return null;

	}

	@RequestMapping("/checkBuy")
	public ModelAndView checkBuy(HttpServletRequest request, HttpServletResponse response, String fileBase_id) throws Exception {
		JSONObject result = new JSONObject();

		long file_id = Long.parseLong(fileBase_id);
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("currentUser");
		if (user == null) {
			result.put("msg", "请登录");
			result.put("status", 0);
		} else {
			long user_id = user.getId();
			User_file userFile = userFileService.selectBuyFile(user_id, file_id);
			if (userFile == null) {
				// 没有购买，需要购买
				result.put("status", 1);
			} else {
				// 已购买，直接下载
				result.put("status", 2);
			}

		}

		ResponseUtil.write(response, result);
		return null;
	}

	@RequestMapping("/download")
	public ModelAndView download(HttpServletRequest request, HttpServletResponse response) throws URISyntaxException, Exception {
		String fileBase_id = request.getParameter("fileBase_id");

		long fileBaseId = Long.parseLong(fileBase_id);

		ClassPathResource classPathResource = new ClassPathResource("fdfs_client.conf");
		ClientGlobal.init(classPathResource.getClassLoader().getResource("fdfs_client.conf").toURI().getPath());
		StorageClient1 storageClient1 = new StorageClient1();

		File_base fileBase = fileBaseService.selectById(fileBaseId);

		String location = fileBase.getPath();

		byte[] bs = storageClient1.download_file1(location);

		String uploadPath = request.getSession().getServletContext().getRealPath("/read");
		System.out.println(uploadPath);
		File folder = new File(uploadPath);
		if (!folder.exists()) {
			folder.mkdirs();
		}
		File file = new File(uploadPath.replace("\\", "/"));
		if (!file.exists()) {
			file.mkdirs();
		}
		String format = "." + fileBase.getFormat();
		int code = (int) ((Math.random() * 9 + 1) * 100000);
		String fileName = "file" + fileBase.getId() + code + format;
		String path = uploadPath.replace("\\", "/") + "/" + fileName;
		System.out.println(uploadPath);
		System.out.println(path);
		IOUtils.write(bs, new FileOutputStream(new File(path)));
		String filePath = uploadPath.replace("\\", "/");
		String Filename = fileBase.getFilename() + format;
		if (format.equals(".txt")) {
			int index = fileName.lastIndexOf(".txt");
			fileName = fileName.substring(0, index) + ".odt";

		}
		final String CONTENT_TYPE = "text/plain; charset=UTF-8";
		response.setContentType(CONTENT_TYPE);
		response.setContentType("application/x-msdownload");
		File downFile = new File(filePath + "/" + fileName);
		response.setContentLength((int) downFile.length());
		// 需要判断是什么浏览器
		String explorer = request.getParameter("explorer");
		System.out.println(explorer);
		String name = getFileName(Filename, explorer);
		response.setHeader("Content-Disposition", name);
		// 读出文件到i/o流
		FileInputStream fis = new FileInputStream(downFile);
		BufferedInputStream buff = new BufferedInputStream(fis);

		byte[] b = new byte[1024];// 相当于我们的缓存

		long k = 0;// 该值用于计算当前实际下载了多少字节

		// 从response对象中得到输出流,准备下载

		OutputStream myout = response.getOutputStream();

		// 开始循环下载

		while (k < downFile.length()) {

			int j = buff.read(b, 0, 1024);
			k += j;

			// 将b中的数据写到客户端的内存
			myout.write(b, 0, j);

		}

		// 将写入到客户端的内存的数据,刷新到磁盘
		myout.flush();
		myout.close();
		// 增加点击数
		System.out.println(fileBase.getFile_property().getDownload_times());
		File_property property = new File_property();
		property.setId(fileBase.getProperty_id());
		property.setDownload_times(fileBase.getFile_property().getDownload_times() + 1);
		filePropertyService.update(property);
		return null;

	}

	private String getFileName(String FileName, String explorer) throws UnsupportedEncodingException {

		// 需要判断是什么浏览器
		// String explorer=request.getParameter("explorer");
		System.out.println(explorer);
		/*
		 * new_filename = URLEncoder.encode(Filename, "UTF8");
		 */
		// "IE"; rtn = "filename=\"" + new_filename + "\"";
		// "Firefox"; rtn = "filename*=UTF-8''" + new_filename;
		// "Chrome"; new_filename = MimeUtility.encodeText(filename, "UTF8",
		// "B"); 和 rtn = "filename=\"" + new_filename + "\"";
		// "Opera"; rtn = "filename*=UTF-8''" + new_filename;
		// "Safari"; rtn = "filename=\"" + new
		// String(filename.getBytes("UTF-8"),"ISO8859-1") + "\"";
		String name = "attachment;filename=" + FileName;
		String filename = new String(URLEncoder.encode(FileName, "UTF8"));
		// "attachment;filename*=UTF-8'"+filename;
		if (explorer.equals("IE")) {
			name = "attachment;filename=" + filename;
		} else if (explorer.equals("Firefox")) {
			name = "attachment;filename*=UTF-8'" + filename;
		} else if (explorer.equals("Chrome")) {
			name = "attachment;filename=" + new String(filename.getBytes("UTF-8"), "ISO8859-1");
		} else if (explorer.equals("Opera")) {
			name = "attachment;filename*=UTF-8'" + filename;
		} else if (explorer.equals("Safari")) {
			name = "attachment;filename=" + new String(filename.getBytes("UTF-8"), "ISO8859-1");
		}

		return name;

	}

	/**
	 * 跳转我的上传、下载
	 */
	@RequestMapping("/to_user_file")
	public ModelAndView toUserFile(HttpServletRequest request, ResouceFileView resouceFileView) {
		User user = (User) request.getSession().getAttribute("currentUser");
		ModelAndView modelAndView = new ModelAndView();
		String state = request.getParameter("state");
		String stamp = request.getParameter("stamp");
		int type = resouceFileView.getType();
		String str = "";
		try {
			if (type == 1) {// 上传
				str = "我的上传";
			} else if (type == 5) {// 下载
				str = "我的下载";
			}
			resouceFileView.setUser_id(user.getId());
			resouceFileView.setRows(12);
			if (resouceFileView.getPage() == 0) {
				resouceFileView.setStartLine(0);
			} else {
				resouceFileView.setStartLine(resouceFileView.getPage() * resouceFileView.getRows());
			}
			List<ResouceFileView> userFileList = userFileService.queryUserFile(resouceFileView);
			int total = userFileService.queryTotalUserFile(resouceFileView);//
			resouceFileView.setTotal(total);
			// 分页总页数
			resouceFileView.setTotalPage(NumUtil.totalPage(total, resouceFileView.getRows()));

			modelAndView.addObject("userFileList", userFileList);
			modelAndView.addObject("resouceFileView", resouceFileView);

			UserInfo userInfo = userInfoService.getByUserId(user.getId());
			request.setAttribute("user", user);
			request.setAttribute("userInfo", userInfo);
			// 个人中心统计数据
			UserCenterView userCenter = userService.queryUserCenter(user.getId());
			modelAndView.addObject("userCenter", userCenter);

			request.setAttribute("state", state);
			request.setAttribute("stamp", stamp);
			modelAndView.addObject("head_title", str);
			modelAndView.setViewName("frontstage/base/personalCenter/user_file");
		} catch (Exception e) {
			log.error(str + "列表查询失败", ExceptionUtil.getExceptionMessage(e));
		}
		return modelAndView;
	}

	// 展示
	@RequestMapping("/to_file")
	public ModelAndView toFile(HttpServletRequest request, File_base file_base) {
		User user = (User) request.getSession().getAttribute("currentUser");
		SessionInfo sessionInfo = (SessionInfo) request.getSession().getAttribute("sessionInfo");
		ModelAndView modelAndView = new ModelAndView();
		boolean flag = true;
		try {
			file_base = fileBaseService.selectById(file_base.getId());
			if (user != null && user.getId() == file_base.getUpload_user()) {
				if (file_base.getStatus() == 3) {
					flag = false;
					modelAndView.addObject("flag", flag);
					modelAndView.setViewName("frontstage/resource/teaching_plan_show");
					modelAndView.addObject("head_title", "资源不存在");
					return modelAndView;
				}
			} else if (sessionInfo != null) {
				// 后台用户浏览
			} else if (file_base.getStatus() != 0) {
				String see = request.getParameter("see");
				if (!see.equals("see")) {
					flag = false;
					modelAndView.addObject("flag", flag);
					modelAndView.setViewName("frontstage/resource/teaching_plan_show");
					modelAndView.addObject("head_title", "资源不存在");
					modelAndView.addObject("error_title", "资源不存在或已删除!");
					return modelAndView;
				}
			}

			modelAndView.addObject("file_base", file_base);
			modelAndView.addObject("flag", flag);
			// 记录点击记录
			User_file userFile = new User_file();
			userFile.setFile_id(file_base.getId());
			userFile.setType(Byte.parseByte("6"));
			if (user != null) {
				userFile.setUser_id(user.getId());
			}
			userFile.setTime(new Date());
			int i = userFileService.insert(userFile);
			// 记录点击次数
			File_property property = file_base.getFile_property();
			property.setId(file_base.getProperty_id());
			property.setClick_times(file_base.getFile_property().getClick_times() + 1);
			filePropertyService.update(property);
			file_base.setFile_property(property);
			// 关注
			if (user != null) {
				User_attent userAttent = userAttentService.selectattent(user.getId(), file_base.getUpload_user());
				if (userAttent == null) {
					modelAndView.addObject("userAttent", 0);
				} else {
					modelAndView.addObject("userAttent", 1);
				}
				// 收藏
				UserCollect userCollect = new UserCollect();

				userCollect.setSource_type(3);
				userCollect.setUser_id(user.getId());
				userCollect.setSource_id(file_base.getId());
				userCollect = userCollectService.selectByCourseIdAndUserId(userCollect);
				modelAndView.addObject("userCollect", userCollect);
				// 是否评价
				UserAppraise userAppraise = userAppraiseService.selectByCourseIdAndUserId(user.getId(), file_base.getId(), 4);
				if (userAppraise != null)
					modelAndView.addObject("userAppraiseId", userAppraise.getId());
			}
			// 评分
			// 评价总数
			long totalAppraise = userAppraiseService.selectCountBySourceId(file_base.getId(), 4);
			// 评价总分
			Integer totalScore = userAppraiseService.selectTotalScore(file_base.getId(), 4);
			int avgScore = 0;
			if (totalAppraise != 0 && totalScore != null) {
				avgScore = (int) (totalScore / totalAppraise);
			} else {
				avgScore = 5;
			}
			modelAndView.addObject("totalAppraise", totalAppraise);
			modelAndView.addObject("avgScore", avgScore);
			long start = 0;
			long pageSize = 5;
			List<UserAppraisView> appraise = userAppraiseService.selectBySourceId(file_base.getId(), start, pageSize, 4);
			modelAndView.addObject("appraise", appraise);
			modelAndView.addObject("pageSize", pageSize);
			if (file_base.getFile_type() == 1) {

				TeachingPlanView teachingPlanView = new TeachingPlanView();
				teachingPlanView.setId(file_base.getTeaching_plan_id());
				teachingPlanView = teachingPlanService.queryTeachingPlan(teachingPlanView);
				modelAndView.addObject("teachingPlanView", teachingPlanView);
				List<TeachingPlanFile> teachingPlanFile = teachingPlanService.selectByPlanId(file_base.getTeaching_plan_id());
				modelAndView.addObject("teachingPlanFile", teachingPlanFile);
				modelAndView.addObject("head_title", "教案展示");
				modelAndView.setViewName("frontstage/resource/teaching_plan_show");
			} else if (file_base.getFile_type() == 0) {
				String classification_id = file_base.getFile_catalog().getClassfication_id();
				if(classification_id.length()>0){
					SubjectList stage = subjectListService.selectById(classification_id.substring(0, 2));
					modelAndView.addObject("stage", stage.getSubjectName());
				}
				if(classification_id.length()>2){
					SubjectList subject = subjectListService.selectById(classification_id.substring(0, 5));
					modelAndView.addObject("subject", subject.getSubjectName());
				}
				if(classification_id.length()>5){
					PubverList pubver = pubverListService.selectById(classification_id.substring(0, 8));
					modelAndView.addObject("pubver", pubver.getVersionName());
				}
				// 永中文件转换
				String dcsUrl = DcsUtil.getUrlRedis(file_base.getPath(), file_base.getFormat());
				modelAndView.addObject("dcsUrl", dcsUrl);
				modelAndView.addObject("format", file_base.getFormat());
				modelAndView.addObject("head_title", "资源展示");
				modelAndView.setViewName("frontstage/resource/read");
			}
			//评价项
			AppraiseReasonView appraiseReasonView=new AppraiseReasonView();
			appraiseReasonView.setType(3);
			appraiseReasonView.setLevel(5);
			appraiseReasonView.setSource_id(file_base.getId());
			List<AppraiseReasonView> appraiseReasonViews = userAppraiseService.selectByType(appraiseReasonView);
			modelAndView.addObject("appraiseReasonViews", appraiseReasonViews);
		} catch (Exception e) {
			log.error("资源或教案查看失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
			flag = false;
			modelAndView.addObject("flag", flag);
			modelAndView.setViewName("frontstage/resource/teaching_plan_show");
			modelAndView.addObject("head_title", "资源不存在");
			modelAndView.addObject("error_title", "资源不存在或已删除!");
			return modelAndView;
		}
		return modelAndView;
	}

	/**
	 * 查看，各种类型附件
	 * 
	 * @param request
	 * @param id
	 * @return
	 */
	@RequestMapping("/see")
	public ModelAndView see(HttpServletRequest request, Long id) {

		TeachingPlanFile teachingPlanFile = teachingPlanService.selectFile(id);
		String url = teachingPlanFile.getUrl();
		url = url.replaceAll("\\\\", "/");
		String fileName = url.substring(url.lastIndexOf("/"));
		String fileUrl=ConfigInfo.getString("attachmentFileUrl")+fileName;
		int i = fileName.lastIndexOf(".");
		String format = fileName.substring(i);
		String dcsUrl = DcsUtil.getUrlRedis(fileName, format,fileUrl);
		// http://dcsapi.com/?k=192638169&url=http://222.128.104.201:8096/${fileBase.path
		// }
		return new ModelAndView("redirect:" + dcsUrl);
	}

	@RequestMapping("publish")
	@ResponseBody
	public void publish(HttpServletRequest request, HttpServletResponse response, File_base file_base) {
		JSONObject result = new JSONObject();
		try {
			file_base = fileBaseService.selectById(file_base.getId());
			if (file_base.getStatus() == 4||file_base.getStatus() == 2) {
				file_base.setStatus((byte) 1);
				fileBaseService.update(file_base);
			}
			result.put("flag", true);
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@RequestMapping("/ajax_more")
	public void getMore(int page, long id, Integer page_size, HttpServletResponse response, HttpServletRequest request) throws Exception {
		JSONObject result = new JSONObject();
		int pageSize = 10;
		if (page_size != null) {
			pageSize = page_size;
		}
		int start = pageSize * (page - 1);

		List<UserAppraisView> appraise = userAppraiseService.selectBySourceId(id, start, pageSize, 4);
		long totalAppraise = userAppraiseService.selectCountBySourceId(id, 4);
		boolean flag = totalAppraise > pageSize * page;
		result.put("appraise", appraise);
		result.put("flag", flag);
		ResponseUtil.write(response, result);
	}

	@RequestMapping("/get_dcs")
	public void getDcs(String path, HttpServletResponse response, HttpServletRequest request) throws Exception {
		JSONObject result = new JSONObject();
		// 永中文件转换
		int i = path.lastIndexOf(".");
		String format = path.substring(i);
		String dcsUrl = DcsUtil.getUrlRedis(path, format);
		result.put("path", dcsUrl);
		ResponseUtil.write(response, result);
	}
}
