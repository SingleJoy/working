package cn.bnsr.edu_yun.frontstage.train.service;

import cn.bnsr.edu_yun.frontstage.train.po.CourseInfo;
import cn.bnsr.edu_yun.frontstage.train.view.CourseView;

public interface CourseInfoService {
	
	/**根据课程id查询课程详细信息*/
	CourseView queryCourseDetail(Long courseId);
	/**
	 * 修改课程详细
	 */
	void updateCourseDetail(CourseView courseView);
	/**
	 * 保存课程详细
	 */
	void insertCourseInfo(CourseInfo couserInfo);
	
	/**查询最大推荐课程序号*/
	int getMaxSeq();
	
	/**课程推荐、取消*/
	void isRecommendCourse(CourseView courseView);
}
