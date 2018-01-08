package cn.bnsr.edu_yun.backstage.base.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.backstage.base.service.BackUserService;
import cn.bnsr.edu_yun.backstage.base.view.PageBase;
import cn.bnsr.edu_yun.backstage.base.view.UserTrackView;
import cn.bnsr.edu_yun.util.ExceptionUtil;

@Controller
@RequestMapping("/back_user_track")
public class UserTrackController  extends BaseController{
	
	private final Logger log = LoggerFactory.getLogger(UserTrackController.class);
	@Autowired
	private BackUserService backUserService;
	
	/**
	 * 获得datagrid
	 * @throws Exception 
	 */
	@RequestMapping("/datagrid")
	public void datagrid(HttpServletResponse response,UserTrackView userTrackview) throws Exception {
		super.writeJson(backUserService.datagridTrack(userTrackview),response);
	}
	/**
	 *跳转评价项管理页面
	 */
	@RequestMapping("/to_user_track")
	public ModelAndView toUserTrack(){
		return new ModelAndView("backstage/base/userTrack/userTrack");
	}
	
	@RequestMapping("/to_user_log_see") 
	public ModelAndView userSee(HttpServletRequest request,Long user_id,String username,int index) {
		request.setAttribute("user_id", user_id);
		request.setAttribute("username", username);
		request.setAttribute("index", index);
		return new ModelAndView("backstage/base/userTrack/userTrack_see");
	}
	
	@RequestMapping("/user_track_datagrid")
	public void userTrackDatagrid(HttpServletResponse response,Long user_id,int index,PageBase p) {
		try {
			//index 0~11
			super.writeJson(backUserService.datagridTrackIndex(user_id,index,p),response);
		//	super.writeJson(userLogService.datagrid(userLogView),response);
		} catch (Exception e) {
			log.error("查询用户日志失败",ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}
	}
}
