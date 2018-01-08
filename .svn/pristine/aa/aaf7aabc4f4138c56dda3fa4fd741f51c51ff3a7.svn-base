package cn.bnsr.edu_yun.frontstage.base.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.base.po.Classification_entry;

public interface Classification_entryService {
	public Classification_entry selectById(String id);
	
	public List<Classification_entry> selectAnyOne(Classification_entry entry); 
	
	List<Classification_entry> selectAllProject(String str);
	List<Classification_entry> selectNotInProject(List<String> strList);
	
	//通过父分类id查询分类
	public List<Classification_entry> getByParentId(String parendtId); 

}
