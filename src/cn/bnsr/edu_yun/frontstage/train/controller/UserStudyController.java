package cn.bnsr.edu_yun.frontstage.train.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.backstage.base.view.ClassifyView;
import cn.bnsr.edu_yun.backstage.train.view.TopicAnswerView;
import cn.bnsr.edu_yun.frontstage.base.po.Notification;
import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.base.po.UserInfo;
import cn.bnsr.edu_yun.frontstage.base.po.UserProperty;
import cn.bnsr.edu_yun.frontstage.base.po.User_attent;
import cn.bnsr.edu_yun.frontstage.base.service.ClassifyService;
import cn.bnsr.edu_yun.frontstage.base.service.NotificationService;
import cn.bnsr.edu_yun.frontstage.base.service.UserAttentService;
import cn.bnsr.edu_yun.frontstage.base.service.UserInfoService;
import cn.bnsr.edu_yun.frontstage.base.service.UserService;
import cn.bnsr.edu_yun.frontstage.base.view.UserCenterView;
import cn.bnsr.edu_yun.frontstage.base.view.UserDetailView;
import cn.bnsr.edu_yun.frontstage.train.po.Course;
import cn.bnsr.edu_yun.frontstage.train.po.CourseHour;
import cn.bnsr.edu_yun.frontstage.train.po.CourseNote;
import cn.bnsr.edu_yun.frontstage.train.po.TopicAnswer;
import cn.bnsr.edu_yun.frontstage.train.po.TopicQuestion;
import cn.bnsr.edu_yun.frontstage.train.po.Train;
import cn.bnsr.edu_yun.frontstage.train.po.UserAppraise;
import cn.bnsr.edu_yun.frontstage.train.po.UserClassHour;
import cn.bnsr.edu_yun.frontstage.train.po.UserStudy;
import cn.bnsr.edu_yun.frontstage.train.po.UserStudyRecord;
import cn.bnsr.edu_yun.frontstage.train.service.CertificateService;
import cn.bnsr.edu_yun.frontstage.train.service.ClassService;
import cn.bnsr.edu_yun.frontstage.train.service.CourseExamStandardService;
import cn.bnsr.edu_yun.frontstage.train.service.CourseHourService;
import cn.bnsr.edu_yun.frontstage.train.service.CourseInfoService;
import cn.bnsr.edu_yun.frontstage.train.service.CourseNoteAgreeService;
import cn.bnsr.edu_yun.frontstage.train.service.CourseNoteService;
import cn.bnsr.edu_yun.frontstage.train.service.CourseService;
import cn.bnsr.edu_yun.frontstage.train.service.MessageService;
import cn.bnsr.edu_yun.frontstage.train.service.TeacherRelationService;
import cn.bnsr.edu_yun.frontstage.train.service.TopicAnswerService;
import cn.bnsr.edu_yun.frontstage.train.service.TopicQuestionService;
import cn.bnsr.edu_yun.frontstage.train.service.TrainCourseService;
import cn.bnsr.edu_yun.frontstage.train.service.TrainPhaseService;
import cn.bnsr.edu_yun.frontstage.train.service.TrainService;
import cn.bnsr.edu_yun.frontstage.train.service.UserAppraiseService;
import cn.bnsr.edu_yun.frontstage.train.service.UserClassHourService;
import cn.bnsr.edu_yun.frontstage.train.service.UserStudyRecordService;
import cn.bnsr.edu_yun.frontstage.train.service.UserStudyService;
import cn.bnsr.edu_yun.frontstage.train.service.UserTrainClassService;
import cn.bnsr.edu_yun.frontstage.train.view.AppraiseReasonView;
import cn.bnsr.edu_yun.frontstage.train.view.CertificatesView;
import cn.bnsr.edu_yun.frontstage.train.view.ClassView;
import cn.bnsr.edu_yun.frontstage.train.view.CourseExamStandardView;
import cn.bnsr.edu_yun.frontstage.train.view.CourseHourView;
import cn.bnsr.edu_yun.frontstage.train.view.CourseRankView;
import cn.bnsr.edu_yun.frontstage.train.view.CourseView;
import cn.bnsr.edu_yun.frontstage.train.view.MessageView;
import cn.bnsr.edu_yun.frontstage.train.view.StudyCenterView;
import cn.bnsr.edu_yun.frontstage.train.view.StudyView;
import cn.bnsr.edu_yun.frontstage.train.view.TeacherRelationView;
import cn.bnsr.edu_yun.frontstage.train.view.TrainPhaseView;
import cn.bnsr.edu_yun.frontstage.train.view.UserAppraisView;
import cn.bnsr.edu_yun.frontstage.train.view.UserStudyView;
import cn.bnsr.edu_yun.util.ConfigInfo;
import cn.bnsr.edu_yun.util.ExceptionUtil;
import cn.bnsr.edu_yun.util.ExportExcel;
import cn.bnsr.edu_yun.util.NumUtil;
import cn.bnsr.edu_yun.util.ReadExcel;
import cn.bnsr.edu_yun.util.ResponseUtil;
import cn.bnsr.edu_yun.util.UserLog;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 我的学习
 */
@Controller
@RequestMapping("/user_study")
public class UserStudyController {

	private final Logger log = LoggerFactory.getLogger(UserStudyController.class);

	@Autowired
	private UserStudyService userStudyService;
	@Autowired
	private UserStudyRecordService userStudyRecordService;
	@Autowired
	private TrainService trainService;
	@Autowired
	private CourseInfoService courseInfoService;
	@Autowired
	private ClassService classService;
	@Autowired
	private CourseService courseSerivce;
	@Autowired
	private UserAppraiseService userAppraiseService;
	@Autowired
	private CourseHourService courseHourService;
	@Autowired
	private CourseNoteService courseNoteService;
	@Autowired
	private TopicQuestionService topicQuestionService;
	@Autowired
	private UserService userService;
	@Autowired
	private UserAttentService userAttentService;
	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private ClassifyService classifyService;
	@Autowired
	private NotificationService notificationService;
	@Autowired
	private CourseNoteAgreeService courseNoteAgreeService;
	@Autowired
	private TeacherRelationService teacherRelationService;
	@Autowired
	private CourseService courseService;
	@Autowired
	private TopicAnswerService topicAnswerService;
	@Autowired
	private UserClassHourService userClassHourService;
	@Autowired
	private TrainCourseService trainCourseService;
	@Autowired
	private CertificateService certificateService;
	@Autowired
	private CourseExamStandardService courseExamStandardService;
	@Autowired
	private UserTrainClassService userTrainClassService;
	@Autowired
	private TrainPhaseService trainPhaseService;
	@Autowired
	private MessageService messageService;

