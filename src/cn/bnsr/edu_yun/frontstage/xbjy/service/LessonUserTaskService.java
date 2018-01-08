package cn.bnsr.edu_yun.frontstage.xbjy.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.xbjy.po.LessonUserTask;
import cn.bnsr.edu_yun.frontstage.xbjy.view.LessonUserTaskView;


public interface LessonUserTaskService {
	
	void saveAll(LessonUserTaskView lessonUserTaskView);
	
	 void delTeacher(Long id);
	
	List<LessonUserTaskView> findUserByLesson(LessonUserTaskView lessonUserTaskView);
	 
	 LessonUserTaskView findByLUP(LessonUserTaskView lessonUserTaskView);
	 
	 LessonUserTask getById(Long id);
	 
	 List<LessonUserTaskView> findPurview(LessonUserTaskView lessonUserTaskView);
	 
	 Integer countTask(LessonUserTaskView lessonUserTaskView);
	 
	 List<LessonUserTaskView> findByPurview(LessonUserTaskView lessonUserTaskView);
	 
	 int update(LessonUserTaskView lessonUserTaskView);
}
