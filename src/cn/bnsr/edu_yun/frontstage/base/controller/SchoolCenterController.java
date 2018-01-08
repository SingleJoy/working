package cn.bnsr.edu_yun.frontstage.base.controller;

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

import cn.bnsr.edu_yun.backstage.base.controller.BaseController;
import cn.bnsr.edu_yun.backstage.base.view.Json;
import cn.bnsr.edu_yun.frontstage.base.po.Area;
import cn.bnsr.edu_yun.frontstage.base.po.Grade;
import cn.bnsr.edu_yun.frontstage.base.po.PubverList;
import cn.bnsr.edu_yun.frontstage.base.po.School;
import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.base.po.UserInfo;
import cn.bnsr.edu_yun.frontstage.base.service.AreaService;
import cn.bnsr.edu_yun.frontstage.base.service.GradeService;
import cn.bnsr.edu_yun.frontstage.base.service.PubverListService;
import cn.bnsr.edu_yun.frontstage.base.service.SchoolService;
import cn.bnsr.edu_yun.frontstage.base.service.UserInfoService;
import cn.bnsr.edu_yun.frontstage.base.service.UserService;
import cn.bnsr.edu_yun.frontstage.base.view.UserInfoView;
import cn.bnsr.edu_yun.frontstage.train.service.CourseService;
import cn.bnsr.edu_yun.frontstage.train.view.SchoolCenterView;
import cn.bnsr.edu_yun.util.NumUtil;

@Controller
@RequestMapping("school_center")
public class SchoolCenterController extends BaseController{
	private final Logger log = LoggerFactory.getLogger(SchoolCenterController.class);
	
	@Autowired
	private CourseService courseService;
	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private GradeService gradeService;
	@Autowired
	private PubverListService pubverService;
	@Autowired
	private UserService userService;
	@Autowired
	private SchoolService schoolService;
	@Autowired
	private AreaService areaService;
	
	@RequestMapping("/query_course")
	public ModelAndView queryCourse(HttpServletRequest request,SchoolCenterView view) {
		ModelAndView modelAndView = new ModelAndView(
				"frontstage/base/personalCenter/school_course");
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("currentUser");
		String state = request.getParameter("state");//二级分类标识
		String stamp = request.getParameter("stamp");//一级分类标识
		UserInfo userInfo = userInfoService.getByUserId(user.getId());
		view.setSchool_id(userInfo.getSchool_id());
		view.setRows(5);
		if(view.getPage()==0){
			view.setStartLine(0);
		}else{
			view.setStartLine(view.getPage()*view.getRows());
		}
		int total=courseService.querySchoolCourseCount(view);
		view.setTotal(total);
		view.setTotalPage(NumUtil.totalPage(total,5));
		List<SchoolCenterView> schoolCenterViews = courseService.querySchoolCourse(view);
		
		modelAndView.addObject("view", view);
		modelAndView.addObject("schoolCenterViews", schoolCenterViews);

		modelAndView.addObject("state", state);
		modelAndView.addObject("stamp", stamp);
		modelAndView.addObject("user", user);
		modelAndView.addObject("head_title", "学校课程");
		return modelAndView;
	}
	@RequestMapping("/query_teacher")
	public ModelAndView queryTeacher(HttpServletRequest request,SchoolCenterView view) {
		ModelAndView modelAndView = new ModelAndView(
				"frontstage/base/personalCenter/school_teacher");
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("currentUser");
		String state = request.getParameter("state");//二级分类标识
		String stamp = request.getParameter("stamp");//一级分类标识
		UserInfo userInfo = userInfoService.getByUserId(user.getId());
		view.setSchool_id(userInfo.getSchool_id());
		view.setRows(5);
		if(view.getPage()==0){
			view.setStartLine(0);
		}else{
			view.setStartLine(view.getPage()*view.getRows());
		}
		int total=courseService.querySchoolTeacherCount(view);
		view.setTotal(total);
		view.setTotalPage(NumUtil.totalPage(total,5));
		List<SchoolCenterView> schoolCenterViews = courseService.querySchoolTeacher(view);
		
		modelAndView.addObject("view", view);
		modelAndView.addObject("schoolCenterViews", schoolCenterViews);


		modelAndView.addObject("state", state);
		modelAndView.addObject("stamp", stamp);
		modelAndView.addObject("user", user);
		modelAndView.addObject("head_title", "学校老师");
		return modelAndView;
	}
	@RequestMapping("/query_resourse")
	public ModelAndView queryResourse(HttpServletRequest request,SchoolCenterView view) {
		ModelAndView modelAndView = new ModelAndView(
				"frontstage/base/personalCenter/school_resourse");
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("currentUser");
		String state = request.getParameter("state");//二级分类标识
		String stamp = request.getParameter("stamp");//一级分类标识
		UserInfo userInfo = userInfoService.getByUserId(user.getId());
		view.setSchool_id(userInfo.getSchool_id());
		view.setRows(5);
		if(view.getPage()==0){
			view.setStartLine(0);
		}else{
			view.setStartLine(view.getPage()*view.getRows());
		}
		int total=courseService.querySchoolResourseCount(view);
		view.setTotal(total);
		view.setTotalPage(NumUtil.totalPage(total,5));
		List<SchoolCenterView> schoolCenterViews = courseService.querySchoolResourse(view);
		
		modelAndView.addObject("view", view);
		modelAndView.addObject("schoolCenterViews", schoolCenterViews);
		modelAndView.addObject("head_title", "学校资源");
		modelAndView.addObject("state", state);
		modelAndView.addObject("stamp", stamp);
		modelAndView.addObject("user", user);
		return modelAndView;
	}
	@RequestMapping("/to_msg")
 	public void to_msg(HttpServletRequest request,HttpServletResponse response,long id,int status) {
		Json j = new Json();
		try {
			UserInfo info=userInfoService.selectById(id);
	 		UserInfoView userInfo = new UserInfoView();
	 		userInfo.setTrue_name(info.getTrue_name());
	 		userInfo.setSex(info.getSex());
	 		userInfo.setID_number(info.getID_number());
	 		userInfo.setCourse(info.getCourse());
	 		userInfo.setSchool(info.getSchool());
	 		userInfo.setPicture1(info.getPicture1());
	 		userInfo.setPicture2(info.getPicture2());
	 		userInfo.setPicture3(info.getPicture3());
	 		userInfo.setUser_id(info.getUser_id());
			User user=userService.selectByPrimaryKey(info.getUser_id());
	 		userInfo.setEmail(user.getEmail());
	 		userInfo.setPhone(user.getPhone());
	 		Grade grade=	gradeService.selectById(info.getGrade_id());
	 		userInfo.setGrade(grade.getGrade_name());
	 		PubverList pubver	=pubverService.selectById(info.getPubver_id());
	 		userInfo.setPubver(pubver.getVersionName());
	  		School school=schoolService.selectById(info.getSchool_id());
	  		Area province=areaService.selectByid(school.getProvinceId());
	  		Area city=areaService.selectByid(school.getCityId());
	  		Area county=areaService.selectByid(school.getCountyId());
	  		userInfo.setProvince(province==null?"":province.getArea_name());
	  		userInfo.setCity(city==null?"":city.getArea_name());
	  		userInfo.setCounty(county==null?"":county.getArea_name());
	  		userInfo.setStatus(status);
	  		j.setObj(userInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		super.writeJson(j,response);
	
	}
}
