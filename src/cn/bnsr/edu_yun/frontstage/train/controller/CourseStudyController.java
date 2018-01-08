package cn.bnsr.edu_yun.frontstage.train.controller;

import java.io.OutputStream;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.ByteBuffer;
import java.nio.channels.Channels;
import java.nio.channels.ReadableByteChannel;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.base.service.UserService;
import cn.bnsr.edu_yun.frontstage.tiku.po.Exam;
import cn.bnsr.edu_yun.frontstage.tiku.po.TestPaper;
import cn.bnsr.edu_yun.frontstage.tiku.service.ExamService;
import cn.bnsr.edu_yun.frontstage.tiku.service.TestPaperService;
import cn.bnsr.edu_yun.frontstage.tiku.service.TestQuestionsService;
import cn.bnsr.edu_yun.frontstage.tiku.view.TestPaperQuestionView;
import cn.bnsr.edu_yun.frontstage.train.po.Course;
import cn.bnsr.edu_yun.frontstage.train.po.CourseFile;
import cn.bnsr.edu_yun.frontstage.train.po.CourseHour;
import cn.bnsr.edu_yun.frontstage.train.po.CourseNote;
import cn.bnsr.edu_yun.frontstage.train.po.TopicQuestion;
import cn.bnsr.edu_yun.frontstage.train.po.Train;
import cn.bnsr.edu_yun.frontstage.train.po.UserAppraise;
import cn.bnsr.edu_yun.frontstage.train.po.UserClassHour;
import cn.bnsr.edu_yun.frontstage.train.po.UserDiscuss;
import cn.bnsr.edu_yun.frontstage.train.po.UserStudy;
import cn.bnsr.edu_yun.frontstage.train.po.UserStudyRecord;
import cn.bnsr.edu_yun.frontstage.train.po.UserTrainClass;
import cn.bnsr.edu_yun.frontstage.train.service.ClassService;
import cn.bnsr.edu_yun.frontstage.train.service.CourseFileService;
import cn.bnsr.edu_yun.frontstage.train.service.CourseHourFileService;
import cn.bnsr.edu_yun.frontstage.train.service.CourseHourService;
import cn.bnsr.edu_yun.frontstage.train.service.CourseNoteService;
import cn.bnsr.edu_yun.frontstage.train.service.TopicQuestionService;
import cn.bnsr.edu_yun.frontstage.train.service.CourseService;
import cn.bnsr.edu_yun.frontstage.train.service.TrainService;
import cn.bnsr.edu_yun.frontstage.train.service.UserAppraiseService;
import cn.bnsr.edu_yun.frontstage.train.service.UserClassHourService;
import cn.bnsr.edu_yun.frontstage.train.service.UserDiscussService;
import cn.bnsr.edu_yun.frontstage.train.service.UserStudyRecordService;
import cn.bnsr.edu_yun.frontstage.train.service.UserStudyService;
import cn.bnsr.edu_yun.frontstage.train.service.UserTrainClassService;
import cn.bnsr.edu_yun.frontstage.train.view.AppraiseReasonView;
import cn.bnsr.edu_yun.frontstage.train.view.CourseHourFileView;
import cn.bnsr.edu_yun.frontstage.train.view.CourseHourView;
import cn.bnsr.edu_yun.frontstage.train.view.UserClassHourView;
import cn.bnsr.edu_yun.frontstage.train.view.UserDiscussView;
import cn.bnsr.edu_yun.util.ConfigInfo;
import cn.bnsr.edu_yun.util.ResponseUtil;

@Controller
@RequestMapping("course_study")
public class CourseStudyController {
	private final Logger log = LoggerFactory.getLogger(CourseStudyController.class);

