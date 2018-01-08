package cn.bnsr.edu_yun.frontstage.train.controller;

import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONArray;

import cn.bnsr.edu_yun.frontstage.base.po.Classify;
import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.base.po.UserInfo;
import cn.bnsr.edu_yun.frontstage.base.service.ClassifyService;
import cn.bnsr.edu_yun.frontstage.base.service.UserInfoService;
import cn.bnsr.edu_yun.frontstage.base.service.UserService;
import cn.bnsr.edu_yun.frontstage.base.view.UserCenterView;
import cn.bnsr.edu_yun.frontstage.tiku.service.ExamService;
import cn.bnsr.edu_yun.frontstage.tiku.view.ExamView;
import cn.bnsr.edu_yun.frontstage.train.po.ClassBelongs;
import cn.bnsr.edu_yun.frontstage.train.po.ClassRelation;
import cn.bnsr.edu_yun.frontstage.train.po.Community;
import cn.bnsr.edu_yun.frontstage.train.po.Course;
import cn.bnsr.edu_yun.frontstage.train.po.CourseHour;
import cn.bnsr.edu_yun.frontstage.train.po.TeacherRelation;
import cn.bnsr.edu_yun.frontstage.train.po.TopicQuestion;
import cn.bnsr.edu_yun.frontstage.train.po.Train;
import cn.bnsr.edu_yun.frontstage.train.po.UserClassHour;
import cn.bnsr.edu_yun.frontstage.train.po.UserCollect;
import cn.bnsr.edu_yun.frontstage.train.po.UserTrainClass;
import cn.bnsr.edu_yun.frontstage.train.po.Workshop;
import cn.bnsr.edu_yun.frontstage.train.service.CertificateService;
import cn.bnsr.edu_yun.frontstage.train.service.ClassBelongsService;
import cn.bnsr.edu_yun.frontstage.train.service.ClassRelationService;
import cn.bnsr.edu_yun.frontstage.train.service.ClassService;
import cn.bnsr.edu_yun.frontstage.train.service.ClassifyRelationService;
import cn.bnsr.edu_yun.frontstage.train.service.CommunityService;
import cn.bnsr.edu_yun.frontstage.train.service.CourseExamStandardService;
import cn.bnsr.edu_yun.frontstage.train.service.CourseHourService;
import cn.bnsr.edu_yun.frontstage.train.service.CourseInfoService;
import cn.bnsr.edu_yun.frontstage.train.service.CourseService;
import cn.bnsr.edu_yun.frontstage.train.service.MessageService;
import cn.bnsr.edu_yun.frontstage.train.service.TeacherRelationService;
import cn.bnsr.edu_yun.frontstage.train.service.TopicQuestionService;
import cn.bnsr.edu_yun.frontstage.train.service.TrainCourseService;
import cn.bnsr.edu_yun.frontstage.train.service.TrainExamStandardService;
import cn.bnsr.edu_yun.frontstage.train.service.TrainPhaseService;
import cn.bnsr.edu_yun.frontstage.train.service.TrainService;
import cn.bnsr.edu_yun.frontstage.train.service.UserClassHourService;
import cn.bnsr.edu_yun.frontstage.train.service.UserCollectService;
import cn.bnsr.edu_yun.frontstage.train.service.UserDiscussService;
import cn.bnsr.edu_yun.frontstage.train.service.UserStudyRecordService;
import cn.bnsr.edu_yun.frontstage.train.service.UserStudyService;
import cn.bnsr.edu_yun.frontstage.train.service.UserTrainClassService;
import cn.bnsr.edu_yun.frontstage.train.service.WorkshopService;
import cn.bnsr.edu_yun.frontstage.train.view.ClassData;
import cn.bnsr.edu_yun.frontstage.train.view.ClassTestView;
import cn.bnsr.edu_yun.frontstage.train.view.ClassView;
import cn.bnsr.edu_yun.frontstage.train.view.ClassifyRelationView;
import cn.bnsr.edu_yun.frontstage.train.view.CourseHourView;
import cn.bnsr.edu_yun.frontstage.train.view.CourseView;
import cn.bnsr.edu_yun.frontstage.train.view.MessageView;
import cn.bnsr.edu_yun.frontstage.train.view.TeacherRelationView;
import cn.bnsr.edu_yun.frontstage.train.view.TeacherView;
import cn.bnsr.edu_yun.frontstage.train.view.TrainCourseView;
import cn.bnsr.edu_yun.frontstage.train.view.TrainExamStandardView;
import cn.bnsr.edu_yun.frontstage.train.view.TrainPhaseView;
import cn.bnsr.edu_yun.frontstage.train.view.TrainView;
import cn.bnsr.edu_yun.frontstage.train.view.TutorClassView;
import cn.bnsr.edu_yun.frontstage.train.view.UserCertificateView;
import cn.bnsr.edu_yun.frontstage.train.view.UserDiscussView;
import cn.bnsr.edu_yun.frontstage.train.view.UserStudyRecordView;
import cn.bnsr.edu_yun.frontstage.train.view.UserStudyView;
import cn.bnsr.edu_yun.frontstage.train.view.UserTotalScoreView;
import cn.bnsr.edu_yun.util.ExceptionUtil;
import cn.bnsr.edu_yun.util.ExportExcel;
import cn.bnsr.edu_yun.util.NumUtil;
import cn.bnsr.edu_yun.util.ResponseUtil;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/class")
public class ClassController {

	private final Logger log = LoggerFactory.getLogger(ClassController.class);

	@Autowired
	private ClassService classService;
	@Autowired
	private ClassRelationService classRelationService;
	@Autowired
	private TrainService trainService;
	@Autowired
	private CourseInfoService courseInfoService;
	@Autowired
	private ClassifyService classifyService;
	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private TeacherRelationService teacherRelationService;
	@Autowired
	private UserStudyService userStudyService;
	@Autowired
	private UserStudyRecordService userStudyRecordService;
	@Autowired
	private UserClassHourService userClassHourService;

	@Autowired
	private TopicQuestionService topicQuestionService;

	@Autowired
	private UserCollectService userCollectService;
	@Autowired
	private UserService userService;
	@Autowired
	private UserDiscussService userDiscussService;
	
	@Autowired
	private CourseHourService courseHourService;
	@Autowired
	private UserTrainClassService userTrainClassService;
	@Autowired
	private CertificateService certificateService;
	@Autowired
	private TrainCourseService trainCourseService;
	@Autowired
	private CourseService courseService;
	@Autowired
	private ExamService examService;
	@Autowired
	private ClassBelongsService classBelongsService;
	@Autowired
	private ClassifyRelationService classifyRelationService;
	@Autowired
	private CommunityService communityService;
	@Autowired
	private WorkshopService workshopService;
	@Autowired
	private TrainPhaseService trainPhaseService;
	@Autowired
	private MessageService messageService;
	@Autowired
	private CourseExamStandardService courseExamStandardService;
	@Autowired
	private TrainExamStandardService trainExamStandardService;
	
	@RequestMapping("/to_class")
	public ModelAndView toClass(HttpServletRequest request, ClassView classView) {
		ModelAndView mv = new ModelAndView();
		try {
			String sign = request.getParameter("sign");
			String flag = request.getParameter("flag");
			Long id = Long.parseLong(request.getParameter("id"));
			if (id != null) {
				if (classView.getSource_type() == 0) {
					CourseView courseView = courseInfoService.queryCourseDetail(id);
					courseView.setFlag(flag);
					courseView.setSign(sign);
					mv.addObject("courseView", courseView);
				} else {
					TrainView trainView = new TrainView();
					trainView.setId(id);
					trainView = trainService.getByTrain(trainView);
					trainView.setSign(sign);
					trainView.setFlag(flag);
					mv.addObject("trainView", trainView);
				}
			}
			classView.setPaging("1");//要分页
			classView.setRows(10);
			if (classView.getPage() == 0) {
				classView.setStartLine(0);
			} else {
				classView.setStartLine(classView.getPage() * classView.getRows());
			}
			int total = classService.countClass(classView);
			classView.setTotal(total);
			classView.setTotalPage(NumUtil.totalPage(total, classView.getRows()));
			mv.addObject("classView", classView);
			mv.addObject("classList", classService.find(classView));
			mv.addObject("head_title", "班级管理");
			mv.setViewName("frontstage/train/class/class");
		} catch (Exception e) {
			e.printStackTrace();
			log.error("跳转课程班级页面失败", ExceptionUtil.getExceptionMessage(e));
		}
		return mv;
	}

