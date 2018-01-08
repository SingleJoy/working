package cn.bnsr.edu_yun.frontstage.train.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.frontstage.tiku.service.ExamService;
import cn.bnsr.edu_yun.frontstage.train.po.ClassRelation;
import cn.bnsr.edu_yun.frontstage.train.po.CourseHour;
import cn.bnsr.edu_yun.frontstage.train.po.Train;
import cn.bnsr.edu_yun.frontstage.train.service.ClassRelationService;
import cn.bnsr.edu_yun.frontstage.train.service.ClassService;
import cn.bnsr.edu_yun.frontstage.train.service.CourseHourService;
import cn.bnsr.edu_yun.frontstage.train.service.CourseInfoService;
import cn.bnsr.edu_yun.frontstage.train.service.TopicQuestionService;
import cn.bnsr.edu_yun.frontstage.train.service.TeacherRelationService;
import cn.bnsr.edu_yun.frontstage.train.service.TrainCourseService;
import cn.bnsr.edu_yun.frontstage.train.service.TrainService;
import cn.bnsr.edu_yun.frontstage.train.service.UserClassHourService;
import cn.bnsr.edu_yun.frontstage.train.service.UserStudyService;
import cn.bnsr.edu_yun.frontstage.train.view.ClassView;
import cn.bnsr.edu_yun.frontstage.train.view.CourseDataView;
import cn.bnsr.edu_yun.frontstage.train.view.CourseView;
import cn.bnsr.edu_yun.frontstage.train.view.TeacherRelationView;
import cn.bnsr.edu_yun.frontstage.train.view.TrainCourseView;
import cn.bnsr.edu_yun.frontstage.train.view.TrainPhaseView;
import cn.bnsr.edu_yun.frontstage.train.view.UserClassHourView;
import cn.bnsr.edu_yun.frontstage.train.view.UserStudyView;

@Controller
@RequestMapping("course_data")
public class CourseDataController {
	@Autowired
	private CourseInfoService courseInfoService;
	@Autowired
	private UserStudyService userStudyService;
	@Autowired
	private UserClassHourService userClassHourService;
	@Autowired
	private TopicQuestionService topicQuestionService;
	@Autowired
	private CourseHourService courseHourService;
	@Autowired
	private ClassService classService;
	@Autowired
	private TeacherRelationService teacherRelationService;
	@Autowired
	private ClassRelationService classRelationService;
	@Autowired
	private TrainService trainService;
	@Autowired
	private TrainCourseService trainCourseService;
	@Autowired
	private ExamService examService;

