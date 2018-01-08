package cn.bnsr.edu_yun.frontstage.train.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.train.mapper.CommunityRelationMapper;
import cn.bnsr.edu_yun.frontstage.train.po.CommunityRelation;
import cn.bnsr.edu_yun.frontstage.train.service.CommunityRelationService;
import cn.bnsr.edu_yun.frontstage.train.view.CommunityRelationView;

public class CommunityRelationServiceImpl implements CommunityRelationService{
	@Autowired
	private CommunityRelationMapper communityRelationMapper;

	@Override
	public void saveCommunityRelation(String periods, String subjects, Long communityId) {
		
		if(!periods.equals("")){
			if(periods.contains(",")){//多个学段
				int lengths = periods.split(",").length;
				for(int i=0;i<lengths;i++){
					CommunityRelation cr = new CommunityRelation();
					cr.setCommunity_id(communityId);
					cr.setSubject_id(periods.split(",")[i]);
					cr.setType(0);
					communityRelationMapper.insertSelective(cr);
				}
			}else{//单个
				CommunityRelation cr = new CommunityRelation();
				cr.setCommunity_id(communityId);
				cr.setSubject_id(periods);
				cr.setType(0);
				communityRelationMapper.insertSelective(cr);
			}
		}
		
		if(!subjects.equals("")){
			if(subjects.contains(",")){//多个学科
				int lengths = subjects.split(",").length;
				for(int i=0;i<lengths;i++){
					CommunityRelation cr = new CommunityRelation();
					cr.setCommunity_id(communityId);
					cr.setSubject_id(subjects.split(",")[i]);
					cr.setType(1);
					communityRelationMapper.insertSelective(cr);
				}
			}else{//单个
				CommunityRelation cr = new CommunityRelation();
				cr.setCommunity_id(communityId);
				cr.setSubject_id(subjects);
				cr.setType(1);
				communityRelationMapper.insertSelective(cr);
			}
		}
	}

	@Override
	public List<CommunityRelationView> searchSubjects(Long communityId) {
		return communityRelationMapper.searchSubjects(communityId);
	}

	@Override
	public void deleteByCommunityId(Long communityId) {
		communityRelationMapper.deleteByCommunityId(communityId);
	}
	
}