	/**
	 * 
	 * 跳转班级学生管理页面
	 * 
	 * @author sunyu
	 * @param classView
	 * @return
	 */
	@RequestMapping("/to_class_student_manage")
	public ModelAndView toClassManage(ClassView classView, UserStudyView studyView, String upload) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("upload", upload);
		List<TeacherRelationView> teacherView = new ArrayList<>();
		try {
			String sign = classView.getSign();
			String flag = classView.getFlag();
			Long classId = classView.getId();
			String source_type = studyView.getSourceType();
			if (classId != null && source_type != null) {
				classView = classService.selectOne(classId, Integer.parseInt(source_type));
				if ("0".equals(source_type)) {// 班级来源于课程
					teacherView = teacherRelationService.queryTeacherRelation(classId, 1, 1);
				}
				if ("1".equals(source_type)) {// 班级来源于培训
					teacherView = teacherRelationService.queryTeacherRelation(classId, 2, 1);
				}
				classView.setSign(sign);
				classView.setFlag(flag);
				studyView.setSourceId(classId + "");
				Long source_id = classView.getSource_id();// 课程或培训
				studyView.setLearnId(source_id + "");
			}
			mv.addObject("teacherView", teacherView);
			mv.addObject("classView", classView);
			studyView.setRows(10);
			if (studyView.getPage() == 0) {
				studyView.setStartLine(0);
			} else {
				studyView.setStartLine(studyView.getPage() * studyView.getRows());
			}
			studyView.setUserId(null);
			studyView.setPaging("1");
			int total = userStudyService.countStudent(studyView);
			studyView.setTotal(total);
			studyView.setTotalPage(NumUtil.totalPage(total, studyView.getRows()));
			mv.addObject("userStudyView", studyView);
			List<UserStudyView> studentList = userStudyService.searchStudent(studyView);
			UserClassHour userClassHour = new UserClassHour();
			for (UserStudyView userStudy : studentList) {
				userClassHour.setCourse_id(Long.parseLong(userStudy.getLearnId()));
				userClassHour.setUser_id(Long.parseLong(userStudy.getUserId()));
				userClassHour.setClass_id(Long.parseLong(userStudy.getSourceId()));
				// 所有课时的数
				double allNum = userClassHourService.selectCountByCourseIdAndUserId(userClassHour);
				// 已学课时数
				double studyNum = userClassHourService.selectCountByCourseIdAndUserIdStudy(userClassHour);
				userStudy.setStudy_progress(0.0);
				if (allNum != 0) {
					userStudy.setStudy_progress(100 * studyNum / allNum);
				}
			}
			mv.addObject("studentList", studentList);
			String stu_name = studyView.getStudentName();
			mv.addObject("stu_name", stu_name);
			mv.setViewName("frontstage/train/class/class_student_manage");
			mv.addObject("head_title", "学员管理");
		} catch (Exception e) {
			e.printStackTrace();
			log.error("跳转班级管理页面失败", ExceptionUtil.getExceptionMessage(e));
		}
		return mv;
	}

	/**
	 * 
	 * 保存student
	 * 
	 * @author sunyu
	 * @param request
	 * @param userStudy
	 * @return
	 */
	@RequestMapping("/save_student")
	public ModelAndView saveStudent(HttpServletRequest request, UserStudy userStudy) {
		String id = request.getParameter("source_id");// 班级id
		String sourceType = request.getParameter("source_type");
		String sign = request.getParameter("sign");
		try {
			User user = userService.selectByPrimaryKey(userStudy.getUser_id());
			ClassView classView = classService.selectOne(Long.parseLong(id), null);
			if ("1".equals(sourceType)) {// 培训
				Long train_id = classView.getSource_id();
				Train train = trainService.getById(train_id);
				if (train.getType() == 1) {// 复杂培训
					StringBuilder builder = new StringBuilder("");
					List<TrainPhaseView> phases = trainPhaseService.queryTrainPhase(train_id, null);
					for (TrainPhaseView phase : phases) {
						List<CourseView> requiredCourses = trainCourseService.queryPhaseCourse(phase.getId(), 0);
						for (CourseView course : requiredCourses) {
							builder.append(phase.getId() + "-" + course.getId() + ",");
						}
					}
					String phaseId = builder.deleteCharAt(builder.length() - 1).toString();
					classView.setPhaseId(phaseId);
				}
			}
			userStudyService.joinStudy(classView, user);
		} catch (Exception e) {
			e.printStackTrace();
			log.error("保存学生失败", ExceptionUtil.getExceptionMessage(e));
		}
		return new ModelAndView("redirect:/user_study/to_class_student_manage.action?id=" + id + "&flag=1&sign=" + sign + "&sourceId=" + id + "&sourceType="
				+ sourceType);
	}

	/**
	 * 
	 * 验证student是否存在
	 * 
	 * @author sunyu
	 * @param userStudyView
	 * @return
	 */
	@RequestMapping("/verify_student")
	@ResponseBody
	public JSONObject verifyStudent(UserStudyView userStudyView) {
		JSONObject num = new JSONObject();
		num.put("num", userStudyService.countStudent(userStudyView));
		return num;
	}

	/**
	 * 
	 * 删除学生
	 * 
	 * @author sunyu
	 * @param request
	 * @return
	 */
	@RequestMapping("/delete_student")
	public ModelAndView deleteStudent(HttpServletRequest request) {
		String classId = request.getParameter("sourceId");
		String sourceType = request.getParameter("sourceType");
		String sign = request.getParameter("sign");
		String id = request.getParameter("id");
		try {
			userStudyService.deleteStudent(id);// 删除学生
		} catch (Exception e) {
			log.error("删除学生失败", ExceptionUtil.getExceptionMessage(e));
		}
		return new ModelAndView("redirect:/user_study/to_class_student_manage.action?id=" + classId + "&flag=1&sign=" + sign + "&sourceId=" + classId
				+ "&sourceType=" + sourceType);
	}

	
	/**
	 * 课程展示
	 */
	@RequestMapping("/to_course_study")
	public ModelAndView toCourseStudy(HttpServletRequest request, UserStudyView userStudyView) {
		ModelAndView modelAndView = new ModelAndView();
		String url = request.getHeader("Referer");
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("currentUser");
		Integer tab = userStudyView.getTab();
		Integer elite = userStudyView.getElite();
		String sort = userStudyView.getSort();
		String course_hour_id = userStudyView.getCourse_hour_id();
		String q_sort = userStudyView.getQ_sort();
		Integer viewType = userStudyView.getViewType();

		String learnId = userStudyView.getLearnId();// 课程id

		String sourceType = userStudyView.getSourceType();

		CourseView view = new CourseView();

		if ("0".equals(sourceType)) {
			view.setId(Long.parseLong(learnId));
		}

		ClassView classView = new ClassView();
		classView.setPaging("0");// 不分页
		classView.setStatus(5);
		classView.setState(0);
		classView.setSource_id(Long.parseLong(learnId));
		classView.setSource_type(Integer.parseInt(sourceType));
		if (userStudyView.getJumpType() != 0) {
			classView.setJumpId(userStudyView.getJumpId());
			classView.setJumpType(userStudyView.getJumpType());
		}
		List<ClassView> classList = classService.find(classView);
		modelAndView.addObject("classList", classList);

		// 问题
		if (q_sort == null) {
			q_sort = "question_time";
		}
		if (elite == null) {
			elite = 0;
		}
		long totalQuestion = topicQuestionService.selectCountByCourseId(view.getId(), 0, elite);
		modelAndView.addObject("totalQuestion", totalQuestion);
		modelAndView.addObject("elite", elite);
		modelAndView.addObject("q_sort", q_sort);
		if (q_sort.equals("question_time")) {
			modelAndView.addObject("q_sort_name", "最新发帖");
		} else {
			modelAndView.addObject("q_sort_name", "最后回复");
		}

		// 评价
		if (user != null) {
			UserAppraise user_appraise = userAppraiseService.selectByCourseIdAndUserId(user.getId(), view.getId(), 0);
			modelAndView.addObject("user_appraise", user_appraise);
		}
		long totalAppraise = userAppraiseService.selectCountBySourceId(view.getId(), 0);
		Integer totalScore = userAppraiseService.selectTotalScore(view.getId(), 0);
		modelAndView.addObject("totalAppraise", totalAppraise);
		if (totalAppraise != 0 && totalScore != null) {
			modelAndView.addObject("average", totalScore / totalAppraise);
		} else {
			modelAndView.addObject("average", -1);
		}

		// 笔记
		if (sort == null) {
			sort = "note_time";
		}
		if (course_hour_id == "" || course_hour_id == null) {
			course_hour_id = null;
		} else {
			modelAndView.addObject("course_hour", courseHourService.getHour(course_hour_id));
		}
		long totalNote = courseNoteService.selectCountByCourseId(view.getId(), course_hour_id);
		modelAndView.addObject("totalNote", totalNote);
		modelAndView.addObject("course_hour_id", course_hour_id);
		modelAndView.addObject("sort", sort);
		if (sort.equals("note_time")) {
			modelAndView.addObject("sort_name", "最新笔记");
		} else {
			modelAndView.addObject("sort_name", "点赞最多");
		}

		CourseView courseView = courseSerivce.queryCourseInfo(view);
		Course course = courseSerivce.getById(view.getId());
		if (course.getClassify_id() != null) {
			long classify_id = course.getClassify_id();
			ClassifyView classifyView = classifyService.getClassifyViewById((int) classify_id);
			modelAndView.addObject("classifyView", classifyView);
		}
		modelAndView.addObject("courseView", courseView);

		Long classId = null;// 班级id
		UserClassHour userClassHour = new UserClassHour();
		// 用户学习list
		List<UserStudy> userStudyList = new ArrayList<UserStudy>();
		/**
		 * 用户是否购买
		 */
		String userStudyStatus = "-1";// 用户学习状态，默认没有报名
		boolean isFlag = false;//
		boolean isPay = false;// 是否购买
		boolean isJoin = false;// 是否报名
		boolean is_teacher = false;// 是否是创课人
		if (user != null) {// 已登陆
			is_teacher = user.getId() == course.getUser_id();
			modelAndView.addObject("is_teacher", is_teacher);
			userStudyView.setUserId(user.getId().toString());
			if (userStudyView.getIs_direct().equals("1")) {// 培训课程
				userStudyList = userTrainClassService.searchCourseClassId(userStudyView);
				if (userStudyList.size() > 0) {// 购买
					classId = Long.parseLong(userStudyList.get(0).getSource_id() + "");
					isPay = true;
				} else {// 未购买培训课程
					isFlag = true;
				}
			} else {// 普通课程
					// 查询是否购买 多个班级，默认第一个
				userStudyList = userStudyService.searchIsPay(userStudyView);
				UserStudy userStudyIsPay = new UserStudy();
				if (userStudyList.size() > 0) {
					userStudyIsPay = userStudyList.get(0);
				} else {
					userStudyIsPay = null;
				}
				if (userStudyIsPay == null) {// 未报名，未购买
					isFlag = true;
				} else if (userStudyIsPay.getStatus() == 0) {// 正常
					// 根据课程id、来源类型、学员id，查询已购买班级id
					List<UserStudy> usList = userStudyService.searchUserStudy(userStudyView);
					// 默认第一个班级
					UserStudy userStudy = usList.get(0);
					userStudyView.setId(userStudy.getId().toString());
					classId = userStudy.getSource_id();
					isPay = true;
				} else if (userStudyIsPay.getStatus() == 1) {// 删除
					isFlag = true;
				} else if (userStudyIsPay.getStatus() == 2) {// 退学
					isFlag = true;
				} else if (userStudyIsPay.getStatus() == 3) {// 报名
					userStudyStatus = "3";
					classId = userStudyIsPay.getSource_id();
					isJoin = true;
				}
				// 处于报名或正常状态时 更新最后浏览时间
				if (userStudyIsPay != null && (userStudyIsPay.getStatus() == 0 || userStudyIsPay.getStatus() == 3)) {
					userStudyIsPay.setLast_browse_time(new Date());
					userStudyService.updateUserStudy(userStudyIsPay);
				}
			}
		} else {// 未登陆
			isFlag = true;
		}
		if (isFlag) {
			if (classList.size() > 0) {// 有班级
				classId = classList.get(0).getId();// 默认第一个班级
			}
		}
		// 查询该课程所有课时list
		List<CourseHourView> hourList = new ArrayList<CourseHourView>();
		UserStudy userStudy = null;
		if (userStudyView.getId() != null) {
			userStudy = userStudyService.getById(Long.parseLong(userStudyView.getId()));
		}
		if (userStudy != null) {
			classId = userStudy.getSource_id();// 培训有userstudy id
												// 这个参数，现在加入，可以直接通过
		}
		CourseHourView courseHourView = new CourseHourView();
		if (user != null) {
			courseHourView.setUser_id(user.getId());
		}
		if (isPay) {
			courseHourView.setClass_id(classId);
		} else {
			courseHourView.setClass_id(null);
		}
		courseHourView.setSource_type(sourceType);
		courseHourView.setCourse_id(Long.parseLong(learnId));
		int courseHourTotal = 0;
		hourList = courseHourService.queryHourListUser(courseHourView);
		if (hourList != null) {
			courseHourTotal = hourList.size();
		}
		if (isPay) {
			userStudyStatus = "0";// 购买
			CourseHour nextCourseHour = null;
			userClassHour.setCourse_id(view.getId());
			userClassHour.setUser_id(user.getId());
			if (userStudyView.getSourceId() != null)
				userClassHour.setClass_id(Long.parseLong(userStudyView.getSourceId()));
			else {
				userClassHour.setClass_id(classId);
			}

			if (hourList.size() > 0) {// 一个课时不用查询,li修改解决一个课时学习报错

				UserClassHour uch = userClassHourService.selectByNextStudy(userClassHour);
				if (uch != null) {
					String hour_id = uch.getCourse_hour_id() + "";
					nextCourseHour = courseHourService.getHour(hour_id);
					modelAndView.addObject("nextCourseHour", nextCourseHour);
				}
			}
			// 所有课时的数
			int allNum = userClassHourService.selectCountByCourseIdAndUserId(userClassHour);
			modelAndView.addObject("allNum", allNum);
			// 已学课时数
			int studyNum = userClassHourService.selectCountByCourseIdAndUserIdStudy(userClassHour);
			modelAndView.addObject("studyNum", studyNum);
			if (tab == -1) {
				tab = 1;
			}
		} else {
			if (tab == -1) {
				tab = 6;// 未购买先展示概览
			}
			if (isJoin) { // 课程(培训中的课程)报名用户
				modelAndView.addObject("allNum", courseHourTotal);
				modelAndView.addObject("studyNum", 0);
			}
		}

		if (userStudyView.getSourceId() == null) {// 第一次查询默认
			userStudyView.setSourceId(classId + "");// 班级id
		}

		int pageSize = 10;
		int page = view.getPage() + 1;
		int start = pageSize * (page - 1);

		// 班级教职人员
		if (classId != null) {
			TeacherRelationView teacherRelationView = new TeacherRelationView();
			long us_source_id = Long.parseLong(userStudyView.getSourceId());
			teacherRelationView.setSource_id(us_source_id);
			int us_source_type = Integer.parseInt(userStudyView.getSourceType());
			if (us_source_type == 0) {
				teacherRelationView.setSource_type(1);
			} else if (us_source_type == 1) {
				teacherRelationView.setSource_type(2);
			}
			List<TeacherRelationView> classTeacherList = teacherRelationService.queryTeacherOfClass(teacherRelationView);
			modelAndView.addObject("classTeacherList", classTeacherList);

			// 最新班级公告
			MessageView messageView = new MessageView();
			messageView.setRows(5);
			messageView.setStartLine(0);
			if (classView.getSource_type() == 0) {
				messageView.setSource_type(2);
			} else if (classView.getSource_type() == 1) {
				messageView.setSource_type(3);
			}
			messageView.setSource_id(classId);
			List<MessageView> messageList = messageService.queryClassNotices(messageView);
			modelAndView.addObject("messageList", messageList);
		}

		if (tab == 1) {// 课时章节
			// 查询该课程所有章节list
			List<CourseHour> chapterList = courseHourService.queryHourList(view.getId(), true);
			modelAndView.addObject("chapterList", chapterList);
			modelAndView.addObject("hourList", hourList);
		} else if (tab == 2) {// 讨论问题
			if (!is_teacher || (userStudyView.getViewType() != 1 && userStudyView.getViewType() != 2)) {
				modelAndView.addObject("class_id", classId);
				List<TopicQuestion> question = topicQuestionService.selectByCourseId(view.getId(), 0, elite, q_sort, start, pageSize);
				modelAndView.addObject("question", question);
			}
		} else if (tab == 3) {// 资料
		} else if (tab == 4) {// 评价

			if (!is_teacher || (userStudyView.getViewType() != 1 && userStudyView.getViewType() != 2)) {
				List<UserAppraisView> appraise = userAppraiseService.selectBySourceId(view.getId(), start, pageSize, 0);
				modelAndView.addObject("appraise", appraise);
				// 评价项
				AppraiseReasonView appraiseReasonView = new AppraiseReasonView();
				appraiseReasonView.setType(0);
				appraiseReasonView.setLevel(5);
				appraiseReasonView.setSource_id(Long.parseLong(learnId));
				List<AppraiseReasonView> appraiseReasonViews = userAppraiseService.selectByType(appraiseReasonView);
				modelAndView.addObject("appraiseReasonViews", appraiseReasonViews);
			}

		} else if (tab == 5) {// 笔记
			modelAndView.addObject("hourList", hourList);
			if (!is_teacher || (userStudyView.getViewType() != 1 && userStudyView.getViewType() != 2)) {
				modelAndView.addObject("note", courseNoteService.selectByCourseId(view.getId(), course_hour_id, sort, start, pageSize));
			}
		} else if (tab == 6) {// 概览
			CertificatesView certificatesView = new CertificatesView();
			certificatesView.setSource_id(view.getId().toString());
			certificatesView.setSource_type("1");
			List<CertificatesView> certificatesViews = certificateService.findAll(certificatesView);
			modelAndView.addObject("certificatesViews", certificatesViews);// 证书情况

			CourseExamStandardView examStandardView = new CourseExamStandardView();
			examStandardView.setCourse_id(view.getId().toString());
			examStandardView.setSource_type("0");
			modelAndView.addObject("jobStandard", courseExamStandardService.queryStandard(examStandardView));
			examStandardView.setSource_type("1");
			modelAndView.addObject("discussionStandard", courseExamStandardService.queryStandard(examStandardView));
			examStandardView.setSource_type("2");
			modelAndView.addObject("examStandard", courseExamStandardService.queryStandard(examStandardView));

		} else if (tab == 7) {// 讨论回答
			if (!is_teacher || (userStudyView.getViewType() != 1 && userStudyView.getViewType() != 2)) {
				List<TopicAnswer> topicAnswers = topicAnswerService.selectAnswerByQuestionId(userStudyView.getQuestionId(), start, pageSize);
				TopicAnswerView topicAnswerView = new TopicAnswerView();
				topicAnswerView.setQuestionId(userStudyView.getQuestionId());
				long topicAnswersCount = topicAnswerService.count(topicAnswerView);
				TopicQuestion topicQuestion = topicQuestionService.selectById(userStudyView.getQuestionId());
				topicQuestion.setWatch_times(topicQuestion.getWatch_times() + 1);
				topicQuestionService.update(topicQuestion);

				// 是不是本人
				if (user != null) {
					boolean is_self = topicQuestion.getUser_id() == user.getId();
					modelAndView.addObject("is_self", is_self);// 是不是本人
				}

				modelAndView.addObject("topicAnswers", topicAnswers);// 问题回答list
				modelAndView.addObject("topicAnswersCount", topicAnswersCount);// 问题回答总数
				modelAndView.addObject("topicQuestion", topicQuestion);// 问题
			}
		} else if (tab == 8) {
			if (!is_teacher || (userStudyView.getViewType() != 1 && userStudyView.getViewType() != 2)) {
				CourseRankView courseRankView = new CourseRankView();
				courseRankView.setCourse_id(view.getId());
				if (classId != null) {
					courseRankView.setClassId(classId);
				} else {
					courseRankView.setClassId(-1L);
				}

				List<CourseRankView> courseRankViews = userClassHourService.paceRank(courseRankView);
				modelAndView.addObject("courseRankViews", courseRankViews);
				List<CourseRankView> courseRankViews1 = userClassHourService.durationRank(courseRankView);
				modelAndView.addObject("courseRankViews1", courseRankViews1);
				for (CourseRankView c : courseRankViews) {
					if (user != null && user.getId() == c.getUser_id()) {
						modelAndView.addObject("myCourseRankView", c);
						break;
					}
				}
				for (CourseRankView c : courseRankViews1) {
					if (user != null && user.getId() == c.getUser_id()) {
						modelAndView.addObject("myCourseRankView1", c);
						break;
					}
				}
			}
		}

		CourseView courseInfo = courseInfoService.queryCourseDetail(view.getId());
		modelAndView.addObject("courseInfo", courseInfo);

		modelAndView.addObject("tab", tab);
		modelAndView.addObject("page", page);

		User t_user = userService.selectByPrimaryKey(course.getUser_id());
		UserProperty userProperty = userService.selectUserPropertyById(t_user.getProperty_id());
		t_user.setUser_property(userProperty);
		modelAndView.addObject("t_user", t_user);
		String profile = userInfoService.getByUserId(course.getUser_id()).getProfile();
		modelAndView.addObject("profile", profile);
		if (user != null) {
			User_attent userAttent = userAttentService.selectattent(user.getId(), course.getUser_id());
			modelAndView.addObject("userAttent", userAttent != null);
		}
		modelAndView.addObject("userStudyView", userStudyView);

		if (viewType == 1) {// 已购买用户浏览或报名用户
			userStudyStatus = "0";// 购买
			modelAndView.addObject("allNum", courseHourTotal);
			modelAndView.addObject("studyNum", 0);
		} else if (viewType == 2) {// 未购买用户浏览
			userStudyStatus = "-1";// 购买
		}// 普通浏览不处理
		modelAndView.addObject("userStudyStatus", userStudyStatus);
		modelAndView.addObject("head_title", courseView.getTitle());
		modelAndView.setViewName("frontstage/train/course_show/course_study");

		return modelAndView;
	}

	/**
	 * 
	 * 用户自主加入课程班级
	 */
	@UserLog(description = "加入学习")
	@RequestMapping("/join_study")
	public void joinStudy(long classId, HttpServletResponse response, HttpServletRequest request) {
		JSONObject result = new JSONObject();
		try {
			User user = (User) request.getSession().getAttribute("currentUser");
			ClassView classView = classService.selectOne(classId, null);
			Integer classType = classView.getSource_type();
			Long sourceId = classView.getSource_id();
			// 加入学习
			boolean isJoin = userStudyService.joinStudy(classView, user);

			result.put("msg", isJoin);
			result.put("sourceId", sourceId);
			result.put("sourceType", classType);
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			e.printStackTrace();
			log.error("加入学习失败", ExceptionUtil.getExceptionMessage(e));
		}

	}

	/**
	 * 加入选修课程
	 */
	@RequestMapping("/join_option_course")
	public void joinOptionCourse(Long courseId, Long trainId, String phaseId, Long userStudyId, HttpServletResponse response, HttpServletRequest request) {
		JSONObject result = new JSONObject();
		try {
			User user = (User) request.getSession().getAttribute("currentUser");
			userStudyService.joinOptionCourse(courseId, user.getId(), trainId, phaseId, userStudyId);
			result.put("msg", true);
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			e.printStackTrace();
			log.error("加入学习失败", ExceptionUtil.getExceptionMessage(e));
		}
	}

	/**
	 * fangxiongwei 2017年3月2日 我的课程、培训 source_type 0-课程；1-培训
	 */
	@RequestMapping("/to_user_study")
	public ModelAndView toUserStudy(HttpServletRequest request, StudyView studyView) {
		User user = (User) request.getSession().getAttribute("currentUser");
		ModelAndView modelAndView = new ModelAndView();
		String state = request.getParameter("state");
		String stamp = request.getParameter("stamp");
		try {
			studyView.setPaping("1");
			studyView.setRows(9);
			if (studyView.getPage() == 0) {
				studyView.setStartLine(0);
			} else {
				studyView.setStartLine(studyView.getPage() * studyView.getRows());
			}
			studyView.setUser_id(user.getId());
			studyView.setSource_type(studyView.getSource_type());
			Integer total = userStudyService.countUserSutdy(studyView);
			studyView.setTotal(total);
			studyView.setTotalPage(NumUtil.totalPage(total, 9));
			List<StudyView> userStudyList = userStudyService.queryUserStudy(studyView);
			modelAndView.addObject("userStudyList", userStudyList);
			modelAndView.addObject("studyView", studyView);

			UserInfo userInfo = userInfoService.getByUserId(user.getId());
			request.setAttribute("user", user);
			request.setAttribute("userInfo", userInfo);
			// 个人中心统计数据
			UserCenterView userCenter = userService.queryUserCenter(user.getId());
			modelAndView.addObject("userCenter", userCenter);

			request.setAttribute("state", state);
			request.setAttribute("stamp", stamp);
			if (studyView.getSource_type() == 0) {
				modelAndView.addObject("head_title", "我的课程");
			} else {
				modelAndView.addObject("head_title", "我的培训");
			}
			modelAndView.setViewName("frontstage/train/personalCenter/user_study");
		} catch (Exception e) {
			e.printStackTrace();
			log.error("跳转我的培训失败", ExceptionUtil.getExceptionMessage(e));
		}
		return modelAndView;
	}

	@RequestMapping("/ajax_more")
	public void getMore(int page, int type, int elite, String q_sort, long id, Integer page_size, HttpServletResponse response, HttpServletRequest request)
			throws Exception {
		JSONObject result = new JSONObject();
		int pageSize = 10;
		if (page_size != null) {
			pageSize = page_size;
		}
		int start = pageSize * (page - 1);

		List<TopicQuestion> question = topicQuestionService.selectByCourseId(id, type, elite, q_sort, start, pageSize);
		long totalQuestion = topicQuestionService.selectCountByCourseId(id, type, elite);
		boolean flag = totalQuestion > pageSize * page;
		result.put("question", question);
		result.put("flag", flag);
		ResponseUtil.write(response, result);
	}

	@RequestMapping("/ajax_appraise")
	public void getMoreAppraise(int page, long id, int type, HttpServletResponse response, HttpServletRequest request) throws Exception {
		JSONObject result = new JSONObject();
		int pageSize = 10;
		int start = pageSize * (page - 1);
		long totalAppraise = userAppraiseService.selectCountBySourceId(id, type);
		List<UserAppraisView> appraise = userAppraiseService.selectBySourceId(id, start, pageSize, type);
		boolean flag = totalAppraise > pageSize * page;
		result.put("appraise", appraise);
		result.put("flag", flag);
		ResponseUtil.write(response, result);
	}

	@RequestMapping("/ajax_note")
	public void getMoreNote(int page, long id, HttpServletResponse response, String course_hour_id, String sort, HttpServletRequest request) throws Exception {
		JSONObject result = new JSONObject();
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("currentUser");
		int pageSize = 10;
		int start = pageSize * (page - 1);
		if (sort == null) {
			sort = "note_time";
		}
		if (course_hour_id == "" || course_hour_id == null) {
			course_hour_id = null;
		}
		long totalNote = courseNoteService.selectCountByCourseId(id, course_hour_id);
		List<CourseNote> note = courseNoteService.selectByCourseId(id, course_hour_id, sort, start, pageSize);
		boolean flag = totalNote > pageSize * page;
		List<Boolean> s = new ArrayList<Boolean>();
		for (CourseNote n : note) {
			int status = courseNoteAgreeService.selectByUserIdAndNoteId(user.getId(), n.getId()).size();
			s.add(status == 0);
		}

		result.put("status", s);
		result.put("note", note);
		result.put("flag", flag);
		ResponseUtil.write(response, result);
	}

	@RequestMapping("/ajax_user")
	public void getUser(HttpServletResponse response, HttpServletRequest request, long id) throws Exception {

		User user = userService.selectByPrimaryKey(id);
		StudyCenterView studyCenterView = new StudyCenterView();
		studyCenterView.setUser_id(id);
		int learnNum = userStudyService.countMyClass(studyCenterView);
		HttpSession session = request.getSession();
		User currentUser = (User) session.getAttribute("currentUser");
		String path = request.getContextPath();
		StringBuffer str = new StringBuffer();
		str.append("<div id=\"user-card-" + user.getId() + "\" class=\"js-card-content\">");
		str.append("<div class=\"card-header media-middle\">");
		str.append("<div class=\"media\">");
		str.append("<div class=\"media-left\">");
		str.append("<div class=\"user-avatar\">");
		str.append("<a class=\" \" href=\"" + path + "/teacher_center/to_teacher_center.action?user_id=" + user.getId() + "\" >");
		str.append("<img class=\"avatar-md\" src=\"" + path + "/" + user.getIcon() + "\">");
		str.append("</a>");
		str.append("<span class=\"icon-user-status\">");
		str.append("<i class=\"es-icon es-icon-school\"></i>");
		str.append("</span>");
		str.append("</div>");
		str.append("</div>");
		str.append("<div class=\"media-body\">");
		str.append("<div class=\"title\">");
		str.append("<a class=\"link-dark \" href=\"" + path + "/teacher_center/to_teacher_center.action?user_id=" + user.getId() + "\" >" + user.getUsername()
				+ "</a>");
		str.append("</div>");
		str.append("<div class=\"content\"> " + user.getRealname() + "</div>");
		str.append("</div>");
		str.append("</div>");
		str.append("<div class=\"metas\">");
		if (currentUser != null && currentUser.getId() != id) {
			User_attent userAttent = userAttentService.selectattent(currentUser.getId(), id);
			if (userAttent == null) {
				str.append("<a class=\"btn btn-primary btn-xs follow-btn\" href=\"javascript:void(0);\" onclick=\"send_attent(" + id + ")\" >关注</a>");
			} else {
				str.append("<a class=\"btn btn-default btn-xs unfollow-btn\" href=\"javascript:void(0);\" onclick=\"send_attent(" + id + ")\">已关注</a>");

			}

			str.append("<a class=\"btn btn-default btn-xs direct-message-btn\" href=\"#private-modal\" data-toggle=\"modal\"   onclick=\"send_private_messages("
					+ id + ",\'" + user.getUsername() + "\')\">私信</a>");
		}
		str.append("</div>");
		str.append("</div>");
		UserInfo userInfo = userInfoService.getByUserId(id);
		if (userInfo != null && userInfo.getProfile() != null) {
			str.append("<div class=\"card-body\">" + userInfo.getProfile() + "</div>");
		} else {
			str.append("<div class=\"card-body\"></div>");
		}
		str.append("<div class=\"card-footer clearfix\">");
		str.append("<span>");
		str.append("<a class=\"link-light\" href=\"javascript:void(0);\">" + learnNum + "<br>在学</a>");
		str.append("</span>");
		str.append("<span>");
		str.append("<a class=\"link-light\" href=\"javascript:void(0);\">");
		UserProperty userProperty = userService.selectProperty(user.getProperty_id());
		int attent = 0;
		if (userProperty != null)
			attent = userProperty.getAttent_count();
		str.append("" + attent + "<br>关注</a>");
		str.append("</span>");
		str.append("<span>");
		str.append("<a class=\"link-light\" href=\"javascript:void(0);\">");
		int is_attent = 0;
		if (userProperty != null)
			is_attent = userProperty.getIs_attented_count();
		str.append("" + is_attent + "<br>粉丝");
		str.append("</a>");
		str.append("</span>");
		str.append("</div>");
		str.append("</div>");
		String s = new String(str);
		ResponseUtil.write(response, s);
	}

	@RequestMapping("/upload_excel")
	public void uploadExcel(HttpServletRequest request, HttpServletResponse response) {
		String filepath = null;
		String filename = null;
		try {
			// 上传部分，IO操作
			// 创建一个通用的多部分解析器
			CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());
			// 判断 request 是否有文件上传,即多部分请求
			if (multipartResolver.isMultipart(request)) {
				// 转换成多部分request
				MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
				// 取得request中的所有文件名
				Iterator<String> iter = multiRequest.getFileNames();

				while (iter.hasNext()) {
					// 取得上传文件
					MultipartFile excel = multiRequest.getFile(iter.next());
					// 上传
					InputStream in = excel.getInputStream();// 获取输入流
					// 上传的路径
					String path = request.getSession().getServletContext().getRealPath("/uploadExcel");
					// 获取文件--创建一个新文件，添加路径和名称
					File f = new File(path, excel.getOriginalFilename());
					// 文件的输出流
					OutputStream os = new FileOutputStream(f);
					// 每次上传的大小
					byte[] buf = new byte[1024];
					int len = 0;
					// 上传
					while ((len = in.read(buf)) > 0) {
						os.write(buf, 0, len);
					}
					os.flush();
					os.close();
					in.close();
					filepath = f.getPath();
					filename = f.getName();
				}
			}
			JSONObject result = new JSONObject();
			result.put("filepath", filepath);
			result.put("filename", filename);
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			log.error("导入EXCEL失败", ExceptionUtil.getExceptionMessage(e));
		}

	}

	@RequestMapping("/verify_data")
	public void verifyData(HttpServletRequest request, HttpServletResponse response) {
		JSONObject result = new JSONObject();
		String classId = request.getParameter("sourceId");
		String type = request.getParameter("sourceType");
		String learnId = request.getParameter("learnId");// 课程或培训id
		String filename = request.getParameter("filename");
		String path = request.getSession().getServletContext().getRealPath(ConfigInfo.getString("userStudyExcel"));
		UserStudyView student = new UserStudyView();
		try {
			List<List<Object>> list = ReadExcel.readExcel(new File(path + "/" + filename), 0, 1, 1000, 2);
			StringBuilder nothing = new StringBuilder("");// 查询数据不存在的行数
			StringBuilder existing = new StringBuilder("");// 查询数据已存在的行数
			Set<String> userIds = new HashSet<>();
			if (list == null || list.size() == 0) {
				result.put("msg", "格式错误");
				ResponseUtil.write(response, result);
				return;
			}
			for (int i = 1; i < list.size(); i++) {
				List<Object> lis = list.get(i);
				for (Object li : lis) {
					TeacherRelationView teacher = userService.searchUser(li.toString(), "all");
					if (teacher == null) {
						// 查无此人
						nothing.append((i + 2) + ",");
						break;
					} else {
						// 验证该用户是否已在班级
						student.setUserId(teacher.getId() + "");
						;
						student.setSourceId(classId);
						student.setSourceType(type);
						student.setLearnId(learnId);
						int exist = userStudyService.countStudent(student);
						if (exist == 0) {
							userIds.add(teacher.getId() + "");
							break;
						} else {
							existing.append((i + 2) + ",");
							break;
						}
					}
				}
			}
			if (nothing.length() > 0) {
				result.put("nothing", nothing.substring(0, nothing.lastIndexOf(",")));
			}
			if (existing.length() > 0) {
				result.put("existing", existing.substring(0, existing.lastIndexOf(",")));
			}
			if (nothing.length() == 0 && existing.length() == 0) {
				StringBuilder user_ids = new StringBuilder("");
				Iterator<String> it = userIds.iterator();
				while (it.hasNext()) {
					user_ids.append(it.next() + ",");
				}
				result.put("userIds", user_ids.substring(0, user_ids.lastIndexOf(",")));
			}
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			log.error("验证学员数据失败", ExceptionUtil.getExceptionMessage(e));
		}
	}

	@RequestMapping("/batch_save_student")
	public ModelAndView batchSaveStudent(HttpServletRequest request, ClassView classView) {
		String userIds = request.getParameter("userIds");
		String sign = request.getParameter("sign");
		Long class_id = classView.getId();
		Long source_id = classView.getSource_id();// 课程或培训id
		Integer source_type = classView.getSource_type();
		try {
			classView = classService.selectOne(class_id, null);
			if (source_type == 1) {// 培训
				Train train = trainService.getById(source_id);
				if (train.getType() == 1) {// 复杂培训
					StringBuilder builder = new StringBuilder("");
					List<TrainPhaseView> phases = trainPhaseService.queryTrainPhase(source_id, null);
					for (TrainPhaseView phase : phases) {
						List<CourseView> requiredCourses = trainCourseService.queryPhaseCourse(phase.getId(), 0);
						for (CourseView course : requiredCourses) {
							builder.append(phase.getId() + "-" + course.getId() + ",");
						}
					}
					String phaseId = builder.deleteCharAt(builder.length() - 1).toString();
					classView.setPhaseId(phaseId);
				}
			}
			for (String user_id : userIds.split(",")) {
				User user = userService.selectByPrimaryKey(Long.parseLong(user_id));
				userStudyService.joinStudy(classView, user);
			}
		} catch (Exception e) {
			log.error("批量保存学员失败", ExceptionUtil.getExceptionMessage(e));
		}
		return new ModelAndView("redirect:/user_study/to_class_student_manage.action?id=" + class_id + "&flag=1&sign=" + sign + "&sourceId=" + source_id
				+ "&sourceType=" + source_type);
	}

	@RequestMapping("/export_student")
	public ModelAndView exportStudent(HttpServletRequest request, HttpServletResponse response, UserStudyView userStudyView) {
		String classId = userStudyView.getSourceId();
		String sourceType = userStudyView.getSourceType();
		ClassView classView = classService.selectOne(Long.parseLong(classId), Integer.parseInt(sourceType));
		List<UserStudyView> studentList = userStudyService.searchStudent(userStudyView);
		UserClassHour userClassHour = new UserClassHour();
		for (UserStudyView userStudy : studentList) {
			userClassHour.setCourse_id(Long.parseLong(userStudy.getLearnId()));
			userClassHour.setUser_id(Long.parseLong(userStudy.getUserId()));
			userClassHour.setClass_id(Long.parseLong(userStudy.getSourceId()));
			// 所有课时的数
			double allNum = userClassHourService.selectCountByCourseIdAndUserId(userClassHour);
			// 已学课时数
			double studyNum = userClassHourService.selectCountByCourseIdAndUserIdStudy(userClassHour);
			userStudy.setStudy_progress(0.0);
			if (allNum != 0) {
				userStudy.setStudy_progress(100 * studyNum / allNum);
			}
		}
		String[] head = { "学员姓名", "加入时间", "有效期至", "剩余时间", "真实姓名", "学习进度", "备注" };
		String[] fieldNames = { "studentName", "addTime", "validityTime", "overTime", "realName", "study_progress", "remarks" };
		// SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
		String fileName = classView.getClasses() + "班学员.xls";
		response.setContentType("application/msexcel");
		try {
			response.setHeader("Content-Disposition", getFileName(fileName, getExplorer(request)));
			OutputStream out = response.getOutputStream();
			ExportExcel<UserStudyView> excel = new ExportExcel<UserStudyView>();
			excel.exportExcel("全体学员", head, fieldNames, studentList, out);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	// 需要判断是什么浏览器
	private String getExplorer(HttpServletRequest request) {
		String agent = request.getHeader("USER-AGENT");
		if (agent != null) {
			// ie
			if (agent.indexOf("MSIE") >= 0) {
				return "IE";
			}
			// firefox
			else if (agent.indexOf("Firefox") >= 0) {
				return "Firefox";
			}
			// Chrome
			else if (agent.indexOf("Chrome") >= 0) {
				return "Chrome";
			}
			// Opera
			else if (agent.indexOf("Opera") >= 0) {
				return "Opera";
			}
			// Safari
			else if (agent.indexOf("Safari") >= 0) {
				return "Safari";
			}
		}
		return "";
	}

	private String getFileName(String FileName, String explorer) throws UnsupportedEncodingException {

		String name = "attachment;filename=" + FileName;
		String filename = new String(URLEncoder.encode(FileName, "UTF8"));
		if (explorer.equals("IE")) {
			name = "attachment;filename=" + filename;
		} else if (explorer.equals("Firefox")) {
			name = "attachment;filename*=UTF-8'" + filename;
		} else if (explorer.equals("Chrome")) {
			name = "attachment;filename=" + new String(filename.getBytes("UTF-8"), "ISO8859-1");
		} else if (explorer.equals("Opera")) {
			name = "attachment;filename*=UTF-8'" + filename;
		} else if (explorer.equals("Safari")) {
			name = "attachment;filename=" + new String(filename.getBytes("UTF-8"), "ISO8859-1");
		}

		return name;

	}

	/**
	 * 退学
	 */
	@UserLog(description = "退出学习")
	@RequestMapping("/out_study")
	public void outStudy(long id, String reson, HttpServletResponse response, HttpServletRequest request) throws Exception {
		JSONObject result = new JSONObject();
		User user = (User) request.getSession().getAttribute("currentUser");

		UserStudy userStudy = userStudyService.getById(id);
		userStudy.setStatus(2);
		userStudy.setReason(reson);
		userStudyService.updateUserStudy(userStudy);
		userClassHourService.deleteClassHour(userStudy.getUser_id(), userStudy.getSource_id());
		// 优化 记录，通知
		// 学习记录
		UserStudyRecord record = new UserStudyRecord();
		record.setUser_id(user.getId());
		record.setLearn_id(userStudy.getLearn_id());// 课程或者培训id
		record.setSource_type(userStudy.getSource_type());
		record.setSource_id(userStudy.getSource_id());// 班级id
		record.setCreate_time(new Date());
		if (userStudy.getSource_type() == 0) {
			record.setMsg("退出课程");
			Course course = courseService.getById(userStudy.getLearn_id());
			if (course != null) {
				record.setSource_name(course.getTitle());
				record.setType(course.getType());
			}
		} else if (userStudy.getSource_type() == 1) {
			record.setMsg("退出培训");
			Train train = trainService.getById(userStudy.getLearn_id());
			if (train != null) {
				record.setSource_name(train.getName());
				record.setType(train.getType());
			}
		}
		userStudyRecordService.saveUserStudyRecord(record);
		// 通知
		Notification notification = new Notification();
		notification.setIs_read(1);
		notification.setCreate_time(new Date());
		notification.setSource_id(userStudy.getLearn_id());
		notification.setSource_type(userStudy.getSource_type());
		notification.setUser_id(user.getId());
		notification.setNotice_type_id(16);
		notificationService.insert(notification);

		result.put("msg", true);

		ResponseUtil.write(response, result);
	}

	/**
	 * 退学
	 */
	@UserLog(description = "跟新备注")
	@RequestMapping("/update_remarks")
	public ModelAndView updateRemarks(HttpServletRequest request, UserStudy userStudy) throws Exception {
		String id = request.getParameter("source_id");// 班级id
		String sourceType = request.getParameter("source_type");
		String sign = request.getParameter("sign");
		userStudyService.updateUserStudy(userStudy);
		return new ModelAndView("redirect:/user_study/to_class_student_manage.action?id=" + id + "&flag=1&sign=" + sign + "&sourceId=" + id + "&sourceType="
				+ sourceType);
	}

	@RequestMapping("/select_user")
	@ResponseBody
	public JSONArray selectUser(UserStudy userstudy) {
		UserDetailView user = userStudyService.selectUserDetail(userstudy);
		if (user != null) {
			return JSONArray.fromObject(user);
		} else {
			return JSONArray.fromObject(0);
		}
	}
}
