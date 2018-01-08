package cn.bnsr.edu_yun.frontstage.train.service.impl;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.train.mapper.ClassRelationMapper;
import cn.bnsr.edu_yun.frontstage.train.po.ClassRelation;
import cn.bnsr.edu_yun.frontstage.train.service.ClassRelationService;

public class ClassRelationServiceImpl implements ClassRelationService {

	@Autowired
	private ClassRelationMapper classRelationMapper;
	
	@Override
	public ClassRelation selectOne(Long class_id) {
		return classRelationMapper.getByClassId(class_id);
	}

	@Override
	public void update(ClassRelation classRelation) {
		if(classRelation.getSeatwork()==null){
			classRelation.setSeatwork(0);
		}
		if(classRelation.getTestpaper()==null){
			classRelation.setTestpaper(0);
		}
		if(classRelation.getQuestion()==null){
			classRelation.setQuestion(0);
		}
		if(classRelation.getActivity()==null){
			classRelation.setActivity(0);
		}
		if(classRelation.getDoubt()==null){
			classRelation.setDoubt(0);
		}
		if(classRelation.getJob()==null){
			classRelation.setJob(0);
		}
		classRelationMapper.updateByPrimaryKeySelective(classRelation);
	}

	@Override
	public void saveClassRelation(ClassRelation cr) {
		classRelationMapper.insert(cr);
	}

	@Override
	public ClassRelation getByClassId(Long class_id) {
		return classRelationMapper.getByClassId(class_id);
	}

}
