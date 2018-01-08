package cn.bnsr.edu_yun.frontstage.xbjy.service.impl;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.xbjy.mapper.LessonTimeMapper;
import cn.bnsr.edu_yun.frontstage.xbjy.po.LessonTime;
import cn.bnsr.edu_yun.frontstage.xbjy.service.LessonTimeService;
import cn.bnsr.edu_yun.frontstage.xbjy.view.LessonTimeView;

public class LessonTimeServiceImpl implements LessonTimeService{

	@Autowired
	private LessonTimeMapper lessonTimeMapper;
	
	@Override
	public void saveAll(LessonTimeView lessonTimeView) {
		LessonTime lessonTime = new LessonTime();
		BeanUtils.copyProperties(lessonTimeView, lessonTime);

		lessonTimeMapper.insertSelective(lessonTime);
		
	}
	
	
	@Override
	public void updateByLesssonId(LessonTimeView lessonTimeView) {

		lessonTimeMapper.updateByLesssonId(lessonTimeView);
		
	}
	
	@Override
	public LessonTimeView findByLesson(Long lesson_id) {
		return lessonTimeMapper.findByLesson(lesson_id);
	}
	
	
}
