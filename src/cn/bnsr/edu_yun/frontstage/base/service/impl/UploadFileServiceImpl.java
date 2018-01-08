package cn.bnsr.edu_yun.frontstage.base.service.impl;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.base.mapper.UploadFileMapper;
import cn.bnsr.edu_yun.frontstage.base.po.UploadFile;
import cn.bnsr.edu_yun.frontstage.base.service.UploadFileService;

public class UploadFileServiceImpl implements UploadFileService{
	@Autowired
	private UploadFileMapper uploadFileMapper;

	@Override
	public long delUploadFile(Long id) {
		return uploadFileMapper.deleteByPrimaryKey(id);
	}

	@Override
	public long insert(UploadFile uploadFile) {
		return uploadFileMapper.insert(uploadFile);
	}

	@Override
	public long save(UploadFile uploadFile) {
		return uploadFileMapper.insertSelective(uploadFile);
	}

	@Override
	public UploadFile queryUploadById(Long id) {
		return uploadFileMapper.selectByPrimaryKey(id);
	}

	@Override
	public long update(UploadFile uploadFile) {
		return uploadFileMapper.updateByPrimaryKeySelective(uploadFile);
	}
	
}
