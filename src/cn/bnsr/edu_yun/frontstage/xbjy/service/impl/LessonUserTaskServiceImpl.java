package cn.bnsr.edu_yun.frontstage.xbjy.service.impl;

import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.xbjy.mapper.LessonUserTaskMapper;
import cn.bnsr.edu_yun.frontstage.xbjy.po.LessonUserTask;
import cn.bnsr.edu_yun.frontstage.xbjy.service.LessonUserTaskService;
import cn.bnsr.edu_yun.frontstage.xbjy.view.LessonUserTaskView;

public class LessonUserTaskServiceImpl implements LessonUserTaskService{

	@Autowired
	private LessonUserTaskMapper lessonUserTaskMapper;
	
	@Override
	public void saveAll(LessonUserTaskView lessonUserTaskView) {
		LessonUserTask lessonUserTask = new LessonUserTask();
		BeanUtils.copyProperties(lessonUserTaskView, lessonUserTask);

		lessonUserTaskMapper.insertSelective(lessonUserTask);
		
	}
	
	
	@Override  
	public LessonUserTaskView findByLUP(LessonUserTaskView lessonUserTaskView) {  
		return lessonUserTaskMapper.findByLUP(lessonUserTaskView);  
	}
	
	@Override
	public List<LessonUserTaskView> findUserByLesson(LessonUserTaskView lessonUserTaskView) {
		return lessonUserTaskMapper.findUserByLesson(lessonUserTaskView);
	}
	
	@Override
	public void delTeacher(Long id) {

		lessonUserTaskMapper.deleteByPrimaryKey(id);
		
	}
	
	@Override
	public LessonUserTask getById(Long id) {
		return lessonUserTaskMapper.selectByPrimaryKey(id);
	}
	
	@Override
	public List<LessonUserTaskView> findPurview(LessonUserTaskView lessonUserTaskView) {
		return lessonUserTaskMapper.findPurview(lessonUserTaskView);
	}
	
	@Override
	public Integer countTask(LessonUserTaskView lessonUserTaskView) {
		return lessonUserTaskMapper.countTask(lessonUserTaskView);
	}
	
	
	@Override
	public List<LessonUserTaskView> findByPurview(LessonUserTaskView lessonUserTaskView) {
		return lessonUserTaskMapper.findByPurview(lessonUserTaskView);
	}


	@Override
	public int update(LessonUserTaskView lessonUserTaskView) {
		LessonUserTask lessonUserTask=new LessonUserTask();
		lessonUserTask.setId(lessonUserTaskView.getId());
		lessonUserTask.setLesson_id(lessonUserTaskView.getLesson_id());
		lessonUserTask.setPurview(lessonUserTaskView.getPurview());
		lessonUserTask.setStatus(lessonUserTaskView.getStatus());
		lessonUserTask.setUser_id(lessonUserTaskView.getUser_id());
		return lessonUserTaskMapper.updateByPrimaryKeySelective(lessonUserTask);
	}
	
}
