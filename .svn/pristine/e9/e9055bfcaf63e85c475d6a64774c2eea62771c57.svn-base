package cn.bnsr.edu_yun.frontstage.train.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.train.mapper.CourseInfoMapper;
import cn.bnsr.edu_yun.frontstage.train.po.CourseInfo;
import cn.bnsr.edu_yun.frontstage.train.service.CourseInfoService;
import cn.bnsr.edu_yun.frontstage.train.view.CourseView;

public class CourseInfoServiceImpl implements CourseInfoService{
	
	@Autowired
	private CourseInfoMapper courseInfoMapper;

	@Override
	public CourseView queryCourseDetail(Long courseId) {
		return courseInfoMapper.queryCourseDetail(courseId);
	}

	@Override
	public void updateCourseDetail(CourseView courseView) {
		CourseInfo courseInfo = new CourseInfo();
		BeanUtils.copyProperties(courseView, courseInfo);
		courseInfo.setId(courseView.getCourseInfoId());
		courseInfoMapper.updateByPrimaryKeySelective(courseInfo);
	}

	@Override
	public void insertCourseInfo(CourseInfo couserInfo) {
		courseInfoMapper.insertSelective(couserInfo);
	}

	@Override
	public int getMaxSeq() {
		return courseInfoMapper.getMaxSeq();
	}

	@Override
	public void isRecommendCourse(CourseView courseView) {
		CourseInfo ci = courseInfoMapper.selectByPrimaryKey(courseView.getCourseInfoId());
		ci.setIs_recommend(courseView.getIsRecommend());
		ci.setRecommend_seq(courseView.getRecommendSeq());
		String recommendTime = courseView.getRecommendTime();
		if(recommendTime!=null){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			try {
				ci.setRecommend_time(sdf.parse(recommendTime));
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		courseInfoMapper.updateByPrimaryKeySelective(ci);
	}
	
}
