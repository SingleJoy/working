package cn.bnsr.edu_yun.frontstage.train.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.train.view.CommunityRelationView;

public interface CommunityRelationService {

	void saveCommunityRelation(String periods, String subjects, Long communityId);
	
	/**根据社区id查询 学科，学段*/
	List<CommunityRelationView> searchSubjects(Long communityId);

	void deleteByCommunityId(Long communityId);

}
