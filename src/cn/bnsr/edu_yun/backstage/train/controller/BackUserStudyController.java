package cn.bnsr.edu_yun.backstage.train.controller;

import java.util.Date;
import java.util.List;

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
import cn.bnsr.edu_yun.backstage.base.view.UserStatsView;
import cn.bnsr.edu_yun.backstage.train.view.StudyTimeStatsView;
import cn.bnsr.edu_yun.frontstage.train.service.UserStudyService;
import cn.bnsr.edu_yun.frontstage.train.service.UserStudyTimeService;
import cn.bnsr.edu_yun.util.ExceptionUtil;
import cn.bnsr.edu_yun.util.ResponseUtil;
import cn.bnsr.edu_yun.util.TimeUtil;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/back_user_study")
public class BackUserStudyController extends BaseController {
	
	private final Logger log = LoggerFactory.getLogger(BackUserStudyController.class);
	
	@Autowired
	private UserStudyTimeService userStudyTimeService;
	@Autowired
	private UserStudyService userStudyService;
	
	
	/**
	 *跳转用户统计页面
	 */
	@RequestMapping("/to_study_time_stats")
	public ModelAndView toStudyTimeStats(HttpServletRequest request){
		String timeType = request.getParameter("timeType");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String days = request.getParameter("days");
		String timeUnit = request.getParameter("timeUnit");
		request.setAttribute("timeType", timeType);
		request.setAttribute("startTime", startTime);
		request.setAttribute("endTime", endTime);
		request.setAttribute("days", days);
		request.setAttribute("timeUnit", timeUnit);
		return new ModelAndView("backstage/train/userStudy/study_time_stats");
	}
	
	/**
	 * 查询用户统计数据
	 */
	@RequestMapping("/query_study_time_stats")
	public void queryUserStats1(HttpServletResponse response,StudyTimeStatsView condition){
		Json j = new Json();
		try {
			List<StudyTimeStatsView> studyTimeStatsList = userStudyTimeService.queryWatchStats(condition);
			j.setSuccess(true);
			j.setObj(studyTimeStatsList);
			j.setMsg("查询统计数据成功!");
		} catch (Exception e) {
			log.error("查询统计数据失败",ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
			j.setMsg("查询统计数据失败！");
		}
		super.writeJson(j,response);
	}
	
	/**
	 * 跳转学生报名页面
	 */
	@RequestMapping("/to_stu_applay")
	public ModelAndView toStuApplay(HttpServletRequest request) {
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
			log.error("跳转学生报名页面失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}
		return new ModelAndView("backstage/train/courseAnalyze/stu_applay");
	}
	
	/**
	 * 查询学生报名数据
	 */
	@RequestMapping("/query_stu_applay")
	public void queryStuApplay(HttpServletResponse response, UserStatsView userStats) {
		JSONObject result = new JSONObject();
		try {
			if(userStats.getDays()!=null&&userStats.getDays().length()>0){
				userStats.setDays(TimeUtil.stringToString1(userStats.getDays()));
			}
			List<UserStatsView> list1 = userStudyService.queryStuArea(userStats);
			result.put("list1", list1);
			List<UserStatsView> list2 = userStudyService.queryAgeByStu(userStats);
			result.put("list2", list2);
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			log.error("查询学生报名失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}

	}

}
