package cn.bnsr.edu_yun.frontstage.tiku.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.tiku.mapper.UserHomeworkScoreMapper;
import cn.bnsr.edu_yun.frontstage.tiku.po.UserHomeworkScore;
import cn.bnsr.edu_yun.frontstage.tiku.po.UserHomeworkScore;
import cn.bnsr.edu_yun.frontstage.tiku.service.UserHomeworkScoreService;
import cn.bnsr.edu_yun.frontstage.tiku.view.UserHomeworkScoreView;

public class UserHomeworkScoreServiceImpl implements UserHomeworkScoreService {

	@Autowired
	private UserHomeworkScoreMapper userHomeworkScoreMapper;
	
	@Override
	public int insert(UserHomeworkScore userHomeworkScore) {
		
		return userHomeworkScoreMapper.insertSelective(userHomeworkScore);
	}

	@Override
	public int update(UserHomeworkScore userHomeworkScore) {
		
		return userHomeworkScoreMapper.updateByPrimaryKeySelective(userHomeworkScore);
	}

	@Override
	public List<UserHomeworkScoreView> findList(UserHomeworkScoreView userHomeworkScoreView) {
		
		return userHomeworkScoreMapper.findList(userHomeworkScoreView);
	}

	@Override
	public int findCount(UserHomeworkScoreView userHomeworkScoreView) {
		
		return userHomeworkScoreMapper.findCount(userHomeworkScoreView);
	}

}
