package cn.bnsr.edu_yun.frontstage.resource.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.resource.mapper.File_catalogMapper;
import cn.bnsr.edu_yun.frontstage.resource.mapper.File_labelMapper;
import cn.bnsr.edu_yun.frontstage.resource.po.File_catalog;
import cn.bnsr.edu_yun.frontstage.resource.po.File_label;
import cn.bnsr.edu_yun.frontstage.resource.service.File_catalogService;

public class File_catalogServiceImpl implements File_catalogService{
	@Autowired 
	private File_catalogMapper mapper;
	@Autowired 
	private File_labelMapper labelMapper;
	@Override
	public List<File_catalog> selectAnyOne(File_catalog file_catalog) {
		// TODO Auto-generated method stub
		return mapper.selectAnyOne(file_catalog);
	}

	@Override
	public int insert(File_catalog catalog) {
		// TODO Auto-generated method stub
		return mapper.insertSelective(catalog);
	}

	@Override
	public int insertLabel(File_label file_label) {
		// TODO Auto-generated method stub
		return labelMapper.insertSelective(file_label);
	}

	@Override
	public File_catalog selectById(long id) {
		// TODO Auto-generated method stub
		return mapper.selectByPrimaryKey(id);
	}

	@Override
	public int update(File_catalog catalog) {
		// TODO Auto-generated method stub
		return mapper.updateByPrimaryKeySelective(catalog);
	}

}
