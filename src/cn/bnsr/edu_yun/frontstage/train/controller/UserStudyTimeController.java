package cn.bnsr.edu_yun.frontstage.train.controller;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.train.po.UserStudyTime;
import cn.bnsr.edu_yun.frontstage.train.service.UserStudyTimeService;
import cn.bnsr.edu_yun.util.ResponseUtil;

@Controller
@RequestMapping("/user_study_time")
public class UserStudyTimeController {

	@Autowired
	private UserStudyTimeService userStudyTimeService;

	@RequestMapping("/ajax_insert")
	public void getMore(HttpServletResponse response, HttpServletRequest request, UserStudyTime userStudyTime, Long start) throws Exception {
		JSONObject result = new JSONObject();
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("currentUser");
		if (user != null) {
			userStudyTime.setUser_id(user.getId());
		}
		if (start != null) {
			System.out.println(start);
			userStudyTime.setStart_time(new Date(start));
		}
		userStudyTimeService.insert(userStudyTime);

		ResponseUtil.write(response, result);
	}
}