package cn.bnsr.edu_yun.backstage.resource.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.backstage.base.controller.BaseController;
import cn.bnsr.edu_yun.backstage.base.view.DataGrid;
import cn.bnsr.edu_yun.backstage.base.view.Json;
import cn.bnsr.edu_yun.backstage.resource.service.BackFileService;
import cn.bnsr.edu_yun.backstage.resource.view.BackFileView;
import cn.bnsr.edu_yun.frontstage.resource.po.File_base;
import cn.bnsr.edu_yun.frontstage.resource.po.File_comment;
import cn.bnsr.edu_yun.frontstage.resource.service.FileCommentService;

/**
 * 资源评价后台
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/back_file_comment")
public class BackFileCommentController extends BaseController{
	@Autowired
	private BackFileService backFileService;
	@Autowired
	private FileCommentService fileCommentService;
	/**
	 *跳转页面
	 */
	@RequestMapping("/to_file_comment")
	public ModelAndView toFile(){
		return new ModelAndView("backstage/resource/fileComment/fileComment");
	}
	/**
	 * 获得资源datagrid
	 */
	@RequestMapping("/datagrid")
	public void datagrid(HttpServletResponse response,HttpServletRequest request,BackFileView backFileView) {
		DataGrid j = new DataGrid();
		int rows=backFileView.getRows();
		int page=backFileView.getPage();
		String filename=backFileView.getFilename();
		if(filename==null){
			filename="";
		}
		 int start=rows*(page-1);
		List<File_base> fileBaseList=backFileService.selectByBack("%"+filename+"%", backFileView.getSort(), backFileView.getOrder(), start, rows);
		j.setRows(fileBaseList);
		j.setTotal((long) 100);
		super.writeJson(j,response);
	}
	@RequestMapping("/to_msg")
	public ModelAndView to_comment_msg(HttpServletRequest request,String id) {
		request.setAttribute("id", id);
		return new ModelAndView("backstage/resource/fileComment/comment_msg");
	}
	@RequestMapping("/msg")
	public void msg(HttpServletResponse response,int id,int page,int rows,Integer status) {
		 int start=rows*(page-1);
		 List<File_comment> commentList=fileCommentService.selectCommentByFileIdAll(id, status, start, rows);
		 long total=fileCommentService.selectCountByFile(id, status);
		
		 
		
		DataGrid j = new DataGrid();
		j.setRows(commentList);
		
		  j.setTotal(total);
		super.writeJson(j,response);
	}
	
	@RequestMapping("/forbidden")
	public void forbidden(HttpServletResponse response,String ids) {
		Json j = new Json();
		String[] idsList=ids.split(",");
		for(String id:idsList){
			File_comment comment=new File_comment();
			
			if(id!=null&&!id.trim().equals("")){
				comment.setId(Long.parseLong(id));
				byte status=0;
				comment.setStatus(status);
				fileCommentService.update(comment);
			}
			}
		j.setSuccess(true);
    	j.setMsg("禁止成功！");
    	super.writeJson(j,response);
		
	}
	@RequestMapping("/recovery")
	public void recovery(HttpServletResponse response,String ids) {
		Json j = new Json();
		String[] idsList=ids.split(",");
		for(String id:idsList){
			File_comment comment=new File_comment();
			if(id!=null&&!id.trim().equals("")){
				comment.setId(Long.parseLong(id));
				byte status=1;
				comment.setStatus(status);
				fileCommentService.update(comment);
			}
			}
		j.setSuccess(true);
    	j.setMsg("恢复成功！");
    	super.writeJson(j,response);
		
	}
}
