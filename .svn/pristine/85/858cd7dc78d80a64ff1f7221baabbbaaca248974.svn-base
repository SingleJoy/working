package cn.bnsr.edu_yun.frontstage.train.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.train.po.CourseExamStandard;
import cn.bnsr.edu_yun.frontstage.train.view.CourseExamStandardView;

public interface CourseExamStandardService {

	List<CourseExamStandardView> queryStandard(CourseExamStandardView examStandardView);
	
	void update(CourseExamStandardView courseExamStandardView);

	void saveExamStandard(CourseExamStandard ces);

	//删除课程考核标准
	void deleteExamStandard(Long course_hour_id);
	//统计课程的的评分总比例
	int queryTotalRatioByCouId(Long course_id);
}
