package cn.bnsr.edu_yun.frontstage.train.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.train.po.UserStudy;
import cn.bnsr.edu_yun.frontstage.train.po.UserTrainClass;
import cn.bnsr.edu_yun.frontstage.train.view.CourseView;
import cn.bnsr.edu_yun.frontstage.train.view.TrainCourseView;
import cn.bnsr.edu_yun.frontstage.train.view.UserStudyView;
import cn.bnsr.edu_yun.frontstage.train.view.UserTrainClassView;

public interface UserTrainClassService {

	void saveOrUpdate(UserTrainClass userTrainClass);

	//TODO 后续用户多个班级优化
	/**查询用户购买课程班级id*/
	List<UserStudy> searchCourseClassId(UserStudyView userStudyView);

	/**根据阶段id用户id,选修课程id查询阶段课程*/
	List<CourseView> queryTrainCourse(Long sourceId, Long userId,Long classId,List<String> list);

	/**查询用户培训课程学习情况*/
	List<TrainCourseView> searchIsStudy(TrainCourseView tcv);
	
	/**根据班级id查询班级学员
	 * @param trainType */
	List<UserStudyView> searchTrainClassStudent(Long classId, int trainType);
	
	/**通过条件查询UserTrainClass*/
	List<UserTrainClass> queryUserTrainClass(UserTrainClass userTrainClass);
	
	int selectCountByCourseIdAndUserId(UserTrainClass userTrainClass);
	
	int selectCountByCourseIdAndUserIdStudy(UserTrainClass userTrainClass);
	
	List<UserTrainClass> queryUserTrainCourse(UserTrainClass userTrainClass);
	/* 查询培训选择课程、已完成、未完成课程学时数 */
	List<UserTrainClassView> queryUserTrainCourseCount(UserTrainClassView userTrainClassView);

	List<User> queryUnfinish(UserTrainClass userTrainClass);
	/* 查询普通培训的已完成的必修/选修课程学时数  */
	List<UserTrainClassView> queryPerTrainFinCourseCount(UserTrainClassView userTrainClassView);
	/* 查询已学完的阶段课程学时总数 */
	UserTrainClassView querystudyedPhaseCourseHour(UserTrainClassView userTrainClassView);
}
