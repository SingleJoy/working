package cn.bnsr.edu_yun.backstage.resource.controller;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.backstage.base.controller.BaseController;
import cn.bnsr.edu_yun.backstage.base.view.Json;
import cn.bnsr.edu_yun.backstage.resource.service.FileAmountService;
import cn.bnsr.edu_yun.backstage.resource.view.AmountView;
import cn.bnsr.edu_yun.util.ExceptionUtil;

/**
 * 文档金额设置
 * @author fangxiongwei
 * @date 2016年10月18日
 */
@Controller
@RequestMapping("/back_file_amount")
public class FileAmountController extends BaseController{
	private final Logger log = LoggerFactory.getLogger(FileAmountController.class);

	@Autowired
	private FileAmountService  fileAmountService;


	/**
	 *跳转金额页面
	 */
	@RequestMapping("/to_amount")
	public ModelAndView toAmount(){
		return new ModelAndView("backstage/resource/fileamount/amount");
	}
	
	/**
	 * 获得金额datagrid
	 */
	@RequestMapping("/datagrid")
	public void datagrid(HttpServletResponse response,AmountView amountView) {
		super.writeJson(fileAmountService.datagrid(amountView),response);
	}
	
	/**
	 * 跳转金额添加页面
	 */
	@RequestMapping("/to_amount_add")
	public ModelAndView amountAdd() {
		return new ModelAndView("backstage/resource/fileamount/amount_add");
	}
	
	/**
	 * 金额添加
	 */
	@RequestMapping("/save_amount")
	public void add(HttpServletResponse response,AmountView amountView){
		Json j = new Json();
		try {
			fileAmountService.save(amountView);
			j.setSuccess(true);
			j.setMsg("添加成功！");
		} catch (Exception e) {
			log.error("金额添加失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("添加失败！");
		}
		super.writeJson(j,response);
	}

	/**
	 * 金额删除
	 */
	@RequestMapping("/delete_amount") 
	public void delete(HttpServletResponse response,AmountView amountView){
		Json j = new Json();
		try{
			fileAmountService.delete(amountView.getIds());
			j.setSuccess(true);
			j.setMsg("删除成功！");
		} catch (Exception e) {
			log.error("金额删除失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("添加失败！");
		}
		
		super.writeJson(j,response);
	}
	
	/**
	 *跳转金额编辑页面
	 */
	@RequestMapping("/to_amount_edit") 
	public ModelAndView amountEdit() {
		return new ModelAndView("backstage/resource/fileamount/amount_edit");
	}
	
	/**
	 * 金额编辑
	 */
	@RequestMapping("/edit_amount") 
	public void edit(HttpServletResponse response,AmountView amountView){
		Json j = new Json();
		try {
			fileAmountService.update(amountView);
			j.setSuccess(true);
			j.setMsg("编辑成功！");
		} catch (Exception e) {
			log.error("金额编辑失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("编辑失败！");
		}
		super.writeJson(j,response);
	}



}
