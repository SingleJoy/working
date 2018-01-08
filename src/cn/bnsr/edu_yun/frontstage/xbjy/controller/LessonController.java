package cn.bnsr.edu_yun.frontstage.xbjy.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.backstage.base.service.SubjectService;
import cn.bnsr.edu_yun.frontstage.base.po.PubverList;
import cn.bnsr.edu_yun.frontstage.base.po.SubjectList;
import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.base.po.UserInfo;
import cn.bnsr.edu_yun.frontstage.base.po.UserProperty;
import cn.bnsr.edu_yun.frontstage.base.service.GradeService;
import cn.bnsr.edu_yun.frontstage.base.service.PubverListService;
import cn.bnsr.edu_yun.frontstage.base.service.UserInfoService;
import cn.bnsr.edu_yun.frontstage.base.service.UserService;
import cn.bnsr.edu_yun.frontstage.base.view.UserCenterView;
import cn.bnsr.edu_yun.frontstage.train.po.UserAppraise;
import cn.bnsr.edu_yun.frontstage.train.po.UserCollect;
import cn.bnsr.edu_yun.frontstage.train.service.CommunityService;
import cn.bnsr.edu_yun.frontstage.train.service.StudentRelationService;
import cn.bnsr.edu_yun.frontstage.train.service.UserAppraiseService;
import cn.bnsr.edu_yun.frontstage.train.service.UserCollectService;
import cn.bnsr.edu_yun.frontstage.train.service.WorkshopService;
import cn.bnsr.edu_yun.frontstage.train.view.AppraiseReasonView;
import cn.bnsr.edu_yun.frontstage.train.view.CommunityCenterView;
import cn.bnsr.edu_yun.frontstage.train.view.CommunityView;
import cn.bnsr.edu_yun.frontstage.train.view.StudentRelationView;
import cn.bnsr.edu_yun.frontstage.train.view.UserAppraisView;
import cn.bnsr.edu_yun.frontstage.train.view.WorkshopView;
import cn.bnsr.edu_yun.frontstage.xbjy.po.Lesson;
import cn.bnsr.edu_yun.frontstage.xbjy.service.LessonAssessService;
import cn.bnsr.edu_yun.frontstage.xbjy.service.LessonAttachmentService;
import cn.bnsr.edu_yun.frontstage.xbjy.service.LessonProblemService;
import cn.bnsr.edu_yun.frontstage.xbjy.service.LessonService;
import cn.bnsr.edu_yun.frontstage.xbjy.service.LessonTimeService;
import cn.bnsr.edu_yun.frontstage.xbjy.service.LessonUserIdentityService;
import cn.bnsr.edu_yun.frontstage.xbjy.service.LessonUserTaskService;
import cn.bnsr.edu_yun.frontstage.xbjy.service.ProblemStudyService;
import cn.bnsr.edu_yun.frontstage.xbjy.view.LessonAssessView;
import cn.bnsr.edu_yun.frontstage.xbjy.view.LessonAttachmentView;
import cn.bnsr.edu_yun.frontstage.xbjy.view.LessonProblemView;
import cn.bnsr.edu_yun.frontstage.xbjy.view.LessonTimeView;
import cn.bnsr.edu_yun.frontstage.xbjy.view.LessonUserIdentityView;
import cn.bnsr.edu_yun.frontstage.xbjy.view.LessonUserTaskView;
import cn.bnsr.edu_yun.frontstage.xbjy.view.LessonView;
import cn.bnsr.edu_yun.frontstage.xbjy.view.MemberStatisticsView;
import cn.bnsr.edu_yun.frontstage.xbjy.view.ProblemStudyView;
import cn.bnsr.edu_yun.util.ConfigInfo;
import cn.bnsr.edu_yun.util.ExceptionUtil;
import cn.bnsr.edu_yun.util.NumUtil;
import cn.bnsr.edu_yun.util.ResponseUtil;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/lesson")
public class LessonController {

	private final Logger log = LoggerFactory.getLogger(LessonController.class);

	@Autowired
	private LessonService lessonService;
	@Autowired
	private UserService userService;
	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private LessonUserIdentityService lessonUserIdentityService;
	@Autowired
	private LessonProblemService lessonProblemService;
	@Autowired
	private LessonTimeService lessonTimeService;
	@Autowired
	private LessonUserTaskService lessonUserTaskService;
	@Autowired
	private GradeService gradeService;
	@Autowired
	private SubjectService subjectService;
	@Autowired
	private PubverListService pubverListService;
	@Autowired
	private ProblemStudyService problemStudyService;
	@Autowired
	private LessonAttachmentService lessonAttachmentService;
	@Autowired
	private LessonAssessService lessonAssessService;
	@Autowired
	private UserAppraiseService userAppraiseService;
	@Autowired
	private CommunityService communityService;
	@Autowired
	private WorkshopService workshopService;
	@Autowired
	private StudentRelationService studentRelationService;
	@Autowired
	private UserCollectService userCollectService;

