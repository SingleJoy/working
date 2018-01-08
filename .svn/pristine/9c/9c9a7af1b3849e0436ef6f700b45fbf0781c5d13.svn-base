package cn.bnsr.edu_yun.frontstage.train.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.backstage.base.view.PageBase;
import cn.bnsr.edu_yun.backstage.base.view.StudyTimeView;
import cn.bnsr.edu_yun.backstage.base.view.UserTrackView;
import cn.bnsr.edu_yun.frontstage.base.service.UserService;
import cn.bnsr.edu_yun.frontstage.base.view.NoteView;
import cn.bnsr.edu_yun.frontstage.train.service.ClassService;
import cn.bnsr.edu_yun.frontstage.train.service.CourseNoteService;
import cn.bnsr.edu_yun.frontstage.train.service.TopicAnswerService;
import cn.bnsr.edu_yun.frontstage.train.service.TopicQuestionService;
import cn.bnsr.edu_yun.frontstage.train.service.UserStudyTimeService;
import cn.bnsr.edu_yun.frontstage.train.view.ClassView;
import cn.bnsr.edu_yun.frontstage.train.view.TopicAnswerView;
import cn.bnsr.edu_yun.frontstage.train.view.TopicQuestionView;
import cn.bnsr.edu_yun.util.NumUtil;
import cn.bnsr.edu_yun.util.ResponseUtil;

@Controller
@RequestMapping("/course_track")
public class CourseUserTrackController {

	@Autowired
	private UserService userService;
	@Autowired
	private ClassService classService;
	@Autowired
	private UserStudyTimeService userStudyTimeService;
	@Autowired
	private TopicQuestionService topicQuestionService;
	@Autowired
	private CourseNoteService courseNoteService;
	@Autowired
	private TopicAnswerService topicAnswerService;

	@RequestMapping("/to_track")
	public ModelAndView toTrack(ClassView classView, HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		Integer type = classView.getSource_type();
		Long classId = classView.getId();
		Long course_id = classView.getSource_id();
		String sign = classView.getSign();
		classView = classService.selectOne(classId, type);
		classView.setSign(sign);
		modelAndView.addObject("classView", classView);
		UserTrackView userTrackView = new UserTrackView();
		userTrackView.setClass_id(classId);
		userTrackView.setCourse_id(course_id);
		List<UserTrackView> userTrackViews = userService.queryUserTrackClassView(userTrackView);
		modelAndView.addObject("userTrackViews", userTrackViews);
		modelAndView.setViewName("frontstage/train/class/class_track");
		modelAndView.addObject("head_title", "用户轨迹");
		return modelAndView;
	}
	@RequestMapping("/track_index")
	public void trackIndex(HttpServletResponse response,long user_id, int index, int page, long class_id, long course_id) throws Exception {
		JSONObject result = new JSONObject();
		PageBase p = new PageBase();
		int rows = 10;
		p.setPage(page);
		p.setRows(rows);
		if (index == 1) {
			StudyTimeView studyTimeView = new StudyTimeView();
			studyTimeView.setPage(NumUtil.startingNum(page+1, rows));
			studyTimeView.setRows(rows);
			studyTimeView.setUser_id(user_id);
			studyTimeView.setClass_id(class_id);
			List<StudyTimeView> studyTimeViews = userStudyTimeService.selectViewByUserId(studyTimeView);
			result.put("studyTimeViews", studyTimeViews);
			long total = userStudyTimeService.selectViewByUserIdCount(studyTimeView);
			p.setTotal((int) total);

		} else if (index == 2) {
			TopicQuestionView topicQuestionView = new TopicQuestionView();
			BeanUtils.copyProperties(p, topicQuestionView);
			topicQuestionView.setStartLine(NumUtil.startingNum(page+1, rows));
			topicQuestionView.setUser_id(user_id);
			topicQuestionView.setBack(1);
			topicQuestionView.setClass_id(class_id);
			 List<TopicQuestionView> topicQuestionViews = topicQuestionService.queryTopic(topicQuestionView);
			 result.put("topicQuestionViews", topicQuestionViews);
			long total = topicQuestionService.queryTopicCount(topicQuestionView);
			p.setTotal((int) total);
		} else if (index == 3) {
			TopicAnswerView topicAnswerView = new TopicAnswerView();
			BeanUtils.copyProperties(p, topicAnswerView);
			topicAnswerView.setStartLine(NumUtil.startingNum(page+1, rows));
			topicAnswerView.setUser_id(user_id);
			topicAnswerView.setClass_id(class_id);
			List<TopicAnswerView> topicAnswerViews = topicAnswerService.queryMyTopicAnswer(topicAnswerView);
			 result.put("topicAnswerViews",topicAnswerViews );
			long total = topicAnswerService.queryMyTopicAnswerCount(topicAnswerView);
			p.setTotal((int) total);
		} else if (index == 4) {
			NoteView noteView = new NoteView();
			BeanUtils.copyProperties(p, noteView);
			noteView.setStartLine(NumUtil.startingNum(page+1, rows));
			noteView.setUser_id(user_id);
			noteView.setCourse_id(course_id);
			List<NoteView> noteViews = courseNoteService.queryMyCourseNote(noteView);
			 result.put("noteViews",noteViews );
			long total=courseNoteService.queryMyCourseNoteCount(noteView);
			p.setTotal((int) total);
		}
		result.put("index", index);
		result.put("page", p);
		ResponseUtil.write(response, result);
	}

}
