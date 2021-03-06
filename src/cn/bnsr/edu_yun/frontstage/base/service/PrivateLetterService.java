package cn.bnsr.edu_yun.frontstage.base.service;

import java.util.List;

import cn.bnsr.edu_yun.backstage.base.view.ClassifyView;
import cn.bnsr.edu_yun.backstage.base.view.DataGrid;
import cn.bnsr.edu_yun.backstage.base.view.LetterView;
import cn.bnsr.edu_yun.backstage.train.view.CourseNoteView;
import cn.bnsr.edu_yun.frontstage.base.po.Classify;
import cn.bnsr.edu_yun.frontstage.base.po.PrivateLetter;
import cn.bnsr.edu_yun.frontstage.base.view.PrivateLetterView;

public interface PrivateLetterService {

	int insert(PrivateLetter p);
	
	List<PrivateLetterView>  queryPrivateLetter(PrivateLetterView privateLetterView);
	
	 List<PrivateLetterView>queryPrivateLetterDetail(PrivateLetterView privateLetterView);
	 
	 void delete(long id);
	 void deleteAll(PrivateLetterView privateLetterView);
	 
	  long  queryPrivateLetterCount(PrivateLetterView privateLetterView);
	  long queryPrivateLetterDetailCount(PrivateLetterView privateLetterView);
	  long queryPrivateLetterNotReaddCount(PrivateLetterView privateLetterView);
	  
	  //后台
	  DataGrid datagrid(LetterView condition);
	  
	  void delete(String ids);

}
