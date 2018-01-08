package cn.bnsr.edu_yun.frontstage.train.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.train.po.CourseHourFile;
import cn.bnsr.edu_yun.frontstage.train.service.CourseFileService;
import cn.bnsr.edu_yun.frontstage.train.service.CourseHourFileService;
import cn.bnsr.edu_yun.frontstage.train.view.CourseFileView;
import cn.bnsr.edu_yun.frontstage.train.view.CourseHourFileView;
import cn.bnsr.edu_yun.util.ConfigInfo;
import cn.bnsr.edu_yun.util.ExceptionUtil;
import net.sf.json.JSONArray;

/**
 * 课时子文件管理
 * @author fangxiongwei
 * @date 2016年11月9日
 */
@Controller
@RequestMapping("/course_hour_file")
public class CourseHourFileController {
	private final Logger log = LoggerFactory.getLogger(CourseHourFileController.class);
	
	@Autowired
	private CourseHourFileService courseHourFileService;
	@Autowired
	private CourseFileService courseFileService;
	
	/**
	 * 保存课时子文件
	 */
	@RequestMapping("/save_hour_file")
	public ModelAndView saveHourFile(HttpServletRequest request,CourseHourFile courseHourFile){
		String courseId = request.getParameter("courseId");
		String sign = request.getParameter("sign");
		try {
			courseHourFileService.saveHourFile(courseHourFile);
		} catch (Exception e) {
			log.error("保存课时子文件失败",ExceptionUtil.getExceptionMessage(e));
		}
		return new ModelAndView("redirect:/course_hour/to_course_hour.action?id="
				+ courseId + "&flag=1&sign="+sign+"&ver="+Math.random());
	}
	
	@RequestMapping("/get_hour_file")
	@ResponseBody
	public JSONArray getHourFile(HttpServletRequest request){
		String hourId=request.getParameter("hourId");
		List<CourseHourFileView> chfList = courseHourFileService.getHourFile(hourId);
		return JSONArray.fromObject(chfList);
	}
	
	
	/**
	 * 删除课时子文件
	 */
	@RequestMapping("/delete_hour_file")
	public ModelAndView deleteHourFile(HttpServletRequest request){
		String courseId = request.getParameter("courseId");
		String sign = request.getParameter("sign");
		String id = request.getParameter("id");
		try {
			courseHourFileService.deleteHourFile(id);
		} catch (Exception e) {
			log.error("删除课时子文件失败",ExceptionUtil.getExceptionMessage(e));
		}
		return new ModelAndView("redirect:/course_hour/to_course_hour.action?id="
				+ courseId + "&flag=1&sign="+sign+"&ver="+Math.random());
	}
	
	@RequestMapping("to_look_course_materials")
	public ModelAndView lookCourseMaterials(HttpServletRequest request,CourseHourFileView courseHourFileView){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/user/home.action");
		User user = (User) request.getSession().getAttribute("currentUser");
		try{
			if(user==null){
				return mv;
			}
			courseHourFileView.setUser_id(user.getId());
			//验证用户是否有权浏览资料
			//角色1：建课老师
			CourseFileView courseFileView = courseFileService.getCourseFileByCourseHourFileIsTeacher(courseHourFileView);
			if(courseFileView!=null){
				String file_server_path = ConfigInfo.getString("file_server_path");
				mv.addObject("file_server_path",file_server_path);
				mv.addObject("courseFileView",courseFileView);
				mv.setViewName("frontstage/train/course_show/course_materials_look");
				return mv;
			}
			CourseFileView courseFileView2 = courseFileService.getCourseFileByCourseHourFileIsStudent(courseHourFileView);
			if(courseFileView2!=null){
				String file_server_path = ConfigInfo.getString("file_server_path");
				mv.addObject("file_server_path",file_server_path);
				//角色2：班级学生
				mv.addObject("courseFileView",courseFileView2);
				mv.setViewName("frontstage/train/course_show/course_materials_look");
				return mv;
			}
		}catch(Exception e){
			log.error("浏览资料失败",ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}
		return mv;
	}
}
