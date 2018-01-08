package cn.bnsr.edu_yun.backstage.base.controller;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.backstage.base.view.Json;
import cn.bnsr.edu_yun.backstage.base.view.LabelView;
import cn.bnsr.edu_yun.frontstage.base.service.LabelService;
import cn.bnsr.edu_yun.util.ExceptionUtil;

@Controller
@RequestMapping("/back_label")
public class LabelController extends BaseController {

	private final Logger log = LoggerFactory.getLogger(LabelController.class);

	@Autowired
	private LabelService  labelService;


	/**
	 *跳转标签页面
	 */
	@RequestMapping("/to_label")
	public ModelAndView toLabel(){
		return new ModelAndView("backstage/base/label/label");
	}
	
	/**
	 * 获得标签datagrid
	 */
	@RequestMapping("/datagrid")
	public void datagrid(HttpServletResponse response,LabelView labelView) {
		super.writeJson(labelService.datagrid(labelView),response);
	}
	
	/**
	 * 跳转标签添加页面
	 */
	@RequestMapping("/to_label_add")
	public ModelAndView labelAdd() {
		return new ModelAndView("backstage/base/label/label_add");
	}
	
	/**
	 * 标签添加
	 */
	@RequestMapping("/save_label")
	public void add(HttpServletResponse response,LabelView labelView){
		Json j = new Json();
		try {
			labelService.save(labelView);
			j.setSuccess(true);
			j.setMsg("添加成功！");
		} catch (Exception e) {
			log.error("标签添加失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("添加失败！");
		}
		super.writeJson(j,response);
	}

	/**
	 * 标签删除
	 */
	@RequestMapping("/delete_label") 
	public void delete(HttpServletResponse response,LabelView labelView){
		Json j = new Json();
		try{
			labelService.delete(labelView.getIds());
			j.setSuccess(true);
			j.setMsg("删除成功！");
		} catch (Exception e) {
			log.error("标签删除失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("删除失败！");
		}
		
		super.writeJson(j,response);
	}
	
	/**
	 *跳转标签编辑页面
	 */
	@RequestMapping("/to_label_edit") 
	public ModelAndView labelEdit() {
		return new ModelAndView("backstage/base/label/label_edit");
	}
	
	/**
	 * 标签编辑
	 */
	@RequestMapping("/edit_label") 
	public void edit(HttpServletResponse response,LabelView labelView){
		Json j = new Json();
		try {
			labelService.update(labelView);
			j.setSuccess(true);
			j.setMsg("编辑成功！");
		} catch (Exception e) {
			log.error("标签编辑失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("编辑失败！");
		}
		super.writeJson(j,response);
	}

}
