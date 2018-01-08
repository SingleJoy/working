package cn.bnsr.edu_yun.frontstage.train.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.train.mapper.CourseFileMapper;
import cn.bnsr.edu_yun.frontstage.train.po.CourseFile;
import cn.bnsr.edu_yun.frontstage.train.service.CourseFileService;
import cn.bnsr.edu_yun.frontstage.train.view.CourseFileView;
import cn.bnsr.edu_yun.frontstage.train.view.CourseHourFileView;

public class CourseFileServiceImpl implements CourseFileService{
	
	@Autowired
	private CourseFileMapper courseFileMapper;
	
	@Override
	public Long saveFile(CourseFile courseFile) {
		courseFileMapper.insertSelective(courseFile);
		return courseFile.getId();
	}
	
	@Override
	public int queryCourseFileTotal(CourseFileView courseFileView){
		return courseFileMapper.queryCourseFileTotal(courseFileView);
	}

	@Override
	public List<CourseFileView> queryCourseFile(CourseFileView courseFileView) {
		return courseFileMapper.queryCourseFile(courseFileView);
	}

	@Override
	public void deleteCourseFile(String fileIds) {
		String[] ids = fileIds.split(",");
		for(int i=0;i<ids.length;i++){
			courseFileMapper.deleteByPrimaryKey(Long.parseLong(ids[i]));
		}
	}

	@Override
	public CourseFile selectByKey(Long id) {
		
		return courseFileMapper.selectByPrimaryKey(id);
	}

	@Override
	public List<CourseFileView> queryFile(CourseFileView courseFileView) {
		return courseFileMapper.queryFile(courseFileView);
	}

	@Override
	public int queryTotalFile(CourseFileView courseFileView) {
		return courseFileMapper.queryTotalFile(courseFileView);
	}

	@Override
	public void updateCourseFile(CourseFile courseFile) {
		courseFileMapper.updateByPrimaryKeySelective(courseFile);	
	}

	@Override
	public CourseFileView getCourseFileByCourseHourFileIsTeacher(
			CourseHourFileView courseHourFileView) {
		// TODO Auto-generated method stub
		return courseFileMapper.getCourseFileByCourseHourFileIsTeacher(courseHourFileView);
	}

	@Override
	public CourseFileView getCourseFileByCourseHourFileIsStudent(
			CourseHourFileView courseHourFileView) {
		// TODO Auto-generated method stub
		return courseFileMapper.getCourseFileByCourseHourFileIsStudent(courseHourFileView);
	}
}
