package cn.bnsr.edu_yun.frontstage.base.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.base.po.Recommended;

public interface RecommendedService {

	List<Recommended> selectByUserId(long user_id);
	
	void update(Recommended recommended);
	
	void insert(Recommended recommended);
	
	void delete(Long id);
	
	int selectBySourceIdCount(Recommended recommended);
	
	Long selectId(Recommended recommended);
}
