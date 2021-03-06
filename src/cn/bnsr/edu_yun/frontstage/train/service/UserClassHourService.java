package cn.bnsr.edu_yun.frontstage.train.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.train.po.UserClassHour;
import cn.bnsr.edu_yun.frontstage.train.po.UserStudy;
import cn.bnsr.edu_yun.frontstage.train.view.ClassView;
import cn.bnsr.edu_yun.frontstage.train.view.CourseHourView;
import cn.bnsr.edu_yun.frontstage.train.view.CourseRankView;
import cn.bnsr.edu_yun.frontstage.train.view.UserClassHourView;

public interface UserClassHourService {

    int insert(UserClassHour userClassHour);
	
	//查下一个没学课时
    UserClassHour selectByNextStudy(UserClassHour userClassHour);
	
	//查课程内所有课时数
	int selectCountByCourseIdAndUserId(UserClassHour userClassHour);
	
	//查课程内所有已学课时数
	int selectCountByCourseIdAndUserIdStudy(UserClassHour userClassHour);
	//查上一个和下一个
	UserClassHour selectByUpAndDown( long type, long course_hour_id,long course_id,long user_id,long source_id,int source_type);
	//修改状态
	int update(UserClassHour userClassHour);
	//按课时id查
	UserClassHour selectByHourId(UserClassHour userClassHour);
	//按自己id查
	UserClassHour selectById(long id);
	/**统计班级课时完成数*/
	int countCompleteCourseHour(ClassView ClassView);

	/**查询是|否学完数*/
	int countIsNotStudy(UserClassHourView uchv);

	/**查询用户是否学习该课程*/
	int queryIsNotStudy(UserClassHourView userClassHourView);
	/**统计数据查询*/
	int queryData(UserClassHourView userClassHourView);
	
	List<User> queryUnfinish(CourseHourView courseHourView);

	/**根据课程id，用户id查询该课程是否学完*/
	List<UserClassHourView> queryCourseStudyed(Long userId, Long courseId,Long classId);
	
	List<UserClassHour> queryAll(Long classId);
	/**查总成绩，并且获得证书*/
	void saveCert(UserClassHourView userClassHourView,UserStudy userStudy);
	
	/**退学时删除学习课时联系*/
	void deleteClassHour(Long user_id,Long class_id);
	
	List<CourseRankView> paceRank(CourseRankView courseRankView);
	
	List<CourseRankView> durationRank(CourseRankView courseRankView);
	
}
