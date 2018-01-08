package cn.bnsr.edu_yun.frontstage.resource.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.resource.mapper.File_typeMapper;
import cn.bnsr.edu_yun.frontstage.resource.po.File_type;
import cn.bnsr.edu_yun.frontstage.resource.service.FileTypeService;

public class FileTypeServiceImpl implements FileTypeService{
	@Autowired
	private File_typeMapper fileTypeMapper;
	
	@Override
	public List<File_type> findAllFileType() {
		return fileTypeMapper.findAllFileType();
	}

}
