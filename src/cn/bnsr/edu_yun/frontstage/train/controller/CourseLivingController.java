package cn.bnsr.edu_yun.frontstage.train.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("course_living")
public class CourseLivingController {

	
	@RequestMapping("/to_living_room")
	public ModelAndView toLivingRoom(HttpServletRequest request,long room_id ) {
		ModelAndView modelAndView = new ModelAndView(
					"frontstage/train/living/living_room");
		modelAndView.addObject("room_id", room_id);
		modelAndView.addObject("head_title", "进入直播教室");
		return modelAndView;
	}
	
}
