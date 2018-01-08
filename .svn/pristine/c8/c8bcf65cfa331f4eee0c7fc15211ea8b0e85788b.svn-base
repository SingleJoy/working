package cn.bnsr.edu_yun.backstage.tiku.controller;

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
import cn.bnsr.edu_yun.backstage.tiku.view.CommentView;
import cn.bnsr.edu_yun.frontstage.tiku.service.CommentService;
import cn.bnsr.edu_yun.util.ExceptionUtil;

/**
 * 作业\试卷 评论
 */
@Controller
@RequestMapping("/back_comment")
public class BackCommentController extends BaseController{

	private final Logger log = LoggerFactory.getLogger(BackCommentController.class);
	
	@Autowired
	private CommentService commentService;
	
	@RequestMapping("/to_comment")
	public ModelAndView toComment(){
		return new ModelAndView("backstage/tiku/comment/comment");
	}
	
	@RequestMapping("/datagrid")
	public void datagrid(HttpServletResponse response,CommentView commentView){
		super.writeJson(commentService.datagrid(commentView), response);
	}
	
	@RequestMapping("/to_comment_detail")
	public ModelAndView toCommentDetail(HttpServletRequest request,String id){
		request.setAttribute("id", id);
		return new ModelAndView("backstage/tiku/comment/comment_detail");
	}
	
	@RequestMapping("/query_detail")
	public void queryDetail(HttpServletRequest request,HttpServletResponse response){
		Json json = new Json();
		try{
			String id = request.getParameter("id");
			CommentView commentView = commentService.getByPrimaryKey((Long.parseLong(id.trim())));
			json.setObj(commentView);
			json.setSuccess(true);
			json.setMsg("查询成功！");
		} catch (Exception e) {
			log.error("详细评语查询失败",ExceptionUtil.getExceptionMessage(e));
			json.setMsg("查询失败！");
		}
		super.writeJson(json,response);
	}
	
	@RequestMapping("/to_comment_add")
	public ModelAndView toCommentAdd(){
		return new ModelAndView("backstage/tiku/comment/comment_add");
	} 
	
	@RequestMapping("/save_comment")
	public void save(HttpServletResponse response,CommentView commentView){
		Json json = new Json();
		try{
			commentService.save(commentView);
			json.setSuccess(true);
			json.setMsg("添加成功");
		}catch(Exception e){
			log.error("评语添加失败",ExceptionUtil.getExceptionMessage(e));
			json.setMsg("添加失败");
		}
		super.writeJson(json, response);
	}
	
	@RequestMapping("/to_comment_edit")
	public ModelAndView toCommentEdit(){
		return new ModelAndView("backstage/tiku/comment/comment_edit");
	}
	
	@RequestMapping("/edit_comment")
	public void edit(HttpServletResponse response,CommentView commentView){
		Json json = new Json();
		try{
			commentService.update(commentView);
			json.setSuccess(true);
			json.setMsg("编辑成功");
		}catch(Exception e){
			log.error("评语编辑失败", ExceptionUtil.getExceptionMessage(e));
			json.setMsg("编辑失败");
		}
		super.writeJson(json, response);
	}
	
	@RequestMapping("/delete_comment")
	public void delete(HttpServletResponse response,CommentView commentView){
		Json json = new Json();
		try{
			commentService.delete(commentView.getIds());
			json.setSuccess(true);
			json.setMsg("删除成功");
		}catch(Exception e){
			log.error("评语删除失败", ExceptionUtil.getExceptionMessage(e));
			json.setMsg("删除失败");
		}
		super.writeJson(json, response);
	}
}
