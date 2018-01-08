package cn.bnsr.edu_yun.frontstage.train.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.bnsr.edu_yun.frontstage.train.po.TeacherRelation;
import cn.bnsr.edu_yun.frontstage.train.view.TeacherRelationView;
import cn.bnsr.edu_yun.frontstage.train.view.TeacherView;

public interface TeacherRelationService {

	void insertTeacherRelation(TeacherRelation teacherRelation);

	List<TeacherRelationView> queryTeacherRelation(Long sourceId,Integer sourceType,Integer type);

	void deleteAllCourseId(int type, Long source_id, int source_type);

	void saveTeacherRelation(TeacherRelationView teacherRelationView, Long userId);

	List<TeacherView> queryAssaint(TeacherRelation teacherRelation);

	/**根据课程ids 查询教师信息*/
	List<TeacherRelationView> queryAllTeacher(List<String> courseIds);

	void deleteTeacher(String id);
	/** 查询班级所属教职人员信息 */
	List<TeacherRelationView> queryTeacherOfClass(TeacherRelationView teacherRelationView);
	/* 查询课程教师名字列表  */
	List<String> queryCourseTeachersRealName(int type,Long sourceId,Integer sourceType);
}
