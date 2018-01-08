package cn.bnsr.edu_yun.frontstage.tiku.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.frontstage.base.po.Notification;
import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.base.po.UserInfo;
import cn.bnsr.edu_yun.frontstage.base.service.NotificationService;
import cn.bnsr.edu_yun.frontstage.base.service.UserInfoService;
import cn.bnsr.edu_yun.frontstage.base.service.UserService;
import cn.bnsr.edu_yun.frontstage.base.view.UserCenterView;
import cn.bnsr.edu_yun.frontstage.tiku.po.Exam;
import cn.bnsr.edu_yun.frontstage.tiku.po.ExamAnswer;
import cn.bnsr.edu_yun.frontstage.tiku.po.TestPaper;
import cn.bnsr.edu_yun.frontstage.tiku.po.UserHomeworkScore;
import cn.bnsr.edu_yun.frontstage.tiku.service.ExamService;
import cn.bnsr.edu_yun.frontstage.tiku.service.TestPaperService;
import cn.bnsr.edu_yun.frontstage.tiku.service.TestQuestionsService;
import cn.bnsr.edu_yun.frontstage.tiku.service.UserHomeworkScoreService;
import cn.bnsr.edu_yun.frontstage.tiku.view.ExamView;
import cn.bnsr.edu_yun.frontstage.tiku.view.TestPaperQuestionView;
import cn.bnsr.edu_yun.frontstage.tiku.view.TestPaperView;
import cn.bnsr.edu_yun.frontstage.tiku.view.UserHomeworkScoreView;
import cn.bnsr.edu_yun.frontstage.train.po.Class;
import cn.bnsr.edu_yun.frontstage.train.po.Course;
import cn.bnsr.edu_yun.frontstage.train.po.CourseHour;
import cn.bnsr.edu_yun.frontstage.train.po.Train;
import cn.bnsr.edu_yun.frontstage.train.po.UserClassHour;
import cn.bnsr.edu_yun.frontstage.train.po.UserStudy;
import cn.bnsr.edu_yun.frontstage.train.po.UserStudyRecord;
import cn.bnsr.edu_yun.frontstage.train.po.UserTrainClass;
import cn.bnsr.edu_yun.frontstage.train.service.ClassService;
import cn.bnsr.edu_yun.frontstage.train.service.CourseHourService;
import cn.bnsr.edu_yun.frontstage.train.service.CourseInfoService;
import cn.bnsr.edu_yun.frontstage.train.service.CourseService;
import cn.bnsr.edu_yun.frontstage.train.service.TeacherRelationService;
import cn.bnsr.edu_yun.frontstage.train.service.TrainCourseService;
import cn.bnsr.edu_yun.frontstage.train.service.TrainService;
import cn.bnsr.edu_yun.frontstage.train.service.UserClassHourService;
import cn.bnsr.edu_yun.frontstage.train.service.UserStudyRecordService;
import cn.bnsr.edu_yun.frontstage.train.service.UserStudyService;
import cn.bnsr.edu_yun.frontstage.train.service.UserTrainClassService;
import cn.bnsr.edu_yun.frontstage.train.view.ClassView;
import cn.bnsr.edu_yun.frontstage.train.view.CourseView;
import cn.bnsr.edu_yun.frontstage.train.view.TeacherRelationView;
import cn.bnsr.edu_yun.frontstage.train.view.TrainPhaseView;
import cn.bnsr.edu_yun.frontstage.train.view.UserClassHourView;
import cn.bnsr.edu_yun.frontstage.train.view.UserStudyView;
import cn.bnsr.edu_yun.util.NumUtil;
import cn.bnsr.edu_yun.util.ResponseUtil;

/**
 * 考试,试卷批阅
 * 
 * @author li
 * @date 2017年2月9日
 */
@Controller
@RequestMapping("/exam")
public class ExamController {
	private final Logger log = LoggerFactory.getLogger(ExamController.class);

	@Autowired
	private CourseHourService courseHourService;
	@Autowired
	private CourseInfoService courseInfoService;
	@Autowired
	private TestPaperService testPaperService;
	@Autowired
	private TestQuestionsService testQuestionsService;
	@Autowired
	private ExamService examService;
	@Autowired
	private UserService userService;
	@Autowired
	private ClassService classService;
	@Autowired
	private TeacherRelationService teacherRelationService;
	@Autowired
	private NotificationService notificationService;
	@Autowired
	private UserStudyService userStudyService;
	@Autowired
	private UserStudyRecordService userStudyRecordService;
	@Autowired
	private UserClassHourService userClassHourService;
	@Autowired
	private UserTrainClassService userTrainClassService;
	@Autowired
	private TrainService trainService;
	@Autowired
	private TrainCourseService trainCourseService;
	@Autowired
	private UserHomeworkScoreService userHomeworkScoreService;
	@Autowired
	private CourseService courseService;
	@Autowired
	private UserInfoService userInfoService;

	// 跳转我的考试
	@RequestMapping("to_my_exam")
	public ModelAndView to_MyExam(HttpServletRequest request, ExamView examView, int stamp, int state) {
		ModelAndView modelAndView = new ModelAndView();
		User user = (User) request.getSession().getAttribute("currentUser");
		if (examView.getPage() == 0) {
			examView.setStartLine(0);
		} else {
			examView.setStartLine(examView.getPage() * examView.getRows());
		}
		examView.setRows(10);
		examView.setUser_id(user.getId());
		examView.setExam_type(0);
		int total = examService.queryMyExamCount(examView);// 总数
		examView.setTotal(total);
		// 分页总页数
		examView.setTotalPage(NumUtil.totalPage(total, 10));
		List<ExamView> examViews = examService.queryMyExam(examView);
		modelAndView.addObject("examViews", examViews);
		modelAndView.addObject("examView", examView);
		modelAndView.addObject("stamp", stamp);
		modelAndView.addObject("state", state);
		UserInfo userInfo = userInfoService.getByUserId(user.getId());
		request.setAttribute("user", user);
		request.setAttribute("userInfo", userInfo);
		//个人中心统计数据  
		UserCenterView userCenter = userService.queryUserCenter(user.getId());
		modelAndView.addObject("userCenter", userCenter);
		modelAndView.addObject("exam_type", examView.getExam_type());
		modelAndView.addObject("head_title", "我的考试");
		modelAndView.setViewName("frontstage/base/personalCenter/my_exam");
		return modelAndView;

	}

