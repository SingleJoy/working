package cn.bnsr.edu_yun.frontstage.xbjy.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.base.service.UserInfoService;
import cn.bnsr.edu_yun.frontstage.base.service.UserService;
import cn.bnsr.edu_yun.frontstage.xbjy.po.LessonAssess;
import cn.bnsr.edu_yun.frontstage.xbjy.service.LessonAssessService;
import cn.bnsr.edu_yun.frontstage.xbjy.service.LessonProblemService;
import cn.bnsr.edu_yun.frontstage.xbjy.service.LessonService;
import cn.bnsr.edu_yun.frontstage.xbjy.service.LessonUserIdentityService;
import cn.bnsr.edu_yun.frontstage.xbjy.view.LessonAssessView;
import cn.bnsr.edu_yun.frontstage.xbjy.view.LessonView;
import cn.bnsr.edu_yun.util.ExceptionUtil;
import cn.bnsr.edu_yun.util.ResponseUtil;




@Controller
@RequestMapping("/lesson_assess")
public class LessonAssessController {

	private final Logger log = LoggerFactory.getLogger(LessonAssessController.class);

	@Autowired
	private LessonService lessonService;
	@Autowired
	private UserService userService;
	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private LessonUserIdentityService lessonUserIdentityService;
	@Autowired
	private LessonProblemService lessonProblemService;
	@Autowired
	private LessonAssessService lessonAssessService;
	
	
	
	/**
	 * 保存课例评价后更改推优状态
	 */
	@RequestMapping("/save_lesson_assess")
	public ModelAndView saveLessonAssess(HttpServletRequest request, LessonAssessView lessonAssessView){
		User user = (User) request.getSession().getAttribute("currentUser");
		lessonAssessView.setUser_id(user.getId());
		lessonAssessService.saveAll(lessonAssessView);
		LessonView lessonView =new LessonView();
		lessonView.setId(lessonAssessView.getLesson_id());
		lessonView.setExcellent(lessonAssessView.getExcellent());
		lessonService.updateExcellent(lessonView);
		String redirectStr = "redirect:/lesson/to_lesson_evaluation_manage.action?lesson_id="+ lessonAssessView.getLesson_id();
		return new ModelAndView(redirectStr);
	}
	
	
	/**
	 * 是否已经存在评价
	 */
	@RequestMapping("/check_lesson_assess")
	public String checkLessonAssess(HttpServletRequest request, HttpServletResponse response, LessonAssessView lessonAssessView){
		try {
		JSONObject result = new JSONObject();
		User user = (User) request.getSession().getAttribute("currentUser");
		lessonAssessView.setUser_id(user.getId());
		
		List<LessonAssessView> lessonAssessViews =lessonAssessService.findAssess(lessonAssessView);
		result.element("lessonAssess", lessonAssessViews);
		ResponseUtil.write(response, result);
			} catch (Exception e) {
		e.printStackTrace();
		log.error("失败", ExceptionUtil.getExceptionMessage(e));
			}
	return null;
	}
	
	@RequestMapping("/show_assess")
	public String showAssess(HttpServletRequest request, HttpServletResponse response, LessonAssessView lessonAssessView){
		try {
		JSONObject result = new JSONObject();
		
		String id =request.getParameter("id");
		LessonAssess lessonAssess = new LessonAssess();
		lessonAssess=lessonAssessService.getById(Long.parseLong(id));


		result.element("lessonAssess", lessonAssess);
		ResponseUtil.write(response, result);
			} catch (Exception e) {
		e.printStackTrace();
		log.error("失败", ExceptionUtil.getExceptionMessage(e));
			}
	return null;
	}
	
	
}
