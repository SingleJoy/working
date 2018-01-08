package cn.bnsr.edu_yun.backstage.lesson.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.backstage.base.controller.BaseController;
import cn.bnsr.edu_yun.backstage.base.view.Json;
import cn.bnsr.edu_yun.frontstage.xbjy.po.Lesson;
import cn.bnsr.edu_yun.frontstage.xbjy.service.LessonService;
import cn.bnsr.edu_yun.frontstage.xbjy.view.LessonView;
import cn.bnsr.edu_yun.util.ExceptionUtil;

@Controller
@RequestMapping("/back_lesson")
public class BackLessonController extends BaseController {
	private final Logger log = LoggerFactory.getLogger(BackLessonController.class);
	
	@Autowired
	private LessonService lessonService;
	
	/**
	 *跳转课例页面
	 */
	@RequestMapping("/to_lesson")
	public ModelAndView toLesson(HttpServletRequest request) {
		return new ModelAndView("backstage/lesson/lesson");
	}
	
	/**
	 * 课例datagrid
	 */
	@RequestMapping("/datagrid")
	public void datagrid(HttpServletResponse response,LessonView lessonView) {
		super.writeJson(lessonService.datagrid(lessonView),response);
	}
	
	/**
	 *跳转推荐课例页面
	 */
	@RequestMapping("/to_recommend_lesson")
	public ModelAndView toRecommendLesson(HttpServletRequest request) {
		return new ModelAndView("backstage/lesson/recommend_lesson");
	}
	
	/**
	 * 推荐时获取最大推荐序号
	 * @throws Exception 
	 */
	@RequestMapping("/get_max_seq")
	public void getMaxSeq(HttpServletResponse response,Long workshop_id){
	    
		Json j = new Json();
		try{
			Long seq = lessonService.getMaxSeq(workshop_id);
			if(seq!=null){
				j.setObj(seq+1);
			}else{
				j.setObj(1);
			}
			j.setSuccess(true);
			j.setMsg("操作成功！");
		} catch (Exception e) {
			log.error("获取最大推荐序号操作失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("操作失败！");
		}
		super.writeJson(j,response);
	}
	
	
	/**
	 * 课例开启关闭
	 */
	@RequestMapping("/update_open_status") 
	public void updateOpenStatus(HttpServletResponse response,String ids,Integer open_status){
		Json j = new Json();
		try{
			for(String id:ids.split(",")){
				Lesson lesson = new Lesson();
				lesson.setId(Long.parseLong(id));
				lesson.setOpen_status(open_status);
				lessonService.update(lesson);
			}
			j.setSuccess(true);
			j.setMsg("更改状态成功！");
		} catch (Exception e) {
			log.error("课例状态更改失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("更改状态失败！");
		}
		
		super.writeJson(j,response);
	}

}
