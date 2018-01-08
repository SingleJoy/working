package cn.bnsr.edu_yun.frontstage.base.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.backstage.base.view.UserStatsView;
import cn.bnsr.edu_yun.frontstage.base.mapper.UserDurationMapper;
import cn.bnsr.edu_yun.frontstage.base.po.UserDuration;
import cn.bnsr.edu_yun.frontstage.base.service.UserDurationService;

public class UserDurationServiceImpl implements UserDurationService {

	@Autowired
	private UserDurationMapper userDurationMapper;
	@Override
	public int insert(UserDuration userDuration) {
		
		return userDurationMapper.insertSelective(userDuration);
	}

	@Override
	public int update(UserDuration userDuration) {
		
		return userDurationMapper.updateByPrimaryKeySelective(userDuration);
	}

	@Override
	public UserDuration selectByUserId(UserDuration userDuration) {
		
		return userDurationMapper.selectByUserId(userDuration);
	}

	@Override
	public String collectmeanVisitTrend(UserStatsView condition) {
		return userDurationMapper.collectmeanVisitTrend(condition);
	}

	@Override
	public String collectmeanNewVisitTrend(UserStatsView condition) {
		return userDurationMapper.collectmeanNewVisitTrend(condition);
	}

	@Override
	public String queryArealDistribution(UserStatsView userStats) {
		String interval1 = userStats.getInterval1();
		userStats.setCountNum(1);
		List<UserStatsView> list = userDurationMapper.queryArealDistribution(userStats);
		if(list.size()==1&&list.get(0)!=null){
			interval1 = list.get(0).getInterval1();
		}
		return interval1;
	}

}