	// 跳转我的作业
	@RequestMapping("to_my_homework")
	public ModelAndView to_MyHomework(HttpServletRequest request, ExamView examView, int stamp, int state) {
		ModelAndView modelAndView = new ModelAndView();
		User user = (User) request.getSession().getAttribute("currentUser");
		if (examView.getPage() == 0) {
			examView.setStartLine(0);
		} else {
			examView.setStartLine(examView.getPage() * examView.getRows());
		}
		examView.setRows(10);
		examView.setUser_id(user.getId());
		examView.setExam_type(1);
		int total = examService.queryMyExamCount(examView);// 总数
		examView.setTotal(total);
		// 分页总页数
		examView.setTotalPage(NumUtil.totalPage(total, 10));
		List<ExamView> examViews = examService.queryMyExam(examView);
		modelAndView.addObject("examViews", examViews);
		modelAndView.addObject("examView", examView);
		modelAndView.addObject("stamp", stamp);
		modelAndView.addObject("state", state);
		
		UserInfo userInfo = userInfoService.getByUserId(user.getId());
		request.setAttribute("user", user);
		request.setAttribute("userInfo", userInfo);
		//个人中心统计数据  
		UserCenterView userCenter = userService.queryUserCenter(user.getId());
		modelAndView.addObject("userCenter", userCenter);
		modelAndView.addObject("head_title", "我的作业");
		modelAndView.addObject("exam_type", examView.getExam_type());
		modelAndView.setViewName("frontstage/base/personalCenter/my_homework");
		return modelAndView;

	}

	// 跳转试卷批阅,作业批改。exam_type 0:试卷;1:作业。status1:未批阅 2:批阅的
	@RequestMapping("exam")
	public ModelAndView toExam(HttpServletRequest request, ExamView examView) {
		ModelAndView modelAndView = new ModelAndView();
		ClassView classView = new ClassView();
		classView.setId(examView.getClass_id());
		int status = examView.getStatus();
		Long classId = classView.getId();
		Integer source_type = examView.getSource_type();
		Long source_id = examView.getSource_id();
		String required = request.getParameter("required");
		if (classId != null && source_type != null) {
			classView = classService.selectOne(classId, source_type);
			if (source_type == 0) {// 班级来源于课程

				if (examView.getPage() == 0) {
					examView.setStartLine(0);
				} else {
					examView.setStartLine(examView.getPage() * examView.getRows());
				}
				examView.setRows(5);
				examView.setCourseId(examView.getSource_id());
				int total = examService.queryExamCount(examView);// 总数
				examView.setTotal(total);
				// 分页总页数
				examView.setTotalPage(NumUtil.totalPage(total, 5));
				List<ExamView> examViews = examService.queryExam(examView);
				if (examView.getStatus() == 1) {
					// 未批阅
					modelAndView.addObject("not_do_total", total);
					examView.setStatus(2);
					int do_total = examService.queryExamCount(examView);
					modelAndView.addObject("do_total", do_total);
					examView.setStatus(1);
				} else {
					// 已批阅
					modelAndView.addObject("do_total", total);
					examView.setStatus(1);
					int not_do_total = examService.queryExamCount(examView);
					modelAndView.addObject("not_do_total", not_do_total);
					examView.setStatus(2);
				}
				modelAndView.addObject("examViews", examViews);
				modelAndView.addObject("status", status);
				modelAndView.addObject("examView", examView);
			} else if (source_type == 1) {// 班级来源于培训
				Train train = trainService.getById(source_id);
				if (train.getType() == 1) {
					List<TrainPhaseView> trainPhaseList = examService.queryTrainPhaseExam(classId, source_id);
					modelAndView.addObject("trainPhaseList", trainPhaseList);
				} else if (train.getType() == 0) {
					modelAndView.addObject("required", required);
					if ("1".equals(required)) {
						// 必修课程
						List<CourseView> requiredCourse = trainCourseService.queryTrainCourseExam(classId, 0, source_id, 0);
						modelAndView.addObject("requiredCourse", requiredCourse);
					} else if ("0".equals(required)) {
						// 选修课程
						List<CourseView> optionCourse = trainCourseService.queryTrainCourseExam(classId, 0, source_id, 1);
						modelAndView.addObject("optionCourse", optionCourse);
					}
				}
				modelAndView.addObject("train_type", train.getType());
			}
			classView.setSign(examView.getSign());
			classView.setFlag(examView.getFlag());

		}
		if(examView.getExam_type()==0){
			modelAndView.addObject("head_title", "试卷批阅");
		}else{
			modelAndView.addObject("head_title", "作业批改");
		}
		modelAndView.addObject("exam_type", examView.getExam_type());
		modelAndView.addObject("classView", classView);
		modelAndView.setViewName("frontstage/tiku/exam/exam_review");
		return modelAndView;

	}
	
	/**
	 * 课程学习-作业预览
	 * @param request
	 * @param testPaperView
	 * @param tab
	 * @param user_study_id
	 * @return
	 */
	@RequestMapping("to_preview_homework")
	public ModelAndView toPreviewHomeWork(HttpServletRequest request, TestPaperView testPaperView, int tab, Long user_study_id) {
		ModelAndView modelAndView = new ModelAndView();
		User user = (User) request.getSession().getAttribute("currentUser");
		String source_type = request.getParameter("source_type");
		String course_id = request.getParameter("course_id");// 培训下的课程id
		Long courseid = testPaperView.getCourseId();
		CourseView courseView = null;
		if (courseid != null) {
			courseView = courseInfoService.queryCourseDetail(courseid);
		}
		if (courseView != null) {
			modelAndView.addObject("courseView", courseView);
			if(courseView.getUserId()==user.getId()){
				modelAndView.addObject("isTeacher", 1);
			}
		}
		/*
		 * 生成exam 用户id 试卷id status=0 exam_type=1
		 */
		Exam exam = new Exam();
		exam.setUser_id(user.getId());
		exam.setTest_paper_id(testPaperView.getId());
		exam.setStatus(0);
		exam.setExam_type(1);
		tab = 2;
		modelAndView.addObject("isPreview",1);
		modelAndView.addObject("exam", exam);
		TestPaperQuestionView testPaperQuestionView = new TestPaperQuestionView();
		testPaperQuestionView.setTestPaper_id(testPaperView.getId());
		testPaperQuestionView.setIs_son(1);
		//List<TestPaperQuestionView> testPaperQuestionViews = testQuestionsService.queryAllTestPaperQuestion(testPaperQuestionView);
		List<TestPaperQuestionView> testPaperQuestionViews = testQuestionsService.queryAllTestPaperQuestionOnDoHomework(testPaperQuestionView);
		testPaperQuestionView.setIs_son(0);
		//List<TestPaperQuestionView> testPaperSonQuestionViews = testQuestionsService.queryAllTestPaperQuestion(testPaperQuestionView);
		List<TestPaperQuestionView> testPaperSonQuestionViews = testQuestionsService.queryAllTestPaperQuestionOnDoHomework(testPaperQuestionView);
		modelAndView.addObject("testPaperQuestionViews", testPaperQuestionViews);
		modelAndView.addObject("testPaperSonQuestionViews", testPaperSonQuestionViews);
		TestPaper testPaper = testPaperService.selectById(testPaperView.getId());
		modelAndView.addObject("testPaper", testPaper);
		modelAndView.addObject("source_type", source_type);
		modelAndView.addObject("course_id", course_id);
		modelAndView.setViewName("frontstage/tiku/exam/homework");
		modelAndView.addObject("tab", tab);
		modelAndView.addObject("head_title", testPaper.getName());
		return modelAndView;
	}

