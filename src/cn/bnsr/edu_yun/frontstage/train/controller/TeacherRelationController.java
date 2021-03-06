package cn.bnsr.edu_yun.frontstage.train.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.train.service.CourseInfoService;
import cn.bnsr.edu_yun.frontstage.train.service.TeacherRelationService;
import cn.bnsr.edu_yun.frontstage.train.view.CourseView;
import cn.bnsr.edu_yun.frontstage.train.view.TeacherRelationView;
import cn.bnsr.edu_yun.util.ExceptionUtil;

/**
 * 教师关联 0-课程；1-课程班级；2-培训班级
 * @author fangxiongwei
 * @date 2016年11月4日
 */
@Controller
@RequestMapping("/teacher_relation")
public class TeacherRelationController {
	private final Logger log = LoggerFactory.getLogger(TeacherRelationController.class);
	
	@Autowired
	private TeacherRelationService teacherRelationService;
	
	@Autowired
	private CourseInfoService courseInfoService;
	
	
	/**
	 * 跳转教师设置页面
	 */
	@RequestMapping("/to_teacher_relation")
	public ModelAndView toTeacherRelation(HttpServletRequest request,CourseView courseView){
		ModelAndView modelAndView = new ModelAndView();
		try {
			String sign = courseView.getSign();
			String flag = courseView.getFlag();
			if(courseView.getId() != null){
				courseView = courseInfoService.queryCourseDetail(courseView.getId());
			}
			List<TeacherRelationView> teacherList = teacherRelationService.queryTeacherRelation(courseView.getId(),0,null);
			courseView.setSign(sign);
			courseView.setFlag(flag);
			modelAndView.addObject("teacherList",teacherList);	
			modelAndView.addObject("courseView",courseView);	
			modelAndView.setViewName("frontstage/train/course/teacher_relation");
			modelAndView.addObject("head_title", "教师设置");
		} catch (Exception e) {
			log.error("跳转教师设置页面失败",ExceptionUtil.getExceptionMessage(e));
		}
		
		return modelAndView;
	}
	
	/**
	 * 保存教师设置
	 */
	@RequestMapping("/save_teacher_relation")
	public ModelAndView saveTeacherRelation(HttpServletRequest request,TeacherRelationView teacherRelationView){
		String sign = request.getParameter("sign");
		User user = (User) request.getSession().getAttribute("currentUser");
		try {
			teacherRelationService.deleteAllCourseId(0,teacherRelationView.getSource_id(),teacherRelationView.getSource_type());//全删
			teacherRelationService.saveTeacherRelation(teacherRelationView,user.getId());//全加
		} catch (Exception e) {
			log.error("保存教师设置失败",ExceptionUtil.getExceptionMessage(e));
		}
		return new ModelAndView("redirect:/teacher_relation/to_teacher_relation.action?id="
				+ teacherRelationView.getSource_id() + "&flag=1&sign="+sign);
	}
	
	/**
	 * 删除教师
	 */
	@RequestMapping("/delete_teacher")
	public ModelAndView deleteTeacher(HttpServletRequest request){
		String courseId = request.getParameter("courseId");
		String sign = request.getParameter("sign");
		String id = request.getParameter("id");
		try {
			teacherRelationService.deleteTeacher(id);//删除老师
		} catch (Exception e) {
			log.error("删除教师失败",ExceptionUtil.getExceptionMessage(e));
		}
		return new ModelAndView("redirect:/teacher_relation/to_teacher_relation.action?id="
				+ courseId + "&flag=1&sign="+sign);
	}
	
	
}
