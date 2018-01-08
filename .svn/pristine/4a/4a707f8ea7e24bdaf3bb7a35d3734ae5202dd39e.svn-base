package cn.bnsr.edu_yun.backstage.train.controller;


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
import cn.bnsr.edu_yun.backstage.train.view.CourseNoteView;
import cn.bnsr.edu_yun.frontstage.train.service.CourseNoteService;
import cn.bnsr.edu_yun.util.ExceptionUtil;

@Controller
@RequestMapping("/back_course_note")
public class BackCourseNoteController extends BaseController{
	
    private final Logger log = LoggerFactory.getLogger(BackCourseNoteController.class);
	
	@Autowired
	private CourseNoteService courseNoteService;
	
	/**
	 *跳转课堂笔记页面
	 */
	@RequestMapping("/to_course_note")
	public ModelAndView toCourseNote(){
		return new ModelAndView("backstage/train/courseNote/course_note");
	}
	
	/**
	 *跳转详细笔记页面
	 */
	@RequestMapping("/to_course_note_detail")
	public ModelAndView toCourseNoteDetail(HttpServletRequest request,String id){
		ModelAndView modelandview = new ModelAndView();
		try{
			CourseNoteView courseNoteView = null;
			if(id!=null){
				courseNoteView = courseNoteService.getById(Long.parseLong(id.trim()));
				if(courseNoteView.getNote_content()!=null&&courseNoteView.getNote_content()!=""){
			    	courseNoteView.setNote_content(courseNoteView.getNote_content().replace("\"", "\'").trim());
			    }
				if(courseNoteView.getNote_time()!=null){			
					courseNoteView.setNote_time(courseNoteView.getNote_time().replace(".0", ""));
				}
				modelandview.addObject(courseNoteView);
		    	modelandview.setViewName("backstage/train/courseNote/course_note_detail");
			}
		}catch(Exception e){
			log.error("跳转笔记详细信息页面失败",ExceptionUtil.getExceptionMessage(e));
		}
		return modelandview;
	}
	
	/**
	 * 获得课堂笔记datagrid
	 */
	@RequestMapping("/datagrid")
	public void datagrid(HttpServletResponse response,CourseNoteView courseNoteView) {
		super.writeJson(courseNoteService.datagrid(courseNoteView),response);
	}

	/**
	 * 笔记删除
	 */
	@RequestMapping("/delete_course_note") 
	public void delete(HttpServletResponse response,CourseNoteView courseNoteView){
		Json j = new Json();
		try{
			courseNoteService.delete(courseNoteView.getIds());
			j.setSuccess(true);
			j.setMsg("删除成功！");
		} catch (Exception e) {
			log.error("笔记删除失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("删除失败！");
		}
		
		super.writeJson(j,response);
	}
	
	/**
	 * 笔记删除
	 */
	@RequestMapping("/query_course_note") 
	public void queryCourseNote(HttpServletResponse response,CourseNoteView courseNoteView){
		Json j = new Json();
		try{
			if(courseNoteView.getId()!=null){
				courseNoteView = courseNoteService.getById(courseNoteView.getId());
				if(courseNoteView.getNote_content()!=null&&courseNoteView.getNote_content()!=""){
			    	courseNoteView.setNote_content(courseNoteView.getNote_content().replace("\"", "\'").trim());
			    }
			}
			j.setObj(courseNoteView);
			j.setSuccess(true);
			j.setMsg("查询笔记成功！");
		} catch (Exception e) {
			log.error("查询笔记失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("查询失败！");
		}
		
		super.writeJson(j,response);
	}
	
	

}
