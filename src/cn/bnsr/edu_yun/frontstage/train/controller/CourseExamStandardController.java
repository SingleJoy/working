package cn.bnsr.edu_yun.frontstage.train.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.frontstage.train.service.CertificateService;
import cn.bnsr.edu_yun.frontstage.train.service.CourseExamStandardService;
import cn.bnsr.edu_yun.frontstage.train.service.CourseInfoService;
import cn.bnsr.edu_yun.frontstage.train.view.CertificatesView;
import cn.bnsr.edu_yun.frontstage.train.view.CourseExamStandardView;
import cn.bnsr.edu_yun.frontstage.train.view.CourseView;
import cn.bnsr.edu_yun.util.ExceptionUtil;
import cn.bnsr.edu_yun.util.ResponseUtil;

@Controller
@RequestMapping("/course_exam_standard")
public class CourseExamStandardController {

	private final Logger log = LoggerFactory.getLogger(CourseExamStandardController.class);
	
	@Autowired
	private CourseExamStandardService courseExamStandardService;
	
	@Autowired
	private CertificateService certificateService;
	
	@Autowired
	private CourseInfoService courseInfoService;
	
	/**
	 * 
	 * TODO 跳转设置考核标准页面
	 * @param request
	 * @param courseView
	 * @return
	 */
	@RequestMapping("/to_course_exam_standard")
	public ModelAndView toCourseExamStandard(HttpServletRequest request,CourseView courseView,CourseExamStandardView examStandardView){
		ModelAndView modelAndView = new ModelAndView();
		List<CertificatesView> certificatesViews = null;
		try{
			String sign = courseView.getSign();
			String flag = courseView.getFlag();
			Long courseid = courseView.getId();
			if(courseid!=null){
				CertificatesView certificatesView = new CertificatesView();
				certificatesView.setSource_id(courseid.toString());
				certificatesView.setSource_type("1");
				courseView = courseInfoService.queryCourseDetail(courseid);
				certificatesViews = certificateService.findAll(certificatesView);
			}
			if(courseView!=null){
				courseView.setSign(sign);
				courseView.setFlag(flag);
				modelAndView.addObject("courseView",courseView);
			}
			if(certificatesViews!=null){
				modelAndView.addObject("certificatesViews",certificatesViews);
			}
			examStandardView.setSource_type("0");
			modelAndView.addObject("jobStandard",courseExamStandardService.queryStandard(examStandardView));
			examStandardView.setSource_type("1");
			modelAndView.addObject("discussionStandard",courseExamStandardService.queryStandard(examStandardView));
			examStandardView.setSource_type("2");
			modelAndView.addObject("examStandard",courseExamStandardService.queryStandard(examStandardView));
			modelAndView.setViewName("frontstage/train/course/course_exam_standard");
			modelAndView.addObject("head_title", "考核标准设置");
		}catch(Exception e){
			e.printStackTrace();
			log.error("跳转考核标准页面失败", ExceptionUtil.getExceptionMessage(e));
		}
		return modelAndView;
	}
	
	/**
	 * 
	 * TODO 保存考核标准设置
	 * @param request
	 * @param certificatesView
	 * @return
	 */
	@RequestMapping("/update_course_exam_standard")
	public ModelAndView saveCouresExamStandard(HttpServletRequest request,CertificatesView certificatesView,CourseExamStandardView examStandardView){
		String courseId = request.getParameter("courseId");
		String sign = request.getParameter("sign");
		try{
			courseExamStandardService.update(examStandardView);
			certificateService.saveOrUpdate(certificatesView);
		}catch(Exception e){
			e.printStackTrace();
			log.error("保存考核标准设置失败", ExceptionUtil.getExceptionMessage(e));
		}
		return new ModelAndView("redirect:/course_exam_standard/to_course_exam_standard.action?id="
				+ courseId + "&flag=1&sign="+sign+"&course_id="+courseId);
	}
	
	@RequestMapping("/del_certificate")
	@ResponseBody
	public String delCertificate(HttpServletResponse response, String ids) {
		try {
			JSONObject result = new JSONObject();
			certificateService.deleteCertificates(ids);
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			e.printStackTrace();
			log.error("跳转失败", ExceptionUtil.getExceptionMessage(e));
		}
		return null;
	}
	
}