	@RequestMapping("/to_data")
	public ModelAndView to_data(ClassView classView, HttpServletResponse response, HttpServletRequest request) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		try {
			String sign = classView.getSign();
			String flag = classView.getFlag();
			Long source_id = classView.getSource_id();
			Integer type = classView.getSource_type();
			List<TeacherRelationView> teacherView = new ArrayList<>();
			Long classId = classView.getId();
			if (classId != null && type != null) {
				classView = classService.selectOne(classId, type);
				Long id = classView.getId();
				if (type == 0) {// 班级来源于课程
					teacherView = teacherRelationService.queryTeacherRelation(id, 1, 1);
					CourseView courseView = courseInfoService.queryCourseDetail(source_id);
					UserStudyView userStudyView = new UserStudyView();
					userStudyView.setSourceType(0 + "");
					userStudyView.setLearnId(source_id + "");
					userStudyView.setSourceId(classId + "");
					// 学习人数
					Integer studentCount = userStudyService.countStudent(userStudyView);
					userStudyView.setIs_studyed(1 + "");
					// 学完人数
					Integer finishCount = userStudyService.countStudent(userStudyView);

					CourseDataView courseDataView = new CourseDataView();
					courseDataView.setTitle(courseView.getTitle());
					courseDataView.setStudentCount(studentCount);
					courseDataView.setFinishCount(finishCount);
					UserClassHourView userClassHourView = new UserClassHourView();
					userClassHourView.setCourse_id(source_id);
					userClassHourView.setClass_id(classId);
					// 考试人数
					userClassHourView.setAttribute_type(0);
					courseDataView.setExamCount(userClassHourService.queryData(userClassHourView));
					// 研讨人数
					userClassHourView.setAttribute_type(3);
					courseDataView.setDiscussCount(userClassHourService.queryData(userClassHourView));
					// 作业人数
					userClassHourView.setAttribute_type(4);
					courseDataView.setHomeworkCount(userClassHourService.queryData(userClassHourView));
					// 提问人数
					modelAndView.addObject("courseDataView", courseDataView);
					List<CourseHour> hourList = courseHourService.queryHourList(source_id, false);
					List<CourseDataView> courseDataViews = new ArrayList<CourseDataView>();
					for (CourseHour hour : hourList) {
						CourseDataView data = new CourseDataView();
						data.setHour_title(hour.getHour_title());
						data.setAttribute_type(hour.getAttribute_type());
						userClassHourView.setAttribute_type(null);
						userClassHourView.setCourse_hour_id(hour.getId());
						userClassHourView.setIs_studyed(null);
						data.setStudentHourCount(userClassHourService.queryData(userClassHourView));
						userClassHourView.setIs_studyed(1);
						data.setFinishHourCount(userClassHourService.queryData(userClassHourView));
						double per = 0;
						if (data.getStudentHourCount() != 0)
							per = (data.getFinishHourCount() * 1.0) / data.getStudentHourCount();
						if (hour.getAttribute_type() == 0) {
							data.setExamPer(per);
						}
						if (hour.getAttribute_type() == 4) {

							data.setHomeworkPer(per);
						}
						if (hour.getAttribute_type() == 3) {
							data.setDiscussPer(per);
						}
						courseDataViews.add(data);
					}

					modelAndView.addObject("courseDataViews", courseDataViews);
				} else if (type == 1) {// 班级来源于培训
					if(classView.getTrainType()==0){
					teacherView = teacherRelationService.queryTeacherRelation(id, 2, 1);
					UserStudyView userStudyView = new UserStudyView();
					userStudyView.setSourceType(1 + "");
					userStudyView.setLearnId(source_id + "");
					userStudyView.setSourceId(classId + "");
					// 学习人数
					Integer studentCount = userStudyService.countStudent(userStudyView);
					userStudyView.setIs_studyed(1 + "");
					// 学完人数
					Integer finishCount = userStudyService.countStudent(userStudyView);
					Train train = trainService.getById(source_id);
					CourseDataView courseDataView = new CourseDataView();
					courseDataView.setTitle(train.getName());
					courseDataView.setStudentCount(studentCount);
					courseDataView.setFinishCount(finishCount);
					// 必修，选修
					TrainCourseView trainCourseView = new TrainCourseView();
					trainCourseView.setSource_id(source_id);
					trainCourseView.setClass_id(classId);
					int requiredCount = trainCourseService.queryCount(trainCourseView);
					courseDataView.setRequiredCount(requiredCount);
					List<CourseDataView> courseDataViews = new ArrayList<CourseDataView>();
					List<TrainCourseView> trainCourseViews = trainCourseService.queryCourseStudy(trainCourseView);
					for (TrainCourseView t : trainCourseViews) {
						CourseDataView data = new CourseDataView();
						CourseView courseView = courseInfoService.queryCourseDetail(t.getCourse_id());
						data.setTitle(courseView.getTitle());
						UserClassHourView userClassHourView = new UserClassHourView();
						userClassHourView.setCourse_id(t.getCourse_id());
						userClassHourView.setClass_id(classId);
						// 考试人数
						userClassHourView.setAttribute_type(0);
						data.setExamCount(userClassHourService.queryData(userClassHourView));
						// 研讨人数
						userClassHourView.setAttribute_type(3);
						data.setDiscussCount(userClassHourService.queryData(userClassHourView));
						// 作业人数
						userClassHourView.setAttribute_type(4);
						data.setHomeworkCount(userClassHourService.queryData(userClassHourView));
						// 学习人数
						data.setStudentCount(t.getDo_count()+t.getNot_do_count());
						// 学完人数
						data.setFinishCount(t.getDo_count());
						data.setIs_required(0);
						courseDataViews.add(data);
					}
					trainCourseView.setIs_required(1);
					int unrequiredCount = trainCourseService.queryCount(trainCourseView);
					courseDataView.setUnrequiredCount(unrequiredCount);
					trainCourseViews = trainCourseService.queryCourseStudy(trainCourseView);
					for (TrainCourseView t : trainCourseViews) {
						CourseDataView data = new CourseDataView();
						CourseView courseView = courseInfoService.queryCourseDetail(t.getCourse_id());
						data.setTitle(courseView.getTitle());
						UserClassHourView userClassHourView = new UserClassHourView();
						userClassHourView.setCourse_id(t.getCourse_id());
						userClassHourView.setClass_id(classId);
						// 考试人数
						userClassHourView.setAttribute_type(0);
						data.setExamCount(userClassHourService.queryData(userClassHourView));
						// 研讨人数
						userClassHourView.setAttribute_type(3);
						data.setDiscussCount(userClassHourService.queryData(userClassHourView));
						// 作业人数
						userClassHourView.setAttribute_type(4);
						data.setHomeworkCount(userClassHourService.queryData(userClassHourView));
						// 学习人数
						data.setStudentCount(t.getDo_count()+t.getNot_do_count());
						// 学完人数
						data.setFinishCount(t.getDo_count());
						data.setIs_required(1);
						courseDataViews.add(data);
					}
					modelAndView.addObject("courseDataViews", courseDataViews);
					modelAndView.addObject("courseDataView", courseDataView);

				}else{
					List<TrainPhaseView> trainPhaseList = examService.queryTrainPhaseExam(classId, source_id);
					modelAndView.addObject("trainPhaseList", trainPhaseList);	
					for(TrainPhaseView tp:trainPhaseList){
						tp.setCourseDataViewList(new ArrayList<CourseDataView>());
						List<CourseView> courseViews1 = tp.getRequiredCourse();
						for(CourseView c1:courseViews1){
							CourseDataView data = new CourseDataView();
							data.setTitle(c1.getTitle());
							UserClassHourView userClassHourView = new UserClassHourView();
							userClassHourView.setCourse_id(c1.getId());
							userClassHourView.setClass_id(classId);
							// 考试人数
							userClassHourView.setAttribute_type(0);
							data.setExamCount(userClassHourService.queryData(userClassHourView));
							// 研讨人数
							userClassHourView.setAttribute_type(3);
							data.setDiscussCount(userClassHourService.queryData(userClassHourView));
							// 作业人数
							userClassHourView.setAttribute_type(4);
							data.setHomeworkCount(userClassHourService.queryData(userClassHourView));
							// 学习人数
							data.setStudentCount(Integer.parseInt(c1.getStudentNum()));
							// 学完人数
							data.setFinishCount(Integer.parseInt(c1.getFinishedNum()));
							data.setIs_required(0);
							tp.getCourseDataViewList().add(data);
						}
						List<CourseView> courseViews2 = tp.getOptionCourse();
						for(CourseView c1:courseViews2){
							CourseDataView data = new CourseDataView();
							data.setTitle(c1.getTitle());
							UserClassHourView userClassHourView = new UserClassHourView();
							userClassHourView.setCourse_id(c1.getId());
							userClassHourView.setClass_id(classId);
							// 考试人数
							userClassHourView.setAttribute_type(0);
							data.setExamCount(userClassHourService.queryData(userClassHourView));
							// 研讨人数
							userClassHourView.setAttribute_type(3);
							data.setDiscussCount(userClassHourService.queryData(userClassHourView));
							// 作业人数
							userClassHourView.setAttribute_type(4);
							data.setHomeworkCount(userClassHourService.queryData(userClassHourView));
							// 学习人数
							data.setStudentCount(Integer.parseInt(c1.getStudentNum()));
							// 学完人数
							data.setFinishCount(Integer.parseInt(c1.getFinishedNum()));
							data.setIs_required(1);
							tp.getCourseDataViewList().add(data);
						}
					}
				}
			
				}
				classView.setSign(sign);
				classView.setFlag(flag);
				classView.setSource_id(source_id);
				classView.setSource_type(type);

				ClassRelation classRelation = classRelationService.selectOne(classId);
				modelAndView.addObject("classRelation", classRelation);
			}
			modelAndView.addObject("teacherView", teacherView);
			modelAndView.addObject("classView", classView);
			modelAndView.setViewName("frontstage/train/course/course_data");
			modelAndView.addObject("head_title", "班级学习数据");
		} catch (Exception e) {
                  e.printStackTrace();
		}
		return modelAndView;
	}
}
