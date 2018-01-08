package cn.bnsr.edu_yun.frontstage.train.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.frontstage.base.po.Classify;
import cn.bnsr.edu_yun.frontstage.base.po.Label;
import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.base.po.UserInfo;
import cn.bnsr.edu_yun.frontstage.base.service.ClassifyService;
import cn.bnsr.edu_yun.frontstage.base.service.LabelService;
import cn.bnsr.edu_yun.frontstage.base.service.NotificationService;
import cn.bnsr.edu_yun.frontstage.base.service.UserAttentService;
import cn.bnsr.edu_yun.frontstage.base.service.UserInfoService;
import cn.bnsr.edu_yun.frontstage.base.service.UserService;
import cn.bnsr.edu_yun.frontstage.base.view.ClassifyView;
import cn.bnsr.edu_yun.frontstage.base.view.NoteView;
import cn.bnsr.edu_yun.frontstage.base.view.NotificationView;
import cn.bnsr.edu_yun.frontstage.base.view.UserCenterView;
import cn.bnsr.edu_yun.frontstage.tiku.po.Exam;
import cn.bnsr.edu_yun.frontstage.tiku.po.TestPaper;
import cn.bnsr.edu_yun.frontstage.tiku.service.ExamService;
import cn.bnsr.edu_yun.frontstage.tiku.service.TestPaperService;
import cn.bnsr.edu_yun.frontstage.tiku.service.TestQuestionsService;
import cn.bnsr.edu_yun.frontstage.tiku.view.ExamView;
import cn.bnsr.edu_yun.frontstage.tiku.view.TestPaperQuestionView;
import cn.bnsr.edu_yun.frontstage.train.po.Course;
import cn.bnsr.edu_yun.frontstage.train.po.CourseFile;
import cn.bnsr.edu_yun.frontstage.train.po.CourseHour;
import cn.bnsr.edu_yun.frontstage.train.po.TopicQuestion;
import cn.bnsr.edu_yun.frontstage.train.po.Train;
import cn.bnsr.edu_yun.frontstage.train.po.UserClassHour;
import cn.bnsr.edu_yun.frontstage.train.po.UserDiscuss;
import cn.bnsr.edu_yun.frontstage.train.po.UserStudy;
import cn.bnsr.edu_yun.frontstage.train.po.UserStudyRecord;
import cn.bnsr.edu_yun.frontstage.train.po.UserTrainClass;
import cn.bnsr.edu_yun.frontstage.train.service.CertificateService;
import cn.bnsr.edu_yun.frontstage.train.service.ClassService;
import cn.bnsr.edu_yun.frontstage.train.service.CourseExamStandardService;
import cn.bnsr.edu_yun.frontstage.train.service.CourseFileService;
import cn.bnsr.edu_yun.frontstage.train.service.CourseHourService;
import cn.bnsr.edu_yun.frontstage.train.service.CourseInfoService;
import cn.bnsr.edu_yun.frontstage.train.service.CourseNoteService;
import cn.bnsr.edu_yun.frontstage.train.service.CourseService;
import cn.bnsr.edu_yun.frontstage.train.service.TopicAnswerService;
import cn.bnsr.edu_yun.frontstage.train.service.TopicQuestionService;
import cn.bnsr.edu_yun.frontstage.train.service.TrainService;
import cn.bnsr.edu_yun.frontstage.train.service.UserAppraiseService;
import cn.bnsr.edu_yun.frontstage.train.service.UserClassHourService;
import cn.bnsr.edu_yun.frontstage.train.service.UserCollectService;
import cn.bnsr.edu_yun.frontstage.train.service.UserDiscussService;
import cn.bnsr.edu_yun.frontstage.train.service.UserStudyRecordService;
import cn.bnsr.edu_yun.frontstage.train.service.UserStudyService;
import cn.bnsr.edu_yun.frontstage.train.view.AppraiseReasonView;
import cn.bnsr.edu_yun.frontstage.train.view.CertificatesView;
import cn.bnsr.edu_yun.frontstage.train.view.ClassMobileView;
import cn.bnsr.edu_yun.frontstage.train.view.ClassView;
import cn.bnsr.edu_yun.frontstage.train.view.CourseCenterView;
import cn.bnsr.edu_yun.frontstage.train.view.CourseExamStandardView;
import cn.bnsr.edu_yun.frontstage.train.view.CourseHourMobileView;
import cn.bnsr.edu_yun.frontstage.train.view.CourseLivingView;
import cn.bnsr.edu_yun.frontstage.train.view.CourseMobileView;
import cn.bnsr.edu_yun.frontstage.train.view.CourseNoteView;
import cn.bnsr.edu_yun.frontstage.train.view.CourseRankView;
import cn.bnsr.edu_yun.frontstage.train.view.CourseView;
import cn.bnsr.edu_yun.frontstage.train.view.ExamMobileView;
import cn.bnsr.edu_yun.frontstage.train.view.NoteMobileView;
import cn.bnsr.edu_yun.frontstage.train.view.NoticeMoblieView;
import cn.bnsr.edu_yun.frontstage.train.view.StudyMobileView;
import cn.bnsr.edu_yun.frontstage.train.view.StudyView;
import cn.bnsr.edu_yun.frontstage.train.view.TopicAnswerMobileView;
import cn.bnsr.edu_yun.frontstage.train.view.TopicQuestionMobileView;
import cn.bnsr.edu_yun.frontstage.train.view.TopicQuestionView;
import cn.bnsr.edu_yun.frontstage.train.view.UserAppraisView;
import cn.bnsr.edu_yun.frontstage.train.view.UserClassHourView;
import cn.bnsr.edu_yun.frontstage.train.view.UserCollectView;
import cn.bnsr.edu_yun.frontstage.train.view.UserDiscussView;
import cn.bnsr.edu_yun.frontstage.train.view.UserStudyView;
import cn.bnsr.edu_yun.util.ConfigInfo;
import cn.bnsr.edu_yun.util.ExceptionUtil;
import cn.bnsr.edu_yun.util.HttpRequest;
import cn.bnsr.edu_yun.util.NumUtil;
import cn.bnsr.edu_yun.util.ResponseUtil;
import cn.bnsr.edu_yun.util.TimeUtil;
import cn.bnsr.edu_yun.util.UserLog;

/**
 * 课程
 * 
 * @author fangxiongwei
 * @date 2016年10月25日
 */
@Controller
@RequestMapping("/course")
public class CourseController {
	private final Logger log = LoggerFactory.getLogger(CourseController.class);

	@Autowired
	private CourseService courseService;
	@Autowired
	private LabelService labelService;
	@Autowired
	private UserService userService;
	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private ClassifyService classifyService;
	@Autowired
	private CourseInfoService courseInfoService;
	@Autowired
	private ClassService classService;
	@Autowired
	private CertificateService certificateService;
	@Autowired
	private CourseExamStandardService courseExamStandardService;
	@Autowired
	private CourseHourService courseHourService;
	@Autowired
	private UserAppraiseService userAppraiseService;
	@Autowired
	private UserStudyService userStudyService;
	@Autowired
	private UserClassHourService userClassHourService;
	@Autowired
	private CourseFileService courseFileService;
	@Autowired
	private TopicQuestionService topicQuestionService;
	@Autowired
	private TopicAnswerService topicAnswerService;
	@Autowired
	private CourseNoteService courseNoteService;
	@Autowired
	private ExamService examService;
	@Autowired
	private UserAttentService userAttentService;
	@Autowired
	private UserCollectService userCollectService;
	@Autowired
	private NotificationService notificationService;
	@Autowired
	private TrainService trainService;
	@Autowired
	private TestPaperService testPaperService;
	@Autowired
	private TestQuestionsService testQuestionsService;
	@Autowired
	private UserDiscussService userDiscussService;
	@Autowired
	private UserStudyRecordService userStudyRecordService;

