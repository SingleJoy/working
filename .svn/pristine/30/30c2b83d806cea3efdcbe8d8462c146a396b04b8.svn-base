package cn.bnsr.edu_yun.frontstage.train.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.base.po.Label;
import cn.bnsr.edu_yun.frontstage.train.mapper.CourseLabelRelationMapper;
import cn.bnsr.edu_yun.frontstage.train.po.CourseLabelRelation;
import cn.bnsr.edu_yun.frontstage.train.service.CourseLabelRelationService;

public class CourseLabelRelationServiceImpl implements CourseLabelRelationService{
	@Autowired 
	private CourseLabelRelationMapper courseLabelRelationMapper;

	@Override
	public void insert(CourseLabelRelation clr) {
		courseLabelRelationMapper.insertSelective(clr);
	}

	@Override
	public List<Label> getByCourseId(Long courseId) {
		return courseLabelRelationMapper.getByCourseId(courseId);
	}

	@Override
	public void deleteCourseRelation(Long courseId) {
		courseLabelRelationMapper.deleteCourseRelation(courseId);
	}
}
