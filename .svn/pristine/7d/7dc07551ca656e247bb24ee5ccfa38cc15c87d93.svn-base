package cn.bnsr.edu_yun.frontstage.train.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.train.mapper.CourseHourFileMapper;
import cn.bnsr.edu_yun.frontstage.train.po.CourseHourFile;
import cn.bnsr.edu_yun.frontstage.train.service.CourseHourFileService;
import cn.bnsr.edu_yun.frontstage.train.view.CourseHourFileView;

public class CourseHourFileServiceImpl implements CourseHourFileService{
	@Autowired
	private CourseHourFileMapper courseHourFileMapper;

	@Override
	public void saveHourFile(CourseHourFile courseHourFile) {
		courseHourFileMapper.insertSelective(courseHourFile);		
	}

	@Override
	public List<CourseHourFileView> getHourFile(String hourId) {
		return courseHourFileMapper.getHourFile(hourId);
	}

	@Override
	public void deleteHourFile(String id) {
		courseHourFileMapper.deleteByPrimaryKey(Long.parseLong(id));	
	}

	@Override
	public void deleteByHourId(String hourId) {
		courseHourFileMapper.deleteByHourId(hourId);	
	}
	
}
