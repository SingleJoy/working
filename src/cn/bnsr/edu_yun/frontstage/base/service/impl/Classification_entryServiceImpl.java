package cn.bnsr.edu_yun.frontstage.base.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.base.mapper.Classification_entryMapper;
import cn.bnsr.edu_yun.frontstage.base.po.Classification_entry;
import cn.bnsr.edu_yun.frontstage.base.service.Classification_entryService;

public class Classification_entryServiceImpl implements Classification_entryService{
	@Autowired 
	private Classification_entryMapper mapper;

	@Override
	public Classification_entry selectById(String id) {
		// TODO Auto-generated method stub
		return mapper.selectByPrimaryKey(id);
	}

	@Override
	public List<Classification_entry> selectAnyOne(Classification_entry entry) {
		// TODO Auto-generated method stub
		return mapper.selectAnyOne(entry);
	}

	@Override
	public List<Classification_entry> selectAllProject(String str) {
		// TODO Auto-generated method stub
		return mapper.selectAllProject(str);
	}

	@Override
	public List<Classification_entry> selectNotInProject(List<String> strList) {
		// TODO Auto-generated method stub
		return mapper.selectNotInProject(strList);
	}

	@Override
	public List<Classification_entry> getByParentId(String parendtId) {
		return mapper.getByParentId(parendtId);
	}

	

	

}
