package cn.bnsr.edu_yun.frontstage.base.service.impl;

import java.util.List;

import javax.security.auth.Subject;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.base.mapper.SubjectListMapper;
import cn.bnsr.edu_yun.frontstage.base.po.SubjectList;
import cn.bnsr.edu_yun.frontstage.base.service.SubjectListService;

public class SubjectListServiceImpl implements SubjectListService{
	@Autowired
	private SubjectListMapper subjectListMapper;
	
	@Override
	public List<SubjectList> querySubject(String subId) {
		return subjectListMapper.querySubject(subId);
	}

	@Override
	public SubjectList selectById(String stageId) {
		return subjectListMapper.selectByPrimaryKey(stageId);
	}

	@Override
	public SubjectList selectBySubjectListId(String subjectId) {
		// TODO Auto-generated method stub
		return subjectListMapper.selectBySubjectListId(subjectId);
	}

	@Override
	public List<SubjectList> selectOtherSubject(String parent_id) {
		// TODO Auto-generated method stub
		return subjectListMapper.selectOtherSubject(parent_id);
	}

	@Override
	public List<SubjectList> searchSubject(List<String> list) {
		return subjectListMapper.searchSubject(list);
	}

}