	/*
	 * 跳转作业 作业有几种状态 1，预览状态 这个状态下显示预览中，不能点击提交 2，答题状态 这个状态显示答题中，可以提交作业 3，批改中状态
	 * 学生浏览，显示批改中，可以看答案，没有操作 4，批改中状态 老师浏览，显示批改中，可以看答案，写评语，完成批改
	 * 5，已批改状态，显示合格或者不合格，都可以再次尝试作业，会生成新的，老的记录保留 如果只有客观题就直接出结果 跳转的同时就生成试卷或作业
	 */
	@RequestMapping("to_homework")
	public ModelAndView toHomework(HttpServletRequest request, TestPaperView testPaperView, int tab, Long user_study_id) {
		ModelAndView modelAndView = new ModelAndView();
		User user = (User) request.getSession().getAttribute("currentUser");
		String source_type = request.getParameter("source_type");
		String course_id = request.getParameter("course_id");// 培训下的课程id
		Long courseid = testPaperView.getCourseId();
		Long class_id = testPaperView.getClass_id();
		CourseView courseView = null;
		if (user_study_id != null) {
			UserStudy userStudy = userStudyService.getById(user_study_id);
			class_id = userStudy.getSource_id();
		}
		if (courseid != null) {
			courseView = courseInfoService.queryCourseDetail(courseid);
		}
		if (courseView != null) {
			modelAndView.addObject("courseView", courseView);
		}
		/*
		 * 生成exam 用户id 试卷id status=0 exam_type=1
		 */
		Exam exam = null;
		// 是否指定exam的id
		if (testPaperView.getExam_id() != null) {
			exam = examService.selectById(testPaperView.getExam_id());
		} else {
			exam = new Exam();
			exam.setUser_id(user.getId());
			exam.setClass_id(class_id);
			exam.setTest_paper_id(testPaperView.getId());
			Exam exam1 = examService.selectStatus(exam);
			// 是否已经存在试卷
			if (exam1 != null) {
				exam = exam1;
			} else {
				exam.setStatus(0);
				exam.setExam_type(1);
				examService.insertSelective(exam);
			}
		}
		// 未交卷
		if (exam.getStatus() == 0) {
			tab = 2;
		}
		// 试卷待批阅的状态
		else if (exam.getStatus() == 1) {
			TestPaper testPaper = testPaperService.selectById(testPaperView.getId());
			CourseHour courseHour = courseHourService.getHour(testPaper.getCourse_hour_id() + "");
			boolean flag = false;
			if (courseHour.getCheck_status() == null || courseHour.getCheck_status() == 0) {
				Class c = classService.getById(class_id);
				List<TeacherRelationView> teacherRelationViews = teacherRelationService.queryTeacherRelation(class_id, c.getType() + 1, null);
				// tab=4为老师批改状态
				// 如果不是老师进来，强制tab=3
				for (TeacherRelationView t : teacherRelationViews) {
					if (t.getUserId().equals(user.getId() + "")) {
						flag = true;
						break;
					}
				}
			} else {
				UserHomeworkScoreView userHomeworkScore = new UserHomeworkScoreView();
				userHomeworkScore.setUser_id(user.getId());
				userHomeworkScore.setExam_id(exam.getId());
				userHomeworkScore.setStatus(0);
				// 学生互评入口
				int i = userHomeworkScoreService.findCount(userHomeworkScore);
				if (i != 0) {
					// 是否分配，分配为true
					tab = 4;
					flag = true;
				}

			}
			if (!flag || tab != 4) {
				tab = 3;
			}
		}
		// 已批阅
		else {
			tab = 5;
			// 如果是本人进来，添加可以跳转重新尝试做
			if (exam.getUser_id() == user.getId()) {
				modelAndView.addObject("try_again", true);
			}

		}
		modelAndView.addObject("exam", exam);
		TestPaperQuestionView testPaperQuestionView = new TestPaperQuestionView();
		testPaperQuestionView.setExam_id(exam.getId());
		testPaperQuestionView.setTestPaper_id(testPaperView.getId());
		testPaperQuestionView.setIs_son(1);
		//List<TestPaperQuestionView> testPaperQuestionViews = testQuestionsService.queryAllTestPaperQuestion(testPaperQuestionView);
		List<TestPaperQuestionView> testPaperQuestionViews = testQuestionsService.queryAllTestPaperQuestionOnDoHomework(testPaperQuestionView);
		testPaperQuestionView.setIs_son(0);
		//List<TestPaperQuestionView> testPaperSonQuestionViews = testQuestionsService.queryAllTestPaperQuestion(testPaperQuestionView);
		List<TestPaperQuestionView> testPaperSonQuestionViews = testQuestionsService.queryAllTestPaperQuestionOnDoHomework(testPaperQuestionView);
		modelAndView.addObject("testPaperQuestionViews", testPaperQuestionViews);
		modelAndView.addObject("testPaperSonQuestionViews", testPaperSonQuestionViews);
		TestPaper testPaper = testPaperService.selectById(testPaperView.getId());
		modelAndView.addObject("testPaper", testPaper);
		modelAndView.addObject("source_type", source_type);
		modelAndView.addObject("course_id", course_id);
		modelAndView.setViewName("frontstage/tiku/exam/homework");
		modelAndView.addObject("class_id", class_id);
		modelAndView.addObject("tab", tab);
		modelAndView.addObject("head_title", testPaper.getName());
		return modelAndView;
	}

