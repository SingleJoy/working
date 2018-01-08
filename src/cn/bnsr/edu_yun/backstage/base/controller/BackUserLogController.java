package cn.bnsr.edu_yun.backstage.base.controller;

import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.backstage.base.service.UserLogService;
import cn.bnsr.edu_yun.backstage.base.view.UserLogView;
import cn.bnsr.edu_yun.util.ExceptionUtil;

@Controller
@RequestMapping("/back_user_log")
public class BackUserLogController extends BaseController {
	
	private final Logger log = LoggerFactory.getLogger(BackUserLogController.class);
	
	@Autowired
	private UserLogService userLogService;
	
	/**
	 *跳转用户日志页面
	 */
	@RequestMapping("/to_user_log")
	public ModelAndView toUserLog(HttpServletRequest request) {
		return new ModelAndView("backstage/base/userlog/userlog");
	}
	/**
	 * 用户日志datagrid
	 */
	@RequestMapping("/datagrid")
	public void datagrid(HttpServletResponse response,UserLogView userLogView) {
		try {
			super.writeJson(userLogService.datagrid(userLogView),response);
		} catch (ParseException e) {
			log.error("查询用户日志失败",ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}
	}
	
	
	/**
	 *跳转用户登录查看页面
	 */
	@RequestMapping("/to_user_log_see") 
	public ModelAndView userSee(HttpServletRequest request,Long user_id,String username) {
		request.setAttribute("user_id", user_id);
		request.setAttribute("username", username);
		return new ModelAndView("backstage/base/userlog/userlog_see");
	}
	/**
	 *个人用户日志datagrid
	 */
	@RequestMapping("/user_log_datagrid")
	public void userLogDatagrid(HttpServletResponse response,UserLogView userLogView) {
		try {
			super.writeJson(userLogService.datagrid(userLogView),response);
		} catch (ParseException e) {
			log.error("查询用户日志失败",ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}
	}

}
