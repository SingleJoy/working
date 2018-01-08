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
import cn.bnsr.edu_yun.frontstage.train.service.TrainService;
import cn.bnsr.edu_yun.frontstage.train.view.CourseView;
import cn.bnsr.edu_yun.frontstage.train.view.TrainView;
import cn.bnsr.edu_yun.util.ExceptionUtil;

/**
 * 
 * 后台课程管理
 * @author sunyu
 * @date 2017年7月28日
 */
@Controller
@RequestMapping("/back_train")
public class BackTrainController extends BaseController{
	private final Logger log = LoggerFactory.getLogger(BackTrainController.class);
	
	@Autowired
	private TrainService trainService;
	
	/**
	 *跳转课程管理页面
	 */
	@RequestMapping("/to_back_train")
	public ModelAndView toBackTrain(){
		return new ModelAndView("backstage/train/train/train");
	}
	
	
	/**
	 * 获得课程管理datagrid
	 */
	@RequestMapping("/datagrid")
	public void datagrid(HttpServletResponse response,
			HttpServletRequest request, TrainView trainView) {
		super.writeJson(trainService.datagrid(trainView),response);
	}
	
	/**
	 * 课程删除、关闭
	 */
	@RequestMapping("/update_status") 
	public void updateStatus(HttpServletResponse response,TrainView trainView){
		Json j = new Json();
		try{
			trainService.updateStatus(trainView);
			j.setSuccess(true);
			j.setMsg("操作成功！");
		} catch (Exception e) {
			log.error("培训管理操作失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("操作失败！");
		}
		super.writeJson(j,response);
	}
	
	/**
	 *跳转推荐培训页面
	 */
	@RequestMapping("/to_recommend_train")
	public ModelAndView toRecommendTrain(){
		return new ModelAndView("backstage/train/train/recommend_train");
	}
	
	/**
	 *查询最大推荐课程序号
	 */
	@RequestMapping("/get_max_seq")
	public void getMaxSeq(HttpServletRequest request,HttpServletResponse response){
		Json j = new Json();
		try {
			int seq = trainService.getMaxSeq();
			j.setObj(seq+1); 
			j.setMsg("查询成功！");
			j.setSuccess(true);
		} catch (Exception e) {
			log.error("查询失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("查询失败！");
		}
		super.writeJson(j,response);
	}
	
	/**
	 * 课程推荐、取消推荐
	 */
	@RequestMapping("/is_recommend_train") 
	public void isRecommendTrain(HttpServletResponse response,TrainView trainView){
		Json j = new Json();
		try{
			trainService.isRecommendTrain(trainView);
			j.setSuccess(true);
			j.setMsg("操作成功！");
		} catch (Exception e) {
			log.error("培训操作失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("操作失败！");
		}
		super.writeJson(j,response);
	}
	
	

}
