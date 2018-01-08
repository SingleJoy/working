package cn.bnsr.edu_yun.backstage.base.controller;

import java.io.OutputStream;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.backstage.base.po.Auth;
import cn.bnsr.edu_yun.backstage.base.service.AuthService;
import cn.bnsr.edu_yun.backstage.base.service.BackUserService;
import cn.bnsr.edu_yun.backstage.base.service.RoleService;
import cn.bnsr.edu_yun.backstage.base.service.SysLogService;
import cn.bnsr.edu_yun.backstage.base.view.Json;
import cn.bnsr.edu_yun.backstage.base.view.SessionInfo;
import cn.bnsr.edu_yun.backstage.base.view.UserDurationView;
import cn.bnsr.edu_yun.backstage.base.view.UserStatsView;
import cn.bnsr.edu_yun.backstage.base.view.UserView;
import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.base.service.UserDurationService;
import cn.bnsr.edu_yun.frontstage.base.service.UserService;
import cn.bnsr.edu_yun.listener.SessionListener;
import cn.bnsr.edu_yun.util.ExceptionUtil;
import cn.bnsr.edu_yun.util.ExportExcel;
import cn.bnsr.edu_yun.util.HttpRequest;
import cn.bnsr.edu_yun.util.IpUtil;
import cn.bnsr.edu_yun.util.MD5;
import cn.bnsr.edu_yun.util.ResponseUtil;
import cn.bnsr.edu_yun.util.TimeUtil;
import cn.bnsr.edu_yun.util.UserLog;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/back_user")
public class BackUserController extends BaseController {
	private final Logger log = LoggerFactory.getLogger(BackUserController.class);

	@Autowired
	private BackUserService backUserService;
	@Autowired
	private UserService userService;
	@Autowired
	private AuthService authService;
	@Autowired
	private  RoleService roleService;
	@Autowired
	private SysLogService sysLogService;
	@Autowired
	private UserDurationService userDurationService;

	/**
	 * 跳转用户页面
	 */
	@RequestMapping("/to_user")
	public ModelAndView user(HttpServletRequest request, UserView userView) {
		request.setAttribute("user_type", userView.getUser_type());
		return new ModelAndView("backstage/base/user/user");
	}

