package cn.bnsr.edu_yun.frontstage.resource.service.impl;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.resource.mapper.File_labelMapper;
import cn.bnsr.edu_yun.frontstage.resource.po.File_label;
import cn.bnsr.edu_yun.frontstage.resource.service.FileLabelService;

public class FileLabelServiceImpl implements FileLabelService{
	@Autowired
	private File_labelMapper fileLabelMapper;
	
	@Override
	public int insert(File_label label) {
		return fileLabelMapper.insert(label);		
	}

}
