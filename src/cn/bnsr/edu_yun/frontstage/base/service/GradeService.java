package cn.bnsr.edu_yun.frontstage.base.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.base.po.Grade;

public interface GradeService {
	public List<Grade> selectGrade();
	public Grade selectById(int id);
}
