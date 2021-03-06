package cn.bnsr.edu_yun.frontstage.train.controller;

import java.io.File;
import java.util.Date;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.frontstage.base.view.ImageView;
import cn.bnsr.edu_yun.frontstage.train.service.CourseInfoService;
import cn.bnsr.edu_yun.frontstage.train.view.CourseView;
import cn.bnsr.edu_yun.util.ConfigInfo;
import cn.bnsr.edu_yun.util.ExceptionUtil;
import cn.bnsr.edu_yun.util.ImageUtil;
import cn.bnsr.edu_yun.util.ResponseUtil;

/**
 * 课程详细信息
 * @author fangxiongwei
 * @date 2016年10月25日
 */
@Controller
@RequestMapping("/course_info")
public class CourseInfoController {
	private final Logger log = LoggerFactory.getLogger(CourseInfoController.class);
	
	@Autowired
	private CourseInfoService courseInfoService;
	
	/**
	 * 跳转课程详细信息页面
	 */
	@RequestMapping("/to_course_detail")
	public ModelAndView toCourseDetail(HttpServletRequest request,CourseView courseView){
		ModelAndView modelAndView = new ModelAndView();
		try {
			String sign = courseView.getSign();
			String flag = courseView.getFlag();
			if(courseView.getId() != null){
				courseView = courseInfoService.queryCourseDetail(courseView.getId());
			}
			courseView.setSign(sign);
			courseView.setFlag(flag);
			if(courseView.getProfile() != null && !courseView.getProfile().equals("")){
				courseView.setProfile(courseView.getProfile().replace("\"", "\'").trim());
			}
			modelAndView.addObject("courseView",courseView);	
			if(sign.equals("2")){
				modelAndView.addObject("head_title", "详细信息");
				modelAndView.setViewName("frontstage/train/course/course_detail");
			}else if(sign.equals("3")){
				modelAndView.addObject("head_title", "课程图片");
				modelAndView.setViewName("frontstage/train/course/course_picture");
			}else if(sign.equals("6")){
				modelAndView.addObject("head_title", "价格设置");
				modelAndView.setViewName("frontstage/train/course/course_price");
			}
		} catch (Exception e) {
			log.error("跳转课程详细信息页面失败",ExceptionUtil.getExceptionMessage(e));
		}
		
		return modelAndView;
	}
	
	/**
	 * 保存课程详细信息
	 */
	@RequestMapping("/save_course_detail")
	public ModelAndView saveCourseDetail(HttpServletRequest request,CourseView courseView,ImageView imageView){
		try {
			if(imageView.getX()!=null){
				 ImageUtil util=new ImageUtil();
				 String img=courseView.getImg();
				System.out.println(request.getContextPath()+img);
           String url=request.getSession().getServletContext().getRealPath("")+img;
				 util.cut(url, url, imageView.getX(), imageView.getY(), imageView.getW(), imageView.getH(), imageView.getWidth(), imageView.getHeight());
			}
			courseInfoService.updateCourseDetail(courseView);
		} catch (Exception e) {
			log.error("保存课程详细信息失败",ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}
		return new ModelAndView("redirect:/course_info/to_course_detail.action?id="
				+ courseView.getId() + "&flag=1&sign="+courseView.getSign());
	}
	
	
	 @RequestMapping("/upload_img")
	 public void upload(@RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request,HttpServletResponse response) throws Exception {
		 
		 String path = request.getSession().getServletContext().getRealPath(ConfigInfo.getString("coursePicture"));
		 Date date=new Date();
		 long time=date.getTime();
	     String fileName = "img"+time;
		 String format=file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
	     Random ra =new Random();
	     fileName = fileName+ ra.nextInt(10) + format;
		 File targetFile = new File(path, fileName);  
         if(!targetFile.exists()){  
             targetFile.mkdirs();  
         }  
         //保存  
         try {  
             file.transferTo(targetFile);  
         } catch (Exception e) {  
             e.printStackTrace();  
         }  
		 JSONObject result=new JSONObject();
		 result.put("fileName", ConfigInfo.getString("coursePicture")+"/"+fileName);
		 ResponseUtil.write(response, result);
		 
	 }
}
