package cn.bnsr.edu_yun.frontstage.xbjy.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.xbjy.mapper.LessonAttachmentMapper;
import cn.bnsr.edu_yun.frontstage.xbjy.po.LessonAttachment;
import cn.bnsr.edu_yun.frontstage.xbjy.service.LessonAttachmentService;
import cn.bnsr.edu_yun.frontstage.xbjy.view.LessonAttachmentView;

public class LessonAttachmentServiceImpl implements LessonAttachmentService{

	@Autowired
	private LessonAttachmentMapper lessonAttachmentMapper;
	
	@Override
	public int insert(LessonAttachment lessonAttachment) {
		
		return lessonAttachmentMapper.insertSelective(lessonAttachment);
	}

	@Override
	public int update(LessonAttachment lessonAttachment) {
		
		return lessonAttachmentMapper.updateByPrimaryKeySelective(lessonAttachment);
	}

	@Override
	public int delete(Long id) {
		
		return lessonAttachmentMapper.deleteByPrimaryKey(id);
	}

	@Override
	public LessonAttachment selectById(Long id) {
		
		return lessonAttachmentMapper.selectByPrimaryKey(id);
	}
	
	@Override
	public Integer countAttachment(LessonAttachmentView lessonAttachmentView) {
		return lessonAttachmentMapper.countAttachment(lessonAttachmentView);
	}

	@Override
	public List<LessonAttachmentView> selectFileList(LessonAttachmentView lessonAttachmentView) {
		
		return lessonAttachmentMapper.selectFileList(lessonAttachmentView);
	}
	
	
	@Override
	public List<LessonAttachmentView> selectAllFile(LessonAttachmentView lessonAttachmentView) {
		
		return lessonAttachmentMapper.selectAllFile(lessonAttachmentView);
	}
}
