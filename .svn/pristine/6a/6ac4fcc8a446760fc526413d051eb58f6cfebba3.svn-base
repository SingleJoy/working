package cn.bnsr.edu_yun.frontstage.base.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.base.mapper.RecommendedMapper;
import cn.bnsr.edu_yun.frontstage.base.po.Recommended;
import cn.bnsr.edu_yun.frontstage.base.service.RecommendedService;

public class RecommendedServiceImpl implements RecommendedService {

	@Autowired
	private RecommendedMapper recommendedMapper;

	@Override
	public List<Recommended> selectByUserId(long user_id) {
		
		return recommendedMapper.selectByUserId(user_id);
	}

	@Override
	public void update(Recommended recommended) {
		
		recommendedMapper.updateByPrimaryKeySelective(recommended);
	}

	@Override
	public void insert(Recommended recommended) {
		
		recommendedMapper.insertSelective(recommended);
	}

	@Override
	public void delete(Long id) {
		
		recommendedMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int selectBySourceIdCount(Recommended recommended) {
		
		return recommendedMapper.selectBySourceIdCount(recommended);
	}

	@Override
	public Long selectId(Recommended recommended) {
		// TODO Auto-generated method stub
		return recommendedMapper.selectId(recommended);
	}
}
