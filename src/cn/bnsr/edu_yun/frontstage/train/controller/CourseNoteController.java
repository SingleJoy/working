package cn.bnsr.edu_yun.frontstage.train.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.base.po.UserInfo;
import cn.bnsr.edu_yun.frontstage.base.service.UserInfoService;
import cn.bnsr.edu_yun.frontstage.base.service.UserService;
import cn.bnsr.edu_yun.frontstage.base.view.NoteView;
import cn.bnsr.edu_yun.frontstage.base.view.UserCenterView;
import cn.bnsr.edu_yun.frontstage.train.po.CourseNote;
import cn.bnsr.edu_yun.frontstage.train.po.CourseNoteAgree;
import cn.bnsr.edu_yun.frontstage.train.service.CourseNoteAgreeService;
import cn.bnsr.edu_yun.frontstage.train.service.CourseNoteService;
import cn.bnsr.edu_yun.util.NumUtil;
import cn.bnsr.edu_yun.util.ResponseUtil;

@Controller
@RequestMapping("course_note")
public class CourseNoteController {
	private final Logger log = LoggerFactory.getLogger(CourseNoteController.class);
	
	@Autowired
	private CourseNoteService courseNoteService;
	@Autowired
	private CourseNoteAgreeService courseNoteAgreeService;
	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private UserService userService;
	

	@RequestMapping("/getNote")
	public void getNote(CourseNote courseNote, HttpServletResponse response,HttpServletRequest request) throws Exception{
		
			HttpSession session=request.getSession();
			User user=(User) session.getAttribute("currentUser");
			courseNote.setUser_id(user.getId());
			courseNote.setNote_time(new Date());
		//判断
	    CourseNote note = courseNoteService.selectByHourIdAndUserId(user.getId(),courseNote.getCourse_hour_id());
		if(note==null){
			courseNoteService.insert(courseNote);
		}else{
			courseNote.setId(note.getId());
			courseNoteService.update(courseNote);
		}
		
		 JSONObject result=new JSONObject();
    	 result.put("msg", true);
    	
    	 ResponseUtil.write(response, result);
			
			
		}
	
	@RequestMapping("/get_note_m")
	public void getNoteM(CourseNote courseNote, HttpServletResponse response,HttpServletRequest request) throws Exception{
		
			courseNote.setNote_time(new Date());
		//判断
	    CourseNote note = courseNoteService.selectByHourIdAndUserId(courseNote.getUser_id(),courseNote.getCourse_hour_id());
		if(note==null){
			courseNoteService.insert(courseNote);
		}else{
			courseNote.setId(note.getId());
			courseNoteService.update(courseNote);
		}
		
		 JSONObject result=new JSONObject();
    	 result.put("msg", true);
    	
    	 ResponseUtil.write(response, result);
			
			
		}
	/**
	 * 笔记点赞
	 * @param id
	 * @param status
	 * @param response
	 * @param request
	 * @throws Exception
	 */
	@RequestMapping("/agree")
	public void agree(long id,HttpServletResponse response,HttpServletRequest request) throws Exception{
			
		HttpSession session=request.getSession();
	     User user=(User) session.getAttribute("currentUser");
	     
	     int status=courseNoteAgreeService.selectByUserIdAndNoteId(user.getId(), id).size();
	   //note_agree表的增加或删除1，-1
	   //mote表的+1或-1
	     CourseNote courseNote=courseNoteService.selectCountById(id);
	     if(status==0){
	    	 CourseNoteAgree courseNoteAgree=new CourseNoteAgree();
	    	 courseNoteAgree.setUser_id(user.getId());
	    	 courseNoteAgree.setNote_id(id);
			courseNoteAgreeService.insert(courseNoteAgree);
			courseNote.setAgree(courseNote.getAgree()+1);
	     }else{
	    	 courseNoteAgreeService.delete(courseNoteAgreeService.selectByUserIdAndNoteId(user.getId(), id).get(0).getId());
	    	 courseNote.setAgree(courseNote.getAgree()-1);
	     }
	     courseNoteService.update(courseNote);
		
		
		 JSONObject result=new JSONObject();
    	 result.put("msg", true);
    	
    	 ResponseUtil.write(response, result);
			
			
		}
	
