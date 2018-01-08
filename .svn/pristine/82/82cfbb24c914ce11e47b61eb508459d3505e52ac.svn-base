package cn.bnsr.edu_yun.frontstage.base.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.base.po.SubjectList;

public interface SubjectListService {

	public List<SubjectList> querySubject(String subId);

	public SubjectList selectById(String stageId);
	SubjectList selectBySubjectListId(String subjectId);
	List<SubjectList> selectOtherSubject(String parent_id);
	
	/**查询根据学段ids 学科*/
	public List<SubjectList> searchSubject(List<String> list);

}