	/**
	 * 暂时考试共用一个方法
	 * 
	 * @param param
	 * @param exam_id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("finish_homework")
	@ResponseBody
	public JSONObject finishHomework(@RequestBody String param, long exam_id, Long time, Long user_study_id) throws Exception {
		// 如果exam已经提交过了，就不进行
		Exam exam = examService.selectById(exam_id);
		Long class_id = exam.getClass_id();// 新加入的属性

		if (user_study_id == null) {
			UserStudyView userStudyView = new UserStudyView();

			userStudyView.setUserId(exam.getUser_id() + "");
			userStudyView.setSourceId(class_id + "");
			List<UserStudy> userStudys = userStudyService.searchIsPay(userStudyView);
			user_study_id = userStudys.get(0).getId();
		}
		// 获取userStudy
		UserStudy userStudy = userStudyService.getById(user_study_id);
		// 找到
		TestPaper testPaper = testPaperService.selectById(exam.getTest_paper_id());
		CourseHour courseHour = courseHourService.getHour(testPaper.getCourse_hour_id() + "");

		if (courseHour.getCheck_status() != null && courseHour.getCheck_status() == 1) {

			Integer num = courseHour.getFrequency();
			if (num != null) {
				UserStudyView studyView = new UserStudyView();
				studyView.setSourceId(userStudy.getSource_id() + "");
				studyView.setSourceType(userStudy.getSource_type() + "");
				studyView.setLearnId(userStudy.getLearn_id() + "");
				List<UserStudyView> studentList = userStudyService.searchStudent(studyView);
				Random random = new Random();
				List<Long> userIds = new ArrayList<Long>();
				/*
				 * 处理一个用户的特殊情况，互评就给自己处理。并不合理，但一个用户的情况也只是理论，暂时给他自己互评
				 */
				if (studentList.size() == 1) {
					userIds.add(exam.getUser_id());
				} else {
					int i = 0;// 互评人的数量
					int size = studentList.size() - 1;// 除去做题人自己的用户数
					if (size > num) {
						i = num; // 如果用户数超过了规定的互评人数，取规定的互评人数，
					} else {
						i = size;// 如果用户数不够规定的互评人数，取用户的人数。
					}
					for (int j = 0; j < i;) {
						int index = random.nextInt(size + 1);// 随机0到size的数量不包含size
						long user_id = Long.parseLong(studentList.get(index).getUserId());
						boolean flag = true;
						if (user_id == exam.getUser_id()) {
							flag = false;// 随机的用户不能为做题人
						} else {
							for (long userId : userIds) {
								if (user_id == userId) {
									flag = false;// 如果此人已经分配了
								}
							}
						}
						if (flag) {
							userIds.add(user_id);
							j++;
						}
					}
				}
				// 随机获得的list列表
				for (long userId : userIds) {
					UserHomeworkScore useHomeworkScore = new UserHomeworkScore();
					useHomeworkScore.setExam_id(exam_id);
					useHomeworkScore.setUser_id(userId);
					useHomeworkScore.setStatus(0);
					userHomeworkScoreService.insert(useHomeworkScore);
				}
			}
		}
		if (exam.getStatus() == 0) {
			Date date = new Date();
			JSONObject jo = JSONObject.fromObject(param);
			Iterator iterator = jo.keys();
			boolean b = true;// 是否自动阅卷,如果有问答题，赋值false
			double score = 0;// 总分
			double right = 0;// 得分
			while (iterator.hasNext()) {
				boolean flag = false;
				String key = (String) iterator.next();
				String value = jo.getString(key);// 用户回答的答案
				long id = Long.parseLong(key);// 题目的id，可以获取题目正确答案和类型。是paper_question的id
				ExamAnswer answer = new ExamAnswer();
				answer.setTest_questions_id(id);
				answer.setAnswer(value);
				answer.setExam_id(exam_id);
				TestPaperQuestionView testPaperQuestionView = testQuestionsService.queryOneTestPaperQuestion(id);
				score += testPaperQuestionView.getQuestions_score();
				if (testPaperQuestionView.getType() != 3) {
					if (testPaperQuestionView.getType() == 0 || testPaperQuestionView.getType() == 2|| testPaperQuestionView.getType() == 5) {
						flag = value.trim().equals(testPaperQuestionView.getRight_key());
					}
					if (testPaperQuestionView.getType() == 1) {
						String[] valueStr = value.split(",");
						String[] rightKeyStr = testPaperQuestionView.getRight_key().split(",");
						int i = 0;
						for (String rightKey : rightKeyStr) {
							String difKey[] = rightKey.split("\\|");
							for (String dif : difKey) {
								if (dif.trim().equals(valueStr[i].trim())) {
									flag = true;
									break;
								} else {
									flag = false;
								}
							}
							if (!flag) {
								break;
							}
							i++;
						}
					}
					if (flag) {
						answer.setIs_right(0);
						right += testPaperQuestionView.getQuestions_score();
						answer.setAnswer_score(testPaperQuestionView.getQuestions_score());
					} else {
						answer.setIs_right(1);
						answer.setAnswer_score(0.0);
					}
				} else {
					b = false;
					answer.setIs_right(2);
				}
				if (value.replace(",", "").trim().equals("")) {
					answer.setIs_right(3);
				}
				examService.saveAnswer(answer);
			}

			if (b) {
				exam.setStatus(2);
				exam.setExam_score(right);
				String accordScore = testPaper.getAccord_score();
				double best = 1;
				double better = 1;
				double good = 1;
				if (accordScore == null) {
					best = 1.0;
					better = 0.8;
					good = 0.6;
				} else {
					String[] accordScores = accordScore.split(",");
					if (accordScores.length == 1) {
						good = Double.parseDouble(accordScores[0]);
					} else if (accordScores.length == 2) {
						good = Double.parseDouble(accordScores[0]);
						better = Double.parseDouble(accordScores[1]);
					} else if (accordScores.length == 3) {
						good = Double.parseDouble(accordScores[0]);
						better = Double.parseDouble(accordScores[1]);
						best = Double.parseDouble(accordScores[2]);
					} else {
						best = 1.0;
						better = 0.8;
						good = 0.6;
					}
				}

				if (right / score >= good && right / score < better) {
					exam.setGrade(2);
				} else if (right / score >= better && right / score < best) {
					exam.setGrade(1);
				} else if (right / score == best) {
					exam.setGrade(0);
				} else {
					exam.setGrade(3);
				}
				// 完成学习
				if (exam.getGrade() != 3) {
					long course_hour_id = testPaper.getCourse_hour_id();
					// userClassHour的class是课程的培训班级，不是培训班，现在exam里是培训的话
					// 存的是培训的class queryClass
					UserClassHour userClassHour = new UserClassHour();
					userClassHour.setCourse_hour_id(course_hour_id);
					userClassHour.setUser_id(exam.getUser_id());
					userClassHour.setClass_id(class_id);
					userClassHour = userClassHourService.selectByHourId(userClassHour);
					userClassHour.setIs_studyed(1);
					userClassHourService.update(userClassHour);
					UserStudyRecord record = new UserStudyRecord();
					record.setUser_id(exam.getUser_id());
					record.setLearn_id(userClassHour.getCourse_id());
					record.setSource_name(courseHour.getHour_title());
					record.setSource_id(userStudy.getSource_id());
					record.setSource_type(userStudy.getSource_type());
					record.setCreate_time(new Date());
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
					record.setMsg("学完了课时");
					userStudyRecordService.saveUserStudyRecord(record);
					// 所有课时的数
					int allNum = userClassHourService.selectCountByCourseIdAndUserId(userClassHour);
					// 已学课时数
					int studyNum = userClassHourService.selectCountByCourseIdAndUserIdStudy(userClassHour);
					// 算成绩
					// 证书
					examService.updateByPrimaryKeySelective(exam);
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
							userTrainClass.setUser_id(exam.getUser_id());
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
			} else {
				exam.setExam_score(score);
				exam.setStatus(1);
				long course_hour_id = testPaper.getCourse_hour_id();
				UserClassHour userClassHour = new UserClassHour();
				userClassHour.setCourse_hour_id(course_hour_id);
				userClassHour.setUser_id(exam.getUser_id());
				userClassHour.setClass_id(class_id);
				userClassHour = userClassHourService.selectByHourId(userClassHour);
				userClassHour.setIs_studyed(2);
				userClassHourService.update(userClassHour);
			}
			exam.setSubmit_time(date);
			if (time != null)
				exam.setExam_hour(time + "");
			examService.updateByPrimaryKeySelective(exam);
		}
		JSONObject other = new JSONObject();
		return other;
	}

	// 作业批改方法
	@RequestMapping("check_homework")
	@ResponseBody
	public JSONObject checkHomework(@RequestBody String param, HttpServletRequest request, long exam_id) throws Exception {
		JSONObject jo = JSONObject.fromObject(param);
		Iterator iterator = jo.keys();
		while (iterator.hasNext()) {
			String key = (String) iterator.next();
			String difKey[] = key.split("\\|");
			long id = Long.parseLong(difKey[0]);// id
			int is_right = Integer.parseInt(difKey[1]);// 对错
			double score = Double.parseDouble(difKey[2]);// 分数
			String value = jo.getString(key);// 评语
			ExamAnswer answer = examService.selectAnswer(id);
			// TestPaperQuestionView testPaperQuestionView =
			// testQuestionsService.queryOneTestPaperQuestion(answer.getTest_questions_id());
			answer.setId(id);
			answer.setAnswer_score(score);
			answer.setAnswer_comment(value);
			answer.setIs_right(is_right);
			examService.updateAnswer(answer);
		}
		List<ExamAnswer> examAnswers = examService.selectByExam(exam_id);
		Exam exam = examService.selectById(exam_id);
		double score = exam.getExam_score();// 总分
		double right = 0;// 得分
		int grade = 0;// 等级
		for (ExamAnswer ea : examAnswers) {

			right += ea.getAnswer_score();

		}
		System.out.println(right);
		TestPaper testPaper = testPaperService.selectById(exam.getTest_paper_id());
		String accordScore = testPaper.getAccord_score();
		double best = 1;
		double better = 1;
		double good = 1;
		if (accordScore == null) {
			best = 1.0;
			better = 0.8;
			good = 0.6;
		} else {
			String[] accordScores = accordScore.split(",");
			if (accordScores.length == 1) {
				good = Double.parseDouble(accordScores[0]);
			} else if (accordScores.length == 2) {
				good = Double.parseDouble(accordScores[0]);
				better = Double.parseDouble(accordScores[1]);
			} else if (accordScores.length == 3) {
				good = Double.parseDouble(accordScores[0]);
				better = Double.parseDouble(accordScores[1]);
				best = Double.parseDouble(accordScores[2]);
			} else {
				best = 1.0;
				better = 0.8;
				good = 0.6;
			}
		}
		if (right / score >= good && right / score < better) {
			grade = 2;
		} else if (right / score >= better && right / score < best) {
			grade = 1;
		} else if (right / score == best) {
			grade = 0;
		} else {
			grade = 3;
		}
		JSONObject other = new JSONObject();
		other.put("right", right);
		other.put("score", score);
		other.put("grade", grade);
		return other;
	}

	@RequestMapping("check_finish")
	public ModelAndView checkFinish(HttpServletRequest request, ExamView examView) {
		Long exam_id = examView.getId();
		Long class_id = examView.getClass_id();
		Date date = new Date();
		User user = (User) request.getSession().getAttribute("currentUser");
		String source_type = request.getParameter("source_type");
		String course_id = request.getParameter("course_id");
		Exam exam = examService.selectById(exam_id);
		String redirect = null;
		TestPaper testPaper = testPaperService.selectById(exam.getTest_paper_id());
		CourseHour courseHour = courseHourService.getHour(testPaper.getCourse_hour_id() + "");
		boolean flag = false;
		if (courseHour.getCheck_status() != null && courseHour.getCheck_status() == 1) {
			UserHomeworkScoreView userHomeworkScoreView = new UserHomeworkScoreView();
			userHomeworkScoreView.setExam_id(exam_id);
			userHomeworkScoreView.setStatus(0);
			userHomeworkScoreView.setUser_id(user.getId());
			// 全部评完flag=true
			userHomeworkScoreView = userHomeworkScoreService.findList(userHomeworkScoreView).get(0);
			if (userHomeworkScoreView != null) {
				UserHomeworkScore userHomeworkScore = new UserHomeworkScore();
				userHomeworkScore.setId(userHomeworkScoreView.getId());
				userHomeworkScore.setStatus(1);
				userHomeworkScore.setScore(examView.getScore());
				userHomeworkScoreService.update(userHomeworkScore);
				userHomeworkScoreView.setUser_id(null);
				// 未批阅的数量，当为0时，即为都互评了此用户的作业
				int count = userHomeworkScoreService.findCount(userHomeworkScoreView);
				if (count == 0) {
					userHomeworkScoreView.setStatus(null);
					List<UserHomeworkScoreView> userHomeworkScoreViews = userHomeworkScoreService.findList(userHomeworkScoreView);
					double score = 0.0;
					for (UserHomeworkScoreView userHomeworkScoreView2 : userHomeworkScoreViews) {
						score += userHomeworkScoreView2.getScore();
					}
					if (userHomeworkScoreViews.size() > 0 && score != 0) {
						score = score / userHomeworkScoreViews.size();
					} else {
						score = 0;
					}
					flag = true;
					// 保存成绩
					exam.setStatus(2);
					exam.setExam_score(score);
					exam.setGrade(examView.getGrade());
					exam.setMarking_time(date);
					exam.setMarking_user_id(user.getId());
					exam.setExam_comment(examView.getExam_comment());
					examService.updateByPrimaryKeySelective(exam);
				}
			}
			redirect = "redirect:/exam/each_homework.action?stamp=2&state=28";
		} else {
			flag = true;
			// 保存成绩
			exam.setStatus(2);
			exam.setExam_score(examView.getScore());
			exam.setGrade(examView.getGrade());
			exam.setMarking_time(date);
			exam.setMarking_user_id(user.getId());
			exam.setExam_comment(examView.getExam_comment());
			examService.updateByPrimaryKeySelective(exam);
            int sign=4;
            if(exam.getExam_type()==1){
            	sign=5;
            }
			if ("1".equals(source_type)) {
				// ${pageContext.request.contextPath}/exam/course_exam.action?required=1&id=${classView.id}&class_id=${course.class_id}&flag=${classView.flag}&sign=${classView.sign}&exam_type=${exam_type}&status=1&source_id=${course.id}&class_type=${course.class_type}&source_type=${classView.source_type}
				redirect = "redirect:/exam/course_exam.action?required=1&id=" + class_id + "&flag=2&sign="+sign+"&exam_type=" + exam.getExam_type()
						+ "&status=1&source_id=" + course_id + "&class_type=2&source_type=1";
			} else if ("0".equals(source_type)) {
				redirect = "redirect:/exam/exam.action?class_id=" + class_id + "&source_id=" + examView.getCourseId()
						+ "&flag=2&sign="+sign+"&status=1&source_type=0&exam_type=" + exam.getExam_type();
			}

		}
		if (exam.getGrade() == 3) {
			flag = false;
		}
		if (flag) {
			UserStudyView userStudyView = new UserStudyView();
			userStudyView.setUserId(exam.getUser_id() + "");
			userStudyView.setSourceId(class_id + "");
			List<UserStudy> userStudys = userStudyService.searchIsPay(userStudyView);
			Long user_study_id = userStudys.get(0).getId();

			// 获取userStudy
			UserStudy userStudy = userStudyService.getById(user_study_id);
			long course_hour_id = testPaper.getCourse_hour_id();
			UserClassHour userClassHour = new UserClassHour();
			userClassHour.setCourse_hour_id(course_hour_id);
			userClassHour.setUser_id(exam.getUser_id());
			userClassHour.setClass_id(class_id);
			userClassHour = userClassHourService.selectByHourId(userClassHour);
			userClassHour.setIs_studyed(1);
			userClassHourService.update(userClassHour);
			UserStudyRecord record = new UserStudyRecord();
			record.setUser_id(exam.getUser_id());
			record.setLearn_id(userClassHour.getCourse_id());
			record.setSource_name(courseHour.getHour_title());
			record.setMsg("学完了课时");
			record.setSource_id(userStudy.getSource_id());
			record.setSource_type(userStudy.getSource_type());
			record.setCreate_time(new Date());
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
					userTrainClass.setUser_id(exam.getUser_id());
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
		return new ModelAndView(redirect);
	}

	// 重新做题方法
	@RequestMapping("do_again")
	public ModelAndView doAgain(HttpServletRequest request, TestPaperView testPaperView, int exam_type) {
		User user = (User) request.getSession().getAttribute("currentUser");
		/*
		 * 生成exam 用户id 试卷id status=0 exam_type=1
		 */
		Exam exam = new Exam();
		exam.setUser_id(user.getId());
		exam.setTest_paper_id(testPaperView.getId());
		exam.setClass_id(testPaperView.getClass_id());
		exam.setStatus(0);
		exam.setExam_type(exam_type);
		Exam exam1 = examService.selectStatus(exam);
		if (exam1.getStatus() == 2) {
			examService.insertSelective(exam);
		}
		if (exam_type == 1)
			return new ModelAndView("redirect:/exam/to_homework.action?id=" + testPaperView.getId() + "&courseId=" + testPaperView.getCourseId() + "&class_id="
					+ testPaperView.getClass_id() + "&tab=2");
		else
			return new ModelAndView("redirect:/exam/to_test.action?id=" + testPaperView.getId() + "&courseId=" + testPaperView.getCourseId() + "&class_id="
					+ testPaperView.getClass_id() + "&tab=2");
	}
	
	/**
	 * 课程学习-考试预览
	 * @param request
	 * @param testPaperView
	 * @param tab
	 * @param user_study_id
	 * @return
	 */
	@RequestMapping("to_preview_test")
	public ModelAndView toPreViewTest(HttpServletRequest request, TestPaperView testPaperView, int tab, Long user_study_id) {
		ModelAndView modelAndView = new ModelAndView();
		User user = (User) request.getSession().getAttribute("currentUser");
		String source_type = request.getParameter("source_type");
		String course_id = request.getParameter("course_id");// 培训下的课程id
		Long courseid = testPaperView.getCourseId();
		CourseView courseView = null;
		if (courseid != null) {
			courseView = courseInfoService.queryCourseDetail(courseid);
		}
		if (courseView != null) {
			modelAndView.addObject("courseView", courseView);
			if(courseView.getUserId()==user.getId()){
				modelAndView.addObject("isTeacher", 1);
			}
		}
		Exam exam = new Exam();
		exam.setUser_id(user.getId());
		exam.setTest_paper_id(testPaperView.getId());
		// 是否已经存在试卷
		exam.setStatus(0);
		exam.setExam_type(0);
		// 未交卷
		tab = 2;
		modelAndView.addObject("exam", exam);
		// 展示题目,0-4代表五种题目类型，5代表子题  //新加入一种类型单选
		for (int type = 0; type < 7; type++) {
			TestPaperQuestionView testPaperQuestionView = new TestPaperQuestionView();
			testPaperQuestionView.setTestPaper_id(testPaperView.getId());
			testPaperQuestionView.setType(type);
			//List<TestPaperQuestionView> testPaperQuestionViews = testQuestionsService.queryTestPaperQuestion(testPaperQuestionView);
			List<TestPaperQuestionView> testPaperQuestionViews = testQuestionsService.queryTestPaperQuestionOnDoTest(testPaperQuestionView);
			modelAndView.addObject("testPaperQuestionViews" + type, testPaperQuestionViews);
			double total_score = 0;
			double right_score = 0;
			int right = 0;
			int wrong = 0;
			int not_do = 0;
			for (TestPaperQuestionView t : testPaperQuestionViews) {
				//total_score += t.getQuestions_score();
				if(t.getQuestion_status()==null||t.getQuestion_status()!=2){
					total_score += t.getQuestions_score();
				}else{
					continue;
				}
				if (t.getIs_right() == 0) {
					right++;
					right_score += t.getQuestions_score();
				}
				if (t.getIs_right() == 1) {
					wrong++;
					right_score += t.getAnswer_score();
				}
				if (t.getIs_right() == 3) {
					not_do++;
				}
				if (type == 6 && tab == 4 && t.getType() == 3) {
					modelAndView.addObject("status", 1);
				}
			}
			modelAndView.addObject("total_score" + type, total_score);
			modelAndView.addObject("right" + type, right);
			modelAndView.addObject("wrong" + type, wrong);
			modelAndView.addObject("not_do" + type, not_do);
			modelAndView.addObject("right_score" + type, right_score);
		}
		TestPaper testPaper = testPaperService.selectById(testPaperView.getId());
		Integer time = testPaper.getTimeless();
		if (time != null && time != 0 && exam.getExam_hour() != null) {
			double time1 = time - Integer.parseInt(exam.getExam_hour()) / 60.0;
			modelAndView.addObject("time", time1);
		} else {
			modelAndView.addObject("time", time);
		}
		modelAndView.addObject("isPreview", 1);
		modelAndView.addObject("source_type", source_type);
		modelAndView.addObject("course_id", course_id);
		modelAndView.addObject("testPaper", testPaper);
		modelAndView.addObject("tab", tab);
		modelAndView.addObject("user", userService.selectByPrimaryKey(exam.getUser_id()));
		modelAndView.addObject("head_title", testPaper.getName());
		modelAndView.setViewName("frontstage/tiku/exam/do_test");
		return modelAndView;
	}
	
	// 跳转考试
	@RequestMapping("to_test")
	public ModelAndView toTest(HttpServletRequest request, TestPaperView testPaperView, int tab, Long user_study_id) {
		ModelAndView modelAndView = new ModelAndView();
		User user = (User) request.getSession().getAttribute("currentUser");
		String source_type = request.getParameter("source_type");
		String course_id = request.getParameter("course_id");// 培训下的课程id
		Long courseid = testPaperView.getCourseId();
		Long class_id = testPaperView.getClass_id();
		CourseView courseView = null;
		if (user_study_id != null) {
			UserStudy userStudy = userStudyService.getById(user_study_id);
			class_id = userStudy.getSource_id();
		}
		if (courseid != null) {
			courseView = courseInfoService.queryCourseDetail(courseid);
		}
		if (courseView != null) {
			modelAndView.addObject("courseView", courseView);
		}
		Exam exam = null;
		// 是否指定exam的id
		if (testPaperView.getExam_id() != null) {
			exam = examService.selectById(testPaperView.getExam_id());
		} else {
			exam = new Exam();
			exam.setUser_id(user.getId());
			exam.setClass_id(class_id);
			exam.setTest_paper_id(testPaperView.getId());
			Exam exam1 = examService.selectStatus(exam);
			// 是否已经存在试卷
			if (exam1 != null) {
				exam = exam1;
			} else {
				exam.setStatus(0);
				exam.setExam_type(0);
				examService.insertSelective(exam);
			}
		}
		// 未交卷
		if (exam.getStatus() == 0) {
			tab = 2;
		}
		// 试卷待批阅的状态
		else if (exam.getStatus() == 1) {
			// tab=4为老师批改状态
			// 如果不是老师进来，强制tab=3
			Class c = classService.getById(class_id);
			List<TeacherRelationView> teacherRelationViews = teacherRelationService.queryTeacherRelation(class_id, c.getType() + 1, null);
			// tab=4为老师批改状态
			// 如果不是老师进来，强制tab=3
			boolean flag = false;
			for (TeacherRelationView t : teacherRelationViews) {
				if (t.getUserId().equals(user.getId() + "")) {
					flag = true;
					break;
				}
			}

			if (!flag || tab != 4) {
				tab = 3;
			}
		}
		// 已批阅
		else {
			tab = 5;
			// 如果是本人进来，添加可以跳转重新尝试做
			if (exam.getUser_id() == user.getId()) {
				modelAndView.addObject("try_again", true);
			}

		}
		modelAndView.addObject("exam", exam);
		// 展示题目,0-4代表五种题目类型，5代表子题  //新加入一种类型单选
		for (int type = 0; type < 7; type++) {
			TestPaperQuestionView testPaperQuestionView = new TestPaperQuestionView();
			testPaperQuestionView.setTestPaper_id(testPaperView.getId());
			testPaperQuestionView.setType(type);
			testPaperQuestionView.setExam_id(exam.getId());
			//List<TestPaperQuestionView> testPaperQuestionViews = testQuestionsService.queryTestPaperQuestion(testPaperQuestionView);
			List<TestPaperQuestionView> testPaperQuestionViews = testQuestionsService.queryTestPaperQuestionOnDoTest(testPaperQuestionView);
			/*
			List<TestPaperQuestionView> testPaperQuestionViews = null;
			if (tab == 2){ //考试状态
				testPaperQuestionViews = testQuestionsService.queryTestPaperQuestionOnDoTest(testPaperQuestionView);
			}else if (tab == 3 || tab == 4 || tab == 5){ //核对答案/查阅试卷
				testPaperQuestionViews = testQuestionsService.queryTestPaperQuestionOnDoCheck(testPaperQuestionView);
			}
			*/
			modelAndView.addObject("testPaperQuestionViews" + type, testPaperQuestionViews);
			double total_score = 0;
			double right_score = 0;
			int right = 0;
			int wrong = 0;
			int not_do = 0;
			for (TestPaperQuestionView t : testPaperQuestionViews) {
				if(t.getQuestion_status()==null||t.getQuestion_status()!=2){
					total_score += t.getQuestions_score();
				}else{
					continue;
				}
				if (t.getIs_right() == 0) {
					right++;
					right_score += t.getQuestions_score();
				}
				if (t.getIs_right() == 1) {
					wrong++;
					right_score += t.getAnswer_score();
				}
				if (t.getIs_right() == 3) {
					not_do++;
				}
				if (type == 6 && tab == 4 && t.getType() == 3) {
					modelAndView.addObject("status", 1);
				}

			}
			modelAndView.addObject("total_score" + type, total_score);
			modelAndView.addObject("right" + type, right);
			modelAndView.addObject("wrong" + type, wrong);
			modelAndView.addObject("not_do" + type, not_do);
			modelAndView.addObject("right_score" + type, right_score);
		}
		TestPaper testPaper = testPaperService.selectById(testPaperView.getId());
		Integer time = testPaper.getTimeless();
		if (time != null && time != 0 && exam.getExam_hour() != null) {
			double time1 = time - Integer.parseInt(exam.getExam_hour()) / 60.0;
			modelAndView.addObject("time", time1);
		} else {
			modelAndView.addObject("time", time);
		}
		modelAndView.addObject("source_type", source_type);
		modelAndView.addObject("course_id", course_id);
		modelAndView.addObject("testPaper", testPaper);
		modelAndView.addObject("tab", tab);
		modelAndView.addObject("class_id", class_id);
		modelAndView.addObject("user", userService.selectByPrimaryKey(exam.getUser_id()));
		modelAndView.addObject("head_title", testPaper.getName());
		if (tab == 2)
			modelAndView.setViewName("frontstage/tiku/exam/do_test");
		if (tab == 3 || tab == 4 || tab == 5)
			modelAndView.setViewName("frontstage/tiku/exam/check_test");

		return modelAndView;
	}

	// 下次再做
	@RequestMapping("do_late")
	@ResponseBody
	public void doLate(@RequestBody String param, long exam_id, long time) throws Exception {
		// 如果exam已经提交过了，就不进行
		JSONObject jo = JSONObject.fromObject(param);
		Iterator iterator = jo.keys();
		while (iterator.hasNext()) {
			String key = (String) iterator.next();
			String value = jo.getString(key);// 用户回答的答案
			long id = Long.parseLong(key);// 题目的id，可以获取题目正确答案和类型。是paper_question的id
			ExamAnswer answer = new ExamAnswer();
			answer.setTest_questions_id(id);
			answer.setAnswer(value);
			answer.setExam_id(exam_id);
			examService.saveAnswer(answer);
		}
		Exam exam = new Exam();
		exam.setId(exam_id);
		exam.setExam_hour(time + "");
		examService.updateByPrimaryKeySelective(exam);

	}

	// 跳转课程下的试卷批阅,作业批改。exam_type 0:试卷;1:作业。status1:未批阅 2:批阅的
	@RequestMapping("course_exam")
	public ModelAndView toTrainCourse(HttpServletRequest request, ExamView examView) {
		ModelAndView modelAndView = new ModelAndView();
		ClassView classView = new ClassView();
		int status = examView.getStatus();
		Long classId = examView.getId();// 实际的班级id,而不是培训课程的班级id
		Integer source_type = examView.getSource_type();
		String required = request.getParameter("required");
		Long course_id = examView.getSource_id();
		examView.setCourseId(course_id);
		if (classId != null && source_type != null) {
			classView = classService.selectOne(classId, source_type);
			if (examView.getPage() == 0) {
				examView.setStartLine(0);
			} else {
				examView.setStartLine(examView.getPage() * examView.getRows());
			}
			examView.setRows(5);
			examView.setClass_id(classId);
			examView.setCourseId(examView.getSource_id());
			int total = examService.queryExamCount(examView);// 总数
			examView.setTotal(total);
			// 分页总页数
			examView.setTotalPage(NumUtil.totalPage(total, 5));
			List<ExamView> examViews = examService.queryExam(examView);
			if (examView.getStatus() == 1) {
				// 未批阅
				modelAndView.addObject("not_do_total", total);
				examView.setStatus(2);
				int do_total = examService.queryExamCount(examView);
				modelAndView.addObject("do_total", do_total);
				examView.setStatus(1);
			} else {
				// 已批阅
				modelAndView.addObject("do_total", total);
				examView.setStatus(1);
				int not_do_total = examService.queryExamCount(examView);
				modelAndView.addObject("not_do_total", not_do_total);
				examView.setStatus(2);
			}
			modelAndView.addObject("examViews", examViews);
			modelAndView.addObject("status", status);
			modelAndView.addObject("exam_type", examView.getExam_type());
			modelAndView.addObject("examView", examView);
		}
		classView.setSign(examView.getSign());
		classView.setFlag(examView.getFlag());
		Course course = courseService.getById(examView.getSource_id());
		modelAndView.addObject("courseTitle", course.getTitle());
		modelAndView.addObject("classView", classView);
		modelAndView.addObject("required", required);
		modelAndView.addObject("course_id", course_id);
		if(examView.getExam_type()==0){
			modelAndView.addObject("head_title", "试卷批阅");
		}else{
			modelAndView.addObject("head_title", "作业批改");
		}
		modelAndView.setViewName("frontstage/tiku/exam/exam_review");
		return modelAndView;
	}

	@RequestMapping("each_homework")
	public ModelAndView eachHomeWork(HttpServletRequest request, UserHomeworkScoreView userHomeworkScoreView, int stamp, int state) {
		ModelAndView modelAndView = new ModelAndView();
		User user = (User) request.getSession().getAttribute("currentUser");
		userHomeworkScoreView.setUser_id(user.getId());
		if (userHomeworkScoreView.getPage() == 0) {
			userHomeworkScoreView.setStartLine(0);
		} else {
			userHomeworkScoreView.setStartLine(userHomeworkScoreView.getPage() * userHomeworkScoreView.getRows());
		}
		userHomeworkScoreView.setRows(10);
		int total = userHomeworkScoreService.findCount(userHomeworkScoreView);// 总数
		userHomeworkScoreView.setTotal(total);
		// 分页总页数
		userHomeworkScoreView.setTotalPage(NumUtil.totalPage(total, 10));

		List<UserHomeworkScoreView> userHomeworkScores = userHomeworkScoreService.findList(userHomeworkScoreView);
		modelAndView.addObject("userHomeworkScores", userHomeworkScores);
		modelAndView.addObject("userHomeworkScoreView", userHomeworkScoreView);
		modelAndView.setViewName("frontstage/base/personalCenter/each_homework");
		modelAndView.addObject("stamp", stamp);
		modelAndView.addObject("state", state);
		modelAndView.addObject("head_title", "作业互评");
		return modelAndView;
	}
	@RequestMapping("ask_teacher")
	public void askTeacher(HttpServletRequest request, HttpServletResponse response,Long course_id) throws Exception {
		User user = (User) request.getSession().getAttribute("currentUser");
		JSONObject result = new JSONObject();
		Date date = new Date();
		Course course=courseService.getById(course_id);
		Notification notification = new Notification();
		notification.setIs_read(1);
		notification.setSource_id(course_id);
		notification.setSource_type(0);
		notification.setCreate_time(date);
		notification.setNotice_time(date);
		notification.setUser_id(course.getUser_id());
		notification.setOther_user_id(user.getId());
		notification.setNotice_type_id(18);
		notificationService.insert(notification);
		
		ResponseUtil.write(response, result);

	}
}