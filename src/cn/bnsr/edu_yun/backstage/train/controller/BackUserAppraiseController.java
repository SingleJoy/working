package cn.bnsr.edu_yun.backstage.train.controller;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.backstage.base.controller.BaseController;
import cn.bnsr.edu_yun.backstage.base.view.Json;
import cn.bnsr.edu_yun.backstage.base.view.LabelView;
import cn.bnsr.edu_yun.backstage.train.view.UserAppraiseView;
import cn.bnsr.edu_yun.frontstage.base.po.AppraiseReason;
import cn.bnsr.edu_yun.frontstage.train.service.UserAppraiseService;
import cn.bnsr.edu_yun.frontstage.train.view.AppraiseReasonView;
import cn.bnsr.edu_yun.util.ExceptionUtil;

@Controller
@RequestMapping("/back_user_appraise")
public class BackUserAppraiseController extends BaseController {

	private final Logger log = LoggerFactory.getLogger(BackUserAppraiseController.class);
	
	@Autowired
	private UserAppraiseService userAppraiseService;
	
	/**
	 *跳转评价管理页面
	 */
	@RequestMapping("/to_user_appraise")
	public ModelAndView toUserAppraise(){
		return new ModelAndView("backstage/train/userAppraise/user_appraise");
	}
	
	
	/**
	 * 获得评价管理datagrid
	 */
	@RequestMapping("/datagrid")
	public void datagrid(HttpServletResponse response,UserAppraiseView userAppraiseView) {
		super.writeJson(userAppraiseService.datagrid(userAppraiseView),response);
	}

	/**
	 * 评价假删除
	 */
	@RequestMapping("/delete_user_appraise") 
	public void delete(HttpServletResponse response,UserAppraiseView userAppraiseView){
		Json j = new Json();
		try{
			userAppraiseService.updateStatus(userAppraiseView.getIds(), userAppraiseView.getStates());
			j.setSuccess(true);
			j.setMsg("删除成功！");
		} catch (Exception e) {
			log.error("课程评价删除失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("删除失败！");
		}
		
		super.writeJson(j,response);
	}
	
	/**
	 * 评价状态更改
	 */
	@RequestMapping("/change_user_appraise_status") 
	public void doChangeStatus(HttpServletResponse response,UserAppraiseView userAppraiseView){
		Json j = new Json();
		try{
			userAppraiseService.updateStatus(userAppraiseView.getIds(), userAppraiseView.getStates());
			j.setSuccess(true);
			j.setMsg("更改状态成功！");
		} catch (Exception e) {
			log.error("课程评价状态更改失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("更改状态失败！");
		}
		
		super.writeJson(j,response);
	}
	/**
	 *跳转评价项管理页面
	 */
	@RequestMapping("/to_appraise_reason")
	public ModelAndView toAppraiseReason(){
		return new ModelAndView("backstage/train/userAppraise/appraise_reason");
	}
	/**
	 * 获得datagrid
	 */
	@RequestMapping("/datagrid1")
	public void datagrid1(HttpServletResponse response,AppraiseReasonView appraiseReasonview) {
		super.writeJson(userAppraiseService.datagrid(appraiseReasonview),response);
	}
	/**
	 * 跳转评价项添加页面
	 */
	@RequestMapping("/to_appraise_add")
	public ModelAndView appraiseAdd() {
		return new ModelAndView("backstage/train/userAppraise/appraise_reason_add");
	}
	
	/**
	 * 评价项添加
	 */
	@RequestMapping("/save_appraise")
	public void add(HttpServletResponse response,AppraiseReason appraiseReason){
		Json j = new Json();
		try {
			userAppraiseService.saveReason(appraiseReason);
			j.setSuccess(true);
			j.setMsg("添加成功！");
		} catch (Exception e) {
			log.error("标签添加失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("添加失败！");
		}
		super.writeJson(j,response);
	}

	/**
	 * 评价项删除
	 */
	@RequestMapping("/delete_appraise") 
	public void delete(HttpServletResponse response,AppraiseReasonView appraiseReasonview){
		Json j = new Json();
		try{
			userAppraiseService.deleteReason(appraiseReasonview.getId());
			j.setSuccess(true);
			j.setMsg("删除成功！");
		} catch (Exception e) {
			log.error("标签删除失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("删除失败！");
		}
		
		super.writeJson(j,response);
	}
	
	/**
	 *跳转评价项编辑页面
	 */
	@RequestMapping("/to_appraise_edit") 
	public ModelAndView appraiseEdit() {
		return new ModelAndView("backstage/train/userAppraise/appraise_reason_edit");
	}
	
	/**
	 *评价项编辑
	 */
	@RequestMapping("/edit_appraise") 
	public void edit(HttpServletResponse response,AppraiseReason appraiseReason){
		Json j = new Json();
		try {
			userAppraiseService.updateReason(appraiseReason);
			j.setSuccess(true);
			j.setMsg("编辑成功！");
		} catch (Exception e) {
			log.error("标签编辑失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("编辑失败！");
		}
		super.writeJson(j,response);
	}

}
