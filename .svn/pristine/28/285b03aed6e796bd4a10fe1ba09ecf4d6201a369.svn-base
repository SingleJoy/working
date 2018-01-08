package cn.bnsr.edu_yun.frontstage.train.service;

import java.util.List;

import cn.bnsr.edu_yun.backstage.base.view.UserStatsView;
import cn.bnsr.edu_yun.backstage.content.view.ContentStatiView;
import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.base.view.UserDetailView;
import cn.bnsr.edu_yun.frontstage.train.po.UserStudy;
import cn.bnsr.edu_yun.frontstage.train.view.ClassView;
import cn.bnsr.edu_yun.frontstage.train.view.StudyCenterView;
import cn.bnsr.edu_yun.frontstage.train.view.StudyView;
import cn.bnsr.edu_yun.frontstage.train.view.UserStudyView;

public interface UserStudyService {

	/**保存或者更新student*/
	void saveOrUpdateStudent(UserStudy userStudy);
	
	/**统计student个数*/
	Integer countStudent(UserStudyView userStudyView);
	
	/**展示student*/
	List<UserStudyView> searchStudent(UserStudyView userStudyView);
	
	/**删除student*/
	void deleteStudent(String id);
	
	/**统计我加入的班级数量*/
	Integer countMyClass(StudyCenterView studyCenterView);
	
	Integer countUserSutdy(StudyView studyView);

	/**根据类型查询我的学习(课程、培训)*/
	List<StudyView> queryUserStudy(StudyView studyView);

	/**加入学习
	 * @throws Exception */
	boolean joinStudy(ClassView classView, User user) throws Exception;

	/**根据来源id、来源类型 0-课程，1-培训、学员id，查询用户学习情况*/
	List<UserStudy> searchUserStudy(UserStudyView userStudyView);

	/**根据id查询学习情况*/
	UserStudy getById(long id);

	void updateUserStudy(UserStudy userStudy);

	/**查询用户购买情况*/
	List<UserStudy> searchIsPay(UserStudyView userStudyView);

	void joinOptionCourse(Long courseId,Long userId,Long trainId, String phaseId, Long userStudyId);
   
	UserDetailView selectUserDetail(UserStudy userStudy);
	/** 报名(普通课程/专业培训/进阶培训)内容信息统计 */
	List<ContentStatiView> userStudyContentStati(ContentStatiView contentStatiView);
	
	List<UserStatsView> queryStuArea(UserStatsView condition);
	
	List<UserStatsView> queryAgeByStu(UserStatsView condition);
	
	
	
	
	
	
	
}
