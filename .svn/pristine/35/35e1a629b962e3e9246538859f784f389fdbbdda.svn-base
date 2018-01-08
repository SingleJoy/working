package cn.bnsr.edu_yun.frontstage.base.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.base.mapper.GradeMapper;
import cn.bnsr.edu_yun.frontstage.base.po.Grade;
import cn.bnsr.edu_yun.frontstage.base.service.GradeService;

public class GradeServiceImpl implements GradeService{
	@Autowired GradeMapper mapper;

	@Override
	public List<Grade> selectGrade() {
		// TODO Auto-generated method stub
		return mapper.selectGrade();
	}

	@Override
	public Grade selectById(int id) {
		// TODO Auto-generated method stub
		return mapper.selectByPrimaryKey(id);
	}

}
