package cn.bnsr.edu_yun.backstage.base.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.base.po.BookCat;
import cn.bnsr.edu_yun.frontstage.base.po.PubverList;
import cn.bnsr.edu_yun.frontstage.base.po.SubjectList;

public interface SubjectService {

	 List<SubjectList> selectByPid(String parent_id);
	 List<PubverList> selectByPid1(String parent_id);
	 List<BookCat> selectByPid2(String parent_id);
	 
	 PubverList findPubverByKey(String id);
	 SubjectList findSubjectByKey(String id);
	 BookCat findBookCatByKey(String id);
    
	 int edit(PubverList pubver_list);
     int edit(SubjectList pubver_list);
     
     int insertSubject(SubjectList subjectList);
     int insertPubverList(PubverList pubverList);
     int insertBookCat(BookCat bookCat);
     
     int updateSubject(SubjectList subjectList);
     int updatePubverList(PubverList pubverList);
     int updateBookCat(BookCat bookCat);
     
     int deleteSubject(String id);
     int deletePubverList(String id);
     int deleteBookCat(String id);
     
}
