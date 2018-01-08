package cn.bnsr.edu_yun.frontstage.resource.controller;

import java.io.File;
import java.net.URISyntaxException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.base.po.User_attent;
import cn.bnsr.edu_yun.frontstage.base.service.BookCatService;
import cn.bnsr.edu_yun.frontstage.base.service.PubverListService;
import cn.bnsr.edu_yun.frontstage.base.service.SubjectListService;
import cn.bnsr.edu_yun.frontstage.base.service.UserAttentService;
import cn.bnsr.edu_yun.frontstage.base.service.UserFileService;
import cn.bnsr.edu_yun.frontstage.resource.po.File_base;
import cn.bnsr.edu_yun.frontstage.resource.po.File_property;
import cn.bnsr.edu_yun.frontstage.resource.po.User_file;
import cn.bnsr.edu_yun.frontstage.resource.service.FilePropertyService;
import cn.bnsr.edu_yun.frontstage.resource.service.File_baseService;
import cn.bnsr.edu_yun.frontstage.train.service.UserAppraiseService;
import cn.bnsr.edu_yun.frontstage.train.view.UserAppraisView;
import cn.bnsr.edu_yun.util.ResponseUtil;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/read")
public class ReadFileController {
	private final Logger log = LoggerFactory.getLogger(ReadFileController.class);

	@Autowired
	private File_baseService fileBaseService;
	@Autowired
	private UserAttentService userAttentService;
	@Autowired
	private UserFileService userFileService;
	@Autowired
	private FilePropertyService filePropertyService;
	@Autowired
	private BookCatService bookCatService;
	@Autowired
	private PubverListService pubverListService;
	@Autowired
	private SubjectListService subjectListService;
	@Autowired
	private UserAppraiseService userAppraiseService;

	@RequestMapping("/playFast")
	public String playFast(HttpServletRequest request, HttpServletResponse response, String fileName) throws Exception {
		System.out.println(fileName);
		JSONObject result = new JSONObject();
		result.put("name", fileName);
		ResponseUtil.write(response, result);
		return null;

	}

	@RequestMapping("/toRead")
	public ModelAndView toRead(HttpServletRequest request, HttpServletResponse response) throws URISyntaxException, Exception {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("head_title", "资源展示");
		long id = Long.parseLong(request.getParameter("id"));
		File_base fileBase = fileBaseService.selectById(id);
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("currentUser");
		modelAndView.addObject("user", user);
		if (user != null) {
			long user_id = user.getId();
			long attent_user_id = fileBase.getUpload_user();
			long file_id = fileBase.getId();
			User_attent userAttent = userAttentService.selectattent(user_id, attent_user_id);
			modelAndView.addObject("attented", userAttent != null);
			User_file userFile = userFileService.selectFile(user_id, file_id);
			modelAndView.addObject("userfile", userFile != null);
		}
		//记录点击记录
		if(fileBase.getId()!=null){
			User_file userFile = new User_file();
			userFile.setFile_id(fileBase.getId());
			userFile.setType(Byte.parseByte("6"));
			if(user!=null){
				userFile.setUser_id(user.getId());
			}
			userFile.setTime(new Date());
			int i = userFileService.insert(userFile);
		}
		// 增加点击数
		File_property property = new File_property();
		property.setId(fileBase.getProperty_id());
		property.setClick_times(fileBase.getFile_property().getClick_times() + 1);
		filePropertyService.update(property);
		fileBase.getFile_property().setClick_times(fileBase.getFile_property().getClick_times() + 1);
		 //评分
		//评价总数
		long totalAppraise = userAppraiseService.selectCountBySourceId(fileBase.getId(),4);
		//评价总分
		Integer totalScore=userAppraiseService.selectTotalScore(fileBase.getId(),4);
		int avgScore =0; 
		if (totalAppraise != 0 && totalScore != null){
			avgScore=(int) (totalScore/totalAppraise);
		}else{
			avgScore=5;
		}
		 modelAndView.addObject("totalAppraise", totalAppraise);
		 modelAndView.addObject("avgScore", avgScore);
		 long start=0;
		long pageSize=10;
		List<UserAppraisView> appraise = userAppraiseService.selectBySourceId(fileBase.getId(), start, pageSize, 4);
		 modelAndView.addObject("appraise", appraise);
		
		modelAndView.addObject("fileBase", fileBase);

		modelAndView.setViewName("frontstage/resource/read");
		return modelAndView;
	}

	@RequestMapping("/fileDelete")
	public void fileDelete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String filePath = request.getSession().getServletContext().getRealPath("/read");
		String fileName = request.getParameter("fileName");
		if (!fileName.equals("")) {
			int index = fileName.indexOf(".");
			String fileNameOnly = fileName.substring(0, index);
			File file_self = new File(filePath + "/" + fileName);
			File file_pdf = new File(filePath + "/" + fileNameOnly + ".pdf");
			File file_odt = new File(filePath + "/" + fileNameOnly + ".odt");
			File file_swf = new File(filePath + "/" + fileNameOnly + ".swf");
			if (file_self.exists()) {
				log.info("file_self删除", file_self.delete());
			}
			if (file_self.exists()) {
				log.info("file_pdf删除", file_pdf.delete());
			}
			if (file_self.exists()) {
				log.info("file_swf删除", file_swf.delete());
			}
			if (file_self.exists()) {
				log.info("file_odt删除", file_odt.delete());
			}
		}
	}

}
