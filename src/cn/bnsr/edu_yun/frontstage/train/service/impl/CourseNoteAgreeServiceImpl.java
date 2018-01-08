package cn.bnsr.edu_yun.frontstage.train.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.train.mapper.CourseNoteAgreeMapper;
import cn.bnsr.edu_yun.frontstage.train.po.CourseNoteAgree;
import cn.bnsr.edu_yun.frontstage.train.service.CourseNoteAgreeService;

public class CourseNoteAgreeServiceImpl implements CourseNoteAgreeService{

	@Autowired
	private CourseNoteAgreeMapper mapper;
	
	@Override
	public int insert(CourseNoteAgree courseNoteAgree) {
		// TODO Auto-generated method stub
		return mapper.insertSelective(courseNoteAgree);
	}

	@Override
	public int delete(long id) {
		// TODO Auto-generated method stub
		return mapper.deleteByPrimaryKey(id);
	}

	@Override
	public List<CourseNoteAgree> selectByUserIdAndNoteId(long user_id,
			long note_id) {
		// TODO Auto-generated method stub
		return mapper.selectByUserIdAndNoteId(user_id, note_id);
	}

}
