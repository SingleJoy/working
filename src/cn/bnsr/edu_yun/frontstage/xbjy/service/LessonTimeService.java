package cn.bnsr.edu_yun.frontstage.xbjy.service;

import cn.bnsr.edu_yun.frontstage.xbjy.view.LessonTimeView;

public interface LessonTimeService {
	
	void saveAll(LessonTimeView lessonTimeView);
	
	void updateByLesssonId(LessonTimeView lessonTimeView);
	
	LessonTimeView findByLesson(Long lesson_id);
	 
}