	@RequestMapping("/agree_m")
	public void agreeM(long note_id,long user_id,HttpServletResponse response,HttpServletRequest request) throws Exception{
			
		int status=courseNoteAgreeService.selectByUserIdAndNoteId(user_id, note_id).size();
	   //note_agree表的增加或删除1，-1
	   //mote表的+1或-1
	     CourseNote courseNote=courseNoteService.selectCountById(note_id);
	     if(status==0){
	    	 CourseNoteAgree courseNoteAgree=new CourseNoteAgree();
	    	 courseNoteAgree.setUser_id(user_id);
	    	 courseNoteAgree.setNote_id(note_id);
			courseNoteAgreeService.insert(courseNoteAgree);
			courseNote.setAgree(courseNote.getAgree()+1);
	     }else{
	    	 courseNoteAgreeService.delete(courseNoteAgreeService.selectByUserIdAndNoteId(user_id, note_id).get(0).getId());
	    	 courseNote.setAgree(courseNote.getAgree()-1);
	     }
	     courseNoteService.update(courseNote);
		
		
		 JSONObject result=new JSONObject();
    	 result.put("msg", true);
    	
    	 ResponseUtil.write(response, result);
			
			
		}
	/**
	 * 是否点过赞
	 * @param id
	 * @param response
	 * @param request
	 * @throws Exception
	 */
	@RequestMapping("/is_agree")
	public void is_agree(long id,HttpServletResponse response,HttpServletRequest request) throws Exception{
	
		HttpSession session=request.getSession();
	     User user=(User) session.getAttribute("currentUser");
		
int status=courseNoteAgreeService.selectByUserIdAndNoteId(user.getId(), id).size();
		
		
		JSONObject result=new JSONObject();
    	 result.put("status", status==0);
    	
    	 ResponseUtil.write(response, result);
	}
	
	/**
	 * 跳转学习中心
	 * @param request
	 * @return
	 */
	@RequestMapping("/to_my_notes")
	public ModelAndView toMyNotes(HttpServletRequest request,NoteView view) {
		ModelAndView modelAndView = new ModelAndView(
				"frontstage/train/personalCenter/student_notes");
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("currentUser");
		String state = request.getParameter("state");//二级分类标识
		String stamp = request.getParameter("stamp");//一级分类标识
		view.setUser_id(user.getId());
		view.setRows(5);
		if(view.getPage()==0){
			view.setStartLine(0);
		}else{
			view.setStartLine(view.getPage()*view.getRows());
		}
		int total=courseNoteService.queryMyNoteCount(view);
		view.setTotal(total);
		view.setTotalPage(NumUtil.totalPage(total,5));
		List<NoteView> noteViews = courseNoteService.queryMyNote(view);
		modelAndView.addObject("view", view);
		modelAndView.addObject("noteViews", noteViews);
		modelAndView.addObject("state", state);
		modelAndView.addObject("stamp", stamp);

		UserInfo userInfo = userInfoService.getByUserId(user.getId());
		request.setAttribute("user", user);
		request.setAttribute("userInfo", userInfo);
		//个人中心统计数据  
		UserCenterView userCenter = userService.queryUserCenter(user.getId());
		modelAndView.addObject("userCenter", userCenter);
		modelAndView.addObject("head_title", "我的笔记");
		return modelAndView;
	}
	@RequestMapping("/to_my_notes_detail")
	public ModelAndView toMyNotesDetail(HttpServletRequest request,NoteView view) {
		ModelAndView modelAndView = new ModelAndView(
				"frontstage/train/personalCenter/student_notes_detail");
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("currentUser");
		String state = request.getParameter("state");//二级分类标识
		String stamp = request.getParameter("stamp");//一级分类标识
		view.setUser_id(user.getId());
		view.setRows(5);
		if(view.getPage()==0){
			view.setStartLine(0);
		}else{
			view.setStartLine(view.getPage()*view.getRows());
		}
		int total=courseNoteService.queryMyCourseNoteCount(view);
		view.setTotal(total);
		view.setTotalPage(NumUtil.totalPage(total,5));
		List<NoteView> noteViews = courseNoteService.queryMyCourseNote(view);
		if(noteViews.size()>0){
		view.setCourse_picture(noteViews.get(0).getCourse_picture());
		view.setCourse_title(noteViews.get(0).getCourse_title());
		modelAndView.addObject("noteViews", noteViews);
		}
		UserInfo userInfo = userInfoService.getByUserId(user.getId());
		request.setAttribute("user", user);
		request.setAttribute("userInfo", userInfo);
		//个人中心统计数据  
		UserCenterView userCenter = userService.queryUserCenter(user.getId());
		modelAndView.addObject("userCenter", userCenter);
		modelAndView.addObject("head_title", "查看笔记");
		modelAndView.addObject("view", view);
		modelAndView.addObject("state", state);
		modelAndView.addObject("stamp", stamp);
		modelAndView.addObject("user", user);
		return modelAndView;
	}
	/**
	 * 删除笔记
	 * @param id
	 * @param response
	 * @param request
	 * @throws Exception
	 */
	@RequestMapping("/delete_note")
	public void deleteNote(long id,HttpServletResponse response,HttpServletRequest request) throws Exception{
		JSONObject result=new JSONObject();
		
		try {
			courseNoteService.deleteNote(id);
			result.put("msg", "删除成功");
		} catch (Exception e) {
			 result.put("msg", "删除失败");
		}
		ResponseUtil.write(response, result);
	}
}
