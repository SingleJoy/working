package cn.bnsr.edu_yun.frontstage.xbjy.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.xbjy.mapper.LessonAssessMapper;
import cn.bnsr.edu_yun.frontstage.xbjy.po.LessonAssess;
import cn.bnsr.edu_yun.frontstage.xbjy.service.LessonAssessService;
import cn.bnsr.edu_yun.frontstage.xbjy.view.LessonAssessView;

public class LessonAssessServiceImpl implements LessonAssessService{

	@Autowired
	private LessonAssessMapper lessonAssessMapper;
	
	@Override
	public void saveAll(LessonAssessView lessonAssessView) {
		LessonAssess lessonAssess = new LessonAssess();
		BeanUtils.copyProperties(lessonAssessView, lessonAssess);
		if(lessonAssessView.getId()>0 && !lessonAssessView.equals("")){
			lessonAssess.setUpdate_time(new Date());
			lessonAssessMapper.updateByPrimaryKeySelective(lessonAssess);
		}else{
			lessonAssess.setUpdate_time(new Date());
			lessonAssessMapper.insertSelective(lessonAssess);
		}
	}
	
	@Override
	public List<LessonAssessView> findAssess(LessonAssessView lessonAssessView) {
		return lessonAssessMapper.findAssess(lessonAssessView);
	}
	
	@Override
	public LessonAssess getById(Long id) {
		return lessonAssessMapper.selectByPrimaryKey(id);
	}
}
