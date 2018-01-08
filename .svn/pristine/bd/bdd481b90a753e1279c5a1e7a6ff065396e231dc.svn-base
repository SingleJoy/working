package cn.bnsr.edu_yun.frontstage.train.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.base.po.Label;
import cn.bnsr.edu_yun.frontstage.train.po.CourseLabelRelation;

public interface CourseLabelRelationService {
	
	/**
	 * 保存课程标签关联表
	 */
	void insert(CourseLabelRelation clr);
	/**
	 * 根据课程id查询标签信息
	 */
	List<Label> getByCourseId(Long id);
	/**
	 * 根据课程id删除关联关系
	 */
	void deleteCourseRelation(Long courseId);

}
