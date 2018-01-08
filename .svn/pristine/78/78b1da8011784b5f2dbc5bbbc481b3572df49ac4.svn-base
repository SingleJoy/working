package cn.bnsr.edu_yun.frontstage.train.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.tiku.view.ExamView;
import cn.bnsr.edu_yun.frontstage.train.po.Class;
import cn.bnsr.edu_yun.frontstage.train.view.ClassData;
import cn.bnsr.edu_yun.frontstage.train.view.ClassTestView;
import cn.bnsr.edu_yun.frontstage.train.view.ClassView;
import cn.bnsr.edu_yun.frontstage.train.view.TrainView;
import cn.bnsr.edu_yun.frontstage.train.view.TutorClassView;
import cn.bnsr.edu_yun.frontstage.train.view.UserTotalScoreView;

public interface ClassService {

	List<ClassView> find(ClassView classView);
	
	void delete(Long[] ids);
	
	void update(ClassView classView);
	
	Integer countClass(ClassView classView);
	
	String getCurrentClasses(ClassView classView);
	
	void saveAll(ClassView classView);
	
	ClassView selectOne(Long id,Integer source_type);
	
	void updateAll(ClassView classView);
	
	void saveUserStudy(ClassView classView);

	/**根据来源id，来源类型0-课程；1-培训，查询班级信息*/
	List<Class> queryClass(TrainView trainView);

	/**查询班级主页作业或考试*/
	List<ClassTestView> queryClassHomeTest(ClassView classView);
	
	/**查询班级主题讨论*/
	List<ClassTestView> queryClassTopic(ClassView classView);

	cn.bnsr.edu_yun.frontstage.train.po.Class getById(Long id);
	
	/**查询班级考试、作业*/
	List<ClassTestView> queryClassTest(ClassTestView testView);
	/**统计班级考试、作业数量*/
	Integer countClassTest(ClassTestView testView);
	
	/**查询班级讨论*/
	List<ClassTestView> queryClassTalking(ClassTestView testView);
	/**统计讨论数量*/
	Integer countClassTalking(ClassTestView testView);
	
	/**查询班级主题讨论(多出章节和讨论数)*/
	List<ClassTestView> searchClassTopic(ClassView classView);
	
	List<ExamView> queryClassStudentScore(ExamView examView);
	
	Integer countClassStudentScore(ExamView examView);
	
	List<ExamView> queryDiscussScore(ExamView examView);
	
	Integer countDiscussScore(ExamView examView);

	/**查询助教班级课程*/
	List<TutorClassView> queryTutorClass(TutorClassView tutorClassView);

	/**查询助教班级总数*/
	int queryTotalTutorClass(TutorClassView tutorClassView);
	/***/
	List<ClassTestView> queryClassHomeTest1(ClassView classView);

	List<UserTotalScoreView> queryUserTotalScore(ClassView classView);
	
	List<ClassData> queryClassData(ClassData classDataView);

	void saveClass(Class c);

	/**查询课程培训班级id*/
	Long searchCourseTrainClass(Long courseId);
	
	List<ClassTestView> queryMyCommunityDiscuss(ClassView classView);
	
	int queryTotalMyCommunityDiscuss(ClassView classView);
	/** 查询课程班级列表 */
	List<ClassView> queryClassesofCourse(ClassView classView);

}