	/**
	 * 跳转课程管理页面(在教课程)
	 */
	@RequestMapping("/to_course")
	public ModelAndView toCourse(HttpServletRequest request, CourseView courseView) {
		User user = (User) request.getSession().getAttribute("currentUser");
		ModelAndView modelAndView = new ModelAndView();
		String state = request.getParameter("state");
		String stamp = request.getParameter("stamp");
		try {
			courseView.setUserId(user.getId());
			courseView.setRows(10);
			if (courseView.getPage() == 0) {
				courseView.setStartLine(0);
			} else {
				courseView.setStartLine(courseView.getPage() * courseView.getRows());
			}
			List<CourseView> courseList = courseService.queryCourse(courseView);
			int total = courseService.queryTotalCourse(courseView);// 课程总数
			courseView.setTotal(total);
			// 分页总页数
			courseView.setTotalPage(NumUtil.totalPage(total, courseView.getRows()));

			modelAndView.addObject("courseList", courseList);
			modelAndView.addObject("courseView", courseView);

			UserInfo userInfo = userInfoService.getByUserId(user.getId());
			request.setAttribute("user", user);
			request.setAttribute("userInfo", userInfo);
			// 个人中心统计数据
			UserCenterView userCenter = userService.queryUserCenter(user.getId());
			modelAndView.addObject("userCenter", userCenter);

			request.setAttribute("state", state);
			request.setAttribute("stamp", stamp);
			modelAndView.addObject("head_title", "在教课程");
			modelAndView.setViewName("frontstage/train/course/teaching_course");
		} catch (Exception e) {
			log.error("课程列表查询失败", ExceptionUtil.getExceptionMessage(e));
		}
		return modelAndView;
	}

	/**
	 * 跳转创建课程页面
	 */
	@RequestMapping("/to_create_course")
	public ModelAndView toCreateCourse(HttpServletRequest request) {
		String type = request.getParameter("type");
		request.setAttribute("type", type);
		request.setAttribute("head_title", "创建课程");
		return new ModelAndView("frontstage/train/course/create_course");
	}

