package cn.bnsr.edu_yun.frontstage.train.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.bnsr.edu_yun.frontstage.train.po.TrainCourse;
import cn.bnsr.edu_yun.frontstage.train.view.ClassView;
import cn.bnsr.edu_yun.frontstage.train.view.CourseView;
import cn.bnsr.edu_yun.frontstage.train.view.TrainCourseView;

public interface TrainCourseMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table train_course
     *
     * @mbggenerated Tue Dec 20 15:07:28 CST 2016
     */
    int deleteByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table train_course
     *
     * @mbggenerated Tue Dec 20 15:07:28 CST 2016
     */
    int insert(TrainCourse record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table train_course
     *
     * @mbggenerated Tue Dec 20 15:07:28 CST 2016
     */
    int insertSelective(TrainCourse record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table train_course
     *
     * @mbggenerated Tue Dec 20 15:07:28 CST 2016
     */
    TrainCourse selectByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table train_course
     *
     * @mbggenerated Tue Dec 20 15:07:28 CST 2016
     */
    int updateByPrimaryKeySelective(TrainCourse record);
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table train_course
     *
     * @mbggenerated Tue Dec 20 15:07:28 CST 2016
     */
    int updateByPrimaryKey(TrainCourse record);

	List<TrainCourseView> queryTrainCourse(TrainCourseView tcView);

	List<CourseView> queryPhaseCourse(@Param("phaseId")Long phaseId,@Param("isRequired")int isRequired);

	void deletePhaseCourse(TrainCourseView tcView);

	List<TrainCourseView> queryRequiredCourse(TrainCourseView tcv);
	
	List<CourseView> queryTrainCourseExam(@Param("id")Long id,@Param("trainType")Integer trainType,@Param("phaseId")Long phaseId,@Param("isRequired")int isRequired);
	
	int queryTrainCourseOfTrainCount(ClassView classView);
	
	List<TrainCourseView> queryCourseStudy(TrainCourseView trainCourseView);
	
	int queryCount(TrainCourseView trainCourseView);
	
	List<TrainCourseView> queryUserCourseStudy(TrainCourseView trainCourseView);

}