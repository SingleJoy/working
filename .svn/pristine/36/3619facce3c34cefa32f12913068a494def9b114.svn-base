package cn.bnsr.edu_yun.frontstage.resource.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.resource.mapper.File_baseMapper;
import cn.bnsr.edu_yun.frontstage.resource.mapper.File_propertyMapper;
import cn.bnsr.edu_yun.frontstage.resource.mapper.File_valueMapper;
import cn.bnsr.edu_yun.frontstage.resource.po.File_base;
import cn.bnsr.edu_yun.frontstage.resource.po.File_property;
import cn.bnsr.edu_yun.frontstage.resource.po.File_value;
import cn.bnsr.edu_yun.frontstage.resource.service.File_baseService;
import cn.bnsr.edu_yun.frontstage.resource.view.FileView;
import cn.bnsr.edu_yun.frontstage.resource.view.ResouceFileView;
import cn.bnsr.edu_yun.frontstage.resource.view.ResourceView;

public class File_baseServiceImpl implements File_baseService{
	@Autowired
	private File_baseMapper mapper;
	@Autowired
	private File_propertyMapper propertyMapper;
	@Autowired
	private File_valueMapper valueMapper;
	@Override
	public List<File_base> selectAnyOne(File_base file_base) {
		// TODO Auto-generated method stub
		return mapper.selectAnyOne(file_base);
	}

	@Override
	public File_base selectById(long id) {
		// TODO Auto-generated method stub
		return mapper.selectByPrimaryKey(id);
	}

	@Override
	public int insert(File_base fileBase) {
		// TODO Auto-generated method stub
		return mapper.insertSelective(fileBase);
	}

	@Override
	public int insertFileProperty(File_property fileProperty) {
		// TODO Auto-generated method stub
		return propertyMapper.insertSelective(fileProperty);
	}

	@Override
	public int insertFileValue(File_value fileValue) {
		// TODO Auto-generated method stub
		return valueMapper.insertSelective(fileValue);
	}

	@Override
	public int update(File_base fileBase) {
		// TODO Auto-generated method stub
		return mapper.updateByPrimaryKeySelective(fileBase);
	}

	

	@Override
	public List<File_base> selectByUserId(long userId,long start, long pageSize) {
		// TODO Auto-generated method stub
		return mapper.selectByUserId(userId,start,pageSize);
	}

	@Override
	public List<File_base> selectAll() {
		// TODO Auto-generated method stub
		return mapper.selectAll();
	}

	@Override
	public List<FileView> queryUserFile(FileView fileView) {
		return mapper.queryUserFile(fileView);
	}

	@Override
	public int getTotalFile(FileView fileView) {
		return mapper.getTotalFile(fileView);
	}

	@Override
	public List<File_base> queryHotFile() {
		return mapper.queryHotFile();
	}

	@Override
	public List<ResourceView> queryRecommend() {
		return mapper.queryRecommend();
	}

	@Override
	public List<ResourceView> queryResource(ResourceView resourceView) {
		return mapper.queryResource(resourceView);
	}

	@Override
	public int queryTotalResource(ResourceView resourceView) {
		return mapper.queryTotalResource(resourceView);
	}

	@Override
	public List<File_base> selectBySearchCount(String str,String format) {
		// TODO Auto-generated method stub
		return mapper.selectBySearchCount(str, format);
	}

	@Override
	public int delete(Long userId) {
		// TODO Auto-generated method stub
		return mapper.deleteByPrimaryKey(userId);
	}

	@Override
	public List<File_base> selectBySearch(String str, String format,
			long start, long pageSize) {
		// TODO Auto-generated method stub
		return mapper.selectBySearch(str, format, start, pageSize);
	}

	@Override
	public List<File_base> selectBySearchByDownload(String str, String format,
			long start, long pageSize) {
		// TODO Auto-generated method stub
		return mapper.selectBySearchByDownload(str, format, start, pageSize);
	}

	@Override
	public List<File_base> selectBySearchByTime(String str, String format,
			long start, long pageSize) {
		// TODO Auto-generated method stub
		return mapper.selectBySearchByTime(str, format, start, pageSize);
	}

	@Override
	public List<File_base> selectBySearchByAgree(String str, String format,
			long start, long pageSize) {
		// TODO Auto-generated method stub
		return mapper.selectBySearchByAgree(str, format, start, pageSize);
	}

	@Override
	public void deleteFile(String id) {
		File_base fb = new File_base();
		fb.setId(Long.parseLong(id));
		fb.setStatus((byte) 3);
		mapper.updateByPrimaryKeySelective(fb);
	}

	@Override
	public File_base getById(String id) {
		return mapper.getById(id);
	}

}