	/**
	 * 
	 * 跳转班级更新或保存页面
	 * @author sunyu
	 * @param classView
	 * @return
	 */
	@RequestMapping("/to_class_add_or_update")
	public ModelAndView toClassAddUpdate(HttpServletRequest request,ClassView classView) {
		ModelAndView mv = new ModelAndView();
		try {
			String sign = request.getParameter("sign");
			String flag = request.getParameter("flag");
			Long id = Long.parseLong(request.getParameter("source_id"));
			if (id != null) {
				if (classView.getSource_type() == 0) {
					CourseView courseView = courseInfoService.queryCourseDetail(id);
					courseView.setFlag(flag);
					courseView.setSign(sign);
					mv.addObject("courseView", courseView);
				} else {
					TrainView trainView = new TrainView();
					trainView.setId(id);
					trainView = trainService.getByTrain(trainView);
					trainView.setSign(sign);
					trainView.setFlag(flag);
					mv.addObject("trainView", trainView);
				}
			}
			// 根据id查询开班范围的子分类
			List<Classify> classifys = classifyService.queryByParentId(33l);
			mv.addObject("classifys", classifys);
			// 班级id
			Long classId = classView.getId();
//			Long source_id = classView.getSource_id();
			Integer source_type = classView.getSource_type();
			if (classId != null) {// 更新
				classView = classService.selectOne(classId,null);
				TeacherRelation teacherRelation = new TeacherRelation();
				teacherRelation.setSource_id(classId);
				teacherRelation.setSource_type(source_type + 1);
				teacherRelation.setType(1);
				List<TeacherView> assiantList = teacherRelationService.queryAssaint(teacherRelation);
				mv.addObject("assiantList", assiantList);
				mv.addObject("classView", classView);
			} else {// 保存
				mv.addObject("classes", classService.getCurrentClasses(classView));
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error("跳转课程班级页面失败", ExceptionUtil.getExceptionMessage(e));
		}
		mv.addObject("head_title", "新建班级");
		mv.setViewName("frontstage/train/class/class_add_or_update");

		return mv;
	}

	@RequestMapping("/show_teacher")
	@ResponseBody
	public String showTeacher(HttpServletRequest request, HttpServletResponse response, TeacherView teacherView) {
		try {
			JSONObject result = new JSONObject();
			User user = (User) request.getSession().getAttribute("currentUser");
			String titles = request.getParameter("titles");
			teacherView.setTitles(titles);
			teacherView.setUser_id(user.getId());
			teacherView.setRows(5);
			if (teacherView.getPage() == 0) {
				teacherView.setStartLine(0);
			} else {
				teacherView.setStartLine(teacherView.getPage() * teacherView.getRows());
			}
			Integer total = userInfoService.countTeacher(teacherView);
			teacherView.setTotal(total);
			// 分页总数
			teacherView.setTotalPage(NumUtil.totalPage(total, teacherView.getRows()));
			List<TeacherView> teacherViews = userInfoService.findTeacher(teacherView);

			List<String> titlelist = userInfoService.findTitles(user.getId());
			result.put("titlelist", titlelist);
			result.put("teacherView", teacherView);
			result.element("teacherViews", teacherViews);
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			e.printStackTrace();
			log.error("跳转失败", ExceptionUtil.getExceptionMessage(e));
		}
		return null;
	}

	/**
	 * 
	 * 保存或更新班级
	 * 
	 * @author sunyu
	 * @param request
	 * @param classView
	 * @return
	 */
	@RequestMapping("/save_or_update")
	public ModelAndView saveOrUpdate(HttpServletRequest request, ClassView classView) {
		ModelAndView mv = new ModelAndView();
		Long sourceId = classView.getSource_id();
		Integer sourceType = classView.getSource_type();
		String sign = classView.getSign();//跳转的标识
		String updateState = request.getParameter("updateState");
		try {
			if(classView.getDiscount()==null){
				classView.setDiscount(100);
			}
			if (classView.getId() != null) {//更新
				classService.updateAll(classView);
				if("1".equals(updateState)){//在班级列表处跟新
					mv.setViewName("redirect:/class/to_class.action?id="+sourceId+"&flag=2&sign="+sign+"&source_id="+sourceId+"&source_type="+sourceType+"&jumpType=-1");
				}else{//在班级设置处更新
					mv.setViewName("redirect:/class/to_class_setting.action?id="+classView.getId()+"&flag=1&sign=8&source_id="+sourceId+"&source_type="+sourceType);
				}
			} else {//保存
				if (classView.getEnd_time() == null) {
					classView.setEnd_time(classView.getOpen_time());
				}
				classView.setStatus(0);
				classView.setType(sourceType);
				User user = (User) request.getSession().getAttribute("currentUser");
				classView.setUserId(user.getId());// 添加班主任id
				classView.setCreate_time(new Date());
				classService.saveAll(classView);
				//暂不处理老师建班，已购买逻辑
				//第二次插入的数据需要第一次插入的数据为前提
				//classService.saveUserStudy(classView);
				
				mv.setViewName("redirect:/class/to_class.action?id=" + sourceId + "&flag=2&sign="+sign+"&source_id=" + sourceId
						+ "&source_type=" + sourceType+"&jumpType=-1");
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error("保存或更新班级失败", ExceptionUtil.getExceptionMessage(e));
		}
		return mv;
	}

	/**
	 * 
	 * 更改为删除状态
	 * 
	 * @author sunyu
	 * @param request
	 * @param ids
	 * @return
	 */
	@RequestMapping("/del_class")
	public ModelAndView delClass(HttpServletRequest request, Long[] classId) {
		ModelAndView mv = new ModelAndView();
		String sourceId = request.getParameter("sourceId");
		String sourceType = request.getParameter("sourceType");
		String sign = request.getParameter("sign");
		try {
			classService.delete(classId);
		} catch (Exception e) {
			e.printStackTrace();
			log.error("保存所有失败", ExceptionUtil.getExceptionMessage(e));
		}
		mv.setViewName("redirect:/class/to_class.action?id=" + sourceId + "&flag=2&sign="+sign+"&source_id=" + sourceId
				+ "&source_type=" + sourceType+"&jumpType=-1");
		return mv;
	}

	/**
	 * 
	 * 删除助教
	 * 
	 * @author sunyu
	 * @param response
	 * @param id
	 * @return
	 */
	@RequestMapping("/delAssaint")
	public String deleteAssaint(HttpServletResponse response, String id) {
		JSONObject result = new JSONObject();
		try {
			teacherRelationService.deleteTeacher(id);
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			e.printStackTrace();
			log.error("删除助教失败", ExceptionUtil.getExceptionMessage(e));
		}
		return null;
	}
	/**
	 * 
	 * 查询一个class
	 * @param response
	 * @param id
	 * @return
	 */
	@RequestMapping("/selectOne")
	public String selectOne(HttpServletRequest request,HttpServletResponse response,ClassView classView) {
		User user = (User) request.getSession().getAttribute("currentUser");

		JSONObject result = new JSONObject();
		Long classId = classView.getId();
		try {
			if(classId!=null){
				classView = classService.selectOne(classId,null);
				UserStudyView studyView = new UserStudyView();
				studyView.setSourceId(classId.toString());
				studyView.setLearnId(classView.getSource_id().toString());
				studyView.setSourceType(classView.getSource_type().toString());
				studyView.setPaging("0");
				//学员list
				List<UserStudyView> studentList = new ArrayList<UserStudyView>();
				if(classView.getType()!=2){
					studentList = userStudyService.searchStudent(studyView);
				}else{//培训课程班级
					studentList = userTrainClassService.searchTrainClassStudent(classId,classView.getTrainType());
				}
				result.element("studentList", studentList);
				
				//学员动态
				UserStudyRecordView recordView = new UserStudyRecordView();
				recordView.setSource_id(classView.getId());
				recordView.setLearn_id(classView.getSource_id());
				recordView.setSource_type(classView.getSource_type());
				List<UserStudyRecordView> userStudyRecords = userStudyRecordService.queryStudyRecordDynamic(recordView);
				result.element("userStudyRecords", userStudyRecords);
				
				if(user != null){
					//收藏
					UserCollect userCollect = new UserCollect();
					userCollect.setLearn_id(classView.getSource_id());
					userCollect.setSource_type(classView.getSource_type());
					userCollect.setUser_id(user.getId());
					userCollect.setSource_id(classId);
					userCollect = userCollectService.selectByCourseIdAndUserId(userCollect);
					result.put("userCollect", userCollect);
				}
				//班级
				ClassView cv = new ClassView();
				cv.setPaging("0");// 不分页
				cv.setStatus(5);
				cv.setState(0);
				cv.setSource_id(classView.getSource_id());
				cv.setSource_type(classView.getSource_type());
				List<ClassView> classList = classService.find(cv);
				result.put("classList", classList);
			}
			result.put("classView", classView);
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			e.printStackTrace();
			log.error("查询一个班级失败", ExceptionUtil.getExceptionMessage(e));
		}
		return null;
	}
	

	/**
	 * 
	 * turn class_service_setting.jsp
	 * @param request
	 * @param classView
	 * @return
	 */
	@RequestMapping("/to_class_service_setting")
	public ModelAndView toClassServiceSetting(ClassView classView){
		ModelAndView mv = new ModelAndView();
		List<TeacherRelationView> teacherView = new ArrayList<>();
		try {
			String sign = classView.getSign();
			String flag = classView.getFlag();
			Long classId = classView.getId();
			Integer source_type = classView.getSource_type();
			if ( classId!= null && source_type!= null) {
				classView = classService.selectOne(classId,source_type);
				if (source_type == 0) {// 班级来源于课程
					teacherView = teacherRelationService.queryTeacherRelation(classId, 1, 1);
				}
				if (source_type == 1) {// 班级来源于培训
					teacherView = teacherRelationService.queryTeacherRelation(classId, 2, 1);
				}
				classView.setSign(sign);
				classView.setFlag(flag);
			}
			mv.addObject("teacherView", teacherView);
			mv.addObject("classView", classView);
			mv.addObject("head_title", "服务设置");
			ClassRelation classRelation = classRelationService.selectOne(classId);
			mv.addObject("classRelation", classRelation);
		}catch(Exception e){
			e.printStackTrace();
			log.error("跳转班级服务设置失败", ExceptionUtil.getExceptionMessage(e));
		}
		mv.setViewName("frontstage/train/class/class_service_setting");
		return mv;
	}
	
	/**
	 * 
	 * 更新班级服务设置
	 * @param classRelation
	 * @return
	 */
	@RequestMapping("/update_class_service_setting")
	public ModelAndView updateClassServiceSetting(ClassRelation classRelation){
		ModelAndView mv = new ModelAndView();
		Long class_id = classRelation.getClass_id();
		Long source_id = classRelation.getSource_id();
		Integer source_type = classRelation.getSource_type();
		try{
			classRelationService.update(classRelation);
		}catch(Exception e){
			log.error("更新班级服务设置失败", ExceptionUtil.getExceptionMessage(e));
		}
		mv.setViewName("redirect:/class/to_class_service_setting.action?id="+class_id+"&flag=1&sign=1&source_id="+source_id+"&source_type="+source_type);
		return mv;
	}
	
	/**
	 * 保存社区分类
	 * @param classView
	 * @return
	 */
	@RequestMapping("/update_classify_setting")
	public ModelAndView saveClassClassifySetting(ClassView classView){
		ModelAndView mv = new ModelAndView();
		ClassBelongs classBelongs = new ClassBelongs();
		classBelongs.setClass_id(classView.getId());
		classBelongs.setSource_type(classView.getCommunityType());
		classBelongs.setStatus(0);
		if(classView.getSecondClassifyId()==null||classView.getSecondClassifyId()==-1){
			classBelongs.setClassify_relation_id(classView.getFirstClassifyId());
		}else{
			classBelongs.setClassify_relation_id(classView.getSecondClassifyId());
		}
		try{
			if(classView.getClassBelongsId()==null){
				classBelongsService.saveClassBelongs(classBelongs);
			}else{
				classBelongs.setId(classView.getClassBelongsId());
				classBelongsService.updateClassBelogs(classBelongs);
			}
		}catch(Exception e){
			log.error("保存班级社区分类失败",ExceptionUtil.getExceptionMessage(e));
		}
		mv.setViewName("redirect:/class/to_Class_CommunityWorkshop_Setting.action?id="
				+classView.getId()+"&flag=2&sign=9&source_id="
				+classView.getSource_id()+"&source_type="
				+classView.getSource_type());
		return mv;
	}
	
	/**
	 * 
	 * 跳转班级首页
	 * @author sunyu
	 * @param classView
	 * @return
	 */
	@RequestMapping("/to_class_home")
	public ModelAndView toClassHome(ClassView classView) {
		ModelAndView mv = new ModelAndView();
		try {
			SimpleDateFormat sdf =new SimpleDateFormat("yyyy-MM-dd");
			String strdate = sdf.format(new Date());
			Date date = sdf.parse(strdate);
			Calendar calendar = new GregorianCalendar();
	        calendar.setTime(date);
	        calendar.add(calendar.DATE,-1);//把日期往前减少一天，若想把日期向后推一天则将负数改为正数
	        
			String sign = classView.getSign();
			String flag = classView.getFlag();
			Long classId = classView.getId();
			Long sourceId = classView.getSource_id();//目前是课程id
			Integer source_type = classView.getSource_type();
			if ( classId!= null && source_type!= null) {
				classView = classService.selectOne(classId,source_type);
				classView.setSign(sign);
				classView.setFlag(flag);
			}
			mv.addObject("classView", classView);
			//今日学员总数
			UserStudyView userStudyView = new UserStudyView();
			userStudyView.setSourceId(classId+"");
			userStudyView.setSourceType(source_type+"");
			Integer todayStuNum = userStudyService.countStudent(userStudyView);
			mv.addObject("todayStuNum", todayStuNum);
			
			//昨日学员总数
			userStudyView.setAddTime(strdate);
			Integer yesterdayStuNum = userStudyService.countStudent(userStudyView);
			mv.addObject("yesterdayStuNum", yesterdayStuNum);
			
			//今日
			classView.setOpen_time(date);
			//完成课时数 course_hour的attribute_type为课时(2)
			Integer toComCourseHourNum = userClassHourService.countCompleteCourseHour(classView);
			//新增研讨数
			Integer toclassDiscussNum = userDiscussService.countClassHomeDiscuss(classView);
			
			//昨日
			classView.setOpen_time(calendar.getTime());
			//完成课时数 course_hour的attribute_type为课时(2)
			Integer yesComCourseHourNum = userClassHourService.countCompleteCourseHour(classView);
			//新增研讨数
			Integer yesclassDiscussNum = userDiscussService.countClassHomeDiscuss(classView);
			//课程
			if(classView.getType()==0){
			//作业
			//classView.setType(1);//删
			classView.setAttribute_type(4);//增
		//	List<ClassTestView> classTaskList = classService.queryClassHomeTest(classView);
			List<ClassTestView> classTaskList = classService.queryClassHomeTest1(classView);
			//考试
			classView.setType(0);
			classView.setAttribute_type(0);
		//	List<ClassTestView> classTestList = classService.queryClassHomeTest(classView);
			List<ClassTestView> classTestList = classService.queryClassHomeTest1(classView);
			mv.addObject("toComCourseHourNum", toComCourseHourNum);
			mv.addObject("yesComCourseHourNum", yesComCourseHourNum);
			mv.addObject("toclassDiscussNum", toclassDiscussNum);
			mv.addObject("yesclassDiscussNum", yesclassDiscussNum);
            mv.addObject("classTaskList", classTaskList);
			mv.addObject("classTestList", classTestList);
			//最新评价
//			List<UserAppraisView> appraiseList = userAppraiseService.selectBySourceId(sourceId, 0, 4, source_type);
//			mv.addObject("appraiseList", appraiseList);
			//主题讨论
			classView.setAttribute_type(3);
			List<ClassTestView> classTopicList = classService.queryClassHomeTest1(classView);
					//classService.queryClassTopic(classView);
			mv.addObject("classTopicList", classTopicList);
			}else{//培训
				//简单培训
				if(classView.getTrainType()==0){
					TrainCourseView trainCourseView=new TrainCourseView();
					trainCourseView.setSource_id(sourceId);
					trainCourseView.setClass_id(classId);
					List<TrainCourseView>	trainCourseViews = trainCourseService.queryCourseStudy(trainCourseView);
					mv.addObject("trainCourseView1", trainCourseViews);
					trainCourseView.setIs_required(1);
					trainCourseViews = trainCourseService.queryCourseStudy(trainCourseView);
					mv.addObject("trainCourseView2", trainCourseViews);
				}else{//阶段培训
					List<TrainPhaseView> trainPhaseList = examService.queryTrainPhaseExam(classId, sourceId);
					mv.addObject("trainPhaseList", trainPhaseList);
				}
			}
			//最新提问
			List<TopicQuestion> questionList = topicQuestionService.selectByClassId(classId, 0, "question_time", 0,3);
			mv.addObject("questionList", questionList);
			int questionTotal= topicQuestionService.selectCountByClassId(classId, 0);
			mv.addObject("questionTotal", questionTotal);
		
			
			mv.addObject("head_title", "班级主页");
			mv.setViewName("frontstage/train/class/class_home");
		} catch (Exception e) {
			log.error("跳转班级主页失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}
		return mv;
	}

	@RequestMapping("/to_train_course_exam")
	public ModelAndView toTrainCourseExam(HttpServletRequest request,ClassView classView,ClassTestView testView) {
		ModelAndView mv = new ModelAndView();
		try{
			String sign = classView.getSign();
			String flag = classView.getFlag();
			Long classId = classView.getId();
			Long source_id=classView.getSource_id();
			Integer source_type = classView.getSource_type();//1培训
			String required = request.getParameter("required");
			String commonTrain = request.getParameter("commonTrain");
			testView.setLearn_id(source_id);
			int total = 0;
			List<ClassTestView> testList = new ArrayList<ClassTestView>();
			if ( classId!= null && source_type!= null) {
				classView = classService.selectOne(classId,source_type);
				testView.setRows(10);
				if (testView.getPage() == 0) {
					testView.setStartLine(0);
				} else {
					testView.setStartLine(testView.getPage() * testView.getRows());
				}
				if(testView.getExam_type() == 0||testView.getExam_type()== 1){
					total = classService.countClassTest(testView);
					testList = classService.queryClassTest(testView);
				}else if(testView.getExam_type() == 2){
					total = classService.countClassTalking(testView);
					testList = classService.queryClassTalking(testView);
				}else{
					List<UserTotalScoreView> userTotalScoreViews = classService.queryUserTotalScore(classView);
					mv.addObject("userTotalScoreViews", userTotalScoreViews);
				}
				testView.setTotal(total);
				testView.setTotalPage(NumUtil.totalPage(total, testView.getRows()));
				mv.addObject("testList", testList);
				classView.setSign(sign);
				classView.setFlag(flag);
				testView.setLearn_id(source_id);
				testView.setSource_id(classId);
				testView.setSource_type(source_type);
				mv.addObject("testView", testView);
			}
			mv.addObject("classView", classView);
			mv.addObject("required", required);
			mv.addObject("commonTrain", commonTrain);
			mv.addObject("class_type", 2);//表示培训课程的调转
			mv.setViewName("frontstage/train/class/class_scores_manage");
			mv.addObject("head_title", "成绩管理");
		}catch(Exception e){
			e.printStackTrace();
			log.error("跳转", ExceptionUtil.getExceptionMessage(e));
		}
		return mv;
	}

	/**
	 * 
	 * 跳转班级分数管理
	 * @author sunyu
	 * @param classView
	 * @return
	 */
	@RequestMapping("/to_class_scores_manage")
	public ModelAndView toClassScoresManage(HttpServletRequest request,ClassView classView,ClassTestView testView) {
		ModelAndView mv = new ModelAndView();
		try {
			String sign = classView.getSign();
			String flag = classView.getFlag();
			Long classId = classView.getId();
			Long source_id=classView.getSource_id();
			Integer source_type = classView.getSource_type();
			String required = request.getParameter("required");
			testView.setLearn_id(source_id);
			int total = 0;
			List<ClassTestView> testList = new ArrayList<ClassTestView>();
			if ( classId!= null && source_type!= null) {
				classView = classService.selectOne(classId,source_type);
				if (source_type == 0) {// 班级来源于课程
					testView.setRows(10);
					if (testView.getPage() == 0) {
						testView.setStartLine(0);
					} else {
						testView.setStartLine(testView.getPage() * testView.getRows());
					}
					if(testView.getExam_type() == 0||testView.getExam_type()== 1){
						total = classService.countClassTest(testView);
						testList = classService.queryClassTest(testView);
					}else if(testView.getExam_type() == 2){
						total = classService.countClassTalking(testView);
						testList = classService.queryClassTalking(testView);
					}else{
						List<UserTotalScoreView> userTotalScoreViews = classService.queryUserTotalScore(classView);
						mv.addObject("userTotalScoreViews", userTotalScoreViews);
					}
					testView.setTotal(total);
					testView.setTotalPage(NumUtil.totalPage(total, testView.getRows()));
					mv.addObject("testList", testList);
				}else if (source_type == 1) {// 班级来源于培训
					if(testView.getExam_type() == 4){
						testView.setRows(10);
						if (testView.getPage() == 0) {
							testView.setStartLine(0);
						} else {
							testView.setStartLine(testView.getPage() * testView.getRows());
						}
						List<UserTotalScoreView> userTotalScoreViews = classService.queryUserTotalScore(classView);
						mv.addObject("userTotalScoreViews", userTotalScoreViews);
						testView.setTotal(total);
						testView.setTotalPage(NumUtil.totalPage(total, testView.getRows()));
						mv.addObject("testList", testList);
					}else{
						Train train = trainService.getById(source_id);
						if (train.getType() == 1) {//阶段培训
							List<TrainPhaseView> trainPhaseList = examService.queryTrainPhaseExam(classId,source_id);
							mv.addObject("trainPhaseList", trainPhaseList);
						} else if (train.getType() == 0) {//普通培训
							mv.addObject("required", required);
							List<CourseView> trainCourse = new ArrayList<CourseView>();
							if("1".equals(required)){
								//必修课程
								trainCourse = trainCourseService.queryTrainCourseExam(classId,0,source_id,0);
							}else if("0".equals(required)){
								//选修课程
								trainCourse = trainCourseService.queryTrainCourseExam(classId,0,source_id,1);
							}
							mv.addObject("trainCourse", trainCourse);
							mv.addObject("commonTrain", 1);
						}
						mv.addObject("train_type", train.getType());
					}
				}
				classView.setSign(sign);
				classView.setFlag(flag);
				testView.setLearn_id(source_id);
				testView.setSource_id(classId);
				testView.setSource_type(source_type);
				mv.addObject("testView", testView);
			}
			mv.addObject("classView", classView);
			mv.addObject("head_title", "成绩管理");
			mv.setViewName("frontstage/train/class/class_scores_manage");
		} catch (Exception e) {
			e.printStackTrace();
			log.error("跳转班级主页失败", ExceptionUtil.getExceptionMessage(e));
		}
		return mv;
	}

	
	/**
	 * fangxiongwei
	 * 20170221
	 * 异步查询是否有班级
	 */
	@RequestMapping("/is_exist_class")
	public String isExistClass(HttpServletResponse response,ClassView classView) {
		JSONObject result = new JSONObject();
		try {
			int ck_total_required=-1;
			//Integer num = classService.countClass(classView);
			int cur_ck=0;
			Course c = null;
			Train t = null;
			if(classView.getSource_type()==0){
				c = courseService.getById(classView.getSource_id());
				cur_ck = c.getIs_check();
			}else if(classView.getSource_type()==1){
				t = trainService.getById(classView.getSource_id());
				cur_ck = t.getIs_check();
			}
		 	int set_check=1;
			if(cur_ck==1){
				set_check=0;	
			}
			if(classView.getSource_type()==0){
			 	int course_hours = -1;
			 	if(c.getHours()!=null&&(!"".equals(c.getHours().trim())&&Integer.parseInt(c.getHours())>=0)){
					course_hours=1;
		 		}
		 		result.put("course_hours", course_hours);
				int courseHour_num = courseHourService.queryHourOfCourseCount(classView.getSource_id());
				result.put("courseHour_num", courseHour_num);
				if(set_check==1){
					int total_ratio = courseExamStandardService.queryTotalRatioByCouId(classView.getSource_id());
					result.put("total_ratio", total_ratio);
				}
				System.out.println(classView.getSource_type()+"===="+courseHour_num);
			}else if(classView.getSource_type()==1){
				int train_of_num = 0;
				List<TrainExamStandardView> tesvList = trainExamStandardService.queryExamStandard(classView.getSource_id(),classView.getTrainType());
				TrainExamStandardView tesv = new TrainExamStandardView();
				if(tesvList.size()>0){//有课程
					tesv = tesvList.get(0);//赋值考核标准
				}
				for(int i=0;i<tesvList.size();i++){//赋值学时
					if(tesvList.get(i).getType()==0){//必修
						tesv.setRequiredHours(tesvList.get(i).getTotalHours());//必修学时
					}else{//选修
						tesv.setOptionHours(tesvList.get(i).getTotalHours());//选修学时
					}
				}
				//总学时
				tesv.setTotalHours(tesv.getRequiredHours()+tesv.getOptionHours());
				
				if(tesv.getId()==null){//没有课程 只查询考核标准
					tesv = trainExamStandardService.queryByTrainId(classView.getSource_id());
				}
				if(classView.getTrainType()==0){
					train_of_num=trainCourseService.queryTrainCourseOfTrainCount(classView);
					System.out.println(classView.getSource_type()+"===="+classView.getTrainType()+"------"+train_of_num);
				}else if(classView.getTrainType()==1){
					//查询该培训所有阶段总学时要求
					int total_required = trainPhaseService.searchTotalHours(classView.getSource_id());
					tesv.setTotal_required(total_required);
					train_of_num=trainPhaseService.queryPhaseOfTrainPhaseCount(classView.getSource_id());
					System.out.println(classView.getSource_type()+"===="+classView.getTrainType()+"------"+train_of_num);
				}
				result.put("trainType", classView.getTrainType());
				result.put("train_of_num", train_of_num);
				if(set_check==1){
					if(tesv.getTotal_required()>0){
						if(tesv.getTotalHours()>=tesv.getTotal_required()&&tesv.getRequiredHours()<=tesv.getTotal_required()){
							ck_total_required=1;
						}
					}
					result.put("ck_total_required", ck_total_required);
					System.out.println(ck_total_required+"----"+tesv.getTotalHours()+"----"+tesv.getTotal_required()+"--=="+tesv.getRequiredHours());
				}
			}
			result.put("set_check",set_check);
			//result.put("num", num);
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			e.printStackTrace();
			log.error("查询班级失败", ExceptionUtil.getExceptionMessage(e));
		}
		return null;
	}
	
	@RequestMapping("/export_exam")
	public ModelAndView exportExam(HttpServletRequest request, HttpServletResponse response,
			ExamView examView) {
		Long class_id = examView.getSource_id();
		Integer source_type = examView.getSource_type();
		Integer exam_type = examView.getExam_type();
		ClassView classView = classService.selectOne(class_id,source_type);
		List<ExamView> examList = null;
		if(exam_type!=2){
			examList = classService.queryClassStudentScore(examView);
		}else if(exam_type==2){
			examList = classService.queryDiscussScore(examView);
		}
		response.setContentType("application/msexcel");
		try {
			OutputStream out = response.getOutputStream();
			ExportExcel<ExamView> excel = new ExportExcel<ExamView>();
			if(exam_type==0){
				String[] head = {"学员姓名", "加入时间","考试名称","成绩","考试时间","批改时间"};
				String[] fieldNames = { "username", "join_time", "name", "score", "start_time", "marking_time"};
				String fileName = classView.getClasses() + "班学员考试成绩.xls";
				response.setHeader("Content-Disposition", getFileName(fileName, getExplorer(request)));
				excel.exportExcel("全体学员", head, fieldNames, examList, out);
			}else if(exam_type==1){
				String[] head = {"学员姓名", "加入时间","作业名称","成绩","提交时间","批改时间"};
				String[] fieldNames = { "username", "join_time", "name", "score", "submit_time", "marking_time"};
				String fileName = classView.getClasses() + "班学员作业成绩.xls";
				response.setHeader("Content-Disposition", getFileName(fileName, getExplorer(request)));
				excel.exportExcel("全体学员", head, fieldNames, examList, out);
			}else if(exam_type==2){
				String[] head = {"学员姓名", "加入时间","研讨名称","参与次数"};
				String[] fieldNames = { "username", "join_time", "name", "grade",};
				String fileName = classView.getClasses() + "班学员研讨成绩.xls";
				response.setHeader("Content-Disposition", getFileName(fileName, getExplorer(request)));
				excel.exportExcel("全体学员", head, fieldNames, examList, out);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	// 需要判断是什么浏览器
	private String getExplorer(HttpServletRequest request){
		String agent = request.getHeader("USER-AGENT"); 
		if(agent != null){
			//ie
	        if (agent.indexOf("MSIE") >= 0) {
	            return "IE";
	        }
	        //firefox
	        else if (agent.indexOf("Firefox") >= 0) {
	            return "Firefox";
	        }
	        //Chrome
	        else if(agent.indexOf("Chrome") >= 0){
	            return "Chrome";
	        }
	        //Opera
	        else if(agent.indexOf("Opera") >= 0){
	            return"Opera";
	        }
	        //Safari
	        else if(agent.indexOf("Safari") >= 0){
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
	 * 
	 * 结业
	 * @author sunyu
	 * @param response
	 * @param id
	 * @return
	 */
	@RequestMapping("/change_status")
	public String completeClass(HttpServletResponse response, ClassView classView) {
		JSONObject result = new JSONObject();
		try {
			if(classView.getStatus()==4){//已完成->结业
				classView.setComplete_time(new Date());
			}
			classService.update(classView);
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			e.printStackTrace();
			log.error("结业失败", ExceptionUtil.getExceptionMessage(e));
		}
		return null;
	}
	/**
	 * 
	 * 跳转班级分数管理
	 * @author sunyu
	 * @param classView
	 * @return
	 */
	@RequestMapping("/to_class_theme_discuss")
	public ModelAndView toClassThemeDiscuss(HttpServletRequest request,ClassView classView) {
		ModelAndView mv = new ModelAndView();
		try {
		    String sign = classView.getSign();
			String flag = classView.getFlag();
			Long classId = classView.getId();
			Long source_id = classView.getSource_id();
			Integer source_type = classView.getSource_type();
			String required = request.getParameter("required");
			if ( classId!= null && source_type!= null) {
				classView = classService.selectOne(classId,source_type);
				if (source_type == 0) {// 班级来源于课程
					List<ClassTestView> themeDiscuss = classService.searchClassTopic(classView);
					mv.addObject("themeDiscuss", themeDiscuss);
				}else if (source_type == 1) {// 班级来源于培训
					Train train = trainService.getById(source_id);
					if (train.getType() == 1) {//阶段培训
						List<TrainPhaseView> trainPhaseList = examService.queryTrainPhaseExam(classId,source_id);
						mv.addObject("trainPhaseList", trainPhaseList);
					} else if (train.getType() == 0) {//普通培训
						mv.addObject("required", required);
						List<CourseView> trainCourse = new ArrayList<CourseView>();
						if("1".equals(required)){
							//必修课程
							trainCourse = trainCourseService.queryTrainCourseExam(classId,0,source_id,0);
						}else if("0".equals(required)){
							//选修课程
							trainCourse = trainCourseService.queryTrainCourseExam(classId,0,source_id,1);
						}
						mv.addObject("trainCourse", trainCourse);
					}
					mv.addObject("train_type", train.getType());
				}
				classView.setSign(sign);
				classView.setFlag(flag);
			}
			mv.addObject("classView", classView);
			mv.setViewName("frontstage/train/class/class_theme_discuss");
			mv.addObject("head_title", "主题研讨");
		} catch (Exception e) {
			e.printStackTrace();
			log.error("跳转班级主页失败", ExceptionUtil.getExceptionMessage(e));
		}
		return mv;
	}
	
	@RequestMapping("course_discuss")
	public ModelAndView toTrainCourse(HttpServletRequest request, ClassView classView) {
		ModelAndView modelAndView = new ModelAndView();
		String sign = classView.getSign();
		String flag = classView.getFlag();
		Long classId = classView.getId();//培训班级id
		Integer source_type = classView.getSource_type();
		Long course_id = classView.getSource_id();
		Long class_id = classView.getClass_id();//培训课程班级id
		String required = request.getParameter("required");
		if (classId != null && source_type != null) {
			List<ClassTestView> themeDiscuss = classService.searchClassTopic(classView);
			modelAndView.addObject("themeDiscuss", themeDiscuss);
			classView = classService.selectOne(classId, source_type);
	    }
		Course course = courseService.getById(course_id);
		classView.setType(2);//表示存在子级班级：培训课程班级
		classView.setCourseId(course_id);
		classView.setClass_id(class_id);
		classView.setSign(sign);
		classView.setFlag(flag);
        modelAndView.addObject("classView", classView);
        modelAndView.addObject("required", required);
        modelAndView.addObject("courseTitle", course.getTitle());
        modelAndView.addObject("head_title", "主题研讨");
		modelAndView.setViewName("frontstage/train/class/class_theme_discuss");
		return modelAndView;
	}	
	/**
	 * 
	 * 跳转班级分数管理
	 * @author sunyu
	 * @param classView
	 * @return
	 */
	@RequestMapping("/to_class_student_scores_manage")
	public ModelAndView toClassStudentScoresManage(HttpServletRequest request,ClassView classView,ExamView examView) {
		ModelAndView mv = new ModelAndView();
		String class_type = request.getParameter("class_type");
		try {
			String sign = classView.getSign();
			String flag = classView.getFlag();
			Long classId = classView.getId();
			Long courseId = classView.getCourseId();
			Integer source_type = classView.getSource_type();
			List<ExamView> examList = null;
			if ( classId!= null && source_type!= null) {
				classView = classService.selectOne(classId,source_type);
				classView.setSign(sign);
				classView.setFlag(flag);
				classView.setCourseId(courseId);
				examView.setSource_id(classId);
			}
			mv.addObject("classView", classView);
			String search_info = examView.getSearch_info();
			if(search_info!=null&&search_info!=""){
				TeacherRelationView user = userService.searchUser(search_info,"all");
				if(user!=null){
					examView.setUser_id(user.getId());
				}
			}
			examView.setRows(10);
			if (examView.getPage() == 0) {
				examView.setStartLine(0);
			} else {
				examView.setStartLine(examView.getPage() * examView.getRows());
			}
			if(examView.getExam_type()!=2){
				int total = classService.countClassStudentScore(examView);
				examView.setTotal(total);
				examView.setTotalPage(NumUtil.totalPage(total, examView.getRows()));
				examList = classService.queryClassStudentScore(examView);
			}else if(examView.getExam_type()==2){
				int total = classService.countDiscussScore(examView);
				examView.setTotal(total);
				examView.setTotalPage(NumUtil.totalPage(total, examView.getRows()));
				examList = classService.queryDiscussScore(examView);
			}
			CourseHour courseHour=courseHourService.getHour(examView.getCourse_hour_id()+"");
			examView.setName(courseHour.getHour_title());
			mv.addObject("examList", examList);
			mv.addObject("examView", examView);
			mv.addObject("class_type", class_type);
			mv.addObject("commonTrain", request.getParameter("commonTrain"));
			mv.addObject("required", request.getParameter("required"));
			mv.setViewName("frontstage/train/class/class_student_scores_manage");
			mv.addObject("head_title", "成绩管理");
		} catch (Exception e) {
			e.printStackTrace();
			log.error("跳转班级主页失败", ExceptionUtil.getExceptionMessage(e));
		}
		return mv;
	}

	/**
	 * 
	 * 跳转研讨详情
	 * @param classView
	 * @return
	 */
	@RequestMapping("/to_class_subject_student_discuss")
	public ModelAndView toClassSubjectStudentDiscuss(ClassView classView,UserDiscussView userDiscussView,HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		String required = request.getParameter("required");
		try {
			String sign = classView.getSign();
			String flag = classView.getFlag();
			Long classId = classView.getId();
			Integer source_type = classView.getSource_type();
			Long class_id = classView.getClass_id();//培训课程班级id
			Long course_id = classView.getCourseId();//培训课程id
			if ( classId!= null && source_type!= null) {
				classView = classService.selectOne(classId,source_type);
				if (source_type == 0) {// 班级来源于课程
					
				}else if (source_type == 1) {// 班级来源于培训
					mv.addObject("required", required);
					classView.setClass_id(class_id);
					classView.setCourseId(course_id);
				}
				classView.setSign("6");
				classView.setFlag(flag);
				userDiscussView.setClass_id(classId);
			}
			mv.addObject("classView", classView);
			CourseHour courseHour = courseHourService.getHour(userDiscussView.getCourse_hour_id()+"");
			mv.addObject("courseHour", courseHour);
			String search_info = userDiscussView.getSearch_info();
			if(search_info!=null&&search_info!=""){
				TeacherRelationView user = userService.searchUser(search_info,"all");
				if(user!=null){
					userDiscussView.setUser_id(user.getId());
				}
				mv.addObject("search_info", search_info);
			}
			userDiscussView.setRows(10);
			if (userDiscussView.getPage() == 0) {
				userDiscussView.setStartLine(0);
			} else {
				userDiscussView.setStartLine(userDiscussView.getPage() * userDiscussView.getRows());
			}
			int total = userDiscussService.countClassDiscuss(userDiscussView);
			userDiscussView.setTotal(total);
			userDiscussView.setTotalPage(NumUtil.totalPage(total, userDiscussView.getRows()));
			mv.addObject("userDiscussView", userDiscussView);
			List<UserDiscussView> discussList = userDiscussService.queryClassDiscuss(userDiscussView);
			mv.addObject("discussList", discussList);
			mv.setViewName("frontstage/train/class/class_subject_student_discuss");
			mv.addObject("head_title", "主题研讨");
		} catch (Exception e) {
			e.printStackTrace();
			log.error("跳转班级主页失败", ExceptionUtil.getExceptionMessage(e));
		}
		return mv;
	}
	
	
	/**
	 * 
	 * 跳转班级分数管理
	 * @author sunyu
	 * @param classView
	 * @return
	 */
	@RequestMapping("/to_class_setting")
	public ModelAndView toClassSetting(ClassView classView) {
		ModelAndView mv = new ModelAndView();
		List<TeacherRelationView> teacherView = new ArrayList<>();
		try {
			String sign = classView.getSign();
			String flag = classView.getFlag();
			Long classId = classView.getId();
			Integer source_type = classView.getSource_type();
			if ( classId!= null && source_type!= null) {
				classView = classService.selectOne(classId,source_type);
				if (source_type == 0) {// 班级来源于课程
					teacherView = teacherRelationService.queryTeacherRelation(classId, 1, 1);
				}
				if (source_type == 1) {// 班级来源于培训
					teacherView = teacherRelationService.queryTeacherRelation(classId, 2, 1);
				}
				classView.setSign(sign);
				classView.setFlag(flag);
				//助教
				TeacherRelation teacherRelation = new TeacherRelation();
				teacherRelation.setSource_id(classId);
				teacherRelation.setSource_type(source_type + 1);
				teacherRelation.setType(1);
				List<TeacherView> assiantList = teacherRelationService.queryAssaint(teacherRelation);
				mv.addObject("assiantList", assiantList);
				
				//获取当前分类
				ClassBelongs cb = classBelongsService.selectClassBelongsByClassId(classId);
				if(cb!=null){
					classView.setClassBelongsId(cb.getId());
					classView.setClassifyId(cb.getClassify_relation_id());
					classView.setCommunityId(cb.getSource_id());
					classView.setCommunityType(cb.getSource_type());
					//
					ClassifyRelationView classifyReV = new ClassifyRelationView();
					classifyReV.setParent_id(null);
					classifyReV.setSource_id(cb.getSource_id());
					classifyReV.setSource_type(cb.getSource_type());
					classifyReV.setType(source_type);
					//获取社区列表
					if(classifyReV.getSource_type()==0){
						List<Community> communitys = communityService.queryCommunitys(); 
						mv.addObject("communitys",communitys);
					}else if(classifyReV.getSource_type()==1){
						List<Workshop> workshops = workshopService.queryWorkshops();
						mv.addObject("workshops",workshops);
					}
					//获取分类列表
					List<ClassifyRelationView> classifyRealtionViews = classifyRelationService.queryAllClassify(classifyReV);						mv.addObject("classifyRealtionViews", classifyRealtionViews);
				}
			}
			mv.addObject("teacherView", teacherView);
			mv.addObject("classView", classView);
			// 根据id查询开班范围的子分类
			List<Classify> classifys = classifyService.queryByParentId(33l);
			mv.addObject("classifys", classifys);
			mv.setViewName("frontstage/train/class/class_setting");
			mv.addObject("head_title", "班级设置");
		} catch (Exception e) {
			e.printStackTrace();
			log.error("跳转班级主页失败", ExceptionUtil.getExceptionMessage(e));
		}
		return mv;
	}
	
	/**
	 * @author fangxiongwei
	 * @date 2017年3月13日
	 * 助教班级列表
	 */
	@RequestMapping("/to_tutor_class")
	public ModelAndView toTutorClass(HttpServletRequest request,TutorClassView tutorClassView){
		ModelAndView modelAndView = new ModelAndView();
		User user = (User) request.getSession().getAttribute("currentUser");
		String state = request.getParameter("state");
		String stamp = request.getParameter("stamp");
		try {
			tutorClassView.setUserId(user.getId());
			tutorClassView.setRows(6);
			if(tutorClassView.getPage()==0){
				tutorClassView.setStartLine(0);
			}else{
				tutorClassView.setStartLine(tutorClassView.getPage()*tutorClassView.getRows());
			}
			List<TutorClassView> tutorClassList = classService.queryTutorClass(tutorClassView);
			int total = classService.queryTotalTutorClass(tutorClassView);//助教班级总数
			tutorClassView.setTotal(total);
			//分页总页数
			tutorClassView.setTotalPage(NumUtil.totalPage(total,tutorClassView.getRows()));
			
			modelAndView.addObject("tutorClassList",tutorClassList);
			modelAndView.addObject("tutorClassView",tutorClassView);
			
			UserInfo userInfo = userInfoService.getByUserId(user.getId());
			request.setAttribute("user", user);
			request.setAttribute("userInfo", userInfo);
			//个人中心统计数据  
			UserCenterView userCenter = userService.queryUserCenter(user.getId());
			modelAndView.addObject("userCenter", userCenter);
			modelAndView.addObject("head_title", "助教班级");
			request.setAttribute("state", state);
			request.setAttribute("stamp", stamp);
			modelAndView.setViewName("frontstage/train/class/tutor_class");
		} catch (Exception e) {
			log.error("跳转助教班级失败", ExceptionUtil.getExceptionMessage(e));
		}
		return modelAndView;
	}
	//获取需要通知的用户
	@RequestMapping("/get_unfinish")
	public void getUnfinish(CourseHourView courseHourView, HttpServletResponse response, HttpServletRequest request) throws Exception {
		
		JSONObject result = new JSONObject();
	  List<User> users=userClassHourService.queryUnfinish(courseHourView);
	  if(users==null||users.size()<1){
		  UserTrainClass userTrainClass=new UserTrainClass();
		  userTrainClass.setSource_id(courseHourView.getSource_id());
		  userTrainClass.setCourse_id(courseHourView.getId());
		users=userTrainClassService.queryUnfinish(userTrainClass);
	  }
	  result.put("users", users);
		ResponseUtil.write(response, result);
	}
	
	/*release_class*/
	
	@RequestMapping("/to_class_data")
	public ModelAndView toClassData(HttpServletRequest request, ClassView classView) {
		ModelAndView mv = new ModelAndView();
		try {
			String sign = request.getParameter("sign");
			String flag = request.getParameter("flag");
			Long id = Long.parseLong(request.getParameter("id"));
			if (id != null) {
				if (classView.getSource_type() == 0) {
					CourseView courseView = courseInfoService.queryCourseDetail(id);
					courseView.setFlag(flag);
					courseView.setSign(sign);
					mv.addObject("courseView", courseView);
				} else {
					TrainView trainView = new TrainView();
					trainView.setId(id);
					trainView = trainService.getByTrain(trainView);
					trainView.setSign(sign);
					trainView.setFlag(flag);
					mv.addObject("trainView", trainView);
				}
			}
			ClassData classData = new ClassData();
			classData.setCourse_id(id);
			List<ClassData> classDataList = classService.queryClassData(classData);
			mv.addObject("classDatas", classDataList);
			mv.setViewName("frontstage/train/course/class_data");
		} catch (Exception e) {
			e.printStackTrace();
			log.error("跳转课程班级页面失败", ExceptionUtil.getExceptionMessage(e));
		}
		return mv;
	}
	
	/**
	 * sunyu
	 * 20170414
	 * 异步查询班级完成状态
	 */
	@RequestMapping("/queryComplete")
	public String queryClassComplete(HttpServletResponse response,ClassView classView) {
		JSONObject result = new JSONObject();
		ClassRelation cr = classRelationService.getByClassId(classView.getId());
		Long classId = cr.getClass_id();
		Integer source_type = cr.getSource_type();
		Long learnId = cr.getSource_id();//课程id，培训id
		UserStudyView userStudyView = new UserStudyView();
		userStudyView.setSourceId(classId+"");
		userStudyView.setSourceType(source_type+"");
		boolean complete = true;
		try {
			if(source_type==0){//课程
				List<UserClassHour> allClassHour = userClassHourService.queryAll(classId);
				for(UserClassHour uc : allClassHour){
					if(uc.getIs_studyed()!=1){//未学完
						complete = false;
						break;
					}
				}
			}else if(source_type==1){//培训
				Train train = trainService.getById(learnId);
				List<Long> courseIdList = new ArrayList<Long>();
				UserCertificateView uc = new UserCertificateView();
				uc.setTrain_id(learnId);
				if(train.getType()==0){//普通培训
					courseIdList = certificateService.queryCommonTrainCourseId(uc);
				}else if(train.getType()==1){//阶段培训
					courseIdList = certificateService.queryPhaseTrainCourseId(uc);
				}
				checkCourse:
					for(Long courseId : courseIdList){
						//课程培训班级id
						Long courseClassId = classService.searchCourseTrainClass(courseId);
						if(courseClassId!=null){
							List<UserClassHour> allClassHour = userClassHourService.queryAll(courseClassId);
							for(UserClassHour uch : allClassHour){
								if(uch.getIs_studyed()!=1){//未学完
									complete = false;
									break checkCourse;
								}
							}
						}
					}
			}
			Integer num = userStudyService.countStudent(userStudyView);
			result.put("num", num);
			result.put("complete", complete);
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			e.printStackTrace();
			log.error("查询班级完成状态失败", ExceptionUtil.getExceptionMessage(e));
		}
		return null;
	}
	
	/**
	 * 获取社区[工作坊]列表
	 * @author heliwei
	 */
	@RequestMapping("query_communitys")
	@ResponseBody
	public String queryCommunitys(HttpServletRequest request,HttpServletResponse response){
		try{
			JSONArray jsonArray= new JSONArray();
			int type = Integer.parseInt(request.getParameter("communityType"));
			if(type==0){
				List<Community> communitys = communityService.queryCommunitys();
				jsonArray.addAll(communitys);
			}else if(type==1){
				List<Workshop> workshops = workshopService.queryWorkshops();
				jsonArray.addAll(workshops);
			}
			ResponseUtil.write(response, jsonArray);
		}catch(Exception e){
			log.error("查询社区(工作坊)列表失败",ExceptionUtil.getExceptionMessage(e));
		}
		return null;
	}
	
	/**
	 * 查询班级分类
	 * @author heliwei
	 */
	@RequestMapping("query_classifys")
	@ResponseBody
	public String queryClassifys(HttpServletRequest request,HttpServletResponse response){
		try{
			JSONArray jsonArray = new JSONArray();
			int source_type = Integer.parseInt(request.getParameter("community_type"));
			int type = Integer.parseInt(request.getParameter("type"));
			long source_id = Integer.parseInt(request.getParameter("community_id"));
			ClassifyRelationView classifyRelationView = new ClassifyRelationView();
			classifyRelationView.setSource_id(source_id);
			classifyRelationView.setType(type);
			classifyRelationView.setSource_type(source_type);
			List<ClassifyRelationView> classifyRelationViews = classifyRelationService.queryAllClassify(classifyRelationView);
			jsonArray.addAll(classifyRelationViews);
			ResponseUtil.write(response, jsonArray);
		}catch(Exception e){
			log.error("查询班级分类列表失败",ExceptionUtil.getExceptionMessage(e));
		}
		return null;
	}
	
	/**
	 * 查询课程班级列表 
	 * @author heliwei
	 */
	@RequestMapping("query_course_classes")
	@ResponseBody
	public String queryCourseClasses(HttpServletRequest request,HttpServletResponse response){
		try{
			User user = (User) request.getSession().getAttribute("currentUser");
			if(user==null){
				return null;
			}
			long source_id = Long.parseLong(request.getParameter("source_id"));
			int source_type = Integer.parseInt(request.getParameter("source_type"));
			int type = Integer.parseInt(request.getParameter("type"));
			int jumpType = Integer.parseInt(request.getParameter("jumpType"));
			String jIdstr = request.getParameter("jumpId");
			Long jumpId = null;
			if(jIdstr!=null&&!"".equals(jIdstr.trim())){
				jumpId = Long.parseLong(jIdstr);
			}
			ClassView classView = new ClassView();
			classView.setCurrent_user(user.getId());
			classView.setSource_id(source_id);
			classView.setSource_type(source_type);
			classView.setEnd_time(new Date());
			classView.setJumpId(jumpId);
			classView.setJumpType(jumpType);
			//type 0-课程 1-简单培训 2-培训阶段
			if(type==0){
				classView.setType(0);
			}else if(type==1){
				classView.setType(1);
				classView.setTrainType(0);
			}else if(type==2){
				classView.setType(1);
				classView.setTrainType(1);
			}
			List<ClassView> classList = classService.queryClassesofCourse(classView);
			System.out.println(classList);
			JSONArray jsonArray = new JSONArray();
			jsonArray.addAll(classList);
			ResponseUtil.write(response, jsonArray);
		}catch(Exception e){
			log.error("查询课程班级列表失败",ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 班级公告管理
	 * @author heliwei
	 */
	@RequestMapping("to_class_notice_manager")
	public ModelAndView class_notice_manager(HttpServletRequest request,MessageView messageView){
		ModelAndView mv = new ModelAndView();
		try{
			String sign = request.getParameter("sign");
			String flag = request.getParameter("flag");
			Long classId = Long.parseLong(request.getParameter("classId"));
			Long sourceId =  Long.parseLong(request.getParameter("source_id"));
			Integer source_type = Integer.parseInt(request.getParameter("source_type"));
			ClassView classView = null;
			if ( classId!= null && source_type!= null) {
				classView = classService.selectOne(classId,source_type);
				classView.setSign(sign);
				classView.setFlag(flag);
			}
			messageView.setSource_id(classId);
			if(source_type==0){
				messageView.setSource_type(2);
			}else if(source_type==1){
				messageView.setSource_type(3);
			}
			messageView.setRows(6);
			if(messageView.getPage()==0){
				messageView.setStartLine(0);
			}else{
				messageView.setStartLine(messageView.getRows()*messageView.getPage());
			}
			int total = messageService.queryClassNoticesCount(messageView);
			messageView.setTotal(total);
			messageView.setTotalPage(NumUtil.totalPage(total, messageView.getRows()));
			List<MessageView> messageList = messageService.queryClassNotices(messageView);
			mv.addObject("classView", classView);
			mv.addObject("messageList", messageList);
			mv.addObject("messageView",messageView);
			mv.setViewName("frontstage/train/class/class_notice");
			mv.addObject("head_title", "公告管理");
		}catch(Exception e){
			log.error("查询班级公告管理失败",ExceptionUtil.getExceptionMessage(e));
		}
		return mv;
	}
	
	/**
	 * 创建/更新班级公告信息页面跳转
	 * @author heliwei
	 */
	@RequestMapping("to_add_or_update_class_notice")
	public ModelAndView add_or_update_class_notice(HttpServletRequest request,ClassView classView){
		ModelAndView mv = new ModelAndView();
		try{
			String messageId = request.getParameter("messageId");
			String sign = classView.getSign();
			String flag = classView.getFlag();
			Long classId = classView.getId();
			Long sourceId = classView.getSource_id();//目前是课程id
			Integer source_type = classView.getSource_type();
			classView = classService.selectOne(classId,source_type);
			classView.setSign(sign);
			classView.setFlag(flag);
			if(messageId!=null&&!"".equals(messageId.trim())){
				Long id = Long.parseLong(messageId);
				MessageView messageView = messageService.selectOne(id);
				mv.addObject("messageView", messageView);
			}
			mv.addObject("classView", classView);
			mv.addObject("head_title", "新建班级公告");
			mv.setViewName("frontstage/train/class/class_add_notice");
		}catch(Exception e){
			log.error("跳转创建/更新班级公告信息页面跳转失败",ExceptionUtil.getExceptionMessage(e));
		}
		return mv;
	}
	
	/**
	 * 保存班级公告
	 * @author heliwei
	 */
	@RequestMapping("save_class_notice")
	public ModelAndView save_class_notice(HttpServletRequest request,MessageView messageView){
		ModelAndView mv = new ModelAndView();
		try{
			User user = (User) request.getSession().getAttribute("currentUser");
			Long classId = Long.parseLong(request.getParameter("classId"));
			String sign = request.getParameter("sign");
			String flag = request.getParameter("flag");
			Integer source_type = messageView.getSource_type();
			if ( classId!= null && source_type!= null) {
				if(messageView!=null&&user!=null){
					messageView.setSource_id(classId);
					messageView.setUser_id(user.getId());
					if(messageView.getSource_type()==0){
						messageView.setSource_type(2);
					}else if(messageView.getSource_type()==1){
						messageView.setSource_type(3);
					}
					if(messageView.getId()==null){
						messageService.saveMessage(messageView);
					}else{
						messageService.updateMessage(messageView);
					}
				}
			}
			mv.setViewName("redirect:/class/to_class_notice_manager.action?classId="+classId+"&flag="+flag+"&sign="+sign+"&source_id="+messageView.getSource_id()+"&source_type="+source_type);
		}catch(Exception e){
			log.error("保存班级公告失败",ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}
		return mv;
	}
	
	/**
	 * 删除消息
	 * @author heliwei
	 */
	@RequestMapping("del_class_notice")
	public ModelAndView delClassNotice(HttpServletRequest request,MessageView messageView){
		ModelAndView modelAndView = new ModelAndView();
		try{
			Long classId = Long.parseLong(request.getParameter("classId"));
			String sign = request.getParameter("sign");
			String flag = request.getParameter("flag");
			Integer source_type = messageView.getSource_type();
			messageService.delClassNotice(messageView.getId());
			modelAndView.setViewName("redirect:/class/to_class_notice_manager.action?classId="+classId+"&flag="+flag+"&sign="+sign+"&source_id="+messageView.getSource_id()+"&source_type="+source_type);
		}catch(Exception e){
			log.error("删除班级公告失败",ExceptionUtil.getExceptionMessage(e));
		}
		return modelAndView;
	}
	
	/**
	 * 批量删除消息
	 * @author heliwei
	 */
	@RequestMapping("batch_del_class_notice")
	public ModelAndView batchDelClassNotice(HttpServletRequest request,MessageView messageView){
		ModelAndView modelAndView = new ModelAndView();
		try{
			Long classId = Long.parseLong(request.getParameter("classId"));
			String sign = request.getParameter("sign");
			String flag = request.getParameter("flag");
			Integer source_type = messageView.getSource_type();
			String ids = messageView.getIds();
			if(ids!=null&&!"".equals(ids.trim())){
				String[] idsStr = ids.split(",");
				long[] idsNum = new long[idsStr.length];
				for(int i=0;i<idsNum.length;i++){
					idsNum[i] = Long.parseLong(idsStr[i]);
				}
				messageService.batchDelClassNotice(idsNum);
			}
			modelAndView.setViewName("redirect:/class/to_class_notice_manager.action?classId="+classId+"&flag="+flag+"&sign="+sign+"&source_id="+messageView.getSource_id()+"&source_type="+source_type);
		}catch(Exception e){
			log.error("批量删除班级公告失败",ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}
		return modelAndView;
	}
	
	@RequestMapping("/query_user_ajax")
	public void queryUserAjax(TrainCourseView trainCourseView, HttpServletResponse response, HttpServletRequest request) throws Exception {
		
		JSONObject result = new JSONObject();
		List<TrainCourseView>	trainCourseViews = trainCourseService.queryUserCourseStudy(trainCourseView);
	  result.put("trainCourseViews", trainCourseViews);
		ResponseUtil.write(response, result);
	}
	
	@RequestMapping("/show_msg_detail")
	@ResponseBody
	public String showMsgDetail(HttpServletRequest request,HttpServletResponse response){
		try{
			long id = Long.parseLong(request.getParameter("id"));
			MessageView messageView = messageService.queryClassNoticeDetail(id);
			JSONObject json = new JSONObject();
			json.put("messageView", messageView);
			ResponseUtil.write(response, json);
		}catch(Exception e){
			log.error("查询班级公告详情失败",ExceptionUtil.getExceptionMessage(e));
		}
		return null;
	}

}
