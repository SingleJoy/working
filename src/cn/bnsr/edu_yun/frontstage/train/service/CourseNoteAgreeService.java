package cn.bnsr.edu_yun.frontstage.train.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.train.po.CourseNoteAgree;

public interface CourseNoteAgreeService {

	
	  int insert(CourseNoteAgree courseNoteAgree);
	  int delete(long id);
	  List<CourseNoteAgree> selectByUserIdAndNoteId(long user_id,long note_id);
}
