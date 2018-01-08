package cn.bnsr.edu_yun.frontstage.xbjy.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.xbjy.po.LessonUserIdentity;
import cn.bnsr.edu_yun.frontstage.xbjy.view.LessonHeadView;
import cn.bnsr.edu_yun.frontstage.xbjy.view.LessonLeftView;
import cn.bnsr.edu_yun.frontstage.xbjy.view.LessonUserIdentityView;
import cn.bnsr.edu_yun.frontstage.xbjy.view.LessonUserTaskView;

public interface LessonUserIdentityService {
	
	void saveAll(LessonUserIdentityView lessonUserIdentityView);
	
	
	/**
	  * 
	  * TODO 查询组员
	  * @param LessonUserIdentityView
	  * @return
	  */
	 List<LessonUserIdentityView> findTeacher(LessonUserIdentityView lessonUserIdentityView);

	 void deleteUser(String checkedId);
	 
	 List<LessonUserIdentityView> findUserByIdentity(LessonUserIdentityView lessonUserIdentityView);
	 
	 
	 void setUserIdentityBylu(LessonUserIdentityView lessonUserIdentityView);
	 
	 void setUserIdentity(LessonUserIdentityView lessonUserIdentityView);
	 LessonUserIdentity getById(Long id);
	 
	 //根据课例及用户身份统计组员
	 Integer countMember(LessonUserIdentityView lessonUserIdentityView);
	 
	 LessonUserIdentityView findUserIdentity(LessonUserIdentityView lessonUserIdentityView);


	LessonLeftView getLessonLeft(Long lesson_id, User user);


	LessonHeadView getLessonHead(Long lesson_id);


	Integer purviewStatus(LessonUserTaskView lessonUserTaskView, int purview);


	List<LessonUserIdentityView> findTeacherNozd(LessonUserIdentityView lessonUserIdentityView);
}
