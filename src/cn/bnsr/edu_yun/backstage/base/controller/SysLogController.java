package cn.bnsr.edu_yun.backstage.base.controller;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.backstage.base.service.SysLogService;
import cn.bnsr.edu_yun.backstage.base.view.Json;
import cn.bnsr.edu_yun.backstage.base.view.SysLogView;
import cn.bnsr.edu_yun.backstage.base.view.UserView;
import cn.bnsr.edu_yun.util.ExceptionUtil;

/**
 * 系统日志管理
 * @author fangxiongwei
 * @date 2017年6月24日
 */
@Controller
@RequestMapping("/back_syslog")
public class SysLogController extends BaseController{
	private final Logger log = LoggerFactory.getLogger(SysLogController.class);
	@Autowired
	private SysLogService  sysLogService;
	
	/**
	 *跳转日志管理页面
	 */
	@RequestMapping("/to_syslog")
	public ModelAndView toSysLog(){
		return new ModelAndView("backstage/base/syslog/syslog");
	}
	
	/**
	 * 日志datagrid
	 */
	@RequestMapping("/datagrid")
	public void datagrid(HttpServletResponse response,SysLogView sysLogView) {
		super.writeJson(sysLogService.datagrid(sysLogView),response);
	}
	
}