	/**
	 * 创建课程
	 */
	@RequestMapping("/create_course")
	public ModelAndView createCourse(HttpServletRequest request, Integer type, String title) {
		User user = (User) request.getSession().getAttribute("currentUser");
		Long courseId = null;
		try {
			String room_id = null;
			if (type == 2) {
				CourseLivingView courseLivingView = new CourseLivingView();
				courseLivingView.setName(title);
				String param = courseLivingView.getStr(courseLivingView);
				String sr = HttpRequest.sendPost("http://www.buka.tv/room/add.do", param);
				JSONObject j = JSONObject.fromObject(sr);
				System.out.println(sr);
				room_id = (Integer) j.get("room_id") + "";
			}
			courseId = courseService.createCourse(title, user.getId(), type, room_id);
			title = URLEncoder.encode(title, "utf-8");
		} catch (UnsupportedEncodingException e) {
			log.error("创建课程编码错误", ExceptionUtil.getExceptionMessage(e));
		} catch (Exception e) {
			log.error("创建课程失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}
		return new ModelAndView("redirect:/course/to_course_info.action?id=" + courseId + "&title=" + title + "&flag=0&sign=1");
	}

	/**
	 * 跳转课程基本信息页面
	 */
	@RequestMapping("/to_course_info")
	public ModelAndView toCourseInfo(HttpServletRequest request, CourseView courseView) {
		ModelAndView modelAndView = new ModelAndView();
		try {
			List<Classify> pcList = classifyService.queryByParentId(54l);// 课程父分类
			List<Classify> classifyList = classifyService.findAllClassify(1, false);// 课程子分类
			List<Label> labelList = labelService.findAllLabel(1);// 课程标签
			if (courseView.getId() != null) {
				courseView = courseService.queryCourseInfo(courseView);
			}
			if (courseView.getValidity() == null) {// 默认0不设置有效期
				courseView.setValidity(0);
			}
			modelAndView.addObject("classifyList", classifyList);
			modelAndView.addObject("pcList", pcList);
			modelAndView.addObject("labelList", labelList);
			modelAndView.addObject("courseView", courseView);
			modelAndView.addObject("head_title", "基本信息");
			modelAndView.setViewName("frontstage/train/course/course_info");
		} catch (Exception e) {
			log.error("跳转课程基本信息页面失败", ExceptionUtil.getExceptionMessage(e));
		}

		return modelAndView;
	}

	/**
	 * 保存课程基本信息
	 */
	@RequestMapping("/save_course")
	public ModelAndView saveCourse(HttpServletRequest request, CourseView courseView) {
		try {
			courseService.saveCourse(courseView);
		} catch (Exception e) {
			log.error("保存课程基本信息失败", ExceptionUtil.getExceptionMessage(e));
		}
		return new ModelAndView("redirect:/course/to_course_info.action?id=" + courseView.getId() + "&flag=1&sign=1");
	}

	/**
	 * 发布课程
	 */
	@RequestMapping("/release_course")
	public ModelAndView releaseCourse(HttpServletRequest request) {
		String id = request.getParameter("id");
		courseService.releaseCourse(id);
		return new ModelAndView("redirect:/course/to_course_info.action?id=" + id + "&flag=2&sign=1");
	}

	/**
	 * 跳转课程中心页面
	 */
	@RequestMapping("/to_course_center")
	public ModelAndView toCourseCenter(HttpServletRequest request, CourseCenterView ccv) {
		ModelAndView modelAndView = new ModelAndView();
		try {
			ccv.setRows(20);
			if (ccv.getPage() == 0) {
				ccv.setStartLine(0);
			} else {
				ccv.setStartLine(ccv.getPage() * ccv.getRows());
			}
			List<String> list = new ArrayList<String>();

			// 课程分类
			List<Classify> classifyList = classifyService.queryByParentId(54l);// 课程父分类
			if (ccv.getClassifyId() != -1) {// 选中一级分类查询二级分类
				List<Classify> sonClassifyList = classifyService.queryByParentId(ccv.getClassifyId());
				list.add(ccv.getClassifyId().toString());
				for (Classify cr : sonClassifyList) {
					list.add(cr.getId().toString());
				}
				ccv.setClassifyIds(list);
				modelAndView.addObject("sonClassifyList", sonClassifyList);
			}
			modelAndView.addObject("classifyList", classifyList);

			List<CourseCenterView> courseList = courseService.queryCourseCenter(ccv);
			int total = courseService.queryTotalCourseCenter(ccv);// 课程总数
			ccv.setTotal(total);
			// 分页总页数
			ccv.setTotalPage(NumUtil.totalPage(total, ccv.getRows()));

			modelAndView.addObject("courseList", courseList);
			modelAndView.addObject("ccv", ccv);
			modelAndView.addObject("head_title", "课程中心");
			modelAndView.setViewName("frontstage/train/course_show/course_center");
		} catch (Exception e) {
			log.error("课程中心查询失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}
		return modelAndView;
	}

	/**
	 * 异步查询课程列表
	 */
	@RequestMapping("/query_all_course")
	@ResponseBody
	public JSONArray queryAllCourse(HttpServletRequest request, CourseView courseView) {
		User user = (User) request.getSession().getAttribute("currentUser");
		try {
			courseView.setUserId(user.getId());
			courseView.setRows(7);
			if (courseView.getPage() == 0) {
				courseView.setStartLine(0);
			} else {
				courseView.setStartLine(courseView.getPage() * courseView.getRows());
			}
			if (courseView.getTitle().equals("")) {
				courseView.setTitle(null);
			}
			courseView.setType("0");// 普通课程
			if (!courseView.getIds().equals("")) {
				courseView.setList(NumUtil.getList(courseView.getIds()));
			}
			List<CourseView> courseList = courseService.queryCourse(courseView);
			int total = courseService.queryTotalCourse(courseView);// 课程总数
			courseView.setTotal(total);
			// 分页总页数
			courseView.setTotalPage(NumUtil.totalPage(total, courseView.getRows()));

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("courseList", courseList);
			map.put("courseView", courseView);

			if (courseList != null) {
				return JSONArray.fromObject(map);
			}

		} catch (Exception e) {
			log.error("课程列表查询失败", ExceptionUtil.getExceptionMessage(e));
		}

		return JSONArray.fromObject(0);

	}

	/**
	 * 异步查询课程信息
	 */
	@RequestMapping("/get_by_course_ids")
	@ResponseBody
	public JSONArray getByCourseIds(HttpServletRequest request, CourseView courseView) {
		try {
			if (!courseView.getIds().equals("")) {
				courseView.setList(NumUtil.getList(courseView.getIds()));
			}
			List<CourseView> courseList = courseService.getByCourseIds(courseView.getList());
			Map<String, Object> map = new HashMap<String, Object>();

			map.put("courseList", courseList);

			if (courseList != null) {
				return JSONArray.fromObject(map);
			}
		} catch (Exception e) {
			log.error("课程列表查询失败", ExceptionUtil.getExceptionMessage(e));
		}

		return JSONArray.fromObject(0);
	}

	@RequestMapping("/to_course_center_m")
	public void toCourseCenterM(HttpServletRequest request, CourseCenterView ccv, HttpServletResponse response) {
		JSONObject result = new JSONObject();
		try {

			// 课程分类
			if (ccv.getClassifyId() == null && ccv.getSortType() == null && ccv.getStatus() == null) {
				if (ccv.getRows() == 0)
					ccv.setRows(5);
				if (ccv.getPage() == 0) {
					ccv.setStartLine(0);
				} else {
					ccv.setStartLine(ccv.getPage() * ccv.getRows());
				}
				List<ClassifyView> classifyList = classifyService.queryViewByParentId(54l);// 课程父分类
				result.put("classifyList", classifyList);
				ccv.setSortType("1");
				List<CourseCenterView> newList = courseService.queryCourseCenter(ccv);
				ccv.setSortType("2");
				List<CourseCenterView> hotList = courseService.queryCourseCenter(ccv);
				ccv.setSortType("3");
				List<CourseCenterView> recommendList = courseService.queryCourseCenter(ccv);
				result.put("newList", newList);
				result.put("hotList", hotList);
				result.put("recommendList", recommendList);
			} else if (ccv.getClassifyId() != null) {
				List<String> list = new ArrayList<String>();
				List<ClassifyView> sonClassifyList = classifyService.queryViewByParentId(ccv.getClassifyId());
				list.add(ccv.getClassifyId().toString());
				for (ClassifyView cr : sonClassifyList) {
					list.add(cr.getId().toString());
				}
				ccv.setClassifyIds(list);
				List<ClassifyView> classifyList = classifyService.queryViewByParentId(54l);// 课程父分类
				for (ClassifyView classifyView : classifyList) {
					List<ClassifyView> son = classifyService.queryViewByParentId(classifyView.getId() + 0l);
					classifyView.setSon(son);
				}
				result.put("classifyList", classifyList);
				List<CourseCenterView> courseList = courseService.queryCourseCenter(ccv);
				result.put("courseList", courseList);
			} else {
				List<ClassifyView> classifyList = classifyService.queryViewByParentId(54l);// 课程父分类
				for (ClassifyView classifyView : classifyList) {
					List<ClassifyView> son = classifyService.queryViewByParentId(classifyView.getId() + 0l);
					classifyView.setSon(son);
				}
				result.put("classifyList", classifyList);
				List<CourseCenterView> courseList = courseService.queryCourseCenter(ccv);
				result.put("courseList", courseList);
			}

			// result.put("courseCenterView", ccv);
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			log.error("课程中心查询失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}

	}

	@RequestMapping("/to_classify_m")
	public void toClassifyM(HttpServletRequest request, HttpServletResponse response) {
		JSONObject result = new JSONObject();
		try {
			List<ClassifyView> classifyList = classifyService.queryViewByParentId(54l);// 课程父分类
			for (ClassifyView classifyView : classifyList) {
				List<ClassifyView> son = classifyService.queryViewByParentId(classifyView.getId() + 0l);
				classifyView.setSon(son);
			}

			result.put("classifyList", classifyList);
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			log.error("课程中心查询失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}

	}

	@RequestMapping("/to_course_m")
	public void toCourseM(HttpServletRequest request, HttpServletResponse response, Long id, Long class_id, Long user_id) {
		JSONObject result = new JSONObject();
		try {
			CourseMobileView courseMobileView = new CourseMobileView();
			CourseView courseInfo = courseInfoService.queryCourseDetail(id);
			courseMobileView.setUrl("/course/to_course_m_profile.action?id=" + id);
			Course course = courseService.getById(id);
			courseMobileView.setCourse_name(course.getTitle());
			User user = userService.selectByPrimaryKey(course.getUser_id());
			courseMobileView.setUsername(user.getUsername());
			UserInfo userInfo = userInfoService.getByUserId(course.getUser_id());
			courseMobileView.setSchool(userInfo.getSchool());
			courseMobileView.setImg(courseInfo.getImg());
			ClassView classView = new ClassView();
			classView.setPaging("0");// 不分页
			classView.setStatus(5);
			classView.setState(0);
			classView.setSource_id(id);
			classView.setSource_type(0);
			int isJoin = 0;
			if (user_id != null) {
				UserStudyView userStudyView = new UserStudyView();
				userStudyView.setSourceType("0");
				userStudyView.setUserId(user_id + "");
				userStudyView.setLearnId(id + "");// 改
				if (class_id != null) {
					userStudyView.setSourceId(class_id + "");
				}
				List<UserStudy> usList = userStudyService.searchUserStudy(userStudyView);
				// 默认第一个班级
				if (usList.size() > 0) {
					UserStudy userStudy = usList.get(0);
					userStudyView.setId(userStudy.getId().toString());
					if (class_id == null) {
						class_id = userStudy.getSource_id();
					}
					isJoin = 1;
				}
			}

			if (class_id == null) {
				List<ClassView> classList = classService.find(classView);
				if (classList != null && classList.size() > 0) {
					classView = classList.get(0);
					courseMobileView.setClass_name(classView.getName());
					courseMobileView.setClass_id(classView.getId());
					courseMobileView.setPrice(classView.getPrice());
					Date end = classView.getClose_time();
					Date start = classView.getOpen_time();
					int valid_date = TimeUtil.getBetweenDates(start, end).size();
					courseMobileView.setValid_date(valid_date);
					courseMobileView.setEndTime(TimeUtil.dateToString1(end));
					courseMobileView.setStartTime(TimeUtil.dateToString1(start));
					courseMobileView.setLastTime(TimeUtil.dateToString2(classView.getEnd_time()));
				}
			} else {
				classView = classService.selectOne(class_id, 0);
				if (classView != null) {
					courseMobileView.setClass_name(classView.getName());
					courseMobileView.setClass_id(class_id);
					courseMobileView.setPrice(classView.getPrice());
					Date end = classView.getClose_time();
					Date start = classView.getOpen_time();
					int valid_date = TimeUtil.getBetweenDates(start, end).size();
					courseMobileView.setValid_date(valid_date);
					courseMobileView.setEndTime(TimeUtil.dateToString1(end));
					courseMobileView.setStartTime(TimeUtil.dateToString1(start));
					courseMobileView.setLastTime(TimeUtil.dateToString2(classView.getEnd_time()));

				}
			}
			result.put("isJoin", isJoin);
			result.put("courseView", courseMobileView);
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			log.error("课程中心查询失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}

	}

	@RequestMapping("/to_course_m_profile")
	public ModelAndView toCourseMProfile(HttpServletRequest request, long id) {
		ModelAndView modelAndView = new ModelAndView();
		CourseView courseInfo = courseInfoService.queryCourseDetail(id);
		modelAndView.setViewName("frontstage/train/course_show/course_intro");
		modelAndView.addObject("courseInfo", courseInfo);
		CertificatesView certificatesView = new CertificatesView();
		certificatesView.setSource_id(courseInfo.getId().toString());
		certificatesView.setSource_type("1");
		List<CertificatesView> certificatesViews = certificateService.findAll(certificatesView);
		modelAndView.addObject("certificatesViews", certificatesViews);// 证书情况

		CourseExamStandardView examStandardView = new CourseExamStandardView();
		examStandardView.setCourse_id(courseInfo.getId().toString());
		examStandardView.setSource_type("0");
		modelAndView.addObject("jobStandard", courseExamStandardService.queryStandard(examStandardView));
		examStandardView.setSource_type("1");
		modelAndView.addObject("discussionStandard", courseExamStandardService.queryStandard(examStandardView));
		examStandardView.setSource_type("2");
		modelAndView.addObject("examStandard", courseExamStandardService.queryStandard(examStandardView));

		return modelAndView;
	}

	@RequestMapping("/to_class_m")
	public void toClassM(HttpServletRequest request, HttpServletResponse response, Long id) throws Exception {
		JSONObject result = new JSONObject();
		ClassView classView = new ClassView();
		List<ClassMobileView> classMoblieList = new ArrayList<ClassMobileView>();
		classView.setPaging("0");// 不分页
		classView.setStatus(5);
		classView.setState(0);
		classView.setSource_id(id);
		classView.setSource_type(0);
		List<ClassView> classList = classService.find(classView);
		for (ClassView c : classList) {
			ClassMobileView classMobileView = new ClassMobileView();
			classMobileView.setClass_name(c.getName());
			Date end = c.getClose_time();
			Date start = c.getOpen_time();
			int valid_date = TimeUtil.getBetweenDates(start, end).size();
			classMobileView.setValid_date(valid_date);
			classMobileView.setClass_id(c.getId());
			classMobileView.setLastTime(TimeUtil.dateToString2(c.getEnd_time()));
			classMoblieList.add(classMobileView);
		}
		result.put("classList", classMoblieList);
		ResponseUtil.write(response, result);
	}

	@RequestMapping("/to_course_hour_m")
	public void toCourseHourM(HttpServletRequest request, HttpServletResponse response, Long id) throws Exception {
		JSONObject result = new JSONObject();
		List<CourseHourMobileView> courseHourMobileViews = new ArrayList<CourseHourMobileView>();
		List<CourseHour> courseHours = courseHourService.queryHourList(id, true);
		int i = 1;
		for (CourseHour c : courseHours) {
			CourseHourMobileView courseHourMobileView = new CourseHourMobileView();
			courseHourMobileView.setId(c.getId());
			courseHourMobileView.setTitle(c.getHour_title());
			courseHourMobileView.setSeq(i++);
			List<CourseHour> courseHours2 = courseHourService.queryHourListByPid(c.getId());
			List<CourseHourMobileView> son = new ArrayList<CourseHourMobileView>();
			int j = 1;
			for (CourseHour ch : courseHours2) {
				CourseHourMobileView courseHourMobileView1 = new CourseHourMobileView();
				courseHourMobileView1.setId(ch.getId());
				courseHourMobileView1.setTitle(ch.getHour_title());
				courseHourMobileView1.setSeq(j++);
				if (ch.getAttribute_type() == 2) {
					if (ch.getHour_type() != null && ch.getHour_type() == 1) {
						courseHourMobileView1.setStatus("1");
					} else {
						courseHourMobileView1.setStatus("2");
					}
				} else {
					courseHourMobileView1.setStatus(ch.getAttribute_type() + "");
				}
				son.add(courseHourMobileView1);
			}
			courseHourMobileView.setSonList(son);
			courseHourMobileViews.add(courseHourMobileView);
		}
		result.put("courseHourView", courseHourMobileViews);
		ResponseUtil.write(response, result);
	}

	@RequestMapping("/to_course_apprise_m")
	public void toCourseAppriseM(HttpServletRequest request, HttpServletResponse response, Long id) throws Exception {
		JSONObject result = new JSONObject();
		List<UserAppraisView> appraise = userAppraiseService.selectBySourceId(id, 0, 0, 0);
		result.put("appraise", appraise);
		// 评价项
		AppraiseReasonView appraiseReasonView = new AppraiseReasonView();
		long totalAppraise = userAppraiseService.selectCountBySourceId(id, 0);
		Integer totalScore = userAppraiseService.selectTotalScore(id, 0);
		result.put("total", totalAppraise);
		if (totalAppraise != 0 && totalScore != null) {
			double score = totalScore * 1.0;
			result.put("average", score / totalAppraise);
		} else {
			result.put("average", 0);
		}
		appraiseReasonView.setType(0);
		appraiseReasonView.setLevel(5);
		appraiseReasonView.setSource_id(id);
		List<AppraiseReasonView> appraiseReasonViews = userAppraiseService.selectByType(appraiseReasonView);
		result.put("reason", appraiseReasonViews);
		ResponseUtil.write(response, result);
	}

	/**
	 * 
	 * 用户手机加入课程班级
	 */
	@UserLog(description = "加入学习")
	@RequestMapping("/join_study_m")
	public void joinStudy(HttpServletResponse response, HttpServletRequest request, Long user_id, Long class_id) {
		JSONObject result = new JSONObject();
		try {
			User user = userService.selectByPrimaryKey(user_id);
			ClassView classView = classService.selectOne(class_id, null);

			boolean isJoin = userStudyService.joinStudy(classView, user);
			result.put("msg", isJoin);

			ResponseUtil.write(response, result);
		} catch (Exception e) {
			e.printStackTrace();
			log.error("加入学习失败", ExceptionUtil.getExceptionMessage(e));
		}

	}

	@RequestMapping("/to_user_study_m")
	public void toUserStudyM(HttpServletRequest request, HttpServletResponse response, Long id, Long class_id, Long user_id) {
		JSONObject result = new JSONObject();

		try {

			CourseMobileView courseMobileView = new CourseMobileView();
			CourseView courseInfo = courseInfoService.queryCourseDetail(id);
			Course course = courseService.getById(id);
			courseMobileView.setCourse_name(course.getTitle());
			User user = userService.selectByPrimaryKey(course.getUser_id());
			courseMobileView.setUsername(user.getUsername());
			UserInfo userInfo = userInfoService.getByUserId(course.getUser_id());
			courseMobileView.setSchool(userInfo.getSchool());
			courseMobileView.setImg(courseInfo.getImg());
			ClassView classView = new ClassView();
			classView.setPaging("0");// 不分页
			classView.setStatus(5);
			classView.setState(0);
			classView.setSource_id(id);
			classView.setSource_type(0);
			if (class_id != null) {
				classView = classService.selectOne(class_id, 0);
				userStudyService.joinStudy(classView, user);
				if (classView != null) {
					courseMobileView.setClass_name(classView.getName());
					courseMobileView.setClass_id(class_id);
					courseMobileView.setPrice(classView.getPrice());
					Date end = classView.getEnd_time();
					Date start = classView.getOpen_time();
					int valid_date = TimeUtil.getBetweenDates(start, end).size();
					courseMobileView.setValid_date(valid_date);
					courseMobileView.setEndTime(TimeUtil.dateToString1(end));
					courseMobileView.setStartTime(TimeUtil.dateToString1(start));
				}
			}
			UserClassHour userClassHour = new UserClassHour();
			userClassHour.setCourse_id(id);
			userClassHour.setUser_id(user_id);
			userClassHour.setClass_id(class_id);
			// 所有课时的数
			int allNum = userClassHourService.selectCountByCourseIdAndUserId(userClassHour);
			result.put("allNum", allNum);
			// 已学课时数
			int studyNum = userClassHourService.selectCountByCourseIdAndUserIdStudy(userClassHour);
			result.put("studyNum", studyNum);
			result.put("courseView", courseMobileView);

			List<CourseHourMobileView> courseHourMobileViews = new ArrayList<CourseHourMobileView>();
			List<CourseHour> courseHours = courseHourService.queryHourList(id, true);
			int i = 1;
			long nextId = 0;
			for (CourseHour c : courseHours) {
				CourseHourMobileView courseHourMobileView = new CourseHourMobileView();
				courseHourMobileView.setId(c.getId());
				courseHourMobileView.setTitle(c.getHour_title());
				courseHourMobileView.setSeq(i++);
				List<CourseHour> courseHours2 = courseHourService.queryHourListByPid(c.getId());
				List<CourseHourMobileView> son = new ArrayList<CourseHourMobileView>();
				int j = 1;
				for (CourseHour ch : courseHours2) {
					CourseHourMobileView courseHourMobileView1 = new CourseHourMobileView();
					userClassHour.setCourse_hour_id(ch.getId());
					UserClassHour userClassHour1 = userClassHourService.selectByHourId(userClassHour);
					if (userClassHour1 == null) {
						continue;
					}
					if (i == 1 && j == 1) {
						nextId = ch.getId();
					}
					courseHourMobileView1.setIs_studyed(userClassHour1.getIs_studyed());
					courseHourMobileView1.setId(ch.getId());
					courseHourMobileView1.setTitle(ch.getHour_title());
					courseHourMobileView1.setSeq(j++);
					if (ch.getAttribute_type() == 2) {
						if (ch.getHour_type() != null && ch.getHour_type() == 1) {
							courseHourMobileView1.setStatus("1");
						} else {
							courseHourMobileView1.setStatus("2");
						}
					} else {
						courseHourMobileView1.setStatus(ch.getAttribute_type() + "");
					}
					son.add(courseHourMobileView1);
				}
				courseHourMobileView.setSonList(son);
				courseHourMobileViews.add(courseHourMobileView);
			}
			result.put("courseHourView", courseHourMobileViews);
			UserClassHour uch = userClassHourService.selectByNextStudy(userClassHour);
			if (uch != null) {
				String hour_id = uch.getCourse_hour_id() + "";
				CourseHour nextCourseHour = courseHourService.getHour(hour_id);
				result.put("nextHour", nextCourseHour.getHour_title());
				result.put("nextId", nextCourseHour.getId());
			} else {
				result.put("nextId", nextId);
			}
			CourseRankView courseRankView = new CourseRankView();
			courseRankView.setCourse_id(id);
			courseRankView.setClassId(class_id);
			List<CourseRankView> courseRankViews = userClassHourService.paceRank(courseRankView);
			result.put("rankView", courseRankViews);
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			log.error("课程中心查询失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}

	}

	@RequestMapping("/to_study_again_m")
	public ModelAndView to_study_again(CourseHour courseHour, HttpServletResponse response, HttpServletRequest request, Long class_id) throws Exception {
		Long user_id = courseHour.getUser_id();// 用courseHour接收，实际不符合逻辑，为学习的用户
		TestPaper testPaper = testPaperService.selectByCourseHourId(courseHour.getId());
		courseHour = courseHourService.getHour(courseHour.getId() + "");// courseHour.getUser_id()为创建课程的用户

		Exam exam = new Exam();
		exam.setUser_id(user_id);
		exam.setClass_id(class_id);
		exam.setTest_paper_id(testPaper.getId());

		exam.setStatus(0);
		if (courseHour.getAttribute_type() == 0) {
			exam.setExam_type(0);
		} else if (courseHour.getAttribute_type() == 4) {
			exam.setExam_type(1);
		}
		Exam exam1 = examService.selectStatus(exam);
		if (exam1.getStatus() == 2) {
			examService.insertSelective(exam);
		}

		return new ModelAndView("redirect:/course/to_study_m.action?id=" + courseHour.getId() + "&class_id=" + class_id + "&user_id=" + user_id);
	}

	@RequestMapping("/to_study_m")
	public ModelAndView to_study(CourseHour courseHour, HttpServletResponse response, HttpServletRequest request, Long class_id) throws Exception {
		Long user_id = courseHour.getUser_id();// 用courseHour接收，实际不符合逻辑，为学习的用户
		courseHour = courseHourService.getHour(courseHour.getId() + "");// courseHour.getUser_id()为创建课程的用户
		ModelAndView modelAndView = new ModelAndView();
		Long courseid = courseHour.getCourse_id();
		TestPaper testPaper = testPaperService.selectByCourseHourId(courseHour.getId());
		UserStudyView userStudyView = new UserStudyView();
		userStudyView.setSourceType("0");
		userStudyView.setUserId(user_id + "");
		userStudyView.setLearnId(courseid + "");
		userStudyView.setSourceId(class_id + "");
		List<UserStudy> usList = userStudyService.searchUserStudy(userStudyView);
		if (usList.size() > 0)
			modelAndView.addObject("user_study_id", usList.get(0).getId());
		if (courseHour.getAttribute_type() == 0) {

			CourseView courseView = null;

			if (courseid != null) {
				courseView = courseInfoService.queryCourseDetail(courseid);
			}
			if (courseView != null) {
				modelAndView.addObject("courseView", courseView);
			}
			Exam exam = new Exam();

			exam.setUser_id(user_id);
			exam.setClass_id(class_id);
			exam.setTest_paper_id(testPaper.getId());
			Exam exam1 = examService.selectStatus(exam);
			// 是否已经存在试卷
			if (exam1 != null) {
				exam = exam1;
			} else {
				exam.setStatus(0);
				exam.setExam_type(0);
				examService.insertSelective(exam);
			}

			int tab = 2;
			// 未交卷
			if (exam.getStatus() == 0) {
				tab = 2;
			}
			// 试卷待批阅的状态
			else if (exam.getStatus() == 1) {

				tab = 3;

			}
			// 已批阅
			else {
				tab = 5;
				// 如果是本人进来，添加可以跳转重新尝试做
				if (exam.getUser_id() == user_id) {
					modelAndView.addObject("try_again", true);
				}

			}
			modelAndView.addObject("exam", exam);
			// 展示题目,0-4代表五种题目类型，5代表子题 //新加入一种类型单选
			for (int type = 0; type < 7; type++) {
				TestPaperQuestionView testPaperQuestionView = new TestPaperQuestionView();
				testPaperQuestionView.setTestPaper_id(testPaper.getId());
				testPaperQuestionView.setType(type);
				testPaperQuestionView.setExam_id(exam.getId());
				List<TestPaperQuestionView> testPaperQuestionViews = testQuestionsService.queryTestPaperQuestionOnDoTest(testPaperQuestionView);
				/*
				List<TestPaperQuestionView> testPaperQuestionViews = null;
				if (tab == 2){
					testPaperQuestionViews = testQuestionsService.queryTestPaperQuestionOnDoTest(testPaperQuestionView);
				}else if (tab == 3 || tab == 4 || tab == 5){
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
					//total_score += t.getQuestions_score();
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

			Integer time = testPaper.getTimeless();
			if (time != null && time != 0 && exam.getExam_hour() != null) {
				double time1 = time - Integer.parseInt(exam.getExam_hour()) / 60.0;
				modelAndView.addObject("time", time1);
			} else {
				modelAndView.addObject("time", time);
			}

			modelAndView.addObject("testPaper", testPaper);
			modelAndView.addObject("tab", tab);
			modelAndView.addObject("class_id", class_id);
			modelAndView.addObject("user", userService.selectByPrimaryKey(exam.getUser_id()));
			modelAndView.addObject("head_title", testPaper.getName());
			if (tab == 2)
				modelAndView.setViewName("frontstage/train/app/app_do_test");
			if (tab == 3 || tab == 4 || tab == 5)
				modelAndView.setViewName("frontstage/train/app/app_check_test");

		} else if (courseHour.getAttribute_type() == 4) {

			CourseView courseView = null;

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

			exam = new Exam();
			exam.setUser_id(user_id);
			exam.setClass_id(class_id);
			exam.setTest_paper_id(testPaper.getId());
			Exam exam1 = examService.selectStatus(exam);
			// 是否已经存在试卷
			if (exam1 != null) {
				exam = exam1;
			} else {
				exam.setStatus(0);
				exam.setExam_type(1);
				examService.insertSelective(exam);
			}

			int tab = 2;
			// 未交卷
			if (exam.getStatus() == 0) {
				tab = 2;
			}
			// 试卷待批阅的状态
			else if (exam.getStatus() == 1) {
				tab = 3;

			}
			// 已批阅
			else {
				tab = 5;
				// 如果是本人进来，添加可以跳转重新尝试做
				if (exam.getUser_id() == user_id) {
					modelAndView.addObject("try_again", true);
				}

			}
			modelAndView.addObject("exam", exam);
			TestPaperQuestionView testPaperQuestionView = new TestPaperQuestionView();
			testPaperQuestionView.setExam_id(exam.getId());
			testPaperQuestionView.setTestPaper_id(testPaper.getId());
			testPaperQuestionView.setIs_son(1);
			//List<TestPaperQuestionView> testPaperQuestionViews = testQuestionsService.queryAllTestPaperQuestion(testPaperQuestionView);
			List<TestPaperQuestionView> testPaperQuestionViews = testQuestionsService.queryAllTestPaperQuestionOnDoHomework(testPaperQuestionView);
			testPaperQuestionView.setIs_son(0);
			//List<TestPaperQuestionView> testPaperSonQuestionViews = testQuestionsService.queryAllTestPaperQuestion(testPaperQuestionView);
			List<TestPaperQuestionView> testPaperSonQuestionViews = testQuestionsService.queryAllTestPaperQuestionOnDoHomework(testPaperQuestionView);
			modelAndView.addObject("testPaperQuestionViews", testPaperQuestionViews);
			modelAndView.addObject("testPaperSonQuestionViews", testPaperSonQuestionViews);
			modelAndView.addObject("testPaper", testPaper);
			modelAndView.setViewName("frontstage/train/app/app_homework");
			modelAndView.addObject("class_id", class_id);
			modelAndView.addObject("tab", tab);
			modelAndView.addObject("head_title", testPaper.getName());
		} else if (courseHour.getAttribute_type() == 3) {
			modelAndView.setViewName("frontstage/train/app/app_discuss");
			UserDiscussView userDiscussView = new UserDiscussView();
			userDiscussView.setClass_id(class_id);
			userDiscussView.setCourse_hour_id(courseHour.getId());
			UserDiscuss userDiscuss = new UserDiscuss();
			userDiscuss.setDiscuss_time(new Date());
			userDiscuss.setUser_id(user_id);
			userDiscuss.setCourse_hour_id(courseHour.getId());
			userDiscuss.setClass_id(class_id);
			int userDiscussCount = userDiscussService.countUserDiscuss(userDiscuss);
			List<UserDiscussView> userDiscussViews = userDiscussService.queryDiscuss(userDiscussView);
			modelAndView.addObject("userDiscussViews", userDiscussViews);
			modelAndView.addObject("userDiscussCount", userDiscussCount);
			modelAndView.addObject("courseHour", courseHour);
			modelAndView.addObject("class_id", class_id);

		}

		else if (courseHour.getAttribute_type() == 2) {
			modelAndView.setViewName("frontstage/train/app/app_living");
			CourseFile courseFile = courseFileService.selectByKey(courseHour.getCourse_file_id());
			modelAndView.addObject("courseFile", courseFile);
			modelAndView.addObject("file_server_path", ConfigInfo.getString("file_server_path"));
			Long id = courseHour.getCourse_id();
			List<CourseHourMobileView> courseHourMobileViews = new ArrayList<CourseHourMobileView>();
			List<CourseHour> courseHours = courseHourService.queryHourList(id, true);
			int i = 1;
			UserClassHour userClassHour = new UserClassHour();
			userClassHour.setCourse_id(id);
			userClassHour.setUser_id(user_id);
			userClassHour.setClass_id(class_id);
			for (CourseHour c : courseHours) {
				CourseHourMobileView courseHourMobileView = new CourseHourMobileView();
				courseHourMobileView.setId(c.getId());
				courseHourMobileView.setTitle(c.getHour_title());
				courseHourMobileView.setSeq(i++);
				List<CourseHour> courseHours2 = courseHourService.queryHourListByPid(c.getId());
				List<CourseHourMobileView> son = new ArrayList<CourseHourMobileView>();
				int j = 1;
				for (CourseHour ch : courseHours2) {
					CourseHourMobileView courseHourMobileView1 = new CourseHourMobileView();
					userClassHour.setCourse_hour_id(ch.getId());
					UserClassHour userClassHour1 = userClassHourService.selectByHourId(userClassHour);
					if (userClassHour1 == null) {
						continue;
					}

					courseHourMobileView1.setIs_studyed(userClassHour1.getIs_studyed());
					courseHourMobileView1.setId(ch.getId());
					courseHourMobileView1.setTitle(ch.getHour_title());
					courseHourMobileView1.setSeq(j++);
					if (ch.getAttribute_type() == 2) {
						if (ch.getHour_type() != null && ch.getHour_type() == 1) {
							courseHourMobileView1.setStatus("1");
						} else {
							courseHourMobileView1.setStatus("2");
						}
					} else {
						courseHourMobileView1.setStatus(ch.getAttribute_type() + "");
					}
					son.add(courseHourMobileView1);
				}
				courseHourMobileView.setSonList(son);
				courseHourMobileViews.add(courseHourMobileView);
			}
			userClassHour.setCourse_hour_id(courseHour.getId());
			userClassHour = userClassHourService.selectByHourId(userClassHour);
			modelAndView.addObject("userClassHour", userClassHour);
			modelAndView.addObject("courseHourMobileViews", courseHourMobileViews);
			// 图文和文档自动变为已学过
			if (courseHour.getHour_type() == 1 || courseHour.getHour_type() == 3) {
				if (userClassHour.getIs_studyed() != 1) {
					userClassHour.setIs_studyed(1);
					userClassHour.setStudyed_time(new Date());
					userClassHourService.update(userClassHour);
					if (usList.size() > 0) {

						UserStudy userStudy = usList.get(0);

						// 存动态
						UserStudyRecord record = new UserStudyRecord();
						record.setUser_id(user_id);
						record.setLearn_id(userClassHour.getCourse_id());
						record.setSource_name(courseHour.getHour_title());
						record.setSource_id(userStudy.getSource_id());
						record.setSource_type(userStudy.getSource_type());
						if (userStudy.getSource_type() == 1) {
							Train train = trainService.getById(userStudy.getLearn_id());
							if (train != null) {
								record.setType(train.getType());
							}
						} else {
							Course cou = courseService.getById(userStudy.getLearn_id());
							if (cou != null) {
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

							userStudy.setIs_studyed(1);
							userStudyService.saveOrUpdateStudent(userStudy);

						}
					}
				}

			}
		}
		modelAndView.addObject("user_id", user_id);
		modelAndView.addObject("courseHour", courseHour);
		modelAndView.addObject("class_id", class_id);
		modelAndView.addObject("course_hour_id", courseHour.getId());

		return modelAndView;
	}

	@RequestMapping("/to_question_m")
	public void toQuestionM(HttpServletRequest request, HttpServletResponse response, long source_id, int source_type, Long user_id, Integer type)
			throws Exception {
		JSONObject result = new JSONObject();
		List<TopicQuestionMobileView> topicQuestionMobileViews = topicQuestionService.selectByCourseIdM(source_id, source_type, user_id, type);
		result.put("topicQuestions", topicQuestionMobileViews);

		ResponseUtil.write(response, result);
	}

	@RequestMapping("/read_question_m")
	public ModelAndView read_question_m(Long question_id, Long user_id, HttpServletResponse response, HttpServletRequest request) throws Exception {
		ModelAndView modelAndView = new ModelAndView("frontstage/train/app/app_question");
		List<TopicAnswerMobileView> topicAnswers = topicAnswerService.selectAnswerM(question_id);
		TopicQuestion topicQuestion = topicQuestionService.selectById(question_id);
		topicQuestion.setWatch_times(topicQuestion.getWatch_times() + 1);
		topicQuestionService.update(topicQuestion);
		TopicQuestionMobileView topicQuestionMobileView = topicQuestionService.selectByIdM(topicQuestion.getId());
		modelAndView.addObject("user_id", user_id);
		modelAndView.addObject("topicAnswers", topicAnswers);
		modelAndView.addObject("topicQuestion", topicQuestionMobileView);

		return modelAndView;
	}

	@RequestMapping("/note_m")
	public void note_m(HttpServletResponse response, long user_id, long course_id, int status) throws Exception {
		JSONObject result = new JSONObject();
		List<CourseNoteView> courseNoteViews = courseNoteService.queryNoteM(user_id, course_id, status);
		result.put("courseNoteViews", courseNoteViews);
		ResponseUtil.write(response, result);
	}

	@RequestMapping("/hour_list_m")
	public void getHourList(HttpServletResponse response, Long user_id, Long course_id, Long class_id) throws Exception {
		JSONObject result = new JSONObject();
		List<CourseHour> courseHours = courseHourService.queryHourList(course_id, false);
		UserClassHour userClassHour = new UserClassHour();
		userClassHour.setCourse_id(course_id);
		userClassHour.setUser_id(user_id);
		userClassHour.setClass_id(class_id);
		List<CourseHourMobileView> courseHourMobileViews = new ArrayList<CourseHourMobileView>();
		for (CourseHour ch : courseHours) {
			CourseHourMobileView courseHourMobileView1 = new CourseHourMobileView();
			userClassHour.setCourse_hour_id(ch.getId());
			UserClassHour userClassHour1 = userClassHourService.selectByHourId(userClassHour);
			if (userClassHour1 == null) {
				continue;
			}
			courseHourMobileView1.setId(ch.getId());
			courseHourMobileView1.setTitle(ch.getHour_title());

			courseHourMobileViews.add(courseHourMobileView1);
		}
		result.put("hourList", courseHourMobileViews);
		ResponseUtil.write(response, result);
	}

	@RequestMapping("/user_study_m")
	public void userStudyM(HttpServletResponse response, Long user_id) throws Exception {
		JSONObject result = new JSONObject();
		UserCenterView userCenter = userService.queryUserCenter(user_id);
		User user = userService.selectByPrimaryKey(user_id);
		result.put("username", user.getUsername());
		result.put("icon", user.getIcon());
		int courseNum = userCenter.getStudyCourse();
		int continueDay = userCenter.getContinueDay();
		long hour = userCenter.getStudytime();// 时
		long minute = userCenter.getStudytimeM();// 分
		result.put("courseNum", courseNum);
		result.put("continueDay", continueDay);
		result.put("hour", hour);
		result.put("minute", minute);
		StudyView studyView = new StudyView();
		studyView.setUser_id(user_id);
		studyView.setSource_type(0);
		studyView.setIs_studyed(-2);
		List<StudyView> userStudyList = userStudyService.queryUserStudy(studyView);
		List<StudyMobileView> studyMobileViews = new ArrayList<StudyMobileView>();
		for (StudyView s : userStudyList) {
			StudyMobileView studyMobileView = new StudyMobileView();
			String end_time = TimeUtil.dateToString1(s.getEnd_time());
			// 是否超过结束时间
			long todayTime = new Date().getTime();
			long endTime = s.getEnd_time().getTime();
			boolean can_study = endTime - todayTime >= 0;
			studyMobileView.setCan_study(can_study);
			long course_id = s.getId();
			String img = s.getImg();
			String name = s.getName();
			int hours = s.getHours();
			int allNum = (int) s.getAllNum();
			int studyNum = (int) s.getStudyNum();
			UserClassHourView uchv = new UserClassHourView();
			uchv.setCourse_id(s.getId());// 课程id
			uchv.setUser_id(user_id);
			uchv.setClass_id(s.getClassId());
			int isNum = 0;
			int notNum = 0;
			int doing = 0;
			uchv.setIs_studyed(0);// 未学
			notNum = userClassHourService.countIsNotStudy(uchv);
			uchv.setIs_studyed(1);// 已学
			isNum = userClassHourService.countIsNotStudy(uchv);
			uchv.setIs_studyed(2);// 学习中
			doing = userClassHourService.countIsNotStudy(uchv);
			allNum = (isNum + notNum + doing);
			studyNum = (isNum);
			studyMobileView.setClass_id(s.getClassId());
			studyMobileView.setStudyNum(studyNum);
			studyMobileView.setAllNum(allNum);
			studyMobileView.setHours(hours);
			studyMobileView.setImg(img);
			studyMobileView.setName(name);
			studyMobileView.setEnd_time(end_time);// 时间
			studyMobileView.setCourse_id(course_id);
			studyMobileViews.add(studyMobileView);
		}
		result.put("studyMobileViews", studyMobileViews);
		ResponseUtil.write(response, result);
	}

	// 跳转我的考试
	@RequestMapping("my_exam_m")
	public void to_MyExam(HttpServletRequest request, long user_id, int type, HttpServletResponse response) throws Exception {
		JSONObject result = new JSONObject();
		ExamView examView = new ExamView();
		examView.setUser_id(user_id);
		examView.setExam_type(type);
		List<ExamMobileView> examMobileViews = new ArrayList<ExamMobileView>();
		List<ExamView> examViews = examService.queryMyExam(examView);
		for (ExamView e : examViews) {
			ExamMobileView examMobileView = new ExamMobileView();
			examMobileView.setClass_id(e.getClass_id());
			examMobileView.setCourse_id(e.getCourseId());
			examMobileView.setName(e.getName());
			examMobileView.setTitle(e.getTitle());
			examMobileView.setTime(e.getSubmit_time());
			examMobileView.setCourse_hour_id(e.getCourse_hour_id());
			if (type == 0) {
				examMobileView.setScore(e.getExam_score() + "");
			} else if (type == 1) {
				if (e.getStatus() == 1) {
					examMobileView.setScore("批改中");
				} else if (e.getStatus() == 2) {
					if (e.getGrade() == 0) {
						examMobileView.setScore("优秀");
					} else if (e.getGrade() == 1) {
						examMobileView.setScore("良好");
					} else if (e.getGrade() == 2) {
						examMobileView.setScore("合格");
					} else if (e.getGrade() == 3) {
						examMobileView.setScore("不合格");
					}
				}

			}
			examMobileViews.add(examMobileView);
		}
		result.put("examViews", examMobileViews);
		ResponseUtil.write(response, result);

	}

	// 跳转我的笔记
	@RequestMapping("my_note_m")
	public void to_MyNote(HttpServletRequest request, long user_id, HttpServletResponse response) throws Exception {
		JSONObject result = new JSONObject();
		ExamView examView = new ExamView();
		examView.setUser_id(user_id);
		NoteView view = new NoteView();
		view.setUser_id(user_id);
		List<NoteView> noteViews = courseNoteService.queryMyCourseNote(view);
		List<NoteMobileView> noteMobileViews = new ArrayList<NoteMobileView>();

		for (NoteView n : noteViews) {
			NoteMobileView noteMobileView = new NoteMobileView();
			String title = n.getCourse_title();
			String hour_title = n.getCourse_hour_title();
			String name = n.getNoteContent();
			Date date = n.getNoteTime();
			String time = TimeUtil.dateToString2(date);
			noteMobileView.setTitle(title);
			noteMobileView.setHour_title(hour_title);
			noteMobileView.setName(name);
			noteMobileView.setTime(time);
			noteMobileViews.add(noteMobileView);
		}
		result.put("noteViews", noteMobileViews);
		ResponseUtil.write(response, result);

	}

	// 我的讨论
	@RequestMapping("my_topic_m")
	public void to_MyTopic(HttpServletRequest request, long user_id, HttpServletResponse response) throws Exception {
		JSONObject result = new JSONObject();
		TopicQuestionView topicQuestionView = new TopicQuestionView();
		topicQuestionView.setUser_id(user_id);
		topicQuestionView.setSource_type(0);
		topicQuestionView.setBack(1);
		List<TopicQuestionView> topicQuestionViews = topicQuestionService.queryTopic(topicQuestionView);

		List<TopicQuestionMobileView> topicQuestionMobileViews = new ArrayList<TopicQuestionMobileView>();

		for (TopicQuestionView t : topicQuestionViews) {
			TopicQuestionMobileView topicQuestionMobileView = new TopicQuestionMobileView();
			int watch_times = Integer.parseInt(t.getBrowseNum());
			String name = t.getQuerstionName();
			Course course = courseService.getById(t.getSource_id());
			String title = course.getTitle();
			topicQuestionMobileView.setTitle(title);
			topicQuestionMobileView.setWatch_times(watch_times);
			topicQuestionMobileView.setName(name);
			topicQuestionMobileView.setId(Long.parseLong(t.getQuestionId()));
			topicQuestionMobileViews.add(topicQuestionMobileView);

		}
		result.put("topicViews", topicQuestionMobileViews);
		ResponseUtil.write(response, result);

	}

	@RequestMapping("user_m")
	public void userM(HttpServletRequest request, long user_id, HttpServletResponse response) throws Exception {
		JSONObject result = new JSONObject();
		User user = userService.selectByPrimaryKey(user_id);
		UserInfo userInfo = userInfoService.getByUserId(user_id);
		result.put("id", user_id);
		// 名称
		result.put("username", user.getUsername());
		// 头像
		result.put("icon", user.getIcon());
		// 关注
		result.put("attent", userAttentService.queryTotalAttention(user_id));
		// 粉丝
		result.put("fans", userAttentService.queryTotalFans(user_id));
		// 手机
		result.put("phone", user.getPhone());
		// 姓名
		result.put("truename", userInfo.getTrue_name());
		// 性别
		if (userInfo.getSex() == null) {
			result.put("sex", "");
		} else if (userInfo.getSex() == 0) {
			result.put("sex", "女");
		} else if (userInfo.getSex() == 1) {
			result.put("sex", "男");
		} else {
			result.put("sex", "");
		}
		// 出生日期
		String ID_number = userInfo.getID_number();
		if (ID_number != null && !ID_number.trim().equals("")) {
			StringBuffer sb = new StringBuffer();
			sb.append(ID_number.subSequence(6, 10));
			sb.append("年");
			sb.append(ID_number.subSequence(10, 12));
			sb.append("月");
			sb.append(ID_number.subSequence(12, 14));
			sb.append("日");
			result.put("birthday", new String(sb));
		} else {
			result.put("birthday", "");
		}
		// 个人签名signature
		result.put("signature", userInfo.getSignature());
		// 自我介绍profile
		result.put("profile", userInfo.getProfile());
		ResponseUtil.write(response, result);
	}

	@RequestMapping("collect_m")
	public void collectM(HttpServletRequest request, long user_id, HttpServletResponse response) throws Exception {
		JSONObject result = new JSONObject();

		UserCollectView userCollectView = new UserCollectView();
		userCollectView.setUserId(user_id);
		userCollectView.setSource_type(0);
		List<UserCollectView> userCollectList = userCollectService.queryMyCollect(userCollectView);
		result.put("userCollectList", userCollectList);
		HttpSession session = request.getSession();
		System.out.println(session.getId() + "session_id****************************");
		ResponseUtil.write(response, result);
	}

	@RequestMapping("notice_m")
	public void noticeM(HttpServletRequest request, long user_id, HttpServletResponse response) throws Exception {
		JSONObject result = new JSONObject();
		NotificationView notificationView = new NotificationView();
		notificationView.setUser_id(user_id);
		List<NoticeMoblieView> noticeMoblieViews = new ArrayList<NoticeMoblieView>();
		List<NotificationView> notificationViews = notificationService.queryNotification(notificationView);
		for (NotificationView view : notificationViews) {
			NoticeMoblieView n = new NoticeMoblieView();
			int type = view.getType();
			String msg = null;
			String msg1 = view.getMsg1();
			String msg2 = view.getMsg2();
			String msg3 = view.getMsg3();
			if (view.getSource_type() == 0) {// 课程

			} else if (view.getSource_type() == 1) {// 培训

			}
			String username = view.getOther_username();
			String course_title = view.getCourse_title();
			String question_title = view.getQuestion_title();
			if (type == 1) {
				msg = username + msg1 + course_title + msg2 + question_title;
				view.setMsg(msg);
			} else if (type == 2) {
				msg = msg1 + course_title + msg2 + question_title + msg3;
				view.setMsg(msg);
			} else if (type == 3 || type == 4 || type == 5 || type == 6) {
				view.setMsg(msg1);
			} else if (type == 7 || type == 8) {
				msg = msg1 + username + msg2;
				view.setMsg(msg);
			} else if (type == 9) {
				msg = username + msg1 + question_title + msg2;
				view.setMsg(msg);
			} else if (type == 10 || type == 11 || type == 12 || type == 13 || type == 14 || type == 15) {
				msg = msg1 + question_title + msg2;
				view.setMsg(msg);
			} else if (type == 16) {
				Date date = new Date(view.getNotice_time().getTime() + 86400000);
				SimpleDateFormat formater = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String time = formater.format(date);
				msg = msg1 + course_title + msg2 + time + msg3;
				view.setMsg(msg);
			} else if (type == 17) {
				CourseHour courseHour = courseHourService.getHour(view.getCourse_hour_id() + "");

				String attribute = "";

				if (courseHour.getAttribute_type() == 0) {
					attribute = "考试:";
				}
				if (courseHour.getAttribute_type() == 3) {
					attribute = "研讨:";
				}
				if (courseHour.getAttribute_type() == 4) {
					attribute = "作业:";
				}
				msg = msg1 + course_title + msg2 + attribute + courseHour.getHour_title() + msg3;
				view.setMsg(msg);

			} else if (type == 18) {
				msg = "课程" + course_title + "有试卷需要批阅";
				view.setMsg(msg);
			} else if (type == 19) {

				Train train = trainService.getById(view.getSource_id());
				Course course = courseService.getById(view.getCourse_hour_id());

				msg = msg1 + train.getName() + msg2 + course.getTitle() + msg3;
				view.setMsg(msg);

			}
			Date date = new Date(view.getNotice_time().getTime());
			SimpleDateFormat formater = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			String time = formater.format(date);
			n.setMsg(view.getMsg());
			n.setTime(time);
			noticeMoblieViews.add(n);
		}
		HttpSession session = request.getSession();
		System.out.println(session.getId() + "session_id****************************");
		result.put("noticeViews", noticeMoblieViews);
		ResponseUtil.write(response, result);
	}

	@RequestMapping("search_m")
	public void searchM(HttpServletRequest request, String str, HttpServletResponse response) throws Exception {
		JSONObject result = new JSONObject();
		List<UserCollectView> userCollectList = new ArrayList<UserCollectView>();
		userCollectList = courseService.searchCourceM(str);
		result.put("searchList", userCollectList);
		ResponseUtil.write(response, result);
	}
}