	@Autowired
	private CourseHourService courseHourService;
	@Autowired
	private CourseFileService courseFileService;
	@Autowired
	private TopicQuestionService topicQuestionService;
	@Autowired
	private CourseNoteService courseNoteService;
	@Autowired
	private CourseHourFileService courseHourFileService;
	@Autowired
	private UserStudyRecordService userStudyRecordService;
	@Autowired
	private UserStudyService userStudyService;
	@Autowired
	private TestPaperService testPaperService;
	@Autowired
	private TestQuestionsService testQuestionsService;
	@Autowired
	private UserClassHourService userClassHourService;
	@Autowired
	private UserDiscussService userDiscussService;
	@Autowired
	private ExamService examService;
	@Autowired
	private CourseService courseService;
	@Autowired
	private ClassService classService;
	@Autowired
	private UserTrainClassService userTrainClassService;
	@Autowired
	private TrainService trainService;
	@Autowired
	private UserAppraiseService userAppraiseService;
	@Autowired
	private UserService userService;
	/**
	 * 课程学习预览
	 * @param courseHour
	 * @param response
	 * @param request
	 * @param user_study_id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/to_study_preview")
	public ModelAndView to_study_preview(CourseHour courseHour, HttpServletResponse response, HttpServletRequest request, Long user_study_id) throws Exception {
		ModelAndView modelAndView = new ModelAndView("frontstage/train/course/course_living");
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("currentUser");
		String train_type=request.getParameter("trainType");
		int trainType=-1;
		if(train_type!=null&&!"".equals(train_type.trim())){
			trainType=Integer.parseInt(train_type.trim());
		}
		String learnId = request.getParameter("learn_id");// 课程id
		String classType = request.getParameter("source_type");//班级类型 课程/培训
		UserClassHour userClassHour = new UserClassHour();
		userClassHour.setCourse_hour_id(courseHour.getId());
		userClassHour.setUser_id(user.getId());
		userClassHour.setCourse_id(Long.parseLong(learnId));
		courseHour = courseHourService.getHour(courseHour.getId() + "");
		CourseHour courseHourParent = courseHourService.getHour(courseHour.getParent_id() + "");
		if (user.getId() == courseHour.getUser_id()) {//是否是创课人
			modelAndView.addObject("isTeacher",1);
		}
		// 直播
		if (courseHour.getAttribute_type() == 5) {
			SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String start_time = courseHour.getStart_time().replace(".0", "");
			Date d = s.parse(start_time);
			long l = courseHour.getMinute() * 60 * 1000;
			Date date = new Date(d.getTime() + l);
			String end_time = s.format(date);
			modelAndView.addObject("start_time", start_time);
			modelAndView.addObject("end_time", end_time);
			// start,直播课的开始状态.0:未开始1:即将开始2:开始3:已结束
			// 当前时间离开始时间超过1个小时，未开始,之内即将开始
			Date now = new Date();
			if ((d.getTime() - now.getTime()) > 0) {
				long time = (d.getTime() - now.getTime()) / 1000 / 60;
				if (time > 60) {
					modelAndView.addObject("start", 0);
				} else {
					modelAndView.addObject("start", 1);
				}

			} else {
				if ((now.getTime() - date.getTime()) > 0) {
					modelAndView.addObject("start", 3);
				} else {
					modelAndView.addObject("start", 2);
				}
			}

			if (user.getId() == courseHour.getUser_id()) {
				modelAndView.addObject("is_teacher", 0);
			} else {
				modelAndView.addObject("is_teacher", 1);
			}

		}
		// 现在要分4种情况，先处理作业的情况
		// 作业需要获得有多少道题
		// 考试
		else if (courseHour.getAttribute_type() == 4 || courseHour.getAttribute_type() == 0) {
			TestPaper testPaper = testPaperService.selectByCourseHourId(courseHour.getId());
			TestPaperQuestionView testPaperQuestionView = new TestPaperQuestionView();
			testPaperQuestionView.setTestPaper_id(testPaper.getId());
			modelAndView.addObject("homeworkId", testPaper.getId());
		}
		// 查询该课程所有章节list
		List<CourseHour> chapterList = courseHourService.queryHourList(courseHour.getCourse_id(), true);
		CourseHourView courseHourView = new CourseHourView();
		courseHourView.setUser_id(user.getId());
		courseHourView.setSource_type(classType);
		courseHourView.setCourse_id(courseHour.getCourse_id());
		// 查询该课程所有课时list
		List<CourseHourView> hourList = courseHourService.queryHourListUser(courseHourView);
		// courseFile
		CourseFile courseFile = courseFileService.selectByKey(courseHour.getCourse_file_id());
		// 该课时下的问答
		String sort = "question_time";
		int pageSize = 10;
		int page = 1;
		int start = pageSize * (page - 1);
		List<TopicQuestion> questions = topicQuestionService.selectByCourseHourId(courseHour.getId(), sort, start, pageSize);
		// 笔记
		CourseNote note = courseNoteService.selectByHourIdAndUserId(user.getId(), courseHour.getId());
		// 资料
		List<CourseHourFileView> courseHourFileList = courseHourFileService.getHourFile(courseHour.getId() + "");
		//课程
		Course course = courseService.getById(courseHour.getCourse_id());
		Date date=new Date();
		long time=date.getTime();
		Random ra =new Random();
	    String num = time+ra.nextInt(10)+"";
	    modelAndView.addObject("isPreview", 1);
		session.setAttribute("numPassword", num);
		modelAndView.addObject("numPassword", num);
		modelAndView.addObject("courseHourStudent", userClassHourService.selectByHourId(userClassHour));
		modelAndView.addObject("courseHourFileList", courseHourFileList);
		modelAndView.addObject("questions", questions);
		modelAndView.addObject("note", note);
		modelAndView.addObject("courseFile", courseFile);
		modelAndView.addObject("chapterList", chapterList);
		modelAndView.addObject("hourList", hourList);
		modelAndView.addObject("courseHour", courseHour);
		modelAndView.addObject("courseHourParent", courseHourParent);
		modelAndView.addObject("classType", classType);
		modelAndView.addObject("course", course);
		modelAndView.addObject("head_title", courseHour.getHour_title());
		modelAndView.addObject("file_server_path", ConfigInfo.getString("file_server_path"));
		modelAndView.addObject("learnId", userClassHour.getCourse_id());
		int is_direct=0;
		if(trainType>=0){
			modelAndView.addObject("trainType", trainType);
			is_direct=1;
		}
		modelAndView.addObject("is_direct", is_direct);
		return modelAndView;
	}

	@RequestMapping("/to_study")
	public ModelAndView to_study(CourseHour courseHour, HttpServletResponse response, HttpServletRequest request, Long user_study_id) throws Exception {

		ModelAndView modelAndView = new ModelAndView("frontstage/train/course/course_living");
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("currentUser");
		String train_type=request.getParameter("trainType");
		int trainType=-1;
		if(train_type!=null&&!"".equals(train_type.trim())){
			trainType=Integer.parseInt(train_type.trim());
		}
		String classId = request.getParameter("source_id");// 班级id,需要清理
		UserStudy userStudy = userStudyService.getById(user_study_id);
		classId=userStudy.getSource_id()+"";//先这么处理
		String learnId = request.getParameter("learn_id");// 课程id
		String classType = request.getParameter("source_type");
		UserClassHour userClassHour = new UserClassHour();
		userClassHour.setCourse_hour_id(courseHour.getId());
		userClassHour.setUser_id(user.getId());
		userClassHour.setClass_id(Long.parseLong(classId));
		userClassHour.setCourse_id(Long.parseLong(learnId));
		courseHour = courseHourService.getHour(courseHour.getId() + "");
		CourseHour courseHourParent = courseHourService.getHour(courseHour.getParent_id() + "");
		//
		//评价项
		UserAppraise user_appraise = userAppraiseService.selectByCourseIdAndUserId(user.getId(), Long.parseLong(learnId), 0);
		modelAndView.addObject("user_appraise", user_appraise);
		AppraiseReasonView appraiseReasonView=new AppraiseReasonView();
		appraiseReasonView.setType(0);
		appraiseReasonView.setLevel(5);
		appraiseReasonView.setSource_id(Long.parseLong(learnId));
		List<AppraiseReasonView> appraiseReasonViews = userAppraiseService.selectByType(appraiseReasonView);
		modelAndView.addObject("appraiseReasonViews", appraiseReasonViews);
		// 直播
		if (courseHour.getAttribute_type() == 5) {
			SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String start_time = courseHour.getStart_time().replace(".0", "");
			Date d = s.parse(start_time);
			long l = courseHour.getMinute() * 60 * 1000;
			Date date = new Date(d.getTime() + l);
			String end_time = s.format(date);
			modelAndView.addObject("start_time", start_time);
			modelAndView.addObject("end_time", end_time);
			// start,直播课的开始状态.0:未开始1:即将开始2:开始3:已结束
			// 当前时间离开始时间超过1个小时，未开始,之内即将开始
			Date now = new Date();
			if ((d.getTime() - now.getTime()) > 0) {
				long time = (d.getTime() - now.getTime()) / 1000 / 60;
				if (time > 60) {
					modelAndView.addObject("start", 0);
				} else {
					modelAndView.addObject("start", 1);
				}

			} else {
				if ((now.getTime() - date.getTime()) > 0) {
					modelAndView.addObject("start", 3);
				} else {
					modelAndView.addObject("start", 2);
				}
			}

			if (user.getId() == courseHour.getUser_id()) {
				modelAndView.addObject("is_teacher", 0);
			} else {
				modelAndView.addObject("is_teacher", 1);
			}

		}
		// 现在要分4种情况，先处理作业的情况
		// 作业需要获得有多少道题
		// 考试
		else if (courseHour.getAttribute_type() == 4 || courseHour.getAttribute_type() == 0) {
			TestPaper testPaper = testPaperService.selectByCourseHourId(courseHour.getId());
			TestPaperQuestionView testPaperQuestionView = new TestPaperQuestionView();
			testPaperQuestionView.setTestPaper_id(testPaper.getId());
			modelAndView.addObject("homeworkId", testPaper.getId());
			Exam exam = new Exam();
			exam.setUser_id(user.getId());
			exam.setTest_paper_id(testPaper.getId());
			exam.setClass_id(Long.parseLong(classId));
			exam = examService.selectStatus(exam);
			if (exam != null) {
				modelAndView.addObject("examStatus", exam.getStatus());
			}
		}
		// 研讨
		else	if (courseHour.getAttribute_type() == 3) {
			UserDiscussView userDiscussView = new UserDiscussView();
			userDiscussView.setClass_id(userStudy.getSource_id());
			userDiscussView.setCourse_hour_id(courseHour.getId());
			UserDiscuss userDiscuss=new UserDiscuss();
			userDiscuss.setDiscuss_time(new Date());
			userDiscuss.setUser_id(user.getId());
			userDiscuss.setCourse_hour_id(courseHour.getId());
			userDiscuss.setClass_id(Long.parseLong(classId));
			int userDiscussCount = userDiscussService.countUserDiscuss(userDiscuss);
			List<UserDiscussView> userDiscussViews = userDiscussService.queryDiscuss(userDiscussView);
			modelAndView.addObject("userDiscussViews", userDiscussViews);
			modelAndView.addObject("userDiscussCount", userDiscussCount);
		}
		// 查询该课程所有章节list
		List<CourseHour> chapterList = courseHourService.queryHourList(courseHour.getCourse_id(), true);
		CourseHourView courseHourView = new CourseHourView();
		courseHourView.setUser_id(user.getId());
		courseHourView.setClass_id(Long.parseLong(classId));
		courseHourView.setSource_type(classType);
		courseHourView.setCourse_id(courseHour.getCourse_id());
		// 查询该课程所有课时list
		List<CourseHourView> hourList = courseHourService.queryHourListUser(courseHourView);
		// courseFile
		CourseFile courseFile = courseFileService.selectByKey(courseHour.getCourse_file_id());
		// 上一课时，下一课时
		// UserClassHour upHourStudent =
		// userClassHourService.selectByUpAndDown(1, courseHour.getId(),
		// courseHour.getCourse_id(), user.getId(),
		// Long.parseLong(classId), Integer.parseInt(classType));
		// UserClassHour downHourStudent =
		// userClassHourService.selectByUpAndDown(0, courseHour.getId(),
		// courseHour.getCourse_id(), user.getId(),
		// Long.parseLong(classId), Integer.parseInt(classType));
		// if (upHourStudent != null) {
		// modelAndView.addObject("up", upHourStudent.getCourse_hour_id());
		// } else {
		// modelAndView.addObject("up", null);
		// }
		// if (downHourStudent != null) {
		// modelAndView.addObject("down", downHourStudent.getCourse_hour_id());
		// } else {
		// modelAndView.addObject("down", null);
		// }
		// 该课时下的问答
		String sort = "question_time";
		int pageSize = 10;
		int page = 1;
		int start = pageSize * (page - 1);
		List<TopicQuestion> questions = topicQuestionService.selectByCourseHourId(courseHour.getId(), sort, start, pageSize);
		// 笔记
		CourseNote note = courseNoteService.selectByHourIdAndUserId(user.getId(), courseHour.getId());
		// 资料
		List<CourseHourFileView> courseHourFileList = courseHourFileService.getHourFile(courseHour.getId() + "");
		//课程
		Course course = courseService.getById(courseHour.getCourse_id());
		// 存动态
		UserStudyRecord record = new UserStudyRecord();
		record.setUser_id(user.getId());
		record.setLearn_id(courseHour.getCourse_id());
		record.setSource_name(courseHour.getHour_title());
		record.setSource_id(Long.parseLong(classId));
		if(trainType>=0){
			record.setSource_type(1);
			record.setType(trainType);
		}else{
			record.setSource_type(0);
			record.setType(course.getType());
		}
		record.setCreate_time(new Date());
		record.setMsg("开始学习课时");
		Date date=new Date();
		long time=date.getTime();
		Random ra =new Random();
	    String num = time+ra.nextInt(10)+"";
	    String url = request.getRequestURL().toString();
		String projName = request.getContextPath();
		int index = url.indexOf(projName);
		index += projName.length();
		String domainName = url.substring(0,index);
		modelAndView.addObject("proj_name", domainName);
	    session.setAttribute("numPassword", num);
		modelAndView.addObject("numPassword", num);
		userStudyRecordService.saveUserStudyRecord(record);
		modelAndView.addObject("courseHourStudent", userClassHourService.selectByHourId(userClassHour));
		modelAndView.addObject("courseHourFileList", courseHourFileList);
		modelAndView.addObject("questions", questions);
		modelAndView.addObject("note", note);
		modelAndView.addObject("courseFile", courseFile);
		modelAndView.addObject("chapterList", chapterList);
		modelAndView.addObject("hourList", hourList);
		modelAndView.addObject("courseHour", courseHour);
		modelAndView.addObject("courseHourParent", courseHourParent);
		modelAndView.addObject("classType", classType);
		modelAndView.addObject("course", course);
		modelAndView.addObject("class_id", classId);
		modelAndView.addObject("user_study_id", user_study_id);
		modelAndView.addObject("head_title", courseHour.getHour_title());
		modelAndView.addObject("file_server_path", ConfigInfo.getString("file_server_path"));
		int is_direct=0;
		if(trainType>=0){
			modelAndView.addObject("trainType", trainType);
			is_direct=1;
		}
		modelAndView.addObject("is_direct", is_direct);
		return modelAndView;

	}

	@RequestMapping("/studyed")
	public void studyed(UserClassHour userClassHour, HttpServletResponse response, HttpServletRequest request, Long user_study_id) throws Exception {

		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("currentUser");
		if(user==null){
			user=userService.selectByPrimaryKey(userClassHour.getUser_id());
		}
		
		if (userClassHour.getIs_studyed() == 1) {

			userClassHour.setStudyed_time(new Date());
		}
		userClassHourService.update(userClassHour);
		JSONObject result = new JSONObject();
		Integer is_studyed = userClassHour.getIs_studyed();
		userClassHour = userClassHourService.selectById(userClassHour.getId());
		// 获取userStudy
		UserStudy userStudy = userStudyService.getById(user_study_id);
		if (is_studyed == 1) {
			// 存动态
			UserStudyRecord record = new UserStudyRecord();
			record.setUser_id(user.getId());
			record.setLearn_id(userClassHour.getCourse_id());
			CourseHour courseHour = courseHourService.getHour(userClassHour.getCourse_hour_id() + "");
			record.setSource_name(courseHour.getHour_title());
			record.setSource_id(userStudy.getSource_id());
			record.setSource_type(userStudy.getSource_type());
			if(userStudy.getSource_type()==1){
				Train train = trainService.getById(userStudy.getLearn_id());
				if(train!=null){
					record.setType(train.getType());
				}
			}else{
				Course cou = courseService.getById(userStudy.getLearn_id());
				if(cou!=null){
					record.setType(cou.getType());
				}
			}
			record.setCreate_time(new Date());
			record.setMsg("学完了课时");
			userStudyRecordService.saveUserStudyRecord(record);
		}
		
		
		// 所有课时的数
		int allNum = userClassHourService.selectCountByCourseIdAndUserId(userClassHour);
		// 已学课时数
		int studyNum = userClassHourService.selectCountByCourseIdAndUserIdStudy(userClassHour);
		// 算成绩
					// 证书
					UserClassHourView userClassHourView = new UserClassHourView();
					userClassHourView.setUser_id(userClassHour.getUser_id());
					userClassHourView.setClass_id(userClassHour.getClass_id());
					userClassHourView.setCourse_id(userClassHour.getCourse_id());
					userClassHourService.saveCert(userClassHourView, userStudy);
		if (allNum != 0 && allNum == studyNum) {
			if (userStudy.getSource_type() == 1) {
				// 是否是培训班级
				UserTrainClass userTrainClass = new UserTrainClass();
				userTrainClass.setClass_id(userClassHour.getClass_id());
				userTrainClass.setUser_id(user.getId());
				userTrainClass.setCourse_id(userClassHour.getCourse_id());
				userTrainClass.setUser_study_id(user_study_id);
				// 为了防止以前生成的数据有重复的,用List接收
				List<UserTrainClass> userTrainClasses = userTrainClassService.queryUserTrainClass(userTrainClass);
				userTrainClass = userTrainClasses.get(0);
				userTrainClass.setIs_studyed(1);
				userTrainClassService.saveOrUpdate(userTrainClass);
				// 查课的进度
				int allClass = userTrainClassService.selectCountByCourseIdAndUserId(userTrainClass);
				int studyClass = userTrainClassService.selectCountByCourseIdAndUserIdStudy(userTrainClass);
				if (allClass != 0 && allClass == studyClass) {
					userStudy.setIs_studyed(1);
					userStudyService.saveOrUpdateStudent(userStudy);
				}
			} else {
				userStudy.setIs_studyed(1);
				userStudyService.saveOrUpdateStudent(userStudy);
			}
			
		}
		result.put("status", is_studyed);

		ResponseUtil.write(response, result);
	}

	@RequestMapping("/get_homework")
	public void getHomework(CourseHourView courseHourView, HttpServletResponse response, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		JSONObject result = new JSONObject();
		User user = (User) session.getAttribute("currentUser");
		TestPaper testPaper = testPaperService.selectByCourseHourId(courseHourView.getId());
		TestPaperQuestionView testPaperQuestionView = new TestPaperQuestionView();
		testPaperQuestionView.setTestPaper_id(testPaper.getId());
		//int homeworkCount = testQuestionsService.queryAllTestPaperQuestion(testPaperQuestionView).size();
		int homeworkCount = testQuestionsService.queryAllTestPaperQuestionOnDoHomework(testPaperQuestionView).size();
		result.put("homeworkId", testPaper.getId());
		result.put("homeworkCount", homeworkCount);
		result.put("courseId", testPaper.getCourse_id());
		Exam exam = new Exam();
		exam.setUser_id(user.getId());
		exam.setTest_paper_id(testPaper.getId());
		exam.setClass_id(courseHourView.getClass_id());
		exam = examService.selectStatus(exam);
		if (exam != null) {
			result.put("examStatus", exam.getStatus());
		} else {
			result.put("examStatus", -1);
		}
		ResponseUtil.write(response, result);
	}

	@RequestMapping("/save_discuss")
	public void saveDiscuss(UserDiscuss userDiscuss, HttpServletResponse response, HttpServletRequest request, Long user_study_id) throws Exception {
		JSONObject result = new JSONObject();
		User user=null;
		if(userDiscuss.getUser_id()!=null){
			user=new User();
			user.setId(userDiscuss.getUser_id());
		}else{
		 user = (User) request.getSession().getAttribute("currentUser");
		}
		// 获取userStudy
		UserStudy userStudy = userStudyService.getById(user_study_id);
		Long class_id = userStudy.getSource_id();
		userDiscuss.setDiscuss_time(new Date());
		userDiscuss.setUser_id(user.getId());
		userDiscuss.setClass_id(class_id);
		result.put("s", userDiscussService.insertDiscuss(userDiscuss));
		// 查研讨几次可以通过 frequency
		CourseHour courseHour = courseHourService.getHour(userDiscuss.getCourse_hour_id() + "");
		// 判断研讨几次合格，在course_hour里
		Integer frequency = courseHour.getFrequency();
		if (frequency == null || userDiscussService.countUserDiscuss(userDiscuss) == 1 || userDiscussService.countUserDiscuss(userDiscuss) == frequency) {
			UserClassHour userClassHour = new UserClassHour();
			userClassHour.setCourse_hour_id(userDiscuss.getCourse_hour_id());
			userClassHour.setUser_id(user.getId());
			userClassHour.setClass_id(class_id);
			userClassHour = userClassHourService.selectByHourId(userClassHour);
			// 是否第一次参加，开始
			if (frequency != null && userDiscussService.countUserDiscuss(userDiscuss) == 1 && userDiscussService.countUserDiscuss(userDiscuss) < frequency) {
				userClassHour.setIs_studyed(2);
				userClassHourService.update(userClassHour);
			}
			// 是否frequency次参加，通过
			else {
				userClassHour.setIs_studyed(1);
				userClassHourService.update(userClassHour);
				UserStudyRecord record = new UserStudyRecord();
				record.setUser_id(user.getId());
				record.setLearn_id(userClassHour.getCourse_id());
				record.setSource_name(courseHour.getHour_title());
				record.setSource_id(userStudy.getSource_id());
				record.setSource_type(userStudy.getSource_type());
				if(userStudy.getSource_type()==1){
					Train train = trainService.getById(userStudy.getLearn_id());
					if(train!=null){
						record.setType(train.getType());
					}
				}else{
					Course cou = courseService.getById(userStudy.getLearn_id());
					if(cou!=null){
						record.setType(cou.getType());
					}
				}
				record.setCreate_time(new Date());
				record.setMsg("学完了课时");
				userStudyRecordService.saveUserStudyRecord(record);
				// 所有课时的数
				int allNum = userClassHourService.selectCountByCourseIdAndUserId(userClassHour);
				// 已学课时数
				int studyNum = userClassHourService.selectCountByCourseIdAndUserIdStudy(userClassHour);
				// 算成绩
				// 证书
				UserClassHourView userClassHourView = new UserClassHourView();
				userClassHourView.setUser_id(userClassHour.getUser_id());
				userClassHourView.setClass_id(userClassHour.getClass_id());
				userClassHourView.setCourse_id(userClassHour.getCourse_id());
				userClassHourService.saveCert(userClassHourView, userStudy);
				if (allNum != 0 && allNum == studyNum) {
					if (userStudy.getSource_type() == 1) {
						// 是否是培训班级
						UserTrainClass userTrainClass = new UserTrainClass();
						userTrainClass.setClass_id(userClassHour.getClass_id());
						userTrainClass.setUser_id(user.getId());
						userTrainClass.setCourse_id(userClassHour.getCourse_id());
						userTrainClass.setUser_study_id(user_study_id);
						// 为了防止以前生成的数据有重复的,用List接收
						List<UserTrainClass> userTrainClasses = userTrainClassService.queryUserTrainClass(userTrainClass);
						userTrainClass = userTrainClasses.get(0);
						userTrainClass.setIs_studyed(1);
						userTrainClassService.saveOrUpdate(userTrainClass);
						// 查课的进度
						int allClass = userTrainClassService.selectCountByCourseIdAndUserId(userTrainClass);
						int studyClass = userTrainClassService.selectCountByCourseIdAndUserIdStudy(userTrainClass);
						if (allClass != 0 && allClass == studyClass) {
							userStudy.setIs_studyed(1);
							userStudyService.saveOrUpdateStudent(userStudy);
						}
					} else {
						userStudy.setIs_studyed(1);
						userStudyService.saveOrUpdateStudent(userStudy);
					}
				
				}
			}

		}
		ResponseUtil.write(response, result);
	}

	@RequestMapping("/get_discuss")
	public void getDiscuss(UserDiscussView userDiscussView, HttpServletResponse response, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		JSONObject result = new JSONObject();
		User user = (User) session.getAttribute("currentUser");
		CourseHour courseHour = courseHourService.getHour(userDiscussView.getCourse_hour_id() + "");
		List<UserDiscussView> userDiscussViews = userDiscussService.queryDiscuss(userDiscussView);
		result.put("courseHour", courseHour);
		result.put("userDiscussViews", userDiscussViews);
		ResponseUtil.write(response, result);
	}
	 @RequestMapping("/read_video")
		public void downloadFile(HttpServletRequest request,HttpServletResponse response,Long id,String num){
		 OutputStream os = null;
	    	ReadableByteChannel  rbc = null;
		String fileExtName = null;
		 String fileurl = null;
		 HttpSession session = request.getSession();
		 String numPassword =(String) session.getAttribute("numPassword");
		  try {
			 if(numPassword.equals(num)){
				
				 session.removeAttribute("numPassword");
			 CourseFile cf = courseFileService.selectByKey(id);
				if(cf != null){
					fileExtName = cf.getName();
					fileurl = cf.getPath();
				}
		     
		     if(!fileExtName.equals("")){
		    	 	Date date=new Date();
		 			long time=date.getTime();
		 			Random ra =new Random();
		    	  String num1 = time+ra.nextInt(10)+"";
		  			session.setAttribute("numPassword", num1);
					os = response.getOutputStream();
		            log.info("===========文件路径==========="+fileurl);
		            //获取远程文件
					URL website = new URL(ConfigInfo.getString("file_server_path")+fileurl);
					//获取数据通道
					rbc = Channels.newChannel(website.openStream());
					//获得浏览器代理信息
					final String userAgent = request.getHeader("USER-AGENT");
					//判断浏览器代理并分别设置响应给浏览器的编码格式
					String finalFileName = null;
		            if(StringUtils.contains(userAgent, "MSIE")||StringUtils.contains(userAgent,"Trident")){//IE浏览器
		                finalFileName = URLEncoder.encode(fileExtName,"UTF8");
		            }else if(StringUtils.contains(userAgent, "Mozilla")){//google,火狐浏览器
		                finalFileName = new String(fileExtName.getBytes(), "ISO8859-1");
		            }else{
		                finalFileName = URLEncoder.encode(fileExtName,"UTF8");//其他浏览器
		            }
		            //设置HTTP响应头
		            response.reset();//重置 响应头
		            //设置response编码
				     response.setCharacterEncoding("UTF-8");
				     response.addHeader("Content-Disposition" ,"attachment;filename=\"" +finalFileName+ "\"");//下载文件的名称
				     
				     //设置输出文件类型
				     response.setContentType("video/mpeg4");  //读取数据
		            ByteBuffer bb = ByteBuffer.allocate(1024);
		            int index = -1;
		            // 循环取出流中的数据
		            while ((index = rbc.read(bb)) > 0){
		            	System.out.println("index"+index);
		                if (index <= 0) {
		                     break;
		               }
		               bb.position(0);
		           	System.out.println("index2"+index);
		               byte[] b = new byte[index];
		               bb.get(b);
		               //将数据输出
		               System.out.println("b"+b+b[0]);
		               os.write(b, 0, index);
		               bb.clear();//缓冲区不会被自动覆盖，需要主动调用该方法
		          
		     
		     
		 }
		            }
			 }
			 }catch (Exception e) {
		// TODO: handle exception
		 e.printStackTrace();
	}
	 }
}
