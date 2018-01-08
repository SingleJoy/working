package cn.bnsr.edu_yun.frontstage.train.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.frontstage.train.po.CourseHour;
import cn.bnsr.edu_yun.frontstage.train.service.ClassService;
import cn.bnsr.edu_yun.frontstage.train.service.CourseHourService;
import cn.bnsr.edu_yun.frontstage.train.view.ClassView;

@Controller
@RequestMapping("/class_question")
public class ClassQuestionController {

	@Autowired
	private CourseHourService courseHourService;
	@Autowired
	private ClassService classService;
	@RequestMapping("/to_class_question")
	public ModelAndView toClassQuestion(HttpServletRequest request,ClassView classView,Integer attribute_type) {
		ModelAndView modelAndView = new ModelAndView();
		if(attribute_type==null){
			attribute_type=0;
		}
		long course_id=classView.getSource_id();
		Integer type = classView.getSource_type();
		Long classId = classView.getId();
		classView = classService.selectOne(classId, type);
		List<CourseHour> courseHours = courseHourService.queryHourListByType(course_id, attribute_type);
		modelAndView.addObject("classView", classView);
		modelAndView.addObject("courseHours", courseHours);
		modelAndView.setViewName("frontstage/train/class/class_question");
		return modelAndView;
	}
	
}