	/**
	 * 用户datagrid
	 */
	@RequestMapping("/datagrid")
	public void datagrid(HttpServletResponse response, UserView userView) {
		try {
			super.writeJson(backUserService.datagrid(userView), response);
		} catch (ParseException e) {
			log.error("用户查寻失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}
	}

	/**
	 * 跳转用户添加页面
	 */
	@RequestMapping("/to_user_add")
	public ModelAndView userAdd(HttpServletRequest request, UserView userView) {
		request.setAttribute("user_type", userView.getUser_type());
		return new ModelAndView("backstage/base/user/user_add");
	}

	/**
	 * 用户添加
	 */
	@RequestMapping("/save_user")
	public void add(HttpServletResponse response, HttpServletRequest request, UserView userView) {
		Json j = new Json();
		// 获取用户登录的外网IP
		String networkIp = IpUtil.getIpAddr(request);
		if ("".equals(networkIp)) {
			networkIp = request.getRemoteAddr();
		}
		networkIp = StringUtils.isBlank(networkIp) ? "" : networkIp;
		try {
			userView.setSign_ip(networkIp);
			userView.setSign_type(2);
			backUserService.save(userView);
			j.setSuccess(true);
			j.setMsg("添加成功！");
		} catch (Exception e) {
			log.error("用户添加失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
			j.setMsg("添加失败！");
		}
		super.writeJson(j, response);
	}

	/**
	 * 删除一个用户
	 */
	@RequestMapping("/delete_user")
	public void delete(HttpServletResponse response, UserView userView) {
		Json j = new Json();
		try {
			backUserService.delete(userView.getIds());
			j.setSuccess(true);
			j.setMsg("删除成功！");
		} catch (Exception e) {
			log.error("用户删除失败", ExceptionUtil.getExceptionMessage(e));
			j.setMsg("删除失败！");
		}
		super.writeJson(j, response);
	}

	/**
	 * 跳转用户编辑页面
	 */
	@RequestMapping("/to_user_edit")
	public ModelAndView userEdit(HttpServletRequest request, UserView userView) {
		request.setAttribute("user_type", userView.getUser_type());
		return new ModelAndView("backstage/base/user/user_edit");
	}

	/**
	 * 跳转用户查看页面
	 */
	@RequestMapping("/to_user_see")
	public ModelAndView userSee(HttpServletRequest request, UserView userView) {
		request.setAttribute("user_type", userView.getUser_type());
		return new ModelAndView("backstage/base/user/user_see");
	}

	/**
	 * 跳转用户密码编辑页面
	 */
	@RequestMapping("/to_user_password_edit")
	public ModelAndView userPasswordEdit(HttpServletRequest request, UserView userView) {
		request.setAttribute("user_type", userView.getUser_type());
		return new ModelAndView("backstage/base/user/user_password_edit");
	}

	/**
	 * 用户编辑
	 */
	@RequestMapping("/edit_user")
	public void edit(HttpServletResponse response, UserView userView) {
		Json j = new Json();
		try {
			String password = userView.getPassword();
			if(password!=null){
				if(password.length()==0||HttpRequest.paramValidate(password)){
					throw new Exception();
				}else{
					userView.setPassword(MD5.MD5c(password));
				}
			}
			backUserService.update(userView);
			j.setSuccess(true);
			j.setMsg("编辑成功!");
		} catch (Exception e) {
			log.error("用户编辑失败", ExceptionUtil.getExceptionMessage(e));
			j.setMsg("编辑失败！");
		}
		super.writeJson(j, response);
	}

	/**
	 * 验证用户名\手机号是否存在
	 */
	@RequestMapping("/doNotNeedSession_checkExis")
	public void doNotNeedSession_checkExis(HttpServletResponse response, UserView userView) {
		Json j = new Json();
		String exis = "";
		try {
			exis = backUserService.checkExis(userView);
			j.setSuccess(true);
			j.setMsg(exis);
		} catch (Exception e) {
			log.error("验证用户失败", ExceptionUtil.getExceptionMessage(e));
			j.setMsg(exis);
		}
		super.writeJson(j, response);
	}

	/**
	 * 禁用、启用用户
	 */
	@RequestMapping("/doNotNeedSession_doChangeStatus")
	public void doNotNeedSession_doChangeStatus(HttpServletResponse response, UserView userView) {
		Json j = new Json();
		try {
			backUserService.doChangeStatus(userView);
			j.setSuccess(true);
			j.setMsg("修改成功！");
		} catch (Exception e) {
			log.error("禁用、启用用户失败", ExceptionUtil.getExceptionMessage(e));
			j.setMsg("修改失败！");
		}
		super.writeJson(j, response);
	}

	/**
	 * 跳转批量修改角色页面
	 */
	@RequestMapping("/to_role_edit")
	public ModelAndView userRoleEdit() {
		return new ModelAndView("backstage/base/user/user_role_edit");
	}

	/**
	 * 批量修改角色
	 */
	@RequestMapping("/save_role_edit")
	public void saveRoleEdit(HttpServletResponse response, UserView userView) {
		Json j = new Json();
		try {
			backUserService.saveRoleEdit(userView);
			j.setSuccess(true);
			j.setMsg("编辑成功！");
		} catch (Exception e) {
			log.error("修改角色失败", ExceptionUtil.getExceptionMessage(e));
			j.setMsg("编辑失败！");
		}
		super.writeJson(j, response);
	}

	/**
	 * 跳转登录页面
	 */
	@RequestMapping("/to_login")
	public ModelAndView toLogin(HttpServletRequest request) throws Exception {
		ModelAndView modelAndView = new ModelAndView();

		modelAndView.setViewName("backstage/index");
		return modelAndView;

	}

	/**
	 * 后台登录
	 */
	@UserLog(description = "用户登录")
	@RequestMapping("/doNotNeedSession_login")
	public void doNotNeedSession_login(HttpServletRequest request, HttpServletResponse response, User user) {
		Json j = new Json();
		String password = user.getPassword();
		if(password!=null){
			if(password.length()==0||HttpRequest.paramValidate(password)){
				j.setMsg("登录失败！用户名或密码错误！");
			}else{
				user.setPassword(MD5.MD5c(password));
			}
		}
		User u = backUserService.login(user);
		if (u != null) {
			boolean b = true;
			if (!u.getStatus().equals("1")) {// 该用户已被禁用
				j.setMsg("登录失败！该用于已被禁用");
				b = false;
			}
			if (!u.getUser_type().equals("0")) {
				j.setMsg("登录失败！您没有权限登录后台！");// 网站用户,不能登录后台
				b = false;
			}
			if (b) {
				String levels = roleService.queryBackUserLevel(u.getId());
				SessionInfo sessionInfo = new SessionInfo();
				sessionInfo.setUserId(u.getId());
				sessionInfo.setUserName(u.getUsername());
				sessionInfo.setIcon(u.getIcon());
				if(levels!=null&&levels.length()>0){
					sessionInfo.setLevel(Integer.parseInt(levels.substring(0, 1)));
				}
				//获取用户登录的外网IP
				String networkIp = IpUtil.getIpAddr(request);
				sessionInfo.setRemote_ip(networkIp);
				List<Auth> authList = authService.getByUserId(u.getId());
				if (authList != null && authList.size() > 0) {
					String authNames = "";
					String authUrls = "";
					for (Auth auth : authList) {
						authNames += auth.getName() + ",";
						authUrls += auth.getUrl() + ",";
					}
					sessionInfo.setAuthNames(authNames.substring(0, authNames.length() - 1));
					sessionInfo.setAuthUrls(authUrls.substring(0, authUrls.length() - 1));
				}
				HttpSession session =  request.getSession();
				int interval=-1;
				session.setMaxInactiveInterval(interval);
				session.setAttribute("sessionInfo", sessionInfo);
				j.setObj(sessionInfo);
				j.setMsg("登录成功！");
				j.setSuccess(true);
			}
		} else {
			j.setMsg("登录失败！用户名或密码错误！");
		}
		super.writeJson(j, response);
	}

	/**
	 * 用户退出
	 */
	@UserLog(description = "用户退出")
	@RequestMapping("/doNotNeedSession_logout")
	public void doNotNeedSession_logout(HttpServletRequest request, HttpServletResponse response) {
		SessionInfo sessionInfo = (SessionInfo) request.getSession().getAttribute("sessionInfo");
		Long user_id = null;
		if(sessionInfo!=null){
			user_id = sessionInfo.getUserId();
		}
		request.setAttribute("extraId",user_id);
		// 删除session
		request.getSession().removeAttribute("sessionInfo");
		Json j = new Json();
		j.setSuccess(true);
		super.writeJson(j, response);
	}

	/**
	 * 跳转用户统计页面
	 */
	@RequestMapping("/to_user_stats")
	public ModelAndView toFileStats(HttpServletRequest request) {
		String month = request.getParameter("month");
		String year = request.getParameter("year");
		request.setAttribute("month", month);
		request.setAttribute("year", year);
		return new ModelAndView("backstage/base/user/user_stats");
	}

	/**
	 * 查询用户统计数据
	 */
	@RequestMapping("/query_user_stats")
	public void queryUserStats(HttpServletResponse response, UserStatsView userStats) {
		Json j = new Json();
		try {
			List<UserStatsView> userStatsList = backUserService.queryUserStats(userStats);
			j.setSuccess(true);
			j.setObj(userStatsList);
			j.setMsg("查询统计数据成功!");
		} catch (Exception e) {
			log.error("查询统计数据失败", ExceptionUtil.getExceptionMessage(e));
			j.setMsg("查询统计数据失败！");
		}
		super.writeJson(j, response);
	}

	/**
	 * 禁用、启用用户
	 */
//	@RequestMapping("/reset_password")
//	public void resetPassword(HttpServletResponse response, Long id) {
//		Json j = new Json();
//		try {
//			backUserService.resetPassword(id);
//			j.setSuccess(true);
//			j.setMsg("重置密码成功！");
//		} catch (Exception e) {
//			log.error("重置密码失败", ExceptionUtil.getExceptionMessage(e));
//			j.setMsg("重置密码失败！");
//		}
//		super.writeJson(j, response);
//	}

	

	/**
	 * 跳转用户统计页面
	 */
	@RequestMapping("/to_user_trend")
	public ModelAndView toUserTrend(HttpServletRequest request) {
		try {
			String timeType = request.getParameter("timeType");
			String isDuration = request.getParameter("isDuration");
			String days = request.getParameter("days");
			String startTime = request.getParameter("startTime");
			String endTime = request.getParameter("endTime");
			String timeUnit = request.getParameter("timeUnit");
			String device = request.getParameter("device");
			String logType = request.getParameter("logType");
			String inactive = request.getParameter("inactive");
			String province = request.getParameter("province");
			String compare = request.getParameter("compare");
			if (timeType != null) {
				if ("0".equals(timeType)) {// 今天
					days = TimeUtil.dateToString1(new Date());
				} else if ("1".equals(timeType)) {// 昨天
					days = TimeUtil.dateToString1(TimeUtil.afterNDay(new Date(), -1));
				} else if ("2".equals(timeType)) {// 最近7天
					startTime = TimeUtil.dateToString1(TimeUtil.afterNDay(new Date(), -6));
					endTime = TimeUtil.dateToString1(new Date());
				} else if ("3".equals(timeType)) {// 最近30天
					startTime = TimeUtil.dateToString1(TimeUtil.afterNDay(new Date(), -29));
					endTime = TimeUtil.dateToString1(new Date());
				}
			}
			request.setAttribute("timeType", timeType);
			request.setAttribute("isDuration", isDuration);
			if ("1".equals(isDuration)) {
				request.setAttribute("days", days);
			} else if ("0".equals(isDuration)) {
				request.setAttribute("startTime", startTime);
				request.setAttribute("endTime", endTime);
			}
			request.setAttribute("timeUnit", timeUnit);
			request.setAttribute("device", device);
			request.setAttribute("logType", logType);
			request.setAttribute("inactive", inactive);
			request.setAttribute("province", province);
			request.setAttribute("compare", compare);
		} catch (Exception e) {
			log.error("查询用户趋势失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}
		return new ModelAndView("backstage/base/user/user_trend");
	}

	
	/**
	 * 查询用户统计数据
	 */
	@RequestMapping("/query_user_trend")
	public void queryUserTrend(HttpServletResponse response, UserStatsView userStats) {
		JSONObject result = new JSONObject();
		try {
			List<UserStatsView> userStatsList = backUserService.queryUserTrend(userStats);
//			Long addUserNum = sysLogService.countAddUser(userStats);
//			Long loginUserNum = sysLogService.countLoginUser(userStats);
			String collectmeanVisit = userDurationService.collectmeanVisitTrend(userStats);
			String collectmeanNewVisit = userDurationService.collectmeanNewVisitTrend(userStats);
			result.put("userStatsList", userStatsList);
//			result.put("addUserNum", addUserNum);
//			result.put("loginUserNum", loginUserNum);
			if (collectmeanVisit != null) {
				result.put("collectmeanVisit", collectmeanVisit);
			} else {
				result.put("collectmeanVisit", "00:00:00");
			}
			if (collectmeanNewVisit != null) {
				result.put("collectmeanNewVisit", collectmeanNewVisit);
			} else {
				result.put("collectmeanNewVisit", "00:00:00");
			}
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			log.error("查询统计数据失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}

	}

	/**
	 * 跳转用户统计页面
	 */
	@RequestMapping("/to_remain_stats")
	public ModelAndView toRemainStats(HttpServletRequest request) {
		String timeType = request.getParameter("timeType");
		String days = request.getParameter("days");
		String year = request.getParameter("year");
		request.setAttribute("timeType", timeType);
		if ("3".equals(timeType) && year != null && year != "") {
			request.setAttribute("year", year);
		} else {// 查询非月活跃度
			if (days == null) {
				try {
					days = TimeUtil.dateToString1(TimeUtil.afterNDay(new Date(), -1));
				} catch (ParseException e) {
					log.error("查询用户留存失败", ExceptionUtil.getExceptionMessage(e));
					e.printStackTrace();
				}
			}
			request.setAttribute("days", days);
		}
		return new ModelAndView("backstage/base/remain/remain_stats");
	}

	/**
	 * 查询用户统计数据
	 */
	@RequestMapping("/query_remain_stats")
	public void queryRemainStats(HttpServletResponse response, UserStatsView userStats) {
		Json j = new Json();
		try {
			List<UserStatsView> userStatsList = backUserService.queryRemainStats(userStats);
			j.setSuccess(true);
			j.setObj(userStatsList);
			j.setMsg("查询统计数据成功!");
		} catch (Exception e) {
			log.error("查询统计数据失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
			j.setMsg("查询统计数据失败！");
		}
		super.writeJson(j, response);
	}

	@RequestMapping("/export_user_trend")
	public void exportStudent(HttpServletRequest request, HttpServletResponse response,
			UserStatsView userStats) {
		try {
			List<UserStatsView> userStatsList = backUserService.queryUserTrend(userStats);
			Long addUserNum = sysLogService.countAddUser(userStats);
			Long loginUserNum = sysLogService.countLoginUser(userStats);
			String collectmeanVisit = userDurationService.collectmeanVisitTrend(userStats);
			String collectmeanNewVisit = userDurationService.collectmeanNewVisitTrend(userStats);
			UserStatsView u = new UserStatsView();
			u.setDays("汇总");
			u.setNewNum(Integer.parseInt(String.valueOf(addUserNum)));
			u.setLoginNum(Integer.parseInt(String.valueOf(loginUserNum)));
			if (collectmeanVisit != null) {
				u.setMeanVisitTime(collectmeanVisit);
			} else {
				u.setMeanVisitTime("00:00:00");
			}
			if (collectmeanNewVisit != null) {
				u.setNewMeanVisitTime(collectmeanNewVisit);
			} else {
				u.setNewMeanVisitTime("00:00:00");
			}
			userStatsList.add(u);
			String time = "小时";
			if(userStats.getTimeUnit()!=0){//日期
				time = "日期";
			}
			String[] head = { time,"新增数","登录数", "平均访问时长", "新用户平均访问时长" };
			String[] fieldNames = { "days", "newNum", "loginNum", "meanVisitTime", "newMeanVisitTime" };
			String fileName = "用户趋势统计.xls";
			response.setContentType("application/msexcel");

			ExportExcel<UserStatsView> excel = new ExportExcel<UserStatsView>();
			response.setHeader("Content-Disposition", excel.getFileName(fileName, excel.getExplorer(request)));
			OutputStream out = response.getOutputStream();
			excel.exportExcel("用户趋势", head, fieldNames, userStatsList, out);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 跳转新用户留存页面
	 */
	@RequestMapping("/to_user_remain")
	public ModelAndView toUserRemain(HttpServletRequest request) {
		try {
			String timeType = request.getParameter("timeType");
			String days = request.getParameter("days");
			String startTime = request.getParameter("startTime");
			String endTime = request.getParameter("endTime");
			String sex = request.getParameter("sex");
			String timeUnit = request.getParameter("timeUnit");
			String device = request.getParameter("device");
			String logType = request.getParameter("logType");
			String province = request.getParameter("province");
			String compare = request.getParameter("compare");
			request.setAttribute("timeType", timeType);
			if (days == null||days == "") {
				days = TimeUtil.dateToString1(TimeUtil.afterNDay(new Date(), -1));
				startTime = TimeUtil.dateToString1(new Date());
				endTime = TimeUtil.dateToString1(TimeUtil.afterNDay(new Date(), 1));
			}else{
				startTime = TimeUtil.afterNDay(days, 1);
				if ("0".equals(timeType)) {// 次日
					endTime = TimeUtil.afterNDay(days, 2);
				} else if ("1".equals(timeType)) {// 三日
					endTime = TimeUtil.afterNDay(days, 4);
				} else if ("2".equals(timeType)) {// 七日
					endTime = TimeUtil.afterNDay(days, 8);
				} else if ("3".equals(timeType)) {// 30天
					endTime = TimeUtil.afterNDay(days, 31);
				}
			}
			
			request.setAttribute("days", days);
			request.setAttribute("startTime", startTime);
			request.setAttribute("endTime", endTime);
			request.setAttribute("sex", sex);
			request.setAttribute("timeUnit", timeUnit);
			request.setAttribute("device", device);
			request.setAttribute("logType", logType);
			request.setAttribute("province", province);
			request.setAttribute("compare", compare);
		} catch (Exception e) {
			log.error("查询用户留存失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}
		return new ModelAndView("backstage/base/remain/user_remain");
	}
	
	/**
	 * 查询用户留存数据
	 */
	@RequestMapping("/query_user_remain")
	public void queryUserRemain(HttpServletResponse response, UserStatsView userStats) {
		JSONObject result = new JSONObject();
		try {
			List<UserStatsView> userStatsList = backUserService.queryUserRemain(userStats);
			result.put("userStatsList", userStatsList);
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			log.error("查询统计数据失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}

	}

	@RequestMapping("/export_user_remain")
	public void exportUserRemain(HttpServletRequest request, HttpServletResponse response,
			UserStatsView userStats) {
		String timeType = request.getParameter("timeType");
		String timeUnit = request.getParameter("timeUnit");
		try {
			List<UserStatsView> userStatsList = backUserService.queryUserRemain(userStats);
			if("0".equals(timeUnit)){//区间
				if("0".equals(timeType)){//次日
					if(userStatsList.size()>1){
						UserStatsView uv = new UserStatsView();
						BeanUtils.copyProperties(userStatsList.get(1), uv);
						uv.setDays("汇总");
						userStatsList.add(uv);
					}
					UserStatsView u1 = userStatsList.get(0);
					userStatsList.remove(u1);
				}else{//非次日
					if(userStatsList.size()>2){
						UserStatsView u = userStatsList.get(userStatsList.size()-1);
						u.setDays("汇总");
					}
					UserStatsView u1 = userStatsList.get(0);
					userStatsList.remove(u1);
				}
			}else{//点日
				if(userStatsList.size()>0){
					UserStatsView uv = new UserStatsView();
					BeanUtils.copyProperties(userStatsList.get(0), uv);
					uv.setDays("汇总");
					userStatsList.add(uv);
				}
			}
			
			String[] head = { "日期","留存数","留存率%", "流失数", "流失率%" };
			String[] fieldNames = { "days", "newNum", "remainRatio", "lossNum", "lossRatio" };
			String fileName = "新增用户留存统计.xls";
			response.setContentType("application/msexcel");

			ExportExcel<UserStatsView> excel = new ExportExcel<UserStatsView>();
			response.setHeader("Content-Disposition", excel.getFileName(fileName, excel.getExplorer(request)));
			OutputStream out = response.getOutputStream();
			excel.exportExcel("新增用户留存", head, fieldNames, userStatsList, out);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	/**
	 * 跳转用户统计页面
	 */
	@RequestMapping("/to_user_active")
	public ModelAndView toUserActive(HttpServletRequest request) {
		try {
			String timeType = request.getParameter("timeType");
			String isDuration = request.getParameter("isDuration");
			String days = request.getParameter("days");
			String startTime = request.getParameter("startTime");
			String endTime = request.getParameter("endTime");
			String sex = request.getParameter("sex");
			String device = request.getParameter("device");
			String logType = request.getParameter("logType");
			String inactive = request.getParameter("inactive");
			String province = request.getParameter("province");
			String compare = request.getParameter("compare");
			String status = request.getParameter("status");
			String hour = request.getParameter("hour");
			String oneDay = request.getParameter("oneDay");
			if (timeType != null) {
				if ("0".equals(timeType)) {// 今天
					days = TimeUtil.dateToString1(new Date());
				} else if ("1".equals(timeType)) {// 昨天
					days = TimeUtil.dateToString1(TimeUtil.afterNDay(new Date(), -1));
				} else if ("2".equals(timeType)) {// 最近7天
					startTime = TimeUtil.dateToString1(TimeUtil.afterNDay(new Date(), -6));
					endTime = TimeUtil.dateToString1(new Date());
				} else if ("3".equals(timeType)) {// 最近30天
					startTime = TimeUtil.dateToString1(TimeUtil.afterNDay(new Date(), -29));
					endTime = TimeUtil.dateToString1(new Date());
				}
			}
			request.setAttribute("timeType", timeType);
			request.setAttribute("isDuration", isDuration);
			if ("1".equals(isDuration)) {
				request.setAttribute("days", days);
			} else if ("0".equals(isDuration)) {
				request.setAttribute("startTime", startTime);
				request.setAttribute("endTime", endTime);
			}
			request.setAttribute("sex", sex);
			request.setAttribute("device", device);
			request.setAttribute("logType", logType);
			request.setAttribute("inactive", inactive);
			request.setAttribute("province", province);
			request.setAttribute("compare", compare);
			request.setAttribute("status", status);
			request.setAttribute("hour", hour);
			request.setAttribute("oneDay", oneDay);
		} catch (Exception e) {
			log.error("查询用户活跃数据失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}
		return new ModelAndView("backstage/base/active/user_active");
	}
	
	/**
	 * 查询用户留存数据
	 */
	@RequestMapping("/query_user_active")
	public void queryUserActive(HttpServletResponse response, UserStatsView userStats) {
		JSONObject result = new JSONObject();
		try {
			List<UserStatsView> userStatsList = backUserService.queryUserActive(userStats);
			result.put("userStatsList", userStatsList);
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			log.error("查询统计数据失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}

	}
	
	@RequestMapping("/export_user_active")
	public void exportUserActive(HttpServletRequest request, HttpServletResponse response,
			UserStatsView userStats) {
		try {
			List<UserStatsView> userStatsList = backUserService.queryUserActive(userStats);
			int activeNum = 0,tryNum = 0,returnNum = 0;
			for(UserStatsView u:userStatsList){
				activeNum += u.getActiveNum();
				tryNum += u.getTryNum();
				returnNum += u.getReturnNum();
			}
			UserStatsView u0 = new UserStatsView();
			u0.setDays("汇总");
			u0.setActiveNum(activeNum);
			u0.setTryNum(tryNum);
			u0.setReturnNum(returnNum);
			userStatsList.add(u0);
			String[] head = { "日期","高活跃用户","尝试用户", "回归僵尸用户"};
			String[] fieldNames = { "days", "activeNum", "tryNum", "returnNum"};
			String fileName = "用户活跃分析.xls";
			response.setContentType("application/msexcel");
			ExportExcel<UserStatsView> excel = new ExportExcel<UserStatsView>();
			response.setHeader("Content-Disposition", excel.getFileName(fileName, excel.getExplorer(request)));
			OutputStream out = response.getOutputStream();
			excel.exportExcel("用户活跃", head, fieldNames, userStatsList, out);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 跳转用户统计页面
	 */
	@RequestMapping("/to_user_online")
	public ModelAndView toUserOnline(HttpServletRequest request) {
		try {
			String sex = request.getParameter("sex");
			String device = request.getParameter("device");
			String province = request.getParameter("province");
			String status = request.getParameter("status");
			request.setAttribute("sex", sex);
			request.setAttribute("device", device);
			request.setAttribute("status", status);
			request.setAttribute("province", province);
		} catch (Exception e) {
			log.error("查询用户活跃数据失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}
		return new ModelAndView("backstage/base/online/user_online");
	}
	
	
	/**
	 * 查询用户留存数据
	 */
	@RequestMapping("/query_user_online")
	public void queryUserOnline(HttpServletResponse response, UserStatsView userStats) {
		JSONObject result = new JSONObject();
		try {
			List<UserStatsView> userStatsList = backUserService.queryOnlineNum(userStats);
			List<UserDurationView> onlineUser = backUserService.queryOnlineUser(userStats);
			result.put("userStatsList", userStatsList);
			result.put("onlineUser", onlineUser);
			result.put("nowtime", TimeUtil.dateToString2(new Date()));
			result.put("nownum", SessionListener.countUser);
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			log.error("查询统计数据失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}

	}
	
	/**
	 * 跳转用户在线分析页面
	 */
	@RequestMapping("/to_online_stats")
	public ModelAndView toOnlineStats(HttpServletRequest request) {
		try {
			String timeType = request.getParameter("timeType");
			String isDuration = request.getParameter("isDuration");
			String days = request.getParameter("days");
			String startTime = request.getParameter("startTime");
			String endTime = request.getParameter("endTime");
			String timeUnit = request.getParameter("timeUnit");
			String device = request.getParameter("device");
			String logType = request.getParameter("logType");
			String inactive = request.getParameter("inactive");
			String province = request.getParameter("province");
			String compare = request.getParameter("compare");
			String status = request.getParameter("status");
			String sex = request.getParameter("sex");
			if (timeType != null) {
				if ("0".equals(timeType)) {// 今天
					days = TimeUtil.dateToString1(new Date());
				} else if ("1".equals(timeType)) {// 昨天
					days = TimeUtil.dateToString1(TimeUtil.afterNDay(new Date(), -1));
				} else if ("2".equals(timeType)) {// 最近7天
					startTime = TimeUtil.dateToString1(TimeUtil.afterNDay(new Date(), -6));
					endTime = TimeUtil.dateToString1(new Date());
				} else if ("3".equals(timeType)) {// 最近30天
					startTime = TimeUtil.dateToString1(TimeUtil.afterNDay(new Date(), -29));
					endTime = TimeUtil.dateToString1(new Date());
				}
			}
			request.setAttribute("timeType", timeType);
			request.setAttribute("isDuration", isDuration);
			if ("1".equals(isDuration)) {
				request.setAttribute("days", days);
			} else if ("0".equals(isDuration)) {
				request.setAttribute("startTime", startTime);
				request.setAttribute("endTime", endTime);
			}
			request.setAttribute("timeUnit", timeUnit);
			request.setAttribute("device", device);
			request.setAttribute("logType", logType);
			request.setAttribute("inactive", inactive);
			request.setAttribute("province", province);
			request.setAttribute("compare", compare);
			request.setAttribute("status", status);
			request.setAttribute("sex", sex);
		} catch (Exception e) {
			log.error("查询用户趋势失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}
		return new ModelAndView("backstage/base/online/online_stats");
	}

	
	/**
	 * 查询用户在线数据
	 */
	@RequestMapping("/query_avg_online")
	public void queryAvgOnline(HttpServletResponse response, UserStatsView userStats) {
		JSONObject result = new JSONObject();
		try {
			List<UserStatsView> userStatsList = backUserService.queryAvgOnline(userStats);
			result.put("userStatsList", userStatsList);
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			log.error("查询在线数据失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}

	}

	@RequestMapping("/export_online_stats")
	public void exportOnlineStats(HttpServletRequest request, HttpServletResponse response,
			UserStatsView userStats) {
		try {
			List<UserStatsView> userStatsList = backUserService.queryAvgOnline(userStats);
			int avgNum = 0,maxNum = 0;
			for(UserStatsView u:userStatsList){
				avgNum += u.getAvgNum();
				maxNum += u.getMaxNum();
			}
			UserStatsView u0 = new UserStatsView();
			u0.setDays("汇总");
			u0.setAvgNum(avgNum);
			u0.setMaxNum(maxNum);
			userStatsList.add(u0);
			String time = "小时";
			if(userStats.getTimeUnit()!=0){//日期
				time = "日期";
			}
			String[] head = { time,"平均同时在线人数","在线峰值"};
			String[] fieldNames = { "days", "avgNum", "maxNum"};
			String fileName = "用户在线分析.xls";
			response.setContentType("application/msexcel");
			ExportExcel<UserStatsView> excel = new ExportExcel<UserStatsView>();
			response.setHeader("Content-Disposition", excel.getFileName(fileName, excel.getExplorer(request)));
			OutputStream out = response.getOutputStream();
			excel.exportExcel("用户在线", head, fieldNames, userStatsList, out);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 跳转用户属性页面
	 */
	@RequestMapping("/to_user_property")
	public ModelAndView toUserProperty(HttpServletRequest request) {
		try {
			String days = request.getParameter("days");
			String timeType = request.getParameter("timeType");
			String startTime = request.getParameter("startTime");
			String endTime = request.getParameter("endTime");
			if (timeType != null) {
				Date date = new Date();
				endTime = TimeUtil.dateToString1(TimeUtil.afterNDay(date, 1));
				if ("0".equals(timeType)) {// 最近30天
					startTime = TimeUtil.dateToString1(TimeUtil.afterNDay(date, -29));
				} else if ("1".equals(timeType)) {// 最近2个月
					startTime = TimeUtil.dateToString1(TimeUtil.afterNDay(date, -59));
				} else if ("2".equals(timeType)) {// 最近3个月
					startTime = TimeUtil.dateToString1(TimeUtil.afterNDay(date, -89));
				} else if ("3".equals(timeType)) {// 最近6个月
					startTime = TimeUtil.dateToString1(TimeUtil.afterNDay(date, -179));
				}
			}
			request.setAttribute("timeType", timeType);
			request.setAttribute("startTime", startTime);
			request.setAttribute("endTime", endTime);
			if(!"选择月份".equals(days)){
				request.setAttribute("days", days);
			}
		} catch (Exception e) {
			log.error("跳转用户属性页面失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}
		return new ModelAndView("backstage/base/userAnalyze/user_property");
	}
	
	/**
	 * 查询用户在线数据
	 */
	@RequestMapping("/query_user_property")
	public void queryUserProperty(HttpServletResponse response, UserStatsView userStats) {
		JSONObject result = new JSONObject();
		try {
			if(userStats.getDays()!=null&&userStats.getDays().length()>0){
				userStats.setDays(TimeUtil.stringToString1(userStats.getDays()));
			}
			List<UserStatsView> userStatsList = backUserService.ageDistribution(userStats);
			userStats.setSex(1);
			Integer menNum = backUserService.querySexNum(userStats);
			userStats.setSex(2);
			Integer womenNum = backUserService.querySexNum(userStats);
			result.put("womenNum", womenNum);
			result.put("menNum", menNum);
			result.put("userStatsList", userStatsList);
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			log.error("查询在线数据失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}

	}
	
	
	/**
	 * 跳转新老用户页面
	 */
	@RequestMapping("/to_new_old_user")
	public ModelAndView toNewOldUser(HttpServletRequest request) {
		try {
			String timeType = request.getParameter("timeType");
			String isDuration = request.getParameter("isDuration");
			String days = request.getParameter("days");
			String startTime = request.getParameter("startTime");
			String endTime = request.getParameter("endTime");
			String province = request.getParameter("province");
			if (timeType != null) {
				if ("0".equals(timeType)) {// 今天
					days = TimeUtil.dateToString1(new Date());
				} else if ("1".equals(timeType)) {// 昨天
					days = TimeUtil.dateToString1(TimeUtil.afterNDay(new Date(), -1));
				} else if ("2".equals(timeType)) {// 最近7天
					startTime = TimeUtil.dateToString1(TimeUtil.afterNDay(new Date(), -6));
					endTime = TimeUtil.dateToString1(new Date());
				} else if ("3".equals(timeType)) {// 最近30天
					startTime = TimeUtil.dateToString1(TimeUtil.afterNDay(new Date(), -29));
					endTime = TimeUtil.dateToString1(new Date());
				}
			}
			request.setAttribute("timeType", timeType);
			request.setAttribute("isDuration", isDuration);
			if ("1".equals(isDuration)) {
				request.setAttribute("days", days);
			} else if ("0".equals(isDuration)) {
				request.setAttribute("startTime", startTime);
				request.setAttribute("endTime", endTime);
			}
			request.setAttribute("province", province);
		} catch (Exception e) {
			log.error("查询新老用户失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}
		return new ModelAndView("backstage/base/userAnalyze/new_old_user");
	}
	
	/**
	 * 查询新老用户数据
	 */
	@RequestMapping("/query_new_old_user")
	public void queryNewOldUser(HttpServletResponse response, UserStatsView userStats) {
		JSONObject result = new JSONObject();
		try {
			UserStatsView totalUser = backUserService.queryAvgVisitTime(userStats);
			userStats.setStatus(1);
			UserStatsView newUser = backUserService.queryAvgVisitTime(userStats);
			userStats.setStatus(2);
			UserStatsView oldUser = backUserService.queryAvgVisitTime(userStats);
			result.put("newUser", newUser);
			result.put("oldUser", oldUser);
			result.put("totalUser", totalUser);
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			log.error("查询新老用户数据失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}

	}
	
	/**
	 * 跳转忠诚度页面
	 */
	@RequestMapping("/to_user_loyalty_index")
	public ModelAndView toUserLoyaltyIndex(HttpServletRequest request) {
		try {
			String logType = request.getParameter("logType");
			String timeType = request.getParameter("timeType");
			String isDuration = request.getParameter("isDuration");
			String days = request.getParameter("days");
			String startTime = request.getParameter("startTime");
			String endTime = request.getParameter("endTime");
			String status = request.getParameter("status");
			String province = request.getParameter("province");
			if (timeType != null) {
				if ("0".equals(timeType)) {// 今天
					days = TimeUtil.dateToString1(new Date());
				} else if ("1".equals(timeType)) {// 昨天
					days = TimeUtil.dateToString1(TimeUtil.afterNDay(new Date(), -1));
				} else if ("2".equals(timeType)) {// 最近7天
					startTime = TimeUtil.dateToString1(TimeUtil.afterNDay(new Date(), -6));
					endTime = TimeUtil.dateToString1(new Date());
				} else if ("3".equals(timeType)) {// 最近30天
					startTime = TimeUtil.dateToString1(TimeUtil.afterNDay(new Date(), -29));
					endTime = TimeUtil.dateToString1(new Date());
				}
			}
			request.setAttribute("logType", logType);
			request.setAttribute("timeType", timeType);
			request.setAttribute("isDuration", isDuration);
			if ("1".equals(isDuration)) {
				request.setAttribute("days", days);
			} else if ("0".equals(isDuration)) {
				request.setAttribute("startTime", startTime);
				request.setAttribute("endTime", endTime);
			}
			request.setAttribute("status", status);
			request.setAttribute("province", province);
		} catch (Exception e) {
			log.error("查询用户忠诚度失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}
		return new ModelAndView("backstage/base/userAnalyze/user_loyalty_index");
	}
	
	/**
	 * 查询用户忠诚度数据
	 */
	@RequestMapping("/query_user_loyalty_index")
	public void queryUserLoyaltyIndex(HttpServletResponse response, UserStatsView userStats) {
		JSONObject result = new JSONObject();
		try {
			List<UserStatsView> loyaltyList = new ArrayList<>();
			if("0".equals(userStats.getLogType())){
				loyaltyList = backUserService.querytimesByduaration(userStats);
			}else if("1".equals(userStats.getLogType())){
				loyaltyList = backUserService.querylastTimeOnlineInterval(userStats);
			}else if("2".equals(userStats.getLogType())){
				loyaltyList = backUserService.queryLoginFrequency(userStats);
			}
			result.put("loyaltyList", loyaltyList);
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			log.error("查询用户忠诚度数据失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}

	}
	
	/**
	 * 跳转地域分布页面
	 */
	@RequestMapping("/to_areal_distribution")
	public ModelAndView toArealDistribution(HttpServletRequest request) {
		try {
			String logType = request.getParameter("logType");
			String timeType = request.getParameter("timeType");
			String isDuration = request.getParameter("isDuration");
			String days = request.getParameter("days");
			String startTime = request.getParameter("startTime");
			String endTime = request.getParameter("endTime");
			String status = request.getParameter("status");
			String device = request.getParameter("device");
			if (timeType != null) {
				if ("0".equals(timeType)) {// 今天
					days = TimeUtil.dateToString1(new Date());
				} else if ("1".equals(timeType)) {// 昨天
					days = TimeUtil.dateToString1(TimeUtil.afterNDay(new Date(), -1));
				} else if ("2".equals(timeType)) {// 最近7天
					startTime = TimeUtil.dateToString1(TimeUtil.afterNDay(new Date(), -6));
					endTime = TimeUtil.dateToString1(new Date());
				} else if ("3".equals(timeType)) {// 最近30天
					startTime = TimeUtil.dateToString1(TimeUtil.afterNDay(new Date(), -29));
					endTime = TimeUtil.dateToString1(new Date());
				}
			}
			request.setAttribute("logType", logType);
			request.setAttribute("timeType", timeType);
			request.setAttribute("isDuration", isDuration);
			if ("1".equals(isDuration)) {
				request.setAttribute("days", days);
			} else if ("0".equals(isDuration)) {
				request.setAttribute("startTime", startTime);
				request.setAttribute("endTime", endTime);
			}
			request.setAttribute("status", status);
			request.setAttribute("device", device);
		} catch (Exception e) {
			log.error("查询地域分布失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}
		return new ModelAndView("backstage/base/userAnalyze/areal_distribution");
	}
	
	/**
	 * 查询地域分布数据
	 */
	@RequestMapping("/query_areal_distribution")
	public void queryArealDistribution(HttpServletResponse response, UserStatsView userStats) {
		JSONObject result = new JSONObject();
		try {
			List<UserStatsView> list = backUserService.queryArealDistribution(userStats);
			result.put("list", list);
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			log.error("查询地域分布数据失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}

	}
	
	/**
	 * 跳转用户查看页面
	 */
	@RequestMapping("/doNotNeedSession_to_see_me")
	public ModelAndView to_see_me(HttpServletRequest request) {
		ModelAndView v = new ModelAndView("backstage/base/user/see_me");
		SessionInfo info = (SessionInfo) request.getSession().getAttribute("sessionInfo");
		UserView u = backUserService.queryme(info.getUserId());
		v.addObject("info", u);
		return v;
	}

}
