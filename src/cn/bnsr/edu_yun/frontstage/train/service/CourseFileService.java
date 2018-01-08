package cn.bnsr.edu_yun.frontstage.train.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.train.po.CourseFile;
import cn.bnsr.edu_yun.frontstage.train.view.CourseFileView;
import cn.bnsr.edu_yun.frontstage.train.view.CourseHourFileView;

public interface CourseFileService {

	Long saveFile(CourseFile courseFile);

	int queryCourseFileTotal(CourseFileView courseFileView);
	
	List<CourseFileView> queryCourseFile(CourseFileView courseFileView);

	void deleteCourseFile(String fileIds);
	
	CourseFile selectByKey(Long id);

	List<CourseFileView> queryFile(CourseFileView courseFileView);

	int queryTotalFile(CourseFileView courseFileView);

	void updateCourseFile(CourseFile courseFile);
	
	//根据课程资料获取课程文件
    CourseFileView getCourseFileByCourseHourFileIsTeacher(CourseHourFileView courseHourFileView);
    //根据课程资料获取课程文件
    CourseFileView getCourseFileByCourseHourFileIsStudent(CourseHourFileView courseHourFileView);
}
