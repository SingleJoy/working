package cn.bnsr.edu_yun.backstage.resource.controller;

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
import cn.bnsr.edu_yun.backstage.resource.service.BackFileService;
import cn.bnsr.edu_yun.backstage.resource.view.BackFileView;
import cn.bnsr.edu_yun.backstage.resource.view.FileDetailView;
import cn.bnsr.edu_yun.frontstage.resource.po.File_base;
import cn.bnsr.edu_yun.frontstage.resource.service.File_baseService;
import cn.bnsr.edu_yun.util.ConfigInfo;
import cn.bnsr.edu_yun.util.ConvertSwf;
import cn.bnsr.edu_yun.util.ExceptionUtil;

/**
 * 资源文档管理
 * @author fangxiongwei
 * @date 2016年9月20日
 */
@Controller
@RequestMapping("/back_file")
public class BackFileController extends BaseController{
	private final Logger log = LoggerFactory.getLogger(BackFileController.class);

	@Autowired
	private BackFileService backFileService;
	@Autowired
	private File_baseService fileBaseService;
	
	/**
	 *跳转资源页面
	 */
	@RequestMapping("/to_file")
	public ModelAndView toFile(){
		return new ModelAndView("backstage/resource/file/file");
	}
	
	/**
	 * 获得资源datagrid
	 */
	@RequestMapping("/datagrid")
	public void datagrid(HttpServletResponse response,HttpServletRequest request,BackFileView backFileView) {
		super.writeJson(backFileService.datagrid(backFileView),response);
	}
	
	/**
	 * 跳转资源添加页面
	 */
	@RequestMapping("/to_file_add")
	public ModelAndView fileAdd() {
		return new ModelAndView("backstage/resource/file/file_add");
	}
	
	/**
	 * 资源添加
	 */
	@RequestMapping("/save_file")
	public void add(HttpServletResponse response,BackFileView backFileView){
		Json j = new Json();
		try {
			backFileService.save(backFileView);
			j.setSuccess(true);
			j.setMsg("添加成功！");
		} catch (Exception e) {
			log.error("资源添加失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("添加失败！");
		}
		super.writeJson(j,response);
	}

	/**
	 * 资源删除
	 */
	@RequestMapping("/delete_file") 
	public void delete(HttpServletResponse response,BackFileView backFileView){
		Json j = new Json();
		try{
			backFileService.delete(backFileView.getIds());
			j.setSuccess(true);
			j.setMsg("删除成功！");
		} catch (Exception e) {
			log.error("资源删除失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("添加失败！");
		}
		
		super.writeJson(j,response);
	}
	
	/**
	 *跳转资源编辑页面
	 */
	@RequestMapping("/to_file_edit") 
	public ModelAndView fileEdit() {
		return new ModelAndView("backstage/resource/file/file_edit");
	}
	
	/**
	 * 资源编辑
	 */
	@RequestMapping("/edit_file") 
	public void edit(HttpServletResponse response,BackFileView backFileView){
		Json j = new Json();
		try {
			backFileService.update(backFileView);
			j.setSuccess(true);
			j.setMsg("编辑成功！");
		} catch (Exception e) {
			log.error("资源编辑失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("编辑失败！");
		}
		super.writeJson(j,response);
	}

	/**
	 *跳转资源审核页面
	 */
	@RequestMapping("/to_review_file") 
	public ModelAndView reviewFile() {
		return new ModelAndView("backstage/resource/file/review_file");
	}
	

	/**
	 * 批量审核资源
	 */
	@RequestMapping("/save_review_file")
	public void saveReviewFile(HttpServletResponse response,BackFileView backFileView){
		Json j = new Json();
		try {
			backFileService.saveReviewFile(backFileView);
			j.setSuccess(true);
			j.setMsg("审核成功！");
		} catch (Exception e) {
			log.error("审核资源失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("审核失败！");
		}
		super.writeJson(j,response);
	}
	
	/**
	 *跳转资源预览页面
	 */
	@RequestMapping("/to_read_file") 
	public ModelAndView readFile(HttpServletRequest request,HttpServletResponse response) {
		ModelAndView modelAndView = new ModelAndView();
		try {
			long id   =	Long.parseLong(request.getParameter("id"));
			File_base fileBase=fileBaseService.selectById(id);
			String folder=ConfigInfo.getString("stream_file_repository");
			String oldName=fileBase.getPath();
			String a1=oldName.substring(oldName.lastIndexOf("/"));
			String a2=a1.substring(0,a1.lastIndexOf("."));
			String newName=folder+a2+".pdf";
			int code = (int)((Math.random() * 9 + 1) * 100000);
		    String uploadPath = request.getSession().getServletContext().getRealPath("/read");
			String swfName="/file"+code+".swf";
			String fileName="file"+code+".swf";
			ConvertSwf c = new ConvertSwf();
			c.convertPdf2Swf(newName,uploadPath+swfName);
			modelAndView.addObject("swfName",fileName);
			modelAndView.setViewName("backstage/resource/file/read_file");
			log.info("转换成功");
		} catch (Exception e) {
			log.error("转换失败",ExceptionUtil.getExceptionMessage(e));
		}
		return modelAndView;
	}
	
	
	/**
	 *跳转资源详细页面
	 */
	@RequestMapping("/to_file_detail") 
	public ModelAndView fileDetail(String file_type,String check) {
		ModelAndView mv = new ModelAndView("backstage/resource/file/file_detail");
		mv.addObject("file_type", file_type);
		mv.addObject("check", check);
		return mv;
	}
	
	/**
	 *查询资源详细
	 */
	@RequestMapping("/query_fileDetail")
	public void queryFileDetail(HttpServletRequest request,HttpServletResponse response){
		Json j = new Json();
		try {
			String id = request.getParameter("id");
			FileDetailView fileDetail = backFileService.queryFileDetail(id);
			j.setObj(fileDetail); 
			j.setMsg("查询成功！");
			j.setSuccess(true);
		} catch (Exception e) {
			log.error("查询失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("查询失败！");
		}
		super.writeJson(j,response);
	}
	
}
