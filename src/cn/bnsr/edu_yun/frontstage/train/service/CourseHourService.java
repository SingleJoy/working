package cn.bnsr.edu_yun.frontstage.train.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.train.po.CourseHour;
import cn.bnsr.edu_yun.frontstage.train.view.CourseHourView;

public interface CourseHourService {

	long saveCourseHour(CourseHour courseHour);

	List<CourseHour> queryHourList(Long courseId,boolean flag);

	int searchSeq(String courseId, String chapterId);

	CourseHour getHour(String id);

	void updateCourseHour(CourseHour courseHour);

	void deleteHour(String id, String attributeType);

	List<CourseHour> queryAllHour(List<String> courseIds, boolean flag);
	
	List<CourseHourView> queryHourListUser(CourseHourView courseHourView);
	/** 查询当前课程的存在第一个课时数  */
	int queryHourOfCourseCount(long courseId);
	
	void sortCourseHour(String ids,String hourSeqs,String parent_ids);
	
	List<CourseHour> queryHourListByPid(Long parent_id);
	
	List<CourseHour> queryHourListByType(long course_id,int attribute_type);
}
