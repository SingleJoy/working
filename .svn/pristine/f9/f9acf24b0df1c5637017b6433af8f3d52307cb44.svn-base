package cn.bnsr.edu_yun.frontstage.xbjy.service.impl;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.xbjy.mapper.LessonProblemMapper;
import cn.bnsr.edu_yun.frontstage.xbjy.po.LessonProblem;
import cn.bnsr.edu_yun.frontstage.xbjy.service.LessonProblemService;
import cn.bnsr.edu_yun.frontstage.xbjy.view.LessonProblemView;

public class LessonProblemServiceImpl implements LessonProblemService{

	@Autowired
	private LessonProblemMapper lessonProblemMapper;
	
	@Override
	public void saveAll(LessonProblemView lessonProblemView) {
		LessonProblem lessonProblem = new LessonProblem();
		BeanUtils.copyProperties(lessonProblemView, lessonProblem);

		lessonProblemMapper.insertSelective(lessonProblem);
		
	}
	
	
	@Override
	public void updateByLesssonId(LessonProblemView lessonProblemView) {

		lessonProblemMapper.updateByLesssonId(lessonProblemView);
		
	}
	
	@Override
	public LessonProblemView findByLesson(Long lesson_id) {
		return lessonProblemMapper.findByLesson(lesson_id);
	}
	
	
}
