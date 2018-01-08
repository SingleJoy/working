package cn.bnsr.edu_yun.frontstage.train.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.train.po.TrainCourse;
import cn.bnsr.edu_yun.frontstage.train.view.ClassView;
import cn.bnsr.edu_yun.frontstage.train.view.CourseView;
import cn.bnsr.edu_yun.frontstage.train.view.TrainCourseView;

public interface TrainCourseService {

	/**培训课程list*/
	List<TrainCourseView> queryTrainCourse(TrainCourseView tcView);
	
	/**保存培训课程*/
	void saveTrainCourse(TrainCourseView tcView);

	/**删除培训课程*/
	void deleteTrainCourse(Long id);
	
	/**接口调用插入培训课程*/
	void insertSelective(TrainCourse tc);

	/**根据阶段id，是否必修，查询阶段课程*/
	List<CourseView> queryPhaseCourse(Long phaseId, int isRequired);

	/**根据阶段id，或者培训id，课程id 删除阶段课程*/
	void deletePhaseCourse(TrainCourseView tcView);

	/**根据培训id查询普通培训必修课程*/
	List<TrainCourseView> queryRequiredCourse(TrainCourseView tcv);
	
	/**根据阶段id，是否必修，查询阶段课程班级*/
	List<CourseView> queryTrainCourseExam(Long id,int trainType,Long phaseId, int isRequired);

	/** 根据培训id和培训类型查询课时数是否存在至少一个 */
	int queryTrainCourseOfTrainCount(ClassView classView);
	
	List<TrainCourseView>  queryCourseStudy(TrainCourseView trainCourseView);
	
	int queryCount(TrainCourseView trainCourseView);
	
	List<TrainCourseView> queryUserCourseStudy(TrainCourseView trainCourseView);
}