	/**
	 * 跳转课程管理页面(在教课程)
	 */
	@RequestMapping("/to_lesson")
	public ModelAndView toLessonn(HttpServletRequest request, LessonView lessonView) {
		User user = (User) request.getSession().getAttribute("currentUser");
		ModelAndView modelAndView = new ModelAndView();
		try {
			// 改为在社区进入时，看社区下所有工作坊的课例
			lessonView.setUser_id(user.getId());
			lessonView.setRows(10);
			String search = "";          
			if (lessonView.getSearch() != null) {
				search = lessonView.getSearch();
				lessonView.setSearch("%" + search + "%");
			}
			if (lessonView.getSort() != null && lessonView.getSort().equals("")) {
				lessonView.setSort(null);
			}
			if (lessonView.getOrder() != null && lessonView.getOrder().equals("")) {
				lessonView.setOrder(null);
			}
			if (lessonView.getPage() == 0) {
				lessonView.setStartLine(0);
			} else {
				lessonView.setStartLine(lessonView.getPage() * lessonView.getRows());
			}
			int total = 0;
			List<LessonView> lessonList = null;
			if (lessonView.getSource_type() == 0) {
				CommunityView communityView = communityService.getById(lessonView.getCommunity_id());
				communityView.setStamp(2);
				modelAndView.addObject("communityView", communityView);
				CommunityCenterView communityCenterView = new CommunityCenterView();
				communityCenterView.setId(lessonView.getCommunity_id());
				communityCenterView.setSearch(lessonView.getSearch());
				communityCenterView.setSort(lessonView.getSort());
				communityCenterView.setOrder(lessonView.getOrder());
				communityCenterView.setStartLine(lessonView.getStartLine());
				communityCenterView.setRows(lessonView.getRows());
				lessonList = lessonService.queryCommunityLesson(communityCenterView);
				total = lessonService.queryTotalCommunityLesson(communityCenterView);
				modelAndView.addObject("head_title", "社区课例");
			} else {
				WorkshopView workshopView = workshopService.showWorkshopById(lessonView.getWorkshop_id());
				workshopView.setStamp(2);
				modelAndView.addObject("workshopView", workshopView);
				lessonList = lessonService.queryLesson(lessonView);
				total = lessonService.queryTotalLesson(lessonView);// 课程总数
				modelAndView.addObject("head_title", "工作坊课例");
			}

			lessonView.setTotal(total);
			// 分页总页数
			lessonView.setTotalPage(NumUtil.totalPage(total, lessonView.getRows()));
			lessonView.setSearch(search);
			modelAndView.addObject("lessonList", lessonList);
			modelAndView.addObject("lessonView", lessonView);

			long user_propertyId = user.getProperty_id();
			UserProperty userProperty = userService.selectUserPropertyById(user_propertyId);
			UserInfo userInfo = userInfoService.getByUserId(user.getId());
			request.setAttribute("user", user);
			request.setAttribute("userProperty", userProperty);
			request.setAttribute("userInfo", userInfo);

			modelAndView.setViewName("frontstage/xbjy/lesson/lesson");
		} catch (Exception e) {
			log.error("课例列表查询失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}
		return modelAndView;
	}

	/**
	 * 跳转课程列表
	 */
	@RequestMapping("/to_lesson_list")
	public ModelAndView toLessonList(HttpServletRequest request, LessonView lessonView) {
		ModelAndView modelAndView = new ModelAndView();
		try {
			lessonView.setRows(6);
			if (lessonView.getPage() == 0) {
				lessonView.setStartLine(0);
			} else {
				lessonView.setStartLine(lessonView.getPage() * lessonView.getRows());
			}
			List<LessonView> lessonList = lessonService.queryLesson(lessonView);
			int total = lessonService.queryTotalLesson(lessonView);// 课程总数
			lessonView.setTotal(total);
			// 分页总页数
			lessonView.setTotalPage(NumUtil.totalPage(total, lessonView.getRows()));

			modelAndView.addObject("lessonList", lessonList);
			modelAndView.addObject("lessonView", lessonView);

			modelAndView.setViewName("frontstage/xbjy/lesson/lesson_list_show");
		} catch (Exception e) {
			log.error("课例列表查询失败", ExceptionUtil.getExceptionMessage(e));
		}

		return modelAndView;
	}

	/**
	 * 跳转创建课例页面 以后可能需要更改取得用户list的方法，目前与班级取得助教条件一致
	 */
	@RequestMapping("/to_create_lesson")
	public ModelAndView toCreateLesson(HttpServletRequest request, StudentRelationView teacherView) {
		ModelAndView modelAndView = new ModelAndView();
		WorkshopView workshopView = workshopService.showWorkshopById(teacherView.getSource_id());
		workshopView.setStamp(2);
		modelAndView.addObject("workshopView", workshopView);
		String checkedIds = request.getParameter("checkedIds");
		teacherView.setSource_type(1);
		teacherView.setRows(10);
		if (teacherView.getPage() == 0) {
			teacherView.setStartLine(0);
		} else {
			teacherView.setStartLine(teacherView.getPage() * teacherView.getRows());
		}
		Integer total = studentRelationService.countStudent(teacherView);
		teacherView.setTotal(total);
		// 分页总数
		teacherView.setTotalPage(NumUtil.totalPage(total, teacherView.getRows()));
		List<StudentRelationView> teacherViews = studentRelationService.findAll(teacherView);
		String type = request.getParameter("type");
		request.setAttribute("type", type);
		request.setAttribute("userList", teacherViews);
		request.setAttribute("teacherView", teacherView);
		request.setAttribute("checkedIds", checkedIds);
		modelAndView.addObject("head_title", "创建课例");
		modelAndView.setViewName("frontstage/xbjy/lesson/create_lesson");
		return modelAndView;
	}

	/**
	 * 保存课例后设置用户身份
	 */
	@RequestMapping("/save_lesson")
	public ModelAndView SaveLesson(HttpServletRequest request, LessonView lessonView, LessonUserIdentityView lessonUserIdentityView) {
		User user = (User) request.getSession().getAttribute("currentUser");
		String arr[] = request.getParameterValues("boxes");
		/***********
		 * 分页功能 String arr1[] = request.getParameterValues("checkedId"); String
		 * arr2 = request.getParameter("checkedId"); arr2 = arr2.substring(0,
		 * arr2.length()-1); String [] stringArr= arr2.split(",");
		 *************/
		for (int i = 0; i < arr.length; i++) {
			System.out.println(arr[i]);
		}
		lessonView.setUser_id(user.getId());
		lessonService.saveLesson(lessonView);

		// 取得刚刚自增的课例主键
		lessonUserIdentityView.setLesson_id(lessonView.getId());
		lessonUserIdentityView.setIdentity(3);

		// 将选中用户插入用户身份表
		for (int i = 0; i < arr.length; i++) {
			lessonUserIdentityView.setUser_id(Long.parseLong(arr[i]));

			lessonUserIdentityService.saveAll(lessonUserIdentityView);
		}
		// lessonUserIdentityView.setIdentity(-1);
		// List<LessonUserIdentityView> lessonUserIdentityViews =
		// lessonUserIdentityService.findTeacher(lessonUserIdentityView);
		// request.setAttribute("userList", lessonUserIdentityViews);
		// request.setAttribute("lesson_id", lid.getId());

		String redirectStr = "redirect:/lesson/to_lesson_user_identity.action?lesson_id=" + lessonView.getId();
		return new ModelAndView(redirectStr);
	}

	/**
	 * 跳转到身份设置页面
	 */
	@RequestMapping("/to_lesson_user_identity")
	public ModelAndView toLessonUserIdentity(HttpServletRequest request, LessonUserIdentityView lessonUserIdentityView) {
		ModelAndView modelAndView = new ModelAndView();
		Lesson lesson = lessonService.getById(lessonUserIdentityView.getLesson_id());
		WorkshopView workshopView = workshopService.showWorkshopById(lesson.getWorkshop_id());
		workshopView.setStamp(2);
		modelAndView.addObject("workshopView", workshopView);
		lessonUserIdentityView.setIdentity(-1);
		List<LessonUserIdentityView> lessonUserIdentityViews = lessonUserIdentityService.findTeacher(lessonUserIdentityView);
		request.setAttribute("userList", lessonUserIdentityViews);
		request.setAttribute("lesson", lesson);
		modelAndView.setViewName("frontstage/xbjy/lesson/lesson_user_identity");
		modelAndView.addObject("head_title", "选择组员身份");
		return modelAndView;
	}

	/****
	 * 新增用户之后做
	 * 
	 * @RequestMapping("/to_lesson_add_user") public ModelAndView
	 *                                        toLessonAddUser(HttpServletRequest
	 *                                        request, LessonTeacherView
	 *                                        teacherView){ ModelAndView
	 *                                        modelAndView = new ModelAndView();
	 *                                        User user = (User)
	 *                                        request.getSession
	 *                                        ().getAttribute("currentUser");
	 *                                        String titles =
	 *                                        request.getParameter("titles");
	 *                                        teacherView.setTitles(titles);
	 *                                        teacherView
	 *                                        .setUser_id(user.getId());
	 *                                        teacherView.setRows(5); if
	 *                                        (teacherView.getPage() == 0) {
	 *                                        teacherView.setStartLine(0); }
	 *                                        else {
	 *                                        teacherView.setStartLine(teacherView
	 *                                        .getPage() *
	 *                                        teacherView.getRows()); } Integer
	 *                                        total =
	 *                                        userInfoService.countTeacher
	 *                                        (teacherView);
	 *                                        teacherView.setTotal(total); //
	 *                                        分页总数
	 *                                        teacherView.setTotalPage(NumUtil
	 *                                        .totalPage(total,
	 *                                        teacherView.getRows()));
	 *                                        List<LessonTeacherView>
	 *                                        teacherViews =
	 *                                        userInfoService.findTeacher
	 *                                        (teacherView);
	 * 
	 *                                        List<String> titlelist =
	 *                                        userInfoService
	 *                                        .findTitles(user.getId()); String
	 *                                        lesson_id =
	 *                                        request.getParameter("lesson_id");
	 *                                        request.setAttribute("lesson_id",
	 *                                        lesson_id);
	 *                                        request.setAttribute("userList",
	 *                                        teacherViews);
	 * 
	 *                                        modelAndView.setViewName(
	 *                                        "frontstage/xbjy/lesson/lesson_add_user"
	 *                                        ); return modelAndView; }
	 * @RequestMapping("/save_lesson_add_user") public ModelAndView
	 *                                          SaveLessonAddUser
	 *                                          (HttpServletRequest request,
	 *                                          LessonView lessonView,
	 *                                          LessonUserIdentityView
	 *                                          lessonUserIdentityView){ // User
	 *                                          user = (User)
	 *                                          request.getSession(
	 *                                          ).getAttribute("currentUser");
	 *                                          String arr[] =
	 *                                          request.getParameterValues
	 *                                          ("boxes"); for(int i =
	 *                                          0;i<arr.length;i++){
	 *                                          System.out.println(arr[i]); }
	 *                                          System.out.println(arr[i]);
	 *                                          //取得刚刚自增的课例主键 LessonView lid =
	 *                                          lessonService
	 *                                          .findPK(user.getId());
	 *                                          System.out.println(lid.getId());
	 *                                          System.out.println(lid);
	 * 
	 *                                          lessonUserIdentityView.
	 *                                          setLesson_id(lid.getId());
	 *                                          lessonUserIdentityView
	 *                                          .setIdentity(3);
	 * 
	 *                                          //将选中用户插入用户身份表 for(int i =
	 *                                          0;i<arr.length;i++){
	 *                                          lessonUserIdentityView
	 *                                          .setUser_id
	 *                                          (Long.parseLong(arr[i]));
	 * 
	 *                                          lessonUserIdentityService.
	 *                                          saveAll(lessonUserIdentityView);
	 *                                          } List<LessonUserIdentityView>
	 *                                          lessonUserIdentityViews =
	 *                                          lessonUserIdentityService
	 *                                          .findTeacher
	 *                                          (lessonUserIdentityView);
	 *                                          request.setAttribute("userList",
	 *                                          lessonUserIdentityViews);
	 *                                          request
	 *                                          .setAttribute("lesson_id",
	 *                                          lid.getId());
	 * 
	 * 
	 *                                          String redirectStr =
	 *                                          "redirect:/lesson/to_lesson_user_identity.action?lesson_id="
	 *                                          + lid.getId(); return new
	 *                                          ModelAndView(redirectStr); }
	 ****/

	/**
	 * 跳转到计划设置页面
	 */
	@RequestMapping("/to_lesson_plan")
	public ModelAndView toLessonPlan(HttpServletRequest request, LessonView lessonView) {
		ModelAndView modelAndView = new ModelAndView();
		User user = (User) request.getSession().getAttribute("currentUser");

		String id = request.getParameter("lesson_id");
		lessonView.setId(Long.parseLong(id));
		Lesson lesson = new Lesson();
		LessonUserIdentityView lessonUserIdentityView = new LessonUserIdentityView();
		LessonProblemView lessonProblemView = new LessonProblemView();
		LessonTimeView lessonTimeView = new LessonTimeView();
		LessonUserTaskView lessonUserTaskView = new LessonUserTaskView();

		// 根据主键查询课例信息
		lesson = lessonService.getById(lessonView.getId());

		lessonUserTaskView.setLesson_id(lessonView.getId());

		lessonUserIdentityView.setLesson_id(lessonView.getId());

		// 得到全部用户被分配的任务
		List<LessonUserTaskView> lessonUserTasks = lessonUserTaskService.findUserByLesson(lessonUserTaskView);

		// 得到其他相关信息
		lessonProblemView = lessonProblemService.findByLesson(lessonView.getId());
		lessonTimeView = lessonTimeService.findByLesson(lessonView.getId());
		List<SubjectList> subjectList = new ArrayList();
		List<PubverList> pubverList = new ArrayList();
		if (lesson.getStage_id() != null && !lesson.getStage_id().equals("")) {
			subjectList = subjectService.selectByPid(lesson.getStage_id());
		}
		if (lesson.getSubject_id() != null && !lesson.getSubject_id().equals("")) {
			pubverList = pubverListService.queryPubver(lesson.getSubject_id());
		}

		request.setAttribute("lesson", lesson);
		request.setAttribute("lessonProblemView", lessonProblemView);
		request.setAttribute("lessonTimeView", lessonTimeView);
		request.setAttribute("subjectList", subjectList);
		request.setAttribute("gradeList", gradeService.selectGrade());
		request.setAttribute("editionList", pubverList);
		request.setAttribute("lessonUserTaskList", lessonUserTasks);

		// 获取课例头部统计信息
		request.setAttribute("lessonHead", lessonUserIdentityService.getLessonHead(lessonView.getId()));
		// 获取左侧权限部分信息
		request.setAttribute("lessonLeft", lessonUserIdentityService.getLessonLeft(lessonView.getId(), user));

		// 左侧选中状态
		String state = request.getParameter("state");
		String stamp = request.getParameter("stamp");
		request.setAttribute("state", state);
		request.setAttribute("stamp", stamp);
		modelAndView.addObject("head_title", "制定计划");
		if (user != null) {
			boolean flag = true;// 权限
			String show = request.getParameter("show");
			if (show != null && !show.equals("")) {
				flag = false;
			}
			lessonUserIdentityView.setIdentity(0);
			List<LessonUserIdentityView> lessonUserIdentityZzs = lessonUserIdentityService.findUserByIdentity(lessonUserIdentityView);
			if (lessonUserIdentityZzs != null && lessonUserIdentityZzs.size() > 0) {
				// 登录用户是否为组长
				if (lessonUserIdentityZzs.get(0).getUser_id() != user.getId()) {
					flag = false;
				}
			} else {
				flag = false;
			}
			/****
			 * 时间限制 if(lessonTimeView!=null){ Date start =
			 * lessonTimeView.getPlan_sta(); Date end =
			 * lessonTimeView.getPlan_end(); Date date = new Date(); if
			 * (date.getTime() < start.getTime() || date.getTime() >
			 * (end.getTime()+24*60*60*1000)) { flag = false; } }
			 ****/
			// 如果课例完成，那么不可再编辑计划
			//if (lesson.getStatus() == 2) {
			//	flag = false;
		//	}
			if (flag) {
				modelAndView.setViewName("frontstage/xbjy/lesson/make_new_plan");
			} else {
				modelAndView.setViewName("frontstage/xbjy/lesson/lesson_plan_show");
			}
		} else {
			modelAndView.setViewName("frontstage/xbjy/lesson/lesson_plan_show");
		}
		return modelAndView;
	}

	// 展示课例所有组员
	@RequestMapping("/show_teacher")
	@ResponseBody
	public String showTeacher(HttpServletRequest request, HttpServletResponse response, LessonUserIdentityView lessonUserIdentityView) {
		try {
			JSONObject result = new JSONObject();

			// 上课老师只能从组员中选取，被分配任务的人员可能是任何身份
			// String mark =request.getParameter("mark");
			// if(mark.equals("0")){
			// lessonUserIdentityView.setIdentity(3);
			// }else{
			// lessonUserIdentityView.setIdentity(-1);
			// }
			// List<LessonUserIdentityView> lessonUserIdentityZzs
			// =lessonUserIdentityService.findTeacher(lessonUserIdentityView);

			// 指导老师不可被分配任务
			List<LessonUserIdentityView> lessonUserIdentityZzs = lessonUserIdentityService.findTeacherNozd(lessonUserIdentityView);
			result.element("lessonUserIdentityZzs", lessonUserIdentityZzs);
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			e.printStackTrace();
			log.error("跳转失败", ExceptionUtil.getExceptionMessage(e));
		}
		return null;
	}

	/**
	 * 保存课例计划
	 */
	@RequestMapping("/save_lesson_plan")
	public ModelAndView SaveLessonPlan(HttpServletRequest request, LessonView lessonView, LessonUserIdentityView lessonUserIdentityView,
			LessonProblemView lessonProblemView, LessonTimeView lessonTimeView, LessonUserTaskView lessonUserTaskView) {
		User user = (User) request.getSession().getAttribute("currentUser");
		lessonView.setId(lessonUserIdentityView.getLesson_id());
		String user_id0 = request.getParameter("user_id0");
		String user_name0 = request.getParameter("user_name0");
		String[] user_id103 = request.getParameterValues("user_id103");
		String[] user_id201 = request.getParameterValues("user_id201");
		String[] user_id202 = request.getParameterValues("user_id202");
		String[] user_id203 = request.getParameterValues("user_id203");
		String[] user_id301 = request.getParameterValues("user_id301");
		String[] user_id302 = request.getParameterValues("user_id302");
		String[] user_id303 = request.getParameterValues("user_id303");
		String[] user_id401 = request.getParameterValues("user_id401");
		String[] user_id402 = request.getParameterValues("user_id402");
		String[] user_id403 = request.getParameterValues("user_id403");
		String[] user_id501 = request.getParameterValues("user_id501");
		LessonUserTaskView lessonUserTaskViewOld = null;

		// 分配上课老师的权限，如果已存在则跳过
		lessonUserTaskView.setPurview(204);
		lessonUserTaskView.setUser_id(Long.parseLong(user_id0));
		lessonUserTaskViewOld = lessonUserTaskService.findByLUP(lessonUserTaskView);
		if (lessonUserTaskViewOld == null) {
			lessonUserTaskService.saveAll(lessonUserTaskView);
			lessonUserTaskView.setPurview(102);
			lessonUserTaskService.saveAll(lessonUserTaskView);
			lessonUserTaskView.setPurview(304);
			lessonUserTaskService.saveAll(lessonUserTaskView);
			lessonUserTaskView.setPurview(502);
			lessonUserTaskService.saveAll(lessonUserTaskView);
		}
		lessonUserTaskViewOld = null;

		// 是否已经存在课例问题，如果存在则更新，不存在则新建
		LessonProblemView lessonProblemViewOld = lessonProblemService.findByLesson(lessonProblemView.getLesson_id());

		if (lessonProblemViewOld != null) {
			lessonProblemService.updateByLesssonId(lessonProblemView);
		} else {
			lessonProblemService.saveAll(lessonProblemView);
		}

		// 是否已经存在课例时间，如果存在则更新，不存在则新建
		LessonTimeView lessonTimeViewOld = lessonTimeService.findByLesson(lessonTimeView.getLesson_id());

		if (lessonTimeViewOld != null) {
			lessonTimeService.updateByLesssonId(lessonTimeView);
		} else {
			lessonTimeService.saveAll(lessonTimeView);
		}

		// 分配用户任务
		if (user_id103 != null) {
			for (int i = 0; i < user_id103.length; i++) {
				lessonUserTaskView.setPurview(103);
				lessonUserTaskView.setUser_id(Long.parseLong(user_id103[i]));
				lessonUserTaskViewOld = lessonUserTaskService.findByLUP(lessonUserTaskView);
				if (lessonUserTaskViewOld == null) {
					lessonUserTaskService.saveAll(lessonUserTaskView);
				}
				lessonUserTaskViewOld = null;
			}
		}
		if (user_id201 != null) {
			for (int i = 0; i < user_id201.length; i++) {
				lessonUserTaskView.setPurview(201);
				lessonUserTaskView.setUser_id(Long.parseLong(user_id201[i]));
				lessonUserTaskViewOld = lessonUserTaskService.findByLUP(lessonUserTaskView);
				if (lessonUserTaskViewOld == null) {
					lessonUserTaskService.saveAll(lessonUserTaskView);
				}
				lessonUserTaskViewOld = null;
			}
		}
		if (user_id202 != null) {
			for (int i = 0; i < user_id202.length; i++) {
				lessonUserTaskView.setPurview(202);
				lessonUserTaskView.setUser_id(Long.parseLong(user_id202[i]));
				lessonUserTaskViewOld = lessonUserTaskService.findByLUP(lessonUserTaskView);
				if (lessonUserTaskViewOld == null) {
					lessonUserTaskService.saveAll(lessonUserTaskView);
				}
				lessonUserTaskViewOld = null;
			}
		}
		if (user_id203 != null) {
			for (int i = 0; i < user_id203.length; i++) {
				lessonUserTaskView.setPurview(203);
				lessonUserTaskView.setUser_id(Long.parseLong(user_id203[i]));
				lessonUserTaskViewOld = lessonUserTaskService.findByLUP(lessonUserTaskView);
				if (lessonUserTaskViewOld == null) {
					lessonUserTaskService.saveAll(lessonUserTaskView);
				}
				lessonUserTaskViewOld = null;
			}
		}
		if (user_id301 != null) {
			for (int i = 0; i < user_id301.length; i++) {
				lessonUserTaskView.setPurview(301);
				lessonUserTaskView.setUser_id(Long.parseLong(user_id301[i]));
				lessonUserTaskViewOld = lessonUserTaskService.findByLUP(lessonUserTaskView);
				if (lessonUserTaskViewOld == null) {
					lessonUserTaskService.saveAll(lessonUserTaskView);
				}
				lessonUserTaskViewOld = null;
			}
		}
		if (user_id302 != null) {
			for (int i = 0; i < user_id302.length; i++) {
				lessonUserTaskView.setPurview(302);
				lessonUserTaskView.setUser_id(Long.parseLong(user_id302[i]));
				lessonUserTaskViewOld = lessonUserTaskService.findByLUP(lessonUserTaskView);
				if (lessonUserTaskViewOld == null) {
					lessonUserTaskService.saveAll(lessonUserTaskView);
				}
				lessonUserTaskViewOld = null;
			}
		}
		if (user_id303 != null) {
			for (int i = 0; i < user_id303.length; i++) {
				lessonUserTaskView.setPurview(303);
				lessonUserTaskView.setUser_id(Long.parseLong(user_id303[i]));
				lessonUserTaskViewOld = lessonUserTaskService.findByLUP(lessonUserTaskView);
				if (lessonUserTaskViewOld == null) {
					lessonUserTaskService.saveAll(lessonUserTaskView);
				}
				lessonUserTaskViewOld = null;
			}
		}
		if (user_id401 != null) {
			for (int i = 0; i < user_id401.length; i++) {
				lessonUserTaskView.setPurview(401);
				lessonUserTaskView.setUser_id(Long.parseLong(user_id401[i]));
				lessonUserTaskViewOld = lessonUserTaskService.findByLUP(lessonUserTaskView);
				if (lessonUserTaskViewOld == null) {
					lessonUserTaskService.saveAll(lessonUserTaskView);
				}
				lessonUserTaskViewOld = null;
			}
		}
		if (user_id402 != null) {
			for (int i = 0; i < user_id402.length; i++) {
				lessonUserTaskView.setPurview(402);
				lessonUserTaskView.setUser_id(Long.parseLong(user_id402[i]));
				lessonUserTaskViewOld = lessonUserTaskService.findByLUP(lessonUserTaskView);
				if (lessonUserTaskViewOld == null) {
					lessonUserTaskService.saveAll(lessonUserTaskView);
				}
				lessonUserTaskViewOld = null;
			}
		}
		if (user_id403 != null) {
			for (int i = 0; i < user_id403.length; i++) {
				lessonUserTaskView.setPurview(403);
				lessonUserTaskView.setUser_id(Long.parseLong(user_id403[i]));
				lessonUserTaskViewOld = lessonUserTaskService.findByLUP(lessonUserTaskView);
				if (lessonUserTaskViewOld == null) {
					lessonUserTaskService.saveAll(lessonUserTaskView);
				}
				lessonUserTaskViewOld = null;
			}
		}
		if (user_id501 != null) {
			for (int i = 0; i < user_id501.length; i++) {
				lessonUserTaskView.setPurview(501);
				lessonUserTaskView.setUser_id(Long.parseLong(user_id501[i]));
				lessonUserTaskViewOld = lessonUserTaskService.findByLUP(lessonUserTaskView);
				if (lessonUserTaskViewOld == null) {
					lessonUserTaskService.saveAll(lessonUserTaskView);
				}
				lessonUserTaskViewOld = null;
			}
		}
		// 组长制定计划任务完成
		lessonUserIdentityView.setIdentity(0);
		List<LessonUserIdentityView> lessonUserIdentityZz = lessonUserIdentityService.findTeacher(lessonUserIdentityView);
		lessonUserTaskView.setPurview(101);
		lessonUserTaskView.setUser_id(lessonUserIdentityZz.get(0).getUser_id());
		lessonUserTaskViewOld = lessonUserTaskService.findByLUP(lessonUserTaskView);
		if (lessonUserTaskViewOld == null) {
			lessonUserTaskView.setStatus(2);
			lessonUserTaskService.saveAll(lessonUserTaskView);
			lessonUserTaskView.setStatus(0);
			lessonUserTaskView.setPurview(503);
			lessonUserTaskService.saveAll(lessonUserTaskView);
		}
		lessonUserTaskViewOld = null;

		// 更新课例状态
		lessonView.setStatus(1);
		lessonView.setUser_sk(Long.parseLong(user_id0));
		lessonView.setUser_sk_name(user_name0);
		lessonService.saveLesson(lessonView);
		String redirectStr = "redirect:/lesson/to_lesson_plan.action?lesson_id=" + lessonView.getId() + "&show=1&stamp=0&state=101";
		return new ModelAndView(redirectStr);
	}

	/**
	 * 保存课例图片
	 */
	@RequestMapping("/upload_img")
	public void upload(@RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String path = request.getSession().getServletContext().getRealPath(ConfigInfo.getString("lessonPicture"));
		Date date = new Date();
		long time = date.getTime();
		String fileName = "img" + time;
		String format = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
		Random ra = new Random();
		fileName = fileName + ra.nextInt(10) + format;
		File targetFile = new File(path, fileName);
		if (!targetFile.exists()) {
			targetFile.mkdirs();
		}
		// 保存
		try {
			file.transferTo(targetFile);
		} catch (Exception e) {
			e.printStackTrace();
		}
		JSONObject result = new JSONObject();
		result.put("fileName", ConfigInfo.getString("lessonPicture") + "/" + fileName);
		ResponseUtil.write(response, result);

	}

	/**
	 * 跳转到全组完成情况页面
	 */
	@RequestMapping("/to_all_statistics")
	public ModelAndView toAllStatistics(HttpServletRequest request, LessonView lessonView) {
		ModelAndView modelAndView = new ModelAndView();
		User user = (User) request.getSession().getAttribute("currentUser");

		String id = request.getParameter("lesson_id");
		lessonView.setId(Long.parseLong(id));
		Lesson lesson = new Lesson();
		LessonUserTaskView lessonUserTaskView = new LessonUserTaskView();
		LessonTimeView lessonTimeView = new LessonTimeView();

		// 根据主键查询课例信息
		lesson = lessonService.getById(lessonView.getId());

		lessonUserTaskView.setLesson_id(lessonView.getId());

		// 得到全部用户被分配的任务
		List<LessonUserTaskView> lessonUserTasks = lessonUserTaskService.findUserByLesson(lessonUserTaskView);

		// 得到时间
		lessonTimeView = lessonTimeService.findByLesson(lessonView.getId());

		request.setAttribute("lesson", lesson);
		request.setAttribute("lessonUserTaskList", lessonUserTasks);

		// 获取课例头部统计信息
		request.setAttribute("lessonHead", lessonUserIdentityService.getLessonHead(lessonView.getId()));
		// 获取左侧权限部分信息
		request.setAttribute("lessonLeft", lessonUserIdentityService.getLessonLeft(lessonView.getId(), user));

		// 左侧选中状态
		String state = request.getParameter("state");
		String stamp = request.getParameter("stamp");
		request.setAttribute("state", state);
		request.setAttribute("stamp", stamp);
		modelAndView.addObject("head_title", "全组完成情况");
		request.setAttribute("lessonTimeView", lessonTimeView);
		modelAndView.setViewName("frontstage/xbjy/lesson/all_statistics");
		return modelAndView;
	}

	/**
	 * 跳转到成员统计页面
	 */
	@RequestMapping("/to_member_statistics")
	public ModelAndView toMemberStatistics(HttpServletRequest request, LessonView lessonView) {
		ModelAndView modelAndView = new ModelAndView();
		User user = (User) request.getSession().getAttribute("currentUser");

		String id = request.getParameter("lesson_id");
		lessonView.setId(Long.parseLong(id));
		Lesson lesson = new Lesson();
		LessonUserIdentityView lessonUserIdentityView = new LessonUserIdentityView();
		LessonUserTaskView lessonUserTaskView = new LessonUserTaskView();
		ProblemStudyView problemStudyView = new ProblemStudyView();
		LessonAttachmentView lessonAttachmentView = new LessonAttachmentView();

		// 根据主键查询课例信息
		lesson = lessonService.getById(lessonView.getId());

		lessonUserTaskView.setLesson_id(lessonView.getId());

		problemStudyView.setLesson_id(lessonView.getId());

		lessonAttachmentView.setLesson_id(lessonView.getId());

		lessonUserIdentityView.setLesson_id(lessonView.getId());
		lessonUserIdentityView.setIdentity(-1);
		// 不管身份得到所有组员信息
		List<LessonUserIdentityView> lessonUserIdentitys = lessonUserIdentityService.findTeacher(lessonUserIdentityView);

		// 成员统计页面需要信息
		List<MemberStatisticsView> memberStatisticsList = new ArrayList();

		for (int i = 0; i < lessonUserIdentitys.size(); i++) {
			MemberStatisticsView memberStatisticsView = new MemberStatisticsView();
			if(lessonUserIdentitys.get(i).getTrue_name()!=null){
			memberStatisticsView.setTrue_name(lessonUserIdentitys.get(i).getTrue_name());
			}else{
			memberStatisticsView.setTrue_name(lessonUserIdentitys.get(i).getUser_name());
			}
			lessonUserTaskView.setUser_id(lessonUserIdentitys.get(i).getUser_id());
			lessonUserTaskView.setStatus(-1);
			memberStatisticsView.setTaskTotal(lessonUserTaskService.countTask(lessonUserTaskView));

			lessonUserTaskView.setStatus(2);
			memberStatisticsView.setAccomplishedTotal(lessonUserTaskService.countTask(lessonUserTaskView));
			lessonAttachmentView.setUser_id(lessonUserIdentitys.get(i).getUser_id());
			lessonAttachmentView.setPurview(-1);
			memberStatisticsView.setArticleTotal(lessonAttachmentService.countAttachment(lessonAttachmentView));

			problemStudyView.setUser_id(lessonUserIdentitys.get(i).getUser_id());
			problemStudyView.setPurview(-1);
			memberStatisticsView.setProblemTotal(problemStudyService.countDiscussion(problemStudyView));

			memberStatisticsList.add(memberStatisticsView);
		}

		request.setAttribute("lesson", lesson);
		// 获取课例头部统计信息
		request.setAttribute("lessonHead", lessonUserIdentityService.getLessonHead(lessonView.getId()));
		// 获取左侧权限部分信息
		request.setAttribute("lessonLeft", lessonUserIdentityService.getLessonLeft(lessonView.getId(), user));

		// 左侧选中状态
		String state = request.getParameter("state");
		String stamp = request.getParameter("stamp");
		request.setAttribute("state", state);
		request.setAttribute("stamp", stamp);
		modelAndView.addObject("head_title", "成员统计");
		request.setAttribute("memberStatisticsList", memberStatisticsList);
		modelAndView.setViewName("frontstage/xbjy/lesson/member_statistics");
		return modelAndView;
	}

	/**
	 * 跳转到课例评价页面
	 */
	@RequestMapping("/to_lesson_evaluation")
	public ModelAndView toLessonEvaluation(HttpServletRequest request, LessonView lessonView) {
		ModelAndView modelAndView = new ModelAndView();
		User user = (User) request.getSession().getAttribute("currentUser");

		String id = request.getParameter("lesson_id");
		lessonView.setId(Long.parseLong(id));
		Lesson lesson = new Lesson();
		LessonAttachmentView lessonAttachmentView = new LessonAttachmentView();

		// 根据主键查询课例信息
		lesson = lessonService.getById(lessonView.getId());

		lessonAttachmentView.setLesson_id(lessonView.getId());

		// 课例管理评价页面需要的参数
		LessonAssessView lessonAssessView = new LessonAssessView();
		lessonAssessView.setUser_id(-1);
		lessonAssessView.setLesson_id(lessonView.getId());
		List<LessonAssessView> lessonAssessList = lessonAssessService.findAssess(lessonAssessView);

		List<LessonAttachmentView> lessonAttachmentList = lessonAttachmentService.selectAllFile(lessonAttachmentView);

		request.setAttribute("lesson", lesson);

		// 获取课例头部统计信息
		request.setAttribute("lessonHead", lessonUserIdentityService.getLessonHead(lessonView.getId()));
		// 获取左侧权限部分信息
		request.setAttribute("lessonLeft", lessonUserIdentityService.getLessonLeft(lessonView.getId(), user));
		// 左侧选中状态
		String state = request.getParameter("state");
		String stamp = request.getParameter("stamp");
		request.setAttribute("state", state);
		request.setAttribute("stamp", stamp);

		request.setAttribute("lessonAssessList", lessonAssessList);
		request.setAttribute("lessonAttachmentList", lessonAttachmentList);

		modelAndView.setViewName("frontstage/xbjy/lesson/lesson_evaluation");
		return modelAndView;
	}

	/**
	 * 跳转到课例评价管理页面
	 */
	@RequestMapping("/to_lesson_evaluation_manage")
	public ModelAndView toLessonEvaluationManage(HttpServletRequest request, LessonView lessonView) {
		ModelAndView modelAndView = new ModelAndView();
		User user = (User) request.getSession().getAttribute("currentUser");

		String id = request.getParameter("lesson_id");
		lessonView.setId(Long.parseLong(id));
		Lesson lesson = new Lesson();

		// 根据主键查询课例信息
		lesson = lessonService.getById(lessonView.getId());

		// 课例管理评价页面需要的参数
		LessonAssessView lessonAssessView = new LessonAssessView();
		lessonAssessView.setUser_id(-1);
		lessonAssessView.setLesson_id(lessonView.getId());
		List<LessonAssessView> lessonAssessList = lessonAssessService.findAssess(lessonAssessView);

		request.setAttribute("lesson", lesson);

		// 获取课例头部统计信息
		request.setAttribute("lessonHead", lessonUserIdentityService.getLessonHead(lessonView.getId()));
		// 获取左侧权限部分信息
		request.setAttribute("lessonLeft", lessonUserIdentityService.getLessonLeft(lessonView.getId(), user));
		// 左侧选中状态
		String state = request.getParameter("state");
		String stamp = request.getParameter("stamp");
		request.setAttribute("state", state);
		request.setAttribute("stamp", stamp);

		request.setAttribute("lessonAssessList", lessonAssessList);
		request.setAttribute("user", user);
		modelAndView.addObject("head_title", "查看课例评价");
		String show = request.getParameter("show");
		if (show != null && !show.equals("")) {
			modelAndView.setViewName("frontstage/xbjy/lesson/lesson_evaluation_manage_show");
		} else {
			// 时候否已经评价过
			if (user != null) {
				lessonAssessView.setUser_id(user.getId());

				List<LessonAssessView> lessonAssessViews = lessonAssessService.findAssess(lessonAssessView);
				if (lessonAssessViews.size() > 0) {
					request.setAttribute("mark", 1);
				} else {
					request.setAttribute("mark", 0);
				}
				modelAndView.setViewName("frontstage/xbjy/lesson/lesson_evaluation_manage");
			} else {
				modelAndView.setViewName("frontstage/xbjy/lesson/lesson_evaluation_manage_show");
			}
		}

		return modelAndView;
	}

	/************
	 * //获取头文件必要信息 public LessonHeadView getLessonHead(Long lesson_id){
	 * LessonHeadView lessonHeadView = new LessonHeadView();
	 * LessonUserIdentityView lessonUserIdentityView =new
	 * LessonUserIdentityView(); LessonUserTaskView lessonUserTaskView =new
	 * LessonUserTaskView(); ProblemStudyView problemStudyView =new
	 * ProblemStudyView(); LessonAttachmentView lessonAttachmentView =new
	 * LessonAttachmentView();
	 * 
	 * lessonUserIdentityView.setLesson_id(lesson_id);
	 * lessonUserTaskView.setLesson_id(lesson_id);
	 * problemStudyView.setLesson_id(lesson_id);
	 * lessonAttachmentView.setLesson_id(lesson_id);
	 * 
	 * 
	 * lessonUserIdentityView.setIdentity(-1);
	 * lessonHeadView.setMemberTotal(lessonUserIdentityService
	 * .countMember(lessonUserIdentityView));
	 * 
	 * lessonUserTaskView.setUser_id(-1); lessonUserTaskView.setStatus(-1);
	 * lessonHeadView
	 * .setTaskTotal(lessonUserTaskService.countTask(lessonUserTaskView));
	 * 
	 * lessonUserTaskView.setStatus(2);
	 * lessonHeadView.setAccomplishedTotal(lessonUserTaskService
	 * .countTask(lessonUserTaskView));
	 * 
	 * problemStudyView.setUser_id(-1); problemStudyView.setPurview(-1);
	 * lessonHeadView
	 * .setProblemTotal(problemStudyService.countDiscussion(problemStudyView));
	 * 
	 * lessonAttachmentView.setUser_id(-1); lessonAttachmentView.setPurview(-1);
	 * lessonHeadView.setArticleTotal(lessonAttachmentService.countAttachment(
	 * lessonAttachmentView));
	 * 
	 * return lessonHeadView; }
	 * 
	 * //获取左侧权限必要信息 public LessonLeftView getLessonLeft(Long lesson_id,User
	 * user){ LessonLeftView lessonLeftView = new LessonLeftView();
	 * LessonUserIdentityView lessonUserIdentityView =new
	 * LessonUserIdentityView(); LessonUserTaskView lessonUserTaskView =new
	 * LessonUserTaskView(); lessonUserIdentityView.setLesson_id(lesson_id);
	 * lessonUserTaskView.setLesson_id(lesson_id);
	 * 
	 * //获取登录用户在课例中所有任务（权限） int UserIdentity = -1; if(user!=null){
	 * lessonUserTaskView.setUser_id(user.getId());
	 * lessonUserIdentityView.setUser_id(user.getId());
	 * if(lessonUserIdentityService
	 * .findUserIdentity(lessonUserIdentityView)!=null){ UserIdentity =
	 * lessonUserIdentityService
	 * .findUserIdentity(lessonUserIdentityView).getIdentity(); } }else{
	 * lessonUserTaskView.setUser_id(-1); } //当前用户在课例中被分配的所有任务
	 * List<LessonUserTaskView> lessonUserPurviewList
	 * =lessonUserTaskService.findPurview(lessonUserTaskView);
	 * 
	 * //大环节权限 int UserPlan = 0; int UserPrepare = 0; int UserClass = 0; int
	 * UserAssessment = 0; int UserIntrospection = 0;
	 * if(lessonUserPurviewList!=null){ for(int
	 * i=0;i<lessonUserPurviewList.size();i++){
	 * if(lessonUserPurviewList.get(i).getPurview
	 * ()<200&&lessonUserPurviewList.get(i).getPurview()>100){ UserPlan =1;
	 * }if(lessonUserPurviewList
	 * .get(i).getPurview()<300&&lessonUserPurviewList.get(i).getPurview()>200){
	 * UserPrepare =1; }if(lessonUserPurviewList.get(i).getPurview()<400&&
	 * lessonUserPurviewList.get(i).getPurview()>300){ UserClass =1;
	 * }if(lessonUserPurviewList
	 * .get(i).getPurview()<500&&lessonUserPurviewList.get(i).getPurview()>400){
	 * UserAssessment =1; }if(lessonUserPurviewList.get(i).getPurview()<600&&
	 * lessonUserPurviewList.get(i).getPurview()>500){ UserIntrospection =1; } }
	 * } lessonLeftView.setUserIdentity(UserIdentity);
	 * lessonLeftView.setUserPlan(UserPlan);
	 * lessonLeftView.setUserPrepare(UserPrepare);
	 * lessonLeftView.setUserClass(UserClass);
	 * lessonLeftView.setUserAssessment(UserAssessment);
	 * lessonLeftView.setUserIntrospection(UserIntrospection);
	 * lessonLeftView.setLessonUserPurviewList(lessonUserPurviewList); return
	 * lessonLeftView; }
	 ************/

	// 更新课例完成状态
	@RequestMapping("/updateStatus")
	public void updateStatus(String lesson_id, int status, HttpServletResponse response, HttpServletRequest request) throws Exception {
		JSONObject result = new JSONObject();
		long id = Long.parseLong(lesson_id);
		try {
			LessonView lessonView = new LessonView();
			lessonView.setId(id);
			lessonView.setStatus(status);
			lessonService.updateStatus(lessonView);

			result.put("msg", "课例已完成");
		} catch (Exception e) {
			result.put("msg", "发布失败");
		}
		ResponseUtil.write(response, result);
	}

	/**
	 * 跳转到课例详情
	 */
	@RequestMapping("/to_lesson_show")
	public ModelAndView toLessonShow(HttpServletRequest request, LessonView lessonView) {
		ModelAndView modelAndView = new ModelAndView();
		User user = (User) request.getSession().getAttribute("currentUser");

		String id = request.getParameter("lesson_id");
		lessonView.setId(Long.parseLong(id));
		Lesson lesson = new Lesson();
		LessonUserTaskView lessonUserTaskView = new LessonUserTaskView();
		LessonTimeView lessonTimeView = new LessonTimeView();

		// 根据主键查询课例信息
		lesson = lessonService.getById(lessonView.getId());

		lessonUserTaskView.setLesson_id(lessonView.getId());

		// 课例详情页面需要的参数
		LessonView lessonShow = lessonService.queryLessonView(lessonView.getId());

		// 得到全部用户被分配的任务
		List<LessonUserTaskView> lessonUserTasks = lessonUserTaskService.findUserByLesson(lessonUserTaskView);

		// 得到时间
		lessonTimeView = lessonTimeService.findByLesson(lessonView.getId());

		request.setAttribute("lesson", lesson);

		// 获取课例头部统计信息
		request.setAttribute("lessonHead", lessonUserIdentityService.getLessonHead(lessonView.getId()));
		// 获取左侧权限部分信息
		request.setAttribute("lessonLeft", lessonUserIdentityService.getLessonLeft(lessonView.getId(), user));
		// 左侧选中状态
		String state = request.getParameter("state");
		String stamp = request.getParameter("stamp");
		request.setAttribute("state", state);
		request.setAttribute("stamp", stamp);

		request.setAttribute("lessonShow", lessonShow);
		request.setAttribute("lessonUserTaskList", lessonUserTasks);
		request.setAttribute("lessonTimeView", lessonTimeView);
		modelAndView.setViewName("frontstage/xbjy/lesson/lesson_show");
		return modelAndView;
	}

	/**
	 * 跳转到课例评论
	 */
	@RequestMapping("/to_lesson_commentary")
	public ModelAndView toLessonCommentary(HttpServletRequest request, LessonView lessonView) {
		ModelAndView modelAndView = new ModelAndView();
		User user = (User) request.getSession().getAttribute("currentUser");
		Long userId = null;
		if (user != null) {
			userId = user.getId();
		}
		String id = request.getParameter("lesson_id");
		lessonView.setId(Long.parseLong(id));
		Lesson lesson = new Lesson();
		LessonUserTaskView lessonUserTaskView = new LessonUserTaskView();

		// 根据主键查询课例信息
		lesson = lessonService.getById(lessonView.getId());

		lessonUserTaskView.setLesson_id(lessonView.getId());

		// 课例评价
		int pageSize = 10;
		int page = lessonView.getPage() + 1;
		int start = pageSize * (page - 1);
		long totalAppraise = userAppraiseService.selectCountBySourceId(lessonView.getId(), 3);
		Integer totalScore = userAppraiseService.selectTotalScore(lessonView.getId(), 1);
		List<UserAppraisView> appraise = userAppraiseService.selectBySourceId(lessonView.getId(), start, pageSize, 3);
		modelAndView.addObject("appraise", appraise);

		if (user != null) {
			UserAppraise user_appraise = userAppraiseService.selectByCourseIdAndUserId(userId, lessonView.getId(), 3);
			modelAndView.addObject("user_appraise", user_appraise);
		}

		modelAndView.addObject("totalAppraise", totalAppraise);
		if (totalAppraise != 0 && totalScore != null) {
			modelAndView.addObject("average", totalScore / totalAppraise);
		} else {
			modelAndView.addObject("average", 5);
		}

		request.setAttribute("lesson", lesson);
		request.setAttribute("lessonView", lessonView);

		// 获取课例头部统计信息
		request.setAttribute("lessonHead", lessonUserIdentityService.getLessonHead(lessonView.getId()));
		// 获取左侧权限部分信息
		request.setAttribute("lessonLeft", lessonUserIdentityService.getLessonLeft(lessonView.getId(), user));
		// 左侧选中状态
		String state = request.getParameter("state");
		String stamp = request.getParameter("stamp");
		request.setAttribute("state", state);
		request.setAttribute("stamp", stamp);
		modelAndView.addObject("head_title", "课例评论");
		modelAndView.setViewName("frontstage/xbjy/lesson/lesson_commentary");
		//评价项
		AppraiseReasonView appraiseReasonView=new AppraiseReasonView();
		appraiseReasonView.setType(2);
		appraiseReasonView.setLevel(5);
		appraiseReasonView.setSource_id(Long.parseLong(id));
		List<AppraiseReasonView> appraiseReasonViews = userAppraiseService.selectByType(appraiseReasonView);
		modelAndView.addObject("appraiseReasonViews", appraiseReasonViews);
		return modelAndView;
	}

	/**
	 * 跳转到自我总结
	 */
	@RequestMapping("/to_lesson_self")
	public ModelAndView toLessonSelf(HttpServletRequest request, LessonView lessonView) {
		ModelAndView modelAndView = new ModelAndView();
		User user = (User) request.getSession().getAttribute("currentUser");

		String id = request.getParameter("lesson_id");
		lessonView.setId(Long.parseLong(id));
		Lesson lesson = new Lesson();
		LessonUserTaskView lessonUserTaskView = new LessonUserTaskView();

		// 根据主键查询课例信息
		lesson = lessonService.getById(lessonView.getId());

		lessonUserTaskView.setLesson_id(lessonView.getId());

		request.setAttribute("lesson", lesson);

		// 获取课例头部统计信息
		request.setAttribute("lessonHead", lessonUserIdentityService.getLessonHead(lessonView.getId()));
		// 获取左侧权限部分信息
		request.setAttribute("lessonLeft", lessonUserIdentityService.getLessonLeft(lessonView.getId(), user));
		// 左侧选中状态
		String state = request.getParameter("state");
		String stamp = request.getParameter("stamp");
		request.setAttribute("state", state);
		request.setAttribute("stamp", stamp);
		modelAndView.addObject("head_title", "小组总结");
		if (user != null) {
			boolean flag = true;// 权限
			String show = request.getParameter("show");
			if (show != null && !show.equals("")) {
				flag = false;
			}
			LessonTimeView lessonTimeView = new LessonTimeView();
			lessonTimeView = lessonTimeService.findByLesson(lessonView.getId());
			if (lessonTimeView != null) {
				Date start = lessonTimeView.getIntrospection_sta();
				Date end = lessonTimeView.getIntrospection_end();
				Date date = new Date();
				if (date.getTime() < start.getTime() || date.getTime() > (end.getTime() + 24 * 60 * 60 * 1000)) {
					flag = false;
				}
			}

			if (flag) {
				modelAndView.setViewName("frontstage/xbjy/lesson/lesson_self");
			} else {
				modelAndView.setViewName("frontstage/xbjy/lesson/lesson_self_show");
			}
		} else {
			modelAndView.setViewName("frontstage/xbjy/lesson/lesson_self_show");
		}
		return modelAndView;
	}

	/**
	 * 保存自我评价
	 */
	@RequestMapping("/save_lesson_self")
	public ModelAndView SaveLessonSelf(HttpServletRequest request, LessonView lessonView) {
		User user = (User) request.getSession().getAttribute("currentUser");
		String id = request.getParameter("lesson_id");
		lessonView.setId(Long.parseLong(id));
		// 将课例状态变为已完成
		lessonView.setStatus(2);
		lessonService.saveLessonSelf(lessonView);

		LessonUserTaskView lessonUserTaskView = new LessonUserTaskView();
		lessonUserTaskView.setUser_id(user.getId());
		lessonUserTaskView.setLesson_id(lessonView.getId());
		lessonUserTaskView.setPurview(503);
		lessonUserTaskView = lessonUserTaskService.findByLUP(lessonUserTaskView);
		if (lessonUserTaskView != null) {
			lessonUserTaskView.setStatus(2);
			lessonUserTaskService.update(lessonUserTaskView);
		}

		String redirectStr = "redirect:/lesson/to_lesson_self.action?lesson_id=" + id + "&purview=503&stamp=0&state=503&show=1";
		return new ModelAndView(redirectStr);
	}

	/**
	 * 跳转我的课例页面
	 */
	@RequestMapping("/to_my_lesson")
	public ModelAndView toMyLessonn(HttpServletRequest request, LessonView lessonView) {
		User user = (User) request.getSession().getAttribute("currentUser");
		ModelAndView modelAndView = new ModelAndView();
		String state = request.getParameter("state");
		String stamp = request.getParameter("stamp");
		try {
			lessonView.setUser_id(user.getId());
			lessonView.setRows(9);
			if (lessonView.getPage() == 0) {
				lessonView.setStartLine(0);
			} else {
				lessonView.setStartLine(lessonView.getPage() * lessonView.getRows());
			}
			if(lessonView.getIdentity()==null){
				lessonView.setIdentity(0);
			}
			List<LessonView> lessonList = lessonService.queryUserLesson(lessonView);
			int total = lessonService.countUserLesson(lessonView);// 我的课程总数
			lessonView.setTotal(total);
			// 分页总页数
			lessonView.setTotalPage(NumUtil.totalPage(total, lessonView.getRows()));

			modelAndView.addObject("lessonList", lessonList);
			modelAndView.addObject("lessonView", lessonView);

			UserInfo userInfo = userInfoService.getByUserId(user.getId());
			request.setAttribute("user", user);
			request.setAttribute("userInfo", userInfo);
			//个人中心统计数据  
			UserCenterView userCenter = userService.queryUserCenter(user.getId());
			modelAndView.addObject("userCenter", userCenter);
			request.setAttribute("state", state);
			request.setAttribute("stamp", stamp);
			modelAndView.addObject("head_title", "我的课例");
			modelAndView.setViewName("frontstage/xbjy/lesson/my_lesson");
		} catch (Exception e) {
			log.error("课例列表查询失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}
		return modelAndView;
	}

	/**
	 * 开启关闭
	 */
	@RequestMapping("/openOrClose")
	public void openOrClose(HttpServletRequest request, HttpServletResponse response, LessonView lessonView) throws Exception {

		String[] ids = lessonView.getIds().split(",");

		for (String id : ids) {
			Lesson lesson = new Lesson();
			lesson.setId(Long.parseLong(id));
			lesson.setOpen_status(lessonView.getOpen_status());
			lessonService.update(lesson);
		}

		JSONObject result = new JSONObject();

		ResponseUtil.write(response, result);

	}
	
	@RequestMapping("/selectOne")
	public void selectOne(HttpServletRequest request,HttpServletResponse response,LessonView lessonView) {
		User user = (User) request.getSession().getAttribute("currentUser");

		JSONObject result = new JSONObject();
		
		try {
			lessonView=lessonService.queryLessonOne(lessonView);
			result.put("lessonView", lessonView);
				if(user != null){
					//收藏
					UserCollect userCollect = new UserCollect();
					
					userCollect.setSource_type(2);
					userCollect.setUser_id(user.getId());
					userCollect.setSource_id(lessonView.getId());
					userCollect = userCollectService.selectByCourseIdAndUserId(userCollect);
					result.put("userCollect", userCollect);
				
				
			}
			
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			e.printStackTrace();
			log.error("查询一失败", ExceptionUtil.getExceptionMessage(e));
		}
	
	}
}