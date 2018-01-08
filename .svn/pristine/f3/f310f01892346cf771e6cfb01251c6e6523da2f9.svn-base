package cn.bnsr.edu_yun.frontstage.train.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.train.po.UserDiscuss;
import cn.bnsr.edu_yun.frontstage.train.view.ClassView;
import cn.bnsr.edu_yun.frontstage.train.view.UserDiscussView;

public interface UserDiscussService {
	
	/**统计班级主页的学生发言数*/
	int countClassHomeDiscuss(ClassView record);
	
	int insertDiscuss(UserDiscuss userDiscuss);
	
	List<UserDiscussView> queryDiscuss(UserDiscussView userDiscussView);
	
	/**查询班级的学生研讨发言*/
    List<UserDiscussView> queryClassDiscuss(UserDiscussView userDiscussView);
    /**查询班级的学生研讨发言数*/
	int countClassDiscuss(UserDiscussView userDiscussView);
	
	/**查询课时的某学生研讨发言数*/
	int countUserDiscuss(UserDiscuss userDiscuss);
	
	
}
